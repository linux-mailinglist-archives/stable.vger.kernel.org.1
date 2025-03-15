Return-Path: <stable+bounces-124502-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EDC3A629AA
	for <lists+stable@lfdr.de>; Sat, 15 Mar 2025 10:13:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C37C1895689
	for <lists+stable@lfdr.de>; Sat, 15 Mar 2025 09:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99E091F4CBA;
	Sat, 15 Mar 2025 09:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="ZBuVIxAe"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2482C1F462D
	for <stable@vger.kernel.org>; Sat, 15 Mar 2025 09:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742029969; cv=none; b=GAXwQx1m6LncwTO0x0DH30+jM9+uLFdSmZ0CdLNaKwTm0LsGMefXJoTgzjnEMA4D5xwXV5arMxTD2hlh2wJ7nZz3rjuOELknK3di26Rwepk3hP9AbAMINJ/JTUw8x7ceFQepMbo2PRvzofsuJM2tDmovIHCcOgbqKSJEM42uRwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742029969; c=relaxed/simple;
	bh=pLEJhlfw3fbIq3nvqJiuw0vOJP9zyUhLd4sW/C6OrrQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PR6sJ+6lcu6YzTUAwwpodfsdRDp9YuMIsllorzizgsG07ruWIlV4Q+B7BoWxCpLIrt4pC3jufLojU+dCKTEvCzX6hLA9F7Zbwg675sT79IyLAKCjVCH3Q/1ntHgBkoZMg26bs6WG6TcnS1xO6mfBdo0WqIP2ZeqKmwwW5qkMV7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=ZBuVIxAe; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2243803b776so78926445ad.0
        for <stable@vger.kernel.org>; Sat, 15 Mar 2025 02:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1742029966; x=1742634766; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fVQeHb+cCKo9FI3oCd5KZj2+ztmvI+IS1H6dV0Bffso=;
        b=ZBuVIxAeujgieAmNiJU7uEPhv8quEDbmWM1ekcacXm7H1Qcle5/WiokQ6PITIP/KpC
         2LxvcpvIIHXdfPAqQApMnlxAQo2kXbgFIs+/+cMr7Crrd2Zopr3SvD5HvR0ykmYPoKAt
         GJrDAkxvDTKd3o6vfCfaMBDI2rA6iD6jcMu2Ug8nsmiTiUyAOdji1+mKUBeq+Agvg04i
         ZH/UaqwqzVG6eGPba3Vm0AR9gM69uhHz9W4kU1PiqU8b/ct2CzfUK5NGWWpQs1Ud70G/
         HDu3if3ctlJO+sFibaY4tBXgHA9t8ziNP3gZR5ewPgNQPGttIu1Uf01VRSbMZJsEb3h0
         8s5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742029966; x=1742634766;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fVQeHb+cCKo9FI3oCd5KZj2+ztmvI+IS1H6dV0Bffso=;
        b=t+FJ0fBKK5Jl5eTDXkSSTqMspMwnUsv3+Cv6GUKbLPwnOVOhY9ud8bY0t0Di/Kczzm
         yyjcYN45EquD60p0DEh+glAVLrsXgJE3upWzMmyjZjx/qDjPMh0wwd5OUEFZ5uO06tJK
         ebKBI3gv3BJM1/bO2PW8SlbW1V7egc9yYdnt+l4Cgc8yyfrQvDGqRXOrrIp8nKFPRrrp
         +/vOnT5+slO/JLaP61zXBbtMOG5HJwtj2Kmq6JzvyscXHC+zH1yhlCzutz2k1OahDXYp
         fhL0fLzSmpRTzuRoXNM976LPxxnLgCQ8bZiefu89ZJuz/kc5oE4iyW5AUfV6BF/YyUZR
         AyWg==
X-Forwarded-Encrypted: i=1; AJvYcCXgv/pd5TpImR3TfLUcjliHz0pMg8YYfeGiTac/ks9P0odv6GN/uE0RatnQzTSQAGNZfD/fa+0=@vger.kernel.org
X-Gm-Message-State: AOJu0YydThD8u6fcNch4NlUC1kLvvv/nI7cDm5E2CXzU3BuIVaLDrcya
	szKNyH2/WYOAdy5jcPnk5b+uXlueu22ry3uIJBeZiT+O/Caj+KRrrapB0c4mA7c=
X-Gm-Gg: ASbGncuqJ4NkbRxpDwPbS4rfqI8LIm1TH4tgGUHNZkkmPBY7+uDoYEW7IT6QB1zgAY3
	QqZWX4c8O+rrcprvQgNpV1+cnIqL4vnF2GU0e1B7mQkuLadYMgsYBVpAcjvpZow8zgUYoMVI++5
	y0xAICZLJKahjMVEhm/GluduwBUp+fc+d9yqdN5HNROvf1q+szd/mJxxc6K3I+czc4suXH0bEXq
	w0h4GoFxLX2LD5PvRuS2eOfyc8YZPd9sLLDMGGtOej+IAGQ5h17FmqpH0P8fezQ1iFwf4xw5aWL
	5BC6zfTJ2LQNUWyZ+wMRWusb6C8uthohq5JRCobzTxlBy52p
X-Google-Smtp-Source: AGHT+IGQ8Gz6JOShy4dRcyVD/SiQ18YggMiPkdBJ/XbTFh26anmZdWe+vf8X98ZKiGLO7S3+Q3G5dQ==
X-Received: by 2002:a17:902:e750:b0:223:90ec:80f0 with SMTP id d9443c01a7336-225e0a6b3f8mr76818965ad.22.1742029966450;
        Sat, 15 Mar 2025 02:12:46 -0700 (PDT)
Received: from localhost ([157.82.205.237])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-225c6bd4a8fsm40925235ad.234.2025.03.15.02.12.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 15 Mar 2025 02:12:46 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sat, 15 Mar 2025 18:12:10 +0900
Subject: [PATCH v5 1/5] KVM: arm64: PMU: Set raw values from user to
 PM{C,I}NTEN{SET,CLR}, PMOVS{SET,CLR}
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250315-pmc-v5-1-ecee87dab216@daynix.com>
References: <20250315-pmc-v5-0-ecee87dab216@daynix.com>
In-Reply-To: <20250315-pmc-v5-0-ecee87dab216@daynix.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
 Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Zenghui Yu <yuzenghui@huawei.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Andrew Jones <andrew.jones@linux.dev>
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
 arch/arm64/kvm/sys_regs.c | 21 ++-------------------
 1 file changed, 2 insertions(+), 19 deletions(-)

diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 82430c1e1dd0..ffee72fd1273 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -1051,26 +1051,9 @@ static bool access_pmu_evtyper(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
 
 static int set_pmreg(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r, u64 val)
 {
-	bool set;
-
-	val &= kvm_pmu_accessible_counter_mask(vcpu);
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
+	u64 mask = kvm_pmu_accessible_counter_mask(vcpu);
 
+	__vcpu_sys_reg(vcpu, r->reg) = val & mask;
 	return 0;
 }
 

-- 
2.48.1


