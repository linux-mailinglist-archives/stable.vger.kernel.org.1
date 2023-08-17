Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B42977F19B
	for <lists+stable@lfdr.de>; Thu, 17 Aug 2023 09:59:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348658AbjHQH6r (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 17 Aug 2023 03:58:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348667AbjHQH6i (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 17 Aug 2023 03:58:38 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 238A1A6
        for <stable@vger.kernel.org>; Thu, 17 Aug 2023 00:58:37 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1qWXta-0000kz-PG; Thu, 17 Aug 2023 09:58:18 +0200
Received: from mfe by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1qWXtY-0003bY-6a; Thu, 17 Aug 2023 09:58:16 +0200
Date:   Thu, 17 Aug 2023 09:58:16 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     linux@roeck-us.net, heikki.krogerus@linux.intel.com,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        jun.li@nxp.com, xu.yang_2@nxp.com, angus@akkea.ca,
        stable@vger.kernel.org, Christian Bach <christian.bach@scs.ch>,
        Fabio Estevam <festevam@denx.de>
Subject: Re: [PATCH v3] usb: typec: tcpci: clear the fault status bit
Message-ID: <20230817075816.udosrvc4rx6cgp5b@pengutronix.de>
References: <20230816172502.1155079-1-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230816172502.1155079-1-festevam@gmail.com>
User-Agent: NeoMutt/20180716
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: stable@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 23-08-16, Fabio Estevam wrote:
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
> ---
> Changes since v2:
> - Submitted it as a standalone patch.
> - Explain that it may cause a kernel hang.
> - Fixed typos in the commit log. (Guenter)
> - Check the tcpci_write16() return value. (Guenter)
> - Write to TCPC_FAULT_STATUS unconditionally. (Guenter)
> - Added Fixes, Reported-by and Closes tags.
> - CCed stable

thanks for the work Fabio :)

Regards,
  Marco

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
> 
