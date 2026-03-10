Return-Path: <stable+bounces-223770-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6GbHJajLr2nWcAIAu9opvQ
	(envelope-from <stable+bounces-223770-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 08:43:36 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D768F246890
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 08:43:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2B7E630EAB5E
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 07:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B82DB3E95B1;
	Tue, 10 Mar 2026 07:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ledlJ3/5";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QfzVHXUH"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1474E359A79
	for <stable@vger.kernel.org>; Tue, 10 Mar 2026 07:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773128385; cv=none; b=hmJHNoyct/nIpQcYyUL/3XJu6RZsw95voiStdl26emYSHoLdczZUlEJrijKd9n7Bq5hRih2F3Jr+d75RspnzfE/i0pfEXqaHCm9rmFqaeS4zolaAKmJ+0k0meWOeAtjpeNAQV8Gqc5au5EeD1ULIHGVKnosAQOfOocVEEF5VET4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773128385; c=relaxed/simple;
	bh=Ee95napIswr+YinpVxc5RjeujdrrEruDYBqteyDH2uM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nj262G04esIUNtGiNdysXoN3TaV/eJA+/fsrqCobCAF753cYAgONWCzaIedQFdv0mGyu6hZpumDAbnqp50FJV1EnXDSz5TndnhESoPJi7qc7fU5tjxV8+ewU6IjGi2sK3q7r1PiMXrLBby8e/XqItoaX6hzyvlBtnQw5nNez3pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ledlJ3/5; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QfzVHXUH; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62A2EQeS2460646
	for <stable@vger.kernel.org>; Tue, 10 Mar 2026 07:39:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=F80HPQ1/HbI25COFxU2GLyzB
	JFuxorX49mUflnSs+xM=; b=ledlJ3/50dzcUX13OPhxOCE1iB4UfMFQIjLXU/eC
	VBkG9EWww6DHReFXbR99imJIXDQJw9M6ql2RQt67jN4/5e0Ppceup/pGBvknfb71
	dlp6cCfmY5Hr08QZ3sXbEKCftaAjL/m+0SvBUWKOx2RQPG6Jxo9aj9uIwmoTL+CK
	IUdyK7luiD7CwgGH+XpzvhQmLouWqI8TyoNz0kbjiNHUTm+m7B4OmZ0XrJUZx5Mg
	u0FIXUubFRo9KL2KeuBuH7eObwPveUx7Q0Fb813DZXqW4c1vGV6JVLcPoYh/PCYi
	oNi8pkPCyvY9do3mISGFHS32gVF8FZohfunXjBnZCb94UA==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4csyv1b55a-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 10 Mar 2026 07:39:41 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c738662b963so3653948a12.0
        for <stable@vger.kernel.org>; Tue, 10 Mar 2026 00:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773128380; x=1773733180; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=F80HPQ1/HbI25COFxU2GLyzBJFuxorX49mUflnSs+xM=;
        b=QfzVHXUHMMupM3sMXpNz5jBPe58aXWk33o89QG0bvirABkQfAOdndGnfie/mF07+DY
         9rLwnsrFmq4qzwCLMyPVcCFh3ghnmTYkscUamHQJKGJaX5WaZFfD60Cvcpn1FZ9sq/xN
         o7d6tGXfTNsX5/4845pyted1Nnge35lf7zNReueNPCF5AOWL0zrwcjsDtG6ea3D+PMcA
         RqBmFDUqjVmd3iOT92RJnaZiRL+htDIK35FMeiZHTL6NdvftcNhSxh3KGGEM614zgjJ9
         QnZxhIW/PAjeYbgNWv2kU8ZLW63OHrNC4RbARlzaWosLKwRSZs8EKxtfgE7BuaDVQSkD
         weVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773128380; x=1773733180;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F80HPQ1/HbI25COFxU2GLyzBJFuxorX49mUflnSs+xM=;
        b=P2IyUzmubbMGIiyVtdn8HqTV8YVwLYcC7mKR2STUYyLyC6VE39xw1byhu7ALAYkPg+
         SHJ958NLxPWSC1BILXM0uPermhA/g+J+l7Q99mDmU8cvT29N3wyLsVQ85GwJnmrcBnMw
         YV5mGQhNzG26u4CO1jIWDPPVwqhEBpMFH01OGCynqo6HJ4xQJT+2OWm0hnoQrh/fg29Z
         OJBkaNeId2kczCMqixpUl6dU5/iaUWqIVa21fT0Z6eRaytennYbceT72YE56kF3n6YSr
         +Tf1mkoGixImxlliVGI016GrSVUcZArWG/kg7thjVLGUrAEF9UalQsqJOq2QCmNfqcsS
         1LGg==
X-Forwarded-Encrypted: i=1; AJvYcCV+Ja+RONLksPS255FzL5I5ezIiT+AbmFNJu5i0wEu5dHWySJIg3C5GlXF/VecJzBQwIjCXLh4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0ttFp0tjCQMYn/HWgsiN0xPjrxp7knJ31+kjo+rES6ktKS2fa
	0MXfmKpBkC9se6ORnDzE9HhBcfY8w68YDfEpEA3LHK5hZOA8cEOtbC11s8PMv2bZ0MSoa9Gvqyr
	mJHB10k9sqTioFvld6wyuM4nIGhS+D7lmv3M22FxSX7Q7of4NZctAu0IY+jA=
X-Gm-Gg: ATEYQzwNOgdXN7ClXi678/v1QHKsFZW+pmW2gDitPKldIJElQE8dwH/TCstiB/bwywm
	wi9byWqAoOjaB1ydUN+PJlXmpaTa87uMSfScqrVoHcwp7AnJB9+A0sguVthoSD7atIYCIZeMPC3
	y7vvEDPTNJRRVsySKoVoF143VrIIOvYDoC727SwONit1ZLYn6zjPZbKmibnSVRY2LtxCkfHutdh
	ozuokkXyoD4gpLWKMw02V+zUqBNmDNKuE5fqpxstffFIet8nbbvWHpi+uW3Sgl/Ay5ArLuvPwDq
	py0I9ctRCQkAlrFz8eO7gp56Tw87CQDt3FGuDizm9gtX322BxPlcg5qyZuWe+B+jXz1s1AFz6Xg
	6Kw9GnvVUHxj/235q9pGIx0tuEUzODbqHo1eXZrFz5FykiGPI
X-Received: by 2002:a17:902:e748:b0:2aa:d5e5:b136 with SMTP id d9443c01a7336-2ae82519bc2mr150496655ad.38.1773128380215;
        Tue, 10 Mar 2026 00:39:40 -0700 (PDT)
X-Received: by 2002:a17:902:e748:b0:2aa:d5e5:b136 with SMTP id d9443c01a7336-2ae82519bc2mr150496235ad.38.1773128379608;
        Tue, 10 Mar 2026 00:39:39 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae83f78370sm145364995ad.43.2026.03.10.00.39.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 00:39:39 -0700 (PDT)
Date: Tue, 10 Mar 2026 13:09:33 +0530
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
Cc: Srinivas Kandagatla <srini@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vinod Koul <vkoul@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 3/7] slimbus: qcom-ngd-ctrl: Correct PDR and SSR cleanup
 ownership
