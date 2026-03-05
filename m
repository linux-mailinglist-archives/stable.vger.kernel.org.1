Return-Path: <stable+bounces-223212-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gNywAQSVqWmKAQEAu9opvQ
	(envelope-from <stable+bounces-223212-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 05 Mar 2026 15:36:52 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 750D4213990
	for <lists+stable@lfdr.de>; Thu, 05 Mar 2026 15:36:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BC400303C83C
	for <lists+stable@lfdr.de>; Thu,  5 Mar 2026 14:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D248B3A2559;
	Thu,  5 Mar 2026 14:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PRAe/0Eq";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bFR/H0x8"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E32338595
	for <stable@vger.kernel.org>; Thu,  5 Mar 2026 14:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772721407; cv=none; b=IpOnVQsh5Fiv+u6tzrwXDQURRkPNSlMbnGINgtXQSRbGFr3Wha1mGkYVul2Im0uik0gGYbl7TsuvCB3znWL3Tq8WYJViIKEO+UrAQo0s79MJLf+jgpqm769uqMlEnzmv7+rB6NTcfT76X7xILTDVNhu9GfBTVWwaKoYliFeQvHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772721407; c=relaxed/simple;
	bh=W7LcSJDO+SmcI9iBgRwPWOz/I3O0rsjVjXKttw3Rl4w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jat+b1Jcy4+NV6Mrr3+AyLUA+NE41qvimP8nuIwk0aJO5R0z6YH8/tajwL5EzNSxMAcrOLVGUmpAJJXeqVlx8Qn2PJnw4jHJXJE1jRhBYizD+XRmqtdaescErGqdO4e6hQv3WtfA5jl2uNWW5eOfFvFmeDFgJ6+DwY+GYzT5fUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PRAe/0Eq; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bFR/H0x8; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 625AFo1Z456100
	for <stable@vger.kernel.org>; Thu, 5 Mar 2026 14:36:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=M9kOZ2oA46DkDMvPSWIl1WyV
	VW6X0vR4sjQ/X/1ot3U=; b=PRAe/0EqEiMjUGnh75oi1rvpcTT0bLSMo3s9Mvxc
	zmQo3yUTTpMYkV+Qnv3XTcQsEV3nq/TqKC2oJCwnbWvi996MpDVwUpc2p+VGUX8d
	bPZikNWVwBCyiT6dpp9QvGWuKlBTRq36joBp/7+CAlOZ7xU6y+n3ERgQ7S/zrHkJ
	574GukIy8tl90hWjHr47GEEw4USQGd4A3Trh9LIbmvgXWQc5hPK+fsZDo+hrqy27
	fOv+tmtvWyYT+qT5BC24UpTdG9vJXz2YqEMWvex2MVwkRPN2OEcr1vKnUDioRQdp
	cGnmlVXHFBmw6zL7YTTNr5cCx1sUb+fUgoju7D9Hb7MVHQ==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cps0wkjus-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 05 Mar 2026 14:36:45 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-89a174bd442so135111906d6.2
        for <stable@vger.kernel.org>; Thu, 05 Mar 2026 06:36:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772721405; x=1773326205; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=M9kOZ2oA46DkDMvPSWIl1WyVVW6X0vR4sjQ/X/1ot3U=;
        b=bFR/H0x8hoMoJ5A2WqrfD/3OrdIP8ZOGC1U5BPnysmfmpj9mnpHLyrvihi8qvvJFy5
         eXUUGAQM71WWSSoFpqoY0KW/fMhveL1dj9I3NTBAo+/WYIyA17lf55BUZ+CouR7Jq1jE
         JMABFM6H/zvdWBZaxdVcRT93VC4h2GzafqxrXuHsXblI42OUB43RmMaXf8mNjIorLr10
         U1RQhpV+hzhaOiwJMh0bXdISDSoQVcJu2zuXd+b3kzOvpfutvuf5MV0sKsLraRYcbH9E
         7aBaNr1OqCJc+VNRdVqbpcOt+Zy7ZC161fa1X+Hl4KRCgwaG/4hEunYz6GHGaRauRTZ0
         XdkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772721405; x=1773326205;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M9kOZ2oA46DkDMvPSWIl1WyVVW6X0vR4sjQ/X/1ot3U=;
        b=wZsbdfYcQZwiZrX3QgdjPipLX22VNXLb0qmxHZq34szEmd1tA57nTFspwgOAcBrfrR
         qKaRjg+d84hVntMUY+3Qo9x31zMPSQrn5oFCmSM3e7Kv72sPfiZAlKK6B8uuxgEUULJr
         RBlWSBZSrWwZgwTAniyp8UBaTg9mCnQdLR3v8FARbspByLD8ojqJ/7eI3NuBFDAZhm3M
         gsz8njeTMkocDWekpylvyr963V05G/nR6hcT62pRmGFiCoBCzlbJxttQaRoHiHcLFUVe
         pWhBZJjFo1DCzqzmiD7497S5LHDW8j8nRKDywRRsdaClFMENWdofo41Fy1a6yhpHl+E6
         948Q==
X-Forwarded-Encrypted: i=1; AJvYcCVVEOsbpV3ilHeM1lH8lm+jQo4zDSA9zxEE6sFwoMF+wdqy2h86skN7j1fcyVX/b62gEG5tNqw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSs3ipdeDA0BbjSSZrx+SvwKDySFRvRh6fZtA0897Z5rdZwG2i
	GyR1dfk8Aq+jwrRTpaIM55vB5ACLPkMy5BPUbirL8zVs32IQcDRFTrD6gTDHm/PsiJpDeLykQxn
	nXTKDKbVXTQgMRvIejI27+f6HS8K8iY6Kc8hPzRrjk1nkQb/9yzlUkJYDTvQ=
X-Gm-Gg: ATEYQzzE2IHhX4I0zbRIfYVMM5ZRgnBIO5bD4vGguia/MkR93ZpDFzZEmWhOk7QdlTy
	63N5K6Q1ZO74gqoho2ngQzItAgsQKdAGnMFNT15rFbfu7TYCCAAsPpGB+Wamd6A8WIRAiqaV8Vo
	/2a/VfGyh0wdvezyMZxa5DQcLhGKvPsH+UKZ1T8F4U9vvJEeaRYEIyHbqIlI6HYlzqVu9/9RRje
	vCg/L9dHv5ZGF+uY2tLk4vOvfU1Jg13etIxK6/x+ebq2qHvnwWSDCrB7adXlXHtNI7f/3SuEMf4
	vVN8uEVZNtfk7+Q70fwFVezzxWYwXuZB/ARWtXDgABXaX95eBhxQjpn/+ZPfgd1gYXmogHjObyj
	dNMiRLwDAAg3hlzck/dX4nyPHRwmCB8tiJHLvoTwiWinKCIwjhsgCe8tAOZlOtUcsSC6HdCUmck
	ABupPEZkyu8VyRtlqprN/FZQHRfeDel+lKvWg=
X-Received: by 2002:a05:620a:3949:b0:8cb:678b:4877 with SMTP id af79cd13be357-8cd5afb739dmr742169785a.57.1772721404780;
        Thu, 05 Mar 2026 06:36:44 -0800 (PST)
X-Received: by 2002:a05:620a:3949:b0:8cb:678b:4877 with SMTP id af79cd13be357-8cd5afb739dmr742163685a.57.1772721404214;
        Thu, 05 Mar 2026 06:36:44 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-389f2ffe02bsm41758591fa.27.2026.03.05.06.36.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 06:36:43 -0800 (PST)
Date: Thu, 5 Mar 2026 16:36:41 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Mahadevan <quic_mahap@quicinc.com>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Abhinav Kumar <quic_abhinavk@quicinc.com>, stable@vger.kernel.org
Subject: Re: [PATCH v5 2/2] drm/msm/dpu: Correct the SA8775P
 intr_underrun/intr_underrun index
Message-ID: <ulrmxcsncz5j7hbi446q33ngk63pfuja4pjvbg6zcg7c6kmn5c@ltguvvq6nsda>
References: <20260305-mdss_catalog-v5-0-06678ac39ac7@oss.qualcomm.com>
 <20260305-mdss_catalog-v5-2-06678ac39ac7@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260305-mdss_catalog-v5-2-06678ac39ac7@oss.qualcomm.com>
X-Proofpoint-GUID: mZQJwLDYnz8Q1cXqj-eb1WB_ekamImNP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA1MDExNiBTYWx0ZWRfX3hxCn7bHv1QV
 ghqZ+0uHZN85UmaAgfvd65sux3ne0aJZYqUeBtXVBVaetgetbwmxVFpNFrjbaZ75DVBB7eFh60H
 XNYfocVNUtqqBKvYQ4buBh7jYA51fZc/mS9Qdez5BbIcm4B32eKk7/5th06YwEU2LPTZ4YNw/FD
 OrOLQCGo23TCR9yhLyrIEWpmvGwamI5t0vMor3Ijuees/v5+4Sag6HcSlX10VKlsaWY0OEk4XFT
 FcDtR6Lrc0zJimRPPSWlvAH3HoBYoUoDhl9VKbBrpgX9krS//red1fxb3Y6lCR2Wt9qAF/GUubl
 46tyd0m29nRuu7R6YEdaLz1fRUhIOVfn2GjEu1Z7e/6roMjEBUI7X4Ro6aiNa3fjl56kAmb1koq
 IYOXy322HAtELVwee/GpdvSUdY+q2+pR4vqgOvCXAtNB5FdPpKqC69Zj08nAc4HOQV1w25rP84U
 yia6zPvbXgoFVQGHAwA==
X-Authority-Analysis: v=2.4 cv=OYWVzxTY c=1 sm=1 tr=0 ts=69a994fd cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=COk6AnOGAAAA:8
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=s80QRqCtEMuw_QvzVh8A:9 a=CjuIK1q_8ugA:10
 a=1HOtulTD9v-eNWfpl4qZ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: mZQJwLDYnz8Q1cXqj-eb1WB_ekamImNP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-05_04,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 adultscore=0 clxscore=1015 priorityscore=1501
 spamscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603050116
X-Rspamd-Queue-Id: 750D4213990
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-223212-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[oss.qualcomm.com,kernel.org,linux.dev,gmail.com,poorly.run,somainline.org,ffwll.ch,quicinc.com,vger.kernel.org,lists.freedesktop.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitry.baryshkov@oss.qualcomm.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

On Thu, Mar 05, 2026 at 06:17:07PM +0800, Yongxing Mou wrote:
> From: Abhinav Kumar <quic_abhinavk@quicinc.com>
> 
> The intr_underrun and intr_vsync indices have been swapped, just simply
> corrects them.
> 
> Cc: stable@vger.kernel.org
> Fixes: b139c80d181c ("drm/msm/dpu: Add SA8775P support")
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_8_4_sa8775p.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

