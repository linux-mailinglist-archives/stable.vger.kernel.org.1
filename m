Return-Path: <stable+bounces-103375-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A668E9EF796
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 18:35:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37ADD1890FE3
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 17:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22CB421660C;
	Thu, 12 Dec 2024 17:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bxseBijx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCDBE211493;
	Thu, 12 Dec 2024 17:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734024378; cv=none; b=EOH8HAGuYDQ5rdYsicF/E/SViAVyHct+eEGgBOlUu/VzwtJ7trv250Gml5rw2kX+ItiV08cxbaRgTFKiLYOCt8Qr+iFTCnTKFgvFpTn93z6pmcjihx4afVQK08LfQNzuvYFuHZeqxLdhnonavpba92xk0qn3rjmSgSE6q8T/FG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734024378; c=relaxed/simple;
	bh=BtoeXyAJpfaKLStH7DWEL7dphnABrvDdi61ScStBvh0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LQF0tqFHVDFyMn5oZWzaUu9EsDRcNXbp4OLhoNgirLnpHBa2loYbhuG5OAkkrLFR9hc7kFAUFCAoB8XKiTscaLHBj4DYzOUUfiGAZvVafcAbhx94Eyfso/O8HCLRS9lS0KcqJhRLOD/S3Yr/5QSgOeQToXpfIBnVpZHZvalpsoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bxseBijx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 437D8C4CED4;
	Thu, 12 Dec 2024 17:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734024378;
	bh=BtoeXyAJpfaKLStH7DWEL7dphnABrvDdi61ScStBvh0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bxseBijxyOE9gZI+ccPGw2opdGPJqydFwGm0EMqNOHlN4MiUZokAlVODDH8IyyL4D
	 qhxXaav/fbxYfkYLeT5/T6srvwAOzXPKBf6KW8vDU2PwV1m/T+UO9iL0M4vxMj/0VN
	 LMrs0yW3tfSHcd2acqaT0ayHS1TnDLRDbivg7KRk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Qiu-ji Chen <chenqiuji666@gmail.com>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>
Subject: [PATCH 5.10 276/459] media: wl128x: Fix atomicity violation in fmc_send_cmd()
Date: Thu, 12 Dec 2024 16:00:14 +0100
Message-ID: <20241212144304.521960330@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212144253.511169641@linuxfoundation.org>
References: <20241212144253.511169641@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

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
@@ -465,11 +465,12 @@ int fmc_send_cmd(struct fmdev *fmdev, u8
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



