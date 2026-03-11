Return-Path: <stable+bounces-224623-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kEqUMVLHsGnTmwIAu9opvQ
	(envelope-from <stable+bounces-224623-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 02:37:22 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 54FF925A64C
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 02:37:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 510A93056653
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 01:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 250FB36E491;
	Wed, 11 Mar 2026 01:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PDRn8tRU";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WH2IQP8r"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0FA631A061
	for <stable@vger.kernel.org>; Wed, 11 Mar 2026 01:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773193037; cv=none; b=CF7MEK0v+TYOMwfl/PEq7floIsOQKw7NlCse6XKTlpccuBzOFxXq6KwT1e8oEyalsL5ylt5/NOe6Hjts/35nU7wqrAVnjdA2YPVQuUw+PDytY1e2JEau9AQxzcsLz0x5pk7nSB/BrpjKJ1QBQVBwxhDFmLp2qizT6Sl1LHi/JWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773193037; c=relaxed/simple;
	bh=sY4VrqF9ohYtCj6dkipnxOwbA4CLc+4Y+UVOTFVVRy8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kVVekWmUYATXbhf9l0rd2LI9FFa0I2m7GREl9xjnsBYKF8TGAhXrluyk5HRRN/716x1d+1ORuD9ZceLX1wPls11FVR+e5CA/L6xPQNoFsR92/oRKkIYlvwuZzq6Goy9bUngKGkDf3Yd+1LhkTQQ4di/yPq4INCVLPyoCsPq9+Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PDRn8tRU; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WH2IQP8r; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62AHbLKp248352
	for <stable@vger.kernel.org>; Wed, 11 Mar 2026 01:37:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=gcSQWdzB0re7FA2BhCO5FeuR
	05PyZU31s8Lle7bw8c8=; b=PDRn8tRUePtAKL42DAP8O3BQnzPR77oGDljViZes
	yld1CInidI1Mo6d5MwPm5/oXAVRqKvFvhRw8GHZUgCA2jETar5G8id5/6osNScOk
	a0FzdY1PTYERk/UGqEn7Hg1rPRbPCZX4ehZnYbLpup2OW0Mr6sRg4NDzf0bAxA92
	wXpiK+Gz+KC3ml/G56xCYZWKzTh7qmd642+8efNSpWaXAkuGbNVd6AUTwGQqPYMd
	C6FS7tgm2IUZAxDu8BlLRsLTA633Tj7r/n6X0Qc1sbEqMr3umVrdSjotemGexfR0
	o5lOKCw9JqCE7peVAXRUcre63NM27seGjCQH89YZXBOC8A==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ctqv11c3b-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 11 Mar 2026 01:37:15 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8cd849cd562so1687526085a.0
        for <stable@vger.kernel.org>; Tue, 10 Mar 2026 18:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773193035; x=1773797835; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gcSQWdzB0re7FA2BhCO5FeuR05PyZU31s8Lle7bw8c8=;
        b=WH2IQP8rd3f/+8Yd5jNXvxakIVV/e9YUZqn1zufITQf74sYzn9Ck5l6QybchytBBIl
         yTdesW9m4t62n7fsfE1H5HmEoRJ3QEWNukXV7nVfJ+r+TXw2dOcWeFYw1uBz4yp+ZEY2
         AfthL8idNF9CiiE+ReGvmpaeCBIgiFVz2/AKkxGsf+hXIuR+190A6f0nBraVaOjYW6HT
         LYd8irbulxN/0tRfO2Wsn5PAJ4tesLvtw9WZDWLDoQX88rcHWmbsZ8vFroPO/5TmuggK
         5teQzLU1FtGF/GamsZ2zicTOMBBmtL/faBAqi5wDYZeRZ967vnTaoerVnzpx9S6Nqr6/
         x5cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773193035; x=1773797835;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gcSQWdzB0re7FA2BhCO5FeuR05PyZU31s8Lle7bw8c8=;
        b=tP3sGFJj9Tyf1fQOKioiaPBnGrsCC6d1CweH3ljjeqX5mbz+YNRT8v39PFK+N4K8uW
         2Gsg2ziPRullMYg4jiHo78E1zwq/+kKN2Nsy32uIFtmlq2u9TSE3t42IjsUkrBaMU/w1
         kXjykTyEW2pByHuXThhPJMqdOW0zKSm6Cxm1/Q0TX/nUCu1Lg2rsQFgl1WC7JfvB5xkk
         VKvusAYc9SAmpy4WK+mltGvCMVIxGhQr0Nf+IIwCJz6NqJg+p3BJQgkq1MIT0IkeWDNY
         U9nFg2mpAosVZTsL2mcikBPSoy3L0D8SMPOnrogz/L4mcNuuT+zt0uOljzg2Wyb0JW4D
         uwlg==
X-Forwarded-Encrypted: i=1; AJvYcCXYsEcB685QI41EnzkwXZhQEL0FaTQHbPjg753S4EJKW18VuZW7zye/HCHmEQuhDGkC8qcHeUc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrPa3TaS4YCB7O13ERL+CBN39Py+TpztY/SOmlLLgojgso0WMf
	0SO1BBcwbkUeRTu3YylvwLniqTD4P84gfBkrgf1w0LQgu81Lx+AGgQz2qCFj4Q56I0zHJlPFjEl
	yRgBW7npjpEKXOSQBEtiiwjhFNjs0Tc27A81lEymbkud/2po/SfJbPskbQTk=
X-Gm-Gg: ATEYQzxR+v5Jl0GNtQsT9FRwEBMuvUZJNO9+70tAkbAeciL/kS1u67p9a0kdmcj1exh
	nFTslj4dj6tIZa/RO1LZ6ox/eqNoavEdWZ7VVpeFggaQ6n6KTdRnLKMs0jmSJyt1aBYGKS9gNcU
	wsDueiH6qtEbrsGRPGuiconhqRISyYm8sVhdI77ldBLsky4jqPER1QQt7vJkvsldEIGTmG0AsAB
	7y5OwQeVuxDWWNJqnxakZxylgTtHlYcBfB8CKuHW1u5b/IM7qp2MZ5w6BF0VPNtXNclF4JH8Dip
	WKdFaSg6TNQoIzjIZ+pwH8F0e839o7OySlXcXPw+zt5M1qoyVk82h2ZEhpmlZa6PRyL/TKsHbTs
	K8pyW1GoxeslgtATcQ5Pcg8FBVJfNsZys/Hcx1kqlv8Vwmso2PxZYfCuFv1Qx8PtfT7m2TOGbOl
	7ssBZEBcksZsZzzOq7K1AVgKGDs9hIwyc7yUA=
X-Received: by 2002:a05:620a:7103:b0:8c6:db3a:3735 with SMTP id af79cd13be357-8cda1936e12mr126921485a.5.1773193034949;
        Tue, 10 Mar 2026 18:37:14 -0700 (PDT)
X-Received: by 2002:a05:620a:7103:b0:8c6:db3a:3735 with SMTP id af79cd13be357-8cda1936e12mr126919685a.5.1773193034394;
        Tue, 10 Mar 2026 18:37:14 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a156366a7fsm131098e87.76.2026.03.10.18.37.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 18:37:12 -0700 (PDT)
Date: Wed, 11 Mar 2026 03:37:10 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
Cc: Srinivas Kandagatla <srini@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vinod Koul <vkoul@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 7/7] slimbus: qcom-ngd-ctrl: Avoid ABBA on
 tx_lock/ctrl->lock
