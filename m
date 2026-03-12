Return-Path: <stable+bounces-224843-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6JToOpOesmndOAAAu9opvQ
	(envelope-from <stable+bounces-224843-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 12:08:03 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 87DA1270A5F
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 12:08:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 942A230752DE
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 11:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F54F39B973;
	Thu, 12 Mar 2026 11:07:52 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07CAA3630A1;
	Thu, 12 Mar 2026 11:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773313672; cv=none; b=rjaIu/hlisHE1LrkPw0ioMoa7d3Z6h11PQ7nbj7Edr4jRoOheTfSoufH1Gaz7m6UKCGBHTcIUyD0Kbvz5AHABQwNzen+ykCcC6vpd/zbhw4yJRFgNsOc1snL5693Fpl2NasJ5gMrfjsuEVaARCiDUv2lUrIj9cfHD+LccbfuYLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773313672; c=relaxed/simple;
	bh=quM1dCUzex7hsDIaji+Lt2uHH4N7ImU0pUBpHPkVSAQ=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cAxieauDUHkh4UXQXzzDaX7q2qZ4DlRED3Fhs0wnJkdfkBePv5HthFIYoL6XX/7v0uxBteCFjjDdVJtMRu7sBkGkMW/RJsWGoLXKtLx02map7mcA8sCSe6BZuBeKdi/3gExVxmU2nIr2i26XeGzBfrhdGttBIEbgs0zHAEAXsFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.107])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fWlDy35XXzJ46fJ;
	Thu, 12 Mar 2026 19:06:58 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id 29C2E40584;
	Thu, 12 Mar 2026 19:07:46 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 12 Mar
 2026 11:07:43 +0000
Date: Thu, 12 Mar 2026 11:07:42 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Chengwen Feng <fengchengwen@huawei.com>
CC: Bjorn Helgaas <bhelgaas@google.com>, Catalin Marinas
	<catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, "Rafael J .
 Wysocki" <rafael@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
	<skhan@linuxfoundation.org>, Huacai Chen <chenhuacai@kernel.org>, "WANG
 Xuerui" <kernel@xen0n.name>, Paul Walmsley <pjw@kernel.org>, "Palmer Dabbelt"
	<palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, "Alexandre Ghiti"
	<alex@ghiti.fr>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar
	<mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, "H . Peter Anvin"
	<hpa@zytor.com>, Juergen Gross <jgross@suse.com>, Boris Ostrovsky
	<boris.ostrovsky@oracle.com>, Len Brown <lenb@kernel.org>, Sunil V L
	<sunilvl@ventanamicro.com>, Mark Rutland <mark.rutland@arm.com>, Kees Cook
	<kees@kernel.org>, Yanteng Si <si.yanteng@linux.dev>, Sean Christopherson
	<seanjc@google.com>, Kai Huang <kai.huang@intel.com>, Tom Lendacky
	<thomas.lendacky@amd.com>, Thomas Huth <thuth@redhat.com>, Thorsten Blum
	<thorsten.blum@linux.dev>, Kevin Loughlin <kevinloughlin@google.com>, Zheyun
 Shen <szy0127@sjtu.edu.cn>, Peter Zijlstra <peterz@infradead.org>, Pawan
 Gupta <pawan.kumar.gupta@linux.intel.com>, Xin Li <xin@zytor.com>, "Ahmed S .
 Darwish" <darwi@linutronix.de>, Sohil Mehta <sohil.mehta@intel.com>, Ilkka
 Koskinen <ilkka@os.amperecomputing.com>, Robin Murphy <robin.murphy@arm.com>,
	James Clark <james.clark@linaro.org>, Besar Wicaksono
	<bwicaksono@nvidia.com>, Ma Ke <make24@iscas.ac.cn>, "Wei Huang"
	<wei.huang2@amd.com>, Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Somnath Kotur <somnath.kotur@broadcom.com>, <punit.agrawal@oss.qualcomm.com>,
	<guohanjun@huawei.com>, <suzuki.poulose@arm.com>, <ryan.roberts@arm.com>,
	<chenl311@chinatelecom.cn>, <masahiroy@kernel.org>,
	<wangyuquan1236@phytium.com.cn>, <anshuman.khandual@arm.com>,
	<heinrich.schuchardt@canonical.com>, <Eric.VanTassell@amd.com>,
	<wangzhou1@hisilicon.com>, <wanghuiqiang@huawei.com>,
	<liuyonglong@huawei.com>, <linux-pci@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <loongarch@lists.linux.dev>,
	<linux-riscv@lists.infradead.org>, <xen-devel@lists.xenproject.org>,
	<linux-acpi@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
	<stable@vger.kernel.org>
