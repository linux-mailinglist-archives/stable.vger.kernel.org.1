Return-Path: <stable+bounces-224790-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iE2JLcIosmlFJQAAu9opvQ
	(envelope-from <stable+bounces-224790-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 03:45:22 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E474726C669
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 03:45:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 145093013FE9
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 02:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB4C137DE9F;
	Thu, 12 Mar 2026 02:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="e6k5neuy";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ikmRculT"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3103637EFF9
	for <stable@vger.kernel.org>; Thu, 12 Mar 2026 02:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773283518; cv=none; b=rUCmwuF/mVm3vXPJDb/wbQPjeZSZ5vJ20R0j3X2hWy5RtdOaUgvaDcTh08hD55hOAAzg0XKF8hogwD93wOFD4xCuLOwTLjPnnnY8+81gWoK9Cix5o8z7jONSEMV+V5huJBZCvzAxYa9KfOLhHs8E0pT2VYhApSbNW2y2o2kHwDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773283518; c=relaxed/simple;
	bh=jAs54Ca8GJ7r/A0R/a9D2iqsFwlLxaOvqHYkHziVzBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OqHPe2qJrFUl+eJZdbby0ufqt0BJJ5S2epHqNTAMRnKBnTUSNeOq+2N3iUMYWHSiICizQ2i+om1dp79WHienzAjN8bJXuP1cjMlpBGAUaTK5SgbYEOdguPlIe4flpTBtiCrIxJCPbd8mV614W3JlX/tWVgT/9icew9MUHDF5xD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=e6k5neuy; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ikmRculT; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62BMNiaI264731
	for <stable@vger.kernel.org>; Thu, 12 Mar 2026 02:45:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=Ss1Bk5xEOyvfFXO0AttClrHW
	ulnGSLKespJtg9jgeOE=; b=e6k5neuyHiGb7BCFzKj9SqAOuF1RCswKgi+Bjl6V
	MVHVn6JLfoC4R1jZVbDASwXyfdcK4rY47N6fM3fokNW/YhPr1ZB0nOxiVJSkmqX4
	SeeObDPMlAcbWJ3cUBLQMk6WnosuGFYX0f3Nz9Tzzu7ZCofDN73TVrgPpTaY4Wef
	PhSQJ0BnTuAXBXnqF93ErN9k2NdVHrDPUo3aT/W96N1xxSru5XuQCK0Hs3dmBSdW
	AAyLILh7SRW/gpv0W6kf8XM4VhTO6/qds5jb4BNSJJbiIha8e5+/1vOUhMdiG4bX
	EtE9MZV03XRdfukjCrpf+eOYU0JX5ooRAgEbr1WHXcWvpQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cuh4ygkwr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 12 Mar 2026 02:45:15 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8cd7a25c5a9so302575885a.2
        for <stable@vger.kernel.org>; Wed, 11 Mar 2026 19:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773283514; x=1773888314; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ss1Bk5xEOyvfFXO0AttClrHWulnGSLKespJtg9jgeOE=;
        b=ikmRculTyCDZwTPEOLe+HBZcH4R2b8TnNklWdMcsJ/afmSTNzvRvlwCYNOi2P7HEZy
         cJDbDDkiF3zN5aJ96km6b48mftToe0L0scSwccHYR65dWWS298omk2YDrxMiwvR82Ud/
         hn6inRsPR6sD8CQr+PIH6hrlVr6ujRYp6qSaPRAiq5Kk94rP7PRhgP15ukFQiEVjs5QJ
         znKgP/94d/vk/UlDd9dno3JAZCIAqpm0S7jD2z11I2My8KIo4p6cacKPY7erf5Mm55yz
         N0ETJlHH98ohbxANtdW21UMXp5h+wc164OB9gGAZBcgIFpgaxinz0SNCl5aGJ58pQVwL
         SZbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773283514; x=1773888314;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ss1Bk5xEOyvfFXO0AttClrHWulnGSLKespJtg9jgeOE=;
        b=SxuD/qBHluOnx6aOfbBLrSDVNjdM7rDRvmr+P/NR2Ech5w1GZzvLBHN6CGOFhI/69G
         29+wGhUBltC/R4YqkN02prU0CBy8MOAbpqRaeSv1TYW9nA9Nv/hXioIkcCyUkiPSv5PY
         o1swPkB6Zw7nbYEA0oAjYxe1Ayr1RLCIW7uMoG1FtsMFOnRWhwRcxJHkOkLPDCNqPtss
         Tdk3/NWaQtEzhQUDJGzKxil9dv1sdmq5aFK+FtOR6gIwGBlpIV6eR90f4CQZV/1iBuVZ
         mPT+x7PvBq/6a2642hNu7YPn3iwpMjnCQsifXRyobBRuBmtqnfuZVMYQpx2iaIwNa9Vm
         fMUg==
X-Forwarded-Encrypted: i=1; AJvYcCV9TKpfNjvAWer7z3hT+EntckLCNZEtFZDtNCdOAXGfDBHWQ1mKlNXZC0Wi8RpI52rGTq+K0e0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTrojRdY8FaAS3ITzykFxZFZwCI/I1cU3FriWIy+VdMWxc+ZwS
	YrHHXM8p83IE77lvsU6aHMN3YVWEBh085yK9Vmt+wsD4EnsJC0SZtuc0aeH2qF/EmT/B5vIsnkE
	CKfJjtQ/9U0aulzjk+FtQbaNwz1Fc7mg05iCj30vJ+aTE4TGsK8wNDqgQD5A=
X-Gm-Gg: ATEYQzwXTiYVNjk4BsLsjONuUTHsygYsZUfD6Y68inuhQifxXfnB7XSEZcl4U2CRaZH
	av6V+/UzhRkxVuuHztcfgRPlJ8h0hvJHyztp2dC0Xl5nIVQ1Yo5ETcy0fWM42DuUvCH25658cqN
	NYpwKcpPumfg9q3rYXUSbA8Dx7fPaODH0YxIONkDUmWyNM4OBAKCMNiab7OZ/56Zh7ix0AHo/bI
	UQwy1AhSdIk+cmPYLNDc2jtOL2GyD8nMj4zlB8XbAY0c1/zHEuhJQmh3k+ViTpgbOu8HsUiRlPr
	GjhIbYyPjtXmBtR2at7ct7tJTO3rHk5rc7tDyXAV4BNGTsWubkn+rl77IWtJnSQP7rd2FPNuLL+
	m90u2YmZL3EZtPOQHbchagzOjc94qBLOtOjrMn4onU3XxXcKYHw1DOwrO5jQtfFV5bzT7tu8Prw
	mPtUFN6Ply7yPts71ZCX779AcmEtbzX9Wqh7A=
X-Received: by 2002:a05:620a:1929:b0:8cd:99de:6b5d with SMTP id af79cd13be357-8cda1ad6b11mr607903485a.75.1773283514588;
        Wed, 11 Mar 2026 19:45:14 -0700 (PDT)
X-Received: by 2002:a05:620a:1929:b0:8cd:99de:6b5d with SMTP id af79cd13be357-8cda1ad6b11mr607900385a.75.1773283514118;
        Wed, 11 Mar 2026 19:45:14 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a156374286sm682727e87.87.2026.03.11.19.45.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 19:45:11 -0700 (PDT)
Date: Thu, 12 Mar 2026 04:45:10 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maxime Ripard <mripard@kernel.org>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] drm/msm/hdmi: Fix wrong CTRL1 register used in writing
 info frames