Message-ID: <eyitss5zwougawqadgpfb2xa3tv6nbqtlte3iou5aut2neuptw@ehktjxi66a33>
References: <20260309-slim-ngd-dev-v1-0-5843e3ed62a3@oss.qualcomm.com>
 <20260309-slim-ngd-dev-v1-7-5843e3ed62a3@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260309-slim-ngd-dev-v1-7-5843e3ed62a3@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDAxMiBTYWx0ZWRfXwP4lmA8wTbeA
 q2EMRC58zr0CLm8kxrGMwnjIYmcDnap1sZ593lq2pTi1IoAj8dUWcIR15YR1knrXNkp/EqABW4d
 1+Y+h7oHBEWUNwhkDjj3smTJiPsK5tC1aN3uQ6UA1G1BkeXii89gQJjR1ljK2IZz+YeRMeZ08EC
 Yt36VGCP3D8r+FsjWCjk78NFrEgSVCvHiXUDCSrOYvAuROh2hyzzMS7LuLCeg0fzlp5RfobIYBl
 /Lp/zyvbmKPjNxRdsu66wsWxFpBbc48OSsup+wY1wiVNs+fI4Ps8lYd9V1n07w4OfQgb/wrcsHc
 lfR/05ZgNI/RAp1Ia2I01cXl5G/UCvOr00RSn3bHZUpnglFnVWsyxxfgOIf/gBq/ZIFJSVJ8Sma
 /UsZ9BorrjXy57eUvxPYsDxWNiz4ghIL9KtN66R6Bz3azrOJrdkVgeHqSWKoosxjPigcQtqLJY+
 P0ERVMy+wHRScGWFPjA==
