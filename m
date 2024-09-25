Return-Path: <stable+bounces-77080-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 020CA985345
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 08:53:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B355D281753
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 06:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0740C155C98;
	Wed, 25 Sep 2024 06:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ZrMv8D6L"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA20155A25
	for <stable@vger.kernel.org>; Wed, 25 Sep 2024 06:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727247224; cv=none; b=BN27Dq1ChW5tXI6kgMrK+wIKDvidxybmKrg9XONZhOCKygNpcBONIqD7p3KC/v//FjMUofV085TVjsfJnFSH8rq3yxSDudpi+vlEioZbBtNvzPNc+6gYh7J2jjO5WCWBjlXZZHQ+Y008Ync11cBSCSvvaDkQsYRmPsy+xIo+5qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727247224; c=relaxed/simple;
	bh=xOEYAu53yq7gRs6vSUaPmm1I4Uq8HUcYekaeYyfJQZ0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Tc9+/pVSrTtunvez4Ot7rQpULuYZG8dmzAZJ0zpE7uEqtfVNFsgXYosSaahGQyMdowxA2LP9hsCvDWuBxObT/7LyFwClSOAGWr556mmoFRPuXBpqVCFoFNKoncs40vZFjfigtxDvqwhyVTw93HHWG7fdbwH3Vud4OpO1uawowZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ZrMv8D6L; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7191fb54147so4650707b3a.2
        for <stable@vger.kernel.org>; Tue, 24 Sep 2024 23:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1727247220; x=1727852020; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ocj9pLKaZVxq69VsJPKezFYPC0j22GZ+6ngnvWMj5Ms=;
        b=ZrMv8D6Lu3OvJi5SL3i7+o5xlj+CBe1LRaVHDtrNONbzh3VdwwepwDP+8mUGwx3FnE
         vKRDcE9/mb/sCN+t04TpxiYa4qyhn5KG5dcfyvHgCFugDZpk3EpbeYaUQXnHevd4JL5+
         lTdFS4VzbEHFRqBfhjhQGdC7vcPQyFLR9+yxA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727247220; x=1727852020;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ocj9pLKaZVxq69VsJPKezFYPC0j22GZ+6ngnvWMj5Ms=;
        b=vxuquczmzTRAIylVUwox4F0M6xmbVMCyYcb5jJmc7zv6lemWU3BwN9Omvwez4nluQI
         ybTtF5XoVSIfCg9BAXj15IYxiwdIAqj5XKWcR3gzhZMKl9EIQOj/BgsmL9ojv7MH7ZIz
         tyZc+wxJiq/ts6YtMPwqz3+D3S4V1YVNijO20ZQmPvMG7BkwVWonbV+an4CuPz/V1HLR
         ldxDvx2RGzAIY8M2lYHgLTBRzeHM1YZE9guGs7439nsBKxr7x7lRp8npyS+OIfMEw+OC
         QGW78PN4aTq26iUm3lVHcbi1RP6uF3Ovb8PKGiJog8yThqSjlN7bvDau762xvE7+ctIE
         AskQ==
X-Gm-Message-State: AOJu0Yy+nOUtx+KRy0/ofuimxNun7OSysTAuz9/sYp/w1QH30ECj/LSA
	48VotxCLtazRg/e4KSsSPiUutJt7mreRg3LcHANG3YGIHtFJMQ7sqAtPqUpw7ml1s41Gfv2GyqV
	rk15uhbWuUQUfNzL5/UxCm2UFPHA59HRhJsY4j+iLwk3xvVNhfeNgUGxpI5SOkXy2CWIBpbUBzc
	q3p4ssTWZv2cW6Z2OvKA3mP8lCbEJ7DoQCl8ZAWIHXl6JcdE0=
X-Google-Smtp-Source: AGHT+IE40F2Z8QFtmyCQfQ6un+BCfmpOsQ5XiqfHbVSIT1H2+hg/dfp8dEW+fqOkJzaaiVe1lO1C2w==
X-Received: by 2002:a05:6a20:cfa5:b0:1cf:3b22:feca with SMTP id adf61e73a8af0-1d4d4aaef94mr2565484637.15.1727247220128;
        Tue, 24 Sep 2024 23:53:40 -0700 (PDT)
