Return-Path: <stable+bounces-204460-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 55D6FCEE607
	for <lists+stable@lfdr.de>; Fri, 02 Jan 2026 12:36:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4E83B30249F6
	for <lists+stable@lfdr.de>; Fri,  2 Jan 2026 11:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C45D186284;
	Fri,  2 Jan 2026 11:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jLwdbu4X";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jiYPr+Yv"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07042F361F
	for <stable@vger.kernel.org>; Fri,  2 Jan 2026 11:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767353657; cv=none; b=TDWBh66kqofwFjxAQFUjjVQhTE6IgcVC0tNhBSnX8QkjQBHqi/Z7g4Xw5XNvcHXZmD1VZ6xt/bpTMknmMxaY58cUpkph1dslcFx2kvGgO5AsOVHtM8OXIwTL7h9TJgbjWSH1sTQbwb6sJeT4p3NT/89ZrJlNRLbfuC1RD+Q4KLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767353657; c=relaxed/simple;
	bh=ZnEfqd8WYbsRBu49JAdPAIcdkTOS76iHfcTHMMFPn+A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iYsqNjJL/f+BZAswlshFYw4s6GJ2KHixvradPGlNXwEVX6nQdd3kB+LoFiq3F+cxmAE6mp2TFR6MFSxkOHZAJ7NK3GrUsGfljrHEv/X5G7nFVDkky9Wkq+DYteP4YXU+RCBU7FR0Gji+3JYDFI6puHan/qnoFIfAPBV9CI+vANs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jLwdbu4X; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jiYPr+Yv; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6029WEgi207467
	for <stable@vger.kernel.org>; Fri, 2 Jan 2026 11:34:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZnEfqd8WYbsRBu49JAdPAIcdkTOS76iHfcTHMMFPn+A=; b=jLwdbu4XBf/DqdhX
	MC0l8u6aUv5G31D+rD2hTJ7zLAYHhc5b7FsR2H/pNvqeTx92CL6soO/gybkf8Cel
	CpiSANtcuw7gzTvJ6Rh3WxFOWY5S9xE8jZITPpndfXwyzU+3tLN4JZ67f+y2rAF4
	Yk7Mz+B8N3OMRmCpIhAyNjzB9p6wLoZtst07jlBdTjoKC6oFNqd+qQsjaMbeBr31
	LnHQUyiamRDwQDJRndAyBHV1clqPz9lhxCSIIvtDfvvQ5cq1k9kGJnbH0o/91aLp
	aTRNdTHZYHLJzm+y9JPP8X8cVa7RqomRanoWwsyLTGZw9tLm3VtfIZyzfpmzoP6k
	RKriLw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bcx74cc62-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 02 Jan 2026 11:34:13 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4ee05927208so54967981cf.1
        for <stable@vger.kernel.org>; Fri, 02 Jan 2026 03:34:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767353653; x=1767958453; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZnEfqd8WYbsRBu49JAdPAIcdkTOS76iHfcTHMMFPn+A=;
        b=jiYPr+Yv81w9pb6ZVS8XNosZewAlofqvPaJ6mHusM3hRWkt3VJFL1B8lelZ+8P3kDY
         eHXOr42dMs61TvONDYjh8gc0F3nQaXepx7kAQv5Twsq+g5A6oLKc/k/1qp8kj+YkSDtt
         3Q/lh9qqUDMwxlQ5X452GD+jRxFnryIu4fphoNQ4AAGAuAlik/XHpFkeWatMq1Zjmbft
         e6LWfNDWlqWI1IrcPjSsa9vpCePmKKUwBzxIJd9GsyRtFMMuDVzCq2rTTJ58ucftjg86
         hbZJtixQWMDSVPAM4KuDTO0OZ3zgVt/lxejuyTYvrixBozBIg2gzK3YodMk+4aKTgZP4
         oaWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767353653; x=1767958453;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZnEfqd8WYbsRBu49JAdPAIcdkTOS76iHfcTHMMFPn+A=;
        b=dxkAS2pmJ/eHbqVPcE5HbFxw4f33IASFE5kbZOjUn1cwmXH+RWAs3042ny0U7mKfw3
         pOT1qSCywf0a9PrPh+dlcbqRAU8RodWapcyFlAMIol92e0zVYE0gp99yobqJ2vbjqnzF
         4Qoi6p+XbrSMD3xrif1T3DERODPaNBM7dczIlYyx/Ajki2Lkl6+1Pdr10x2Au7LuZmLq
         3J2DaxcUJ2rSGp7KgWYRGsmh/u4GFTO7Ha7vutkC+9ZubjS2Art1/V5hanLWluiyswiw
         Qn9Sd4sRU0Z1hP8PUK0rpwB1S7baNg19DNmmsNT0XwXTtKucIE2efMFxIT6+fCm6Tgl8
         GzpA==
