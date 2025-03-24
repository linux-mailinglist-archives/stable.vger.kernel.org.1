Return-Path: <stable+bounces-125956-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE2DFA6E24C
	for <lists+stable@lfdr.de>; Mon, 24 Mar 2025 19:32:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 185D23AE0EB
	for <lists+stable@lfdr.de>; Mon, 24 Mar 2025 18:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6BF21993A3;
	Mon, 24 Mar 2025 18:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="A+dKL14N"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D916FF507
	for <stable@vger.kernel.org>; Mon, 24 Mar 2025 18:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742841116; cv=none; b=KIQAOuyNu3xyVWOobOqm/HSrDxg8Tuw5fpcqXSkaW6Xs6FdsXiDraMhEzy+pNKW0DtBEkDKSRVXj0geWKmTLLMneKsg8MljQdHj7/5MogRvyV8EDHGYrcI3fZgONhvDqbcxncfRL3g7LvHixyX/cI8EvZKJmXIuxTI7/EfixcBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742841116; c=relaxed/simple;
	bh=Rd9f1W4SUoTIrQdR8+hMtMIoh7qDTbEspD3QsW+JBi0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=N67Zhzh1PYhNpRcgBgDc2jdBLGSMGXwB9TGgYpqHondDBlb6yloFh5WQLtfzOhPOG+VrkQ6NztV9f/PPqmNmTsi0n3YE+f0tlUTe9WXztxjl0FItY5y1Wtm3f4IQQGciGMIrhZcG6qXN+tsHGYMRlaTiKIPZBwl1Cg8vEuV+mno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=A+dKL14N; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3913290f754so660421f8f.1
        for <stable@vger.kernel.org>; Mon, 24 Mar 2025 11:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1742841113; x=1743445913; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=s1yQlub4UdGmwkrMUv8AADmJGdzZU0hE4K3hK6gkYrM=;
        b=A+dKL14NdJlTOxlV4vIEHNF+kkgpOxzb9GfeljOfcQ/biW/XqO1HH0xA62R5+JSndX
         K5A8gRf1lbARcP5z8ISmU4wSt25DL+ZZZgOBViT9nUEJWXtln4AU1rBPjhB5swU2CY+S
         ywUtToCZOyLmrCqv8X6iZbwVyLW5phqW8GoyD4r+S7u0FdbBvztBt/U+AncKfnIeromJ
         lnxyWEBn/KtzxOmrjwaX+tEeXhTxdbRYjjBoHcgkQE564Ft2RPx5fqMzc0zswze6G4uU
         mw1rQJ56JlxCwnxgo9/N6zdcla6yFvTTFjDlIJxi73KpLOehNuvcMOanU5iXpErg2kdf
         4bpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742841113; x=1743445913;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s1yQlub4UdGmwkrMUv8AADmJGdzZU0hE4K3hK6gkYrM=;
        b=m8lW4BScWVtwUtvDkCasGHLOvGI7bRh8vlERNqMID6KKO9014Do2TxDa1BuxD//n4n
         FeOMrDF/DffWM9b3nqztEgPsuXGdbm3oYwN/GxWv33I/mygBgjkrEknZJA5pmV9REy9X
         PjiANzKqXE27vX3w1mKNnzgOoMQce21zBuuQdqvNXP297D6vsY7wfWaXhDYB6sQ5u1M5
         90DGU218OrIR6EzCJS3BmGIReaX2EJyEKXjmEcfprN1CYqJUXkXQSelfnGH4hDirLEIu
         6lLTluhqhS2YfEnQukZt7bjn+IBcrot6fnPyzXZia0blkcs+Pc1gwErUh37TaRdqHCJx
         ZBlQ==
X-Forwarded-Encrypted: i=1; AJvYcCWv0egbwGds/BUkFmgL6Nd1G+LlqnkG7XJePThfGq6Zc4YrOQt53Tw+vil+4gP0CzFR+FkhmEU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYPD2XuXVVJGP17Gv+RwjLs6VlYqabJftffiob9cE0nssaxmb4
	Fv40yrWG47JP372vsecZWr3evQcodAJPFZqb9uQUKv/Ayumr5s/pWvVlEfxOT40=
X-Gm-Gg: ASbGncsQpnek0afhEQLpdBJF7qjcVDS4gvtp7Kv4YzBh67oeps0hfOW2mpL6FxJY+lF
	/AOC9PXoYjSHNb0N4fueSgds3Im2uL1nS8FZfnkGH7PDSUQUsVrGCax/uTG6Jd8INyKlGaFhE4U
	YFxZoZdY5V1bmOo++Ko2WYSnE1cEvtKl5p3ou51YxH0zioDJSywFSDFkSPQjKe0Cw7pSboGoUH0
	NhQY6vPuWYtu11+TaIw4PX6tReOWAavCkatg8k/3CbbFATYElyMkiGwLJwR3dvgxGcseOQwB2Hw
	tUgqy4m/C7p1SBOIIB3atGFutuYUO7zCRXwjD28yWAaHW3BEBRkW
