Return-Path: <stable+bounces-223777-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8KaULhTNr2nWcAIAu9opvQ
	(envelope-from <stable+bounces-223777-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 08:49:40 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A9E12469F6
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 08:49:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B4F31300D34A
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 07:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01EDD3644C7;
	Tue, 10 Mar 2026 07:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nFTWXqOi";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BLryLWZ4"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2278363C4C
	for <stable@vger.kernel.org>; Tue, 10 Mar 2026 07:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773128978; cv=none; b=HYEMPxk7n0rqrPF0gf+sYOj9noutM4net2GZaFBK+lMs+p+Pq1hUkg67n1DJyzJO6CGqwO4ITGo7s4Fr9+DlCfcsu0gbMvdglnv5OU2g3hnwd43qJEWmW00l8WVYPtyXONanXQzu9yqbQXMH1gZ/JIXvG0BYcXsa6I4KWAOTsqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773128978; c=relaxed/simple;
	bh=It3ms7EIy4dmxaWQD/Orfr4adYAkDCvqX0LSMJzNLwA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I5EY/+nLzPsYaGS3HX9gr3M9jCDWQMfx/sCqnpXWvlTVH+DMOG8hFsHHB3jVZaGQwGpH/ET8QvqBl57vGIT6Pk6qF9M+NjGJ0hBm6hSLmIAMVALcNDjkDii/M/+oTQnDjGZqrx5lq17V5i/ocNeRbvifCTGzfcoeht0GLYzbNgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nFTWXqOi; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BLryLWZ4; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62A2Ee8j2363996
	for <stable@vger.kernel.org>; Tue, 10 Mar 2026 07:49:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=wTTtsMPKkibaIuhnYjbzK5Ge
	RXMToz1A0g7v6k/rrDo=; b=nFTWXqOiakvMHVEXUEsri/CEzVXwpKCY+7/nTM40
	fTj36Cb/Y4MH4Bj+N1nEeJZp9nNlR6KCcHllgmhZSWwabdht8HrF5sykJprQtTmS
	tpQ+Bv17umaWGk2fzwZEE3nzgmBK98fFQtOZ73mRaHSSF3j0vkLn9G6rK+WwfDH7
	gb78h6pDiGlq8B9oHTgDYGAt3/E+LT9BMpwOsJA82Q3PxASQBsTOpqL/uVXuNj6u
	PT8MtZYT1MYEO8WGLzilzU7Crx9hZ24Vhnr9gyVD7ov2S6zqs/IsLndsJOgXNvih
	kLtLzNNOdj8XgtCAcXTMjjojdvs3UEWP6yLAC2Jq+LR1yQ==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ct032b4um-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 10 Mar 2026 07:49:36 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c7378ffeeacso24254307a12.0
        for <stable@vger.kernel.org>; Tue, 10 Mar 2026 00:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773128976; x=1773733776; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wTTtsMPKkibaIuhnYjbzK5GeRXMToz1A0g7v6k/rrDo=;
        b=BLryLWZ4Atfx3hy6VZqlp1o/u3drv85xxtm/NLfzE6VpWLGw+DanyVbkD15ms5qfMx
         oX/bvcJyG3T19IkrArxhzJHL5Fx4+8qaaxLKUw+IXuPtjnXYmhS0nSyCBnuEEItjmdJJ
         NlrQ6Og4wSse/+lnq7BN2CVUo2s5zAvV3QATRLpNbdFURwHpGEAvYMThZAYr1uVQLl1E
         J8wqr1M+ETd3ihZOhp/aRo3hqwAA/Tds036MN/PrXZlfBCcLibZIS5y3f2p0On7g54Du
         OwoNZrkVKQxndKkSAG0ZzU6+0G7fffXWX9+ZZcGr/vxm1eksfJUHhy61tuSK3wWiHEp9
         /SJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773128976; x=1773733776;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wTTtsMPKkibaIuhnYjbzK5GeRXMToz1A0g7v6k/rrDo=;
        b=BmhE3yu0mIqVnYJcYgJ4TkwW/tBNEo60SCXmkAveHYXJf7qyfannUlLw/UEUQE1GYl
         MP8MohCLLW16dgJSrlAumnD/ktEfgTCtKBWHp3+t3+LlQ551e43E3T7AJiYUZjq1Fku6
         uQUaQIBVtX+IvSaXRgMV8VmSgxHX0EKzP9Bn3h579vRQCvEuP3MA3pfZaYRx808AdJVm
         jEpicJLCV9dR1rox4qHyL8x0HcLqPJUmKcBu61O/NsWZnl4Qul4D+wavqhdcxNHaVhcC
         a1zyqh5motGxTlmTCtfby6zV5w9o5kojWSiOu/BIkVGkSb+YDnWswKsH0Kqq+oYnnXY9
         6CHw==
X-Forwarded-Encrypted: i=1; AJvYcCUYcEqlv/38CP7T1EUkefM96QKww/3x7Sp7mMVOdA6bu4HZW60j81EGChrLc508WDdZRn83UN4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZ1gqtpd7kdeeg1z9jNIrlvlwKob/AiVwo+MEzTGKVlgAGvfIG
	FNoWj9eSPNA/WJidquonxIQf3MJxYZL0Z9iKkZFdpFaA49alA+TKyWLVxhu86fYk+XTBKyKzDjG
	aG+JXOBou1P5jCAzoYAtT+0djWLA2YmKGes7ZNmcJNFSq8AZrlWvahwynulU=
X-Gm-Gg: ATEYQzy32uGO0EF5UB0/fItnhsaTBN8qBRvuuzkfE48QrD9KXG1wDjXar+fkdPnVpc2
	ZX/BiTu/wnwk3RhSdgvKWC6jLDomqT99QZpL48P45o8bpp1oHkFybLL0A7olPySTgS61LpbOb5c
	c2b/kZwQ31HtVLUFX/VGW47+MND9NtE+AkkwYNld0Uf3L0KRQU5fUilrSvTZIKCG+0s7wGP0gdN
	tkcFfQSJgSjIyaSbh9badxkkP1yLiL5zc44YefuhvzeMALvM0UxC66uYqshvyJ7lskKoO9n1uwy
	++jAxB3uZF2f9C9B60m1H6X+XufQRIL4SlM7NHKbi08WvBln00uuAwNHZ4+5Kh5o2Ugtof4pODY
	sHBQr1cAhyxATt0FgMg704o0fkMr0wrYuoD7ZH86qhGfA7yxS
X-Received: by 2002:a05:6a00:983:b0:829:7e6d:cf20 with SMTP id d2e1a72fcca58-829a30dfcb6mr11809505b3a.58.1773128975373;
        Tue, 10 Mar 2026 00:49:35 -0700 (PDT)
X-Received: by 2002:a05:6a00:983:b0:829:7e6d:cf20 with SMTP id d2e1a72fcca58-829a30dfcb6mr11809469b3a.58.1773128974611;
        Tue, 10 Mar 2026 00:49:34 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829a465b702sm12518109b3a.20.2026.03.10.00.49.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 00:49:34 -0700 (PDT)
Date: Tue, 10 Mar 2026 13:19:28 +0530
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
Cc: Srinivas Kandagatla <srini@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vinod Koul <vkoul@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 4/7] slimbus: qcom-ngd-ctrl: Register callbacks after
 creating the ngd
