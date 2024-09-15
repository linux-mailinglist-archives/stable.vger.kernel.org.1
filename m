Return-Path: <stable+bounces-76160-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75B1C979741
	for <lists+stable@lfdr.de>; Sun, 15 Sep 2024 16:41:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E16C281662
	for <lists+stable@lfdr.de>; Sun, 15 Sep 2024 14:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76CCC1C6F78;
	Sun, 15 Sep 2024 14:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G1LNfT3s"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4311C6F66
	for <stable@vger.kernel.org>; Sun, 15 Sep 2024 14:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726411296; cv=none; b=QMvdVAt3LPrfRaYhGSv0x51l7FcqOiHGoCCSiECyzqynY+xWWmQ8O4QNBUWmzmJ2+ZGHiXBPMVRZ6aMsM3wUd4ZJ1nfft4seCFNJPUsDmE2kKb/98Xf+pRW4ZMF4ali1IRPXoAXo2UQ16lvqOi26Z08mbpFNdA/M+cTIz7sOBEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726411296; c=relaxed/simple;
	bh=3WcMNrZ0tsoHg+qzEqC8I515GwoTWxUcB94qskQiDls=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=GMiPHV1PSMisS05TXeoVm5Ps1+MVwahOHdWqExPmVK9AGHPRUvSQAilWGcqMlzkYbwlmRfHnO7lcgL8yf85uiSrg29jDOwhAI+Sw7qXUXBRCyk8PC+G5ZAHHZCS2O0y9off3grz+YJVyXsEmvk/7pxw+ETYvxB2bupyHgYDtkGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G1LNfT3s; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-42cb374f0cdso18406335e9.0
        for <stable@vger.kernel.org>; Sun, 15 Sep 2024 07:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726411292; x=1727016092; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=r/O8x7VJ554ueyy+hbUwWFKRcP1g4JZ3yxvjNVEBW2I=;
        b=G1LNfT3sAgPIOlM2/fU7DbTQqtREmOtCy0ybMdHFkNU9T+nPcwsBQbJklxNYD9TvtD
         GMiq09+qdmyzG7/m1Lk31C1fHmrBQomVKTe9TFkfAyvQBFsxKm2erkTHg/nwvspY5L5B
         ikD1/SZISKmWGQFAbUwRCQjjmrNRsRfCWppAph+kBSXoHLChPwJ8/Ub6E3XS6w78CptB
         OUq2/jYJRZbpYMhOt7+RIXEm6iuPgYOrda06OIPkCs8063FaLJdTXN9YAlG1LoUvbrTX
         3SEq5Hv4RU/Unrp3s/HRMaDTAnQxB8qDZAruM8EV/Xj6nGEwLCtDfdPnQxiPVQRlhxmT
         M2hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726411292; x=1727016092;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r/O8x7VJ554ueyy+hbUwWFKRcP1g4JZ3yxvjNVEBW2I=;
        b=Vp3bTwIhuaf+IZPbWvaw7r8Y5lLjrib+ExkuynTkTyqsOstdKp8CTi8JQciucdM8mR
         y5a3WVoKiGXUBFGpv+UC9YnGvGfxILMnZAwdRIsIzqbQUAntAa1zrtVGsfg4IGqfxfLS
         4Sr9WQ1GYuiaMBC8No+lCMEQ9q+PyyOTczdvTlwFdhNa7ugyibo7XjWlr3qoQ1CoTMmk
         tvNN5nDNcttu7bu4RsEUfltgQ2MjKEWNFlUrelUQueSIh0COFojEM87Z+J7Yt0CjfTnJ
         3Z3CkLt34Fab0lL0Jx5HFSgdEhc7rJ+3GQ/U7UxWl+tm3pd6C9YcXDwTMRxoPJEa4ban
         02QQ==
X-Forwarded-Encrypted: i=1; AJvYcCXybVsj6SkGYegFUnwBrG2CoE6RotZfGYHDuF91LeMe96aKzcxMzXe08WwDtl+3Tye3vlxW7EQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdGDgsSp7scTg9XWVrlPoGywqabkr/NT0c0GFpezVveErJEyRR
	0lCuxoWWJ/wp2oAAGJcYOT4dLtU4Iz3DiiunEEFgHrPGDcmEiBcaAmV8AFD7+RULsY5dvLMmAg4
	IJhG0pLbNNVuEBQ==
X-Google-Smtp-Source: AGHT+IF6tbgP24fOhUCyIFJUdfk1J1lsm3emGm3kIkIAo9VgaODWeLcdjdRZMS5qXJKsI5d95ieOiuRPkZ0IYuM=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:35bd])
 (user=aliceryhl job=sendgmr) by 2002:a05:600c:2318:b0:42c:b026:4525 with SMTP
 id 5b1f17b1804b1-42cdc88d08bmr1412005e9.1.1726411292105; Sun, 15 Sep 2024
 07:41:32 -0700 (PDT)
