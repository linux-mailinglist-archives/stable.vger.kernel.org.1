Return-Path: <stable+bounces-222566-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gEeiBM5jpWmx+wUAu9opvQ
	(envelope-from <stable+bounces-222566-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 11:17:50 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AFAF1D6461
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 11:17:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6C0713040007
	for <lists+stable@lfdr.de>; Mon,  2 Mar 2026 10:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49699395D8E;
	Mon,  2 Mar 2026 10:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pHv8Y92O";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SEjWzZiI"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE51138F62D
	for <stable@vger.kernel.org>; Mon,  2 Mar 2026 10:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772446324; cv=none; b=E65nLNjDuBvZlaxHSgrVspceUGa7YEfsdNz1LjqXXsR/kHk5kgiSj6m9anwsmUmXAf1Md4IEA6DhL3keX+NZdDtYzYpyf2MaPhvqZG/zrySGzSfjsKhZYvSzcoQeOG/+ro1glpCdMv4ua8ZUy3jytTWFMBvI9ZuG7oV7N7gay0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772446324; c=relaxed/simple;
	bh=txdY5rJ/ZRLNRF9fgeSs9EjL4oxzE2aFUDw8jLdrJpo=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=F2weV0fkpe5BesYm+3vi5r+7MtUZd7JGxa/+bKeQmYEP1+eu1x7CKZWw2pENnhPnaDbq3GPUn3lNQ527x+yykP9DQNCPFVhyf6IcKF5G9d27vsKjeBrbbSR1YmPUXw8uuDAzeUWfq63z8mMWsNjPLS37IXMdSGQJEQDQWT+kUBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pHv8Y92O; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SEjWzZiI; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62285bmO662340
	for <stable@vger.kernel.org>; Mon, 2 Mar 2026 10:12:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qYtlAUqEB4PsAxcph4isW3Atz2Cxuy6C5HTehGmJZIc=; b=pHv8Y92ORgWuZQvE
	Dv1vZHnzRiq4Rxg9Qf8YbmYZZwspNFX1eMLxm4EVDF59j8BZYcZchO6Zuix0W10T
	hsi3o8pvD8cB4mzvqNyMntd2em0PjXOGroc/ONvosYqN7Amq56YZxVD8eMU0zS1L
	wYZ91dZ3mwpo+L/UN9Y3AC28sMEM2VL0QFbFKa7pkpz2q5KuWus+hoZLOOUNtdgI
	qhaF3SOBzjBGGVxd3uO+vKxW7vMOFZYrumSrPz6FhMgw7+Ktp+96WJNVxyzkUHMj
	XiS48K1tCDxX3PiafQj/eMUEun25FNNTu8LFIx8qnuTPpRer5JUq5CwUVT7YkNLX
	+wxnSQ==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cn6r2rhht-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 02 Mar 2026 10:12:02 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-8274dbdbadcso10458651b3a.0
        for <stable@vger.kernel.org>; Mon, 02 Mar 2026 02:12:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772446321; x=1773051121; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qYtlAUqEB4PsAxcph4isW3Atz2Cxuy6C5HTehGmJZIc=;
        b=SEjWzZiInW1PZPVefcOKX8V9USzDQ8+NwpVNAwQSoYe/QWvUR0Ggjgy7yVYhFO0wVV
         SHMb75sIKRfb1V/+ZML4lAYbytD5mhmtIiMCk7tVQ0WHwd3BPtcY2GYVm8VAMuUoPy7d
         T17QqtKnzBzAwcxdlloLQ6fNUTESbVLpFPLgID+c+ORf1HwZIRQDwMOXiQOB2kQj4bJC
         BE+efFHM0RKaV9exb3CmX8uhGBk+1WCqbSXhMlaTeyHAhk9SptXY38HPmQPQQH2qVC+r
         nsLsi+ZB8g9SRS5D2gb16uqdpAPyeEEHfpLj+425yXXvbGihlxP3PPsSIh/6G2zdGeed
         Zt+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772446321; x=1773051121;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qYtlAUqEB4PsAxcph4isW3Atz2Cxuy6C5HTehGmJZIc=;
        b=Gmc828oVhsTOWGrwpb3qqOhCneA7Tz8N5qh16ABGs99cHE5D4ySLfQ6A2VvTYzhhNJ
         ME/RsNtdUCkqAeUkxaV5K6Te7bHfMRABBwF/wES+n5wnqbOoGqvWEw354348BqC3LB+f
         ZYFKljW0aLkMZK6CdahqBN5WmjSBaPz4lUnvmtmquKU+hInvWIFhsw1lSocw4OjKFTxo
         dY6uckryyzkIHTJRPlyhRdZs+u1EsR7xuvdlGklTbguurqld2YaOqBSWfwZ8xejhcHoI
         vF0WWX61EGJ0VLtREek2lhq05xOZ11yYwmTs8eWQfxl1kJY0BPZO8Y8eGz/Ejqsdwc1n
         0TXw==
X-Forwarded-Encrypted: i=1; AJvYcCV9h5DEpatUaXLkDIIsFKVoWawAxOE0z+ov8b1t3YxScmwZj8J6uF0bO7Y7UavvxQnPN9bdhto=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXVzQbZDrSAMB7hlnssz0X1g11tpKkKHupKE5pAmDuEI8Y9MiJ
	qo8LOyo8uLQVy/o9dWNx96Wqkpjyo6/5f+HF+DYS2g6j0lFmVMDAv07uKLNfg6TYUr7XKHjqCAH
	YKMJuv6nXQhKzUEa856colYfp/BcyzvkdEa6Lj0yaopKsI1roony10YDUbpiHixaio4I=
X-Gm-Gg: ATEYQzzrgMbnYl8WKW4FvHnTzXD+jd3Uuyp1IODui04A0ul0htE9s3Cv8XBgqV6Cf2Z
	g3UmRG0TIcQYCrDSyRF9GHgQzD8lnqolYbyrcZx5KbhPQXFbyDIWvuFIwvVuaUhbeW0IVVPLap1
	rVFnUOWFAZSnuzmlxBZbU69SZzX6d0ZztpeEg2PONuFfXvlshJM2Hef20Yp1C4usO8rsg6TO/z7
	gel4r6AGM4EGyV7/vcx2lZ292uHL0Y6HpsP1mN3EenqivLhs/MP5ZD/Ogo/J40dfDhkNzSioc9L
	P/vsHR9lBxprrtqIw4L8BEZV5ezH5kZOTapsWWvOdHQztwtWFXFh0rd+QgWFI0cwfJgCVSUcCdY
	k6PV8JCpM8GWfZyCd2uHlBQBc/ab9uzVmpyDdXOMWyfj+qIXTYA==
X-Received: by 2002:a05:6a00:4ac9:b0:81e:408e:47d2 with SMTP id d2e1a72fcca58-8274da12e28mr9293442b3a.53.1772446321162;
        Mon, 02 Mar 2026 02:12:01 -0800 (PST)
X-Received: by 2002:a05:6a00:4ac9:b0:81e:408e:47d2 with SMTP id d2e1a72fcca58-8274da12e28mr9293421b3a.53.1772446320642;
        Mon, 02 Mar 2026 02:12:00 -0800 (PST)
Received: from [10.217.222.63] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82739d4c910sm12494189b3a.8.2026.03.02.02.11.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Mar 2026 02:12:00 -0800 (PST)
Subject: Re: [PATCH v3 1/4] soc: qcom: ice: Fix race between qcom_ice_probe()
 and of_qcom_ice_get()
To: manivannan.sadhasivam@oss.qualcomm.com,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson
 <ulf.hansson@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Abel Vesa <abelvesa@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-scsi@vger.kernel.org,
        Sumit Garg <sumit.garg@oss.qualcomm.com>, stable@vger.kernel.org
References: <20260223-qcom-ice-fix-v3-0-6ca5846329f7@oss.qualcomm.com>
 <20260223-qcom-ice-fix-v3-1-6ca5846329f7@oss.qualcomm.com>
From: Neeraj Soni <neeraj.soni@oss.qualcomm.com>
Message-ID: <5e9a399a-074b-4b41-2e10-f2ed654eafcf@oss.qualcomm.com>
Date: Mon, 2 Mar 2026 15:41:54 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260223-qcom-ice-fix-v3-1-6ca5846329f7@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: IT44rkd4Z3HfPl4p4jSNUKDqlrPRRiaN
X-Proofpoint-ORIG-GUID: IT44rkd4Z3HfPl4p4jSNUKDqlrPRRiaN
X-Authority-Analysis: v=2.4 cv=Hpp72kTS c=1 sm=1 tr=0 ts=69a56272 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=MqxRADgNEBqUf3RlVf8A:9 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAyMDA4NSBTYWx0ZWRfX5hfDXbuq9fYw
 imBtKkOZcjJR7VVqQtxcpLd+xsc5aI/r3V2TWIE9LRcULOHv3omOsJ7ao0YRUSEzf3Fvftds0pw
 DXzC+7KDSOGG0TWK60r4O8+yypChZ9pk3a8hJVywus6LVBA8IoVooCerwqvkI3jKbN+SLkya8WD
 XOTEFD5fbtxYPdkrpdUXTkP8o24uvS1urZhF2QDCoXW066sOLGEr9heEcZcFTDYcIaP8mF/w0S4
 KCW4yXo8WJbnP1BXEZFqayT0biixe6ItMp7iotieg93zqG3BXKJ2bCP28gSOp0vfBqrtQ5Gj9ug
 dlYUPZTreZm0rza721xRUtTppXkf/cRfcWpgTO4SrnMbbKudTUb/e12DUCoeE30W1LaNT/7NBN9
 Fp7GpdQUQXN+nj45SULur5Udc0hNeuzI3Wn/xtf0FBk80/92EVBix/cxXhvDtZq4xPEHrI6hDi1
 /HNQasg18HjiQ5DsHFA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_02,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 impostorscore=0 phishscore=0
 priorityscore=1501 adultscore=0 bulkscore=0 malwarescore=0 clxscore=1015
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2603020085
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-222566-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[neeraj.soni@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 7AFAF1D6461
X-Rspamd-Action: no action



On 2/23/2026 1:32 PM, Manivannan Sadhasivam via B4 Relay wrote:
> From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> 
> The current platform driver design causes probe ordering races with
> consumers (UFS, eMMC) due to ICE's dependency on SCM firmware calls. If ICE
> probe fails (missing ICE SCM or DT registers), devm_of_qcom_ice_get() loops
> with -EPROBE_DEFER, leaving consumers non-functional even when ICE should
> be gracefully disabled. devm_of_qcom_ice_get() doesn't know if the ICE
> driver probe has failed due to above reasons or it is waiting for the SCM
> driver.
> 
> Moreover, there is no devlink dependency between ICE and consumer drivers
> as 'qcom,ice' is not considered as a DT 'supplier'. So the consumer drivers
> have no idea of when the ICE driver is going to probe.
> 
> To address these issues, introduce a global ice_handle to store the valid
> ICE handle pointer, and set during successful ICE driver probe. On probe
> failure, set it to an error pointer and propagate the error from
> of_qcom_ice_get().
> 
> Additionally, add a global ice_mutex to synchronize qcom_ice_probe() and
> of_qcom_ice_get().
> 
> Note that this change only fixes the standalone ICE DT node bindings and
> not the ones with 'ice' range embedded in the consumer nodes, where there
> is no issue.
> 
> Cc: <stable@vger.kernel.org> # 6.4
> Fixes: 2afbf43a4aec ("soc: qcom: Make the Qualcomm UFS/SDCC ICE a dedicated driver")
> Reported-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> ---
>  drivers/soc/qcom/ice.c | 44 +++++++++++++++++++++++++++-----------------
>  1 file changed, 27 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/soc/qcom/ice.c b/drivers/soc/qcom/ice.c
> index b203bc685cad..3c3c189e24f9 100644
> --- a/drivers/soc/qcom/ice.c
> +++ b/drivers/soc/qcom/ice.c
> @@ -113,6 +113,9 @@ struct qcom_ice {
>  	u8 hwkm_version;
>  };
>  
> +static DEFINE_MUTEX(ice_mutex);
> +static struct qcom_ice *ice_handle;
> +
>  static bool qcom_ice_check_supported(struct qcom_ice *ice)
>  {
>  	u32 regval = qcom_ice_readl(ice, QCOM_ICE_REG_VERSION);
> @@ -608,7 +611,6 @@ static struct qcom_ice *qcom_ice_create(struct device *dev,
>  static struct qcom_ice *of_qcom_ice_get(struct device *dev)
>  {
>  	struct platform_device *pdev = to_platform_device(dev);
> -	struct qcom_ice *ice;
>  	struct resource *res;
>  	void __iomem *base;
>  	struct device_link *link;
> @@ -631,6 +633,22 @@ static struct qcom_ice *of_qcom_ice_get(struct device *dev)
>  		return qcom_ice_create(&pdev->dev, base);
>  	}
>  
> +	guard(mutex)(&ice_mutex);
> +
> +	/*
> +	 * If ice_handle is NULL, then it means the ICE driver is not probed
> +	 * yet. So return -EPROBE_DEFER to let the client try later.
> +	 */
> +	if (!ice_handle)
> +		return ERR_PTR(-EPROBE_DEFER);
> +
> +	/*
> +	 * If ice_handle has error code, then it means the ICE driver has probe
> +	 * failed. So return the handle for the client to digest it.
> +	 */
> +	if (IS_ERR(ice_handle))
> +		return ice_handle;
> +
>  	/*
>  	 * If the consumer node does not provider an 'ice' reg range
>  	 * (legacy DT binding), then it must at least provide a phandle
> @@ -647,24 +665,16 @@ static struct qcom_ice *of_qcom_ice_get(struct device *dev)
>  		return ERR_PTR(-EPROBE_DEFER);
>  	}
>  
> -	ice = platform_get_drvdata(pdev);
> -	if (!ice) {
> -		dev_err(dev, "Cannot get ice instance from %s\n",
> -			dev_name(&pdev->dev));
> -		platform_device_put(pdev);
> -		return ERR_PTR(-EPROBE_DEFER);
> -	}
> -
>  	link = device_link_add(dev, &pdev->dev, DL_FLAG_AUTOREMOVE_SUPPLIER);
>  	if (!link) {
>  		dev_err(&pdev->dev,
>  			"Failed to create device link to consumer %s\n",
>  			dev_name(dev));
>  		platform_device_put(pdev);
> -		ice = ERR_PTR(-EINVAL);
> +		return ERR_PTR(-EINVAL);
>  	}
>  
> -	return ice;
> +	return ice_handle;
>  }
>  
>  static void qcom_ice_put(const struct qcom_ice *ice)
> @@ -716,20 +726,20 @@ EXPORT_SYMBOL_GPL(devm_of_qcom_ice_get);
>  
>  static int qcom_ice_probe(struct platform_device *pdev)
>  {
> -	struct qcom_ice *engine;
>  	void __iomem *base;
>  
> +	guard(mutex)(&ice_mutex);
> +
>  	base = devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(base)) {
>  		dev_warn(&pdev->dev, "ICE registers not found\n");
> +		ice_handle = base;
>  		return PTR_ERR(base);
>  	}
>  
> -	engine = qcom_ice_create(&pdev->dev, base);
> -	if (IS_ERR(engine))
> -		return PTR_ERR(engine);
> -
> -	platform_set_drvdata(pdev, engine);

This allows the driver to set the data per ICE device instance which allows
the addition of multiple ICE platform devices. For example this patch:
https://lore.kernel.org/all/20260217052526.2335759-1-neeraj.soni@oss.qualcomm.com/
utilizes this capability. I think it doesen't harm to keep this support. 
Moreover, the issue which your patch intends to address do not need this to be removed.

> +	ice_handle = qcom_ice_create(&pdev->dev, base);
> +	if (IS_ERR(ice_handle))
> +		return PTR_ERR(ice_handle);
>  
>  	return 0;
>  }
> 
Regards,
Neeraj

