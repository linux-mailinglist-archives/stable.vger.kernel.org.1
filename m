Return-Path: <stable+bounces-224625-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8E8BAEPJsGk8nAIAu9opvQ
	(envelope-from <stable+bounces-224625-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 02:45:39 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 01E3825A78C
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 02:45:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F086C3009809
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 01:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07AD41B6CE9;
	Wed, 11 Mar 2026 01:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ClVhRmEd";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ffjZc9XN"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84BDB40DFAE
	for <stable@vger.kernel.org>; Wed, 11 Mar 2026 01:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773193531; cv=none; b=ncQWPwiR3qytwzBp93qDu3RIv+mfAEUhWKhOtuDk2dPBNa8TPo8cPjj2Q4KDwTdPL66O2JIqizMvDlOYsK4ODRzbuhMDdoBmm6Hj3O7dN7DS6cK/UQ4Gw8oOLL0txMcvHIdd6fZHEaY1jsQAcWvKUR4P352UE7h5j58lozDTqcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773193531; c=relaxed/simple;
	bh=5YtUYEmAFTe9h0/m9ByxK+bX3xsmB1lIBbTonuwpxL4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mA1hWMvu2nGWb9Mg9Jk7CcbJahZUbR0AoiR0+AGANZnlRjE1bRYHMx+nxm2nlJIj5HT10FV3LorFgqXxu3IkNhP7hSUXZ+fRxvGogPSOIwObr0rAQ7GJH1r5AZBMom2Vswd6Ypc70DH+eZyYp0ZSqqEJ7lG1DrIiyL3MECkW51k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ClVhRmEd; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ffjZc9XN; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62AJ07bA3417921
	for <stable@vger.kernel.org>; Wed, 11 Mar 2026 01:45:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=MnvYoQz83uuHbndV1q5nJmq+
	tn2JTM91TDSnDm7YcUk=; b=ClVhRmEdykA/wzekWq7Ui6cVkrYWn5qU4rGioJoH
	ZCBDRTCEirktT37AFltIBA+AuUWtM2vm4XG5BtD2ctSJQtZ7jNFQidtijVdOxyPA
	WiEbrqB+TGW5UDz0fi1KdmAuFJm1h7YCAYCPlHf49xtZwrfn94yYzAGH63bGOXeA
	zNmqgOWRwkbhSqiOeEY3vueBQe1DUT/oL1yfui4j2InrRPr6hbtl3bIGb/UxG76w
	c9AaHmhVfj71vPsS1SA0y3pjJc9Rpsrajx4pCGGcadxSQ8T1yO3asQv7ESu7hYx0
	bTYu6fuXE/vI8iHcNZ9NGCj06THoRvLEitYXMUnGS9drwg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ctja2awdu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 11 Mar 2026 01:45:29 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-50937c5b742so15967341cf.2
        for <stable@vger.kernel.org>; Tue, 10 Mar 2026 18:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773193529; x=1773798329; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MnvYoQz83uuHbndV1q5nJmq+tn2JTM91TDSnDm7YcUk=;
        b=ffjZc9XNnC3iTGt9sAYTjR5oFxXs0ff9XMoCtnay1UCNPmaOuj2rqe815syF5Jqcdu
         zocDcLzIee+DYZbRB75T5qBFICSa1MdRtN7Phs2tLwFX4CRPtUA1ezaSiYEvHCb3XkTR
         1O+OmVroAdH3vhGsCsYaky6Iv2BTleNCmULvyl9Pi5SVFp+suPGAhU5Vyrfed8AuxVI1
         kfS/PNIxSsrrnJNZkT3PjEKCmSZORT+d7L6E6ljSdaYPeBYKIgmsE78aioHJZphgrkrn
         pGe6hE8k8Qi0378QnLrMopPIhIPnJdxls4Cyunba361Uw/ME4VvEIQDffrrD4/l6yp9W
         gr9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773193529; x=1773798329;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MnvYoQz83uuHbndV1q5nJmq+tn2JTM91TDSnDm7YcUk=;
        b=JGAQtXo6Q4JcDZWiIPSNpNgitbO/4pdVtlEMcO9KSIjiDTlioR+OWaF7+SZg+Y9W9L
         OsC6se+FA/tJm66O+p8K+VFxkIgCGvGmqpSWD7LbMm2uRXD3PlYJyn51/wrPLg/ZBAXf
         6zoZqsOF5U8K5WMxdVbUfy8CLccmiKvmuosgfMIBa+Segof/Sa/1SpOxo6SeBM9hL4Wu
         c5+JEsNROiAmpZBER6Lyo8PfShfMQBbFGN3JKBjnLSmB9Lb4bChew4g+omMlFN2q0NNx
         jgm6JyNB903Pwfs0ZeMUTpZ8JQHBnCf9ryEK1fYHWJqmw5qlL4LmJCqnFRNf/iLunhO1
         cIug==
X-Forwarded-Encrypted: i=1; AJvYcCV/pCuI1L0nisxtOS11PEtPgsXqssTddbseUoKG3JKQHJveJNQ87q54UB+cxQVEVO1DailRovI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGCQ65swdHgZJePKotKbP4LjL46gi1CewRGG6iETpHmhLFS7WG
	8TLt3KEwg2E/RUpUfoaLRgOuKlPV2/Id7Lm3STEXwlfK2/m2/O87V13mE3cDSoOzIcHkeSaLs3/
	W5/HA7UlgpNofgJkEnqXZXAU9f6b3Yxx/Gu1ptOBN/2chCW2750BHKpR6+nM=
X-Gm-Gg: ATEYQzyp3RYodlirRpLSNHnV/XO1jKF253vHLbu+FCw6rDb9DwrEM3V/IGXBffklMvU
	mJl4jnVQTRB5838ckN90l/SMGYho496wAPS8NFertN0UdSZgR+KlKf9FwxODyTGrEczUtvqwz3W
	egYkeG9S+FTZpTzoUEcCDPSGkyWO+OLVVZo48AxO3/janNzjY74vs5I8oHDfRa318qmumApk54Y
	R6E9pa/dArlCrAhlf0VvyLa5lUCj9ERDs0EJTuT3YjpQjGI4qKDfbmAK/MXXrH91arrjl33ZQXF
	+9bebn2BLuzngfTAUQss3ADrG15F91PLWoIaKtHQaUYDlLTF4aqiLw4dOSInJ/1pXhDFeDkr7rJ
	9nS2vCAYW+UoxIDKlo9mBYLz7nl6gCd94zqtj8z6yOyBmgHS3mT8tRau640hwFZPnk11MGjKSVY
	PBJW7Bx9eq6BEoLVBAuS+An25CQU0NhqnmtCU=
X-Received: by 2002:a05:622a:180c:b0:509:379b:d48 with SMTP id d75a77b69052e-50939f530camr11693121cf.9.1773193528718;
        Tue, 10 Mar 2026 18:45:28 -0700 (PDT)
X-Received: by 2002:a05:622a:180c:b0:509:379b:d48 with SMTP id d75a77b69052e-50939f530camr11692941cf.9.1773193528307;
        Tue, 10 Mar 2026 18:45:28 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a155f33be6sm132524e87.7.2026.03.10.18.45.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 18:45:27 -0700 (PDT)
Date: Wed, 11 Mar 2026 03:45:25 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
Cc: Srinivas Kandagatla <srini@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vinod Koul <vkoul@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 4/7] slimbus: qcom-ngd-ctrl: Register callbacks after
 creating the ngd
