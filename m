Return-Path: <stable+bounces-169535-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2394B264FB
	for <lists+stable@lfdr.de>; Thu, 14 Aug 2025 14:07:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF2917B6E10
	for <lists+stable@lfdr.de>; Thu, 14 Aug 2025 12:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2456D2FC89D;
	Thu, 14 Aug 2025 12:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="Uco0q+ye"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2954B2EA72D
	for <stable@vger.kernel.org>; Thu, 14 Aug 2025 12:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755173213; cv=none; b=qs69U66rM9s6xYPTSswBcIocOu8gWyAYZTMUvFzhhCHZ2D9mHWhDg+EuQySrVm1KrEiNGObhZbCld19R4UxgaWp9jkqVsYilUlXoHi/7kYtSHyNoaHB+2QsU1J+S4HPcDzqqBZKD3DrBYwKuXvm7/8UUrd+XL/SJQUxQ5EFZG2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755173213; c=relaxed/simple;
	bh=wiB//OFp2BrFQuwN6BZWO5CNv4TW0Uuh2XVDxdHzt2g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=V+nKfmZvjzO7A+2N0qXBrXP4UXRgTmML92+x3inp+/EHpn5uHkUzzlMC7bcIHE57TFGlqxf+U0nzyEJ1TgRMRxEyHCsheLR0xEwVhlVz7vw+ABoe4Bij9EdL6l54E1SayhqyimvRHKukF6aWpFcGSatV+npPjeoxDYC6NURg2uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=Uco0q+ye; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-323266cb393so946178a91.0
        for <stable@vger.kernel.org>; Thu, 14 Aug 2025 05:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1755173210; x=1755778010; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uVJEHbwUiQHMVs0nBo4suasLYxYlbOfnqJ9z6JjAl18=;
        b=Uco0q+yevvvJ8ufD9rEQuGtsN3P8qyXinaF7KujzHsRwdtEuyquqqlpxeOWlMypvWu
         W6Kt0vtiPtxKAz6ugQfq3PKTpHoQPRXsaJL+nLYUHUn6wuw4VjLdHVJfqctUDBdEgS/e
         Hirv0SSS0iwxxtT6yijbUGUCoaFo8RIrnAzqjRjs6++iwxbJ7qm/InT3fmlAUN4SE3ZN
         En/n9oqOzmz3aXpdpdOAn4vNBFeKUFd8KlZhyZ3F9to4zCbRn6BYFym68oLcOKnOvrFH
         p4Khorzzm9NksDwbB1yDo7JAvjlotvYqdmecndy6g4vU5RK/G1JLtulyVIw9ksoQR6Sp
         u6NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755173210; x=1755778010;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uVJEHbwUiQHMVs0nBo4suasLYxYlbOfnqJ9z6JjAl18=;
        b=Nw1JH48YrCay5E/iJcD2liWQeIHEVsUf3HH5kBuGziMwQyALnYfao0Y84X+MdIQ9tL
         mExvZZBoThXNcEoR3X6zB0yTBL3MvNVnDYqFshLeQpACZajEiYNralF8zwKR2dkdZL4V
         En07KlHgjSwvvXhfCqP67QKf1fe6U1WhuZifL5r2Xm/wB+3fdbHJaR0J53UtPAxt/4hr
         8EYj6SE00/evASOUAK3Avn+EczrZPfChkX+YCkzvfl5Ai7odoO1DIWUF0qHZ+cLVtlID
         ZPgNAaD8WSKkdWlsXosyj7nLPJUEZf0H93t/J75e8gID/uC7p7XQPnIVN21yBaTbO+hg
         F+tg==
X-Forwarded-Encrypted: i=1; AJvYcCVlAtnZHcJ5bEFBvZK2CdC0TbGZ96UZ3xEC9oOIsVan4wNa87Qs1NAxG9ozHMM9L70mzk/ZYMM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMBs7BoKYHT5QiYDzHKTVoljLgkdS1PWmJfYs0oEir8ZrGkmhd
	tzx3GlmzqVY3GY4H0D55fMLu65IPQZxLysmWra4bMnZqwJb0GA7tTnbW3qvaZCjkn6c=
