Return-Path: <stable+bounces-216839-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4JgABOx5lGkfFAIAu9opvQ
	(envelope-from <stable+bounces-216839-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 15:23:40 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 677B614D1D3
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 15:23:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 79806303C014
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 14:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECBDF36C0DC;
	Tue, 17 Feb 2026 14:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uBDOIn76"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1F436BCF6
	for <stable@vger.kernel.org>; Tue, 17 Feb 2026 14:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771338175; cv=none; b=KQvTGVmUW7rylT4rbXa4REYyw71YMZhdRrtmaZKBvnRTcv6ZThRF82WIVNpJ+6nhlYBSMo9QwMFUU09/m+jD0V89kdHvOXAc+tNU0sKcsLi1/Wi6IOkQVYqU1ZrkMKR/UV0wEtepHnFDlW6e5sW5XPJ1GuPJMVKPN6Hnp8J2ffQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771338175; c=relaxed/simple;
	bh=nQm0AngjwMT2UjJFuUZvKHEzTseqZByPMN8Hgm6xrz0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bWAZFa9XLF2V3xi7aNdpqyuGNGbeUDlukoL90Pw7abvE6HwfjQjZZ/JIHA4dNtJl8uonudd4QTerIUTGaIKCyiXZpd6FgVsJ5oea0brQsScxqnLkgEje5Q33wTkhhbW39D6/vmG2dbGeHjIf6sffHArKJ9rsAMe+GNYcngsXfRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uBDOIn76; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-482d8e6e13aso29807855e9.3
        for <stable@vger.kernel.org>; Tue, 17 Feb 2026 06:22:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771338173; x=1771942973; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=82Js1rcnoAKTgbxsBEWU8ya5WrRt0JL+YHVGM9jGo+A=;
        b=uBDOIn76Lyf0G3yEJiZ0b4XjGmDMsmSt5t1tVwzGE5NZfRpMs24Bo3XIpHKmzQLUC9
         +JaaS/mFsBuUjd4C+9ZaDeJ4/zLvJeqT/1Gwz4KIia0xYwdliOHmGaW22onOMRtx/TNg
         AbKB48rqQf9LDlSwoMSssOKsyzMZVXHKcXV5UnYY1SujCKD5WLN1c5Wmc3vIy/SravIi
         cTBivMqxt7qH8EFTBP98maw3RIFfr4Q3mJzVXt4gi+/c/g9uh/ftvfL59tNhdRmRl0j9
         NPoOAZIl67b3RGDj5njkNaUUlcQnvzk3BnMwkcE/7CPCkf3i7Bbn48UrGFwFX2jtm1IG
         iD5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771338173; x=1771942973;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=82Js1rcnoAKTgbxsBEWU8ya5WrRt0JL+YHVGM9jGo+A=;
        b=XGopOSEw7vH23NywV3XgLL8l24tJ2DN5Y9G42cnXlrlQN1KHR+VpnpHtGGSFE2ldBc
         FsNUBhUyd4F7j6B2lLW6QCwN2ANfZpF3n8vZ3cqkVduP3i5RiTJyH2/Tl1F9evEspn1v
         4QKFeqCpaEvftiv3P+x1baJU/aok1UrztWJf8g886SFep1+XPYv7PI1aKY9/HOZilw03
         rpNQ+HLGunsknMH1OXGfuLFxp8mWUAgkLt7ePrbCFRmpUrF2ufrewzv0fAaR5u/rylOW
         7UZhunytjXxKCAmMCZZgXvvNle6dOV0ljM0AjKB7fctgVkcQ87xWXqcknNnj7Zth/Wup
         MoVg==
X-Forwarded-Encrypted: i=1; AJvYcCXlt9go3Q35zeS0O+SQCXPVgL+Lsj5bRlQQrmwdZ7SPmJuPUQJXcSuPkhusgPHKPU5+rxoJVO4=@vger.kernel.org
X-Gm-Message-State: AOJu0YypaFsjBE5AOlXlVqTr1c2B6xjXNF6/L9Kx9iX3DBxXSAG8VuxS
	GjOPyl2aQxsihJTL2YGrRvT83eXGLSfojXkOAF4p5BsXii1vzDI4CK5HZYEyY8OwDkotwdTMc00
	40OuTJnix2YtFKrdvGg==
X-Received: from wmpz8.prod.google.com ([2002:a05:600c:a08:b0:483:248b:3e95])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:6096:b0:483:612d:7a9a with SMTP id 5b1f17b1804b1-483737b89a4mr196316545e9.0.1771338172603;
 Tue, 17 Feb 2026 06:22:52 -0800 (PST)
Date: Tue, 17 Feb 2026 14:22:38 +0000
In-Reply-To: <20260217-binder-vma-check-v1-0-1a2b37f7b762@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260217-binder-vma-check-v1-0-1a2b37f7b762@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=6670; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=nQm0AngjwMT2UjJFuUZvKHEzTseqZByPMN8Hgm6xrz0=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBplHm5X0xpCMTJgViI69+ZHnDddFhIjmNIbX3+H
 22nzhl4nK+JAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaZR5uQAKCRAEWL7uWMY5
 RvfVEACevIXSL/nDzA5yoF/95U0BuALOFRvt2mjZyyKCqmRHKG9aBPN8m+1nL/RiNvc5mBC/Zwk
 Zey/Sl5m6/sD4ByVyYcIK3WFhrQ4qJ56vGXB6kTaEDjvJcrC97c2IQz2CaQoFXaafhth3ZPUhWC
 kRbmr1DB/5f/owITX8pEibPhT9k0seZ5ehsQOhleqwoX2d49V8q5LisgL6pzxJVAgItj53wcUJa
 jEk8+qm9TXYV7lHzkrpUE1PfjjCfTatfBHtupQMxsje6oxHcwnxWG7M4C3YbMAQC28s+j5nepA8
 HIkErf5ecF2gZ2W20F0um9mOe4jlhoOrWn2EmvoV9SfR0xU+7wdq9D61ZpaZN5lPtkaSZXmc0rQ
 ifxWJLTPlfL9eETm8SnFGqZf5OAJN+OX/KXsvbOIImLEJk6PlUwgu5p6RoN9LtfPnMZFwKw77Y/
 ZacwJnRlncRWqto1hLWU+D92I/Klj1QdyQfRI6YPAlnF02qMf/oSIFMA4kJSvuQJvYGpKoRDgIx
 oUFK2uhuuCY5lMhrOK0EuQrHjtSOKOcrS2swG1FsaWVPRzaGEMhn1OdU2+D/jJEBqo0JDW324tb
 1ypvZ/ou6BQrVGMUsgzjHiPjbe65SCrn9sn74AUW458o3QesKzrTDY7ftjtdZdnx5OW+b0Cfx3e R1fE2AJ/jGgNmcw==
X-Mailer: b4 0.14.2
Message-ID: <20260217-binder-vma-check-v1-1-1a2b37f7b762@google.com>
Subject: [PATCH 1/2] rust_binder: check ownership before using vma
From: Alice Ryhl <aliceryhl@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Carlos Llamas <cmllamas@google.com>, 
	Jann Horn <jannh@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-mm@kvack.org, 
	Alice Ryhl <aliceryhl@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-216839-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[18];
	FREEMAIL_CC(0.00)[kernel.org,garyguo.net,protonmail.com,umich.edu,oracle.com,vger.kernel.org,kvack.org,google.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aliceryhl@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 677B614D1D3
X-Rspamd-Action: no action

When installing missing pages (or zapping them), Rust Binder will look
up the vma in the mm by address, and then call vm_insert_page (or
zap_page_range_single). However, if the vma is closed and replaced with
a different vma at the same address, this can lead to Rust Binder
installing pages into the wrong vma.

By installing the page into a writable vma, it becomes possible to write
to your own binder pages, which are normally read-only. Although you're
not supposed to be able to write to those pages, the intent behind the
design of Rust Binder is that even if you get that ability, it should not
lead to anything bad. Unfortunately, due to another bug, that is not the
case.

To fix this, I will store a pointer in vm_private_data and check that
the vma returned by vma_lookup() has the right vm_ops and
vm_private_data before trying to use the vma. This should ensure that
Rust Binder will refuse to interact with any other VMA. I will follow up
this patch with more vma abstractions to avoid this unsafe access to
vm_ops and vm_private_data, but for now I'd like to start with the
simplest possible fix.

C Binder performs the same check in a slightly different way: it
provides a vm_ops->close that sets a boolean to true, then checks that
boolean after calling vma_lookup(), but I think this is more fragile
than the solution in this patch. (We probably still want to do both, but
I'll add the vm_ops->close callback with the follow-up vma API changes.)

Cc: stable@vger.kernel.org
Fixes: eafedbc7c050 ("rust_binder: add Rust Binder driver")
Reported-by: Jann Horn <jannh@google.com>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 drivers/android/binder/page_range.rs | 78 +++++++++++++++++++++++++++---------
 1 file changed, 58 insertions(+), 20 deletions(-)

diff --git a/drivers/android/binder/page_range.rs b/drivers/android/binder/page_range.rs
index fdd97112ef5c8b2341e498dc3567b659f05e3fd7..90bab18961443c6e59699cb7345e41e0db80f0dd 100644
--- a/drivers/android/binder/page_range.rs
+++ b/drivers/android/binder/page_range.rs
@@ -142,6 +142,27 @@ pub(crate) struct ShrinkablePageRange {
     _pin: PhantomPinned,
 }
 
+// We do not define any ops. For now, used only to check identity of vmas.
+static BINDER_VM_OPS: bindings::vm_operations_struct = pin_init::zeroed();
+
+// To ensure that we do not accidentally install pages into or zap pages from the wrong vma, we
+// check its vm_ops and private data before using it.
+fn check_vma(vma: &virt::VmaRef, owner: *const ShrinkablePageRange) -> Option<&virt::VmaMixedMap> {
+    // SAFETY: Just reading the vm_ops pointer of any active vma is safe.
+    let vm_ops = unsafe { (*vma.as_ptr()).vm_ops };
+    if !ptr::eq(vm_ops, &BINDER_VM_OPS) {
+        return None;
+    }
+
+    // SAFETY: Reading the vm_private_data pointer of a binder-owned vma is safe.
+    let vm_private_data = unsafe { (*vma.as_ptr()).vm_private_data };
+    if !ptr::eq(vm_private_data, owner.cast()) {
+        return None;
+    }
+
+    vma.as_mixedmap_vma()
+}
+
 struct Inner {
     /// Array of pages.
     ///
@@ -308,6 +329,16 @@ pub(crate) fn register_with_vma(&self, vma: &virt::VmaNew) -> Result<usize> {
         inner.size = num_pages;
         inner.vma_addr = vma.start();
 
+        // This pointer is only used for comparison - it's not dereferenced.
+        //
+        // SAFETY: We own the vma, and we don't use any methods on VmaNew that rely on
+        // `vm_private_data`.
+        unsafe { (*vma.as_ptr()).vm_private_data = self as *const Self as *mut c_void };
+
+        // SAFETY: We own the vma, and we don't use any methods on VmaNew that rely on
+        // `vm_ops`.
+        unsafe { (*vma.as_ptr()).vm_ops = &BINDER_VM_OPS };
+
         Ok(num_pages)
     }
 
@@ -399,22 +430,24 @@ unsafe fn use_page_slow(&self, i: usize) -> Result<()> {
         //
         // Using `mmput_async` avoids this, because then the `mm` cleanup is instead queued to a
         // workqueue.
-        MmWithUser::into_mmput_async(self.mm.mmget_not_zero().ok_or(ESRCH)?)
-            .mmap_read_lock()
-            .vma_lookup(vma_addr)
-            .ok_or(ESRCH)?
-            .as_mixedmap_vma()
-            .ok_or(ESRCH)?
-            .vm_insert_page(user_page_addr, &new_page)
-            .inspect_err(|err| {
-                pr_warn!(
-                    "Failed to vm_insert_page({}): vma_addr:{} i:{} err:{:?}",
-                    user_page_addr,
-                    vma_addr,
-                    i,
-                    err
-                )
-            })?;
+        check_vma(
+            MmWithUser::into_mmput_async(self.mm.mmget_not_zero().ok_or(ESRCH)?)
+                .mmap_read_lock()
+                .vma_lookup(vma_addr)
+                .ok_or(ESRCH)?,
+            self,
+        )
+        .ok_or(ESRCH)?
+        .vm_insert_page(user_page_addr, &new_page)
+        .inspect_err(|err| {
+            pr_warn!(
+                "Failed to vm_insert_page({}): vma_addr:{} i:{} err:{:?}",
+                user_page_addr,
+                vma_addr,
+                i,
+                err
+            )
+        })?;
 
         let inner = self.lock.lock();
 
@@ -667,12 +700,15 @@ fn drop(self: Pin<&mut Self>) {
     let mmap_read;
     let mm_mutex;
     let vma_addr;
+    let range_ptr;
 
     {
         // CAST: The `list_head` field is first in `PageInfo`.
         let info = item as *mut PageInfo;
         // SAFETY: The `range` field of `PageInfo` is immutable.
-        let range = unsafe { &*((*info).range) };
+        range_ptr = unsafe { (*info).range };
+        // SAFETY: The `range` outlives its `PageInfo` values.
+        let range = unsafe { &*range_ptr };
 
         mm = match range.mm.mmget_not_zero() {
             Some(mm) => MmWithUser::into_mmput_async(mm),
@@ -717,9 +753,11 @@ fn drop(self: Pin<&mut Self>) {
     // SAFETY: The lru lock is locked when this method is called.
     unsafe { bindings::spin_unlock(&raw mut (*lru).lock) };
 
-    if let Some(vma) = mmap_read.vma_lookup(vma_addr) {
-        let user_page_addr = vma_addr + (page_index << PAGE_SHIFT);
-        vma.zap_page_range_single(user_page_addr, PAGE_SIZE);
+    if let Some(unchecked_vma) = mmap_read.vma_lookup(vma_addr) {
+        if let Some(vma) = check_vma(unchecked_vma, range_ptr) {
+            let user_page_addr = vma_addr + (page_index << PAGE_SHIFT);
+            vma.zap_page_range_single(user_page_addr, PAGE_SIZE);
+        }
     }
 
     drop(mmap_read);

-- 
2.53.0.273.g2a3d683680-goog


