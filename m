Return-Path: <stable+bounces-224622-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oO9cIgHHsGnTmwIAu9opvQ
	(envelope-from <stable+bounces-224622-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 02:36:01 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3632025A634
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 02:36:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 64A0631715E9
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 01:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94FDF36DA1B;
	Wed, 11 Mar 2026 01:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cwZa+JlA";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Wi8T2pez"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A272D0617
	for <stable@vger.kernel.org>; Wed, 11 Mar 2026 01:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773192886; cv=none; b=aOjRjts5zkpks5AvuaBXBhB4HqyFq+XIvvAOxDnIRACiLF5gg7rMU8upD+9VEXMabqjRmUuDHrOTPTNnnwE1Z9b5M0P4ARmFoW4fSnkPy7tkKylIk3CjJaUky8wJAgOje97LVd/4NKhX+xI57j1dvQP2n53rRdOULQktFx/UBSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773192886; c=relaxed/simple;
	bh=BvYgs0qZ6toKJFKhPFtvfzO/PJ5KPWmnR6gRI3OQ6KQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NXUNLY9RvWER+g+zXwL6ImkTkU6IBga9Z45eFfTNiAQGTW3AtTIRNvkaD2QGOiUlSu6h91qV14Bw9oZLPdJEhcl5EA0QXjr9msY1551FkabcDszwSyZu/XXct78MlRMgJBdISw5RSSt0W3GOKwuZeQQeR+0as6/qrobwy0ZmpXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cwZa+JlA; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Wi8T2pez; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62AHCqoo1573018
	for <stable@vger.kernel.org>; Wed, 11 Mar 2026 01:34:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=fr+mKmHEmOU1zJtYrSEfTHIp
	QHWCN5N9LBxVDEc9HXU=; b=cwZa+JlAo44RvCZwO+hCer051J1+NGL8II2Ezhrw
	EmN4voWzCEgZdQgq6oPJZK6gmdi0nqwySTo/g+9d/kAGxwwzUmRaNn8KFr6qRpsq
	bdXRdMDqWpdtUA/PLqGJjgXUmUo+2NXNBMGCwc0LT5Ec+wN/V+zMc8uWf8iJL7Bs
	5zyiJpS+3L/O043tRZqsxEorfHfWc+c7Uvkpv6r9bqtk8E8KU+Jvu7NKWiHgke1Z
	h17Z47397tEtu4jo3i+I1taGNyB4VVSXnDcidJohcif+DgDeYqS7JGQE+dh6pv56
	VOT/FCFGXt/wIVeFV1ZDeAJjd5yF2G+GMb01IBw4XcqI2g==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ctqgk9erp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 11 Mar 2026 01:34:44 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8cd81c571a5so1572361685a.0
        for <stable@vger.kernel.org>; Tue, 10 Mar 2026 18:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773192883; x=1773797683; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fr+mKmHEmOU1zJtYrSEfTHIpQHWCN5N9LBxVDEc9HXU=;
        b=Wi8T2pezj4JJlk3Daptz59DpEaK0Rl77XCdSyKGGFYjPDw8fEcK7SGJ2O4u1dVwmD8
         Uu79YiTh0PzmQR9imbVZT09+dX46bb0cirbAuVB8gqh2gmcjqU5LP/E8yjKn0QtzxNNh
         cDgYbMS8pq0iSr2BznVfLxpZNnToa29VQk/U+EEZm5bkMYC4WEki27YD0MtPOyPLhdAu
         IEB/1cbiC9vlX3NRqrLPX0RFAOrQ08DbBU0mNMA5txWvrb17Q49cvXzDiQRglHEZR4Cr
         mGBtoVEdLnO6A8lr3p78SkE6z9oPShzAv7MsZflhIZrtosKvYgG4XbHmo2KTmnKWiMuO
         WGfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773192883; x=1773797683;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fr+mKmHEmOU1zJtYrSEfTHIpQHWCN5N9LBxVDEc9HXU=;
        b=kEdy1ntVem6Mkg35mLa+kZ5Hcpmh2hwFPAlNQIFH7us2kFKclV2hKYN9YTz6vkaFzR
         ASfwlQ4N2MEgpodn7ZsXcOYAzyq6MKdBpACcSwJcn9yyMqaeWnPO3jFP7L82DeP2rNm5
         rQvzy6gZSES/66WuPvONMdJPesmEFUtdhua7gNEIyjDJjWEcNj9AfHdGewXE7o9WkxfA
         CrnkXvegw/GQzuCx8Spaor6UYbPTCiapQo8nJrW0DKp9AIbYwHG5bhps0/dBGQXCXF3X
         JwazV9VegkzaIabNCVwgZPX5bVvb1Sc2N5kylAX2x2phefu8M4D13KeGCGpePJ2/cl/5
         QWuQ==
X-Forwarded-Encrypted: i=1; AJvYcCW5+egxv8x3JDWf7BJOMFkZRmbED6q1Z/w3065C37b8FqW7RRAHNYzCFoVNLados3ngvP8FNP4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/L/8jQsjgx4ty61CY8oLnNXJmE+qVn8Y/7hedEuyCFh36dzV2
	uWloFHjH2i+yln8lQP3RLKN/NkHpyaNXJ2dM53KAysqwq57a5lJ2BRJ6YoIJ6cQhjWFm7rFedhp
	oL8hpUzgCpnL04pvP0gOrxOnFzvMUlSUVxdeV6Vxl2GlSpP7OOQj3j6h1Uz0=
X-Gm-Gg: ATEYQzxyzqqoPLhTUc+WjYJG8+s8khMbFm+6K7lnOv/05j6bD0mlvqEVZDztwk2Z18k
	p2EAijDYBHLb6ySqIarrmZg+xbcwsUokwN7LBEyfJFtUsvGh7rqCiFKvxx30G9bHlKOmHJ290u6
	6Q5JqXKlettBBW2iWS8pQPsfcYgTlvW6acCQpYOO6PXwOWyegPdnD5w5R79rymki6KbDvwiR9ks
	pRTPuueCH7oQeC/hu3OGwyUbwcjtUxyxeTSLvIvmXJPE1VjpxeCX/Ry8uTuYQH3L5A5YfAUkJdX
	NuD3Y/wefdKmsEA+ylZM9ebMqC3Vagept6mklp6Vub2niEdtfCHPkUAky2RuPg1ICe5e6L33tNH
	020eKDrafnbQUbbtKS9TYvSYdNGQe+UqGJOWQTgwnrX2iK0qEjd/5GaC+1PgF47da4hyyf/J0w1
	v/7AjoY+zfxVtIroZCE20Znzim2qPdeDaBdjA=
X-Received: by 2002:a05:620a:31a5:b0:8cd:9a1d:4f1 with SMTP id af79cd13be357-8cda1a89e84mr129679985a.80.1773192883497;
        Tue, 10 Mar 2026 18:34:43 -0700 (PDT)
X-Received: by 2002:a05:620a:31a5:b0:8cd:9a1d:4f1 with SMTP id af79cd13be357-8cda1a89e84mr129678085a.80.1773192883105;
        Tue, 10 Mar 2026 18:34:43 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a15635829esm131270e87.66.2026.03.10.18.34.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 18:34:42 -0700 (PDT)
Date: Wed, 11 Mar 2026 03:34:40 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
Cc: Srinivas Kandagatla <srini@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vinod Koul <vkoul@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 6/7] slimbus: qcom-ngd-ctrl: Balance pm_runtime
 enablement for NGD
