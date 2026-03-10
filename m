Return-Path: <stable+bounces-223779-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QBFnC0nOr2kfcgIAu9opvQ
	(envelope-from <stable+bounces-223779-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 08:54:49 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C9519246AF3
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 08:54:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 40188303299B
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 07:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0862E364EBA;
	Tue, 10 Mar 2026 07:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Q2LeOYx8";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XMczXr1f"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86795362127
	for <stable@vger.kernel.org>; Tue, 10 Mar 2026 07:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773129284; cv=none; b=UF7kx3mktBwGbaaGoSwlxWdCK8BVI694sSSh8nDRpXP1FinR3btyGgdUyDVVcccW5+16e9+mTXKx6bOWWUxsHhxH1yPkwlGD4Ej1l7rlr+GhtFPea+3IOP11XG3W56Uy+G1rJR2xvJV/Rl2HeexNqD4zQ7W9iMRj5cGnlwuDNsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773129284; c=relaxed/simple;
	bh=gNInfhjd6MISyIxpaQFrR/jdhlcl9F16klySSUxMkGk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CbHXs4J//xNlvaJD8T9YNAD34S5W4GDz71itl2KFUQqhO7mguKofdcCmFOxYlbKEMGbOJzZtXNjO2Fjaed/obosDsBAF5ADNX3I96mQfwMxTVNmz17uVywlh8DrXtJ8d4piQqpmeh4y+bowNahoMENOvkHsezEeUJ/7+ipLhqaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Q2LeOYx8; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XMczXr1f; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62A2EI0r2362950
	for <stable@vger.kernel.org>; Tue, 10 Mar 2026 07:54:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=+0oCbgUSnbR1XCQY05IPXN3M
	te7+uEnIM7kPBZI0/2M=; b=Q2LeOYx8VRu5+XO2x+zpD/h1ScmVF3mIRHF+m44H
	Hl49ara2cSreUZQQ6elDA7NLKjHl4UE1fnRBkt7SumHsn5MYUZUckYlPjTiflhvi
	x+oSdV4oolnDKjw6+m/SsqZnrGMawLPTuDdMt/z6TeYYFsS88qG4w4uoXLMzMbi0
	C00jyyvgYU7pcY1qArmz/CtxZ3oDzaeBbCHML3q8ulysz3FlyqLJ+N60Sh/XWVgf
	Gk6koNnFi0ZLVCOGSa2j0MCzi2IOQeIj6NRZKSGaLrkVp2eke1M+YR+trtei1d6F
	xZcrEg86nTWSmkMkhZ+ANnxyerG/Ezn/KI3MMvo57GQAhQ==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ct032b5f3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 10 Mar 2026 07:54:42 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-829ad972df6so1466754b3a.3
        for <stable@vger.kernel.org>; Tue, 10 Mar 2026 00:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773129282; x=1773734082; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+0oCbgUSnbR1XCQY05IPXN3Mte7+uEnIM7kPBZI0/2M=;
        b=XMczXr1fPF6FuvxKlUvVmTs0yXBYJpl0X/Xx1T4n61GYCVwbUM2gOhGvhky83H2OL/
         /xr+YY2xsovfX5JpHsNkVwwWlm7gxHn9Ekwt+inNFbhnFTnSs/Q9ZwUcMHEFAmdl3flX
         p1o/CkLF1cWf3g2ome8Xza1MMkoLok2ZjjysdNUXYP+xVN9hnXYrmIEOL9QXZzfx8Tdq
         Tzw5Zxw2oFutUdRzmiHatxb72B+6NviLY/I1Y5BHhG/zmv7QdRa0umxNYpCxzcqi/ZAs
         5tD+JDqutSijKSRunOYMu0hOd9lCj4Zri/GRyiF9edb43Idy7ZDhTl55vVKBdkVAfev4
         TbgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773129282; x=1773734082;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+0oCbgUSnbR1XCQY05IPXN3Mte7+uEnIM7kPBZI0/2M=;
        b=NAjsa75p64elmqPJ+Ct7Qjpg92Lmf8rZ+/Uy9ctaiopa5Eu2W07AbJrM6dJm0M5KUO
         yuwRVsSCkEGQP/lcJUgL9sS4uBm91naclbETRnV3caTokyAPZlCiCfV0/G5Dhr4H0pJG
         Oytr0VRVm6QFssYfn6qL8vCmR7Wpcsm3KpsSdci9aDfARB/vFRnbVojCPVIPQDZ1HLKo
         2WKMG6yrmRz3GZt7aLh5yITfMhah1zDP4Q1jAnihE4lu0hi0GfvFLw8Om4osdEXZHbD8
         AKtTpA1YVx6LyTixmBYjElXQuFeZosMsLgRgvf69Pfe8yx9K1xtYaLdCtBeSWxlr2ffL
         UB3g==
X-Forwarded-Encrypted: i=1; AJvYcCXHQ/JnAyRYVOm+Hr7Epczxk+6mtxvm6Kz1Xh2oC3y/P10N2NrOMg/bq3YAewK94H4SCNbWewA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWlh1WXh096srq1TuCeq1w2Qs9tdwa5GKTPrce1MDAKobmAbEI
	1KAy1Jhl1Kj0Z0RWqD9MDW2It/qNBQKowlZ0c3jNAGym7zl+/X/jsmnLwhGRtRQ5kA0VSACV05Q
	UwRit8AzV+c1I7MQ0urV9jrEnheoMTGNXyD8e4cxS0LdbB6+YdFQ/vRu4Qmw=
X-Gm-Gg: ATEYQzxRUMpRCmyMOPi8XjVTghlRRzUhrVflOgts261gJIh1WYtWdHhhN8EF+J/L8jL
	/Ft0H2hWDgQlWDBFBsiXVRKoVos6YoIne1HMLOkY4Sh0/atcp3vdhN1esMBUjmvrwJ9Lj9YTarQ
	PIAsBo4nZ9Ho5ddiKLCzL+l5TAi3Kzh61y61Cr6LVTO8V18Xok5wYSihljHIf2uZEEDQ4N4ommE
	3wk0sUlVp0mqBcE9tF8TSaQK9aMU+Cs1YT+bL4NMBVwpa/sUH8ip/C0hHUYCTczxw2U/hIxdXo7
	Fw6RMrYwFerdJicP1iDCO7Bs/J4JSKa8IMVt2xqWu9c65kdN77Hy9SXj4jR6Nv9yi99ZXfB8+kr
	pNQnQfewrdZkwk5m3UmgnwIDyMg0pxRph2EBGrFiVgGTV4aBm
X-Received: by 2002:a05:6a00:2e15:b0:823:f96:63bb with SMTP id d2e1a72fcca58-829a2f8be9amr13946865b3a.52.1773129282128;
        Tue, 10 Mar 2026 00:54:42 -0700 (PDT)
X-Received: by 2002:a05:6a00:2e15:b0:823:f96:63bb with SMTP id d2e1a72fcca58-829a2f8be9amr13946849b3a.52.1773129281470;
        Tue, 10 Mar 2026 00:54:41 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829a4635d62sm13060340b3a.5.2026.03.10.00.54.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 00:54:41 -0700 (PDT)
Date: Tue, 10 Mar 2026 13:24:35 +0530
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
Cc: Srinivas Kandagatla <srini@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vinod Koul <vkoul@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 5/7] slimbus: qcom-ngd-ctrl: Initialize controller
 resources in controller
