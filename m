Return-Path: <stable+bounces-217688-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YO3kDhCtm2k84gMAu9opvQ
	(envelope-from <stable+bounces-217688-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 02:27:44 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DA954171532
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 02:27:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 61DA13019191
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 01:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE3772BDC0B;
	Mon, 23 Feb 2026 01:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bNS9gO64";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JbOpltJb"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79EB619E98D
	for <stable@vger.kernel.org>; Mon, 23 Feb 2026 01:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771810045; cv=none; b=RJLX6dYtgZBQcsIqhYhBkcrwqTvNQkq0KKtdZ37qXq/ThaiL23nZ92JH8ob/5cF7bNjoGx5Dqi7HjAg4nbVOx4WTRkMdSyKDI0bus7mmksFQeOT3XLtAtjrqVYEiRixWMeUfGPP5Vh69R2ju0H6AEn6Go0j1t8ws7K/O36finm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771810045; c=relaxed/simple;
	bh=0G3/fVFWXDWd5zj6OScRBLA7Pto39xgPATr4cu62hGk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SZqcLX3vioZHE1rjXfm9Ps60JVdG7AVcWvfpONRdcVMVqmduKNPsNiYjUSB9OVhqYOkmKfkp9N6RQDW9mD0CM0Oq0DtwOUWF2I0uPKVu8fOh41tD4/S2pPkoxlENtTLZoXNOy5tvKfC1QvY+/W6+evovGyDWctuQvIODWBaWf04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bNS9gO64; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JbOpltJb; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61MINtEh3076321
	for <stable@vger.kernel.org>; Mon, 23 Feb 2026 01:27:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=nc/80AnnWzN7Qo5u3ZWEwQKF
	DtrZaT4Kue5jCLEJQfQ=; b=bNS9gO642xJRcQUTr0Yep2Af/2ExXZssXrHLX6T1
	vpovU956i6r3RufAlUUT39qyiRpqRXM8Pdt2IIblyLz8/tY9SEFna7EXh3/31Ka1
	sx087LBjlwy43/hFJkx7gjwImm2RhxtamB5O05pPKHSUAbNTA/4vlwHby7A0fO0M
	yCgU/0wmpbTD+agoYBoLEbYeAZwjIA8w+D4K9mQ5vj+NT0PMGIVvub5Cshk8v524
	Uroh3SHNGUf4IJXqVqf9eD7rMxGAMNhvfZVlILH0CT/XWC5Ih7T0j2cHNzZDjLuR
	WTlNX0uQJfOjBOFaZpBTpYUAfGKEumARTrfbQA9VVb8nxA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cf5u8k21c-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 23 Feb 2026 01:27:23 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8cb413d0002so4508056985a.1
        for <stable@vger.kernel.org>; Sun, 22 Feb 2026 17:27:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771810042; x=1772414842; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nc/80AnnWzN7Qo5u3ZWEwQKFDtrZaT4Kue5jCLEJQfQ=;
        b=JbOpltJbJbjt/WqLDMTVnf+pZ/6Unyr5oS+Y/MsaD+p2JkMtlfd2hwcZD+16orKTYL
         yaX+omxo4Y0na0NPLc/Lfu8XP3Nrf1VJW3SeOQhnYpQyqlqzEvXEsVw6KCVrMGmTXPWV
         +EMaALj/aNwR0hOaTo3x8e5xC+OF8wIT6XDeHYsI1hoOdC7/xhHd5KFimLhbDFKRpKfA
         mgWkspZjBR3C1v2XTdcokoQa4i9uXPOEonGpZEDi3+ADtttHUabvwlaih1e2iw2t8Wg6
         auy7SkoEK+5ZqRZ/PteUZvdPzrcZEdylvg9zMF2WbGmdATK0LSSX/gshsKWxHBhbYgVl
         kB3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771810042; x=1772414842;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nc/80AnnWzN7Qo5u3ZWEwQKFDtrZaT4Kue5jCLEJQfQ=;
        b=jjbqc3AsmGvrGraq+eOhNgOjx6KmAqzyuHVsFOTVbcblBPfV3LQmq96ViiUdghLEIa
         BPNI3sF1fGN1U9bYPcjGuXAzD3e3Vd2PvjNv3QozI1uAdnbDKCPqCU6jvD64IXh4SjeF
         DLf86KgxmpvUaO4r8EpQPkoKqJyHRvyhxZOEQ6r3pnmnyhyUTWsKmtsAd0FnLD/dmeGT
         ev63yXoqipmHNIBvuKf293UN4KSClFPI6lZpBkcujT+MbSfKmNE6kWQ10pzdaNDh2c0D
         P8BVuf60ipeZcAq23b51gn3GIJNUI4/hglkJymYHOv006OTC+ZVHCGtM7LCChxrDUmxA
         0J9Q==
X-Forwarded-Encrypted: i=1; AJvYcCXkNYdAedgpxzJ4evHM1FwC0dCXUHHzAGs7XablU/pn1OgdWOBVOIoqEM0PJyakSS7QcUxiJzM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNYil/xImEQPFQ6TcnSkmqiRqVu5Z2jJwVWPeacN+droIjMBiJ
	lTmPvOAK+u0alO5/v+ogSfg1XoaQvjSdscIRMkLekRauuUbeRdLHEGyB9/+q/udOmx+p7SZx880
	hN50Qxy7ET7/8n+3GgxnLcsw1phF6YlKRh7eNOWmfrXiiwqG+CTshqrEsiCo=
X-Gm-Gg: AZuq6aKcbtGtZLVzJHTd7tW0tu7faZ4LXIOE9Hu/qv0N7NACcRNF65vwkV97OzgAOgX
	NQfLJGxVcIiHO5Jcwl0tTHlzJIakCrvykzWQBjgG5aOCIuGHPp0lI7KZp+zMdHCwTyK2fzKIvAU
	zEvL9t5QP4+9Zxodp18rQIYNgIgN5zRZclqt3k9r2m7acL24oO7ndeFRvenEqyD+EPidBexwRz0
	PIjwzAKryBmTYAHsPFQvz0KDWbrCbOfRo/BWgtgo6wsvUuDXiQuvfvem9slnEc9MvaOob1okUSo
	dXFV70uW4EYrcUitXhThjF0jYd2MjlTlVls9DCWtGa6L3yi0z5UvRNspNSTRHdofMXcV6EklFFs
	vsRbhsq0b73LL5gw9mB8Z7UbLInYm9s9DSRyiStYrhEFPC9s4iPDntBKzMUSWbof74f+ke2v3Ix
	itTzgMYx3rYvpYNTJCEZ2Kp7vSnJsjXE9W8hA=
X-Received: by 2002:a05:620a:1908:b0:8c5:3045:854f with SMTP id af79cd13be357-8cb7bfe7916mr1526394885a.30.1771810041937;
        Sun, 22 Feb 2026 17:27:21 -0800 (PST)
X-Received: by 2002:a05:620a:1908:b0:8c5:3045:854f with SMTP id af79cd13be357-8cb7bfe7916mr1526392585a.30.1771810041462;
        Sun, 22 Feb 2026 17:27:21 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-389a78d2326sm13201841fa.15.2026.02.22.17.27.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Feb 2026 17:27:19 -0800 (PST)
Date: Mon, 23 Feb 2026 03:27:17 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/4] clk: qcom: dispcc-sdm845: set GENPD_FLAG_NO_STAY_ON
 flag for MDSS domain
