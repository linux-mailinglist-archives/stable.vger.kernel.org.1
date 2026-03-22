Return-Path: <stable+bounces-227820-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AODIEPChv2nX6wMAu9opvQ
	(envelope-from <stable+bounces-227820-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 22 Mar 2026 09:01:52 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 99E792E8904
	for <lists+stable@lfdr.de>; Sun, 22 Mar 2026 09:01:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0F4223010DA1
	for <lists+stable@lfdr.de>; Sun, 22 Mar 2026 08:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 410FD1FBC8E;
	Sun, 22 Mar 2026 08:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K1MJ6cr8"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A42392C9D
	for <stable@vger.kernel.org>; Sun, 22 Mar 2026 08:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774166508; cv=none; b=cDdrjshg4MyElcJrWMLMicjOeMt6OVjHkJZJmiriqH/ccZrjlB/UidNsEI8JeqUjyLBq4E089hpsgbnuljsithCI+LA+iXZ/a3pzny/QfICBzoW29CqFGwN8qfmG1EzSKwsqCl3APxnddi8bLgdQa2rglk425E/mhrH6fu+U6xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774166508; c=relaxed/simple;
	bh=CUtcDYUZcehcFPO/0m5mPasYV0AHLbc9LFAPhj/qYDI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n0kK5uYFpS4KlmktcTfOeqvg7IJUiKxzZwthpuWYZ1Z68BmSZwtUX+Eqv2yYB9bUL++NUC6dMeF5/o/qMXdh591XXPBbZJLmalps5uTttRggM+m36JY6qN+rS1DLl+1WZdbUcAvEXlC5QJVuFFAyIAKsdv2Tx6hD++7wZFKOFAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K1MJ6cr8; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-43b4fd681c2so2621593f8f.3
        for <stable@vger.kernel.org>; Sun, 22 Mar 2026 01:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774166505; x=1774771305; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3OlOI2HFLk6+v2H1iuaik78KkHdqoW+ayRupAqfqnCA=;
        b=K1MJ6cr8zRmHi9UBTWOI7axOBArD5sUMpN7EFALOzLTWNo76ptQ+LyDXsqsry4ANcr
         YAV2tB+qsla5FcQ+pRv9E2k1yGyNnJSAvpuH8spWf3sGYWsfXqtUY9Wvx+EOH3fxD/59
         Q03h10yD9WVTVcPjZQHj1w7kogXZa37Bqf1GCEJQeiy3fcGtDUoY1Js7GGvPrLT6oY1x
         jc6NaqFiLPruOlVgD3f4p+/16dImQDGjI84jJVs1xmxDLMEVyVJ16q3CAaJOz7+HggUf
         54mUp6l0P29ZBhmNkCaJVX2c4iBuGOEIJuIxYd9mEiO4/O5c/lyR9UNIz3kkxhIHbz/V
         6Atg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774166505; x=1774771305;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3OlOI2HFLk6+v2H1iuaik78KkHdqoW+ayRupAqfqnCA=;
        b=LWPBx1CRLz+4Bazxf5lRIf9CHtqO59indEVIamnGY3EbmWhSFXuu04Ona+yVKNUFQQ
         aOPpLdBwa3G1ESYuj9FD2JTKvhvM5um6TTc0LQnF3HH3S/jI3RZ3DaSfrGEJPPlZP2Q9
         CbQn7dc80zpT6NLUmq8+19I9X+8taDA0oKzp8fYJ+VMKAwSU1AqSiwLxQtyFDddjV659
         iWbiBsSO4xvJcljFZklHajcaN6UQKB7t86k35vU5MsQ1H6HPxNfkXx7mJtMRwy77ughc
         BvCG59eXB1bq7I+HHokdP4b01q3iN5dE0YXTwDvPeKzIeg41YuDVDwFVcsZmXeAtDpPI
         4aGQ==
X-Forwarded-Encrypted: i=1; AJvYcCVpw7dGlCfXDXTLiUqMmiD2+vZ4VUJhn4RM/CkL0Weh9WXEJ4VTlqdHMiSDuLdtLggpQcxTkY4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHOQoG5Kjs1Ind2+Fg4iu34qFwx4KgqZd87skhl7VrXlpqUdig
	qVVHCQ/TDC4VcUxXxjdoopLXxU2Gf9B4kYl4edYp8la4rXzeZ+P6zJ8w
X-Gm-Gg: ATEYQzw4vEPTObk2cMkBhGJ5HjrPJ6C/XJnaKA1Jy9i3PeINQccdsWEp8iOGV8r4qYY
	Wa2kZG/JlsEMgcYX4ENvJK9S3RDUDY2CYzYw1WFxGFibfHqQDfIuTZhesygsYOJUXgi7d9DMKCb
	qnM/zI2mrW5hAZqEma/QVdnC2/Zvv4EN3u1rEZTxUUy9WQSdpOnrSAFNosKJ06+PGJDgOl2qirG
	2bwx+4k7PQoJ3OxgVxNkQ+NPhBV17uO/1blsK37iusLJVuLdj2CGeC3zZRdkGPM2Qzqfa/PUooX
	1/Zzsa6o/2tGx1Hbc/sc+ebn/4pvUnXqRnw2zVchvOjqF0xNb77cAq0y2U5FFBEXRN2CTprT99Q
	SbvdFMG5QrRtLAdyQhVZsbJtJOutNeuQDa/P0Z7VuDcTluVB17fgkTVStGI30K42+edPI5ezvu5
	YSID+ZBziRAEliHU7tp/rYRaHCvyylhSmZR7q0GbPVt8/8aP6JY//I85SzCPOmmYbqCqBHhr3fq
	IH0+twWDjAAiQX5JIVgqBU=
X-Received: by 2002:a05:6000:2012:b0:43b:436d:782a with SMTP id ffacd0b85a97d-43b6423883amr14257278f8f.5.1774166504579;
        Sun, 22 Mar 2026 01:01:44 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b644bdaf8sm22651976f8f.13.2026.03.22.01.01.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2026 01:01:44 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Qi Zheng <zhengqi.arch@bytedance.com>
Cc: linux-mm@kvack.org,
	David Carlier <devnexen@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] mm/memcontrol: fix obj_cgroup leak in mem_cgroup_css_online() error path
