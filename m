Return-Path: <stable+bounces-203651-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 725FECE73A3
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 16:38:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E0D85300E7DC
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 15:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51B0326CE2B;
	Mon, 29 Dec 2025 15:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YXz7+seg"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9572124BBE4
	for <stable@vger.kernel.org>; Mon, 29 Dec 2025 15:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767022706; cv=none; b=VUBMB1iKYc7f1zkHebCM2i37dbQ/FF/UBItaRiDvSzmBYAIC55aqkB1urWE9BgBYd8H2Toh9fObcfeu8zGWbVz2z7owaFzEC4onbJz77pTScAc7MOohLv+Reip8/wxa3ffvZ3h6EvF1i1asQeLMO/eNCMTht/EKzoOqMu1o/8Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767022706; c=relaxed/simple;
	bh=Y6Ea4Z7dcYryMC4FzmOI5WW/TWDy28tX9/x+j04ymkw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=W2l1TQWbTqXGUwCbW2wXqfwaKo4UWfOqv7iYriD5Lranw2LdsseRRLiBmVG41Nxs8tP2rnkNfgrmXKuEvTUP5va+PWUPTG4bvNZZsHI5+Xoqg+gh2LFkgSnVkq+qVrC4ZFqK4fIv1FYuDCgUdNuKOYeoLFwhwaV+W3yuDYC5IZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YXz7+seg; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-430fcfe4494so9002034f8f.2
        for <stable@vger.kernel.org>; Mon, 29 Dec 2025 07:38:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767022702; x=1767627502; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jv1bfL8UVpkwL6HAaa3ZJfw2xxgzOOcpqTF8GDMtxH0=;
        b=YXz7+seguY+npplDN+AUcnxIYNPmkTmwJwfqrR/OR7hhSKEM0hjz0ZOPOZz1ZN84vf
         md9a5GnZFU5lx06YHhHPoei5t5UXzRskDCaP/T4hTc1Y6fB1FizvKoB8rfSRf2NIL5/y
         axwBcRr8fOVlJg3dwD7YcK8lEZlh8l9+OpBO2T4IO86kyOL90VpPax/m0HU0E0lQozFc
         0e5B2oIXBHINd1i7f+s2YC9uzRyt1aKuUnBgGnfJrS+I0SPcRBeCDYXdSnjOGWvVF6Zu
         umORnBjEMP/TCyP+LZADwKM7gdmkLmWHXLCHbBGI/ggrI77l6c3PQty3GeITjZ0AllUp
         ZX0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767022702; x=1767627502;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jv1bfL8UVpkwL6HAaa3ZJfw2xxgzOOcpqTF8GDMtxH0=;
        b=eGF7BRNjkN/N7122Z9SHoxoIuC2vobaYT1A4p6WUgC9O8jRZY/hxHPeRPJ3esWT47x
         Fj4R8DirTTe5c37Ih+96BiOYdlrqy8hk67UvzDI9YYTjs85FLxEqedpbniUnDFaNpgUk
         /C6YI8KCkz27cmwDY2Ft0wg1YQObFKgUguWLN1lGpAHjKcokA19CY+1BZg20l6//vfzM
         QtnvoxkG9Ucrdcsimx7Tr6kXHXeIm3BfKYkMdy7vpF9/Cd/VIBegq1y/wDc5EiIryGdU
         AvSXjrNlihfp8PbOmLxYUZEQAEayDMIV2zUK03Rftri+aD3lOYRHNRRSzZyxzKjS4jmn
         V8ow==
X-Forwarded-Encrypted: i=1; AJvYcCUgx3QM96hKtiwkN/A3ORRI04qcwaHvchIrY8r4fLy3qmk7vId80Zxi1ujs5CRoM4Q7XYlKz2s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUpbbwOhQNttqDLkCa92sWsV+aQos4AIFSvssoEU+QffduW0/8
	cYR4O5m+pRBZuVE/VRp5k1ZvVmQk4SCpd4jpzasyG7FsEQG1cE5+V1Yoy683uOegS35MzF/HZew
	mSG64JwO4nCuONfcTmQ==
X-Google-Smtp-Source: AGHT+IFxtD0GdZpJz0pNJUbAiSxNd2h4uts5rUN32W6Te6/i3nu/CNsM+WlL7lc3O57NG4BfPLHyiF6OP7LgfAM=
X-Received: from wrbgv10.prod.google.com ([2002:a05:6000:460a:b0:42f:8d68:be9c])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a5d:64e3:0:b0:430:fced:90a with SMTP id ffacd0b85a97d-4324e4cd1c4mr33849938f8f.16.1767022702052;
 Mon, 29 Dec 2025 07:38:22 -0800 (PST)
