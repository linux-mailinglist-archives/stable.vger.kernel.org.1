Return-Path: <stable+bounces-217266-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +I7FDXGolWlVTAIAu9opvQ
	(envelope-from <stable+bounces-217266-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Feb 2026 12:54:25 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C4777156228
	for <lists+stable@lfdr.de>; Wed, 18 Feb 2026 12:54:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 987E1305D286
	for <lists+stable@lfdr.de>; Wed, 18 Feb 2026 11:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C8B330FF10;
	Wed, 18 Feb 2026 11:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ct3kMbTi"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D54A30AD06
	for <stable@vger.kernel.org>; Wed, 18 Feb 2026 11:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771415628; cv=none; b=YMNohdAbTutT1zfAS8xy+gOc3UlJpgakOatm9lBFh3KacLsFF5gsPckTx1p1zC8kPMRvPwwIE2vWA37WQVOVro/Gp9eD08CYK9wINwzs1TfNayP4hz40xXeiI8kRCjYz8AxdGaS46di9wTIyStC2M0mvg9f9XjrMaDkgXE/3ll8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771415628; c=relaxed/simple;
	bh=AHwJyjos7iEyMW0S0TgaVF/r84EvhJvZEX/erTcBJg4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PDdmo1mDxkIqUaoQDszEFNZ9Qsj5/GxtsJNfvBJsp0OSbCILRQUzBSMe2+iURlVk9S9eSIfZF/THv5kzgznygnysCrRf7Z4C+vXCnPT9bx3zuHqxxjDKF/bPsnNd9IrPKQAnr+vl37mIyoud3q+70rlGmgtu6yUP9Cfl1MFOHUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ct3kMbTi; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-65c13e2123dso3100180a12.1
        for <stable@vger.kernel.org>; Wed, 18 Feb 2026 03:53:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771415625; x=1772020425; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=POlj+5b3FeGUDIy0t6zTY3NKGZo0gnMVI1S8/pn9WM8=;
        b=ct3kMbTi9MD/YsExWkAzl/clTjC046hfE62W90o+4h2HnnwOGCK/8go29wU3gaY8gf
         ymJ5ZegNP/GAHHQytgrE7AT6RFTOWhsyyCoAFPfzm7tFC7gkrIVP4hMwByk5jMtMTS/d
         rb/zgIosVVz17Xuz/n8vjtNA/y+qmqativIReA6aEj6kr/LjWbLBnGt7XnNzFe+RAtXB
         uhZK+SCtaSUobqDBBsrwf4/lkp26WkoMcTGRsjnFhMfJ27nFji4oODhSgEyxF7ve18/O
         QDCleTxDAsxesTToRCxRy76i3aKDqyuwPp9Rilcabs8TvawvtggduGDMCOdHV1K7Ndku
         Jc2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771415625; x=1772020425;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=POlj+5b3FeGUDIy0t6zTY3NKGZo0gnMVI1S8/pn9WM8=;
        b=Qg5xp4LXmYbdIwz9R2GQqsXiLlEbX8tFWuSKG+p8yQw4wV1ohjHfif5WAcm/H2RblZ
         i5Gi5cUZq3TsdZ6YrxfeDCe0PalxEMpU53ytbFll35lFQPqUp0G7h8UKoPThnM2lpG62
         fup8SQawGfx4inQFSwBfVcso+bhEgtn+yNUnm1sg1ngwlO4zUl6hHmV6seVl3uKXcopv
         DhcYmXQKqVSM9yT/GJDLkZ5M3tuxkAxvD7XxqVYZPQ0o6ogE0RruUq4Zt8j005fsbfQM
         wlA3Fy2CYaZNEuCLfw5koOaOBLwu1OdC2DAC0uzXpxE6nqBxV72n3L4I+t/8zMNlsmhH
         3Hcg==
X-Forwarded-Encrypted: i=1; AJvYcCW1DmjwLmQXWEO9CK09cpWjAzAgTIDPuUcHSwPh4pZ5wU3ZLAs3Qt+z0UBlR3nBoaR88ceomMs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yws+jK0kGStM5lXLRduFjkjDYNeRKRMXAUOtMrckOQyLHLvQveG
	zbFf+C1fY8h1Ybgmoqvf/xqtA2rOI3ViVckMAljXVppJJqFWQUK45DdedllmjQVxJE+HJ9kW07Z
	iZ86jiwI9OEEQ3wTo7g==
X-Received: from edsl24.prod.google.com ([2002:aa7:d958:0:b0:63c:6537:43ec])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:1470:b0:65c:63f0:a92 with SMTP id 4fb4d7f45d1cf-65c63f00e8bmr2549835a12.23.1771415624762;
 Wed, 18 Feb 2026 03:53:44 -0800 (PST)
Date: Wed, 18 Feb 2026 11:53:26 +0000
In-Reply-To: <20260218-binder-vma-check-v2-0-60f9d695a990@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260218-binder-vma-check-v2-0-60f9d695a990@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=7238; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=AHwJyjos7iEyMW0S0TgaVF/r84EvhJvZEX/erTcBJg4=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBplahFgui5qXvwywJz5fy38GnQcd/vmShYSKX2R
 yDlD1BgEXaJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaZWoRQAKCRAEWL7uWMY5
 RkFCD/0cX5qG36V764Q3IeYDdRES05yduGLy7SvLEGQd4l/JdSZoLzFgO6SSAR5zFlF8ZOMRdc2
 4rPFkme+mMC6uClTNzue0xVeSm9cTFaZJgIWzbDN3I9AgnTqurQQE0UQXwlAc37fTjdzkbDahX2
 RB+p1PFmbZOYbuscdcuc+37de7FBlCxdZWjQu9Am2bUWbQ71W6HPWj4uPHAPuXrXVo2z4s0GE7n
 7RdmBazBHK37jQRMUJwG9xtJjLI9GdhZ2LWy271qayls0aW9lZ9waRqh4ATzgqBJlNf0IXS5bnu
 uiWurWiMzaeaDWp+f9P8wsdGKMZmt30ReZcD9EYD9pc2bxbi8ooIO3YKMVgavTwYaJQhQZaFiMI
 fsSIqu3WtFBW7a2fNzFyA0M5c7NfXMuI76Nh/Prj29sgyEV6xX+rFWTUzFfdLyqIWjFJp7fa4s4
 LXz1MqduYOEexBAUjviuPo+W6cuOyf6DDqRkO7zg5ktcWKlgK3yUW1ALLBM0tWDTPTjTcuqqxWY
 S7Kj4DUpja9OAzmTdYdwY49wYMgogqLg5XAxCE37XMmkqvXd0vU1m2/6M5mIZHUQ9/0d2OB0hKb
 /sOH45UxQ1+blp3ajGC2hJb7/VGFzTadtC9cAt70WDoIM4dQh2syJDESamrt7CMTceNn5HRpYka nedUIkmOKe2rrkA==
X-Mailer: b4 0.14.2
Message-ID: <20260218-binder-vma-check-v2-1-60f9d695a990@google.com>
Subject: [PATCH v2 1/2] rust_binder: check ownership before using vma
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-217266-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C4777156228
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

To fix this, store a pointer in vm_private_data and check that the vma
returned by vma_lookup() has the right vm_ops and vm_private_data before
trying to use the vma. This should ensure that Rust Binder will refuse
to interact with any other VMA. The plan is to introduce more vma
abstractions to avoid this unsafe access to vm_ops and vm_private_data,
but for now let's start with the simplest possible fix.

C Binder performs the same check in a slightly different way: it
provides a vm_ops->close that sets a boolean to true, then checks that
boolean after calling vma_lookup(), but this is more fragile
than the solution in this patch. (We probably still want to do both, but
the vm_ops->close callback will be added later as part of the follow-up
vma API changes.)

It's still possible to remap the vma so that pages appear in the right
vma, but at the wrong offset, but this is a separate issue and will be
fixed when Rust Binder gets a vm_ops->close callback.

Cc: stable@vger.kernel.org
Fixes: eafedbc7c050 ("rust_binder: add Rust Binder driver")
Reported-by: Jann Horn <jannh@google.com>
Reviewed-by: Jann Horn <jannh@google.com>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 drivers/android/binder/page_range.rs | 83 +++++++++++++++++++++++++++---------
 1 file changed, 63 insertions(+), 20 deletions(-)

diff --git a/drivers/android/binder/page_range.rs b/drivers/android/binder/page_range.rs
index fdd97112ef5c8b2341e498dc3567b659f05e3fd7..67aae783e8b8b7cf60ecf7e711d5f6f6f5d1dbe3 100644
--- a/drivers/android/binder/page_range.rs
+++ b/drivers/android/binder/page_range.rs
@@ -142,6 +142,30 @@ pub(crate) struct ShrinkablePageRange {
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
+    // The ShrinkablePageRange is only dropped when the Process is dropped, which only happens once
+    // the file's ->release handler is invoked, which means the ShrinkablePageRange outlives any
+    // VMA associated with it, so there can't be any false positives due to pointer reuse here.
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
@@ -308,6 +332,18 @@ pub(crate) fn register_with_vma(&self, vma: &virt::VmaNew) -> Result<usize> {
         inner.size = num_pages;
         inner.vma_addr = vma.start();
 
+        // This pointer is only used for comparison - it's not dereferenced.
+        //
+        // SAFETY: We own the vma, and we don't use any methods on VmaNew that rely on
+        // `vm_private_data`.
+        unsafe {
+            (*vma.as_ptr()).vm_private_data = ptr::from_ref(self).cast_mut().cast::<c_void>()
+        };
+
+        // SAFETY: We own the vma, and we don't use any methods on VmaNew that rely on
+        // `vm_ops`.
+        unsafe { (*vma.as_ptr()).vm_ops = &BINDER_VM_OPS };
+
         Ok(num_pages)
     }
 
@@ -399,22 +435,24 @@ unsafe fn use_page_slow(&self, i: usize) -> Result<()> {
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
 
@@ -667,12 +705,15 @@ fn drop(self: Pin<&mut Self>) {
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
@@ -717,9 +758,11 @@ fn drop(self: Pin<&mut Self>) {
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
2.53.0.310.g728cabbaf7-goog


