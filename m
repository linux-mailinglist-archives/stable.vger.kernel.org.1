Return-Path: <stable+bounces-98162-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 028659E2B92
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 20:02:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCBC3162A5C
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 19:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E5041FC7EF;
	Tue,  3 Dec 2024 19:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Dyd7+T1q"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f202.google.com (mail-il1-f202.google.com [209.85.166.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C801FA177
	for <stable@vger.kernel.org>; Tue,  3 Dec 2024 19:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733252563; cv=none; b=IwiiGOibHlbbfkxJrXygs/KRFbA8OftUZoV97S2DI4tSCZH72nZ8IdDHTWO3IRzWKgLbO4d0RGFRlt6SGHGk0NLhJU6CkhpKFUKvcLbTx90NjRNhhnmWV5dNvN8NyhOCi5h49lrdILIEF8aoommTG4izV3T5YQtMUXfFWzBWVqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733252563; c=relaxed/simple;
	bh=FnJqzXsr3QKWMxtAKAm8hkyEQsmTlP1JiMe+msO9RaQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mZG5JoMd8b0atuAWCtrdMmgmVIrNoeO9Kf4uDLOcIRK4fyBgCom8hjSbK7FHWxhTplry9to3dBvbOpFoHsK2teGf1Pqagf+yPl/sEB8N5JSZYJwJwWTrVwKSBDeEcGzmfhqIBGkecaLashrnO5khAUQDXy5nZjlmIMEB6r9Q4Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--rananta.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Dyd7+T1q; arc=none smtp.client-ip=209.85.166.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--rananta.bounces.google.com
Received: by mail-il1-f202.google.com with SMTP id e9e14a558f8ab-3a77a808c27so69647075ab.1
        for <stable@vger.kernel.org>; Tue, 03 Dec 2024 11:02:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733252559; x=1733857359; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1K1EHJSDASd0pKCy5F9GlO/gKSdK1mhmJ0G8ZobFByM=;
        b=Dyd7+T1qyx9isEoED5S8CB0FDuzRtwZS1HPO8stMWTK2doq7SvnX1xFIglyOQrnUEV
         6eWxeZKF4IG2volmbuOcFxrOIfdQubkRpAjg7iQTF7WbfKt8JXhzWRn3V7hERKqFvi7f
         pKfmmXaDicJyLMZIGKQUaVRRJQ9uDAybvZan9pIuwZcl6nk0WF1YnQbEsmX3tZHltE9a
         YnUHqbTtnsYff4mUwQUGueXYacMYIKwIWGDzc5bNaWWA7dnkuL4G2mFNWYIGj+1vd3qA
         R/d7cEnM60C7ZjbLDy9eHdN3x9XPE91UWrPg+rJPNS9/1KFTEZLwG04GQ23u2ehyQgCc
         tR0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733252559; x=1733857359;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1K1EHJSDASd0pKCy5F9GlO/gKSdK1mhmJ0G8ZobFByM=;
        b=NHEZoDVn7LFJqVIdkPG5t8JrkhLhfn3UySBI9zfSv+N2obCVD54TorkfjfXJ7GuNXv
         Ot7EC4NkdXUwb0vzKPCsAVXoPdABOo2qrU1pMwS8AtrFrfg2qc8B/ohjWEwzQMo3TXXQ
         sCiTvk2TJIJ0txA926LDNXfmcJ0IBKvY5DYaQ8jKiJNzhvTbLGnpOYgocyHIvSaGlh95
         K6kOgY+6Tm7e3hwH922J0fRWjSbDMQWq7Lp6zq4Ovz+LDv7VcjIrNF+P9rbZeMQGW79M
         EUNH3+kISt7zeypPf16eIju+9u6qpg7F2bI0eRFmjtBlSXQbiQ39intM+oW2RA1KuE7S
         HMbQ==
