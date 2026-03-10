Return-Path: <stable+bounces-224481-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6NCLM+sEsGlAegIAu9opvQ
	(envelope-from <stable+bounces-224481-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:47:55 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5291424B8F3
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:47:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3BE3230DF86C
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 11:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB7DA3EDAB2;
	Tue, 10 Mar 2026 11:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HfA83gJ+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F1A244E040;
	Tue, 10 Mar 2026 11:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773142212; cv=none; b=tRZpg6CmhR1+2uTwg/6aoRhR+blrH5pzT6rjDudkvaJEpjn8dxrjcgiyce6A8MBpVDwJkud7yjiMlLcaNoul12j09/wOr2+9MrQ1fwQbqq1mBn7IghysupxiHvgUJ6g+q62FRgHb6KPwxa3IITdjcXfKom/5K1p/62OT+vB8/iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773142212; c=relaxed/simple;
	bh=ofkiFYobMeRAyCF5p7DSR9LH6imLwb4VUlfSG+CuHEc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Baiet6UhWPH/4g+FGkEtzTMZHBewMRd9iaCqSq79d7PqBeI5qeet0xI9yLDpVSBVf21ccjCYBlrfXsyqyvovUX0MnRhFIV4KX1nYzC51rov6RUhU3LYB10K91tSmj3IAEdRn/OdF3DOKjFObiww5BDM866oCWBA8bs5XUGiqmC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HfA83gJ+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8314AC2BC86;
	Tue, 10 Mar 2026 11:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773142212;
	bh=ofkiFYobMeRAyCF5p7DSR9LH6imLwb4VUlfSG+CuHEc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HfA83gJ+eA5rAN7L4dBRMD3GKRk5PJrRRToFidnm4DNfCaXR3X6kYoCfbd5Yy61Bh
	 KnTaZ20ZEbOrwR+q9tKBOY9CeeHJFT7vTyLhVbewupDnDUq2WLaKKlXpOyG4zqxqrS
	 0Fd7g+Yi7IRqWZgLTydsTn6x6uNh8Ft1yWDV3S1Oijrp1RfTA7fw5MyM3HRcTgv8VC
	 HbBKX0/PNLehrWxoaA9b1mkoMMCO75SpB+MOZk3fs8OQMLhwmRv+fdDXEkMfnCjKWO
	 oHWJkul/P1MOVJXQbrl5XivmcM1XTlE/nJ+0PuOAqw4ryDp9cDkmwuJjDoBkk7Yp1s
	 9kphMD8MjO3bQ==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@shopee.com>,
	Ido Schimmel <idosch@nvidia.com>,
	syzbot+334190e097a98a1b81bb@syzkaller.appspotmail.com,
	David Ahern <dsahern@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 302/314] net: ipv6: fix panic when IPv4 route references loopback IPv6 nexthop
Date: Tue, 10 Mar 2026 07:19:21 -0400
Message-ID: <2646b27411f2d88d3665d7227eaaefc381aefa1d.1773141556.git.sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1773141554.git.sashal@kernel.org>
References: <cover.1773141554.git.sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 5291424B8F3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-224481-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,334190e097a98a1b81bb];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,shopee.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,nvidia.com:email,appspotmail.com:email]
X-Rspamd-Action: no action

From: Jiayuan Chen <jiayuan.chen@shopee.com>

[ Upstream commit 21ec92774d1536f71bdc90b0e3d052eff99cf093 ]

When a standalone IPv6 nexthop object is created with a loopback device
(e.g., "ip -6 nexthop add id 100 dev lo"), fib6_nh_init() misclassifies
it as a reject route. This is because nexthop objects have no destination
prefix (fc_dst=::), causing fib6_is_reject() to match any loopback
nexthop. The reject path skips fib_nh_common_init(), leaving
nhc_pcpu_rth_output unallocated. If an IPv4 route later references this
nexthop, __mkroute_output() dereferences NULL nhc_pcpu_rth_output and
panics.

Simplify the check in fib6_nh_init() to only match explicit reject
routes (RTF_REJECT) instead of using fib6_is_reject(). The loopback
promotion heuristic in fib6_is_reject() is handled separately by
ip6_route_info_create_nh(). After this change, the three cases behave
as follows:

1. Explicit reject route ("ip -6 route add unreachable 2001:db8::/64"):
   RTF_REJECT is set, enters reject path, skips fib_nh_common_init().
   No behavior change.

2. Implicit loopback reject route ("ip -6 route add 2001:db8::/32 dev lo"):
   RTF_REJECT is not set, takes normal path, fib_nh_common_init() is
   called. ip6_route_info_create_nh() still promotes it to reject
   afterward. nhc_pcpu_rth_output is allocated but unused, which is
   harmless.

3. Standalone nexthop object ("ip -6 nexthop add id 100 dev lo"):
   RTF_REJECT is not set, takes normal path, fib_nh_common_init() is
   called. nhc_pcpu_rth_output is properly allocated, fixing the crash
   when IPv4 routes reference this nexthop.

Suggested-by: Ido Schimmel <idosch@nvidia.com>
Fixes: 493ced1ac47c ("ipv4: Allow routes to use nexthop objects")
Reported-by: syzbot+334190e097a98a1b81bb@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/698f8482.a70a0220.2c38d7.00ca.GAE@google.com/T/
Signed-off-by: Jiayuan Chen <jiayuan.chen@shopee.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
Link: https://patch.msgid.link/20260304113817.294966-2-jiayuan.chen@linux.dev
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv6/route.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index e7d90a28948a4..e01331d965313 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -3584,7 +3584,6 @@ int fib6_nh_init(struct net *net, struct fib6_nh *fib6_nh,
 	netdevice_tracker *dev_tracker = &fib6_nh->fib_nh_dev_tracker;
 	struct net_device *dev = NULL;
 	struct inet6_dev *idev = NULL;
-	int addr_type;
 	int err;
 
 	fib6_nh->fib_nh_family = AF_INET6;
@@ -3626,11 +3625,10 @@ int fib6_nh_init(struct net *net, struct fib6_nh *fib6_nh,
 
 	fib6_nh->fib_nh_weight = 1;
 
-	/* We cannot add true routes via loopback here,
-	 * they would result in kernel looping; promote them to reject routes
+	/* Reset the nexthop device to the loopback device in case of reject
+	 * routes.
 	 */
-	addr_type = ipv6_addr_type(&cfg->fc_dst);
-	if (fib6_is_reject(cfg->fc_flags, dev, addr_type)) {
+	if (cfg->fc_flags & RTF_REJECT) {
 		/* hold loopback dev/idev if we haven't done so. */
 		if (dev != net->loopback_dev) {
 			if (dev) {
-- 
2.51.0


