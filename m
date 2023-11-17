Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 391377EF7A3
	for <lists+stable@lfdr.de>; Fri, 17 Nov 2023 20:03:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231406AbjKQTD7 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 17 Nov 2023 14:03:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjKQTD6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 17 Nov 2023 14:03:58 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4A8DD6C
        for <stable@vger.kernel.org>; Fri, 17 Nov 2023 11:03:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700247834;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=X+KCXQbIarVw8dFpyS/S6NmCYqtvRHzg1KlSXBjGlMw=;
        b=XiwYQeO4fhaR3b0JA3o53rclKNdPfm9CODon0eQSnJGAawRCvj1eTeD8V8HObCC+wR4bYr
        +0HHbtpblejv8+uu86sJGHphleWocDL3sUWxS2zUm1UE03LgpEIpT3ceyTpjxR5UpA5h/I
        2RORWGmbgenFcIPAkEH23As/TeVlcBA=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-487-1UQmAKpIOXK5ED_6dN02XA-1; Fri, 17 Nov 2023 14:03:52 -0500
X-MC-Unique: 1UQmAKpIOXK5ED_6dN02XA-1
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-41cb4d6744bso27961151cf.0
        for <stable@vger.kernel.org>; Fri, 17 Nov 2023 11:03:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700247832; x=1700852632;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X+KCXQbIarVw8dFpyS/S6NmCYqtvRHzg1KlSXBjGlMw=;
        b=GbTzZD6/Ks16oQiZhjABDAbv7cF53BncN497X+Ci5BIKXYLRRTRcY70gITJgBC7scV
         Kpk69Km75+BoKVELl3+fURjfEi+IKDeKe5NQVlo7t5UIwzSK3624AaF34lPTJsIc8WIf
         VHOhow4yzMv+nZc0Nq9jau/QfJGPf+gA/i3pyrEuaUVbyshxnZkaeQxXij2Mfqx8PpOu
         2QZ6H3rDLVRozOKdpLRi0HiB9CbVYkE2C6XBzwicjZN8gS8CtXnWzKvSUcZ18h6Otsp+
         6vz+4ilBhwY+6QD7OvtCrsz6b4biNUWeX+qIYLBigwRWbF/3O81o1DgoZr54jndXtKCA
         T1Nw==
X-Gm-Message-State: AOJu0Yy3+i1PuOCkUcmiGBpiHe2TRUKpIAVI4wygJW4yQPu1ySveQo21
        8SorBcWbfaA1UBD/qY6lKtDDhoBwz6ArRfSWWjtxjOh2e6JUnEhzDZvKnru5GGyxSgMNvFZYeh5
        eusXpAV3YbIlScfKL
X-Received: by 2002:ac8:5d09:0:b0:41c:c045:3ed with SMTP id f9-20020ac85d09000000b0041cc04503edmr527679qtx.68.1700247831924;
        Fri, 17 Nov 2023 11:03:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEgrKAJm8oEake3WBQPoR8ynpL7SEnW6LA4DrAoArIRr8hwun119GSAFcqC7ATK0hCExElHWQ==
X-Received: by 2002:ac8:5d09:0:b0:41c:c045:3ed with SMTP id f9-20020ac85d09000000b0041cc04503edmr527648qtx.68.1700247831507;
        Fri, 17 Nov 2023 11:03:51 -0800 (PST)
Received: from fedora ([2600:1700:1ff0:d0e0::49])
        by smtp.gmail.com with ESMTPSA id c14-20020ac8660e000000b004198d026be6sm775588qtp.35.2023.11.17.11.03.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Nov 2023 11:03:51 -0800 (PST)
Date:   Fri, 17 Nov 2023 13:03:48 -0600
From:   Andrew Halaney <ahalaney@redhat.com>
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Lee Jones <lee@kernel.org>
Subject: Re: [PATCH 1/3] USB: dwc3: qcom: fix resource leaks on probe deferral
Message-ID: <uof6ti3ula3gfijsucp5yjp6bxldjhmyek77xub5ybifrm3g3b@d3qd4jqusvix>
References: <20231117173650.21161-1-johan+linaro@kernel.org>
 <20231117173650.21161-2-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231117173650.21161-2-johan+linaro@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Fri, Nov 17, 2023 at 06:36:48PM +0100, Johan Hovold wrote:
> The driver needs to deregister and free the newly allocated dwc3 core
> platform device on ACPI probe errors (e.g. probe deferral) and on driver
> unbind but instead it leaked those resources while erroneously dropping
> a reference to the parent platform device which is still in use.
> 
> For OF probing the driver takes a reference to the dwc3 core platform
> device which has also always been leaked.
> 
> Fix the broken ACPI tear down and make sure to drop the dwc3 core
> reference for both OF and ACPI.
> 
> Fixes: 8fd95da2cfb5 ("usb: dwc3: qcom: Release the correct resources in dwc3_qcom_remove()")
> Fixes: 2bc02355f8ba ("usb: dwc3: qcom: Add support for booting with ACPI")
> Fixes: a4333c3a6ba9 ("usb: dwc3: Add Qualcomm DWC3 glue driver")
> Cc: stable@vger.kernel.org      # 4.18
> Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> Cc: Lee Jones <lee@kernel.org>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---

I foobared the review of one of the patches listed as being fixed by
this, but for what it is worth I think this makes sense.

Hopefully my eye is better this time.

Acked-by: Andrew Halaney <ahalaney@redhat.com>

>  drivers/usb/dwc3/dwc3-qcom.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
> index 3de43df6bbe8..00c3021b43ce 100644
> --- a/drivers/usb/dwc3/dwc3-qcom.c
> +++ b/drivers/usb/dwc3/dwc3-qcom.c
> @@ -758,6 +758,7 @@ static int dwc3_qcom_of_register_core(struct platform_device *pdev)
>  	if (!qcom->dwc3) {
>  		ret = -ENODEV;
>  		dev_err(dev, "failed to get dwc3 platform device\n");
> +		of_platform_depopulate(dev);
>  	}
>  
>  node_put:
> @@ -899,7 +900,7 @@ static int dwc3_qcom_probe(struct platform_device *pdev)
>  
>  	if (ret) {
>  		dev_err(dev, "failed to register DWC3 Core, err=%d\n", ret);
> -		goto depopulate;
> +		goto clk_disable;
>  	}
>  
>  	ret = dwc3_qcom_interconnect_init(qcom);
> @@ -934,7 +935,8 @@ static int dwc3_qcom_probe(struct platform_device *pdev)
>  	if (np)
>  		of_platform_depopulate(&pdev->dev);
>  	else
> -		platform_device_put(pdev);
> +		platform_device_del(qcom->dwc3);
> +	platform_device_put(qcom->dwc3);
>  clk_disable:
>  	for (i = qcom->num_clocks - 1; i >= 0; i--) {
>  		clk_disable_unprepare(qcom->clks[i]);
> @@ -957,7 +959,8 @@ static void dwc3_qcom_remove(struct platform_device *pdev)
>  	if (np)
>  		of_platform_depopulate(&pdev->dev);
>  	else
> -		platform_device_put(pdev);
> +		platform_device_del(qcom->dwc3);
> +	platform_device_put(qcom->dwc3);
>  
>  	for (i = qcom->num_clocks - 1; i >= 0; i--) {
>  		clk_disable_unprepare(qcom->clks[i]);
> -- 
> 2.41.0
> 
> 

