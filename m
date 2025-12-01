Return-Path: <stable+bounces-197703-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92E75C96C6B
	for <lists+stable@lfdr.de>; Mon, 01 Dec 2025 11:58:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C4E13A1290
	for <lists+stable@lfdr.de>; Mon,  1 Dec 2025 10:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7E4B305067;
	Mon,  1 Dec 2025 10:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="aiohxu63"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A263054CE
	for <stable@vger.kernel.org>; Mon,  1 Dec 2025 10:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764586707; cv=none; b=NiaLEOoAze1TQiPc8nwcRGVjAJSzBe/vsuyhftxtLHzjgHVsO3+Nv3yhDoirnRZF3NRFtOh+KINJeD0fJXljdy5yPjpICSMDVTfElF9UxvXDOuJ6N65UZCsyxwTKHp9oP4PDdTItyK+PtkCi5wyLXdYQhPNQPP56cLHYkZJ0acY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764586707; c=relaxed/simple;
	bh=qr0vaWvHtrxzcNBLafJYlo1Q7LkDqnJAeUv207HxnVE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GAleTGqLzN5pja/pqC6DJ36jZb2or84frCOpReJvONdhXmDnPC+HtZTF3+fM4FBz3eb+Vfdp6LmAZ053DmG0Hw7M0IvglSaLsg/R0lqF6VWP7Wc1xHmNGo2OxBrPagcr/FDZqPvLflBOKanRi4Z/cp3SpPToKMGRfAE7u57PjC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=aiohxu63; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AUMI7HY009816;
	Mon, 1 Dec 2025 10:58:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=s0dMlg
	ifAPhqyyXehdPmq4G+rQo3HiGoDfUu+Qp6B54=; b=aiohxu63iy+JXAj6OugduE
	9N5QHU4/0uHnGyvbRPAn4ySWIX72k2a8Xxd/ziH6ltdcCH99ploN+nIbcTPnLTZg
	QWihWzhPsfXELuuBSLXdevPebprS2L2dG5iFol8KDuwtJXurvjxZTF+aDtAmWAa6
	J4FmNnHmGnxjHJSHxe/x1V7bSWd1AcN5CF+inbf1soUEjmwYZDwpqs8Wrt2dHIQS
	+BJ55aH9p0M9DebezORLQtqtgM+S/YdXIeWpmcQ5iN+0ne7O6pLg4S47Rr1cF88+
	WP0Bh8DyWOb6iOEz4I/w6Qau5vWBULrQxxjoTS9yzC+ePOBuetlvRWwHI0/s5GMQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aqq8uema9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Dec 2025 10:58:14 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5B1AtEBT024536;
	Mon, 1 Dec 2025 10:58:13 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aqq8uema3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Dec 2025 10:58:13 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5B1AI8Ou003838;
	Mon, 1 Dec 2025 10:58:12 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ardcjdmvq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Dec 2025 10:58:12 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5B1AwBO947710610
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 1 Dec 2025 10:58:11 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E113620043;
	Mon,  1 Dec 2025 10:58:10 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2BBD320040;
	Mon,  1 Dec 2025 10:58:09 +0000 (GMT)
Received: from aboo.ibm.com (unknown [9.36.19.217])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  1 Dec 2025 10:58:08 +0000 (GMT)
Message-ID: <dcd1165bab40f31878bb86cd2f582ed950c491ae.camel@linux.ibm.com>
Subject: Re: [PATCH] powerpc/64s/radix/kfence: map __kfence_pool at page
 granularity
From: Aboorva Devarajan <aboorvad@linux.ibm.com>
To: stable@vger.kernel.org
Cc: hbathini@linux.ibm.com, mpe@ellerman.id.au, ritesh.list@gmail.com,
        gregkh@linuxfoundation.org
