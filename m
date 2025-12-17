Return-Path: <stable+bounces-202761-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D188BCC6052
	for <lists+stable@lfdr.de>; Wed, 17 Dec 2025 06:15:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9E61E3021FBE
	for <lists+stable@lfdr.de>; Wed, 17 Dec 2025 05:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF4D01C695;
	Wed, 17 Dec 2025 05:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="LdfCEd2E"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2DBD9475
	for <stable@vger.kernel.org>; Wed, 17 Dec 2025 05:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765948532; cv=none; b=pINUxhYwzxrSLTMW8hRcUNv97gMEo7qIbGxEzh3cICW3eug4NYRX/sTC8eCWHlSw6utuEVLlVNPHfXLNDhLQOWUHyqC83Uc3WVztvgsnMHbiD3Gl4QqEidH0yftReQTZwKtI7dmcl20cMNUYIok0YYKIjOAOXDkdJkOpaO66ZcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765948532; c=relaxed/simple;
	bh=IJNRgdClf+jCQiE1AI3z3vgZBbXx9E9JF71QP4EeXQY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ghpr39YaUDQDoL4+1XzN9GuqD0S+QfosbFnQCpnimkSxTeHeZ5pm8Kt3cKJ9iRQ2PJ8fSzXJGledQF4cUQGevFDJh+SiQQEbhTlxkXNnyXvU7oQUUnhvMZiCIfGigKNULsk3f4XeMpvXxo4e/ayema9Z7TSNZOOC5hlAt5IFfRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=LdfCEd2E; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BH1Cs1d027256;
	Wed, 17 Dec 2025 05:15:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=QRfou8
	I6wRKISL07S5MQirs67xQJFea3Vthx7Em6ez4=; b=LdfCEd2EggBU619nlWATrg
	bv9RWulR7W+oT8c93jfb5vRnDCeAeA4rZ8gpfcDCGTMnd4vPzcAKNkL52ebXI3vW
	P3FBKlJUXuSzBONKIl0ldgp9gkDwbP/qgQPJKr1UzjHg38nKID2ithq56DCBGmO5
	Bo48zwOW828Me7WaNiOt+TW3peoQOHfQfJ7ml5amrh8+o+ut6vjnF4k5jd1FbxDt
	L2nKmVbWg93FeIm6DJATWbxZ6OtgCsDzpBlJ11scb/9ulLv3eErmWpNkh9BmiUaC
	jtEmEVD8k1Kg5XdwpDgwBq4AT0bjgaJF272DmtK3j7eJZkrZhz3J2gakzxieHOGg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b0yn8k5yg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Dec 2025 05:15:22 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5BH59iXZ009044;
	Wed, 17 Dec 2025 05:15:22 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b0yn8k5yb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Dec 2025 05:15:22 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5BH5ECr8026777;
	Wed, 17 Dec 2025 05:15:21 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4b1jfsgsjb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Dec 2025 05:15:21 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5BH5FHUt50266408
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Dec 2025 05:15:17 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8110F2004B;
	Wed, 17 Dec 2025 05:15:17 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A382220040;
	Wed, 17 Dec 2025 05:15:15 +0000 (GMT)
Received: from aboo.ibm.com (unknown [9.36.2.78])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 17 Dec 2025 05:15:15 +0000 (GMT)
Message-ID: <17403d485965b2a0765d1422e7f720b792ab6743.camel@linux.ibm.com>
Subject: Re: [PATCH] powerpc/64s/radix/kfence: map __kfence_pool at page
 granularity
From: Aboorva Devarajan <aboorvad@linux.ibm.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, hbathini@linux.ibm.com, mpe@ellerman.id.au,
        ritesh.list@gmail.com, aboorvad@linux.ibm.com
