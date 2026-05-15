Return-Path: <stable+bounces-247596-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8G0SJibgBmqkogIAu9opvQ
	(envelope-from <stable+bounces-247596-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 10:58:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0306B54BD67
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 10:58:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 138E83179C80
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 08:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57D3F40759B;
	Fri, 15 May 2026 08:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tlo56nQu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15EB3402B83
	for <stable@vger.kernel.org>; Fri, 15 May 2026 08:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778834450; cv=none; b=ftQlRR3OWWIjAAav9399LkRiWd2KYVWEbHNbgfN5QrP/EtVpvb/8ZQE4FClOaJf+JRgbnrC4cAPkJtvmBEx19rmFP9PsSxqwqf8+kioM2wAmdpFxc4qnSA6sWO48fb8SUSThyBFewpvVuYulHNacPnSW/mY966qglsyJWJc5wVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778834450; c=relaxed/simple;
	bh=OfC7wJUUT4Xi5Gp2+HP75J65WR9nwoKDGI+Uv4h6OIs=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=eRH5aMwh8tmv9i86SLmyV0Q/LiM665xVqO+3faUUcRmXo896h51BC2pyetSxRDUndJOPoiv3veMYBnA5/zqejhoF8okW1woK/jfDoyB4i814EPRlkxmMGmpgJgCK7tS0AKLdaDSiXJCsHC1DfdOExKYij+E2NhG1wVgvCyJm95A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tlo56nQu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96D66C2BCC7;
	Fri, 15 May 2026 08:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778834450;
	bh=OfC7wJUUT4Xi5Gp2+HP75J65WR9nwoKDGI+Uv4h6OIs=;
	h=Subject:To:Cc:From:Date:From;
	b=tlo56nQuni8wGtvz6m4tdOaRYBkRr88jRJfkjDh47lm2amSBeKQqaj/JRPMPkLIGp
	 hL8ah+XIcFOYns45iSkFi0qsblvDpCMKjxzW2wh0PpiSVna9pEW0yd1A//BSQ6MdnK
	 DaapiHUiYUfbKRuhEtBXDO04G8RkEqpgaqhsN4GI=
Subject: FAILED: patch "[PATCH] drm/bridge: tda998x: Use __be32 for audio port OF property" failed to apply to 6.1-stable tree
To: kory.maincent@bootlin.com,luca.ceresoli@bootlin.com,rmk+kernel@armlinux.org.uk
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 15 May 2026 10:40:38 +0200
Message-ID: <2026051538-posh-turret-38d9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 0306B54BD67
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-247596-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NO_DN(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,kernel];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+]
X-Rspamd-Action: no action


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 2a46a9356ba7b1bdd741c8b41e5374edcd960557
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026051538-posh-turret-38d9@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 2a46a9356ba7b1bdd741c8b41e5374edcd960557 Mon Sep 17 00:00:00 2001
From: "Kory Maincent (TI)" <kory.maincent@bootlin.com>
Date: Tue, 28 Apr 2026 11:04:56 +0200
Subject: [PATCH] drm/bridge: tda998x: Use __be32 for audio port OF property
 pointer

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

diff --git a/drivers/gpu/drm/bridge/tda998x_drv.c b/drivers/gpu/drm/bridge/tda998x_drv.c
index d9b388165de1..779b976f601c 100644
--- a/drivers/gpu/drm/bridge/tda998x_drv.c
+++ b/drivers/gpu/drm/bridge/tda998x_drv.c
@@ -1762,7 +1762,7 @@ static const struct drm_bridge_funcs tda998x_bridge_funcs = {
 static int tda998x_get_audio_ports(struct tda998x_priv *priv,
 				   struct device_node *np)
 {
-	const u32 *port_data;
+	const __be32 *port_data;
 	u32 size;
 	int i;
 


