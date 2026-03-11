Return-Path: <stable+bounces-224621-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8IeYCOTGsGnTmwIAu9opvQ
	(envelope-from <stable+bounces-224621-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 02:35:32 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 765E125A61C
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 02:35:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7AE5E3193915
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 01:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D3E112B94;
	Wed, 11 Mar 2026 01:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="H9C82eBs";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WZd7/xl6"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC121C84C0
	for <stable@vger.kernel.org>; Wed, 11 Mar 2026 01:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773192851; cv=none; b=B4F1zzs4HNiBRR9TWfsu6DU4hXyKntbmT9LrC3A/BIa6enTVe7rMgavPAXNI6l4vZuX+qF/WRozvG5N1ydGcYyRmK9wXNA7kbGuIzpN/bXwHbhW94E5Bq6ki8FyxTzvWu1fgn6ExZc3rh+WXCPisFC2kpYi+LpIZDJKVfi6MMFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773192851; c=relaxed/simple;
	bh=Q8Hc9ooUxbVtdPnIEu0z5CIgsowGg7hwXBssOJd6aG8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZH8OVDM6O2VidKjsAdzSOWxTlS2oXedHVgh+7WG72PqIpTB9juVwRhnXtH41go+Rjv74JN+iA6beAZLg6KNhjWxnr7gCCMy9SQQ//MpPruqjBXgHrzogcQqa0GMKJP0INwxmjkDAq32UAM3TRLBTuUAqrggUdmrA+ubQCs83lRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=H9C82eBs; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WZd7/xl6; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62AIJ0kJ3759641
	for <stable@vger.kernel.org>; Wed, 11 Mar 2026 01:34:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=t/kScn5c1KsInTDkcb6FS1tb
	UgTxGiH/6Yim6dWg/T4=; b=H9C82eBsch15e9p1UJY0bBXn6Zfuk68BW3fkqHsX
	dsTpDl84zR49d9+ogXS/qkdeoJFOjFxPWCZEblSaE0VTOIfT1LCLeQY8evfVJbDd
	r7ythIWy4yj+1MFN5OVIwIvSbFlYRh5a2Ho0ZXqaQsaw1tqLLA8Ttji6E0jSnIUX
	xoJlFhaUNWeyno3nokGeXQTptVSxMLZBqrQZSOxtM5qz1fMo0SGDWD0kIwKOprv9
	bGJ8h9z3gDTFUgMOE3WnrlXM8gPElKPEyPRW9rZRyLHuM1eoqsJ3+A9onLnDc8hR
	+p2GSiaBeYTyvSN2E3A3Gsc90BKgbj8v89sNhwCsYMXISQ==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com [209.85.222.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ctk8ujpvv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 11 Mar 2026 01:34:09 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-9484dbd65a7so22292564241.1
        for <stable@vger.kernel.org>; Tue, 10 Mar 2026 18:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773192849; x=1773797649; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=t/kScn5c1KsInTDkcb6FS1tbUgTxGiH/6Yim6dWg/T4=;
        b=WZd7/xl6qTfk3N1Sj0nz/BZ2UL+oHpIzqlIdSJsMrk0VpDKp/XWEjYkfX2RvKZyCKI
         ioMBp4RaNIV2AgXaA53OXm7FVovo+sVyJpi9Ajx2vEuSc+jTxOrXLJXlYqEseRmzXHyX
         brPsxfNAFnldjLpwO6+eH4BfKiqrUgEIs8qmRDlXYc5vsgHiliAZoqCvcvur/UwlHXqu
         BJgWR3K1uDHDP85i3xcTKOnrgdXndDdYEQb2TgAI3FIEXJSKuTrQ1Z3CO8rl3u1XzNT9
         UIZWuSXaIU4U1z793TjhOJwyNp0Bj6ixl441nI/hAv5lse1kFez9ilaM5iclzLwLmWc0
         pkBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773192849; x=1773797649;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t/kScn5c1KsInTDkcb6FS1tbUgTxGiH/6Yim6dWg/T4=;
        b=w5hiVCrp3NVdw68WCamVqyfr5W3Awfyk3aJ4F/c7SmqMxbT9xTHnl6I/8eAq4Njytw
         cKCzfyP8QOSJgRAJ1pkzD3VuHucJRL+7Y8AvBIMCbkf/d1XW6yK6K7UEv0w6BOSh6l2U
         lbf3ikHl1JuJhVSfD9jrKxedXybmJBv1bvL7DstwRvHUWUL4AVv/ZCyN64MsRDBIH8jd
         0Gv6rHf00c6yx6EOqcMlci8PLM9iAwGtuFvyGsSZ4IFYaLWpGsFf5HJv8DSDIKRf+OVr
         BBnlcEHO5ggToMDI9jYFAL4+YmRqNzqv2/kHsQl8Gl+J9whvA/fkcZwL2Zimb/8JVZFe
         jl4Q==
X-Forwarded-Encrypted: i=1; AJvYcCX7mNpMU/EKlvY9yw1Z2s/GF4nj05m68DFH1+qUqo84muGout8Uxb98aWWsefegSJxFN+jBKBU=@vger.kernel.org
X-Gm-Message-State: AOJu0YysYCya7+sNEkfy4/iElpPgkFeftkjvA0oSKMPA3nSItR2EhbnV
	cOutiIIYcikFWfhhRcRuk5fQGfihbAe1q3xrbMMQkcSs/rUS1syco8gg8mV6uixEMYb6ZEpJdeq
	p8GaznE/5EyysHVtSfgC7ZTK3a/1DbJ6EqwuCbjYcdcRHhOsZWmyu8jfRecc=
X-Gm-Gg: ATEYQzyR0W3Li84YpyIZt30mGMKUZghmCAEO4eGKzeSd/rvFMB3ZXhHs5WIW2v56BZ7
	UDO4Z8U8kMV9/IHslIPlNKCd7Cu3QqZlSFA9jXkiWJp/PkIKJhRDc9cv9D34HdPc+P6BniRRGGV
	gEOqohTS7xtF+HpZOJXNbmCRL+KO6gWhNdjTjycg2u8Cm04dCqusnUIsbvkd+B+l15nehMiZ5T5
	Y/5x9RJteSeXE9BzvghTnm4DVryexFs7c4N5Q2GbUwLaQnWbcT9RmlZFK9/9U8vw8OaBognmj5Y
	ZdXJUJyIv9B6imY8DdIwBAsNQYm25QWl/CTbRI6OTIEQuP2tznELaDVnKqQdv+ZQmOBRr9PzRE0
	ep8EOysb5reeWRTOEErXVOnRsvlW9vCoWiyLYgT+onx+nUkCno7nJ10FdiJDe7S7ga71qAg2ApZ
	Gfi4INJvehvpCD2zyxgdc3lm/58/LuAn7b76o=
X-Received: by 2002:a05:6102:4409:b0:5ff:f6ee:1089 with SMTP id ada2fe7eead31-601debc1b95mr329011137.13.1773192848321;
        Tue, 10 Mar 2026 18:34:08 -0700 (PDT)
X-Received: by 2002:a05:6102:4409:b0:5ff:f6ee:1089 with SMTP id ada2fe7eead31-601debc1b95mr329004137.13.1773192847869;
        Tue, 10 Mar 2026 18:34:07 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38a67e70d66sm1267171fa.40.2026.03.10.18.34.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 18:34:06 -0700 (PDT)
Date: Wed, 11 Mar 2026 03:34:03 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
Cc: Srinivas Kandagatla <srini@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vinod Koul <vkoul@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 5/7] slimbus: qcom-ngd-ctrl: Initialize controller
 resources in controller
Message-ID: <cnbyqrpmfgofeoybc6kehztsrtyfc5xhwdjhu6qanq4l5434jz@xllc7ichy3y2>
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
X-Proofpoint-ORIG-GUID: lytSDyG38OoO50-j9Oh3sbQRfEZ53MZN
X-Proofpoint-GUID: lytSDyG38OoO50-j9Oh3sbQRfEZ53MZN
X-Authority-Analysis: v=2.4 cv=YcmwJgRf c=1 sm=1 tr=0 ts=69b0c691 cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=eovvkHS26EnLs4EkxgwA:9 a=CjuIK1q_8ugA:10
 a=TD8TdBvy0hsOASGTdmB-:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDAxMSBTYWx0ZWRfX/uv803/hCQmr
 VcRsDGNqseqRfUe1TSKb8LDW7UPb7txMa31KAv5nIngWff9uPVefgFOWYkRvQl4mvXCinh+meLx
 X9XY6+jj29vB8aThAH6nyceeA0jON8mVpURk4+H+y0OSJtUzZZ27up+oA3JRlSRxtp/U39d9DXY
 59SFIeWb9XH20Tb/MrTBJLEE7ciLDkbEJ46cHJ5h+a9CmZLHaCIr4FfYbgQOjQWDZAdFr8YnQ08
 vYfp/vuB22T7Pd1nSHfCWHaUJZD//zhyfy8fEnPcf0OTfwi6GZjP8Gu9D8ds0M6YGr8rHZdxeZH
 020psDgZAOS4XHOLcwaa2gPHbSAzm8fXbZqfmhb3GaRHBTAWyIQsu6Ni/RoJlRg6bxdta/pmorp
 JvYaVmMI4MlHpv9Kv0OCuTqHHZkMZeGyqNe7X2NU1MMFxq7VW4JiLM1JhisnTBUkAuvEHUzILZ3
 soave9grEnxA7OaJRKw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_05,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 impostorscore=0 spamscore=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 adultscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2603110011
X-Rspamd-Queue-Id: 765E125A61C
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
	TAGGED_FROM(0.00)[bounces-224621-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
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

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

