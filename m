Return-Path: <stable+bounces-223399-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cJrxK0Vmq2kfcwEAu9opvQ
	(envelope-from <stable+bounces-223399-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 07 Mar 2026 00:41:57 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 12D73228CE2
	for <lists+stable@lfdr.de>; Sat, 07 Mar 2026 00:41:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 03FAB30F9B4D
	for <lists+stable@lfdr.de>; Fri,  6 Mar 2026 23:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA43037FF6D;
	Fri,  6 Mar 2026 23:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="luUTEPec"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896DB329C74
	for <stable@vger.kernel.org>; Fri,  6 Mar 2026 23:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772840362; cv=none; b=eoW4p27tnsgKOGCwwwvO95wW+iFMGKAqfRLU2Zef6fmvSpJnQEAC4SC5n7kUAVt8MSuj9HCiyXq9wMiW3rHNtjLxS+WF5/L0j7wd36zueehRGSmzPKJblWPJKr5n1FU97Dr+XVfi5wHRjyZMsIi2kULzfsP0pCbDUdG11Ga2jXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772840362; c=relaxed/simple;
	bh=apPiXEb0O6w+YA4l9CCmEorK71PzvfzP4YtEPO9dM5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=U+wACj8dg40us6x4o/PEElYr0J4rrrr/YTER+hKlnDUQV7ZjHtOn0sWDztqdGfHTM/6+ayuCcGp3Uyd4Q40qCPAN2FuORJVGx9Ahwc87p2TvFNsc+1yGtDdN2NAJJscGKPEjQEnT0dQqgxeaazKF5hdbztQpfnkJ/ktCKwCI9xQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=luUTEPec; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-79801df3e42so127881037b3.0
        for <stable@vger.kernel.org>; Fri, 06 Mar 2026 15:39:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772840360; x=1773445160; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=d9wovly74FgcJKa8Ed9Xsx768BrjeHrTIyaL2Oh1KxY=;
        b=luUTEPec30OcD9y0DJOHbho82GyFT/KTGcK04/QvwXiC7AdZa4b7AzqhvEeml/IAeO
         +Uck2i689+DOawsjOlQ2YHiUo5MeYHS8ecBmXVPYHLMQKp5PYnkNBNrNJFadvesM8q1d
         F8dcfscOzekJ6NBpGWhZlKQXzElhmU4mWULvvqed4XFp+zLnagV6naZzEfb3+nxaCXpy
         C6YGUMUtPcAgB6S7EYDWFVUOIKE3WEy5m9AAoOVgAVz+t/Xp6AeSEzBRBpKdvbGExPCV
         r5xfyM70YUJm4fXKfpsNI+8RximNXH2qGq38O1usY3eAccyWReUuUFZjfSPTW1P4Kpt2
         ck8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772840360; x=1773445160;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d9wovly74FgcJKa8Ed9Xsx768BrjeHrTIyaL2Oh1KxY=;
        b=BICrKXmzi0GPoQHcQ7CU01e9uwsTxStVbUEhGWvBtG1Ul5wCT0lfvlOahUTFeaGkTB
         2d2Ob4ly99XiJWSWeQCnrqBUZv3k7VqFsR6iw2bKE+pon+6CEMlb/SYbdrKO5wxbTV9n
         PX+HpBqgQfKs3CZXEE+yMYiuWA1/9Y1tpmxlrWd8wISaI3wgBFRjAhACXE6ohDESh5vS
         /HSrDnMFYr1dvGaat7T+oaDi0GfB7UQlZ9CznJfsWhzbH/0BbcMq8K81pj5U8rgQa5qg
         TPIrCjU0tjTDWvTZ4h+FEN7+F8u0P1DoitqWwl3k6u7N4dgrrHSo6ER/wCSQlUPHnPJk
         9rOA==
X-Forwarded-Encrypted: i=1; AJvYcCWXcXbIm//QmfJeokUvzOcCTEPv/5ED/gJTxvsG1GTFeZTP+1t1GgwpvEPmmDTT8J9Qd9c9bWg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxmt+rBAW/JQp9adY0WLNz7+dngXm+ftwmMrSfkIa35+sbQ87gR
	qoFSwNMAFPGIRb9pbWBmCyW26UZMUTRJ6nl+3XGM5CB8hC59MlPKotnx
X-Gm-Gg: ATEYQzz9AVndoo3DfmKeyKE3olWmN7d6x2I2aUOWNOs3s4WACRVt5NtvgxmDKks8MPx
	cTxuunxXrXhohFNB+1Gz22N795RG3zHwg93DFYlr6lDIULN2Q0RyFgW2Oo6xa5Y61NjOiutuawy
	XlsiF0SHcUF9eGf7cK6zr1iXWMe8ZQzQgAvcZXGQqJ6yWmK4+yxmElOHrKShkLvAqnh5l3koOKD
	V7paIwhWzd27FreTjZBKw+v2tMTXIZo7/gGQazM6kur0XqCWIV88PgSt/n3O106tc2oFAyMdy71
	E/n8LuV2+mKUbA6VmRb8L8qW1xCjFegDFx/E2S5+V0pxELsgzLfsx3TW945Wza4ZkzFteeJvOLa
	OswD63J8ekjsHV6uoCDTzGDwX7Y/WqeyZUIK96d7cVDpUgdF6wjCuehcbpBUvzaoF1kSQcZd/LZ
	mGZiirrhQEZ04lJkyo6qdJONq2au+MMaqhqRts8h5cDEZ/YaxZ0wI2E+G1LlHfd4x0n08=
X-Received: by 2002:a05:690c:660d:b0:798:63ab:757f with SMTP id 00721157ae682-798dd6d3d80mr35940637b3.9.1772840360031;
        Fri, 06 Mar 2026 15:39:20 -0800 (PST)
Received: from desktop-linux.python-stargazer.ts.net ([50.168.180.218])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-798dee4883bsm14013957b3.31.2026.03.06.15.39.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 15:39:19 -0800 (PST)
From: Mehul Rao <mehulrao@gmail.com>
To: dsahern@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: horms@kernel.org,
	petrm@nvidia.com,
	idosch@nvidia.com,
	netdev@vger.kernel.org,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mehul Rao <mehulrao@gmail.com>
Subject: [PATCH net] net: nexthop: fix percpu use-after-free in remove_nh_grp_entry
Date: Fri,  6 Mar 2026 18:38:20 -0500
Message-ID: <20260306233821.196789-1-mehulrao@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 12D73228CE2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-223399-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,nvidia.com,vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mehulrao@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.929];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

