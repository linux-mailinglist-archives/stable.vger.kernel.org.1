Return-Path: <stable+bounces-248827-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yC/MJw5QB2rBxgIAu9opvQ
	(envelope-from <stable+bounces-248827-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 18:55:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 41618554317
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 18:55:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7831430DE6B3
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 16:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 684793B4EA3;
	Fri, 15 May 2026 16:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Xh+HfUda"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A9242798F3;
	Fri, 15 May 2026 16:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778862734; cv=none; b=B+Y9+qcDuLNIim4Z6RTgvoywdYyqVU/hR4GY+jFrEnVewWz+/EHM29YciqGYUNRy9xp6J8bx3r9Bto2rcGOzWPv3LXtLBLztSAjV5asTApB2DLJrg9Zwc3rsbr/xeRXuXVWMvnAbkE8Kxvebn3zx8wR/J0ntTzTqztR2bUjoLQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778862734; c=relaxed/simple;
	bh=8V1opyRP86ewd8j42MlQc1ioJFkNece4VmvCS8Acktc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qWfc+z3Ds52sJR1CNF/TuwxswKT4Y85jW8Kxmg6DmEPGRANCQrZGTplLNIr4K43Bpxtttq2wFHOKaIT8qSB9B2w1fAWMmOOEHiFnZESUzTX3IC1pXUGNWZCCSj+JFBc8ldVkjpcAocWKJkliyxTOexvsnu7eHKSwZdB7Fw7/YdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Xh+HfUda; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3A81C2BCB0;
	Fri, 15 May 2026 16:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778862734;
	bh=8V1opyRP86ewd8j42MlQc1ioJFkNece4VmvCS8Acktc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Xh+HfUdaJacbi2kHZYAmIlZJmQZUmMgyxYcjeOPkS+Nw0OctR3W+u3Mq7BiJz58HU
	 Y4gAtuZE8FcmwTVLaaxjeoscIJyk8YjuQ8qFxp8Ul+JVQGk3rLjNeEQWMWc2EzOWZA
	 YTtP3Fa2ueRA/Et6+NPKkaba9Y9/XF9Uw8Jv1Uuc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Kory Maincent (TI)" <kory.maincent@bootlin.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>
Subject: [PATCH 7.0 161/201] drm/bridge: tda998x: Use __be32 for audio port OF property pointer
Date: Fri, 15 May 2026 17:49:39 +0200
Message-ID: <20260515154702.063289780@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260515154658.538039039@linuxfoundation.org>
References: <20260515154658.538039039@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 41618554317
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-248827-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,kernel];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,bootlin.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,msgid.link:url,armlinux.org.uk:email]
X-Rspamd-Action: no action

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kory Maincent (TI) <kory.maincent@bootlin.com>

commit 2a46a9356ba7b1bdd741c8b41e5374edcd960557 upstream.

of_get_property() returns a pointer to big-endian (__be32) data, but
port_data in tda998x_get_audio_ports() was declared as const u32 *,
causing a sparse endianness type mismatch warning. Fix the declaration
to use const __be32 *.

Fixes: 7e567624dc5a4 ("drm/i2c: tda998x: Register ASoC hdmi-codec and add audio DT binding")
Cc: stable@vger.kernel.org
Signed-off-by: Kory Maincent (TI) <kory.maincent@bootlin.com>
Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Link: https://patch.msgid.link/20260428090457.121894-1-kory.maincent@bootlin.com
Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/bridge/tda998x_drv.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/gpu/drm/bridge/tda998x_drv.c
+++ b/drivers/gpu/drm/bridge/tda998x_drv.c
@@ -1697,7 +1697,7 @@ static const struct drm_bridge_funcs tda
 static int tda998x_get_audio_ports(struct tda998x_priv *priv,
 				   struct device_node *np)
 {
-	const u32 *port_data;
+	const __be32 *port_data;
 	u32 size;
 	int i;
 