Date: Mon, 01 Dec 2025 16:28:08 +0530
In-Reply-To: <149c66a94a28f33330e2016e50e4f3faad4dd59d.camel@linux.ibm.com>
References: <20250910110245.123817-1-aboorvad@linux.ibm.com>
	 <149c66a94a28f33330e2016e50e4f3faad4dd59d.camel@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: oFNegJb_FSunqOFLe_vLR4UrehTvqbC9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI5MDAwOCBTYWx0ZWRfX5DpJIoEIsuPP
 H7oG90UPzfP6p5+r6gM3Y9rKyQupeZBxEcjgNca5+txyVw7uNYERml323KI/Cx/o+n4b4r8WBhi
 XjC/OPEiX55uPi55BvMq8O+ZWsFmksTNNzxyz+sLpvlS1OHD6LVP5FQ0GpW/OwDQIaAUER1rW46
 RAYlhykEDAGhOkaa4kxVs8JJkRsj+NEq2y97fEjHnWC46pnImoMR4PaVCMOUaO1UuraBb4wHv8A
 tSOfXgeiE0vLN/RxvGcfHUCtxudFljUlArnwHw7cjqzcsHKGfOhFU46maZPXQV5zNkW8tcQf8ON
 gflRLakC6DqSbNW//zSnqo43NPGnFQlL50sDW9yI8B6i0N8nbiOoddjx7HWhS9+6ry56IHyeco2
 CmTAxxydivvXkj9MylaC6YDzrF++Zg==
X-Authority-Analysis: v=2.4 cv=Scz6t/Ru c=1 sm=1 tr=0 ts=692d74c6 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=1XWaLZrsAAAA:8 a=bC-a23v3AAAA:8 a=VnNF1IyMAAAA:8
 a=G_HbIYvWetri5qaG9CAA:9 a=QEXdDO2ut3YA:10 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-GUID: 3KqyCF4SsuSHEgo_-7t3hhCuvh0XSxrS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-28_08,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0
 clxscore=1011 spamscore=0 impostorscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511290008

