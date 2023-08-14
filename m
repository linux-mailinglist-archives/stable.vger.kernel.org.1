Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8300577B2C6
	for <lists+stable@lfdr.de>; Mon, 14 Aug 2023 09:42:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234221AbjHNHmG (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 14 Aug 2023 03:42:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234334AbjHNHl6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 14 Aug 2023 03:41:58 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8966EE75
        for <stable@vger.kernel.org>; Mon, 14 Aug 2023 00:41:57 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3fea0640d88so1824925e9.2
        for <stable@vger.kernel.org>; Mon, 14 Aug 2023 00:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691998916; x=1692603716;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=BBL9irmWHTMujcW4M1YOlLfxnMuczJQ+8mOVXEk0MVk=;
        b=P1iq/wXbOo9batstDzGV9YJzd+25bRwaiWK6awDIC0BZVCTq6Ne82lsk/7vIeDXZA+
         1vDti1FRtCZExgKWGz5fFWlczEQwtema0pHr1L2vCySRLS9DIEwvoRGPs2CmakOLi0JC
         Gl5AMM894PvoEEcRkVbJfplm/NQfo/LMYT7kFUMlwFcsifvJc9bdbDqb/I1eWNA38fyu
         4wu7ZmrvPaoUMEc9o//9Pnavsn8iuX0WDtqufc2T/T3y3YBQPNddnP6yQwdGMpVpyc9N
         56ooqAUo7xmTVH1gRb0RX1AGItygrf1MvFO3w7bzVJAE4UHzAe/CZbq1t8w60wiF46g+
         v7mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691998916; x=1692603716;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BBL9irmWHTMujcW4M1YOlLfxnMuczJQ+8mOVXEk0MVk=;
        b=kK88YJQoYx3JLRvN4y6B/utlBmGpwwwrg5A52uvy7eAktPpbWX5cBlCOSWY/OYSxj2
         T+Vgn/z93utoub9L7JhFllfhvZCl2hvOiPCqmV36MgrLp1+udx1wSDGkHpB0d7d748l1
         EgMTWDMEitiiN+p6/6O9HZpnUQpmhCdfwKWaFBxS+x9RqykR+HaFb40pp4LzavekW4pk
         7Oyb+ftD6pTnx23pqJwOSagPTKohwqWbjB/XU7JGalT3zKJiFc1QC13KMt8FAogrhbV4
         g+y8l5PP9Xq6iZ+cXOi6waYRpSD5uh9s/8tbbYRA8EoGBWYgSUJprOT/gMLNx6fAUJko
         FM6A==
X-Gm-Message-State: AOJu0YwiqnGNI2jaaxdYhbH2FRTcOtzdy8i7kOI2YRI0rxPhtum7a1p6
        UZPAsR3uPTbl3CjpZvWZt5+ZnA==
X-Google-Smtp-Source: AGHT+IFIrpJ3pZKR98GY/ZQMj9zHd+SKgxbbYpqvJsQjOEPPpk3/oxMFBr9duPkiu1pVrX0yA9+2uA==
X-Received: by 2002:a7b:ce05:0:b0:3fb:ffa8:6d78 with SMTP id m5-20020a7bce05000000b003fbffa86d78mr6531169wmc.36.1691998915875;
        Mon, 14 Aug 2023 00:41:55 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:a3d8:b217:d82c:9bc0? ([2a01:e0a:982:cbb0:a3d8:b217:d82c:9bc0])
        by smtp.gmail.com with ESMTPSA id z15-20020a1c4c0f000000b003fc0505be19sm13452478wmf.37.2023.08.14.00.41.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Aug 2023 00:41:55 -0700 (PDT)
Message-ID: <4de07b08-5eda-86d7-8925-f2fadbfca407@linaro.org>
Date:   Mon, 14 Aug 2023 09:41:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v2] usb: dwc3: meson-g12a: do post init to fix broken usb
 after resumption
Content-Language: en-US
To:     Luke Lu <luke.lu@libre.computer>, linux-usb@vger.kernel.org,
        linux-amlogic@lists.infradead.org
Cc:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Da Xue <da@libre.computer>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
References: <20230809212911.18903-1-luke.lu@libre.computer>
Organization: Linaro Developer Services
In-Reply-To: <20230809212911.18903-1-luke.lu@libre.computer>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 09/08/2023 23:29, Luke Lu wrote:
> Device connected to usb otg port of GXL-based boards can not be
> recognised after resumption, doesn't recover even if disconnect and
> reconnect the device. dmesg shows it disconnects during resumption.
> 
> [   41.492911] usb 1-2: USB disconnect, device number 3
> [   41.499346] usb 1-2: unregistering device
> [   41.511939] usb 1-2: unregistering interface 1-2:1.0
> 
> Calling usb_post_init() will fix this issue, and it's tested and
> verified on libretech's aml-s905x-cc board.
> 
> Cc: stable@vger.kernel.org # v5.8+
> Fixes: c99993376f72 ("usb: dwc3: Add Amlogic G12A DWC3 glue")
> Signed-off-by: Luke Lu <luke.lu@libre.computer>
> 
> ---
> Note here, the commmit of Fixes tag is the first patch which bring
> suspend/resume function, so let's use it as the fix tag.
> 
> As commit 5b0ba0caaf3a: (usb: dwc3: meson-g12a: refactor usb init)"
> introduced the use_post_init() function, and this patch will explicitly
> depend on it, so let's set kernel version higher or equal to v5.8.
> 
> Changes since v1:
>   - add Fixes tag and Cc stable tree
> ---
>   drivers/usb/dwc3/dwc3-meson-g12a.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/usb/dwc3/dwc3-meson-g12a.c b/drivers/usb/dwc3/dwc3-meson-g12a.c
> index e99c7489dba0..2c07c038b584 100644
> --- a/drivers/usb/dwc3/dwc3-meson-g12a.c
> +++ b/drivers/usb/dwc3/dwc3-meson-g12a.c
> @@ -926,6 +926,12 @@ static int __maybe_unused dwc3_meson_g12a_resume(struct device *dev)
>   			return ret;
>   	}
>   
> +	if (priv->drvdata->usb_post_init) {
> +		ret = priv->drvdata->usb_post_init(priv);
> +		if (ret)
> +			return ret;
> +	}
> +
>   	return 0;
>   }
>   

Acked-by: Neil Armstrong <neil.armstrong@linaro.org>
