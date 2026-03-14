Return-Path: <stable+bounces-225429-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eBReC7mGtWnP1QAAu9opvQ
	(envelope-from <stable+bounces-225429-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 14 Mar 2026 17:03:05 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DF8C428DC41
	for <lists+stable@lfdr.de>; Sat, 14 Mar 2026 17:03:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DB199302291B
	for <lists+stable@lfdr.de>; Sat, 14 Mar 2026 16:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B86D314D37;
	Sat, 14 Mar 2026 16:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QYASmWMm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CBAF1DD525;
	Sat, 14 Mar 2026 16:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773504178; cv=none; b=gK3zd3+y1/dX9TiPwodfKuR++r/7Z5S0DlkexF/1NI6I1OAMoPSfV3Nh6qYpRnEDsU/TrXC8v/KxsNI98zhbwUF0qeDKqhw6QF3O2lSToSL9tO+eqL2nll3PLZK7xZ0tPLuuAuohXfg5DXelg+WR+y0lbAX/YhtDwg2OIrc/gcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773504178; c=relaxed/simple;
	bh=gW273cX5oHbg/QoABE2SB7PT0aTQ/h5U216t18qbRMs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=L6iYqLqFHfHcVlOFxP7GnZqm6i9aXxfcttArtCriTDW3xXz5clzkxG67nsWEbfjCi0tzvbBBPSXHCsLJGRQmsiSE4C1ZyuLbA3RCDP9o6UEYOK8xEyJ7HAQW0Jh/O5fIf1jQXYJ5GOxB/1Yao2z0omGkHz2Dxe+7GsXp5avjp28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QYASmWMm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 236E1C116C6;
	Sat, 14 Mar 2026 16:02:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773504178;
	bh=gW273cX5oHbg/QoABE2SB7PT0aTQ/h5U216t18qbRMs=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=QYASmWMmM5rPb6P6M/GW67xjWV0DT2QV6FnyrC4XUjVrQaRAM6mP1gsANpFO3gcHl
	 XzYCqtfvxi8oGwntcVW4pRyoh+nejoV8cnOZ3aCD/JYyWJDtMsgMtoVMvz2T49HX4x
	 7StCfls88j2SlaMD7GE6yzX1ACkZHXN7D2HXTYTlyHvDY7WwvGLqkZ7x7/IjyiHDtw
	 cXORGe1sfs+kcBbXhAnBJGoKxDZEZTwJTHrV/IVBh0w0ysCBml3lTIBPJ41jHmuYyc
	 aIaE6RynhHdB8cRc422lONZiGyS6rpbBjwsWrpTNKfmjrnNL/Goah+oRSCir4ByhIE
	 e0Nf50eLdE1Hg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 117BC10706E2;
	Sat, 14 Mar 2026 16:02:58 +0000 (UTC)
From: Levi Zim via B4 Relay <devnull+rsworktech.outlook.com@kernel.org>
Date: Sun, 15 Mar 2026 00:02:48 +0800
Subject: [PATCH bpf v3] bpf: do not use kmalloc_nolock when
 !HAVE_CMPXCHG_DOUBLE
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260315-bpf-kmalloc-nolock-v3-1-91c72bf91902@outlook.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4XNyQ6CMBAG4Fchc7amCxT15HsYDwWm0rAMabHRE
 N7dpjcvepnkn+WbDQJ6hwEuxQYeowuO5hTUoYC2N/MDmetSBsml5kqUrFksGyYzjtSymVIdmOa
 dOXHUQnUI6XDxaN0rozdI+3BPzd6Flfw7P4oij36ZUTDBZGkaq2xdmbO90nMdiYZjS1MGo/yPy
 IRUtUalsLRG19/Ivu8fv2qK1AABAAA=
X-Change-ID: 20260314-bpf-kmalloc-nolock-60da80e613de
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>
Cc: Amery Hung <ameryhung@gmail.com>, linux-riscv@lists.infradead.org, 
 stable@vger.kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-rt-devel@lists.linux.dev, Levi Zim <rsworktech@outlook.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=5177;
 i=rsworktech@outlook.com; s=ryzen; h=from:subject:message-id;
 bh=F3NzhvAzd0zCVDcRlr7RmrSHpJygKeFMqZIONIS/DVY=;
 b=owEBbQKS/ZANAwAKAW87mNQvxsnYAcsmYgBptYataz9Rjqgmj6vGqmsIM8a6ZekZLkTCdBL8E
 xjDsqOUPQWJAjMEAAEKAB0WIQQolnD5HDY18KF0JEVvO5jUL8bJ2AUCabWGrQAKCRBvO5jUL8bJ
 2F2AD/9oKgja014FkRBZt0+EeVAdwGQx2xV8nIGzJFegeQEj1nn2IEPSyYITgmeLJ+wp0LhaJ7M
 KZ2ZG7quAiDTUYPLSTk1+qNAR+JaDp15cA1/GHDrdFoLCEO0A4TYRP4eMrqQIOIZra2hF+7EX0C
 v6ndojsunyGRPgeDln9cs6pYfa1XUa8dHgD9bSivT1DluvOajJU1gXjbhTKEOeasYdzMt1IQfNw
 kQX7wq/P3JoUFMTJCL4I66odN1QlGfe2sS7xNg5GOu08NtxDrXY8QkbSLNGAqYA/t5lKwOjdjNg
 MfdFm4zzKcTm4Qe9STv6V9cQjVoG3kRqCbP35meqrOq690na+7HUW4RrAjozujCSLeQ8Zv2s32q
 o9m6p3nzUyP6wB2/sJkwk8eD7S3o4X9ODWpdSAr76mi+9o5AHTvTA2BdaHE4yDhjfSByRrZxjin
 riSi1Foj46ovVjKDCFwdEN0ocJFHCfUW1GjnXA2qjM2Sale7GV7fS/UNNnftktWBTyYA2Jw8hyK
 V30UKE2bZsSHx5wsDVKV/YphBApMDRFi+2OUkKhFIJovNl7pxU2DxjHiKa0T5r1u6xAVlpvEfA7
 5lHcoM60D8Hn0Xn4JcC9YioctxKS6UI/2FPAVvrham+ytnO0SIbDZbXaiqjWhkr/F7qR0LE3eGI
 k2lMPSDkv1fCCIA==
X-Developer-Key: i=rsworktech@outlook.com; a=openpgp;
 fpr=17AADD6726DDC58B8EE5881757670CCFA42CCF0A
X-Endpoint-Received: by B4 Relay for rsworktech@outlook.com/ryzen with
 auth_id=536
X-Original-From: Levi Zim <rsworktech@outlook.com>
Reply-To: rsworktech@outlook.com
X-Spamd-Result: default: False [1.34 / 15.00];
	FREEMAIL_REPLYTO_NEQ_FROM(2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-225429-lists,stable=lfdr.de,rsworktech.outlook.com];
	FREEMAIL_REPLYTO(0.00)[outlook.com];
	SUBJECT_HAS_EXCLAIM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,iogearbox.net,linux.dev,gmail.com,fomichev.me,google.com,linutronix.de,goodmis.org,dabbelt.com,eecs.berkeley.edu,ghiti.fr];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[26];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	HAS_REPLYTO(0.00)[rsworktech@outlook.com];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,lists.infradead.org,vger.kernel.org,lists.linux.dev,outlook.com];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DKIM_TRACE(0.00)[kernel.org:+];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[outlook.com:email,outlook.com:replyto,outlook.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DF8C428DC41
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Levi Zim <rsworktech@outlook.com>

kmalloc_nolock always fails for architectures that lack cmpxchg16b.
For example, this causes bpf_task_storage_get with flag
BPF_LOCAL_STORAGE_GET_F_CREATE to fails on riscv64 6.19 kernel.

Fix it by enabling use_kmalloc_nolock only when HAVE_CMPXCHG_DOUBLE.
But leave the PREEMPT_RT case as is because it requires kmalloc_nolock
for correctness. Add a comment about this limitation that architecture's
lack of CMPXCHG_DOUBLE combined with PREEMPT_RT could make
bpf_local_storage_alloc always fail.

Fixes: f484f4a3e058 ("bpf: Replace bpf memory allocator with kmalloc_nolock() in local storage")
Cc: stable@vger.kernel.org
Signed-off-by: Levi Zim <rsworktech@outlook.com>
---
I find that bpf_task_storage_get with flag BPF_LOCAL_STORAGE_GET_F_CREATE
always fails for me on 6.19 kernel on riscv64 and bisected it.

In f484f4a3e058 ("bpf: Replace bpf memory allocator with kmalloc_nolock()
in local storage"), bpf memory allocator is replaced with kmalloc_nolock.
This approach is problematic for architectures that lack CMPXCHG_DOUBLE
because kmalloc_nolock always fails in this case:

In function kmalloc_nolock (kmalloc_nolock_noprof): 

	if (!(s->flags & __CMPXCHG_DOUBLE) && !kmem_cache_debug(s))
		/*
		 * kmalloc_nolock() is not supported on architectures that
		 * don't implement cmpxchg16b, but debug caches don't use
		 * per-cpu slab and per-cpu partial slabs. They rely on
		 * kmem_cache_node->list_lock, so kmalloc_nolock() can
		 * attempt to allocate from debug caches by
		 * spin_trylock_irqsave(&n->list_lock, ...)
		 */
		return NULL;

Fix it by enabling use_kmalloc_nolock only when HAVE_CMPXCHG_DOUBLE.
(But not for a PREEMPT_RT case as explained in the comment and commitmsg)

Note for stable: this only needs to be picked into v6.19 if the patch
makes it into 7.0.
---
Changes in v3:
- Use macro instead of const static variable to avoid triggering
  warnings.
- Wrap lines at 80 columns
- Link to v2: https://lore.kernel.org/r/20260314-bpf-kmalloc-nolock-v2-1-576e33e4fa67@outlook.com

Changes in v2:
- Drop the modification to the PREEMPT_RT case as it requires
  kmalloc_nolock for correctness.
- Add a comment to the PREEMPT_RT case about the limitation when
  not HAVE_CMPXCHG_DOUBLE but enables PREEMPT_RT.
- Link to v1: https://lore.kernel.org/r/20260314-bpf-kmalloc-nolock-v1-1-24abf3f75a9f@outlook.com
---
 include/linux/bpf_local_storage.h | 1 +
 kernel/bpf/bpf_cgrp_storage.c     | 3 ++-
 kernel/bpf/bpf_local_storage.c    | 4 ++++
 kernel/bpf/bpf_task_storage.c     | 3 ++-
 4 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/include/linux/bpf_local_storage.h b/include/linux/bpf_local_storage.h
index 8157e8da61d40..d8f2c5d63a80e 100644
--- a/include/linux/bpf_local_storage.h
+++ b/include/linux/bpf_local_storage.h
@@ -18,6 +18,7 @@
 #include <asm/rqspinlock.h>
 
 #define BPF_LOCAL_STORAGE_CACHE_SIZE	16
+#define KMALLOC_NOLOCK_SUPPORTED IS_ENABLED(CONFIG_HAVE_CMPXCHG_DOUBLE)
 
 struct bpf_local_storage_map_bucket {
 	struct hlist_head list;
diff --git a/kernel/bpf/bpf_cgrp_storage.c b/kernel/bpf/bpf_cgrp_storage.c
index c2a2ead1f466d..cd18193c44058 100644
--- a/kernel/bpf/bpf_cgrp_storage.c
+++ b/kernel/bpf/bpf_cgrp_storage.c
@@ -114,7 +114,8 @@ static int notsupp_get_next_key(struct bpf_map *map, void *key, void *next_key)
 
 static struct bpf_map *cgroup_storage_map_alloc(union bpf_attr *attr)
 {
-	return bpf_local_storage_map_alloc(attr, &cgroup_cache, true);
+	return bpf_local_storage_map_alloc(attr, &cgroup_cache,
+					   KMALLOC_NOLOCK_SUPPORTED);
 }
 
 static void cgroup_storage_map_free(struct bpf_map *map)
diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
index 9c96a4477f81a..a6c240da87668 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -893,6 +893,10 @@ bpf_local_storage_map_alloc(union bpf_attr *attr,
 	/* In PREEMPT_RT, kmalloc(GFP_ATOMIC) is still not safe in non
 	 * preemptible context. Thus, enforce all storages to use
 	 * kmalloc_nolock() when CONFIG_PREEMPT_RT is enabled.
+	 *
+	 * However, kmalloc_nolock would fail on architectures that do not
+	 * have CMPXCHG_DOUBLE. On such architectures with PREEMPT_RT,
+	 * bpf_local_storage_alloc would always fail.
 	 */
 	smap->use_kmalloc_nolock = IS_ENABLED(CONFIG_PREEMPT_RT) ? true : use_kmalloc_nolock;
 
diff --git a/kernel/bpf/bpf_task_storage.c b/kernel/bpf/bpf_task_storage.c
index 605506792b5b4..6e8597edea314 100644
--- a/kernel/bpf/bpf_task_storage.c
+++ b/kernel/bpf/bpf_task_storage.c
@@ -212,7 +212,8 @@ static int notsupp_get_next_key(struct bpf_map *map, void *key, void *next_key)
 
 static struct bpf_map *task_storage_map_alloc(union bpf_attr *attr)
 {
-	return bpf_local_storage_map_alloc(attr, &task_cache, true);
+	return bpf_local_storage_map_alloc(attr, &task_cache,
+					   KMALLOC_NOLOCK_SUPPORTED);
 }
 
 static void task_storage_map_free(struct bpf_map *map)

---
base-commit: e06e6b8001233241eb5b2e2791162f0585f50f4b
change-id: 20260314-bpf-kmalloc-nolock-60da80e613de

Best regards,
-- 
Levi Zim <rsworktech@outlook.com>



