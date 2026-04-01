Return-Path: <stable+bounces-232718-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uO/lErDUzGnnWwYAu9opvQ
	(envelope-from <stable+bounces-232718-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 10:17:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DD083769DC
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 10:17:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 55C3530A2953
	for <lists+stable@lfdr.de>; Wed,  1 Apr 2026 08:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A98E3AD52E;
	Wed,  1 Apr 2026 08:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="s0jHWYux"
X-Original-To: stable@vger.kernel.org
Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 220623AB29A;
	Wed,  1 Apr 2026 08:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775031418; cv=none; b=myEKSgLdi3nTLPrsYjs4fi886Fa7jnfhMpkLfn8Y7fEYQ6SPtV+UBZo0iUxAW1ypdGTtRqY9Wt1nR5F++pkSdMIS9HhmlP7Y+eyg+FuWSQV7YPPxLLzPpYUonaXeE3TxmOM8gI+36+1vy59ynCzp33m1Lx/pWrtMdfGlwbb13oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775031418; c=relaxed/simple;
	bh=mWFuylDN3gumG6Mci9fYRAjdIJ9JzoCKwenkUyx/LSU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lXG7giernFKSP9yspd+m7DjT7TUzSlQH/l2mOpCY6gcwsdcxoYLG/aS6rAILYWILNsuQgL4HF3xxHGEN90nGaBNpK4MJzG/QBfKdjKQofa3BAgl2MUW4qTFi46ZPC+K8dDSsGTXCRVU3tHDpmjssjUmcLxex0dsL7DRqUiWtDC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=s0jHWYux; arc=none smtp.client-ip=113.46.200.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=c9AlrYXsxBFF3IzNBDnKrFfgKSQZlOG3wlCt2foyY+Y=;
	b=s0jHWYuxfoxkRN+t4KseYGhpk5P2m2+oPxvld1K2wRhg/xq/KJ6rPLjiy3A+eHJcZDd4LECJR
	hk2c9oJcG9N70ZRCYC/HPCz/7V6gQufIs9IC6ExJohMMFTan9KIJsB7lPAuY/r27HFSh7GQcO9C
	uY27gGt24m7NlqDK+Rfdv9c=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4flyNC08FCz1prLN;
	Wed,  1 Apr 2026 16:10:35 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
	by mail.maildlp.com (Postfix) with ESMTPS id 9190740537;
	Wed,  1 Apr 2026 16:16:47 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 1 Apr 2026 16:16:45 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Catalin Marinas
	<catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, "Rafael J .
 Wysocki" <rafael@kernel.org>
CC: Jonathan Corbet <corbet@lwn.net>, WANG Xuerui <kernel@xen0n.name>, Thomas
 Gleixner <tglx@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, "H .
 Peter Anvin" <hpa@zytor.com>, Juergen Gross <jgross@suse.com>, Boris
 Ostrovsky <boris.ostrovsky@oracle.com>, Len Brown <lenb@kernel.org>, Sunil V
 L <sunilvl@ventanamicro.com>, Mark Rutland <mark.rutland@arm.com>, Jonathan
 Cameron <jonathan.cameron@huawei.com>, Kees Cook <kees@kernel.org>, Yanteng
 Si <si.yanteng@linux.dev>, Sean Christopherson <seanjc@google.com>, Kai Huang
	<kai.huang@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, Thomas Huth
	<thuth@redhat.com>, Thorsten Blum <thorsten.blum@linux.dev>, Kevin Loughlin
	<kevinloughlin@google.com>, Zheyun Shen <szy0127@sjtu.edu.cn>, Peter Zijlstra
	<peterz@infradead.org>, Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Xin
 Li <xin@zytor.com>, "Ahmed S . Darwish" <darwi@linutronix.de>, Sohil Mehta
	<sohil.mehta@intel.com>, Ilkka Koskinen <ilkka@os.amperecomputing.com>, Robin
 Murphy <robin.murphy@arm.com>, James Clark <james.clark@linaro.org>, Besar
 Wicaksono <bwicaksono@nvidia.com>, Ma Ke <make24@iscas.ac.cn>, Wei Huang
	<wei.huang2@amd.com>, Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Somnath Kotur <somnath.kotur@broadcom.com>, <punit.agrawal@oss.qualcomm.com>,
	<guohanjun@huawei.com>, <suzuki.poulose@arm.com>, <ryan.roberts@arm.com>,
	<chenl311@chinatelecom.cn>, <masahiroy@kernel.org>,
	<wangyuquan1236@phytium.com.cn>, <anshuman.khandual@arm.com>,
	<heinrich.schuchardt@canonical.com>, <Eric.VanTassell@amd.com>,
	<wangzhou1@hisilicon.com>, <wanghuiqiang@huawei.com>,
	<liuyonglong@huawei.com>, <fengchengwen@huawei.com>,
	<linux-pci@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<loongarch@lists.linux.dev>, <linux-riscv@lists.infradead.org>,
	<xen-devel@lists.xenproject.org>, <linux-acpi@vger.kernel.org>,
	<linux-perf-users@vger.kernel.org>, <stable@vger.kernel.org>,
	<x86@kernel.org>
Subject: [PATCH RESEND v10 0/8] ACPI: Unify CPU UID interface and fix ARM64 TPH steer-tag issue
Date: Wed, 1 Apr 2026 16:16:32 +0800
Message-ID: <20260401081640.26875-1-fengchengwen@huawei.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemk500009.china.huawei.com (7.202.194.94)
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-232718-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fengchengwen@huawei.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_GT_50(0.00)[62];
	DKIM_TRACE(0.00)[huawei.com:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:dkim,huawei.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0DD083769DC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This patchset unifies ACPI Processor UID retrieval across
arm64/loongarch/riscv/x86 via acpi_get_cpu_uid() (with input validation)
and fixes ARM64 CPU steer-tag retrieval failure in PCI/TPH:

1-4: Add acpi_get_cpu_uid() for arm64/loongarch/riscv/x86 (update
     respective users)
5: Centralize acpi_get_cpu_uid() declaration in include/linux/acpi.h
6: Clean up perf/arm_cspmu
7: Clean up ACPI/PPTT and remove unused get_acpi_id_for_cpu()
8: Pass ACPI Processor UID to Cache Locality _DSM

The interface refactor ensures consistent CPU UID retrieval across
architectures (no functional changes for valid inputs) and provides the
unified interface required for the ARM64 TPH fix

---
Changes in v10-resend:
- Add Catalin's ack-by for arm64 commit
- Add CC to x86@kernel.org

Changes in v10:
- Refine commit header&log according to Punit's and Bjorn's review
- Split perf/arm_cspmu as a separate commit which address Punit's
  review

Changes in v9:
- Address Bjorn's review: split commits to each platform so that make
  them easy to review

Changes in v8:
- Moving arm64's get_cpu_for_acpi_id() to kernel/acpi.c which address
  Jeremy's review

Chengwen Feng (8):
  arm64: acpi: Add acpi_get_cpu_uid() for unified ACPI CPU UID retrieval
  LoongArch: Add acpi_get_cpu_uid() for unified ACPI CPU UID retrieval
  RISC-V: ACPI: Add acpi_get_cpu_uid() for unified ACPI CPU UID
    retrieval
  x86/acpi: Add acpi_get_cpu_uid() for unified ACPI CPU UID retrieval
  ACPI: Centralize acpi_get_cpu_uid() declaration in
    include/linux/acpi.h
  perf: arm_cspmu: Switch to acpi_get_cpu_uid() from
    get_acpi_id_for_cpu()
  ACPI: PPTT: Use acpi_get_cpu_uid() and remove get_acpi_id_for_cpu()
  PCI/TPH: Pass ACPI Processor UID to Cache Locality _DSM

 Documentation/PCI/tph.rst          |  4 +--
 arch/arm64/include/asm/acpi.h      | 17 +---------
 arch/arm64/kernel/acpi.c           | 30 ++++++++++++++++++
 arch/loongarch/include/asm/acpi.h  |  5 ---
 arch/loongarch/kernel/acpi.c       |  9 ++++++
 arch/riscv/include/asm/acpi.h      |  4 ---
 arch/riscv/kernel/acpi.c           | 16 ++++++++++
 arch/riscv/kernel/acpi_numa.c      |  9 ++++--
 arch/x86/include/asm/cpu.h         |  1 -
 arch/x86/include/asm/smp.h         |  1 -
 arch/x86/kernel/acpi/boot.c        | 20 ++++++++++++
 arch/x86/xen/enlighten_hvm.c       |  5 +--
 drivers/acpi/pptt.c                | 50 ++++++++++++++++++++++--------
 drivers/acpi/riscv/rhct.c          |  7 ++++-
 drivers/pci/tph.c                  | 16 +++++++---
 drivers/perf/arm_cspmu/arm_cspmu.c |  6 ++--
 include/linux/acpi.h               | 11 +++++++
 include/linux/pci-tph.h            |  4 +--
 18 files changed, 158 insertions(+), 57 deletions(-)

-- 
2.17.1


