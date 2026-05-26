Return-Path: <stable+bounces-254246-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4LifNck+FWrJTwcAu9opvQ
	(envelope-from <stable+bounces-254246-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 08:33:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A0DE5D1319
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 08:33:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 03CEB301DCC9
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 06:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD3ED3537F5;
	Tue, 26 May 2026 06:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cpfdUPE5"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 391692139C9;
	Tue, 26 May 2026 06:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779777222; cv=none; b=OmU6EDIWOKW0OkVh4n1gaNI5zlXd1d1X+CxqApPzUdu6OM41dGajCE5CZepajuEsvk6dxlMmToI8ukesTuvDCiuI1M0EKzurGk7l9Nv2jpH1bxyGMb4/Iza3OWmyZcnG8LJP8ZNQxNK64QDy0/zKZXRNB8mipDEAbW37X+IsLMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779777222; c=relaxed/simple;
	bh=HKAO9maESbKI4Exfss2i7RDbJyHWmkSIKxamB9uJhLA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t4ngz1QZxZGdyOFo38h/r30NAfdlASdEELDIMkPFB0Ev9YySaT6l6I04ksU4102e4RZnOmQB50KufmeKDR64TKSDk3W/5y78A5LCxj550Z+OLUhHc/j5HYKPd/KFRZWCZO1wEiisfZtQo4YHKAlyV3wBg1iH14rHokHbFqcdctI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=cpfdUPE5; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64PN5oCG4112531;
	Tue, 26 May 2026 06:33:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=lSSTgI
	JxElpRPZXCwCiqCKzOkrKn0h4qZngFuiv7DgQ=; b=cpfdUPE5GXZtk7jlSz6ZR/
	9gZW04DexbKzX0Ao2CT9354Iq2VdPZ2LkuXTN020t0l+7B4S649D87v25jlxY+Z1
	fptQYAGSz4U5aA71XLqZ1+H3eQpa7MDV5OebBvNT3zPJqwCxtO8XZwiyvCKZW5MP
	vNjZ7GOVmQmOFsP4ubf8V4Him10gnMSvo6Q7A6UvS6mY/vhC/3AqKH1kb7LNpw7O
	kK7Yapbyl/J5v1llS2nr+NsDqecbtAf9nkMrdYO9JZUk5E+sQenhTiu3kVQOb9oN
	vN+A7y4ar4YBnHSMpgpwI4Ob/Cor1Wx5MmfeegXRaDOVBfx0sRlOjBwPGHH/R2DA
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eb4pd9t75-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 May 2026 06:33:06 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64Q6O35j009870;
	Tue, 26 May 2026 06:33:06 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ebqjjr3xx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 May 2026 06:33:06 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64Q6X5mr30147200
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 26 May 2026 06:33:05 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6C7D958055;
	Tue, 26 May 2026 06:33:05 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1FE0558043;
	Tue, 26 May 2026 06:33:00 +0000 (GMT)
Received: from [9.123.0.169] (unknown [9.123.0.169])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 26 May 2026 06:32:59 +0000 (GMT)
Message-ID: <76f82194-9afb-4dfe-ad96-ae338c7db61d@linux.ibm.com>
Date: Tue, 26 May 2026 12:02:58 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] KVM: Validate irqchip index for LoongArch and PowerPC
Content-Language: en-GB
To: Yanfei Xu <yanfei.xu@bytedance.com>, zhaotianrui@loongson.cn,
        maobibo@loongson.cn, chenhuacai@kernel.org, maddy@linux.ibm.com,
        npiggin@gmail.com, sashiko-reviews@lists.linux.dev, seanjc@google.com,
        pbonzini@redhat.com
Cc: kvm@vger.kernel.org, loongarch@lists.linux.dev,
        linuxppc-dev@lists.ozlabs.org, caixiangfeng@bytedance.com,
        fangying.tommy@bytedance.com, isyanfei.xu@gmail.com,
        Sashiko <sashiko-bot@kernel.org>, stable@vger.kernel.org
References: <20260525070154.495455-1-yanfei.xu@bytedance.com>
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <20260525070154.495455-1-yanfei.xu@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=OdqoyBTY c=1 sm=1 tr=0 ts=6a153ea3 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=f7IdgyKtn90A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22
 a=VwQbUJbxAAAA:8 a=968KyxNXAAAA:8 a=VnNF1IyMAAAA:8 a=VhF_hiyGZBDqKw0Zxd0A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: LRBMiiFu8R_IMzxWSnnQX7_Q9AYoCXuw
