Return-Path: <stable+bounces-83506-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADCAF99AF23
	for <lists+stable@lfdr.de>; Sat, 12 Oct 2024 01:13:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF8501C2446E
	for <lists+stable@lfdr.de>; Fri, 11 Oct 2024 23:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACE6F1D278A;
	Fri, 11 Oct 2024 23:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L+6pzHk6"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9ACB28EB;
	Fri, 11 Oct 2024 23:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728688377; cv=none; b=YRdERXWlf8nnKjCI7drE7GY0Moj4N9JuhWk5h8Czi8zujQejfUYoLYujIynQh0kOG4uxie5lgjvPoec4yod+bwgwvfRBg54vbDkY2w46njiClFukInKmPudzhivVbAadQ+ctAUUv4u+XJvSWABFBqdrEEt/Qx8b1sRNgdPoDaCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728688377; c=relaxed/simple;
	bh=auAhPt31Xt+AgKaDcyvXxW6DNEn+hNzH4SmSDSvruqc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aefW/KhAOAtuu3LcuWlGwy2Kg+6UJsd507SAmvvOFU+oYbDEsZDEavFj3LtMsxx61H2nV3P8PYTQ5U6bzuD1Hvgv7EddENpUs7Ao2x9CPq9PUEZENal1V2Zsn9Rv2XscXyzZabE8MiHk7qw+SO/MtD1XxuRO/gJ+a9/8mdle9Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L+6pzHk6; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4603d3e456bso20260051cf.2;
        Fri, 11 Oct 2024 16:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728688375; x=1729293175; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vHFnPxtUSSTOxvi5ge8xazxjEmltcPwcI4eJ2m8KsA0=;
        b=L+6pzHk6kLeRQE7kWuzIJVYa2yne5qHGLFmHyyJlygNKW8YwbLHwtaPPn/wDdmzmQL
         1fwU581aVZn1zq7ad0QgQY3qbnmw7UXNA408GfNi39nv69Z76fogIBayDSpHjcVdlTZK
         F9Iy7rGDxjy9dhdy1jXIWFJjivrprlcrQ96UizTK0zEf4zCb4lldV5TWzMFE/zfw0Vgu
         gKun1FYV0ajO3+99O1NfO281L+O8KHqaKHYzsVG+McxbckaTGOPNTviAreKYgE4/m1c6
         o+3+eb6PVoY55gP1LDztC8FclOjoK1htP6P6EaRmj5ocqWhG792gXeOZllV0xhi1DhF7
         C5/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728688375; x=1729293175;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:feedback-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vHFnPxtUSSTOxvi5ge8xazxjEmltcPwcI4eJ2m8KsA0=;
        b=v6kDrvxNDP/OOHdM18xVK8IHqgFhd1Y4DgJzU4EBBIc4s0B68sk0WPg/BkzgIlcdh9
         NY4NoEXh2YLCLyRuv+pl0WTJwdnw1xetfFpQiFnieAUDmmzYGsRYwdQVgFDbj658v3wG
         aooFJqXRt8UwEIoEUNPaJXJZf70fU8sYAfJPeevb6PnyB4pi8TnDbJiNQxhUap6JBYko
         bo78iyMJeO7ElrY9ltt/NO25YOxdVJF+7oM48xkaCQSEBI+Y9RAIbaBxDjuwB5eHuGZ8
         qqu4TXpFhW8nDIJeIsO5UIJzhnk8Bkns2eq1e5uY7B3s1iLqweGeY9VzfKgG/3SO4zK+
         r+wg==
X-Forwarded-Encrypted: i=1; AJvYcCUoDugXmq6JBF36BiXcbMPIgXd3+eqyExk8tH0UVe6UQm5X7IlDWTJ/GbVnz9Egq3qVRl/obdJZ64W9snV7eQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxKTp2UI7vftTmEkYHKTmx/AQOtqvpbIF7erCgTfwl2Ouaz6L3F
	m2YBOIn1rJoBJeroPKbECcJ8HNNosutONlnESuJs0V4Olj0qkQ6M
X-Google-Smtp-Source: AGHT+IHF+cpsbmeZQPPJToJxbLgArS79LCL4pU5OLVi4da4nP491ue2MxH5v+x0nndQzhkE+PQm0SA==
X-Received: by 2002:a05:622a:401a:b0:446:5952:2725 with SMTP id d75a77b69052e-4604bbb796bmr50897971cf.16.1728688374749;
        Fri, 11 Oct 2024 16:12:54 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b1148e0948sm179121885a.48.2024.10.11.16.12.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 16:12:54 -0700 (PDT)
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfauth.phl.internal (Postfix) with ESMTP id C55321200066;
	Fri, 11 Oct 2024 19:12:53 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Fri, 11 Oct 2024 19:12:53 -0400
X-ME-Sender: <xms:9bAJZ5AfSjHUO9UI9_eAKNqXgNtZ9F71Y5ARybJBsTGdjY_1sYNtrg>
    <xme:9bAJZ3jsoNV8JPUaAWCl05E8BWrDAHkefhg_WtFptPfq5kWtKPuYbXoZ6BQs9Mcuy
    qYKCKlMmyB_lWELVQ>
