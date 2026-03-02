Return-Path: <stable+bounces-222501-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KF/kAlz0pGmcwgUAu9opvQ
	(envelope-from <stable+bounces-222501-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 03:22:20 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 526DE1D273E
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 03:22:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0EEE83010510
	for <lists+stable@lfdr.de>; Mon,  2 Mar 2026 02:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC801284669;
	Mon,  2 Mar 2026 02:22:06 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70059175A8D;
	Mon,  2 Mar 2026 02:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772418126; cv=none; b=B7bbyQafjzbq0hW2ZBHw16qkI2iW+RYh9DfWWaKsv/2ETv2Cr3qWYa7YLA6OssQy9kHxJdxkyP+vkML6kodFZKQ3xpSwoyGG08wP+/cWXE+ubPcnvZ/P+Bm94RcyW/9bRSSn352aY1OZ7v+BrYGBRaQbOM5DfR/tkkhdMWU87ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772418126; c=relaxed/simple;
	bh=4ODW+gVPwkrj2pak7U9SMn9U1HrnAuRyY02jANk5SF0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=MfNeL/QkvKIvP+aw9F8VneExz5ZvDpV0JclkgfF38YIAW+Ihjhwnq5dUWRhucXczx2gaxZ482cB/Ac8ECcR7u9sVuhCX6JUOvSWjKgz0JRNBoP/dsvINYMrCKTsqGbTtRJwVsDSqwj0aTd137fTGXs11cRuF/g7AtHKfxmLg5zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [127.0.0.2] (unknown [210.73.43.101])
	by APP-03 (Coremail) with SMTP id rQCowAD3E9s39KRp6CWmCQ--.11902S2;
	Mon, 02 Mar 2026 10:21:43 +0800 (CST)
From: Vivian Wang <wangruikang@iscas.ac.cn>
Subject: [PATCH 0/3] riscv: kfence: Handle the spurious fault after
 kfence_unprotect()
Date: Mon, 02 Mar 2026 10:21:29 +0800
Message-Id: <20260302-handle-kfence-protect-spurious-fault-v1-0-25c82c879d9c@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACn0pGkC/yWNQQ6CMBAAv0L27JpSDShfIZiUstWNQHHbEhPC3
 23kOHOY2SCQMAVoig2EVg7s5wzlqQD7MvOTkIfMoJWulNY3zHIYCd+OZku4iI9kI4YlCfsU0Jk
 0Rqx0qZRx/b2+XCGnFiHH3/+m7Q4W+qR8i4eE3gRC66eJY1Os9Vmh2PKx7dDt+w98ojvypQAAA
 A==
X-Change-ID: 20260228-handle-kfence-protect-spurious-fault-62100afb9734
To: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
 Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>, 
 Dmitry Vyukov <dvyukov@google.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 kasan-dev@googlegroups.com, Palmer Dabbelt <palmer@rivosinc.com>, 
 Vivian Wang <wangruikang@iscas.ac.cn>, stable@vger.kernel.org, 
 Yanko Kaneti <yaneti@declera.com>
X-Mailer: b4 0.14.3
X-CM-TRANSID:rQCowAD3E9s39KRp6CWmCQ--.11902S2
X-Coremail-Antispam: 1UD129KBjvJXoWxCF13tr4ftFy8Xw1DurWktFb_yoW5urW5pF
	s3JryfKr4DJryxXw13Z3Wjqr1rJw1xtw1Fg3WfJw1Fyw15Zr4Dtrn5trZ5XF98Wr97Ar1U
	Aa10vr1UCrn0k37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9E14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVWxJr
	0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFylc2xSY4AK67AK6r4UMxAIw28IcxkI7VAKI4
	8JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xv
	wVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjx
	v20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20E
	Y4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267
	AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbBMNUUUUUU==
X-CM-SenderInfo: pzdqw2pxlnt03j6l2u1dvotugofq/
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	DMARC_NA(0.00)[iscas.ac.cn];
	FROM_NEQ_ENVFROM(0.00)[wangruikang@iscas.ac.cn,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-222501-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[iscas.ac.cn:mid]
X-Rspamd-Queue-Id: 526DE1D273E
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

Patch 3 is the implementation to poke (what was called) new_vmalloc upon
kfence_unprotect(). Patch 1 and 2 are just refactoring. In particular
Patch 1 is just a substitution job, to make reviewing easier.

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
Vivian Wang (3):
      riscv: mm: Rename new_vmalloc into new_valid_map_cpus
      riscv: mm: Extract helper mark_new_valid_map()
      riscv: kfence: Call mark_new_valid_map() for kfence_unprotect()

 arch/riscv/include/asm/cacheflush.h | 27 +++++++++++++----------
 arch/riscv/include/asm/kfence.h     |  7 ++++--
 arch/riscv/kernel/entry.S           | 44 +++++++++++++++++++------------------
 arch/riscv/mm/init.c                |  2 +-
 4 files changed, 44 insertions(+), 36 deletions(-)
---
base-commit: 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f
change-id: 20260228-handle-kfence-protect-spurious-fault-62100afb9734

Best regards,
-- 
Vivian "dramforever" Wang