Date: Sun, 22 Mar 2026 08:01:42 +0000
Message-ID: <20260322080142.5834-1-devnexen@gmail.com>
X-Mailer: git-send-email 2.53.0
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
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kvack.org,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-227820-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnexen@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 99E792E8904
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When obj_cgroup_alloc() fails partway through the NUMA node loop in
mem_cgroup_css_online(), the free_objcg error path drops the extra
reference held by pn->orig_objcg but never kills the initial percpu_ref
from obj_cgroup_alloc() stored in pn->objcg.

Since css_offline is never called when css_online fails,
memcg_reparent_objcgs() never runs, so the percpu_ref_kill() that
normally drops this initial reference never executes. The obj_cgroup and
its per-cpu ref allocations are leaked.

Add the missing percpu_ref_kill() in the error path, matching the normal
teardown sequence in memcg_reparent_objcgs().

Fixes: 098fad3e1621 ("mm: memcontrol: convert objcg to be per-memcg per-node type")
Cc: stable@vger.kernel.org
Signed-off-by: David Carlier <devnexen@gmail.com>
---
 mm/memcontrol.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index a47fb68dd65f..0da996d37c74 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -4100,8 +4100,9 @@ static int mem_cgroup_css_online(struct cgroup_subsys_state *css)
 
 	for_each_node(nid) {
 		objcg = obj_cgroup_alloc();
-		if (!objcg)
+		if (!objcg) {
 			goto free_objcg;
+		}
 
 		if (unlikely(mem_cgroup_is_root(memcg)))
 			objcg->is_root = true;
@@ -4137,6 +4138,9 @@ static int mem_cgroup_css_online(struct cgroup_subsys_state *css)
 free_objcg:
 	for_each_node(nid) {
 		struct mem_cgroup_per_node *pn = memcg->nodeinfo[nid];
+		objcg = rcu_dereference_protected(pn->objcg, true);
+		if (objcg)
+			percpu_ref_kill(&objcg->refcnt);
 
 		if (pn && pn->orig_objcg) {
 			obj_cgroup_put(pn->orig_objcg);
-- 
2.53.0


