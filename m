Return-Path: <stable+bounces-198178-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E239C9E5DA
	for <lists+stable@lfdr.de>; Wed, 03 Dec 2025 10:02:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B7863347B76
	for <lists+stable@lfdr.de>; Wed,  3 Dec 2025 09:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C55582D77F6;
	Wed,  3 Dec 2025 09:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="n7T7X+pn";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TLA1OENm"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC4062BDC00
	for <stable@vger.kernel.org>; Wed,  3 Dec 2025 09:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764752455; cv=none; b=nOZAM1VXCx8D3RY0kaNQ1i92Yvu79BIZdgngx0eDhgkggeqD7ATI3N/+X3lvSY90ScDkVPlTFVM1N1EU0PIEYmX2UnQhUjnD51NVR6CGOGxtfZO5Z5dHNWzrNjfui+cnSexBrtuLTqkMpYb4uCj0FZj4lMG6lr9hIHSIDb+yaTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764752455; c=relaxed/simple;
	bh=e2W1kyT422lZsnApQ289V6vBlFIkvpuLVttKm4JWqcE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b4RagLEWUqH9F6dcIujAEFKwvVZB9Zpg0ghgDJMcmYysQHjTMwWiGyN2lkz7OLiUfGLBcpJlJeDgfW/LxrbFOcjaqRlAR9F42Kd1Rf9mxtyhuF67Db5GYfXsa+nH8njwUhMOfsFwdT51XtytkZRHsFgUTT0zW9S0XZ6W4u4wD/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=n7T7X+pn; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TLA1OENm; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B37YGLD1909983
	for <stable@vger.kernel.org>; Wed, 3 Dec 2025 09:00:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9o+5hmQIQFM/sIVASo8uRQ+mODl3UI3mwXQQ6VLH63o=; b=n7T7X+pnJwX1X3VN
	y1ZJJEIGmFRBx70zhkjo5MzRvooWhp3ei1RNYHMRUBLB015MyvVSx6FdkF6z0aXm
	ieMzZdzUQqJPYAbRjadHKj/x4phVN15lwtKANoYO/8J4XLl1Z9YfxYsj7MgeZpbY
	/JlpaBjPiYmZaB87QY3R7z8uwcasxLnv4Ohy+qR5Fml50WAyoGt/0B1R4ogicUm0
	kiXe+1oQgeZz6Wu13kmwMNl/IXEYGadwdKJc2gNy20f/NvjWwm1UEKLmz/CdomX0
	QSWXHI41Zsn8kgax8tq1XQ+qtNUE7Y7z59NBsviXnUTvD7f9wAJX+vTbt0gtfhe3
	BUVxIw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4atgx3g7v2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 03 Dec 2025 09:00:52 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-297ddb3c707so50824565ad.2
        for <stable@vger.kernel.org>; Wed, 03 Dec 2025 01:00:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1764752451; x=1765357251; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9o+5hmQIQFM/sIVASo8uRQ+mODl3UI3mwXQQ6VLH63o=;
        b=TLA1OENmiUQ631LwuyeeerNXZPaiLIr3Nt2rbNk8qfbjNI8OSTnmLZX3EHAm+1frkl
         FamN8w5BPPs0xBBkWtTRp3hTX+S2fyMQgY6heC96cyKP+0EXG73tTBhEv11v4NQDnDZR
         cyiRr8+XBCIngHaqK65Mu0hF5prYnM/6i7JLMap+pc9X6prS7CCQMa6sh43hLQAuguUe
         M/3keFAcKNWdnQwebELe0JoL8fEdZaqZfwK0ai6Wvpa2cB+WaXRYbisAvV1ETk4e4A7l
         0UKXiQd2eieVG7QZ1omTQhoUldnBeyEwZ6pmzJWekYp+HGOhGn6OM4J7pQmxJa12jF1p
         fWYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764752451; x=1765357251;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9o+5hmQIQFM/sIVASo8uRQ+mODl3UI3mwXQQ6VLH63o=;
        b=ULo9Yiv69TXH4Ns8TsffYa5k33HV0Aih1/Zo3yZnkJCZEFrZZXv68FSjTVOETCgJCZ
         q96LtcLaamVx03K8ny9YXmZ9P3b3mS+jScVmyQkwCrk4hCCeFmB7MtuHaJns52L9pZqD
         oRwv/ukyF0QK8nYODxsKAT5+gNug9Bp6Uha4B2pH6rgGUfHMthY/zS8/KS9T71aoD3CF
         nkzmN2MsdmuC9rCHIlrPI5wzYdLJc69ab2fOYw5sGaYoP+oeEtXf4zqQ027A68MbUfjG
         FMnN2TuUiIn/o+z9ro3PKVUtIgLIu6bGkReQp/kKzz9lJzOg0scIOwk7CSD7yDcFh8eF
         rsfw==
