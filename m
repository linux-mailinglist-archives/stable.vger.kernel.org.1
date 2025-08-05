Return-Path: <stable+bounces-166549-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 87769B1B250
	for <lists+stable@lfdr.de>; Tue,  5 Aug 2025 12:54:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5A3817F02D
	for <lists+stable@lfdr.de>; Tue,  5 Aug 2025 10:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA0D1242925;
	Tue,  5 Aug 2025 10:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="MfB/95/X"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00DF8241691
	for <stable@vger.kernel.org>; Tue,  5 Aug 2025 10:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754391248; cv=none; b=Cpa221+PFVfCO9PeZ1y1hTleBwJgE3PI0hjGKOZnfNsqcZC+J+rn9Xptm5i939VYTadRtMC6T0f0WKXUxJsy2LpUIFJtyg8hQjG47dTiwu3dXrX4iyCVfhmkN1KsmM+IEB6s7DzQucWJSNgEDrIxYrCRWBb7Jj9Lc2c/wNbTeRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754391248; c=relaxed/simple;
	bh=j6njE58QFD+zg3/0GPbXJiFfWjG2rF0iiy1yUJKDjrI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bMSFbbbkv412MKEaXDAFD/tDAs6MfRfhgCq6NCXf/cnYhvdFC9DurhvAjrzBZuCy/RQ6JiIkPXlHhtuHLoFWG37MIpc2NAP06AMOStZPyqA4QodyBpCHn18zKFAAPyk0g69ZjyA9Inf15nlzeHC2UZpOZzT7Lgs3MRXO1ml/T+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=MfB/95/X; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3b77dece52eso563517f8f.2
        for <stable@vger.kernel.org>; Tue, 05 Aug 2025 03:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1754391245; x=1754996045; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WUiodtQBvKBTA/iKS7oNMgVKazgBWdic3Ly/8SfR7xc=;
        b=MfB/95/X6j7hyi4c7mQpUHSGHCFQ+iwVMOhVU76zaZu1/ti6Q7Fsddwq90v7WAby9Z
         bpQrNgHRQOapowQzdW2rKJND/CykUwh0CHt7OC6y16oXCsqauOJ6Iv+Q+dCZkBRD9TB/
         ESbOFd/jij75oNWIsHZbATIku4rL7puYnZWQKDwCT9OZSWGKtpVz+4QfrgpGJYkkX2Ns
         9HGPug2CVmlfubL7YgWML764DvueOgAsDvN2zAn282lf4EuuTU4mX/eDTC67Dnmq2r7e
         SlANsfpi7uwMevgl1FI631eJEjgOtuMz6XnJKReJp3mdRah9u2Ik5NF6s5Y/vXwPCfgR
         D06Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754391245; x=1754996045;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WUiodtQBvKBTA/iKS7oNMgVKazgBWdic3Ly/8SfR7xc=;
        b=B0OIgu9sBmILiD7Sf/cM6pr324Waf5Q2nNFqetkB4yfjrfiaGvmHenePm3OlOEkjig
         mrLoAW1P9dFTqrv7iul9ZUK9M6TviHcEQoju9EP9IiTPUxsSpLY848OoblZZsbrkK4pS
         VHQ7havIEF4fWbVvspLiLZMcbKfar8VB7nm2oteWgZFvtMW4xfu/zMUjRofPGfC+dTaR
         F/DyNcKl67sz0xDGp3PrY9CrYHmMdkxHF2G3cYxX16ylODgtyC20E+ruuF2bIu/2b0F2
         IaqiklsHbpUmLMriP5ni7JNE5/Bq1HATEce6lO1OHppPxLHtjVVs/GzGhRWra2z9KdnV
         Usdg==
X-Forwarded-Encrypted: i=1; AJvYcCXoQqjowJPuyyCywY5kotLHYQFLianuiW3HoxtwZPwi14GfbdUrlrnRktlsC4APaNeFWBlpE7k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzC3dEUdc3Z80G9z2sCjGz0SRdNK31VKRcotyh/UKhMhwMgJm0n
	FX/KOvmIydnzc+7225qFDPpGm+dYJU9BxPhdE7N9vMk2JFiRaJ2ox4CwIkgj3LXR+TU=
X-Gm-Gg: ASbGnct3aEUMUjes7PIMBMkFs87imTc+vCCkmhX1Fym9knBBcVEMvUSJsZ3w3PbX7ID
	Qp28rCs5MZnq6yfWFCrQsAmGNOmuXkrfB4RHlz6sAzkpYGUFpKy4eHaykl20GNzC3X6vNS03nkj
	n0l57i4qbzzGMmD7yeZR/QvnlBw2qiN6rPciLNi66r47OFQbTIqwnOSo5a7vWOCmf+jJ9G9Figf
	WDH9hGf32QqkU2wg2akiXlT0/+fxiLi2YzvirYDX2HlsbGA3VrNDvDCMtVAbp8uxEKYkMGyE8/A
	/FZyhDsgRAzF07fQbJdefAGo9fODJAKEqZImXZN1MEVBdqhRyTY8VCpbPgcfl1ohbF3hNCdvWTe
	XozrR+IMxSCYrMVXzF0N2fPeXlEI3/whnDyyqfAQ=
X-Google-Smtp-Source: AGHT+IEpOsq0FAVja98/mlRReMdSEb+xPNZ7ZEoi0EN4dXoUtDCJVpNHURSd1y/tvYFRXGJZtratYw==
X-Received: by 2002:a05:6000:1a86:b0:3b7:99a8:bf6d with SMTP id ffacd0b85a97d-3b8d94b6fa0mr3885890f8f.11.1754391245272;
        Tue, 05 Aug 2025 03:54:05 -0700 (PDT)
Received: from localhost ([2a02:8308:a00c:e200:d884:b809:d57:1ad7])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3b79c3abf0csm18344450f8f.14.2025.08.05.03.54.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 03:54:04 -0700 (PDT)
From: =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@ventanamicro.com>
To: kvm-riscv@lists.infradead.org
Cc: kvm@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Anup Patel <anup@brainfault.org>,
	Atish Patra <atishp@atishpatra.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
	stable@vger.kernel.org
Subject: [PATCH] RISC-V: KVM: fix stack overrun when loading vlenb
Date: Tue,  5 Aug 2025 12:44:21 +0200
Message-ID: <20250805104418.196023-4-rkrcmar@ventanamicro.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The userspace load can put up to 2048 bits into an xlen bit stack
buffer.  We want only xlen bits, so check the size beforehand.

Fixes: 2fa290372dfe ("RISC-V: KVM: add 'vlenb' Vector CSR")
Cc: <stable@vger.kernel.org>
Signed-off-by: Radim Krčmář <rkrcmar@ventanamicro.com>
---
 arch/riscv/kvm/vcpu_vector.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/riscv/kvm/vcpu_vector.c b/arch/riscv/kvm/vcpu_vector.c
index a5f88cb717f3..05f3cc2d8e31 100644
--- a/arch/riscv/kvm/vcpu_vector.c
+++ b/arch/riscv/kvm/vcpu_vector.c
@@ -182,6 +182,8 @@ int kvm_riscv_vcpu_set_reg_vector(struct kvm_vcpu *vcpu,
 		struct kvm_cpu_context *cntx = &vcpu->arch.guest_context;
 		unsigned long reg_val;
 
+		if (reg_size != sizeof(reg_val))
+			return -EINVAL;
 		if (copy_from_user(&reg_val, uaddr, reg_size))
 			return -EFAULT;
 		if (reg_val != cntx->vector.vlenb)
-- 
2.50.0


