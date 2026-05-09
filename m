Return-Path: <stable+bounces-244891-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6JJJHTOl/mnPuQAAu9opvQ
	(envelope-from <stable+bounces-244891-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 09 May 2026 05:08:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B5024FDD22
	for <lists+stable@lfdr.de>; Sat, 09 May 2026 05:08:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 40CFB30074A9
	for <lists+stable@lfdr.de>; Sat,  9 May 2026 03:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2880B381AF1;
	Sat,  9 May 2026 03:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RqkDbT/z"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE85737B018
	for <stable@vger.kernel.org>; Sat,  9 May 2026 03:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778296112; cv=none; b=G2L5T+z0HXUGatJUOSC18Bzc3bfocAX/Id+aIA97PPA4OP1GX7yosBywYU0vJ68AiIXxpuHc5REZY5aHWWawFJpnlmS3+3wlfQQi27GMLUOiO7q1nJCD4/8anKAlGuh+4An/d9ZzPQugQc7XkguHIfZDVsyxYbKFM3I0B0iu0Eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778296112; c=relaxed/simple;
	bh=313VO7p8Crn1A78Y+1u+Eta/AdIbxTpcdOXYrr3qCTo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bsJGORZRGmPTab7i6GQWwwQQ5b05sI+qZp1BkSlnPYkRLELeA719q7C+ViC9u2G0YR3iClKx6TFtAedfMTMJYqQPyN71sZ+f6tDhDtP4VSIdbPgE+Px3Ruyyd1Zmy9XFF0zqzZbyURkAgstSTVhPlXQtEQAHXsb9dXhK9H1ixB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RqkDbT/z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7B08C2BCB0;
	Sat,  9 May 2026 03:08:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778296112;
	bh=313VO7p8Crn1A78Y+1u+Eta/AdIbxTpcdOXYrr3qCTo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RqkDbT/zsD4jF7jSgkX8iCTV6EJ96h0grIbJyyN9uhsryInzrQxHu2xvLF3A1ZKid
	 mHdwTzVhioAtx9clS753VKtpeS/Td7r70L9uzAQljtHlq03MMejhflHfzADuIgkRIN
	 H/wwj1m45mPAP9QYw09x+BhBe/6z4OWczqSKfAD0RM8rU3CtJbfsFG+JO4X89nU9yT
	 yuaNkppWDDba3He3bFcRzab3Yb3Hc5qESeJzI7649A6imLZ/GChkIVm+3HAySUjl6C
	 2w6fQ4dRj1UINxAHxKlv3DW5BvbXIiRXXI6NlH7nPzpCkPfI6DN3nEcxaXU4G1aaOk
	 dv8xOtFuHFwUA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Julia Lawall <Julia.Lawall@inria.fr>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/2] can: ucan: fix typos in comments
Date: Fri,  8 May 2026 23:08:28 -0400
Message-ID: <20260509030829.3038691-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026050411-squeegee-passion-d179@gregkh>
References: <2026050411-squeegee-passion-d179@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 0B5024FDD22
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-244891-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-0.997];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FROM_HAS_DN(0.00)[]
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
index c8b2b814bafec..58069c96cab20 100644
--- a/drivers/net/can/usb/ucan.c
+++ b/drivers/net/can/usb/ucan.c
@@ -1393,7 +1393,7 @@ static int ucan_probe(struct usb_interface *intf,
 	 * Stage 3 for the final driver initialisation.
 	 */
 
-	/* Prepare Memory for control transferes */
+	/* Prepare Memory for control transfers */
 	ctl_msg_buffer = devm_kzalloc(&udev->dev,
 				      sizeof(union ucan_ctl_payload),
 				      GFP_KERNEL);
@@ -1527,7 +1527,7 @@ static int ucan_probe(struct usb_interface *intf,
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


