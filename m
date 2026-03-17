Return-Path: <stable+bounces-226907-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sOX3DQfFuWmcNQIAu9opvQ
	(envelope-from <stable+bounces-226907-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 22:17:59 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A3D442B290B
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 22:17:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9E52F306967B
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 21:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2182391503;
	Tue, 17 Mar 2026 21:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cNiJcch+";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eI80Xyfb"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DDF932E121
	for <stable@vger.kernel.org>; Tue, 17 Mar 2026 21:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773782276; cv=none; b=Tr1Ghuwyt/HuzlB7cOOafXSIns7hpnQtll6+4gp7q4L705YVJGQipuyHg8oDx8Ep4WtpyRfq5LiuX2BMqYuerxxWoLxzzaVKieNjB9oW8I+pr67cqomvXqBHtrBMJdUYar31Rc8Rwzd3ygN8XhfCvniSBfVRczFr2WSZgqaeARc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773782276; c=relaxed/simple;
	bh=G5E8gMLHI0jXAIgdFPIt0X29EOUh8FSYC6STGx61EjI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=haSxcifK+csNMARXrvvroaC49tWJGgfq0YkLLOJspspKk7AD5icw3ks9OqBjnfPpi1+0GJCkpFu1yOQNzlEoG0g+lUgo358ewW3r+Lwczn1m2op9Dy/q+1yoikrzbv2HSQ6v1r416mbGRU+SwHFllvtmU9FMNN/oa5R8GNulfXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cNiJcch+; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=eI80Xyfb; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62HIJEFq2730161
	for <stable@vger.kernel.org>; Tue, 17 Mar 2026 21:17:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Z/q9ATIVSVM4no+0kTRB9tPAmYoqjGUwM+IAHs7hi/4=; b=cNiJcch+zPsdab4z
	eOffazYrzU8osz5oImwF+Bz7avHqEY9AlQ1hB8sf7xLdI+B/0VEoB1I05ETln2in
	sqWfBRQShZKm/c2I7jcJRNhTH5sJb4NlfCwh5Yjt8SdLuF4xK631lDBcS8z1YBFN
	968t107oOq+VU+MhnHUWiSNU5WH5OgbZvocul7s0yyTuv8aW0fVuuFUp755QCnJz
	4KHZF540N+nKYNEAE8Ex03xmh7pBh7Fx9ZzzKJj0FShkJ/i7P5WJkLIR+gFlO6oe
	wJNyCbfRWM1Lx0prW2AB8znUpZY/rUoFgECmUFDiRMJjQJqHMTV+jZxqOZgDgaXh
	t6LLgQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cy8kjsmwc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 17 Mar 2026 21:17:53 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-2bdf75bc88fso5652238eec.0
        for <stable@vger.kernel.org>; Tue, 17 Mar 2026 14:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773782273; x=1774387073; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z/q9ATIVSVM4no+0kTRB9tPAmYoqjGUwM+IAHs7hi/4=;
        b=eI80XyfbbWrWPrDbtNV5Cg2CKy0djcfEanuwBS3JRjTz3sioBmmgMhlp8TIeku9eQC
         rON9sevHbWoi/Ps0eI/ki+XUMzjVSHvBltXN8fwzta0V/3GEsWwMExieowcfVVVktbHm
         CuQaTZsrKQhW6MlJAloisN9FHmWg4/sNPs9RoeXyrhhN4kKEDSKkVEJkCMhy5Bp57eC6
         OJYDRf4QyebiWFBUBHZMZtV338Ul851LbQzOjbmzA+A4AixCeU+HM1MWMzvQIIISmGr5
         nvVGtwWN7YZqDuAg7KIjNyca0D54vTqGC/AaxgbtS8MovchN5xbCY83EJRL9iJJwSg5P
         dj4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773782273; x=1774387073;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z/q9ATIVSVM4no+0kTRB9tPAmYoqjGUwM+IAHs7hi/4=;
        b=rwDQvSAkJMJtHdVRnK0lWuYbqQvyfyhoS8nlZsata05oWR/Rdt1W9c33GbQRHFhD5D
         cfispQSNg5VA6SV8N7YECqrVU3F5mHyV33VheslOq4aObNDjr6gFETKhlED950Z6mc7a
         GF462FfVWzT7LuZUvVqpe0tHB3nUlcN7zAgcd4vyhSZ5ScyGYei0W2pWka3Wxj18sWYx
         PxsZVifnKmHWOAj8KVlAw9bDXn6tYvPvkapbOkcZtFHCJqJXrfmBAd/LCuaWTMvjMfF/
         hkrVuIg0j3nDgWDDQa8XAntKvXkPCXZKSYoXAPraY7m2599eWicMbity4FjmhRVv5JNw
         R7Aw==
X-Forwarded-Encrypted: i=1; AJvYcCXRAuiguhWVlwu6ISUREq3MM3l83wmrVh5nW5NUfFC90Sa4LATfYxTr+j1ml6sa5niKQX5mc5I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGAMLK1DDVmiROpwHwATWTFsguXWChtaQ3WHjweyFDPsB/VI91
	UWczG+WEHcREk+oqToERL9iMf5v9Y9hEfW1L86jQdg8ikDWy3SDW+cLTOfto4yc54IuCDy+QYRp
	D4hMOkuRo/wFlKPziyItJfyY+Dv0DEJqQhz1N1iSTZRUrPVnkRgWdVuoDdIQ=
X-Gm-Gg: ATEYQzw+fmVQtBGOXTiAoyxN1mVTeEnZasY0XTV6Wbo/yW5OAyd9dCD2bmtg8YXtP1f
	BxZbqzxr3i3GMxDag2DKsqbEQrnUAIz59g/ZdX8EFKqdfoeJsEYvY4k9bcMYIzmdq7XZbzosLlQ
	MMv7D3mztFczM+xwGpxBlOaQHrknRGrcwKhMbPqgVhFzUJzrZq9ynWcIW5K9WdQUKRvrztJt+h3
	8eMV+pi+uSKat0r9+8WmF6qJ17dzJJchBylG8k76N8WTn2nhDzjkvN9STAnI/T7JhM/EahV3Ca/
	D5ICqRQs83RMUojFnH3Ax4P8MDVQTPPr3KzsYDjJCaymIu8BHf1A3fdpFhcOeu3XPzOZPhL+HO2
	6HnDdeqzKpiUtQrr0Cj68PxwCrFnl9PlRVXKQk8RZWbXj6C19l/wJzPYEYBI6D99fD3mn
X-Received: by 2002:a05:7301:3d12:b0:2c0:af67:e908 with SMTP id 5a478bee46e88-2c0e4fb8276mr476655eec.11.1773782272890;
        Tue, 17 Mar 2026 14:17:52 -0700 (PDT)
X-Received: by 2002:a05:7301:3d12:b0:2c0:af67:e908 with SMTP id 5a478bee46e88-2c0e4fb8276mr476635eec.11.1773782272260;
        Tue, 17 Mar 2026 14:17:52 -0700 (PDT)
Received: from [10.73.193.53] (pat_11.qualcomm.com. [192.35.156.11])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c0e55834a0sm969550eec.14.2026.03.17.14.17.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Mar 2026 14:17:51 -0700 (PDT)
Message-ID: <505ab422-f933-4674-8f93-8744d0e67c6d@oss.qualcomm.com>
Date: Tue, 17 Mar 2026 14:17:51 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] usb: offload: move device locking to callers in
 offload.c
