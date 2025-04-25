Return-Path: <stable+bounces-136731-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31554A9CF24
	for <lists+stable@lfdr.de>; Fri, 25 Apr 2025 19:09:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED2DC7AAAF3
	for <lists+stable@lfdr.de>; Fri, 25 Apr 2025 17:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BECBF1DE3C1;
	Fri, 25 Apr 2025 17:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WPr3/3SK"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A5791A23A0
	for <stable@vger.kernel.org>; Fri, 25 Apr 2025 17:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745600965; cv=none; b=ig6ZETBUlzUHobUbCkCQEXcCrvtz0Wx8pFsomkN4OgEsGDUdaPC7Ed41h3oXc98UUtVqIMeWcSdV0z7cc5sMRxXIEMzjYzFxP6dFXh8q7UfWJs3f02F/GBkJLQwcQgWld5Jmb1jAc+0QwiWchyFEFnYcDbEycw+p7Ed67YCQ+Ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745600965; c=relaxed/simple;
	bh=YBKs1OJeY57nKYNeChCZ589xtIUrmsli3AvxXg0AEc8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LtqNSSh4NDSj3vQj7qPDG6NNOCqXtIrUsReGDfyONb1F5e2nGm1t0E4PHI/3qJ5gjyEpMwLLum8Z7k4KwHvczKl2hCDwUFdD5EHMCfZXJmE9Fo+RmFCTs4UoLiJbi7SUSJf/jfLa6nyrAhG+UKRgAUlA7D2Iz949Jx8M+0rF51Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WPr3/3SK; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53PGJr9I011043
	for <stable@vger.kernel.org>; Fri, 25 Apr 2025 17:09:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	SNLXvLbbpTqBFTNrbbCRYuJ3NMrzd7CEVCz/JN/Qj1I=; b=WPr3/3SKmQO5tUCH
	DZrcVmn391fGOy14p3URxwSckn/7VjQ0fCGkhHKsAg6xLfF/6IHj/imbEpYMyr6F
	1rc2fWeJVXlar2PeuQ//ms531J6YkWPSQ7H0CJxrGbYWOIQfmeOYTHdn8OO/lVmr
	xL3bvr/hngqYKkzc94dj/qtCuiHDNPwSohFe3gGonRdyDHgnwjy6VE8s6MfRkIaA
	DQWL4l8Ge0s1gAktx2rJmX3C3lAR44WcY9R2ZrXmlOCg+8bnjlm4t5xODQQtXL6D
	J4O2BEvD5TKK39AvoRt8UiWm1DiTUv36mxybf5Usy0LF6uk5ZO2hgH1J3cq/bCkC
	+3BhDQ==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 466jh0hx6j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 25 Apr 2025 17:09:23 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-afd1e7f52f7so1621149a12.1
        for <stable@vger.kernel.org>; Fri, 25 Apr 2025 10:09:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745600962; x=1746205762;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SNLXvLbbpTqBFTNrbbCRYuJ3NMrzd7CEVCz/JN/Qj1I=;
        b=M5CEd4fOGZHXZT4N0ldCol9qGG7Qk9I1Lt+AYGaykb7sl4UynK/dOZCDZ7ERA+xCzQ
         IIxKSmKyg4eCxbfDh4D3+ynZmfkCONhynqM3J4Ah3Gtcm9TlUchL46spuUqPTpWm7vLt
         t2fGLyd0co6q5U5E7SBCmn97cTJgbbhXqVk/mYaqFScOWr5SDMk5u3F1ycX/G07ldteA
         oipjq8tm1KtYdgnzB2Iux8jK1iS1C29f+HTorFXU3kqSNFU7CfrrtjEtTdYCXUedLKwt
         nuxvf19YB08tKh7dedndjQwWFNJ/R0Uwye8GE0ohlIkNyWEoNLFQGVfD7XDBLeWfGKn6
         YYDA==
X-Forwarded-Encrypted: i=1; AJvYcCUjvL6WT+5hUVOjeCsyXnFnGxroZy3PrgGTky9iUIYsochUuACyfjcIGWAAkqhyzQrcId2XKmI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXf8kd24vxS3rLujAJgwS4AvuytJsWryyopQOmvLuf/G94sfNR
	XO59g4E2jlilJDJTGf/9hQQLvWxImuYn1/W4p7dKCGrmXmzr7CcxLEdoYAcLjTPB9cIuYFPpH2H
	SynpxeV7yBDvmMyIweUbKcWFlguUEj+HsQWZ9FZ3EGagY6B1NtmvG25LTzLsInzk=
