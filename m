Return-Path: <stable+bounces-223769-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UBV2BqvKr2nWcAIAu9opvQ
	(envelope-from <stable+bounces-223769-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 08:39:23 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CE2382467E9
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 08:39:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EE5EF305DA3B
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 07:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E2B23E8C5B;
	Tue, 10 Mar 2026 07:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="b95/m8Ge";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WOeSt5yI"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A48232FC037
	for <stable@vger.kernel.org>; Tue, 10 Mar 2026 07:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773128195; cv=none; b=FLWaxGcyRSNyX1gNEtY0d7ALOuyKt80FJmYqBFpV3uhmB8xTAQiEIDp7RJ3lSFkbfTfKCZlQdPPn0PNt0SmynzVvE1x0efS9c3FDJTExP0eo1dIrYtgJLXH3R/J+HUwLqZ3lbriVI+Ty3RMGyqywwDIaRmovNQ/93s0Ri87ILf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773128195; c=relaxed/simple;
	bh=evPPlA3o8/RHmcQ5jBRYKEHN7vySVMUhhyZM9RQ1IYw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YOwmK0kTMl5imGQAUHFavMuwo6L8cb8bRh6nCfs9wLoA0KvuIVE+HHhN4DJO8NU+7er2hSUDYaNl3Kp8tFVQGF6SYrqsnHO9AVQNpaVtFowpz/cu42xCRFPa34ib+enl0exB10iVLmm7YEQp0lw/0+HFu5hm8zOJTOlIqzy/laU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=b95/m8Ge; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WOeSt5yI; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62A2EcnE3587427
	for <stable@vger.kernel.org>; Tue, 10 Mar 2026 07:36:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=hrpBkcjZ0X2R4bvpnhheb3vH
	Wc/nYCiUqWYNqIv9sLU=; b=b95/m8GeprC3+GwB48btZUoWm/0hQtxu0n6Mfppn
	E+p/2iV2+5gJtmr84Ea5jX8y7OqYE8JYqLJPfX8wv2eDdeEFo4uAjiCQ5KMgKBmt
	dxmGQp+Evc5YUx53s4xDHqglj8uuAdGcHv/43fOAyuM5ZUq13ZuY5Z5uAHKN0DKa
	Ub6mzZKujaicaDPpptxNRob6hNTpdlVY1ba27ShQMjKzYRa5PM/B2ltOz0VjDYne
	HNK/D7AiOrim2qgRYx2kkm9x0hJG2HtDMOMjHObIHrbignHDCuoTZqhOhyzR7gxv
	sSss3wPW8nKSvFJht58vV+81DzEwNtxQIsnuHETJW2WvFw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ct1ektr9a-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 10 Mar 2026 07:36:32 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2aad5fec175so462725865ad.2
        for <stable@vger.kernel.org>; Tue, 10 Mar 2026 00:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773128192; x=1773732992; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hrpBkcjZ0X2R4bvpnhheb3vHWc/nYCiUqWYNqIv9sLU=;
        b=WOeSt5yIfp7GT62jJI2h0FDtBDKuyVq/HEWB0F+XbwF2QkaFFiYWnil2BFyaW/1rpk
         4Yfk6B5AkVLUjBEa/PzFrTLiTtpnXj1mCVmarYBMv+FWEuPHTKkNuuH/rvFcfjf8bEKU
         XhmtX6/fF12mqfI3AZamsM+Vv26gUDhMzoEYlfN2nMtS2I4NzZhoNZAA+Es5TXY9RoV2
         MzWiYRiHCJW3LhzIfFmfrHSagRTzm+3Dt0Ta73iVnVcTJG0wRRLR/UeQHs/eJSfO2ZGX
         HZWaPpnA1rF4BNScBwk+E0GylIZ/y7pEufxoqlSyhdeI/ouX02lqx/UtRSy29cMGo4ER
         3QfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773128192; x=1773732992;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hrpBkcjZ0X2R4bvpnhheb3vHWc/nYCiUqWYNqIv9sLU=;
        b=dOwe3yNpHe7Q5ZSRpl73kib2xWGkyqrQplaQZpT5qhqLYND/DWG7f2RjEj8qkQkFQV
         6sBQC4M3CTHn8YvelTPX0lb1wmY7dsbtZnArf7m2xP8uVQHbfwK+XVbHni/L/Fz8sAzh
         OzvjjFmEJYdkjdX7pUSm36rXr0OPAg4S1kOqfP+I2oY4SFOP6IA43yKBygLJqrxoVK5x
         czbQtQ73KFNgyL7FuLaFWAinh9Y+LrhvGBQNyCij+EFCEszpkN21RFKNXsiRuTGTx+3T
         Bw4sOLAll9WjsfXp/dd+Vn/AHTuciJOfSTwv04vWuJ0r3jO1zXuoxT2D3fcxPPZfdPHy
         yWsA==
X-Forwarded-Encrypted: i=1; AJvYcCXX5+kWFeBvvsVT9XSD8yWbwegwPTBvo6Ds9YahMFzluaAkPqwxtrcCgim0mJEW/iqqAeMmZEo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyO/k03WtIOoyLUd4rwUjR+x0UXiCr6/qFols8Koqm3tPwNQvUo
	QA7nmwBVkKl2CoOC420UuwERQwKb0WnZPkhRWJgWIVtci+hGHmMAliukH9aJhlMwF4ZQhtqWCPA
	6nHqEysgcXSseEojArCPvVknmQqcsHX/xBg7PjKUEU7a/QP98JJlHFBQvqUM=
X-Gm-Gg: ATEYQzydhTrO/dpFSRJI5yxRt0fmK+NzgcP/1cwrVY+F8sb3cOeI7e0ZUuEKdUWzSZK
	gndq7l02/rLGELohJGsTfI0jOPZNhZSCa/ve1eoonBZjEBqDdeY9f+N1u8vgzSTv18KPezJvDFV
	YpbkIwGR0wso1W1xFROiINVF6Yi9pEtKMm281C+XNs0VvpFzaTLM5BMpVXXzy7Xvpdq8MDQx5ys
	MKlzOR5GMuIMm1ZfOcptgTG7tzlB+Pw0v/TnASoVjFvVd7zK89SqUx4XBwyEX4bkITsWWzFSOyR
	ql4Ls1hXTBjJ6UeUuc4dxdqaklkgrofZH7ylaQhm8Mbt3/H26cplQf2x8Xhhycp4KtZifgoH/3U
	uf6+U4y7dIvJyJPPhqdHNdxsn4eIb6UTS1Jj1QJ5bWLb4ZO8r
X-Received: by 2002:a17:902:db0f:b0:2ae:59d3:27f8 with SMTP id d9443c01a7336-2ae8238bc3dmr156453225ad.19.1773128192142;
        Tue, 10 Mar 2026 00:36:32 -0700 (PDT)
X-Received: by 2002:a17:902:db0f:b0:2ae:59d3:27f8 with SMTP id d9443c01a7336-2ae8238bc3dmr156452885ad.19.1773128191506;
        Tue, 10 Mar 2026 00:36:31 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae840ad74asm192662105ad.78.2026.03.10.00.36.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 00:36:31 -0700 (PDT)
Date: Tue, 10 Mar 2026 13:06:25 +0530
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
Cc: Srinivas Kandagatla <srini@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vinod Koul <vkoul@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 2/7] slimbus: qcom-ngd-ctrl: Fix probe error path ordering
Message-ID: <20260310073625.dyqkkaasd6khgmzj@hu-mojha-hyd.qualcomm.com>
References: <20260309-slim-ngd-dev-v1-0-5843e3ed62a3@oss.qualcomm.com>
 <20260309-slim-ngd-dev-v1-2-5843e3ed62a3@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260309-slim-ngd-dev-v1-2-5843e3ed62a3@oss.qualcomm.com>