To: Guan-Yu Lin <guanyulin@google.com>, gregkh@linuxfoundation.org,
        mathias.nyman@intel.com, perex@perex.cz, tiwai@suse.com,
        quic_wcheng@quicinc.com, broonie@kernel.org, arnd@arndb.de,
        christophe.jaillet@wanadoo.fr, xiaopei01@kylinos.cn
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sound@vger.kernel.org, stable@vger.kernel.org,
        Hailong Liu <hailong.liu@oppo.com>
References: <20260309022205.28136-1-guanyulin@google.com>
 <20260309022205.28136-2-guanyulin@google.com>
Content-Language: en-US
From: Wesley Cheng <wesley.cheng@oss.qualcomm.com>
In-Reply-To: <20260309022205.28136-2-guanyulin@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE3MDE4NyBTYWx0ZWRfXw88UjJ50Unc/
 BAghhvJZNFYlb7LqQF80X/e65Dr+aPaY0g5GeQATBNiQEE96OhdUKzP1acujbcvGpgxLPqcX6dw
 SVmnKR8A2j8+/7BzGHNlFFtZXR0DKCfJ68vwQoNeLvuTPCRPZ+D3qQIpeicd5IVBqSs3a348F6R
 uLRksbTeet/r/PVLN7TjpBhH6X2NYl70Y9fBsnMT6LpnURVabCJdFk8KO9bmXboKwnH/OaGbZ3P
 PSSVTrwHwyznarhMlgnF6wey8+4Kw+GfYQyGO6ejNp3WRCu1DQ9/VWDeMnfUgBZYO95wirf8nud
 JR4uJWEGnvrjpnIRCm//N5/osbXJEuouRQp43dmq4y4Nfh0XavkWzD0/4U2Iv+67srEEjo5Sl5Z
 gSZW3/tfKcoVTNZHdjlWm/XRXZ559ygM0M03OBm7iDfdtNKsqhDae6Yq9jW4DxggpCCBG5g49rk
 U3sioU29jlF3l1YRRVQ==
