Return-Path: <stable+bounces-76541-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BD8B97A9F9
	for <lists+stable@lfdr.de>; Tue, 17 Sep 2024 02:31:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23387286A11
	for <lists+stable@lfdr.de>; Tue, 17 Sep 2024 00:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D15824A2F;
	Tue, 17 Sep 2024 00:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JQvqtj22"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4A5A48
	for <stable@vger.kernel.org>; Tue, 17 Sep 2024 00:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726533094; cv=none; b=ugPZLngy9zCfF03d9mMvuBmiJLO6LnkQqEhmQw5rJ0eV7zDtYKP74keGxqEL0PBWhM1cAkH8PW7nrqrYb+4L/A4qlNftjpXKrhjZg0KEj4bdQ/pmUjd7tqWEE5S4EJNNZjlr8pWiMTdUyQqcIT0r637GacSBtTig43NEKgpjg9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726533094; c=relaxed/simple;
	bh=80vqc1h5k7QtbNAI9S7XWwwbt2B/2ScQEoMPE7fX1uA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YqoOETTaMnjxsRJK3Ykc95vnI4MahYU+TiZMYgSVqtigZFWOJqLko1/kAtSAlsItIyqBzlTp/rFA+TrTJaFTUVksfdpwFZd3vXbwDL/srVqPp6ZrEC8o8jveFvOK+BfMuv/qf6cbajP2PPIlpdTirnVrs1dS8FECRra0NKxDd3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JQvqtj22; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726533091;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YTrfXOeRwBkIVUBR9O4O2yoB1GQ/xZoXRHhKkvHx0gI=;
	b=JQvqtj22KWpSaOB/5Ttmqi+BLymfFRDyfduuRJLOO+cpgxUbf0n/KlqsyQcw83ZOflD/JN
	5NJovCGhv5h8hZEDuBRAmVXVsz5apdCpIgtoByc2MlPq0isC2Q+r3vLVDoiYdOdksO59w8
	L8WpgX1MkbenIzNn1pgZv9cA0v5HcaI=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-478-OKmzecTyNkOyxbbfXYTkhA-1; Mon, 16 Sep 2024 20:31:30 -0400
X-MC-Unique: OKmzecTyNkOyxbbfXYTkhA-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6c517e32a97so94670916d6.0
        for <stable@vger.kernel.org>; Mon, 16 Sep 2024 17:31:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726533089; x=1727137889;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YTrfXOeRwBkIVUBR9O4O2yoB1GQ/xZoXRHhKkvHx0gI=;
        b=Ruimaw6XHylcCQkw/sMr9Ut8+dfDExgaFCtbSxFm21FQT+esn2Gga8CaYNSFh2CUPn
         laTki5OLRbqQCbls2jLD31gk0b5NZ2k+QGJdNGikm8uPKNWnHtdhAG3jIm25+oOovoj9
         BfKeGnSvwBGNkFhEZSzZC/6NPqbn+hKOFp0GdKBBkxFRGvcWLGRUrQhtKFyXdmO1qaqA
         0fLoa/4zLI2LZV7sajyr4MnVctiR5fL5GG109yz8/vNFzBG0nUTklY0Vt1cAjSZQ505P
         cZ8dopDzeZ2hVrUe8qKK+brbA9+yuUF9G3BC+OwIRWZFntAjJ7SbdJPItP6TeS7WbHR7
         T+pg==
X-Forwarded-Encrypted: i=1; AJvYcCWU2TMEVjS8bGrKMYbXEIiOS2+fzYd6sMKv09ZaKDobfct5LJTLOouXaKkr/zl86RtPFX2AQeQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxL/Ra7Tjxp4QPx0O8QzfRIbBn+xmDzpNuHTFwLhNBoRBC757lq
	rHoZMn07GyMvfPQzEIO5ZDfyQq0vx/rhaaul7WNdILYZ7lbalR1+bIJ5mMT/ruww58f91EmDjn2
	ojbGu7MppF4+diSbWhiFKtjwdxRiv4GtYoqHYDVz/CFHV6LvIh2rSBN7A8XLk6YNs
X-Received: by 2002:a05:6214:5b86:b0:6c5:4b90:b5ce with SMTP id 6a1803df08f44-6c57352f5eamr266133836d6.24.1726533089640;
        Mon, 16 Sep 2024 17:31:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFo7WVOhFAZCy7dJKRN2IgQWI2V62itbEidTmQgeCNcgyiTCHaVeu04ROWhSObSJxOIeCYJpA==
X-Received: by 2002:a05:6214:5b86:b0:6c5:4b90:b5ce with SMTP id 6a1803df08f44-6c57352f5eamr266133546d6.24.1726533089160;
        Mon, 16 Sep 2024 17:31:29 -0700 (PDT)
Received: from towerofpower.montleon.net (syn-066-026-073-226.res.spectrum.com. [66.26.73.226])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c58c633343sm29342076d6.39.2024.09.16.17.31.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 17:31:28 -0700 (PDT)
From: Jason Montleon <jmontleo@redhat.com>
To: jason@montleon.com
Cc: Jason Montleon <jmontleo@redhat.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/1] RISC-V: Fix building rust when using GCC toolchain
Date: Mon, 16 Sep 2024 20:31:18 -0400
Message-ID: <20240917003118.722365-2-jmontleo@redhat.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240917003118.722365-1-jmontleo@redhat.com>
References: <20240917003118.722365-1-jmontleo@redhat.com>
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
-- 
2.46.0


