Return-Path: <stable+bounces-201021-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E1C4CBD50E
	for <lists+stable@lfdr.de>; Mon, 15 Dec 2025 11:09:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 32FF6300BED1
	for <lists+stable@lfdr.de>; Mon, 15 Dec 2025 10:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CD1232AADC;
	Mon, 15 Dec 2025 10:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QrHKRD3e";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="irfGtO4j"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E51D2459C5
	for <stable@vger.kernel.org>; Mon, 15 Dec 2025 10:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765793395; cv=none; b=gqJ0k0UGsucOdzLoebN2TTj58jdd3ThEK9WmrFhzeOCTUCxby74ZSU1eelOaKt5eZvRbT0cWg2cNnL/X3lxtI+fHm+QvApAbhSGFHuMgJ8oFSVmSThBjx64TKiqSYJwIFMIHeecwUUsZMRxTxf36cnlnpwfJVkLsOSAidUqftpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765793395; c=relaxed/simple;
	bh=OMSRFXqBtIuJb1Qi4jXiPtLsu7uqZmK1Qg6s3oVNdo0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uc1OjXcHoiJyRpWuXzDWfetsLS/AyftOS0ttpNALfOfpISHc512DWQbFfEwx0ykWRKJHq/zjVQ/mQ/m+plSII9qUitQ+Jh2wSe9QKfnD6qtQ+ZcrUvKGbp1oCO+ihm6Va2wmmwAz48CRwFARaCpRRuE8TCorCel67ZWvDHe0HjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QrHKRD3e; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=irfGtO4j; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BF8dl242576879
	for <stable@vger.kernel.org>; Mon, 15 Dec 2025 10:09:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XQ4DZ1KiE5L590veavXKBgfstDLP94A36MM1K3JZsIU=; b=QrHKRD3e4bkyf4Bl
	HQYD2hVFW+hmZegehfKomSPZFkTd+kV5h+c7qsyKDcmbhybuqYmpq0lxHH8rFe3m
	0rkpyW0Be3ZXzl8DIMmOfyQ2H82373ENt9Aqll0Q8w5hMO/YoAHLaGsIUt9gwV4u
	xlJfU7t7QXU1lnXkv50qJ/i9odvN/ddWNptdwApj4yPoAqX3vqu+ziWo3fqInzCR
	YUQwP6aQS9jNm0qVnR92f3xZNsPVjgCJrAENE9mwAwVaKyWyyfHSrOqRwse6ucwP
	BBcg2H7ZhP6vVsNYhKb/94UWABGepjsJYA74ckB8qsWbdpVhbJFTYK6Ht+JHZ2Ns
	G1xcUA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b11c6m4yg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 15 Dec 2025 10:09:53 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-29e6b269686so74092675ad.1
        for <stable@vger.kernel.org>; Mon, 15 Dec 2025 02:09:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1765793392; x=1766398192; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XQ4DZ1KiE5L590veavXKBgfstDLP94A36MM1K3JZsIU=;
        b=irfGtO4jbLj8g4605wyxgqkh88YhjMt4imtZ8oUZTjKCakYFCzNkH7IFdBlmwJ5gb4
         S4l+xncY5I8S4PFwhn630cR/DJVaRM49EQir62Z+bEkpzIUoWp0FU55WIDrUwn5QvqoL
         J+6qIxUVYxi+gaPtJwIMCjCihywgdpbkoejsrdQmbCct9ffPufY44StDZiqAITOy9Ip8
         JN3FQvfsSFK49ao4BrCTUWkp1hMrkegU0q3JaoCSoxk8Kx0APRmMuAqidr/+kqCjVOyy
         +E3jBamuE9LOQUA9IEOCvtcLujZcmHj+IC60nOktJ4h33NKljg9LfnG8XHlPq78jUvZS
         ypkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765793392; x=1766398192;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XQ4DZ1KiE5L590veavXKBgfstDLP94A36MM1K3JZsIU=;
        b=Hw4V3Uegj72oE2tSXt3AnFAouQtcNJlpOF/q2JvIeRdPeqOQ5UD8FbChUl3EZNaYHb
         ek+C9FK4Eo+foT9hgdrSx4adfcIkVRESRmeqdHE9PqY4D/Rj8AIEJmLBjRKvYE8pPtYi
         S7eAleXrCKI+UXw6w6z+S8KhXRDgoW5RyRLwuAhSiFIVOPkMpsEKxcLzd4FQX6WjCbl7
         ieOxFEu31vu2SqqLU/Bz6nAOFOszzTcCqQApLfp89uomTihvDOgngfZqRozpGb6QSwAg
         KR1ceGXpsPI3fLDnEdSTxE+mzkPqGUYuDYqw9c6JWx9y4u1SQdmk0D/m0A9kz+uE5JSZ
         Fqkg==
