Return-Path: <stable+bounces-124850-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EB24A67BA7
	for <lists+stable@lfdr.de>; Tue, 18 Mar 2025 19:08:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E3A53B34D3
	for <lists+stable@lfdr.de>; Tue, 18 Mar 2025 18:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6281E212FBA;
	Tue, 18 Mar 2025 18:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lI9sD+gr"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE6DD169AE6
	for <stable@vger.kernel.org>; Tue, 18 Mar 2025 18:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742321118; cv=none; b=urGXK3xoM9bYBMlw2x8eoSQmqnTbMi2UO5mBQZixG8YoHBclG/xnE3Rz99Or/1vxNJroQJMEufo2ZyFBxEhD7Rts85fCXcsO2Z2+NGVKct9h+BHGniGZjjYF12A98RFUSfHX9fPDGDaT+cu/8UJRJj8UBDZgFL6v+L21rKk/TaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742321118; c=relaxed/simple;
	bh=CueRC8PJeTB/4IkHMkrVWXgaytvI+cbWyZWFk6bfaao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a4iIa84xHTnC3crCF+TCMyUsg3GhDmjwxzZAtYeaHtb1gGCy+3JZeBxPkCdczYkFeY9tEaC7uRfqkq0EqXT+v5yuM0YReeeUucTcERrdL+dIhJ9XqNOxsFYAZOclUVk/sP//RD/awlc/t656zp5ddUIspxoNvcBgDAlRjzl9m6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lI9sD+gr; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7c08fc20194so1045126485a.2
        for <stable@vger.kernel.org>; Tue, 18 Mar 2025 11:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742321111; x=1742925911; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FjAd8+d/AVUCTr0AtzBX8UuIIEKWtuWipcfyFxs+Bpc=;
        b=lI9sD+grewqcn6gHbjTBlKSOTMIpceDnQb3wLDCYDsdOmvFPz2LZTBuoxDIVvpIt9E
         2c8RNFCAhArPgYzoa6rqwh4fuRkSdJVq2smthsge3qscKYjud6PuOJw+MpYakivV8Vkt
         USm+CDgwKx/72pYJpMJAy+F1DBsNFMsIFB41OKwd43vu/n1J7oQWVhVPKZJDm05tAiX+
         0gLX9joB6sthNU3bnJjqZeQqDyA6xbG/rVdK6466pZg+HfLo3XQ3IoSiOmNILYuwqquM
         rXTYn91DpuE/RowlOnkXlWuwSqrCBxyb1etm+5DmlaG6BqqvX5rVr6FMLvuIitUvRviV
         nybA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742321111; x=1742925911;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FjAd8+d/AVUCTr0AtzBX8UuIIEKWtuWipcfyFxs+Bpc=;
        b=vMfa/HaW+iLwmGzmekT9oghMiNm23rlXFHI8alyzq+P8KHmT4RyPdtOMdh0BYf+qP2
         bm/GFvYd/W5Zp1xz2TsDG2HqwAt5Gaeaxfxs2QmXF+GHtkIhW9c4YxbvEviNSPZtHHGV
         +sDYDGTcuQKNoYGGniveiQceEbkQ8KSWWicyl75HkZZ/Dz46M2Z5NDOxk32i51c2shuF
         VvvlnmIe/noXV5wuJdbEiOqiPuO30Zop5Vi3xcFm7igIDpQS0dWLtx+mZJ94n1ij0Pyx
         aO8h8Cvl7R5Q0BVMt/W4B09q7a70xYV7OD3ioYC6JOpGZyJ/JBi7nnZ1MmDyvwwZ67up
         nCbQ==
X-Gm-Message-State: AOJu0Yz5mqbKJ/0iJlznbxY8cN28pAPpLP49qzglReHOk+ER9p6cC7/5
	jiUKihVOVvMgc4q4FBqxTOEcPQ1DkWhMOR626P5+1Z1NsUmiB0tY
X-Gm-Gg: ASbGnctXQgUzxAOgppjrr0r2qRGBOppI3B453ENr7kXzLP5RbNBYpQ351n5uPVmmjEa
	OsWitNBt52STg1gc2OLIIp2wQh2RYV2fQF+nernS4tRQfNLDt12BgcaaSFz4DAEJTzx1eSj4FvA
	ZsjezyQtIWhp+LywVitmXnFWWdR1O8jPDlMipsG01GMlK7DYKlPLXrtKkZEltr8eTN8pEjTs2zM
	EoKF3JVULT37RkQfSZ+uobDlddHkuQg9KY9rwZm6l5S6gCFPXUJqZqfHuVXUkY6jApEM+P0blux
	ufJ3NPibrW6Jk77BEhPSqitrFgQxoJDyCDh+oBobaJJyNMSG4vLzo5J51PjMloTFMuL1qV2bIBm
	qwTGBDFUe2iibwTt3w7IThmKAaxG2SniT6zE=
