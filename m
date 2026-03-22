Return-Path: <stable+bounces-227815-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uEIYGntwv2lE4wMAu9opvQ
	(envelope-from <stable+bounces-227815-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 22 Mar 2026 05:30:51 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B0BDA2E8337
	for <lists+stable@lfdr.de>; Sun, 22 Mar 2026 05:30:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B09A13011BC1
	for <lists+stable@lfdr.de>; Sun, 22 Mar 2026 04:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A28C32F12A5;
	Sun, 22 Mar 2026 04:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EH9SGABB"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC6839FD4
	for <stable@vger.kernel.org>; Sun, 22 Mar 2026 04:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774153847; cv=none; b=EL18r2WoH44/BwchQy8r2BlInuxrmsysZ+1E8yuZ7R1PVjkd02ZCSMMEUDSMIPOJWdQOs/I0uYg77uis9nEPdUzvonO8aigkeRJtdJGYPAmrke/pzYMHNoX6HqJ8uHQNC2NxxmRrvQVUwa8hl3/Bs28aiw8kisJexZ5GVh7HnR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774153847; c=relaxed/simple;
	bh=CUuApDKoQMtCCg4GpytN1g4Bwai+oBAFU8ZlbmUpBFM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oamR1dvlFkpBphUizUc9CCUy/qNRCMCZvSLufEsLDTIR+qNQxqfwRI0PzIh942FdwhWqdVkpdy4LPCWzs6cU8X0GrXe5NEMbxQUFK3mPDX5H+a1XCPEKyc2VsvUTGeaVCYOwEh6/O6x4qiN1IndvKz5SAZtMgoJQ1Zy2T0UulD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EH9SGABB; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-c739561f0d3so1418535a12.3
        for <stable@vger.kernel.org>; Sat, 21 Mar 2026 21:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774153845; x=1774758645; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=a/hTMYLpbPYpDp+7S6/jATXJO+v3rVSWzKNTKPenwC8=;
        b=EH9SGABBXRl26kw8iFV95WCbD8Hag+/uYTD2FFzFUOLjvN6ffq1xa5fZqIdI4uoo1L
         JhFHRwVv1/UFnb3WX3+Knf4FEBeG7Ln3MG6WCaa7zYzkJ9ODPFS0fkb3B14AzhK3v5e+
         YNZ5rtR36M41FP4JgG4R4/f7YYbG6b7sTOD5phwObowOdURQ2l5eCP7ZNpuIbJyElbXQ
         uaMskfE7PrdhMZH0qhs7OY0Hs42PgLex2hFJLFDoO7YHSxM0x1zoWhuwJR3I+XBkU1x9
         kQf4VN+yiMV3FRnEgYnD+nCWfduzc5NOwibLJWcfcRSVZE/UV+aj9pzaPxWROJscg731
         zrdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774153845; x=1774758645;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a/hTMYLpbPYpDp+7S6/jATXJO+v3rVSWzKNTKPenwC8=;
        b=GB1UCRU/s/DyF8U1pkwQjy8Sn/K1KVh1M4e/lDjwFHSbNVGkSUH7EDCSFm527/5o3J
         LpAm4vOsesf2ypP8bZelLjNk1AYnRXIZV7k8rP+kBRIoPMlq3D6InyyT70Kya9LvUNUf
         ki5kGh+A3Tpxm0lk0DgSAmVTcTfu28xB2HUCBo5HKzXJg5+JJAzDy3jxIS93F9artplM
         1ZhKHvEuDgFS1/ssnd1RtUwfC4A/oY1qhIOvr2e7ZDOMR2l+uAjHHjIh7dkXjelu73FJ
         CF/Zry8cmSkHgzKsmi3UGscJa5o6VuzPZK4Gddw3e/8jHu9KzcXnWHGRtNag2lNTtBWy
         xjJQ==
X-Forwarded-Encrypted: i=1; AJvYcCW5sWiXK8yEamD3B2J58yg0SbVc1rE67mBWKsFeBaO1OZCsgXr7kUtxOwOL5CRwK0IQYANaz1w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzG2RLDIunF/WXRElzlHaea/PHWl1udgGRerGhTEhHDznUdXoJw
	sv6dK+Lj0UHNgDccndPREGiTLUZD3zPS+IkJfaOTnqfTvWTA9a5DKkuP
X-Gm-Gg: ATEYQzwgoC226oQTOJc/DIacOVi4ip+MJiiY9v6DNsB0Txux5WmIKZrQga+M1h0DcAT
	ncQSIM8Yd/LoZXFjn+N+Ex8GsxweGuPaMPOSGrdhmvZX2pmoygSaEC424Bd15t4CBnAkycKF6HN
	O+j4lv/IUO7IaL1GDpg3QA0A4s/LFaqgCSTpNXGSpzYAFbfiKN9HMwmYkeyOnaQdIdxSufIs3km
	dP561KMrJQhF9+AmzFuUb4tEEREYN2i50yX811OfARPy60BvLPMorsaqcfhcp0tLW8aOMyCfChm
	ygelg2kc9RXfFPKVkXwtuvJhtzpc6BY7qtVaK9qXx873hpcPJ7mgcFfZpOodH9kxZNFJQKq+peS
	mXrI+waKawCRvGdVYjWlmeJkb5sfU4U5/cA0Pcl21vK+p6QMZs8Z/DeDFuaX2tq3fKetKdZtT8T
	qL4+70ZeC+DwWd5sSZlC3lBbmCaU0VWKwS2hIexMlK9dk+M6tt5/gDMpoHK33oDyysLCkx0+uWl
	TJ7daoM9qM=
X-Received: by 2002:a17:902:e74b:b0:2b0:7531:b61e with SMTP id d9443c01a7336-2b0827c2095mr75386555ad.41.1774153845392;
        Sat, 21 Mar 2026 21:30:45 -0700 (PDT)
Received: from SLSGDTSWING002.tail0ac356.ts.net ([129.126.109.177])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b08366c3f7sm86002005ad.60.2026.03.21.21.30.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2026 21:30:44 -0700 (PDT)
From: bestswngs@gmail.com
To: pablo@netfilter.org,
	fw@strlen.de
Cc: phil@nwl.cc,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	xmei5@asu.edu,
	Weiming Shi <bestswngs@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH nf] netfilter: xt_devgroup: reject unsupported families in checkentry
