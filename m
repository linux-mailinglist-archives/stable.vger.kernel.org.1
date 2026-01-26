Return-Path: <stable+bounces-211624-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QFmRAo12d2n7ggEAu9opvQ
	(envelope-from <stable+bounces-211624-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 15:13:33 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 71596895A2
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 15:13:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 133DD301B165
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 14:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B058033D4E4;
	Mon, 26 Jan 2026 14:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="k779G+EK";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="B1MqDmSj"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46FC033C539
	for <stable@vger.kernel.org>; Mon, 26 Jan 2026 14:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769436808; cv=none; b=JnMWitHIadIRbWIthmCAxiRX5gQNiPaf1ANyhBifI1boOHJvb/MvK0OUDhbDDxfAX/geI+TiZIcwIbMybYurJPeR8xIpz29ICFKB/l8efuJMk8N8p5c0nBn+3THTffUhpzWaFBniX9WbQ9qvg/fp40rOCFz2f+RbLObKpf4HYdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769436808; c=relaxed/simple;
	bh=6geHjh/9hsSjWD6hE4Xd1wl22nHSGXv5yRtGUwWnh20=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ukVogGqv7P7AQwvcPSdItKMEoU6WujM5CuWr226q0hn+dNP43YUSLHAfhHa+W1m5heRb2UfNEsejjHHsRVB35q9TkdNivQ3PAcwizjqJtgN/vX7br4ORYXjS1WIYgEqa/bVWB7e+u8NEqxOdkHUZt+FhiOXMMcNb1R0EaEjz11k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=k779G+EK; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=B1MqDmSj; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60Q81pFs368462
	for <stable@vger.kernel.org>; Mon, 26 Jan 2026 14:13:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=iEaVzMwy7Oz22VXJ+dYjmA5L
	8/T6Ef+Gyyl/6dzhQsc=; b=k779G+EKbuXwpcMQX+GBw+0C8VCmwJmvmlR8t7MI
	T9NzdjvWEOYmmQsABTnzMDWuANVZ5AqYuA9+duSWmSSDTGochI0L8ocsrtaok2my
	WEPWJcODNJOdkQDaV03zMBBedSblGqSCPJGYJSHbDMjRVy0zdIKCrov/FMPBLDdh
	vl9xJa9ZHcDewITo92lOE1SwNfYd2imJh/ysv+Ow6PiV/AIMrSJxQOSA0SwH9As9
	2/4IDYImCR9UCsNfP95TsAQzFRGsIgodSnSog3NyESUrI7mKG7zHu8dTY09E87CC
	Zn6MNV/2gOn2Wp65LsMSpwEIkxiu2e+WYtqzMXpON6y58w==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bvq9f4q9h-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 26 Jan 2026 14:13:26 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8c52fd47227so751695685a.2
        for <stable@vger.kernel.org>; Mon, 26 Jan 2026 06:13:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769436805; x=1770041605; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iEaVzMwy7Oz22VXJ+dYjmA5L8/T6Ef+Gyyl/6dzhQsc=;
        b=B1MqDmSjCiAtj+vpxwEPicWBAf4Cu44aVvt5wRAxqICPHpSL394q/D2/PpPFaFCbLB
         HHqhlaFrKAMoe0O0JenFN8i1yvDnxTsejz8U4cvGGuoYxb5AEEWiwOZ1dWePp+UxrN63
         DsQYjuApjW4mMdiyIlSUGYQ/HVJ1Ggp7bz/TpgRXl72fwtp7hbB88NLDJj6+uRET4QYH
         /Gd1oDmknhgUF+FsPqXsu+f1mj1vWWenKERVm1tjeUxI+y1SACfsSU8qJsXLmHoUvurv
         c5ixJ2W6lT9m9ieBSKtMi57ag2aHUlzLIttIKknU/Qu2oL4RgXm0GZ8bFsgw4V31KSis
         F1wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769436805; x=1770041605;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iEaVzMwy7Oz22VXJ+dYjmA5L8/T6Ef+Gyyl/6dzhQsc=;
        b=LTRAol2WbhA9L9BF8sAz5tmwUIzthUBG5oU0m3NhouBeUCNz+NM/MjiqIxRlBc8lwc
         VVySDYMC0GbzsLX7dzdNr9baxpVfgZnbvbl8CWE2hBadz21LC0Cfzn2/9tQ1goyV7cvC
         S1nnHY7xNDRaAtgJWYGiLKEHebf+BCRCgEWmMFJS1c4o1qV/po5wasRZW459E50Qqt6F
         0ElDjbXaWvsBWCgqjk8qVH0L8/2wPSTxHkyEXbGw7l2gTXUE669HybrujFETAplviepB
         eoBP3YlTKKVAS9lLD7SdkxKD0xwveEJbXxAtSb3ji8AYkheVgqRZ7MUXEEOyHxdGU+qY
         yexg==
X-Forwarded-Encrypted: i=1; AJvYcCW9hnrJLb0k36muPhdBHT6GCtdD3FPiblAjYtjx9Zx0vrtkf1bmZCAh6TCJ5Gm5DwXQ2sgClfo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpsGgjtLAentFl45f0R/FuxIKAX7ePAvwoND/svvAD0YdD/s2R
	v8zErx/i4D7NEoha/wprOpY58FDqmeO5tSHpONzYa3tno6I9VEj2idDajyXXnCpKp0vXnMG+2bY
	rnZGkabWbEBllPpagDuOyS8zhbTv3WQM4nAevicXRbTw1v/oYo6ECi7UiGEQ=
X-Gm-Gg: AZuq6aJWbEieo0xjdfLcnNN2adGb4SCBTR+0l4fpMzLigYrrHzpHl0Iz99bTquJvzbj
	4a8ufx0VLLcyiXwyfo+KEPvdJmAK9Xr3hIHwzlRPws39ulord2kl/THEuSHJCWCYr3zV3wxm5EF
	duKlu3MCGAG1WB+pm9e6LwAR2WpOJDaWv/3iaUtG0pOM4RW89iEFK2o9P4oNsXJuM+p1fO7RDce
	4CuZLhXfb0HmJqHzGKs76co6XFx1TyDv6XqfzydjbmIDVvOHVKLWaS8cvjg7SCG+LrsORIMpZeB
	It1W/tASG68/8+s5/cvTEl6pA9a7xy2rMtzPoTqSqbzL1eT5aGA2bE4ezaKM+3GdbqbQRz3aM6N
	t2uM3zg+1SFlFlULMYAWe4Ido
X-Received: by 2002:a05:620a:6914:b0:8c6:3c47:74cb with SMTP id af79cd13be357-8c6f963b964mr543323085a.49.1769436805321;
        Mon, 26 Jan 2026 06:13:25 -0800 (PST)
X-Received: by 2002:a05:620a:6914:b0:8c6:3c47:74cb with SMTP id af79cd13be357-8c6f963b964mr543317485a.49.1769436804661;
        Mon, 26 Jan 2026 06:13:24 -0800 (PST)
Received: from oss.qualcomm.com ([86.121.162.109])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435b1f7c8efsm30888230f8f.42.2026.01.26.06.13.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 06:13:23 -0800 (PST)
Date: Mon, 26 Jan 2026 16:13:22 +0200
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Linus Walleij <linusw@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abel Vesa <abelvesa@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH] pinctrl: lpass-lpi: implement .get_direction() for the
 GPIO driver