X-Gm-Gg: ASbGncs6FMX8KiZO2NJFYYLfUDX/QrYan0OfH2IW6uSCjKEZc+gCXXiVRXetJir6PF6
	qqwv+KfUoVSiYhvliEqgB5wyBrOQj98vmHOKtmxG2BPeeEDsNoRoT+HHA+jT97aT+ORfem60ShX
	aYGb41G2ygy0gFPnPw7+AJCaaDFOduCA/oxFCFbnS1gbWl0BDwmmAhx2wsBLFRVKsjyCvka2g6G
	skvESYX961Bc1AVfhiTMI0AK8XNovp+33v5aru9J1UBhYltTnxx416OUVxfSP8YvXC1ojLAG1Yj
	k49tmYIpAwQZ2HLLoHIqPVbnqzmNZo4n8VBanYZ/ZKHIAEEc8r2fR3OGnC/qJw==
X-Received: by 2002:a05:6a20:d70b:b0:1f3:418d:91b5 with SMTP id adf61e73a8af0-2046a5a9d2fmr68329637.24.1745600962152;
        Fri, 25 Apr 2025 10:09:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGM9HokRCyBhJ15lR9DwESI9IeJZojuQyt/SqQBpUGC27jSIlqVaVyxmI7Z2IF0snSSH+wOiQ==
X-Received: by 2002:a05:6a20:d70b:b0:1f3:418d:91b5 with SMTP id adf61e73a8af0-2046a5a9d2fmr68297637.24.1745600961761;
        Fri, 25 Apr 2025 10:09:21 -0700 (PDT)
Received: from [10.226.59.182] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73e25a9a8e7sm3395150b3a.121.2025.04.25.10.09.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Apr 2025 10:09:21 -0700 (PDT)
Message-ID: <38a0739b-4b27-4619-80d0-1926876cf19b@oss.qualcomm.com>
Date: Fri, 25 Apr 2025 11:09:20 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/ivpu: Increase state dump msg timeout
To: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
        dri-devel@lists.freedesktop.org
Cc: lizhi.hou@amd.com, stable@vger.kernel.org
References: <20250425092822.2194465-1-jacek.lawrynowicz@linux.intel.com>
Content-Language: en-US
From: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
In-Reply-To: <20250425092822.2194465-1-jacek.lawrynowicz@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: QgZAL-iK-uwuKTEONiCIBv20iySSG4h4
X-Proofpoint-ORIG-GUID: QgZAL-iK-uwuKTEONiCIBv20iySSG4h4
X-Authority-Analysis: v=2.4 cv=Fv0F/3rq c=1 sm=1 tr=0 ts=680bc1c3 cx=c_pps a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=EUspDBNiAAAA:8 a=_zbj01uBmePObPNM0bIA:9
 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI1MDEyMSBTYWx0ZWRfX7gIYKdcPw3C8 PNCfseTQ5epS+B0hxN76Dym/m+8brSVR+F11Q/2sd8EwwDA09Zpc9paJcw4zY9+nGbEsqib23Ok woXSjbHd/4gpw3/yIHQUo9uFUSq7oWMmaXrUV0PAjuww3L2+s1tTTX7VGhgqUppFTL2sGzdX1ue
 gWc4zu4bC0Vj7eKMUH3KOriCcUUBF2reHyeIshCPduztK7UDZTW614hfZTvpQgvDwXjhrXDXuuj EO7+uthNZ/VCs3mpPHzDdnMJH97jYglCNmKEvkbvmV3TYI3rKAdB4vb/nSxn6IClMpmPwYH03yt ec9dECJbBZrJrG1XpfNjQl73UlCCV2Srf/PRxo7sYiYYGLMyLINXb4DCe5sX2T06qlEuoIyu5Xr
 jZ4TWMXAgGtKgzOhDli3KLGf5CYJxK64eT3fKVOGKEgZgdOO0Mi+1IsMj+0XozY9P5KfRhWg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-25_05,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 malwarescore=0 mlxlogscore=996 priorityscore=1501 suspectscore=0
 adultscore=0 bulkscore=0 clxscore=1015 spamscore=0 lowpriorityscore=0
 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504250121

On 4/25/2025 3:28 AM, Jacek Lawrynowicz wrote:
> Increase JMS message state dump command timeout to 100 ms. On some
> platforms, the FW may take a bit longer than 50 ms to dump its state
> to the log buffer and we don't want to miss any debug info during TDR.
> 
> Fixes: 5e162f872d7a ("accel/ivpu: Add FW state dump on TDR")
> Cc: <stable@vger.kernel.org> # v6.13+
> Signed-off-by: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>

Reviewed-by: Jeff Hugo <jeff.hugo@oss.qualcomm.com>

As a side note, my email address changed a little bit ago, but I suspect 
you are not aware as I'm still getting patches addressed to my old 
address.  While I still have access to the old address, I'm not entirely 
sure how long that will last and I'd like to avoid missing anything.

