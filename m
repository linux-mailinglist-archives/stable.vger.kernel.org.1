Return-Path: <stable+bounces-181851-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B619BA7C2F
	for <lists+stable@lfdr.de>; Mon, 29 Sep 2025 03:38:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3ED617F884
	for <lists+stable@lfdr.de>; Mon, 29 Sep 2025 01:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 431701E231E;
	Mon, 29 Sep 2025 01:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="E3iVFuLC"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1915D1DF26E
	for <stable@vger.kernel.org>; Mon, 29 Sep 2025 01:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759109898; cv=none; b=SdQX/SGUIztcuVO80sLTydefS0w/GPAw1wb1ESshzX2oboIjwpYyCn747wSHTLL/A/RvsGU2du3aPaGiylxAMcyxbka26SSdHX5Z4e59eMrnon/498mYP5CEwZA9IY3LMwW4/FI64EPjzn+REipbZY4sP4dvou+O7QHKVIdHnqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759109898; c=relaxed/simple;
	bh=WKS9IoxPOgCC27t1BX/cRoqm9Wvuzdo2fUv1SOYP8DA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=slFbso3IF5AM9kvK42IzCZ2JKO24eqs6t1h8spP4EV9yZncJyoELquA2emqKG1d+wAZRiJE96gBX89sjBGkrY28o2U0xUsZCzqRevWcIVOsprGkWp7M6DS3+E4PoRDu74bgaMUyTdi+g0JIyX+dvvTBiCGDSzkMwNTMI1EPlHgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=E3iVFuLC; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58SM0GsK007681;
	Mon, 29 Sep 2025 01:38:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=7mIOv0
	MRtUww0E9YPWmsPlsJwh0njc1X60L8NEUZ/qA=; b=E3iVFuLCIdvCMP3stun7xF
	MUWKyPQIp/IZvqg91LeOFSVus9B0xdtdnLtmHqD4PZg3IHdFl44r0mO+Rn0odBXV
	hrnb3qdfrppQeNkUsIn8htNy4ZW/qskwUzSJqDvgtkoJfoIHokvhCLy+w86zaw5X
	FQoVLsM2TqVCMDq5aJKymnTJv9kGNzr4s0Y8/cRDfC+cqD2VDEW1HKzisAxO2SHg
	Xt6c/vNUyJu9pT48tuFzkFs6wVDxwh++xis0mpIEMIi14g1wK6pDV3TH6K0lfOtF
	/4B16IDc9ivxmV7+ZuZr/BNk5ntWqD/e7HQdtu0gp/J13XpY64swJy9ZsoYEUJOQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49e5bqft03-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Sep 2025 01:38:06 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58T1ae0G010947;
	Mon, 29 Sep 2025 01:38:06 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49e5bqft00-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Sep 2025 01:38:05 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58SM69je020508;
	Mon, 29 Sep 2025 01:38:05 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 49et8rv2nf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Sep 2025 01:38:05 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58T1c1oo46334312
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Sep 2025 01:38:01 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4E54520043;
	Mon, 29 Sep 2025 01:38:01 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8177220040;
	Mon, 29 Sep 2025 01:37:59 +0000 (GMT)
Received: from aboo.ibm.com (unknown [9.150.3.105])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 29 Sep 2025 01:37:59 +0000 (GMT)
Message-ID: <149c66a94a28f33330e2016e50e4f3faad4dd59d.camel@linux.ibm.com>
Subject: Re: [PATCH] powerpc/64s/radix/kfence: map __kfence_pool at page
 granularity
From: Aboorva Devarajan <aboorvad@linux.ibm.com>
To: stable@vger.kernel.org
Cc: hbathini@linux.ibm.com, mpe@ellerman.id.au, ritesh.list@gmail.com,
        aboorvad@linux.ibm.com
