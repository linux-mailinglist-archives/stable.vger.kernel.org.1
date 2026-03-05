Return-Path: <stable+bounces-223193-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MIvqCb1oqWlN6wAAu9opvQ
	(envelope-from <stable+bounces-223193-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 05 Mar 2026 12:27:57 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 96E16210918
	for <lists+stable@lfdr.de>; Thu, 05 Mar 2026 12:27:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 475DF30D36CA
	for <lists+stable@lfdr.de>; Thu,  5 Mar 2026 11:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7701B38553F;
	Thu,  5 Mar 2026 11:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="h212qy8V";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="e5helCi1"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D2F23D7E3
	for <stable@vger.kernel.org>; Thu,  5 Mar 2026 11:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772709994; cv=none; b=aI48SjwAtzIfq+RDJnF+3ZOTD6Rb636avXg4u9DljVLkvakvV9KlwKRP3VRtNReBRjKLfqUPcB7bwg+lWB9b4N5at58KrRTCHy5F5rbFeWoMNFrGSGIHWzO1wXgN1/rYFpkoGdb6L9CggP3Rp8T/nuNXEVfFSLvrQHUyPKPdiCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772709994; c=relaxed/simple;
	bh=dr5emGJraYIs4xJ8NQwD5jkh+vFN9+JErA9PMS3i2jQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CJ1kJiRfVhw6hVCpNkUn4+zeOUy7BtXQtJDVO3zI9zZGS3LOc45QM7mPUfW5OvEM78XI2n8rVIuj05Mnp9ypKX1b/0056RmyjbE+M/+P9+gDCqg09mgkBKH0/h1mA8/qTNJiHrXZv5vtU16Q6IqVYr8TBqzKKlqLYZSuN3Ui8ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=h212qy8V; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=e5helCi1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 625AFfuR2922564
	for <stable@vger.kernel.org>; Thu, 5 Mar 2026 11:26:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ikL2asIb5828chxodoMfcJf85JaQ/u87oXZeJV+vIe8=; b=h212qy8VEayL2FfF
	DM311BINSYf072iMHaoQK+kaw8sMsj0hY7VJer0qnuRwOmrPqoKz7XBsn6tNgX8P
	rUnKMUURYXK7YOvGKmF3uEekav15ZylqgcEsxMPxt08wKU648sCI4a3jpwcxCy+W
	NQ33rRZ+GOtBEahFE0aQ4tKAy3fd8PpqdQvsU5uXZEpSY1C2yKAxKOTnXclrE9Uc
	wM+IBIi1NopaajlSCDWtCCbnEUdXLV+Jayhdi8negVaK3INR2dI3I15hd55yoiGH
	z4+3MV1/nZry2YI0BtfJsWJ+86Pwaogr+DeTVu9a/Zf01s/JDrgYRmpo2vMFdGaw
	716AAw==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cq2q81cjx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 05 Mar 2026 11:26:31 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-89a012f8ab7so26024086d6.2
        for <stable@vger.kernel.org>; Thu, 05 Mar 2026 03:26:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772709990; x=1773314790; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ikL2asIb5828chxodoMfcJf85JaQ/u87oXZeJV+vIe8=;
        b=e5helCi1LScTWPlU86ZxSsdIJGu3hi3/0ztkd374Xx3g1NO9Wq0GvvLUYRzjx07tAj
         n4Ne1vIonLcHOUQQ80Z4HL+Lhc+uWr7vuXhvaRHD+e2/bwigw09Stl8px+m/eutF83/h
         LIZoJwnZ7e5l8k8Hzy+kZLDLVFldhTcfHYHpDY0GPBQI4RN9jelf7PIGD02Fofj0EjKo
         Gh9Y8tvH7w3uNQHfbym5bZuTA2CxJXEW8+m0aFu/fFzMdI4cWN5a5ZYcFBWPsZTrKeNV
         z5ltEXKOWA+bYVMwZsXD1Uv3ATG98xn9lqy7oqf9E4Ogo1NjuBPH9EZpXFDP4VOQYg2i
         Rl5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772709990; x=1773314790;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ikL2asIb5828chxodoMfcJf85JaQ/u87oXZeJV+vIe8=;
        b=lb40N9dtbQTbVNm+/dfbZpdaRbOBZsuBGiihPSQgnEsmfOY6jvkojWnWNtBlLi8fU+
         xu+flTG5ymRTkwhwdU/7XcGOADPChr0LbgJ/cE6St6lBMsNvwKcJ67XSRaeYxGSsSefS
         tOaYmmJzKG/7zf9Ul5HTPFjbe8hpMcsp558us0hNycgV+PCD1iB/7n9kE0kMX5vskanw
         hPy1TucQK3HKkPd6/XLA7D+/6PJHqsBwaK0E2OINS3f/xUizL0Uqx6AJxEabHsF6NwZM
         SGZus6ma+sKDbInJe2Pw8YORxozk/bn8Rtck5MDnHbSQS+sb8aR3UGwRQpB80wwmhTHb
         ejaw==
X-Forwarded-Encrypted: i=1; AJvYcCULsqWWnDLSk5IZPgDa36bLP8imR+L3KGdC856r6dY+tEefWqkCfMNT5nLwxvwTbgf+3TMXNhg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvWXiPdvrdrHiBKqxAsSX4bvTt7iMvbspQ1AoqhDMzvB8nYBOR
	1FFbiIIGzcvc4q4j09VJqFx23OiSSCT1iW/dbyNwgW1vlI2Zv6FudhPIHbjcqgFGNx6cdS1pnZV
	edWwYQsYPAofm6iLr3lswMZWxk7z7Olfh2ZKz9u4y9ZZ/DPFfBeH7/zzs9RU=
X-Gm-Gg: ATEYQzx6hKlWv4ZaWSDVxW45tEb4GvfukDBD+96o2/cxqMO1k79XKaTh+GwxvKJwbs7
	U/a34U63bb0OEdDdTwPwhgeLNhKfVO094SFEBbLJL2Nd8K2s/wbllFxTvVLW68joNwysi5laAN1
	ogYQJ9nTESirslpQfRnrdOn/ZNdTMPMMK9Mp7bUG3OwQ8WvaSyozOZ9ob4M6MziqvQuvQq+Wq5t
	heA3nfV260d5W5iHB5dxFRijCw/raIdb4rQPVV1h2wpJ5qS0vm/X/L/b0C6NRiK11b8jGzgBDcp
	W4ksdeQytsATUwhUJoX3KCJ07EbjzGBGHlxZjr2zOvwMBoOl6KlVXTzjr3QNNFJBsVugY2SNxBZ
	Je4cKMTFu/ruoMRZWIkqUDBlZQngywebh+nvwEVVvjxCh2uxmCL4oAjDcFm0nXoNnmOaFjaVWEc
	U5dME=
X-Received: by 2002:a05:6214:4e15:b0:89a:150a:233a with SMTP id 6a1803df08f44-89a1998b7femr52277836d6.2.1772709990192;
        Thu, 05 Mar 2026 03:26:30 -0800 (PST)
X-Received: by 2002:a05:6214:4e15:b0:89a:150a:233a with SMTP id 6a1803df08f44-89a1998b7femr52277326d6.2.1772709988918;
        Thu, 05 Mar 2026 03:26:28 -0800 (PST)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b940d35aa45sm80322466b.16.2026.03.05.03.26.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Mar 2026 03:26:28 -0800 (PST)
Message-ID: <7416ac06-0af8-44b7-8987-a9990f30e6a9@oss.qualcomm.com>
Date: Thu, 5 Mar 2026 12:26:25 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] phy: qcom: edp: Add per-version LDO configuration
 callback
