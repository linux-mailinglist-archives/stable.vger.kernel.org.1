Return-Path: <stable+bounces-240386-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uA4mBBcl6WmMUwIAu9opvQ
	(envelope-from <stable+bounces-240386-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 21:44:23 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DDB044A47A
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 21:44:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CD35330074E1
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 19:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 512C73F1675;
	Wed, 22 Apr 2026 19:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="S5uk3YIw";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LUTuiWRa"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC173F0ABA
	for <stable@vger.kernel.org>; Wed, 22 Apr 2026 19:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776887049; cv=none; b=cY0y5xuIbzzlBvMjWYdmZLH5BSuo5myvT7g5ygjdoEhSzsG0WwUlh7zZnjv/sF2o7KgAg+osIbOH0JAf4fJ2uMu/KgmplxZh2F9Q1gjYeBIpXHs9cCszyls1DyJWXAVEjesO3Oy3BqvNqfaYALGCiGyF7U/pxzkgYSy2JYTRCVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776887049; c=relaxed/simple;
	bh=UvSNowWfVPrko69VNDpkOadUZRsnzxWhRiuKcLSTRHc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kn7d9KUAuLIjEqRwyJ327ftkziLfG4jwebmdh57H3vHbQGk9KUYpz6LFiV4sBPInSG1eokv3PDJpFiv85juJN8Ha5BYV848TkI2MVGmLzU7NMFBJaRL7A4Hq6nIaKbRLTgFRSr5TkF4IrSTwM0FwozSfBC/P1quicXZpyCF2Jec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=S5uk3YIw; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LUTuiWRa; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63MGA83f3174074
	for <stable@vger.kernel.org>; Wed, 22 Apr 2026 19:44:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=QZ7ccC/Oi6MF6opuvHlXZAnP
	QwAxSMZhaQdKsbbz5YI=; b=S5uk3YIwpzKSCshHbU8Fa8WxsEo0Aie6CptlEGs5
	NSNLdBuKuuUVFX7FjLh3vk3Foh5rA/ZvJ5Bs8KHPxUOUSl6i293igpL7Q/eBu8Jd
	wJe0B+OZrzSnETX2NAa+ujS8NNxXNiwO4KJ4LrLiZQLYlvHxugzZYTaVDWgoUxGr
	PaXMc2sOdnN7gKwGBQeui97ZrKPD1GScRoc65PcsZlkXE10wQ3tZqWlM60lB+j1c
	STVi4hLzuff967KHvGio5rQYotzN5jD9wRZTuN1oF2ourvSjq486BbfE6i1pP1xJ
	mNgiB5psvMPfZaoAtHadf7X77t9x/gV4I7xx06X1gh+Dpw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dq1m30rne-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 22 Apr 2026 19:44:07 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-50e67a4f642so83081581cf.0
        for <stable@vger.kernel.org>; Wed, 22 Apr 2026 12:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776887046; x=1777491846; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QZ7ccC/Oi6MF6opuvHlXZAnPQwAxSMZhaQdKsbbz5YI=;
        b=LUTuiWRaBTEFG4kvEveyD9mgSxFfnxdpjw3F6Qx+ruw0CciU+qMzrjwouOnERX3w9q
         qUyYD2obRR+R6LVzqP2wiBtlcRWNnLULPKyhuD2qG88ruISecPLE+Lu4NC292NNzKztp
         EFy0HNCH7xmMg3nhhqxSS+UzHmrphZhmisa0R1E5w16C7PaWxqBVj+ZuRb6hwF6a54hU
         hoqtIcfBRbKf2QPT/skbu8IUsFGniN8CgYyY4kBje8NbukirtnR0lDd0X+3AycXTbbXq
         G5oR4WusgHq5hG+6B/ZBRaC23A5IFcI6IdrczrIrn0+KaKEO6QnRR4ByM25LAwNHK9pe
         jjYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776887046; x=1777491846;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QZ7ccC/Oi6MF6opuvHlXZAnPQwAxSMZhaQdKsbbz5YI=;
        b=aUI43F1Hrkn+QNlQfKlSxPqOD0ZFly2AsaH1irrRpjN3j5HElVgedLVc/HPdvMbR59
         ULLqGMcY/xed+C2y40qM7QFGbgJCyjWlv1/kmR/OirpyytBvSJ2mJKumClc6wRBD2lJ5
         d4W4Ybmg8JtvJtkx9rVW08fOKCfuWxX5uIHCAWgpY2IH5g8ghwoPU++bxZfwRHw506vo
         y0avp3Ga/wyl9eYr2PWZcVm8LS/D44MnSW0NBEX6X0D35X6UUVLzlhFScl07Ng+A117c
         GPqe0wSfR8++XhCjU+BQnb/5oNf84/enylHg1JEFny1btiBqIh/en27b6GgdYHd0Wnua
         +OFA==
X-Forwarded-Encrypted: i=1; AFNElJ+Atze8ClS6tzgvxEsr2j7y2yicR8ru1WyNiEHx6aIQNa7MEdf/GzLLDSDEvEC3qfZV02HvX2M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTg/4DJd7zZ40Vtx390oAxz50wcc+5FnFGWwHGYg0uLBRBT+H9
	FJrhOhb/w9dm2KK/pBaD8H/436hpTvp/oWEy87XgNNQCQVvXfyy0AYatgoBWO1y4SRcUauzZ8i1
	uyWBYDtpzZkPQ/6PMEIeEkFWxFGRViLlJOePg+f+dAc9I5m8JV5RUVcX5pek=
X-Gm-Gg: AeBDievgcvfupFeG5UhObsofN5JjuYE6PgvzfLYB9lOjgf12Ye1U0/1MDt5EQvpkLom
	Mk0Yk4NNWsJjcyRZeo8qlTT36YJ1zNpPUarbbG/V8BgJlw1rMsK+J9g1YtLQbrd8KK75ednIWtG
	cEcE57DN04PgAQMX09BRSketVpwlrBfiRxEpp42o4MdJgKlqQo1DBdyXP4zfRyzHss/XycRRcZM
	mmglV/Ann5elKN0vqEO4Gv+FhLajYerCu76iODX0rHdpE3MoigYRwZpN+9EtIyxDl5d5dM6uCgy
	hDUh6IxkjL5cmh/yh8whIyzTU1pC6tGgDQs65UPEqtJW4F6fqd5cWfJVZEv/5idEkMf55uAkeuH
	lpXWzOMPu7bI+JGp71gjcY9fArOY9h5sHg+CHU9fA8rwW9F2u83xnK0PQtJvNlFAkpSEULTsGEx
	nP6rT7g5ruWpxKUn5VTD2115ttuLx89ZQSAbyjpSXZzUbeZw==
X-Received: by 2002:a05:622a:a951:b0:50e:5a1d:8422 with SMTP id d75a77b69052e-50e5a1d85bbmr173885591cf.28.1776887045934;
        Wed, 22 Apr 2026 12:44:05 -0700 (PDT)
X-Received: by 2002:a05:622a:a951:b0:50e:5a1d:8422 with SMTP id d75a77b69052e-50e5a1d85bbmr173885271cf.28.1776887045460;
        Wed, 22 Apr 2026 12:44:05 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a4187e7a57sm4585441e87.57.2026.04.22.12.44.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 12:44:04 -0700 (PDT)
Date: Wed, 22 Apr 2026 22:44:01 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Udit Kumar <u-kumar1@ti.com>
Cc: andrzej.hajda@intel.com, vigneshr@ti.com, b-padhi@ti.com, devarsht@ti.com,
        y-d@ti.com, neil.armstrong@linaro.org, rfoss@kernel.org,
        yamonkar@cadence.com, sjakhade@cadence.com,
        Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@gmail.com, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
        simona@ffwll.ch, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] drm/bridge/cdns-mhdp8546: Fix incorrect register clear
 in j721e disable
