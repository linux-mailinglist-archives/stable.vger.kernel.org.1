Return-Path: <stable+bounces-104390-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 86AE79F3808
	for <lists+stable@lfdr.de>; Mon, 16 Dec 2024 18:54:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C0DD1888153
	for <lists+stable@lfdr.de>; Mon, 16 Dec 2024 17:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AB9F207662;
	Mon, 16 Dec 2024 17:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yy5+kOny"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f74.google.com (mail-ot1-f74.google.com [209.85.210.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 855C1207641
	for <stable@vger.kernel.org>; Mon, 16 Dec 2024 17:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734371649; cv=none; b=KmdTPiVtfVbqKOHGyOElxFfv5oorlZDcn2F1pIJplp7lYK77WVBN+fGN+vyIhQh/5PmKBQ9+99BEkKiKhPrh7SwmiB+791CbFq4q74YR23jOIfoPDVMiWz97B9eeeUZv+xC3/2DfFkiHeRFfAg2U7gV0V2rwV7dCGZCpMTB7GWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734371649; c=relaxed/simple;
	bh=ccj+Xnt+d4LiWXO/Gae8lnFz+Lc4W4Q7bQ5UvAE7ebs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=pWSpHyzuLt7islGnmj1NRrbre5BbF1LnRhNR2dmxAAeY/ynrxiDFpSPB+/q+oRkfu4gajcOjyB7SS5hXwOnPwxGIob/2yv8ZxK+WpVL4aDHsohf4meNkuUQPM0Eq2G3Dy9nKLBKq9De3gRKhaoLrXaYPmyjAPIwpAE45IAkoeFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--rananta.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yy5+kOny; arc=none smtp.client-ip=209.85.210.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--rananta.bounces.google.com
Received: by mail-ot1-f74.google.com with SMTP id 46e09a7af769-71e211f9b94so2670145a34.1
        for <stable@vger.kernel.org>; Mon, 16 Dec 2024 09:54:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734371646; x=1734976446; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gbCL4n28PIJ+KSYzw6TG+pf2SykSK+WKVpyY1H5BThU=;
        b=yy5+kOnyn/LO7O70IkHLp5PR6zb9fUdszABIWNMQVqYV9eeiQ4WUr1vtD+f3fQDF3g
         EK9lzLROkdy/dypyegxa9DLwofMFIhT+OCOB7ZhZrzx8i1c3Tu1gEXd/DceYrgIa2nJ7
         3lICPS9Tn27w3abmD28gibz7dWHuTPQIQtAEC/stLERDPDOwe90FN6IfOpx4wZo1NnEV
         zOyqNW3Zwim/e7g+miumlJgZWNw4+LUawDZGDTZeZNNujuTF/c5ySlZe96g0OIz/fVWs
         TO56JGbS8P0j5BF2GvunRxiV+e+6r3MCJH3Iyg504ZKvvJn0JwRH/8NLONQy9yocVBLc
         Is8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734371646; x=1734976446;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gbCL4n28PIJ+KSYzw6TG+pf2SykSK+WKVpyY1H5BThU=;
        b=OEsptB5jCnY3t//ekicslkiY6RqT5xj5FKUWDAAJhhAL73k9gaMN4pBfsTfMOzBFTd
         Ij0NqdPXoc7KZg3q4IEvbGE2x2Hu4CTENIWdjF6/nUk9N9/zJo2udMmf5Y9JAKmmHqzc
         7mMaWaCBPbOYjNIXRiD7W7QIHTxDrNqR43PTkOVXeNmxMnvn8af3v9pMf6adeSYjLit/
         qp/Klh0c0ZTsJLg/0pe9MflvaU5QHQeBP+GwdOev0Vdv2O5E066DH05FMQrgfoulvNND
         nfRe/+qgrV0gGmP6Yg5K89Og0Hu8C/c7nzg4JiPU5+qzRBm0rxWycIdL4c78wZYSH55Y
         +8Jw==
X-Forwarded-Encrypted: i=1; AJvYcCX5CCyDb7crFDVIVtvVb71/4zhaeLtQ9y2g9Vehrn9uDJa8eeqSkDNIaSnJxJL6VS7l8hXJgHw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzVG0BT+PGFBkuZRd3tx79wzwcC1/BFB0P2U53uKqLqXoiJ9bQ
	tPYJNyBaoms5R1K4nKd611g6K7UtuapAzScS0DYtBuhSPTDZES/qKt/lQpePDYSvMXiaxJzCvBI
	NudRVaQ==
X-Google-Smtp-Source: AGHT+IGmJtCJARV5b/sNil0Cp9eJnIHTW7wJ2CMepKiQv1jmPctDD3ZFEBU1628ZTSOC6CnttYfd/wRtlJYD
X-Received: from oobcg8.prod.google.com ([2002:a05:6820:988:b0:5f1:f45c:5244])
 (user=rananta job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6830:264c:b0:71d:634a:e0d6
 with SMTP id 46e09a7af769-71e3b821316mr6424403a34.6.1734371646502; Mon, 16
 Dec 2024 09:54:06 -0800 (PST)
Date: Mon, 16 Dec 2024 17:54:03 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241216175403.82853-1-rananta@google.com>
Subject: [PATCH] KVM: arm64: Ignore PMCNTENSET_EL0 while checking for overflow status
From: Raghavendra Rao Ananta <rananta@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: Oliver Upton <oliver.upton@linux.dev>, Marc Zyngier <maz@kernel.org>, 
	Raghavendra Rao Anata <rananta@google.com>
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
index 4c08fd009768..9732c5e0ed22 100644
--- a/virt/kvm/arm/pmu.c
+++ b/virt/kvm/arm/pmu.c
@@ -357,7 +357,6 @@ static u64 kvm_pmu_overflow_status(struct kvm_vcpu *vcpu)
 
 	if ((__vcpu_sys_reg(vcpu, PMCR_EL0) & ARMV8_PMU_PMCR_E)) {
 		reg = __vcpu_sys_reg(vcpu, PMOVSSET_EL0);
-		reg &= __vcpu_sys_reg(vcpu, PMCNTENSET_EL0);
 		reg &= __vcpu_sys_reg(vcpu, PMINTENSET_EL1);
 		reg &= kvm_pmu_valid_counter_mask(vcpu);
 	}

base-commit: 6708005a36cfdb32aa991ebd9ea172e1183231ef
-- 
2.47.1.613.gc27f4b7a9f-goog