Message-ID: <20260310075435.sshej5qbahcyjxti@hu-mojha-hyd.qualcomm.com>
References: <20260309-slim-ngd-dev-v1-0-5843e3ed62a3@oss.qualcomm.com>
 <20260309-slim-ngd-dev-v1-5-5843e3ed62a3@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260309-slim-ngd-dev-v1-5-5843e3ed62a3@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEwMDA2NSBTYWx0ZWRfXxRgHWUugk8j6
 ADv98dOPp/XYAAWeW+GMTLW3gzgGvcdxLQYLDNJhyQ84afqkiBYpnWrcTPx3XlwP7S6LV5JV8mD
 +MT2joMucyXLd2xlvIpyl8+5Wy7DpKqHzV4T/DIZ53wtp+hsd8LGOPCcLdHlb3+0sK4wt2VVFCD
 /sAeIkp7bpjiDLhLRiQFiLKROA7DtE/hW/57x2IeZddwMRxhhg8U1pAb4y+cW92lIEpcYNCnuVd
 mda2AvrEUcr/EVSOeFTz6fs4emonQ/aDbOW14V94MtIlCELlT+Mt7poXoeCXMvxK1DTfz6mVVmI
 /JP+4bad7e6f4hv4S/ZZ9T+a216ci+GUWJ+ZKOhROSA20i370IQkjSvG/8if6WSA/UST6dcQ5LO
 vSMSc74nwsHhAW1w4OCvNTC8A813FvLxbY9ul1PGCoSNHYNxuNrYt0Y2WXiTfPWd2S36CNMbUSk
 yqK4wfhnF+E9BVTprQg==
X-Proofpoint-ORIG-GUID: AroHuEh-g4hh5OxCkZEo9CQrFHig1Nss
X-Proofpoint-GUID: AroHuEh-g4hh5OxCkZEo9CQrFHig1Nss
X-Authority-Analysis: v=2.4 cv=WtEm8Nfv c=1 sm=1 tr=0 ts=69afce42 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=kj9zAlcOel0A:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=gbuOVpkGrxRoZeIW0QkA:9 a=CjuIK1q_8ugA:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_01,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 spamscore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603100065
X-Rspamd-Queue-Id: C9519246AF3
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,qualcomm.com:dkim,qualcomm.com:email,hu-mojha-hyd.qualcomm.com:mid,oss.qualcomm.com:dkim];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-223779-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mukesh.ojha@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

