Return-Path: <stable+bounces-264117-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id JKZqMqVvMWokjQUAu9opvQ
	(envelope-from <stable+bounces-264117-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:45:41 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EC976915E3
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:45:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=si5zjOaf;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-264117-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-264117-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1CC74311427A
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 15:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C542D44BCBE;
	Tue, 16 Jun 2026 15:36:56 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D1034889F;
	Tue, 16 Jun 2026 15:36:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781624216; cv=none; b=IyHVdJr9YfaPlHdt0l1FEv2nhUGEWZGFfwGJUbK2wYWueBC565nhl+PV0QESFjUZDHdhWe8LbsfFJ7IR68PT21KMNHTnMovpo/IkihMgLSdofnyQ6a2jxd7CpXMeR4lrDPdTqVlivF7VV4CQyZ+Vlc7KgLVkumLeu0Amj3wZ4+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781624216; c=relaxed/simple;
	bh=qDCslrJGTNisHFTqnlddg3fnePWkTCCgcExjmmldqGk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L9+sExf0HnGvi4bb8lC0IChKEcMKD5VmuQOlWtt1DQamOY+K2BubTuVh2MAnvt4RDXU2qYdAOPgpwZV6TkgRxmenWGjcoO+7Kou/ZeOrdMhGJ98reVtiNbPX1kwIVvS+Mp/Pw6SQqYuI7Ljm8DpctapzHzVpm3txTnJCzUN0/0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=si5zjOaf; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 685111F00A3F;
	Tue, 16 Jun 2026 15:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781624215;
	bh=ONMFNck8dsl0frLDkVjB/HsuFzsMdLjHzXvdFnQugpI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=si5zjOafPKeCY7syuohshtqLClwomS3P1r4jZpbp+WBi0Vw+uXc/jnvQn8ngylxmq
	 fy7zPDW2DhdN0MOa5GIJrmf5T4Goobyxl5eueGKxEdEjmieAx1zAMT6CP28lFx21PE
	 DyCMywPX+kfW/IqQwEb8TvVN5HxDPV+ddpmeF/m8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jonas Jelonek <jelonek.jonas@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 7.0 293/378] net: sfp: initialize i2c_block_size at adapter configure time
Date: Tue, 16 Jun 2026 20:28:44 +0530
Message-ID: <20260616145125.490752370@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145109.744539446@linuxfoundation.org>
References: <20260616145109.744539446@linuxfoundation.org>
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
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-264117-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:jelonek.jonas@gmail.com,m:kuba@kernel.org,m:jelonekjonas@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5EC976915E3

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jonas Jelonek <jelonek.jonas@gmail.com>

commit 56d0885514491e5ed8f7593400879ab77c52504c upstream.

sfp->i2c_block_size is only assigned in sfp_sm_mod_probe(), which runs
from the state machine timer after SFP_F_PRESENT has been set. Between
those two points, sfp_module_eeprom() (the ethtool -m callback) gates
only on SFP_F_PRESENT and can be entered with i2c_block_size still at
its kzalloc'd value of 0.

On a pure-I2C adapter, sfp_i2c_read() then issues an i2c_transfer()
with msgs[1].len = 0 inside a loop that subtracts this_len from len
each iteration; on adapters that succeed a zero-length read the loop
never advances, spinning while holding rtnl_lock.

This was previously addressed by initializing i2c_block_size in
sfp_alloc() (commit 813c2dd78618), but the initialization was dropped
when i2c_block_size was split from i2c_max_block_size.

Initialize sfp->i2c_block_size from sfp->i2c_max_block_size in
sfp_i2c_configure(), so the field is valid as soon as the adapter is
known. sfp_sm_mod_probe() still reassigns it on each module insertion
to recover from a per-module clamp to 1 (sfp_id_needs_byte_io).

Fixes: 7662abf4db94 ("net: phy: sfp: Add support for SMBus module access")
Cc: stable@vger.kernel.org
Signed-off-by: Jonas Jelonek <jelonek.jonas@gmail.com>
Link: https://patch.msgid.link/20260528205242.971410-2-jelonek.jonas@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/phy/sfp.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/net/phy/sfp.c
+++ b/drivers/net/phy/sfp.c
@@ -820,6 +820,7 @@ static int sfp_i2c_configure(struct sfp
 		return -EINVAL;
 	}
 
+	sfp->i2c_block_size = sfp->i2c_max_block_size;
 	return 0;
 }
 



