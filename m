Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB2DC7CD7B4
	for <lists+stable@lfdr.de>; Wed, 18 Oct 2023 11:17:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbjJRJRw (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 18 Oct 2023 05:17:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbjJRJRu (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 18 Oct 2023 05:17:50 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 179BF106
        for <stable@vger.kernel.org>; Wed, 18 Oct 2023 02:17:45 -0700 (PDT)
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 194D83FA5B
        for <stable@vger.kernel.org>; Wed, 18 Oct 2023 09:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1697620663;
        bh=qiSPUE4lltvCtn5SLG3vKziLbxmxWqFtKHW2HMAswqk=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=q5UTNrVecSU5Bvrc2Oxe5KujV+oGuJB+FE3TjKVhWt+IAKmLoAJepHfgeyIZEOEFB
         BmYXUXUOw6HF+pwEiGLD5qmxptXr9DUHdEVaPFwNAwysP+5VfEFLGD5SzUHkgwIYRz
         cN8SSTDY+JUHN+erJLxwW+/kZ1rXkqhDvJS5gs2wkPPTSaa1YKVcMuaBfJ0F5nhJ9o
         LYDBZkh5mX3Ms5+JjKiUmOYehvN+jO7khkS8H2hsWxFtIlM6xRCd9ZkUj4xhUVWq3g
         clXM/OewVKVJHzAl0LXC0uIc8jR3OdyfSaL3IVq7MtMTPIg5+gZVsqyaO5RV4OvNyM
         G2/Sk61OkmQdA==
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4083c9b426fso2589045e9.2
        for <stable@vger.kernel.org>; Wed, 18 Oct 2023 02:17:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697620662; x=1698225462;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qiSPUE4lltvCtn5SLG3vKziLbxmxWqFtKHW2HMAswqk=;
        b=XJQDD74kAegt5izPVFMREA8inHsEPKtSw4iVsBia2f+wiKV0cBGHLoNwsqAhug/69k
         VBuUiNARIt34ufHVR3KEi7XungDcHyQQbZAa6GPgHGRCVmaY3RHoKrkY65/K0oNAgmAh
         vafmA2EVtvLCTxleS8USygYArGpo6+G9glRMWngK8x81R+ixtxJnrTUEAEeb0fodH76s
         3X7piw4n9MvpHzaqenegTEfHgFnEDeGk11eRy/u6rcrT4RpMWAd1/0VMd2+QLDF9FDIX
         /q+cIo8eJ4FojAuIpD04dk3QmCacqwd8ILtma5cTYPeIlMC9tPfYQkx+tvGFHeMJiTIU
         a/rw==
X-Gm-Message-State: AOJu0YyQKZKVTwytMXaYorDR4RUHImhVBc9KKbVllZM8T0ZuOKk+Iofn
        l1Ejc/d1iFPmQXFzchvhhIkzxLXmhASF28Dd1mobx4inmPPp2BkpOnEN4BLUcMs3+WzCOXMXp8Y
        lh4fN94D+FxiIc0M4JksiPPiVr9KcKbWbng==
X-Received: by 2002:a05:600c:4754:b0:405:359a:c965 with SMTP id w20-20020a05600c475400b00405359ac965mr3658625wmo.4.1697620662476;
        Wed, 18 Oct 2023 02:17:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHF4/5CTl7f9O/lUmT8j/5SH4dJRwUt7GqFCJNVeh6EIJ0xbtMMhP4HVtXfqGfuLkQSFM3yQQ==
X-Received: by 2002:a05:600c:4754:b0:405:359a:c965 with SMTP id w20-20020a05600c475400b00405359ac965mr3658609wmo.4.1697620662033;
        Wed, 18 Oct 2023 02:17:42 -0700 (PDT)
Received: from [192.168.123.94] (ip-178-202-040-247.um47.pools.vodafone-ip.de. [178.202.40.247])
        by smtp.gmail.com with ESMTPSA id b12-20020a05600c150c00b0040586360a36sm1128985wmg.17.2023.10.18.02.17.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Oct 2023 02:17:41 -0700 (PDT)
Message-ID: <817366c2-33e0-4908-90ec-57c63e3eb471@canonical.com>
Date:   Wed, 18 Oct 2023 11:17:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] boot fails for EFI boot stub loaded by u-boot
Content-Language: en-US, de-DE
To:     Ben Schneider <ben@bens.haus>
Cc:     Regressions <regressions@lists.linux.dev>,
        Linux Efi <linux-efi@vger.kernel.org>,
        Stable <stable@vger.kernel.org>, Ard Biesheuvel <ardb@kernel.org>
References: <Nh-DzlX--3-9@bens.haus>
 <CAMj1kXFKe6piagNLdSUhxUhwLB+RfNHqjNWt8-r2CNS-rBdJKA@mail.gmail.com>
From:   Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CAMj1kXFKe6piagNLdSUhxUhwLB+RfNHqjNWt8-r2CNS-rBdJKA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 10/18/23 10:34, Ard Biesheuvel wrote:
> (cc Heinrich)
> 
> Hello Ben,
> 
> Thanks for the report.
> 
> On Wed, 18 Oct 2023 at 03:19, Ben Schneider <ben@bens.haus> wrote:
>>
>> Hi Ard,
>>
>> I have an ESPRESSObin Ultra (aarch64) that uses U-Boot as its bootloader. It shipped from the manufacturer with with v5.10, and I've been trying to upgrade. U-Boot supports booting Image directly via EFI (https://u-boot.readthedocs.io/en/latest/usage/cmd/bootefi.html), and I have been using it that way to successfully boot the system up to and including v6.0.19. However, v6.1 and v6.5 kernels fail to boot.
>>
>> When booting successfully, the following messages are displayed:
>>
>> EFI stub: Booting Linux Kernel...EFI stub: ERROR: FIRMWARE BUG: efi_loaded_image_t::image_base has bogus value
>> EFI stub: ERROR: FIRMWARE BUG: kernel image not aligned on 64k boundary
>> EFI stub: Using DTB from configuration table
>> EFI stub: ERROR: Failed to install memreserve config table!
>> EFI stub: Exiting boot services...
>> [    0.000000] Booting Linux on physical CPU 0x0000000000 [0x410fd034]
>>
>> I suspect many of the above error messages are simply attributable to using U-Boot to load an EFI stub and can be safely ignored given that the system boots and runs fine.

These messages are not typical for launching a kernel via the EFI stub 
from U-Boot. It should look like this:

=> load mmc 0:1 $fdt_addr_r boot/dtb
28846 bytes read in 6 ms (4.6 MiB/s)
=> load mmc 0:1 $kernel_addr_r boot/vmlinuz
53686664 bytes read in 2223 ms (23 MiB/s)
=> setenv bootargs root=/dev/mmcblk0p1 efi=debug earlyprintk 
initrd=boot/initrd.img
=> bootefi $kernel_addr_r $fdt_addr_r
Card did not respond to voltage select! : -110
Failed to load EFI variables
Booting /boot\vmlinuz
EFI stub: Booting Linux Kernel...
EFI stub: EFI_RNG_PROTOCOL unavailable
EFI stub: Loaded initrd from command line option
EFI stub: Using DTB from configuration table
EFI stub: Exiting boot services...
[    0.000000] Booting Linux on physical CPU 0x0000000000 [0x410fd034]

>>
> 
> I suspect that these are not as harmless as you think. How old is the
> u-boot build on this platform?
> 
>> When boot fails (v6.5), the following messages are displayed:
>>
>> EFI stub: Booting Linux Kernel...
>> EFI stub: ERROR: FIRMWARE BUG: efi_loaded_image_t::image_base has bogus value
>> EFI stub: ERROR: FIRMWARE BUG: kernel image not aligned on 64k boundary
>> EFI stub: ERROR: Failed to install memreserve config table!
>> EFI stub: Using DTB from configuration table
>> EFI stub: Exiting boot services...
>> EFI stub: ERROR: Unable to construct new device tree.
>> EFI stub: ERROR: Failed to update FDT and exit boot services
>>
>> In case it's relevant, the device tree for this device is arch/arm64/boot/marvell/armada-3720-espressobin-ultra.dts
>>
> 
> This is a uboot path, right? Not a linux path? Are you sure this DTS
> is compatible with the v6.5 kernel?

There is no arch/arm64/ in U-Boot. Maybe 
arch/arm64/boot/dts/marvell/armada-3720-espressobin-ultra.dts?

Best regards

Heinrich

> 
>> Hopefully I've reported this in the correct place or that the information provided is sufficient to get it where it needs to be. Let me know if there is additional information I can provide. I am also able to use the device to test.
>>
> 
> Please add some efi_warn() message inside the update_fdt() routine in
> drivers/firmware/efi/libstub/fdt.c to narrow down which call is
> causing it to return an error. Nothing in that code jumps out to me,
> but we regularly update libfdt in the kernel as well, so it might be a
> change in there that triggers this.

