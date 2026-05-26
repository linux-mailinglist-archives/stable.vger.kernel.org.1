Return-Path: <stable+bounces-254251-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QFk8JVNFFWqLUAcAu9opvQ
	(envelope-from <stable+bounces-254251-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 09:01:39 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E9A3D5D16FB
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 09:01:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7CC493020A77
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 07:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B48A837B023;
	Tue, 26 May 2026 07:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="T4KD+iQQ"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E0A7311592;
	Tue, 26 May 2026 07:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779778864; cv=none; b=FdjP5a8QGcr2tsRGrTQFwBLHDsjGGnmHkrUKore0pq5CHUKETAIEwJ382TeJkOMImDANckifWrDh2BKPkHnrS78WvKgs/CY718DGymeDA/UEAjJDo3KY1FqY+yJNZss0rxcYIH6o7O2xi9fFkZxEZcKg8KVqSWkm/RxmPs5LurQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779778864; c=relaxed/simple;
	bh=xU9ey+/gCReKFhu6u/IO0ogzUI4OXMbbCdFe4TuRYio=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RH8CA7zPnyjlMiFTPpe2OEYWAoBbvH0av6oV/95oKGrRc3j609dxo0fnj4NVxEqBd73qEVH/U5Cx3HpWrS5Oqtw7b0TYj4Kz054YVED0PiPyBIFDjv01LfY2/cSWuNRB2ao/WXurLhXoWSEuISBTqwKh8fDVLx0BsPXrNoe+rnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=T4KD+iQQ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64PLIBLH4185202;
	Tue, 26 May 2026 07:00:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=VX8+1S
	+jkayJgLaGXATX8h/OXyDc7O/lTdANJFoVST4=; b=T4KD+iQQboiVBtFZGNTDlv
	6HQA1fviE+ITIN4jI7Q6KD4g5IlfSepPGRiQj9w2ZGyDIbyHoLyRCYraXbKLb+ig
	p2+6pF17f01gJbfR+ByVTS6SwphcLzeYj0L8vQy4hfyzWt6hJ0Oksa6F84t1LzOq
	HROIkyXGVKBnsR0mytCVl2L1VHoiG5hqOYEdL7gt7Gznnu//1a7mXfUbNWUALidO
	nI1/MCisBVQu/qSJfTxpHB0qbe5ff5f6PtmS5zM1BJpEhrM3LQjVZwi3xoGV/Cfo
	RLc494LM3BXmx9WPYJ1lx3yw/H8ptpx0iJf6AmzDTsGh+xekYFxSx7wa3sTBf1dw
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eb4nq1wma-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 May 2026 07:00:50 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64Q6s4Aa005766;
	Tue, 26 May 2026 07:00:49 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ebpjq8bnv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 May 2026 07:00:49 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64Q70lqX16122604
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 26 May 2026 07:00:48 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A7BCA58059;
	Tue, 26 May 2026 07:00:47 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 73A285805D;
	Tue, 26 May 2026 07:00:44 +0000 (GMT)
Received: from [9.123.0.169] (unknown [9.123.0.169])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 26 May 2026 07:00:44 +0000 (GMT)
Message-ID: <40b7656b-52ef-4140-b6e3-e034fd44a4fd@linux.ibm.com>
Date: Tue, 26 May 2026 12:30:43 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] KVM: PPC: Kconfig: Enable CONFIG_VPA_PMU with KVM
Content-Language: en-GB
To: Gautam Menghani <gautam@linux.ibm.com>, maddy@linux.ibm.com,
        npiggin@gmail.com, mpe@ellerman.id.au, chleroy@kernel.org,
        atrajeev@linux.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260518044150.34632-1-gautam@linux.ibm.com>
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <20260518044150.34632-1-gautam@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: 7qkukWVPBjDP_LO3AnDPm149bcRTJKrk
X-Proofpoint-ORIG-GUID: NvEfuJU5a97V-5xkwsqXfnF1So_ulFhD
X-Authority-Analysis: v=2.4 cv=QIJYgALL c=1 sm=1 tr=0 ts=6a154522 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=f7IdgyKtn90A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=mE7zvaIDyRbJdjUQ4pMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI2MDA1NiBTYWx0ZWRfX1z7hS0EfpvnJ
 sAbzsT4d5VZP3aY/4JjjtCMq4OHBCdmWJCbaSHRTaI6TsLLmI9xXEfeQugl8Cvxlk3QjRkmGYQo
 LC/GbOwQkFJW3uVhCLG4B8CHmlS6Vpi20Tsb7gNfdkQD5LYZYHhw3QUeMvrV5QygEmxQkXSwCDz
 CsK/p8bPmfjjxzhy7c8PrZZdXbBZbIx9Pv87yCOGxSjM5ES/4DYwAnkjxnOGHOmAyJBC0g9vhef
 pJJjyUbxe4wrYImY7mzXrBrgwDDkbHbifkqjZHqs0pN1G5JZQI+tr1Yww9wmlcfBZk+yz3mK6kT
 KbF2ompqmrEy5dQztaK6vZvoUyvT67skM7pOG3qCzigFRAPl4UZsteEiCnOrp1+R8gsECZx/84s
 M74ib5oI5RxCGYYjZhvu9acMgFevCn16wYoBbnqwJL8yewcJzmFe/LRR25GNeEnHMc3xl6Cw5Ll
 Qv/ZJm5QmBkq55YMOLw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-26_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 impostorscore=0 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 adultscore=0 spamscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605260056
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-254251-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[linux.ibm.com,gmail.com,ellerman.id.au,kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[harshpb@linux.ibm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: E9A3D5D16FB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 18/05/26 10:11 am, Gautam Menghani wrote:
> Enable CONFIG_VPA_PMU with KVM to enable its usage. Currently, the
> vpa-pmu driver cannot be used since it is not enabled in distro configs.
> 

I think the commit log needs a rephrase as irrespective of current state 
of distro configs, it makes sense to enable CONFIG_VPA_PMU for KVM 
guests on Power by default since this is the only use-case for VPA 
counters (i.e. in a KVM guest).

> On fedora kernel 6.13.7, the config option is disabled:
> $ cat /boot/config-6.19.12-200.fc43.ppc64le  | grep VPA_PMU
>   # CONFIG_VPA_PMU is not set
> 
> Fixes: 176cda0619b6c ("powerpc/perf: Add perf interface to expose vpa counters")
> Cc: stable@vger.kernel.org # v6.13+
> Signed-off-by: Gautam Menghani <gautam@linux.ibm.com>
> ---
> v1 -> v2:
> 1. Rebased on latest master
> 
>   arch/powerpc/kvm/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/powerpc/kvm/Kconfig b/arch/powerpc/kvm/Kconfig
> index 9a0d1c1aca6c..56e86b46ff13 100644
> --- a/arch/powerpc/kvm/Kconfig
> +++ b/arch/powerpc/kvm/Kconfig
> @@ -82,6 +82,7 @@ config KVM_BOOK3S_64_HV
>   	select KVM_BOOK3S_HV_POSSIBLE
>   	select KVM_BOOK3S_HV_PMU
>   	select CMA
> +	select VPA_PMU if HV_PERF_CTRS


Also, since we already select KVM_BOOK3S_HV_PMU, VPA_PMU is a natural 
extension, provided we enable only if the required dependecy is enabled.

With an update to the changelog with suggested rationale:

Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>

>   	help
>   	  Support running unmodified book3s_64 guest kernels in
>   	  virtual machines on POWER7 and newer processors that have