Message-ID: <20260310073933.ttble7algoiy7rwq@hu-mojha-hyd.qualcomm.com>
References: <20260309-slim-ngd-dev-v1-0-5843e3ed62a3@oss.qualcomm.com>
 <20260309-slim-ngd-dev-v1-3-5843e3ed62a3@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260309-slim-ngd-dev-v1-3-5843e3ed62a3@oss.qualcomm.com>
X-Proofpoint-GUID: tLCFYQTbpQDJzPFzCONAI0QKoGJhJD3v
X-Proofpoint-ORIG-GUID: tLCFYQTbpQDJzPFzCONAI0QKoGJhJD3v
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEwMDA2MyBTYWx0ZWRfXxtVsyoWoGqzL
 Mek8Ge13bNTnWXMku0mUQmiYlVeZ29jx7jHfW/5Iz3GnR8O+Mc/tNI1UgBfX1dccw3L70QxTpeu
 f6StwSIwymyQ7+/jejZm2yNSP48zfozElGzSqI1Rmd68ZAqIjxF5c2hhju2+geyTCE+6z5IfmdQ
 XdYJf9HbO6off9UfBakO5jJKCt9OXaBe647ZFnqrv6IWpd79KK0FZoZBA2vQ6qcTx5kC+kdmrzH
 5AaGp45FnpG4Vmzg8Jq7XI4HRmaXnpB2H5o+NUJuoT4gHfOS4MyibHXE0nsruLUF8UcTpreXMxm
 519cpOpLTrJpo4M9xNzvUJsuBKvEEz5YMYOoiI8KDqqh1r75zjupN5hqFJAvwirTd6QtCKUJKl/
 Qedgd+kaG6MXkuMfTR0Np18mJVXvkPbI4+x0BUy5NLzCuTyJxlSXv2afC4OBySton0LJX4fVl4a
 p3y1ApOVYx2NFc3W3FA==