When removing a nexthop from a group, remove_nh_grp_entry() publishes
the new group via rcu_assign_pointer() then immediately frees the
removed entry's percpu stats with free_percpu(). However, the
synchronize_net() grace period in the caller remove_nexthop_from_groups()
runs after the free. RCU readers that entered before the publish still
see the old group and can dereference the freed stats via
nh_grp_entry_stats_inc() -> get_cpu_ptr(nhge->stats), causing a
use-after-free on percpu memory.

Fix by deferring the free_percpu() until after synchronize_net() in the
caller. Removed entries are chained via nh_list onto a local deferred
free list. After the grace period completes and all RCU readers have
finished, the percpu stats are safely freed.

Fixes: f4676ea74b85 ("net: nexthop: Add nexthop group entry stats")
Cc: stable@vger.kernel.org
Signed-off-by: Mehul Rao <mehulrao@gmail.com>
---
 net/ipv4/nexthop.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/net/ipv4/nexthop.c b/net/ipv4/nexthop.c
index 1aa2b05ee8de..c942f1282236 100644
--- a/net/ipv4/nexthop.c
+++ b/net/ipv4/nexthop.c
@@ -2002,7 +2002,8 @@ static void nh_hthr_group_rebalance(struct nh_group *nhg)
 }
 
 static void remove_nh_grp_entry(struct net *net, struct nh_grp_entry *nhge,
-				struct nl_info *nlinfo)
+				struct nl_info *nlinfo,
+				struct list_head *deferred_free)
 {
 	struct nh_grp_entry *nhges, *new_nhges;
 	struct nexthop *nhp = nhge->nh_parent;
@@ -2062,8 +2063,8 @@ static void remove_nh_grp_entry(struct net *net, struct nh_grp_entry *nhge,
 	rcu_assign_pointer(nhp->nh_grp, newg);
 
 	list_del(&nhge->nh_list);
-	free_percpu(nhge->stats);
 	nexthop_put(nhge->nh);
+	list_add(&nhge->nh_list, deferred_free);
 
 	/* Removal of a NH from a resilient group is notified through
 	 * bucket notifications.
@@ -2083,6 +2084,7 @@ static void remove_nexthop_from_groups(struct net *net, struct nexthop *nh,
 				       struct nl_info *nlinfo)
 {
 	struct nh_grp_entry *nhge, *tmp;
+	LIST_HEAD(deferred_free);
 
 	/* If there is nothing to do, let's avoid the costly call to
 	 * synchronize_net()
@@ -2091,10 +2093,16 @@ static void remove_nexthop_from_groups(struct net *net, struct nexthop *nh,
 		return;
 
 	list_for_each_entry_safe(nhge, tmp, &nh->grp_list, nh_list)
-		remove_nh_grp_entry(net, nhge, nlinfo);
+		remove_nh_grp_entry(net, nhge, nlinfo, &deferred_free);
 
 	/* make sure all see the newly published array before releasing rtnl */
 	synchronize_net();
+
+	/* Now safe to free percpu stats — all RCU readers have finished */
+	list_for_each_entry_safe(nhge, tmp, &deferred_free, nh_list) {
+		list_del(&nhge->nh_list);
+		free_percpu(nhge->stats);
+	}
 }
 
 static void remove_nexthop_group(struct nexthop *nh, struct nl_info *nlinfo)
-- 
2.53.0


