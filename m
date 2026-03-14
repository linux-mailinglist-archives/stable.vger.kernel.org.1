Return-Path: <stable+bounces-225427-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kOiZEGd/tWmK1AAAu9opvQ
	(envelope-from <stable+bounces-225427-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 14 Mar 2026 16:31:51 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BB82E28DB35
	for <lists+stable@lfdr.de>; Sat, 14 Mar 2026 16:31:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9B006301E7F7
	for <lists+stable@lfdr.de>; Sat, 14 Mar 2026 15:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 464202FDC2C;
	Sat, 14 Mar 2026 15:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iQPP8QB+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04DA1EEB3;
	Sat, 14 Mar 2026 15:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773502308; cv=none; b=ZrtH0upbK8CbXJNxctjLr+k+mHqLRAc+WdKdkq4+6tw9JkFzyE3p4Pdb9jX6XQMUKSAuvkRUKWii1/HHdPstzq2+1O68D0wgtVT49eLbAHCm/h115Rp9LU2/IrKy2MKBoQx5umWcXkLGCnGbP8qdW491t11Je3vhFEMpJjGtykI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773502308; c=relaxed/simple;
	bh=3oto4NzWUu1PAVH049AXdYT4Jt2n+mb0nBzsSwynlzE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=QxCo5KwhTva+FiMWzKatF2ThD5mQ76S3Jty+QQ87JXrnxCe1EGGloQbMM1A3gtKlm6luDMyGHjNlcHAFxJJhuUVNWUGBsG9VY00lefw8qiaV715l+5KnI/rRSpGOt9N87IdYiiME+krRK8+v7G71uJk0KVKpnILHBzkeDZ2BhvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iQPP8QB+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6F5C5C116C6;
	Sat, 14 Mar 2026 15:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773502307;
	bh=3oto4NzWUu1PAVH049AXdYT4Jt2n+mb0nBzsSwynlzE=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=iQPP8QB+76beLhL9mgIsGOEnujrXfyNA/t375e1sEvAXmazwvZph7TkB1QH6ZhSVr
	 IScYlS/3J9Ge+/rlKQ+nCNooke286BA1Soh0MznOFTlJJm+4uu1FocrQu2TOsvCHN3
	 ZL5JtLCryVxZ/dS7oZmXrWFU3Pkl1c5Dc2x4jqwvsUuTEg6uV+g86Ye9tdmToWDnwt
	 KCE173RlgKVlbs/OMwAa9UrcLyx2lZzUEHs2HLu+MaI9deK24lDcCUm+KtKSbYImhT
	 eAMbKK7A0ySpP0XH/aeGrBFIqB0NHoUTOsQTCNYScGegsl4R4QtM4i179y3AiqagBS
	 Un9V0yvtYCSsQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5783710706D1;
	Sat, 14 Mar 2026 15:31:47 +0000 (UTC)
From: Levi Zim via B4 Relay <devnull+rsworktech.outlook.com@kernel.org>
Date: Sat, 14 Mar 2026 23:31:28 +0800
Subject: [PATCH bpf v2] bpf: do not use kmalloc_nolock when
 !HAVE_CMPXCHG_DOUBLE
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260314-bpf-kmalloc-nolock-v2-1-576e33e4fa67@outlook.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/31NSw6CMBC9Cpm1Y/pBVFbew7AodCoN0CEtEg3h7
 jYcwM1L3n+DRNFTgrrYINLqk+eQiToV0PUmvAi9zRyUUJXQssR2djhMZhy5w8AZB6yENTdBldS
 WIBfnSM5/jtEn5Dw0Wex9Wjh+j6NVHta/zVWiRFWa1ml3vZi7e/B7GZmHc8cTNPu+/wC4ZOdtu
 wAAAA==
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4940;
 i=rsworktech@outlook.com; s=ryzen; h=from:subject:message-id;
 bh=OgmsL+IoFTwpgQ53xi0uCbqj+KUlvmYc6EsmLeVQARY=;
 b=owEBbQKS/ZANAwAKAW87mNQvxsnYAcsmYgBptX9aBEUQoXxUoQbiBYRV3LwvC1cyq5/288bP7
 35R5HsR91qJAjMEAAEKAB0WIQQolnD5HDY18KF0JEVvO5jUL8bJ2AUCabV/WgAKCRBvO5jUL8bJ
 2BRsD/96Swu0tWcACwdoVeOTVhC7njCgpPYwK7wSVhEobsYCLke6OMJCvhzTH9oy3RdMe9w0TWL
 TjRmb7Lmy5uMgLM6EFp+buP+147gkZKf8pjUDTjDpqXeHIBwqD5b4c8lXSCwmPXJDT1T8yTkW7k
 f2Dq3kAz4bD5VPbWOEu2cAYK+VkQVfHUD7qKvhMnkn/lh/2HNNYbcS6HhcWHbWNavYWkYT+4/zK
 ymDxTC0qpCa8qNCyIgz7rkH2CDddoOXRi5QScgb9BR+EZMy7rQyoeGyQ1xnEsF1qeihAzIwdHGb
 PnoRdg0iNIK8Zgv0lqflDDOo46IxQRVHv4oB2zeAxGV/XuOIMp9WDBC0kGQv5sydzb/ATIWbNey
 QE9KicHd8ZgiLOlO7/FMQRrupfMZq4aJzpxx3PS8+MpN8owd+4XYbd5k4p2s+tCfUDB+9QtgmH+
 KSO+DSXbUeuVSJqx4mGPaBS960sshd0Os1fvag8eqF0z3RnvHxBFVj8rfA58wW7t2C4usIS/6rc
 7/txBQVAV8I+ukor2HacVOsvhEfpfxnmJ7KOIIwnnRLdaN/l3sp2sEFmJzqmca5D6i1ye70N3yY
 UftIwAZFk8nldDqLTu8DkBjR2eLg615FVkL57XrZqrh9M8fFjb/13T37CAU6xV8LIQr9KXcq8OA
 FC9BoF/h2QyyAOQ==
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-225427-lists,stable=lfdr.de,rsworktech.outlook.com];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,outlook.com:email,outlook.com:replyto,outlook.com:mid]
X-Rspamd-Queue-Id: BB82E28DB35
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
Changes in v2:
- Drop the modification to the PREEMPT_RT case as it requires
  kmalloc_nolock for correctness.
