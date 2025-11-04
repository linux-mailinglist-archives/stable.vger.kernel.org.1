Return-Path: <stable+bounces-192360-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D9D5DC30B6C
	for <lists+stable@lfdr.de>; Tue, 04 Nov 2025 12:24:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B72C54E52C9
	for <lists+stable@lfdr.de>; Tue,  4 Nov 2025 11:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF9FD2E6CAE;
	Tue,  4 Nov 2025 11:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ec9AeCon"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2252C0F7E;
	Tue,  4 Nov 2025 11:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762255493; cv=none; b=Yy3HP5HAHr+1lUIyUStG77N6QmPcwbqElbAXtPKjTMDGtsaCoqlf4HbJUM8C2CyYN8t9/JNimHEnXXZgIeuQ84SzuHFWgwqWKqHX6l0hFa/b5hCyN/87Jpm1LFPiRSghs6QUtOa61JJfXVPL4PKpOvrhlHuYsejxW/SpI94/Omg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762255493; c=relaxed/simple;
	bh=PsGgME/2TmsjD7bZrHlOjr/MX9qjSqEHXA98Em3/T+Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=LQsYHqTC4X+cLrwpmUwgxhWN/OrBOG3XlsqXL5Zse9Frpet5KsTtJksDk8el7ht6ayoVtitt4ezXOA6N0Xj0QjnfZcx42pFlKFF7ue/rFhgcLMv5AeMJoGvIDJAujHKg+L372K1ua7jBisq119g08nogV86fxJwvAVdaXwBhWnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ec9AeCon; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A42bVfY000802;
	Tue, 4 Nov 2025 11:24:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=seaE6F
	hghR7fv2Dv8o+PZ8LTcSRYnVGDjIamqipTMTU=; b=ec9AeConec9k1b09w5amYU
	JFv6+Y/KWyE3/2HH+kadeQB/jZ6DFAcK/+3k1FE3IUhXPDovpCkNDTwmyNIdLHQr
	hRP8jrM7GYgu/BmREBWE5Cxx/yOZzXkL4IrnvbhLNepSWAaGNkGEWGws3/qs1m5Q
	VylpHW4bie0w2LNgFx3wk/Yy4V+DYwb0vg4HCWzrkXVWxHKWzTocartEIYYr31Tf
	gdW71dydRZhAvZPsCfhAGYkvYEPOFLOM+uys46phfPvraj0Rw1AEOjuqiYGivbz3
	+fo3ZlAwd1ER1etYcQCHPw7SUm4hsPgruVcXvD9BRH62JJ1HVilfVIWszz3N201g
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a59q8umxs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Nov 2025 11:24:45 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5A4B0Cc1009877;
	Tue, 4 Nov 2025 11:24:44 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4a5x1kanjy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Nov 2025 11:24:44 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5A4BOhQ333686220
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 4 Nov 2025 11:24:43 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 34CDF58058;
	Tue,  4 Nov 2025 11:24:43 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 04ED558057;
	Tue,  4 Nov 2025 11:24:40 +0000 (GMT)
Received: from [9.61.241.11] (unknown [9.61.241.11])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  4 Nov 2025 11:24:39 +0000 (GMT)
Message-ID: <56905387-ec43-4f89-9146-0db6889e46ab@linux.ibm.com>
Date: Tue, 4 Nov 2025 16:54:38 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [mainline]Error while running make modules_install command
Content-Language: en-GB
To: Samir M <samir@linux.ibm.com>, linux-kernel@vger.kernel.org,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, nathan@kernel.org,
        dimitri.ledkov@surgut.co.uk, stable@vger.kernel.org
