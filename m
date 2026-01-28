Return-Path: <stable+bounces-211962-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ELG9MMsBemn31QEAu9opvQ
	(envelope-from <stable+bounces-211962-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 13:32:11 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 85352A149C
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 13:32:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 73BF4300D624
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 12:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D69F34EF16;
	Wed, 28 Jan 2026 12:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DnC5nSJ8";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TsdCp/J1"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF6A290D81
	for <stable@vger.kernel.org>; Wed, 28 Jan 2026 12:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769603511; cv=none; b=SsfbG12DtvhicZVUitATSCxgeeR7vPQEHoRowXNabUFVlueDsTu6b1hTORSkulu01Hphbx4iUGjW0z6U8MgEOC/UmP9FMaQdpRQohxztGZfHBPeyzULPgbdFHmJgZT1+JS3SLnx2+iZ3l739tbpXQakqWDcy7LnlRQKQZNxFIw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769603511; c=relaxed/simple;
	bh=tYo9u5QXjBzdVOM3n8bZ3egw7knCKbpodAuAnu7Q7GM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a3aQBgNnEDDhllRQF8YrFG0qz34tPwgi5ZEfsofFaJzmdIFF+iyKEL4EwaJ6aI5oUImIfduB1cgOMMeu7sfFrtPtwkSWZrJ510P81n5gaHVJYojoSu2+94uU6NpshY7Felib8yvzmPktaZwlvRxgLBD2guyu/3kduXthyyKnLIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DnC5nSJ8; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TsdCp/J1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60SBdvBs1750475
	for <stable@vger.kernel.org>; Wed, 28 Jan 2026 12:31:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Aka7Tv0bzP3IlquIu30uTYsQNXrdKO9r+dm+vThfXYg=; b=DnC5nSJ8xHw3Ls6l
	sXORxqrp+LryKufJnflxjHf2BqkJQApT0yFGEkOc2TgNgaCFKBBiB+RmnPh+vFfr
	m8QNZpu3fw3m1q4D5tTdW7ZdhREilMz8ygBx5D41jxRPfFjDPh5OlCEA4nuy1Tno
	K+b/fFKK5w+jqx8JmwHQ+0CT54OsFu9J3QkP8S0uOuVnYzeqasm2GWYrRxOFqpg2
	cPSETPHXQqNGrw1fv4Ooz1JAs3in+f9Waad5FOuJ+H63yCm94mXyfF1mZ3EzMlwV
	IHAf4z43fNvgrxaQmfcrCiDn98nG8Rfo9MUYAMFRRO+S9/PsRy/7xHBDqDBf3aHp
	aSAXrA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4byhsj85p5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 28 Jan 2026 12:31:49 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8c710279d57so50091385a.3
        for <stable@vger.kernel.org>; Wed, 28 Jan 2026 04:31:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769603508; x=1770208308; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Aka7Tv0bzP3IlquIu30uTYsQNXrdKO9r+dm+vThfXYg=;
        b=TsdCp/J1GaVDWihLD8YrFUgb6PLITj0CbdhuCZZzDCuT5Zplo7ZTN/eyjbNvEjqqal
         K0u8JdjIBLvWmfGwkTzK5H7O6un/sviu4hYUxMNoIqa9wZyjXAoeu/nLEAVLTq4RUFZY
         8HUPxA0qVYOMLg7U4qO1iU5KPuv/CM5Up//eg9XUa76aNadOwLVDL9AplbLtfiX02kCJ
         PNVLIzofODf+QlQBaWOWwkqkbQIiQPjXdfWjB3gdKemQzw8sPeWJEC2m04DG+GfJAmkb
         80SSIHcFpt8g+IIJ/9IPtKrmemXMvpNExW6x6Gas7NiHn9YJqHrjj4FVVqg8NGmmCD2V
         Dc3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769603508; x=1770208308;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Aka7Tv0bzP3IlquIu30uTYsQNXrdKO9r+dm+vThfXYg=;
        b=U9vnXTAUy+thr2tOq9yb2e5d3nPPRmPPwcq/lq0N4eexaDXA+H+wjzQbqGRS0Es3HQ
         8kkda1QNHzv6IKYz19V2zTWP+8VIeRMHokb9UrcJBxrJFwTXour37c9f53i5RfReEGEr
         IrBNMJUTktDs//ZJFhfy/PPt6f+jf2M4OZKw5XD0/tYQ8Wiapaf7N63m7wh/wHfTyvhZ
         DmnqZxtO93dzzNSAyjqIXQwZc8jBS8wfXPPXuh1dlfAZynNvMFR4e1Z2d2vBqsXslsuB
         PQ6ZU4h09gPqTBnRdj/T+B2aGLEKXWzTB9+Af4pZevGF4X+35cKqfECzQ3+CrqFucbOt
         EvVw==
X-Forwarded-Encrypted: i=1; AJvYcCV2l59r0qYo/0Bkaf9jQEjqDl8PAMuHPbedq/pEuYlYMUIQ3eyPYYq4l+Z8KsxXG9DwLgmyCMk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXRFXCRRYG2PVL6lOdB3smFbMLv53V4m2CjVkrEVUpIx1wpjCP
	/8OVnbk/d5gTwAspFsq4Jy1dFaaj7Xcftbjj3S3wf6LKxr4+FLsaeQM/BT8xnBUXwUxKT2bbD/A
	vLHYgNfXLTJiDK6kxPAch9qOtu2EmW9CJWvJkVqkCp22zUukDRw7oJ5RwBtY=
X-Gm-Gg: AZuq6aJwsGAvZYeLeakGBLF8ERZXkMMLDIB2K039FuwFv/DPKfkDw/LliXlrpiEyDfx
	b+qJmw77ujVcG/YPowmUEsf/KSIbtms/c+ekOho+/mOPDiPYP1/sRP9yUmiwN9ZrQ94riKAykbU
	nYffiOezeXTjBkCztBi5p8gD1k3yUb1Y1u8Hg6YqanEwNdPi/JDfXHbh7bsVNxpofhe6u5xILad
	BhkAJj0ElAJ53dFsOds78TCmcX6paggZmFlwZIEsOVWThJVH6WGFkDHtUHVMkYuG3muDsQCCH47
	jixk1WWzaNFXML+0pckSrhCTtWbpZ+oPg3x9tQmfgL0iOOMLnrk02n5VL5dtgi/KhriPzMG0cxe
	6OPOI1C+u5uENQltBRmpsA6bEZPyxUYuW8Zte5T9Ilso5nyHLjmLO/U+++S5QsEWOBII=
X-Received: by 2002:a05:620a:4508:b0:8b2:1f8d:f11d with SMTP id af79cd13be357-8c714b440e8mr153439185a.2.1769603508306;
        Wed, 28 Jan 2026 04:31:48 -0800 (PST)
X-Received: by 2002:a05:620a:4508:b0:8b2:1f8d:f11d with SMTP id af79cd13be357-8c714b440e8mr153435385a.2.1769603507851;
        Wed, 28 Jan 2026 04:31:47 -0800 (PST)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8dbf183cbesm117532566b.38.2026.01.28.04.31.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jan 2026 04:31:46 -0800 (PST)
Message-ID: <30e971d3-90ea-4f08-bc5b-ff25030130b6@oss.qualcomm.com>
Date: Wed, 28 Jan 2026 13:31:44 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: qcom: Prevent GDSC power down on suspend
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>
Cc: linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260128-genpd_fix-v1-1-cd45a249d12f@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260128-genpd_fix-v1-1-cd45a249d12f@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: n9p_xZEUAkXmsVcKkXvrrbWPb4YXv5Gu
X-Authority-Analysis: v=2.4 cv=GbMaXAXL c=1 sm=1 tr=0 ts=697a01b5 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=jU-KX4cHS3eJyRZ3RZEA:9 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: n9p_xZEUAkXmsVcKkXvrrbWPb4YXv5Gu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI4MDEwMiBTYWx0ZWRfX/vYVYWnpTsCv
 fAhWMLPX3m1XIQfR9Obs+rNWBoVjusD9xT830s5HNrf3b5FMoNkZtgkb22549pua5E0p7R9tTHQ
 ze0hb1eobPUAf1JXonIMW1H2UezVcgfqPCSvH0MSkh5ENKHylgjpmJZqREQMxXrmDNmvVMef9qG
 f14AvKgknPLO0hfSRdm51A078nJfBUpwTieiZwBtdkCM/7Jb21E8zXPLi/78zsWmiaj7GZcvMKV
 /n3OvVSqlRdVnyMJ4mpE/us7yjX2afOmilJT1ekokF8cU66PHMAWVfevkYy/OlJDJF8F9bourHd
 +ga2z9u7phmBScRLqwf3+uYGdIHE2KvHLfinimmTzaVCQr2ZOfhk5Trz7i4ZOHVw7iwqmKKSyAw
 /awAnRxLrPTQvBaTOuYvYcipQkRHwcAajR2DU/wMBsocfG0l1mPUiPFKH2SE+2FMCF2zJDQNJjJ
 Wy7TfwyIpR6yW6fXViw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-28_02,2026-01-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 suspectscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601280102
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:mid,oss.qualcomm.com:dkim,qualcomm.com:email,qualcomm.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-211962-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FROM_NEQ_ENVFROM(0.00)[konrad.dybcio@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 85352A149C
X-Rspamd-Action: no action

On 1/28/26 1:22 PM, Krishna Chaitanya Chundru wrote:
> Currently, the driver expects the devices to remain in D0 across system
> suspend, but the genpd framework may still power down the associated
> GDSC during suspend. When that happens, the PCIe link goes down and
> cannot be recovered on resume.
> 
> Prevent genpd from turning off the PCIe GDSC by using
> dev_pm_genpd_rpm_always_on() so that the power domain stays on while
> the controller is suspended. This preserves the link state across
> suspend/resume and avoids unrecoverable link failures.
> 
> Fixes: 82a823833f4e ("PCI: qcom: Add Qualcomm PCIe controller driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> ---

How does this play along with your D3Cold series?

Is this patch supposed to be applied first?

Konrad

