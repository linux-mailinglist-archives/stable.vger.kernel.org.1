Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D91397E513E
	for <lists+stable@lfdr.de>; Wed,  8 Nov 2023 08:40:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235204AbjKHHky (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 8 Nov 2023 02:40:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235198AbjKHHkx (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 8 Nov 2023 02:40:53 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8E95AF
        for <stable@vger.kernel.org>; Tue,  7 Nov 2023 23:40:50 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-5440f25dcc7so8919198a12.0
        for <stable@vger.kernel.org>; Tue, 07 Nov 2023 23:40:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699429249; x=1700034049; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2lkiZdWgmRWFfGNffoKo4M/Hwx+l7mjg/N7m923EUjw=;
        b=mvaLBvb+K1hCPrIJqLuB8xs+iZIhMq56S1SlyDSivPkt862SgS4Tx+09QrGrB6yJ7x
         Iq1Hg6cRXMT+iOSmeKKPP2ey074pEQmI/mgdJC9S7WUzqV1kqaCRrQrUODagCiaYKV0C
         0s9Zf9VJ+CLp0zzc3XtySo/m6SsS5Sa4UtQO4W4Bn9Eo8PKVszMl/IJUYfkVY1LOz7Rp
         FEzyDAkhDYfKAdIevCM0DDnbJ3aMIqYuJCUBtOwxaZneUWBpyhtbnsZwui1O8mnhQDAy
         6YQyn2XrlAErCrriUue0XUdMMkD/tMwrJXI3lUgEeomsoLZOEBEc541S/m0cwX7NVvx/
         1Cfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699429249; x=1700034049;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2lkiZdWgmRWFfGNffoKo4M/Hwx+l7mjg/N7m923EUjw=;
        b=WKAeLruIncRhUOOujB04l0Z5Oeg+Tn06XY6kPe3UTYpcD3YK5iRS04athpPMTruNeb
         XF9y/lZO5KBHUJjq/s+WDR91LDVfI93uglCObsMKe+44Vx9iDNvAot0iCiNsMCChHRjV
         o7jhVW1YN302Wl15s+BhcYqzoMbH85RlDbaOogJwO7P0CuA8rWdev+b7mG0Rbzrr+Aoh
         ZGdQrtFvNjdFIIi1uWuQw1oXcPVqIA2k6gF41yUJ4ng1GLbhqhUl7gCQAzp2g9pFvKVe
         dh0KBnBOpFIF1N8ZTHqHtGDlFq7Tih4gNebFL8wRVTQY8CT8E0WFs3E/+Pa9diDMeGxH
         MXXg==
X-Gm-Message-State: AOJu0YxbIf55SCAcCSVr/CVwlIYoCA+/MiPa1e7rmcU4ia/7CEaxG0CE
        UVS1dADuBQSudryI4ZZlTxej2CtN468=
X-Google-Smtp-Source: AGHT+IHUI++8Ml5IvltjXJxqBZQ7Dn9AocE6M02frZ1M9yKxnxNZjupKWLMoj3/lq+XdPYRi0l/4lQ==
X-Received: by 2002:a17:906:dc92:b0:9ae:420e:739b with SMTP id cs18-20020a170906dc9200b009ae420e739bmr567104ejc.46.1699429248305;
        Tue, 07 Nov 2023 23:40:48 -0800 (PST)
Received: from ?IPV6:2a01:c23:c56e:b200:75f2:d482:5d42:c8a0? (dynamic-2a01-0c23-c56e-b200-75f2-d482-5d42-c8a0.c23.pool.telefonica.de. [2a01:c23:c56e:b200:75f2:d482:5d42:c8a0])
        by smtp.googlemail.com with ESMTPSA id l10-20020a170906078a00b009b95787eb6dsm602950ejc.48.2023.11.07.23.40.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Nov 2023 23:40:47 -0800 (PST)
Message-ID: <9a5ba6df-5d15-4c23-98cd-686b1f62e05b@gmail.com>
Date:   Wed, 8 Nov 2023 08:40:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] r8169: fix ASPM-related issues on a number of systems
 with NIC version from RTL8168h
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
        mario.limonciello@amd.com, yifan1.zhang@amd.com,
        stable@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
        Li Ma <li.ma@amd.com>
References: <20231108033359.3948216-1-li.ma@amd.com>
 <2023110845-factual-dawn-7d68@gregkh>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <2023110845-factual-dawn-7d68@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 08.11.2023 08:05, Greg KH wrote:
> On Wed, Nov 08, 2023 at 11:34:00AM +0800, Li Ma wrote:
>> From: Heiner Kallweit <hkallweit1@gmail.com>
>>
>> This effectively reverts 4b5f82f6aaef. On a number of systems ASPM L1
>> causes tx timeouts with RTL8168h, see referenced bug report.
>>
>> Fixes: 4b5f82f6aaef ("r8169: enable ASPM L1/L1.1 from RTL8168h")
>> Cc: stable@vger.kernel.org
>> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217814
>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
>> Signed-off-by: David S. Miller <davem@davemloft.net>
>> (cherry picked from commit 90ca51e8c654699b672ba61aeaa418dfb3252e5e)
>> ---
>>  drivers/net/ethernet/realtek/r8169_main.c | 4 ----
>>  1 file changed, 4 deletions(-)
> 
> Is this a proposed stable tree patch?  If so, what kernel(s) are you
> wanting it applied to?
> 
This should have been sent neither to you nor stable@vger.kernel.org.
This patch has been applied to stable already, the mail is something
AMD-internal it seems.

> thanks,
> 
> greg k-h

Heiner