X-Gm-Gg: ASbGncv7Vtx9+VSLaMvQSTi+XkhNt6A2Oid7k5+VxWAkzwrd0b/P+RgcSxehpjaH0tI
	g1wR6eVO1uoC8K9HMymALMNQfd0LcwwfDBi3ShM4A1grNk9VC0UMrcrSbuJWambclPk7k/cXj/g
	C85PyKqTjdkmO0t/AUzz53J3qvXDXxlCH9oE/AF4rLuaiICF7zKi0UABWp7Rvvp1aeSbKpRml7a
	KZT/lSS9gEGabeEI7evXnboc6JeAGNdnpnys2MSjIvdWNZZDhw3GBoAYp9xDwwrg4HMUNlTXTOI
	eA8ffYfOFud92efa9tYLOID/yav7kvi0UWH40qCUKTECLffU7pYzo7v8TMTwg0EQpNqh4I0fG0J
	TWUyMktyBSn4Agj78Z7PI6gaHcFyJqq5EmvOCKmjM1RtFWEovwZGPqPt9JQEHTPf4WDlKiQ==
X-Google-Smtp-Source: AGHT+IFEAHkPnfRIgoDwjDPEfLaXInGcoKVU6vuvYGC8vXWNCk2KB5smgVfxup0qNj0vfsNR8sfSYA==
X-Received: by 2002:a17:90b:3d8c:b0:31e:7410:a4d7 with SMTP id 98e67ed59e1d1-32327accc9bmr5541078a91.33.1755173210426;
        Thu, 14 Aug 2025 05:06:50 -0700 (PDT)
Received: from alexghiti.eu.rivosinc.com (alexghiti.eu.rivosinc.com. [141.95.202.232])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3232f8c8e4bsm923478a91.2.2025.08.14.05.06.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 05:06:50 -0700 (PDT)
From: Alexandre Ghiti <alexghiti@rivosinc.com>
Date: Thu, 14 Aug 2025 12:06:14 +0000
Subject: [PATCH] riscv: Use an atomic xchg in pudp_huge_get_and_clear()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250814-dev-alex-thp_pud_xchg-v1-1-b4704dfae206@rivosinc.com>
X-B4-Tracking: v=1; b=H4sIADXRnWgC/x3MQQqAIBBA0avErBvI1KiuEhGhUw5EiVYI0d2Tl
 m/x/wORAlOEvngg0M2Rjz1DlAUYN+8rIdtsqKtaV61QaOnGeaOEp/OTv+yUjFuxFVoaKaTtVAO
 59YEWTv93GN/3A4nQqbBnAAAA
X-Change-ID: 20250814-dev-alex-thp_pud_xchg-8153c313d946
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Alexandre Ghiti <alexghiti@rivosinc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1490;
 i=alexghiti@rivosinc.com; h=from:subject:message-id;
 bh=wiB//OFp2BrFQuwN6BZWO5CNv4TW0Uuh2XVDxdHzt2g=;
 b=owGbwMvMwCGWYr9pz6TW912Mp9WSGDLmXvT/2sjZzsLpbla9zt1RuuD5t94w2cMrAiYbPNs49
 c9vRsYXHaUsDGIcDLJiiiwK5gldLfZn62f/ufQeZg4rE8gQBi5OAZjIyyMM//1mHIl5e/635P6/
 pQ/FNQKfHZd/Ja4ac2j/y6McX6b1rhFkZJhk8vpp7+FXXZc0rvpcrXQS7NPLM3TaFGYw/3j4Sov
 1HpwA
X-Developer-Key: i=alexghiti@rivosinc.com; a=openpgp;
 fpr=DC049C97114ED82152FE79A783E4BA75438E93E3

Make sure we return the right pud value and not a value that could
have been overwritten in between by a different core.

Fixes: c3cc2a4a3a23 ("riscv: Add support for PUD THP")
Cc: stable@vger.kernel.org
Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
Note that this will conflict with
https://lore.kernel.org/linux-riscv/20250625063753.77511-1-ajd@linux.ibm.com/
if applied after 6.17.
---
 arch/riscv/include/asm/pgtable.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 91697fbf1f9013005800f713797e4b6b1fc8d312..e69346307e78608dd98d8b7a77b7063c333448ee 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -942,6 +942,17 @@ static inline int pudp_test_and_clear_young(struct vm_area_struct *vma,
 	return ptep_test_and_clear_young(vma, address, (pte_t *)pudp);
 }
 
+#define __HAVE_ARCH_PUDP_HUGE_GET_AND_CLEAR
+static inline pud_t pudp_huge_get_and_clear(struct mm_struct *mm,
+					    unsigned long address, pud_t *pudp)
+{
+	pud_t pud = __pud(atomic_long_xchg((atomic_long_t *)pudp, 0));
+
+	page_table_check_pud_clear(mm, pud);
+
+	return pud;
+}
+
 static inline int pud_young(pud_t pud)
 {
 	return pte_young(pud_pte(pud));

---
base-commit: 62950c35a515743739e3d863eac25c20a5bd1613
change-id: 20250814-dev-alex-thp_pud_xchg-8153c313d946

Best regards,
-- 
Alexandre Ghiti <alexghiti@rivosinc.com>


