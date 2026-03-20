Return-Path: <stable+bounces-227434-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YFnvM5fdvGmb3wIAu9opvQ
	(envelope-from <stable+bounces-227434-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 06:39:35 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E3872D5FEC
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 06:39:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B5BD63070905
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 05:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84EB42F6931;
	Fri, 20 Mar 2026 05:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nb96Km0v";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Mo6yyHVy"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 428422F3600
	for <stable@vger.kernel.org>; Fri, 20 Mar 2026 05:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773985170; cv=none; b=dOnNMipeK7JWov64Aa/o6SvIbvo7msqzfceClDkCZJ3vdNj4Wyuxg6VWdAYC2ErPkfl9sfpbQVDNYpAvBm0MAblyNL3dLr24IGyqrbIKDBZX14uDNYPJl04f79Ew0QPZf+wooacfdr+0ZAZSZRBpKC9eBtIFWoWrbWt63F8NVHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773985170; c=relaxed/simple;
	bh=tn1xlzI5Rsz9i5z+/pm+Z9WjiBMi3P8O1OnrgdXz98I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GPoGoLhWXPNW86S4DxEgthO8TnJIZalpcA4sfkKOmchotZkjRGD0DAEplOTdfL53q/STzKATU113zmi9uvZV8lx3xCNMQ3EA1H94cc5/lj5GZewZOsE/i1LoEV6ca+aejCzxwfbuPR/t36UXp8QSJ2D0ct0VpWNZCsh82U+Ulg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nb96Km0v; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Mo6yyHVy; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62K2Y8qP989742
	for <stable@vger.kernel.org>; Fri, 20 Mar 2026 05:39:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=j4ERqPzE1Zo551nVhEOlkvzN
	9K/lc+AKC3gauqsRUQ8=; b=nb96Km0vt4GalVJZFzds16Qxbpg7k3fQPv4PVJHO
	0hFmppwxVzyp9ZF/W3gFyES8uUe3IrbRxFjI5vm9vUfjBNAdDhfZOlu3UudRAXVi
	hppOOdUGk5x6ndTZbrQl0/ihGIG10ldteHcEjnB9mqp4JZyahf7jIjwSy7BNOISm
	uqoYy7Bfm6bIYAECauR1uXHtS7RLWIlnTlKjDFLfOzNtaB4TgcFSAIoJGFxQjxEQ
	7JJtKAKLFybaij8jg9mp7SQ2rssr9dIbnyvYcHuVI5QmfLXtMlPmlvzU+HA9B5mU
	ldRg6JtFh265Ex7WqO/ZsktqzEI0c9PH0i61ljc9DEXwxw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d0k0vacmk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 20 Mar 2026 05:39:27 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-5094741c1c1so128385421cf.1
        for <stable@vger.kernel.org>; Thu, 19 Mar 2026 22:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773985166; x=1774589966; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=j4ERqPzE1Zo551nVhEOlkvzN9K/lc+AKC3gauqsRUQ8=;
        b=Mo6yyHVy5bKF2K6S5M1pwTDQ5eR3/y4QQ5hCHeGSnqXIqHJnvIj2x3ygqyuZbWkg6z
         CBBv4ZoTIBMChaChnJnpdWOABDgkrCQwH7z3bkOHg6OJyB/1ipfXP0JTKMoPzDwxpd0D
         H/ttcC2qn4HREm8La87e0Vp5cug8pcoRtMU+m1V5Vb+OirJRTS8WAGul/WlVOXmz91Nd
         /NmUvnJOXkO8xu9tnXbMDwah1LiYZh4wRQrJerwisXXfsmMQabkO2yHMmmPEFCxeUCz2
         3VFhA/Pa02GwSlBeilvbZZab/zufvjZM4uwfZjAmHRIiLSmR5bQMg2y4Ys9DXe5wBtLC
         7r+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773985166; x=1774589966;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j4ERqPzE1Zo551nVhEOlkvzN9K/lc+AKC3gauqsRUQ8=;
        b=C6aXgJrMIADKXtS+N5W8avuYitWodpnmUJ65n9Nh9opmjfyOYpHbs0CPgvvBWdBuXe
         t3Co+Kw8JOGhvyOVbUVjxNC1wRe31efix5OAi4YYcQRI88a8FZJ7Qc0eT2uL9GGxbQtQ
         KL/PNQLhxvl9JdLINz8/iga31ReK+goZRPZxkb7MMZNP3kYGvTWnksb3YTGV7uqbgg+B
         EOKmubeKbrrP2uvqdi8lFuPR3SmXOBzAKRyMWMOwJdqZIpD4eKW6JCIiJQ3TowHzorOM
         KlIAMAhMPLmEktMHtzQ33bVfshDaRo3je+Wh7L29PF9pewlMOkoksiBKKF5bZAqIGNvk
         bmTw==
X-Forwarded-Encrypted: i=1; AJvYcCUopdl8IjTEdCPr50t3p5i9mwXIJjEIW+XgL7fDtuwu9cn23dxeO8PUCOLfO1yEFTLFXpabAQ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTRseTOGqN8h1Iw4IeXoMpxF9gvJIMmYH4wObDtUoR+jYENgkQ
	cb0EcmFK+pKLjXIhDy7NWW3X1g+3HRrDVblIGTcPK4G72+uYsFVdoMZVVKGxJyFry/rvxK3m//G
	Zh5wRjbbEt8z5H4UgvtfFLvLNB3nUxMMYP31GDBeZFeZ2J7ETXMNCR5hAJ84=
X-Gm-Gg: ATEYQzxWHHCGSngYdw83nqmEkCuBSw+DF8/C9pk750HjFMtDdGcRo4CQgbSCExIwswq
	v7vnOqw3XT3jMUK+/Ih5new9RQBGKaP+Ycw1rzma8oamGbcReNHASIvcWwWpyutT11Jvg0Uphx0
	Xze3jhyDilePzEPytnV166RLogNje5kStTVtkqVOaYTiumqaxoGFjkXaCorLJ4WhyITx7792/iX
	YljKP1Xwo7tbOJtVay9GTJi169lw7tqj4Bh05fSyC52eaiILIhs7Bj5yIhPvvkTmUkdbA7OqJgY
	ZL9pgyHU17sMGfooFyzvdqsv6IKxA5Jovv8G50gU6JIcfTvrPmUaqWAPVhc1+OC+nxziH5auqVx
	0ga5yhkqqN+P6n4VGwgHO0204fQJatzVMpirCY+56SQPRxZY3QuYGPtzZPryuYD+OlhQHdxn0NK
	fmF0Ygsnk8gnCeoPVa0FQPQ/uYY2scYi0OAo0=
X-Received: by 2002:a05:622a:49:b0:509:2222:4201 with SMTP id d75a77b69052e-50b375b779amr27242151cf.69.1773985166482;
        Thu, 19 Mar 2026 22:39:26 -0700 (PDT)
X-Received: by 2002:a05:622a:49:b0:509:2222:4201 with SMTP id d75a77b69052e-50b375b779amr27241971cf.69.1773985165848;
        Thu, 19 Mar 2026 22:39:25 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38bf976ff2fsm3238171fa.17.2026.03.19.22.39.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 22:39:24 -0700 (PDT)
Date: Fri, 20 Mar 2026 07:39:23 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Cc: Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Bjorn Andersson <andersson@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH v3 2/2] phy: qcom: edp: Add per-version LDO configuration
 callback