X-Authority-Analysis: v=2.4 cv=P8I3RyAu c=1 sm=1 tr=0 ts=69b9c501 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ZdW6uxA9NKXbfdqeeS2OGA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=1XWaLZrsAAAA:8 a=A2pY-5KRAAAA:8 a=NM9l3GWZ3kzQVf3-aygA:9
 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-ORIG-GUID: YqlXKH2p5uVIstKrSQpDMJORkTvWBgLo
X-Proofpoint-GUID: YqlXKH2p5uVIstKrSQpDMJORkTvWBgLo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-17_05,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1011 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 malwarescore=0 bulkscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603170187
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-226907-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[google.com,linuxfoundation.org,intel.com,perex.cz,suse.com,quicinc.com,kernel.org,arndb.de,wanadoo.fr,kylinos.cn];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wesley.cheng@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: A3D442B290B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 3/8/2026 7:22 PM, Guan-Yu Lin wrote:
> Update usb_offload_get() and usb_offload_put() to require that the
> caller holds the USB device lock. Remove the internal call to
> usb_lock_device() and add device_lock_assert() to ensure synchronization
> is handled by the caller. These functions continue to manage the
> device's power state via autoresume/autosuspend and update the
> offload_usage counter.
> 
> Additionally, decouple the xHCI sideband interrupter lifecycle from the
> offload usage counter by removing the calls to usb_offload_get() and
> usb_offload_put() from the interrupter creation and removal paths. This
> allows interrupters to be managed independently of the device's offload
> activity status.
> 
> Cc: stable@vger.kernel.org
> Fixes: ef82a4803aab ("xhci: sideband: add api to trace sideband usage")
> Signed-off-by: Guan-Yu Lin <guanyulin@google.com>
> Tested-by: Hailong Liu <hailong.liu@oppo.com>
> ---
>   drivers/usb/core/offload.c       | 34 +++++++++++---------------------
>   drivers/usb/host/xhci-sideband.c | 14 +------------
>   2 files changed, 13 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/usb/core/offload.c b/drivers/usb/core/offload.c
> index 7c699f1b8d2b..e13a4c21d61b 100644
> --- a/drivers/usb/core/offload.c
> +++ b/drivers/usb/core/offload.c
> @@ -20,6 +20,7 @@
>    * enabled on this usb_device; that is, another entity is actively handling USB
>    * transfers. This information allows the USB driver to adjust its power
>    * management policy based on offload activity.
> + * The caller must hold @udev's device lock.
>    *
>    * Return: 0 on success. A negative error code otherwise.
>    */
> @@ -27,31 +28,25 @@ int usb_offload_get(struct usb_device *udev)
>   {
>   	int ret;
>   
> -	usb_lock_device(udev);
> -	if (udev->state == USB_STATE_NOTATTACHED) {
> -		usb_unlock_device(udev);
> +	device_lock_assert(&udev->dev);
> +
> +	if (udev->state == USB_STATE_NOTATTACHED)
>   		return -ENODEV;
> -	}
>   
>   	if (udev->state == USB_STATE_SUSPENDED ||
> -		   udev->offload_at_suspend) {
> -		usb_unlock_device(udev);
> +	    udev->offload_at_suspend)
>   		return -EBUSY;
> -	}
>   

Do we really need to be explicitly checking for the usb device state before 
we touch the offload_usage count?  In the end, its a reference count that 
determines how many consumers are active for a specific interrupter, so my 
question revolves around if we need to have such strict checks.

>   	/*
>   	 * offload_usage could only be modified when the device is active, since
>   	 * it will alter the suspend flow of the device.
>   	 */
>   	ret = usb_autoresume_device(udev);
> -	if (ret < 0) {
> -		usb_unlock_device(udev);
> +	if (ret < 0)
>   		return ret;
> -	}
>   