- Add a comment to the PREEMPT_RT case about the limitation when
  not HAVE_CMPXCHG_DOUBLE but enables PREEMPT_RT.
- Link to v1: https://lore.kernel.org/r/20260314-bpf-kmalloc-nolock-v1-1-24abf3f75a9f@outlook.com
---
 include/linux/bpf_local_storage.h | 2 ++
 kernel/bpf/bpf_cgrp_storage.c     | 2 +-
 kernel/bpf/bpf_local_storage.c    | 4 ++++
 kernel/bpf/bpf_task_storage.c     | 2 +-
 4 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/include/linux/bpf_local_storage.h b/include/linux/bpf_local_storage.h
index 8157e8da61d40..a7ae5dde15bcb 100644
--- a/include/linux/bpf_local_storage.h
+++ b/include/linux/bpf_local_storage.h
@@ -19,6 +19,8 @@
 
 #define BPF_LOCAL_STORAGE_CACHE_SIZE	16
 
+static const bool KMALLOC_NOLOCK_SUPPORTED = IS_ENABLED(CONFIG_HAVE_CMPXCHG_DOUBLE);
+
 struct bpf_local_storage_map_bucket {
 	struct hlist_head list;
 	rqspinlock_t lock;
diff --git a/kernel/bpf/bpf_cgrp_storage.c b/kernel/bpf/bpf_cgrp_storage.c
index c2a2ead1f466d..09c557e426968 100644
--- a/kernel/bpf/bpf_cgrp_storage.c
+++ b/kernel/bpf/bpf_cgrp_storage.c
@@ -114,7 +114,7 @@ static int notsupp_get_next_key(struct bpf_map *map, void *key, void *next_key)
 
 static struct bpf_map *cgroup_storage_map_alloc(union bpf_attr *attr)
 {
-	return bpf_local_storage_map_alloc(attr, &cgroup_cache, true);
+	return bpf_local_storage_map_alloc(attr, &cgroup_cache, KMALLOC_NOLOCK_SUPPORTED);
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
index 605506792b5b4..9f74fd1ef7f46 100644
--- a/kernel/bpf/bpf_task_storage.c
+++ b/kernel/bpf/bpf_task_storage.c
@@ -212,7 +212,7 @@ static int notsupp_get_next_key(struct bpf_map *map, void *key, void *next_key)
 
 static struct bpf_map *task_storage_map_alloc(union bpf_attr *attr)
 {
-	return bpf_local_storage_map_alloc(attr, &task_cache, true);
+	return bpf_local_storage_map_alloc(attr, &task_cache, KMALLOC_NOLOCK_SUPPORTED);
 }
 
 static void task_storage_map_free(struct bpf_map *map)

---
base-commit: e06e6b8001233241eb5b2e2791162f0585f50f4b
change-id: 20260314-bpf-kmalloc-nolock-60da80e613de

Best regards,
-- 
Levi Zim <rsworktech@outlook.com>



