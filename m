Return-Path: <stable+bounces-266449-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9jFALNSdMWpJoQUAu9opvQ
	(envelope-from <stable+bounces-266449-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 21:02:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A1BF694AF8
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 21:02:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=lMDQX8rY;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-266449-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-266449-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BCF1C3070723
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 19:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CD9A362149;
	Tue, 16 Jun 2026 19:01:14 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C3423191BA;
	Tue, 16 Jun 2026 19:01:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781636474; cv=none; b=ZKYMnu3Tzkx9xy+sMc7Vp9NJm37ZUYnlOhlNuLKXDxRm9R4jd0aiD0IIriTISCjx1fUNcSL2qf5TVENgxC9jF9hN7WPMHJvexIEjNzMsiDQHFwapK3Hi8gnrXWsDUUldq+rL15XplS21pxgXpXKMg/xuFwlmPPynyXs2pBYuEPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781636474; c=relaxed/simple;
	bh=ltGNaADxQkNgy9KYakM+dXSfFdghMWbvQ8HOZ8j1EV8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gYzl3u8O+8Os6vBvHa8i9x5i7vwaSzQmGzPDe45HX3OO3o6xgbHq7JPsS2umQDpP3uSXY/WOyjThKkOOPpUNiW58KBKBjfkCPAvZiQA2JngYicCOlK/iBRmtnUWOkfVDDhUYSksVZmUzu1zboyxG3ND5a2l3jCGsc/ii5bERzsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lMDQX8rY; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DC401F000E9;
	Tue, 16 Jun 2026 19:01:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781636472;
	bh=uoSbW6mB2D+lrDkgGNGmlKPOdl2WXbdCQdtFYTPZy9A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lMDQX8rY9eT08KkYx6PK3mtk6bLPfbSd0lQq0fQj/apBKAuE2W3jp7nmsBANMJysJ
	 /kfsQ+08W1Geu51vEcKOEoARiztHNMFF8+GEahLIk1/mGpJkrI+XGGO+7nNrI6hQVd
	 iRJJDIG4Wj5SG/2lp1ONhIp1CYHadO0w9bJfl+x0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Julia Lawall <Julia.Lawall@inria.fr>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 244/342] can: ucan: fix typos in comments
Date: Tue, 16 Jun 2026 20:29:00 +0530
Message-ID: <20260616145059.581152271@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145048.348037099@linuxfoundation.org>
References: <20260616145048.348037099@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-266449-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:Julia.Lawall@inria.fr,m:mkl@pengutronix.de,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,inria.fr:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4A1BF694AF8

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/can/usb/ucan.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/net/can/usb/ucan.c
+++ b/drivers/net/can/usb/ucan.c
@@ -1393,7 +1393,7 @@ static int ucan_probe(struct usb_interfa
 	 * Stage 3 for the final driver initialisation.
 	 */
 
-	/* Prepare Memory for control transferes */
+	/* Prepare Memory for control transfers */
 	ctl_msg_buffer = devm_kzalloc(&udev->dev,
 				      sizeof(union ucan_ctl_payload),
 				      GFP_KERNEL);
@@ -1527,7 +1527,7 @@ static int ucan_probe(struct usb_interfa
 	ret = ucan_device_request_in(up, UCAN_DEVICE_GET_FW_STRING, 0,
 				     sizeof(union ucan_ctl_payload));
 	if (ret > 0) {
-		/* copy string while ensuring zero terminiation */
+		/* copy string while ensuring zero termination */
 		strncpy(firmware_str, up->ctl_msg_buffer->raw,
 			sizeof(union ucan_ctl_payload));
 		firmware_str[sizeof(union ucan_ctl_payload)] = '\0';



