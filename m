Return-Path: <stable+bounces-226092-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AJh5NHduuWm8EgIAu9opvQ
	(envelope-from <stable+bounces-226092-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 16:08:39 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 765012ACAFC
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 16:08:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 418DD30530F1
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 15:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C3D13EBF3F;
	Tue, 17 Mar 2026 15:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GHK/6Trn";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Q8dzeNh/"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5DED3EB80C
	for <stable@vger.kernel.org>; Tue, 17 Mar 2026 15:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773759922; cv=none; b=hTXsJfVksIXwtwZoj/OOmvrWsxieLitQ28ZT116UFHGaib4VXOtbJc86g2XWk+IjEbvAsWkhplSi9z5bAR3VVkLdQmou3Holkddgr89U6hIiWL6hDpZzqb23zeR4hTvQbDURer/afWr0rLNn2ZJItWsozNoXBVaY0IzxJ4Mk1UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773759922; c=relaxed/simple;
	bh=aZou+yP3G0/l0RZo0Ej0425LMj0QTuKIG4nLtZZfIjM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ls5OAxZJavtRTEha0SEaBT7hktbMLqxef4nq/tnkTq/auyYMrtz/PB86IAy0rSyoz59bJK7eANPt4FAafFieoy9d8d+DF+niaZeocXzBuW1z2ofAUEvYDkDT84KPtPxxuP7mu9+kqW8w82bF7xyL4HcGQ5Z9tT0IuPegIbK55uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GHK/6Trn; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Q8dzeNh/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62HDxsAn3124207
	for <stable@vger.kernel.org>; Tue, 17 Mar 2026 15:05:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=aEJSSb3e4zGS3VYD2UkwZYPu
	2XsP+s6BRwgxd3j7tRM=; b=GHK/6Trn3Bnx7pG9X+w6T7p5m6Ob3FMPC1C2tsP3
	qASohyIKdmSCZWxqv+I/8sN08SPCcy/GY8MU7Yh49UMPkw97ViXplfj0s9zNT1XW
	hAwEWWSZXzswh7iwhEmdjfVoYMjB+EcLcITNCu2fEZgZQlN739nGtaN3pAwrjv1M
	fJUNb1KApy6DwZVjU1lLqEy8ZGpjSd+fuhAwWQS1+tBKvNhLnwgQiQzCj1SA4gEi
	wi3SYmHjhslav379l9mBL/4sd3gI6wxiCQ1sCL/GB0lO3W09BWMjRN8HJKEMkDqa
	2VpmncDcFQLNo6scQeBCVlA1XD1gK3eLwP6cpBGPmxf9tA==
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com [209.85.161.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cy2fbspjs-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 17 Mar 2026 15:05:19 +0000 (GMT)
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-67bb4c04306so46828056eaf.3
        for <stable@vger.kernel.org>; Tue, 17 Mar 2026 08:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773759919; x=1774364719; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aEJSSb3e4zGS3VYD2UkwZYPu2XsP+s6BRwgxd3j7tRM=;
        b=Q8dzeNh/wGoofrpOG+bLzY90D0urdrCPdC1AMM+8xUwYtklrflQJ6A1DkMyxvsp6Cs
         U77QLH6erQRgV8QIQNh/Lxhfcu7Cx4kHGEMhxtQ8Eynn3yfEPnYMhCa/b/jfBvASJmA+
         CuVskWzpE4TbZO9DJiI7o0fY7wNTg8rs1u83kfz01WtTXoc6j/GyjfP+EgUMqMpyXP2r
         lhupx1RBxqqtCSI/ftZrtZy8cBWQxrH1KQnkUGkshsIuReGtfAI8PUz7vbUJFyOYxssO
         xQIHyMOEMGd9HcXkVEtNDcmz7FNZrxVB/Oi/uix05rG8w5huc+/YtYf1HCYUSB6slsU5
         YZnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773759919; x=1774364719;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aEJSSb3e4zGS3VYD2UkwZYPu2XsP+s6BRwgxd3j7tRM=;
        b=CntYCe0lePz8xJDXqdYbUEF7WEuqGR1raOPUECMn2g+qjZ69V1aQhcYuGcVCsSsAX0
         r9jvuZXKpamFiw8LklNkJMlkQZJaJKfBn6OxKIhMtxZuJTU2ga1TRo7Q5tyoNMoYpV1l
         fjxgZvnpQc8l9m9rnKPxqHt8t/vYO5digTleH4N9O4QIEEYB7JBNAf3zc33zRBQW0qHn
         R2KU8JepbYTiGxBETmBh9I9UnZhK8jPHuBhQmOJS9W2A4U01ARVzJiSNUItJKXlDhn1o
         95Z8WRPvZmCZaGpAjEjYfbCa0jYijp4pA02peJiEA6DqxOuT6Lu0W97YdSXRdTNhQx/x
         +aeQ==
X-Forwarded-Encrypted: i=1; AJvYcCXlwJbPeC3pHVXeMQKV1TI53AuqnYk+XapJU3tajlOug3K6O/ZdH0cDb6nN2NVLRmrdR4rzHzQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcJTpW605jEyw4tG4ekX0RA02ztRulP7bkxAEy3wlYZ1Ts3k/j
	Kz4LIGWPaZLcNv8qlyKOk+Gd+iSVpMXo8oxcPaTBfMAn+ccrpkJlwXaO/x6s8yNMOqc7UEsNdMJ
	RievH0+8FTkbSNOzb8wauqy2V1T0mo0OHnOr/THSuA1m9Cvj9urBw0Qz9M+s=
X-Gm-Gg: ATEYQzwFMy7gqD6LiPdq25rdjSxDc0wQCTvR/6Y45b9Id4uDOcDKsRSUkwMf5RNKFFF
	YxtzY5aT0YvXmAOQretmZ3wh7C2+5QlvEuTAjexnUiMTprSfjV1IM3trVgak9Xu4FpWgACQ0yjT
	1poVBFCUbjwQ6ZQLl7DDs781guZYLvVmCdSzpE4C2pIIsds3v3CUZNiFrmX5SliMpf8DzzvXmni
	sxeS/x9ibNqXABOW3KenzPw5RinVsKJx1oWgs8vqbejdMRYdX7D7lTwTsPpIFrwkJEZVyVTXQTn
	26lPpMyaY6j+xw/WAdMEmB5ncFeGLIKDALOwp3pEXO7weIA80IOSWAynmgN5c2757bh8/hPJL0C
	XYoLkhzvdHlQuLMqiIUXGFb4bw7Q8xDxwdrKOOYbCcN/uVnBSLByZ+3YlWBjU46TrvROIu1Eny/
	1gj8ldQ5+IdUierT16hD53K8tuAcEdxqXU3BY=
X-Received: by 2002:a05:6820:1793:b0:676:96fa:299e with SMTP id 006d021491bc7-67bda9d8756mr11400310eaf.27.1773759919112;
        Tue, 17 Mar 2026 08:05:19 -0700 (PDT)
X-Received: by 2002:a05:6820:1793:b0:676:96fa:299e with SMTP id 006d021491bc7-67bda9d8756mr11400256eaf.27.1773759918631;
        Tue, 17 Mar 2026 08:05:18 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a171a41c8csm952933e87.62.2026.03.17.08.05.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 08:05:17 -0700 (PDT)
Date: Tue, 17 Mar 2026 17:05:15 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Abel Vesa <abel.vesa@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Abel Vesa <abelvesa@kernel.org>,
        Sibi Sankar <sibi.sankar@oss.qualcomm.com>,
        Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>,
        Taniya Das <taniya.das@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: hamoa: Fix OPP tables for all
 DisplayPort controllers
Message-ID: <nsli6wazkrudgofn7l7nrktk53foa6unkxtqeawxfwyvf3v3sv@7a2vrc6fhgxn>
References: <20260309-hamoa-fix-dp3-opp-table-v1-1-1a8141d71f9f@oss.qualcomm.com>
 <2f4e4cc7-2600-482e-88d9-d4b20d328a72@oss.qualcomm.com>
 <drcot4oxpea5lnpa5htrrl2n6tcc4ocxmb5vsho3ocouvajwlo@6ueabivtjy4h>
 <7d8211c5-7b12-4349-a329-cfb51a918a1c@oss.qualcomm.com>
 <6qhpiiroqnpzg44i2j5rgmlw7uaffw4t5z6gv2kgubfoqpktpd@r7h75knlv5a2>
 <87a103cf-d066-4319-ab68-bea3463c0fa2@oss.qualcomm.com>
 <4gxuy4a37yr56p7ialwpovzjeizic522ttjqrsivx2murjyoy4@eolb2sdb5tq6>
 <udbyliefljz3p7jokufzc7tjgkp43ekxqmuio5or7abhlzzb6q@wkh7mbj23xo7>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <udbyliefljz3p7jokufzc7tjgkp43ekxqmuio5or7abhlzzb6q@wkh7mbj23xo7>
X-Proofpoint-ORIG-GUID: -aOyoR-xAHmGn6TVMPdUqWCPGTmqJMw5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE3MDEzMyBTYWx0ZWRfX4Y3+xuzN8Nc6
 4G1gj0+x4hLdU3DojA2+NYBlp0LLPIRZ4OosZvtDfnJE8D+lh/5k35t04xoX6J0ubZucRLedyaK
 De0XiPtTWy/udxq3HYOLYONvjC6D2kGnJUbC+TmGUaEvFIx/r609C8f/vdlUVgkiCf3A92TwvRD
 gxG2Ue8x9Juw8JnxRFodHeKnxq/YWfu4ggpzIvFTz87CVYIeImIKlWGYywJiO4hY05muEOBvWM6
 IkK/oHLFYQET+Bg7sArFqumzcgkus69XY6yvPlKGRgP8KPfWQEbBHi1+lDVkvSwea1bfIJZDhrc
 cTwD6dAqjmUytapGyF12nTYYgIcpoYzkUZWMHbn53jtLKEWFO1vLI5mKJ3svnB7NL4LfNq+40Bl
 4HMuqw7unhEiSyqyzJnYLEaGRzYNpgsbs613itnnVkVJcXioqvbbGjcYzG6b+KEGxVRMu7S4/HX
 pywAZTfKliepuvChdmA==
X-Authority-Analysis: v=2.4 cv=fa6gCkQF c=1 sm=1 tr=0 ts=69b96daf cx=c_pps
 a=wURt19dY5n+H4uQbQt9s7g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=luQ4TZCkvUVMvnjqsb8A:9
 a=CjuIK1q_8ugA:10 a=-UhsvdU3ccFDOXFxFb4l:22
X-Proofpoint-GUID: -aOyoR-xAHmGn6TVMPdUqWCPGTmqJMw5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-17_01,2026-03-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
 impostorscore=0 adultscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603170133
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-226092-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,oss.qualcomm.com:dkim,qualcomm.com:dkim];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitry.baryshkov@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,dt];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 765012ACAFC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 17, 2026 at 03:39:34PM +0530, Viresh Kumar wrote:
> On 16-03-26, 21:38, Dmitry Baryshkov wrote:
> > I was sure that DT bindings mandate it. However, the bindings don't
> > include anything supporting that definition. It simply says:
> >   Devices work at voltage-current-frequency combinations and some
> >   implementations have the liberty of choosing these.
> > 
> > Viresh, what is the more exact interpretation? If we have a valid rate
> > for which all other params match the other defined OPP, should we still
> > define that in the table?
> 
> The frequency in the OPP table entry is the highest frequency at which the
> properties apply. You don't need duplicate entries in the OPP table if rest of
> the properties are same. If you look at dev_pm_opp_set_rate(), it preserves the
> frequency passed to it (well modifies it with the return value of round-rate),
> which is then used to set the clock eventually. The opp-rate isn't directly
> used.

Ack, thanks!

So we can drop 19.2 corner (and 192 ofc) and we don't need 162 corner.

-- 
With best wishes
Dmitry

