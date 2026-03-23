Return-Path: <stable+bounces-227881-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sASFB9uxwGm5KAQAu9opvQ
	(envelope-from <stable+bounces-227881-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 04:22:03 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A2EEE2EC298
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 04:22:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0EDAD305CE38
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 03:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB74E29993D;
	Mon, 23 Mar 2026 03:17:02 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9176622CBF1;
	Mon, 23 Mar 2026 03:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774235822; cv=none; b=om1CCicnYB9SEhqETLymH8ywGGOhicq4tCOF1Sa3twgFp9UoaPRzEQ5tcLORkBW/MoyhSvbZ76QGB3G6UN4yHgRaPzW6IXDKnrsCPYGea6KsdDb/o+ChgoIX8CFhXB4QKVYr2jN1LdLTmoq04CVbJ3FGkSsCnFqzYdqdbiuF5gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774235822; c=relaxed/simple;
	bh=YuVQUXfe8MAM+ZjW6m/Dc5BJWsK8geS7PtG88iyPWyA=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=iXmZ4HcHHgLr6ZToOZpDrnUc3ndTwKoTwuWNboPQ4Ne/ck9WfWrYKOMMB19uU75dVMJojkpc6rM2+mNMirR2l65H3WFd7X0pgXjuKsk7yboHCpura8WLTWS0tnmpgLL8E0xsoXT6MBEBuXahmMuD9EAt7oGA9Lg+kxncD24ifHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.62])
	by gateway (Coremail) with SMTP id _____8Dx88CisMBpE6gdAA--.25938S3;
	Mon, 23 Mar 2026 11:16:50 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
	by front1 (Coremail) with SMTP id qMiowJDxB8GgsMBpRhFbAA--.29168S3;
	Mon, 23 Mar 2026 11:16:49 +0800 (CST)
Subject: Re: [PATCH 2/2] LoongArch: KVM: Handle the case that EIOINTC's
 coremap is empty
To: Huacai Chen <chenhuacai@loongson.cn>, Paolo Bonzini
 <pbonzini@redhat.com>, Huacai Chen <chenhuacai@kernel.org>,
 Tianrui Zhao <zhaotianrui@loongson.cn>
Cc: kvm@vger.kernel.org, loongarch@lists.linux.dev,
 linux-kernel@vger.kernel.org, Xuerui Wang <kernel@xen0n.name>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, stable@vger.kernel.org,
 Aurelien Jarno <aurel32@debian.org>
References: <20260322135346.3720577-1-chenhuacai@loongson.cn>
 <20260322135346.3720577-2-chenhuacai@loongson.cn>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <faf3a249-4290-8d91-8a28-738af28032c1@loongson.cn>
Date: Mon, 23 Mar 2026 11:14:04 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260322135346.3720577-2-chenhuacai@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJDxB8GgsMBpRhFbAA--.29168S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7ZF1kCF1kGr18XrW5WFy5Jrc_yoW8Gr1DpF
	W7C393K3yrKFy5Xa48tayfWF47Zr95Wr1IqF1UKFyUAFn8XF15XrWrZrs8XFn3C34rKF40
	qF1rKw109a1UAacCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUPIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1ln4kS14v26r126r1DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
	xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q
	6rW5McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr4
	1lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxG
	rwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AKxVWUAVWUtwC20s026c02F40E14
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4U
	MIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jz5lbUUU
	UU=
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,loongson.cn:email,loongson.cn:mid];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_SEVEN(0.00)[11];
	R_DKIM_NA(0.00)[];
	DMARC_NA(0.00)[loongson.cn];
	FROM_NEQ_ENVFROM(0.00)[maobibo@loongson.cn,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-227881-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: A2EEE2EC298
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 2026/3/22 下午9:53, Huacai Chen wrote:
> EIOINTC's coremap in eiointc_update_sw_coremap() can be empty, currently
> we get a cpuid with -1 in this case, but we actually need 0 because it's
> similar as the case that cpuid >= 4.
> 
> This fix an out-of-bounds access to kvm_arch::phyid_map::phys_map[].
> 
> Cc: <stable@vger.kernel.org>
> Fixes: 3956a52bc05bd81 ("LoongArch: KVM: Add EIOINTC read and write functions")
> Reported-by: Aurelien Jarno <aurel32@debian.org>
> Link: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1131431
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
>   arch/loongarch/kvm/intc/eiointc.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/loongarch/kvm/intc/eiointc.c b/arch/loongarch/kvm/intc/eiointc.c
> index d2acb4d09e73..c7badc813923 100644
> --- a/arch/loongarch/kvm/intc/eiointc.c
> +++ b/arch/loongarch/kvm/intc/eiointc.c
> @@ -83,7 +83,7 @@ static inline void eiointc_update_sw_coremap(struct loongarch_eiointc *s,
>   
>   		if (!(s->status & BIT(EIOINTC_ENABLE_CPU_ENCODE))) {
>   			cpuid = ffs(cpuid) - 1;
> -			cpuid = (cpuid >= 4) ? 0 : cpuid;
> +			cpuid = ((cpuid < 0) || (cpuid >= 4)) ? 0 : cpuid;
>   		}
>   
>   		vcpu = kvm_get_vcpu_by_cpuid(s->kvm, cpuid);
> 
Reviewed-by: Bibo Mao <maobibo@loongson.cn>