X-Authority-Analysis: v=2.4 cv=Cuays34D c=1 sm=1 tr=0 ts=69afcabd cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=kj9zAlcOel0A:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=Rba0rGCAh4Qlar_hUqYA:9 a=CjuIK1q_8ugA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_01,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 spamscore=0 adultscore=0 priorityscore=1501
 phishscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603100063
X-Rspamd-Queue-Id: D768F246890
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[hu-mojha-hyd.qualcomm.com:mid,oss.qualcomm.com:dkim,qualcomm.com:dkim,qualcomm.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-223770-lists,stable=lfdr.de];
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

On Mon, Mar 09, 2026 at 11:09:04PM -0500, Bjorn Andersson wrote:
> PDR and SSR callbacks are registred from the controller probe function,
> but currently released from the child device's remove function.
> 
> In the next commit the controller probe function will be modified such
> that the error path will unregister the child device, resulting in a
> double free of these resources.

Change is fine, Could this not be accommodated in the next commit?

> 
> Fixes: 917809e2280b ("slimbus: ngd: Add qcom SLIMBus NGD driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>

Reviewed-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>

> ---
>  drivers/slimbus/qcom-ngd-ctrl.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/slimbus/qcom-ngd-ctrl.c b/drivers/slimbus/qcom-ngd-ctrl.c
> index b34e727bab086c95dc7e760bf1141baac9ccf6a7..09ce3299e15c25b1b9cf6b1559850adf4aa20737 100644
> --- a/drivers/slimbus/qcom-ngd-ctrl.c
> +++ b/drivers/slimbus/qcom-ngd-ctrl.c
> @@ -1685,6 +1685,9 @@ static void qcom_slim_ngd_ctrl_remove(struct platform_device *pdev)
>  {
>  	struct qcom_slim_ngd_ctrl *ctrl = platform_get_drvdata(pdev);
>  
> +	pdr_handle_release(ctrl->pdr);
> +	qcom_unregister_ssr_notifier(ctrl->notifier, &ctrl->nb);
> +
>  	qcom_slim_ngd_unregister(ctrl);
>  }
>  
> @@ -1693,8 +1696,6 @@ static void qcom_slim_ngd_remove(struct platform_device *pdev)
>  	struct qcom_slim_ngd_ctrl *ctrl = platform_get_drvdata(pdev);
>  
>  	pm_runtime_disable(&pdev->dev);
> -	pdr_handle_release(ctrl->pdr);
> -	qcom_unregister_ssr_notifier(ctrl->notifier, &ctrl->nb);
>  	qcom_slim_ngd_enable(ctrl, false);
>  	qcom_slim_ngd_exit_dma(ctrl);
>  	qcom_slim_ngd_qmi_svc_event_deinit(&ctrl->qmi);
> 
> -- 
> 2.51.0
> 

-- 
-Mukesh Ojha

