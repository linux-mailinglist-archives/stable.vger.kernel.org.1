Return-Path: <stable+bounces-256379-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WPibIlOtGGqnmAgAu9opvQ
	(envelope-from <stable+bounces-256379-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 23:02:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 06B585FA1C6
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 23:02:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4405B3053305
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 20:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9BC12BE621;
	Thu, 28 May 2026 20:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1kVwdrz0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE7FA27603A;
	Thu, 28 May 2026 20:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780001535; cv=none; b=jZskXBEScta46hMmVBNpdYWHcrcm3N8D+MFFSPQWnvfqDDeQHcjeax2HRXbxKV8OaLdZiepj9QREF2j5icvOzQzPHS0TPavR6uUj3W1aOherDPfDZ22/YEKjHDwHA54DvnLwuObf195YNBsL3ATga4kckixBl6FaWT30mX3kAXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780001535; c=relaxed/simple;
	bh=xQzct3Y8xOMaJwyqZurrnJAADuyi8NMZxQ7OYbcB5Yo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JO96KnWMMjEQCPUxO7B4pD4eHKQQSljq8MDb/aU/0mg+m89oM1lac3TwZZZznzwdZb1ZXlJnFqk4wz7F4caDpauZLrx7VlUbeladsTAC4sXK3juoTOoLn40Eg9WRY714YqNBx8g6+0FdyKZQPUEy5EW+PWWiDZdiq43/eKc0Lko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1kVwdrz0; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18C331F000E9;
	Thu, 28 May 2026 20:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780001534;
	bh=rYxwb+8xmJNfot1PCRSHjypD+quY0x/5NZfT1Ds0o2Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=1kVwdrz0p4SDAAhKlvpwWiBw9FlLd5zMFFg9faRl3nu4vYDrzWVGoyy1Cw0RNNcVC
	 /6WqPylMHlHn/7IapzneZEmNQCer6cCsz5D2AY/2qlgDZmemmOfthbzKBqisqGroLa
	 WeyCjugs2V0yZ11J0I1PFJuIPc3QeKIqz/WtB0sU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Petr Machata <petrm@nvidia.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 163/186] net: bridge: Flush multicast groups when snooping is disabled
Date: Thu, 28 May 2026 21:50:43 +0200
Message-ID: <20260528194933.363700326@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528194928.941004471@linuxfoundation.org>
References: <20260528194928.941004471@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256379-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nvidia.com:email,blackwall.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 06B585FA1C6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Petr Machata <petrm@nvidia.com>

[ Upstream commit 68800bbf583f26f71491141e4b3c8582f9cfcbde ]

When forwarding multicast packets, the bridge takes MDB into account when
IGMP / MLD snooping is enabled. Currently, when snooping is disabled, the
MDB is retained, even though it is not used anymore.

At the same time, during the time that snooping is disabled, the IGMP / MLD
control packets are obviously ignored, and after the snooping is reenabled,
the administrator has to assume it is out of sync. In particular, missed
join and leave messages would lead to traffic being forwarded to wrong
interfaces.

Keeping the MDB entries around thus serves no purpose, and just takes
memory. Note also that disabling per-VLAN snooping does actually flush the
relevant MDB entries.

This patch flushes non-permanent MDB entries as global snooping is
disabled.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>
Link: https://patch.msgid.link/5e992df1bb93b88e19c0ea5819e23b669e3dde5d.1761228273.git.petrm@nvidia.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: 4df78ff02629 ("bridge: mcast: Fix a possible use-after-free when removing a bridge port")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bridge/br_multicast.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index 4e75ec75c7021..f0a0f24f2172a 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -4641,6 +4641,14 @@ static void br_multicast_start_querier(struct net_bridge_mcast *brmctx,
 	rcu_read_unlock();
 }
 
+static void br_multicast_del_grps(struct net_bridge *br)
+{
+	struct net_bridge_port *port;
+
+	list_for_each_entry(port, &br->port_list, list)
+		__br_multicast_disable_port_ctx(&port->multicast_ctx);
+}
+
 int br_multicast_toggle(struct net_bridge *br, unsigned long val,
 			struct netlink_ext_ack *extack)
 {
@@ -4661,6 +4669,7 @@ int br_multicast_toggle(struct net_bridge *br, unsigned long val,
 	br_opt_toggle(br, BROPT_MULTICAST_ENABLED, !!val);
 	if (!br_opt_get(br, BROPT_MULTICAST_ENABLED)) {
 		change_snoopers = true;
+		br_multicast_del_grps(br);
 		goto unlock;
 	}
 
-- 
2.53.0




