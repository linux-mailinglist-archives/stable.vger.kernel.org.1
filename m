Return-Path: <stable+bounces-167166-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DB26B22B0B
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 16:51:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B88851891851
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 14:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BCD52F4A18;
	Tue, 12 Aug 2025 14:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bG/edStX"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7711B2ED860;
	Tue, 12 Aug 2025 14:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755009762; cv=none; b=X7s+jj1WsAiQiKTE+yDesRZaGBCqyw0i9gyEtV1z0JDZyqE8/gWhBNBcTG2tMENuNmlde41XThNIDNwkN8pZ2HbG6u0Vid7oCI74eTkA77VhvoBrBXHpfraYuZwaCUF5A25dtxNiRdv8qKkn80F663lD+C9uq8SXrUGpFMB7xos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755009762; c=relaxed/simple;
	bh=/vfWdDuxS4cmrgYy2Y1FDIhYup6GKzcFqTnOIHVLxd8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oJKMGf1F/+CHIQja6laVVvugYc0t4pbV2EfQRFrIhKB+0VpYQK1QHmu7AJr6b4FCsBl58yFwhvtC5tXi4Y7N2mGBK2CO13MTRh2tfCY/U1h3b/87d1aKwLeHrkVi73o/CeMU3B8YBalahuCHysEMLzYK+scmntXc/pYib/E+llc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bG/edStX; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3b792b0b829so5420733f8f.3;
        Tue, 12 Aug 2025 07:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755009759; x=1755614559; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ksFZyo5Cvq1kE+J4/jOZ7KQ+h5+N9CEPfSL/qK66cWI=;
        b=bG/edStXPlvlIHsZ62KmvCcW/VlFQbYi25vNV72RFY4MGEq/fR1tSWBBtK8w+/fhVJ
         tBx80bY2C0zWgaexKPchTbwEfrqejVa6tT2v/0QMrh9RtISTB0YWva3Ho5sOi45DH5mg
         9ApDAM7tpDrcFQEwuzZTBpAKkWrrWMP+sbG92iPV7SlNiaCVBM6/9co4jGnp8sM1KHzB
         gQbodpr4Lleu1ZS6PnKTUASrbBJ+6SGOOkGhS7omKSJdd9xqQ+ySYmbRlok1/du9b/Qy
         +HHNfoM4ZNegDcpimmZ9wLRTM+LBJ4/PQapcT9ALJ8vtP8otf9M5SAlkyn/5uV6MGRmS
         bl9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755009759; x=1755614559;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ksFZyo5Cvq1kE+J4/jOZ7KQ+h5+N9CEPfSL/qK66cWI=;
        b=A5saCyp0O2E6HUSt6rIosIYmVj5IoTAFRZ1FQvObBmkI55vKRLfQSIrYLxfJZuE7K/
         JqCVhxXvUPtadHIpc1LHV2ppiperUEfhkfcWqKBxodBOAm/8GnVsjaCDmCPZHX+uJ9da
         Pge1PjdZGnRSW/mP3hJ/P73stCL4ARVfufAiyp5edicWF9dJWItHEKzw48nR+WeDswne
         kY8pM1wPFHAr8F9eyTs04OmOIDG0KaRb/TvEEoet5BRgiRA8TDAxjhV1CoY8XGa2rMtE
         46gcMUkRlUyefhqHjxqOqO3hMdHl+Zh5S/xSuU06G5fsl4wZdyESCaLiQkQ2odiUlfQx
         PDkw==