Date: Wed, 17 Dec 2025 10:45:14 +0530
In-Reply-To: <2025120130-comprised-water-debe@gregkh>
References: <20250910110245.123817-1-aboorvad@linux.ibm.com>
	 <149c66a94a28f33330e2016e50e4f3faad4dd59d.camel@linux.ibm.com>
	 <dcd1165bab40f31878bb86cd2f582ed950c491ae.camel@linux.ibm.com>
	 <2025120130-comprised-water-debe@gregkh>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjEzMDAxOCBTYWx0ZWRfX2QPoCduKBo35
 bSOafQ/1189zBrtQEeAMwr0cTEf5es/VWH3p8KiP5jnmyRsCHLak3bpeUuuJJqHRUu0mFDFime7
 9bSuiVwPUxWgL7m+7LJJG17WLmmTO+L2mHeRToGBlrgjCmUoRH/BTx+TT8Z1EdZHxvAtIM7WARl
 qpS0dZiaFTrumMG8ejZ1jexzUF8cr4pugYB/vMwsaRB+Mm9W7JauefznTVGIIHnBrZF6f/vUTxG
 GPBpBIzIvJtFntl+tPOAwU6BYekhylRJHRH/NMPCVilDnp4s4ZkGNtOSs0LwhMvqx3Mvye4Wk3j
 /TSDMPRFxUIgaP1+eZLo3v/vM6NoAzUIRwUsaS6zPb/IPfFAwB6gzZf7bIUYMOGxbTKN/2hAJDm
 XeZTJtXbKAauxr0cKz13azZscsfZNA==
X-Proofpoint-GUID: Q8HPe4q_0nxIXfSV20EpqarhKqdJv6nV
X-Proofpoint-ORIG-GUID: XWRJS0mw1gWNn9zR6-TnIpIK6dQrCJi_
X-Authority-Analysis: v=2.4 cv=LbYxKzfi c=1 sm=1 tr=0 ts=69423c6a cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=1XWaLZrsAAAA:8 a=bC-a23v3AAAA:8 a=VnNF1IyMAAAA:8
 a=IeavItMo2miHUoWvFl4A:9 a=QEXdDO2ut3YA:10 a=1R1Xb7_w0-cA:10
 a=OREKyDgYLcYA:10 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-16_03,2025-12-16_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 phishscore=0 clxscore=1015 suspectscore=0
 adultscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2512130018