Message-ID: <auuvpevzpawojqo2girimhfaudtueukbgibklfzwiseslpswmg@qto5chpsermz>
References: <20260309-slim-ngd-dev-v1-0-5843e3ed62a3@oss.qualcomm.com>
 <20260309-slim-ngd-dev-v1-4-5843e3ed62a3@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260309-slim-ngd-dev-v1-4-5843e3ed62a3@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=c9WmgB9l c=1 sm=1 tr=0 ts=69b0c939 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=1m0rO8gg5OcOTR6atC4A:9 a=CjuIK1q_8ugA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: 28x2v9PKFksiIUHxeZtZK-z1QyOGP4Kl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDAxMyBTYWx0ZWRfX1oXD2NDC51Vk
 y8crLjfUqouSIofPIgqHCwBxNPMuTdr40qoZgWaDcbnqLyGiuMGjFiwQFdGDdRKLsA5LmPwa3Yj
 qQNZqj9EZCxctZUA1Vh1+6Wpa58FfLPaNZ3d0cW0om/ew3CYMUyix3ZrJagja4fRGMVCtZByqxs
 GV3L90ToaFJDkoN91O3m+/M8UQqvGniOff02Vn8G+B67moSyIZMlc0fhAgk9xRhClNMZIULS6bd
 CnwwZ58nraYSYtM44RQu2MZ2QkcE8M3ACLaDpx1wwlpnuOfyschoYj2Uu8UC2F/zyCarrE0RZPH
 NjMIAiwXi9KbVqPnUXIjwqL87B6jdg0Gtd8ACJ/xkAn9hlZzsRGB6YU092HLiD1sf+Zx8XyOr8y
 Edpaao9tOFuxrIBsD6QO5Yqo4rZNGwx3ywt1zSMsoZIaOwRMq7P5N2kVHQt+lDMg7ETDvtkXZei
 J6MCVhQvMejoApVBAfw==
