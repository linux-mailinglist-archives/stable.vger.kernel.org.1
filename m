Return-Path: <stable+bounces-76540-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A737397A9DD
	for <lists+stable@lfdr.de>; Tue, 17 Sep 2024 02:11:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D1D51F26A79
	for <lists+stable@lfdr.de>; Tue, 17 Sep 2024 00:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 549B17F6;
	Tue, 17 Sep 2024 00:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MEm1qqLW"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D00B4C7E
	for <stable@vger.kernel.org>; Tue, 17 Sep 2024 00:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726531873; cv=none; b=Q1zSG55wiNoTy/cS12qMLE4LhpSZ5oS8GQx/YTS7vNWRWLTy3NjUwZ3lrxwbCVl4X0qsu34hhn1thCSMufBdqJ18zJQyGLu3d2iRh0I6BxkUchU6uCakxCht4TOGIiZb8antvt6PeE7bVW8q4cpnwfaN6tKewG1P9wqN1DHjh6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726531873; c=relaxed/simple;
	bh=W56FUMR9QIT0LTtxeEn0yFfK/pN99UsZE7+uyX1M+rg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S4PbqfanWSYpjJ37Y79zEyFgygwaYMODZq7tx+4rlTuUkhQfGxZZn4IL4svT3CIoFx1rSloLBOexMaALHkCLJ3l3GBzkSQS1Q2zrjRBAIz7WARTEGzjsh+RHXLpgGfFrlrqV2rdJZDwrNohWwFK0wAfe4uOdOS20NRT86mlnwdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MEm1qqLW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726531870;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P3XRknCuZ+rddMbA9raqM8xFOQmhedysMspZNVnmtig=;
	b=MEm1qqLWC4o6AMm8LBw7NSy6E0Smn6nIhEK0y/CLWiJA4QA8P5nYE1geja1OA4xOdAiWkP
	PLRQN8k+h+B2XjNbZdbma9t6sJBs0DbjabUuPlGa/JN5OWcnBZoh3RztgV2Sbc9ZLR6rdu
	peFgcbgr2o0agxJ5D09pUFFG6zIHI14=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-13-6lW8Zrn7MMGYTKVrQHURWA-1; Mon, 16 Sep 2024 20:11:09 -0400
X-MC-Unique: 6lW8Zrn7MMGYTKVrQHURWA-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6c517e32a97so94441176d6.0
        for <stable@vger.kernel.org>; Mon, 16 Sep 2024 17:11:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726531869; x=1727136669;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P3XRknCuZ+rddMbA9raqM8xFOQmhedysMspZNVnmtig=;
        b=Vxe4zJTZM05MSEeg//uQkfFKcZI5Fppxjud/htYe/QMcM1QcWyiyA6MaZ4wzBs1Yzx
         whYjr/KZ0uzM72wzEshVMepmN2KqF09+S/nDXVj5S8FJa//dZK6wGjaos9vvOkNXaGXb
         s/sNfOrCwN5FIGj2P++UJ93ub1CURC23PzrPMupeLDPzmNLCu8o5PwdjVwdfpHw07Daq
         1AZ2IlHGD2uJuhxC++Mv9qJ2pQCtZlfEjp4pHHfMbMdZ0TttJKyRYqThihYCxsqPsx/D
         TcTNwrQOcN0yJriBlW82TX3sSvm67hp30VwIumTsfQ8t1eGrXenepy/6dfFhKTfYDH9h
         TZ4g==
X-Forwarded-Encrypted: i=1; AJvYcCXZ950HkYESDohtbUuDZPjWJlW39gniBOzCQFirWuFnuKttd6flL+fDIiep6puOTby2vOzALLo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwU9Cq0BzQLW6p+fqfx7l5fQWtrIAT02//UScvxzQhOLSPxFKgu
	lwOhLqwKfx1/AvEq+EnrxJS6tVPm5e7AIJ+8mHByPjfGhxm0JusxQ8rhhUcXfQZttXE5bbgoxbq
	57i6BmQfYuGWrOdlJE5ap3k2/iqXuLAg2YQ2RkCYe2LtRnmCQ/eP2Dw==
X-Received: by 2002:a05:6214:311a:b0:6c3:5496:3e06 with SMTP id 6a1803df08f44-6c57350b986mr276808276d6.10.1726531868919;
        Mon, 16 Sep 2024 17:11:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEHnGglfemeo+Af3oezjiRWKnnZJZ0HiOz3D898c3WHVJObvGXlST1AzNl9ohW/gu5HlG6/gw==
X-Received: by 2002:a05:6214:311a:b0:6c3:5496:3e06 with SMTP id 6a1803df08f44-6c57350b986mr276807636d6.10.1726531868420;
        Mon, 16 Sep 2024 17:11:08 -0700 (PDT)
Received: from towerofpower.montleon.net (syn-066-026-073-226.res.spectrum.com. [66.26.73.226])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c58c62633bsm29221956d6.25.2024.09.16.17.11.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 17:11:07 -0700 (PDT)
From: Jason Montleon <jmontleo@redhat.com>
To: ojeda@kernel.org,
	alex.gaynor@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	benno.lossin@proton.me,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	nathan@kernel.org,
	ndesaulniers@google.com,
	morbo@google.com,
	justinstitt@google.com
Cc: rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	llvm@lists.linux.dev,
	Jason Montleon <jmontleo@redhat.com>,
	stable@vger.kernel.org
Subject: [PATCH] RISC-V: Fix building rust when using GCC toolchain
Date: Mon, 16 Sep 2024 20:08:48 -0400
Message-ID: <20240917000848.720765-2-jmontleo@redhat.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240917000848.720765-1-jmontleo@redhat.com>
References: <20240917000848.720765-1-jmontleo@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Clang does not support '-mno-riscv-attribute' resulting in the error
error: unknown argument: '-mno-riscv-attribute'

Not setting BINDGEN_TARGET_riscv results in the in the error
error: unsupported argument 'medany' to option '-mcmodel=' for target \
'unknown'
error: unknown target triple 'unknown'

Signed-off-by: Jason Montleon <jmontleo@redhat.com>
Cc: stable@vger.kernel.org
---
 rust/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/rust/Makefile b/rust/Makefile
index f168d2c98a15..73eceaaae61e 100644
--- a/rust/Makefile
+++ b/rust/Makefile
@@ -228,11 +228,12 @@ bindgen_skip_c_flags := -mno-fp-ret-in-387 -mpreferred-stack-boundary=% \
 	-fzero-call-used-regs=% -fno-stack-clash-protection \
 	-fno-inline-functions-called-once -fsanitize=bounds-strict \
 	-fstrict-flex-arrays=% -fmin-function-alignment=% \
-	--param=% --param asan-%
+	--param=% --param asan-% -mno-riscv-attribute
 
 # Derived from `scripts/Makefile.clang`.
 BINDGEN_TARGET_x86	:= x86_64-linux-gnu
 BINDGEN_TARGET_arm64	:= aarch64-linux-gnu
+BINDGEN_TARGET_riscv	:= riscv64-linux-gnu
 BINDGEN_TARGET		:= $(BINDGEN_TARGET_$(SRCARCH))
 
 # All warnings are inhibited since GCC builds are very experimental,

base-commit: ad060dbbcfcfcba624ef1a75e1d71365a98b86d8
-- 
2.46.0