Received: from shivania.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71afc97b623sm2147203b3a.169.2024.09.24.23.53.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 23:53:39 -0700 (PDT)
From: Shivani Agarwal <shivani.agarwal@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	vasavi.sirnapalli@broadcom.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	linux-trace-kernel@vger.kernel.org,
	peterz@infradead.org,
	jpoimboe@redhat.com,
	sashal@kernel.org,
	Shivani Agarwal <shivani.agarwal@broadcom.com>
Subject: [PATCH 1/2 v5.10] x86/ibt,ftrace: Search for __fentry__ location
Date: Tue, 24 Sep 2024 23:53:23 -0700
Message-Id: <20240925065324.121176-2-shivani.agarwal@broadcom.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240925065324.121176-1-shivani.agarwal@broadcom.com>
References: <20240925065324.121176-1-shivani.agarwal@broadcom.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Peter Zijlstra <peterz@infradead.org>

[ Upstream commit aebfd12521d9c7d0b502cf6d06314cfbcdccfe3b ]

Currently a lot of ftrace code assumes __fentry__ is at sym+0. However
with Intel IBT enabled the first instruction of a function will most
likely be ENDBR.

Change ftrace_location() to not only return the __fentry__ location
when called for the __fentry__ location, but also when called for the
sym+0 location.