On Mon, Mar 09, 2026 at 11:09:06PM -0500, Bjorn Andersson wrote:
> The work structs and work queue are controller resources, create and
> destroy them in the controller context. Creating them as part of the
> child device's probe path seems to be okay now that the controller's
> probe has been updated, but if for some reason the child does not probe
> successfully a SSR or PDR notification will schedule_work() on an
> uninitialized "ngd_up_work".
> 
> Move the initialization of these controller resources to the controller
> probe function to avoid any issues, and to clarify the ownership.
> 
> Fixes: 917809e2280b ("slimbus: ngd: Add qcom SLIMBus NGD driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
> ---
>  drivers/slimbus/qcom-ngd-ctrl.c | 38 ++++++++++++++++----------------------
>  1 file changed, 16 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/slimbus/qcom-ngd-ctrl.c b/drivers/slimbus/qcom-ngd-ctrl.c
> index 76944c515291a62fb9cb192bec5cd5c2caa542f4..d932f7fd6170773890f561e3af444ac2c5730338 100644
> --- a/drivers/slimbus/qcom-ngd-ctrl.c
> +++ b/drivers/slimbus/qcom-ngd-ctrl.c
> @@ -1584,25 +1584,8 @@ static int qcom_slim_ngd_probe(struct platform_device *pdev)
>  	pm_runtime_enable(dev);
>  	pm_runtime_get_noresume(dev);
>  	ret = qcom_slim_ngd_qmi_svc_event_init(ctrl);
> -	if (ret) {
> +	if (ret)
>  		dev_err(&pdev->dev, "QMI service registration failed:%d", ret);
> -		return ret;
> -	}
> -
> -	INIT_WORK(&ctrl->m_work, qcom_slim_ngd_master_worker);
> -	INIT_WORK(&ctrl->ngd_up_work, qcom_slim_ngd_up_worker);
> -	ctrl->mwq = create_singlethread_workqueue("ngd_master");
> -	if (!ctrl->mwq) {
> -		dev_err(&pdev->dev, "Failed to start master worker\n");
> -		ret = -ENOMEM;
> -		goto wq_err;
> -	}
> -
> -	return 0;
> -wq_err:
> -	qcom_slim_ngd_qmi_svc_event_deinit(&ctrl->qmi);
> -	if (ctrl->mwq)
> -		destroy_workqueue(ctrl->mwq);
>  
>  	return ret;
>  }
> @@ -1649,9 +1632,18 @@ static int qcom_slim_ngd_ctrl_probe(struct platform_device *pdev)
>  	init_completion(&ctrl->qmi.qmi_comp);
>  	init_completion(&ctrl->qmi_up);
>  
> +	INIT_WORK(&ctrl->m_work, qcom_slim_ngd_master_worker);
> +	INIT_WORK(&ctrl->ngd_up_work, qcom_slim_ngd_up_worker);
> +
> +	ctrl->mwq = create_singlethread_workqueue("ngd_master");
> +	if (!ctrl->mwq)
> +		return dev_err_probe(dev, -ENOMEM, "Failed to start master worker\n");
> +
>  	ctrl->pdr = pdr_handle_alloc(slim_pd_status, ctrl);
> -	if (IS_ERR(ctrl->pdr))
> -		return dev_err_probe(dev, PTR_ERR(ctrl->pdr), "Failed to init PDR handle\n");
> +	if (IS_ERR(ctrl->pdr)) {
> +		ret = dev_err_probe(dev, PTR_ERR(ctrl->pdr), "Failed to init PDR handle\n");
> +		goto err_destroy_mwq;
> +	}
>  
>  	ret = of_qcom_slim_ngd_register(dev, ctrl);
>  	if (ret)
> @@ -1685,6 +1677,8 @@ static int qcom_slim_ngd_ctrl_probe(struct platform_device *pdev)
>  	qcom_slim_ngd_unregister(ctrl);
>  err_pdr_release:
>  	pdr_handle_release(ctrl->pdr);
> +err_destroy_mwq:
> +	destroy_workqueue(ctrl->mwq);
>  
>  	return ret;
>  }
> @@ -1697,6 +1691,8 @@ static void qcom_slim_ngd_ctrl_remove(struct platform_device *pdev)
>  	qcom_unregister_ssr_notifier(ctrl->notifier, &ctrl->nb);
>  
>  	qcom_slim_ngd_unregister(ctrl);
> +
> +	destroy_workqueue(ctrl->mwq);
>  }
>  
>  static void qcom_slim_ngd_remove(struct platform_device *pdev)
> @@ -1707,8 +1703,6 @@ static void qcom_slim_ngd_remove(struct platform_device *pdev)
>  	qcom_slim_ngd_enable(ctrl, false);
>  	qcom_slim_ngd_exit_dma(ctrl);
>  	qcom_slim_ngd_qmi_svc_event_deinit(&ctrl->qmi);
> -	if (ctrl->mwq)
> -		destroy_workqueue(ctrl->mwq);
>  
>  	kfree(ctrl->ngd);
>  	ctrl->ngd = NULL;

Reviewed-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>

> 
> -- 
> 2.51.0
> 

-- 
-Mukesh Ojha