X-Forwarded-Encrypted: i=1; AJvYcCU+nyL1qHiGXT9GCy2WpRw2mLOB4MEUrX2SrFMz/vKZKUmfTD7s/el6SqIoIzvBNGr+KwPTcdM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+GJhSgn/zZ9gVbRmhvXihNteRF0H8dcijCVaW9VnrnKsOcaem
	vbd9kGZPUEZGZbuphu7S4Lw8l40mgXeGd99dfyQLog1IxBGvM0Nh7aYlJhvH6kwekgNATwfBRH/
	HaFgrEHqASZcPmf8yYFiV3/npoVC6ZG9nVaPmrXyFBO158bxuXJBdbchYOjCzbXS18nAVaw==
X-Gm-Gg: AY/fxX4wk9+uN4kJtSx4j4bs5Nt6mhP7CBPYP/saYEnd6ipWC79uhVRb2SXcSvPk0m5
	uHaokkE+WCGDhlwH4kWfnLV4eKuj9PMA+YfZgjwi5EkpT8PBJLHqohC9iY8QatzT+4KudnEY9JL
	a+47LlOmSrH5S26XMkbQ8Mx5UE2A3QZy6RdEk7TpCUKgrmb32UlXt11FxCBN2vmNXH6ddmVpmlL
	584PK2qlCHNDmUlN6RCrcizXqbyFz2RpuK/00ph5BUQzkAxyGe5JDGo0EF5+VI2fPSknXI1jtLm
	2errG3m80MntgoWY9T4gjNRrTiCXnoj4u25lpcU6FqH4HB50m/CTUCNDPT49sXLGGW2Q+ayMoTe
	nMZsZhby/pyLVoqxk/94C9XvkCL2rLqUiQdttYSUHy1Rd7iLfIUZDga8Log+R8FvJLCm+x51fac
	Q=
X-Received: by 2002:a17:903:2f50:b0:27e:ef96:c153 with SMTP id d9443c01a7336-29f23e6eb35mr103664115ad.19.1765793392224;
        Mon, 15 Dec 2025 02:09:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFWec5hjICjl1sGxg9VkQ5x2vkWQbWzR7eOuDA/Udz/Oy1CGb16uGqInntsurGtyzQXYw3Vgg==
X-Received: by 2002:a17:903:2f50:b0:27e:ef96:c153 with SMTP id d9443c01a7336-29f23e6eb35mr103663895ad.19.1765793391697;
        Mon, 15 Dec 2025 02:09:51 -0800 (PST)
Received: from [10.133.33.126] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29efb3657f0sm115430205ad.72.2025.12.15.02.09.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Dec 2025 02:09:51 -0800 (PST)
Message-ID: <f85c7d37-4980-46f0-9136-353a35a8f0ed@oss.qualcomm.com>
Date: Mon, 15 Dec 2025 18:09:45 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 RESEND] coresight: etm-perf: Fix reference count leak
 in etm_setup_aux
