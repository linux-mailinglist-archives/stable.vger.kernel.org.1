Return-Path: <stable+bounces-114353-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A79AA2D250
	for <lists+stable@lfdr.de>; Sat,  8 Feb 2025 01:39:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 006987A1F1F
	for <lists+stable@lfdr.de>; Sat,  8 Feb 2025 00:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2052EDDCD;
	Sat,  8 Feb 2025 00:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hu1PBrMa"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A4C154F81;
	Sat,  8 Feb 2025 00:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738975168; cv=none; b=qcs4YsMQ5M+V7SQeEqVQP+IMMx2KUCG9NYdEVGynbzW/wZ1WsdbVubYQj6lnrQCoY6vaXgmTUMsRAROltkO2Rr33qpWgWH5TLf2+qdK8o0s45IjT9TpOZkM0z3Vrrmegr0c915pvzDbGjGT0EzwhfxJ3TnvFU3P2YPlrZY0IcIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738975168; c=relaxed/simple;
	bh=qQa0gNrNTh8rflyzMXqpg7lZJIs7+dLRTkmivq69rQY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=CIPXGs3GnW+sPNyS+VleCdhXWyFklMP/8gp76ENgnk857IyXEXSDKYD8dxrfwpYV523do65diCPIcnxu7EpN6Kl4/W/4nL52fMmL2ht1onDiZoVf9VJvzg50crABfaDLJ9oy1hpSp+RoSkfP1nenyCoxARbbPVImpVrKc4BVNmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hu1PBrMa; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2fa0f222530so4572160a91.0;
        Fri, 07 Feb 2025 16:39:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738975166; x=1739579966; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mn+Gj6V5QB68lisHjccd5SYXG74nCY14H9Pe4YY0PYs=;
        b=Hu1PBrMaOd1gYuy/v0b8lGDXRWNKJeEU5bzyaGMHHy0SBES8LgX+eHn977m29/6FkU
         ju01AAb3+pb+Bn/iPH0sUCcc951u8zfPVCHHRiss9uFPvCSUPHFoRE1SrAa3gu/5qyHw
         cYPCEiUEqusEXgRVdXY04qFiEQkqVGn7h4WuITaUhAq75Nn6kjOnRt+cRfrR1no3aDgM
         e1VyuJb5Z+YFnXHzIbexrBUxP98R1oD0wtJXvRkOpwF3b14WGjqlnmeDtpLuY5t9GThK
         c+QjQWSGJ2hBQ+DbQMg0CsY4vh3lVymNigFjr9nSbFeDMJp6kW1Pi1ggqzQPs0o84ng3
         cbYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738975166; x=1739579966;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mn+Gj6V5QB68lisHjccd5SYXG74nCY14H9Pe4YY0PYs=;
        b=VZny83rFyLPwDrIoXguCu/FUYfQafQ8SV9qhKYBAMLFsQKQ5MspSAHC7qbcNnlvrcy
         MZ0bFrjjJxKdtLC/GYOGDpc3GyaDV+yAbBZFv1ys+6Jzim2RbFdpwBLgbCOycmUln9Da
         X00RwUkSI+vOkULhc06XeOJhUpDDx3YStjo3Rb/MM9Ut/TrulSc4ehIr9fkn0fjOz2pJ
         V8uk0SjWqQTS7S5QLcT6kKbnie9ZyZtbmlbEd6lqZ9k2zF5VNf6fBXLZlL6YVa/8Z+5f
         XbSEYW+zlZ3gGtz2NQsO2KiOt7wfqr1xB8lw1aZiZxS0UHoyEG6gjlDZpCbkdxprYVsB
         aGkg==
X-Forwarded-Encrypted: i=1; AJvYcCUg2czAX9jL8xZH+r/zWLddvCF3vpFmLkgXuzTs5CgT+8qYO+mHgaOVcCRosW+SABnMx8F3YfJb@vger.kernel.org, AJvYcCUnaUbgmDM/w0mLD3GxFBP8rqaBo839kMK41SiOdRkE4Wip3Hl5bC7MQr2rv7jzTqluvXcsFWfNOBReCak=@vger.kernel.org
X-Gm-Message-State: AOJu0YwP3TBne/+N+k5eJeYC50bAlsYkOnCG86/bZRuq3TPnpPDgVGtX
	a6Pz+szCUdWJvWjQjtyc4K7Am9JR35NlecOC11litzCGHjpBcTdh
X-Gm-Gg: ASbGncs3Tcvayh5xFOQspTR0PAyL+kJsk4ZXWyBL3J7LksqF/2slUv+qYReO3zG1jc7
	g3WrCozjtAlKLxfW58+3F9Pt09v35flBV/DfeEnZYGstNIqQ+4OIf4m3cNWaJTmdDToDPNgGI06
	GWpAyqLiDqXWAsFlj9LAEAGum49gXzLmr5tlLTxpU6Kc3k72atn24d+mhUbaecGCtX4WSYSeSAL
	5hmFqr1sFcc9NZm9ox1BaRgPpW+MAzSo456XUKEp/IqZmblbt7goqRLJxGyiyjOZIed6IBBx/9S
	mjNyN/77cXrhIOHM/PsO9g==
X-Google-Smtp-Source: AGHT+IFYcsIZByxigtPhOugwI9tbewNEbeIUh+/2FY1PeHByKW59F9geHHy6PhNJDM/F6E/NfQMMWQ==
X-Received: by 2002:a17:90b:2888:b0:2f6:be57:49d2 with SMTP id 98e67ed59e1d1-2fa2417bee0mr8477438a91.17.1738975166182;
        Fri, 07 Feb 2025 16:39:26 -0800 (PST)