X-Google-Smtp-Source: AGHT+IE9v8F78f/HQFwsh+bXXo2tcFdaV4BstEJx4mi3doJWf2aCSypK98C6M4tA5dxJYVwLRCfWqw==
X-Received: by 2002:a05:6000:2c8:b0:391:320d:95de with SMTP id ffacd0b85a97d-3997f8fd165mr4955100f8f.4.1742841113007;
        Mon, 24 Mar 2025 11:31:53 -0700 (PDT)
Received: from localhost ([2a02:8308:a00c:e200:88bb:b389:fb44:fa3b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9a3f6bsm11877289f8f.39.2025.03.24.11.31.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 11:31:52 -0700 (PDT)
From: =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@ventanamicro.com>
To: ventana-sw-patches@ventanamicro.com
Cc: Anup Patel <apatel@ventanamicro.com>,
	Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	stable@vger.kernel.org
Subject: [PATCH] KVM: RISC-V: reset smstateen CSRs
Date: Mon, 24 Mar 2025 19:26:30 +0100
Message-ID: <20250324182626.540964-5-rkrcmar@ventanamicro.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi, I'm sending this early to ventana-sw as we hit the issue in today's
slack discussion.  I only compile-tested it so far and it will take me a
while to trigger a bug and verify the solution.

---8<--
The smstateen CSRs control which stateful features are enabled in
VU-mode.  SU-mode must properly context switch the state of all enabled
features.

Reset the smstateen CSRs, because SU-mode might not know that it must
context switch the state.  Reset unconditionally as it is shorter and
safer, and not that much slower.

Fixes: 81f0f314fec9 ("RISCV: KVM: Add sstateen0 context save/restore")
Cc: stable@vger.kernel.org
Signed-off-by: Radim Krčmář <rkrcmar@ventanamicro.com>
---
 arch/riscv/include/asm/kvm_host.h | 3 +++
 arch/riscv/kvm/vcpu.c             | 4 ++++
 2 files changed, 7 insertions(+)

diff --git a/arch/riscv/include/asm/kvm_host.h b/arch/riscv/include/asm/kvm_host.h
index cc33e35cd628..1e9fe3cbecd3 100644
--- a/arch/riscv/include/asm/kvm_host.h
+++ b/arch/riscv/include/asm/kvm_host.h
@@ -234,6 +234,9 @@ struct kvm_vcpu_arch {
 	/* CPU CSR context upon Guest VCPU reset */
 	struct kvm_vcpu_csr guest_reset_csr;
 
+	/* CPU smstateen CSR context upon Guest VCPU reset */
+	struct kvm_vcpu_smstateen_csr reset_smstateen_csr;
+
 	/*
 	 * VCPU interrupts
 	 *
diff --git a/arch/riscv/kvm/vcpu.c b/arch/riscv/kvm/vcpu.c
index 60d684c76c58..b11b4027a859 100644
--- a/arch/riscv/kvm/vcpu.c
+++ b/arch/riscv/kvm/vcpu.c
@@ -57,6 +57,8 @@ static void kvm_riscv_reset_vcpu(struct kvm_vcpu *vcpu)
 	struct kvm_vcpu_csr *reset_csr = &vcpu->arch.guest_reset_csr;
 	struct kvm_cpu_context *cntx = &vcpu->arch.guest_context;
 	struct kvm_cpu_context *reset_cntx = &vcpu->arch.guest_reset_context;
+	struct kvm_vcpu_smstateen_csr *smstateen_csr = &vcpu->arch.smstateen_csr;
+	struct kvm_vcpu_smstateen_csr *reset_smstateen_csr = &vcpu->arch.reset_smstateen_csr;
 	bool loaded;
 
 	/**
@@ -73,6 +75,8 @@ static void kvm_riscv_reset_vcpu(struct kvm_vcpu *vcpu)
 
 	memcpy(csr, reset_csr, sizeof(*csr));
 
+	memcpy(smstateen_csr, reset_smstateen_csr, sizeof(*smstateen_csr));
+
 	spin_lock(&vcpu->arch.reset_cntx_lock);
 	memcpy(cntx, reset_cntx, sizeof(*cntx));
 	spin_unlock(&vcpu->arch.reset_cntx_lock);
-- 
2.48.1


