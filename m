Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 958E07D2289
	for <lists+stable@lfdr.de>; Sun, 22 Oct 2023 12:17:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231302AbjJVKRF (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 22 Oct 2023 06:17:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjJVKRE (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 22 Oct 2023 06:17:04 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4A08E6
        for <stable@vger.kernel.org>; Sun, 22 Oct 2023 03:17:02 -0700 (PDT)
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 556F13F722
        for <stable@vger.kernel.org>; Sun, 22 Oct 2023 10:17:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1697969820;
        bh=gColUGB2JSdwsFjV3ExI1Ly4vT+H+2Kv7wPXR0ErwzI=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=blaHAvsho5Zn9cui+CySfUoGsFTRF2uN2yDN7L1o68ZPcX/mQltZD6kIdAinUX8ce
         HQ5j043vM2WikfQ4kLCGKYTknq0fyVHZXJ8X5WJWTjB5dPgRtfGswKgN1GChVtyZi0
         TB1BqI0Vg97Fw1lz++ONXBjL0LDAA9WvY6adSEg7aMnDkStZ8GpCW+5zWrbZ9P4yNm
         w1oOeaTK1WQypgxbhi7ZmqVYfUi0Iv0wE9n+589NNp8Y9JRa3BMvCVEhq90t/6WVeA
         92UIsTM+T52bXb256Tflwr2MVtRKFkC8I4kYqPnzRWfouCWxchRtq9iBhPVguhL3zL
         dVsomquVbGajg==
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4083fec2c30so13368985e9.1
        for <stable@vger.kernel.org>; Sun, 22 Oct 2023 03:17:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697969817; x=1698574617;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gColUGB2JSdwsFjV3ExI1Ly4vT+H+2Kv7wPXR0ErwzI=;
        b=UdK0citI1D0rICM6wsCCHkMeE+HwAcNel2fqdS29VpqgG0lYhHzA8m5O7jFLdiTH9t
         q1kVN4L17h0Y56jBnChUghlYbShy+nSXmF22ZGQwrOyUQiUEsDb4wHNS2gEi2EufSrGn
         Qc2yNeNHZ9oqrE6r2uHyWP9MsH7Dg8MInOjNELiHRibdHVnELdjwdRrXRKiFzSqNfhXt
         cLL9Bpkbv5N4mGqjt0HEQiNok5vVQO8A0LmSKnGTeqBpxItDFccgHeB6em7LaujnPysi
         KlzvEiHyES+BdbzmepmL+MbtSaYjizt/GIq93NzyUMPiQIuGsh202X2pOEkru6zfncOq
         eCPw==
X-Gm-Message-State: AOJu0YyokbYnzQ6YAL9PGTStkyCAIvITTsSgZhJDZs7kpgUjwOOPeeUu
        kn5iEvwsbxHvcs/2RbgAfI6nQ4rp65w8X6ZjdDWqK+H73Ca8dBbqt7CVufZJsNdY2y4gotiYsXC
        a+txZQd2f8tr2GtMtv/X6qr6ukOw0s9VEzVjZ4husog==
X-Received: by 2002:a05:600c:a02:b0:405:4daa:6e3d with SMTP id z2-20020a05600c0a0200b004054daa6e3dmr4857182wmp.39.1697969817325;
        Sun, 22 Oct 2023 03:16:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHR9ajGyAKxGnJTHGXo85cKGVbITf+pxIsTZxiW6T8a2EGRQXazCWzonnmgcZkbqGRIZyg5GQ==
X-Received: by 2002:a05:600c:a02:b0:405:4daa:6e3d with SMTP id z2-20020a05600c0a0200b004054daa6e3dmr4857170wmp.39.1697969816846;
        Sun, 22 Oct 2023 03:16:56 -0700 (PDT)
Received: from [192.168.123.94] (ip-178-202-040-247.um47.pools.vodafone-ip.de. [178.202.40.247])
        by smtp.gmail.com with ESMTPSA id 1-20020a05600c028100b004077219aed5sm11287461wmk.6.2023.10.22.03.16.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Oct 2023 03:16:56 -0700 (PDT)
Message-ID: <d3afc8dc-51db-43fd-abb8-b9030d86bbe2@canonical.com>
Date:   Sun, 22 Oct 2023 12:17:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] boot fails for EFI boot stub loaded by u-boot
Content-Language: en-US, de-DE
To:     Ben Schneider <ben@bens.haus>
Cc:     Regressions <regressions@lists.linux.dev>,
        Linux Efi <linux-efi@vger.kernel.org>,
        Stable <stable@vger.kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <Nh-DzlX--3-9@bens.haus>
 <CAMj1kXFKe6piagNLdSUhxUhwLB+RfNHqjNWt8-r2CNS-rBdJKA@mail.gmail.com>
 <817366c2-33e0-4908-90ec-57c63e3eb471@canonical.com>
 <CAC_iWjJB3OTWiYX5YsJmNcPQw+rHSm955c1Z5pUajedWGM5QgA@mail.gmail.com>
 <Nh30qsF--3-9@bens.haus> <57062702-f858-46d3-bccc-f0f96891128b@canonical.com>
 <Nh8pThy--3-9@bens.haus> <NhEYpWg--3-9@bens.haus>
From:   Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <NhEYpWg--3-9@bens.haus>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 10/21/23 02:07, Ben Schneider wrote:
> Oct 20, 2023, 01:25 by ben@bens.haus:
> 
>> Oct 19, 2023, 07:21 by heinrich.schuchardt@canonical.com:
>>
>>> Compiling upstream U-Boot's qemu_arm64_defconfig yields lib/efi_loader/dtbdump.efi. If you run this instead of the kernel, you can write the device-tree as it is passed in a configuration table to the ESP.
>>>
>> I compiled and ran this fine, but I was unable to save the device tree. I suspect this is because the program searches for an ESP, and there is none on the device. U-boot was compiled with support to load directly from an ext4 filesystem so I didn't bother setting one up. I will work on it.
>>
> Hi Heinrich, I loaded dtbdump.efi from a FAT32 formatted partition with type EFI System, but attempts to run the save command return "Failed to open simple file system protocol". Sorry if there is something else I am missing.

On upstream U-Boot I cannot see this problem.

Best regards

Heinrich