Date: Sun, 15 Sep 2024 14:41:28 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIABfy5mYC/32NTQ6CMBBGr0Jm7Zh2wJ+68h6GhUyH0ojUtKaRE
 O5u5QAu30u+9y2QJHpJcKkWiJJ98mEqQLsKeLhPTtDbwkCKGmU04Rj4IRa7GdM8Mfb+g+qkTW3
 7A/XmDGX4ilL0Fr21hQef3iHO20fWP/s3lzVqpGNT19wxd5auLgQ3yp7DE9p1Xb9YmzwBtQAAA A==
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=3347; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=3WcMNrZ0tsoHg+qzEqC8I515GwoTWxUcB94qskQiDls=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBm5vIZzbcn43lhxpnxChoTQ4UlOIGXoizh9RPck
 GOqCSjJT/+JAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZubyGQAKCRAEWL7uWMY5
 RjlhD/47qaRnFhoeeKcGD65fEJvXyOsg6UlWoXkHdTIqzdWc+gD5xYKrax+0CQRTYhLTbjxHbfE
 wmAiz1ApmJw6QFuVbfFb8eZfArOIkbuxU03K3mU0EWQ8GQxsl/UzAtJnCtuIneUoWjSQaXQOLlY
 vb5mhfJMWSvcxCLCVKVpi2IAHPI8aVaD/DZ2y35btYOqzOHjzHTyoy3UmPbx6D60m5q2qY58vmW
 5jH/NzV1JEOiQ9P/OsdUwbKxTHxpUJtrmSBuKzUEcurZpirT3PGqB0+snRQPEAp3UwYBi0iF0TV
 Pov70T51EJMisFa+GHAY2yTgH4Eq+TSvqHOCr5cbmzQRF+dqyMetDLbZsBnf2/bS63Uo2cIqi4O
 1oGVEnIKCntj3HriNyhmFwbvLLhN6svYAcQVb/Y9NBWRUvamckq73oNOg+3P5/nSNnc8JZ8FmVM
 5+j7la/1LNeceFYZEEV+ZsGKNoYoouTojtEIZzQr//hP7/o4QqctaRlg6ZGxiH9ttehN7N/+nyN
 FZu40e9L4/z3AlW9VlZlpFB47nxkP15UY16w8I/05HISn270zlx55k76Vz79I2V0JOHpgvSCRUb
 rKspVY9zpp2gufT5HWhZfPLIlDHTS7TqxplBtXi4VjCYPywZPxUq8iUb8vwHLFxy0YSKIjhzqdQ IdRtLCV4s56hzBA==
X-Mailer: b4 0.13.0
Message-ID: <20240915-locked-by-sync-fix-v2-1-1a8d89710392@google.com>
Subject: [PATCH v2] rust: sync: require `T: Sync` for `LockedBy::access`
From: Alice Ryhl <aliceryhl@google.com>
To: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Trevor Gross <tmgross@umich.edu>, 
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"

The `LockedBy::access` method only requires a shared reference to the
owner, so if we have shared access to the `LockedBy` from several
threads at once, then two threads could call `access` in parallel and
both obtain a shared reference to the inner value. Thus, require that
`T: Sync` when calling the `access` method.

An alternative is to require `T: Sync` in the `impl Sync for LockedBy`.
This patch does not choose that approach as it gives up the ability to
use `LockedBy` with `!Sync` types, which is okay as long as you only use
`access_mut`.

Cc: stable@vger.kernel.org
Fixes: 7b1f55e3a984 ("rust: sync: introduce `LockedBy`")
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
Changes in v2:
- Use a `where T: Sync` on `access` instead of changing `impl Sync for
  LockedBy`.
- Link to v1: https://lore.kernel.org/r/20240912-locked-by-sync-fix-v1-1-26433cbccbd2@google.com
---
 rust/kernel/sync/locked_by.rs | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/rust/kernel/sync/locked_by.rs b/rust/kernel/sync/locked_by.rs
index babc731bd5f6..ce2ee8d87865 100644
--- a/rust/kernel/sync/locked_by.rs
+++ b/rust/kernel/sync/locked_by.rs
@@ -83,8 +83,12 @@ pub struct LockedBy<T: ?Sized, U: ?Sized> {
 // SAFETY: `LockedBy` can be transferred across thread boundaries iff the data it protects can.
 unsafe impl<T: ?Sized + Send, U: ?Sized> Send for LockedBy<T, U> {}
 
-// SAFETY: `LockedBy` serialises the interior mutability it provides, so it is `Sync` as long as the
-// data it protects is `Send`.
+// SAFETY: If `T` is not `Sync`, then parallel shared access to this `LockedBy` allows you to use
+// `access_mut` to hand out `&mut T` on one thread at the time. The requirement that `T: Send` is
+// sufficient to allow that.
+//
+// If `T` is `Sync`, then the `access` method also becomes available, which allows you to obtain
+// several `&T` from several threads at once. However, this is okay as `T` is `Sync`.
 unsafe impl<T: ?Sized + Send, U: ?Sized> Sync for LockedBy<T, U> {}
 
 impl<T, U> LockedBy<T, U> {
@@ -118,7 +122,10 @@ impl<T: ?Sized, U> LockedBy<T, U> {
     ///
     /// Panics if `owner` is different from the data protected by the lock used in
     /// [`new`](LockedBy::new).
-    pub fn access<'a>(&'a self, owner: &'a U) -> &'a T {
+    pub fn access<'a>(&'a self, owner: &'a U) -> &'a T
+    where
+        T: Sync,
+    {
         build_assert!(
             size_of::<U>() > 0,
             "`U` cannot be a ZST because `owner` wouldn't be unique"
@@ -127,7 +134,10 @@ pub fn access<'a>(&'a self, owner: &'a U) -> &'a T {
             panic!("mismatched owners");
         }
 
-        // SAFETY: `owner` is evidence that the owner is locked.
+        // SAFETY: `owner` is evidence that there are only shared references to the owner for the
+        // duration of 'a, so it's not possible to use `Self::access_mut` to obtain a mutable
+        // reference to the inner value that aliases with this shared reference. The type is `Sync`
+        // so there are no other requirements.
         unsafe { &*self.data.get() }
     }
 

---
base-commit: 93dc3be19450447a3a7090bd1dfb9f3daac3e8d2
change-id: 20240912-locked-by-sync-fix-07193df52f98

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>


