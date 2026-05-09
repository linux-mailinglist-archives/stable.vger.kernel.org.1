Return-Path: <stable+bounces-244881-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qJPvOHyW/ml5tAAAu9opvQ
	(envelope-from <stable+bounces-244881-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 09 May 2026 04:05:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F2824FD83D
	for <lists+stable@lfdr.de>; Sat, 09 May 2026 04:05:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B0C33301991F
	for <lists+stable@lfdr.de>; Sat,  9 May 2026 02:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 067492882CD;
	Sat,  9 May 2026 02:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z9nqqaiw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE850282F3F
	for <stable@vger.kernel.org>; Sat,  9 May 2026 02:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778292296; cv=none; b=BLrLmgGxDmh9wOVlXwsIMRPgtS7QR4PkgMxnTL781ToS45z41/bLKlrgmM5SkJv4E7TabSgkyxC4WykfG6Piwx4OkYU4CwoSGnad0KLM1WcbJL3a5M6L0Ud3lrqwXhok+P2xjC22ptW05dQQa33xyaa04aPrWmJM2Y9lOOdNSxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778292296; c=relaxed/simple;
	bh=ErGZ43rjQWdUJmB+KhALXzc3XYKlAwGYRDfMYOrTQXs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N3d1ivAJIQwAG6bxuFzW/Q5/DykTx2+9mHNLTTwYGQC8DJ7DjSaiO/bKaqnmTGlfswYMsJrZ4cTtRn5zUkP+k/o4YFt8Vz+PRk3wdsNGviAMsB3OxkNnpiVECtI2gvIGbTjiEQ6DSBsbvDnE8g8/a66CKThxGAU2dmocSAXaZ9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z9nqqaiw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDBC5C2BCB0;
	Sat,  9 May 2026 02:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778292296;
	bh=ErGZ43rjQWdUJmB+KhALXzc3XYKlAwGYRDfMYOrTQXs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z9nqqaiwSP41eAMW79501oNO5SJvKKxqZSEb3vnNFLaiUUPB9CwwSj4RgS5E1ul14
	 H9zebRNndkGzbgB5Tz89gTrtxcvx8D7IrIzBu3OHIJfQh0CdvnuDeBmXDhKUSiZ8+K
	 vCVkHJDZMVpRQ9FEr+XAvKTnvWIPd6ZTdWWniS+A62Yam0pSj4S3ADUNlTjtTmWJre
	 MVBaI3cEPQF55Fm9kNLQCdz+ozycj1OPBmLzjx/4XP59HR1cY0XCRTnF40JlIsYuAG
	 k4WWwlBHSHCpbs5/PU850jorKGELAtwMBMvF8Xb9QjaSLO96lqpsh3H/h5pzkjHDC+
	 ofT9t9F+SWLhQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Julia Lawall <Julia.Lawall@inria.fr>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/2] can: ucan: fix typos in comments
Date: Fri,  8 May 2026 22:04:52 -0400
Message-ID: <20260509020453.2868235-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026050411-monsoon-twitch-7df9@gregkh>
References: <2026050411-monsoon-twitch-7df9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4F2824FD83D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244881-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,inria.fr:email]
X-Rspamd-Action: no action

From: Julia Lawall <Julia.Lawall@inria.fr>

[ Upstream commit c34983c94166689358372d4af8d5def57752860c ]

Various spelling mistakes in comments.
Detected with the help of Coccinelle.

Link: https://lore.kernel.org/all/20220314115354.144023-28-Julia.Lawall@inria.fr
Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>
Acked-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Stable-dep-of: fed4626501c8 ("can: ucan: fix devres lifetime")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/can/usb/ucan.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/usb/ucan.c b/drivers/net/can/usb/ucan.c
index 77d06b682ce68..8332c6d6e5e21 100644
--- a/drivers/net/can/usb/ucan.c
+++ b/drivers/net/can/usb/ucan.c
@@ -1395,7 +1395,7 @@ static int ucan_probe(struct usb_interface *intf,
 	 * Stage 3 for the final driver initialisation.
 	 */
 
-	/* Prepare Memory for control transferes */
+	/* Prepare Memory for control transfers */
 	ctl_msg_buffer = devm_kzalloc(&udev->dev,
 				      sizeof(union ucan_ctl_payload),
 				      GFP_KERNEL);
@@ -1529,7 +1529,7 @@ static int ucan_probe(struct usb_interface *intf,
 	ret = ucan_device_request_in(up, UCAN_DEVICE_GET_FW_STRING, 0,
 				     sizeof(union ucan_ctl_payload));
 	if (ret > 0) {
-		/* copy string while ensuring zero terminiation */
+		/* copy string while ensuring zero termination */
 		strncpy(firmware_str, up->ctl_msg_buffer->raw,
 			sizeof(union ucan_ctl_payload));
 		firmware_str[sizeof(union ucan_ctl_payload)] = '\0';
-- 
2.53.0