Message-ID: <hc3jz44ibxye4jm5bhjwdcfjg42ia3of5crzgcgodqc5kyrotv@d7jw2joumry4>
References: <20260302-edp_phy-v3-0-ca8888d793b0@oss.qualcomm.com>
 <20260302-edp_phy-v3-2-ca8888d793b0@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260302-edp_phy-v3-2-ca8888d793b0@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: lsQJQjubj0LFOwqOQU4HPbojKQpoq4DI
X-Authority-Analysis: v=2.4 cv=EcjFgfmC c=1 sm=1 tr=0 ts=69bcdd8f cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=VwQbUJbxAAAA:8 a=82J-8U3TcAj4iTVDHMYA:9 a=CjuIK1q_8ugA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: lsQJQjubj0LFOwqOQU4HPbojKQpoq4DI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIwMDAzOCBTYWx0ZWRfX6jWHTMaxR38l
 imjFHTyUhnUv/nW01o100lNjiOmMH+kJrGYCPXnQKch3Bm6p1K3SEryqP5uk7sWhMCa6sdIZvxQ
 tR1DNeI+jyd4Cgt1O1elAuo12NQJ5bt1bDwOwDOhSP0i/+/SIENZVLGeMaBWUcaBRbtHLCYMtmY
 CSZ717W7wpO8KMKt45E3C5dBLZC63soMq8NKjI1aKnmji9OXYcbrw8Zwu4WG2eBCt37PQvezKBT
 5WvDnfeM1Hjlg5HQ2yiCcy4KRlEfmF3gksn+b/lhG2OAy4/cM3Rct9jDsVoON/PFam1z+SHBxaz
 ISigYpYt7KkvA5zXD4E3FBQweeS7gRRpNj0kQ0cKxhde80YTT+YIVob6yuz1n9jarcvBh1M0nW6
 spJvjWpyu2JfmGEvRB7Je+SaGZeVbAxLa0QcaNCt+5SKHcYER++NmtpB8kw0DSXTIxLF/HwRcl6
 l6KzaAklIYejI85fD/Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-19_04,2026-03-19_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 clxscore=1015 suspectscore=0 impostorscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603200038
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227434-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitry.baryshkov@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.995];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 3E3872D5FEC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 02, 2026 at 04:28:30PM +0800, Yongxing Mou wrote:
> For eDP low Vdiff, the LDO setting depends on the PHY version, instead of
> being a simple 0x0 or 0x01. Introduce the com_ldo_config callback to
> correct LDO setting accroding to the HPG.
> 
> Since SC7280 uses different LDO settings than SA8775P/SC8280XP, introduce
> qcom_edp_phy_ops_v3 to keep the LDO setting correct.

Please mention that this also uses low vdiff for eDP.

With that in place:


Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


> 
> Cc: stable@vger.kernel.org
> Fixes: f199223cb490 ("phy: qcom: Introduce new eDP PHY driver")
> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> ---
>  drivers/phy/qualcomm/phy-qcom-edp.c | 86 ++++++++++++++++++++++++++++++++-----
>  1 file changed, 76 insertions(+), 10 deletions(-)

-- 
With best wishes
Dmitry