X-Proofpoint-ORIG-GUID: 5_W0oqDVcmHgDExfvwT3FxNm3zkLR1hH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI2MDA1MSBTYWx0ZWRfX90z2vKmC0yAk
 CWSucWXg+h4/Q/KVFzuUyOVTM3Ffn5pOF70e9b6dUfaJEKlTKVS5FhR0ih3lCU5NshKV2HubsWL
 SLfOz2KgQyFTWyDyk2c5VFMWK1WwrBK2V9He1yI9qH2vWFfu8CbOiIp2svrl8Uq45ssuZG3u1Ui
 cuswYiUbKsINKddCpffjDXQZri/svJx49y8R9X0UXJ5QeIaEer68I3nADevAk7o7ZS6KHC7DBh7
 MG28r5i57DGfw6xEXwCLKnf0V7ak8mqhnXdEfVg1oz1XtuJKej7DUYpLPsxWAu1QchEvUJRRzOU
 iv4n2vwDpREmpc8NxtC0O7SgemcbY5bh0qeZ95hhSCXTfhTLcwq9eHdse9QCZxpX66x3iCn1oei
 xB1qrl0z7NgLSMif/uc2QI9feykHP1Y9tJixKyB/lftuVZyDsUVJxUFB8gmLDmtZlH8qNq8mrER
 2NZy1yKpnBXTVaXu5PQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-26_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1011 malwarescore=0
 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605260051
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254246-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[bytedance.com,loongson.cn,kernel.org,linux.ibm.com,gmail.com,lists.linux.dev,google.com,redhat.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,lists.ozlabs.org,bytedance.com,gmail.com,kernel.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bytedance.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[harshpb@linux.ibm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: 3A0DE5D1319
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

+ cc: stable@vger.kernel.org

On 25/05/26 12:31 pm, Yanfei Xu wrote:
> Sashiko reported that irqchip index is not validated for LoongArch and
> PowerPC. Add validation and reject out-of-range irqchip indexes to avoid
> indexing past the routing table's chip array.
> 
> Fixes: de9ba2f36368 ("KVM: PPC: Support irq routing and irqfd for in-kernel MPIC")
> Fixes: 1928254c5ccb ("LoongArch: KVM: Add irqfd support")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/kvm/20260525051714.485D51F000E9@smtp.kernel.org/
> Signed-off-by: Yanfei Xu <yanfei.xu@bytedance.com>
> ---
>   arch/loongarch/kvm/irqfd.c | 3 ++-
>   arch/powerpc/kvm/mpic.c    | 3 ++-
>   2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/loongarch/kvm/irqfd.c b/arch/loongarch/kvm/irqfd.c
> index f4f953b22419..40ed1081c4b6 100644
> --- a/arch/loongarch/kvm/irqfd.c
> +++ b/arch/loongarch/kvm/irqfd.c
> @@ -51,7 +51,8 @@ int kvm_set_routing_entry(struct kvm *kvm,
>   		e->irqchip.irqchip = ue->u.irqchip.irqchip;
>   		e->irqchip.pin = ue->u.irqchip.pin;
>   
> -		if (e->irqchip.pin >= KVM_IRQCHIP_NUM_PINS)
> +		if (e->irqchip.pin >= KVM_IRQCHIP_NUM_PINS ||
> +		    e->irqchip.irqchip >= KVM_NR_IRQCHIPS)
>   			return -EINVAL;
>   
>   		return 0;
> diff --git a/arch/powerpc/kvm/mpic.c b/arch/powerpc/kvm/mpic.c
> index 3070f36d9fb8..fb5f9e65e02e 100644
> --- a/arch/powerpc/kvm/mpic.c
> +++ b/arch/powerpc/kvm/mpic.c
> @@ -1833,7 +1833,8 @@ int kvm_set_routing_entry(struct kvm *kvm,
>   		e->set = mpic_set_irq;
>   		e->irqchip.irqchip = ue->u.irqchip.irqchip;
>   		e->irqchip.pin = ue->u.irqchip.pin;
> -		if (e->irqchip.pin >= KVM_IRQCHIP_NUM_PINS)
> +		if (e->irqchip.pin >= KVM_IRQCHIP_NUM_PINS ||
> +		    e->irqchip.irqchip >= KVM_NR_IRQCHIPS)

Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com> # PPC KVM
>   			goto out;
>   		break;
>   	case KVM_IRQ_ROUTING_MSI:


