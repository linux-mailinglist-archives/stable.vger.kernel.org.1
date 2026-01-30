Return-Path: <stable+bounces-212865-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EBfpJqSJfGmbNgIAu9opvQ
	(envelope-from <stable+bounces-212865-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 30 Jan 2026 11:36:20 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0849AB969E
	for <lists+stable@lfdr.de>; Fri, 30 Jan 2026 11:36:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 007B83016481
	for <lists+stable@lfdr.de>; Fri, 30 Jan 2026 10:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 265C536998C;
	Fri, 30 Jan 2026 10:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="o6T0LzFk";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Dh0FB66d"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B3D354AEF
	for <stable@vger.kernel.org>; Fri, 30 Jan 2026 10:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769769377; cv=none; b=Zm+yOKCeJFhW9CNdHhLdz57XNCyIRCL20x4sBTwXBCzuQDW92QcEP6f4gyuZSsW8hSo4xpRxCCyF+49nUPt45vQ9LtakH+OIJ3AoD3F9HxwHWKBzhDtzlWQEfBCcIqhju/HfgFHE4I/SB1B1UGaUrZahS9jxMbBY9iJZjcO4Axg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769769377; c=relaxed/simple;
	bh=hfmrj9P+j01HoA3GJA5njWt63IBxLmC9zENgjTjmTMg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iycuVfZzfWmmx2ldJ5r0KxS1OwECbR/oG4apz9t2kF/d2IfOcNyK+c+2xMTRuxCH/4SxlRpKOQA/A6IA9N41AHUmklIubm9Cs3NBUFtFzIgnChn0x3/V/4QRdr6rQwrl383wdnAPjSb/R/GaWJZG4FA/moPLtHhbqFv7nCsq6io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=o6T0LzFk; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Dh0FB66d; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60U9V50c2675495
	for <stable@vger.kernel.org>; Fri, 30 Jan 2026 10:36:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Wl5V3XT9hGaQENmvghDS/LfyoUs8wvTCz21wt7ua918=; b=o6T0LzFkZQLf7QDN
	hQ4NQjA5oYIx5jfzJ4K7iXKjuu+sndXC6305/S+9EewrR7NGdEOkw55w7qr3uh7Y
	1/y7naD9fJg60N3D6sqOxd4d9KRyTDY2oiT2zvkBbEaHP3HX23Ecz70feOjA+yYH
	NE/z1NfzHdVc7/9JG4cECh0afNMTubuV3fq3nLXjzjHRdO48aUcngbdAsAC++BHl
	wBncQNRVJ47+lepvJsrsAMLTa7JoWTSocro8lmEEQ5mVIUPKZ0MReK+9eitzqQG8
	nq6MqbVx66QfoVgOjOdZ3dIsHqnEo9+eH4wK3Kujp7ivqPeosKiYZbGxupgnxcfZ
	L1JznA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c0t34070w-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 30 Jan 2026 10:36:15 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8c53892a195so34613785a.3
        for <stable@vger.kernel.org>; Fri, 30 Jan 2026 02:36:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769769375; x=1770374175; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Wl5V3XT9hGaQENmvghDS/LfyoUs8wvTCz21wt7ua918=;
        b=Dh0FB66dHPO/PajRLnRijUt+MN41AY7VJVR50jPyhqTNW0QHzYns6Px6EMlLWyJswE
         aA6BqYlpBTPw1o/Vj6ZNGoCJaki9bbtdXNraE3ch1BMSUgeL6ccktRo7aGhMnkhf3OJi
         Mo34RzrOzSS38+pyJJBjYsNPm4PQ0ELL0zGjL+CI9vP0qFnpyQPEY4O4+ekTPiwPOaOR
         OZDcDeydbnhidjD6sc6sN5IbvQ27KfyvpD8u9chMYbdCDkuXC5L7xQIcLwiizLfQm17z
         +VkqjIHlPugJMzFeGFvinzDDHNWkccWSTgRnRmqi8fyDbnYyCYSpef4Vc6KDmUhv/Ind
         53CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769769375; x=1770374175;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wl5V3XT9hGaQENmvghDS/LfyoUs8wvTCz21wt7ua918=;
        b=H6wR4fla3Xa2o44FZwIeZF90V2uj1RBohARRX4o/9Pr78BRQNOH6Ko3lVgCynH4FkS
         Mj/3wydzJgk+sfgJIP6WDQ5q1nCQXbEYg5UdpkcuKsSo9kwgVlEoemreyhe3njA9q3zl
         DB8/UkFejNmML//FBEbU5jjLYfiBxBp31eMOBd+AIECuTE9kHQrk2QXB+NEDtUoVlrar
         39oDZsNlcn8e0bAeAqNT2ooWk05EDI4hDRqGj5rSTfiVLskc5HLPltBL4/Tu37Hrn9cI
         1k8tJi+L8fymsRuRDrdgzFrgE0Gx3F+4dSEVQMZjANyd45pvrzt0Tiuaq5PbBNjmlCei
         F8xg==
X-Forwarded-Encrypted: i=1; AJvYcCVZJX93rgaB3KAmUi5LQl8+ItwOtKNUT6jwWbUGxdkhY0tTMUSa9I2wpUIfVdqDkG76bkTw6iU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+7/Yo5zoVFYmSMenWzM0Fwr1O0zOB5W0a+DfQeiJK4y9VdB5M
	4X+4OJ48fzyq+fsDWUvZAkX/rfZkeTOy0IOEW5ulvxmYK7ZU1MD1h5+R6sFqoaUg2OBrDkhg5N/
	XtgUhXAmYZBNh//fy3jwvrx83yen33AQFFkgFddoGZ6+1KbJhLBobRXvNvUk=
X-Gm-Gg: AZuq6aIHahkyrNGws8KLlHz5PTuORyCQg31dUyI9bc9HX4udXvXpaKSTA+LcjbelaPK
	31soBBb2tzFXF/1E56/BgGnK7f4TnmNe4I8Ne1b8Qm6PdeZNYP9i38Tp6Ez78wnI/QWTy5sYQVh
	6qFBnKFMgRjgD7EW/fXyzUFkXHsd0AlD5+6HUqgqpY2xQX3mONc7yAmYA1jK2V82II78VhWkRKa
	oYCBk8RRx/Opb9Z4v8dZSwk3H/iZ3Ym0V1t0FdvS9zT5P34SWJ1+fkZEejr9xoZaMyQtxVjXPGb
	1FV73NirucCuXtwSIHi/Biid5oWrYC8vnNkqcLmZsTb52skkkRVJ8Y7K+oiJvfwUs/dFo0HQiaA
	JfWv1CSlAbI8QVpXGRXtF70zoR3I6orLlud+JUi+vNswAG3p/65hpI34c0lAr5xpvHyQ=
X-Received: by 2002:a05:620a:1a18:b0:8c6:f7ad:49b with SMTP id af79cd13be357-8c9eb29d0b9mr271020285a.5.1769769374855;
        Fri, 30 Jan 2026 02:36:14 -0800 (PST)
X-Received: by 2002:a05:620a:1a18:b0:8c6:f7ad:49b with SMTP id af79cd13be357-8c9eb29d0b9mr271017185a.5.1769769374372;
        Fri, 30 Jan 2026 02:36:14 -0800 (PST)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8dbefc69ebsm403930966b.20.2026.01.30.02.36.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Jan 2026 02:36:13 -0800 (PST)
Message-ID: <121b00a2-2040-4ac4-9ce4-3865f9fa09e7@oss.qualcomm.com>
Date: Fri, 30 Jan 2026 11:36:09 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] clk: qcom: gcc: Do not turn off PCIe GDSCs during
 gdsc_disable()
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>, Taniya Das <quic_tdas@quicinc.com>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Bartosz Golaszewski
 <brgl@kernel.org>,
        Shazad Hussain <quic_shazhuss@quicinc.com>,
        Sibi Sankar <sibi.sankar@oss.qualcomm.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Melody Olvera <quic_molvera@quicinc.com>,
        Dmitry Baryshkov
 <lumag@kernel.org>,
        Taniya Das <taniya.das@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Imran Shaik <quic_imrashai@quicinc.com>,
        Abel Vesa <abelvesa@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        manivannan.sadhasivam@oss.qualcomm.com, stable@vger.kernel.org
