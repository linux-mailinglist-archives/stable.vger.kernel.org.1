Return-Path: <stable+bounces-253899-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YPPWJQ49EWpzjAYAu9opvQ
	(envelope-from <stable+bounces-253899-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 07:37:18 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D0ECF5BD4AC
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 07:37:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B1C22300AD81
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 05:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A76C3128AB;
	Sat, 23 May 2026 05:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rQ8PAWkF"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 611F7307AC6
	for <stable@vger.kernel.org>; Sat, 23 May 2026 05:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779514621; cv=none; b=rpAQE5dFUKq5TZd/RD2GyX6Tzh49UAFMp1ALtImqPZLNFNY6/OX9bLTV8TLs48n7IDC3YPHFZSo5TaqZiUgp3OLf+5TkwM86sBn4/QF5lK6ognTGxFQO6r4I+jbR5kWDyW/rP3SqKwb9sNhecOP/a9D3B+w6JUEK2e0sDFJoZCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779514621; c=relaxed/simple;
	bh=K1iy/7Us+v9iabohnw6QHdQ4FKbTQ+1yjGBvyFrzzaw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YAUhjkedtZqafsKNgUNkYBf4Lev6eR7Pxh6KTJ2lz2ZB4+wiAGfzejzwdsL1PiuqSh4jS1Mvwnj0LwRTvSfJwZxMhcDIoj2nh7ACbvyAXMFsNrBKrIrIzyMZlsMVluQQjSYXg1wPA25ZYRIzvmH5jwCxHYyiTCPVbkNxqVTfju8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rQ8PAWkF; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-44a5174670eso4687043f8f.1
        for <stable@vger.kernel.org>; Fri, 22 May 2026 22:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779514618; x=1780119418; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LfCXYx65YgeEukMHypUmArLMk/VIi+xGB6BZmr+icPM=;
        b=rQ8PAWkFYtCSvihyR3Nf21St1nM3N2XyrNwWp8eAh+Z7W3C51MJKlyyTV5sNh4nf/e
         OU2OhCghSunIuXKUdvO5m1HMc8NB4beWjqIGZXMcTIgvi4F5AkZQ5jZnsr0ktvmOUQka
         fgz3Aspqm5+Cn9ti8uEA0ccnHJpPONqqeS2NGUGSGLiQHg7pA5XMlaIR6GJ7vyFe11jW
         DOg05O70HxJsAIKheBwB4um7XLvk+bRHXiHEq/hKF/6sQMkrZmKKbx8o31Rev1AID48c
         2FuEpWgQFLb6VKHQk3h6Q37OGPb4MdkpMQHe3HbYZeEpPwqEERKsXVXmcDEZiOGLVyHM
         5t3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779514618; x=1780119418;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LfCXYx65YgeEukMHypUmArLMk/VIi+xGB6BZmr+icPM=;
        b=rXAjaXobGEXa4TvHAqV/XAwaUnQXB+F6gnWK96gh5KvhtgmvAtg9oJ9q9hjyKZz2/3
         FuprNhKeW3pXsObhcJKYyxp6R1iupzyq+P1bkRvnhF5eZZLSAXthvC18D0cCjyWikJoU
         dbRSR6fknSJWUDxPpveMhSSkJu7Z1wpBv/pJVoLQY1lanIK7gfKyRXQeQps2Jz8/O/zW
         rs+Uhd+r1BgOIHv96x0J9DQ3ZvwAkWaKb1RePOQvbTrXeh1sd+39bw+2XuFQao15DAW1
         zv3Wbm7CP3UxgMofrzFltYxepHqRGVSizhsJymIQu9IHvRsH4rXGVM3ELvxC5pIeDNxM
         lzfA==
X-Forwarded-Encrypted: i=1; AFNElJ9fGuhNCyOChnPpU8js8bb/84aXlYlKJNv3Zv6WRKFIIR5fa98rWoL5cdMX1ORoLBsKpy5bwu8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzksC+36uqcF3iA22kBSmk2zJfnw7UyoAJSnwWMO0tMBwTZjyHA
	7L+6Wvvv5aHNi9SBGXO+wrSsz1Ir1q2LDG8RBeosDQbn0gXPcQmeN+Ja
X-Gm-Gg: Acq92OEr17jPSRoaXCnC4Bunz3PTX4vxYChJce2NOte67AJ+EKfdNNd6b7JHJe15wJe
	4RP4oR3HhErOe4qh662xDjoS0nTst/J6pBdHUuyG7LqwE7fQ0cxKMNFW0GF3dGSv5igb2Yngdjr
	xDA2J7NwteUZJGJ/hMF1wIDfINVPKr0x/bPgRhMAojvoF4uYUiN8J2r82pM+faicvziO9LhLs27
	qtmiDh32WiORONONu25PPSwhgXA9fhdjvLM9/zOXXn5b0LbusmziDapRll7ekiQ/0MnXAbhX1Tb
	Iyy0M5a1z6FAytS04NJ+2BtJrYLrXY8PF7EQLqEqKMKUZHOJ/hDqxFd8keG/PchxjBNvVOYp07f
	g0k7X+szyrPC0F/BCvb5eu4H3L1blPVkXj2g3M6VVo8V8k3EKPAGEwWNz7iZ6BDk1Wk4OB5X/aM
	A61D8sdqNKumYU1/+F7y5SnuN2IVDDCcOVcr+bt+ivmrc2l01PMYNulPiwEPnxMYuvOoY6HWFWn
	g0ypg==
X-Received: by 2002:a05:6000:2007:b0:43e:a81d:c475 with SMTP id ffacd0b85a97d-45eb3673201mr10681423f8f.6.1779514617661;
        Fri, 22 May 2026 22:36:57 -0700 (PDT)
Received: from localhost (brnt-04-b2-v4wan-170138-cust2432.vm7.cable.virginm.net. [94.175.9.129])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45eb6d5e484sm9473519f8f.30.2026.05.22.22.36.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 22:36:56 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Linux OpenRISC <linux-openrisc@vger.kernel.org>,
	Stafford Horne <shorne@gmail.com>,
	stable@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Jason Baron <jbaron@akamai.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Jonas Bonn <jonas@southpole.se>,
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
	chenmiao <chenmiao.ku@gmail.com>
Subject: [PATCH 3/3] openrisc: Fix jump_label smp syncing
Date: Sat, 23 May 2026 06:36:18 +0100
Message-ID: <20260523053624.630443-4-shorne@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260523053624.630443-1-shorne@gmail.com>
References: <20260523053624.630443-1-shorne@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,infradead.org,kernel.org,akamai.com,google.com,goodmis.org,southpole.se,saunalahti.fi];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-253899-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shorne@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.989];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: D0ECF5BD4AC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The original commit 8c30b0018f9d ("openrisc: Add jump label support")
copies from arm64 and does not properly consider how icache invalidation
on remote cores works in OpenRISC.  On OpenRISC remote icaches need to
be invalidated otherwise static key's may remain state after updating.