Message-ID: <3tmais7fsu4bfpaeto5xrseeuxyapva7n27apurmu3ijagir3t@mfvm2xeqmn4d>
References: <20260416040933.3052831-1-u-kumar1@ti.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260416040933.3052831-1-u-kumar1@ti.com>
X-Proofpoint-ORIG-GUID: LUndWMRi9BnUQwrxjePHKrnOkD6ODAC5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIyMDE5MCBTYWx0ZWRfX+DllGFJ8BqoE
 SISvr8ozCReopFGKeFp/2CCHSyzVplOPZOy8f/jN1+EXFMXTnm6VL560XZn+GFeKu4TTJBZrbyk
 kMXL+64XPGDF1GY9QoPPjUiWJqlHcpHz1JmegA6SzEv3nGfEe+fKjxd35nsMGwv6FaNpyflSJT2
 2EojvRLUZT80YmHBc5yqc2f2gmZCjrJgyHG7VAKWvUEl+KXvJ7kOWxPGWknG5+8Hg8FDJsSsue5
 zNKSQUrYHu1y0q878IuKobS123WID+njNoNqcuINmpH8Fw/PQg4EcfV/zIlqM4Ybj5Lr5kgeXP0
 I48WBI4AWaWukkvv/iqwF0obK5fg1LsSzev0JCUMFZJWEYsqKeshA86CUuvlPJdg8p8fnGdw5ZB
 OGKGmLVXv5h/CZvOD8NCxSCVLgojQVnhimE5rb5LToo5RrstxNJiAzqpx6arXLjtM3Eog2kdJoO
 6j5KJyQqRIAc/gXJetg==
X-Authority-Analysis: v=2.4 cv=PsOjqQM3 c=1 sm=1 tr=0 ts=69e92507 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=VwQbUJbxAAAA:8
 a=sozttTNsAAAA:8 a=EUspDBNiAAAA:8 a=lARSoy7frKUrfrJr5SoA:9 a=CjuIK1q_8ugA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: LUndWMRi9BnUQwrxjePHKrnOkD6ODAC5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-22_02,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 clxscore=1015 bulkscore=0 malwarescore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604220190
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-240386-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[intel.com,ti.com,linaro.org,kernel.org,cadence.com,ideasonboard.com,kwiboo.se,gmail.com,linux.intel.com,suse.de,ffwll.ch,lists.freedesktop.org,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim,ti.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitry.baryshkov@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 0DDB044A47A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 16, 2026 at 09:39:33AM +0530, Udit Kumar wrote:
> Fix the cdns_mhdp_j721e_disable() function to clear the correct register.
> The function should clear DPTX_SRC_CFG (video source configuration) instead
> of DPTX_DSC_CFG (DSC configuration) when disabling the display interface.
> 
> Clearing DPTX_SRC_CFG properly resets all video source settings (VIF enable
> bits and DPI selections) to their default state.
> 
> Cc: stable@vger.kernel.org
> Fixes: afba7e6c5fc19 ("drm: bridge: cdns-mhdp8546: Add TI J721E wrapper")
> Signed-off-by: Udit Kumar <u-kumar1@ti.com>
> ---
>  drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-j721e.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

