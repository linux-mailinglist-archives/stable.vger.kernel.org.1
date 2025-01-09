Return-Path: <stable+bounces-108119-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A9D8EA077DF
	for <lists+stable@lfdr.de>; Thu,  9 Jan 2025 14:41:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 793121693B6
	for <lists+stable@lfdr.de>; Thu,  9 Jan 2025 13:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 585A62206A4;
	Thu,  9 Jan 2025 13:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YqGkmfWy"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D1421E0BF
	for <stable@vger.kernel.org>; Thu,  9 Jan 2025 13:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736429908; cv=none; b=IETia7SK1uHijy4kp3Sf2ZSYNoVenu5zF6bAOiuN99DnmcStNgUAT9MqDCjp3EmgJEMPnnDeC4jTR744kmYha3egmGNaPCzO2INErjl5LKVMZsLL3j7SLAGMknAcz8uwGJD23DebviPNO++71xU8jni0PnLUzGVHUbaukP0z3uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736429908; c=relaxed/simple;
	bh=gHVqbeeLDW26xdNiUZY5UzwMkP98DCAKakRVGGlY3Dg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bk/SyjUR0esRuuBYdtccBopjhnyhKjn550ljBvvO18Lz5ZBkc9q/bh3oj/wfcxn7iE8CZuU52CWZCU7b4WDG96dgYio3rsWF3Vs35Ti6Mzl1y1+VFKSwsvphPDmzyPLT3yVeZvpf8cj+BtddHdtoG1Aku2r/M5xl4BMjTfTQd5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YqGkmfWy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736429905;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+qIG/0LvnjXMgyU8eqBX8hgYV7UmJPw6Xa2UEwpxHJA=;
	b=YqGkmfWyEjjY77HA0vyTth1nUFN7C+3p0TP6pni2mbjmzQzWkCOEOtuS6ch3rFRJUnmvJZ
	TP2s+6j68+qVWWDwZQQnViMHPtRUIvXqNfINzq8KF0LIsblGIUT5jmNeRNajkGc97+16bw
	pF+kcTICC5E/UQHUWdPcxFr51mKz8KY=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-539-jFCsoYeWPdWVid1mDf17tw-1; Thu, 09 Jan 2025 08:38:24 -0500
X-MC-Unique: jFCsoYeWPdWVid1mDf17tw-1
X-Mimecast-MFC-AGG-ID: jFCsoYeWPdWVid1mDf17tw
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-aa69c41994dso70060866b.0
        for <stable@vger.kernel.org>; Thu, 09 Jan 2025 05:38:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736429903; x=1737034703;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+qIG/0LvnjXMgyU8eqBX8hgYV7UmJPw6Xa2UEwpxHJA=;
        b=MROAgxO7Dz0RsA64kiDVnFK4Q8unFVYJiYdaPXtqm77Ipyp0UN2nVhZFz0tg9hIKdU
         r6zUgitDsVREVcjRlh2sVVhpnYg6BaW0/v46VIvErIBWX8CEuM+tOfgFIFDCKfqBjZeC
         4IbZVe/6NwJDPjHS9rNT5Hwlq1GKuZTjq5HV5JijR5IEXmChQWZhffbV8pDNyF15dDwO
         mQi3Fk2uaz665LzLJz8h8Jsve561GIXNZ25cS5M0i/WR8IGc2hK+XcE/ePnTygWXOkSX
         NJuBaa7z4SBCOKwgze/UCpTh9yLLN6IoYYaYskbnPhE6/peyDL8nt1Sg0MbE0ISvtoSJ
         UZGg==
X-Forwarded-Encrypted: i=1; AJvYcCWC1KcQN6cDgivJiaECFOcM+EoxrR0RPuGCRNq43/KmoNv/JI5CD6k5/ow2lle131nVkk+d3Oo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGrG1JjeCJDrkUEvBy1vl+40nbX2QbG4feqmc5yu8ttoh0UoFa
	N03LHKikEuTe93rFP8ZzP4zbZ/exjFdM+KzcF5sSDhJcDHvNLEEd8Z6m1WBBXHp3gVSrO1xxIIn
	ACSLLHdo30jYf2fOHLTS3j+4jFQVMtz629yQMMIMOmJUiWGUjoaJy3w==
X-Gm-Gg: ASbGnctBy+Al0v8u7K/p4DdF1FrcqFiYh/r0DstO/f88bugMVfNrZ8CoQBGI1jcE1Dn
	hBBYUH1n/W52eQclw30Pu/iNxgBcRUJn8fIQSCwS2TMPws1IIfod2jJ2NP9DWjqXg6r8UqnTb45
	CG3fi7g93uFPueXN2vh41JNdZytLOasujZhpoEa87ua06qoV2RxmkUHG40X001q00N6pr3oyLqA
	AisRJGqVzs6ieUgPXDYZzH0LYcMKXXs/7a/Rc1kdmGauLW6pWZT8SG6BcB8
X-Received: by 2002:a05:6402:3549:b0:5d0:e73c:b7f0 with SMTP id 4fb4d7f45d1cf-5d972e70945mr15040478a12.28.1736429902593;
        Thu, 09 Jan 2025 05:38:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHsGUykWSOpesU6tHxPGZnO3JxPfRRnO6klBd/fYEFfPEHAwQWWT0oVTu7t2r5Sxoacsy+c3Q==
X-Received: by 2002:a05:6402:3549:b0:5d0:e73c:b7f0 with SMTP id 4fb4d7f45d1cf-5d972e70945mr15040371a12.28.1736429901823;
        Thu, 09 Jan 2025 05:38:21 -0800 (PST)
Received: from [192.168.10.47] ([151.62.105.73])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d99008c366sm624477a12.17.2025.01.09.05.38.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2025 05:38:21 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: oliver.upton@linux.dev,
	Will Deacon <will@kernel.org>,
	Anup Patel <apatel@ventanamicro.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	seanjc@google.com,
	linuxppc-dev@lists.ozlabs.org,
	regressions@lists.linux.dev,
	stable@vger.kernel.org
Subject: [PATCH 1/5] KVM: e500: retry if no memslot is found
Date: Thu,  9 Jan 2025 14:38:13 +0100
Message-ID: <20250109133817.314401-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250109133817.314401-1-pbonzini@redhat.com>
References: <20250109133817.314401-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Avoid a NULL pointer dereference if the memslot table changes between the
exit and the call to kvmppc_e500_shadow_map().

Cc: stable@vger.kernel.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/powerpc/kvm/e500_mmu_host.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/powerpc/kvm/e500_mmu_host.c b/arch/powerpc/kvm/e500_mmu_host.c
index e5a145b578a4..732335444d68 100644
--- a/arch/powerpc/kvm/e500_mmu_host.c
+++ b/arch/powerpc/kvm/e500_mmu_host.c
@@ -349,6 +349,11 @@ static inline int kvmppc_e500_shadow_map(struct kvmppc_vcpu_e500 *vcpu_e500,
 	 * pointer through from the first lookup.
 	 */
 	slot = gfn_to_memslot(vcpu_e500->vcpu.kvm, gfn);
+	if (!slot) {
+		ret = -EAGAIN;
+		goto out;
+	}
+
 	hva = gfn_to_hva_memslot(slot, gfn);
 
 	if (tlbsel == 1) {
-- 
2.47.1