X-Proofpoint-GUID: ofwf6HNtavJPKLB4Vwz1w68SKzckizLc
X-Proofpoint-ORIG-GUID: ofwf6HNtavJPKLB4Vwz1w68SKzckizLc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEwMDA2MiBTYWx0ZWRfX75lJnVI31OC1
 uhX2zBCjspX9A2WZ4vMF0cWdSuUBp3kk0zkJzXnpI+Fm9RaWK/3704RHKm+rm1l9BgiN6yKS4PL
 +P4NW5VLTqcU8wK7qbZtsG550Gtwywwn2GQUVXr6C6PeN/gUZHm68JGIZPpQWFpeVobSWVpwfQn
 fBUad6j3Wt2Sb+aZVLuxMAXqISQrtDviei/oHh221F2cqHasVRHEHM8QNEDaYmpj09DSh3/PwRO
 X6F17gY2GZ98s4HkdFT+/55JXCFBd5Ome5drsC2aAm6hmMQQUW8zex5uq4+0DCkC3vkwFBCLyC9
 CHS6vP95EagLaaxbAoWMQbIgDX7pg3w0FT0bkrbRoWnXtRISjRUIBhyyf9vOGNTljletJVq3pY+
 7IJD9zz5l6/0J7kGsf3J1xzIoAKy1F6KzBR5tTzBeHdOxFWrpna7MHOnCrNexgS/emrF4CA9UPs
 AmejUFLl4h4daErMWyw==
