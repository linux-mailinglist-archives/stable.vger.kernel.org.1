Return-Path: <stable+bounces-239979-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +OteJuF05mkNwwEAu9opvQ
	(envelope-from <stable+bounces-239979-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 20:48:01 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C06C43310C
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 20:48:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C5FA530B3F14
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 18:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 113553A9D9A;
	Mon, 20 Apr 2026 18:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oveS3xKe";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="L2qtR6yA"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B7583B0ACE
	for <stable@vger.kernel.org>; Mon, 20 Apr 2026 18:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776709928; cv=none; b=U7X59TDlXXGKqSpSTxDYcG9mICIvuT8PGf3TtfODAz6zfOn7gWkzpcuoToN2NOJ0EiiNTPShMWNFQSqE//kZXmIUOd0sY8lUKmn/Jg36PJIhxmKV3bXVhzvZ5IuVDyRUltNSf9koU5OTZWFHx2wcRMMWnOeKY3DR13dWAS42VR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776709928; c=relaxed/simple;
	bh=W6QavrvBH7AjDnv5WKZX+q/dyVslaJZVioNwIB14diY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LmriMIAWHF8kzHPwKf6/l1TQOmDJ9qfEdwHPvF97l+W3mIUTx+uzs7sT6Y/pm6XLgMiQLrS90/HFZ1gU8OW9lJrQHacDGOjbrUDwbCulo4QsfrcfU5zZ2ddJEQOMay6Ylm+1c540lekKV6ry+b8o/6USZWdowwXzT8ep7k7oJR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oveS3xKe; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=L2qtR6yA; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63KFYOL81600585
	for <stable@vger.kernel.org>; Mon, 20 Apr 2026 18:32:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MxNLE1MroW8m7Sdy5DUKFAIpmZj77ZEaz/yED/SLZB4=; b=oveS3xKe4loKoJ2d
	TPreMGrVp6gFKcGH8+y1lMRDidbu67Eku0LfVNnby24DZi0miSHxxGEojiLBh9nV
	8F/eaQPzDgJHIqOLGir7oNwkL4aypNjpwmfN9hiMBT260fHdG5xqxR8lU6GNCTZ3
	WHPqrDG9B1zL5l4PJo3h2wd0NPw564mvOhij9K+7csCfhUJU+A5bWLDsSlpqqtCu
	H6nj+niD3ht6oDTUIxC67JN1G5Y29/VY2pwGE9Glh8MEdqJx7G3NEi2LwmTIOtCN
	MzgE+EPK41fvg+eyMVatnLFA2XQ1qPzkzqq9YKRcuDSpnnj5PfXchMzoGNFY9+MM
	P/YekQ==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com [209.85.217.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dnh89a35q-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 20 Apr 2026 18:32:06 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-6058280770fso789020137.1
        for <stable@vger.kernel.org>; Mon, 20 Apr 2026 11:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776709924; x=1777314724; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MxNLE1MroW8m7Sdy5DUKFAIpmZj77ZEaz/yED/SLZB4=;
        b=L2qtR6yA/U8hDlOc8p6zat0Suod2dr8svLdq8a3LBd0qhDZjanIQfhOzPYdNg6SXRt
         x0g4wc0/XC9nJuif6xHKnHKgEin0f4zDgCvTSmSvDd9wgG2nwL7iv3ZAyGsmJpGNbiNV
         mlkjRdNUd269uK6tReU9sZ9WXg5bI59R7lybePzgynVnMAda78Q9AKSXWHtHfzc2uobS
         hjj1OdXlFMLrQNS9onzzviqdBFvP9zz8+X63ZIoqsjpn1VUeLjphFtH9Vq2XNi9Qvak1
         rlEbkPWMP2Y0PBKmaekf7Cbi1mVqgmH6qivlhCbJbCEMwT/FxxRr6wQfw+FFlujLXX6m
         GouA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776709924; x=1777314724;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MxNLE1MroW8m7Sdy5DUKFAIpmZj77ZEaz/yED/SLZB4=;
        b=Y8PZ4YMg7KQbRsS97dGxHlfduQAHuStk+AKAlNBE2gdHovmzT+9j8nOl+iMFn/1yWg
         wWQ60plvqqhV45Y/lxaXwmflcuBi/XVCT9q3o5RxKbweBImryGxEfCWDNPiKD+MJq7So
         PhD8PHzHHpKc6gM1bvraj0B8U5Xf+lHn8dL4uIctJMFqkXmWA4iiZECDWNLYdQH4+Hvq
         ipKa7Y1+ppW6hXINbUUoqaJ62CK/9/ddOzGogyzFkvcsmBzOJgtG0oupMi2wlRXwoYR1
         hPzMLu1QCIp9DxklNF1zje3GiE/xuaa0UPAVhK55hW4BcHi+BV7f2qH43m9yZPDYieWW
         mSlw==
X-Forwarded-Encrypted: i=1; AFNElJ/H0SseTBkUz9eYZNKDPxqgYWe6MNDOnn46w1mro7+2vnkTB29yNe0b/VwcxNZhbFL4yeL7MPE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVjymbFagQ6Ow6AYjNNWBiHPb9hf9h7Ug7HuolqS+TWPfy3GsX
	yV8XxiH309VdQyJeWdPdO2+yKJxtWKUcNCQFXOPwUdhA0qA0NfhCknQTsn46C6432UfeWGcoDwE
	/ibizXDy+AUCSyAzdiQ5au4j00BfryuNiktWLx6Vuzu/QLFIvVMLEOB0/pPgKTe0JRmE=
X-Gm-Gg: AeBDietOf3Dvl862xGrczFJjiRWcFZ//L4Htci/Y/y7TEPdzex8y0IFTIBChAZdtqJS
	y16qLPa007R94wjDV/X54Y19V9VW0qn+rTO7XQMDmBPROvFhboxdUrjHEcd1uigh7Lm63OnmTen
	Z4KXA1idOKhj+HGP25TL6oMl+J0e/C6Eb4UjPr/zm0Aq2hGnI+9859aXnmykdR/xZF0wtcLMQ4l
	01JLhl0KKlvYvSatQnrCeEUmZe03U10Sn6nWjrSPNC1vGrY5CRsC+1s4QnDOgNihX1JW6O6ymNR
	QwERjG8zLEBkTAopO5YKFOrTXUTXrXLv7NQbqmgneH2nHBo5TmNkju0JFbMlzp4LZu8RmQrNzfg
	M8Dt6XfrV3nSay+4RsDb6BH7SfhUc3ShKP4JY97KHRa5563u2L4Bafz61r5F/sqOSsKepHCwNms
	EuanTLUSuZnlO96X2PlcbXuuS41LhRU3O64dw/+7Ejrube6Q==
X-Received: by 2002:a05:6102:956:b0:608:a960:c858 with SMTP id ada2fe7eead31-616f68c9ae6mr6129600137.8.1776709923977;
        Mon, 20 Apr 2026 11:32:03 -0700 (PDT)
X-Received: by 2002:a05:6102:956:b0:608:a960:c858 with SMTP id ada2fe7eead31-616f68c9ae6mr6129570137.8.1776709923385;
        Mon, 20 Apr 2026 11:32:03 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a41d85f704sm2119762e87.44.2026.04.20.11.32.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 11:32:02 -0700 (PDT)
Date: Mon, 20 Apr 2026 21:32:00 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Cc: Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Bjorn Andersson <andersson@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH v3 1/2] phy: qcom: edp: Add eDP/DP mode switch support
Message-ID: <vywmtt6p3itkrbnucahzvsh6hpwqbno7al5h5zrqdcf3cejyto@pr4of7o3zdeo>
References: <20260302-edp_phy-v3-0-ca8888d793b0@oss.qualcomm.com>
 <20260302-edp_phy-v3-1-ca8888d793b0@oss.qualcomm.com>
 <islxoe4wbqx5pl54difetdcl5lrqvfd5ysbaicxz5lv235sfmd@6hwrq3rmqx7c>
 <fffa03f6-82c5-4d87-9a41-19e6f82ec39b@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fffa03f6-82c5-4d87-9a41-19e6f82ec39b@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIwMDE4MCBTYWx0ZWRfX9FoQD8DLiAP/
 fOgNILn+owj55m+icknYEBfjWcbm36pN7YPwBSL8pWqhuMqAiMSXbduK2DNIvZYXpTcPXXNI5J6
 bQuITzubQY0b+PTo751boAtT0lnZtqKq/KcP+haCDuE8dVnHqt2mw2ApPiiI+YWKI1jVGJ4PEft
 Q/lH1v9rXplJUwGmnZVlf5ZuBgPQ12xP4dEjZ9kHyQ3EP1ugW6sx9y9QjBOk1vOKysJkwwjW9tt
 6dfRfhYTunQz/iI70nGR+e83AY41NiNvzQ7Z6e+B65ShGdZXF82cgtkvB+TEL2hSRlhyplNINej
 u1hHCiMEMjO8BZv5rh7ONEdBj3zYqR7ahlbUoOq55oYb9VRLL26LEyibRdHjbu8Zxte/F/3Wgaa
 2JLh8Tx+VTn77WGzmG5I5q//8gew+pEYAvsUhKJnhSFgVS0NjgrkzQnm6x24I82q98e2TIxdfGt
 JgcDNLDx4BGrat7TlSA==
X-Authority-Analysis: v=2.4 cv=D6B37PRj c=1 sm=1 tr=0 ts=69e67126 cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=E1eVf6o5s5qXEWiT5LcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=ODZdjJIeia2B_SHc_B0f:22
X-Proofpoint-ORIG-GUID: kX8cIt0XdlNWx2hrDJssPiqPenYIVOKu
X-Proofpoint-GUID: kX8cIt0XdlNWx2hrDJssPiqPenYIVOKu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-20_03,2026-04-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 bulkscore=0 adultscore=0 lowpriorityscore=0
 malwarescore=0 suspectscore=0 priorityscore=1501 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604200180
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
	TAGGED_FROM(0.00)[bounces-239979-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:dkim,qualcomm.com:email];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitry.baryshkov@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 3C06C43310C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 20, 2026 at 08:47:09PM +0800, Yongxing Mou wrote:
> 
> 
> On 3/20/2026 2:36 PM, Dmitry Baryshkov wrote:
> > On Mon, Mar 02, 2026 at 04:28:29PM +0800, Yongxing Mou wrote:
> > > The eDP PHY supports both eDP&DP modes, each requires a different table.
> > > The current driver doesn't fully support every combo PHY mode and use
> > > either the eDP or DP table when enable the platform. In addition, some
> > > platforms mismatch between the mode and the table where DP mode uses
> > > the eDP table or eDP mode use the DP table.
> > > 
> > > Clean up and correct the tables for currently supported platforms based on
> > > the HPG specification.
> > > 
> > > Here lists the tables can be reused across current platforms.
> > > DP mode：
> > > 	-sa8775p/sc7280/sc8280xp/x1e80100
> > > 	-glymur
> > > eDP mode(low vdiff):
> > 
> > Separate question: should we extend phy_configure_dp_opts with the
> > low/high vdiff? Is there a point in providing the ability to toggle
> > between low vdiff and high vdiff?
> > 
> Emm ,i haven't found any platform using high vdiff so far, and I'm not clear
> in which cases switching between low and high vdiff would be needed.

From my (maybe incorrect) understanding of eDP B.3, the high vs low
vdiff selection should be based on the cable length. 

> 
> > > 	-glymur/sa8775p/sc8280xp/x1e80100
> > > 	-sc7280
> > 
> > I understand your wish to perform all the changes in a single patch, but
> > there is one problem with that. Consider this patch regresses one of the
> > platforms (I'm looking at Kodiak and SC8180X as they get the biggest set
> > of changes). It would be almost impossible to separate, which particular
> > change caused the regression. I'd suggest splitting this patch into a
> > set of more atomic changes. E.g. the AUX_CFG8 is definitely a separate
> > change. Writing swing / pre_emph tables on Kodiak and SC8180X is a
> > separate change (or two). Switching each of the platforms to the
> > corrected set of tables ideally also should come as a separate change,
> > so that in case of a regression the issue would be easier to identify.
> > 
> Thank for point this, will separate the change.
> I mostly overlooked SC8180X here, since I assumed it shares the same PHY as
> SC7280. However, they are using different PHY sub‑versions. Will add proper
> support for it in the next version.

Thanks!

> > > 
> > > Cc: stable@vger.kernel.org
> > > Fixes: f199223cb490 ("phy: qcom: Introduce new eDP PHY driver")
> > > Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> > > ---
> > >   drivers/phy/qualcomm/phy-qcom-edp.c | 90 ++++++++++++++++++++++---------------
> > >   1 file changed, 53 insertions(+), 37 deletions(-)
> > > 

-- 
With best wishes
Dmitry

