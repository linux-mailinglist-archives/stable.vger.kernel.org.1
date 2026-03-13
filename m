Return-Path: <stable+bounces-225229-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YFTXCsp0s2mwWgAAu9opvQ
	(envelope-from <stable+bounces-225229-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 03:22:02 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2909F27CA7A
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 03:22:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2D4783026BF4
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 02:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CD3133F5B6;
	Fri, 13 Mar 2026 02:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="k2FbFqJD"
X-Original-To: stable@vger.kernel.org
Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48AE8227B94;
	Fri, 13 Mar 2026 02:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773368516; cv=none; b=KXLAxii3OpOBP3TOj4PRVL+N5QHy4pJr8u+OCCMIShF8NLV/BqVXPcpIb6NwzoN7d4r6GKgxpfR+GEpCN+CWC3S1KuywTwZrWaqNvwn22HtrhE3VjjcGYs3I2O8ojuWnTMlRF3b2mhKrh/WK+BGxRh2Bc6D4bx0shDIKLmTZsUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773368516; c=relaxed/simple;
	bh=C8FH3g7QQHs/jbvPrgWRUijURB3c8zk5RpSybl32ieg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=i3yeqaj4kCaqogpevAHIF6hm6YnsBCqvD1p0dZcrUev9LTWVIIC06D0uh//hkr4ApuQhAh0Hq1Alj9NGSQ3hdS/PcTjPuzOWBTJUoseWG1CwMaciGLD0YEL4iS3bAdgz8jw2ZUe/I2z2rMj4/hydg3ZzAbuCkLhkUvG2XjCBTjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=k2FbFqJD; arc=none smtp.client-ip=113.46.200.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=2rcpAa1TtZWLDIvssxD1LEn5AvFd7LlqWNSfVu4tX3w=;
	b=k2FbFqJDheDFD8ZQ1TIKD7MLAMU7NtAmyzZS79wyrByImlG/9Oz+7Ht/PCD+SNciSCiVeFaBq
	3VV/zPoCsVqgcC+m0j9DJ69/4Lo6oVqnv6AFub2EAZnQ3hPUkQ+J/R+M/YieceCx1b3KO4HESDm
	4ZRimNSFXHPkX5qqZZQWUsU=
Received: from mail.maildlp.com (unknown [172.19.162.140])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4fX7QX0pcgzpTJ7;
	Fri, 13 Mar 2026 10:16:36 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
	by mail.maildlp.com (Postfix) with ESMTPS id 9A98E2022B;
	Fri, 13 Mar 2026 10:21:50 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 13 Mar 2026 10:21:49 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Catalin Marinas
	<catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, "Rafael J .
 Wysocki" <rafael@kernel.org>
CC: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
	Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, Paul
 Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
	<aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, Thomas Gleixner
	<tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, <x86@kernel.org>,
	"H . Peter Anvin" <hpa@zytor.com>, Juergen Gross <jgross@suse.com>, Sohil
 Mehta <sohil.mehta@intel.com>, Ilkka Koskinen <ilkka@os.amperecomputing.com>,
	Robin Murphy <robin.murphy@arm.com>, James Clark <james.clark@linaro.org>,
	Besar Wicaksono <bwicaksono@nvidia.com>, Ma Ke <make24@iscas.ac.cn>, Wei
 Huang <wei.huang2@amd.com>, Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Somnath Kotur <somnath.kotur@broadcom.com>, <kees@kernel.org>,
	<punit.agrawal@oss.qualcomm.com>, <guohanjun@huawei.com>,
	<suzuki.poulose@arm.com>, <ryan.roberts@arm.com>, <chenl311@chinatelecom.cn>,
	<masahiroy@kernel.org>, <wangyuquan1236@phytium.com.cn>,
	<anshuman.khandual@arm.com>, <heinrich.schuchardt@canonical.com>,
	<Eric.VanTassell@amd.com>, <jonathan.cameron@huawei.com>,
	<wangzhou1@hisilicon.com>, <wanghuiqiang@huawei.com>,
	<liuyonglong@huawei.com>, <fengchengwen@huawei.com>,
	<linux-pci@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<loongarch@lists.linux.dev>, <linux-riscv@lists.infradead.org>,
	<xen-devel@lists.xenproject.org>, <linux-acpi@vger.kernel.org>,
	<linux-perf-users@vger.kernel.org>, <stable@vger.kernel.org>
Subject: [PATCH v7 0/3] Fix get cpu steer-tag fail on ARM64 platform
Date: Fri, 13 Mar 2026 10:21:41 +0800
Message-ID: <20260313022144.40942-1-fengchengwen@huawei.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemk500009.china.huawei.com (7.202.194.94)
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-225229-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fengchengwen@huawei.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_GT_50(0.00)[54];
	DKIM_TRACE(0.00)[huawei.com:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,huawei.com:dkim,huawei.com:mid]
X-Rspamd-Queue-Id: 2909F27CA7A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This patchset fixes the failure of CPU steer tag retrieval on ARM64
platforms. The series is structured as follows:

1. First commit: Refactor the ACPI Processor UID retrieval interface
   (no functional changes when input valid) to align naming conventions
   across arm64/riscv/loongarch architectures;
2. Second commit: Implement acpi_get_cpu_uid() for the x86 platform to
   complete the unified ACPI Processor UID interface across all
   ACPI-enabled architectures;
3. Third commit: Implement the core fix for the CPU steer tag retrieval
   logic on ARM64 (the root cause of the retrieval failure).

The refactor and x86 implementation lay the groundwork for the unified
ACPI interface required by the ARM64 steer tag fix, ensuring consistent
CPU UID retrieval across architectures before addressing the functional
bug.

---
Changes in v7:
- Refine first commit which address Jonathan's reviews
- Fix x86 implement bug (not consider INVALID-ID) which address Peter's
  review
- Fix CI error of x86 implement by moving function to acpi/boot.c

Changes in v6:
- Rename existing get_acpi_id_for_cpu() to acpi_get_cpu_uid()
- Split x86's modify as one commit

Changes in v5:
- Refine commit-log of commit 2/2
- Replace cpu_acpi_id() by acpi_get_cpu_acpi_id() on x86

Changes in v4:
- Split the rename into a separate commit.

Changes in v3:
- Rename existing get_acpi_id_for_cpu() to acpi_get_cpu_acpi_id() other
  than add one new API.

Changes in v2:
- Add ECN _DSM reference doc name and its URL.
- Separate implement acpi_get_cpu_acpi_id() in each arch which supports
  ACPI.
- Refine commit-log

Chengwen Feng (3):
  ACPI: Refactor get_acpi_id_for_cpu() to acpi_get_cpu_uid() on non-x86
  x86: Implement acpi_get_cpu_uid()
  PCI/TPH: Fix get cpu steer-tag fail on ARM64 platform

 Documentation/PCI/tph.rst          |  4 +--
 arch/arm64/include/asm/acpi.h      | 16 +---------
 arch/arm64/kernel/acpi.c           | 16 ++++++++++
 arch/arm64/kernel/acpi_numa.c      | 14 +++++++++
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
 19 files changed, 158 insertions(+), 56 deletions(-)

-- 
2.17.1