Message-ID: <mgsigotfsu7xbquwgsrrm2rctx2e5xjmaijg6b7nzaedqerefi@oxvufd72novr>
References: <20260217-sdm845-hdk-v1-0-866f1965fef7@oss.qualcomm.com>
 <20260217-sdm845-hdk-v1-1-866f1965fef7@oss.qualcomm.com>
 <vbmo6qvepw5sjmtrffkdiaqulgqrhxlo3lrlzxhjz6i252efvg@uyhzdskc3jut>
 <wiztxwsea2aojcxmcs2q4vskooli7lrw3oio75bij54273mrbr@ody4vonry2qr>
 <857f0582-8b46-4bfa-8c62-5ca6f3d0aec5@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <857f0582-8b46-4bfa-8c62-5ca6f3d0aec5@oss.qualcomm.com>
X-Proofpoint-GUID: y8-pJ1x_43-9lpyhzls2p2fsssr6OEO2
X-Authority-Analysis: v=2.4 cv=cJftc1eN c=1 sm=1 tr=0 ts=699bacfb cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=J2S0nMzMed9wqxottccA:9
 a=CjuIK1q_8ugA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: y8-pJ1x_43-9lpyhzls2p2fsssr6OEO2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDAxMCBTYWx0ZWRfX6oMg4sq0vstE
 26V0FzPR5Im0KhtH7DpU8EPtT/QkrsMvyN2hLGUTxTKKsECmwgJM+AtS5eqs2OoDeKJtz2+MlzK
 iCm/eY30kreg6VaonLcPSvcPw4g+5216ftHA5oPuRT2RHZ8vHeEEjQVurmFmUhGXxJvi6scMMj+
 XA4yrxXdcbPtIAAnn7Vdy7LOO3TEx2JQOCA9uwguM8whJ8L2K3O0lOfVTjy1yHNxJ9Cvr3+vCrg
 TOeHYTkheurcEOATk2y7cgGOkFzu3rA0yGXjiz/CLlQIGk3JMbCUAtSH/qH6TrBCKSGYcAIOlhu
 qPtqiN844o2FiBONc9o1k/wuam/2P+RE+h8Dl38t77CIPgD1uSwts2sBeaFCs02nAe/cgNkusY2
 NzitZPQ294mmDV6H+Xta/obWepU+OvqNJgKE62xsweRATQDV2apJ0OvZXdKZVo8PoStTrz4C97X
 pFvrp0SWRNsimS674EQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_01,2026-02-20_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 clxscore=1015 malwarescore=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2602230010
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-217688-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oss.qualcomm.com:dkim,qualcomm.com:dkim];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitry.baryshkov@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: DA954171532
X-Rspamd-Action: no action