Date: Mon, 29 Dec 2025 15:38:14 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAGWgUmkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDIyNL3bSURN2q1KJ8XZNUE7NUU7OkVFOLFCWg8oKi1LTMCrBR0bG1tQC wRqEWWgAAAA==
X-Change-Id: 20251229-fda-zero-4e46e56be58d
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=7110; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=Y6Ea4Z7dcYryMC4FzmOI5WW/TWDy28tX9/x+j04ymkw=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBpUqBnxjnuT+VFuVlxhfLtXrABPQCbIpTVcAIOz
 T98k2Gz2AKJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaVKgZwAKCRAEWL7uWMY5
 Rm9VD/472WCNE+7sP7xX7AqIPS43qVHqs8yZO4o/RQ4X4sVivANeKmbMnQusZNpimGpX6KT+J1l
 0cLDR7EssaNrFgKPFmcBtrICXQxYi8kiiN8uNQ9DiaUWqm2SBpc5SsNjmR00MDTb8wCvaU27rQO
 ZHkmScZcuj6YftGRUeTERy0gZo8dhATpqkOTqk/yc2GpiacrHJZbXp5ChbG3OEkjk6zWFB8/11l
 P/Y1BtRJ9WayGHg/GYSo6nKhtf4e5i+0sTpQk9GOP4iWdRC0imlusmuuzIDJbek03vT8x6fuCte
 DBSioeqWLnx8jqeo29FGCyOTyrVNaNOCamdh4Z9er0UeJmiJQDjqlvwmMnZSv8579vADL+M13Hk
 GT8PIMByR9aJ30zgS2hXAmxdXxPZjLhjLD5ULEbojG34GmhG04C8HDktMSO8JCdHQGO2j8wnR0f
 lvVlFURNnwkS1SX67aPWojpgiDHap39MSE4fb8uvf29tXdXz4jlsqa2u76Aemm0XX1ruF1llnRE
 wahTtg8WXQgc+dv84F5rs7lN04qW0Vgxb1CDy+QAitxQ5NjCWoelJeVvz6ApQNC8tR3tifqOrfW
 NME7Xatx2FCmaxeJMkExtckyOP1LXlkEQSPAj0S+aqyoxKPlANkF8i9+JZkpWGWwconcoUvxJOu f1WmjQCkTk5u2Lw==
X-Mailer: b4 0.14.2
Message-ID: <20251229-fda-zero-v1-1-58a41cb0e7ec@google.com>
Subject: [PATCH] rust_binder: correctly handle FDA objects of length zero
From: Alice Ryhl <aliceryhl@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Carlos Llamas <cmllamas@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, stable@vger.kernel.org, 
	DeepChirp <DeepChirp@outlook.com>, Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"

Fix a bug where an empty FDA (fd array) object with 0 fds would cause an
out-of-bounds error. The previous implementation used `skip == 0` to
mean "this is a pointer fixup", but 0 is also the correct skip length
for an empty FDA. If the FDA is at the end of the buffer, then this
results in an attempt to write 8-bytes out of bounds. This is caught and
results in an EINVAL error being returned to userspace.

The pattern of using `skip == 0` as a special value originates from the
C-implementation of Binder. As part of fixing this bug, this pattern is
replaced with a Rust enum.

I considered the alternate option of not pushing a fixup when the length
is zero, but I think it's cleaner to just get rid of the zero-is-special
stuff.

The root cause of this bug was diagnosed by Gemini CLI on first try. I
used the following prompt:

> There appears to be a bug in @drivers/android/binder/thread.rs where
> the Fixups oob bug is triggered with 316 304 316 324. This implies
> that we somehow ended up with a fixup where buffer A has a pointer to
> buffer B, but the pointer is located at an index in buffer A that is
> out of bounds. Please investigate the code to find the bug. You may
> compare with @drivers/android/binder.c that implements this correctly.

Cc: stable@vger.kernel.org
Reported-by: DeepChirp <DeepChirp@outlook.com>
Closes: https://github.com/waydroid/waydroid/issues/2157
Fixes: eafedbc7c050 ("rust_binder: add Rust Binder driver")
Tested-by: DeepChirp <DeepChirp@outlook.com>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 drivers/android/binder/thread.rs | 59 +++++++++++++++++++++++-----------------
 1 file changed, 34 insertions(+), 25 deletions(-)

diff --git a/drivers/android/binder/thread.rs b/drivers/android/binder/thread.rs
index 1a8e6fdc0dc42369ee078e720aa02b2554fb7332..dcd47e10aeb8c748d04320fbbe15ad35201684b9 100644
--- a/drivers/android/binder/thread.rs
+++ b/drivers/android/binder/thread.rs
@@ -69,17 +69,24 @@ struct ScatterGatherEntry {
 }
 
 /// This entry specifies that a fixup should happen at `target_offset` of the
