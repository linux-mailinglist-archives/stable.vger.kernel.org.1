Return-Path: <stable+bounces-28289-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 831E187D725
	for <lists+stable@lfdr.de>; Sat, 16 Mar 2024 00:06:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A77001C20FD7
	for <lists+stable@lfdr.de>; Fri, 15 Mar 2024 23:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC0A4524C3;
	Fri, 15 Mar 2024 23:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nx2xfPQs"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4B654747
	for <stable@vger.kernel.org>; Fri, 15 Mar 2024 23:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710543952; cv=none; b=cybrWPbNp/3FTZyB/WhCt2csi7vIls0oKFGZLkIFsdQas7xdw+jvhP100kUJVNwR/6PUJQulnYgywwnln/WgoIaz0Y5vaopNmOHpRwOw1ZOboPBsHJYVFJ0DhfT4gPrw8v4LbtOllpvFSYPspplXy1hfLbNvZDdFMYpuRmEVuUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710543952; c=relaxed/simple;
	bh=Cov+K61W3yOa0ObcP5pESyRYZi1gcNyUFK/aJ3wNmNA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PVU6VGvrXhBsqd7WZBKOTOcse36LtW2pdCnGlhydGqgLrrwePBAg/QPgw0Z6o18R7rXrIrPd5w7HoCE27+Za8Ialti0xaACjAyFYrKXBHs+pMauxEvvMwFB0LtVon+VRtwdp8qeRxc3ou+l3QtdhQHJoY0G22w7NaBCbRJ6bocY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nx2xfPQs; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dd169dd4183so3253610276.3
        for <stable@vger.kernel.org>; Fri, 15 Mar 2024 16:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710543947; x=1711148747; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Jq6dTiQO4a7GzTIlCZ/7Sr+NoQ1v4+WQzk26lh1YhWg=;
        b=nx2xfPQsmrlIMvymOTajI1vWZCq3JXkc3DqiDKzlAVi1Boe7XR5uZRuO8NyXiFMz0a
         KUBiattLFvFkbUF8Q53ZVNTJ1x2Gbk8EdFPh072SlxwvUd+hcgOHhfpjXKdkbqckEhu/
         Uo6yqc3hMx6i6ed6+08daFtEobEdnkoXExMwExvjzIh1lbuvr7MWyLJRXKIkR3/RN1a4
         0fQxGqxx1gyPego0cypJil5xXHC22AFRnTaX+scyc0z8FtZ1lRa68wV2Zf8spscYqP8c
         UhAksR1hFFzrfFUyZd9dYIPwENlWDSeamzOZlWvqcLkE4sNCn7xtA63Ry4Yw1IA6JGj3
         ARzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710543947; x=1711148747;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jq6dTiQO4a7GzTIlCZ/7Sr+NoQ1v4+WQzk26lh1YhWg=;
        b=ifuh+Qi/xlXyIMYXKuDSo8oXQ4stJX+Qpr9HjOzpCKN28DkK9R5xBqcuq77r6SZ35A
         /ovEyaUUBxbWaSNiNfO9RMs3/+Z6K1Rex/7CxBDaC8XmFuvvWS9NqHYQDOEhzGxJpWHF
         ZhP5MgiTPSy5xUMNCt2Kvfo6pRhGXrZ9YO4BsgxUbB01yLnH7EHRH5NZJMOxjCFysuFv
         vA0C1brOnYN8h5r7/XB4KzQT+VjEL/AziJycrL97o86B3DaGIwtVSK6I6aS5xSW8hS35
         xpRtcJffcym1VZN436pogcs4KWeqpjnmALxNeNywqO2TV1x+xno/9gOJqJ+HAkzAurm/
         Zfaw==
X-Forwarded-Encrypted: i=1; AJvYcCXDKC+a60B8dKpT5+OQ6SpBjpnNmV8YBvErkG6+IPy748HVFTk/qmR37TNSkOFUn7VttJa+b3Gnz18BkbmnyDkJouKaYMFI
X-Gm-Message-State: AOJu0YyXczOPSyWzNOBQhnwXQno7mP/vWzr9s24AqeikBHF9wrVdm0KU
	3FQ3T29twUdt73NSsW3lJIRAMVDaT1igTG6ujlsQURHW/Hw86gDwfk5DVVH6YTb9Rr4a139BcEo
	plq3QozLqNw==
X-Google-Smtp-Source: AGHT+IFwIWtAdHF9qqf2R5hkb2fp5Hri3uJzjkEaEVE9KnILaqL8bJMQ8Iv75zE4rNjwop2zjTqbg6D2eL2TPg==
X-Received: from dmatlack-n2d-128.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:1309])
 (user=dmatlack job=sendgmr) by 2002:a05:6902:2301:b0:dc7:865b:22c6 with SMTP
 id do1-20020a056902230100b00dc7865b22c6mr338437ybb.8.1710543947439; Fri, 15
 Mar 2024 16:05:47 -0700 (PDT)
