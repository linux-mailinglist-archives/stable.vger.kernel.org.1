Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F3227768C8
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 21:33:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbjHITde (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 15:33:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234064AbjHITd0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 15:33:26 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D02842684
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 12:33:23 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-563e21a6011so171107a12.0
        for <stable@vger.kernel.org>; Wed, 09 Aug 2023 12:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691609603; x=1692214403;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0xVlfa4BbN5B52yKwFRQSAnAaB7SvfP0B/VYlu3C5ok=;
        b=cW5wg48VUfqEZChf2iHsXRd8YC1OkN/z7sHCpCj29Q9ipmaKoiq3k8NGe3vP+/MRHF
         PqOI7n6+pACsDV6ZgjuBd8gjegEahfx9S4nbScpuVNvzxiI8TcQOJBJC8flryUApSWKq
         fZCSNUJBmZVYFo7xFvMQjb3YijXk6f9iGBsPpHNLCpsAVPIRjjS5PGowtL+dZ/hFeSj0
         epsWdhsecybANey6K3HrECWOlO2O1DkroZijAFP7l2mtzPby3cXyWpszJFrXBSF1TmN9
         2yeUNeJsjLjQ4WAhXPm1ZvzT/oQK5wElxtjkkSSrnF4MV4rRUGtjvAMfUA3dsgENC5bt
         AjSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691609603; x=1692214403;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0xVlfa4BbN5B52yKwFRQSAnAaB7SvfP0B/VYlu3C5ok=;
        b=KCmEUej6Kh/krjSwyveohUY2VJ+roOO3tdgMPCH3yPvYcDOscuz5VLBpeJnkhBfPgv
         cSuW7QbmfoiG2wNzwjEtYchJqOZOwrg89iEPbiM2YLNPCyqfQKLErVSpVCQfXc7xQLUY
         9VN2SB9NFIOVhNmfvbMUQG4SBem8LSi9/wenwTnkEI7c7KgCCM+/Wb/rKOn3zkToYuf5
         GlNwC8/3GeYc7oagoJGz2u0u+Zf/oPsaYwrdkkU4WJ0i4RH2Y0fgEV3t5mMNK5UnKdNM
         eA0udNeSz0P/qjaoDMupr7YMqMHM17XYByYrk+YBUzCUfeujg/R6Hk6ay0QP3HptQUnu
         tdfQ==
X-Gm-Message-State: AOJu0YyuAyLbOt+/XMGQ0tSJB/UEeFHOjFnIbfVTN7SZ1HKtpLdW//BF
        Qh3Cb20SwEkSePV2APQNhxo=
X-Google-Smtp-Source: AGHT+IFCdtHHamFefuaCh4YzSuKB1mBkcLLamyxGektlJ61aV3HY05FFvFoTNIXzg6njdKJSBSNsKg==
X-Received: by 2002:a17:90a:fa7:b0:269:14eb:653a with SMTP id 36-20020a17090a0fa700b0026914eb653amr250920pjz.4.1691609603068;
        Wed, 09 Aug 2023 12:33:23 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id 25-20020a17090a199900b002636e5c224asm1956681pji.56.2023.08.09.12.33.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Aug 2023 12:33:22 -0700 (PDT)
Message-ID: <cf831d49-ebdc-d132-9b8e-189e9688a9f2@gmail.com>
Date:   Wed, 9 Aug 2023 12:33:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 5.15 11/92] firmware: arm_scmi: Fix chan_free cleanup on
 SMC
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jim Quinlan <james.quinlan@broadcom.com>
Cc:     patches@lists.linux.dev, Bjorn Andersson <andersson@kernel.org>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Sasha Levin <sashal@kernel.org>
References: <20230809103633.485906560@linuxfoundation.org>
 <20230809103633.950016368@linuxfoundation.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20230809103633.950016368@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 8/9/23 03:40, Greg Kroah-Hartman wrote:
> From: Cristian Marussi <cristian.marussi@arm.com>
> 
> [ Upstream commit d1ff11d7ad8704f8d615f6446041c221b2d2ec4d ]
> 
> SCMI transport based on SMC can optionally use an additional IRQ to
> signal message completion. The associated interrupt handler is currently
> allocated using devres but on shutdown the core SCMI stack will call
> .chan_free() well before any managed cleanup is invoked by devres.
> As a consequence, the arrival of a late reply to an in-flight pending
> transaction could still trigger the interrupt handler well after the
> SCMI core has cleaned up the channels, with unpleasant results.
> 
> Inhibit further message processing on the IRQ path by explicitly freeing
> the IRQ inside .chan_free() callback itself.
> 
> Fixes: dd820ee21d5e ("firmware: arm_scmi: Augment SMC/HVC to allow optional interrupt")
> Reported-by: Bjorn Andersson <andersson@kernel.org>
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> Link: https://lore.kernel.org/r/20230719173533.2739319-1-cristian.marussi@arm.com
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>   drivers/firmware/arm_scmi/smc.c | 17 +++++++++++------
>   1 file changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/firmware/arm_scmi/smc.c b/drivers/firmware/arm_scmi/smc.c
> index 4effecc3bb463..f529004f1922e 100644
> --- a/drivers/firmware/arm_scmi/smc.c
> +++ b/drivers/firmware/arm_scmi/smc.c
> @@ -21,6 +21,7 @@
>   /**
>    * struct scmi_smc - Structure representing a SCMI smc transport
>    *
> + * @irq: An optional IRQ for completion
>    * @cinfo: SCMI channel info
>    * @shmem: Transmit/Receive shared memory area
>    * @shmem_lock: Lock to protect access to Tx/Rx shared memory area
> @@ -30,6 +31,7 @@
>    */
>   
>   struct scmi_smc {
> +	int irq;

For this backport to apply as-is and not define a duplicate "int irq" 
field we need to take in f716cbd33f038af87824c30e165b3b70e4c6be1e 
("firmware: arm_scmi: Make smc transport use common completions") which 
did remove the "int irq" from struct scmi_smc.

Alternatively, we can just omit this hunk adding the "int irq" member 
from the back port.

This is a 5.15 stable kernel problem only because 
f716cbd33f038af87824c30e165b3b70e4c6be1e is in v5.18 and newer.
-- 
Florian

