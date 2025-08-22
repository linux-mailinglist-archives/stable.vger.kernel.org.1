Return-Path: <stable+bounces-172269-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F927B30CA8
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 05:37:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6ACC17B2E82
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 03:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A7EC28C2A6;
	Fri, 22 Aug 2025 03:37:18 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C0BE22D785;
	Fri, 22 Aug 2025 03:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755833837; cv=none; b=Nos0wJ65wWTAivlZa20dam8OM4Bfn4uXDKqVm1vureKwxBLqqZUVujRViFPbeKG3XfobRGPslgDql+rWl+5bybkqY0cDTVaj+ukurrD+RSKMHme4bplMKFJSkPD+eSFMUOhtuozZ0G0/nf8QKUClqrka8CPRMZemEQaIDZKqDew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755833837; c=relaxed/simple;
	bh=m1v8p2k+fKPNQhAi0CmcXdRTIQFBi30nev5PjI8vlNM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NQB1hf7GdI0CVnR9B3HHi+rDOpwKB7g2mIL7QvudcRX5l3TVoViJtKf1S19IKLVwaWZMQyfwcIP5+fASvQd1FUv+2k2eJG/x7jdAFFQb15rmdxKaWySCXGOhCAlbG4v6S6YwWX4L1ho8F5T0sTxtGcrppk3UwF8KHUEuMGgWGF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4c7Qkp1vTFz13NJ3;
	Fri, 22 Aug 2025 11:33:22 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id C07841402DF;
	Fri, 22 Aug 2025 11:36:57 +0800 (CST)
Received: from huawei.com (10.67.174.55) by dggpemf500011.china.huawei.com
 (7.185.36.131) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 22 Aug
 2025 11:36:56 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <hpa@zytor.com>, <prarit@redhat.com>,
	<gregkh@linuxfoundation.org>, <x86@kernel.org>, <stable@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH v5.10 RESEND 0/2] x86/irq: Plug vector setup race
Date: Fri, 22 Aug 2025 03:33:02 +0000
Message-ID: <20250822033304.1096496-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 dggpemf500011.china.huawei.com (7.185.36.131)

There is a vector setup race, which overwrites the interrupt
descriptor in the per CPU vector array resulting in a disfunctional device.

CPU0				CPU1
				interrupt is raised in APIC IRR
				but not handled
  free_irq()
    per_cpu(vector_irq, CPU1)[vector] = VECTOR_SHUTDOWN;

  request_irq()			common_interrupt()
  				  d = this_cpu_read(vector_irq[vector]);

    per_cpu(vector_irq, CPU1)[vector] = desc;

    				  if (d == VECTOR_SHUTDOWN)
				    this_cpu_write(vector_irq[vector], VECTOR_UNUSED);

free_irq() cannot observe the pending vector in the CPU1 APIC as there is
no way to query the remote CPUs APIC IRR.

This requires that request_irq() uses the same vector/CPU as the one which
was freed, but this also can be triggered by a spurious interrupt.

Interestingly enough this problem managed to be hidden for more than a
decade.

Prevent this by reevaluating vector_irq under the vector lock, which is
held by the interrupt activation code when vector_irq is updated.

The first patch provides context for subsequent real bugfix patch.

Fixes: 9345005f4eed ("x86/irq: Fix do_IRQ() interrupt warning for cpu hotplug retriggered irqs")
Cc: stable@vger.kernel.org#5.10.x
Cc: gregkh@linuxfoundation.org

v1 -> RESEND
- Add upstream commit ID.

Jacob Pan (1):
  x86/irq: Factor out handler invocation from common_interrupt()

Thomas Gleixner (1):
  x86/irq: Plug vector setup race

 arch/x86/kernel/irq.c | 70 ++++++++++++++++++++++++++++++++++---------
 1 file changed, 56 insertions(+), 14 deletions(-)

-- 
2.34.1


