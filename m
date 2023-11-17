Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 036C77EF5AE
	for <lists+stable@lfdr.de>; Fri, 17 Nov 2023 16:50:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231546AbjKQPuu (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 17 Nov 2023 10:50:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231693AbjKQPut (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 17 Nov 2023 10:50:49 -0500
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id BFF73172D
        for <stable@vger.kernel.org>; Fri, 17 Nov 2023 07:50:40 -0800 (PST)
Received: (qmail 1359560 invoked by uid 1000); 17 Nov 2023 10:50:39 -0500
Date:   Fri, 17 Nov 2023 10:50:39 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Niklas Neronin <niklas.neronin@linux.intel.com>
Cc:     linux-usb@vger.kernel.org, gregkh@linuxfoundation.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] usb: config: fix iteration issue in
 'usb_get_bos_descriptor()'
Message-ID: <c9df94db-c810-4f8c-846f-dc2e83fd327c@rowland.harvard.edu>
References: <20231115121325.471454-1-niklas.neronin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231115121325.471454-1-niklas.neronin@linux.intel.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Wed, Nov 15, 2023 at 02:13:25PM +0200, Niklas Neronin wrote:
> The BOS descriptor defines a root descriptor and is the base descriptor for
> accessing a family of related descriptors.
> 
> Function 'usb_get_bos_descriptor()' encounters an iteration issue when
> skipping the 'USB_DT_DEVICE_CAPABILITY' descriptor type. This results in
> the same descriptor being read repeatedly.
> 
> To address this issue, a 'goto' statement is introduced to ensure that the
> pointer and the amount read is updated correctly. This ensures that the
> function iterates to the next descriptor instead of reading the same
> descriptor repeatedly.
> 
> Cc: stable@vger.kernel.org
> Fixes: 3dd550a2d365 ("USB: usbcore: Fix slab-out-of-bounds bug during device reset")
> Signed-off-by: Niklas Neronin <niklas.neronin@linux.intel.com>
> ---

Reviewed-by: Alan Stern <stern@rowland.harvard.edu>

Don't know how I missed that four years ago...

>  drivers/usb/core/config.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/core/config.c b/drivers/usb/core/config.c
> index b19e38d5fd10..7f8d33f92ddb 100644
> --- a/drivers/usb/core/config.c
> +++ b/drivers/usb/core/config.c
> @@ -1047,7 +1047,7 @@ int usb_get_bos_descriptor(struct usb_device *dev)
>  
>  		if (cap->bDescriptorType != USB_DT_DEVICE_CAPABILITY) {
>  			dev_notice(ddev, "descriptor type invalid, skip\n");
> -			continue;
> +			goto skip_to_next_descriptor;
>  		}
>  
>  		switch (cap_type) {
> @@ -1078,6 +1078,7 @@ int usb_get_bos_descriptor(struct usb_device *dev)
>  			break;
>  		}
>  
> +skip_to_next_descriptor:
>  		total_len -= length;
>  		buffer += length;
>  	}
> -- 
> 2.42.0
> 
