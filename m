Return-Path: <stable+bounces-223783-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yHjhHrzPr2kfcgIAu9opvQ
	(envelope-from <stable+bounces-223783-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 09:01:00 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A7D9246D4B
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 09:00:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 474773014A1B
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 08:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B005D3ED5C6;
	Tue, 10 Mar 2026 08:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lURctvYB";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dMQFmape"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B503ECBD2
	for <stable@vger.kernel.org>; Tue, 10 Mar 2026 08:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773129636; cv=none; b=hE9Np28QHq2zGxUR7UjVZ6bKezGmgatn7QWEap68ao0l8sTvNxAz1Syf7dHPSM40StxSXjKAubYzbANGgEaoCiineBY4PAU7RFBP6aDm6x3ltq0r9T/E3t2zQH4GH8L9gDzRt0m3bK7Zl1HCG6HazwOZforSb4yOeR7p+EApxm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773129636; c=relaxed/simple;
	bh=fYNOujxx6NxYe2zOaLlz1irIB+ilchNKF1jB0JvRFYU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TUk6OlOovyLFsFe1NgX2aLonwbsmonlKmCN0RKC9MG0GH7yMyd9F4I0v2vahl0kFthm2BNfIHf3rETXZm6rR7ACB+SPuKQ6YvWemJnNfwXkqbFF8ueh6elR5lV0kUnzYNx6USRq3CEAvNSv1F4tpTZ4N38N49cy5AakiTQMlFPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lURctvYB; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dMQFmape; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62A2EQL12460634
	for <stable@vger.kernel.org>; Tue, 10 Mar 2026 08:00:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=0glcIkHMPYElUIV5XbqxlIA8
	HWv58+kwPpFRAYmUSIM=; b=lURctvYBQZwhlQib1Iy86m36wkqntNPJ8kjgRG8y
	4PYTXRmI8uDRdE4uO+6LDwe6g3I0npgTTzqKXwsLtt/TY3pQhVWwfH/lbO5k8R0u
	iQQ8b1k6NdI/e3io55rSpbibJX9ZoVjjogRtLerSZsIWLmKZz7+GTwHf9YYxhoyJ
	kGVAKDPuQckWwJHRZZw0SvTlVyPgyLm4y3HBE/Hdbw8ukbgAoE4gDFXkOcYaypEs
	HnBvnBRI1YDPo3fnNHv2PH1sEqcv5fp2jSkcIc9JHvWKaglpKr5ZBs/MBUAEILDY
	u7Tf0HrB42UaZevgFfed9RAKFLApJsw7riq2NGeKT0XSog==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4csyv1b7cg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 10 Mar 2026 08:00:33 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-829a72475a1so11628043b3a.3
        for <stable@vger.kernel.org>; Tue, 10 Mar 2026 01:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773129633; x=1773734433; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0glcIkHMPYElUIV5XbqxlIA8HWv58+kwPpFRAYmUSIM=;
        b=dMQFmapex9RURoZ2Ix7YLpPjbsiduxwpRHMm2Y3yptcb/M3FURbJIXz68beo7EptfK
         X4Jy7bshSi97bgFtn44SK6/QvQyEGkYZSIke+UFXn+BuEOCLT8CYV0+6mpDPhjmm4nKH
         S+yPzFNqu8+Ut0oSSRx8bxqmzBsyzsEOABu46ySsHw/UeSfgHkGL7ACWDaE81tL/t2sa
         QziAhYMHps4FwiGbeP/fHgQQ68zj34mEFXLa6GvAxHi2GyFoH+cy0Wv+5EUBC+y2O38C
         Rlh4dU/PxIXozI2JllBj2CmrnaEjMr1a0iWiCmDAy5Lc9o8Ug+LuOtK+OSEunEeqmFPD
         VQFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773129633; x=1773734433;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0glcIkHMPYElUIV5XbqxlIA8HWv58+kwPpFRAYmUSIM=;
        b=lRf8upflY6lkd/FTAFjQB7CFiFI5ICn7QD8w0rfC27nuplJg4w88Wp4a4Cw7DR8h7O
         80iW4DcCiCEZVMFQUg0eP8FiitvR/l3mrAnh3R23ywroYu73fkal64ompx7v0W5W+5Sp
         EO47sSZmJTZMZvW0djVrynLTGKT7UesPFSj7Zeembk6BkmmQF8pTkNctn4JaMUOCfITn
         ob2mHMStTu+Sg+G8V7Lu7jOnuJh8mfPI0H7RnR6UAIGpVVqAE/s7G198tnWp95YzZXNJ
         c/SXOn9aHxlNJNc2nY2EbrlSHOriwbJbpjcRdul6SJPX62p7SJaon1QC5r8t/rmkh4Em
         s6+w==
X-Forwarded-Encrypted: i=1; AJvYcCUaNlkXU6FhVdrUK1xkY9AzUMRXZTqQKEeK6fM2z18UPzlshTK4LXHj6cEbYOrdh62T7uv7WMM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvLabuzuXtnEEsChotLPgeue233SP2js6RrVoCAhTzDNMTA88y
	dv9v1/hi32iw14ayZgo1Dx6Pl0gctkpFQnKs3dEvyavAayQw8by2S1ahUm1TcscbGkQhQFAVcEe
	sPX5e6ZhawD1ESQPcAMzvZGDlJeYdZBTE38MNJSaRJ43wierKzhvV7y+iAhQ=
X-Gm-Gg: ATEYQzzwQzNYVLb4bXkkk8soFumlwIxwII6S58sOD9Ar6ddTWlPJev4Ce1VP7eWSUtP
	oaNMTft9vgd/3iuJqA4XReb1Fr+FTOk6PbnskYX1fl+/6+8Tc4Q1bFahVd6YgOckwbq9CMVmEg6
	5KUU7a189Wha8Xkeavs+ua/iSqbfAlWuQUGbsrcYxnorDOOM+l2dZEjm3pIoSAmvzvv+7E6QnPS
	sCvIdOu8GOPG0HDQm52WVGCzF7DwYVWes5Wcecul7QEdAMLc6jatOiSnqzlPrbvW1oo6eZ/BRGr
	7x8TGaHnfqOP3x/dfgr4LFXt/FAr0oN9rCwklkcDlaSfoQYA4TIdhkAc+myLmcGaAvIEZI6CdTO
	Jhe1J6DVcE4C3uUGD3V9m5lNyz8eHjVUmzzToc87+z10eXeTh
X-Received: by 2002:a05:6a00:983:b0:829:7e6d:cf20 with SMTP id d2e1a72fcca58-829a30dfcb6mr11834186b3a.58.1773129632546;
        Tue, 10 Mar 2026 01:00:32 -0700 (PDT)
X-Received: by 2002:a05:6a00:983:b0:829:7e6d:cf20 with SMTP id d2e1a72fcca58-829a30dfcb6mr11834145b3a.58.1773129632002;
        Tue, 10 Mar 2026 01:00:32 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829a4638a7esm16029383b3a.7.2026.03.10.01.00.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 01:00:31 -0700 (PDT)
Date: Tue, 10 Mar 2026 13:30:25 +0530
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
Cc: Srinivas Kandagatla <srini@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vinod Koul <vkoul@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 6/7] slimbus: qcom-ngd-ctrl: Balance pm_runtime
 enablement for NGD
