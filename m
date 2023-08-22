Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C90878429A
	for <lists+stable@lfdr.de>; Tue, 22 Aug 2023 15:57:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235675AbjHVN5N (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 22 Aug 2023 09:57:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234758AbjHVN5N (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 22 Aug 2023 09:57:13 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB2241B2;
        Tue, 22 Aug 2023 06:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692712630; x=1724248630;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xm+ChoDHCRRg92ZpEGU+hqMQz3A/PQV2UsdtIYTADCU=;
  b=d4bSIupHoppOty8HcGbfYYdza3V9eSfv4XN3cWhWUfmSoKG76y7FSl/d
   VKMlap8M5UBFwL28smW5Ezv5FulyaJfvB1gLfwy4W2oSAhSspEjpUociz
   ABWpEn0DkANUTcVNRWVSSB6V3f4ShCksfe41HLvmOWamvS3K27y0geZio
   vxRjLcJozYVOrN1ktNwy7V2ACaQON3aAPcaH56c40mxpceWjdd6qCbr11
   4B2mwqsCX/NIdcxNEq8OldFiMgR45ND1R0m3Xx/AxdwHa2C/BntqHhyOv
   4GnLZgma5STx7BSsRxmijBmQ3jaXvcUIM5NlHzCvp0/3EIqzw6jl0b1/W
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="440250858"
X-IronPort-AV: E=Sophos;i="6.01,193,1684825200"; 
   d="scan'208";a="440250858"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2023 06:57:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="879962605"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 22 Aug 2023 06:57:09 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 22 Aug 2023 16:57:04 +0300
Date:   Tue, 22 Aug 2023 16:57:04 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     linux@roeck-us.net, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, m.felsch@pengutronix.de, jun.li@nxp.com,
        xu.yang_2@nxp.com, angus@akkea.ca, stable@vger.kernel.org,
        Christian Bach <christian.bach@scs.ch>,
        Fabio Estevam <festevam@denx.de>
Subject: Re: [PATCH v3] usb: typec: tcpci: clear the fault status bit
Message-ID: <ZOS+sPN43cpMwd8e@kuha.fi.intel.com>
References: <20230816172502.1155079-1-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230816172502.1155079-1-festevam@gmail.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

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

-- 
heikki
