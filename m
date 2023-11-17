Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A6437EF7B1
	for <lists+stable@lfdr.de>; Fri, 17 Nov 2023 20:09:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231475AbjKQTJ5 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 17 Nov 2023 14:09:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjKQTJ4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 17 Nov 2023 14:09:56 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBA25C5
        for <stable@vger.kernel.org>; Fri, 17 Nov 2023 11:09:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700248192;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hpxsXLMOh5JybuE462HK7tCO92oncuL8g+hgD8Ou5d8=;
        b=DtRo4upey3e21f36LrrZ2lD9D17Ul/H+fN7+gjyW1lrcdQgKr6hPhY7JE65VD5iHKoHZYi
        EwNsSdRbW6wl4RR5HhEs3dnDTgyZJ3/qyYKJ9epjfWp2ch7PSApNQ7QOyzhbaTapzRqwrp
        jsTwPew1EjxdbhnoZ1uWN26LwqzjXbI=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-449-KzEXv4VyOVCfaoDspJWqWw-1; Fri, 17 Nov 2023 14:09:50 -0500
X-MC-Unique: KzEXv4VyOVCfaoDspJWqWw-1
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-421ace48f00so24801521cf.2
        for <stable@vger.kernel.org>; Fri, 17 Nov 2023 11:09:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700248190; x=1700852990;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hpxsXLMOh5JybuE462HK7tCO92oncuL8g+hgD8Ou5d8=;
        b=VPLYNAcDJ3/WQ5fHgHDfin5bDjpfYDd0o1x8eDWos3nZAz5jEvwzk60PfbS29rvfpE
         VvLzDDTxFHLenGhB0WYBRu2bP0TZZ0dIdGTb2fKWlMBIsVDVza4PSx/DWTKskjltOTAT
         fFeqpRJVxj3dK/qYoReBlSQFhmV/w6kbtguyI2NhPrr3Dnf8c3oT0LfxnS1wbUyZw9XY
         nyryCh3ko6Y5EugdW6tWACFh73mg3bxIlNr23Pkimv8ckb1cErnhpY2qz3+wIV3k5gF+
         9JhbbzlflbUqNu3W2BFMK6q/OXpfHPn0397C5QkrOhuYyfnKWG6wuKuqJXLVrXq1XOKQ
         S03Q==
X-Gm-Message-State: AOJu0YwsucKgGwvyU2F0phxs/kRwuoVIWi3huLt8N0lp18GUg8rUDfAh
        gcLjqXV3zkJ13huQdDAhnV7bcc2DvwaQfm+xfg1Zt3CkX7UD4SOqO/mzFVMo7N25nmwOIs1KrsB
        huL3KuSGLfiFTuY8m
X-Received: by 2002:ac8:5c09:0:b0:403:eb5b:1f6 with SMTP id i9-20020ac85c09000000b00403eb5b01f6mr624110qti.63.1700248190190;
        Fri, 17 Nov 2023 11:09:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFlvdvwGKHUH6kh6AfHGMsjzT8Ii5VyQWe+IyIfRxw35V00JsB0JULxo2khiOl3sAAFk7zK0w==
X-Received: by 2002:ac8:5c09:0:b0:403:eb5b:1f6 with SMTP id i9-20020ac85c09000000b00403eb5b01f6mr624087qti.63.1700248189946;
        Fri, 17 Nov 2023 11:09:49 -0800 (PST)
Received: from fedora ([2600:1700:1ff0:d0e0::49])
        by smtp.gmail.com with ESMTPSA id x8-20020ac87a88000000b00419cb97418bsm776100qtr.15.2023.11.17.11.09.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Nov 2023 11:09:49 -0800 (PST)
Date:   Fri, 17 Nov 2023 13:09:47 -0600
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
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH 2/3] USB: dwc3: qcom: fix software node leak on probe
 errors
Message-ID: <lufc4csmbtkx2plvwxce32tofon76x6jmk4tbwjkwqqffukrka@pygyjtb2kiv5>
References: <20231117173650.21161-1-johan+linaro@kernel.org>
 <20231117173650.21161-3-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231117173650.21161-3-johan+linaro@kernel.org>
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

On Fri, Nov 17, 2023 at 06:36:49PM +0100, Johan Hovold wrote:
> Make sure to remove the software node also on (ACPI) probe errors to
> avoid leaking the underlying resources.
> 
> Note that the software node is only used for ACPI probe so the driver
> unbind tear down is updated to match probe.
> 
> Fixes: 8dc6e6dd1bee ("usb: dwc3: qcom: Constify the software node")
> Cc: stable@vger.kernel.org      # 5.12
> Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>

Acked-by: Andrew Halaney <ahalaney@redhat.com>

> ---
>  drivers/usb/dwc3/dwc3-qcom.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
> index 00c3021b43ce..0703f9b85cda 100644
> --- a/drivers/usb/dwc3/dwc3-qcom.c
> +++ b/drivers/usb/dwc3/dwc3-qcom.c
> @@ -932,10 +932,12 @@ static int dwc3_qcom_probe(struct platform_device *pdev)
>  interconnect_exit:
>  	dwc3_qcom_interconnect_exit(qcom);
>  depopulate:
> -	if (np)
> +	if (np) {
>  		of_platform_depopulate(&pdev->dev);
> -	else
> +	} else {
> +		device_remove_software_node(&qcom->dwc3->dev);
>  		platform_device_del(qcom->dwc3);
> +	}
>  	platform_device_put(qcom->dwc3);
>  clk_disable:
>  	for (i = qcom->num_clocks - 1; i >= 0; i--) {
> @@ -955,11 +957,12 @@ static void dwc3_qcom_remove(struct platform_device *pdev)
>  	struct device *dev = &pdev->dev;
>  	int i;
>  
> -	device_remove_software_node(&qcom->dwc3->dev);
> -	if (np)
> +	if (np) {
>  		of_platform_depopulate(&pdev->dev);
> -	else
> +	} else {
> +		device_remove_software_node(&qcom->dwc3->dev);
>  		platform_device_del(qcom->dwc3);
> +	}
>  	platform_device_put(qcom->dwc3);
>  
>  	for (i = qcom->num_clocks - 1; i >= 0; i--) {
> -- 
> 2.41.0
> 
> 

