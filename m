Return-Path: <stable+bounces-227846-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id tOI/CbQdwGmoDwQAu9opvQ
	(envelope-from <stable+bounces-227846-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 22 Mar 2026 17:49:56 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 877CD2EA0EA
	for <lists+stable@lfdr.de>; Sun, 22 Mar 2026 17:49:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6C92F300889C
	for <lists+stable@lfdr.de>; Sun, 22 Mar 2026 16:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BB5036606D;
	Sun, 22 Mar 2026 16:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="foSJnCCK"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865FC1F4C8C
	for <stable@vger.kernel.org>; Sun, 22 Mar 2026 16:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774198192; cv=none; b=LH6/GGxD0gTCUONDsD6jor8FmjRtDuJOJNplyjW8Sf6G0S+Y6AlBFZcHBLAG0RWxihcWRLp7ZBYbhKBOdwLPQ9WO2f3jmyWFYnMZUASuX+jVGsNr7R1TgSov+viqSldz0KkaWAzKEJ32+VJQu2RPqCG0i2Hy8Gyj+nHk6vvZqqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774198192; c=relaxed/simple;
	bh=l+FPeiEP5OKtf4CU8WrIUaDmVyrj0dsyX0uKWhhfhtI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WnNjPo1doV4dqWNBRq169bDLvS7jUBOMyELvz0WGMo5d4LZIBck6Uw7LFwRGrGZaf2So1xrBUY4slNWAfZYuhSrA9/P3bwKJB4G3UNnXk+s5+CGmrvm7Wx/cBrWZxO2vxZjPSQCscoLxGrKjnvNJ46Vsol+JNowPq0P+p4wdmsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=foSJnCCK; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-486fb439299so26755915e9.0
        for <stable@vger.kernel.org>; Sun, 22 Mar 2026 09:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774198190; x=1774802990; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JWjZGVQFq+8rxchM7WYzJZsANmNue13rkhqmq5WeFqc=;
        b=foSJnCCKyA4+ZnLRMIPA9lQzS9IJDaMFKW0MoN2/nIbJ/Wp8dexf/eTZw1OoukEChF
         3DLBLNT30iU7R8fqXL+7+kzUJ4qUHdLZuZPjr5jMLq3Tk02hogrcfOTWo3xio1hpMhhS
         kxl8W+TO7dgIUniYPPc9u6OrVPZHp3XcNnPDQNq8Llo9wHL5n0b2wDglVVrz/4O1Sq8f
         PkAas2Uf1d2IPe8l21BffD0ELtiE7fPC65ISI0+76T7eO2tthRmDbDrmW1LQaI5grb0S
         /l7T0BpfobNz+nGeo4XEognWBgZ/+GAnH6OPPcuBb6kfRN/YEeCZEseJN5njQfZPOhHp
         oxFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774198190; x=1774802990;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JWjZGVQFq+8rxchM7WYzJZsANmNue13rkhqmq5WeFqc=;
        b=CIsTRqPe2LbfjBlCjqYpS7lirFqDJpwLDBv/SXyha2XOPicBT/+0W5jIIsPhySGE4f
         3FRtxLf2iFuyqbI5pT+NUclZ5q/1+kuuP4l+CB+Lwvme7WWLzFBL6uYgSOFZnlvgjFFQ
         R1dFYHtbZKDDWGAwHvuq96Fxiy7Xcd3PnFDbsdHCrBxMExRRiBhoeViJ4PB8xod+SXUG
         gMO6d0n7QUWBlSyNOI0re9z1bKe1qSYepI52ac6b2VpubAwAh1h420wMtrcWYarKBvD6
         pQWpMSga/wJ5IR/g9+xjPgWqQE85pEJVlF+MYXb5WYR8YiXcbJ7nenoOqWE+Jcq2cipw
         Cdlw==
X-Forwarded-Encrypted: i=1; AJvYcCWSM8pxoguDoQ4q/qkGgxlgSvvQhke+PL2Xws6cHyh1i1zaJ37GfC5y814TiUaifXMu9K0L1aE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyX7AXizp5YD4HQd+FxkAY5ftEKPAD1Dky+klGYcDjXqU2108N6
	V2d5+e04mgNx5+gI9azAMoeZDwp4yoSwh0sogZnYlo5RsYqOhmcGsFMm2TwTwuuL
X-Gm-Gg: ATEYQzztxzaXBbNBzbCGMm0A32zThYnCSV6QWt3qUxqJc+6Bzx6YBz4VcFUcE+1K1OV
	WWQ/yh/WQOH1NrxCkIg3C43K9Kf2CdvkAvDJWpqmHwKBD5PPr8tVuriKYInuBEusFgoTdH0nCb2
	xFXWmezGxIrXXsA4qxd0bqyNtO3cE73gUraQPlK/moKHfXWEGkWOM26WM1mi1R61RWS6PQPgt1L
	aaplvouEh9tLxu1/QekP2Ro6i4QSY8lcdPRc9FgKOqbG+nkQDu05UlpFgsCaWIVxxS++jCL9KkP
	eL3RYYZKGoxWPOIAWRh2G3ph5U0cjQ+DbG5NQ9OUMdswPc2lXeNyqh9t5S9kk7TBsMd3X6wsSiQ
	TauRGcBKKGDY0c3b1oFBjci31rS2s8zoIzKsnpxokbDXsPZjWXYpJe0bVZN9U/IVmO6/PMmp6hz
	Wn83DEysqtjAPJAlM/HjMDE14dcV8d38u0ntKkTqsIua3833sr8i/xLrRzbOFOQj1eMRMk+oQrE
	4voS8amZ0To
X-Received: by 2002:a05:600c:12d6:b0:487:1c2:6a4f with SMTP id 5b1f17b1804b1-48701c26bdamr67227245e9.31.1774198189586;
        Sun, 22 Mar 2026 09:49:49 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486ff109b95sm146464215e9.1.2026.03.22.09.49.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2026 09:49:48 -0700 (PDT)
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
Date: Sun, 22 Mar 2026 16:49:43 +0000
Message-ID: <20260322164943.37460-1-devnexen@gmail.com>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[kvack.org,gmail.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227846-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnexen@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 877CD2EA0EA
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

Fixes: 098fad3e1621 ("mm: memcontrol: convert objcg to be per-memcg per-node type")
Cc: stable@vger.kernel.org
Signed-off-by: David Carlier <devnexen@gmail.com>
---
 mm/memcontrol.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index a47fb68dd65f..dc83e9d43eea 100644
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
+		objcg = rcu_replace_pointer(pn->objcg, NULL, true);
+		if (objcg)
+			percpu_ref_kill(&objcg->refcnt);
 
 		if (pn && pn->orig_objcg) {
 			obj_cgroup_put(pn->orig_objcg);
-- 
2.53.0


