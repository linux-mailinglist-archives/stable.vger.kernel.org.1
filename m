Return-Path: <stable+bounces-240304-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CK/4HbOi6GngOAIAu9opvQ
	(envelope-from <stable+bounces-240304-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 12:28:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 09CA6444B21
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 12:28:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 860BC302A520
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 10:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBAF33CCFC0;
	Wed, 22 Apr 2026 10:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jUGMoVgc";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eTT20DOD"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45AA43CCFAA
	for <stable@vger.kernel.org>; Wed, 22 Apr 2026 10:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776853574; cv=none; b=luBLaEHDnfbAeXqgZ4FUeLDiOJLE1Cah2DtTjiUDLA6MQIflGHLR41XGVG6gWL4msadiSBAAIHYoia3on73sMQ8QuyvFXymOezzLojxXQRHy46XAKBeST04GfQMnw32GPKHBens35lm5BKL7LO2LxPR4aBFvh0fLxE60yzxaIeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776853574; c=relaxed/simple;
	bh=9oMx8UUh3LEuh0OifJ5/c28imvIhOfoxOFygb2DvIuI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pqLZuLXSsbujHRN2hOUGhs0R9Bd3tUL0wuCIVatfAIUSefQfnreS6uD7CWgqpqvg9HAC2VudUD+ZVSiokY/kINrJhAWRMAAHtz01Y3xgILULPFuj5hD/8WV4PNBV/fpd5yeZ8ZiQxc5S4ouUIYP3qsDBbcNkhyOSZ+IzzwC4qls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jUGMoVgc; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=eTT20DOD; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63M96o3h1077703
	for <stable@vger.kernel.org>; Wed, 22 Apr 2026 10:26:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/CMRzFsDXCD5ac6G9NNtEZ+SCThRSqqF+fw6lWJ++kU=; b=jUGMoVgcqC9j8ip9
	vKJ2HwgNchP5gQDkjYbzDTL6Wy04Qp9iB7QTLZYwJUfz9VUgf5LfKXWVjTP+5LvO
	SnnxyppI91gtSBIT+/Fy+VzFm4wchHumrIyQdK1yIF9Me/x57MTGr/tXP/4u9ZQq
	zw4vN4ogT/iHImYSxhS26O2US3+Pdq+R1tqn3ccNd/+5B/2f8WWwTSUsUxZdkGeZ
	jv2be5YAcwoPbeVXAK1EII6KpdFEPPSBnReMJM3vXXBzyDwpaN0p5tfJE2WEKvXJ
	vADYn6dXG0urj4l4bcq8vSAquXyxXck+BWyw3yl+x3m04JIeFE1pFDyK4tOSN18v
	jumeKA==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dpeng304w-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 22 Apr 2026 10:26:10 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-8a5bf7ee420so15328796d6.0
        for <stable@vger.kernel.org>; Wed, 22 Apr 2026 03:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776853570; x=1777458370; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/CMRzFsDXCD5ac6G9NNtEZ+SCThRSqqF+fw6lWJ++kU=;
        b=eTT20DODyOlK3hGwSb7ru33i/jHyp72NQHmjBeyX6Mgklxt/TUS1Wd7xzFfiTkLQWC
         VVlzN23C/QvZbEhU+hLUPLaX8tI6W2qyZ4V9j+sV3bkLidHdm6GmBbV16Dws2awte4zJ
         NLQBuk8jv0oRykeHcv3nNJOMMrlCDHAE7nsgUc3uC7+wW1HZfPSFgTDim++Sdp1jHm+O
         IpqeBYIZERdxH/r7UBdf167hnQotPC2eT7jo7kOFmJOdv4HOuZnBpZMPrf7/1tJm31F7
         g9rd2vP502nDcje1p9a1eHIsXKz4d4dvb5D+cUQWP17yQAfuPav3IyKZmeyPRRlrBLVT
         KILA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776853570; x=1777458370;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/CMRzFsDXCD5ac6G9NNtEZ+SCThRSqqF+fw6lWJ++kU=;
        b=mHepU/IgDYS1Q+WUPcVsNOLyFTXd8gmlySIuq8xrehWgRceQWj/5bpjrisgVt1IbiA
         M3QMz7yPBW1mqd9FSf0DllYt4LEve90v3leyLDYUKzrgP1XreB0JabiZeUc9IX1VIxXP
         wBJ6oveNpvA0J8/fipRTdUkgbMDXqf68Wiw4BPcbp/vxy0KJ/2O8QOE9Qa7ZrEuWJma2
         fiL6cj0JKhBFWVLXbcEusPfk3v/DhSUnuYsI17hkPSY2zXLRpeuIdNk9nxh2ki5bG7xg
         itz5xEUGXgwpDZd+SH8uO0U7Ln3TUTMrycNuGYYYSt0CDmOfmMtJn8SY/KTxJfEKuwCc
         Q/uQ==
X-Forwarded-Encrypted: i=1; AFNElJ+u3Fo0aUoqKqJvZ8I0uo5qEthCTfqS+/0B6kVDxmLaeffzEcW48IIbmyoh8iK+4gLlL6lTvxU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIRXklyUdzbxE7Kj9Nb4y7gMmaNsBlZN67Z3A61Wl2YXyeKHB3
	QOX7vlokYzIX5pvSXmiF4u3TTd7pU9HdiVY8Jrpj87z3bYfMuY0U/O+qO644YcNLnIOzfGZfVc8
	f3v66stJsXDtlKO//mxKhSHee/g7uA6oG0Va31rbpBS/9E9P0EWj6u79obZw=
X-Gm-Gg: AeBDiesQ59+C8gLQ7FkLiMtWNhJWIm+yRKm6WDWsdpKp8tm8tqqNGyy7DX8QoBGTNaw
	g9b47AXLXW30xzv5tr+KXXRXtOSGabQDQ2kQ/qxBRA+WG6Rv2w2Will+fmv8ivYRVss4Z+JoC6X
	gubalNmZr1pI3wOn9V5qSC9hBZTWsQt6uSDDyGt40N5kvB8pRw1jHeC0zKh5jgLrR5KcJ6Qr4t3
	nQ4lmHIggLI94fi8F8VpvXBsV+2H19yIEt7+f83EWETLCURBPlmAOjq3fuX6sletj1S6HzkyNgP
	I1szUhH02b5n6Y9Et541fox1P6lUIjLoM7EHzXC8kIjIGUFAxeakE50HKYwlgF2pVfSPZtDb3EY
	G9I+3d94461C1CYsvmYdCYqDi4HJo/HERSdYEwDrzpMipn2yXSIdFuOTUCIoq0RcYoCUzPruchV
	+goQPdJenLpZGEwg==
X-Received: by 2002:a05:6214:2521:b0:8ac:a205:f118 with SMTP id 6a1803df08f44-8b0281997b8mr228050686d6.8.1776853570145;
        Wed, 22 Apr 2026 03:26:10 -0700 (PDT)
X-Received: by 2002:a05:6214:2521:b0:8ac:a205:f118 with SMTP id 6a1803df08f44-8b0281997b8mr228050556d6.8.1776853569671;
        Wed, 22 Apr 2026 03:26:09 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ba45572d01esm547277666b.62.2026.04.22.03.26.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Apr 2026 03:26:08 -0700 (PDT)
Message-ID: <6c2c5fd6-c032-4658-9a15-039c77074c4b@oss.qualcomm.com>
Date: Wed, 22 Apr 2026 12:26:06 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: hamoa-iot-evk: Enable retimer on USB0
 port
To: Prashanth K <prashanth.k@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>,
        stable@vger.kernel.org
References: <20260422093924.2976069-1-prashanth.k@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260422093924.2976069-1-prashanth.k@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=CNUamxrD c=1 sm=1 tr=0 ts=69e8a242 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=wN9py1S4oeCFzi0qT3MA:9 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-GUID: poQTM0O0LkrzjSM3LC98l5wU6NrvKIVR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIyMDA5OSBTYWx0ZWRfX5DlVrEFkIdeR
 +A/tE5j8l9F9f7LkiNhy0mKENXru3wRvs6P27CaRV+mo6nLgDpMDLoxe3Cbma6UTwTc+jsI5A53
 5x+ELNFwO/PxO/GlTQTQR7YP1T0DxIPUaG7v45QNbdcjksXgAcf+9M8yqNlFghgAtOMejb7DQQd
 /xuU9VCAXj0ctK8nxns3Xw3NpSX85LmmDU4syblgNrD2RfdCxRy+PwtiF4/VqlFeZKP/O8g77+O
 UGn4kYKrZL6rvNTjfDrLCjZ4vBJa97GStwh/ttMZQ2a5rzLITSnWyoWH6KbhJhPTYoRped7y7sf
 TJBm8lIhxHvOYhKqco7koGOH5ymPm8NFxqLrua41/SVyWJLcvp7D5w17581m3jmv27ThlgYJ4TY
 xbj4bQ9Ofwhcp3mL/lnX2po1ome0H2s5LeAWvqhEaw2jsLUzRe2uZrmv7LvBy3kjW/IfPLgsWcp
 inIv+mNEI36y/fiD/xQ==
X-Proofpoint-ORIG-GUID: poQTM0O0LkrzjSM3LC98l5wU6NrvKIVR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-22_01,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 impostorscore=0 phishscore=0 bulkscore=0
 suspectscore=0 clxscore=1015 spamscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604220099
X-Spamd-Result: default: False [3.34 / 15.00];
	SEM_URIBL(3.50)[0.0.0.0:email];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	DMARC_POLICY_ALLOW(0.00)[qualcomm.com,reject];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-240304-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,oss.qualcomm.com:mid,qualcomm.com:dkim,0.0.0.0:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	R_DKIM_ALLOW(0.00)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DBL_PROHIBIT(0.00)[0.0.0.1:email];
	FROM_NEQ_ENVFROM(0.00)[konrad.dybcio@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	NEURAL_HAM(-0.00)[-0.972];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	R_SPF_ALLOW(0.00)[+ip4:172.234.253.10:c];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 09CA6444B21
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/22/26 11:39 AM, Prashanth K wrote:
> Add the retimer for usb_1_ss0 port (USB0), in order to enable
> super-speed enumeration on that port.
> 
> Fixes: c11645afb0e2 ("arm64: dts: qcom: Add base HAMOA-IOT-EVK board")
> Cc: stable@vger.kernel.org

This is a feature addition, not a fix

[...]

> +		ports {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			port@0 {
> +				reg = <0>;
> +
> +				retimer_ss0_ss_out: endpoint {
> +					remote-endpoint = <&pmic_glink_ss0_ss_in>;
> +				};
> +			};
> +
> +			port@1 {
> +				reg = <1>;
> +
> +				retimer_ss0_ss_in: endpoint {
> +					remote-endpoint = <&usb_1_ss0_qmpphy_out>;
> +				};
> +			};
> +

Stray \n, but you should really have a @2 port here as well.

Konrad

