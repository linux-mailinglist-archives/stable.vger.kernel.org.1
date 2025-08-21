Return-Path: <stable+bounces-172051-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60E03B2FA1A
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 15:21:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C64CB5E4CE9
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 13:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B25732A3D0;
	Thu, 21 Aug 2025 13:14:52 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE7F32779F;
	Thu, 21 Aug 2025 13:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755782092; cv=none; b=oMdUsiHj7pKIfx+H6TwSlqZYJS8Jk5MobqbjIqZiEq5uvHm8RkwefR/B63NVhn7I29qNQcU3k8zicU9KPzDw3B7q6jryEfPH0+dhem+SnAhQMguHg5zLLTBZ0u9hdQ+eMQV6B56daeyow1nNy7tTCuuiDoseQEwuAUY76ncnhtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755782092; c=relaxed/simple;
	bh=iz/d8UW6i3KTxLO7elBnkVpPnEZ3GzBOpf2zb2nSH4I=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Gd6LP68BldciCu9mmzZF8Wz3VWgkJClHMzeXNPujcJq+jzLaijH1OVw+HMI4lJVwNdqNzxePIDcZAvnFIpiEZXGQ1pWTERTYenaQyBIixqPjYLu8vg8OX4fVKH8ii9vL/CUDfwo05QFSCNN12y1qlKohYhh/iAjxtpxZ+4VqHJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4c73Zp2rntzPqMf;
	Thu, 21 Aug 2025 21:10:10 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id 5691C180080;
	Thu, 21 Aug 2025 21:14:46 +0800 (CST)
Received: from huawei.com (10.67.174.55) by dggpemf500011.china.huawei.com
 (7.185.36.131) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 21 Aug
 2025 21:14:45 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <hpa@zytor.com>, <prarit@redhat.com>,
	<rui.y.wang@intel.com>, <gregkh@linuxfoundation.org>, <x86@kernel.org>,
	<stable@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH v5.15 0/2] x86/irq: Plug vector setup race
Date: Thu, 21 Aug 2025 13:10:52 +0000
Message-ID: <20250821131054.1094506-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
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

Fixes: 9345005f4eed ("x86/irq: Fix do_IRQ() interrupt warning for cpu hotplug retriggered irqs")
Cc: stable@vger.kernel.org#5.15.x
Cc: gregkh@linuxfoundation.org

Jacob Pan (1):
  x86/irq: Factor out handler invocation from common_interrupt()

Thomas Gleixner (1):
  x86/irq: Plug vector setup race

 arch/x86/kernel/irq.c | 70 ++++++++++++++++++++++++++++++++++---------
 1 file changed, 56 insertions(+), 14 deletions(-)

-- 
2.34.1


