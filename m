Return-Path: <stable+bounces-124147-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F03E3A5DC0B
	for <lists+stable@lfdr.de>; Wed, 12 Mar 2025 12:56:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72B053B3958
	for <lists+stable@lfdr.de>; Wed, 12 Mar 2025 11:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9945624168E;
	Wed, 12 Mar 2025 11:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="DpHpyJTD"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A09241672
	for <stable@vger.kernel.org>; Wed, 12 Mar 2025 11:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741780576; cv=none; b=Nunvb0kR+0D+M1VqRO8OAVMcdBVwx8TcsInFeCPcVmBTEQ8cwo0h4VSL8Gqc1lKZjP8y6pROkrafAsP2mJlcrcCMNQsS5+vxrOTxkNcbWcscCRjiG68PIS/3zHEY6dNgNK5qeb4Stewy1GcmJnc8jnwMuOBk/eK90FWexj2d9Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741780576; c=relaxed/simple;
	bh=Nls52lkzjmJ+bhk/FuveEgJphMZM3lsoGJmXIHJqvZ8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UQKig6gz0F3drQo1IHtO4MgbykkSA0L4+S94t9aPUQ3/HGPC5nKfUemIoXEl10YMXpNpAp37wOTp7y4M7L/LnNcONnNczgtTIyPGj2O9nUdh28/KWuj66eVdLyVVbRPHHZxMszvBOnUNrK3U5GHuSo1TjqX9vXUXiuQFskPXEN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=DpHpyJTD; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-224100e9a5cso125235145ad.2
        for <stable@vger.kernel.org>; Wed, 12 Mar 2025 04:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1741780574; x=1742385374; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rAMd6rGhip9Etdi0DcL12HaRjFlmNQeXSBT7tbE4ZZA=;
        b=DpHpyJTDvRc9ec1bE6qFFFImDqKRMd9xE6ZiR3ZBEiUyGccu2lIkyvTFORokT8UWEk
         TPWWo20ou48bdvtuVSLcugMNcEeLCKDnAJyp6P9cgmOleMriCTmNkngRaruGoP6+7JeT
         gX6RHH8WALWvOHyqlW/gCi1QrrswDjTegxYerdZhBBhzi/hDwf+qsxyRyvBbpKhFRsDo
         cdOHVWLB/19WwVkdx5D7TmPjbRz1Qe3wXRq9YFE9vmbBr3sKfy/fHc5I6SYfJWjB2kJ1
         vwARCvEXGeQxOOs+sEkYIcGocZRxh7dETVwukNgqJTogFQzbl0rM81EKMgMBZOglvK6i
         6nRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741780574; x=1742385374;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rAMd6rGhip9Etdi0DcL12HaRjFlmNQeXSBT7tbE4ZZA=;
        b=nv7iiUeJxFJxThKrD4ECJ7Px9oplc02iQAB80wFOxaU1RCrsqdv92Wx8+jCfhvURqN
         z5lnPcTAaN0UF6XRRjv0Jo7jU5SxQQ875P2dHGUBI8M1b3mOOFORtvSQJ2COlkE7Z6XC
         U+v154WgjI+4Sy6J58Vz7xiar3IgZq4TPAVTwa79VtriFaO50yZ26Q5RO/ErHYp5jj3K
         JWPcupaMWwJoJlVSG62/3Y48TbvFLvbeHwSm1v1urqD/5MCE6r1ACruYQfBR61GBf907
         ELz0fqkyVYWBKeV2pL9yngorwcADAB6BsWjv3GSMpikpORhoQP08t8aMfjNzGkrtPtC7
         58PA==
X-Forwarded-Encrypted: i=1; AJvYcCXe3RvcCdFErUefkpbX9b7RoQY0KcEdPrO2VUI/3F+qfvlV5Ff1STxYpdHSut+ZImkTbLSnSj0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzLcoxKE/ILT6FBkk9Y/nR2B1Z1IsMYn3lzSVt1QLdUZ042p6d
	dxgg+PW6RAMUFsQr3hZVDZMTqMH4j8CFSOOd+okstdvwAaWTlSwbsPMghdgw9FY=