Then audit/update all callsites of this function to consistently use
these new semantics.

Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lore.kernel.org/r/20220308154318.227581603@infradead.org
Stable-dep-of: e60b613df8b6 ("ftrace: Fix possible use-after-free issue in ftrace_location()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
[Shivani: Modified to apply on v5.10.y]
Signed-off-by: Shivani Agarwal <shivani.agarwal@broadcom.com>
---
 arch/x86/kernel/kprobes/core.c | 11 ++------
 kernel/bpf/trampoline.c        | 20 +++-----------
 kernel/kprobes.c               |  8 ++----
 kernel/trace/ftrace.c          | 48 ++++++++++++++++++++++++++++------
 4 files changed, 48 insertions(+), 39 deletions(-)

diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
index e7edc9e4c6cd..6d59c8e7719b 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -194,17 +194,10 @@ static unsigned long
 __recover_probed_insn(kprobe_opcode_t *buf, unsigned long addr)
 {
 	struct kprobe *kp;
-	unsigned long faddr;
+	bool faddr;
 
 	kp = get_kprobe((void *)addr);
-	faddr = ftrace_location(addr);
-	/*
-	 * Addresses inside the ftrace location are refused by
-	 * arch_check_ftrace_location(). Something went terribly wrong
-	 * if such an address is checked here.
-	 */
-	if (WARN_ON(faddr && faddr != addr))
-		return 0UL;
+	faddr = ftrace_location(addr) == addr;
 	/*
 	 * Use the current code if it is not modified by Kprobe
 	 * and it cannot be modified by ftrace.
diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index 87becf77cc75..0a14f14d83fe 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -87,18 +87,6 @@ static struct bpf_trampoline *bpf_trampoline_lookup(u64 key)
 	return tr;
 }
 
-static int is_ftrace_location(void *ip)
-{
-	long addr;
-
-	addr = ftrace_location((long)ip);
-	if (!addr)
-		return 0;
-	if (WARN_ON_ONCE(addr != (long)ip))
-		return -EFAULT;
-	return 1;
-}
-
 static int unregister_fentry(struct bpf_trampoline *tr, void *old_addr)
 {
 	void *ip = tr->func.addr;
@@ -127,12 +115,12 @@ static int modify_fentry(struct bpf_trampoline *tr, void *old_addr, void *new_ad
 static int register_fentry(struct bpf_trampoline *tr, void *new_addr)
 {
 	void *ip = tr->func.addr;
+	unsigned long faddr;
 	int ret;
 
-	ret = is_ftrace_location(ip);
-	if (ret < 0)
-		return ret;
-	tr->func.ftrace_managed = ret;
+	faddr = ftrace_location((unsigned long)ip);
+	if (faddr)
+		tr->func.ftrace_managed = true;
 
 	if (tr->func.ftrace_managed)
 		ret = register_ftrace_direct((long)ip, (long)new_addr);
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index c8e62458d323..551ac118159f 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1609,14 +1609,10 @@ static inline int check_kprobe_rereg(struct kprobe *p)
 
 int __weak arch_check_ftrace_location(struct kprobe *p)
 {
-	unsigned long ftrace_addr;
+	unsigned long addr = (unsigned long)p->addr;
 
-	ftrace_addr = ftrace_location((unsigned long)p->addr);
-	if (ftrace_addr) {
+	if (ftrace_location(addr) == addr) {
 #ifdef CONFIG_KPROBES_ON_FTRACE
-		/* Given address is not on the instruction boundary */
-		if ((unsigned long)p->addr != ftrace_addr)
-			return -EILSEQ;
 		p->flags |= KPROBE_FLAG_FTRACE;
 #else	/* !CONFIG_KPROBES_ON_FTRACE */
 		return -EINVAL;
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 31fec924b7c4..a781733b2a01 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -1575,17 +1575,34 @@ unsigned long ftrace_location_range(unsigned long start, unsigned long end)
 }
 
 /**
- * ftrace_location - return true if the ip giving is a traced location
+ * ftrace_location - return the ftrace location
  * @ip: the instruction pointer to check
  *
- * Returns rec->ip if @ip given is a pointer to a ftrace location.
- * That is, the instruction that is either a NOP or call to
- * the function tracer. It checks the ftrace internal tables to
- * determine if the address belongs or not.
+ * If @ip matches the ftrace location, return @ip.
+ * If @ip matches sym+0, return sym's ftrace location.
+ * Otherwise, return 0.
  */
 unsigned long ftrace_location(unsigned long ip)
 {
-	return ftrace_location_range(ip, ip);
+	struct dyn_ftrace *rec;
+	unsigned long offset;
+	unsigned long size;
+
+	rec = lookup_rec(ip, ip);
+	if (!rec) {
+		if (!kallsyms_lookup_size_offset(ip, &size, &offset))
+			goto out;
+
+		/* map sym+0 to __fentry__ */
+		if (!offset)
+			rec = lookup_rec(ip, ip + size - 1);
+	}
+
+	if (rec)
+		return rec->ip;
+
+out:
+	return 0;
 }
 
 /**
@@ -4948,7 +4965,8 @@ ftrace_match_addr(struct ftrace_hash *hash, unsigned long ip, int remove)
 {
 	struct ftrace_func_entry *entry;
 
-	if (!ftrace_location(ip))
+	ip = ftrace_location(ip);
+	if (!ip)
 		return -EINVAL;
 
 	if (remove) {
@@ -5096,11 +5114,16 @@ int register_ftrace_direct(unsigned long ip, unsigned long addr)
 	struct ftrace_func_entry *entry;
 	struct ftrace_hash *free_hash = NULL;
 	struct dyn_ftrace *rec;
-	int ret = -EBUSY;
+	int ret = -ENODEV;
 
 	mutex_lock(&direct_mutex);
 
+	ip = ftrace_location(ip);
+	if (!ip)
+		goto out_unlock;
+
 	/* See if there's a direct function at @ip already */
+	ret = -EBUSY;
 	if (ftrace_find_rec_direct(ip))
 		goto out_unlock;
 
@@ -5229,6 +5252,10 @@ int unregister_ftrace_direct(unsigned long ip, unsigned long addr)
 
 	mutex_lock(&direct_mutex);
 
+	ip = ftrace_location(ip);
+	if (!ip)
+		goto out_unlock;
+
 	entry = find_direct_entry(&ip, NULL);
 	if (!entry)
 		goto out_unlock;
@@ -5360,6 +5387,11 @@ int modify_ftrace_direct(unsigned long ip,
 	mutex_lock(&direct_mutex);
 
 	mutex_lock(&ftrace_lock);
+
+	ip = ftrace_location(ip);
+	if (!ip)
+		goto out_unlock;
+
 	entry = find_direct_entry(&ip, &rec);
 	if (!entry)
 		goto out_unlock;
-- 
2.39.4