To: Leo Yan <leo.yan@arm.com>, James Clark <james.clark@linaro.org>
Cc: Ma Ke <make24@iscas.ac.cn>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, stable@vger.kernel.org,
        suzuki.poulose@arm.com, mike.leach@linaro.org,
        alexander.shishkin@linux.intel.com, mathieu.poirier@linaro.org
References: <20251215022709.17220-1-make24@iscas.ac.cn>
 <c698d581-da15-42bf-9612-62f1bad66615@linaro.org>
 <20251215095103.GA681384@e132581.arm.com>
Content-Language: en-US
From: Jie Gan <jie.gan@oss.qualcomm.com>
In-Reply-To: <20251215095103.GA681384@e132581.arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=actsXBot c=1 sm=1 tr=0 ts=693fde71 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=quK4xr9WOROKk1m0v-0A:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: 7liAV3vjF4ng61eGT8FiAm-zROWgAvTn
X-Proofpoint-GUID: 7liAV3vjF4ng61eGT8FiAm-zROWgAvTn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE1MDA4NiBTYWx0ZWRfX2zoksK2L3TCI
 dL3HMd/SQ6F5mw2E+CtSJVW8DDcG1gvyzPNvMPej7pe0L2mSUs3nIMwpxB1j8gVW149OKvyxCGT
 BxsZoNyOLcjDRQqkWEnTnETpEp4i9NGLh6KmonxS2k8xtQrJOB6ck1QBcEk7zcd9zLu0ghlUCtn
 ifBixhoVBnldzM96gy5EIGF9tyjQuTczloLMJC8SItkC3NN9WOD76xb/keZ9osrg1w5/SM9+385
 iavRpl33HBJYMQxZ2/DBJz2Bzijs65CHP8UH4zv7pPxrnM8JnRJeFe/HSZ6WsPKj5tVFipHOgsR
 lNZpFKytN/LCb7zvqeNTsN2+YgaHFZu/4TkVBKH+300pYWZ/GZbhZu1/2mHZI4WBEyoy7eAE6aU
 Nbx7qGzmes8l5zK/plBgM+vee7RD4w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-15_02,2025-12-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 priorityscore=1501 spamscore=0 phishscore=0 lowpriorityscore=0
 impostorscore=0 suspectscore=0 bulkscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512150086



On 12/15/2025 5:51 PM, Leo Yan wrote:
> On Mon, Dec 15, 2025 at 11:02:08AM +0200, James Clark wrote:
>>
>>
>> On 15/12/2025 04:27, Ma Ke wrote:
>>> In etm_setup_aux(), when a user sink is obtained via
>>> coresight_get_sink_by_id(), it increments the reference count of the
>>> sink device. However, if the sink is used in path building, the path
>>> holds a reference, but the initial reference from
>>> coresight_get_sink_by_id() is not released, causing a reference count
>>> leak. We should release the initial reference after the path is built.
>>>
>>> Found by code review.
>>>
>>> Cc: stable@vger.kernel.org
>>> Fixes: 0e6c20517596 ("coresight: etm-perf: Allow an event to use different sinks")
>>> Signed-off-by: Ma Ke <make24@iscas.ac.cn>
>>> ---
>>> Changes in v2:
>>> - modified the patch as suggestions.
>>
>> I think Leo's comment on the previous v2 is still unaddressed. But releasing
>> it in coresight_get_sink_by_id() would make it consistent with
>> coresight_find_csdev_by_fwnode() and prevent further mistakes.
> 
> The point is the coresight core layer uses coresight_grab_device() to
> increase the device's refcnt.  This is why we don't need to grab a
> device when setup AUX.

That make sense. We dont need to hold the refcnt for a while and it 
should be released immediately after locating the required device.

Thanks,
Jie

> 
>> It also leads me to see that users of coresight_find_device_by_fwnode()
>> should also release it, but only one out of two appears to.
> 
> Good finding!
> 
> Thanks,
> Leo
> 