References: <20260102-pci_gdsc_fix-v1-0-b17ed3d175bc@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260102-pci_gdsc_fix-v1-0-b17ed3d175bc@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTMwMDA4NSBTYWx0ZWRfX6ZvREhP4uWB/
 FHmh2zgypmF8ddK1ivLaTZxva41X8bpQMicFNIHlNFhBTfFGEEPN/2Xl9+UoctVT1yLKcHNu4m2
 kbDcR5FcWgsj/nhzbcFddiEJ8STJqWyApMlVCb/wsubdIZ+SKnbDjXpSnCjRSH14dioE+PeAPYt
 YJjWCtyLx/ufx06MrB6ExJYUrzQ0BCUj0uOPJC2tgDcnLoyseBbjjDaS08q8K27kFW3LmZuf+1H
 Uv8pnpvcyZQ98ueRrSmUMzpRGCF9OvvOb227zTM1tmGTWJZkwlxJik1XbRzxKliZ2HKHL/nkMoD
 kWIyZY1MwPNJYDFNJxeYTPYqwtC5oBdgMtHA47JPliGmDsiP7F8nUz2qmzLZePTBZPm3isZFBum
 wBlIfsNquwLkV8PzEdXaWMchhYjMIuVAaYSz4cg9j6qsooIrouc4H6+ap4yBJO2vrF3253fTkeD
 udAsFx0TM0UBUxEsGBA==
