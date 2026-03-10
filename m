Return-Path: <stable+bounces-223745-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iOTCB5aOr2kragIAu9opvQ
	(envelope-from <stable+bounces-223745-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 04:23:02 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AECC2244BCC
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 04:23:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 369E2315923D
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 03:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9A893BA243;
	Tue, 10 Mar 2026 03:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="fxjB361v"
X-Original-To: stable@vger.kernel.org
Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C67D385501;
	Tue, 10 Mar 2026 03:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773112864; cv=none; b=WLtaG4FVBaqccwbl5Gfaruce8NRiWMJpKbrC7JhlZxZXFS4EYcbgiMhmbIpG4t/u6wJ4dq6sbEUl5O38rKhPoFz0jcKQpLjYBGJmRDeMhAlL79/NjPZDy+e/Zi3u5rXZS5Dhr7WcdLTW8zYf1F8V/jem7fw/4Jtu5clPVYF6q50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773112864; c=relaxed/simple;
	bh=e9DKhxJ7I29sGub6miMoMkUxUTyXd5sexvIzavurIVA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YIHVMMxTAq8sdyYl2R+WyJBaR1VQ0QktURP3XqB84RWeNWeJ4LOogxSm9DiLgPKcWBMwmvHG7BiZBb/zq1yDhLjRt2rn2+1My9bV9v0t9y/6EDb1t8N40J3dSf5sTExiot0zwYw5EOT+uR2cyBkfhhNB6FBB91gRAfyTwxb+Wog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=fxjB361v; arc=none smtp.client-ip=113.46.200.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=CoRpNTmhms6uOa5K4ZBNB1qadS4KRwgybZKo09j4UpA=;
	b=fxjB361v9DDU1Vc+vLq2UHX6kf3YaHF64h4a8BYjj4aAMs12yChq1Z0Yq6LWSEtvySPL+BtAo
	SmhO/UwvL3+krDUwG6Ey2Y4dTPD6DcU6QbkOWDYEtWJMfpBjNaajoNIgGcRf4UfrVM1Nvz67TAV
	1UXfCWkUyhSSX4AnepSv81U=
Received: from mail.maildlp.com (unknown [172.19.163.104])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4fVJtT143zz1prR7;
	Tue, 10 Mar 2026 11:16:01 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
	by mail.maildlp.com (Postfix) with ESMTPS id 00BA9404AD;
	Tue, 10 Mar 2026 11:20:58 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 10 Mar 2026 11:20:56 +0800
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
	"H . Peter Anvin" <hpa@zytor.com>, Juergen Gross <jgross@suse.com>, Boris
 Ostrovsky <boris.ostrovsky@oracle.com>, Len Brown <lenb@kernel.org>, Sunil V
 L <sunilvl@ventanamicro.com>, Mark Rutland <mark.rutland@arm.com>, Chengwen
 Feng <fengchengwen@huawei.com>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Kees Cook <kees@kernel.org>, Yanteng Si
	<si.yanteng@linux.dev>, Sean Christopherson <seanjc@google.com>, Kai Huang
	<kai.huang@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, Thomas Huth
	<thuth@redhat.com>, Thorsten Blum <thorsten.blum@linux.dev>, Kevin Loughlin
	<kevinloughlin@google.com>, Zheyun Shen <szy0127@sjtu.edu.cn>, Peter Zijlstra
	<peterz@infradead.org>, Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Xin
 Li <xin@zytor.com>, "Ahmed S . Darwish" <darwi@linutronix.de>, Sohil Mehta
	<sohil.mehta@intel.com>, Ilkka Koskinen <ilkka@os.amperecomputing.com>, Robin
 Murphy <robin.murphy@arm.com>, James Clark <james.clark@linaro.org>, Besar
 Wicaksono <bwicaksono@nvidia.com>, Ma Ke <make24@iscas.ac.cn>, Ajit Khaparde
	<ajit.khaparde@broadcom.com>, Wei Huang <wei.huang2@amd.com>, Andy Gospodarek
	<andrew.gospodarek@broadcom.com>, Somnath Kotur <somnath.kotur@broadcom.com>,
	<wangzhou1@hisilicon.com>, <wanghuiqiang@huawei.com>,
	<liuyonglong@huawei.com>, <linux-pci@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <loongarch@lists.linux.dev>,
	<linux-riscv@lists.infradead.org>, <xen-devel@lists.xenproject.org>,
	<linux-acpi@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
	<stable@vger.kernel.org>
Subject: [PATCH v5 0/2] Fix get cpu steer-tag fail on ARM64 platform
Date: Tue, 10 Mar 2026 11:20:47 +0800
Message-ID: <20260310032049.25387-1-fengchengwen@huawei.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemk500009.china.huawei.com (7.202.194.94)
X-Rspamd-Queue-Id: AECC2244BCC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-223745-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fengchengwen@huawei.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_GT_50(0.00)[61];
	DKIM_TRACE(0.00)[huawei.com:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:dkim,huawei.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

This patchset addresses the issue where retrieving the CPU steer-tag
fails on ARM64 platforms. The first commit is a pure renaming of the
ACPI CPU ID retrieval interface (no functional changes), which serves
as preparation for the second commit that implements the core fix for
the steer-tag retrieval logic.

---
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
- Refine commit-log.

Chengwen Feng (2):
  ACPI: Rename get_acpi_id_for_cpu() to acpi_get_cpu_acpi_id() on
    non-x86
  PCI/TPH: Fix get cpu steer-tag fail on ARM64 platform

 Documentation/PCI/tph.rst          |  4 ++--
 arch/arm64/include/asm/acpi.h      |  4 ++--
 arch/loongarch/include/asm/acpi.h  |  2 +-
 arch/riscv/include/asm/acpi.h      |  2 +-
 arch/riscv/kernel/acpi_numa.c      |  2 +-
 arch/x86/include/asm/acpi.h        |  2 ++
 arch/x86/include/asm/cpu.h         |  1 -
 arch/x86/include/asm/smp.h         |  1 -
 arch/x86/kernel/cpu/common.c       | 12 ++++++++++++
 arch/x86/xen/enlighten_hvm.c       |  4 ++--
 drivers/acpi/pptt.c                | 16 ++++++++--------
 drivers/acpi/riscv/rhct.c          |  2 +-
 drivers/pci/tph.c                  | 11 ++++++-----
 drivers/perf/arm_cspmu/arm_cspmu.c |  2 +-
 include/linux/pci-tph.h            |  4 ++--
 15 files changed, 41 insertions(+), 28 deletions(-)

-- 
2.17.1