Message-ID: <o2tdppb32d4ekqtylxzwppqljv2c3bxeaesmoduvlyh7ifz6ah@6k774jbwndq5>
References: <20260311191620.245394-2-krzysztof.kozlowski@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260311191620.245394-2-krzysztof.kozlowski@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEyMDAyMCBTYWx0ZWRfX924bl89+d3YV
 BvRvChbg3u4EqYoyubOdUc1x9Dc8Y2UaylmoLYAzq8MP6Z2/zu1e0mx726mBkFoFfr+6tofn18P
 4equGVnIwrSxLr8Icsxb4RDCUwW3UzSxwZJG240QhcwsSV4DOduI1V/d+zdpvCsT2spVYAbw8p3
 KIQsmf1vnFPqV4QFtyChavND18kzdVpSSGtFIZi1bCJxqACv/C+ht0rkzThWscaP28bbcIgp1Xh
 eVogLvC0bWZYmgZQ0C9rMzcvcc9sVYcO8W1egtaPGufftNBRbV2zieXYv4GOtq5rZIhL78lFAWJ
 nnM4RqEACRoY+dVkNUlLT0avSMMlfjgNPjD57zcB0NoQDKo7lJDEUav182Axn1SpOphRfL24MVD
 IizhZJ88dX8J05hhP7SZZ50oR3ZamSweL8+dZtlNeY+MmwAYfwXM6HfOlLBI6FR7chQJK03GSeN
 MoEOCBVXsRVZEzMeeIg==
X-Proofpoint-ORIG-GUID: oVsEfLzVf4Q1tX9mQsjHe9eOfCQNpL1J
X-Authority-Analysis: v=2.4 cv=C+7kCAP+ c=1 sm=1 tr=0 ts=69b228bb cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=4RWvjT-ast3oIKXtKOcA:9 a=CjuIK1q_8ugA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: oVsEfLzVf4Q1tX9mQsjHe9eOfCQNpL1J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-11_02,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 phishscore=0 adultscore=0 suspectscore=0
 bulkscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603120020
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-224790-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[oss.qualcomm.com,kernel.org,linux.dev,gmail.com,poorly.run,somainline.org,ffwll.ch,vger.kernel.org,lists.freedesktop.org];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,oss.qualcomm.com:dkim,qualcomm.com:dkim,qualcomm.com:email];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitry.baryshkov@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: E474726C669
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 11, 2026 at 08:16:21PM +0100, Krzysztof Kozlowski wrote:
> Commit 384d2b03d0a1 ("drm/msm/hdmi: make use of the drm_connector_hdmi
> framework") changed the unconditional register writes in few places to
> updates: read, apply mask, write.  The new code reads
> REG_HDMI_INFOFRAME_CTRL1 register, applies fields/mask for
> HDMI_INFOFRAME_CTRL0 register and finally writes to
> HDMI_INFOFRAME_CTRL0.  This difference between CTRL1 and CTRL0 looks
> unintended and may result in wrong data being written to HDMI bridge
> registers.
> 
> Cc: <stable@vger.kernel.org>
> Fixes: 384d2b03d0a1 ("drm/msm/hdmi: make use of the drm_connector_hdmi framework")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/hdmi/hdmi_bridge.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

