Return-Path: <stable+bounces-114354-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0109A2D252
	for <lists+stable@lfdr.de>; Sat,  8 Feb 2025 01:39:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8B59188B43A
	for <lists+stable@lfdr.de>; Sat,  8 Feb 2025 00:39:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDBDE2556E;
	Sat,  8 Feb 2025 00:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kVXCKsPM"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2918D2FB;
	Sat,  8 Feb 2025 00:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738975170; cv=none; b=jVhbL3dWCJ8wLJBOou/fpgNZbbWSTmsRCOqdB2k/TR94afVDrowjX1nrf65gd6lFNwLoMDP7miiCiDy7q9qXIK2GKwyGFYRMazkz4DjSRKnhIQxzEK9KhejVvGuvQpZPLRaVi6BNyjFs+3wey6NBsSGRDGGz3Gl2f0bGLq8FC5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738975170; c=relaxed/simple;
	bh=g9B1kvG9mClroHKpE152++oX3t0NfIdlQxqqWY54w68=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DeB5uYlEnG2dZew5/uuqEKRga5096Qb9AK1n3mDhnxJSs29TbJUN5pDvXlijP3GccEl3jrToiwJMLajDATS4bHYThBdqbZ0j876DtWGTjpnOVN9SjB1/86JDUBMQuMyd8KsegIEQU4szAB/+8QqPc8S3IQphP6sbwV5CD4lGzQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kVXCKsPM; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2fa48404207so173342a91.1;
        Fri, 07 Feb 2025 16:39:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738975168; x=1739579968; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EdTghmhqKtN7JF2YPRSDRNjRx4uKB58Nq5zV5cez4X4=;
        b=kVXCKsPMt0C8W98xRglDwPeT6BrMpQXVMH7sXrEO0XCYxeg91n/IQjkghOMV6PgPHF
         P8f0rIx1jTOqrGwBD3aac4Z3K0xwMuY9axFYC9b3Z2OA2mSPJpkPcT4nhEvA9MgrAoYb
         4bApDEiymcg1phF9L0WykMl10eKTKRTqto0mmaCdxdpg690kpVF4zSmX9MnR+JUFURzM
         imoA8f184gFxVORLZ9LFICbXoH6GpEu5Rd0A1oJe7MkoIBkfUmSQtSbpVmGhCCvxURN3
         +h+6xqNInQtOepnzBTN0N9hi6ZIOV6o1yslkpmlBJ+wxoAlDGwtLpNb41um/As62e1Di
         WT/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738975168; x=1739579968;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EdTghmhqKtN7JF2YPRSDRNjRx4uKB58Nq5zV5cez4X4=;
        b=kxov0f2FJEe59+xg2ovdl7/XDQmpQtFtRGJen1qxbLzn3v+5e4GLfX4tmGAX9axCDr
         rpSj3Xr3bguUwGDzMoguDpa7bSWRa/+Np+b5XzmlrYzJF5LtOKicG+Hl/fHq3Qd8TbpA
         yybEq/8YZpPE7HQJvJgM1LWrD5JOYZohl6l/tGqQXGGSa0EQERXr8ZSWmcJyaFyU65T4
         ror7PR1Tc35n8vfKk4gBTvYpyYiDD/A3vAAmCDR3lESgH54ZiHqjtpB14frwDfWT8jYf
         VmhelbooA1UYlZxOXgaeoxIAruYKeSyaZtcaCh1PyVARhc/NWszCh2nbsE68N4rc23Uw
         9biQ==
X-Forwarded-Encrypted: i=1; AJvYcCW6axqQNIukcJoAI51ru6mo1yxLIV81gdzRwBoYO79UGWzYqDfpBWEWMDtSu/Debvh9PA8eFXsN@vger.kernel.org, AJvYcCXP/enGxdxki6rbdN1DsrA0EwW3DYkLyyz9ZZGQGBRiKx/HmhVUbwwutMzQIiJe+7McheOOWOybMIXOfrg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0myZwlrjV6gHI20e3uBLjLw19Bk1c/enTSQPQ+WnLrWTjZequ
	gJYdwIcbxbpOTwk6C7MUKIU6ywMG3S+2BPoZ+8iHwgdXttqkVCz1
