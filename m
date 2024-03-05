Return-Path: <stable+bounces-26828-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 058358726E3
	for <lists+stable@lfdr.de>; Tue,  5 Mar 2024 19:49:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09033B2887D
	for <lists+stable@lfdr.de>; Tue,  5 Mar 2024 18:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF72C1AAC4;
	Tue,  5 Mar 2024 18:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tz3Y3RTy"
X-Original-To: stable@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3097B199B9
	for <stable@vger.kernel.org>; Tue,  5 Mar 2024 18:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709664537; cv=none; b=LZ70MLOrhKyTU7uIoQ+jxNIXXvzX67A3vUIOKfFcYSr2urT2mYRll9FQQcL/GdZp3R43Hz1PSZ5tIojsRjtb0bwMiQ2A75ghUynnh2It3OZsB1/D9PlYMH2GxXYexObc3uoxVx8JGM/JffxgzQBqGYaW/6MIywPFU2TlorqkA2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709664537; c=relaxed/simple;
	bh=zFHpeoHrk2fy3c/j0OJVv5j9Rm4YAqZK0RHIRw+CLq8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Is/lR3XyTAIPRPdZshMgldxmSJqMs8x5k63aYjEhu5cgk1w2w8dhBiNafnx1YHtnqscuiDg++E5aFbUXcioVbwrPyFLgGiASnORSi1BrJl85ee+Db3BFQHrUn8olV9TcfTqdKZL/JzgTz/D7gPmBJcAen6GHoqYXxAwjgK9S77w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tz3Y3RTy; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1709664534;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DKOAySTmtsid9rWndhWZ282Y5Z7nMyZa3Vt79s4X/6c=;
	b=tz3Y3RTyGDXm7Lt7cGt1xxxz3Tm24ZAnhgvF4Ixi4LWM7rNAO/52LTktdTjXC5qRXfMkaL
	/3m5Qt+83aH6zalf3eMMQgJuxw7jwXmuFmLyMBvX3wPv3IeSKVBzxyiKpf69cKqiMl0kJk
	Sy2rZ4rKgtOLrNuT5X32tK9wj5XBUDk=
From: Oliver Upton <oliver.upton@linux.dev>
To: kvmarm@lists.linux.dev
Cc: Marc Zyngier <maz@kernel.org>,
	James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Will Deacon <will@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	stable@vger.kernel.org
Subject: [PATCH 2/3] KVM: arm64: Fix host-programmed guest events in nVHE
Date: Tue,  5 Mar 2024 18:48:39 +0000
Message-ID: <20240305184840.636212-3-oliver.upton@linux.dev>
In-Reply-To: <20240305184840.636212-1-oliver.upton@linux.dev>
References: <20240305184840.636212-1-oliver.upton@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Programming PMU events in the host that count during guest execution is
a feature supported by perf, e.g.

  perf stat -e cpu_cycles:G ./lkvm run

While this works for VHE, the guest/host event bitmaps are not carried
through to the hypervisor in the nVHE configuration. Make
kvm_pmu_update_vcpu_events() conditional on whether or not _hardware_
supports PMUv3 rather than if the vCPU as vPMU enabled.

Cc: stable@vger.kernel.org
Fixes: 84d751a019a9 ("KVM: arm64: Pass pmu events to hyp via vcpu")
Signed-off-by: Oliver Upton <oliver.upton@linux.dev>
---
 include/kvm/arm_pmu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/kvm/arm_pmu.h b/include/kvm/arm_pmu.h
index 4b9d8fb393a8..df32355e3e38 100644
--- a/include/kvm/arm_pmu.h
+++ b/include/kvm/arm_pmu.h
@@ -86,7 +86,7 @@ void kvm_vcpu_pmu_resync_el0(void);
  */
 #define kvm_pmu_update_vcpu_events(vcpu)				\
 	do {								\
-		if (!has_vhe() && kvm_vcpu_has_pmu(vcpu))		\
+		if (!has_vhe() && kvm_arm_support_pmu_v3())		\
 			vcpu->arch.pmu.events = *kvm_get_pmu_events();	\
 	} while (0)
 
-- 
2.44.0.278.ge034bb2e1d-goog