Date: Fri, 15 Mar 2024 16:05:38 -0700
In-Reply-To: <20240315230541.1635322-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240315230541.1635322-1-dmatlack@google.com>
X-Mailer: git-send-email 2.44.0.291.gc1ea87d7ee-goog
Message-ID: <20240315230541.1635322-2-dmatlack@google.com>
Subject: [PATCH 1/4] KVM: x86/mmu: Check kvm_mmu_page_ad_need_write_protect()
 when clearing TDP MMU dirty bits
From: David Matlack <dmatlack@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>
Cc: Vipin Sharma <vipinsh@google.com>, kvm@vger.kernel.org, 
	David Matlack <dmatlack@google.com>, syzbot+900d58a45dcaab9e4821@syzkaller.appspotmail.com, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Check kvm_mmu_page_ad_need_write_protect() when deciding whether to
write-protect or clear D-bits on TDP MMU SPTEs.

TDP MMU SPTEs must be write-protected when the TDP MMU is being used to
run an L2 (i.e. L1 has disabled EPT) and PML is enabled. KVM always
disables the PML hardware when running L2, so failing to write-protect
TDP MMU SPTEs will cause writes made by L2 to not be reflected in the
dirty log.

Reported-by: syzbot+900d58a45dcaab9e4821@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=900d58a45dcaab9e4821
Fixes: 5982a5392663 ("KVM: x86/mmu: Use kvm_ad_enabled() to determine if TDP MMU SPTEs need wrprot")
Cc: stable@vger.kernel.org
Cc: Vipin Sharma <vipinsh@google.com>
Cc: Sean Christopherson <seanjc@google.com>
Signed-off-by: David Matlack <dmatlack@google.com>
---
 arch/x86/kvm/mmu/tdp_mmu.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index 6ae19b4ee5b1..c3c1a8f430ef 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -1498,6 +1498,16 @@ void kvm_tdp_mmu_try_split_huge_pages(struct kvm *kvm,
 	}
 }
 
+static bool tdp_mmu_need_write_protect(struct kvm_mmu_page *sp)
+{
+	/*
+	 * All TDP MMU shadow pages share the same role as their root, aside
+	 * from level, so it is valid to key off any shadow page to determine if
+	 * write protection is needed for an entire tree.
+	 */
+	return kvm_mmu_page_ad_need_write_protect(sp) || !kvm_ad_enabled();
+}
+
 /*
  * Clear the dirty status of all the SPTEs mapping GFNs in the memslot. If
  * AD bits are enabled, this will involve clearing the dirty bit on each SPTE.
@@ -1508,7 +1518,8 @@ void kvm_tdp_mmu_try_split_huge_pages(struct kvm *kvm,
 static bool clear_dirty_gfn_range(struct kvm *kvm, struct kvm_mmu_page *root,
 			   gfn_t start, gfn_t end)
 {
-	u64 dbit = kvm_ad_enabled() ? shadow_dirty_mask : PT_WRITABLE_MASK;
+	const u64 dbit = tdp_mmu_need_write_protect(root)
+		? PT_WRITABLE_MASK : shadow_dirty_mask;
 	struct tdp_iter iter;
 	bool spte_set = false;
 
@@ -1523,7 +1534,7 @@ static bool clear_dirty_gfn_range(struct kvm *kvm, struct kvm_mmu_page *root,
 		if (tdp_mmu_iter_cond_resched(kvm, &iter, false, true))
 			continue;
 
-		KVM_MMU_WARN_ON(kvm_ad_enabled() &&
+		KVM_MMU_WARN_ON(dbit == shadow_dirty_mask &&
 				spte_ad_need_write_protect(iter.old_spte));
 
 		if (!(iter.old_spte & dbit))
@@ -1570,8 +1581,8 @@ bool kvm_tdp_mmu_clear_dirty_slot(struct kvm *kvm,
 static void clear_dirty_pt_masked(struct kvm *kvm, struct kvm_mmu_page *root,
 				  gfn_t gfn, unsigned long mask, bool wrprot)
 {
-	u64 dbit = (wrprot || !kvm_ad_enabled()) ? PT_WRITABLE_MASK :
-						   shadow_dirty_mask;
+	const u64 dbit = (wrprot || tdp_mmu_need_write_protect(root))
+		? PT_WRITABLE_MASK : shadow_dirty_mask;
 	struct tdp_iter iter;
 
 	lockdep_assert_held_write(&kvm->mmu_lock);
@@ -1583,7 +1594,7 @@ static void clear_dirty_pt_masked(struct kvm *kvm, struct kvm_mmu_page *root,
 		if (!mask)
 			break;
 
-		KVM_MMU_WARN_ON(kvm_ad_enabled() &&
+		KVM_MMU_WARN_ON(dbit == shadow_dirty_mask &&
 				spte_ad_need_write_protect(iter.old_spte));
 
 		if (iter.level > PG_LEVEL_4K ||
-- 
2.44.0.291.gc1ea87d7ee-goog