X-Proofpoint-ORIG-GUID: l4W9hXE0R_jFNZNQ25K1zKIpsW2KfzXI
X-Authority-Analysis: v=2.4 cv=QfFrf8bv c=1 sm=1 tr=0 ts=697c899f cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=67GeUOcPIWvtFfd3FpAA:9
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: l4W9hXE0R_jFNZNQ25K1zKIpsW2KfzXI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-30_01,2026-01-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 impostorscore=0 adultscore=0 phishscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601300085
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[22];
	TAGGED_FROM(0.00)[bounces-212865-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:mid,oss.qualcomm.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[konrad.dybcio@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 0849AB969E
X-Rspamd-Action: no action

On 1/2/26 10:43 AM, Krishna Chaitanya Chundru wrote:
> With PWRSTS_OFF_ON, PCIe GDSCs are turned off during gdsc_disable(). This
> can happen during scenarios such as system suspend and breaks the resume
> of PCIe controllers from suspend.
> 
> So use PWRSTS_RET_ON to indicate the GDSC driver to not turn off the GDSCs
> during gdsc_disable() and allow the hardware to transition the GDSCs to
> retention when the parent domain enters low power state during system
> suspend.
> 
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> ---
> Krishna Chaitanya Chundru (7):
>       clk: qcom: gcc-sc7280: Do not turn off PCIe GDSCs during gdsc_disable()
>       clk: qcom: gcc-sa8775p: Do not turn off PCIe GDSCs during gdsc_disable()
>       clk: qcom: gcc-sm8750: Do not turn off PCIe GDSCs during gdsc_disable()
>       clk: qcom: gcc-glymur: Do not turn off PCIe GDSCs during gdsc_disable()
>       clk: qcom: gcc-qcs8300: Do not turn off PCIe GDSCs during gdsc_disable()
>       clk: qcom: gcc-x1e80100: Do not turn off PCIe GDSCs during gdsc_disable()
>       clk: qcom: gcc-kaanapali: Do not turn off PCIe GDSCs during gdsc_disable()
> 
>  drivers/clk/qcom/gcc-glymur.c    | 16 ++++++++--------
>  drivers/clk/qcom/gcc-kaanapali.c |  2 +-
>  drivers/clk/qcom/gcc-qcs8300.c   |  4 ++--
>  drivers/clk/qcom/gcc-sa8775p.c   |  4 ++--
>  drivers/clk/qcom/gcc-sc7280.c    |  2 +-
>  drivers/clk/qcom/gcc-sm8750.c    |  2 +-
>  drivers/clk/qcom/gcc-x1e80100.c  | 16 ++++++++--------
>  7 files changed, 23 insertions(+), 23 deletions(-)

Using a terrible chain of shell commands:

rg "pcie.*_gdsc " -A 8 drivers/clk/qcom | grep OFF | awk '{print $1}' | sort | uniq                                                             

I get a larger list (it may be incomplete):

drivers/clk/qcom/gcc-apq8084.c-
drivers/clk/qcom/gcc-glymur.c-
drivers/clk/qcom/gcc-msm8994.c-
drivers/clk/qcom/gcc-msm8996.c-
drivers/clk/qcom/gcc-msm8998.c-
drivers/clk/qcom/gcc-qcs615.c-
drivers/clk/qcom/gcc-qdu1000.c-
drivers/clk/qcom/gcc-sar2130p.c-
drivers/clk/qcom/gcc-sc7280.c-
drivers/clk/qcom/gcc-sc8180x.c-
drivers/clk/qcom/gcc-sc8280xp.c-
drivers/clk/qcom/gcc-sdm660.c-
drivers/clk/qcom/gcc-sdm845.c-
drivers/clk/qcom/gcc-sdx55.c-
drivers/clk/qcom/gcc-sdx65.c-
drivers/clk/qcom/gcc-sdx75.c-
drivers/clk/qcom/gcc-sm4450.c-
drivers/clk/qcom/gcc-sm7150.c-
drivers/clk/qcom/gcc-sm8150.c-
drivers/clk/qcom/gcc-sm8350.c-
drivers/clk/qcom/gcc-x1e80100.c-

I presume these changes should apply to all of them?

(sidenote: 660 has a PCIe GDSC even though it doesn't have PCIe.. nice)

Konrad