X-Forwarded-Encrypted: i=1; AJvYcCUSyeFh1N/ipx60/LcI1h5qgvkgBZEj3732R+RGGlOnitGZzh3LOhhgEDJPQAVaJ7M5vV0ibcg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwanEtK+Uz+iEVqQGzw+RPpNeMEJKuHAbx1wSAiYiuEfwG5bkGf
	WrihOQj8DUk7lC6TB90+KP8FggMFwfj+VEPuqOp95wPAX6l3pDVKwjDigKwzbkek/z0THyhMVdt
	rQtjvl7ly85kQ6AG7nHd6iRRJY6sDhukCZ3vg62i4iEEy7Ej0e/Rcc9dVqW4=
X-Gm-Gg: ASbGncvw0CnqMbeluZBzBk0Lyv26jqL7NiHMBrTqNYmsPFBpmUIyPiZGokin/AH5Yu4
	yYp4UkU269/AP8LpGjSS5eDLrTy98zCArKEHg+SAETtBczhBQqkHE35q/p0PqkEwvZwd/+iNSXX
	3fyLPOofWzlBibnyiel/Vhucp5I2FN816s0VVTPExkwuz3F42jXTFaRDn5CYzjr6nGL8F0UwONs
	D+A6mIIEkBczzWyC+IwG+eQlR0aXBSa4ObYfRyTH9jYl4UoGaq5ATEN75UVlJ7K8UESI04ijVF8
	UmM6GmJ1g8J6NH8aFK0tuLITu1FnU6FoNzYyQi1ZFfUqhOkMvQrlPe+BAFz6XHU03PKgx+2mbel
	TjmDLZ9+Mibem9rSlCPyPfGsPwAzM4q+N0k0b+2i/SiElA7QYVmKZiTIw7SFha1DD2VJbVUdjrQ
	VCpTZVCw==
X-Received: by 2002:a17:902:d586:b0:295:2c8e:8e56 with SMTP id d9443c01a7336-29d683f3ec6mr18426415ad.44.1764752451400;
        Wed, 03 Dec 2025 01:00:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH4B9P4/ChOKVOH4A1ZFkwuY6wW2UquGMcGNeJ7UjIkbYf/foEWfC18XZboOhL4IHQyYkuD2A==
X-Received: by 2002:a17:902:d586:b0:295:2c8e:8e56 with SMTP id d9443c01a7336-29d683f3ec6mr18425955ad.44.1764752450686;
        Wed, 03 Dec 2025 01:00:50 -0800 (PST)
Received: from [10.133.33.183] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29bceb4af8bsm177932185ad.81.2025.12.03.01.00.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Dec 2025 01:00:50 -0800 (PST)
Message-ID: <e11fa440-a278-4e39-adb5-244eb04ec702@oss.qualcomm.com>
Date: Wed, 3 Dec 2025 17:00:46 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rpmsg: core: fix race in driver_override_show() and use
 core helper
To: Gui-Dong Han <hanguidong02@gmail.com>, andersson@kernel.org,
        mathieu.poirier@linaro.org
Cc: linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, zhongqiu.han@oss.qualcomm.com
References: <20251202174948.12693-1-hanguidong02@gmail.com>
Content-Language: en-US
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
In-Reply-To: <20251202174948.12693-1-hanguidong02@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjAzMDA3MCBTYWx0ZWRfX11mkHukbeG3o
 NUk1+arMIJEbPKBt6K+g0PiSwHEmcOmPjnJ3OyIMTUy2rBVW2vxdaNVefI4C7flZXMKTxEEg5B7
 PprapGO8TYYh84xMrPkdMYF53JNvcsMCjOpi0cncizBNo158RHC7psNp/eQ6Ky2/w7ttu7TNNAC
 dtLuVxDDRnzlyTSAlhp5pqLJAXv+X7YFymsoCiLh467Y3SUNUkLYbBDYjcYAYBzk/d1wOOXi9/X
 rwf36UsEfVQc9XyFYkJPcRyrqQwvBGzqhyXBkoKQk+PlZaLM6QYHkhLHd12F1PLUvjZMh6N2uNu
 lv8Txv84rr4qN0goFLMd/jiyXnETfMYLWFI8LFloE7GXiKVTmqI6KQmSUnH5psRpZds3PkzsPZ5
 3hkOxNyyfuZA4FR8eZ7OuCl/BpCbgA==
X-Proofpoint-GUID: lqx5FjZonUFPswMIa-aMJ2aWsJcIfEVH
X-Proofpoint-ORIG-GUID: lqx5FjZonUFPswMIa-aMJ2aWsJcIfEVH
X-Authority-Analysis: v=2.4 cv=R/QO2NRX c=1 sm=1 tr=0 ts=692ffc44 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8
 a=YfPkN0mvrXhG1xwvAmMA:9 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-02_01,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0 adultscore=0
 phishscore=0 clxscore=1015 impostorscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512030070