Date: Mon, 29 Sep 2025 07:07:58 +0530
In-Reply-To: <20250910110245.123817-1-aboorvad@linux.ibm.com>
References: <20250910110245.123817-1-aboorvad@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI2MDIxNCBTYWx0ZWRfX2kOLyEBkyaOs
 v5YpclLC27XN1mUcXCO+lpVoJo8OUKrBWR6OgbE8DVYPjAy5B6+5RsdSa7lhS8rN4lEPnMVelVx
 /l2iiz8KBceZFnRCTlI/DYVk9dW5anh63Q11QgKjT9kged3dxQT1/b+rRVHcY2huv9oRPY6iHMB
 YjR4Q8JQStG67lFmjp7UrxLrRBlwKo7ia1LL1eF6JmsxHWu4dknuz5K4YvrRl1WC2mb+5V+gJaF
 tmT0jWH+yeoEBwIMoDENU3dA++KCCxwdX/yWEwb+n7663CVLBrsqgbJAcPAIqF6Bcvz+FkU3UTt
 TRfy+i5xBuiIQL5mYBk5QXjclAb7v/T779vVoGf3DALbjGoIq/Fu1zXJF2dAwtDE1M7001N8sIg
 hEHDz2EVx309XIAnXXtqm3IvA0EHig==
X-Proofpoint-GUID: d3dsH_wVQouPufkIV_-cp7M4GgAMfyIv
X-Authority-Analysis: v=2.4 cv=LLZrgZW9 c=1 sm=1 tr=0 ts=68d9e2fe cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=1XWaLZrsAAAA:8
 a=bC-a23v3AAAA:8 a=VnNF1IyMAAAA:8 a=8pUQU5ZKEEYkf1kkbX4A:9 a=QEXdDO2ut3YA:10
 a=FO4_E8m0qiDe52t0p3_H:22 a=poXaRoVlC6wW9_mwW8W4:22 a=HhbK4dLum7pmb74im6QT:22
 a=Z5ABNNGmrOfJ6cZ5bIyy:22 a=SsAZrZ5W_gNWK9tOzrEV:22
X-Proofpoint-ORIG-GUID: JX5w3TUuP-oqj3o-m_bOVj-9PmITcSen
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-28_10,2025-09-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 clxscore=1015 priorityscore=1501 phishscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509260214

On Wed, 2025-09-10 at 16:32 +0530, Aboorva Devarajan wrote:


> From: Hari Bathini <hbathini@linux.ibm.com>
>=20
> When KFENCE is enabled, total system memory is mapped at page level
> granularity. But in radix MMU mode, ~3GB additional memory is needed
> to map 100GB of system memory at page level granularity when compared
> to using 2MB direct mapping.This is not desired considering KFENCE is
> designed to be enabled in production kernels [1].
>=20
> Mapping only the memory allocated for KFENCE pool at page granularity is
> sufficient to enable KFENCE support. So, allocate __kfence_pool during
> bootup and map it at page granularity instead of mapping all system
> memory at page granularity.
>=20
> Without patch:
> =C2=A0 # cat /proc/meminfo
> =C2=A0 MemTotal:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 101201920 kB
>=20
> With patch:
> =C2=A0 # cat /proc/meminfo
> =C2=A0 MemTotal:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 104483904 kB
>=20
> Note that enabling KFENCE at runtime is disabled for radix MMU for now,
> as it depends on the ability to split page table mappings and such APIs
> are not currently implemented for radix MMU.
>=20
> All kfence_test.c testcases passed with this patch.
>=20
> [1] https://lore.kernel.org/all/20201103175841.3495947-2-elver@google.com=
/
>=20
> Fixes: a5edf9815dd7 ("powerpc/64s: Enable KFENCE on book3s64")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> Signed-off-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
> Link: https://msgid.link/20240701130021.578240-1-hbathini@linux.ibm.com
>=20
> ---
>=20
> Upstream commit 353d7a84c214 ("powerpc/64s/radix/kfence: map __kfence_poo=
l at page granularity")
>=20
> This has already been merged upstream and is required in stable kernels a=
s well.
>=20
> ---
> =C2=A0arch/powerpc/include/asm/kfence.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 | 11 +++-
> =C2=A0arch/powerpc/mm/book3s64/radix_pgtable.c | 84 +++++++++++++++++++++=
+--
> =C2=A0arch/powerpc/mm/init-common.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 3 +
> =C2=A03 files changed, 93 insertions(+), 5 deletions(-)
>=20
> diff --git a/arch/powerpc/include/asm/kfence.h b/arch/powerpc/include/asm=
/kfence.h
> index 424ceef82ae615..fab124ada1c7f2 100644
> --- a/arch/powerpc/include/asm/kfence.h
> +++ b/arch/powerpc/include/asm/kfence.h
> @@ -15,10 +15,19 @@
> =C2=A0#define ARCH_FUNC_PREFIX "."
> =C2=A0#endif
> =C2=A0
> +#ifdef CONFIG_KFENCE
> +extern bool kfence_disabled;
> +
> +static inline void disable_kfence(void)
> +{
> +	kfence_disabled =3D true;
> +}
> +
> =C2=A0static inline bool arch_kfence_init_pool(void)
> =C2=A0{
> -	return true;
> +	return !kfence_disabled;
> =C2=A0}
> +#endif
> =C2=A0
> =C2=A0#ifdef CONFIG_PPC64
> =C2=A0static inline bool kfence_protect_page(unsigned long addr, bool pro=
tect)
> diff --git a/arch/powerpc/mm/book3s64/radix_pgtable.c b/arch/powerpc/mm/b=
ook3s64/radix_pgtable.c
> index 15e88f1439ec20..b0d927009af83c 100644
> --- a/arch/powerpc/mm/book3s64/radix_pgtable.c
> +++ b/arch/powerpc/mm/book3s64/radix_pgtable.c
> @@ -17,6 +17,7 @@
> =C2=A0#include <linux/hugetlb.h>
> =C2=A0#include <linux/string_helpers.h>
> =C2=A0#include <linux/memory.h>
> +#include <linux/kfence.h>
> =C2=A0
> =C2=A0#include <asm/pgalloc.h>
> =C2=A0#include <asm/mmu_context.h>
> @@ -31,6 +32,7 @@
> =C2=A0#include <asm/uaccess.h>
> =C2=A0#include <asm/ultravisor.h>
> =C2=A0#include <asm/set_memory.h>
> +#include <asm/kfence.h>
> =C2=A0
> =C2=A0#include <trace/events/thp.h>
> =C2=A0
> @@ -293,7 +295,8 @@ static unsigned long next_boundary(unsigned long addr=
, unsigned long end)
> =C2=A0
> =C2=A0static int __meminit create_physical_mapping(unsigned long start,
> =C2=A0					=C2=A0=C2=A0=C2=A0=C2=A0 unsigned long end,
> -					=C2=A0=C2=A0=C2=A0=C2=A0 int nid, pgprot_t _prot)
> +					=C2=A0=C2=A0=C2=A0=C2=A0 int nid, pgprot_t _prot,
> +					=C2=A0=C2=A0=C2=A0=C2=A0 unsigned long mapping_sz_limit)
> =C2=A0{
> =C2=A0	unsigned long vaddr, addr, mapping_size =3D 0;
> =C2=A0	bool prev_exec, exec =3D false;
> @@ -301,7 +304,10 @@ static int __meminit create_physical_mapping(unsigne=
d long start,
> =C2=A0	int psize;
> =C2=A0	unsigned long max_mapping_size =3D memory_block_size;
> =C2=A0
> -	if (debug_pagealloc_enabled_or_kfence())
> +	if (mapping_sz_limit < max_mapping_size)
> +		max_mapping_size =3D mapping_sz_limit;
> +
> +	if (debug_pagealloc_enabled())
> =C2=A0		max_mapping_size =3D PAGE_SIZE;
> =C2=A0
> =C2=A0	start =3D ALIGN(start, PAGE_SIZE);
> @@ -356,8 +362,74 @@ static int __meminit create_physical_mapping(unsigne=
d long start,
> =C2=A0	return 0;
> =C2=A0}
> =C2=A0
> +#ifdef CONFIG_KFENCE
> +static bool __ro_after_init kfence_early_init =3D !!CONFIG_KFENCE_SAMPLE=
_INTERVAL;
> +
> +static int __init parse_kfence_early_init(char *arg)
> +{
> +	int val;
> +
> +	if (get_option(&arg, &val))
> +		kfence_early_init =3D !!val;
> +	return 0;
> +}
> +early_param("kfence.sample_interval", parse_kfence_early_init);
> +
> +static inline phys_addr_t alloc_kfence_pool(void)
> +{
> +	phys_addr_t kfence_pool;
> +
> +	/*
> +	 * TODO: Support to enable KFENCE after bootup depends on the ability t=
o
> +	 *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 split page table mappings. As su=
ch support is not currently
> +	 *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 implemented for radix pagetables=
, support enabling KFENCE
> +	 *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 only at system startup for now.
> +	 *
> +	 *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 After support for splitting mapp=
ings is available on radix,
> +	 *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 alloc_kfence_pool() & map_kfence=
_pool() can be dropped and
> +	 *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mapping for __kfence_pool memory=
 can be
> +	 *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 split during arch_kfence_init_po=
ol().
> +	 */
> +	if (!kfence_early_init)
> +		goto no_kfence;
> +
> +	kfence_pool =3D memblock_phys_alloc(KFENCE_POOL_SIZE, PAGE_SIZE);
> +	if (!kfence_pool)
> +		goto no_kfence;
> +
> +	memblock_mark_nomap(kfence_pool, KFENCE_POOL_SIZE);
> +	return kfence_pool;
> +
> +no_kfence:
> +	disable_kfence();
> +	return 0;
> +}
> +
> +static inline void map_kfence_pool(phys_addr_t kfence_pool)
> +{
> +	if (!kfence_pool)
> +		return;
> +
> +	if (create_physical_mapping(kfence_pool, kfence_pool + KFENCE_POOL_SIZE=
,
> +				=C2=A0=C2=A0=C2=A0 -1, PAGE_KERNEL, PAGE_SIZE))
> +		goto err;
> +
> +	memblock_clear_nomap(kfence_pool, KFENCE_POOL_SIZE);
> +	__kfence_pool =3D __va(kfence_pool);
> +	return;
> +
> +err:
> +	memblock_phys_free(kfence_pool, KFENCE_POOL_SIZE);
> +	disable_kfence();
> +}
> +#else
> +static inline phys_addr_t alloc_kfence_pool(void) { return 0; }
> +static inline void map_kfence_pool(phys_addr_t kfence_pool) { }
> +#endif
> +
> =C2=A0static void __init radix_init_pgtable(void)
> =C2=A0{
> +	phys_addr_t kfence_pool;
> =C2=A0	unsigned long rts_field;
> =C2=A0	phys_addr_t start, end;
> =C2=A0	u64 i;
> @@ -365,6 +437,8 @@ static void __init radix_init_pgtable(void)
> =C2=A0	/* We don't support slb for radix */
> =C2=A0	slb_set_size(0);
> =C2=A0
> +	kfence_pool =3D alloc_kfence_pool();
> +
> =C2=A0	/*
> =C2=A0	 * Create the linear mapping
> =C2=A0	 */
> @@ -381,9 +455,11 @@ static void __init radix_init_pgtable(void)
> =C2=A0		}
> =C2=A0
> =C2=A0		WARN_ON(create_physical_mapping(start, end,
> -						-1, PAGE_KERNEL));
> +						-1, PAGE_KERNEL, ~0UL));
> =C2=A0	}
> =C2=A0
> +	map_kfence_pool(kfence_pool);
> +
> =C2=A0	if (!cpu_has_feature(CPU_FTR_HVMODE) &&
> =C2=A0			cpu_has_feature(CPU_FTR_P9_RADIX_PREFETCH_BUG)) {
> =C2=A0		/*
> @@ -875,7 +951,7 @@ int __meminit radix__create_section_mapping(unsigned =
long start,
> =C2=A0	}
> =C2=A0
> =C2=A0	return create_physical_mapping(__pa(start), __pa(end),
> -				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nid, prot);
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nid, prot, ~0UL);
> =C2=A0}
> =C2=A0
> =C2=A0int __meminit radix__remove_section_mapping(unsigned long start, un=
signed long end)
> diff --git a/arch/powerpc/mm/init-common.c b/arch/powerpc/mm/init-common.=
c
> index d3a7726ecf512c..21131b96d20901 100644
> --- a/arch/powerpc/mm/init-common.c
> +++ b/arch/powerpc/mm/init-common.c
> @@ -31,6 +31,9 @@ EXPORT_SYMBOL_GPL(kernstart_virt_addr);
> =C2=A0
> =C2=A0bool disable_kuep =3D !IS_ENABLED(CONFIG_PPC_KUEP);
> =C2=A0bool disable_kuap =3D !IS_ENABLED(CONFIG_PPC_KUAP);
> +#ifdef CONFIG_KFENCE
> +bool __ro_after_init kfence_disabled;
> +#endif
> =C2=A0
> =C2=A0static int __init parse_nosmep(char *p)
> =C2=A0{


Hi,

Just a gentle reminder, this patch is required in the stable kernels.

Please let me know if there are any comments.

Thanks,
Aboorva

