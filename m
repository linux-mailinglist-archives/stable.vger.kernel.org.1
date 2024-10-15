Return-Path: <stable+bounces-86114-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B65299EBBD
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 15:10:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39983B2062C
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 13:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0028B1AF0B7;
	Tue, 15 Oct 2024 13:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="byfKOvxh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B20A91C07ED;
	Tue, 15 Oct 2024 13:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728997816; cv=none; b=eNA8RbMCwQzJnkJ/vFSze8onNhYZ8jzyilO2DAS+zto9HdvgjSYCmcm2U9k6OPOCJMjYos6sGMhuFtaW08fjgmWUBQz20IGaWkZJDRsLMVxJAJPCj6wKzblbDwXAHU2C6BU08JRYM5yqcw6sY0zwsZ+bo4bZyiEorcmKHO07uAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728997816; c=relaxed/simple;
	bh=mhrVFQsLEPdYdLEXTqL/UO+qPhSILp3q4LcEW4lnN+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eoY0jcRAgrgJ0pdwBUKkVFHj00sOd7r5kl69HPvb1HrH970oYWiVAO5QD1SqGZt5OHVpImrBjL4IoiUgJREcmupzPd4G1Iu5JXfbUbDx1dwQIclCPRDkNVWkja7kDvvhdl5pXe1tjyD1gkoN0f4aBAdvj+P5sh34vPATBbsE/H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=byfKOvxh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21861C4CEC6;
	Tue, 15 Oct 2024 13:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728997816;
	bh=mhrVFQsLEPdYdLEXTqL/UO+qPhSILp3q4LcEW4lnN+s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=byfKOvxhyHSqVx8jP1++ox+oDBPi1Jk03BhLHPCsb8DQxaqqvkF/1lJfsqNC0s+gr
	 F2i+ICnwMsHwG0wjM3JtrdHjUTkaa7ssdxwhJByL1fuFhTzAeaJSycZ0qZ2IsXHU5A
	 HQ22ggNRUgalx7UOAMJch49A0nzVxipmIgjCkUik=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+98afa303be379af6cdb2@syzkaller.appspotmail.com,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Kalle Valo <quic_kvalo@quicinc.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 295/518] wifi: ath9k_htc: Use __skb_set_length() for resetting urb before resubmit
Date: Tue, 15 Oct 2024 14:43:19 +0200
Message-ID: <20241015123928.375471226@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241015123916.821186887@linuxfoundation.org>
References: <20241015123916.821186887@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Toke Høiland-Jørgensen <toke@redhat.com>

[ Upstream commit 94745807f3ebd379f23865e6dab196f220664179 ]

Syzbot points out that skb_trim() has a sanity check on the existing length of
the skb, which can be uninitialised in some error paths. The intent here is
clearly just to reset the length to zero before resubmitting, so switch to
calling __skb_set_length(skb, 0) directly. In addition, __skb_set_length()
already contains a call to skb_reset_tail_pointer(), so remove the redundant
call.

The syzbot report came from ath9k_hif_usb_reg_in_cb(), but there's a similar
usage of skb_trim() in ath9k_hif_usb_rx_cb(), change both while we're at it.

Reported-by: syzbot+98afa303be379af6cdb2@syzkaller.appspotmail.com
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
Link: https://patch.msgid.link/20240812142447.12328-1-toke@toke.dk
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath9k/hif_usb.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ath/ath9k/hif_usb.c b/drivers/net/wireless/ath/ath9k/hif_usb.c
index e0130beb304df..6c73c0c0b82a9 100644
--- a/drivers/net/wireless/ath/ath9k/hif_usb.c
+++ b/drivers/net/wireless/ath/ath9k/hif_usb.c
@@ -718,8 +718,7 @@ static void ath9k_hif_usb_rx_cb(struct urb *urb)
 	}
 
 resubmit:
-	skb_reset_tail_pointer(skb);
-	skb_trim(skb, 0);
+	__skb_set_length(skb, 0);
 
 	usb_anchor_urb(urb, &hif_dev->rx_submitted);
 	ret = usb_submit_urb(urb, GFP_ATOMIC);
@@ -756,8 +755,7 @@ static void ath9k_hif_usb_reg_in_cb(struct urb *urb)
 	case -ESHUTDOWN:
 		goto free_skb;
 	default:
-		skb_reset_tail_pointer(skb);
-		skb_trim(skb, 0);
+		__skb_set_length(skb, 0);
 
 		goto resubmit;
 	}
-- 
2.43.0




