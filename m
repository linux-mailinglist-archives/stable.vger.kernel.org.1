Return-Path: <stable+bounces-238097-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MOMKHiRw32lWTAAAu9opvQ
	(envelope-from <stable+bounces-238097-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 13:01:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E3A0E40389B
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 13:01:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B242D304BBA8
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 11:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBDF134B43F;
	Wed, 15 Apr 2026 10:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="o+vvvPTZ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KqhJG+IJ"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD7E3491D0
	for <stable@vger.kernel.org>; Wed, 15 Apr 2026 10:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776250799; cv=none; b=OqPWZEeJuYAVOkYAbg0JzzVvxvgBrSXaPbQ8HMzGrb4flJmMt9eROqmos/KMatNCFrTyBAY3TpgsDHU5nuky67ZdqwYS4epGXJG2TfphWM8FMUpTQr2a5gmc/tf0JCfiow0na6CAYwraNNoBe9+oWzHFkqqLd668lcIegLpTEcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776250799; c=relaxed/simple;
	bh=+lnRg2QVwgm/33FpWxNm7zhDQuwHwAICUyGFrKrkn9w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fYwo24vA1BpsmjpIBwAJLMPfm1WsblSQb0JdYKcVa/UpFBM//cjAL8p9VSVXZxBy+zeDHC6TkCoAVSyOzHZ4njQtsec+S7UobzT+OSu4GfypO/IYafbJX9xZFrA541SY5l9Gx6tqrDiTopKoxDdtcXIYsrbS7SET0QV0+T/BGgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=o+vvvPTZ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KqhJG+IJ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63F7tZCR764384
	for <stable@vger.kernel.org>; Wed, 15 Apr 2026 10:59:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	r/7FN8NQtfV7xQGVRyNcE/DUA+bUuRssnQVKpgLbVXk=; b=o+vvvPTZrb/xN3zj
	49oGiH1oJIYx8vbIku1sto2ygLwSW+b1f4xN0ORlCBzAdIrBidJo3R0/cIDPHtuP
	WoOJ3M3lMN8t4GhUrkEsTVPDm691cOy1uPhucOLy/BLpw8wDfHGCqFFJyWVF++/a
	RkNRrXJhQClGZOWtul2uBkpswW2RBi9MH6Ee5CKDvN7UMfqzccvt7G6liumpH5gO
	mZCoqNgRi9VAX0hQ8yyJvDUKNDFB5jZ3prEs+QEoXd46gyb8BstOr1d/VtmDEh+t
	8jUMv8Uva4wt3wsNmURzMwHM1+5b3kQn1XtXp+m36K2urwRAmMBzxoAdv/o4wjzX
	K658Kg==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dj6q7rpaj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 15 Apr 2026 10:59:57 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-8acb4b340f4so8844846d6.1
        for <stable@vger.kernel.org>; Wed, 15 Apr 2026 03:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776250797; x=1776855597; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r/7FN8NQtfV7xQGVRyNcE/DUA+bUuRssnQVKpgLbVXk=;
        b=KqhJG+IJFECGHGsT1i97JXVXPd7TerkTln4a7TWgL9nGjdBGS+qa21borcFnPtTmVB
         I+P1JXSmgHMCDqTI2vF/fwIrkOU1cKTHQHU7GCGlbtUKrAcLJWJStv7Y7hbVFqU9Ho6o
         bJXW5a9rTkcyI3lJltvp5Ohm6iw4H0BGBSZkyUi/+zjM0Sn0oBk7jc9rVH4KGgZQcl6J
         1CnBI9ryDmB3iOdCfXDOFUy3vKlieHi/mgYMp85UWyeSmWJ0jb5xnL+uR749ZXGABD+t
         2NrEBht09AuCfGH3Nc162wjQnmBpzsdVfOQvRAaTMFy2ikWc963rkNGqTEO4JNmleyDh
         yGvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776250797; x=1776855597;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r/7FN8NQtfV7xQGVRyNcE/DUA+bUuRssnQVKpgLbVXk=;
        b=A2MxiAY8UIcdQtgI+T7M8p+T/IBPK3SQIMncSVmjcIoX/lxLT1NU0w4sdVQEuqpIz5
         Ue3yjP5r28cUxXAbjgcP6bS57zuG0IOXbXMdaDAS/wlHfmwZV+I78GMRAfVgZSQTh5Pp
         aF1LAWGOwR52yQVevWBXzIANecCnM67bsjzYaOcgxlEGi/7mibLQ6KMfzMBSxizVDLrZ
         8/m8xhkFUvnspwFkNXy1alvpmn76d5cwdMh9oUnkfK0aBu1k1r5WwzjfCrfz+KGWV6vM
         NoF/D7q53V66KgY5wk2GcEyDk5mYBWMTa96yuHT2UrKVlI3VRNcF92yj3bsV1yDiY3O7
         A1kw==
X-Forwarded-Encrypted: i=1; AFNElJ97znWRu/QUTSdBH9IUlGBVv8zJ7SS0q6fyhn4MF182ZUD+gDJZDupJPfmvB9Ayg7YPebzR9nA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxV4+V7XbbvC2cq/1Gl3hbPQv0BH7L62F3+vtqRB/OuqpBpf9DG
	mW/4qrvaqnwJljbS57EtooWvKKq8nuP5O+q+ePYcFtehAJl8xFQc2ci68sVtgZHUPgo6O87P/us
	z9wQ2rkYBUnDjQ/h7Ua09oiOmO4c3YhczMHC2jHXpHZsAuHFDchsHOs5whlw=
X-Gm-Gg: AeBDiet0i8tHyXx+FIR5Fvc3B7N1x6wkhz2AvStx21dL55idAjAw6riMH08N7RF2HQu
	aWnFb+OSd6r7Mm/eD6hxUJuXWvjck6Nx6rR9m15OPAICunMWHzN/TszxwjxrUTo2CvQr353fgx0
	GdsAr8D2NNRG5nsoJXmIV7xaGTzgXRD1tZI1JAiP5t3AtwfRNBdpfQlRYSSp/FWHz2FlFy2FN+S
	j/EQQ+Z5tU055IuOrLXeg3itRiJFd/CbQIgZCdw5XOgLEKlWV47wvG7krhY+08gj52BOE2hNboT
	fEfNIEpelmOLgBlPIL8LdCmvOLQWHmgrWLomfdbR+1ct58P3rUv+qyESP9vikPADi2lh+K0eV1P
	i8t5rwdxuK/5B8JVjS4KXwOfA6wro1GB1n5CauiBcdM3awsMT8/dOQuknVvWNoAnQCYrI/Nbz+Q
	zZwt1qZarC/Jd2/A==
X-Received: by 2002:ac8:690d:0:b0:509:a3c:e390 with SMTP id d75a77b69052e-50e1a7601b3mr16917241cf.4.1776250796854;
        Wed, 15 Apr 2026 03:59:56 -0700 (PDT)
X-Received: by 2002:ac8:690d:0:b0:509:a3c:e390 with SMTP id d75a77b69052e-50e1a7601b3mr16917081cf.4.1776250796485;
        Wed, 15 Apr 2026 03:59:56 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-67237fff281sm310720a12.20.2026.04.15.03.59.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Apr 2026 03:59:54 -0700 (PDT)
Message-ID: <baa7a564-2106-40d1-a363-b95645d283bf@oss.qualcomm.com>
Date: Wed, 15 Apr 2026 12:59:51 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] phy: qcom-qmp-ufs: Fix kaanapali PHY PLL lock failure
 after SM8650 G4 fix
