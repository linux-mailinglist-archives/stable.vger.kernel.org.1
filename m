Return-Path: <stable+bounces-249586-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wAQtNm1gDGpXggUAu9opvQ
	(envelope-from <stable+bounces-249586-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 15:06:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B34957F4AD
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 15:06:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4A4CB3021666
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 13:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 273B24DD6FC;
	Tue, 19 May 2026 13:00:30 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59A773F0744;
	Tue, 19 May 2026 13:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779195630; cv=none; b=AUT0ySOfFPEgrYLDNjjxJHlXdTqgF6G7FHDCkTJjKcediKXK5X1OaStwHNeheZENwYHrtBmnZESNTqd/GIHgXw0y5lHrwgkIcAMePPuS3ZYegyTKNYtwC83ZmDkXrqpo92f1qLLeZJ+YqL2iq1Hn+EOhSaB4y+K172muBPz+rW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779195630; c=relaxed/simple;
	bh=3WlavuYFyG826CqF8Gc3U83JaaU7/hj7idobD7tgd5g=;
	h=Subject:From:To:Cc:References:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=fVRPt9q6xEG39a6NX55Q91W4enI2ZaAVg9+1Ri69mLLqMzvnQDqLwTyXFg6nFeW2/PEuJBf6+69xc+eUcDKlHwMpT8WK2jN31wd1PRVlJmryjQla4qVezNL25011GyZ6hgn926TiymStNETRVbrLquAyBYDByJQj+uQvPtl7W+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.62])
	by gateway (Coremail) with SMTP id _____8BxDuriXgxqGDoLAA--.32494S3;
	Tue, 19 May 2026 21:00:18 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
	by front1 (Coremail) with SMTP id qMiowJDxTMLgXgxqjGSIAA--.59686S3;
	Tue, 19 May 2026 21:00:16 +0800 (CST)
Subject: Re: [PATCH v3 1/6] LoongArch: KVM: Check irq validility in
 kvm_vcpu_ioctl_interrupt()
From: Bibo Mao <maobibo@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: kernel@xen0n.name, kvm@vger.kernel.org, loongarch@lists.linux.dev,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260519094308.3983046-1-maobibo@loongson.cn>
 <20260519094308.3983046-2-maobibo@loongson.cn>
Message-ID: <786dda77-1fda-7741-c20f-bafbaacd6fd2@loongson.cn>
Date: Tue, 19 May 2026 20:57:16 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260519094308.3983046-2-maobibo@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJDxTMLgXgxqjGSIAA--.59686S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7Jw48XFy5CrWfWFW7ur1UCFX_yoW8JrWDpr
	9rCF1DX3yrGrnrKw1xXayv9wsIvrykKr1I9asrJa4rAr9Iyr1YqFWxCrW29Fy7Gw1rJF4I
	qr1ft3Wj9as8A3gCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
	1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv
	67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
	AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
	F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw
	1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
	xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
	1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8j-
	e5UUUUU==
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DMARC_NA(0.00)[loongson.cn];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maobibo@loongson.cn,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249586-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,loongson.cn:mid,loongson.cn:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 5B34957F4AD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 2026/5/19 下午5:43, Bibo Mao wrote:
> Function kvm_vcpu_ioctl_interrupt() can be called from userspace, here
> add irq validility cheking in kvm_vcpu_ioctl_interrupt().
> 
> Fixes: f45ad5b8aa93 ("LoongArch: KVM: Implement vcpu interrupt operations")
> Cc: stable@vger.kernel.org
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>   arch/loongarch/kvm/vcpu.c | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/loongarch/kvm/vcpu.c b/arch/loongarch/kvm/vcpu.c
> index e28084c49e68..673977a25138 100644
> --- a/arch/loongarch/kvm/vcpu.c
> +++ b/arch/loongarch/kvm/vcpu.c
> @@ -1486,7 +1486,14 @@ void kvm_lose_fpu(struct kvm_vcpu *vcpu)
>   
>   int kvm_vcpu_ioctl_interrupt(struct kvm_vcpu *vcpu, struct kvm_interrupt *irq)
>   {
> -	int intr = (int)irq->irq;
> +	int vector, intr = (int)irq->irq;
> +
> +	vector = intr;
> +	if (intr < 0)
> +		vector = -intr;
By AI review, there is still problem if the value of intr is 0x8000000. 
I should notice this earlier :(

http://sashiko.dev/#/patchset/20260519094308.3983046-1-maobibo%40loongson.cn

Regards
Bibo Mao
> +
> +	if (vector >= EXCCODE_INT_NUM)
> +		return -EINVAL;
>   
>   	if (intr > 0)
>   		kvm_queue_irq(vcpu, intr);
> 


