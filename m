Return-Path: <stable+bounces-272856-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vsQjLgluT2paggIAu9opvQ
	(envelope-from <stable+bounces-272856-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Jul 2026 11:46:49 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B82872F1BF
	for <lists+stable@lfdr.de>; Thu, 09 Jul 2026 11:46:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ibm.com header.s=pp1 header.b=eIRongIA;
	dmarc=pass (policy=none) header.from=ibm.com;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272856-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-272856-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3309B304653D
	for <lists+stable@lfdr.de>; Thu,  9 Jul 2026 09:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BB983EF643;
	Thu,  9 Jul 2026 09:39:43 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 336643E47B;
	Thu,  9 Jul 2026 09:39:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783589983; cv=none; b=uFGKEYXI4PUd/YuuRggL3nLjbwk/+WOJORJ9l+OQx1GuwchhgziGRn7AMRQ/3QPPnxWNbt/sXsjLNx1x+stnpBPQRzTRRO/1FzTpY0o8Ytgase2+2Z+zxU0/wnG0dhIC7ffBqoT8FRGYUcdJdNjp9IY2VmYXe57LwHIzzeiT00o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783589983; c=relaxed/simple;
	bh=7GA2pZHLuihFzNC5suVPNdeb2rgyYNSlTVmoPdc1Jnc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NV2fzTbzrkAri85ewPbLmOIkdrth7VdCYOLkPE4tdfyqi6xwJAfP26+eOClmP57brkVM8rZoih6g6yvCg9EMDt7PxhIcBzibmTDoyHIaa39Ai6V0kzJng3Tfbf6bxbPXuGmZDQ8mSRPEz+tY35NuCnHhfPK9gs2OvN9B6wNw7Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=eIRongIA; arc=none smtp.client-ip=148.163.156.1
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6696IWr21897392;
	Thu, 9 Jul 2026 09:39:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=M05QQu
	2AhxhlfwVGw0snPzMy6XvSIYRk6m4W88pP9io=; b=eIRongIAq53MmskZdIMHqN
	VE37M89HblCDzG+p6Ccgmmmed6tnA8+VCmvn+X0nean+8csGmJcftc1tJzT29Yzq
	6Z4y/I1aQnvWbIxaC2NHaixr+wKOaRrf1thIqBMg8Q69MRKKwYvVcT6Va9GjWId6
	NmDqI24kOfkBKP8+BI9WHwhyUCeaN3whHV+6AJG6afkWTITqge4Q4mVE88UB1fO9
	bUMnqbf9ZLPiLAEHZZL48xnoUz9jhknBEOP0pZiSiNGAUgrpyuT4DDGKC1RRK/KD
	JcotwNWYjvyHfqHFPHcN6lFJEqEOij9EIhjaM+aHYgz7L6NRSV0vPPs9vPqlYHEw
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6sur0rfp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Jul 2026 09:39:16 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6699YfLV020115;
	Thu, 9 Jul 2026 09:39:15 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f7dgkch4j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Jul 2026 09:39:15 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6699dD3S52953366
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 9 Jul 2026 09:39:13 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 09E302004F;
	Thu,  9 Jul 2026 09:39:13 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 817442004B;
	Thu,  9 Jul 2026 09:39:10 +0000 (GMT)
Received: from fedora (unknown [9.5.7.39])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu,  9 Jul 2026 09:39:10 +0000 (GMT)
Date: Thu, 9 Jul 2026 15:09:33 +0530
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: leixiang <leixiang@kylinos.cn>
Cc: seanjc@google.com, pbonzini@redhat.com, stable@vger.kernel.org,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Suresh Warrier <warrier@linux.vnet.ibm.com>,
        Paul Mackerras <paulus@ozlabs.org>, linuxppc-dev@lists.ozlabs.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: PPC: Book3S HV: Set irqfd->producer only on success
Message-ID: <20260709150215.e5b5af63-43-amachhiw@linux.ibm.com>
Mail-Followup-To: leixiang <leixiang@kylinos.cn>, seanjc@google.com, 
	pbonzini@redhat.com, stable@vger.kernel.org, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
	Suresh Warrier <warrier@linux.vnet.ibm.com>, Paul Mackerras <paulus@ozlabs.org>, 
	linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <ak59frQUBl9Gs3Qn@google.com>
 <20260709055755.31297-1-leixiang@kylinos.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260709055755.31297-1-leixiang@kylinos.cn>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDA4OSBTYWx0ZWRfX0J8Kx25YbE25
 gEKF/7pooXdZT5w2Ana836uEphAVHc51zuQyuiCckgLkullwvVqhD27s5+O3jxr7yjsLJ1qEWto
 M/TFd5KcrnU6ZCNi6yjlkXo/uY2KLdo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDA4OSBTYWx0ZWRfX/tF6QwN3C+Hu
 ELnzvTFlZW8BmZAF6YGV1s97Nt8NYWU12kEb39Q9ZeR6FCKPMw2XJINZ14fht5Xkv1+9oiLe7zN
 RXNuCfQ+1XidblYy5gwGTZVwGIydiMcPu/HW3uWcHiMdP0svvYUk9WmtCy82fRCJAliLMuNCS98
 nxkk5ZNwf1/OpwollX5I3+eFdtYGKyUDzZtukCUpTZ7xxYU8G82Fpwq6j6aZIjkYpAbVxaA5zKT
 u6L/CZ/1aourPoRhz8Qd5Jt4WOYJRhBdLIR/fGzFKuzv/n4fXMDedCznPte2bzqcX5YlYAQjBru
 NOpqgLVbKMact4TdZaBOrq4ZyAOeLd2rjWz8qEI8MAh0iR+GUqjP0WDVzYYQIaCxagYHh75ZEu/
 UXDi37wkNFQBEv6yKJIkm/ODzINhu63c7ICiZuBB9kuZ0pg6IxgMyYKqtIvoOM5myqRCf2iu7OC
 NIklSjUVC1BR1Z1HvQA==
X-Proofpoint-GUID: ZJlaxRQCVLZf1W0xgI-7SUYf5knbDxjI
X-Authority-Analysis: v=2.4 cv=Oot/DS/t c=1 sm=1 tr=0 ts=6a4f6c44 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=1XWaLZrsAAAA:8
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=aQTDHXOw4a3q5qQiMUEA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 3PrTwKRV1brcDspQTSDzvnlPTg6EvwHR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_01,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 clxscore=1011 impostorscore=0 phishscore=0
 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090089
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[google.com,redhat.com,vger.kernel.org,linux.ibm.com,gmail.com,ellerman.id.au,kernel.org,linux.vnet.ibm.com,ozlabs.org,lists.ozlabs.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272856-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:leixiang@kylinos.cn,m:seanjc@google.com,m:pbonzini@redhat.com,m:stable@vger.kernel.org,m:maddy@linux.ibm.com,m:npiggin@gmail.com,m:mpe@ellerman.id.au,m:chleroy@kernel.org,m:warrier@linux.vnet.ibm.com,m:paulus@ozlabs.org,m:linuxppc-dev@lists.ozlabs.org,m:kvm@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[amachhiw@linux.ibm.com,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,linux.ibm.com:mid,linux.ibm.com:from_mime,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,kylinos.cn:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[amachhiw@linux.ibm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1B82872F1BF

On 2026/07/09 01:57 PM, leixiang wrote:
> Set irqfd->producer only after kvmppc_set_passthru_irq() succeeds to
> avoid leaving a dangling pointer on failure. The bypass manager does
> not register a failed producer, so the pointer is never cleared.
> 
> Fixes: c57875f5f9be ("KVM: PPC: Book3S HV: Enable IRQ bypass")
> Suggested-by: Sean Christopherson <seanjc@google.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: leixiang <leixiang@kylinos.cn>
> ---
>  arch/powerpc/kvm/book3s_hv.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
> index 61dbeea317f3..ff7b25629125 100644
> --- a/arch/powerpc/kvm/book3s_hv.c
> +++ b/arch/powerpc/kvm/book3s_hv.c
> @@ -6111,12 +6111,12 @@ static int kvmppc_irq_bypass_add_producer_hv(struct irq_bypass_consumer *cons,
>  	struct kvm_kernel_irqfd *irqfd =
>  		container_of(cons, struct kvm_kernel_irqfd, consumer);
>  
> -	irqfd->producer = prod;
> -
>  	ret = kvmppc_set_passthru_irq(irqfd->kvm, prod->irq, irqfd->gsi);
>  	if (ret)
>  		pr_info("kvmppc_set_passthru_irq (irq %d, gsi %d) fails: %d\n",
>  			prod->irq, irqfd->gsi, ret);
> +	else
> +		irqfd->producer = prod;

cons->add_producer is invoked by __connect() in virt/lib/irqbypass.c,
which itself is called from either irq_bypass_register_consumer() or
irq_bypass_register_producer(). __connect() only records the pairing —
setting cons->producer and prod->consumer — if add_producer returns 0.

  static int __connect(struct irq_bypass_producer *prod,
  		     struct irq_bypass_consumer *cons)
  {
  	[...]
  
  	if (!ret) {
  		prod->consumer = cons;
  		cons->producer = prod;
  	}

On failure, no pairing is recorded, so __disconnect() is never called,
and del_producer is never invoked to clear irqfd->producer. The old
unconditional assignment indeed left a dangling pointer on any
kvmppc_set_passthru_irq() failure.

Reviewed-by: Amit Machhiwal <amachhiw@linux.ibm.com>

~Amit

>  
>  	return ret;
>  }
> -- 
> 2.45.0

