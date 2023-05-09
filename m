Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A31EA6FC206
	for <lists+stable@lfdr.de>; Tue,  9 May 2023 10:51:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234756AbjEIIvo (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 9 May 2023 04:51:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234704AbjEIIvk (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 9 May 2023 04:51:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72CEE2705
        for <stable@vger.kernel.org>; Tue,  9 May 2023 01:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683622254;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BkaiU4x3nb/m17t7da/BF+paIsIxbmGrYRV18L4UmqM=;
        b=E3J7H8z1KVtGPkWG7EKvwrrNrdw8n3u3aMorS7aEwxJ/da9RFJXu2qNnaGM55F2qG1laum
        9jWnBmI9gUb6dlNKGI5Gt4kOzK4HPpgVE6+erPlbzlxS5eG8WZg+9fI6qQs28XrVmaPpVv
        2IsmDTkwY/7c5SrTFDhIm/k614aTrQU=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-5-5lO5qtHKNtekXo4mQ9ZucQ-1; Tue, 09 May 2023 04:50:53 -0400
X-MC-Unique: 5lO5qtHKNtekXo4mQ9ZucQ-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-9662960d1e4so299819666b.1
        for <stable@vger.kernel.org>; Tue, 09 May 2023 01:50:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683622252; x=1686214252;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BkaiU4x3nb/m17t7da/BF+paIsIxbmGrYRV18L4UmqM=;
        b=ctQOeZImadBybwjcZyma72e61d2iRu4uF1Ef2IF3pcM2A9YhgmeUgzcqnNvJS7BR99
         QDDzjOKWKVfMkBT0eQYekCtPVpe9BqAIhQiISLdnas4PxWcZG3gG4CORFqqeGTJRu2OI
         zDYc5yCQGZAeCBgW6yMtXS5PADrGpUwWUHz2hxteaWVCUSEwF6O5q1tXi2TOOphUmRu6
         72SaOekUNVXHca/93Ty3lK7WbPEpz7JdnP682mfLmmqOTnw7gpHHV3lUngrXqZfJDeDk
         0ATP+JIkVHXe+2w7yvKNfCz2UhI2mHveVUpgOSgtFhKtODeLoYoZVVVe5GQL88Pode19
         /jWQ==
X-Gm-Message-State: AC+VfDxg7rptpXcDlrtMWku4E1kzHmnJUe4TbDO7IYPi/jM1KYuOjX1n
        zIvYDNW79lBfYnQELVjYWzBjfELfiP6wbr1nfjk/mNyBXrqTraklWd+eyNeUiMu1Gt0csRsGNrr
        DWK6FQrsxrPcy3YJA
X-Received: by 2002:a17:906:db07:b0:94f:6058:4983 with SMTP id xj7-20020a170906db0700b0094f60584983mr9472734ejb.76.1683622252376;
        Tue, 09 May 2023 01:50:52 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7Lys4qdpzHH9JUAe/2W8oRmKIyI5dKTyBiJp+bDzHM33dUKLdgufbsI8thNpHUtEOQx0Kl7w==
X-Received: by 2002:a17:906:db07:b0:94f:6058:4983 with SMTP id xj7-20020a170906db0700b0094f60584983mr9472718ejb.76.1683622252039;
        Tue, 09 May 2023 01:50:52 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id e26-20020a170906845a00b00965cd15c9bbsm1063350ejy.62.2023.05.09.01.50.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 May 2023 01:50:51 -0700 (PDT)
Message-ID: <0ca69990-064f-8b9d-4b7f-7024ad85951f@redhat.com>
Date:   Tue, 9 May 2023 10:50:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 1/2] platform/x86: thinkpad_acpi: Fix platform profiles on
 T490
Content-Language: en-US, nl
To:     Mark Pearson <mpearson-lenovo@squebb.ca>
Cc:     markgross@kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <mpearson-lenovo@squebb.ca>
 <20230505132523.214338-1-mpearson-lenovo@squebb.ca>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230505132523.214338-1-mpearson-lenovo@squebb.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi,

On 5/5/23 15:25, Mark Pearson wrote:
> I had incorrectly thought that PSC profiles were not usable on Intel
> platforms so had blocked them in the driver initialistion. This broke
> platform profiles on the T490.
> 
> After discussion with the FW team PSC does work on Intel platforms and
> should be allowed.
> 
> Note - it's possible this may impact other platforms where it is advertised
> but special driver support that only Windows has is needed. But if it does
> then they will need fixing via quirks. Please report any issues to me so I
> can get them addressed - but I haven't found any problems in testing...yet
> 
> Fixes: bce6243f767f ("platform/x86: thinkpad_acpi: do not use PSC mode on Intel platforms")
> Link: https://bugzilla.redhat.com/show_bug.cgi?id=2177962
> Cc: stable@vger.kernel.org
> Signed-off-by: Mark Pearson <mpearson-lenovo@squebb.ca>

Thank you for your patch series, I've applied this series
to my fixes branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=fixes

Note it will show up in my fixes branch once I've pushed my
local branch there, which might take a while.

I will include this patch in my next fixes pull-req to Linus
for the current kernel development cycle.

Regards,

Hans



> ---
>  drivers/platform/x86/thinkpad_acpi.c | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
> index 826c522ed1c0..d84a4c7e3c35 100644
> --- a/drivers/platform/x86/thinkpad_acpi.c
> +++ b/drivers/platform/x86/thinkpad_acpi.c
> @@ -10585,11 +10585,6 @@ static int tpacpi_dytc_profile_init(struct ibm_init_struct *iibm)
>  				dytc_mmc_get_available = true;
>  		}
>  	} else if (dytc_capabilities & BIT(DYTC_FC_PSC)) { /* PSC MODE */
> -		/* Support for this only works on AMD platforms */
> -		if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD) {
> -			dbg_printk(TPACPI_DBG_INIT, "PSC not support on Intel platforms\n");
> -			return -ENODEV;
> -		}
>  		pr_debug("PSC is supported\n");
>  	} else {
>  		dbg_printk(TPACPI_DBG_INIT, "No DYTC support available\n");

