Return-Path: <stable+bounces-217304-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mGpzKr7hlWliVwIAu9opvQ
	(envelope-from <stable+bounces-217304-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Feb 2026 16:58:54 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CBCB157891
	for <lists+stable@lfdr.de>; Wed, 18 Feb 2026 16:58:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 588AC3014C1A
	for <lists+stable@lfdr.de>; Wed, 18 Feb 2026 15:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33F3B343D74;
	Wed, 18 Feb 2026 15:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VI+8b6zP";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GtvM+UVQ"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA3634107C
	for <stable@vger.kernel.org>; Wed, 18 Feb 2026 15:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771430327; cv=none; b=dPXIvw2z7fb8ceOEG0UxmbNyGUHtPJ7LhSENcvOfN7ZuBtHzn/PlHi50MwrTFMEbTEeJJgERUA7w3cW8Hy0UqzHb94vPabqwUC4rn7gV/vSBJqfozq5u2IZyUCrFrELkXwqCiJSFpDGL6R5qvej2BZlyCwr3UXyLWhICX/pXGkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771430327; c=relaxed/simple;
	bh=4UKsrMNfLCiF1xF8FvDDsNS8miSUkjRKIn22yVThOZw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hyVJTEchhMQltjkQqq+L3imWQ1yLt60yQ8qteyv6G2OB9pymJ7iem3dF4hc5EFPA3yWmL1j5oHEyjXF+5YtTsVLP4099QzwJYBgv1FZA2s/V4oHzTY4lFIJYcW0Jpu+zcjB0gUDbFkUqalaeCwxTS9xLHZFCOp/GgPsUmAItmDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VI+8b6zP; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GtvM+UVQ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61I8IXnU3379972
	for <stable@vger.kernel.org>; Wed, 18 Feb 2026 15:58:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=w1emkyL2g0/kDWQ3j+VkHCmb
	QpoawetFO2n6H9Fw8Cw=; b=VI+8b6zPKSdkgvsz3S4TrP4UYgz+ewvj+mZLtcVU
	PQjOYyBFANihm1T8+A/u6H2xLus2GSa9v3PPwnxxIVNDspDH95MWpTcYVXSN+suU
	6FCI1Mon/E/YlZVPGREOkN5DZi3MnyQZCbcTUCVMSsxgxN2OiHAAuiQl+15YJbkS
	NF5nQsLPbviYo0lVIy2vUoLXV7Q90P6SRSF7W44OQOOUSmEI8v3e9DDQtLsG5y37
	FU824JczQ+mEdqNbKXLoAnoJsudjP2xolOeKrIRZiATedqUmlqcARJBCdI9R0LhK
	GToAmIMGp1Ms3H+pkri6Fg6jCLvgfTEj7AJjy5wVcKXOHQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ccxnyjwbg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 18 Feb 2026 15:58:45 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8c881d0c617so3428928085a.1
        for <stable@vger.kernel.org>; Wed, 18 Feb 2026 07:58:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771430324; x=1772035124; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=w1emkyL2g0/kDWQ3j+VkHCmbQpoawetFO2n6H9Fw8Cw=;
        b=GtvM+UVQ/JEo+t33j1nzJeVOpJw2sfVfCnHwES94qLR9VaApcRp7guWxrSM5uoaYvr
         jHuIP8JQruLGWyHZTAYAoi7JbK4xKPpB4S53UHaDsdPIo+EF0nEf5g9AAZS2ndGNfdTQ
         T2+ZFQNi4L8OG2iuz1vkQ5AS+GGs0PFxDOsSHHUeL7yNcV6kwlv1RREONVnScwCycKHl
         +2ncg6K0Rw7T6/UEfcvuwUn8uLcwMxPlSdIwotzTBPLeN2UbgMUradpeUSQAoGYZvnyD
         H/tNjZqajFoLFYCF50ajl/Zg0LkhhUQkg+OKDDZP8JK8saMHamlymvyBI79vVi5idSlu
         YZXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771430324; x=1772035124;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w1emkyL2g0/kDWQ3j+VkHCmbQpoawetFO2n6H9Fw8Cw=;
        b=cwhKqbDEqaI9eQZqkfcfgQAOEbWQ5XruTM3mftQ750NazjawoL/BXMW4RHKK9opsJz
         QcoRVA1961/aIZeVPFYtdylnXLuLLH5hm1bS3VTPeOduOvQm9qWzknCS9ahFg++vfN7S
         HM5Hcj+t0EnCIqiOqHNklXu6yScurGuUan+IpbwYRRjYTIaCW/AYP6YWHAuHwoR2HXUr
         L7jsQ8VTb/L7J7+OlK/od3NNbeNsgc39Z/7+PrhdIks0orxgr1c6S+sj+Jh+Wv5cXEwn
         ywZa3FdLFl4+GCLVM1NPxyWIzLIdD5SCSbmaPtgTI4D4NcYTSn8UPcJkrPsnLjgq3Vtl
         /INg==
X-Forwarded-Encrypted: i=1; AJvYcCU7Yqc5/P8gxfBvm+otvd4S390BMyjG/Nfbs1ytm4GX5trLCK7XUXDPMchWgAzHgdv106jfVRs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyT+FzeJGcGpzELaFWCPL9p8wy8mrSDfEnfPGaG0UewMesHji1r
	FxoO0XZ0h6QifwIsBiK+Y7J5pCfroDFc7jJwyl6zLiy6xlK8n5wBtDjGSS1ekooy4MEn2IgfclC
	xwE9ZiKL3OAHmEsJ0WUE3Hi/FgXuQxBBUsBhLa9hSaFubqyhfygqLjj1UQro=
X-Gm-Gg: AZuq6aJBgzHbhATrX0ehlK9otjPji47wkf9++Lz4CP1XUIa8dh6EbDj13Y7do6ZqyWa
	W+Xz19kWU6MaFwzuEFo63e3u1QNJHz4i/gq/hFBY4SLv8IjIsq7d3rtlRMmSnX0nI+C0QB5+OGo
	sLBaJjtP3E+0uq7OffvVd897XbHh5jeZ9yk3WJbExgM3xZHQyuAqkqbpUaazmVVrw19lFOUQEd6
	f9ZXhhLz/Lo0PCCQzymCliE1c6qMEnrQnSb0ojXrbNC6bEoF3PHE3J06y5ORKU8s7ktHHeBNbhg
	RZ1BolEzC/P0OLZaNvuvxKELAVOIjacqhXs7FI5IQjXWessvheqkfU+SpjsZzMgSfGePcqW9DiN
	RShvBXIVb7me4tcS8oba/HSPCAuyNq+9fF9QiskE63qGlgzIldrB1RZYsptWBBnL8ihhIXy4Qxa
	YGhCVYKfk1cLshj6ILGiARofN2PiSKcLb8ihQ=
X-Received: by 2002:a05:620a:19a3:b0:8c5:c99d:b2c with SMTP id af79cd13be357-8cb4bfa7a4fmr1728976085a.34.1771430324073;
        Wed, 18 Feb 2026 07:58:44 -0800 (PST)
X-Received: by 2002:a05:620a:19a3:b0:8c5:c99d:b2c with SMTP id af79cd13be357-8cb4bfa7a4fmr1728972985a.34.1771430323548;
        Wed, 18 Feb 2026 07:58:43 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-387068923c3sm44147201fa.5.2026.02.18.07.58.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Feb 2026 07:58:41 -0800 (PST)
Date: Wed, 18 Feb 2026 17:58:39 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/4] clk: qcom: dispcc-sdm845: set GENPD_FLAG_NO_STAY_ON
 flag for MDSS domain