X-Authority-Analysis: v=2.4 cv=eIEeTXp1 c=1 sm=1 tr=0 ts=69afca00 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=kj9zAlcOel0A:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=hgJ7biYs1z6SSqIWfREA:9 a=CjuIK1q_8ugA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_01,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0 suspectscore=0
 spamscore=0 priorityscore=1501 malwarescore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603100062
X-Rspamd-Queue-Id: CE2382467E9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,hu-mojha-hyd.qualcomm.com:mid,oss.qualcomm.com:dkim,qualcomm.com:dkim,qualcomm.com:email];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-223769-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mukesh.ojha@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

On Mon, Mar 09, 2026 at 11:09:03PM -0500, Bjorn Andersson wrote:
> qcom_slim_ngd_ctrl_probe() first registers the SSR callback then
> allocates the PDR context, as such the error path needs to come in
> opposite order to allow us to unroll each step.
> 
> Fixes: 16f14551d0df ("slimbus: qcom-ngd: cleanup in probe error path")
> Cc: stable@vger.kernel.org
> Signed-off-by: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
> ---
>  drivers/slimbus/qcom-ngd-ctrl.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/slimbus/qcom-ngd-ctrl.c b/drivers/slimbus/qcom-ngd-ctrl.c
> index c69656a0ef1766d5a9df40bdf37bae8f64789fab..b34e727bab086c95dc7e760bf1141baac9ccf6a7 100644
> --- a/drivers/slimbus/qcom-ngd-ctrl.c
> +++ b/drivers/slimbus/qcom-ngd-ctrl.c
> @@ -1662,22 +1662,21 @@ static int qcom_slim_ngd_ctrl_probe(struct platform_device *pdev)
>  	if (IS_ERR(ctrl->pdr)) {
>  		ret = dev_err_probe(dev, PTR_ERR(ctrl->pdr),
>  				    "Failed to init PDR handle\n");
> -		goto err_pdr_alloc;
> +		goto err_unregister_ssr;
>  	}
>  
>  	pds = pdr_add_lookup(ctrl->pdr, "avs/audio", "msm/adsp/audio_pd");
>  	if (IS_ERR(pds) && PTR_ERR(pds) != -EALREADY) {
>  		ret = dev_err_probe(dev, PTR_ERR(pds), "pdr add lookup failed\n");
> -		goto err_pdr_lookup;
> +		goto err_pdr_release;
>  	}
>  
>  	return of_qcom_slim_ngd_register(dev, ctrl);
>  
> -err_pdr_alloc:
> -	qcom_unregister_ssr_notifier(ctrl->notifier, &ctrl->nb);
> -
> -err_pdr_lookup:
> +err_pdr_release:
>  	pdr_handle_release(ctrl->pdr);
> +err_unregister_ssr:
> +	qcom_unregister_ssr_notifier(ctrl->notifier, &ctrl->nb);
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