Subject: Re: [PATCH v6 1/3] ACPI: Rename get_acpi_id_for_cpu() to
 acpi_get_cpu_uid() on non-x86
Message-ID: <20260312110742.00002716@huawei.com>
In-Reply-To: <20260312072316.4806-2-fengchengwen@huawei.com>
References: <20260312072316.4806-1-fengchengwen@huawei.com>
	<20260312072316.4806-2-fengchengwen@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml500012.china.huawei.com (7.191.174.4) To
 dubpeml500005.china.huawei.com (7.214.145.207)
X-Spamd-Result: default: False [0.04 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[huawei.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-224843-lists,stable=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jonathan.cameron@huawei.com,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-0.944];
	RCPT_COUNT_GT_50(0.00)[69];
	R_DKIM_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,huawei.com:email,huawei.com:mid]
X-Rspamd-Queue-Id: 87DA1270A5F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 12 Mar 2026 15:23:14 +0800
Chengwen Feng <fengchengwen@huawei.com> wrote:

> To unify the CPU ACPI ID retrieval interface across architectures,
> rename the existing get_acpi_id_for_cpu() function to
> acpi_get_cpu_uid() on arm64/riscv/loongarch platforms.
>=20
> This is a pure rename with no functional change, preparing for a

It's not just a rename.  This should mention that the addition of error
checks and hence the resulting signature change.

> consistent ACPI Processor UID retrieval interface across all ACPI-enabled
> platforms.
>=20
> Note: Move the ARM64-specific get_cpu_for_acpi_id() implementation to
>       arch/arm64/kernel/acpi_numa.c to fix compilation errors from
>       circular header dependencies introduced by the rename.
>=20
> Cc: stable@vger.kernel.org
> Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
=46rom a reread, a few minor style consistency things inline.

> ---
>  arch/arm64/include/asm/acpi.h      | 16 +---------
>  arch/arm64/kernel/acpi.c           | 16 ++++++++++
>  arch/arm64/kernel/acpi_numa.c      | 15 ++++++++++
>  arch/loongarch/include/asm/acpi.h  |  5 ----
>  arch/loongarch/kernel/acpi.c       |  9 ++++++
>  arch/riscv/include/asm/acpi.h      |  4 ---
>  arch/riscv/kernel/acpi.c           | 16 ++++++++++
>  arch/riscv/kernel/acpi_numa.c      |  8 +++--
>  drivers/acpi/pptt.c                | 47 +++++++++++++++++++++---------
>  drivers/acpi/riscv/rhct.c          |  7 ++++-
>  drivers/perf/arm_cspmu/arm_cspmu.c |  6 ++--
>  include/linux/acpi.h               | 13 +++++++++
>  12 files changed, 120 insertions(+), 42 deletions(-)

> diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
> index af90128cfed5..984a11788265 100644
> --- a/arch/arm64/kernel/acpi.c
> +++ b/arch/arm64/kernel/acpi.c
> @@ -458,3 +458,19 @@ int acpi_unmap_cpu(int cpu)
>  }
>  EXPORT_SYMBOL(acpi_unmap_cpu);
>  #endif /* CONFIG_ACPI_HOTPLUG_CPU */
> +
> +int acpi_get_cpu_uid(unsigned int cpu, u32 *uid)
> +{
> +	struct acpi_madt_generic_interrupt *gicc;
> +
> +	if (cpu >=3D nr_cpu_ids)
> +		return -EINVAL;
> +
> +	gicc =3D acpi_cpu_get_madt_gicc(cpu);
> +	if (gicc =3D=3D NULL)

Seems local style for null pointer checks is
	if (!gicc)
Just for consistency we should follow that.

> +		return -ENODEV;
> +
> +	*uid =3D gicc->uid;
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(acpi_get_cpu_uid);
> diff --git a/arch/arm64/kernel/acpi_numa.c b/arch/arm64/kernel/acpi_numa.c
> index 2465f291c7e1..56e2e486e49b 100644
> --- a/arch/arm64/kernel/acpi_numa.c
> +++ b/arch/arm64/kernel/acpi_numa.c
> @@ -34,6 +34,21 @@ int __init acpi_numa_get_nid(unsigned int cpu)
>  	return acpi_early_node_map[cpu];
>  }
> =20
> +int get_cpu_for_acpi_id(u32 uid)
> +{
> +	u32 cpu_uid;
> +	int cpu;
> +	int ret;
> +
> +	for (cpu =3D 0; cpu < nr_cpu_ids; cpu++) {

Given more recent acceptance of the following perhaps it is neater here.

	for (int cpu =3D 0; cpu < nr_cpu_ids; cpu++) {

Amazingly there aren't any for loops in this file so we can do what we
like from a consistency point of view.


> +		ret =3D acpi_get_cpu_uid(cpu, &cpu_uid);
> +		if (ret =3D=3D 0 && uid =3D=3D cpu_uid)
> +			return cpu;
> +	}
> +
> +	return -EINVAL;
> +}
> +
>  static int __init acpi_parse_gicc_pxm(union acpi_subtable_headers *heade=
r,
>  				      const unsigned long end)
>  {


> diff --git a/arch/riscv/kernel/acpi.c b/arch/riscv/kernel/acpi.c
> index 71698ee11621..bde810d02c4f 100644
> --- a/arch/riscv/kernel/acpi.c
> +++ b/arch/riscv/kernel/acpi.c
> @@ -337,3 +337,19 @@ int raw_pci_write(unsigned int domain, unsigned int =
bus,
>  }
> =20
>  #endif	/* CONFIG_PCI */
> +
> +int acpi_get_cpu_uid(unsigned int cpu, u32 *uid)
> +{
> +	struct acpi_madt_rintc *rintc;
> +
> +	if (cpu >=3D nr_cpu_ids)
> +		return -EINVAL;
> +
> +	rintc =3D acpi_cpu_get_madt_rintc(cpu);
> +	if (rintc =3D=3D NULL)

Similar to above. Local style for NULL checks is
	if (!rintc)
so this should follow that.
> +		return -ENODEV;
> +
> +	*uid =3D rintc->uid;
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(acpi_get_cpu_uid);
> diff --git a/arch/riscv/kernel/acpi_numa.c b/arch/riscv/kernel/acpi_numa.c
> index 130769e3a99c..cd8adc9857e3 100644
> --- a/arch/riscv/kernel/acpi_numa.c
> +++ b/arch/riscv/kernel/acpi_numa.c
> @@ -37,11 +37,15 @@ static int __init acpi_numa_get_nid(unsigned int cpu)
> =20
>  static inline int get_cpu_for_acpi_id(u32 uid)
>  {
> +	u32 cpu_uid;
>  	int cpu;
> +	int ret;
> =20
> -	for (cpu =3D 0; cpu < nr_cpu_ids; cpu++)
> -		if (uid =3D=3D get_acpi_id_for_cpu(cpu))
> +	for (cpu =3D 0; cpu < nr_cpu_ids; cpu++) {

Can pull the int into the loop her as well.

> +		ret =3D acpi_get_cpu_uid(cpu, &cpu_uid);
> +		if (ret =3D=3D 0 && uid =3D=3D cpu_uid)
>  			return cpu;
> +	}
> =20
>  	return -EINVAL;
>  }
> diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
> index de5f8c018333..d034a217e85b 100644
> --- a/drivers/acpi/pptt.c
> +++ b/drivers/acpi/pptt.c

>  static int check_acpi_cpu_flag(unsigned int cpu, int rev, u32 flag)
>  {
>  	struct acpi_table_header *table;
> -	u32 acpi_cpu_id =3D get_acpi_id_for_cpu(cpu);
> +	u32 acpi_cpu_id;
>  	struct acpi_pptt_processor *cpu_node =3D NULL;
>  	int ret =3D -ENOENT;
> =20
> +	if (acpi_get_cpu_uid(cpu, &acpi_cpu_id) !=3D 0)
> +		return -ENOENT;
> +
>  	table =3D acpi_get_pptt();
>  	if (!table)
>  		return -ENOENT;
> @@ -651,7 +661,8 @@ static int check_acpi_cpu_flag(unsigned int cpu, int =
rev, u32 flag)
>   * in the PPTT. Errors caused by lack of a PPTT table, or otherwise, ret=
urn 0
>   * indicating we didn't find any cache levels.
>   *
> - * Return: -ENOENT if no PPTT table or no PPTT processor struct found.
> + * Return: -ENOENT if no PPTT table, can't get CPU's ACPI Process UID or=
 no PPTT
> + *	   processor struct found.
>   *	   0 on success.
>   */
>  int acpi_get_cache_info(unsigned int cpu, unsigned int *levels,
> @@ -671,7 +682,8 @@ int acpi_get_cache_info(unsigned int cpu, unsigned in=
t *levels,
> =20
>  	pr_debug("Cache Setup: find cache levels for CPU=3D%d\n", cpu);
> =20
> -	acpi_cpu_id =3D get_acpi_id_for_cpu(cpu);
> +	if (acpi_get_cpu_uid(cpu, &acpi_cpu_id))
> +		return -ENOENT;
I'd put a blank line here (similar to the code you added just above).
>  	cpu_node =3D acpi_find_processor_node(table, acpi_cpu_id);
>  	if (!cpu_node)
>  		return -ENOENT;
> @@ -780,8 +792,9 @@ int find_acpi_cpu_topology_package(unsigned int cpu)
>   * It may not exist in single CPU systems. In simple multi-CPU systems,
>   * it may be equal to the package topology level.
>   *
> - * Return: -ENOENT if the PPTT doesn't exist, the CPU cannot be found
> - * or there is no toplogy level above the CPU..
> + * Return: -ENOENT if the PPTT doesn't exist, can't get CPU's ACPI
> + * Processor UID, the CPU cannot be found or there is no toplogy level
> + * above the CPU.
>   * Otherwise returns a value which represents the package for this CPU.
>   */
> =20
> @@ -797,7 +810,8 @@ int find_acpi_cpu_topology_cluster(unsigned int cpu)
>  	if (!table)
>  		return -ENOENT;
> =20
> -	acpi_cpu_id =3D get_acpi_id_for_cpu(cpu);
> +	if (acpi_get_cpu_uid(cpu, &acpi_cpu_id) !=3D 0)
> +		return -ENOENT;
Again, I'd put a blank line here.

>  	cpu_node =3D acpi_find_processor_node(table, acpi_cpu_id);
>  	if (!cpu_node || !cpu_node->parent)
>  		return -ENOENT;
> @@ -872,7 +886,8 @@ static void acpi_pptt_get_child_cpus(struct acpi_tabl=
e_header *table_hdr,
>  	cpumask_clear(cpus);
> =20
>  	for_each_possible_cpu(cpu) {
> -		acpi_id =3D get_acpi_id_for_cpu(cpu);
> +		if (acpi_get_cpu_uid(cpu, &acpi_id) !=3D 0)
> +			continue;
and here.
>  		cpu_node =3D acpi_find_processor_node(table_hdr, acpi_id);
> =20
>  		while (cpu_node) {