Message-ID: <njjcltt5zzjzcoucjrbrhyzrqkwdcck25gpnoabx3uoiep3lw3@xctftuapxdai>
References: <20260126135627.34191-1-bartosz.golaszewski@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260126135627.34191-1-bartosz.golaszewski@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=YLGSCBGx c=1 sm=1 tr=0 ts=69777686 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=oauzzCmhM186DRC0Y2yWPg==:17
 a=kj9zAlcOel0A:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=jvEoDTpiSnUK1vfo43gA:9 a=CjuIK1q_8ugA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: 5yNjYbP8LjHvqzsW3KiIFHq7WT6DWxhi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI2MDEyMSBTYWx0ZWRfXzJ6rQ3A9cxDp
 CH6Eiwjxj+9OKlEOUpR4m8X9hP2HvTvX2RoFazCYiT3vNkZiKU4BqNuoyVWeo/v+hVoFddiL65M
 7qT+OZOrxj5GuLUV3RbPisfv2Za4c2DshOYIntWhh+HZm4XeEf+MHh6enoaiwzuMppYDALdCTZt
 jr/y+s4WT/Nsxe1xFwdYAyWeriX2oKfDP7DHMZKl7H2HZkjjqVfv/7sO2QsqcnzanzJQEdSqWIw
 3POeHfVSxnkH0w5B5vRmY7XFKIAON0a2j1kNQpiPcXy/62OKBbzxyKVsDts5HdKN9gy24jJNtm4
 o7AJRz41f5EOwroTy63ApGF2Ga5pV4xB6ZAXfVX3tl0uPvoqkpOCiM+Qw1DlyFtR3KTO2Yg4Tpj
 nYc5OxCDrlxvE9bO0u3V1wPuCYspG5iyGAUIOAHVfIYnQqYPY5BpGEPiWqXPEjeeUk83rwIxB/V
 7U/+gU8wa5eSVfAvLdA==
X-Proofpoint-ORIG-GUID: 5yNjYbP8LjHvqzsW3KiIFHq7WT6DWxhi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-26_03,2026-01-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 lowpriorityscore=0
 clxscore=1015 impostorscore=0 phishscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601260121
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-211624-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oss.qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[abel.vesa@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 71596895A2
X-Rspamd-Action: no action

On 26-01-26 14:56:27, Bartosz Golaszewski wrote:
> GPIO controller driver should typically implement the .get_direction()
> callback as GPIOLIB internals may try to use it to determine the state
> of a pin. Add it for the LPASS LPI driver.
> 
> Reported-by: Abel Vesa <abelvesa@kernel.org>
> Cc: stable@vger.kernel.org
> Fixes: 6e261d1090d6 ("pinctrl: qcom: Add sm8250 lpass lpi pinctrl driver")
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

Tested on Dell XPS13 9345 (x1e80100).

Tested-by: Abel Vesa <abel.vesa@oss.qualcomm.com>

