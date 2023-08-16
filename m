Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8638577EA91
	for <lists+stable@lfdr.de>; Wed, 16 Aug 2023 22:17:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346081AbjHPURB (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 16 Aug 2023 16:17:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346073AbjHPUQs (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 16 Aug 2023 16:16:48 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D45E1FE3;
        Wed, 16 Aug 2023 13:16:47 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-68879c7f5easo1203366b3a.1;
        Wed, 16 Aug 2023 13:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692217007; x=1692821807;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nZM/eyn/Z81Tm9J694oWmHZlVhE2rGX5Mf5KWzu1qc0=;
        b=ZZLlPWhtpBfb8SoQ0BhA/882tPCtx3FYqRb+hioIWXD0wyuZgBXPWKfFA+9LrWWWW2
         KPSzsog2P0h343wrzVZ2b71JnJ0Ww3DXgg2IwqDAKKtWNgHzTaRpA7tW+7fS+8yC5L5v
         ScOV2Vcp0fivunwcTAKxIAlhhEQjC0EVhlxBQD7Z6rTTSn7FcGQ5AhUNt1sDhYyyGWym
         4TK3/Dy6sTMlnix3YwUTqsdIetuhlD7lYKg5qJRrDJ5dfZ5R3rkjGnnrTKGYXA63DBRu
         expypEbq5Q69/l9G8IGbSU/BCpPmjrIjnClDiHghwxOPwiTfjBOdZcRXOyg2UsmiQ75a
         wcRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692217007; x=1692821807;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nZM/eyn/Z81Tm9J694oWmHZlVhE2rGX5Mf5KWzu1qc0=;
        b=Y8izhaQP1mquXqzetTssSeRF1dWf6/DDq/29y4Diq/EAUmvu14QPXDZpMwGJHNCivM
         78aWL52k/a1bkoxkdxGlnmIU5kMQTCee/augkgK6X6y9rO0Z89IFU5G3rQFolZYu0bXN
         qRlleKHHn1YPj/q38pkUI0Llkd7/2uZbizGLvqYQSe4IQRL5RJEqvT7THEgssUHAMsnw
         0p3TAOzEEdNaMsunY3kxp0NDafvSMxFAYVkry0fmroW3eUFi7thFQBJiVxHuCGhCrUxc
         NvklO9xUgeVRDwkX9PtZy104hSxSCaQHOiNXJF14ePRvg/cV6sriFa5C2CF8BlG4jMBr
         UWKQ==
X-Gm-Message-State: AOJu0YwgJe4xcL7pr1zVCtyhuNnHPUAGpF8F+p4ndWQN6PPPRsif7Dye
        m8WYqatp3kVlKABlOlcNg2jePRpocH4=
X-Google-Smtp-Source: AGHT+IG7oPpIeGE0niswNlwO4hc+s+FI0MmkllISzy9y0LRDHfCq+UZnlTYGS32lTEsHnmV8McNbbQ==
X-Received: by 2002:a05:6a21:3383:b0:13b:9d80:673d with SMTP id yy3-20020a056a21338300b0013b9d80673dmr3631298pzb.48.1692217006754;
        Wed, 16 Aug 2023 13:16:46 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id n12-20020aa7904c000000b00688214cff65sm7884844pfo.44.2023.08.16.13.16.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 13:16:46 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 16 Aug 2023 13:16:44 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, m.felsch@pengutronix.de, jun.li@nxp.com,
        xu.yang_2@nxp.com, angus@akkea.ca, stable@vger.kernel.org,
        Christian Bach <christian.bach@scs.ch>,
        Fabio Estevam <festevam@denx.de>
Subject: Re: [PATCH v3] usb: typec: tcpci: clear the fault status bit
Message-ID: <462383e9-48be-41a2-a275-8c330a2fb7e6@roeck-us.net>
References: <20230816172502.1155079-1-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230816172502.1155079-1-festevam@gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Wed, Aug 16, 2023 at 02:25:02PM -0300, Fabio Estevam wrote:
> From: Marco Felsch <m.felsch@pengutronix.de>
> 
> According the "USB Type-C Port Controller Interface Specification v2.0"
> the TCPC sets the fault status register bit-7
> (AllRegistersResetToDefault) once the registers have been reset to
> their default values.
> 
> This triggers an alert(-irq) on PTN5110 devices albeit we do mask the
> fault-irq, which may cause a kernel hang. Fix this generically by writing
> a one to the corresponding bit-7.
> 
> Cc: stable@vger.kernel.org
> Fixes: 74e656d6b055 ("staging: typec: Type-C Port Controller Interface driver (tcpci)")
> Reported-by: Angus Ainslie (Purism) <angus@akkea.ca>
> Closes: https://lore.kernel.org/all/20190508002749.14816-2-angus@akkea.ca/
> Reported-by: Christian Bach <christian.bach@scs.ch>
> Closes: https://lore.kernel.org/regressions/ZR0P278MB07737E5F1D48632897D51AC3EB329@ZR0P278MB0773.CHEP278.PROD.OUTLOOK.COM/t/
> Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> Signed-off-by: Fabio Estevam <festevam@denx.de>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
> Changes since v2:
> - Submitted it as a standalone patch.
> - Explain that it may cause a kernel hang.
> - Fixed typos in the commit log. (Guenter)
> - Check the tcpci_write16() return value. (Guenter)
> - Write to TCPC_FAULT_STATUS unconditionally. (Guenter)
> - Added Fixes, Reported-by and Closes tags.
> - CCed stable
> 
>  drivers/usb/typec/tcpm/tcpci.c | 4 ++++
>  include/linux/usb/tcpci.h      | 1 +
>  2 files changed, 5 insertions(+)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpci.c b/drivers/usb/typec/tcpm/tcpci.c
> index fc708c289a73..0ee3e6e29bb1 100644
> --- a/drivers/usb/typec/tcpm/tcpci.c
> +++ b/drivers/usb/typec/tcpm/tcpci.c
> @@ -602,6 +602,10 @@ static int tcpci_init(struct tcpc_dev *tcpc)
>  	if (time_after(jiffies, timeout))
>  		return -ETIMEDOUT;
>  
> +	ret = tcpci_write16(tcpci, TCPC_FAULT_STATUS, TCPC_FAULT_STATUS_ALL_REG_RST_TO_DEFAULT);
> +	if (ret < 0)
> +		return ret;
> +
>  	/* Handle vendor init */
>  	if (tcpci->data->init) {
>  		ret = tcpci->data->init(tcpci, tcpci->data);
> diff --git a/include/linux/usb/tcpci.h b/include/linux/usb/tcpci.h
> index 85e95a3251d3..83376473ac76 100644
> --- a/include/linux/usb/tcpci.h
> +++ b/include/linux/usb/tcpci.h
> @@ -103,6 +103,7 @@
>  #define TCPC_POWER_STATUS_SINKING_VBUS	BIT(0)
>  
>  #define TCPC_FAULT_STATUS		0x1f
> +#define TCPC_FAULT_STATUS_ALL_REG_RST_TO_DEFAULT BIT(7)
>  
>  #define TCPC_ALERT_EXTENDED		0x21
>  
> -- 
> 2.34.1
> 
