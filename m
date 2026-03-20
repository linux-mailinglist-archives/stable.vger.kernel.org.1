Return-Path: <stable+bounces-227424-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UNkMLq28vGlC2gIAu9opvQ
	(envelope-from <stable+bounces-227424-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 04:19:09 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 70F9E2D5723
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 04:19:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ABBFA3055F81
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 03:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC6562DFA2F;
	Fri, 20 Mar 2026 03:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="MIxrkXi9"
X-Original-To: stable@vger.kernel.org
Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0482E6CA6;
	Fri, 20 Mar 2026 03:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773976675; cv=none; b=WWolD1XKYv6iDAFJzYjntIgk4IfbEAIwYVLsZ4SJ3Oc1MGgxUxoXcLeYCsqukL/8yzYiEd/qTgMa+X/OcfRVuBQVIi39CpWTuh3ds/6t4KKzPE1nXX77f8o1FUIL/pM/khqlfvA9CCwdGI/n8m3oqUuknQGMEoT93gkYQ/ect+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773976675; c=relaxed/simple;
	bh=lw/ZE2DX0T6qWzkDdvlLAqLw9jOCvb280xzuRRSLqz8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=C1lslyKkX4+1mZaKYjq/5bRw3AD+5NJZ41Lmbfm+UPY43MJr7pf6OcjOJHyct4HHe6tNziCe2MXSm2Z6F/jspAfL462Ori6YoGDYKi4BXDDaLEXqWzAYgtrs/f2Fvz/DlTPZMpKMkG0c0Dl1MDAZkHbiX8WPaewU7CV4CdV+ons=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=MIxrkXi9; arc=none smtp.client-ip=113.46.200.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=BSRbjJDKdaGxbUo/K8gqf6JQzc2twFPR77ICmENPgIQ=;
	b=MIxrkXi9nr96VTs83oM4cRd7w+yFrG/lh54DDqdd6CvvvRceY55ubQT28/1aq6Hbg1rNmzRkP
	rLYTV3ixY/D1xC9iqJhIH1H8nK9oVSuMP+gE0i1HS/wIlpkqSBix2mhb57dsWBdQ4qYcfLEjbln
	uzIYmB35vjixX1vabMNe7FI=
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4fcSKG5BvHzcZxn;
	Fri, 20 Mar 2026 11:12:02 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
	by mail.maildlp.com (Postfix) with ESMTPS id EEB6840363;
	Fri, 20 Mar 2026 11:17:44 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 20 Mar 2026 11:17:43 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Catalin Marinas
	<catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, "Rafael J .
 Wysocki" <rafael@kernel.org>
CC: Jonathan Corbet <corbet@lwn.net>, Palmer Dabbelt <palmer@dabbelt.com>,
	Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>, Juergen
 Gross <jgross@suse.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Len
 Brown <lenb@kernel.org>, Sunil V L <sunilvl@ventanamicro.com>, Mark Rutland
	<mark.rutland@arm.com>, Jonathan Cameron <jonathan.cameron@huawei.com>, Kees
 Cook <kees@kernel.org>, Yanteng Si <si.yanteng@linux.dev>, Sean
 Christopherson <seanjc@google.com>, Kai Huang <kai.huang@intel.com>, Tom
 Lendacky <thomas.lendacky@amd.com>, Thomas Huth <thuth@redhat.com>, Thorsten
 Blum <thorsten.blum@linux.dev>, Kevin Loughlin <kevinloughlin@google.com>,
	Zheyun Shen <szy0127@sjtu.edu.cn>, Peter Zijlstra <peterz@infradead.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Xin Li <xin@zytor.com>,
	"Ahmed S . Darwish" <darwi@linutronix.de>, Sohil Mehta
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
	<linux-perf-users@vger.kernel.org>, <stable@vger.kernel.org>
Subject: [PATCH v10 0/8] ACPI: Unify CPU UID interface and fix ARM64 TPH steer-tag issue
Date: Fri, 20 Mar 2026 11:17:29 +0800
Message-ID: <20260320031737.35048-1-fengchengwen@huawei.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
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
	TAGGED_FROM(0.00)[bounces-227424-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fengchengwen@huawei.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	RCPT_COUNT_GT_50(0.00)[60];
	DKIM_TRACE(0.00)[huawei.com:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,huawei.com:dkim,huawei.com:mid]
X-Rspamd-Queue-Id: 70F9E2D5723
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
unified interface required for the ARM64 TPH fix.

---
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