Message-ID: <20260310080025.lbof4hj5zqytc3vy@hu-mojha-hyd.qualcomm.com>
References: <20260309-slim-ngd-dev-v1-0-5843e3ed62a3@oss.qualcomm.com>
 <20260309-slim-ngd-dev-v1-6-5843e3ed62a3@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260309-slim-ngd-dev-v1-6-5843e3ed62a3@oss.qualcomm.com>
X-Proofpoint-GUID: zIYDgc_yb8EkGjWB0ZH83_Enao3J8ihd
X-Proofpoint-ORIG-GUID: zIYDgc_yb8EkGjWB0ZH83_Enao3J8ihd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEwMDA2NyBTYWx0ZWRfX73I9jfc5AYjv
 RE/GGeodxGzK84nj9zvy6C6ymlB+/BO2FCqiq/fcWx8jVnLll0uaizyUJ3yI4b4fpcOxkrnUBQU
 nqURLwg1JLx3/1obQvEYq3lhRf1t2/oX7VtDdOlXYCczu7ysxYLCB4gnye886CkX82cF+HfF/OB
 AFLVd4qvxKSI+qzqmITQpsrXisfoUcof3uSz7MND1AuqX+3xGz+YBHZ0fmw+oRjcuDp+TaVELTL
 tD7IXaj8QoUbcmGf645sIGg5tF6yLdrdfP/dVu//LwrCbEQb8dwIfjwRJ6a7CDzSlTfFD9id4dd
 Snu978n3GVOxWEOxTs5lTEZIw4gUHTeJk5sIOeBC5QN5v7PXgBMQNTZphKTfN5fyGSLW06djwms
 Hq1V71wrVFpJ4eAhEn4k1FID8zoUJIYMqtDBUBc+HM+H7+ge1+SebUfPy6PU9ltWiaLHIqwglIj
 jvHAQz4/5Yt8xI5eCPA==