On Mon, 2025-09-29 at 07:07 +0530, Aboorva Devarajan wrote:
> On Wed, 2025-09-10 at 16:32 +0530, Aboorva Devarajan wrote:
>=20
>=20
> > From: Hari Bathini <hbathini@linux.ibm.com>
> >=20
> > When KFENCE is enabled, total system memory is mapped at page level
> > granularity. But in radix MMU mode, ~3GB additional memory is needed
> > to map 100GB of system memory at page level granularity when compared
> > to using 2MB direct mapping.This is not desired considering KFENCE is
> > designed to be enabled in production kernels [1].
> >=20
> > Mapping only the memory allocated for KFENCE pool at page granularity i=
s
> > sufficient to enable KFENCE support. So, allocate __kfence_pool during
> > bootup and map it at page granularity instead of mapping all system
> > memory at page granularity.
> >=20
> > Without patch:
> > =C2=A0 # cat /proc/meminfo
> > =C2=A0 MemTotal:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 101201920 kB
> >=20
> > With patch:
> > =C2=A0 # cat /proc/meminfo
> > =C2=A0 MemTotal:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 104483904 kB
> >=20
> > Note that enabling KFENCE at runtime is disabled for radix MMU for now,
> > as it depends on the ability to split page table mappings and such APIs
> > are not currently implemented for radix MMU.
> >=20
> > All kfence_test.c testcases passed with this patch.
> >=20
> > [1] https://lore.kernel.org/all/20201103175841.3495947-2-elver@google.c=
om/
> >=20
> > Fixes: a5edf9815dd7 ("powerpc/64s: Enable KFENCE on book3s64")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
> > Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> > Signed-off-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
> > Link: https://msgid.link/20240701130021.578240-1-hbathini@linux.ibm.com
> >=20
> > ---
> >=20
> > Upstream commit 353d7a84c214 ("powerpc/64s/radix/kfence: map __kfence_p=
ool at page granularity")
> >=20
> > This has already been merged upstream and is required in stable kernels=
 as well.
> >=20
> > ---
> > =C2=A0arch/powerpc/include/asm/kfence.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 | 11 +++-
> > =C2=A0arch/powerpc/mm/book3s64/radix_pgtable.c | 84 +++++++++++++++++++=
+++--
> > =C2=A0arch/powerpc/mm/init-common.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 3 +
> > =C2=A03 files changed, 93 insertions(+), 5 deletions(-)
> >=20
> > diff --git a/arch/powerpc/include/asm/kfence.h b/arch/powerpc/include/a=
sm/kfence.h
> > index 424ceef82ae615..fab124ada1c7f2 100644
> > --- a/arch/powerpc/include/asm/kfence.h
> > +++ b/arch/powerpc/include/asm/kfence.h
> > @@ -15,10 +15,19 @@
> > =C2=A0#define ARCH_FUNC_PREFIX "."
> > =C2=A0#endif
> > =C2=A0
> > +#ifdef CONFIG_KFENCE
> > +extern bool kfence_disabled;
> > +
> > +static inline void disable_kfence(void)
> > +{
> > +	kfence_disabled =3D true;
> > +}
> > +
> > =C2=A0static inline bool arch_kfence_init_pool(void)
> > =C2=A0{
> > -	return true;
> > +	return !kfence_disabled;
> > =C2=A0}
> > +#endif
> > =C2=A0
> > =C2=A0#ifdef CONFIG_PPC64
> > =C2=A0static inline bool kfence_protect_page(unsigned long addr, bool p=
rotect)
> > diff --git a/arch/powerpc/mm/book3s64/radix_pgtable.c b/arch/powerpc/mm=
/book3s64/radix_pgtable.c
> > index 15e88f1439ec20..b0d927009af83c 100644
> > --- a/arch/powerpc/mm/book3s64/radix_pgtable.c
> > +++ b/arch/powerpc/mm/book3s64/radix_pgtable.c
> > @@ -17,6 +17,7 @@
> > =C2=A0#include <linux/hugetlb.h>
> > =C2=A0#include <linux/string_helpers.h>
> > =C2=A0#include <linux/memory.h>
> > +#include <linux/kfence.h>
> > =C2=A0
> > =C2=A0#include <asm/pgalloc.h>
> > =C2=A0#include <asm/mmu_context.h>
> > @@ -31,6 +32,7 @@
> > =C2=A0#include <asm/uaccess.h>
> > =C2=A0#include <asm/ultravisor.h>
> > =C2=A0#include <asm/set_memory.h>
> > +#include <asm/kfence.h>
> > =C2=A0
> > =C2=A0#include <trace/events/thp.h>
> > =C2=A0
> > @@ -293,7 +295,8 @@ static unsigned long next_boundary(unsigned long ad=
dr, unsigned long end)
> > =C2=A0
> > =C2=A0static int __meminit create_physical_mapping(unsigned long start,
> > =C2=A0					=C2=A0=C2=A0=C2=A0=C2=A0 unsigned long end,
> > -					=C2=A0=C2=A0=C2=A0=C2=A0 int nid, pgprot_t _prot)
> > +					=C2=A0=C2=A0=C2=A0=C2=A0 int nid, pgprot_t _prot,
> > +					=C2=A0=C2=A0=C2=A0=C2=A0 unsigned long mapping_sz_limit)
> > =C2=A0{
> > =C2=A0	unsigned long vaddr, addr, mapping_size =3D 0;
> > =C2=A0	bool prev_exec, exec =3D false;
> > @@ -301,7 +304,10 @@ static int __meminit create_physical_mapping(unsig=
ned long start,
> > =C2=A0	int psize;
> > =C2=A0	unsigned long max_mapping_size =3D memory_block_size;
> > =C2=A0
> > -	if (debug_pagealloc_enabled_or_kfence())
> > +	if (mapping_sz_limit < max_mapping_size)
> > +		max_mapping_size =3D mapping_sz_limit;
> > +
> > +	if (debug_pagealloc_enabled())
> > =C2=A0		max_mapping_size =3D PAGE_SIZE;
> > =C2=A0
> > =C2=A0	start =3D ALIGN(start, PAGE_SIZE);
> > @@ -356,8 +362,74 @@ static int __meminit create_physical_mapping(unsig=
ned long start,
> > =C2=A0	return 0;
> > =C2=A0}
> > =C2=A0
> > +#ifdef CONFIG_KFENCE
> > +static bool __ro_after_init kfence_early_init =3D !!CONFIG_KFENCE_SAMP=
LE_INTERVAL;
> > +
> > +static int __init parse_kfence_early_init(char *arg)
> > +{
> > +	int val;
> > +
> > +	if (get_option(&arg, &val))
> > +		kfence_early_init =3D !!val;
> > +	return 0;
> > +}
> > +early_param("kfence.sample_interval", parse_kfence_early_init);
> > +
> > +static inline phys_addr_t alloc_kfence_pool(void)
> > +{
> > +	phys_addr_t kfence_pool;
> > +
> > +	/*
> > +	 * TODO: Support to enable KFENCE after bootup depends on the ability=
 to
> > +	 *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 split page table mappings. As =
such support is not currently
> > +	 *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 implemented for radix pagetabl=
es, support enabling KFENCE
> > +	 *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 only at system startup for now=
.
> > +	 *
> > +	 *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 After support for splitting ma=
ppings is available on radix,
> > +	 *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 alloc_kfence_pool() & map_kfen=
ce_pool() can be dropped and
> > +	 *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mapping for __kfence_pool memo=
ry can be
> > +	 *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 split during arch_kfence_init_=
pool().
> > +	 */
> > +	if (!kfence_early_init)
> > +		goto no_kfence;
> > +
> > +	kfence_pool =3D memblock_phys_alloc(KFENCE_POOL_SIZE, PAGE_SIZE);
> > +	if (!kfence_pool)
> > +		goto no_kfence;
> > +
> > +	memblock_mark_nomap(kfence_pool, KFENCE_POOL_SIZE);
> > +	return kfence_pool;
> > +
> > +no_kfence:
> > +	disable_kfence();
> > +	return 0;
> > +}
> > +
> > +static inline void map_kfence_pool(phys_addr_t kfence_pool)
> > +{
> > +	if (!kfence_pool)
> > +		return;
> > +
> > +	if (create_physical_mapping(kfence_pool, kfence_pool + KFENCE_POOL_SI=
ZE,
> > +				=C2=A0=C2=A0=C2=A0 -1, PAGE_KERNEL, PAGE_SIZE))
> > +		goto err;
> > +
> > +	memblock_clear_nomap(kfence_pool, KFENCE_POOL_SIZE);
> > +	__kfence_pool =3D __va(kfence_pool);
> > +	return;
> > +
> > +err:
> > +	memblock_phys_free(kfence_pool, KFENCE_POOL_SIZE);
> > +	disable_kfence();
> > +}
> > +#else
> > +static inline phys_addr_t alloc_kfence_pool(void) { return 0; }
> > +static inline void map_kfence_pool(phys_addr_t kfence_pool) { }
> > +#endif
> > +
> > =C2=A0static void __init radix_init_pgtable(void)
> > =C2=A0{
> > +	phys_addr_t kfence_pool;
> > =C2=A0	unsigned long rts_field;
> > =C2=A0	phys_addr_t start, end;
> > =C2=A0	u64 i;
> > @@ -365,6 +437,8 @@ static void __init radix_init_pgtable(void)
> > =C2=A0	/* We don't support slb for radix */
> > =C2=A0	slb_set_size(0);
> > =C2=A0
> > +	kfence_pool =3D alloc_kfence_pool();
> > +
> > =C2=A0	/*
> > =C2=A0	 * Create the linear mapping
> > =C2=A0	 */
> > @@ -381,9 +455,11 @@ static void __init radix_init_pgtable(void)
> > =C2=A0		}
> > =C2=A0
> > =C2=A0		WARN_ON(create_physical_mapping(start, end,
> > -						-1, PAGE_KERNEL));
> > +						-1, PAGE_KERNEL, ~0UL));
> > =C2=A0	}
> > =C2=A0
> > +	map_kfence_pool(kfence_pool);
> > +
> > =C2=A0	if (!cpu_has_feature(CPU_FTR_HVMODE) &&
> > =C2=A0			cpu_has_feature(CPU_FTR_P9_RADIX_PREFETCH_BUG)) {
> > =C2=A0		/*
> > @@ -875,7 +951,7 @@ int __meminit radix__create_section_mapping(unsigne=
d long start,
> > =C2=A0	}
> > =C2=A0
> > =C2=A0	return create_physical_mapping(__pa(start), __pa(end),
> > -				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nid, prot);
> > +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nid, prot, ~0UL);
> > =C2=A0}
> > =C2=A0
> > =C2=A0int __meminit radix__remove_section_mapping(unsigned long start, =
unsigned long end)
> > diff --git a/arch/powerpc/mm/init-common.c b/arch/powerpc/mm/init-commo=
n.c
> > index d3a7726ecf512c..21131b96d20901 100644
> > --- a/arch/powerpc/mm/init-common.c
> > +++ b/arch/powerpc/mm/init-common.c
> > @@ -31,6 +31,9 @@ EXPORT_SYMBOL_GPL(kernstart_virt_addr);
> > =C2=A0
> > =C2=A0bool disable_kuep =3D !IS_ENABLED(CONFIG_PPC_KUEP);
> > =C2=A0bool disable_kuap =3D !IS_ENABLED(CONFIG_PPC_KUAP);
> > +#ifdef CONFIG_KFENCE
> > +bool __ro_after_init kfence_disabled;
> > +#endif
> > =C2=A0
> > =C2=A0static int __init parse_nosmep(char *p)
> > =C2=A0{
>=20
>=20
> Hi,
>=20
> Just a gentle reminder, this patch is required in the stable kernels.
>=20
> Please let me know if there are any comments.
>=20
> Thanks,
> Aboorva



CC'ing Greg to check whether this patch can be backported to the stable
kernels.


Regards,
Aboorva

