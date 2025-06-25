Return-Path: <stable+bounces-158605-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FA13AE886A
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 17:41:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42A2D1883798
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 15:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53CEF28935A;
	Wed, 25 Jun 2025 15:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="a7kjGolx"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0934286D75
	for <stable@vger.kernel.org>; Wed, 25 Jun 2025 15:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750866086; cv=none; b=stkoY4FeHFwKlNDqD51nEvOGegSVoAOajzaYGfUtxfy11+XaPtOfCSAMKZrhSb7ueDz4T38tJY8uzlXoK1AUJE3NY27L0Hzx1FIjlS6bIQhsBt3IhNX3eDBIIVqwX1rRUmfR4LXvdZ7eMIWFveMJfORyvhiJw5nA5GR6VnvkgZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750866086; c=relaxed/simple;
	bh=6McqjBxGI04s6MAVtEJ0z4GFsv1LxIRPtK/v9BEjGvk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RSNCL2JxkTcnYytX/ks918e74jJNnxJOhf9egipZ9a+przInQaQCYR4VcOEMiKy4HE/HGzd9Qdp5GDA8yrGahGVhOVcmF0PFRJlZ9KucW/Lhu44U0v2/hmZzzCz//a9X1jbbSF4JxxfeiRZSsDn5Ejn8mEz/mA+xCNjfFrcRxoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=a7kjGolx; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55PCa5qh021079
	for <stable@vger.kernel.org>; Wed, 25 Jun 2025 15:41:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	w1m7rJB50SZfSiBdwdM6cOmKzQ8rEb7FS+FQ3vsiuRg=; b=a7kjGolxeqY2aQcz
	8RMA49SUGRDB/FpbWKF+e76g09ImeRB4XHj95R+xrs9V25tSQV0gBcGahzTCjtI0
	Rm6T7If27oEr+O/IM6KYBWPIi1dinbUUQnE1gEYjK9o3xH0mFnsjlgc8mlsLnvp0
	lXDffmHGMG6jhkCF6oThaBxyOEEjht/KnXXazOF8Z6w1fY5ChbyVEe/35pI7kwRr
	EXtOUxPLrUg5h37jfqM0Xo9erKiYsVbD51hx7HaFYOC1KANYI1rmvu+PiP4MoE+1
	KVaSvK+/Iqkeh5Obl/YQ2RPU0Dvt8V0PU2S1QDaXNEKxRAdVg9kCdhSUuXFjNOkQ
	iDUeEg==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47f4b408js-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 25 Jun 2025 15:41:23 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6fabbaa1937so187906d6.0
        for <stable@vger.kernel.org>; Wed, 25 Jun 2025 08:41:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750866082; x=1751470882;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w1m7rJB50SZfSiBdwdM6cOmKzQ8rEb7FS+FQ3vsiuRg=;
        b=eFYuU/0YFR0qCJQ6TFFXRb6h/WLYNMHSkHrkH9aF6GkxlxZmCEM18hxEXb0Lbs3iIt
         ZJzRs/allkpJa02tpJge8H/UhHzNhZjkNFPczSIAVKf19vCeggCxu6fWm6Wqh7iKRv4g
         3q8MbPq83ir4wn8lKk6QshQ3EhHTt4qB+8z1XxQfSAf3FneZ08ZL2EOgteeqTCMHOqhs
         ixmFhsGnRj1KNPRQhf12eKgdPjdQuBIgtxLZNyueFnfvvkjpR1XfhIIU0KIiSot+qOYN
         ELkRbeFJgLsW55WEONkhyUaPIUB0CRZctVbkjLMJbS4Kj9zmSrmRHidOR9N/pcvlynl5
         Lx8g==
X-Forwarded-Encrypted: i=1; AJvYcCV4d9t0D5uRVI3zbiHQaYdrs/LqXGaBY9IRLoSY2B5SirV3ZUiH/UXUz6aLd870PaEyS4L51n4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yynldq/Sgl5m9CuS3/J4MjFZhIAfJdwsV5HxzPQ8Eqn6CHvWi+A
	HhP9aQXAxeaG43OPMxETxqPyGdUkeAm0yeXLwgdmDZt8IlxPNCsBNGrDoRfhnWxwhI6h+2aFMcW
	zZaPPGxzRQf4JdSCm4cl4N3qANf6N2UdXc2FfQ5lwGc1G1o8p1Ld9WV02imU=
X-Gm-Gg: ASbGnctff7xM0v2Peh82CTOHTeg9G1DXh2jOueaW+JLIheR+sUMW19/BjnHDczXOCbb
	RANxDwHt6RBp55hJiFfqRisaOv24OxHRpa20g8VtptQLtrdsvRBJabPMH+h6Lgx2px/Wcc8cUdL
	egLQP2IizKJx/NNikTiVWhj1KqAhcdfYUnKOM8dxE0Ugu8OGUKwl3zEjiZ7kwnMrrdAQubyIAtw
	H3To0K5ABGnS64Q5gMpffVfXEfJ04io0wDL8TxQJClZj0PyRoRPJKQRiOstHQFhJgXsUCyDCLmX
	00qSOvtfB7iWVzNaJaIMtvEizpb7w7t3QdunZmy1EQ6QU5ARxo3uEJfTlPXeIGJ3RfuGUhY0k9D
	wZVc=
