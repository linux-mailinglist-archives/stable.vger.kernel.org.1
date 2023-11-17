Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D383F7EFC34
	for <lists+stable@lfdr.de>; Sat, 18 Nov 2023 00:42:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230379AbjKQXmb (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 17 Nov 2023 18:42:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjKQXma (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 17 Nov 2023 18:42:30 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C108410C6
        for <stable@vger.kernel.org>; Fri, 17 Nov 2023 15:42:25 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id d2e1a72fcca58-6b7f0170d7bso2459531b3a.2
        for <stable@vger.kernel.org>; Fri, 17 Nov 2023 15:42:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700264544; x=1700869344; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9O1oW7KZ8SQt3HNOzuLeHyVCNivgj2SqUNZzfIRzA6s=;
        b=TZGrUnpIAVLNgxCUVIru4tliPZXd+iLhF+lztX9gseLNE2zEHv3HQvG0V8hJdVE32f
         9VMl0OA+egGWfIbQh9uvGuj47Wd/yKbEn8B27ZnRWkD0ODy9DnFqG+U/aTy2BKd3HsMq
         027ExmVp1KdrMBGOsM15/gzhnZFW/2RY3ibRz19oSIziSPWQESrY3VUfbNUlrWsogjcf
         aLyJANVgl9ztPjzHeBiTOxxv81G0GBfvbCez8OeUNkEXRee9RVbnCMhZsZmDql6QaS/2
         ZfEvjFj6wLDEQGMSHpJvKiiQEIeei94xX0/+igB7HGfQ43/8LaMGJFY/NQ8B+vj7JWge
         dodw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700264544; x=1700869344;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9O1oW7KZ8SQt3HNOzuLeHyVCNivgj2SqUNZzfIRzA6s=;
        b=dtVNWK/DSEStiX9tIie3Zq/iw2PCuupU83j4nNPIKi7SqBiDhwO/TuFfPKLAQ9Fwap
         3qYA/K6IbWWVM9REtTlCTykBjmkLL1ZdWk1kZrGRrKbrQdxIU6+XpjSQ/xHNzKXDJUDU
         hcHIyO4KQ1j/B1MVWo9Y1ChVcqZQBTE5BVBvDT5YBInNXrrt5pMImlm1rFjuXppxVIaT
         etbNvaYJ4Dj8Q7UtitpVlULKKAn6DcKTb8aPMHQjFIh/xphd7wW7Lugn20ARjxa+PiAA
         hpYQFU70cBG2UpTTBOtQQpRmRR0/8lbxPgnCOiT1dz6dk1N/FgNLRs4E2eLF9wf0Ez9y
         +SgA==
X-Gm-Message-State: AOJu0YxrlWa5l1wKb2RS8yTJY3EUldgL36gbfaLd58ISUPoEfRjth40u
        hFS1rHwjUzyEDe7wciLm9kCfnjy8G3iVcA==
X-Google-Smtp-Source: AGHT+IH+R1ZzIjPcpAEXYTVLeQXQK5QpBbV6SU0KTeaGsz8qrv3t5nNt4c95tjYyESfmBaWeVG7mxQ==
X-Received: by 2002:a05:6a00:140a:b0:6b2:6835:2a7f with SMTP id l10-20020a056a00140a00b006b268352a7fmr1058396pfu.22.1700264543986;
        Fri, 17 Nov 2023 15:42:23 -0800 (PST)
Received: from [10.10.13.50] ([136.226.64.177])
        by smtp.gmail.com with ESMTPSA id f19-20020a056a001ad300b006c64cef0c61sm1905595pfv.186.2023.11.17.15.42.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Nov 2023 15:42:23 -0800 (PST)
Message-ID: <6b2973c5-469a-4af8-995b-ee9196d0818b@gmail.com>
Date:   Fri, 17 Nov 2023 15:42:22 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 6.5 153/191] Input: xpad - add HyperX Clutch Gladiate Support
Content-Language: en-US
To:     stable@vger.kernel.org
References: <20231016084015.400031271@linuxfoundation.org>
 <20231016084018.949398466@linuxfoundation.org>
 <MW4PR84MB17804D57BB57C0E2FB66EFC6EBADA@MW4PR84MB1780.NAMPRD84.PROD.OUTLOOK.COM>
 <MW4PR84MB178083997D411DFFD45BEFCDEBB7A@MW4PR84MB1780.NAMPRD84.PROD.OUTLOOK.COM>
Cc:     "Nguyen, Max" <maxwell.nguyen@hyperx.com>, carl.ng@hp.com
From:   "Nguyen, Max" <hphyperxdev@gmail.com>
In-Reply-To: <MW4PR84MB178083997D411DFFD45BEFCDEBB7A@MW4PR84MB1780.NAMPRD84.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


> Hi,
>
> We would like to apply this patch to version 6.1 of the LTS branch.  
> This is to add a project ID for Android support for a gamepad 
> controller.  We would like it to apply sooner than waiting for the 
> next LTS branch due to project schedules.
>
> commite28a0974d749e5105d77233c0a84d35c37da047e
>
> Regards,
>
> Max
>
Hi Linux team,

We would like to have this patch backported to LTS versions 4.19, 5.4, 
5.10, and 5.15 as well.  The main purpose would to add our device ID for 
support across older android devices.  Feel free to let us know if there 
are any concerns or issues.
>
> *CAUTION: External Email *
>
> 6.5-stable review patch. If anyone has any objections, please let me know.
>
> ------------------
>
> From: Max Nguyen <maxwell.nguyen@hp.com>
>
> commit e28a0974d749e5105d77233c0a84d35c37da047e upstream.
>
> Add HyperX controller support to xpad_device and xpad_table.
>
> Suggested-by: Chris Toledanes <chris.toledanes@hp.com>
> Reviewed-by: Carl Ng <carl.ng@hp.com>
> Signed-off-by: Max Nguyen <maxwell.nguyen@hp.com>
> Reviewed-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
> Link: 
> https://lore.kernel.org/r/20230906231514.4291-1-hphyperxdev@gmail.com
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
> drivers/input/joystick/xpad.c | 2 ++
> 1 file changed, 2 insertions(+)
>
> --- a/drivers/input/joystick/xpad.c
> +++ b/drivers/input/joystick/xpad.c
> @@ -130,6 +130,7 @@ static const struct xpad_device {
> { 0x0079, 0x18d4, "GPD Win 2 X-Box Controller", 0, XTYPE_XBOX360 },
> { 0x03eb, 0xff01, "Wooting One (Legacy)", 0, XTYPE_XBOX360 },
> { 0x03eb, 0xff02, "Wooting Two (Legacy)", 0, XTYPE_XBOX360 },
> + { 0x03f0, 0x0495, "HyperX Clutch Gladiate", 0, XTYPE_XBOXONE },
> { 0x044f, 0x0f00, "Thrustmaster Wheel", 0, XTYPE_XBOX },
> { 0x044f, 0x0f03, "Thrustmaster Wheel", 0, XTYPE_XBOX },
> { 0x044f, 0x0f07, "Thrustmaster, Inc. Controller", 0, XTYPE_XBOX },
> @@ -458,6 +459,7 @@ static const struct usb_device_id xpad_t
> { USB_INTERFACE_INFO('X', 'B', 0) }, /* Xbox USB-IF not-approved class */
> XPAD_XBOX360_VENDOR(0x0079), /* GPD Win 2 controller */
> XPAD_XBOX360_VENDOR(0x03eb), /* Wooting Keyboards (Legacy) */
> + XPAD_XBOXONE_VENDOR(0x03f0), /* HP HyperX Xbox One controllers */
> XPAD_XBOX360_VENDOR(0x044f), /* Thrustmaster Xbox 360 controllers */
> XPAD_XBOX360_VENDOR(0x045e), /* Microsoft Xbox 360 controllers */
> XPAD_XBOXONE_VENDOR(0x045e), /* Microsoft Xbox One controllers */
>
