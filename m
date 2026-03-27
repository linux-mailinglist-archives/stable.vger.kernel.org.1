Return-Path: <stable+bounces-230717-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aGQ5O/PgxmnAPgUAu9opvQ
	(envelope-from <stable+bounces-230717-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 20:56:35 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5511434A880
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 20:56:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 92B223053BB0
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 19:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0A7239E6E4;
	Fri, 27 Mar 2026 19:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="g+6qcBiE";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FUuOjlWX"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF3C39E16C
	for <stable@vger.kernel.org>; Fri, 27 Mar 2026 19:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774640915; cv=none; b=jFaW1ghtofTnahFGZzxyc5SxBSrIK73Or3yagPIOslcaaEW6l3gSWTnRDrLPed1eAvV0DdfDNqn/SUiQnQRVOgVfopueP+WSb6FAyCvYcFt4nJ+8MQxYOxRxKnuGzNDB88yMekPb/dELG6YalxWq3YvlHxvKJVvwELPixQ6j0vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774640915; c=relaxed/simple;
	bh=FhYiQP96HY6KI1u/Sv5K6ZgtFOX8h22y24DEQ5ZNJw4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JMU2wHALEQT5Ox6dVBfVPpoYVMsSN7bL0sOPktEx02PI+taQCw3jLurLzgCW/C+CIYjbA3J5nVnBoGNF5x5OOGM/a8cMUmmF56IfuId3GSN0pPUAKZewB0rz60PrQwzyqFYtn2PZhQdkdlI06dEBYzv6VPuYgS60XzTyPwRyat0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=g+6qcBiE; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FUuOjlWX; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62RI2ZIp1458364
	for <stable@vger.kernel.org>; Fri, 27 Mar 2026 19:48:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	DTcml2DXC/4wK1DbbRxZTt2MfDBgAA+ck/H1+9Sm9R0=; b=g+6qcBiEQOMOtMCv
	7B58zVp1yBRYPPxi3g2wPPoVEEbnjb00A4+y8mRBjD0kTm6hHcm1/oR2l/JdI70D
	TuZqDcF8my/zLKgETCdnxG5iGCbE0Ob9EwJwbwE+YTzrL0Z8hFO0iMks/3hHMuz0
	BKMjtsSj6Xn+QWHs14ukBfjuN3DFEI20KePAPAS1HNcCg99kkU7HG6nUo2tYPhja
	wAmlxh+Iv0OfLcSs/TL4KE46DI6WWOqcGMthftBI2RlLHNZsCBFhoCuewmmMX0go
	rH1+QB0N1YYtAR9vH8w4enFp4Q8eH2pZrVqfBBJh0isivd7NJc76/iA20/VorIp/
	I0n7sA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d5dd6m600-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 27 Mar 2026 19:48:33 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-509219f94b0so24012291cf.3
        for <stable@vger.kernel.org>; Fri, 27 Mar 2026 12:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774640913; x=1775245713; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DTcml2DXC/4wK1DbbRxZTt2MfDBgAA+ck/H1+9Sm9R0=;
        b=FUuOjlWXk0XIsJnHeEnY1An+JZSKXSVgOYVW3HnuL4ru5nwOKebE2Bt7oIJ+vmE8kN
         gc3vGMwjjMCUiqWhh7vCXB9RJqekogrXDviROillJTefPJ7j4Uv+zcS4zOsU4BnIL5C/
         f5Y+7tQCfreRce2rtAj+8DYEDLdMYNEkOB6SqJMyl9uqN4Vu4WdT2gNrqXrjv/WZYFRj
         QO6qXSKTNbmZjZYveEa9mIVChobcEIpoc8nKMmo8uszEUYAOHoNbePdV1hhzFIR40kcX
         bnHAtzBggfKnSzZGfodeEGpf9PylrKEXN4sew4phQAfu9E/MC7pBAFF1I6uCkV1flb4e
         /TYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774640913; x=1775245713;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DTcml2DXC/4wK1DbbRxZTt2MfDBgAA+ck/H1+9Sm9R0=;
        b=W3aEYQ/FRTSnm4I2/F75i3wyLcDjCGPt1pWLQ2j4hOJzwipv7An3qbrsAkBTzaNPeT
         vHqDNSXef1fS6EDN4fsjxecv0qpvGPaQtomP88AjxHzvoCefEBFmopreZeEOeJQY6lzu
         Tlv7STdMQjk76n1zS2r6E5yJE2tqqp5cFS4ITN0YeZVUyMlIN1EQwqLM6Rkkf2QSpJHe
         IDCyvua5A7eGYc31eVE/v4svGVc1Ql5MZ5So61Q1O75ITX9ghVmJc8im0R8Ff0y0AIzl
         f3LfC9u7C5KuJNFQBLnr3Q1WGX1JWGHFuMj8RdTSnAhL34Ey7nEMDVqilgIH/XQpr8en
         /fEA==
X-Forwarded-Encrypted: i=1; AJvYcCVsYqhT9Mj3tASZWLUGsGIstQDKZHwk2DBGK8aJGc2flckQNwfftRbL05g+Z+gmINyVJsVNkbo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZSjJb8kx9ZYDMphTf3nXfYWd0yb2FMwlAnCOBLTagkk6da6e0
	mNjaRssjfq/RlPHW/6K8fGYajgOqQFFPP2ZiR1sfxEYCj9ySGd4A8VmYeRV/z8bK1xWgct93Bdc
	VPfLKjeIccv1XEm1gCbDHgHU35FN03OjUOgwALVXDxBggIhk6gnk9tZY34as=
X-Gm-Gg: ATEYQzx+o1mBLWPNxjeqzYtNJXKfSjK8ThbJLHSn+wfLMXAV1a6+bfv73OdcNfkVfx2
	lOJH+ke9Wf0CQgpuMx9/MANd/XhVV3a3lLk48TkWTVo/YAa97B76dWPAOvfibg9a9JzKkftZFxS
	alQ2GLgEKVRjWPWB/zT7Quq1oTmPn2B9t/4yHSC48Rzk+K7tnUyrXIoyugnkXx6cO1ue1peaoOH
	MrWysIIXFoBSywMVvPSZhY4tHBLWblDTKpnxahv9tRjrcgphV+ky7dp5brkw38Gg+bGbK3dDKpe
	FT092ecudp5uhGgQcfz1OSucuRewLKtx7yU6g69tFYQU+djEQJwHs4GtcCDo1bbdePKLYhsW5P6
	KmQXYBJ5Q8tfwcu2e/xAoK1mOwq7i/XvQ2cpA7uJj+abWgnO5OHA7sHiMLumdScvCowqAJgp950
	OdYZAIWR9Mla9XYgup2PZkcac8ANEZfJwI
X-Received: by 2002:a05:622a:1ba6:b0:50b:408f:f54 with SMTP id d75a77b69052e-50ba39130efmr51506161cf.53.1774640912763;
        Fri, 27 Mar 2026 12:48:32 -0700 (PDT)
X-Received: by 2002:a05:622a:1ba6:b0:50b:408f:f54 with SMTP id d75a77b69052e-50ba39130efmr51505671cf.53.1774640912293;
        Fri, 27 Mar 2026 12:48:32 -0700 (PDT)
Received: from umbar.. (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38c837130basm275211fa.12.2026.03.27.12.48.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 12:48:29 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: robin.clark@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev,
        jesszhan0024@gmail.com, sean@poorly.run, marijn.suijten@somainline.org,
        airlied@gmail.com, simona@ffwll.ch, neil.armstrong@linaro.org,
        krzk@kernel.org, abelvesa@kernel.org, konrad.dybcio@oss.qualcomm.com,
        yuanjie yang <yuanjie.yang@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, tingwei.zhang@oss.qualcomm.com,
        aiqun.yu@oss.qualcomm.com
Subject: Re: [PATCH v2] drm/msm/dpu: fix mismatch between power and frequency
Date: Fri, 27 Mar 2026 21:47:56 +0200
Message-ID: <177463970824.3488980.601109933319325787.b4-ty@b4>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260309063720.13572-1-yuanjie.yang@oss.qualcomm.com>
References: <20260309063720.13572-1-yuanjie.yang@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=NenrFmD4 c=1 sm=1 tr=0 ts=69c6df11 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=e5mUnYsNAAAA:8
 a=5-8HcrL-3tWewVUv8uQA:9 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-GUID: Jz27-o47RX4hq_gJdc62hdzCrTByK0N6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI3MDEzOCBTYWx0ZWRfX2ZznUMmLTArf
 VtJNhtOybu/Pkliw2zBG7Uc99g2YuF8d4HPinJbT53FbbuKsMg6eiaNOtYdqy0VqBE+vxXeXD9r
 VM0IpHCt0YiO8RgC5/fKv2+ScHpKmTB2dpNo4JS1kp+G4q7ssrmNGCQ3871vKJRn2ecXnhE+26c
 c/NRXNre9exG/v3w1maD3rOwvlHvFZC2WRn6VkclaZHEJ4iAI5QGvrrC8Hy7HLkRXtwqlG6BlCl
 eQdVpR/PUyFzuNhPeyhpJZk1MU7oNypvQFdu3dqWTUEvn6ciDj5xfgz2/53CBZIuXO2uVrhVUQS
 61fkZAxccIZChV1HL5dJqngXMhsntjJ+wZOwVubsYxMrPd+966A5W8W5TwBAbA+qOH6y1RPl5lG
 8SI2YX4zbKz8dFsDloqJL5rwi5O5UVxQ8vXiaAo402u3amUPRLBvzNls38u6UetO/PvNJOMdw9U
 3Pax3KxLa8m1BygSnCg==
X-Proofpoint-ORIG-GUID: Jz27-o47RX4hq_gJdc62hdzCrTByK0N6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-27_01,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0
 clxscore=1015 suspectscore=0 adultscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603270138
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[oss.qualcomm.com,kernel.org,linux.dev,gmail.com,poorly.run,somainline.org,ffwll.ch,linaro.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230717-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gitlab.freedesktop.org:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oss.qualcomm.com:dkim,qualcomm.com:dkim];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
X-Rspamd-Queue-Id: 5511434A880
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 09 Mar 2026 14:37:20 +0800, yuanjie yang wrote:
> During DPU runtime suspend, calling dev_pm_opp_set_rate(dev, 0) drops
> the MMCX rail to MIN_SVS while the core clock frequency remains at its
> original (highest) rate. When runtime resume re-enables the clock, this
> may result in a mismatch between the rail voltage and the clock rate.
> 
> For example, in the DPU bind path, the sequence could be:
>   cpu0: dev_sync_state -> rpmhpd_sync_state
>   cpu1:                                     dpu_kms_hw_init
> timeline 0 ------------------------------------------------> t
> 
> [...]

Applied to msm-next, thanks!

[1/1] drm/msm/dpu: fix mismatch between power and frequency
      https://gitlab.freedesktop.org/lumag/msm/-/commit/bc1dccc518cc

Best regards,
-- 
With best wishes
Dmitry