Date: Sun, 22 Mar 2026 12:18:46 +0800
Message-ID: <20260322041844.983129-3-bestswngs@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[nwl.cc,davemloft.net,google.com,kernel.org,redhat.com,asu.edu,gmail.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227815-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NO_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bestswngs@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B0BDA2E8337
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Weiming Shi <bestswngs@gmail.com>

devgroup_mt_checkentry() validates hook_mask using NF_INET_* constants,
but the match is registered with NFPROTO_UNSPEC, which allows it to be
used from any protocol family through nft_compat.

On an ARP nftables output chain, nft_compat passes
hook_mask = 1 << NF_ARP_OUT. Because NF_ARP_OUT == 1 == NF_INET_LOCAL_IN,
the source-group hook validation incorrectly accepts the rule. At runtime
arp_xmit() invokes the chain with state->in == NULL, and devgroup_mt()
dereferences xt_in(par)->group, crashing the kernel:

 Oops: general protection fault, probably for non-canonical address 0xdffffc0000000044: 0000 [#1] SMP KASAN NOPTI
 KASAN: null-ptr-deref in range [0x0000000000000220-0x0000000000000227]
 RIP: 0010:devgroup_mt+0xff/0x350
 Call Trace:
  <TASK>
  nft_match_eval (net/netfilter/nft_compat.c:407)
  nft_do_chain (net/netfilter/nf_tables_core.c:285)
  nft_do_chain_arp (net/netfilter/nft_chain_filter.c:61)
  nf_hook_slow (net/netfilter/core.c:623)
  arp_xmit (net/ipv4/arp.c:666)
  arp_solicit (net/ipv4/arp.c:393)
  neigh_probe (net/core/neighbour.c:1098)
  __neigh_event_send (net/core/neighbour.c:1277)
  neigh_resolve_output (net/core/neighbour.c:1604)
  ip_finish_output2 (net/ipv4/ip_output.c:237)
  </TASK>
 Kernel panic - not syncing: Fatal exception in interrupt

Reject families whose hook numbering differs from the NF_INET_* scheme
early in checkentry. NFPROTO_INET and NFPROTO_BRIDGE share the same
five-hook layout (PRE_ROUTING ... POST_ROUTING) and the same
state->in/state->out semantics as IPv4/IPv6, so they are safe.
ARP only has three hooks (IN=0, OUT=1, FORWARD=2) with different
semantics, causing the numbering collision that triggers this bug.

The match is intentionally registered as NFPROTO_UNSPEC (it carries
MODULE_ALIAS entries for both ipt_devgroup and ip6t_devgroup), but
accepting it on ARP chains was never intended and is unsafe.

Trigger conditions:
- Required CONFIG: CONFIG_NF_TABLES=y, CONFIG_NFT_COMPAT=y,
  CONFIG_NF_TABLES_ARP=y, CONFIG_NETFILTER_XT_MATCH_DEVGROUP=y
  (all enabled by default on Ubuntu 24.04)
- Required privilege: CAP_NET_ADMIN (namespace-reachable via user+net
  namespace on systems with unprivileged user namespaces)
- Attack vector: local, via nftables ARP output chain + xt-compat match

Fixes: 9291747f118d ("netfilter: xtables: add device group match")
Cc: stable@vger.kernel.org
Reported-by: Xiang Mei <xmei5@asu.edu>
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
 net/netfilter/xt_devgroup.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/netfilter/xt_devgroup.c b/net/netfilter/xt_devgroup.c
index 9520dd00070b2..86eb07d63274e 100644
--- a/net/netfilter/xt_devgroup.c
+++ b/net/netfilter/xt_devgroup.c
@@ -37,6 +37,12 @@ static int devgroup_mt_checkentry(const struct xt_mtchk_param *par)
 {
 	const struct xt_devgroup_info *info = par->matchinfo;

+	if (par->family != NFPROTO_IPV4 &&
+	    par->family != NFPROTO_IPV6 &&
+	    par->family != NFPROTO_INET &&
+	    par->family != NFPROTO_BRIDGE)
+		return -EINVAL;
+
 	if (info->flags & ~(XT_DEVGROUP_MATCH_SRC | XT_DEVGROUP_INVERT_SRC |
 			    XT_DEVGROUP_MATCH_DST | XT_DEVGROUP_INVERT_DST))
 		return -EINVAL;
--
2.43.0

