Return-Path: <stable+bounces-194776-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E6B3C5C368
	for <lists+stable@lfdr.de>; Fri, 14 Nov 2025 10:20:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9824F4E488C
	for <lists+stable@lfdr.de>; Fri, 14 Nov 2025 09:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D5EA2FE075;
	Fri, 14 Nov 2025 09:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qDL/ZFoo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC9A227EFEF;
	Fri, 14 Nov 2025 09:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763111484; cv=none; b=ec64i2yiIRGx3bW9Kk+aAvyEzaN8YyyndTo2JK8G0tVtRU+mQDpoZafz40mu7YmnUy+FE1YrQS5NTWWr8mjyqZYY8SWFmOCwnz5t83aI65qgs1q9NVEUZ1iYqV2ytpipscgs37e2G6MN91evvICIMVQTrKazPPLIiY4MCm0OTyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763111484; c=relaxed/simple;
	bh=4bUe5Ax7eP5+O7eH4xwn1ucE348NJIHO1n8FTISL6Wk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gcSb+L57Asa/sAqmy1QOLVIKYUIlUQoVFbWGNdmLlI2EPYSuYv98b/3OsOV6vFhEogn5/J3x+7fbVijslGNC8Iz+JaA3ZdRXR7cC6xoRUr9+OwAwOpecKG8Au/4VVwZAwLcIl7B92eeg6Hc7w9soZW1+zyKqX9F8vUZP0v1ePxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qDL/ZFoo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12C26C4CEF1;
	Fri, 14 Nov 2025 09:11:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763111484;
	bh=4bUe5Ax7eP5+O7eH4xwn1ucE348NJIHO1n8FTISL6Wk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qDL/ZFooJb8prJ+A5aXqzeCEsCIeVSCJ9HXcKqM+XON3p75vVtCyUZy7lWYQ4eCz/
	 +z2JSFQAbWBZulQ/jzOAHjxpO9klt8A0ULEOth50qNtoqOojUbiL5be1zN6TglfKyA
	 o9CZIydGR3Ks496J7GqPO58FeUFwpSylZ0Z4PuO/HOV5l5B7OQ4flhLoOzU2jcqVuf
	 NfSKk/mFCSCOl0GbibxdkCZmJD4N4UtW+pfbDzftDFoHcp2Kqdw/KlBmYni2Zw/ZOM
	 FW4Gd9xAoiPLClhPBig3kExl8BZM8d0AD0j85bksdu43agdSm4XeRPmiit/m2klW7E
	 GhaWeyOsr+H6A==
Message-ID: <d1d857ee-60c9-4e38-82c7-062e55e6f4f3@kernel.org>
Date: Fri, 14 Nov 2025 10:11:17 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] powerpc/powermac: Fix reference count leak in i2c probe
 functions
To: Miaoqian Lin <linmq006@gmail.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@ozlabs.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20251027084556.80287-1-linmq006@gmail.com>
From: Christophe Leroy <chleroy@kernel.org>
Content-Language: fr-FR
In-Reply-To: <20251027084556.80287-1-linmq006@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 27/10/2025 à 09:45, Miaoqian Lin a écrit :
> [Vous ne recevez pas souvent de courriers de linmq006@gmail.com. Découvrez pourquoi ceci est important à https://aka.ms/LearnAboutSenderIdentification ]
> 
> The of_find_node_by_name() function returns a device tree node with its
> reference count incremented. The caller is responsible for calling
> of_node_put() to release this reference when done.
> 
> Fixes: 730745a5c450 ("[PATCH] 1/5 powerpc: Rework PowerMac i2c part 1")
> Cc: stable@vger.kernel.org
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> ---
>   arch/powerpc/platforms/powermac/low_i2c.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/platforms/powermac/low_i2c.c b/arch/powerpc/platforms/powermac/low_i2c.c
> index 02474e27df9b..f04dbb93bbfa 100644
> --- a/arch/powerpc/platforms/powermac/low_i2c.c
> +++ b/arch/powerpc/platforms/powermac/low_i2c.c
> @@ -802,8 +802,10 @@ static void __init pmu_i2c_probe(void)
>          for (channel = 1; channel <= 2; channel++) {
>                  sz = sizeof(struct pmac_i2c_bus) + sizeof(struct adb_request);
>                  bus = kzalloc(sz, GFP_KERNEL);
> -               if (bus == NULL)
> +               if (bus == NULL) {
> +                       of_node_put(busnode);

We are in a loop, what happens when kzalloc() succeded in the first 
iteration but not in a further iteration ? In that case we have already 
registered some bus which references busnode as bus->busnode so it just 
can't but put.

>                          return;
> +               }
> 
>                  bus->controller = busnode;
>                  bus->busnode = busnode;
> @@ -928,6 +930,7 @@ static void __init smu_i2c_probe(void)
>                  bus = kzalloc(sz, GFP_KERNEL);
>                  if (bus == NULL) {
>                          of_node_put(busnode);
> +                       of_node_put(controller);
>                          return;
>                  }
> 
> --
> 2.39.5 (Apple Git-154)
> 
-- 
pw-bot: cr


