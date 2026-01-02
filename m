Return-Path: <stable+bounces-204506-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 90569CEF4FC
	for <lists+stable@lfdr.de>; Fri, 02 Jan 2026 21:31:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A1D6B30155C6
	for <lists+stable@lfdr.de>; Fri,  2 Jan 2026 20:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FC3022B8A9;
	Fri,  2 Jan 2026 20:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KFO+fQ0z"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A366920322;
	Fri,  2 Jan 2026 20:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767385862; cv=none; b=c3j4F3mg7lcAo/6OYhqTQEfC9Vf1pZbx6NFdA3jA/Ub7zb1dOvGAGmUoTbioTt36YcJQIk2UivvFfXXXWOVLdqWCbbhU/lGDjMFIqhL7I+10Mh9lLG1MNyrMxIdw3jbqiRCbZxx58GguytnuDNEwERyDT5EpoKx1RIOs9HukC6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767385862; c=relaxed/simple;
	bh=ZcS1r01wASAUo3tvqsFvXyz1gqF3XdbSj9z+tImePpY=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=Xwr5Yc4XUL5jxEzgq6jZZvAu/EE/TGYS8OBfTmUcx0l/NqdeFdTty67YHuuh3Lfy8UIqmFZj6lamoT57q/KjQl5/3ZmEyHayWiK1haL7IfFi2BHMQhj11ZSxLjVTnExg7JiLp18rf0VU0s7YlCGcYw/klnE1fdSzt8WlklFDWmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=KFO+fQ0z; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 602I2YZt016063;
	Fri, 2 Jan 2026 20:30:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=VLMveP
	M9aLXxHXsAqUNIDosGw6Fl+ti3r18PkN3f1r4=; b=KFO+fQ0zB1As4t0kStL3UR
	Ua0MSz9Z4SYObJ6phFEuZGTAtSPoRI9oY0wvl9a3Zdhra8hl9RUD7OVeyffRQNYD
	MEYEaYmB+nyBScSnTF23AR332HCH6jMZ3O4yGA+O5i4qQKhfqY87qsjFgN8jsMhY
	01PPE4BRYiAlQsF9QLB3kjA7eyaFxYkLmvEFPtuJhQc8c6/s892m8oIPfzyrdr2C
	ezhA24U0fAC3Il9f3u/goW3AoEuhMOZOnzCTP/zkEAUDX4m3RpO9bdSStGNkxZ0+
	VDlaTYttHjJRtLWLkmRYSw+BjrY/MHqAgBJ2BV9j8v+7kf4rruwD/zdlxIviW/gg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ba7658q4v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Jan 2026 20:30:25 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 602KRuir027450;
	Fri, 2 Jan 2026 20:30:24 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ba7658q4r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Jan 2026 20:30:24 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 602JGDNs024985;
	Fri, 2 Jan 2026 20:30:23 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4bau9kr0e2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Jan 2026 20:30:23 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 602KUMqL5374912
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 2 Jan 2026 20:30:23 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A021E58052;
	Fri,  2 Jan 2026 20:30:22 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 38B105805E;
	Fri,  2 Jan 2026 20:30:21 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.43.105])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  2 Jan 2026 20:30:21 +0000 (GMT)
Message-ID: <8d780b6eff19fd61096c07768cf730b985d29177.camel@linux.ibm.com>
Subject: Re: [PATCH v3 1/3] ima: verify the previous kernel's IMA buffer
 lies in addressable RAM
From: Mimi Zohar <zohar@linux.ibm.com>
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
        akpm@linux-foundation.org
Cc: ardb@kernel.org, bp@alien8.de, dave.hansen@linux.intel.com,
        graf@amazon.com, guoweikang.kernel@gmail.com, henry.willard@oracle.com,
        hpa@zytor.com, jbohac@suse.cz, joel.granados@kernel.org,
        linux-kernel@vger.kernel.org, mingo@redhat.com, noodles@fb.com,
        paul.x.webb@oracle.com, rppt@kernel.org, sohil.mehta@intel.com,
        sourabhjain@linux.ibm.com, stable@vger.kernel.org, tglx@linutronix.de,
        x86@kernel.org, yifei.l.liu@oracle.com
