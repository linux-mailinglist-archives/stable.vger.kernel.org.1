Return-Path: <stable+bounces-249150-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +CJwMy0yCmpvxgQAu9opvQ
	(envelope-from <stable+bounces-249150-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 17 May 2026 23:25:01 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BCC6563FE8
	for <lists+stable@lfdr.de>; Sun, 17 May 2026 23:25:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 40DDB300288F
	for <lists+stable@lfdr.de>; Sun, 17 May 2026 21:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E74830B535;
	Sun, 17 May 2026 21:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TF3vj+r9";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Qi+o6nRI"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A61725FA10
	for <stable@vger.kernel.org>; Sun, 17 May 2026 21:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779053098; cv=none; b=sIV8GihGrBuyKQ9yAgCgf5wyG/+YotTj7QxpFw9hN0ZKREr8+bvBgaPXmAxofage0FWuuIwLIkHFZxnAUExSvcM6T1KYk+lqM+ZfYzAAnBK4FfEPih/Ya6IHkTHwt0R+suWnHM3yoFwBEOJbLNFYF6kjQrl7ON5BbbmhY0ihWPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779053098; c=relaxed/simple;
	bh=Ntpg2Gyvch5OmrzCoxhFjOpwjquxUKtWeYRWnP62d48=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iSu57kLIyeYoOjhSfbYUEuDQO6+j8Yx5/dO/D78tkIdY+ERYTMZ5r6YPx5A53invqYqLbThecbZnpNtgJDb51Xvai1G8T93PQOv3lL+SqbaxcdiredYK+91GkBV3V+bRkngvfpmX+IgPFU+g+sXByc/voXoJPrq9/tSn1dCyGgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TF3vj+r9; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Qi+o6nRI; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64H41jCL3241932
	for <stable@vger.kernel.org>; Sun, 17 May 2026 21:24:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=vJ+pq0wVqiTr5Da621Qq+GFD
	AAi6LNEw4Xd4lZj0BSc=; b=TF3vj+r9gC5N8T6347EzSoEqkRCosy8HHvJldvcS
	nhc7iUIJ0dEagFVKwPj4YGk0B0ZngqT4/B3fV/zBmWtoi99YMhfGVeN2PVsQk+QT
	qqBiaCdbErb6aPR4x2BTmX1jRBXkD7E67tsQr2xUXWrPxoRl3KNKOMdyT/fRKBA/
	Tk7bHTcSp27aFxrlmntHeNEQvoZiHcJaWhNzbVUJozT/aHg37+7qVnNmZeOqzuoP
	gESKDqFbShp6YhABdHH9IuiUghnI/TMjgtGrP9oN6fJxgEMPq7ZmbZaIGGsc1wx9
	OyTYZ3+NbnCYAtcGgBUsOB7YK0YBSAxWmFKdATNpgY4V1Q==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e6gvqum2c-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Sun, 17 May 2026 21:24:56 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-50e575a50bcso17315051cf.0
        for <stable@vger.kernel.org>; Sun, 17 May 2026 14:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779053095; x=1779657895; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vJ+pq0wVqiTr5Da621Qq+GFDAAi6LNEw4Xd4lZj0BSc=;
        b=Qi+o6nRI5UvXtJXspbKmFMy0YC6jC6/UZFkguH0xxiXSIM7jun0SNsJ4j/pdgYi4Pu
         4hrgBmk74wpYnrrXGi4WLUU2So7CsxdfPgix2PgPUyGXj8dhwg305p7biPthlUQNoPLY
         iOzVu5QuSx74Qe5BpyJ1cUDfM7CoCEV5nXNdmsJNzOuMDEKO8vixvKIrUrUSlqUqZPpl
         CSbbCUWvFrvM6qdxpkWoBVSE6afyh9j5C2+VU0fjOIWRSCHz9CYmcV4nLb3UJzOnXEg/
         0tGBTjjmLN6sq4beaKZat7VkneT1cnxhB0vT7EpwJp40cbF6N/3B7CnMYMHdhhkxMLiU
         uEFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779053095; x=1779657895;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vJ+pq0wVqiTr5Da621Qq+GFDAAi6LNEw4Xd4lZj0BSc=;
        b=XSVgn2L19lSTAZydKI9qRpRcG9uD24beCPmLTO+aPvSX4asPCfc0OcUYNB6mZr4TOs
         u/q5eio1GAkyNc5UkRtxJVGOiYJiYqfTR8299isOCH9MZWdk0fg0dQ4H2MVBlyY7NtPQ
         QAudjAmEM/BVWs3liBnLASnnmXovMZSeFMdFfXddoNtObB1KeOJmBK/wnyOPdSjSjWrp
         8ZXwgnCI/OHzufrfZP+5E4DMCe+uUM1yA/Hedy+x9cW63IIdCly7Vf6NRn7Qaljveuv+
         a+2GVhMaHdzR6xSLSNUEBwnKZmEWuwATEg44wdE2T0fqqC8qfVDzUHykqpCRD2xUXpJ3
         G6NA==
X-Forwarded-Encrypted: i=1; AFNElJ8q5sBoS8fFYlZEn39+yP0PXxnEdW6uBq+CXzAareLTUid3cGJ0KzrvzRaZMENrYTZ/L8lyOf8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6HoMnyaki6l7w+O0/SieBD4nluiADsXP9gut6K4LM10xAdqwM
	Xbnh6SnjCAJ1cT6Hr2QPOV3L2++4hpq4mGqHoxJfWTkFS2ml05yKZjdNLbn0Qij0kG7QkXG8vWo
	l8umXl8jEDcixEdc+GzW02/KuzKS7tB5BRqpt5xFCM2uTlfLo1phyCKjGemQ=
X-Gm-Gg: Acq92OHivSSP3Fus7Wr5hf/wm9zzeMKgBN+osOWbmia5uqUDbTY1hQdpFsu1pBi71Vj
	uxPqlarx+UR/SLIJil1eiN013VBlyXftO0ABSjbFDs2K9TRaeEj5ZwJIzZS777SFOaJ/HtiJyXI
	w0av2NUzMpjlw68ZZ/gKBAAVAkgCN/LyTz4xlrSF2FlIsBl4Qp+8gRU8WOh0brmRTgOy0gQWBJ6
	fPWzb2FOzVtvbEOUqwQhhxiSUkNvIFw1TLBESC55sxQqc0YACgpypbPzJyWDTpMR/jx4253aJmt
	Bm3XmDfJcvxdLq1+qJZh1AZEG6o0b4V67io9q3L9MROOQr2Z8DIVrpjJ54spPkZhyoZiHUWluRU
	JC5icCdT8df9hk4MxvbHm1LCqHk6qOKm29cqs1NDYIs6ZduHR4vYzKRs84LlmaJH0R+QFVbEEF8
	YsvET5RJoncuDsWtWI/dO3A45KpPmft7XRmUE=
X-Received: by 2002:a05:622a:250e:b0:50b:4491:a2cf with SMTP id d75a77b69052e-5165a078cf2mr177666681cf.27.1779053095419;
        Sun, 17 May 2026 14:24:55 -0700 (PDT)
X-Received: by 2002:a05:622a:250e:b0:50b:4491:a2cf with SMTP id d75a77b69052e-5165a078cf2mr177666511cf.27.1779053094986;
        Sun, 17 May 2026 14:24:54 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a90f10ca52sm2871074e87.15.2026.05.17.14.24.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 14:24:53 -0700 (PDT)
Date: Mon, 18 May 2026 00:24:51 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Junrui Luo <moonafterrain@outlook.com>
Cc: Srinivas Kandagatla <srini@kernel.org>,
        Amol Maheshwari <amahesh@qti.qualcomm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Yuhao Jiang <danisjiang@gmail.com>
Subject: Re: [PATCH] misc: fastrpc: fix DMA address corruption due to
 find_vma misuse
Message-ID: <hkqh3vriu6tqkxi53t6mvjn3hare3qbrkdvwenk2rfmtwoq2ft@nctcnnu47mwh>
References: <SYBPR01MB78819393A1F4FA658B2AB076AF042@SYBPR01MB7881.ausprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SYBPR01MB78819393A1F4FA658B2AB076AF042@SYBPR01MB7881.ausprd01.prod.outlook.com>
X-Proofpoint-GUID: UjbMc5K5iHHNM2F2JRoMj4JcN0qvSGa2
X-Proofpoint-ORIG-GUID: UjbMc5K5iHHNM2F2JRoMj4JcN0qvSGa2
X-Authority-Analysis: v=2.4 cv=LKJWhpW9 c=1 sm=1 tr=0 ts=6a0a3228 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=UqCG9HQmAAAA:8 a=EUspDBNiAAAA:8 a=pi3H7CPb95a1Pu1mXnEA:9
 a=CjuIK1q_8ugA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE3MDIzMSBTYWx0ZWRfXwdQSuoTig8/r
 bjkd63sTOjg/drQbXEzeyYJ6AS44x27sV1w+NWQMoKMDECEiMpaQVy7JomjrV/FTu7rQewTe67f
 G6xea79jtld1UTncbW1tEXVnNF8HDe69FgO3befaHgkLOkXf8p96Lhi1ISu18xZRvBcOrTCyHPU
 09b98hzdtvZbcofPiU6kNwkmPPtrr1/oEfBOCqdRkOOj2E7YadDAtJRfO8/ajkF1S6h4JEwf1fz
 jttxUqcALEd4rdXu26e/x7cITmXj8Bxo3/2zW/k0ulsYcJKCR4FxWWjVSHOzJ5cRLLWoXrV7JL7
 6goft9V5gQV1LPYCzZeWU/3OLjBWZc/SdkudH+My1KuBXylWugTR4jook8cMVQAAD6vh29wzEBB
 k5TlfMzbq64aN0PbX9j6nQ4Bj6ci/csJujWafMC1trfSgGdt7u10dgOFbLwq7yWj9ZEL1NPv/U5
 guWNmovLby1qtfXm2qQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-17_05,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 spamscore=0 adultscore=0 phishscore=0
 clxscore=1015 lowpriorityscore=0 suspectscore=0 malwarescore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605170231
X-Rspamd-Queue-Id: 7BCC6563FE8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-249150-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,qti.qualcomm.com,arndb.de,linuxfoundation.org,vger.kernel.org,lists.freedesktop.org,gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,oss.qualcomm.com:dkim,outlook.com:email,qualcomm.com:email,qualcomm.com:dkim];
	FREEMAIL_TO(0.00)[outlook.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitry.baryshkov@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

On Fri, May 15, 2026 at 05:16:03PM +0800, Junrui Luo wrote:
> fastrpc_get_args() uses find_vma() to look up the VMA for a user-provided
> pointer and compute a DMA address offset. When the address falls in a gap
> before the returned VMA, (ptr & PAGE_MASK) - vma->vm_start underflows,
> corrupting the DMA address sent to the DSP.
> 
> Replace find_vma() with vma_lookup(), which returns NULL when the address
> is not contained within any VMA.
> 
> Cc: stable@vger.kernel.org
> Fixes: 80f3afd72bd4 ("misc: fastrpc: consider address offset before sending to DSP")
> Reported-by: Yuhao Jiang <danisjiang@gmail.com>
> Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
> ---
>  drivers/misc/fastrpc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