On Thu, Feb 19, 2026 at 11:41:06PM +0530, Jagadeesh Kona wrote:
> 
> 
> On 2/18/2026 9:28 PM, Dmitry Baryshkov wrote:
> > On Wed, Feb 18, 2026 at 08:49:34AM -0600, Bjorn Andersson wrote:
> >> On Tue, Feb 17, 2026 at 11:20:42PM +0200, Dmitry Baryshkov wrote:
> >>> Since the commit 13a4b7fb6260 ("pmdomain: core: Leave powered-on genpds
> >>> on until late_initcall_sync") setting of the display clocks is partially
> >>> broken. For example, when on SDM845-HDK the bootloader leaves display
> >>> enabled, later the kernel can't set up DSI clocks, ending up with the
> >>> broken display, blinking blue.
> >>
> >> This describes how the problem manifest itself. Can you please document
> >> why clocks are partially broken and how that relate to the GDSC state,
> >> and why setting GENPD_FLAG_NO_STAY_ON solves this?
> > 
> > Probably the best answer (for the second part of the question): I don't
> > know (yet).
> > 
> 
> RCG update typically gets stuck if the new/old source is OFF while the RCG is ON; but
> if the RCG is already OFF, the update proceeds safely even if new/old source is OFF.
> 
> A possible theory is that if the GDSC is in OFF state, the branch clocks will be OFF,
> due to this RCG also will be in OFF state, preventing the update stuck issue even if
> the new/old source is OFF. But, if the GDSC remains on until sync_state, the branches
> and RCG likely stays ON, leading to update stuck issue if the new/old source is OFF.
> 
> Ideally, if both old and new RCG sources are ON during the update configuration, the
> update should succeed regardless of the GDSC status.

Both pclkN_clk_src clocks have CLK_OPS_PARENT_ENABLE set, so the parents
must be on.

-- 
With best wishes
Dmitry

