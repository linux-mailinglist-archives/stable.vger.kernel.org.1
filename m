Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E17078717C
	for <lists+stable@lfdr.de>; Thu, 24 Aug 2023 16:27:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241602AbjHXO0e (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 24 Aug 2023 10:26:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241671AbjHXO0S (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 24 Aug 2023 10:26:18 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D7F11BD4
        for <stable@vger.kernel.org>; Thu, 24 Aug 2023 07:26:14 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-99bf3f59905so890440366b.3
        for <stable@vger.kernel.org>; Thu, 24 Aug 2023 07:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692887172; x=1693491972;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:cc:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CCHvYEd1PfEl4rJScvMY9o8sfEv3Q8eVY9fAdWiBnmA=;
        b=As/eXROcSyXu+fSWH/H7qVtBpSQQJN6isxMM5j44wrZSBYa6LHfDimUj/jogfd7ZcZ
         xTxB8FjTzhj9Ne3i0dLm7q/sStSWUQVgOu0goxEyPd0+S3t5MkZomKtBWiW/gqmu2GSY
         FARpcuTDNK/UVl49oQ6Hhh2vMAgrme7zAMXXvXflAsXxHuz36U4XOYaqNiIx2Bb9yMFS
         aUGv8t/pO1fHIMqAOO/8oCtZTFXoe8gLdrIZexahDXhN8+iNworo8+IBf+AQ7vyOlGQ6
         8V+1o9y8+KOUMlMVg9uq9iWsVf8jWvrzhCZFwPgjGrdeJwGf/ON1SdQPs/b4ub1T87hi
         cK0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692887172; x=1693491972;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:cc:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CCHvYEd1PfEl4rJScvMY9o8sfEv3Q8eVY9fAdWiBnmA=;
        b=E+VmqNehDvpKnGBCgINxL+xe1enmqWob/mwXXN32wZu6eRAxEoJRdjGVgURp3anR0/
         tvGjhG3BvqKb/hlxxehdBtTVvQJuJmHJ4dchM/JNYesqKATew5DX5noVKs90RDXr1TVt
         XPcBwu2SQD1Cn9nPdfn6jwDwA/apy4gzFxfc2T3Jx0CzK4RstEoSfccHuJ7smGrO6+ZQ
         ntsIo3O/Mv1lpEKraMKxGYq1jBjctC/rFGTzJkmZfrDvZtqxwyRTwKYKiYsKoRNIfNqL
         cojUSYdox9PyMxTBYQHoguw1oIHhUK3X+ggcbHvmuWvEcxYNGy6ku3u3vexDcfu0wrC9
         lDgQ==
X-Gm-Message-State: AOJu0YzGZ0m3gV4wRNt5DNlajbwjQc6+MACb0gzEz7XnRfjqTxq1QwWH
        sf0D2F1ggCxuhqbmGaDhpxUDcMD97vw=
X-Google-Smtp-Source: AGHT+IGO2VikYRC4DlsrpSpgXRkYioUbIb7s+9hNv1jPiXsI697+88QczjMllcsYOI0YJfPc2aVDUA==
X-Received: by 2002:a17:907:75ed:b0:99c:4111:1881 with SMTP id jz13-20020a17090775ed00b0099c41111881mr12295915ejc.35.1692887171808;
        Thu, 24 Aug 2023 07:26:11 -0700 (PDT)
Received: from [192.168.0.28] (cable-178-148-234-71.dynamic.sbb.rs. [178.148.234.71])
        by smtp.gmail.com with ESMTPSA id i6-20020a170906698600b009928b4e3b9fsm11046373ejr.114.2023.08.24.07.26.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Aug 2023 07:26:11 -0700 (PDT)
Message-ID: <c4197112-986d-81f2-53aa-7d53086d5eb2@gmail.com>
Date:   Thu, 24 Aug 2023 16:26:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Cc:     savicaleksa83@gmail.com
Subject: Re: [PATCH v6.1] hwmon: (aquacomputer_d5next) Add selective 200ms
 delay after sending ctrl report
Content-Language: en-US
To:     stable@vger.kernel.org
References: <2023081222-chummy-aqueduct-85c2@gregkh>
 <20230824141500.1813549-1-savicaleksa83@gmail.com>
From:   Aleksa Savic <savicaleksa83@gmail.com>
In-Reply-To: <20230824141500.1813549-1-savicaleksa83@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 2023-08-24 16:15:00 GMT+02:00, Aleksa Savic wrote:
> commit 56b930dcd88c2adc261410501c402c790980bdb5 upstream.
> 
> Add a 200ms delay after sending a ctrl report to Quadro,
> Octo, D5 Next and Aquaero to give them enough time to
> process the request and save the data to memory. Otherwise,
> under heavier userspace loads where multiple sysfs entries
> are usually set in quick succession, a new ctrl report could
> be requested from the device while it's still processing the
> previous one and fail with -EPIPE. The delay is only applied
> if two ctrl report operations are near each other in time.
> 
> Reported by a user on Github [1] and tested by both of us.
> 
> [1] https://github.com/aleksamagicka/aquacomputer_d5next-hwmon/issues/82
> 
> Fixes: 752b927951ea ("hwmon: (aquacomputer_d5next) Add support for Aquacomputer Octo")
> Signed-off-by: Aleksa Savic <savicaleksa83@gmail.com>
> ---
> This is a backport of the upstream commit to v6.1. No functional
> changes, except that Aquaero support first appeared in
> v6.3, so that part of the original is not included here.
> ---

Just noticed that I left in the Aquaero mention in the commit
message, sorry for the omission... Do I need to resend?

Aleksa
