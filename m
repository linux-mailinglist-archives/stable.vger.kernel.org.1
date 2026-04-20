Return-Path: <stable+bounces-239150-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0BcrKdFA5mlutgEAu9opvQ
	(envelope-from <stable+bounces-239150-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 17:05:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E332C42DC9C
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 17:05:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2A87233937D4
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 14:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C58B4481AB1;
	Mon, 20 Apr 2026 13:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b6VS48p+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85258481652;
	Mon, 20 Apr 2026 13:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776691906; cv=none; b=JKdmWc1KAb9QfWQRYFnl4RDCs47imBR5Pvz+NcCKoN+SlOUScFj077bvQF+hriYB7d/G8rZQ/4Nocn8KUrQCu7IrKireNsziteae0EEJqdeMHJ0PmJg8V7xkvmO5rr7R5ZnADOrL5rYiSl9Hy3/P5X58vTTo52TvG0veK7ith4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776691906; c=relaxed/simple;
	bh=B4Xzqt4Lv43VwlYDa91QCLcZ2QtZNuBo7FtpCh86sWM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i6ABg/+i6wAcoQcJe9mB1QTIxiS7ey042iCrgwWxLaXbaDcH8rYF4M6xlratGHMdMzpKU6+HOK3elvOMcTtLKNUUGMo+SURl+C1mmOKf1zb+3+2Wcm+FVQl34yVq8VOVhqSKbRhY2lnPJfUk/i+xgNwDrfcSJMODcHPHJe4S96s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b6VS48p+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 086FCC2BCB6;
	Mon, 20 Apr 2026 13:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776691906;
	bh=B4Xzqt4Lv43VwlYDa91QCLcZ2QtZNuBo7FtpCh86sWM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=b6VS48p+8zFYs3FmNoYWZhX0XNqrc4tNb2+b3w8nb2peaHNHZkkW3iSCNoM9ZC3T0
	 UeSWXGsqj0A/p23HNmQdf/eOVO7icpebi2+wLv+ROo03llApsluoAjX7Z2IbzfgP6e
	 bNL9FP3OpgfTOksOAkMSwgsRRN5TWFCUkAjk2PfWy13tYW67MiAUQ1Cz2ObORw1eKr
	 mywJ9MpC6E+ZbHFhjrO/zMMvVTsze003uOIa4mZgIZJeStVsi3A7aZqLa4req9COlJ
	 UdYsDUPMAJZIe3Fi/0FNKqH45MqzcjAvAfeaL9TdN1dbF1F37BobS3SzkRHJ+gz5Q2
	 Dh2SKe4T2dUrQ==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Zijing Yin <yzjaurora@gmail.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	petrm@nvidia.com,
	bridge@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.18] bridge: guard local VLAN-0 FDB helpers against NULL vlan group
Date: Mon, 20 Apr 2026 09:20:56 -0400
Message-ID: <20260420132314.1023554-262-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260420132314.1023554-1-sashal@kernel.org>
References: <20260420132314.1023554-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.18.23
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,nvidia.com,blackwall.org,kernel.org,davemloft.net,google.com,redhat.com,lists.linux.dev,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-239150-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: E332C42DC9C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Zijing Yin <yzjaurora@gmail.com>

[ Upstream commit 1979645e1842cb7017525a61a0e0e0beb924d02a ]

When CONFIG_BRIDGE_VLAN_FILTERING is not set, br_vlan_group() and
nbp_vlan_group() return NULL (br_private.h stub definitions). The
BR_BOOLOPT_FDB_LOCAL_VLAN_0 toggle code is compiled unconditionally and
reaches br_fdb_delete_locals_per_vlan_port() and
br_fdb_insert_locals_per_vlan_port(), where the NULL vlan group pointer
is dereferenced via list_for_each_entry(v, &vg->vlan_list, vlist).

The observed crash is in the delete path, triggered when creating a
bridge with IFLA_BR_MULTI_BOOLOPT containing BR_BOOLOPT_FDB_LOCAL_VLAN_0
via RTM_NEWLINK. The insert helper has the same bug pattern.

  Oops: general protection fault, probably for non-canonical address 0xdffffc0000000056: 0000 [#1] KASAN NOPTI
  KASAN: null-ptr-deref in range [0x00000000000002b0-0x00000000000002b7]
  RIP: 0010:br_fdb_delete_locals_per_vlan+0x2b9/0x310
  Call Trace:
   br_fdb_toggle_local_vlan_0+0x452/0x4c0
   br_toggle_fdb_local_vlan_0+0x31/0x80 net/bridge/br.c:276
   br_boolopt_toggle net/bridge/br.c:313
   br_boolopt_multi_toggle net/bridge/br.c:364
   br_changelink net/bridge/br_netlink.c:1542
   br_dev_newlink net/bridge/br_netlink.c:1575

Add NULL checks for the vlan group pointer in both helpers, returning
early when there are no VLANs to iterate. This matches the existing
pattern used by other bridge FDB functions such as br_fdb_add() and
br_fdb_delete().

Fixes: 21446c06b441 ("net: bridge: Introduce UAPI for BR_BOOLOPT_FDB_LOCAL_VLAN_0")
Signed-off-by: Zijing Yin <yzjaurora@gmail.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>
Link: https://patch.msgid.link/20260402140153.3925663-1-yzjaurora@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

Error: Failed to generate final synthesis

 net/bridge/br_fdb.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
index 0501ffcb8a3dd..e2c17f620f009 100644
--- a/net/bridge/br_fdb.c
+++ b/net/bridge/br_fdb.c
@@ -597,6 +597,9 @@ static void br_fdb_delete_locals_per_vlan_port(struct net_bridge *br,
 		dev = br->dev;
 	}
 
+	if (!vg)
+		return;
+
 	list_for_each_entry(v, &vg->vlan_list, vlist)
 		br_fdb_find_delete_local(br, p, dev->dev_addr, v->vid);
 }
@@ -630,6 +633,9 @@ static int br_fdb_insert_locals_per_vlan_port(struct net_bridge *br,
 		dev = br->dev;
 	}
 
+	if (!vg)
+		return 0;
+
 	list_for_each_entry(v, &vg->vlan_list, vlist) {
 		if (!br_vlan_should_use(v))
 			continue;
-- 
2.53.0


