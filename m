Return-Path: <stable+bounces-67675-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB30D951ECA
	for <lists+stable@lfdr.de>; Wed, 14 Aug 2024 17:42:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBB2E1C2147D
	for <lists+stable@lfdr.de>; Wed, 14 Aug 2024 15:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D51D51B5801;
	Wed, 14 Aug 2024 15:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="BMcMUG39"
X-Original-To: stable@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D741B3F20;
	Wed, 14 Aug 2024 15:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723650122; cv=none; b=dKC/S3FF04ExQEOQmEBYZhHBHWcYJ38gzrNiVjmJE72L/vuq+Ox1WT1hjCIChOusZ2Xv6TL8xZ5FFousRyoN18s5mlNxfsJ9qAkwQLP0NoF65S0J1PrNuTW1HvAa8jqOR6gMA7XQQglpA6oWI3HUT7edHfkz9vq4E7bBWrYp5hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723650122; c=relaxed/simple;
	bh=MjnTildxpAbHNkgPDPWLipmp28QBUWJrUm+Kw3OHJHM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=JwwfiahSiAWuWOD2O2OkssIncNP9LpmaTw0e/GsVHeV3NGMMU7CEj9dwxg6CeK4bitj65xw3tSMaZ53DqGrW9YfUZm6GNBnrI5zF3hmmb7KS+sztR4N6QLSqcQ5aEIQ2BZPS4ITH6CohC6qWjKR8gYobb4dJRqIalEh44SwQvkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=BMcMUG39; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47EFES7o004014;
	Wed, 14 Aug 2024 17:41:25 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	/ISX9nWWuQJU87xnhrjQ6QeMAsmctnZJm1c7Gl4Q0hw=; b=BMcMUG39HgKxS7uG
	hzu1sw2eA2f7UEbbFJZZVJtRG/MC2Cwr3JnUb1EVN2ti+u72yeMuHQcY3Ppu7FbX
	bRZYJ+XkyfyGuSqyzsx4zlgEKdFovXQ+bAmvaslsSpJvW1W4cKcIs477IrylZdGp
	UB+BCgWvFzlElUFoVkQWVkJAD30IIGdsRN0tSfyvbld9dW3oOPDZQpQH2phDFP+4
	YN+lacM75ZeEypdH0ouGK+jNpZf5yPLtywwnsHe/uqyaGLrdPJpzRMQ1Hnhr2X7r
	ae3TCun6YBfvP+1xm87RsR6fT2B+++cfCC0AOHJNX7FzqBGGXSTQ2VNsfdJwezPK
	hrnI3w==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 410y2402yw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Aug 2024 17:41:25 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id A13CD4002D;
	Wed, 14 Aug 2024 17:41:20 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 5B7B227DDE4;
	Wed, 14 Aug 2024 17:40:40 +0200 (CEST)
Received: from [10.48.87.62] (10.48.87.62) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Wed, 14 Aug
 2024 17:40:39 +0200
Message-ID: <119de711-3234-4efa-b311-290ce9fa5c4e@foss.st.com>
Date: Wed, 14 Aug 2024 17:40:39 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] usb: dwc3: st: add missing depopulate in probe error
 path
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Thinh Nguyen
	<Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@ti.com>, Peter Griffin <peter.griffin@linaro.org>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Lee Jones <lee@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <stable@vger.kernel.org>
References: <20240814093957.37940-1-krzysztof.kozlowski@linaro.org>
 <20240814093957.37940-2-krzysztof.kozlowski@linaro.org>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20240814093957.37940-2-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-14_11,2024-08-13_02,2024-05-17_01



On 8/14/24 11:39, Krzysztof Kozlowski wrote:
> Depopulate device in probe error paths to fix leak of children
> resources.
> 
> Fixes: f83fca0707c6 ("usb: dwc3: add ST dwc3 glue layer to manage dwc3 HC")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Context of my other cleanup patches (separate series to be sent soon)
> will depend on this.
> ---
>  drivers/usb/dwc3/dwc3-st.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/dwc3/dwc3-st.c b/drivers/usb/dwc3/dwc3-st.c
> index a9cb04043f08..c8c7cd0c1796 100644
> --- a/drivers/usb/dwc3/dwc3-st.c
> +++ b/drivers/usb/dwc3/dwc3-st.c
> @@ -266,7 +266,7 @@ static int st_dwc3_probe(struct platform_device *pdev)
>  	if (!child_pdev) {
>  		dev_err(dev, "failed to find dwc3 core device\n");
>  		ret = -ENODEV;
> -		goto err_node_put;
> +		goto depopulate;
>  	}
>  
>  	dwc3_data->dr_mode = usb_get_dr_mode(&child_pdev->dev);
> @@ -282,6 +282,7 @@ static int st_dwc3_probe(struct platform_device *pdev)
>  	ret = st_dwc3_drd_init(dwc3_data);
>  	if (ret) {
>  		dev_err(dev, "drd initialisation failed\n");
> +		of_platform_depopulate(dev);
>  		goto undo_softreset;
>  	}
>  
> @@ -291,6 +292,8 @@ static int st_dwc3_probe(struct platform_device *pdev)
>  	platform_set_drvdata(pdev, dwc3_data);
>  	return 0;
>  
> +depopulate:
> +	of_platform_depopulate(dev);
>  err_node_put:
>  	of_node_put(child);
>  undo_softreset:

Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

Thanks
Patrice