X-Gm-Gg: ASbGncv76h2yYh1evm0BYalwdH5RmFhJbFweaZX+1/LRx/MdTqZxKSISP1LyepU5hFA
	HaWencHXlwnWb0FC6bC0ekBe0ygFqeMO0saMjbgMP0fwr6w45ti2hfvoRhfFDMzPKZ0/h4hwZl8
	w1ln1mFi/Z0N/8Xb7B8S8GiOyMnjAFtlQ+Tf0JQGJHtRQBQRW8HDB9K4PENzXanMihgzHOfM/2y
	pLE5Oy7zTDx04TwIw8kMg2xy0owWNaXHsmnm9dQu8+KZNJQIsMcceZrKrSk3FjfJNNpitucZ+QS
	o1W3KGWev+Nur5j0eA6IEmY/j4Ik3o9fgnBgq2hPGi0nF2f7
X-Google-Smtp-Source: AGHT+IGVJsaOES3D6e5IgzEgtMMcyBt78uD5r1dUvwmlCbFQdHU9CycZp7wTmKosTDLuCPhOfc8eNw==
X-Received: by 2002:a17:902:e812:b0:211:e812:3948 with SMTP id d9443c01a7336-2242850b42amr315559235ad.0.1741780574197;
        Wed, 12 Mar 2025 04:56:14 -0700 (PDT)
Received: from localhost ([157.82.205.237])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-73699da011asm11973015b3a.84.2025.03.12.04.56.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Mar 2025 04:56:13 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Wed, 12 Mar 2025 20:55:55 +0900
Subject: [PATCH v3 1/6] KVM: arm64: PMU: Set raw values from user to
 PM{C,I}NTEN{SET,CLR}, PMOVS{SET,CLR}
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250312-pmc-v3-1-0411cab5dc3d@daynix.com>
References: <20250312-pmc-v3-0-0411cab5dc3d@daynix.com>
In-Reply-To: <20250312-pmc-v3-0-0411cab5dc3d@daynix.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
 Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Zenghui Yu <yuzenghui@huawei.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Andrew Jones <drjones@redhat.com>, Shannon Zhao <shannon.zhao@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
 linux-kernel@vger.kernel.org, devel@daynix.com, 
 Akihiko Odaki <akihiko.odaki@daynix.com>, stable@vger.kernel.org
X-Mailer: b4 0.15-dev-edae6

Commit a45f41d754e0 ("KVM: arm64: Add {get,set}_user for
PM{C,I}NTEN{SET,CLR}, PMOVS{SET,CLR}") changed KVM_SET_ONE_REG to update
the mentioned registers in a way matching with the behavior of guest
register writes. This is a breaking change of a UAPI though the new
semantics looks cleaner and VMMs are not prepared for this.

Firecracker, QEMU, and crosvm perform migration by listing registers
with KVM_GET_REG_LIST, getting their values with KVM_GET_ONE_REG and
setting them with KVM_SET_ONE_REG. This algorithm assumes
KVM_SET_ONE_REG restores the values retrieved with KVM_GET_ONE_REG
without any alteration. However, bit operations added by the earlier
commit do not preserve the values retried with KVM_GET_ONE_REG and
potentially break migration.

Remove the bit operations that alter the values retrieved with
KVM_GET_ONE_REG.

Cc: stable@vger.kernel.org
Fixes: a45f41d754e0 ("KVM: arm64: Add {get,set}_user for PM{C,I}NTEN{SET,CLR}, PMOVS{SET,CLR}")
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Acked-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/kvm/sys_regs.c | 21 +--------------------
 1 file changed, 1 insertion(+), 20 deletions(-)

diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 42791971f758..0a2ce931a946 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -1126,26 +1126,7 @@ static bool access_pmu_evtyper(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
 
 static int set_pmreg(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r, u64 val)
 {
-	bool set;
-
-	val &= kvm_pmu_valid_counter_mask(vcpu);
-
-	switch (r->reg) {
-	case PMOVSSET_EL0:
-		/* CRm[1] being set indicates a SET register, and CLR otherwise */
-		set = r->CRm & 2;
-		break;
-	default:
-		/* Op2[0] being set indicates a SET register, and CLR otherwise */
-		set = r->Op2 & 1;
-		break;
-	}
-
-	if (set)
-		__vcpu_sys_reg(vcpu, r->reg) |= val;
-	else
-		__vcpu_sys_reg(vcpu, r->reg) &= ~val;
-
+	__vcpu_sys_reg(vcpu, r->reg) = val & kvm_pmu_valid_counter_mask(vcpu);
 	return 0;
 }
 

-- 
2.48.1


