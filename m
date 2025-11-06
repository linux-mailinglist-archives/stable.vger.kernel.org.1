Return-Path: <stable+bounces-192571-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 10F04C39382
	for <lists+stable@lfdr.de>; Thu, 06 Nov 2025 07:10:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DB8544E213A
	for <lists+stable@lfdr.de>; Thu,  6 Nov 2025 06:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82A692DAFB5;
	Thu,  6 Nov 2025 06:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ElF1dVm0"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF6122DAFA8;
	Thu,  6 Nov 2025 06:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762409412; cv=none; b=SAXZume6Z8jjdpQy+TAg1gSdzhWS0BAIl+yZvuCF6OjxQwZ1OuapePJdKqJV5LngdWK1mk7Bw/pYTHOTFlGLDDemJndVxF+E4FiTxqPRlhMKZR8g0hC9EsYuto2u5gSBa+b7em3NfdelPUpiCH2XVsxme7YIHEe9zLlSEivWCUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762409412; c=relaxed/simple;
	bh=PNbZ//mjttXPJb3yONShlvpYxJ0IjQ+8uVab+aHuuM8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UC/AGqa9QrvzUgxZ1w2sQ7LTEdYeACz5EdP+7ZBWgIqL0QONj5iFKHJ+iP3m6NHraDD+852Rg5mmeyHR5Xapiqxo3U4bpAtazlEP1RuPRr9edjZ9BW5ZCK7Fjak1G9OSSDJ0vor60qvBj/libAdSB28Qfi70rBdeW3FYn5rIsag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ElF1dVm0; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A65aI3e009252;
	Thu, 6 Nov 2025 06:10:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Phvrrh
	TQJ7Z0NnfSz3ZRbSMUDYtfHlMm5TlpGRPS3ek=; b=ElF1dVm0Y8J9Z4+WacWS4t
	E7C+n9m9KCBRYkpzb1B/97BLNwkknsEq1BZgyb1HaJENCg8ptGIe1NJrsOKjcj+4
	YorQvHTZrcR9H0i7TAwIE3Fr1Ypa8myZvG0/lc7apoTlvfNdsz0R6Ylt6uTNZi+w
	NcoLpja4uflyzGKCB/dwX5gvyydG/hSxjc7SWEtG5d79gnZLlq8kApNIRiOBQw32
	AwqdAA09ERi3HaYeeEUu7iUsBBqNEyhJAonvjLO1JFbKQZIpwM4jcgIdZXmrNq5g
	mmjeqpmaxC5AwuqNdzzbrninEMG84wiPok1v/xwjydCfnALeBOwexX+8lD3Z8WSQ
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a59xc5cqy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Nov 2025 06:10:00 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5A628A7U025605;
	Thu, 6 Nov 2025 06:09:59 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4a5vhsv6d1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Nov 2025 06:09:59 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5A669vod53018934
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 6 Nov 2025 06:09:57 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7419C58051;
	Thu,  6 Nov 2025 06:09:57 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A2ED85805E;
	Thu,  6 Nov 2025 06:09:53 +0000 (GMT)
Received: from [9.61.250.250] (unknown [9.61.250.250])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  6 Nov 2025 06:09:53 +0000 (GMT)
Message-ID: <16abe317-1a17-4edb-ab71-5f2e27405c18@linux.ibm.com>
Date: Thu, 6 Nov 2025 11:39:51 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [mainline]Error while running make modules_install command
To: Nathan Chancellor <nathan@kernel.org>,
        Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
        Omar Sandoval <osandov@osandov.com>
Cc: linux-kernel@vger.kernel.org, Madhavan Srinivasan <maddy@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, dimitri.ledkov@surgut.co.uk,
        stable@vger.kernel.org, Nicolas Schier <nsc@kernel.org>,
        Alexey Gladkov <legion@kernel.org>, linux-debuggers@vger.kernel.org
References: <7fef7507-ad64-4e51-9bb8-c9fb6532e51e@linux.ibm.com>
 <56905387-ec43-4f89-9146-0db6889e46ab@linux.ibm.com>
 <20251105005603.GA769905@ax162>
Content-Language: en-US
From: Samir M <samir@linux.ibm.com>
In-Reply-To: <20251105005603.GA769905@ax162>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAxMDAyMSBTYWx0ZWRfX5xvM4uBI9w8N
 x5e5DR8fZtLo/Bsjq58z0vXlqP3eHxrKTODaB3AMlGVdnhNZ1nA/vAFMCbRASud179b6+JrUxru
 IvJSd+ii4Zb/1K1EtSvc00myh169edFI6fBm0FUU+E3MKnm8S95I/NlqXpFk1fjVDijwRYR4PaE
 UHTySjCS9HP6Y/d9W0ygOAZ+KH3hlRywNULVcg0mD7eX2iP41c62ymE7xJiQjAFyGoHG2409Ksw
 1EvL1yNWD51lpB533gnHil+7JS+nHC0MyXvuL6eyAixyKj7YiVaPfaOy27nJHu+nyX/nd2c8BK8
 NDLSA4gsO+zrHSYY/sWfzPIU1YNez0MsfDzrZ19GCTu8JhTqA16A5xCj01nf5pnNx7fEPzXqy0n
 mHDpPX81wKEvXMfPFke8haQkjmdTiQ==
X-Proofpoint-GUID: epWAkT0AsDvtFuRGDI0Lw5v2vkCRLxEm
X-Authority-Analysis: v=2.4 cv=OdCVzxTY c=1 sm=1 tr=0 ts=690c3bb8 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=WG_6xDmpAAAA:8 a=s5HezVcRJVFevGRlhjIA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=vnvZt3YqmSlbJLwVaSfU:22
 a=cPQSjfK2_nFv0Q5t_7PE:22 a=HhbK4dLum7pmb74im6QT:22 a=pHzHmUro8NiASowvMSCR:22
 a=Ew2E2A-JSTLzCXPT_086:22
X-Proofpoint-ORIG-GUID: epWAkT0AsDvtFuRGDI0Lw5v2vkCRLxEm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-06_01,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 spamscore=0 suspectscore=0 impostorscore=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1011 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511010021


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

Hi,


This change fixes the reported issue. You can add below tag as well, 
 while sending a patch.


Tested-by: Samir M <samir@linux.ibm.com>


Thank you for the fix !!

Regards,

Samir


