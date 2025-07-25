Return-Path: <stable+bounces-164754-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DA33B1226D
	for <lists+stable@lfdr.de>; Fri, 25 Jul 2025 18:57:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B925B3BF678
	for <lists+stable@lfdr.de>; Fri, 25 Jul 2025 16:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88C892EF9D1;
	Fri, 25 Jul 2025 16:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="cfWfGWUN"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06CEC2EF655
	for <stable@vger.kernel.org>; Fri, 25 Jul 2025 16:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753462626; cv=none; b=lCMurvOJGGSE4cFMNmzgnugpXpIdzMy4g8kkExqg91kZlhR9L9kb5OWuIstCnvuBAo/2dLeLqlxAyZWgVN0TDmyUErhJL6APzi7M9QFr2UuDlRpFZl1c5j8Oti12zSUZnPwJUm8K83IF+S9FnuNlT8z1EzyoXUebY0Qa/p341OM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753462626; c=relaxed/simple;
	bh=WTVgwj0NqIM1mwrJwTCHrv0cVZbvjmz1jy2rjbVpIak=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BPVL4z7GC0CPODR8MtGh+bWHmvV/4BZilE5kuhdt5S4EYyMAPGVj00CqtswIutamPNGlhHCXKwkp2iVyReASrYpU31qwNhswsxRm9+HKmbBF0ZFcJykrL/mXAKQtbG6B1e3qwQ9paMrirnN5E7zERn65wMAnGKI3XjWufQ+Vyk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=cfWfGWUN; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3a4e57d018cso107741f8f.1
        for <stable@vger.kernel.org>; Fri, 25 Jul 2025 09:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1753462622; x=1754067422; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nu92pVnSGWyGOs+NZnSegiv1w6Yea+eMpYHDq7DsV5Y=;
        b=cfWfGWUNSXG4PBgwbOlFxzs1mSVkaQcosATqwcCYkuRrDWGb802lZsQD+X1VukxNrU
         BgP0Y3vnf40QbQa13mkwO4/NME+/KCvnqxPM4Z2ouC6OmYCYiO2JNbPJs0iRs0TZ6NtS
         80Q/EjgT7lyZaQkiyz9CoMqj5dv5+VfnBb4EZA0asWyhjqadVM1WAvqHXdbpDZnPa8R7
         WbzHwzNdTvO7zaQSSsWDTyl6vVTlLhdINO0+ad41mpESqyDruq0UyCRfA0vXfbNP2vP7
         PUB5xP5MeSSao5QfzDJIV1Q5wbqqgX+FwqyTeZtP1eSpadeurl81q6Iu5Mygk9IkM2yT
         FskA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753462622; x=1754067422;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nu92pVnSGWyGOs+NZnSegiv1w6Yea+eMpYHDq7DsV5Y=;
        b=Yckeeq0ypSIgyjmHfrWjB+T15EuNhpFjdWD1ESiqBrqB9EEZ8zRKtZa3syMrOy9/LH
         aJYmT3k4Ys6hrdmVbsz/OGih/i9O2vt1Ft3xDncoyLCROKuJf2Oeb8GMU3PX7mtmnqpY
         XwcoN4F6wQvNkd1OFt3zAmNm9YTPDBYqVwnCE+d9ZRt8yMIVJF11DXXql23xKLizA0pn
         h0WxGtP1KDFG8Slv3E63eVvC+d/Jw4TcR4fB7PlPwVAF4YyCCspeooCkaW/1eF0eHbec
         fVC9g4SPeUZ98+kST0svI+Unua+E5WZasRqzq3bzoF8DSONMPB5dZOToIQWWpftTXL9i
         jd7A==
X-Forwarded-Encrypted: i=1; AJvYcCXXpMz+pLUe8uH0hXBtrDFwDzbgezYc4dNtu/f4j6pevg6CsGpMlm7Rq2zt1OxI7Sxh/BjRk/Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZb6jCDePvgwpbUG1FhQ9ejfpl2vmIgSbTkCoBjtp4x/T/nPbf
	CB19I0mpSrQJx9xFuk9H6oXvVzqr14Y0jn9D990W9KpjBjNxIB3QMwGOD+rkP9CfEmg=
X-Gm-Gg: ASbGncvWdUyb38kZrHhpvwGC/oBKmJy7ZbNlF78dvd6tENFOlhSXx3O4kTC10MGYlEn
	4oq6XfEj8xCSNgbSLVUZYyhgwGICn7KUCnFCXF5JkTp+UnUit+7m74iqG1Kp0NrfLOgSpMMHn1p
	CRrmUIFVeeR+3Psug3jOhQGmeVSBtoRmro5Johrac8vSzInBfTMLQc6z9yolAec6EFZFJvmux6a
	uwbZFLBrRe4bl602dxkfxwWnJMwLtSpuuy5tELUagRmbySMo01PJMktwaxFkowJM4jEBn9slwwN
	ZLHWm66DOdfC9vH6JcOOrvo6XfWmAVboI7vDmQuu+neol4jfRHVKmTXC5wNBiIZRlFk8OflH1U+
	WHp6AVhbC37fRpwWMcQPyssepQ+Kdyg==
X-Google-Smtp-Source: AGHT+IGLDnI7S2DxdD4vV12toUgj+4yMXj/sNb0KZhkdWDQvG5ZTMV5h/+RVkNNZKk1RId3rYnFmdQ==
X-Received: by 2002:a05:600c:3507:b0:456:4bb5:c956 with SMTP id 5b1f17b1804b1-458766c1d21mr10060865e9.7.1753462622148;
        Fri, 25 Jul 2025 09:57:02 -0700 (PDT)
Received: from localhost ([2a02:8308:a00c:e200:8c15:2281:5347:b367])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3b778ec36bcsm380333f8f.37.2025.07.25.09.57.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 09:57:01 -0700 (PDT)
From: =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@ventanamicro.com>
To: linux-riscv@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Deepak Gupta <debug@rivosinc.com>,
	stable@vger.kernel.org,
	Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH v2 2/4] riscv: use lw when reading int cpu in asm_per_cpu
Date: Fri, 25 Jul 2025 18:54:10 +0200
Message-ID: <20250725165410.2896641-5-rkrcmar@ventanamicro.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250725165410.2896641-3-rkrcmar@ventanamicro.com>
References: <20250725165410.2896641-3-rkrcmar@ventanamicro.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

REG_L is wrong, because thread_info.cpu is 32-bit, not xlen-bit wide.
The struct currently has a hole after cpu, so little endian accesses
seemed fine.

Fixes: be97d0db5f44 ("riscv: VMAP_STACK overflow detection thread-safe")
Cc: <stable@vger.kernel.org>
Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Signed-off-by: Radim Krčmář <rkrcmar@ventanamicro.com>
---
v2: split for stable [Alex]
---
 arch/riscv/include/asm/asm.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/asm.h b/arch/riscv/include/asm/asm.h
index a8a2af6dfe9d..2a16e88e13de 100644
--- a/arch/riscv/include/asm/asm.h
+++ b/arch/riscv/include/asm/asm.h
@@ -91,7 +91,7 @@
 #endif
 
 .macro asm_per_cpu dst sym tmp
-	REG_L \tmp, TASK_TI_CPU_NUM(tp)
+	lw    \tmp, TASK_TI_CPU_NUM(tp)
 	slli  \tmp, \tmp, PER_CPU_OFFSET_SHIFT
 	la    \dst, __per_cpu_offset
 	add   \dst, \dst, \tmp
-- 
2.50.0