X-Authority-Analysis: v=2.4 cv=Cuays34D c=1 sm=1 tr=0 ts=69afcfa1 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=kj9zAlcOel0A:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=prLrz33j-ZeXCHbr2zwA:9 a=CjuIK1q_8ugA:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_01,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 spamscore=0 adultscore=0 priorityscore=1501
 phishscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603100067
X-Rspamd-Queue-Id: 7A7D9246D4B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,qualcomm.com:dkim,qualcomm.com:email,hu-mojha-hyd.qualcomm.com:mid,oss.qualcomm.com:dkim];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-223783-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mukesh.ojha@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

On Mon, Mar 09, 2026 at 11:09:07PM -0500, Bjorn Andersson wrote:
> The pm_runtime_enable() and pm_runtime_use_autosuspend() calls are
> supposed to be balanced on exit, add these calls.
> 
> Fixes: 917809e2280b ("slimbus: ngd: Add qcom SLIMBus NGD driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
> ---
>  drivers/slimbus/qcom-ngd-ctrl.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/slimbus/qcom-ngd-ctrl.c b/drivers/slimbus/qcom-ngd-ctrl.c
> index d932f7fd6170773890f561e3af444ac2c5730338..54a4c6ee1e71fe55794f09575979826d9aa5be9f 100644
> --- a/drivers/slimbus/qcom-ngd-ctrl.c
> +++ b/drivers/slimbus/qcom-ngd-ctrl.c
> @@ -1584,8 +1584,11 @@ static int qcom_slim_ngd_probe(struct platform_device *pdev)
>  	pm_runtime_enable(dev);
>  	pm_runtime_get_noresume(dev);
>  	ret = qcom_slim_ngd_qmi_svc_event_init(ctrl);
> -	if (ret)
> +	if (ret) {
>  		dev_err(&pdev->dev, "QMI service registration failed:%d", ret);
> +		pm_runtime_dont_use_autosuspend(dev);
> +		pm_runtime_disable(dev);
> +	}

Can this entire pm_runtime_* calls moved after
qcom_slim_ngd_qmi_svc_event_init() ?

>  
>  	return ret;
>  }
> @@ -1699,6 +1702,7 @@ static void qcom_slim_ngd_remove(struct platform_device *pdev)
>  {
>  	struct qcom_slim_ngd_ctrl *ctrl = platform_get_drvdata(pdev);
>  
> +	pm_runtime_dont_use_autosuspend(&pdev->dev);
>  	pm_runtime_disable(&pdev->dev);
>  	qcom_slim_ngd_enable(ctrl, false);
>  	qcom_slim_ngd_exit_dma(ctrl);
> 
> -- 
> 2.51.0
> 

-- 
-Mukesh Ojha