Message-ID: <wiztxwsea2aojcxmcs2q4vskooli7lrw3oio75bij54273mrbr@ody4vonry2qr>
References: <20260217-sdm845-hdk-v1-0-866f1965fef7@oss.qualcomm.com>
 <20260217-sdm845-hdk-v1-1-866f1965fef7@oss.qualcomm.com>
 <vbmo6qvepw5sjmtrffkdiaqulgqrhxlo3lrlzxhjz6i252efvg@uyhzdskc3jut>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <vbmo6qvepw5sjmtrffkdiaqulgqrhxlo3lrlzxhjz6i252efvg@uyhzdskc3jut>
X-Proofpoint-ORIG-GUID: 8G6xZBFd0-8dIFu-bnCxcuS__eFhObAj
X-Authority-Analysis: v=2.4 cv=Do5bOW/+ c=1 sm=1 tr=0 ts=6995e1b5 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=0j2gUKGghzJNiw40VA4A:9
 a=CjuIK1q_8ugA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: 8G6xZBFd0-8dIFu-bnCxcuS__eFhObAj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE4MDEzMyBTYWx0ZWRfXxpZA44TrnN4A
 CKP5XbYdVtivspYDc/kmOVNjubH2sS4XJfkNIFAfALnX7Do5RbisPsg1mB7rWd2qvTGoo6POaBR
 NfGq13BeUKWUDGJbNxNevHszHBu9/6iMUXVrMymak4UOQ6V88NjkWMEoDvgzSrl6e3TU1qC7FRj
 fhiHg1gDEpzAbo+mdzdKd3OBTFtsAQRZ4sdLAEcVKxnLbESw2GCzm3lvsDbdwSU6wfP8YqF+by/
 w8h5AbmPU6MxacrP2ByIhiwZypESwv+QyXzaGnHUXelGqf0m3WPbVx2K2n6BwuAIXnqkvj197ZJ
 VKKlVVkmpC6dOFQJe4J07Gpl0BM7zQlyc+EMSyl/VaKZyvNL6oSO2P3MmWoF1/CSdtVWGjNf8Gx
 bWDC5xdBkm8XGJNqrf59BoS+7aPspyBnwmbjCkpXfsyjmOlOfG+AhbojL5mGLw1TYQblT4Ql8jk
 k2L0PmNTr699qxfWsQg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-18_03,2026-02-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 phishscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 adultscore=0 malwarescore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602180133
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-217304-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitry.baryshkov@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	TAGGED_RCPT(0.00)[stable,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 0CBCB157891
X-Rspamd-Action: no action

On Wed, Feb 18, 2026 at 08:49:34AM -0600, Bjorn Andersson wrote:
> On Tue, Feb 17, 2026 at 11:20:42PM +0200, Dmitry Baryshkov wrote:
> > Since the commit 13a4b7fb6260 ("pmdomain: core: Leave powered-on genpds
> > on until late_initcall_sync") setting of the display clocks is partially
> > broken. For example, when on SDM845-HDK the bootloader leaves display
> > enabled, later the kernel can't set up DSI clocks, ending up with the
> > broken display, blinking blue.
> 
> This describes how the problem manifest itself. Can you please document
> why clocks are partially broken and how that relate to the GDSC state,
> and why setting GENPD_FLAG_NO_STAY_ON solves this?

Probably the best answer (for the second part of the question): I don't
know (yet).

-- 
With best wishes
Dmitry