X-Received: by 2002:a05:620a:2787:b0:7d3:8e88:dc0a with SMTP id af79cd13be357-7d42975039cmr135894885a.11.1750866082240;
        Wed, 25 Jun 2025 08:41:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEjCnP8SQUzlqdNjYZ4QmBSaiPoq0qSztYeP4vFnZ1xsmOZrCI9JTcS/JWKsTew9AG3lg8/LQ==
X-Received: by 2002:a05:620a:2787:b0:7d3:8e88:dc0a with SMTP id af79cd13be357-7d42975039cmr135893385a.11.1750866081807;
        Wed, 25 Jun 2025 08:41:21 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae053edc0f5sm1076549166b.59.2025.06.25.08.41.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Jun 2025 08:41:20 -0700 (PDT)
Message-ID: <842ed535-ed0f-43d6-9b69-b5f9aeb853d2@oss.qualcomm.com>
Date: Wed, 25 Jun 2025 17:41:18 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] usb: hub: fix detection of high tier USB3 devices
 behind suspended hubs
To: Mathias Nyman <mathias.nyman@linux.intel.com>, gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org, stern@rowland.harvard.edu, oneukum@suse.com,
        stable@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
References: <20250611112441.2267883-1-mathias.nyman@linux.intel.com>
 <acaaa928-832c-48ca-b0ea-d202d5cd3d6c@oss.qualcomm.com>
 <c8ea2d32-4e8e-49da-9d75-000d34f8e819@linux.intel.com>
 <67d4d34a-a15f-47b1-9238-d4d6792b89e5@oss.qualcomm.com>
 <c9584bc8-bb9f-41f9-af3c-b606b4e4ee06@linux.intel.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <c9584bc8-bb9f-41f9-af3c-b606b4e4ee06@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI1MDExNiBTYWx0ZWRfX7JNzCqaevEo9
 UKjQcxhMw0eEz2i3QM1JJ4IP01oyxMDu0IwgJr5WkT6pM3LgUJCDuRn+8dJeTc4Vj75xADbHw+N
 8e/dYtThQlvmX+RLf3mIiiXSqcQK0jIy++ROq2nLGdiHbMblv0Nlk6VViIqs2LyOF2MpW0Yhay2
 AcLvAN9HaWJEds9BMXBJaZtCPyeuivk02NX59i5rp2Y2PN+LWFCogP2GzPtL5nGWSZmBBjOo5q8
 3YpRFA9FHszESvQ5jtum620c/PmecSJcrCJXC+OfA17k/wX0ssVjz3W7zYlLKdSlGQmLP1pQx7t
 +MhC3PGtBc1/J0E4jY1/GitTh5qHPoarj81LNgLyWGuOOtKQPEprtepppCy7+7gMd2rSSu2xX67
 JsT8M2mKWXVo15+eOuu/euHAvTxaJTFcfkYiGScAI33vpppDNl2LW14+tATvzuDeOWG2+G6C
X-Proofpoint-ORIG-GUID: Dqo1eEY7pYoozpCvzCAdtsHvd9ZmEN9X
X-Proofpoint-GUID: Dqo1eEY7pYoozpCvzCAdtsHvd9ZmEN9X
X-Authority-Analysis: v=2.4 cv=A8BsP7WG c=1 sm=1 tr=0 ts=685c18a3 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=eEY_hVyVELhf5x2GTEsA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-25_05,2025-06-25_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 mlxlogscore=999 malwarescore=0 spamscore=0 bulkscore=0
 phishscore=0 adultscore=0 impostorscore=0 suspectscore=0 mlxscore=0
 clxscore=1015 priorityscore=1501 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506250116

On 6/25/25 5:11 PM, Mathias Nyman wrote:
> On 24.6.2025 19.40, Konrad Dybcio wrote:
>> On 6/24/25 11:47 AM, Mathias Nyman wrote:
>>> On 23.6.2025 23.31, Konrad Dybcio wrote:
>>>> On 6/11/25 1:24 PM, Mathias Nyman wrote:

[...]

> I added some memory debugging but wasn't able to trigger this.
> 
> Does this oneliner help? It's a shot in the dark.
> 
> diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
> index d41a6c239953..1cc853c428fc 100644
> --- a/drivers/usb/core/hub.c
> +++ b/drivers/usb/core/hub.c
> @@ -1418,6 +1418,7 @@ static void hub_quiesce(struct usb_hub *hub, enum hub_quiescing_type type)
>  
>     /* Stop hub_wq and related activity */
>     timer_delete_sync(&hub->irq_urb_retry);
> +    flush_delayed_work(&hub->init_work);
>     usb_kill_urb(hub->urb);
>     if (hub->has_indicators)
>         cancel_delayed_work_sync(&hub->leds);

I can't seem to trigger the bug anymore with this (and Alan's change)!

> If not, then could you add 'initcall_debug' to kernel cmd line, and usb core
> dynamic debug before suspend test
> 
> mount -t debugfs none /sys/kernel/debug
> echo 'module usbcore =p' >/sys/kernel/debug/dynamic_debug/control
> 
> Also curious about lsusb -t output

Just hubs:

[root@sc8280xp-crd ~]# lsusb -t
/:  Bus 001.Port 001: Dev 001, Class=root_hub, Driver=xhci-hcd/1p, 480M
/:  Bus 002.Port 001: Dev 001, Class=root_hub, Driver=xhci-hcd/1p, 10000M
/:  Bus 003.Port 001: Dev 001, Class=root_hub, Driver=xhci-hcd/1p, 480M
/:  Bus 004.Port 001: Dev 001, Class=root_hub, Driver=xhci-hcd/1p, 10000M

Konrad

