Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AA15775268
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 07:58:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbjHIF6k (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 01:58:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjHIF6k (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 01:58:40 -0400
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E79FF1BF1;
        Tue,  8 Aug 2023 22:58:38 -0700 (PDT)
Received: from [192.168.0.2] (ip5f5bf3a6.dynamic.kabel-deutschland.de [95.91.243.166])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id CFF1761E5FE01;
        Wed,  9 Aug 2023 07:58:08 +0200 (CEST)
Message-ID: <ce62fee5-7f67-4cf9-b265-f6e6fdc2c59b@molgen.mpg.de>
Date:   Wed, 9 Aug 2023 07:58:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] bluetooth: Add device 0bda:4853 to device tables
Content-Language: en-US
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Gustavo Padovan <gustavo@padovan.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, Hilda Wu <hildawu@realtek.com>,
        stable@vger.kernel.org
References: <20230809010403.24612-1-Larry.Finger@lwfinger.net>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20230809010403.24612-1-Larry.Finger@lwfinger.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Dear Larry,


Thank you for your patch.

Am 09.08.23 um 03:04 schrieb Larry Finger:
> This device is part of a Realtek RTW8852BE chip. The device table
> is as follows:

[…]
> Cc: stable@vger.kernel.org
> Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
> ---
> v2 - fix too long line in description

You also need to start with a capital letter: Bluetooth.

Also, I’d be more specific in the commit message summary. Maybe:

Bluetooth: Flag RTL 0bda:4853 to support wide band speech

> ---
>   drivers/bluetooth/btusb.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 764d176e9735..1019f19d86a7 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -540,6 +540,8 @@ static const struct usb_device_id blacklist_table[] = {

(Unrelated, although it’s named `blacklist_table`, it evolved to a quirk 
table?

>   	/* Realtek 8852BE Bluetooth devices */
>   	{ USB_DEVICE(0x0cb8, 0xc559), .driver_info = BTUSB_REALTEK |
>   						     BTUSB_WIDEBAND_SPEECH },
> +	{ USB_DEVICE(0x0bda, 0x4853), .driver_info = BTUSB_REALTEK |
> +						     BTUSB_WIDEBAND_SPEECH },
>   	{ USB_DEVICE(0x0bda, 0x887b), .driver_info = BTUSB_REALTEK |
>   						     BTUSB_WIDEBAND_SPEECH },
>   	{ USB_DEVICE(0x13d3, 0x3571), .driver_info = BTUSB_REALTEK |


Kind regards,

Paul
