Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 387987064D6
	for <lists+stable@lfdr.de>; Wed, 17 May 2023 12:03:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbjEQKDl (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 17 May 2023 06:03:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbjEQKDk (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 17 May 2023 06:03:40 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EFB230C1
        for <stable@vger.kernel.org>; Wed, 17 May 2023 03:03:38 -0700 (PDT)
Message-ID: <f36d0a4f-6a7b-653f-8f10-f9a87999d029@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1684317815; h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hOv6CsIx1f54meav43d67GxYm//0h4sJ37ZVe84q8Mc=;
        b=oyma1cowN1NenRixALL4KKfRCt+9kiz+nczY+HujnfmZj2Sfo1uGpnPQGZFA3fIvQc442w
        P+MbWRDxeol4WNz2uVklidEjA9IyrosunQ0YjL+5e2eCs3bGl84O9Lmc1b/kc8n7kUXMY5
        sba8Z9C3hQ/M+0pf3VPC5gtzrb7KghkwY8YJmenn7pFRS9LL6v5DN8VT2tk1uGhGvF4a7j
        AGJptcVQ6qAmnOTsqYtWEIRbo3eE/oiLHpiT8X67UWL9coCWl8t0/yakg9D1KPhHBMHfio
        67+BMQ1SS+EAyNgD5apYbcinongJYPsp+fvqKxER7bkC/0H197NaW8h9JivSzg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1684317815; h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hOv6CsIx1f54meav43d67GxYm//0h4sJ37ZVe84q8Mc=;
        b=Z0EqxQ0UXNv94GWkzbeScJFyqUxNHl311/0CtxWUOOvbHPNLXntHa+/+ObIOOQFVtK5l8e
        /R4oBmBIo/ZdeQDA==
Date:   Wed, 17 May 2023 12:06:18 +0200
MIME-Version: 1.0
Reply-To: steffen.kothe@linutronix.de
Subject: Re: [PATCH 4/5] nvmem: core: fix registration vs use race
Content-Language: en-US
To:     Christian Gabriel <christian.gabriel@linutronix.de>
Cc:     review@linutronix.de,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        stable@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
References: <20230517092024.188665-1-christian.gabriel@linutronix.de>
 <20230517092024.188665-5-christian.gabriel@linutronix.de>
From:   Steffen Kothe <steffen.kothe@linutronix.de>
Organization: Linutronix GmbH
In-Reply-To: <20230517092024.188665-5-christian.gabriel@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 17.05.23 11:20, Christian Gabriel wrote:
> From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
> 
> The i.MX6 CPU frequency driver sometimes fails to register at boot time
> due to nvmem_cell_read_u32() sporadically returning -ENOENT.
> 
> This happens because there is a window where __nvmem_device_get() in
> of_nvmem_cell_get() is able to return the nvmem device, but as cells
> have been setup, nvmem_find_cell_entry_by_node() returns NULL.
> 
> The occurs because the nvmem core registration code violates one of the
> fundamental principles of kernel programming: do not publish data
> structures before their setup is complete.
> 
> Fix this by making nvmem core code conform with this principle.
> 
> Cc: stable@vger.kernel.org
> Fixes: eace75cfdcf7 ("nvmem: Add a simple NVMEM framework for nvmem providers")
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
(cherry picked from ab3428cfd9aa2f3463ee4b2909b5bb2193bd0c4a)
> Signed-off-by: Christian Gabriel <christian.gabriel@linutronix.de>

Please add the (cherry-picked line above your SoB)

Than add my:
	Reviewed-by: Steffen Kothe <steffen.kothe@linutronix.de>

> ---
>   drivers/nvmem/core.c | 16 +++++++---------
>   1 file changed, 7 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
> index 84f4078216a3..6aa8947c4d57 100644
> --- a/drivers/nvmem/core.c
> +++ b/drivers/nvmem/core.c
> @@ -418,16 +418,10 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
>   
>   	device_initialize(&nvmem->dev);
>   
> -	dev_dbg(&nvmem->dev, "Registering nvmem device %s\n", config->name);
> -
> -	rval = device_add(&nvmem->dev);
> -	if (rval)
> -		goto err_put_device;
> -
>   	if (config->compat) {
>   		rval = nvmem_sysfs_setup_compat(nvmem, config);
>   		if (rval)
> -			goto err_device_del;
> +			goto err_put_device;
>   	}
>   
>   	if (config->cells) {
> @@ -444,6 +438,12 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
>   	if (rval)
>   		goto err_remove_cells;
>   
> +	dev_dbg(&nvmem->dev, "Registering nvmem device %s\n", config->name);
> +
> +	rval = device_add(&nvmem->dev);
> +	if (rval)
> +		goto err_remove_cells;
> +
>   	blocking_notifier_call_chain(&nvmem_notifier, NVMEM_ADD, nvmem);
>   
>   	return nvmem;
> @@ -453,8 +453,6 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
>   err_teardown_compat:
>   	if (config->compat)
>   		nvmem_sysfs_remove_compat(nvmem, config);
> -err_device_del:
> -	device_del(&nvmem->dev);
>   err_put_device:
>   	put_device(&nvmem->dev);
>   

Mit freundlichen Grüßen / Kind Regards
-- 
Steffen Kothe
Linutronix GmbH | Bahnhofstrasse 3 | D-88690 Uhldingen-Mühlhofen
Phone: +49 7556 25 999 38; Fax.: +49 7556 25 999 99

Hinweise zum Datenschutz finden Sie hier (Informations on data privacy
can be found here): https://linutronix.de/kontakt/Datenschutz.php

Linutronix GmbH | Firmensitz (Registered Office): Uhldingen-Mühlhofen |
Registergericht (Registration Court): Amtsgericht Freiburg i.Br., HRB700
806 | Geschäftsführer (Managing Directors): Heinz Egger, Thomas Gleixner,
Sharon Heck, Yulia Beck, Tiffany Silva