-/// buffer. If `skip` is nonzero, then the fixup is a `binder_fd_array_object`
-/// and is applied later. Otherwise if `skip` is zero, then the size of the
-/// fixup is `sizeof::<u64>()` and `pointer_value` is written to the buffer.
-struct PointerFixupEntry {
-    /// The number of bytes to skip, or zero for a `binder_buffer_object` fixup.
-    skip: usize,
-    /// The translated pointer to write when `skip` is zero.
-    pointer_value: u64,
-    /// The offset at which the value should be written. The offset is relative
-    /// to the original buffer.
-    target_offset: usize,
+/// buffer.
+enum PointerFixupEntry {
+    /// A fixup for a `binder_buffer_object`.
+    Fixup {
+        /// The translated pointer to write.
+        pointer_value: u64,
+        /// The offset at which the value should be written. The offset is relative
+        /// to the original buffer.
+        target_offset: usize,
+    },
+    /// A skip for a `binder_fd_array_object`.
+    Skip {
+        /// The number of bytes to skip.
+        skip: usize,
+        /// The offset at which the skip should happen. The offset is relative
+        /// to the original buffer.
+        target_offset: usize,
+    },
 }
 
 /// Return type of `apply_and_validate_fixup_in_parent`.
@@ -762,8 +769,7 @@ fn translate_object(
 
                     parent_entry.fixup_min_offset = info.new_min_offset;
                     parent_entry.pointer_fixups.push(
-                        PointerFixupEntry {
-                            skip: 0,
+                        PointerFixupEntry::Fixup {
                             pointer_value: buffer_ptr_in_user_space,
                             target_offset: info.target_offset,
                         },
@@ -807,9 +813,8 @@ fn translate_object(
                 parent_entry
                     .pointer_fixups
                     .push(
-                        PointerFixupEntry {
+                        PointerFixupEntry::Skip {
                             skip: fds_len,
-                            pointer_value: 0,
                             target_offset: info.target_offset,
                         },
                         GFP_KERNEL,
@@ -871,17 +876,21 @@ fn apply_sg(&self, alloc: &mut Allocation, sg_state: &mut ScatterGatherState) ->
             let mut reader =
                 UserSlice::new(UserPtr::from_addr(sg_entry.sender_uaddr), sg_entry.length).reader();
             for fixup in &mut sg_entry.pointer_fixups {
-                let fixup_len = if fixup.skip == 0 {
-                    size_of::<u64>()
-                } else {
-                    fixup.skip
+                let (fixup_len, fixup_offset) = match fixup {
+                    PointerFixupEntry::Fixup { target_offset, .. } => {
+                        (size_of::<u64>(), *target_offset)
+                    }
+                    PointerFixupEntry::Skip {
+                        skip,
+                        target_offset,
+                    } => (*skip, *target_offset),
                 };
 
-                let target_offset_end = fixup.target_offset.checked_add(fixup_len).ok_or(EINVAL)?;
-                if fixup.target_offset < end_of_previous_fixup || offset_end < target_offset_end {
+                let target_offset_end = fixup_offset.checked_add(fixup_len).ok_or(EINVAL)?;
+                if fixup_offset < end_of_previous_fixup || offset_end < target_offset_end {
                     pr_warn!(
                         "Fixups oob {} {} {} {}",
-                        fixup.target_offset,
+                        fixup_offset,
                         end_of_previous_fixup,
                         offset_end,
                         target_offset_end
@@ -890,13 +899,13 @@ fn apply_sg(&self, alloc: &mut Allocation, sg_state: &mut ScatterGatherState) ->
                 }
 
                 let copy_off = end_of_previous_fixup;
-                let copy_len = fixup.target_offset - end_of_previous_fixup;
+                let copy_len = fixup_offset - end_of_previous_fixup;
                 if let Err(err) = alloc.copy_into(&mut reader, copy_off, copy_len) {
                     pr_warn!("Failed copying into alloc: {:?}", err);
                     return Err(err.into());
                 }
-                if fixup.skip == 0 {
-                    let res = alloc.write::<u64>(fixup.target_offset, &fixup.pointer_value);
+                if let PointerFixupEntry::Fixup { pointer_value, .. } = fixup {
+                    let res = alloc.write::<u64>(fixup_offset, pointer_value);
                     if let Err(err) = res {
                         pr_warn!("Failed copying ptr into alloc: {:?}", err);
                         return Err(err.into());

---
base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
change-id: 20251229-fda-zero-4e46e56be58d

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>


