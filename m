Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 661567204FF
	for <lists+stable@lfdr.de>; Fri,  2 Jun 2023 16:57:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236299AbjFBO5B (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 2 Jun 2023 10:57:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236152AbjFBO45 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Jun 2023 10:56:57 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D0A6123;
        Fri,  2 Jun 2023 07:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685717808; x=1717253808;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Eyv4owJ+a1r3cmbMtjO6sLOlcMuL3iqL/tf7QEiAlrg=;
  b=H/7uCIvgOl/ktEEs0YFiUQ/mES6Ytk46ABAlh3R7Sic6c06ihEgzbXqE
   CXTAfukqQNJs/lVjOgy9o24YIcuPdmcuNQQ8m8DPSTzn+P88U081Qlex2
   2yfZFVK3G8pSGfBC6a4sKruJE1ugrlCm7n9PIrZrc65z9rZ+6iJLNRqBJ
   jsGZpjt14hPAomHDQ+fDJiIph5kTdqOjDBQc5mClcK+Jgbwm00Cd9xy0t
   p6JHI1zVgU9EGQIip/WQE3rIAuoArvKKX3u0lgT+zOibHhk+FQ5hgAltj
   YUKED56TftBi+KFeHMVP/Ljh/w5X0cpbILaZmAGwLCMUS2kfLC7l7Rx4J
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10729"; a="354736440"
X-IronPort-AV: E=Sophos;i="6.00,213,1681196400"; 
   d="scan'208";a="354736440"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2023 07:56:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10729"; a="852185973"
X-IronPort-AV: E=Sophos;i="6.00,213,1681196400"; 
   d="scan'208";a="852185973"
Received: from rspatil-mobl3.gar.corp.intel.com ([10.251.208.112])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2023 07:56:46 -0700
Date:   Fri, 2 Jun 2023 17:56:43 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Bernhard Seibold <mail@bernhard-seibold.de>
cc:     linux-serial <linux-serial@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Subject: Re: [PATCH] serial: lantiq: add missing interrupt ack
In-Reply-To: <20230602133029.546-1-mail@bernhard-seibold.de>
Message-ID: <de21c62d-c8a-ccbd-abbe-45bd1c12847@linux.intel.com>
References: <20230602133029.546-1-mail@bernhard-seibold.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-304693598-1685717807=:1742"
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-304693598-1685717807=:1742
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Fri, 2 Jun 2023, Bernhard Seibold wrote:

> Currently, the error interrupt is never acknowledged, so once active it
> will stay active indefinitely, causing the handler to be called in an
> infinite loop.
> 
> Fixes: 2f0fc4159a6a ("SERIAL: Lantiq: Add driver for MIPS Lantiq SOCs.")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Bernhard Seibold <mail@bernhard-seibold.de>
> ---
>  drivers/tty/serial/lantiq.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/tty/serial/lantiq.c b/drivers/tty/serial/lantiq.c
> index a58e9277dfad..f1387f1024db 100644
> --- a/drivers/tty/serial/lantiq.c
> +++ b/drivers/tty/serial/lantiq.c
> @@ -250,6 +250,7 @@ lqasc_err_int(int irq, void *_port)
>  	struct ltq_uart_port *ltq_port = to_ltq_uart_port(port);
>  
>  	spin_lock_irqsave(&ltq_port->lock, flags);
> +	__raw_writel(ASC_IRNCR_EIR, port->membase + LTQ_ASC_IRNCR);
>  	/* clear any pending interrupts */
>  	asc_update_bits(0, ASCWHBSTATE_CLRPE | ASCWHBSTATE_CLRFE |
>  		ASCWHBSTATE_CLRROE, port->membase + LTQ_ASC_WHBSTATE);

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

This has been there since the beginning, it is a bit odd if nobody has hit 
this before now.

-- 
 i.

--8323329-304693598-1685717807=:1742--
