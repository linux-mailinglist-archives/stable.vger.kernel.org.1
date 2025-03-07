Return-Path: <stable+bounces-121518-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1029A5760F
	for <lists+stable@lfdr.de>; Sat,  8 Mar 2025 00:31:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE0F4179519
	for <lists+stable@lfdr.de>; Fri,  7 Mar 2025 23:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BA1C25A34F;
	Fri,  7 Mar 2025 23:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f19YZS0f"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0FE25D8F2;
	Fri,  7 Mar 2025 23:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741390167; cv=none; b=dyvtasxdfISj8rRbO2XLpdA94eMNaF6aDEf6senM3LUgMht0t1O1Qe/WWVD8IecXLU8va3ESaCGiFUG1K3lJZGCLajYZ2YkmCEy+gixDw8CMo65gRxD0LCFtcVbaLFbs1dD5WjQeCAI39p+Yeis3QZFsYFgYExyYqPPvHtQvOxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741390167; c=relaxed/simple;
	bh=EN2WCM3Fe2apmKI2sJLPkfk+FyqHPeBOOQKGk2eCDQU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=czbYFSmS2P6BbMLLVO/trff5/cxuKIbozmpXXzZNS9vyuamg3Zpvoh29Ffh1/DZewdghy0RRdpyrvCSebDIQzkN9JX/SuJskoGQqRJ5fAaRydXSMeS8MUhDTXGV6dc9yrq10QL3oIBD56tg8xhq0DL4gBECCmUAl5SnIbA4jc3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f19YZS0f; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-46c8474d8f6so19355291cf.3;
        Fri, 07 Mar 2025 15:29:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741390164; x=1741994964; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=u97qSHNSHn4i8j/JUzVrDl8csPGwebUmG7SRNObd36M=;
        b=f19YZS0fAepfWSvwp8/xTHsj0CPW7AKOrM6WGgRoTfYqVxRg3HMaKi8jyIDpf1d+uY
         SrB6UJy3CB46Dsl7JGC2g+HBlADDbhMMlI5v9qqnBqTkiBQmL4T8kiCbpWL8TAHfPg1l
         NqXQcs6by0KoNnggqJqUlLOAJrBt7+LxfhI8XD4M2ntHOPvO9ZwjUi4Y1iBkhfgh/bK4
         vaenisJeq7Y2p0XBvhksPn1PwKLBBQKN8TNBYxdhZKgxqlZ4GQzbEzGrEGCazh863Dpn
         BOQIRp6PxuRMF1bk86r5Gv/tYYzHlxl5CoISx3aAtjXng9ZwfaJGWGJIUBVIrVGKko/O
         NcpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741390164; x=1741994964;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u97qSHNSHn4i8j/JUzVrDl8csPGwebUmG7SRNObd36M=;
        b=vMCEXZwOiKRhD+g7rEUbnT/RDtmUXn/pS7ZRuGj1EMJdL9YVWSCYybJQStWQ6DqtUL
         VgpST5cMdzPBpNNSHSxCerJcKry6eKbhwo+UmqIVbCtVarpBmV2OQwvp53mLORL5W7Wb
         6++VRjbABm8e/t8PdYi2IaO1+W1IbNZRiFefzdIcuqvmqkSLfi5qnhNW0tGA+zI8uslf
         Yr/YMeZVBsftDvnpESGIkFbZZLF30Yl46suys7mubjhgd0dIbkSLDuO5x2KRBY47mbaf
         qCuJH+byrtzDAnt6uEM5faZP+Iw+zB3Ox+fR82iwqsNlJ7TypDcgaCPN+nDakrqFtp1k
         wBlA==
X-Forwarded-Encrypted: i=1; AJvYcCUyiN3owfG4dwIn22knlHl6jDXPxoScR0+J3tyIGIWxUoieCAWqVhYM082rDspvkcHUE1H0DG1GMWbxs7Y=@vger.kernel.org, AJvYcCWdRrtuGcZhHnlQP++I8nX8/dahio9v/JVrI2Dm9nmtxFyzfh2sW7qbCT5u2I/GYTY8kHoDHqXoTA6kgvTJi4g=@vger.kernel.org, AJvYcCXPj1ymVdcrI6uRA0TMMyQhAr+ZuSlf9dWNPqrs3eIZfJMOH/fpxfBLQ6h0U7dGReErrqM45GCT@vger.kernel.org
X-Gm-Message-State: AOJu0YzG9GxfZ2wqtRMgbnizmm9LEaPtdnaiCWXukWubJ6pi4SuVaDLs
	XOHVzLVGmRjX+7Vw0r36Vp2snLhx1Fw4saqyE97mTtPRTzBTwwMi
X-Gm-Gg: ASbGncu5K+n1pMNbHVeUZjepCaQenvHRNJFRHO5r12ZogmLszrdY+6kRCHMGVk38GS3
	m6eqpEoQZA6a7bAGn9GISYkm+03Rvc/UkmAKhRTKGkK6Q/kUj776QApcGgmk+VhWY13RFotY02K
	9J51DzJe9DTx1EPewNie4+6t3aEPowjCdMwBtGVW24ic2e4b9LxsV6DyGaWXus+G2H8ta1U8Nlq
	ktsnXEjG5/RMcVXH5xXbrbsi41p5HHL5ON2X0rgpjEZmK+5xgPjkDt7jOXboGGoSK579Lo/zK6N
	wMhqbEaubvh4V393P8890MHVNilEi1LEVzw8H9jdQb/rv9zs0Dabb63w0YL5cfxMIjFzTvz8p/C
	TZmwI/Gu2/+7+A85BT8FIYqpcZLwVv4SwpPI=