Fix SMP cache syncing by:

 1. Properly invalidate remote core icaches on SMP systems by using
    icache_all_inv.  The old code uses kick_all_cpus_sync() which runs a
    no-op IPI function call on remote CPU's which does execute a lot of
    code and flushes many cache lines in the process, but does not flush
    all and it's not correct on OpenRISC.
 2. For architectures that do not have WRITETHROUGH caches be sure
    to flush the dcache after patching.

To test this I first reproduced the issue using a custom test module
[0].  The test confirmed that some icache lines maintained stale
static_key code sequences after calling static_branch_enable().  After
this patch there are no longer jump_label coherency issues.

[0] https://github.com/stffrdhrn/or1k-utils/tree/master/tests/smp_static_key_test

Cc: stable@vger.kernel.org # depends on openrisc: Add icache_all_inv
Fixes: 8c30b0018f9d ("openrisc: Add jump label support")
Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 arch/openrisc/kernel/jump_label.c | 2 +-
 arch/openrisc/kernel/patching.c   | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/openrisc/kernel/jump_label.c b/arch/openrisc/kernel/jump_label.c
index ab7137c23b46..9cb63f2d2e2b 100644
--- a/arch/openrisc/kernel/jump_label.c
+++ b/arch/openrisc/kernel/jump_label.c
@@ -47,5 +47,5 @@ bool arch_jump_label_transform_queue(struct jump_entry *entry,
 
 void arch_jump_label_transform_apply(void)
 {
-	kick_all_cpus_sync();
+	icache_all_inv();
 }
diff --git a/arch/openrisc/kernel/patching.c b/arch/openrisc/kernel/patching.c
index d186172beb33..5db027b78bc4 100644
--- a/arch/openrisc/kernel/patching.c
+++ b/arch/openrisc/kernel/patching.c
@@ -49,6 +49,9 @@ static int __patch_insn_write(void *addr, u32 insn)
 	waddr = patch_map(addr, FIX_TEXT_POKE0);
 
 	ret = copy_to_kernel_nofault(waddr, &insn, OPENRISC_INSN_SIZE);
+	if (!IS_ENABLED(CONFIG_DCACHE_WRITETHROUGH))
+		local_dcache_range_flush((unsigned long)waddr,
+					 (unsigned long)waddr + OPENRISC_INSN_SIZE);
 	local_icache_range_inv((unsigned long)waddr,
 			       (unsigned long)waddr + OPENRISC_INSN_SIZE);
 
-- 
2.53.0


