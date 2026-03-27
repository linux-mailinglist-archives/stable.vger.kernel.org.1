Return-Path: <stable+bounces-230716-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iIJBO5DfxmnAPgUAu9opvQ
	(envelope-from <stable+bounces-230716-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 20:50:40 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EE7A34A742
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 20:50:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 21DDF3030A1C
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 19:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EF493939DB;
	Fri, 27 Mar 2026 19:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pJNQ8bn8";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jvu15aWP"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F6243939B6
	for <stable@vger.kernel.org>; Fri, 27 Mar 2026 19:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774640899; cv=none; b=ZE8GuWF7zsyOzulSrHMsirLEqUc1AWrMjPhnNTLrDhLAHAGAmQjkK2p9rTSdLwDUv/3QSb6PzEVlJ11beORyjJH8YOXKx+cUSusCnFtdfcPPLO7A4KsBbgJ4kxH4DqccwnDhPvqV39tHTM2KluSR9LbB3JuApr/5oh4ojgXMCK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774640899; c=relaxed/simple;
	bh=M9yFdKVnxfaBThcDkIddKciB+kotta7uqMM6KThTDFM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SwSDOj1OyPV+i34QiPm/sqKYzwsouFKPx9Q4pz4PFhTykW1uXkkS3A/PvGOCcV0zmRYJ58j8nSPa3jCcztR7+qzdzA3lGh5ZHsD08T/+1ZqRHDyIgFA4OsoCfsZLKWWqaELkC5ekJFYPc92qsBxZPwRtvKZg+JVf41Fl8UIP90U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pJNQ8bn8; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jvu15aWP; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62RI2i853351634
	for <stable@vger.kernel.org>; Fri, 27 Mar 2026 19:48:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Nc5BQLdxMwwYUmrYYywNJDjCwfZ322iu+GCikJgAULc=; b=pJNQ8bn8/fEJnd1M
	4pvsKtWckqfiDvbsfp3Zs867WCOwlOETW+gIoFn7+pmimIUOQH+m05McVffzqgMP
	Z3cXMqFNR5+Gdtu/AWGk9riAimNg0JJTGMPtOM3HUIhtEflDGk+BxCK8V13KluTm
	2dB9Vj0hvia1f1R2yWrCwe1hAzLGjXXlKFVT801xSzbP5E3ma0N0uK26nWAWplHw
	W4e6wwSLtfZLFxU7Oh+jBsQP/t7Ccgw30ye6lBH+zAWbO0YkdcmsTFvcH5Xjj6Lf
	OpLb71+iRdEAT1jeerUqxQ6ciRAe6comHGKWd4cpBIeYXs0zSA42L1/4PUjA5XbT
	gJxBJw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d5bxv4g3y-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 27 Mar 2026 19:48:17 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-5093025ffecso73592161cf.0
        for <stable@vger.kernel.org>; Fri, 27 Mar 2026 12:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774640897; x=1775245697; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nc5BQLdxMwwYUmrYYywNJDjCwfZ322iu+GCikJgAULc=;
        b=jvu15aWPTJwd3XCfg91iDmBUJYl5xC1ag2KIcMPx9Oboqw3J0b354zO2e49vUhiKAM
         +oDYiH+Dziqo+EksUJaZzv8+vtJxtHhso0jrOCWr7kTS8wKQu7+hN6El3+5X66Mkk8c/
         NQqfR1Vhqz6ebo1LmHdJF3blz+GRU84geLJoCIBYsjqDDKMCakleIrSW5VtTFXUpGjqS
         qwu7Bk1UBbLic4Here8Ml8UW2Uo9C2rAzK4eD2CfAUmOuqmOpHkbNVEHTsgS55V4ysJh
         gdwX1TRDSfHXH7FWqIm0JD+CS5whg9xt9ZMktthNVNhQ5tXQtA8FyMjorwz0ehq3NRO/
         Ykww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774640897; x=1775245697;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Nc5BQLdxMwwYUmrYYywNJDjCwfZ322iu+GCikJgAULc=;
        b=BPs0XpIjZQmXob9lrV4DiD5zqIPYT4l8OHUuEpQ0jXSOfQVC5/0g/6CAyFSbr/fNK0
         Eykydqr0DYDBJagdowfRDk/KbDzZeW0wn0cCjQCEUUc+5yUwCC+TsoYTuHACYgUDdIEi
         uUyCLZje8PFcs4whsiwyuMVRYkx4lJNSTArvsQptfLPj1ZQZOfbfC7f+Qvd2QVI1PsF9
         JFbjrnTjf1/I7CqrWpEUWOTSYfobekfuZ2hxp2ATlifTGFkcRbp59lXlX3K2pIt8JwXq
         XJaNjA8GvnWFAAsU6+15A36yyXmRIN1m32crBhA4B+D/FpSEP24v6PheKjNjciZO2ohQ
         uiEQ==
X-Gm-Message-State: AOJu0YwnbfIWNVHTWkUvlYM2aPO7yH8MHa4g479+LpSUYkCjtTEJPqXV
	kCWP83tTirWDgrkLz/h9B0oDbvvMymCPUEmSu5M9+UMZwsgZn6PxVE8Ls7C859szOiUtxNFTCda
	dQSCz07y95iUqFA0Po9+OwiZ/VmpdcRtDCg9A6afwWG3aKRqjmhC+ww6PT9A=
X-Gm-Gg: ATEYQzx7ghbKyk8yQ7pizstfICPM+dmOTuonala5ltaJpRsCBP0yqFz6859dMeIuESt
	qNsGqrZ/qR2lUpxF4JEvWS5P/9hwL1i9CfzUTuZhkZ6hCUOKGBqmgFJ1qxEHDE2W6BSBn3Vp2Wa
	XGXkJ2XGQnOFDsp4Gv8oizTlCA7zoIQ/AtDxS0k9i1FPN7n3DV6fJ7g0c+P88u2Om9Dwu1SqUfQ
	6MDIbB80+mAiWySpLoKFw14ug3RW9+nPmyzeU6LzR1sQLn0IkcEu5Vr93iLB3ggWmQCHiQT+1Bv
	BMgsV0mwhpH/oKrze8fGkyHEPWuEJHXVznsPYRgsNSQ9b36+5AJlMuZ/uuL6vQVaRiTtBBXfNfc
	dvFQETISP+V4/43Y1la8IIwJo5N28BGVEOsKUXizM/ZKIUGlQJF0cBpXdC45s55Eyi+L/3QEwsF
	KSugjXjsk+2fhF/cGKnk8kx40G/uLfRxLq
X-Received: by 2002:ac8:7d4b:0:b0:509:3d06:96a with SMTP id d75a77b69052e-50ba397b630mr47748751cf.53.1774640896741;
        Fri, 27 Mar 2026 12:48:16 -0700 (PDT)
X-Received: by 2002:ac8:7d4b:0:b0:509:3d06:96a with SMTP id d75a77b69052e-50ba397b630mr47748431cf.53.1774640896323;
        Fri, 27 Mar 2026 12:48:16 -0700 (PDT)
Received: from umbar.. (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38c837130basm275211fa.12.2026.03.27.12.48.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 12:48:15 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maxime Ripard <mripard@kernel.org>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: stable@vger.kernel.org
Subject: Re: [PATCH] drm/msm/hdmi: Fix wrong CTRL1 register used in writing info frames
Date: Fri, 27 Mar 2026 21:47:49 +0200
Message-ID: <177463970801.3488980.2533820588503538950.b4-ty@b4>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260311191620.245394-2-krzysztof.kozlowski@oss.qualcomm.com>
References: <20260311191620.245394-2-krzysztof.kozlowski@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=A99h/qWG c=1 sm=1 tr=0 ts=69c6df01 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=e5mUnYsNAAAA:8
 a=s7uc8e38FLtQ-qa--o4A:9 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-ORIG-GUID: Sh0S7ejDZEc-mRpn0KEPHW_2kGsRaTBV
X-Proofpoint-GUID: Sh0S7ejDZEc-mRpn0KEPHW_2kGsRaTBV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI3MDEzOCBTYWx0ZWRfXztYhgoQz+di9
 ZdluBCD3ecCU36ZOnsijEFlxQmlxHPaHT9Xv/+axIgaM9+WhsYiH523JpI8nqsFLc34LrlbD+Gt
 PxC8ShZX2nd+ITniqbtpJv4NnzjysO/tcCEC7Ob1Mdo4+SzWuDCKUwlS6S+/OaUF/gu7CVb4PFH
 P6BEy+SMCn5RwOM4ZJJn39yP80sz4gGSSTNcVysN9OUjKuwCUFQ0C0UXfl96UnRWy/NJ3/YPL37
 /9gqKvEW3e9/ShRhl6qCQ0+vhe0XMgB6v9kUK/ZYUUQZ+5+jAryvYCzmpi9NNpdVy5jVh1JWu3Y
 Z815RLd78AVioZkCS8H3je/ZVVN/z/qW/Y+6o8zT53Y99yrBw2f0pfXShUIC4IGYng92sd/jl0G
 UsraS59P5peuteGh8QkWp0k1nPlbyiHnvSvzH8Mf3RHFMSTucKmujLJNlzUtukV286u5b3MNb8/
 iLH31Ps4Y3QmCOMROUg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-27_01,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 malwarescore=0 spamscore=0 impostorscore=0
 phishscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603270138
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[oss.qualcomm.com,kernel.org,linux.dev,gmail.com,poorly.run,somainline.org,ffwll.ch,vger.kernel.org,lists.freedesktop.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230716-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gitlab.freedesktop.org:url,oss.qualcomm.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,qualcomm.com:dkim];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitry.baryshkov@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 9EE7A34A742
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 11 Mar 2026 20:16:21 +0100, Krzysztof Kozlowski wrote:
> Commit 384d2b03d0a1 ("drm/msm/hdmi: make use of the drm_connector_hdmi
> framework") changed the unconditional register writes in few places to
> updates: read, apply mask, write.  The new code reads
> REG_HDMI_INFOFRAME_CTRL1 register, applies fields/mask for
> HDMI_INFOFRAME_CTRL0 register and finally writes to
> HDMI_INFOFRAME_CTRL0.  This difference between CTRL1 and CTRL0 looks
> unintended and may result in wrong data being written to HDMI bridge
> registers.
> 
> [...]

Applied to msm-next, thanks!

[1/1] drm/msm/hdmi: Fix wrong CTRL1 register used in writing info frames
      https://gitlab.freedesktop.org/lumag/msm/-/commit/8c6c93b7db42

Best regards,
-- 
With best wishes
Dmitry