In-Reply-To: <20251231061609.907170-2-harshit.m.mogalapalli@oracle.com>
References: <20251231061609.907170-1-harshit.m.mogalapalli@oracle.com>
	 <20251231061609.907170-2-harshit.m.mogalapalli@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 02 Jan 2026 15:30:20 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.54.3 (3.54.3-2.fc41) 
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTAyMDE4MiBTYWx0ZWRfX6S4SF9IpdzYK
 HS81VBAwT74nHTK0BAOXQNFGsAnmgGJCaNpMY+hQEfhhZ02WvpNK5E+fVIu2K90nKephEklUnEa
 kFEIC5VOyExSIof5gl/c4dt2TaaRAbiR5JuqpineA8rpXwbcexqkT0k1DppATjOHkdOwSu1W0hA
 4ZCLGyAG/+ffdISDSVnqYZqFA5iq7hlPXnMGry5/AG4EAjlyi4meXD8g9Uq49PPNnWrnM4O5AY4
 PP3hPsiPmywZLciDZ3fY8atTXvSJyKlSLssNsnWpwzH176PHj485GSYkOHnaTVqEw3djpW5bsde
 tQtcB1CmSwvwycgqNOSJxE0XilDVZ7g9U9gq6OAb+2vJ8Py8jmkoJVvEw/NwycoX5y+6n6JsSCq
 3uKOXi5wmI6+l9iiwpOoe4WBVkx/uMLQUQAawxZ2nn5c5QYxZbroZHLNA71PJbl49CZY3Viq4kI
 4k+jGtUUEmL6nSDatXA==
X-Proofpoint-GUID: Es9376BlPr9bRfPUshyUM84CXviKinyh
X-Authority-Analysis: v=2.4 cv=B4+0EetM c=1 sm=1 tr=0 ts=69582ae1 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=VnNF1IyMAAAA:8 a=cM2GJM6JWcOulyiZAt0A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: rKQ2v4UCpN_khiE8R7-4P0kRq_uuQ6U1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-02_03,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 phishscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 spamscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2512120000
 definitions=main-2601020182

On Tue, 2025-12-30 at 22:16 -0800, Harshit Mogalapalli wrote:
> When the second-stage kernel is booted with a limiting command line
> (e.g. "mem=3D<size>"), the IMA measurement buffer handed over from the
> previous kernel may fall outside the addressable RAM of the new kernel.
> Accessing such a buffer can fault during early restore.
>=20
> Introduce a small generic helper, ima_validate_range(), which verifies
> that a physical [start, end] range for the previous-kernel IMA buffer
> lies within addressable memory:
> 	- On x86, use pfn_range_is_mapped().
> 	- On OF based architectures, use page_is_ram().
>=20
> Cc: stable@vger.kernel.org
> Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>

Thanks!

Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>

> ---
> v2->v3: Update subject to exactly describe the patch [ Suggested by Mimi
> Zohar]
> ---
>  include/linux/ima.h                |  1 +
>  security/integrity/ima/ima_kexec.c | 35 ++++++++++++++++++++++++++++++
>  2 files changed, 36 insertions(+)
>=20
> diff --git a/include/linux/ima.h b/include/linux/ima.h
> index 8e29cb4e6a01..abf8923f8fc5 100644
> --- a/include/linux/ima.h
> +++ b/include/linux/ima.h
> @@ -69,6 +69,7 @@ static inline int ima_measure_critical_data(const char =
*event_label,
>  #ifdef CONFIG_HAVE_IMA_KEXEC
>  int __init ima_free_kexec_buffer(void);
>  int __init ima_get_kexec_buffer(void **addr, size_t *size);
> +int ima_validate_range(phys_addr_t phys, size_t size);
>  #endif
> =20
>  #ifdef CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT
> diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/=
ima_kexec.c
> index 7362f68f2d8b..8b24e3312ea0 100644
> --- a/security/integrity/ima/ima_kexec.c
> +++ b/security/integrity/ima/ima_kexec.c
> @@ -12,6 +12,8 @@
>  #include <linux/kexec.h>
>  #include <linux/of.h>
>  #include <linux/ima.h>
> +#include <linux/mm.h>
> +#include <linux/overflow.h>
>  #include <linux/reboot.h>
>  #include <asm/page.h>
>  #include "ima.h"
> @@ -296,3 +298,36 @@ void __init ima_load_kexec_buffer(void)
>  		pr_debug("Error restoring the measurement list: %d\n", rc);
>  	}
>  }
> +
> +/*
> + * ima_validate_range - verify a physical buffer lies in addressable RAM
> + * @phys: physical start address of the buffer from previous kernel
> + * @size: size of the buffer
> + *
> + * On success return 0. On failure returns -EINVAL so callers can skip
> + * restoring.
> + */
> +int ima_validate_range(phys_addr_t phys, size_t size)
> +{
> +	unsigned long start_pfn, end_pfn;
> +	phys_addr_t end_phys;
> +
> +	if (check_add_overflow(phys, (phys_addr_t)size - 1, &end_phys))
> +		return -EINVAL;
> +
> +	start_pfn =3D PHYS_PFN(phys);
> +	end_pfn =3D PHYS_PFN(end_phys);
> +
> +#ifdef CONFIG_X86
> +	if (!pfn_range_is_mapped(start_pfn, end_pfn))
> +#else
> +	if (!page_is_ram(start_pfn) || !page_is_ram(end_pfn))
> +#endif
> +	{
> +		pr_warn("IMA: previous kernel measurement buffer %pa (size 0x%zx) lies=
 outside available memory\n",
> +			&phys, size);
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}


