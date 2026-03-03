Return-Path: <stable+bounces-222789-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AEGoOTlypmnLPwAAu9opvQ
	(envelope-from <stable+bounces-222789-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 06:31:37 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 877691E9421
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 06:31:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 161F43055F81
	for <lists+stable@lfdr.de>; Tue,  3 Mar 2026 05:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A25C374E57;
	Tue,  3 Mar 2026 05:31:06 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 488F440855;
	Tue,  3 Mar 2026 05:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772515866; cv=none; b=lbJV88I61Jf7jeuxYfFLSqRZWfFiiNK5HLiliqINpl+4NfBPRK/KMmTAIKCWuRwiooo4vSnA4QeYwpDBMujUbU2HuTWDMrb1cWECI4Vb5N/uZSGqfLWBUZwHkcxRdWgKHmUSThC/15QLKND+UaPtAdR1z5GY9idyw45yCjbuHQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772515866; c=relaxed/simple;
	bh=971QZuBPX8vDJm+DbuLvrLOPHCLVRgRHvCt+mGqBS+I=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=DMavfJp77cjWPsYAKWMVjTED4xxPl8Q9OjpO+Q7/FXr5Er6RX8qBUwKkEI9uiRT0Em+p5n6zQBW1SHmhwzWMiVYDwdnVOiwz25FQj9gv6ExpSUYUzCHp8dLygPmIKk2Hgm/rVhHOL6ptC0i0FR66eT12FWda3zFLJwh5XQ7rmlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [127.0.0.2] (unknown [210.73.43.101])
	by APP-03 (Coremail) with SMTP id rQCowAAHHdT9caZpAmO+CQ--.19798S2;
	Tue, 03 Mar 2026 13:30:38 +0800 (CST)
From: Vivian Wang <wangruikang@iscas.ac.cn>
Subject: [PATCH v2 0/5] riscv: kfence: Handle the spurious fault after
 kfence_unprotect(), and related fixes
Date: Tue, 03 Mar 2026 13:29:44 +0800
Message-Id: <20260303-handle-kfence-protect-spurious-fault-v2-0-f80d8354d79d@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMhxpmkC/42OXW6DQAyEr4L8XKPF+QHy1HtUqbQxprGasHS9o
 FaIu2dDLtDHbzSa+RYwiSoGp2KBKLOahiEDvRXAVz98CWqXGcjR0RE1mMPuJvjdy8CCYwxJOKG
 NU9QwGfZ+uiU8UuWc7y9tvdtDnhqj9Pq73XycXxzlZ8pv6RXCxZsgh/td06mY69Jh5OpzWeFZv
 6qlEP82ybna+pvPztH/fOYKHdKBG+KmbruW39XYW+m55AHO67o+ACFd/4UJAQAA
X-Change-ID: 20260228-handle-kfence-protect-spurious-fault-62100afb9734
To: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alexandre Ghiti <alex@ghiti.fr>, Alexander Potapenko <glider@google.com>, 
 Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>, 
 Yunhui Cui <cuiyunhui@bytedance.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 kasan-dev@googlegroups.com, Palmer Dabbelt <palmer@rivosinc.com>, 
 stable@vger.kernel.org, Vivian Wang <wangruikang@iscas.ac.cn>, 
 Yanko Kaneti <yaneti@declera.com>
X-Mailer: b4 0.14.3
X-CM-TRANSID:rQCowAAHHdT9caZpAmO+CQ--.19798S2
X-Coremail-Antispam: 1UD129KBjvJXoWxCF13tr4kAryUCr15XF4kXrb_yoWrJw4xpF
	s3Jr93Gr4DJryxXw13Z3WjqFn5Jw1Iqr1rK3Z3Gw1Fyw13Zr4jyrn7Kws5XF98ur97Ar1j
	yw1F9F4UCrn0kwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9014x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1x
	MIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIda
	VFxhVjvjDU0xZFpf9x0JUqeHgUUUUU=
X-CM-SenderInfo: pzdqw2pxlnt03j6l2u1dvotugofq/
X-Rspamd-Queue-Id: 877691E9421
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-0.880];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wangruikang@iscas.ac.cn,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,iscas.ac.cn:mid];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-222789-lists,stable=lfdr.de];
	DMARC_NA(0.00)[iscas.ac.cn];
	FORGED_RECIPIENTS_MAILLIST(0.00)[]
