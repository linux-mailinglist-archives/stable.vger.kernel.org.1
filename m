Return-Path: <stable+bounces-121706-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B9E0A594EC
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 13:44:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52481188E1C8
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 12:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F338E22A4E0;
	Mon, 10 Mar 2025 12:42:15 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06D9E22171B;
	Mon, 10 Mar 2025 12:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741610535; cv=none; b=XKJDlmtETagW4ZSZ1DYMYweFptQo/5yw/058iE+sim4emwgfaHZH4BVttJ4PH7+q98cukATdNKFkjq5utG+Ofgoa5mp6fqeFOhtZDZx4+9qbin1x9SGpL8gNSFw92wyHpUyTCnxJ+pHA01ZbW1rJutLBV5Jo2v4AFEox+iMnLWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741610535; c=relaxed/simple;
	bh=Mr3ArIL90r3nfEex8ek2xRQJm5qwrKjXOVhHUs4sTTI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PS/EkGojOpEUR5beGdgbXHJ8kSoc8ploJCvd2Apt6l4C4s99a8pHMHUmL42xDy2Tk7glQuZ+UsXO8zmM/wHYMVJs78S08oj1oYriaIOQ5ycNXsvi7l6zjca27q509c6qdiBdVerWi8KsLQTtOoP4UrZaJUsLSJ7O/LFfijbeWSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BB0DF152B;
	Mon, 10 Mar 2025 05:42:24 -0700 (PDT)
Received: from [10.57.39.174] (unknown [10.57.39.174])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 142693F5A1;
	Mon, 10 Mar 2025 05:42:11 -0700 (PDT)
Message-ID: <6f5f2047-b315-440b-b57d-2ed0dd7395f6@arm.com>
Date: Mon, 10 Mar 2025 12:42:10 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/arm: Allow disabling Qualcomm support in
 arm_smmu_v3
To: webgeek1234@gmail.com, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20250310-b4-qcom-smmu-v1-1-733a1398ff85@gmail.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20250310-b4-qcom-smmu-v1-1-733a1398ff85@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-03-10 6:11 am, Aaron Kling via B4 Relay wrote:
> From: Aaron Kling <webgeek1234@gmail.com>
> 
> If ARCH_QCOM is enabled when building arm_smmu_v3,

This has nothing to do with SMMUv3, though?

> a dependency on
> qcom-scm is added, which currently cannot be disabled. Add a prompt to
> ARM_SMMU_QCOM to allow disabling this dependency.

Why is that an issue - what problem arises from having the SCM driver 
enabled? AFAICS it's also selected by plenty of other drivers including 
pretty fundamental ones like pinctrl. If it is somehow important to 
exclude the SCM driver, then I can't really imagine what the use-case 
would be for building a kernel which won't work on most Qualcomm 
platforms but not simply disabling ARCH_QCOM...

Thanks,
Robin.

> Fixes: 0f0f80d9d5db ("iommu/arm: fix ARM_SMMU_QCOM compilation")
> Cc: stable@vger.kernel.org
> Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
> ---
>   drivers/iommu/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index ec1b5e32b9725bc1104d10e5d7a32af7b211b50a..cca0825551959e3f37cc2ea41aeae526fdb73312 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -381,6 +381,7 @@ config ARM_SMMU_MMU_500_CPRE_ERRATA
>   
>   config ARM_SMMU_QCOM
>   	def_tristate y
> +	prompt "Qualcomm SMMUv3 Support"
>   	depends on ARM_SMMU && ARCH_QCOM
>   	select QCOM_SCM
>   	help
> 
> ---
> base-commit: 1110ce6a1e34fe1fdc1bfe4ad52405f327d5083b
> change-id: 20250310-b4-qcom-smmu-d4ccaf66a1ce
> 
> Best regards,