X-Gm-Message-State: AOJu0Yzn4JZPmiofIFEFmIUbt7quOlD7AnrCVyToy1fv3U+gyaBORMDr
	3h1ssH7TYWM8gStvjkWeQAl2W7wVc/aBIVu/wUj1aoP1wUn/zrz3Er+4o3nhlQPpeg+7BYeSzN1
	wo2Sq9rr9kujVwtST/UZJk9s0PmYhkvW+QJkp+XSevbz2AnL6aNT8f+QgUoGfuNNdM4oPpNgyqG
	MxaRVcuIVX7rxFw7DYNswA2mUR+17yxr36nV3Xag==
X-Google-Smtp-Source: AGHT+IGZ2bQ4x6kLs5tOsy8QpSRrJIxJN2rSOTQLo5zJa+k741wZS6CKX9qQSWwwMmljosrp/PYAo91QeU90
X-Received: from ilgd9.prod.google.com ([2002:a05:6e02:1c49:b0:3a7:7ded:521a])
 (user=rananta job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6e02:2143:b0:3a7:78a8:1fb4
 with SMTP id e9e14a558f8ab-3a7f9a4e0bamr45220625ab.13.1733252559709; Tue, 03
 Dec 2024 11:02:39 -0800 (PST)
Date: Tue,  3 Dec 2024 19:02:36 +0000
In-Reply-To: <2024120223-stunner-letter-9d09@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2024120223-stunner-letter-9d09@gregkh>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241203190236.2711302-1-rananta@google.com>
Subject: [PATCH] KVM: arm64: Ignore PMCNTENSET_EL0 while checking for overflow status
From: Raghavendra Rao Ananta <rananta@google.com>
To: stable@vger.kernel.org
Cc: Oliver Upton <oliver.upton@linux.dev>, Marc Zyngier <maz@kernel.org>, 
	Raghavendra Rao Ananta <rananta@google.com>
Content-Type: text/plain; charset="UTF-8"

commit 54bbee190d42166209185d89070c58a343bf514b upstream.

DDI0487K.a D13.3.1 describes the PMU overflow condition, which evaluates
to true if any counter's global enable (PMCR_EL0.E), overflow flag
(PMOVSSET_EL0[n]), and interrupt enable (PMINTENSET_EL1[n]) are all 1.
Of note, this does not require a counter to be enabled
(i.e. PMCNTENSET_EL0[n] = 1) to generate an overflow.

Align kvm_pmu_overflow_status() with the reality of the architecture
and stop using PMCNTENSET_EL0 as part of the overflow condition. The
bug was discovered while running an SBSA PMU test [*], which only sets
PMCR.E, PMOVSSET<0>, PMINTENSET<0>, and expects an overflow interrupt.

Cc: stable@vger.kernel.org
Fixes: 76d883c4e640 ("arm64: KVM: Add access handler for PMOVSSET and PMOVSCLR register")
Link: https://github.com/ARM-software/sbsa-acs/blob/master/test_pool/pmu/operating_system/test_pmu001.c
Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>
[ oliver: massaged changelog ]
Reviewed-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20241120005230.2335682-2-oliver.upton@linux.dev
Signed-off-by: Oliver Upton <oliver.upton@linux.dev>
---
 virt/kvm/arm/pmu.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/virt/kvm/arm/pmu.c b/virt/kvm/arm/pmu.c
index 6d52fd50c1ff..b92b1d406374 100644
--- a/virt/kvm/arm/pmu.c
+++ b/virt/kvm/arm/pmu.c
@@ -195,7 +195,6 @@ static u64 kvm_pmu_overflow_status(struct kvm_vcpu *vcpu)
 
 	if ((__vcpu_sys_reg(vcpu, PMCR_EL0) & ARMV8_PMU_PMCR_E)) {
 		reg = __vcpu_sys_reg(vcpu, PMOVSSET_EL0);
-		reg &= __vcpu_sys_reg(vcpu, PMCNTENSET_EL0);
 		reg &= __vcpu_sys_reg(vcpu, PMINTENSET_EL1);
 		reg &= kvm_pmu_valid_counter_mask(vcpu);
 	}
-- 
2.47.0.338.g60cca15819-goog


