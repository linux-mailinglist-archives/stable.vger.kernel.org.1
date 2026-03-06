Return-Path: <stable+bounces-223305-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QPLqI3dKqmlkOgEAu9opvQ
	(envelope-from <stable+bounces-223305-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 06 Mar 2026 04:31:03 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E71EF21B1CB
	for <lists+stable@lfdr.de>; Fri, 06 Mar 2026 04:31:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 613183029E49
	for <lists+stable@lfdr.de>; Fri,  6 Mar 2026 03:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4745933F581;
	Fri,  6 Mar 2026 03:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="x/9//8zZ"
X-Original-To: stable@vger.kernel.org
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE6F123FC5A;
	Fri,  6 Mar 2026 03:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.243.244.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772767856; cv=none; b=E7Iq8R88YMtx+Dsr8SzbjBk8CsPiJj/wfVMMHzZGF5MSa3tIpu+BM0mVFOwNrRGfMJfTDrORr/8GCXNJSr/ESzIfKKbgz7S/+Y2mOBHkauwIQH2LC/8xbTjOHjvb70ScmPrcR1SySawamjOEcD2prlut26ow7usuDKl+NGWmajM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772767856; c=relaxed/simple;
	bh=9JD6kBkSfcMgcL1f24JUH05YEvcrs2BAYO8Lh88O1+4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=kGDcSECwptAtrSBCgBAUtTpZOcANHuHHo6obL7KxWG4HhR1bSpK4KTB1t+WLvQ8rerL79whcKFOqmK+dINizpmpyYgGFFoUSjxfRA04JE1RYe5FdgCstjNC6bx5FXxXjeAtnkQ/JrRT02qtto2dx8N4elWzZ9UXUlB4tW1zwTDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=x/9//8zZ; arc=none smtp.client-ip=54.243.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1772767815;
	bh=glyq+F+BtseRvj5gR/MbcEWW00ve4s02FxEWiBBWcqQ=;
	h=From:Date:Subject:MIME-Version:Message-Id:To;
	b=x/9//8zZ9FY3CAjeSOywIFkPhN1s4xyqiVo3M+NdhM/tnQ+3XN3CCRzTFdh2UuRS0
	 ZgXvfLEUCBeR7T4MIj7ScZZy8LNaCkjBkpuIG1nqIaN7t8MEJBsYkQM3OGuiX7KODa
	 ev7Dq+Y9rcP7doprN9d5uk5IeO1bAVkzztf8xA9M=
X-QQ-mid: esmtpgz14t1772767813tef51b2a8
X-QQ-Originating-IP: q5sbB4QY4DiPKFW1XvuMDhNDZLnpT6hQegF4Oki3utY=
Received: from LT-PANJUNZHONG.dc.com ( [120.237.158.181])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 06 Mar 2026 11:30:12 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3452352524430289917
EX-QQ-RecipientCnt: 7
From: Junzhong Pan <panjunzhong@linux.spacemit.com>
Date: Fri, 06 Mar 2026 11:30:09 +0800
Subject: [PATCH] usb: gadget: uvc: fix interval_duration calculation
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260306-fix-uvc-interval-v1-1-9a2df6859859@linux.spacemit.com>
X-B4-Tracking: v=1; b=H4sIAEBKqmkC/x2MQQqAIBAAvyJ7bsE0JPpKdDDdaiEstCQI/550H
 JiZFxJFpgSDeCFS5sRHqNA2Atxmw0rIvjIoqYzU0uDCD97ZIYeLYrY7Su+08bOnrieo2RmpOv9
 ynEr5ABtuZidiAAAA
X-Change-ID: 20260306-fix-uvc-interval-0dc36dbde48e
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Frank Li <Frank.Li@nxp.com>, Xu Yang <xu.yang_2@nxp.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Junzhong Pan <panjunzhong@linux.spacemit.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772767812; l=1195;
 i=panjunzhong@linux.spacemit.com; s=20260306; h=from:subject:message-id;
 bh=9JD6kBkSfcMgcL1f24JUH05YEvcrs2BAYO8Lh88O1+4=;
 b=Ml0gZ8h12QkGWcIz9pcDjz8GbJKk2RitH5gEqV+Tw3Lr7CL+GPow8qBIdunAa8L5QXBgYUuh6
 q7E2l+sfDRtA0e5+Xf1wJAT8yqzNhHXgNrGIO3dQAFM03gnxxx65IRJ
X-Developer-Key: i=panjunzhong@linux.spacemit.com; a=ed25519;
 pk=bY08BOg2T9H93/jG8fEE/tVmdXoQQMp9M2rtzPFoyJg=
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:linux.spacemit.com:qybglogicsvrgz:qybglogicsvrgz5b-2
X-QQ-XMAILINFO: ME/Ngba2Rsnv8Y3zloXp1i7IPbHLqbocAzRR3qbaMa13gIcGZKyzKB8i
	MWIEzHTsg7e2uN1SW8bytzLmKErCo1PAGjQTvMm6/ybgZbW1UW2n8i91PHUo1jlC4AvUKua
	tFs9otJ3zs3aWCXZ3O7udtmNhsZtvZvzOWGpAba/cysPqnuj54YAEhQvaGc6LFC0paj30wz
	fsGJefHKF9KJ2avkMu/tP+6SXad1EzX77GNP3byj/AFFu4dm9HbwYoBPugbOi9RYsZ+5/pU
	xLhzu5dcF38JlnMWZbjqTdqsyJG2nKPj3J3vHwpLly1AqrzdXQ0Se9Pm9MO/BwfM2vPlip5
	xlB2i1fKX49VA0dPGMrO7hP2kYcPBByYXBpU4L7C8lwO+6aBiZeaX/H/lsRWH4pf9Apcras
	FIj9+kUQXwEJ7aQ8r/8WTpv5EcqI5+AtkJJbLwgMPW0kyt0ondqKlSvjhQU7ugirXnsuQ5k
	6c0i3x49S/u1dAPp+Hb44JchhodQofdTC4kjfPNt4/vhuGLmdv6zTl2DmAT0wygwAZ2AFbF
	BYWfPyIAKMcujQOVMh11bBD5S876eMEVJ1a0Iujp+jo2337ZD4orz33UY9qJoopbQEqIPYe
	g0Gen+xVdJ5Q/PmfD2QS5urZzaz/zzu/PT3SYMvzA0ckSDXo+ao0Oq3Fkr//+paDsMIG59g
	iPkIivDIqD7IcMcqic+qS3XzUNofrA8K4l3t5/7L+bkr6MrEG4UygpAQsw1bHB87baiDce4
	Oel9sTcTmx9zGt3njm2NSBjLVXtCb5hPp4C/l6xnKArcsAkgQ7CCfKRunZ30HHRCikayNwo
	i55vxZy/EdCwgafu8TJFK2ioFXcRBtHRah8JXxoxpL3fmvxWhjK/l9DF/bXEL+BVhAcYJ3H
	i7Z7irFKaqxdxKCgEXNNDQ1/m6wG/+lD5yWI+x28mCMTyFkhAP/uN3xPy6DNnThpbiqjEqs
	lLYeqbwrUBBSjfviIYFNxRIKl4s9I2lzQvEZtWtlKeOkE298xAMC1kmmf6+VTBT3qHHgbrc
	fghKAlGdwkPzRweOmGTwGk6QJT9iUwbjjHTGQtzN1T09sNehsiqJonazuL9b9HlYBRVJCcg
	F+nylkDThJz9KbNwwYWeFgmgPZ/nZ0dfrCI+RO1xITu
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
X-QQ-RECHKSPAM: 0
X-Rspamd-Queue-Id: E71EF21B1CB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[linux.spacemit.com:s=mxsw2412];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[linux.spacemit.com:+];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DMARC_NA(0.00)[spacemit.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[panjunzhong@linux.spacemit.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-223305-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[]
X-Rspamd-Action: no action

To correctly convert bInterval as interval_duration:
  interval_duration = 2^(bInterval-1) * frame_interval

Current code uses a wrong left shift operand, computing 2^bInterval
instead of 2^(bInterval-1).

Fixes: 010dc57cb516 ("usb: gadget: uvc: fix interval_duration calculation")
Cc: stable@vger.kernel.org
Signed-off-by: Junzhong Pan <panjunzhong@linux.spacemit.com>
---
 drivers/usb/gadget/function/uvc_video.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/function/uvc_video.c b/drivers/usb/gadget/function/uvc_video.c
index 7cea641b06b4..2f9700b3f1b6 100644
--- a/drivers/usb/gadget/function/uvc_video.c
+++ b/drivers/usb/gadget/function/uvc_video.c
@@ -513,7 +513,7 @@ uvc_video_prep_requests(struct uvc_video *video)
 		return;
 	}
 
-	interval_duration = 2 << (video->ep->desc->bInterval - 1);
+	interval_duration = 1 << (video->ep->desc->bInterval - 1);
 	if (cdev->gadget->speed < USB_SPEED_HIGH)
 		interval_duration *= 10000;
 	else

---
base-commit: 5ee8dbf54602dc340d6235b1d6aa17c0f283f48c
change-id: 20260306-fix-uvc-interval-0dc36dbde48e

Best regards,
-- 
Junzhong Pan <panjunzhong@linux.spacemit.com>


