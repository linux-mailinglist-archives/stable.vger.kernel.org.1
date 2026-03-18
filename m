Return-Path: <stable+bounces-227098-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eL/qI9/EumkNbwIAu9opvQ
	(envelope-from <stable+bounces-227098-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 16:29:35 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E8852BE35B
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 16:29:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E8AC1319CAE7
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 15:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC1BF3E5EE1;
	Wed, 18 Mar 2026 15:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZBJMsSpN";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UweIgq1C"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A06D53E5ED2
	for <stable@vger.kernel.org>; Wed, 18 Mar 2026 15:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773846458; cv=none; b=kjTSfeVSCZHvkRfmvIwVhwGayOApavdYWQP4sUcCViJVSjrkrFB9PhmLMVN20iqddPugJPCrmQTnWrdW6fNItEaSyJNabjOHAvHiMv4hb8xE+4+cmj/onXM56/cdiFY6ob+rnRXbnTC/fiJfQSPk0jsdonM5y8lpVHlK0PlkAqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773846458; c=relaxed/simple;
	bh=mzgHeyxMbEEsfZ3jPLKIDaRSBe7jBLAicQhrqIL6YHk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dolUxkakhxGzgMM61WIfkvjmwXfeUP0VVIc+n7CVEwfdC5VcTrwlcYh5gw/6IjZflXyo8FAs7l+xnTo1P2IggciOh9wbT6DjZvt3vUUq2kPBlIp5CKhJyKUx0Wddi9BYCpPioYIyGJd7FMtPBf77xxZMI2xF/45vmB1PZL9TFCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZBJMsSpN; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UweIgq1C; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62I90lm02241177
	for <stable@vger.kernel.org>; Wed, 18 Mar 2026 15:07:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=jfjDbpo0OeUU7Qpi0b5V87qt
	tFxS8ZeOgtYmurIGFkM=; b=ZBJMsSpNovvjczVPrGWRTkhe/VeD1nXevI1+wpBR
	w9ydX7TJgCOcsY1C4rNQAAiZwHy4++oeLLx9SH7t9QkT/hclpa/j3E8yaNxf8vXR
	ew+1QDUIpMNAU5kzpyLA7GVly4X/2YoHPckZ0V6Fd7zZaSrK+F/rFvpoSychjj2R
	PY27qeg8Aslg+TIpdF0Na6J6EPuMiLbxvIxow++6dRCCOuPzzLmZ/eS6yl/PJFVw
	LJXaYA4Ml1NW1s0yDzXrVyDRyWOUVPLIvFEjaTpYhgbUfiTdSgh/vnCK72ZXdW13
	wfFbqOsdH4r6Q7fNTkKCMj/zQvSlMrSR3ZZB81+9Dg/+bg==
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com [209.85.161.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cyak3vs9p-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 18 Mar 2026 15:07:36 +0000 (GMT)
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-67c0da9bd62so17872149eaf.1
        for <stable@vger.kernel.org>; Wed, 18 Mar 2026 08:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773846456; x=1774451256; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jfjDbpo0OeUU7Qpi0b5V87qttFxS8ZeOgtYmurIGFkM=;
        b=UweIgq1CNHoD/jZ8uusV1W9f+QSk73+7e3NZaD2lwnRD1JEpfeb0PKosz5zQl9SduB
         yveZNamBxIe2t+q1RiNfUamMMfZ4NH3mX+G3v98FqfGytZ2S1dLiML57I6OUmjmuPGV5
         uWvSHE6e5zcGPHPky2uHagRVu0JXrEqLKTfepMVzz1/Wv0NNlcwPmwkrBmM929paX6K7
         sDx03XVVGmV8rf5k4TGy4RU2oBkNyBBTLvRNXxEJtku79TkWULZqjPHfQqkHbW8IuoCK
         dAjYfc+BF7UWdXwmjqYfqoVI6cTUqGctr3J0JNG5DsPQ/xfJ/Jc/vwHe0AH2hTSJh1fY
         KE0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773846456; x=1774451256;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jfjDbpo0OeUU7Qpi0b5V87qttFxS8ZeOgtYmurIGFkM=;
        b=Htb6sLr8xr5E3eaGRNG5TKjLgaQPh4Z510UdMBwqoKUisMXXWY+SJCoMNimjP50Q+9
         Y8VUDihrKDJ5AYaWT++S914EMeiJc3jIS6YOGBce5UoZ+Bh9Ayb0ueqx1avMvOTJS4CQ
         SvGbR8TyjgamWy5hvfJhvEPjpeMA0XL9ci5fEf9d/cWZLu6gj3NbnCdnMONh9mhiql3H
         OUFctpRQeIxQrmLHhl6iPABtYE1VM53b1ph1mXb4kSgoTvo2ZShxTs84CBKQLlg40QMG
         kycs0O6Fr9Ao6uH/5037Pn1hbefMahKVCnsTZfwWwP19YiYUWbg3JKVPHTVgWKmLK9j7
         LMhQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/u0xpACsBgkps9WkI03AO5sVyBject+CT33r3fvYi1f9D/8aPTyUYhPdGytPMCf3+lcZrYNI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzU8A6WqT5w3a5wmhd400I8DVOX93Gaml8czak+c2ruKUr8y3CV
	C2EPynlrMEMSYn2J9H58RFtChvT3DJeA14sFdzHoLY7W2QQb0qthaaFc78A5HU37Ya7nqA9TzGm
	la5UWPJ49DX5oyB9DKndyuOMlxWPK6OYHrNL60udcUkY8qleef6qV+U7k/rc=
X-Gm-Gg: ATEYQzz0oL+4BL4ukEY8nVNqmKV6NHiWIseNvEFqlLTUBABxkeR4IdOpk0ppJNc4g6S
	/o4CzTFWU77xKD9nOD8s+CaZQTqF/oJwXULh5bPDG70ImU0C8vtfN6ItlUpZRAcPBwsEG3x51HU
	TcQDafbhhBVUmUftJkwvPcjQ7p69c6lWmmWYiJry4T9Z8cNS86RLdBimFnJe8mogE3NLPdgmtik
	V8GMPq39I8I6oiLID5FIMHGg23gG0LvyzV+aOaSRpnbWfyk6dqchqEzc7ESEVzi8jcY163z3SK9
	lQopJI9Sled4+0NgJi9V34BYxxoCgkMdJtbQS+nUPpw6mhW5CQTmgI5PfregfBNDfmBKpSP/qtN
	SDCHRpiiLUPWZmQyASCoRQ+wplcronZCwF2KGXB/zm4L3KZtjSthLJm4HSGshg9YXIfO7Z+6rtF
	ngFTZIPxRxGh4e7PehprAzGw/2ydiLI2umIXM=
X-Received: by 2002:a05:6820:450b:b0:67c:c93:a438 with SMTP id 006d021491bc7-67c0db1a793mr2002184eaf.57.1773846455968;
        Wed, 18 Mar 2026 08:07:35 -0700 (PDT)
X-Received: by 2002:a05:6820:450b:b0:67c:c93:a438 with SMTP id 006d021491bc7-67c0db1a793mr2002158eaf.57.1773846455342;
        Wed, 18 Mar 2026 08:07:35 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a279c6e208sm584792e87.41.2026.03.18.08.07.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 08:07:34 -0700 (PDT)
Date: Wed, 18 Mar 2026 17:07:32 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Abel Vesa <abel.vesa@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Abel Vesa <abelvesa@kernel.org>,
        Sibi Sankar <sibi.sankar@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] arm64: dts: qcom: hamoa: Fix OPP tables for all
 DisplayPort controllers
Message-ID: <pi3yikktq5qra7ptvzonoqtbxr3bejqahnrucz2xjwm7cspip2@scthbe4ugeij>
References: <20260318-hamoa-fix-dp3-opp-table-v2-1-3663767e22b0@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260318-hamoa-fix-dp3-opp-table-v2-1-3663767e22b0@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=A7Zh/qWG c=1 sm=1 tr=0 ts=69babfb8 cx=c_pps
 a=wURt19dY5n+H4uQbQt9s7g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=bC-a23v3AAAA:8
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=JCVw8PmOVHFGJkcgEd8A:9 a=CjuIK1q_8ugA:10
 a=-UhsvdU3ccFDOXFxFb4l:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-GUID: qjU4EhOGpkMOMLVvHkQBMVzr1PmFyPDS
X-Proofpoint-ORIG-GUID: qjU4EhOGpkMOMLVvHkQBMVzr1PmFyPDS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE4MDEyOSBTYWx0ZWRfXzFmlmc7rEjGT
 V8ICCqk6NEXQpK50qWVNt+TP9xS+AKGFOnwjqiP8rfvtNEl8IRf28zKDx9/KBToZDLIPcEZQ3zj
 kHXirKSkVNjY/Glfay0pSVyVe9WUzaDKwTRX16NvW9xp/42CEkNhQhM6+XmHRqaRCXdbJ+XJNwi
 Kk+HyIbFIc7kQx+vX32qAIPL/15+egyf9Q0y1aiU5tDO7iX4cpyIVaZmlkSXF7GUfBtgmgWY7DL
 TMORtlNOCT2vx8PurZnhvqHbjZ9UB6AfJFfI1ilClynRgZp4KRJzRbPO+W9Lr6mtCEI34DwAj/R
 +ax8a7Zp489d14AmJt2SyDo41HsTZ+cwJhWBdeOuZOxmgpd1xlKhMWvmqW6Nbuwkugb1JM8+G0O
 jZIPQerxVM7GXMDS3ZOsYoBNWeW3AGDDoO/4zVrMTxttoYw6GBYw3Jed5S1p5xzL9T01KuZ5uCS
 MxRMsyMPAta/E708/6w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-18_01,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 malwarescore=0 phishscore=0 spamscore=0
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 clxscore=1015
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603180129
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227098-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitry.baryshkov@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,dt];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 8E8852BE35B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 18, 2026 at 04:42:25PM +0200, Abel Vesa wrote:
> According to internal documentation, the corners specific for each rate
> from the DP link clock are:
>  - LOWSVS_D1 -> 19.2 MHz
>  - LOWSVS    -> 270 MHz
>  - SVS       -> 540 MHz (594 MHz in case of DP3)
>  - SVS_L1    -> 594 MHz
>  - NOM       -> 810 MHz
>  - NOM_L1    -> 810 MHz
>  - TURBO     -> 810 MHz
> 
> So fix all tables for each of the four controllers according to the
> documentation, but since DP0 through DP2 have the same entries in their
> tables, lets drop the DP1 and DP2 and have all of them share the DP0
> table instead. However keep a separate table for the DP3 as it is
> different for the SVS, compared to the rest of the controllers.
> 
> The 19.2 @ LOWSVS_D1 isn't needed as the controller will select 162 MHz

Nit: ... as it's not an actual working frequency and the controller will
never select it, but I think it's good enough even now.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


> for RBR, which falls under the 270 MHz and it will vote for that LOWSVS
> in that case.
> 
> Cc: stable@vger.kernel.org # v6.9+
> Fixes: 1940c25eaa63 ("arm64: dts: qcom: x1e80100: Add display nodes")
> Suggested-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Signed-off-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
> ---
> Changes in v2:
> - Rebased on next-20260317.
> - Dropped the DP1 and DP2 opp tables and used the DP0 for them instead.
>   However kept the DP3 one in as it is now different.
> - Link to v1: https://patch.msgid.link/20260309-hamoa-fix-dp3-opp-table-v1-1-1a8141d71f9f@oss.qualcomm.com

-- 
With best wishes
Dmitry

