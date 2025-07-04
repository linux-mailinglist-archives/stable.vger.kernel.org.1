Return-Path: <stable+bounces-160146-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED966AF8841
	for <lists+stable@lfdr.de>; Fri,  4 Jul 2025 08:45:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7C1D58462F
	for <lists+stable@lfdr.de>; Fri,  4 Jul 2025 06:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A606726158D;
	Fri,  4 Jul 2025 06:44:45 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F635261390;
	Fri,  4 Jul 2025 06:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751611485; cv=none; b=uS+95h5hURve6aCFRjHZnyD7dH1uiXCYDgfZm6VU4ZNUgkNFon1k6/d2wSQrh3WXzl32e/4C0mRr++nDKn8SZTHQxX2XRL4M5db2S/6rCWzeYi6I9yQ7H0xSafxxM5jDDsWSZwI8UTl7H8z9JHdZmVCC8Vx5etv9Jo5hF7Xu8Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751611485; c=relaxed/simple;
	bh=4jqv/tFlSpCT9VBH8J464fArP8r5d9j/6sOOfWltQDo=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=aG6lvmRo+dhqae6fQx2vNWQYfeANPOCrRAdStvTspb9oKy1wCNw+U3EIo6MGF770NlwR4lOzZz9pNlIMDrmkyMcrxkK923vLkO5Qo0t5Dlnqmob01P5cfuBGuhZvmm9fXd1NWRQ0IkjVMXHCv9JIxneyx/izOEHQWzPEnqlalOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4bYPG45GX2z2BdVd;
	Fri,  4 Jul 2025 14:42:52 +0800 (CST)
Received: from kwepemk200017.china.huawei.com (unknown [7.202.194.83])
	by mail.maildlp.com (Postfix) with ESMTPS id F24791A016C;
	Fri,  4 Jul 2025 14:44:40 +0800 (CST)
Received: from [10.174.178.219] (10.174.178.219) by
 kwepemk200017.china.huawei.com (7.202.194.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 4 Jul 2025 14:44:39 +0800
Subject: Re: [PATCH 1/2] KVM: arm64: Fix enforcement of upper bound on
 MDCR_EL2.HPMN
To: Ben Horgan <ben.horgan@arm.com>
CC: <catalin.marinas@arm.com>, <will@kernel.org>, <maz@kernel.org>,
	<oliver.upton@linux.dev>, <joey.gouly@arm.com>, <suzuki.poulose@arm.com>,
	<linux-arm-kernel@lists.infradead.org>, <kvmarm@lists.linux.dev>,
	<yury.norov@gmail.com>, <linux@rasmusvillemoes.dk>,
	<linux-kernel@vger.kernel.org>, <james.morse@arm.com>,
	<stable@vger.kernel.org>
References: <20250703135729.1807517-1-ben.horgan@arm.com>
 <20250703135729.1807517-2-ben.horgan@arm.com>
From: Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <ca3054b2-b053-3859-a992-09499809d4d4@huawei.com>
Date: Fri, 4 Jul 2025 14:44:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250703135729.1807517-2-ben.horgan@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemk200017.china.huawei.com (7.202.194.83)

On 2025/7/3 21:57, Ben Horgan wrote:
> Previously, u64_replace_bits() was used to no effect as the return value
> was ignored. Convert to u64p_replace_bits() so the value is updated in
> place.
> 
> Signed-off-by: Ben Horgan <ben.horgan@arm.com>
> Fixes: efff9dd2fee7 ("KVM: arm64: Handle out-of-bound write to MDCR_EL2.HPMN")
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: stable@vger.kernel.org
> ---
>  arch/arm64/kvm/sys_regs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
> index 76c2f0da821f..c20bd6f21e60 100644
> --- a/arch/arm64/kvm/sys_regs.c
> +++ b/arch/arm64/kvm/sys_regs.c
> @@ -2624,7 +2624,7 @@ static bool access_mdcr(struct kvm_vcpu *vcpu,
>  	 */
>  	if (hpmn > vcpu->kvm->arch.nr_pmu_counters) {
>  		hpmn = vcpu->kvm->arch.nr_pmu_counters;
> -		u64_replace_bits(val, hpmn, MDCR_EL2_HPMN);
> +		u64p_replace_bits(&val, hpmn, MDCR_EL2_HPMN);
>  	}
>  
>  	__vcpu_assign_sys_reg(vcpu, MDCR_EL2, val);

Reviewed-by: Zenghui Yu <yuzenghui@huawei.com>

Thanks!