X-Rspamd-Action: no action

kfence_unprotect() on RISC-V doesn't flush TLBs, because we can't send
IPIs in some contexts where kfence objects are allocated. This leads to
spurious faults and kfence false positives.

Avoid these spurious faults using the same "new_vmalloc" mechanism,
which I have renamed new_valid_map_cpus to avoid confusion, since the
kfence pool comes from the linear mapping, not vmalloc.

Commit b3431a8bb336 ("riscv: Fix IPIs usage in kfence_protect_page()")
only seemed to consider false negatives, which are indeed tolerable.
False positives on the other hand are not okay since they waste
developer time (or just my time somehow?) and spam kmsg making
diagnosing other problems difficult.

Patch 2 is the implementation to poke (what was called) new_vmalloc upon
kfence_unprotect(). Patch 1 is some refactoring that patch 2 depends on.
Patch 3 through 5 are some additional refactoring and minor fixes.

How this was found
------------------

This came up after a user reported some nonsensical kfence
use-after-free reports relating to k1_emac on SpacemiT K1, like this:

    [   64.160199] ==================================================================
    [   64.164773] BUG: KFENCE: use-after-free read in sk_skb_reason_drop+0x22/0x1e8
    [   64.164773]
    [   64.173365] Use-after-free read at 0xffffffd77fecc0cc (in kfence-#101):
    [   64.179962]  sk_skb_reason_drop+0x22/0x1e8
    [   64.179972]  dev_kfree_skb_any_reason+0x32/0x3c

    [...]

    [   64.181440] kfence-#101: 0xffffffd77fecc000-0xffffffd77fecc0cf, size=208, cache=skbuff_head_cache
    [   64.181440]
    [   64.181450] allocated by task 142 on cpu 1 at 63.665866s (0.515583s ago):
    [   64.181476]  __alloc_skb+0x66/0x244
    [   64.181484]  alloc_skb_with_frags+0x3a/0x1ac

    [...]

    [   64.182917] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 7.0.0-rc1-dirty #34 PREEMPTLAZY
    [   64.182926] Hardware name: Banana Pi BPI-F3 (DT)
    [   64.183111] ==================================================================

In particular, these supposed use-after-free accesses:

- Were never reported by KASAN despite being rather easy to reproduce
- Never contain a "freed by task" section
- Never happen on the same CPU as the "allocated by task" info
- And, most importantly, were not found to have been caused by the
  object being freed by anyone at that point

An interesting corollary of this observation is that the SpacemiT X60
CPU *does* cache invalid PTEs, and for a significant amount of time, or
at least long enough to be observable in practice. Or maybe only in an
wfi, given how most of these reports I've seen had the faulting CPU in
an IRQ?

---
Changes in v2:
- Reordered patches 1 through 3 to minimize what needs to be backported
- (New patch 4) Change the bitmap to use DECLARE_BITMAP (Alexander)
- (New patch 5) Additional fix
- Link to v1: https://lore.kernel.org/r/20260302-handle-kfence-protect-spurious-fault-v1-0-25c82c879d9c@iscas.ac.cn

---
Vivian Wang (5):
      riscv: mm: Extract helper mark_new_valid_map()
      riscv: kfence: Call mark_new_valid_map() for kfence_unprotect()
      riscv: mm: Rename new_vmalloc into new_valid_map_cpus
      riscv: mm: Use the bitmap API for new_valid_map_cpus
      riscv: mm: Unconditionally sfence.vma for spurious fault

 arch/riscv/include/asm/cacheflush.h | 25 +++++++++---------
 arch/riscv/include/asm/kfence.h     |  7 +++--
 arch/riscv/kernel/entry.S           | 51 ++++++++++++++++++++-----------------
 arch/riscv/mm/init.c                |  2 +-
 4 files changed, 47 insertions(+), 38 deletions(-)
---
base-commit: 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f
change-id: 20260228-handle-kfence-protect-spurious-fault-62100afb9734

Best regards,
-- 
Vivian "dramforever" Wang