Received: from mitchelllevy. ([131.107.8.113])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f36511106sm36521545ad.5.2025.02.07.16.39.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 16:39:25 -0800 (PST)
From: Mitchell Levy <levymitchell0@gmail.com>
Subject: [PATCH v4 0/2] rust: lockdep: Fix soundness issue affecting
 LockClassKeys
Date: Fri, 07 Feb 2025 16:39:07 -0800
Message-Id: <20250207-rust-lockdep-v4-0-7a50a7e88656@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKunpmcC/3XOQQrCMBAF0KtI1kZmJo22rryHuEinEw1qK4kWR
 Xp3U0ERxeUfeP/PXSWJQZJaTu4qSh9S6NociulE8c61W9GhyVkRUAEVWB0v6awPHe8bOenGiAF
 LyGXtVCanKD5cn3XrTc67kM5dvD3bexyvf4p61Kgb4ooJnStrWm2PLhxm3B3H3hEhQPGDQEvlL
 Bd2Qej5A43rPb0XkbD6wpSxn1sDpa/ZsvvG5oUt0M+7JmNr0EhpHNTiP/EwDA82q7sDVwEAAA=
 =
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1738975167; l=3256;
 i=levymitchell0@gmail.com; s=20240719; h=from:subject:message-id;
 bh=qQa0gNrNTh8rflyzMXqpg7lZJIs7+dLRTkmivq69rQY=;
 b=aU5432tbB/zpsDXxlaz6mKNk4iotAZAdT5eLDzW81HtTyrDK9yKASwr3acAKd5r+X7lZNUhsa
 19gZwtZZMePDsm4AD9uQ27TwLoGJ+yXRNhLMGRBWa+i34KbJvNEUXcR
X-Developer-Key: i=levymitchell0@gmail.com; a=ed25519;
 pk=n6kBmUnb+UNmjVkTnDwrLwTJAEKUfs2e8E+MFPZI93E=

This series is aimed at fixing a soundness issue with how dynamically
allocated LockClassKeys are handled. Currently, LockClassKeys can be
used without being Pin'd, which can break lockdep since it relies on
address stability. Similarly, these keys are not automatically
(de)registered with lockdep.

At the suggestion of Alice Ryhl, this series includes a patch for
-stable kernels that disables dynamically allocated keys. This prevents
backported patches from using the unsound implementation.

Currently, this series requires that all dynamically allocated
LockClassKeys have a lifetime of 'static (i.e., they must be leaked
after allocation). This is because Lock does not currently keep a
reference to the LockClassKey, instead passing it to C via FFI. This
causes a problem because the rust compiler would allow creating a
'static Lock with a 'a LockClassKey (with 'a < 'static) while C would
expect the LockClassKey to live as long as the lock. This problem
represents an avenue for future work.

---
Changes in v4:
- Expand the cover letter in the 2nd patch to explain why Pin is used
  despite being redundant at the moment (Thanks Benno Lossin).
- Include a Fixes tag in the 1st patch (Thanks Miguel Ojeda).
- Link to v3: https://lore.kernel.org/r/20250205-rust-lockdep-v3-0-5313e83a0bef@gmail.com

Changes in v3:
- Rebased on rust-next
- Fixed clippy/compiler warninings (Thanks Boqun Feng)
- Link to v2: https://lore.kernel.org/r/20241219-rust-lockdep-v2-0-f65308fbc5ca@gmail.com

Changes in v2:
- Dropped formatting change that's already fixed upstream (Thanks Dirk
  Behme).
- Moved safety comment to the right point in the patch series (Thanks
  Dirk Behme and Boqun Feng).
- Added an example of dynamic LockClassKey usage (Thanks Boqun Feng).
- Link to v1: https://lore.kernel.org/r/20241004-rust-lockdep-v1-0-e9a5c45721fc@gmail.com

Changes from RFC:
- Split into two commits so that dynamically allocated LockClassKeys are
removed from stable kernels. (Thanks Alice Ryhl)
- Extract calls to C lockdep functions into helpers so things build
properly when LOCKDEP=n. (Thanks Benno Lossin)
- Remove extraneous `get_ref()` calls. (Thanks Benno Lossin)
- Provide better documentation for `new_dynamic()`. (Thanks Benno
Lossin)
- Ran rustfmt to fix formatting and some extraneous changes. (Thanks
Alice Ryhl and Benno Lossin)
- Link to RFC: https://lore.kernel.org/r/20240905-rust-lockdep-v1-1-d2c9c21aa8b2@gmail.com

---
Mitchell Levy (2):
      rust: lockdep: Remove support for dynamically allocated LockClassKeys
      rust: lockdep: Use Pin for all LockClassKey usages

 rust/helpers/helpers.c          |  1 +
 rust/helpers/sync.c             | 13 +++++++++
 rust/kernel/sync.rs             | 63 ++++++++++++++++++++++++++++++++++-------
 rust/kernel/sync/condvar.rs     |  5 ++--
 rust/kernel/sync/lock.rs        |  9 ++----
 rust/kernel/sync/lock/global.rs |  5 ++--
 rust/kernel/sync/poll.rs        |  2 +-
 rust/kernel/workqueue.rs        |  2 +-
 8 files changed, 77 insertions(+), 23 deletions(-)
---
base-commit: beeb78d46249cab8b2b8359a2ce8fa5376b5ad2d
change-id: 20240905-rust-lockdep-d3e30521c8ba

Best regards,
-- 
Mitchell Levy <levymitchell0@gmail.com>


