Return-Path: <stable+bounces-225302-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OFphILUHtGlvfwAAu9opvQ
	(envelope-from <stable+bounces-225302-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 13:48:53 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D9F0C28336E
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 13:48:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 613EB3179457
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 12:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA9B237F743;
	Fri, 13 Mar 2026 12:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VgfwfG8a"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72001372B22
	for <stable@vger.kernel.org>; Fri, 13 Mar 2026 12:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773406100; cv=none; b=K7rGtOsWEwjUKuphWJcAcVdHcME6o5vg92lZ+qghO445Vt3k3hgEv7sHumElWpx/PzKTrTpyLb699fRd+UrXWVRh70o2EtBMxRVf7EYwLIe2Xgwka+ZM8+JkdFQN2W5103J7Laix61XiOi13Hfwvj2J/qonR9687+USO+aQw3x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773406100; c=relaxed/simple;
	bh=XfKfXzjf7gbxNC6vib8RG4R2P1jsad/9oN/bvop1Wqc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=f9g2fbxQJbOIkoaer9pcbIe7cd9vN+kf358qoqx/mmUhEoekhanGqQyXnOhydg/aHOb+nkKVlReW9n9m0xcOzih/1AJMToBrUJOOCU6A4FZc1aalsvbRLxTN6TZyzFw3peJ1tWwxbBMsqf+gs0j8hUUT9xrYrazP4s3YvIAvvQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VgfwfG8a; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-829b2019b39so1241870b3a.3
        for <stable@vger.kernel.org>; Fri, 13 Mar 2026 05:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773406098; x=1774010898; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JVbq1+5JLiB1PQXQIov/VgYGmmN3xnvNqpwoZJ8TqWI=;
        b=VgfwfG8a1iKH9C5R8AIlNG+ToqHvtUL75XdgvwkqeMu8XJzMmwShXs/b4zWQpUbjsj
         fxUs9DeFASFIAOoU9sK6qplHy7j5cv1obMnTeNp80Au5P76Y5+oNIoR2pfUjiHz/J6IF
         ePozc7YREpWFFNQFfdn1+kXcNvUXh1jxKnJY6UCu0PcxSvEa/XLXWXZ6fIlYFwY9m//u
         39m8URxOy8bb8qVlN4trj5idX5T/ksJMe5drWu6luNOPV80gctmsiZ2XkywvUotu+twx
         OW2zT5PPKmrSFgkpvNZu+NgJFeWRSad/dBA4bkz+/cmr6YTnhTcKCduptMkpsHCVL7kR
         7tnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773406098; x=1774010898;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JVbq1+5JLiB1PQXQIov/VgYGmmN3xnvNqpwoZJ8TqWI=;
        b=PT94zhnlJY4yuniA160uW6rQR8bRGSRMQX0RpQN5NreqhvWQK5XsVwzN3ouYPwjHkt
         yewKnc5R0TW+jnxsEYjtkfoqaspFFgK/3f9nOJZxZRt5vcDRJryXL1dd+Dz1VbNZEMeW
         P1hFv9EVmvWrsJMv55JZxNCvdYaKNVXU7tIOOGzAyB6qATyuwriH5g1xd9EhzqP5lPKO
         bQ6GZejKlCVzUAsbbXd3nRoeNkZIfcJkmiMy/E8zQzvuIWqVBOFBG63D+RbC/tD2A/Wn
         9SMi0nmKYrGiiUGcfecWQf2J2ruiZETsCSxXBI/avR/c7PZkSZZgLMg25IclACtHtTI6
         mdxA==
X-Forwarded-Encrypted: i=1; AJvYcCW3XJ6Xv6kJpDmhv9WJZclF/WP8h7eZNgeSViT1iHfMV5nFS+4EWkAz5pbh/i8N+zZKnGyTyBE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywlm9bUL3xysL0yB5FxACqVACiczirACheZjFzOP1s6+5L2R4Lb
	PW5qDq9RDSeD6qMw64jpMskcVxrmjGfCnoAwvYyyuyeb7xK59u+5/xoP
X-Gm-Gg: ATEYQzyqYeHIC+v5kj9+L2l9qd5t2tmijDTU/ksfndCoPx8OQG2DzttBoull5PC2v8d
	uwjN0XDce3C2O3WteHZFcUdyObB+k/S7J04wTpGyoKfT24fbs4rSLLEotEQxfo/6yvic7j2P/rG
	hocxb1m83INAV5SXqEP4CJ0k1nRwGVw1YZup5rIKOV+kMB15XVAbPGB0oj0S8D/xbKNRtKLT1eU
	t8TuJMY3E20AbBNupAm1Ps+fTKp3A+zyI2EN2DC/VBxJhPBN4HnXVeFTNADw+HXzLIxdtktytQL
	WkdpAF+wEHqRaX8u8uY9H7mBOZqpUDYrfrDe+72JFRzkjP7iHvEW4AQPgSl2+LJJO1rOKKXxUql
	pspjuglqIB0eISKWPc6Ieu0VBAgP8tI4vU9ZtzS6KPoluOjAS4ZOziVB8D3FQ0YNKq2d06Qeb8n
	ckwCcis26TJWn6mvrL/v95CRjOQp+7ZeFi/9Zyle+y+x0/gYX+24bJdaQda2NypmzKUHxngDHw5
	dYFcOV1vQsF2M94zCRkQ25I1N4D
X-Received: by 2002:a05:6a00:2e90:b0:82a:1380:417d with SMTP id d2e1a72fcca58-82a198fcf29mr3024562b3a.52.1773406096636;
        Fri, 13 Mar 2026 05:48:16 -0700 (PDT)
Received: from naup-virtual-machine.localdomain (114-36-226-49.dynamic-ip.hinet.net. [114.36.226.49])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a07240f25sm6104225b3a.5.2026.03.13.05.48.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 05:48:13 -0700 (PDT)
From: Hao-Yu Yang <naup96721@gmail.com>
To: security@kernel.org
Cc: tglx@kernel.org,
	mingo@redhat.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hao-Yu Yang <naup96721@gmail.com>
Subject: [PATCH v2] futex: Use-after-free between futex_key_to_node_opt and vma_replace_policy
Date: Fri, 13 Mar 2026 20:47:56 +0800
Message-Id: <20260313124756.52461-1-naup96721@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-225302-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[naup96721@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D9F0C28336E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

During futex_key_to_node_opt() execution, vma->vm_policy is read under
speculative mmap lock and RCU. Concurrently, mbind() may call
vma_replace_policy() which frees the old mempolicy immediately via
kmem_cache_free().

This creates a race where __futex_key_to_node() dereferences a freed
mempolicy pointer, causing a use-after-free read of mpol->mode.

[  151.412631] BUG: KASAN: slab-use-after-free in __futex_key_to_node (kernel/futex/core.c:349)
[  151.414046] Read of size 2 at addr ffff888001c49634 by task e/87
[  151.414476]
[  151.415431] CPU: 1 UID: 1000 PID: 87 Comm: e Not tainted 7.0.0-rc3-g0257f64bdac7 #1 PREEMPT(lazy)
[  151.415758] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
[  151.415969] Call Trace:
[  151.416059]  <TASK>
[  151.416161]  dump_stack_lvl (lib/dump_stack.c:123)
[  151.416299]  print_report (mm/kasan/report.c:379 mm/kasan/report.c:482)
[  151.416359]  ? __virt_addr_valid (./include/linux/mmzone.h:2046 ./include/linux/mmzone.h:2198 arch/x86/mm/physaddr.c:54)
[  151.416412]  ? __futex_key_to_node (kernel/futex/core.c:349)
[  151.416517]  ? kasan_complete_mode_report_info (mm/kasan/report_generic.c:182)
[  151.416583]  ? __futex_key_to_node (kernel/futex/core.c:349)
[  151.416631]  kasan_report (mm/kasan/report.c:597)
[  151.416677]  ? __futex_key_to_node (kernel/futex/core.c:349)
[  151.416732]  __asan_load2 (mm/kasan/generic.c:271)
[  151.416777]  __futex_key_to_node (kernel/futex/core.c:349)
[  151.416822]  get_futex_key (kernel/futex/core.c:374 kernel/futex/core.c:386 kernel/futex/core.c:593)
[  151.416871]  ? __pfx_get_futex_key (kernel/futex/core.c:550)
[  151.416927]  futex_wake (kernel/futex/waitwake.c:165)
[  151.416976]  ? __pfx_futex_wake (kernel/futex/waitwake.c:156)
[  151.417022]  ? __pfx___x64_sys_futex_wait (kernel/futex/syscalls.c:398)
[  151.417081]  __x64_sys_futex_wake (kernel/futex/syscalls.c:382 kernel/futex/syscalls.c:366 kernel/futex/syscalls.c:366)
[  151.417129]  x64_sys_call (arch/x86/entry/syscall_64.c:41)
[  151.417236]  do_syscall_64 (arch/x86/entry/syscall_64.c:63 arch/x86/entry/syscall_64.c:94)
[  151.417342]  entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
[  151.418312]  </TASK>

Fix by adding rcu to __mpol_put().

change-log:
 v2-v1: add rcu to __mpol_put

Fixes: c042c505210d ("futex: Implement FUTEX2_MPOL")
Reported-by: Hao-Yu Yang <naup96721@gmail.com>
Signed-off-by: Hao-Yu Yang <naup96721@gmail.com>
---
 include/linux/mempolicy.h | 1 +
 mm/mempolicy.c            | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/mempolicy.h b/include/linux/mempolicy.h
index 0fe96f3ab3ef..65c732d440d2 100644
--- a/include/linux/mempolicy.h
+++ b/include/linux/mempolicy.h
@@ -55,6 +55,7 @@ struct mempolicy {
 		nodemask_t cpuset_mems_allowed;	/* relative to these nodes */
 		nodemask_t user_nodemask;	/* nodemask passed by user */
 	} w;
+	struct rcu_head rcu;
 };
 
 /*
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 0e5175f1c767..6dc61a3d4a32 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -487,7 +487,7 @@ void __mpol_put(struct mempolicy *pol)
 {
 	if (!atomic_dec_and_test(&pol->refcnt))
 		return;
-	kmem_cache_free(policy_cache, pol);
+	kfree_rcu(pol, rcu);
 }
 EXPORT_SYMBOL_FOR_MODULES(__mpol_put, "kvm");
 
-- 
2.34.1