X-Google-Smtp-Source: AGHT+IGYRCdD3Q7FZFT43BsjaBxyWh9yUY4vkr7hQ9Bi4GFFzJrNeT+f1m1+ytPjCvc8tEGf4Wl58g==
X-Received: by 2002:a05:622a:1a1e:b0:474:bca3:9192 with SMTP id d75a77b69052e-476109ad024mr74857131cf.26.1741390164440;
        Fri, 07 Mar 2025 15:29:24 -0800 (PST)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4751d9a89acsm26020021cf.44.2025.03.07.15.29.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 15:29:24 -0800 (PST)
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 6C7F6120006B;
	Fri,  7 Mar 2025 18:29:23 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Fri, 07 Mar 2025 18:29:23 -0500
X-ME-Sender: <xms:U4HLZzpExMx-ymy2wimYN6-YEjlg0IwTYn46n0dbth_67AsYk4C4Rg>
    <xme:U4HLZ9pES_6rQXign5zS-q6t0K936N9oAcnMOfbOKRb6qInWYDfVZ7hBYYTAswKGw
    PIMLSVG5elAxpCjDA>
X-ME-Received: <xmr:U4HLZwOFQGK_87loF3SmZ4WRFg7WyUoSbhML8P8OBXvIItXtD2m-us-9nyo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduudduleekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredt
    tdenucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrih
    hlrdgtohhmqeenucggtffrrghtthgvrhhnpefghfffvefhhfdvgfejgfekvdelgfekgeev
    ueehlefhiedvgeffjefgteeugfehieenucffohhmrghinhepkhgvrhhnvghlrdhorhhgne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhu
    nhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqdduje
    ejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdr
    nhgrmhgvpdhnsggprhgtphhtthhopedvtddpmhhouggvpehsmhhtphhouhhtpdhrtghpth
    htohepmhhinhhgoheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvthgvrhiisehi
    nhhfrhgruggvrggurdhorhhgpdhrtghpthhtohepfihilhhlsehkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehlohhnghhmrghnsehrvgguhhgrthdrtghomhdprhgtphhtthhopehl
    ihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hlvghvhihmihhttghhvghllhdtsehgmhgrihhlrdgtohhmpdhrtghpthhtoheprghlihgt
    vghrhihhlhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepshhtrggslhgvsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsggvnhhnohdrlhhoshhsihhnsehprhho
    thhonhdrmhgv
X-ME-Proxy: <xmx:U4HLZ27AoEo5tOdVp8cT4I7uIsDJwNOHQGV7FyxBG632yhCKqnwRHQ>
    <xmx:U4HLZy6HADmYnwR5bckn0KiDS7bZxMuap_j-e8h_axKqxvTUiJGgzQ>
    <xmx:U4HLZ-h--8GAbO9E4uEAsWSrbDrW-_6tT5YcmFoUORLavgMf40y1LQ>
    <xmx:U4HLZ04KlywHG0oYZ6iYzJckitgg7_eZ36Yj_JdXmzDMIrB43wbHIg>
    <xmx:U4HLZxJEKtyHrPUraXRc_mUXhiO_dH0IUt6U1SoMwkz69u4p-dNlfuab>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Mar 2025 18:29:22 -0500 (EST)
From: Boqun Feng <boqun.feng@gmail.com>
To: Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>,
	linux-kernel@vger.kernel.org,
	Mitchell Levy <levymitchell0@gmail.com>,
	Alice Ryhl <aliceryhl@google.com>,
	stable@vger.kernel.org,
	Benno Lossin <benno.lossin@proton.me>,
	Boqun Feng <boqun.feng@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Lyude Paul <lyude@redhat.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
	rust-for-linux@vger.kernel.org (open list:RUST)
Subject: [PATCH locking 10/11] rust: lockdep: Remove support for dynamically allocated LockClassKeys
Date: Fri,  7 Mar 2025 15:27:00 -0800
Message-ID: <20250307232717.1759087-11-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250307232717.1759087-1-boqun.feng@gmail.com>
References: <Z76Uk1d4SHPwVD6n@Mac.home>
 <20250307232717.1759087-1-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mitchell Levy <levymitchell0@gmail.com>

Currently, dynamically allocated LockCLassKeys can be used from the Rust
side without having them registered. This is a soundness issue, so
remove them.

Suggested-by: Alice Ryhl <aliceryhl@google.com>
Link: https://lore.kernel.org/rust-for-linux/20240815074519.2684107-3-nmi@metaspace.dk/
Cc: stable@vger.kernel.org
Fixes: 6ea5aa08857a ("rust: sync: introduce `LockClassKey`")
Reviewed-by: Benno Lossin <benno.lossin@proton.me>
Signed-off-by: Mitchell Levy <levymitchell0@gmail.com>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Link: https://lore.kernel.org/r/20250207-rust-lockdep-v4-1-7a50a7e88656@gmail.com
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
2.47.1


