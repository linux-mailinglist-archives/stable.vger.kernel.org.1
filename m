Return-Path: <stable+bounces-271115-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7IhYMzyYRmpIZgsAu9opvQ
	(envelope-from <stable+bounces-271115-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 18:56:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FEDF6FAC5D
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 18:56:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=NqqmodX1;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-271115-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-271115-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E566E30DC45A
	for <lists+stable@lfdr.de>; Thu,  2 Jul 2026 16:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FF363290C9;
	Thu,  2 Jul 2026 16:45:10 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 155503AF64D;
	Thu,  2 Jul 2026 16:45:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783010710; cv=none; b=QgJnldocpfQzPDLanGR+ggO56zd9ZLrpy0VxCnjKNOhbhvjkch+xo0Y/fk4YmVtvY+N+gFgdtDBsTYFX89CGAsmuzZ0y8XM0UKLmTk1E9hEFxJo0hqKWqj6XV34wkI/hA63LGZC+I55xV59poNMgSVYXqbxxvb4O05bqqAto0B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783010710; c=relaxed/simple;
	bh=S7Jk7ky1p4uVrbkQbDfdggfvu2yaazvbxj9h5cdhCq0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OCKRgF1PDVXTi772vdukynu5nuIs/DYUSi6eK66dj3ymJn28ykx84F58adEa0Z4+vRRRJcvc6xTeA30I/g6H7v0vgeLm3I9tFqV+02u3z+QDrDJl6qDFg/Vi2zRWcgaPZhHD6dScg/7MjkaxHt6SOQssi7pVvN6vK2HU+14QXeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NqqmodX1; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BC881F000E9;
	Thu,  2 Jul 2026 16:45:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783010708;
	bh=qcng3kCTruOsyoKOsYWsW9a81s0OnAasgh/X6KagxU8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NqqmodX1njzyGym4U0VpSSyCegawP/lQ52hAIfhtIopzgRNb/S2hTBfrU+QONSjFk
	 SglyM7kL++JGcBIUETscg1wNKqYq61KUu0F+qPim2A4nsdaS5xxA2P5i9pm6qVbgRv
	 MX8pidsC874YcqudQJsqbNw6BQ0AQhbBsz9zlDnc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Jiri Slaby <jirislaby@kernel.org>,
	Tonghao Zhang <tonghao@bamaicloud.com>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Jay Vosburgh <jv@jvosburgh.net>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.12 202/204] net: bonding: update the slave array for broadcast mode
Date: Thu,  2 Jul 2026 18:20:59 +0200
Message-ID: <20260702155122.896823808@linuxfoundation.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260702155118.667618796@linuxfoundation.org>
References: <20260702155118.667618796@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-271115-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:horms@kernel.org,m:corbet@lwn.net,m:andrew+netdev@lunn.ch,m:jirislaby@kernel.org,m:tonghao@bamaicloud.com,m:liuhangbin@gmail.com,m:razor@blackwall.org,m:jv@jvosburgh.net,m:kuba@kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,kernel.org,lwn.net,lunn.ch,bamaicloud.com,gmail.com,blackwall.org,jvosburgh.net];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,vger.kernel.org:from_smtp,blackwall.org:email,lunn.ch:email,lwn.net:email,bamaicloud.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5FEDF6FAC5D

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tonghao Zhang <tonghao@bamaicloud.com>

commit e0caeb24f538c3c9c94f471882ceeb43d9dc2739 upstream.

This patch fixes ce7a381697cb ("net: bonding: add broadcast_neighbor option for 802.3ad").
Before this commit, on the broadcast mode, all devices were traversed using the
bond_for_each_slave_rcu. This patch supports traversing devices by using all_slaves.
Therefore, we need to update the slave array when enslave or release slave.

Fixes: ce7a381697cb ("net: bonding: add broadcast_neighbor option for 802.3ad")
Cc: Simon Horman <horms@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>
Cc: <stable@vger.kernel.org>
Reported-by: Jiri Slaby <jirislaby@kernel.org>
Tested-by: Jiri Slaby <jirislaby@kernel.org>
Link: https://lore.kernel.org/all/a97e6e1e-81bc-4a79-8352-9e4794b0d2ca@kernel.org/
Signed-off-by: Tonghao Zhang <tonghao@bamaicloud.com>
Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>
Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
Acked-by: Jay Vosburgh <jv@jvosburgh.net>
Link: https://patch.msgid.link/20251016125136.16568-1-tonghao@bamaicloud.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/bonding/bond_main.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -2390,7 +2390,9 @@ skip_mac_set:
 			bpf_prog_inc(bond->xdp_prog);
 	}
 
-	if (bond_mode_can_use_xmit_hash(bond))
+	/* broadcast mode uses the all_slaves to loop through slaves. */
+	if (bond_mode_can_use_xmit_hash(bond) ||
+	    BOND_MODE(bond) == BOND_MODE_BROADCAST)
 		bond_update_slave_arr(bond, NULL);
 
 	bond_xdp_set_features(bond_dev);
@@ -2533,7 +2535,8 @@ static int __bond_release_one(struct net
 
 	bond_upper_dev_unlink(bond, slave);
 
-	if (bond_mode_can_use_xmit_hash(bond))
+	if (bond_mode_can_use_xmit_hash(bond) ||
+	    BOND_MODE(bond) == BOND_MODE_BROADCAST)
 		bond_update_slave_arr(bond, slave);
 
 	slave_info(bond_dev, slave_dev, "Releasing %s interface\n",



