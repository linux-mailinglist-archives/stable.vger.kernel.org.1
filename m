Return-Path: <stable+bounces-227427-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GLCTIZu8vGlc2gIAu9opvQ
	(envelope-from <stable+bounces-227427-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 04:18:51 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 722EC2D56F0
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 04:18:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3A09D302794E
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 03:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A142F3033E8;
	Fri, 20 Mar 2026 03:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="J5TZKxoH"
X-Original-To: stable@vger.kernel.org
Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E63280CFC;
	Fri, 20 Mar 2026 03:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773976679; cv=none; b=phZyWVwIxu07RuXGYiDU+lJzG1d/I4XGs/5wlNr0U5dA5GcIft9NFq3kxFZOFN767Nz222dd/9I9tetxykrvJ/WXkqBOg5D3WDDlzGpve/BiX3TRk3ofICOJwvRImrvcnu/UJKnq/Jbb8+trYxE0Zvuk0WEIKv9uWeN1nEXTVYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773976679; c=relaxed/simple;
	bh=JJ+irYO0/Sk53ifwdtDInLmbzYF7zyJYMf5T6EoJuv4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t8oMzOeQizux8nUdqVuCI+f0VEcsBVauQ6T7uL6JyQFu9NRZjJW8HDCNkB9aJOLPBWuS6ZSEazYBcUYnOvWdbFamk4hq0y7TIuDoc2KSYwKQEfZ3g0hhFTtx2eKRckGlMXLA+k97J73spE0Tv+8sDWKXBT8wwY37VNODyVSxHRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=J5TZKxoH; arc=none smtp.client-ip=113.46.200.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=zauzEDoW1iZZVg1rc8HmzuZCwLSftmOLfB8Jb8RY2BQ=;
	b=J5TZKxoHIReSEQmbTRfXFVLNZ+/IUwuE+uW11i8+jkMuLeZGtwJVXLQfuq4LHOSczhwfghmzc
	YFCMaPt2RTCEgwugJISj0LKEbk2ZW0qVVKN1TRrnTPUfnEonx2LqeBG0wXshmZawXX2M7xbOaMf
	BcPDzWOBbKROUN5RO0vtU+I=
Received: from mail.maildlp.com (unknown [172.19.163.15])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4fcSK46rJzzLlVb;
	Fri, 20 Mar 2026 11:11:52 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
	by mail.maildlp.com (Postfix) with ESMTPS id 7BEF640565;
	Fri, 20 Mar 2026 11:17:54 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 20 Mar 2026 11:17:52 +0800
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
Subject: [PATCH v10 6/8] perf: arm_cspmu: Switch to acpi_get_cpu_uid() from get_acpi_id_for_cpu()
Date: Fri, 20 Mar 2026 11:17:35 +0800
Message-ID: <20260320031737.35048-7-fengchengwen@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260320031737.35048-1-fengchengwen@huawei.com>
References: <20260320031737.35048-1-fengchengwen@huawei.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-227427-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fengchengwen@huawei.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	RCPT_COUNT_GT_50(0.00)[60];
	DKIM_TRACE(0.00)[huawei.com:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 722EC2D56F0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Update arm_cspmu to use acpi_get_cpu_uid() instead of
get_acpi_id_for_cpu(), aligning with unified ACPI CPU UID interface.

No functional changes are introduced by this switch (valid inputs retain
original behavior).

Cc: stable@vger.kernel.org
Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
---
 drivers/perf/arm_cspmu/arm_cspmu.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/perf/arm_cspmu/arm_cspmu.c b/drivers/perf/arm_cspmu/arm_cspmu.c
index 34430b68f602..ed72c3d1f796 100644
--- a/drivers/perf/arm_cspmu/arm_cspmu.c
+++ b/drivers/perf/arm_cspmu/arm_cspmu.c
@@ -1107,15 +1107,17 @@ static int arm_cspmu_acpi_get_cpus(struct arm_cspmu *cspmu)
 {
 	struct acpi_apmt_node *apmt_node;
 	int affinity_flag;
+	u32 cpu_uid;
 	int cpu;
+	int ret;
 
 	apmt_node = arm_cspmu_apmt_node(cspmu->dev);
 	affinity_flag = apmt_node->flags & ACPI_APMT_FLAGS_AFFINITY;
 
 	if (affinity_flag == ACPI_APMT_FLAGS_AFFINITY_PROC) {
 		for_each_possible_cpu(cpu) {
-			if (apmt_node->proc_affinity ==
-			    get_acpi_id_for_cpu(cpu)) {
+			ret = acpi_get_cpu_uid(cpu, &cpu_uid);
+			if (ret == 0 && apmt_node->proc_affinity == cpu_uid) {
 				cpumask_set_cpu(cpu, &cspmu->associated_cpus);
 				break;
 			}
-- 
2.17.1