X-Google-Smtp-Source: AGHT+IEniY+GkXyMMQxSHJf4Xbbj48xZ2u24Fe8yWLt+K56YL/zNLr+gtzVJggq4ZG8sp5eyCpiHHA==
X-Received: by 2002:a05:620a:1a0e:b0:7c3:d5a4:3df3 with SMTP id af79cd13be357-7c5a69320a2mr20534485a.34.1742321111418;
        Tue, 18 Mar 2025 11:05:11 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c573c545c5sm751305185a.21.2025.03.18.11.05.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 11:05:10 -0700 (PDT)
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfauth.phl.internal (Postfix) with ESMTP id A4C3D1200075;
	Tue, 18 Mar 2025 14:05:10 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Tue, 18 Mar 2025 14:05:10 -0400
X-ME-Sender: <xms:1rXZZ3ubPFAnVnJTYBiUJVcZsNfawwLJuLE8lsk9C5Ad5nECVfCQCQ>
    <xme:1rXZZ4fR2OTZ3qZLRrlsfJj8cEORExgDjcP7C92it7_Wr6rQgWyvasP45DhV7R-jV
    OAhZbqgvdCm5kwaZg>
X-ME-Received: <xmr:1rXZZ6zYZG7frSAPd6LAbL9YaWvP5sPb22m9i2vew_HI7nqdGPyTV00txpNQpA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugeefudduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvf
    evufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeeuohhquhhnucfhvghnghcu
    oegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrthhtvghrnhepgf
    fhffevhffhvdfgjefgkedvlefgkeegveeuheelhfeivdegffejgfetuefgheeinecuffho
    mhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgr
    lhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppe
    hgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohepkedpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtohepshhtrggslhgvsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohepghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhn
    rdhorhhgpdhrtghpthhtoheplhgvvhihmhhithgthhgvlhhltdesghhmrghilhdrtghomh
    dprhgtphhtthhopegrlhhitggvrhihhhhlsehgohhoghhlvgdrtghomhdprhgtphhtthho
    pegsvghnnhhordhlohhsshhinhesphhrohhtohhnrdhmvgdprhgtphhtthhopegsohhquh
    hnrdhfvghnghesghhmrghilhdrtghomhdprhgtphhtthhopehmihhnghhosehkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehojhgvuggrsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:1rXZZ2M1DsfLLOl_SCvc8X9PWAggGGvLfO5Qsi7WcK_C5lOJz1IZYQ>
    <xmx:1rXZZ39xi9JWJh-EPrTYJPUWxkNZvhY1sbEfm2_dX5iSBf6l7h-Aqg>
    <xmx:1rXZZ2UJUjG63b8_mP5yPuT_nZ8iK2U17BBFOxqBZC0ZmCSpcH45Sg>
    <xmx:1rXZZ4dPGGZyw4YPsCMGjCHDfKa-H3BNqkLa5TeoKwyGbwoIVxj4NQ>
    <xmx:1rXZZ1fz8brr-UKMXnwqInm7fo-iLWZ4RJHm8_ROS1RRKGY4IliTvdz8>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Mar 2025 14:05:10 -0400 (EDT)
From: Boqun Feng <boqun.feng@gmail.com>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	levymitchell0@gmail.com,
	aliceryhl@google.com,
	benno.lossin@proton.me,
	boqun.feng@gmail.com,
	mingo@kernel.org,
	ojeda@kernel.org
Subject: [PATCH 6.6.y] rust: lockdep: Remove support for dynamically allocated LockClassKeys
Date: Tue, 18 Mar 2025 11:04:47 -0700
Message-ID: <20250318180447.4958-1-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <2025031632-divorcee-duly-868e@gregkh>
References: <2025031632-divorcee-duly-868e@gregkh>
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

Fixes: 6ea5aa08857a ("rust: sync: introduce `LockClassKey`")
Suggested-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Mitchell Levy <levymitchell0@gmail.com>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Benno Lossin <benno.lossin@proton.me>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20250307232717.1759087-11-boqun.feng@gmail.com
(cherry picked from commit 966944f3711665db13e214fef6d02982c49bb972)
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 rust/kernel/sync.rs | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/rust/kernel/sync.rs b/rust/kernel/sync.rs
index d219ee518eff..8b40589b1028 100644
--- a/rust/kernel/sync.rs
+++ b/rust/kernel/sync.rs
@@ -26,11 +26,6 @@
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
@@ -41,7 +36,10 @@ pub(crate) fn as_ptr(&self) -> *mut bindings::lock_class_key {
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
2.48.1


