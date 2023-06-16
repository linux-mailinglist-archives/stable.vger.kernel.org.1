Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 451897331AB
	for <lists+stable@lfdr.de>; Fri, 16 Jun 2023 14:55:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244744AbjFPMzg (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 16 Jun 2023 08:55:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjFPMzg (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 16 Jun 2023 08:55:36 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0370230FE
        for <stable@vger.kernel.org>; Fri, 16 Jun 2023 05:55:35 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-986bfdfe8d4so22075366b.1
        for <stable@vger.kernel.org>; Fri, 16 Jun 2023 05:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686920133; x=1689512133;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2+oaBIK2LF4p170HeT28XZaKtZGrxpWgqFm5igejLSk=;
        b=su2zY1LAiIwX3sFJUhe3T1HAXYNIbO+v7/iM6ZNDrUAHA04DQSVZZub+JGXPDnOrja
         GWE2f8Nf22zDDZZq+ICrQq6sbcaAFoC4tHICUI/rZGgGNfvCoRnOpwzWarYk3XEAsV6C
         HixSX0ujIn6zXlVJNYdFDxZEIoAYiwVJPA+n8SaNLyMpmLtab3Omb+wzajkU26bWMOZi
         jAcZExziTjTdXZ9kj5emXaH62hnsgfOSop2ovb3ZJklWFQchzWrztNkmNkqyf2pF32uR
         fMNEG03rQXUhVpgqPunkzUbfKR6S76F7hl/4duLZImJUC+2p88RMMNmeZ/SNCsnyrvjK
         JDyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686920133; x=1689512133;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2+oaBIK2LF4p170HeT28XZaKtZGrxpWgqFm5igejLSk=;
        b=E137hNxW2ALvPVAGFTrbCuGIh9MWS+kTT/73NE3trmdB3MazsOf5UJw+txeVyj5r8D
         tKmG3Cx2sLO+kZwHuoPG1d3IfyIs349tjc9myNcC+60aVpqxIuo3lZ8MNbD6FoeZJh9V
         NL3ltPBkaYMXAlX8CwZgOz6fUTSkyJ43mVQ8l9knPH/eUiL8s6Z5T+GYTtqEoiGGdZRP
         ftnbTu2Kg1bOOgsHK2G7yu/Q6uI2LU8VHfDnJxVIoxCWNL0KvXWZccZDFFfRTGIrOITn
         g8I69I2vFFEAmkgsabBtR8V7wtuNeGSEm4FoyJIWIxZ3klonneEP67zrymDM6BeXfvY9
         FvwA==
X-Gm-Message-State: AC+VfDy8WhuPkY8q18aq8jUEfz7OJjczIGeDPg6swKsEHhFfPq6I6k5h
        sZUKUrCSgi9cn5MBCBOIM88wW9YE374=
X-Google-Smtp-Source: ACHHUZ6//kLJfSfYb13DuxlEl/F8twAlkdZ/OIHE9hlVt8E43TOpYOfMiLMfLYRZG5t4bEQfWrf9gA==
X-Received: by 2002:a17:907:1c85:b0:982:84a4:9f80 with SMTP id nb5-20020a1709071c8500b0098284a49f80mr7815459ejc.31.1686920133300;
        Fri, 16 Jun 2023 05:55:33 -0700 (PDT)
Received: from ?IPV6:2a00:e180:151b:3a00:4ba7:36a9:cecb:189? ([2a00:e180:151b:3a00:4ba7:36a9:cecb:189])
        by smtp.gmail.com with ESMTPSA id m8-20020a1709066d0800b0098275b9e00csm3308858ejr.156.2023.06.16.05.55.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jun 2023 05:55:32 -0700 (PDT)
Message-ID: <5d86416d-d3ec-f651-f608-5ba20a6952dd@gmail.com>
Date:   Fri, 16 Jun 2023 14:55:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] drm/amdgpu: fix clearing mappings for BOs that are always
 valid in VM
Content-Language: en-US
To:     Samuel Pitoiset <samuel.pitoiset@gmail.com>,
        amd-gfx@lists.freedesktop.org
Cc:     stable@vger.kernel.org
References: <20230616062708.15913-1-samuel.pitoiset@gmail.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20230616062708.15913-1-samuel.pitoiset@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Am 16.06.23 um 08:27 schrieb Samuel Pitoiset:
> If the BO has been moved the PT should be updated, otherwise the VAs
> might point to invalid PT.

You might want to update this sentence a bit. Something like:

Per VM BOs must be marked as moved or otherwise their ranges are not 
updated on use which might be necessary when the replace operation 
splits mappings.

Apart from that really good catch and the patch is Reviewed-by: 
Christian König <christian.koenig@amd.com>

Regards,
Christian.

>
> This fixes random GPU hangs when replacing sparse mappings from the
> userspace, while OP_MAP/OP_UNMAP works fine because always valid BOs
> are correctly handled there.
>
> Cc: stable@vger.kernel.org
> Signed-off-by: Samuel Pitoiset <samuel.pitoiset@gmail.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 143d11afe0e5..eff73c428b12 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -1771,18 +1771,30 @@ int amdgpu_vm_bo_clear_mappings(struct amdgpu_device *adev,
>   
>   	/* Insert partial mapping before the range */
>   	if (!list_empty(&before->list)) {
> +		struct amdgpu_bo *bo = before->bo_va->base.bo;
> +
>   		amdgpu_vm_it_insert(before, &vm->va);
>   		if (before->flags & AMDGPU_PTE_PRT)
>   			amdgpu_vm_prt_get(adev);
> +
> +		if (bo && bo->tbo.base.resv == vm->root.bo->tbo.base.resv &&
> +		    !before->bo_va->base.moved)
> +			amdgpu_vm_bo_moved(&before->bo_va->base);
>   	} else {
>   		kfree(before);
>   	}
>   
>   	/* Insert partial mapping after the range */
>   	if (!list_empty(&after->list)) {
> +		struct amdgpu_bo *bo = after->bo_va->base.bo;
> +
>   		amdgpu_vm_it_insert(after, &vm->va);
>   		if (after->flags & AMDGPU_PTE_PRT)
>   			amdgpu_vm_prt_get(adev);
> +
> +		if (bo && bo->tbo.base.resv == vm->root.bo->tbo.base.resv &&
> +		    !after->bo_va->base.moved)
> +			amdgpu_vm_bo_moved(&after->bo_va->base);
>   	} else {
>   		kfree(after);
>   	}

