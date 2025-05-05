Return-Path: <stable+bounces-139727-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C9878AA9A98
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 19:32:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8CD257A392A
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 17:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80E1E26C391;
	Mon,  5 May 2025 17:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pu6B5gli"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A0525C6EA
	for <stable@vger.kernel.org>; Mon,  5 May 2025 17:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746466341; cv=none; b=O8MBEWeHvpRD7ywZ7wvdAVh2ta6xCfcajpAQhFzN3nec9hXLpGCqn70tNWriuuOZLbc1bfOWYA0EHaESUcqbtl++zTpP3oNwgwKYvTGsa5/DMQ9yAAirM01p5ssnRZi3PGM7vUaDrPzuFOPCueYpAVhG7KCztBDyhojckYO9qN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746466341; c=relaxed/simple;
	bh=Sirt4gr8r2sZgygHZ7WpIIJ0uwlYX2WulgE8mLU8plo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Hk62JJo9JdRwL07HH0ihRbZYNV3dcjQcmKHsSlS1HX30r3+PGWWsQj2QTVdzYIWpYqy7i8I8vd+8vflFuVrGq+5PfKUxKSrWogk2+kqOxQXn8KgfZ3/AwmQy4564yADeTr4L3q0VD2hi9/9OPyHdKtsBzOxj3NuWH11q4PYXRBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Pu6B5gli; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746466338;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=JjAxyTaB2HZtvewgEgyYKDE4ThQVrWuUNuivvsqnLN4=;
	b=Pu6B5glisPCi3wu9kK28wRPVcr2I1KmSgCnj14qDXvpKyNnvroUTScG8Sk67o5IyKYE5Dg
	PLo1DrcnK/S9ImjZbgznYA1R7OS0vMqXraZyLb9gSRAO15lYjAcGImz0D1dVpSjNpw8db7
	N7BNSK5tRQ01bVLkV4WJRE0r9agQoiU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-396-6gvZLPMHOvqDbXL6ewkzhg-1; Mon, 05 May 2025 13:32:16 -0400
X-MC-Unique: 6gvZLPMHOvqDbXL6ewkzhg-1
X-Mimecast-MFC-AGG-ID: 6gvZLPMHOvqDbXL6ewkzhg_1746466335
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43cec217977so28113375e9.0
        for <stable@vger.kernel.org>; Mon, 05 May 2025 10:32:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746466335; x=1747071135;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JjAxyTaB2HZtvewgEgyYKDE4ThQVrWuUNuivvsqnLN4=;
        b=cNX8fdcOldCKWjy4+OtswUaTDEaDnelcxsg5XTX6EXfN6vhC/u/AMKhXLIew1t9hG5
         +yXanGHq8tFQcyTP7QwLh1Wi0l3uroASVbncqX5azPUs8w424Z42Jaggx5cSkTa7AnFn
         ubCGzHaCHtU9pSGYBmp9PKXp0wr7pDEeEVCyH9RlbpwM6AeqARjHkNWqijOQqyslIKp4
         72w5lwZN3U50QdF0zfxrjgEUDrLASt71SbJ1sdFTSvCiFHLWbk4LCkeC3uc6ZMeAS9uw
         lQWnx9SUWaewzs+0bOJ38T1B2Lc69JAk4qTlCEi6zMyOyRb5L8MdFhiWx+VDoFzuRUoa
         Rkug==
X-Forwarded-Encrypted: i=1; AJvYcCVnk9C8ZlwpEq+Ai+XwBvV51XDztYYRzQGc2aYBBqSLgT5zLOqml6KEptymG8g2N3C887upluw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeAyb9ckl9mSivIz/1ni07iFzScf/81lMyO5kGRydAh4WJjKj6
	2YEopYknMiW6M78wx0Ocj6gszjGGMS9ML6t8cnddfZvDaD1MyHq4NWh60ABnUCGPWySwdNHK4q5
	byBWy4QD9lipEKq9jO1RwhBkgd+3h1HqvgTg68bDW+rh5LMOo7JwiLw==