To: Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
        Vinod Koul <vkoul@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260302-edp_phy-v3-0-ca8888d793b0@oss.qualcomm.com>
 <20260302-edp_phy-v3-2-ca8888d793b0@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260302-edp_phy-v3-2-ca8888d793b0@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 5nd5ByoBpcZZVLWIwnNlVm6-D7ziYdsO
X-Proofpoint-ORIG-GUID: 5nd5ByoBpcZZVLWIwnNlVm6-D7ziYdsO
X-Authority-Analysis: v=2.4 cv=GecaXAXL c=1 sm=1 tr=0 ts=69a96867 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=82J-8U3TcAj4iTVDHMYA:9 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA1MDA5MyBTYWx0ZWRfX3a1GMpLGSeke
 lHyQXNbCp7TOSHFcfSEExxRTQMxqrgi0TBSJWAPR3KZWhu7mDqttLXhfe/FdzOqpFrHbiWMQNRE
 zUfv9LWoYUgomQS8/2vYXuvLhhOzXQdQ92HwvS9glFhGiiWvgEEJUP98QEyyQve+7X+QvwToRjV
 nOvyLZl2UykIzMoD/lWbRsKtzOUymNv17REdk3rHlL9Ei5fAd21c0CaGZm4QpxjA/pOzFez/mqj
 BAiTh4HwvtOnA48ND8sLTZxQGtJuZ84eiH0WW8KhYc3bp/rpWLjm16AknVEZlV33shwIC1vmMN9
 rhUrNzPSxqiDhJ6jfGj2gqkZzM3stRe4tYvRpWMY8ix45wt3PYTVYUSs/xqWctXSJQAT6jLWIhW
 uKgq+j9dj/gLJfdmp0Ic47I71KmrLD7fYs+CKrUOEv47rZiMZOA2Bz/sZv/CDzv6c61lSyWjHEY
 NRuxI7BVwLL3V/iXo7Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-05_04,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 impostorscore=0 spamscore=0 suspectscore=0
 clxscore=1015 lowpriorityscore=0 adultscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603050093
X-Rspamd-Queue-Id: 96E16210918
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-223193-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FROM_NEQ_ENVFROM(0.00)[konrad.dybcio@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

On 3/2/26 9:28 AM, Yongxing Mou wrote:
> For eDP low Vdiff, the LDO setting depends on the PHY version, instead of
> being a simple 0x0 or 0x01. Introduce the com_ldo_config callback to
> correct LDO setting accroding to the HPG.
> 
> Since SC7280 uses different LDO settings than SA8775P/SC8280XP, introduce
> qcom_edp_phy_ops_v3 to keep the LDO setting correct.
> 
> Cc: stable@vger.kernel.org
> Fixes: f199223cb490 ("phy: qcom: Introduce new eDP PHY driver")
> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Tested-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com> # SC8280XP X13s

Konrad