IMO this should be handled already by the class driver, and if not, what is 
the harm?

>   	udev->offload_usage++;
>   	usb_autosuspend_device(udev);
> -	usb_unlock_device(udev);
>   
>   	return ret;
>   }
> @@ -64,6 +59,7 @@ EXPORT_SYMBOL_GPL(usb_offload_get);
>    * The inverse operation of usb_offload_get, which drops the offload_usage of
>    * a USB device. This information allows the USB driver to adjust its power
>    * management policy based on offload activity.
> + * The caller must hold @udev's device lock.
>    *
>    * Return: 0 on success. A negative error code otherwise.
>    */
> @@ -71,33 +67,27 @@ int usb_offload_put(struct usb_device *udev)
>   {
>   	int ret;
>   
> -	usb_lock_device(udev);
> -	if (udev->state == USB_STATE_NOTATTACHED) {
> -		usb_unlock_device(udev);
> +	device_lock_assert(&udev->dev);
> +
> +	if (udev->state == USB_STATE_NOTATTACHED)
>   		return -ENODEV;
> -	}
>   
>   	if (udev->state == USB_STATE_SUSPENDED ||
> -		   udev->offload_at_suspend) {
> -		usb_unlock_device(udev);
> +	    udev->offload_at_suspend)
>   		return -EBUSY;
> -	}
>   

During your testing, did you ever run into any unbalanced counter issues 
due to the above early exit conditions?

I guess these are all just questions to see if we can remove the need to 
lock the udev mutex, and move to a local mutex for the offload framework. 
That would address the locking concerns being brought up by Greg, etc...

Thanks
Wesley Cheng

>   	/*
>   	 * offload_usage could only be modified when the device is active, since
>   	 * it will alter the suspend flow of the device.
>   	 */
>   	ret = usb_autoresume_device(udev);
> -	if (ret < 0) {
> -		usb_unlock_device(udev);
> +	if (ret < 0)
>   		return ret;
> -	}
>   
>   	/* Drop the count when it wasn't 0, ignore the operation otherwise. */
>   	if (udev->offload_usage)
>   		udev->offload_usage--;
>   	usb_autosuspend_device(udev);
> -	usb_unlock_device(udev);
>   
>   	return ret;
>   }
> diff --git a/drivers/usb/host/xhci-sideband.c b/drivers/usb/host/xhci-sideband.c
> index 2bd77255032b..6fc0ad658d66 100644
> --- a/drivers/usb/host/xhci-sideband.c
> +++ b/drivers/usb/host/xhci-sideband.c
> @@ -93,8 +93,6 @@ __xhci_sideband_remove_endpoint(struct xhci_sideband *sb, struct xhci_virt_ep *e
>   static void
>   __xhci_sideband_remove_interrupter(struct xhci_sideband *sb)
>   {
> -	struct usb_device *udev;
> -
>   	lockdep_assert_held(&sb->mutex);
>   
>   	if (!sb->ir)
> @@ -102,10 +100,6 @@ __xhci_sideband_remove_interrupter(struct xhci_sideband *sb)
>   
>   	xhci_remove_secondary_interrupter(xhci_to_hcd(sb->xhci), sb->ir);
>   	sb->ir = NULL;
> -	udev = sb->vdev->udev;
> -
> -	if (udev->state != USB_STATE_NOTATTACHED)
> -		usb_offload_put(udev);
>   }
>   
>   /* sideband api functions */
> @@ -328,9 +322,6 @@ int
>   xhci_sideband_create_interrupter(struct xhci_sideband *sb, int num_seg,
>   				 bool ip_autoclear, u32 imod_interval, int intr_num)
>   {
> -	int ret = 0;
> -	struct usb_device *udev;
> -
>   	if (!sb || !sb->xhci)
>   		return -ENODEV;
>   
> @@ -348,12 +339,9 @@ xhci_sideband_create_interrupter(struct xhci_sideband *sb, int num_seg,
>   	if (!sb->ir)
>   		return -ENOMEM;
>   
> -	udev = sb->vdev->udev;
> -	ret = usb_offload_get(udev);
> -
>   	sb->ir->ip_autoclear = ip_autoclear;
>   
> -	return ret;
> +	return 0;
>   }
>   EXPORT_SYMBOL_GPL(xhci_sideband_create_interrupter);
>   


