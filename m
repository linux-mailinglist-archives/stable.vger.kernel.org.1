Return-Path: <stable+bounces-96436-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B5B39E1FBE
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 15:41:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C1DC165ED3
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 14:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6D711F4279;
	Tue,  3 Dec 2024 14:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UM999Nf5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646B11E4A9;
	Tue,  3 Dec 2024 14:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733236804; cv=none; b=G2xlITL6MP/cvbcidvLZL2rkiGJ7uspCUvyPZd3iZQ9SxzwaRsKbwqNyn85lpOjjUcdvjKOfLMvwH249yagG7jDBMjHkpwp90HOJqa0AQQvydCXVz1pm07KkgkhTg4tmxG20xgTRsfZ4frqyRE9WeskIjnH+pWtJnGWJQSLBojM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733236804; c=relaxed/simple;
	bh=xZIb+bB5GM0H48rg510gI4xfD+kBxrf2xc4Pm9oPMso=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qoRQdKWDseBvNmdcxJJPa6O9g6muPYIbo0HwCAFjnoLGFIv2R6QhOi6OyFjCcPlAjnICuIJqNX9C5d05w/2cC8CgEUsYQCN8Y/9jMuf3tJye5mMdJ2W87CKQaZFPI8LCBlf8qEA/H9O6+5ct00A9VZMx3si4/M6RFKpHP3gb+ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UM999Nf5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B4F5C4CECF;
	Tue,  3 Dec 2024 14:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733236803;
	bh=xZIb+bB5GM0H48rg510gI4xfD+kBxrf2xc4Pm9oPMso=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UM999Nf5hn2q0z9U58jQ6m2/94LtDrKg3BNJPp236mOEomXlCUow0smKQdGaw1P3V
	 4H4V63ACbDYZrWBG6UkEPhm6o7xUkdU+J41JAh5nc19YOBTJ84DseO3qTX59+fuTRH
	 3FiaV9H3rj4kNZRHzpTwhwK3knQgqUZcdL/V7BDY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Qiu-ji Chen <chenqiuji666@gmail.com>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>
Subject: [PATCH 4.19 122/138] media: wl128x: Fix atomicity violation in fmc_send_cmd()
Date: Tue,  3 Dec 2024 15:32:31 +0100
Message-ID: <20241203141928.234151546@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241203141923.524658091@linuxfoundation.org>
References: <20241203141923.524658091@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Qiu-ji Chen <chenqiuji666@gmail.com>

commit ca59f9956d4519ab18ab2270be47c6b8c6ced091 upstream.

Atomicity violation occurs when the fmc_send_cmd() function is executed
simultaneously with the modification of the fmdev->resp_skb value.
Consider a scenario where, after passing the validity check within the
function, a non-null fmdev->resp_skb variable is assigned a null value.
This results in an invalid fmdev->resp_skb variable passing the validity
check. As seen in the later part of the function, skb = fmdev->resp_skb;
when the invalid fmdev->resp_skb passes the check, a null pointer
dereference error may occur at line 478, evt_hdr = (void *)skb->data;

To address this issue, it is recommended to include the validity check of
fmdev->resp_skb within the locked section of the function. This
modification ensures that the value of fmdev->resp_skb does not change
during the validation process, thereby maintaining its validity.

This possible bug is found by an experimental static analysis tool
developed by our team. This tool analyzes the locking APIs
to extract function pairs that can be concurrently executed, and then
analyzes the instructions in the paired functions to identify possible
concurrency bugs including data races and atomicity violations.

Fixes: e8454ff7b9a4 ("[media] drivers:media:radio: wl128x: FM Driver Common sources")
Cc: stable@vger.kernel.org
Signed-off-by: Qiu-ji Chen <chenqiuji666@gmail.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/radio/wl128x/fmdrv_common.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/media/radio/wl128x/fmdrv_common.c
+++ b/drivers/media/radio/wl128x/fmdrv_common.c
@@ -472,11 +472,12 @@ int fmc_send_cmd(struct fmdev *fmdev, u8
 			   jiffies_to_msecs(FM_DRV_TX_TIMEOUT) / 1000);
 		return -ETIMEDOUT;
 	}
+	spin_lock_irqsave(&fmdev->resp_skb_lock, flags);
 	if (!fmdev->resp_skb) {
+		spin_unlock_irqrestore(&fmdev->resp_skb_lock, flags);
 		fmerr("Response SKB is missing\n");
 		return -EFAULT;
 	}
-	spin_lock_irqsave(&fmdev->resp_skb_lock, flags);
 	skb = fmdev->resp_skb;
 	fmdev->resp_skb = NULL;
 	spin_unlock_irqrestore(&fmdev->resp_skb_lock, flags);



