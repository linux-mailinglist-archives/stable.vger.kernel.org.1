Return-Path: <stable+bounces-192486-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AC667C34D94
	for <lists+stable@lfdr.de>; Wed, 05 Nov 2025 10:31:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D1F6B4FFB65
	for <lists+stable@lfdr.de>; Wed,  5 Nov 2025 09:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7BF92FCC1E;
	Wed,  5 Nov 2025 09:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="eRH98J6F"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7AB92FBDE9;
	Wed,  5 Nov 2025 09:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762334562; cv=none; b=OrCp04dyU3O0F6amvNa5UzjAK3tFc7NGXTMWxtu3+zycXwLsMX9gIoQnlqqdYeh4Tk6j2mL/ujezvf8Qu8/0dtW5Ezs/C/guXTD8nT1KnFQNFbHqemQ1tTQSve4ayJ5pFYnovixfJ0wTfw5WbMjj98sGoB511tzGeMJ2jxvnduU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762334562; c=relaxed/simple;
	bh=7yLkrBwTjt7wnToghWwiDhk0t6t6nvsEA1O9oSg398E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XmqLv3kfHc7pHscqPWe0Mb34oasoYjrfyoN3yMYPbkg2A3tfP8VqJWb80X0SwiALACn+28ji+VbRd4juiurRQulblnd1RqGGJoosW0wU3ycj3heyOs+HjFayEtdEc1fhWkJb0hVJluUHex35FAtvckx4moJOiSzUlvgm0utHXT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=eRH98J6F; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A55udU4007542;
	Wed, 5 Nov 2025 09:22:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=oCaa74
	4/yx6Gsm/RozBFAn6s5R65rM23DqxrRNPJW44=; b=eRH98J6FH91A4UZTTLgcPV
	WvAtl+xZp6NDo6wrxaVOB3jSxqwF7KroIzhlfuFQRovDNlp2WOVH5480nZlCUQ73
	ilygzTTL3hSo1sFDIsIA3DSaG/QWqKf2PYq9aceO6aMfhbppKJnM7bYxlMjbLfB5
	GKIsXV4gJrqEFKPcb094QeHi7Ro3FiwUJ0knt3AUnVpQG3/IWlrWAu8DxAgzokGQ
	ieECzr7AwZOkxGynvqMWByzv7WeL+Ri5dUt+miqOPYLwqAfvSCB3Y2SeF6d7jF/D
	h8FBg4B/PHsqt7W0Fb0MDn/Boq/Gv2IPAiU/4PNpoKMF5mxkAc/Ovcrd8EyDm/oQ
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a59vugcmf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Nov 2025 09:22:26 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5A599D0r012923;
	Wed, 5 Nov 2025 09:22:25 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4a5y81y1md-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Nov 2025 09:22:25 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5A59M9XO30016136
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 Nov 2025 09:22:10 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0B9D658059;
	Wed,  5 Nov 2025 09:22:23 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 90A5D58055;
	Wed,  5 Nov 2025 09:22:19 +0000 (GMT)
Received: from [9.98.109.80] (unknown [9.98.109.80])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  5 Nov 2025 09:22:19 +0000 (GMT)
Message-ID: <2ab4297c-b4b5-4eb2-8389-cd9fe29d7bc3@linux.ibm.com>
Date: Wed, 5 Nov 2025 14:52:18 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [mainline]Error while running make modules_install command
Content-Language: en-GB
To: Nathan Chancellor <nathan@kernel.org>, Omar Sandoval <osandov@osandov.com>
Cc: Samir M <samir@linux.ibm.com>, linux-kernel@vger.kernel.org,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, dimitri.ledkov@surgut.co.uk,
        stable@vger.kernel.org, Nicolas Schier <nsc@kernel.org>,
        Alexey Gladkov <legion@kernel.org>, linux-debuggers@vger.kernel.org
References: <7fef7507-ad64-4e51-9bb8-c9fb6532e51e@linux.ibm.com>
 <56905387-ec43-4f89-9146-0db6889e46ab@linux.ibm.com>
 <20251105005603.GA769905@ax162>