On 12/3/2025 1:49 AM, Gui-Dong Han wrote:
> The driver_override_show function reads the driver_override string
> without holding the device_lock. However, the store function modifies
> and frees the string while holding the device_lock. This creates a race
> condition where the string can be freed by the store function while
> being read by the show function, leading to a use-after-free.
> 
> To fix this, replace the rpmsg_string_attr macro with explicit show and
> store functions. The new driver_override_store uses the standard
> driver_set_override helper. Since the introduction of
> driver_set_override, the comments in include/linux/rpmsg.h have stated
> that this helper must be used to set or clear driver_override, but the
> implementation was not updated until now.
> 
> Because driver_set_override modifies and frees the string while holding
> the device_lock, the new driver_override_show now correctly holds the
> device_lock during the read operation to prevent the race.
> 
> Additionally, since rpmsg_string_attr has only ever been used for
> driver_override, removing the macro simplifies the code.
> 
> Fixes: 39e47767ec9b ("rpmsg: Add driver_override device attribute for rpmsg_device")
> Cc: stable@vger.kernel.org
> Signed-off-by: Gui-Dong Han <hanguidong02@gmail.com>

Reviewed-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>

> ---
> I verified this with a stress test that continuously writes/reads the
> attribute. It triggered KASAN and leaked bytes like a0 f4 81 9f a3 ff ff
> (likely kernel pointers). Since driver_override is world-readable (0644),
> this allows unprivileged users to leak kernel pointers and bypass KASLR.
> Similar races were fixed in other buses (e.g., commits 9561475db680 and
> 91d44c1afc61). Currently, 9 of 11 buses handle this correctly; this patch
> fixes one of the remaining two.
> ---
>   drivers/rpmsg/rpmsg_core.c | 66 ++++++++++++++++----------------------
>   1 file changed, 27 insertions(+), 39 deletions(-)
> 
> diff --git a/drivers/rpmsg/rpmsg_core.c b/drivers/rpmsg/rpmsg_core.c
> index 5d661681a9b6..96964745065b 100644
> --- a/drivers/rpmsg/rpmsg_core.c
> +++ b/drivers/rpmsg/rpmsg_core.c
> @@ -352,50 +352,38 @@ field##_show(struct device *dev,					\
>   }									\
>   static DEVICE_ATTR_RO(field);
>   
> -#define rpmsg_string_attr(field, member)				\
> -static ssize_t								\
> -field##_store(struct device *dev, struct device_attribute *attr,	\
> -	      const char *buf, size_t sz)				\
> -{									\
> -	struct rpmsg_device *rpdev = to_rpmsg_device(dev);		\
> -	const char *old;						\
> -	char *new;							\
> -									\
> -	new = kstrndup(buf, sz, GFP_KERNEL);				\
> -	if (!new)							\
> -		return -ENOMEM;						\
> -	new[strcspn(new, "\n")] = '\0';					\
> -									\
> -	device_lock(dev);						\
> -	old = rpdev->member;						\
> -	if (strlen(new)) {						\
> -		rpdev->member = new;					\
> -	} else {							\
> -		kfree(new);						\
> -		rpdev->member = NULL;					\
> -	}								\
> -	device_unlock(dev);						\
> -									\
> -	kfree(old);							\
> -									\
> -	return sz;							\
> -}									\
> -static ssize_t								\
> -field##_show(struct device *dev,					\
> -	     struct device_attribute *attr, char *buf)			\
> -{									\
> -	struct rpmsg_device *rpdev = to_rpmsg_device(dev);		\
> -									\
> -	return sprintf(buf, "%s\n", rpdev->member);			\
> -}									\
> -static DEVICE_ATTR_RW(field)
> -
>   /* for more info, see Documentation/ABI/testing/sysfs-bus-rpmsg */
>   rpmsg_show_attr(name, id.name, "%s\n");
>   rpmsg_show_attr(src, src, "0x%x\n");
>   rpmsg_show_attr(dst, dst, "0x%x\n");
>   rpmsg_show_attr(announce, announce ? "true" : "false", "%s\n");
> -rpmsg_string_attr(driver_override, driver_override);
> +
> +static ssize_t driver_override_store(struct device *dev,
> +				     struct device_attribute *attr,
> +				     const char *buf, size_t count)
> +{
> +	struct rpmsg_device *rpdev = to_rpmsg_device(dev);
> +	int ret;
> +
> +	ret = driver_set_override(dev, &rpdev->driver_override, buf, count);
> +	if (ret)
> +		return ret;
> +
> +	return count;
> +}
> +
> +static ssize_t driver_override_show(struct device *dev,
> +				    struct device_attribute *attr, char *buf)
> +{
> +	struct rpmsg_device *rpdev = to_rpmsg_device(dev);
> +	ssize_t len;
> +
> +	device_lock(dev);
> +	len = sysfs_emit(buf, "%s\n", rpdev->driver_override);
> +	device_unlock(dev);
> +	return len;
> +}
> +static DEVICE_ATTR_RW(driver_override);
>   
>   static ssize_t modalias_show(struct device *dev,
>   			     struct device_attribute *attr, char *buf)


-- 
Thx and BRs,
Zhongqiu Han