Message-ID: <fusum3ildpm2epfipamzlttb7oyopua6bt2rl2kfh6jjtl52oc@mcy5rcbpim7i>
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
X-Proofpoint-GUID: ghxssCHbqmtB4AiHaqidBUSc1f8LWTkx
X-Proofpoint-ORIG-GUID: ghxssCHbqmtB4AiHaqidBUSc1f8LWTkx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDAxMSBTYWx0ZWRfX53C7GcuVleRo
 OnTOvHdTnMO9ZD9+eABykoNyiOXBNEx8d9q15Scmb3d1DcT8QfBal6n+OVfIzfxdSgeKCjNz2kU
 BomsB3JhjVtco99LoEzqyvmVOAokcKSBH/ri2HsApzuy9BhgfdI1xmy3U3zi8T5PbwRS0gzhoT3
 FxCATS820Wf4etyBENzrNHRBk4MxoshxNgdgmazMQ9mkFduKXxDCffJHzGdspafZpm32dvzjl6q
 ajZUdxZz+YoRCLWGOD10OuSMeCTGSYbUKsNy9+NvfWS5N1Dm4nBZ21rzX4x9c2rM6uQYMy5lV8c
 WDoeEIPUqeHgWqWD/W6423v9F/08CrJg8z+4vhfBnOQexNSdkN1Fri/t0wsugEoVocQRYHm0cUP
 HV43OpydwllSFKy3CraP769WlmEBtTV8bLVa9iEB/pK76tD2qgRSjknSu63AVarfzOM8TNvPYPZ
 iBmZr3BfqKpQFA+GC9A==
X-Authority-Analysis: v=2.4 cv=M4JA6iws c=1 sm=1 tr=0 ts=69b0c6b4 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=kUWDpvuyKQ_uwZtR66oA:9 a=CjuIK1q_8ugA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_05,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 adultscore=0 lowpriorityscore=0 phishscore=0
 impostorscore=0 spamscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603110011
X-Rspamd-Queue-Id: 3632025A634
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-224622-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitry.baryshkov@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

On Mon, Mar 09, 2026 at 11:09:07PM -0500, Bjorn Andersson wrote:
> The pm_runtime_enable() and pm_runtime_use_autosuspend() calls are
> supposed to be balanced on exit, add these calls.

Use devm_pm_runtime_enable()?

> 
> Fixes: 917809e2280b ("slimbus: ngd: Add qcom SLIMBus NGD driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
> ---
>  drivers/slimbus/qcom-ngd-ctrl.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 

-- 
With best wishes
Dmitry