Message-ID: <20260310074928.sqqzyw6v7dm3j32c@hu-mojha-hyd.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEwMDA2NSBTYWx0ZWRfX0jPEywMBcrc9
 FTqUZZQrU+9CNXYACvjrko+1FOA1nZaZdyO/RC2CaBxN6qBGGFNlfJnxS6fziAd6IAOu9DpEM5L
 oXBk4EdPfZ3GizW6iJroP8bFuM7Dlw2xO5AM0VUh8niP2oMcj5z1NZ1db2qmWRESFoU9VIKHFqz
 AmXvXVI2Oaku3PbOvxY7W5XbF1kr9/r8ajpLuTBB3YXb2k9A27nqsb9+ikmaAM+dWTOzUE2mf5G
 viGbH0eMrOC62IiQYH0Gsfi9CO0vi+C2dX/n3jMW6/X3984JYycpPlaOqJWsTrdwu+Z490ZJiia
 w6Kl3RtA7kDQv5MkUqm9iWuq0v7mxuaGmoIorO6MGKth6ZFLeET9h2CpkiVcaqRx9ErI54jot+8
 0dHvY32CElxPJsWRtmTMOn1tZl7DPYGISicl2Ee2bC/En9nUokpPVsepy1b1vFACOMznHB4i36A
 OyfOFd9ArG7d0xVtwdg==
X-Proofpoint-ORIG-GUID: tl8OQBH8v-azkoo7NHup7xQMgEJTol4D
X-Proofpoint-GUID: tl8OQBH8v-azkoo7NHup7xQMgEJTol4D
X-Authority-Analysis: v=2.4 cv=WtEm8Nfv c=1 sm=1 tr=0 ts=69afcd10 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=kj9zAlcOel0A:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=1m0rO8gg5OcOTR6atC4A:9 a=CjuIK1q_8ugA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_01,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 spamscore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603100065
X-Rspamd-Queue-Id: 4A9E12469F6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[hu-mojha-hyd.qualcomm.com:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-223777-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mukesh.ojha@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
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

Reviewed-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>

> 
> -- 
> 2.51.0
> 

-- 
-Mukesh Ojha