X-Gm-Gg: ASbGnct4eigBol6GeQ6BVWTmT/Kw2P3E+gQnAharIUcrOaf6Nm82jGf+SqxK2UUGp6k
	V2gvOFKiS9Q0h/G5++cH3NsQIeUsfY8GVET3ehjFiH8rohVoG3n6WrzCB5PgUDFQUT5+YYTmONh
	FU+Wb9U+vFmtDY0boSiKte0BHLzukJVNYNzIL62Gr7gEWG9BxJDOcemGXb6dXQyYwoksbpyy/3H
	FBjRwCXkByRUflHodfwIsDLPqSstKz9LwYgXxeTiRYIb5RgrGrPxZA8mcO5ZSnGtON4kvBkhwfs
	pDifAUzZr6ipkdaAbsBFxw==
X-Google-Smtp-Source: AGHT+IE0U4vBz6yhsGCEdIiwj7Hc1IMCy+v9WeSGwz91iDkH7Rea0VI4i1hxuXs5Rutmmpo6oqBSNA==
X-Received: by 2002:a17:90b:38c3:b0:2f4:434d:c7ed with SMTP id 98e67ed59e1d1-2fa24177361mr8750136a91.16.1738975167751;
        Fri, 07 Feb 2025 16:39:27 -0800 (PST)
Received: from mitchelllevy. ([131.107.8.113])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f36511106sm36521545ad.5.2025.02.07.16.39.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 16:39:26 -0800 (PST)
From: Mitchell Levy <levymitchell0@gmail.com>
Date: Fri, 07 Feb 2025 16:39:08 -0800
Subject: [PATCH v4 1/2] rust: lockdep: Remove support for dynamically
 allocated LockClassKeys
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250207-rust-lockdep-v4-1-7a50a7e88656@gmail.com>
References: <20250207-rust-lockdep-v4-0-7a50a7e88656@gmail.com>
In-Reply-To: <20250207-rust-lockdep-v4-0-7a50a7e88656@gmail.com>
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <benno.lossin@proton.me>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 Wedson Almeida Filho <walmeida@microsoft.com>, 
 Martin Rodriguez Reboredo <yakoyoku@gmail.com>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Mitchell Levy <levymitchell0@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1738975167; l=1706;
 i=levymitchell0@gmail.com; s=20240719; h=from:subject:message-id;
 bh=g9B1kvG9mClroHKpE152++oX3t0NfIdlQxqqWY54w68=;
 b=cnrZ9vCz2l9OzZkGn7ri2rDDCo3ttaRZIiUnIT5e9jJmlO0c8rRIsAKjM+/8WChcJoWWqLN5g
 983VTnRXQV9Bp6/1jEhM8/0iC0K1wKwNLpUrvSmLkxzu8yVc5LoWAc2
X-Developer-Key: i=levymitchell0@gmail.com; a=ed25519;
 pk=n6kBmUnb+UNmjVkTnDwrLwTJAEKUfs2e8E+MFPZI93E=

Currently, dynamically allocated LockCLassKeys can be used from the Rust
side without having them registered. This is a soundness issue, so
remove them.

Suggested-by: Alice Ryhl <aliceryhl@google.com>
Link: https://lore.kernel.org/rust-for-linux/20240815074519.2684107-3-nmi@metaspace.dk/
Cc: stable@vger.kernel.org
Fixes: 6ea5aa08857a ("rust: sync: introduce `LockClassKey`")
Reviewed-by: Benno Lossin <benno.lossin@proton.me>
Signed-off-by: Mitchell Levy <levymitchell0@gmail.com>
---
 rust/kernel/sync.rs | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/rust/kernel/sync.rs b/rust/kernel/sync.rs
index 3498fb344dc9..16eab9138b2b 100644
--- a/rust/kernel/sync.rs
+++ b/rust/kernel/sync.rs
@@ -30,28 +30,20 @@
 unsafe impl Sync for LockClassKey {}
 
 impl LockClassKey {
-    /// Creates a new lock class key.
-    pub const fn new() -> Self {
-        Self(Opaque::uninit())
-    }
-
     pub(crate) fn as_ptr(&self) -> *mut bindings::lock_class_key {
         self.0.get()
     }
 }
 
-impl Default for LockClassKey {
-    fn default() -> Self {
-        Self::new()
-    }
-}
-
 /// Defines a new static lock class and returns a pointer to it.
 #[doc(hidden)]
 #[macro_export]
 macro_rules! static_lock_class {
     () => {{
-        static CLASS: $crate::sync::LockClassKey = $crate::sync::LockClassKey::new();
+        static CLASS: $crate::sync::LockClassKey =
+            // SAFETY: lockdep expects uninitialized memory when it's handed a statically allocated
+            // lock_class_key
+            unsafe { ::core::mem::MaybeUninit::uninit().assume_init() };
         &CLASS
     }};
 }

-- 
2.34.1