X-Gm-Gg: ASbGncsmFLCtuKFshAROJSZgoNlg4IIm1uoZiCI6baZolXx6fKJeFvPnsemh30Gllcf
	Jt/MfV8hDfsMhNLMIpy8Wc5t/xp+u40VdPiXG8zIkPNqdupWggjCdK6Q9mg69LO28bzFesimKbf
	NXZkYPbirA557A6DFIM697JICxNcgtgtdW8x6+DtRdNcRxpxrQBq67VT5tUa9pmElhXTjYSiBP5
	xoYuOka+2Aiv/idTEJnNYFPFtVpmeoMy8YwrjNLx1zvsB0ALy5PNq+L9Ykio8iR/DyWwLhYMKUW
	rgzhq6cm/9Ysj7JsWVWVXNZGK2RYHNHXJlnp1Gc11MrxmyJ6wKMIXSbUp/xRYJ5dazdVs/kUCA=
	=
X-Received: by 2002:a05:600c:a401:b0:43c:e2dd:98f3 with SMTP id 5b1f17b1804b1-441c525facbmr56096355e9.21.1746466335027;
        Mon, 05 May 2025 10:32:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFILc2vKI3/xP04PnDAD0gBqfLoTJ7gk5HkYL4nRmV2jGTs1rwbkDQtRYRRFH+l5ESk0GD4dg==
X-Received: by 2002:a05:600c:a401:b0:43c:e2dd:98f3 with SMTP id 5b1f17b1804b1-441c525facbmr56096055e9.21.1746466334623;
        Mon, 05 May 2025 10:32:14 -0700 (PDT)
Received: from rh.fritz.box (p200300f6af1bce00e6fe5f11c0a7f4a1.dip0.t-ipconnect.de. [2003:f6:af1b:ce00:e6fe:5f11:c0a7:f4a1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a099ae0c3dsm11343310f8f.12.2025.05.05.10.32.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 May 2025 10:32:14 -0700 (PDT)
From: Sebastian Ott <sebott@redhat.com>
To: Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>
Cc: Quentin Perret <qperret@google.com>,
	Fuad Tabba <tabba@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Sebastian Ott <sebott@redhat.com>,
	stable@vger.kernel.org
Subject: [PATCH] KVM: arm64: Fix uninitialized memcache pointer in user_mem_abort()
Date: Mon,  5 May 2025 19:31:48 +0200
Message-ID: <20250505173148.33900-1-sebott@redhat.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit fce886a60207 ("KVM: arm64: Plumb the pKVM MMU in KVM") made the
initialization of the local memcache variable in user_mem_abort()
conditional, leaving a codepath where it is used uninitialized via
kvm_pgtable_stage2_map().

This can fail on any path that requires a stage-2 allocation
without transition via a permission fault or dirty logging.

Fix this by making sure that memcache is always valid.

Fixes: fce886a60207 ("KVM: arm64: Plumb the pKVM MMU in KVM")
Signed-off-by: Sebastian Ott <sebott@redhat.com>
Reviewed-by: Marc Zyngier <maz@kernel.org>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/kvmarm/3f5db4c7-ccce-fb95-595c-692fa7aad227@redhat.com/
---
 arch/arm64/kvm/mmu.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index 754f2fe0cc67..eeda92330ade 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -1501,6 +1501,11 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 		return -EFAULT;
 	}
 
+	if (!is_protected_kvm_enabled())
+		memcache = &vcpu->arch.mmu_page_cache;
+	else
+		memcache = &vcpu->arch.pkvm_memcache;
+
 	/*
 	 * Permission faults just need to update the existing leaf entry,
 	 * and so normally don't require allocations from the memcache. The
@@ -1510,13 +1515,11 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 	if (!fault_is_perm || (logging_active && write_fault)) {
 		int min_pages = kvm_mmu_cache_min_pages(vcpu->arch.hw_mmu);
 
-		if (!is_protected_kvm_enabled()) {
-			memcache = &vcpu->arch.mmu_page_cache;
+		if (!is_protected_kvm_enabled())
 			ret = kvm_mmu_topup_memory_cache(memcache, min_pages);
-		} else {
-			memcache = &vcpu->arch.pkvm_memcache;
+		else
 			ret = topup_hyp_memcache(memcache, min_pages);
-		}
+
 		if (ret)
 			return ret;
 	}

base-commit: 92a09c47464d040866cf2b4cd052bc60555185fb
-- 
2.49.0