References: <7fef7507-ad64-4e51-9bb8-c9fb6532e51e@linux.ibm.com>
From: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
In-Reply-To: <7fef7507-ad64-4e51-9bb8-c9fb6532e51e@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=StmdKfO0 c=1 sm=1 tr=0 ts=6909e27d cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=NEAV23lmAAAA:8 a=bC-a23v3AAAA:8 a=WG_6xDmpAAAA:8 a=e5mUnYsNAAAA:8
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=YERNkyx8TXSLzj1xzs0A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=FO4_E8m0qiDe52t0p3_H:22 a=vnvZt3YqmSlbJLwVaSfU:22
 a=Vxmtnl_E_bksehYqCbjh:22 a=poXaRoVlC6wW9_mwW8W4:22 a=cPQSjfK2_nFv0Q5t_7PE:22
 a=HhbK4dLum7pmb74im6QT:22 a=p-dnK0njbqwfn1k4-x12:22 a=jjky5lfK57Ii_Ajn6BuG:22
X-Proofpoint-ORIG-GUID: f80xjLA0N57Pfk6qylBFyXiTekapi543
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAxMDAxOCBTYWx0ZWRfX3qiCJGBVDI3B
 QBgGAtYltJm5KqqnOtRyjE30vlexvfkyKV//p41ubAvqcXzXX6iQUnTGhrKr4gtv8Mj0ZR5jI25
 AQfC7Tte3d6aZ77we//tqFWr4tl2TvrNdTyeN830Z9Pghfj1wCkXfe2bGp/RpPRWroOYZRN+Cfu
 yM2kMTPR00stEkzHrCfPdp8fLW/egaIdANnhscvTW0DQleBPBnDSW0XcZRl+29Q2f1P+FmlMKNg
 HjUGhTeuw4WS+Na7IicitWfvDDmtXKGsqBs8of+o/fTvS+NRoTjuiG9te9YJjDWqv2qOP8GYX1r
 90/aQcq4qUJ3BMTeABVJkhOcGJPSKmjl1k2T4501VE7FifaudLTq12VExDTC6gIQ+KoHCoQBh6z
 ZwCbThTg3HVfACh7YAoCtPIgbstwFg==
X-Proofpoint-GUID: f80xjLA0N57Pfk6qylBFyXiTekapi543
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-03_06,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 phishscore=0 impostorscore=0 priorityscore=1501
 malwarescore=0 clxscore=1011 adultscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511010018


On 04/11/25 4:47 pm, Samir M wrote:
> Hello,
>
>
> I am observing below error while running the make modules_install 
> command on latest mainline kernel on IBM Power11 server.
>
>
> Error:
> DEPMOD  /lib/modules/6.18.0-rc4 depmod: ERROR: kmod_builtin_iter_next: 
> unexpected string without modname prefix
>

IBM CI has also reported this error.


Error:


depmod: ERROR: kmod_builtin_iter_next: unexpected string without modname 
prefix
   INSTALL /boot
depmod: ERROR: kmod_builtin_iter_next: unexpected string without modname 
prefix
depmod: ERROR: kmod_builtin_iter_next: unexpected string without modname 
prefix


Git bisect is pointing to below commit as first bad commit.


d50f21091358b2b29dc06c2061106cdb0f030d03 is the first bad commit
commit d50f21091358b2b29dc06c2061106cdb0f030d03
Author: Dimitri John Ledkov <dimitri.ledkov@surgut.co.uk>
Date:   Sun Oct 26 20:21:00 2025 +0000

     kbuild: align modinfo section for Secureboot Authenticode EDK2 compat

     Previously linker scripts would always generate vmlinuz that has 
sections
     aligned. And thus padded (correct Authenticode calculation) and 
unpadded
     calculation would be same. As in https://github.com/rhboot/pesign 
userspace
     tool would produce the same authenticode digest for both of the 