X-ME-Received: <xmr:9bAJZ0nX-I8XGQzcJlwJhNJE8Qm4UtN23kOU16WVpED7VxBwNk5FIpU3Od0Qfg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefledgvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefufffkofgggfestdekredtredttdenucfh
    rhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtoh
    hmqeenucggtffrrghtthgvrhhnpeekjeelgfeiveelgfegjeeutddugedvfeduveehkeej
    veeugfdvudehjedufeetheenucffohhmrghinhepiihulhhiphgthhgrthdrtghomhdpkh
    gvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghi
    lhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqie
    elvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdr
    tghomhesfhhigihmvgdrnhgrmhgvpdhnsggprhgtphhtthhopeduvddpmhhouggvpehsmh
    htphhouhhtpdhrtghpthhtohepshhtrggslhgvsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepshgrshhhrghlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehgrh
    gvghhkhheslhhinhhugihfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopegrrdhh
    ihhnuggsohhrgheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsghjohhrnhefpghghh
    esphhrohhtohhnmhgrihhlrdgtohhmpdhrtghpthhtoheprhhushhtqdhfohhrqdhlihhn
    uhigsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsghoqhhunhdrfhgvnh
    hgsehgmhgrihhlrdgtohhmpdhrtghpthhtoheprghlihgtvghrhihhlhesghhoohhglhgv
    rdgtohhmpdhrtghpthhtohepthhmghhrohhsshesuhhmihgthhdrvgguuh
X-ME-Proxy: <xmx:9bAJZzysjuhV3ShFdR10bDy8vvxW0R9bBIFvJWNp3FCfb9Zn1WOUbQ>
    <xmx:9bAJZ-QBET_pqahOn7m6nWNNDuDDWC8gvgvHeg7Aq_lkCnLXcjxl1Q>
    <xmx:9bAJZ2ZCBxm3gOBDbH9Ntx6NX_DPZ2N3K9TxDc1dzdz8PhL5JwnMqw>
    <xmx:9bAJZ_R6ZEpr-baA8fj4q_p0ahbvX7udtAYuWnWj0H6uw3sRNF1wWg>
    <xmx:9bAJZ8Be4Oz3gd_Sjdl6J-E3CMBKp-A8J2iRK7r6uFsem-R7aC79j9jn>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Oct 2024 19:12:53 -0400 (EDT)
From: Boqun Feng <boqun.feng@gmail.com>
To: stable@vger.kernel.org,
	sashal@kernel.org,
	gregkh@linuxfoundation.org
Cc: Andreas Hindborg <a.hindborg@kernel.org>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	rust-for-linux@vger.kernel.org,
	Boqun Feng <boqun.feng@gmail.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Benno Lossin <benno.lossin@proton.me>,
	Gary Guo <gary@garyguo.net>,
	Miguel Ojeda <ojeda@kernel.org>
Subject: [PATCH 6.1.y] rust: macros: provide correct provenance when constructing THIS_MODULE
Date: Fri, 11 Oct 2024 16:12:28 -0700
Message-ID: <20241011231228.4070521-1-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit a5a3c952e82c1ada12bf8c55b73af26f1a454bd2 upstream.

Currently while defining `THIS_MODULE` symbol in `module!()`, the
pointer used to construct `ThisModule` is derived from an immutable
reference of `__this_module`, which means the pointer doesn't have
the provenance for writing, and that means any write to that pointer
is UB regardless of data races or not. However, the usage of
`THIS_MODULE` includes passing this pointer to functions that may write
to it (probably in unsafe code), and this will create soundness issues.

One way to fix this is using `addr_of_mut!()` but that requires the
unstable feature "const_mut_refs". So instead of `addr_of_mut()!`,
an extern static `Opaque` is used here: since `Opaque<T>` is transparent
to `T`, an extern static `Opaque` will just wrap the C symbol (defined
in a C compile unit) in an `Opaque`, which provides a pointer with
writable provenance via `Opaque::get()`. This fix the potential UBs
because of pointer provenance unmatched.

Reported-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Trevor Gross <tmgross@umich.edu>
Reviewed-by: Benno Lossin <benno.lossin@proton.me>
Reviewed-by: Gary Guo <gary@garyguo.net>
Closes: https://rust-for-linux.zulipchat.com/#narrow/stream/x/topic/x/near/465412664
Fixes: 1fbde52bde73 ("rust: add `macros` crate")
Cc: stable@vger.kernel.org # 6.6.x: be2ca1e03965: ("rust: types: Make Opaque::get const")
Link: https://lore.kernel.org/r/20240828180129.4046355-1-boqun.feng@gmail.com
[ Fixed two typos, reworded title. - Miguel ]
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
[ Boqun: Use `UnsafeCell` since `Opaque` is not in v6.1, as suggested by
  Gary Guo, `UnsafeCell` also suffices for this particular case because
  `__this_module` is only used to create `THIS_MODULE`, no other Rust
  code will touch it. ]
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
Backports for 6.6+ are already done automatically, we have to do a
special backport for 6.1 because of lacking an API.

I've tested it on x86 with the rust_minimal module based on 6.1.112

 rust/macros/module.rs | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/rust/macros/module.rs b/rust/macros/module.rs
index 031028b3dc41..94a92ab82b6b 100644
--- a/rust/macros/module.rs
+++ b/rust/macros/module.rs
@@ -183,7 +183,11 @@ pub(crate) fn module(ts: TokenStream) -> TokenStream {
             // freed until the module is unloaded.
             #[cfg(MODULE)]
             static THIS_MODULE: kernel::ThisModule = unsafe {{
-                kernel::ThisModule::from_ptr(&kernel::bindings::__this_module as *const _ as *mut _)
+                extern \"C\" {{
+                    static __this_module: core::cell::UnsafeCell<kernel::bindings::module>;
+                }}
+
+                kernel::ThisModule::from_ptr(__this_module.get())
             }};
             #[cfg(not(MODULE))]
             static THIS_MODULE: kernel::ThisModule = unsafe {{
-- 
2.45.2