X-Proofpoint-GUID: 28x2v9PKFksiIUHxeZtZK-z1QyOGP4Kl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_05,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0 spamscore=0
 clxscore=1015 impostorscore=0 phishscore=0 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603110013
X-Rspamd-Queue-Id: 01E3825A78C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-224625-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitry.baryshkov@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

On Mon, Mar 09, 2026 at 11:09:05PM -0500, Bjorn Andersson wrote:
> When the remoteproc starts in parallel with the NGD driver being probed,
> or the remoteproc is already up when the PDR lookup is being registered,
> or in the theoretical event that we get an interrupt from the hardware,
> these callbacks will operate on uninitialized data. This result in
> issues to boot the affected boards.
> 
> One such example can be seen in the following fault, where
> qcom_slim_ngd_ssr_pdr_notify() schedules work on the NULL ngd_up_work.
> 
> [   21.858578] ------------[ cut here ]------------
> [   21.858745] WARNING: kernel/workqueue.c:2338 at __queue_work+0x5e0/0x790, CPU#2: kworker/2:2/116
> ...
> [   21.859251] Call trace:
> [   21.859255]  __queue_work+0x5e0/0x790 (P)
> [   21.859265]  queue_work_on+0x6c/0xf0
> [   21.859273]  qcom_slim_ngd_ssr_pdr_notify+0x110/0x150 [slim_qcom_ngd_ctrl]
> [   21.859304]  qcom_slim_ngd_ssr_notify+0x24/0x40 [slim_qcom_ngd_ctrl]
> [   21.859318]  notifier_call_chain+0xa4/0x230
> [   21.859329]  srcu_notifier_call_chain+0x64/0xb8
> [   21.859338]  ssr_notify_start+0x40/0x78 [qcom_common]
> [   21.859355]  rproc_start+0x130/0x230
> [   21.859367]  rproc_boot+0x3d4/0x518
> ...
> 
> Move the three registrations of interrupts, SSR and PDR until after the
> NGD device has been registered.
> 
> This could be further refined by moving initialization to the control
> driver probe and by removing the platform driver model from the picture.
> 
> Fixes: 917809e2280b ("slimbus: ngd: Add qcom SLIMBus NGD driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
> ---
>  drivers/slimbus/qcom-ngd-ctrl.c | 52 ++++++++++++++++++++++++-----------------
>  1 file changed, 30 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/slimbus/qcom-ngd-ctrl.c b/drivers/slimbus/qcom-ngd-ctrl.c
> index 09ce3299e15c25b1b9cf6b1559850adf4aa20737..76944c515291a62fb9cb192bec5cd5c2caa542f4 100644
> --- a/drivers/slimbus/qcom-ngd-ctrl.c
> +++ b/drivers/slimbus/qcom-ngd-ctrl.c
> @@ -1613,6 +1613,7 @@ static int qcom_slim_ngd_ctrl_probe(struct platform_device *pdev)
>  	struct qcom_slim_ngd_ctrl *ctrl;
>  	int ret;
>  	struct pdr_service *pds;
> +	int irq;
>  
>  	ctrl = devm_kzalloc(dev, sizeof(*ctrl), GFP_KERNEL);
>  	if (!ctrl)
> @@ -1624,19 +1625,9 @@ static int qcom_slim_ngd_ctrl_probe(struct platform_device *pdev)
>  	if (IS_ERR(ctrl->base))
>  		return PTR_ERR(ctrl->base);
>  
> -	ret = platform_get_irq(pdev, 0);
> -	if (ret < 0)
> -		return ret;
> -
> -	ret = devm_request_irq(dev, ret, qcom_slim_ngd_interrupt,
> -			       IRQF_TRIGGER_HIGH, "slim-ngd", ctrl);

This should be still called here, with the IRQF_NO_AUTOEN flag and then
manually enabled after registering the subdevice.

> -	if (ret)
> -		return dev_err_probe(&pdev->dev, ret, "request IRQ failed\n");
> -
> -	ctrl->nb.notifier_call = qcom_slim_ngd_ssr_notify;
> -	ctrl->notifier = qcom_register_ssr_notifier("lpass", &ctrl->nb);
> -	if (IS_ERR(ctrl->notifier))
> -		return PTR_ERR(ctrl->notifier);
> +	irq = platform_get_irq(pdev, 0);
> +	if (irq < 0)
> +		return irq;
>  
>  	ctrl->dev = dev;
>  	ctrl->framer.rootfreq = SLIM_ROOT_FREQ >> 3;
> @@ -1659,24 +1650,41 @@ static int qcom_slim_ngd_ctrl_probe(struct platform_device *pdev)
>  	init_completion(&ctrl->qmi_up);
>  
>  	ctrl->pdr = pdr_handle_alloc(slim_pd_status, ctrl);
> -	if (IS_ERR(ctrl->pdr)) {
> -		ret = dev_err_probe(dev, PTR_ERR(ctrl->pdr),
> -				    "Failed to init PDR handle\n");
> -		goto err_unregister_ssr;
> -	}
> +	if (IS_ERR(ctrl->pdr))
> +		return dev_err_probe(dev, PTR_ERR(ctrl->pdr), "Failed to init PDR handle\n");
> +
> +	ret = of_qcom_slim_ngd_register(dev, ctrl);
> +	if (ret)
> +		goto err_pdr_release;
>  
>  	pds = pdr_add_lookup(ctrl->pdr, "avs/audio", "msm/adsp/audio_pd");
>  	if (IS_ERR(pds) && PTR_ERR(pds) != -EALREADY) {
>  		ret = dev_err_probe(dev, PTR_ERR(pds), "pdr add lookup failed\n");
> -		goto err_pdr_release;
> +		goto err_unregister_ngd;
>  	}
>  
> -	return of_qcom_slim_ngd_register(dev, ctrl);
> +	ctrl->nb.notifier_call = qcom_slim_ngd_ssr_notify;
> +	ctrl->notifier = qcom_register_ssr_notifier("lpass", &ctrl->nb);
> +	if (IS_ERR(ctrl->notifier)) {
> +		ret = PTR_ERR(ctrl->notifier);
> +		goto err_unregister_ngd;
> +	}
> +
> +	ret = devm_request_irq(dev, irq, qcom_slim_ngd_interrupt,
> +			       IRQF_TRIGGER_HIGH, "slim-ngd", ctrl);
> +	if (ret) {
> +		ret = dev_err_probe(&pdev->dev, ret, "request IRQ failed\n");
> +		goto err_unregister_ssr;
> +	}
> +
> +	return 0;
>  
> -err_pdr_release:
> -	pdr_handle_release(ctrl->pdr);
>  err_unregister_ssr:
>  	qcom_unregister_ssr_notifier(ctrl->notifier, &ctrl->nb);
> +err_unregister_ngd:
> +	qcom_slim_ngd_unregister(ctrl);
> +err_pdr_release:
> +	pdr_handle_release(ctrl->pdr);
>  
>  	return ret;
>  }
> 
> -- 
> 2.51.0
> 

-- 
With best wishes
Dmitry