following
     commands:

         pesign --padding --hash --in ./arch/x86_64/boot/bzImage
         pesign --nopadding --hash --in ./arch/x86_64/boot/bzImage

     The commit 3e86e4d74c04 ("kbuild: keep .modinfo section in
     vmlinux.unstripped") added .modinfo section of variable length. 
Depending
     on kernel configuration it may or may not be aligned.

     All userspace signing tooling correctly pads such section to 
calculation
     spec compliant authenticode digest.

     However, if bzImage is not further processed and is attempted to be 
loaded
     directly by EDK2 firmware, it calculates unpadded Authenticode 
digest and
     fails to correct accept/reject such kernel builds even when propoer
     Authenticode values are enrolled in db/dbx. One can say EDK2 requires
     aligned/padded kernels in Secureboot.

     Thus add ALIGN(8) to the .modinfo section, to esure kernels 
irrespective of
     modinfo contents can be loaded by all existing EDK2 firmware builds.

     Fixes: 3e86e4d74c04 ("kbuild: keep .modinfo section in 
vmlinux.unstripped")
     Cc: stable@vger.kernel.org
     Signed-off-by: Dimitri John Ledkov <dimitri.ledkov@surgut.co.uk>
     Link: 
https://patch.msgid.link/20251026202100.679989-1-dimitri.ledkov@surgut.co.uk
     Signed-off-by: Nathan Chancellor <nathan@kernel.org>

  include/asm-generic/vmlinux.lds.h | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)


Git Bisect log:


git bisect log
git bisect start
# status: waiting for both good and bad commits
# bad: [c9cfc122f03711a5124b4aafab3211cf4d35a2ac] Merge tag 
'for-6.18-rc4-tag' of 
git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux
git bisect bad c9cfc122f03711a5124b4aafab3211cf4d35a2ac
# status: waiting for good commit(s), bad commit known
# good: [dcb6fa37fd7bc9c3d2b066329b0d27dedf8becaa] Linux 6.18-rc3
git bisect good dcb6fa37fd7bc9c3d2b066329b0d27dedf8becaa
# good: [3ad81aa52085a7e67edfa4bc8f518e5962196bb3] Merge tag 'v6.18-p4' 
of git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6
git bisect good 3ad81aa52085a7e67edfa4bc8f518e5962196bb3
# good: [f414f9fd68797182f8de4e1cd9855b6b28abde99] Merge tag 
'pci-v6.18-fixes-4' of git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci
git bisect good f414f9fd68797182f8de4e1cd9855b6b28abde99
# good: [41dacb39fe79cd2fce42d31fa6658d926489a548] Merge tag 
'drm-xe-fixes-2025-10-30' of 
https://gitlab.freedesktop.org/drm/xe/kernel into drm-fixes
git bisect good 41dacb39fe79cd2fce42d31fa6658d926489a548
# bad: [f9bc8e0912b8f6b1d60608a715a1da575670e038] Merge tag 
'perf-urgent-2025-11-01' of 
git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
git bisect bad f9bc8e0912b8f6b1d60608a715a1da575670e038
# good: [c44b4b9eeb71f5b0b617abf6fd66d1ef0aab6200] objtool: Fix 
skip_alt_group() for non-alternative STAC/CLAC
git bisect good c44b4b9eeb71f5b0b617abf6fd66d1ef0aab6200
# bad: [cb7f9fc3725a11447a4af69dfe8d648e4320acdc] Merge tag 
'kbuild-fixes-6.18-2' of 
git://git.kernel.org/pub/scm/linux/kernel/git/kbuild/linux
git bisect bad cb7f9fc3725a11447a4af69dfe8d648e4320acdc
# bad: [d50f21091358b2b29dc06c2061106cdb0f030d03] kbuild: align modinfo 
section for Secureboot Authenticode EDK2 compat
git bisect bad d50f21091358b2b29dc06c2061106cdb0f030d03
# good: [5ff90d427ef841fa48608d0c19a81c48d6126d46] kbuild: 
install-extmod-build: Fix when given dir outside the build dir
git bisect good 5ff90d427ef841fa48608d0c19a81c48d6126d46
# first bad commit: [d50f21091358b2b29dc06c2061106cdb0f030d03] kbuild: 
align modinfo section for Secureboot Authenticode EDK2 compat


Please add below tag as well, if you happen to fix this.


Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>


Regards,

Venkat.

>
> If you happen to fix the above issue, then please add below tag.
> Reported-by: Samir M <samir@linux.ibm.com>
>
>
> Regards,
> Samir.
>
>

