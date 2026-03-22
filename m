Return-Path: <stable+bounces-227858-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 1S+oJcpEwGnXFQQAu9opvQ
	(envelope-from <stable+bounces-227858-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 22 Mar 2026 20:36:42 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E3ACA2EA81B
	for <lists+stable@lfdr.de>; Sun, 22 Mar 2026 20:36:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 622053008749
	for <lists+stable@lfdr.de>; Sun, 22 Mar 2026 19:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4A0E32860F;
	Sun, 22 Mar 2026 19:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b5YNxORD"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 342E0C14A
	for <stable@vger.kernel.org>; Sun, 22 Mar 2026 19:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774208198; cv=none; b=BrgOpSh8oT6hqP+pqDKBM/8fCCaRny4ZB3a9VlpH744Z80gCCT+tFMYVfgceHm5g7JLrW0kmDVJyls+0TEUFqkoiQ06JlUwINNAAez+Yjw20Sk33M0VtIff0L5bFQpMdhwj4eyEAKJAsHRipW1CS+QHAPW4rEROlQOV4iVUbvLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774208198; c=relaxed/simple;
	bh=VZaN6lNZZBS+1rSrx0q5Xehr6MmHVXDCHWOgf9+gbYc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bMcG+lpIgHegrlbT4fZxX6NVgvhKlaIVpEksfBY+klmOF9EIyzq+/pGUGNlfdxj+TyLUt2rPYTPCFr5ikvJRJ/HdGjK6u0+IqHTKDdjQowkul7uxXar1RV/X1cAxGf0dQLAAt0M35pQEbGaxbHzMnX5qcKc9GSu4vPHpjCPui3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b5YNxORD; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-43b40003d13so2084291f8f.2
        for <stable@vger.kernel.org>; Sun, 22 Mar 2026 12:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774208196; x=1774812996; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z5NkvB6rUQmujjUBlOsuvgVhbuKs5zhTZMlpuU7ZH9E=;
        b=b5YNxORDqz+61TuptwONRK5mUWpJ3SvrznPOrOWueLQ00eO4PWT7uc9K0FI9gK0o0y
         82blOCvGgESxjfKkW9UoR3cZ14JlwVkmguWdXptVYjm6QOvcsdoQYyo9Ht2ZAfqjlOZy
         0s1Y9Zc26NH5571e+kbvm8kIfPuhjLUDcSm7E9ZiAfBvfLkuBTqBhSD08KEjUw15WiRf
         tWi+OWJ7Tt3B4ukcXYE0GANsXdeip4s5BtbKgKz0F3wu++zAC17k+M2OlJb6ZLjB9YFS
         qRXbmGxn8fOpV2IOHYzuXv/kNFB9NNKSYuxFft2JlPTfh8WLMWvxNyMkDTGc86XKG52j
         9wGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774208196; x=1774812996;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Z5NkvB6rUQmujjUBlOsuvgVhbuKs5zhTZMlpuU7ZH9E=;
        b=HSyEIwx7pClVFwxtTVyhNwcqVtrO3V/3Nq2I0TCkQ7ZXAQ5+nvPKIMhYVp1nt8Ey1f
         Mgpj55tccC4kfER/o1wdEsme6IGVPrH8RIKipSeRocDv0wtYaVVEFORsyiPiaLkoc5N7
         BJSPwAm0lvl4pmcPm3iUWirLqTXcxUfhzBpIRJNiiEj0qZdkwBdUupy4UK+PlN0fZGs5
         GiXu55QonQtCmkzCv54ehnQrkhqqjx2Q5DazG5zddG2ZzkGkMPopZXVfzSyfOXk1Ivmf
         xpztU6Sloo/Kyxz5/AqaZW6A0ITwa1uP+tkJer+VatPLLZ+k1nG1J+JZqLa9eaZ0lPyA
         65tw==
X-Forwarded-Encrypted: i=1; AJvYcCWAes/zVxOO/4ZeiovvQenyY9Sa5tPJBtwLhNdWnrFLlmcfK0SEl0wJehK8s2KIXU5vYf+f7KA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwP31hlUT7qwRIVlBpOjJzd88Dlc0AP+ayhnA4EgI5YVEmHEDto
	m2C2+TBzlSJG0uvPmS23aWhR5NP7/Uq9NYFEy+BSvgL163WvB0+8dLphZAI18Cz1
X-Gm-Gg: ATEYQzw6Jm9+uEOhkNiUsP5avSbuhfqPMiQDjWBSZ7QPrcBOoJdlyG2KsIsLWUCYxvA
	B9expr7+DaBcfSP4oKZl7FbaD54HE5qCemPI+lKh3H1ehyvxuvx1iHFz3XV1C2ZHOZkIaIMB3WU
	KomGxNGv7ZG03ZirhrqaQertQC/TlE0Xf4HoG5RfvGb0FolTObCGr3Dmndffvc7Bg3S6wHvyw0i
	wZ7oFTNxL+kQIKUwDyD0V1K1YaOHBtZZdzDAZS1YBXIVaLOerc4vjbI2+a0pZ5qr5GIq1e9CnfH
	xH3Rd3mE+IaXR1msPjGR8boy2YPGTePY1uV0PAf+C0gQIW/UlZvHRbq2PIwOSI1g+7Vk9tVvXHm
	/EfQODNK3zFNbm7UKiHQyCS9qLcoQnncpxOHtahf5TAZaCh+3mPSX0Oy2Ay7wUnTuUsa/QkO+8q
	cESrFPYBpnNV09MyrNVPjnFSAvsq4g2NB2AIDkGcmRSpvyxaBlY3eJxM4ANAt3543X214iMIWtd
	tf4wAfSmAIXvGn9wm+TlqY=
X-Received: by 2002:a05:6000:2407:b0:43b:6345:8d72 with SMTP id ffacd0b85a97d-43b6424ac69mr17019251f8f.12.1774208195393;
        Sun, 22 Mar 2026 12:36:35 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b64717e97sm25121657f8f.35.2026.03.22.12.36.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2026 12:36:34 -0700 (PDT)
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
Date: Sun, 22 Mar 2026 19:36:31 +0000
Message-ID: <20260322193631.45457-1-devnexen@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260322080142.5834-1-devnexen@gmail.com>
References: <20260322080142.5834-1-devnexen@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kvack.org,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-227858-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E3ACA2EA81B
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

Clear pn->objcg via rcu_replace_pointer() and add the missing
percpu_ref_kill() in the error path, matching the normal teardown
sequence in memcg_reparent_objcgs().

Also add a NULL check for pn in __mem_cgroup_free() to prevent a NULL
pointer dereference when alloc_mem_cgroup_per_node_info() fails partway
through the node loop in mem_cgroup_alloc().

Fixes: 098fad3e1621 ("mm: memcontrol: convert objcg to be per-memcg per-node type")
Cc: stable@vger.kernel.org
Signed-off-by: David Carlier <devnexen@gmail.com>
---
 mm/memcontrol.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index a47fb68dd65f..00b3bb81aee4 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3936,6 +3936,8 @@ static void __mem_cgroup_free(struct mem_cgroup *memcg)
 
 	for_each_node(node) {
 		struct mem_cgroup_per_node *pn = memcg->nodeinfo[node];
+		if (!pn)
+			continue;
 
 		obj_cgroup_put(pn->orig_objcg);
 		free_mem_cgroup_per_node_info(pn);
@@ -4137,8 +4139,11 @@ static int mem_cgroup_css_online(struct cgroup_subsys_state *css)
 free_objcg:
 	for_each_node(nid) {
 		struct mem_cgroup_per_node *pn = memcg->nodeinfo[nid];
+		objcg = rcu_replace_pointer(pn->objcg, NULL, true);
+		if (objcg)
+			percpu_ref_kill(&objcg->refcnt);
 
-		if (pn && pn->orig_objcg) {
+		if (pn->orig_objcg) {
 			obj_cgroup_put(pn->orig_objcg);
 			/*
 			 * Reset pn->orig_objcg to NULL to prevent
-- 
2.53.0


