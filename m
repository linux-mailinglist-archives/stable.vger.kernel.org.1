Return-Path: <stable+bounces-261125-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id UgKUJdVEJWr6FQIAu9opvQ
	(envelope-from <stable+bounces-261125-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:15:49 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9003D64F72F
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:15:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=nv2yXH0x;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-261125-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-261125-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BF7C63002B5C
	for <lists+stable@lfdr.de>; Sun,  7 Jun 2026 10:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE5062E3AF1;
	Sun,  7 Jun 2026 10:15:44 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F9584071DA;
	Sun,  7 Jun 2026 10:15:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780827344; cv=none; b=phl8dFXNES5etzSih2rd47f8FrktLjMoG5aM5JUpJOXAd1NLnvZjqliOEu8Bn6/d+vs1be7YqHBA9/ua0cH+P/UwK89IBt4he5EdiJMJmebmVu0qPzyUhqAzd0bYI/Tdg43Z39gRnFoVV1sJdkx/WDEK7onpD4fMCDyG7fXzKaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780827344; c=relaxed/simple;
	bh=MH+zu6bwV9RX3C48941Eaq0h2IHGcxeq6rBRS+6Gt8s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rU9EuGvWSMyFGhZlFMvDwJa+dM4mGWN1nvrx0sBxIlcj0v60g4Yfnk2IZeR8qJcH+3RREux+GDP18tH6ZrcNHxYWV3DqR5e/WthEF2wRZkoM1IHl5S8oNgkuOKCUFG13HGsXpXoMQ3UhZshSDc2QnTLACjZIQWHZ9sPv70yza3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nv2yXH0x; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE4731F00893;
	Sun,  7 Jun 2026 10:15:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780827343;
	bh=usvDKK46CRG6iBlitsgm/SRey0JyrR4TOr3gdjDEDLY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nv2yXH0xDh0LFgwT/vef6ieYTFlvDkb+hY/RHpWHe0eexEHZl30OPGMUQpmM3nk+z
	 bep5NELz26V6Or5nSwzYPasASdzewP4BOpe2Y3ldXPLC+lec4WU7xSDT4bGreRBqcg
	 yUlPos39RSWp7mDv3R4EV1ndWgItU39kQbpmlBzM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Frank Li <Frank.Li@nxp.com>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 047/307] gpio: mxc: fix irq_high handling
Date: Sun,  7 Jun 2026 11:57:24 +0200
Message-ID: <20260607095729.440859631@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260607095727.647295505@linuxfoundation.org>
References: <20260607095727.647295505@linuxfoundation.org>
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
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-261125-lists,stable=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:alexander.stein@ew.tq-group.com,m:Frank.Li@nxp.com,m:bartosz.golaszewski@oss.qualcomm.com,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,linuxfoundation.org:mid,linuxfoundation.org:from_mime,linuxfoundation.org:dkim,qualcomm.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,msgid.link:url,tq-group.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9003D64F72F

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexander Stein <alexander.stein@ew.tq-group.com>

[ Upstream commit dac917ed5aead741004db8d0d5151dd577802df8 ]

If port->irq_high is -1 (fsl,imx21-gpio compatible) and gpio_idx is >= 16
enable_irq_wake() is called with -1 which is wrong.

Fixes: 5f6d1998adeb ("gpio: mxc: release the parent IRQ in runtime suspend")
Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Link: https://patch.msgid.link/20260526063504.25916-1-alexander.stein@ew.tq-group.com
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpio/gpio-mxc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-mxc.c b/drivers/gpio/gpio-mxc.c
index 3cdc2b218a86af..a8ab78ae7fa30c 100644
--- a/drivers/gpio/gpio-mxc.c
+++ b/drivers/gpio/gpio-mxc.c
@@ -473,7 +473,7 @@ static int mxc_gpio_probe(struct platform_device *pdev)
 		 * the handler is needed only once, but doing it for every port
 		 * is more robust and easier.
 		 */
-		port->irq_high = -1;
+		port->irq_high = 0;
 		port->mx_irq_handler = mx2_gpio_irq_handler;
 	} else
 		port->mx_irq_handler = mx3_gpio_irq_handler;
-- 
2.53.0




