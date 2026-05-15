Return-Path: <stable+bounces-247595-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qEZDACLgBmqkogIAu9opvQ
	(envelope-from <stable+bounces-247595-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 10:58:10 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 53B6554BD60
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 10:58:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EE8023178E11
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 08:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B74964266A6;
	Fri, 15 May 2026 08:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="t5k1jVBh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC2842669B
	for <stable@vger.kernel.org>; Fri, 15 May 2026 08:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778834447; cv=none; b=qROsqPdTuU+iRlb/dJWeA9PVkQpyf5mpx5NgaGiXGgfqn2EgqcgwRtm3dNfJnwccCda7oGTT+SNFWuLg2j1h+Teqdoe141M0ATKlLZPJz4C674rsWpsWS7R2pnaX4t4A7pPbShbCn4+TdyS7fF37gIC7e/B6PH0db7GcFTSfgzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778834447; c=relaxed/simple;
	bh=zmbuO87UQZAGiQecOR9TFN50jjn+hLrsvfkfq2YdqPk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=qjfun7whd5OK/1zdSB32LHjdSVw7CwNBAjUbLu7CpD5X7VUmGm7hLT488oTT6grEnFFtumP2iQ4TJrdhGug+FcoBAe//ivrBiGn5dsnQRTHpgwp2WNKKoZ+CWAqLW1ms0liAk1xGAHEsvwlDgiJuQLFjJd/EPmCnNv5x3qMPPm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=t5k1jVBh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C33CDC2BCB0;
	Fri, 15 May 2026 08:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778834447;
	bh=zmbuO87UQZAGiQecOR9TFN50jjn+hLrsvfkfq2YdqPk=;
	h=Subject:To:Cc:From:Date:From;
	b=t5k1jVBhoL81jxItyKYwYterSidMhuEMXqOcQYII8BSsw9N6AcY0QmOw+X1AxvhmJ
	 h+DHhtzv54PogMSN9xp/dVOgEwEqMmp4KTa9W94iND/T9u2eQlsKfTsNIm88mDkJFI
	 cVird6y5gtEopF83mMc+W/nZS9S0oICjF/TZ7nfo=
Subject: FAILED: patch "[PATCH] drm/bridge: tda998x: Use __be32 for audio port OF property" failed to apply to 5.10-stable tree
To: kory.maincent@bootlin.com,luca.ceresoli@bootlin.com,rmk+kernel@armlinux.org.uk
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 15 May 2026 10:40:38 +0200
Message-ID: <2026051538-riverside-stove-8eaf@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 53B6554BD60
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-247595-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 2a46a9356ba7b1bdd741c8b41e5374edcd960557
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026051538-riverside-stove-8eaf@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

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
 