To: Nitin Rawat <nitin.rawat@oss.qualcomm.com>, vkoul@kernel.org,
        neil.armstrong@linaro.org, dmitry.baryshkov@oss.qualcomm.com,
        mani@kernel.org, abel.vesa@oss.qualcomm.com
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260415104851.2763238-1-nitin.rawat@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260415104851.2763238-1-nitin.rawat@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=AvHeGu9P c=1 sm=1 tr=0 ts=69df6fad cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=IGLtpV1Bqx4y0bnjnHsA:9 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-GUID: xLYu-P6QD3v7_YYQEoDv7vTKgKg1VpVs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE1MDEwMSBTYWx0ZWRfX6Mmj1MP54bFU
 H8o/TwMCeRZzCxbNOTAykbfUVATIFbywF7YkCrqJoqmXsChWIeJWLg8/MJTmYSiEBszHEVi+Hzr
 IDVhPoDw/EJ4JMu4LhIQwGi8MyPbnWbYUtBLq4pwlpVt81W9h+3CdPDdKrHDGcU7y0eMd4697ZQ
 TNSrMRDYhZdBIodawYFvLnAaA5kaD6c779NE+czbnjcwxDcC3BkjdDef7XRguPswkGkZqt7nC9e
 ht2wu0xq+LCNWfuxDkO7/8y7iH/p1JUIOt0BvxoY82kIinWa8q7bekTmBpjt8MPVmCkrYJmTl5X
 bWi4SHOEd4DMm2BPTjKJFW308Z5oWKAIsjCD8I3sIsHXk14Q5dQfAgGZqvJRt4EzrTkLsrXhcF8
 e93GoSicS+8XXEmzLtBIl78gr69mawqwVo7X+T/kdjIqQrWwk1EpKghPzsEcZLSPD5dmZ6Y9mWo
 I1s1c9kEzaJ34pTPNmg==
X-Proofpoint-ORIG-GUID: xLYu-P6QD3v7_YYQEoDv7vTKgKg1VpVs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-14_04,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 clxscore=1015 adultscore=0 phishscore=0
 bulkscore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604150101
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,oss.qualcomm.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-238097-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FROM_NEQ_ENVFROM(0.00)[konrad.dybcio@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: E3A0E40389B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/15/26 12:48 PM, Nitin Rawat wrote:
> Commit 81af9e40e2e4 ("phy: qcom: qmp-ufs: Fix SM8650 PCS table for Gear 4")
> moved QPHY_V6_PCS_UFS_PLL_CNTL register configuration from the shared
> sm8650_ufsphy_g5_pcs table to the SM8650-specific sm8650_ufsphy_pcs base
> table to fix Gear 4 operation on SM8650.
> 
> However, this change inadvertently broke kaanapali and SM8750 SoCs
> which also rely on the shared sm8650_ufsphy_g5_pcs table for Gear 5
> configuration but use their own sm8750_ufsphy_pcs base table. After the
> change, kaanapali PHYs are left without the required PLL_CNTL = 0x33
> setting, causing the PHY PLL to remain at its hardware reset default
> value, preventing PLL lock and resulting in DME_LINKSTARTUP timeouts.
> 
> Fix this by adding the missing QPHY_V6_PCS_UFS_PLL_CNTL = 0x33 entry
> to the sm8750_ufsphy_pcs table, mirroring what the original commit
> already did for sm8650_ufsphy_pcs.
> 
> Cc: stable@vger.kernel.org # v6.19.12
> Fixes: 81af9e40e2e4 ("phy: qcom: qmp-ufs: Fix SM8650 PCS table for Gear 4")
> Signed-off-by: Nitin Rawat <nitin.rawat@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

