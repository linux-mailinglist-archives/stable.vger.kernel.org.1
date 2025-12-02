Return-Path: <stable+bounces-198076-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90F40C9B4E7
	for <lists+stable@lfdr.de>; Tue, 02 Dec 2025 12:24:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A9BC3A255D
	for <lists+stable@lfdr.de>; Tue,  2 Dec 2025 11:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1AF530FC39;
	Tue,  2 Dec 2025 11:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g//xRQmr"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E5528A3FA
	for <stable@vger.kernel.org>; Tue,  2 Dec 2025 11:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764674677; cv=none; b=eEGZ2+G29lZEg5qnjtIUulNfUCN/G8lMxD57PJQom96mCvl8DVGS+ga80Ps6GIcCw1OO69C+8O+cCyBKfPaQPqld18vpYmwL8tBsMpNSDIZhlX8GXhIqg/miwG7xutvz+mFjDdo1T5xTjviK6Y+qK0Rdtx/GYE5Ma674PHpDZ40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764674677; c=relaxed/simple;
	bh=Qpp77KvX2ntGTeGFE+/vG+eyDI372EHiHsKKWaIxMak=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=OhS+DtIw6MNdfkbf0QkTQJNX5mtqfHcY3Swy7h3Y1PEDZsyDh20fiOefVuTY2REqj36dGUcoXkNdODwggEWqMH3+Xe5Q+CQZDkbCKgdIKlJvdRmt8nzTbFm1AZTnQqYD2ti2a181my/gjZmFL7g9HAiW5uTdhMpzt4SJDICtMrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=g//xRQmr; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4775f51ce36so41146505e9.1
        for <stable@vger.kernel.org>; Tue, 02 Dec 2025 03:24:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764674674; x=1765279474; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yw15L8Ws5Za4ir4TV1kcpHhvEfEabzRhGkOhypMthRI=;
        b=g//xRQmrtH80duu0wmL1HQ+yDCnrGmOy6VjkgRjB4bm2xGZh/l+3hV1LIoAFxDTsZT
         ukqyyr+tliBCqHw3xavwV7ZIhgFGLWWOZwD9BK6nb6BVs/82II38rkHKsxAZBav1RZmh
         o54nBJzdhdfg3Q8QeyG4Lz6tnuP1id8g287Cu8MxbaegsjC91qgLP/XKg33Rl8PdhllL
         L63FCsyDblXa68bel+g9hmMY+2+OZrlVZjbRmSkkG4iwZ1LWlgExS4oxmW7Z7ws3s+/Y
         Rut6w5vTA7ytigq52MLt0Rm/Sus4tCxKvpHvBc8QbjVAI5YOb4wIk/R/WqIvHb8aKfr5
         0CVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764674674; x=1765279474;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yw15L8Ws5Za4ir4TV1kcpHhvEfEabzRhGkOhypMthRI=;
        b=s5ttxwgvnoRq8JaEJ15KWVL+OJfilXkn7JI4CknBy8F7vET3dSi099qkLPyIdJTCUG
         LhIHb8frRzVAe1Ag5EJz/08UmI69FEZtglaTb6wGwdpSeM/qtXp6TI4Vd3XsTnDuins9
         IePc9b9RaqzHE6AZc7UU8m1qQ4mI17BgKqJwTnOTeyE4EreIozTdxJHHwLKwWpHOPC//
         TMPHciasfFziYgkRGPFZbXnexfL3Tpzwn5d5G4S3BYeCB5zCerK6iyaMYTESjbCcXOvS
         6zGR5OuALGNQKITkNgQkAMoKDEzS3CiCu4C7wAEpOSidWXcyedgjRb0faau1D2KErH49
         jccQ==
X-Forwarded-Encrypted: i=1; AJvYcCWHxJuWrPTxzKcpk50PZhKuHtA+7//D4EtFJwej8PASsNChmzO5KxYhk7Dk30CFKp0xk4Zdr2o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeO2HCFmqpuS/nEEmyBjLbyj/SC1Lf2LvXPn4BI0UAaYbHuDi/
	w+FAI2QjT/ZNZz7/KdLNLEgpCTecJ8mPxrqIxFt5IVqdpE3/LvmNlZ5dWQuHEwU4OGPnT2gTSkS
	LSXj3h3lEGii6c+c4uA==
X-Google-Smtp-Source: AGHT+IHpdnN6oA8rWAxr9avC2fSutMAuLGfVm4Oddyr1NAX+wKpul280w/9NJWaMSOqzUAdPClbkFoDL7J9C8Uc=
X-Received: from wmbh6.prod.google.com ([2002:a05:600c:a106:b0:471:1414:8fd1])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1c29:b0:477:639d:bca2 with SMTP id 5b1f17b1804b1-477c10c85e2mr478818625e9.4.1764674674469;
 Tue, 02 Dec 2025 03:24:34 -0800 (PST)
Date: Tue, 02 Dec 2025 11:24:24 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAGfMLmkC/x2MwQqDQAwFf0VyNuAuiNpfKT3Y3acGIZUERRD/v
 YuXgTnMXOQwgdOrushwiMtPi4S6orSMOoMlF6fYxDYU8Fc0w9gXE115V99EOQBD38WUIjKVdDN Mcj7b9+e+/1lu/w5mAAAA
