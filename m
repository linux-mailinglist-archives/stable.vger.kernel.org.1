Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B60C760027
	for <lists+stable@lfdr.de>; Mon, 24 Jul 2023 21:58:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbjGXT6q (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 24 Jul 2023 15:58:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjGXT6o (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 24 Jul 2023 15:58:44 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ECD911C
        for <stable@vger.kernel.org>; Mon, 24 Jul 2023 12:58:43 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2b93fba1f62so67994131fa.1
        for <stable@vger.kernel.org>; Mon, 24 Jul 2023 12:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690228722; x=1690833522;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=niPEUXnBamyr5cTO7f26fUfBDvy6d6X/a1Hns1HFPfc=;
        b=g8OETqHZnqXEfj3Spqark3wEuPzvnT2TvGho7e6E226GvEzM1/sVA7Cra5ywrp+uzm
         Ktu51IubVEAkyzGutXi9SIcfKHwUCTVV1/uSt7EsFCE65d6KwZH0IDUcmubIG23kB94Y
         2g/1qT8aXCGUqkzbZgHsZ0Z+gjEvJj/+TGYpwsPPu6+yDFkrtLYrH/LxTJYDAAjtxQ2u
         XkQGK6I9QUe2lIpkjQDEDRKeBVfujQHOeo9K+5dk8AppGNZQoL6ZbxG9R7WwFfbx74EO
         GrFtJZ3gBsdKb7/0FatVWLGV7rFwEJQ8wWLugkd541ISr8Ck6+HdywVYPr3RV6tPh8pf
         jyrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690228722; x=1690833522;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=niPEUXnBamyr5cTO7f26fUfBDvy6d6X/a1Hns1HFPfc=;
        b=CwHFftXjP66GKuSllfwKzSqrMZwh8rW+1P6lornF78+r+HvKj4Pi06N3X+tBfJ986p
         WStG5M6siFMgIi4IiLFc9Spjjn9RfVBzH97soz/P9OHq1W/IkyQINdjE6KFWpe9TaUE3
         3VdkInymxX3SdkQxh70nFJEzZWBqJQhaO4icWR3UdtyDCsIZ878LxQIAO7znSdtwuhiv
         q26hHWZhCgWHnOW1aOeLTe4dKtWCB1DBoR7lJrNMd3d9GsjM6vbVwZ2u/BFIWlWVb8cA
         /iTwuv78tGAlKMnA5r1p46m4zeT7shKXvidhrgwxP1VGIe0OYrYhB/1QLxOiSPg/AQqn
         bYYQ==
X-Gm-Message-State: ABy/qLbmNKWY7x21mNXUmYf45yzk48zN/ZXRu94+vklWKlUgpcLERWBq
        VuISRnX4/mh2CNmPw6rKwm0=
X-Google-Smtp-Source: APBJJlEZ1Z1oVfuOaMmfQGp5fewWOFWclC6fR2xtHwkV0ozYst5mVA4Brt1Bhe1pkvo8S5BKlcnZXw==
X-Received: by 2002:ac2:5dd2:0:b0:4f8:7781:9870 with SMTP id x18-20020ac25dd2000000b004f877819870mr5484516lfq.60.1690228721262;
        Mon, 24 Jul 2023 12:58:41 -0700 (PDT)
Received: from ?IPV6:2a02:3100:904e:4d00:8d5a:dd56:14c5:dfa5? (dynamic-2a02-3100-904e-4d00-8d5a-dd56-14c5-dfa5.310.pool.telefonica.de. [2a02:3100:904e:4d00:8d5a:dd56:14c5:dfa5])
        by smtp.googlemail.com with ESMTPSA id a23-20020aa7cf17000000b005221f0b75b7sm3443142edy.27.2023.07.24.12.58.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jul 2023 12:58:40 -0700 (PDT)
Message-ID: <e24f1b91-efd1-5398-624f-a73c0e92d677@gmail.com>
Date:   Mon, 24 Jul 2023 21:58:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] r8169: revert 2ab19de62d67 ("r8169: remove ASPM
 restrictions now that ASPM is disabled during NAPI poll")
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, kuba@kernel.org
References: <2023072337-dreamlike-rewrite-a12e@gregkh>
 <38cddf6d-f894-55a1-6275-87945b265e8b@gmail.com>
 <2023072453-saturate-atlas-2572@gregkh>
Content-Language: en-US
From:   Heiner Kallweit <hkallweit1@gmail.com>
In-Reply-To: <2023072453-saturate-atlas-2572@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 24.07.2023 19:32, Greg KH wrote:
> On Mon, Jul 24, 2023 at 05:59:07PM +0200, Heiner Kallweit wrote:
>> There have been reports that on a number of systems this change breaks
>> network connectivity. Therefore effectively revert it. Mainly affected
>> seem to be systems where BIOS denies ASPM access to OS.
>> Due to later changes we can't do a direct revert.
>>
>> Fixes: 2ab19de62d67 ("r8169: remove ASPM restrictions now that ASPM is disabled during NAPI poll")
>> Cc: stable@vger.kernel.org # v6.4.y
>> Link: https://lore.kernel.org/netdev/e47bac0d-e802-65e1-b311-6acb26d5cf10@freenet.de/T/
>> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217596
>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
>> Link: https://lore.kernel.org/r/57f13ec0-b216-d5d8-363d-5b05528ec5fb@gmail.com
>> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
>> ---
>>  drivers/net/ethernet/realtek/r8169_main.c | 27 ++++++++++++++++++++++-
>>  1 file changed, 26 insertions(+), 1 deletion(-)
>>
> 
> <formletter>
> 
> This is not the correct way to submit patches for inclusion in the
> stable kernel tree.  Please read:
>     https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
> for how to do this properly.
> 
> </formletter>

The conflict notification email mentioned the following, therefore I replied
with the backported patch. Which part is wrong or what is missing?

The patch below does not apply to the 6.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.4.y
git checkout FETCH_HEAD
git cherry-pick -x cf2ffdea0839398cb0551762af7f5efb0a6e0fea
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023072337-dreamlike-rewrite-a12e@gregkh' --subject-prefix 'PATCH 6.4.y' HEAD^..