X-Forwarded-Encrypted: i=1; AJvYcCXBU8IBXniaPKNCxMgDnjZsFgrkTREw3M7HmSf1DWyQ2E8+jeLTyXOzCpN4awFoZTEeA6omiyM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy84uPhjRNRSQmRAbTKdYKtytnEpM6VMqt0DTKZjgHYfRvf0SOq
	ZWzVyIm1t4Fr626sBTqgmVtsiwZEcDPsmm2Fe/UphXY3WvaxoeDqXXk7v5gdEWg4O8Pawac3CBo
	o9Bi/f3JzuD536i9l4KowtOJGNAVDxsYQ5Liy31W1Ktv/bFQzyRZVxb844Sc=
X-Gm-Gg: AY/fxX7I1SYUxa40WTNmughKrZ/BLNB7I8HqakbXIgjgZLVg9OoX/9doGu+ZJhR2+gI
	eh2j/GSqQRNMFZBWlEKlM4XaQLfd49DnE3mGXLM7s50Ldp4p+Yr0MTPD3fo2l7eUvKOsRtWK2a0
	mh2QqSJv17aUYPfup1JEFCzKlB9HVwU0/zsuHpJza+X8e1ZOUbmTNwciuq7tudoCXf+8T28Jtri
	JnDSk73ouVZqBa9BernVe5v0Eatr2AGC2ekrkMyvEBGIfdPxnXpRc0C+FI1OZxO5GQIfDWlxBGD
	GSNG1hX5W2+oBz9lrcnlypjSeGnKy7F7gnW06WtX3HSXjwLSfYqyrttlci7bn6rnFKE74sIzRo0
	lw/n3YBqFnI42LzmB4PoiW8/uSf5XQd+K3CtZ9DK/jfHd4QIK0ZKBpTYyXr7O9hl21Q==
X-Received: by 2002:a05:622a:1922:b0:4f1:b3c0:2ae7 with SMTP id d75a77b69052e-4f4b43e3a80mr432106361cf.6.1767353653077;
        Fri, 02 Jan 2026 03:34:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGQcpKMZLQyO21S342Q1ST+russHl3QXOoA+e/hjw4x2uXgifbAQtXq3FQdi//CJyR1kaPJsA==
X-Received: by 2002:a05:622a:1922:b0:4f1:b3c0:2ae7 with SMTP id d75a77b69052e-4f4b43e3a80mr432106031cf.6.1767353652663;
        Fri, 02 Jan 2026 03:34:12 -0800 (PST)
Received: from [192.168.119.72] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8037ab4f0dsm4573315866b.15.2026.01.02.03.34.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Jan 2026 03:34:12 -0800 (PST)
Message-ID: <a42f963f-a869-4789-a353-e574ba22eca8@oss.qualcomm.com>
Date: Fri, 2 Jan 2026 12:34:08 +0100
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
X-Proofpoint-ORIG-GUID: CmRZOlPmRqqgWBAZ3UYi8gbH3stPcGhG
X-Proofpoint-GUID: CmRZOlPmRqqgWBAZ3UYi8gbH3stPcGhG
X-Authority-Analysis: v=2.4 cv=HNvO14tv c=1 sm=1 tr=0 ts=6957ad35 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=B3EyukNvg1VkyB4u8sgA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTAyMDEwMSBTYWx0ZWRfX01jVpoYJtHD0
 InyF+L/TS0Jaj960FNQTIJDUH1HxwdKPAoNRfrmY9uuW4zh89242mdbGnv0Tgy3iS3sD2V4/Cm7
 nUokwhDbYocbQS6Sawa3ko0Ul78rVKtkkCMa7XacNWDn8PE9qpsmw5R4H4Z4ehjuv6Taw1vrWKG
 fC/JptsKAqDFJxolftkE6Bek/mpip4EsGzwNnebtdAkmtpeEv42ARx00d1uVw2on8Lnv+d6H59z
 /RaKITvEglfxu3rp10cG6fzusj60SIXQD5xL8U1e/1eWlnRBHXd3y4tEZrlcW9JZTczRyITIP1E
 T2WTJ9b/0B9sQXN8QXNYzMLoZewGCDpnhYJz6/XpyBQfneIpjZpyUu3u5Lo0R0mkISZJD1G+45w
 TysKj6yrEBcGf2thwYd5nhMVW9oGFf+1YwZ3POfwB/920WRYJVILg5C/e+VKc73oCEtQC5z+Gc2
 imMtkcfxgR7DGpT9ScQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-02_01,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 bulkscore=0 adultscore=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601020101

On 1/2/26 10:43 AM, Krishna Chaitanya Chundru wrote:
> With PWRSTS_OFF_ON, PCIe GDSCs are turned off during gdsc_disable(). This
> can happen during scenarios such as system suspend and breaks the resume
> of PCIe controllers from suspend.

Isn't turning the GDSCs off what we want though? At least during system
suspend?

Konrad