X-Change-Id: 20251202-binder-shrink-unspin-1ee9872cc2ed
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=2269; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=Qpp77KvX2ntGTeGFE+/vG+eyDI372EHiHsKKWaIxMak=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBpLsxsRsF2Pm0STXgKjlHONC+GhOBhTzDZmPRSM
 hwpthfO+nCJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaS7MbAAKCRAEWL7uWMY5
 Rjh3D/9SweS3JEuEOxc/0TnA7tPi4QbgQGSRoW44kIb9vrVS2o2cNQI16KHakNImCaR8mHQrE/g
 4ddJM7fX7hgW23eX+kx7sBMdXLDM/EyX5cR1TT8GCScCkk+yDnf5A35biFO9AOrJr4SUSIpBfI7
 9VuzP5SqCemvs/3iM4Kuk3TVsUQU0KwTaZK4ZkgoFMmEMo4ObramV05EecdHLC5qETgrjLDROdc
 kaSnSoqWfwfWl+ZVM5LB9KGL1ZjfTfaQna9iaJa5HhAhxatFlfvCEllOrKK6Pzq+NXA4At655b9
 yVCOMeGXzLOueeTbuyXe/qLlU6wp9q8zZZT8i8s6D2aj24c214cfmU3d2eZA2zbREsNzZypQvwN
 oR/Lqz7jTQdVB++5U2Xs3KSfaZdFvtkEUHHQthARc5IrYOfmfilr8rhZ4xzu4rt3j9+GwGz64Ko
 ZK0nxNt26sNcScfw8xOg6RNmR39sFQJUNMRRzd0bawL2jtN3z4Hjjt6XDs1zVNZCOo52IPvQJb0
 eJWYrtEtpn+hvbWoiSk/T+9Gf8q9yrKxMCScwUpJ9/X9f3K5f9vWF/qjj9b53icGTkNlW/wiJVa
 y1BwuPbmJe2S+CwRGiFJMO68wYE7NGJzdd1LR5xFw8fNGBx3pfJYlO4bRsO7qPdMTX18Qnc/wMY pVj/uU60mnqK6Uw==
X-Mailer: b4 0.14.2
Message-ID: <20251202-binder-shrink-unspin-v1-1-263efb9ad625@google.com>
Subject: [PATCH] rust_binder: remove spin_lock() in rust_shrink_free_page()
From: Alice Ryhl <aliceryhl@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Carlos Llamas <cmllamas@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, 
	"=?utf-8?q?Arve_Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Christian Brauner <brauner@kernel.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, stable@vger.kernel.org, 
	Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"

When forward-porting Rust Binder to 6.18, I neglected to take commit
fb56fdf8b9a2 ("mm/list_lru: split the lock to per-cgroup scope") into
account, and apparently I did not end up running the shrinker callback
when I sanity tested the driver before submission. This leads to crashes
like the following:

	============================================
	WARNING: possible recursive locking detected
	6.18.0-mainline-maybe-dirty #1 Tainted: G          IO
	--------------------------------------------
	kswapd0/68 is trying to acquire lock:
	ffff956000fa18b0 (&l->lock){+.+.}-{2:2}, at: lock_list_lru_of_memcg+0x128/0x230

	but task is already holding lock:
	ffff956000fa18b0 (&l->lock){+.+.}-{2:2}, at: rust_helper_spin_lock+0xd/0x20

	other info that might help us debug this:
	 Possible unsafe locking scenario:

	       CPU0
	       ----
	  lock(&l->lock);
	  lock(&l->lock);

	 *** DEADLOCK ***

	 May be due to missing lock nesting notation

	3 locks held by kswapd0/68:
	 #0: ffffffff90d2e260 (fs_reclaim){+.+.}-{0:0}, at: kswapd+0x597/0x1160
	 #1: ffff956000fa18b0 (&l->lock){+.+.}-{2:2}, at: rust_helper_spin_lock+0xd/0x20
	 #2: ffffffff90cf3680 (rcu_read_lock){....}-{1:2}, at: lock_list_lru_of_memcg+0x2d/0x230

To fix this, remove the spin_lock() call from rust_shrink_free_page().

Cc: stable@vger.kernel.org
Fixes: eafedbc7c050 ("rust_binder: add Rust Binder driver")
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 drivers/android/binder/page_range.rs | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/android/binder/page_range.rs b/drivers/android/binder/page_range.rs
index 9379038f61f513c51ebed6c7e7b6fde32e5b8d06..fdd97112ef5c8b2341e498dc3567b659f05e3fd7 100644
--- a/drivers/android/binder/page_range.rs
+++ b/drivers/android/binder/page_range.rs
@@ -727,8 +727,5 @@ fn drop(self: Pin<&mut Self>) {
     drop(mm);
     drop(page);
 
-    // SAFETY: We just unlocked the lru lock, but it should be locked when we return.
-    unsafe { bindings::spin_lock(&raw mut (*lru).lock) };
-
     LRU_REMOVED_ENTRY
 }

---
base-commit: 82d12088c297fa1cef670e1718b3d24f414c23f7
change-id: 20251202-binder-shrink-unspin-1ee9872cc2ed

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>


