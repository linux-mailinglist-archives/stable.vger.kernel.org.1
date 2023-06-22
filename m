Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB2F273A1F1
	for <lists+stable@lfdr.de>; Thu, 22 Jun 2023 15:37:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbjFVNhY (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 22 Jun 2023 09:37:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbjFVNhY (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 22 Jun 2023 09:37:24 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD39E1996
        for <stable@vger.kernel.org>; Thu, 22 Jun 2023 06:37:22 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-98cd280cf94so214158466b.1
        for <stable@vger.kernel.org>; Thu, 22 Jun 2023 06:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1687441041; x=1690033041;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pHIa7KLb5FChUHw6+UlwK0hSQUCSJKaQ9+jMazq1pQA=;
        b=vziUmvgIWhFicw7wqFdZusxgf8A85TsG3qTNgohJev4SPnNKlI4HbvaW5wcLyb2ajr
         QhgkbLM3hFcBA1Q/Cp2EROrrx43Se/3/yQR3P44S9ukqFGhmx1BAttoj5YrvEMM6AA+S
         w5gQCt6aEs5YA89oDmB6A7UiXeVBswE87/rU0AeM2Xa0DYXB/K0/YJBBB+PzjGZsvs1V
         lwwvb48BrfQHNm0aZbLTnmDDdOl8EGJ+KVX9kqD92Ejd9OQdfIH7KUT2SyQFdSE6Q0Kd
         llDDos8RmLKOrn9sRny5WXyaFT/ftEYiPvf15cK6z7TUFRgfHqodrBtHDSvlZQNNwQrY
         eKiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687441041; x=1690033041;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pHIa7KLb5FChUHw6+UlwK0hSQUCSJKaQ9+jMazq1pQA=;
        b=flCv2BCoM/OgyxOV/lagtqdD3Sxk+4X6czyJHiWD9/qNcM/klCIjG7l+tX5k593dsH
         dnxlLh5jV5JKAh/xBBjDdV/EZTTHZ5ZT4HNAtEa3WDoq9qrl1HAGVjnM0sQ/6MzeBrXo
         go/nw4ay5GYqhs5vy8QEhrZ9GRBeGoJJ9L8nxxYOlrefBDGjcZ68K6WO/yJQqAt6Eumb
         WadgAO3/Vp/0P+kkpfG/5aUQX1m/z4CmNo2hyY6Nls+6/lLu+8cKflk5kPDy+lGSokOm
         mD0qv2AEP6K8LAbjI/vJw4Waa7dHLLcsGEHrHLVJy1kgFTFV4KCm0NDjcfZYi9p5Zh9M
         O54w==
X-Gm-Message-State: AC+VfDxSpOrfmIb7EvGcrJ5I5m9aV9syQ3QBFO5jyWMbrkxbuc3S1oXp
        FTqtwoJLk46dXFwY/i1Ws5d/4w==
X-Google-Smtp-Source: ACHHUZ4Xwei94QDrtoLTs4Uowi9CJrZpVNEPXmXh2H9RHI5qvT+e1L1lz7PUCF+BjX0m+Ro3gPGMGw==
X-Received: by 2002:a17:907:e8b:b0:988:9b29:5647 with SMTP id ho11-20020a1709070e8b00b009889b295647mr10088056ejc.77.1687441041263;
        Thu, 22 Jun 2023 06:37:21 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:c154:8b90:b6a7:cb1d? ([2a02:578:8593:1200:c154:8b90:b6a7:cb1d])
        by smtp.gmail.com with ESMTPSA id g13-20020a170906348d00b0098654d3c270sm4630450ejb.52.2023.06.22.06.37.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jun 2023 06:37:21 -0700 (PDT)
Message-ID: <b094480a-a050-c4c6-3213-31fe1912e36b@tessares.net>
Date:   Thu, 22 Jun 2023 15:37:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: FAILED: patch "[PATCH] selftests: mptcp: join: helpers to skip
 tests" failed to apply to 5.15-stable tree
Content-Language: en-GB
To:     gregkh@linuxfoundation.org, kuba@kernel.org
Cc:     stable@vger.kernel.org
References: <2023062227-sporting-calcium-8268@gregkh>
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <2023062227-sporting-calcium-8268@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi Greg,

On 22/06/2023 09:59, gregkh@linuxfoundation.org wrote:
> 
> The patch below does not apply to the 5.15-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.

(...)

> ------------------ original commit in Linus's tree ------------------
> 
> From cdb50525345cf5a8359ee391032ef606a7826f08 Mon Sep 17 00:00:00 2001
> From: Matthieu Baerts <matthieu.baerts@tessares.net>
> Date: Sat, 10 Jun 2023 18:11:38 +0200
> Subject: [PATCH] selftests: mptcp: join: helpers to skip tests
> 
> Selftests are supposed to run on any kernels, including the old ones not
> supporting all MPTCP features.
> 
> Here are some helpers that will be used to mark subtests as skipped if a
> feature is not supported. Marking as a fix for the commit introducing
> this selftest to help with the backports.
> 
> While at it, also check if kallsyms feature is available as it will also
> be used in the following commits to check if MPTCP features are
> available before starting a test.

Thank you for this notification (and all the other ones and the
backports linked to this series)! And sorry for all these conflicts :)

We don't need to backport this commit cdb50525345c ("selftests: mptcp:
join: helpers to skip tests"): it depends on a feature introduced in
commit c7d49c033de0 ("selftests: mptcp: join: alt. to exec specific
tests") and we don't want to backport this. Also, this fix here is
mainly useful for the last stable version: I guess people will likely
not take the selftests version from v5.15.y and run them on older
kernels. They will more likely take the selftests from the last stable
version (or the same version as the kernel one).

So no need to do anything here.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