X-Proofpoint-GUID: Clhm-VqRM8Qzvhnpjyln2kcaW3-SslUv
X-Authority-Analysis: v=2.4 cv=S5vUAYsP c=1 sm=1 tr=0 ts=69b0c74b cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=hSI2FgT3CeMcK4FCQxQA:9 a=CjuIK1q_8ugA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: Clhm-VqRM8Qzvhnpjyln2kcaW3-SslUv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_05,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0
 malwarescore=0 adultscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603110012
X-Rspamd-Queue-Id: 54FF925A64C
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
	TAGGED_FROM(0.00)[bounces-224623-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitry.baryshkov@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

On Mon, Mar 09, 2026 at 11:09:08PM -0500, Bjorn Andersson wrote:
> During the SSR/PDR down notification the tx_lock is taken with the
> intent to provide synchronization with active DMA transfers.
> 
> But during this period qcom_slim_ngd_down() is invoked, which ends up in
> slim_report_absent(), which takes the slim_controller lock. In multiple
> other codepaths these two locks are taken in the opposite order (i.e.
> slim_controller then tx_lock).
> 
> The result is a lockdep splat, and a possible deadlock:
> 
>   rprocctl/449 is trying to acquire lock:
>   ffff00009793e620 (&ctrl->lock){+.+.}-{4:4}, at: slim_report_absent (drivers/slimbus/core.c:322) slimbus
> 
>   but task is already holding lock:
>   ffff00009793fb50 (&ctrl->tx_lock){+.+.}-{4:4}, at: qcom_slim_ngd_ssr_pdr_notify (drivers/slimbus/qcom-ngd-ctrl.c:1475) slim_qcom_ngd_ctrl
> 
>   which lock already depends on the new lock.
> 
>   Possible unsafe locking scenario:
> 
>         CPU0                    CPU1
>         ----                    ----
>    lock(&ctrl->tx_lock);
>                                 lock(&ctrl->lock);
>                                 lock(&ctrl->tx_lock);
>    lock(&ctrl->lock);
> 
> The assumption is that the comment refers to the desire to not call
> qcom_slim_ngd_exit_dma() while we have an ongoing DMA TX transaction.
> But any such transaction is initiated and completed within a single
> qcom_slim_ngd_xfer_msg().
> 
> Prior to calling qcom_slim_ngd_exit_dma() the slim_controller is torn
> down, all child devices are notified that the slimbus is gone and the
> child devices are removed.
> 
> Stop taking the tx_lock in qcom_slim_ngd_ssr_pdr_notify() to avoid the
> deadlock.
> 
> Fixes: a899d324863a ("slimbus: qcom-ngd-ctrl: add Sub System Restart support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
> ---
>  drivers/slimbus/qcom-ngd-ctrl.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/slimbus/qcom-ngd-ctrl.c b/drivers/slimbus/qcom-ngd-ctrl.c
> index 54a4c6ee1e71fe55794f09575979826d9aa5be9f..75d70de0909a8d17e2410d30f7811f32d5eebea3 100644
> --- a/drivers/slimbus/qcom-ngd-ctrl.c
> +++ b/drivers/slimbus/qcom-ngd-ctrl.c
> @@ -1471,15 +1471,12 @@ static int qcom_slim_ngd_ssr_pdr_notify(struct qcom_slim_ngd_ctrl *ctrl,
>  	switch (action) {
>  	case QCOM_SSR_BEFORE_SHUTDOWN:
>  	case SERVREG_SERVICE_STATE_DOWN:
> -		/* Make sure the last dma xfer is finished */
> -		mutex_lock(&ctrl->tx_lock);
>  		if (ctrl->state != QCOM_SLIM_NGD_CTRL_DOWN) {
>  			pm_runtime_get_noresume(ctrl->ctrl.dev);
>  			ctrl->state = QCOM_SLIM_NGD_CTRL_DOWN;

What will protect ctrl->state from the possible concurrent modification?

>  			qcom_slim_ngd_down(ctrl);
>  			qcom_slim_ngd_exit_dma(ctrl);
>  		}
> -		mutex_unlock(&ctrl->tx_lock);
>  		break;
>  	case QCOM_SSR_AFTER_POWERUP:
>  	case SERVREG_SERVICE_STATE_UP:
> 
> -- 
> 2.51.0
> 

-- 
With best wishes
Dmitry

