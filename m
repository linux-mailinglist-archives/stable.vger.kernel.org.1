Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FE8D77917C
	for <lists+stable@lfdr.de>; Fri, 11 Aug 2023 16:12:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234414AbjHKOML (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 11 Aug 2023 10:12:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbjHKOMK (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 11 Aug 2023 10:12:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 945BDD7
        for <stable@vger.kernel.org>; Fri, 11 Aug 2023 07:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691763083;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=da3RUjNaf0ptiK4vOUMQ3vUy+8sPGczXAYcIjVXcZwQ=;
        b=C6A2TK2yRVPFDsEksy6Qq6Qb+3wbVcQQXS7mwPjdEvToNKe7+FPFpFQMOsRBy+RNKyw7Nu
        vnaVy/QLII6qzxr+m9sZQcro7NTI2M43jwG/bKaunbOaiBXsi6jaQzZzw1n2TzOEHVKwAT
        gCr+bj35yoKOncJjWgBvum6e+Agy7uU=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-507-xa1-b5fGOwqIQ6h1rqLQxg-1; Fri, 11 Aug 2023 10:11:22 -0400
X-MC-Unique: xa1-b5fGOwqIQ6h1rqLQxg-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-94a35b0d4ceso138666766b.3
        for <stable@vger.kernel.org>; Fri, 11 Aug 2023 07:11:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691763081; x=1692367881;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=da3RUjNaf0ptiK4vOUMQ3vUy+8sPGczXAYcIjVXcZwQ=;
        b=aMF14RIDer0B+FoBO8YkVP3jECVSUeLa/q3OBfxvidRh2FqkcSv1Dla9+gYxEP3xzJ
         GqVkG0faAg4kRoHl6lVoNTIGLL5oVUW6YyaQ+0kfAjt5ANJejhf5kLqJ39VfnHpg3gVv
         ohAqQsUxW6jD97mnuoZS48pDQwnRyj7DGA4/Nxa6GzNNNCLvVQhqpGuUM+aeFDMMgCxf
         WBaZHQG7OKZNU49qhChjE/HE5M4ooMXIMQm6p6dLMCDmtvd5TOj8LOWHlGpvXZGd52VM
         hlqbU/CDRRl55sfUFi5590sZyamB7bRsJXbYadoWbNYyF7BuJ/vP9bV/CyakCpVR5A05
         tSSw==
X-Gm-Message-State: AOJu0YxBZ/goGDFitzfJlVUoJbptBxH8c8tgImnvLzK9Io8z3H/nvzjS
        kQndImTrOePQ5FJi9FoqqJ5KYgBzE/fEcbjtuoF0UNZbjoaZRzF0waVGKzW1XvsFTWO934eEh1v
        UWDz2K6R/tn8eUDhq
X-Received: by 2002:a17:907:2e19:b0:993:e9b8:90f5 with SMTP id ig25-20020a1709072e1900b00993e9b890f5mr1767064ejc.8.1691763081108;
        Fri, 11 Aug 2023 07:11:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE3CP863bST7FaekwEhDxjrgXYjLqo4nMZTrm9tNfxW3VBjtGXfw2+O+ug3S3qNei6o8RDvHQ==
X-Received: by 2002:a17:907:2e19:b0:993:e9b8:90f5 with SMTP id ig25-20020a1709072e1900b00993e9b890f5mr1767043ejc.8.1691763080759;
        Fri, 11 Aug 2023 07:11:20 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id v8-20020a1709060b4800b009930308425csm2306491ejg.31.2023.08.11.07.11.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Aug 2023 07:11:19 -0700 (PDT)
Message-ID: <e6857898-e145-411a-c1da-6996ab88b66f@redhat.com>
Date:   Fri, 11 Aug 2023 16:11:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] ACPI: resource: Add IRQ override quirk for PCSpecialist
 Elimina Pro 16 M
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>,
        August Wikerfors <git@augustwikerfors.se>
Cc:     Linux regressions mailing list <regressions@lists.linux.dev>,
        stable@vger.kernel.org, linux-acpi@vger.kernel.org
References: <20230810090011.104770-1-hdegoede@redhat.com>
Content-Language: en-US, nl
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230810090011.104770-1-hdegoede@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi,

On 8/10/23 11:00, Hans de Goede wrote:
> The PCSpecialist Elimina Pro 16 M laptop model is a Zen laptop which
> needs to use the MADT IRQ settings override and which does not have
> an INT_SRC_OVR entry for IRQ 1 in its MADT.
> 
> So this model needs a DMI quirk to enable the MADT IRQ settings override
> to fix its keyboard not working.
> 
> Fixes: a9c4a912b7dc ("ACPI: resource: Remove "Zen" specific match and quirks")
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=217394#c18
> Cc: Mario Limonciello <mario.limonciello@amd.com>
> Cc: Linux regressions mailing list <regressions@lists.linux.dev>
> Cc: All applicable <stable@vger.kernel.org>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

I have received confirmation from the reporter that this bug *avoids* things regressing on the PCSpecialist Elimina Pro 16 M after reverting a9c4a912b7dc ("ACPI: resource: Remove "Zen" specific match and quirks").

Regards,

Hans



> ---
>  drivers/acpi/resource.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
> index 8e32dd5776f5..a4d9f149b48d 100644
> --- a/drivers/acpi/resource.c
> +++ b/drivers/acpi/resource.c
> @@ -498,6 +498,17 @@ static const struct dmi_system_id maingear_laptop[] = {
>  	{ }
>  };
>  
> +static const struct dmi_system_id pcspecialist_laptop[] = {
> +	{
> +		.ident = "PCSpecialist Elimina Pro 16 M",
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "PCSpecialist"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "Elimina Pro 16 M"),
> +		},
> +	},
> +	{ }
> +};
> +
>  static const struct dmi_system_id lg_laptop[] = {
>  	{
>  		.ident = "LG Electronics 17U70P",
> @@ -523,6 +534,7 @@ static const struct irq_override_cmp override_table[] = {
>  	{ asus_laptop, 1, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 0, false },
>  	{ tongfang_gm_rg, 1, ACPI_EDGE_SENSITIVE, ACPI_ACTIVE_LOW, 1, true },
>  	{ maingear_laptop, 1, ACPI_EDGE_SENSITIVE, ACPI_ACTIVE_LOW, 1, true },
> +	{ pcspecialist_laptop, 1, ACPI_EDGE_SENSITIVE, ACPI_ACTIVE_LOW, 1, true },
>  	{ lg_laptop, 1, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 0, false },
>  };
>  

