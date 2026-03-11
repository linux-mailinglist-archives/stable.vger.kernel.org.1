Return-Path: <stable+bounces-224618-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EIPRJ8jFsGnTmwIAu9opvQ
	(envelope-from <stable+bounces-224618-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 02:30:48 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 22C8125A57E
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 02:30:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 22C6F314BDAA
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 01:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4455366065;
	Wed, 11 Mar 2026 01:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IP7ttoWV";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LBotim0g"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D4AE36CDE2
	for <stable@vger.kernel.org>; Wed, 11 Mar 2026 01:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773192641; cv=none; b=epspqNTbjDu1llLv/zQFsOnG2iXt9A9XiAqyxX66SxfJBDkQcUFmTNvJsyuy1M5T+/Ha7AKm6RprvI232VGi4hkcRDsHFFwAen+vlL5aPlJiW6IzfgvzlLIizIwqEX2n+10gKSO4EMWpqXY5ZReR0LS2FbjwcFtDDclNN3htHZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773192641; c=relaxed/simple;
	bh=ihJwfkzCs6BdMROR1EIEVe2OLNg0Qq7mc331gjk2O1o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oeqlqrhNwzLWh2XLEeogGuJhHx+r9iiLP5cj+B5JpjdpEaDlJQquIwV98UZLdLxbP5wsewn2wYyos6xxk8O9YQK+QXsoAk4iqfqj0nz+EUfjge/RySKk7gsKgZmpwaYVJtSpuOKNmuhZnQefPle1YLMNkXAYJUu84T2oWCsxMKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IP7ttoWV; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LBotim0g; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62AHd2GH2179907
	for <stable@vger.kernel.org>; Wed, 11 Mar 2026 01:30:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=sT5IPYC4UnHqleGHP2h0UMI6
	i8sGmw3mElFsaqMjQfE=; b=IP7ttoWVPFDuYr7uWvQibNLDhF0OpKAYEs8F1ucj
	z0stsDmpJgQG3JAEpH8F7LB9ZTxyoi8KRwXr8lbn99roqmQAFvVpFpkOAInKe7Be
	AnuXPQqI7hT9Gi9ElBA35BhMa3zWEEIV7o9K4mhskk2w1HbGM5PsGUZTX+8vnCvY
	GczdHEO7IhL6y2L1N6HcP2r+Dw9TYiYQG53es8Xg8dJaurEaOX9JYP9NoINrO6Xb
	T1d+dWIkiT5H7lsYNxCKxslAwuUcwyRoMurB+PM3U2lmW9uxZoLIW7bLM8geUQKW
	vnVGoX5YnOdXNj9Q9c3g3B8sVef6ici/cVQdJYBAzGcS8A==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ctqvssc5h-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 11 Mar 2026 01:30:38 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-50937cf66b5so68939031cf.3
        for <stable@vger.kernel.org>; Tue, 10 Mar 2026 18:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773192638; x=1773797438; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sT5IPYC4UnHqleGHP2h0UMI6i8sGmw3mElFsaqMjQfE=;
        b=LBotim0giWLeTfkWW4/uAZ0Vdal68I/2W6FPSUpm+HamIlxhXqgWmRFn83wrRFWX1f
         0bC03GhzSDD7I1I2DFxpae/L0w/oYlNYOwUx/zioeBXN1eMRwzDSkvycYyTVADgLY4ea
         bpnxmByeM75vNzLluArKJcslS3fGLPL0J0GTSaG6xojW0rckw2rHB9SntOPrRHPHP6Uu
         n8cmvcPwb03f/8x9GlAtm851ehj1WZBzaFxkTRONihDZYxZIs+TwvGX934W7ut8DnRO0
         EGU7a7NMjOu7D1MfyklgeRePTSLy2aTmgiDfLnzAghsCiA2taC+Xx/nKcMOkn0zLcDmG
         D6iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773192638; x=1773797438;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sT5IPYC4UnHqleGHP2h0UMI6i8sGmw3mElFsaqMjQfE=;
        b=jkap7CJhUgEB77k7mZapZww18IZy4NEpmzt4tjUZAE1/elqMFEYB/8OrukLbz7G4z5
         Eqb3ManYT0cItwKdPNF9XL6FUk8DVgxal7uyMVZhti2hbn+0g9he0bkzb12cOjOTnJ1K
         nvAyLDIOb0keHcOIHChzwkQ4UOqvHV4zmCBnC7KVdaDaAkvZmrOg4fOE/5PEI62ylFlQ
         R9hJB4tmxV9CavWL1vodd+NjJ7J3WcB7nN/3RqOt2gLqhZlkzYmdoxG2kOiR9dNhMmH8
         Q0L3HBFQzqwQzJrAudZpwF5jpFUgFrYFGoF180wzKsQfSkRqNeXGR/ZVqwlbQbrGCFHb
         oN/A==
X-Forwarded-Encrypted: i=1; AJvYcCUX/39gVRwfgsXWFvCh69HGhm+I8uX3qtYsyCsSF8Mgxl/mDxm7mFTnf0yLuzjHuVRXkg05V4M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzhh1fggSajodKYickeIEpvhQgByqC10IxgN6+5+viXT2ZPOhTv
	LeaQq2yFBelcs9qos1kyBWmCjb0AbdBBY0VjN5fwk+m0qbJYDypAvX7WZl32bh4pjkJDEL/o2Uz
	zztbzLbabAywSbyBwmWFVFv7EESigXI7VuAqDpUFh/SYgw/wKHHIOaJqoJ1g=
X-Gm-Gg: ATEYQzzSsn2HzQO7HZ0rQuSPwjvLYkxUTDB1XiWWZoLH+/RQKvqdzKz6NjZvUUUUKr9
	yvvaoENLSFaKkWiM43/TdzKeKroB3xT7tfCw584cdMXj+B2snBu4HwmrGhOMfcSZi6CSk2u912B
	DthWGzPLIBcXEebe0M2JEbxm/KWwP9DTk7WYGVHRL3rwry8Zb1+K1SMrk5HMxJAoi49Z/kvhtNI
	dMgT6XFQaDeTQjqO3BL/EMO2/IuzKSKex0XnihKX6rC9DuItE0UhmYjBdXGVgCOrDXNx7lF/2zq
	j83LzOWUaVfBjED8q6AMHJ2IYi3iS/DdmKle3kUS9WgJ0Nuo/NXm48IRkkIIytiRLt2xvMEBIZ0
	Ig5KXx2l9T2jI4DY1uGxYNRnaLeDyU0y2d/6ETVFLRuQ+jO9/v1R45spoYcdtRwQ7GmQpM4uBdn
	7KbuO53bKkcbL6fXxvcjjDMqlytvZMq9mQzqo=
X-Received: by 2002:a05:622a:64b:b0:509:23c5:3298 with SMTP id d75a77b69052e-5093a1cafcemr10426841cf.57.1773192638381;
        Tue, 10 Mar 2026 18:30:38 -0700 (PDT)
X-Received: by 2002:a05:622a:64b:b0:509:23c5:3298 with SMTP id d75a77b69052e-5093a1cafcemr10426521cf.57.1773192637985;
        Tue, 10 Mar 2026 18:30:37 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a15603487bsm134034e87.41.2026.03.10.18.30.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 18:30:35 -0700 (PDT)
Date: Wed, 11 Mar 2026 03:30:34 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
Cc: Srinivas Kandagatla <srini@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vinod Koul <vkoul@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 2/7] slimbus: qcom-ngd-ctrl: Fix probe error path ordering
Message-ID: <mliitly6dwqxvm5oz34ipnigjlqddbq3tjlzplq6z53zptxbyq@jcftal2n3u6z>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDAxMCBTYWx0ZWRfX4m3hIMtUxgB4
 eyqf+u+6ZAeQvjlTCDg8YY7gRJAh276PkBR9ElXI67E2chgXaR0pQa7aG9NUdSSdPSPqWRnevzE
 4P2h0FyU9eOS7vBQ0g/vbqiCs56Tc9P7M9qUusdXwP+7aNpHg9FzdqKRPPMADgAZMOCirzsgaxF
 c5eF1MpHjdXpwRszzTWMnJ8qpxuY8CNwmmolaHkVj1KQfKRfYzrnpe5W+x3QBvJ76KNrvo3zhf9
 CvQ06aS9PBq4tUoj9wO9viIFajMRhHNQjhQAx3nX6Q8982u38QrhwhV2VGrFPlQwUJ6JiPLuQ3F
 sAa9bya3o2G/awEuPyb1yJOoWJvNOtwk5+1kA/LUAZHOmyh7PH+7t3Jp9fFlDCyK0sSC8VA6E5Y
 zZz4jxGQeW3JqbV9b9hEUQYC5QU+hC7ChEB++mijYGrqOcWoq0UwZBe0sKiU0i4PhrtTGkGL/uC
 UAkndOfhEmmGezeevyg==
X-Proofpoint-ORIG-GUID: pFqRgOkvsgCm8K3iCPP5ONxtouHo496n
X-Authority-Analysis: v=2.4 cv=Lo2fC3dc c=1 sm=1 tr=0 ts=69b0c5be cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=vcyf5Ab826s2KLMX7cAA:9 a=CjuIK1q_8ugA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: pFqRgOkvsgCm8K3iCPP5ONxtouHo496n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_05,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 impostorscore=0 bulkscore=0 malwarescore=0
 phishscore=0 lowpriorityscore=0 adultscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603110010
X-Rspamd-Queue-Id: 22C8125A57E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-224618-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitry.baryshkov@oss.qualcomm.com,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
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

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

