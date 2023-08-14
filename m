Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1265177C396
	for <lists+stable@lfdr.de>; Tue, 15 Aug 2023 00:41:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229441AbjHNWkr (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 14 Aug 2023 18:40:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233366AbjHNWkp (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 14 Aug 2023 18:40:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B12198
        for <stable@vger.kernel.org>; Mon, 14 Aug 2023 15:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692052802;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=l7gIh6nlPqSk8LuuWdz7csSouyNxDZki4ms0rDOko5s=;
        b=WRIjQBjJPz9VloENeOoxHvr/UkFHC9HZn+lnCinXL0z0HiPD4W1nXXKdJIh1laTiuzu6o/
        vIB9UzIDO2cFz+upj9ulNs3WJq9goPyw8yiFC+KrTZ26jjjnlkGKk4GV60r+H74ZMjXGvh
        JwPSnTEeLgxYez756nb6T1oo67flMao=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-159-FdKiehdZPKahAmFFDNyPVA-1; Mon, 14 Aug 2023 18:40:01 -0400
X-MC-Unique: FdKiehdZPKahAmFFDNyPVA-1
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-5646868b9e7so5080611a12.3
        for <stable@vger.kernel.org>; Mon, 14 Aug 2023 15:40:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692052800; x=1692657600;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l7gIh6nlPqSk8LuuWdz7csSouyNxDZki4ms0rDOko5s=;
        b=ZcGa6f6XZ2NbQy9FrIuJvlhgRzHc2nLXxlHfoh9b1MX4Bzhd3zG3LtKzLPCTgdjOA+
         lOg+eXhPaJ0nZPxhVVnBzW3wpu/iOn7BNQiGvfJDtxHBhhtBD4FdWWIgAIpuq+ljOkUq
         vrpMn+9pHbkqzY+Si7LBjjlRG2XGWH5nqFIVZ2XB4pq64yXXyI96yVVoWNlZrFMNdZg2
         UxYEpQhVK1i5W6QMqeJnVVsv4pmHvwQot1iCL/aganCfF4bFysLMyY0X2OruIs4M3eGl
         ic9zHmSFC19qnZWN6W6Bvxn0Noyd0OsRSjuQgc1EJCLrN95R19KMQBIkX4HDMbwbJolD
         ctFg==
X-Gm-Message-State: AOJu0YwoNqh1OqHsoP+rJ9l514fnQ/biPMYRcJv2U/saYfy3naCQj8Uw
        btjkrG/002vTSPssh2sb7qQz6XKCcY7GhxBNle2RYVtUYCD2xCYMPC+w6eiA3lavXXJi5K7pH56
        8ffyZxYGPj95A2TDt
X-Received: by 2002:a05:6a20:441f:b0:12e:7c29:a6dd with SMTP id ce31-20020a056a20441f00b0012e7c29a6ddmr11376822pzb.43.1692052800014;
        Mon, 14 Aug 2023 15:40:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF01jSZJ6upznh7bf7zow0hjWHaC+2v5nH9nEmy2PDwpj41mQnVkeFYwD3RO97AQ8NT35C/VA==
X-Received: by 2002:a05:6a20:441f:b0:12e:7c29:a6dd with SMTP id ce31-20020a056a20441f00b0012e7c29a6ddmr11376811pzb.43.1692052799700;
        Mon, 14 Aug 2023 15:39:59 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id u18-20020a170903125200b001b53953f306sm9975124plh.178.2023.08.14.15.39.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 15:39:57 -0700 (PDT)
Date:   Mon, 14 Aug 2023 15:39:56 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     linux-integrity@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        stable@vger.kernel.org, Takashi Iwai <tiwai@suse.de>,
        Lino Sanfilippo <l.sanfilippo@kunbus.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tpm/tpm_tis: Disable interrupts categorically for Lenovo
Message-ID: <7ruidj3qnt6eapetwt6uwhkqeextehaisoc2i6axqax3s5js7z@eu6hoh2q7tkd>
References: <20230810182433.518523-1-jarkko@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230810182433.518523-1-jarkko@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Thu, Aug 10, 2023 at 09:24:33PM +0300, Jarkko Sakkinen wrote:
> By large most of the entries in tpm_tis_dmi_table[] are for Lenovo laptops,
> and they keep on coming. Therefore, disable IRQs categorically for Lenovo.
> 
> Fixes: e644b2f498d2 ("tpm, tpm_tis: Enable interrupt test")
> Cc: <stable@vger.kernel.org> # v6.4+
> Reported-by: "Takashi Iwai" <tiwai@suse.de>
> Closes: https://lore.kernel.org/linux-integrity/87il9qhxjq.wl-tiwai@suse.de/
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

Acked-by: Jerry Snitselaar <jsnitsel@redhat.com>

> ---
> This will be included into v6.5-rc6 PR, as long as Takashi ack's it. I'm
> planning to send tomorrow morning (GMT+3).
> 
> BR, Jarkko
>  drivers/char/tpm/tpm_tis.c | 34 ----------------------------------
>  1 file changed, 34 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm_tis.c b/drivers/char/tpm/tpm_tis.c
> index 3c0f68b9e44f..dd0f52d35073 100644
> --- a/drivers/char/tpm/tpm_tis.c
> +++ b/drivers/char/tpm/tpm_tis.c
> @@ -132,42 +132,8 @@ static const struct dmi_system_id tpm_tis_dmi_table[] = {
>  	},
>  	{
>  		.callback = tpm_tis_disable_irq,
> -		.ident = "ThinkPad T490s",
>  		.matches = {
>  			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> -			DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad T490s"),
> -		},
> -	},
> -	{
> -		.callback = tpm_tis_disable_irq,
> -		.ident = "ThinkStation P360 Tiny",
> -		.matches = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> -			DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkStation P360 Tiny"),
> -		},
> -	},
> -	{
> -		.callback = tpm_tis_disable_irq,
> -		.ident = "ThinkPad L490",
> -		.matches = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> -			DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad L490"),
> -		},
> -	},
> -	{
> -		.callback = tpm_tis_disable_irq,
> -		.ident = "ThinkPad L590",
> -		.matches = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> -			DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad L590"),
> -		},
> -	},
> -	{
> -		.callback = tpm_tis_disable_irq,
> -		.ident = "ThinkStation P620",
> -		.matches = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> -			DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkStation P620"),
>  		},
>  	},
>  	{
> -- 
> 2.39.2
> 

