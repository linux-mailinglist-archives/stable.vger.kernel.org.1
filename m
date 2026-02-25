Return-Path: <stable+bounces-218441-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QPfVFQpTnmm3UgQAu9opvQ
	(envelope-from <stable+bounces-218441-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:40:26 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CD40A18F678
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:40:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A8A3F31D63B8
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45EE6242D9B;
	Wed, 25 Feb 2026 01:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Hu0/OAJ3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092051E2834;
	Wed, 25 Feb 2026 01:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771983263; cv=none; b=nqI1F041iijZ6kPQJc9y1gDa1E3/jURAuVry/5wAYau10uMFfitEKG+Hd/ZrnOEQPCZLwZkkS4MFRkGk2YWTZ7YOP8/3XtouNqyuUwujZ4pYxH3q+AhEDWKyGwPbrZhW8ZFKhEATeshY+lUX+HaxRtbA2sx7aLA+Fa6wZV59Z3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771983263; c=relaxed/simple;
	bh=xvXXnhkOHssovsxSq+tFlo2HJOeWLtErlzNfbGNu4ow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k/jHmHXa7Jk8h1w+Rv79X6PL3L8R3msH1QUhVnDInhxqROf7Tel4bBMiO4dgOfA5HLC4C9JNwPJE8dUF/4Ohy44aICcCojnLdUORS+oavjgV3Gfwedz5Wqzl4Eiskb2Q2MqwBZgdur1ntgrGo9hSg02c6w9cp7yXx0UQlUQOX4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Hu0/OAJ3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA0B8C116D0;
	Wed, 25 Feb 2026 01:34:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771983262;
	bh=xvXXnhkOHssovsxSq+tFlo2HJOeWLtErlzNfbGNu4ow=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Hu0/OAJ3/lozDlKm8y1SJg9aWCMFna5UNEUPxGZBnaHpPE6g50rf6/CpEzTBIeuSJ
	 Lh6hLsGNNyA7xGva+fsWIRTZOFi1fMYeWBKBZZ/1f7KaEgj5OG83vnwGXEVruqZQef
	 Fm9JkDLxyyk1DuD4STKXTTwvpm6b2vx/uFQ7mxBY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Thomas Bogendoerfer <tbogendoerfer@suse.de>,
	Jay Vosburgh <jv@jvosburgh.net>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 404/781] bonding: only set speed/duplex to unknown, if getting speed failed
Date: Tue, 24 Feb 2026 17:18:33 -0800
Message-ID: <20260225012409.613011146@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225012359.695468795@linuxfoundation.org>
References: <20260225012359.695468795@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,suse.de,jvosburgh.net,blackwall.org,gmail.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-218441-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,suse.de:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,blackwall.org:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CD40A18F678
X-Rspamd-Action: no action

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Bogendoerfer <tbogendoerfer@suse.de>

[ Upstream commit 48dec8d88af96039a4a17b8c2f148f2a4066e195 ]

bond_update_speed_duplex() first set speed/duplex to unknown and
then asks slave driver for current speed/duplex. Since getting
speed/duplex might take longer there is a race, where this false state
is visible by /proc/net/bonding. With commit 691b2bf14946 ("bonding:
 update port speed when getting bond speed") this race gets more visible,
if user space is calling ethtool on a regular base.

Fix this by only setting speed/duplex to unknown, if link speed is
really unknown/unusable.

Fixes: 98f41f694f46 ("bonding:update speed/duplex for NETDEV_CHANGE")
Signed-off-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>
Acked-by: Jay Vosburgh <jv@jvosburgh.net>
Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>
Link: https://patch.msgid.link/20260203141153.51581-1-tbogendoerfer@suse.de
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/bonding/bond_main.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 45bd2bb102ffd..47f13d86cb7ef 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -791,26 +791,29 @@ static int bond_update_speed_duplex(struct slave *slave)
 	struct ethtool_link_ksettings ecmd;
 	int res;
 
-	slave->speed = SPEED_UNKNOWN;
-	slave->duplex = DUPLEX_UNKNOWN;
-
 	res = __ethtool_get_link_ksettings(slave_dev, &ecmd);
 	if (res < 0)
-		return 1;
+		goto speed_duplex_unknown;
 	if (ecmd.base.speed == 0 || ecmd.base.speed == ((__u32)-1))
-		return 1;
+		goto speed_duplex_unknown;
 	switch (ecmd.base.duplex) {
 	case DUPLEX_FULL:
 	case DUPLEX_HALF:
 		break;
 	default:
-		return 1;
+		goto speed_duplex_unknown;
 	}
 
 	slave->speed = ecmd.base.speed;
 	slave->duplex = ecmd.base.duplex;
 
 	return 0;
+
+speed_duplex_unknown:
+	slave->speed = SPEED_UNKNOWN;
+	slave->duplex = DUPLEX_UNKNOWN;
+
+	return 1;
 }
 
 const char *bond_slave_link_status(s8 link)
-- 
2.51.0