From: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
In-Reply-To: <20251105005603.GA769905@ax162>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ya8hwmud08LkMknuqq7GXmfR9YS6A8zH
X-Proofpoint-GUID: ya8hwmud08LkMknuqq7GXmfR9YS6A8zH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAxMDAyMSBTYWx0ZWRfX6CR4MZ02sUer
 1aMpOY+rDbjWAsp6mrqRyT1PA8iB9yf0U0FnlwHJTI3D5/cuqU2sRjXHhKQzDTgEAhoPmIIOor9
 9jx5Yz2a9CJAcEBfklG5csj+5SfUA5PO/S3EPueuP44a1rA51YDtRprp9vBK9z1d3NE4tgPKtT9
 5E6JIIIPPQPvjIH94TvteBCNq27cW50JWBqCuW+RrGQ6wTM43CyxVZniu3Qfzx7xA3ZSaEmrFtT
 dNdZnVymY7aXQbm/PFHEuJFS3Nuq/HzhUE7l3QcmQFqCWt/RlckYwvA56ymMu2mmJYc/s93eTzw
 mnthn+kAwgjGF2fpi6w11/Os26xa6qUxoF94xYtdxwvverDCSY2ejYxeaX1+nTrs4kHuC3PAAVw
 FUMK1/AM5A68U2gUtOxinxOiBTKW+w==
X-Authority-Analysis: v=2.4 cv=U6qfzOru c=1 sm=1 tr=0 ts=690b1752 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=WG_6xDmpAAAA:8 a=s5HezVcRJVFevGRlhjIA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=vnvZt3YqmSlbJLwVaSfU:22
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-05_03,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 impostorscore=0 spamscore=0 phishscore=0
 clxscore=1011 malwarescore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2511010021


On 05/11/25 6:26 am, Nathan Chancellor wrote:
> + Nicolas and Alexey, just as an FYI.
>
> Top of thread is:
>
> https://lore.kernel.org/7fef7507-ad64-4e51-9bb8-c9fb6532e51e@linux.ibm.com/
>
> On Tue, Nov 04, 2025 at 04:54:38PM +0530, Venkat Rao Bagalkote wrote:
>> IBM CI has also reported this error.
>>
>>
>> Error:
>>
>>
>> depmod: ERROR: kmod_builtin_iter_next: unexpected string without modname
>> prefix
>>    INSTALL /boot
>> depmod: ERROR: kmod_builtin_iter_next: unexpected string without modname
>> prefix
>> depmod: ERROR: kmod_builtin_iter_next: unexpected string without modname
>> prefix
>>
>>
>> Git bisect is pointing to below commit as first bad commit.
>>
>>
>> d50f21091358b2b29dc06c2061106cdb0f030d03 is the first bad commit
>> commit d50f21091358b2b29dc06c2061106cdb0f030d03
>> Author: Dimitri John Ledkov <dimitri.ledkov@surgut.co.uk>
>> Date:   Sun Oct 26 20:21:00 2025 +0000
>>
>>      kbuild: align modinfo section for Secureboot Authenticode EDK2 compat
> Thank you for the bisect. I can reproduce this with at least kmod 29.1,
> which is the version I can see failing in drgn's CI from Ubuntu Jammy
> (but I did not see it with kmod 34, which is the latest version in Arch
> Linux at the moment).
>
> Could you and Omar verify if the following diff resolves the error for
> you? I think this would allow us to keep Dimitri's fix for the
> Authenticode EDK2 calculation (i.e., the alignment) while keeping kmod
> happy. builtin.modules.modinfo is the same after this diff as it was
> before Dimitri's change for me.
>
> Cheers,
> Nathan
>
> diff --git a/scripts/Makefile.vmlinux b/scripts/Makefile.vmlinux
> index ced4379550d7..c3f135350d7e 100644
> --- a/scripts/Makefile.vmlinux
> +++ b/scripts/Makefile.vmlinux
> @@ -102,11 +102,23 @@ vmlinux: vmlinux.unstripped FORCE
>   # modules.builtin.modinfo
>   # ---------------------------------------------------------------------------
>   
> +# .modinfo in vmlinux is aligned to 8 bytes for compatibility with tools that
> +# expect sufficiently aligned sections but the additional NULL bytes used for
> +# padding to satisfy this requirement break certain versions of kmod with
> +#
> +#   depmod: ERROR: kmod_builtin_iter_next: unexpected string without modname prefix
> +#
> +# Strip the trailing padding bytes after extracting the .modinfo sections to
> +# comply with what kmod expects to parse.
> +quiet_cmd_modules_builtin_modinfo = GEN     $@
> +      cmd_modules_builtin_modinfo = $(cmd_objcopy); \
> +                                    sed -i 's/\x00\+$$/\x00/g' $@
> +
>   OBJCOPYFLAGS_modules.builtin.modinfo := -j .modinfo -O binary
>   
>   targets += modules.builtin.modinfo
>   modules.builtin.modinfo: vmlinux.unstripped FORCE
> -	$(call if_changed,objcopy)
> +	$(call if_changed,modules_builtin_modinfo)
>   
>   # modules.builtin
>   # ---------------------------------------------------------------------------
>

This change fixes the reported issue. You can add below tag as well, 
while sending a patch.


Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>


Regards,

Venkat.