On Mon, 2025-12-01 at 12:07 +0100, Greg KH wrote:
> On Mon, Dec 01, 2025 at 04:28:08PM +0530, Aboorva Devarajan wrote:
> > On Mon, 2025-09-29 at 07:07 +0530, Aboorva Devarajan wrote:
> > > On Wed, 2025-09-10 at 16:32 +0530, Aboorva Devarajan wrote:
> > >=20
> > >=20
> > > > From: Hari Bathini <hbathini@linux.ibm.com>
> > > >=20
> > > > When KFENCE is enabled, total system memory is mapped at page level
> > > > granularity. But in radix MMU mode, ~3GB additional memory is neede=
d
> > > > to map 100GB of system memory at page level granularity when compar=
ed
> > > > to using 2MB direct mapping.This is not desired considering KFENCE =
is
> > > > designed to be enabled in production kernels [1].
> > > >=20
> > > > Mapping only the memory allocated for KFENCE pool at page granulari=
ty is
> > > > sufficient to enable KFENCE support. So, allocate __kfence_pool dur=
ing
> > > > bootup and map it at page granularity instead of mapping all system
> > > > memory at page granularity.
> > > >=20
> > > > Without patch:
> > > > =C2=A0 # cat /proc/meminfo
> > > > =C2=A0 MemTotal:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 101201920 kB
> > > >=20
> > > > With patch:
> > > > =C2=A0 # cat /proc/meminfo
> > > > =C2=A0 MemTotal:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 104483904 kB
> > > >=20
> > > > Note that enabling KFENCE at runtime is disabled for radix MMU for =
now,
> > > > as it depends on the ability to split page table mappings and such =
APIs
> > > > are not currently implemented for radix MMU.
> > > >=20
> > > > All kfence_test.c testcases passed with this patch.
> > > >=20
> > > > [1] https://lore.kernel.org/all/20201103175841.3495947-2-elver@goog=
le.com/
> > > >=20
> > > > Fixes: a5edf9815dd7 ("powerpc/64s: Enable KFENCE on book3s64")
> > > > Cc: stable@vger.kernel.org
> > > > Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
> > > > Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> > > > Signed-off-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
> > > > Link: https://msgid.link/20240701130021.578240-1-hbathini@linux.ibm=
.com
> > > >=20
> > > > ---
> > > >=20
> > > > Upstream commit 353d7a84c214 ("powerpc/64s/radix/kfence: map __kfen=
ce_pool at page granularity")
> > > >=20
> > > > This has already been merged upstream and is required in stable ker=
nels as well.
> > > >=20
> > > > ---
> > > > =C2=A0arch/powerpc/include/asm/kfence.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 | 11 +++-
> > > > =C2=A0arch/powerpc/mm/book3s64/radix_pgtable.c | 84 +++++++++++++++=
+++++++--
> > > > =C2=A0arch/powerpc/mm/init-common.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 3 +
> > > > =C2=A03 files changed, 93 insertions(+), 5 deletions(-)
> > > >=20
> > > > diff --git a/arch/powerpc/include/asm/kfence.h b/arch/powerpc/inclu=
de/asm/kfence.h
> > > > index 424ceef82ae615..fab124ada1c7f2 100644
> > > > --- a/arch/powerpc/include/asm/kfence.h
> > > > +++ b/arch/powerpc/include/asm/kfence.h
> > > > @@ -15,10 +15,19 @@
> > > > =C2=A0#define ARCH_FUNC_PREFIX "."
> > > > =C2=A0#endif
> > > > =C2=A0
> > > > +#ifdef CONFIG_KFENCE
> > > > +extern bool kfence_disabled;
> > > > +
> > > > +static inline void disable_kfence(void)
> > > > +{
> > > > +	kfence_disabled =3D true;
> > > > +}
> > > > +
> > > > =C2=A0static inline bool arch_kfence_init_pool(void)
> > > > =C2=A0{
> > > > -	return true;
> > > > +	return !kfence_disabled;
> > > > =C2=A0}
> > > > +#endif
> > > > =C2=A0
> > > > =C2=A0#ifdef CONFIG_PPC64
> > > > =C2=A0static inline bool kfence_protect_page(unsigned long addr, bo=
ol protect)
> > > > diff --git a/arch/powerpc/mm/book3s64/radix_pgtable.c b/arch/powerp=
c/mm/book3s64/radix_pgtable.c
> > > > index 15e88f1439ec20..b0d927009af83c 100644
> > > > --- a/arch/powerpc/mm/book3s64/radix_pgtable.c
> > > > +++ b/arch/powerpc/mm/book3s64/radix_pgtable.c
> > > > @@ -17,6 +17,7 @@
> > > > =C2=A0#include <linux/hugetlb.h>
> > > > =C2=A0#include <linux/string_helpers.h>
> > > > =C2=A0#include <linux/memory.h>
> > > > +#include <linux/kfence.h>
> > > > =C2=A0
> > > > =C2=A0#include <asm/pgalloc.h>
> > > > =C2=A0#include <asm/mmu_context.h>
> > > > @@ -31,6 +32,7 @@
> > > > =C2=A0#include <asm/uaccess.h>
> > > > =C2=A0#include <asm/ultravisor.h>
> > > > =C2=A0#include <asm/set_memory.h>
> > > > +#include <asm/kfence.h>
> > > > =C2=A0
> > > > =C2=A0#include <trace/events/thp.h>
> > > > =C2=A0
> > > > @@ -293,7 +295,8 @@ static unsigned long next_boundary(unsigned lon=
g addr, unsigned long end)
> > > > =C2=A0
> > > > =C2=A0static int __meminit create_physical_mapping(unsigned long st=
art,
> > > > =C2=A0					=C2=A0=C2=A0=C2=A0=C2=A0 unsigned long end,
> > > > -					=C2=A0=C2=A0=C2=A0=C2=A0 int nid, pgprot_t _prot)
> > > > +					=C2=A0=C2=A0=C2=A0=C2=A0 int nid, pgprot_t _prot,
> > > > +					=C2=A0=C2=A0=C2=A0=C2=A0 unsigned long mapping_sz_limit)
> > > > =C2=A0{
> > > > =C2=A0	unsigned long vaddr, addr, mapping_size =3D 0;
> > > > =C2=A0	bool prev_exec, exec =3D false;
> > > > @@ -301,7 +304,10 @@ static int __meminit create_physical_mapping(u=
nsigned long start,
> > > > =C2=A0	int psize;
> > > > =C2=A0	unsigned long max_mapping_size =3D memory_block_size;
> > > > =C2=A0
> > > > -	if (debug_pagealloc_enabled_or_kfence())
> > > > +	if (mapping_sz_limit < max_mapping_size)
> > > > +		max_mapping_size =3D mapping_sz_limit;
> > > > +
> > > > +	if (debug_pagealloc_enabled())
> > > > =C2=A0		max_mapping_size =3D PAGE_SIZE;
> > > > =C2=A0
> > > > =C2=A0	start =3D ALIGN(start, PAGE_SIZE);
> > > > @@ -356,8 +362,74 @@ static int __meminit create_physical_mapping(u=
nsigned long start,
> > > > =C2=A0	return 0;
> > > > =C2=A0}
> > > > =C2=A0
> > > > +#ifdef CONFIG_KFENCE
> > > > +static bool __ro_after_init kfence_early_init =3D !!CONFIG_KFENCE_=
SAMPLE_INTERVAL;
> > > > +
> > > > +static int __init parse_kfence_early_init(char *arg)
> > > > +{
> > > > +	int val;
> > > > +
> > > > +	if (get_option(&arg, &val))
> > > > +		kfence_early_init =3D !!val;
> > > > +	return 0;
> > > > +}
> > > > +early_param("kfence.sample_interval", parse_kfence_early_init);
> > > > +
> > > > +static inline phys_addr_t alloc_kfence_pool(void)
> > > > +{
> > > > +	phys_addr_t kfence_pool;
> > > > +
> > > > +	/*
> > > > +	 * TODO: Support to enable KFENCE after bootup depends on the abi=
lity to
> > > > +	 *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 split page table mappings.=
 As such support is not currently
> > > > +	 *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 implemented for radix page=
tables, support enabling KFENCE
> > > > +	 *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 only at system startup for=
 now.
> > > > +	 *
> > > > +	 *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 After support for splittin=
g mappings is available on radix,
> > > > +	 *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 alloc_kfence_pool() & map_=
kfence_pool() can be dropped and
> > > > +	 *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mapping for __kfence_pool =
memory can be
> > > > +	 *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 split during arch_kfence_i=
nit_pool().
> > > > +	 */
> > > > +	if (!kfence_early_init)
> > > > +		goto no_kfence;
> > > > +
> > > > +	kfence_pool =3D memblock_phys_alloc(KFENCE_POOL_SIZE, PAGE_SIZE);
> > > > +	if (!kfence_pool)
> > > > +		goto no_kfence;
> > > > +
> > > > +	memblock_mark_nomap(kfence_pool, KFENCE_POOL_SIZE);
> > > > +	return kfence_pool;
> > > > +
> > > > +no_kfence:
> > > > +	disable_kfence();
> > > > +	return 0;
> > > > +}
> > > > +
> > > > +static inline void map_kfence_pool(phys_addr_t kfence_pool)
> > > > +{
> > > > +	if (!kfence_pool)
> > > > +		return;
> > > > +
> > > > +	if (create_physical_mapping(kfence_pool, kfence_pool + KFENCE_POO=
L_SIZE,
> > > > +				=C2=A0=C2=A0=C2=A0 -1, PAGE_KERNEL, PAGE_SIZE))
> > > > +		goto err;
> > > > +
> > > > +	memblock_clear_nomap(kfence_pool, KFENCE_POOL_SIZE);
> > > > +	__kfence_pool =3D __va(kfence_pool);
> > > > +	return;
> > > > +
> > > > +err:
> > > > +	memblock_phys_free(kfence_pool, KFENCE_POOL_SIZE);
> > > > +	disable_kfence();
> > > > +}
> > > > +#else
> > > > +static inline phys_addr_t alloc_kfence_pool(void) { return 0; }
> > > > +static inline void map_kfence_pool(phys_addr_t kfence_pool) { }
> > > > +#endif
> > > > +
> > > > =C2=A0static void __init radix_init_pgtable(void)
> > > > =C2=A0{
> > > > +	phys_addr_t kfence_pool;
> > > > =C2=A0	unsigned long rts_field;
> > > > =C2=A0	phys_addr_t start, end;
> > > > =C2=A0	u64 i;
> > > > @@ -365,6 +437,8 @@ static void __init radix_init_pgtable(void)
> > > > =C2=A0	/* We don't support slb for radix */
> > > > =C2=A0	slb_set_size(0);
> > > > =C2=A0
> > > > +	kfence_pool =3D alloc_kfence_pool();
> > > > +
> > > > =C2=A0	/*
> > > > =C2=A0	 * Create the linear mapping
> > > > =C2=A0	 */
> > > > @@ -381,9 +455,11 @@ static void __init radix_init_pgtable(void)
> > > > =C2=A0		}
> > > > =C2=A0
> > > > =C2=A0		WARN_ON(create_physical_mapping(start, end,
> > > > -						-1, PAGE_KERNEL));
> > > > +						-1, PAGE_KERNEL, ~0UL));
> > > > =C2=A0	}
> > > > =C2=A0
> > > > +	map_kfence_pool(kfence_pool);
> > > > +
> > > > =C2=A0	if (!cpu_has_feature(CPU_FTR_HVMODE) &&
> > > > =C2=A0			cpu_has_feature(CPU_FTR_P9_RADIX_PREFETCH_BUG)) {
> > > > =C2=A0		/*
> > > > @@ -875,7 +951,7 @@ int __meminit radix__create_section_mapping(uns=
igned long start,
> > > > =C2=A0	}
> > > > =C2=A0
> > > > =C2=A0	return create_physical_mapping(__pa(start), __pa(end),
> > > > -				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nid, prot);
> > > > +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nid, prot, ~0UL);
> > > > =C2=A0}
> > > > =C2=A0
> > > > =C2=A0int __meminit radix__remove_section_mapping(unsigned long sta=
rt, unsigned long end)
> > > > diff --git a/arch/powerpc/mm/init-common.c b/arch/powerpc/mm/init-c=
ommon.c
> > > > index d3a7726ecf512c..21131b96d20901 100644
> > > > --- a/arch/powerpc/mm/init-common.c
> > > > +++ b/arch/powerpc/mm/init-common.c
> > > > @@ -31,6 +31,9 @@ EXPORT_SYMBOL_GPL(kernstart_virt_addr);
> > > > =C2=A0
> > > > =C2=A0bool disable_kuep =3D !IS_ENABLED(CONFIG_PPC_KUEP);
> > > > =C2=A0bool disable_kuap =3D !IS_ENABLED(CONFIG_PPC_KUAP);
> > > > +#ifdef CONFIG_KFENCE
> > > > +bool __ro_after_init kfence_disabled;
> > > > +#endif
> > > > =C2=A0
> > > > =C2=A0static int __init parse_nosmep(char *p)
> > > > =C2=A0{
> > >=20
> > >=20
> > > Hi,
> > >=20
> > > Just a gentle reminder, this patch is required in the stable kernels.
> > >=20
> > > Please let me know if there are any comments.
> > >=20
> > > Thanks,
> > > Aboorva
> >=20
> >=20
> >=20
> > CC'ing Greg to check whether this patch can be backported to the stable
> > kernels.
>=20
> <formletter>
>=20
> This is not the correct way to submit patches for inclusion in the
> stable kernel tree.=C2=A0 Please read:
> =C2=A0=C2=A0=C2=A0 https://www.kernel.org/doc/html/latest/process/stable-=
kernel-rules.html
> for how to do this properly.
>=20
> </formletter>

Hi Greg,

Thanks for the response.

I've sent a mail requesting the backport following "Option 2" in the
stable kernel rules:
https://lore.kernel.org/all/7810b263e0fb16002609fba72321fabd5f0bbc4c.camel@=
linux.ibm.com/

Regards,
Aboorva