X-Forwarded-Encrypted: i=1; AJvYcCV5sRCmHNMihHs6VMectGaInPT6/bivTtx1DDR4UWT5QqVLMNeqPEO0M5ZGCHuENdy4f3ZzR80D9GV5V1A=@vger.kernel.org, AJvYcCW9iRn09tsp5eiTh74Xik9mY25RC/asEDAihgz2oy7tAfj3d9AqIVNMshUzfoNTP4fABPGhs2iZJmNyW4yStQI=@vger.kernel.org, AJvYcCWN640QD9NZg39ecAlMa1aCxBYQ8oZDa62kYix6i6YMTK/zaRXgIsF7wqP+/ainXgrFvK+8moe7@vger.kernel.org
X-Gm-Message-State: AOJu0YzMjIzQf4Be82icIOoqct62BesrxdCqPFXgJ7f9ofLuhy8iH4se
	VMVbqtzc8X2RErTpweBNP0CvMoKSMBnKkN0QqH6OWN5UMXMg4h1/3N5Y
X-Gm-Gg: ASbGncuKPMmI/l9i2IyzCn/pdAArbxx4yz4OtD9/hBGni8wUxJIn5TlC/+20xo8Yfrm
	yRZKeqW5hwIljo+b7AfRFRu14EkMDSRNsw560kNTN7wgXURIEJ0aQEoKoQPUO0E7mnZT80tbJVK
	cRgv/QlYY8dCKdv8Gzvi7f72xnLaHoJEHGYV/1qvSWw8CDDE3tO/OXGOBHNmXWoFefUeeGOyudo
	Fl3+NpQHCdh+VTnXioOWZOE5Z/nAdH6Mops38RCrYOC99f8g8GYSw3BWb8hBaGKAoBl7+3IUA+y
	j4P/pEdz77p851qJ5iTH6nKREuxWiciLpoCGT2rWLy9NZYoN/pSw1mXjIK2P9MNVeXO3M1WyeEV
	RNrFlW78zIwRsp7t/401c+gGWdLH3N0xiW/3iEQD3rxEK
X-Google-Smtp-Source: AGHT+IHavcYA44T40lCV5RrSKd0V+Intv3acaFD1J/sQ3KPgNjMpYmbIlv1QyoKIG/ybOxSoDeNXBA==
X-Received: by 2002:a05:6000:26ca:b0:3b7:9bfe:4f6f with SMTP id ffacd0b85a97d-3b900b7be30mr13872464f8f.44.1755009758481;
        Tue, 12 Aug 2025 07:42:38 -0700 (PDT)
Received: from blepers-Latitude-5420.. ([213.55.220.53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459db3048bdsm404377165e9.29.2025.08.12.07.42.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 07:42:37 -0700 (PDT)
From: Baptiste Lepers <baptiste.lepers@gmail.com>
To: 
Cc: Baptiste Lepers <baptiste.lepers@gmail.com>,
	stable@vger.kernel.org,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Yury Norov <yury.norov@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] rust: cpumask: Mark CpumaskVar as transparent
Date: Tue, 12 Aug 2025 16:42:11 +0200
Message-ID: <20250812144215.64809-1-baptiste.lepers@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Unsafe code in CpumaskVar's methods assumes that the type has the same
layout as `bindings::cpumask_var_t`. This is not guaranteed by
the default struct representation in Rust, but requires specifying the
`transparent` representation.

Fixes: 8961b8cb3099a ("rust: cpumask: Add initial abstractions")
Cc: stable@vger.kernel.org
Signed-off-by: Baptiste Lepers <baptiste.lepers@gmail.com>
---
 rust/kernel/cpumask.rs | 1 +
 1 file changed, 1 insertion(+)

diff --git a/rust/kernel/cpumask.rs b/rust/kernel/cpumask.rs
index 3fcbff438670..05e1c882404e 100644
--- a/rust/kernel/cpumask.rs
+++ b/rust/kernel/cpumask.rs
@@ -212,6 +212,7 @@ pub fn copy(&self, dstp: &mut Self) {
 /// }
 /// assert_eq!(mask2.weight(), count);
 /// ```
+#[repr(transparent)]
 pub struct CpumaskVar {
     #[cfg(CONFIG_CPUMASK_OFFSTACK)]
     ptr: NonNull<Cpumask>,
-- 
2.43.0


