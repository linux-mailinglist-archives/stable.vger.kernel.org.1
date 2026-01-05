Return-Path: <stable+bounces-204583-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FC72CF1DBB
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 06:15:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 567AA3009FFD
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 05:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FB1E3233ED;
	Mon,  5 Jan 2026 05:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kpymggrY";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="A4L2NzW4"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5D8324B33
	for <stable@vger.kernel.org>; Mon,  5 Jan 2026 05:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767590091; cv=none; b=PXHcqaECIEuNI+Xv6tVV0dwePpqUl0le96cvuZGFpL5PtpJqCviR4iK4arB9er7RX1hccPFKI+DoPa3oJXSLfsqwfJEE0E29sCe8aGir06rYQ7Dt0HA/w2hrItkdhaCMhgO/PbHEz9IQ6dNI6WxiOM7gkByizBja4n8iEn5Jing=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767590091; c=relaxed/simple;
	bh=2Rvn9mdTtpv70ZbopaDh26zknLNtq9Ko5JJQBTSNe6A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jGaMmgowLmSVlTEEz9Yc/TYYmYsLrkVx1ltUY7JiBhkgEBzyMbN30VpIqbMWfYYlVPp6RIxckmxwoaE4r/znwC/NU06UX2my1IPYjJwaT3vSyTaTkUNWQuwTueE8kdzqSg985jb41FtsQok471bshHCKLRqaK/4XjX4x7ZjaXWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kpymggrY; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=A4L2NzW4; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6052o6Hx091257
	for <stable@vger.kernel.org>; Mon, 5 Jan 2026 05:14:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	BiP+iMImvGqtxpeQOQhAfUF3T3vnj0BsWlspquDFhO4=; b=kpymggrYrgHao9tT
	rX1W3otBN+TiOUVL0nK32InDQ6SUF9j6xnni2LGfL6q0Df9w8GLQ6hLepI+9xwK8
	i2FUYPfh2HbXqMlbMiZxsRCLiZvqno/I3Sh2g6MCAwixNWe0ZSUP66DjDy6cJ04X
	s7EKqkQyZUI6WY2IoqWFX5b5FvJ7uUY8CBZHdct3FGc7v+HiWZY8PHlK13eskJqF
	X/CGEyFBC/VtRKLzTQ9EXNQtq5EIEtRusEdzZ73vj5SFE+fSK9NdcATteKSWm6Bo
	Hma+TYwI5DyJP1jH4x4IUv4H4sx7xUIn/YQM6xH2ZnOY9AyC9yAFC8D3VjW+WATP
	dhTNBg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bg4v609uc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 05 Jan 2026 05:14:49 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2a377e15716so183306915ad.3
        for <stable@vger.kernel.org>; Sun, 04 Jan 2026 21:14:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767590088; x=1768194888; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BiP+iMImvGqtxpeQOQhAfUF3T3vnj0BsWlspquDFhO4=;
        b=A4L2NzW4oJIw/T3+RDdoX1cETLiOOZnzSxMzEM1Qozd5bT+gcalqt9KEDV9MX4iJZU
         mVOl6XY0ggDqHGbJdBopi5WsNCCj+vpOsMO8eeIPtJfTOcgBJ0vQvFjgqjStjG+zNjIl
         bG39DyhbKTQLok1FyYq478R8EanKJ4WpbFM734LUL4a/DffZQhCnawg+hJhaTlkFPT//
         /MPTDEsfWzMwr0L1Z7dhnFZyAqVOTwYD3FDgXKjTR3GtdfK14P/sAJWgAEu1vGtHRSJT
         0HO5kXoRFh1TxMVG1GOlQav2GNhJaOWVw1oxexTJ38+cWBGfzaKBGhMCi2y9pP1DvGzj
         CNHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767590088; x=1768194888;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BiP+iMImvGqtxpeQOQhAfUF3T3vnj0BsWlspquDFhO4=;
        b=JkAU66XflOdNZi2JaHo1t1KbaEIn0dKjr52XGK1y/j33msS/K4Ly/2KfwRQhpDQt3N
         E0BYbGH6xA1PLp60Kk691wczECWNuibp63f4nsM6mUXHVRkF79F+Pi4l9csQ0rx8nWPj
         UIPj/AiLgkFNMbUrCJxvls0ezUzgCpohmPHyy54xMTqZjUBwfpzpGWGBR+/EIV9PPm7U
         xpzL6t6BDdPbe8xwNh+LCIN1C3bk6QabWQwABFMdqhlB/UrT5nagkO6zUZTDv1ZWl+y3
         rPo9NiwDdXAtHNezz2ZDKn2fOUNEzP9/AveSDtxpSibNfjjqe8Jwqr+ZAkypUABlD9wi
         fXVw==
X-Forwarded-Encrypted: i=1; AJvYcCVXECpB2F3F3Ae00XaiVMBrIVpzsy0r7kmN6Znl/9BLLqTGO1IA8k4XiaP4H5wdASi5tgPMiJs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzci/M1EU1z9v/ozeKbX4EpGJOO3S7DEBPOVjfTFaGbVgUu4BfB
	/r/4OsqXBy/F2ewnN41PFUv7TueOjNhnxQxLndQp9blx5p4pME6GAMtTdEfqAzkDO1LEVI6Yx27
	IQdRN95kTFMD8fEMG0bG9y6MoxwPAlcCabZPoq7uZZUmU7YtK8i/E6tpPAw8=
X-Gm-Gg: AY/fxX4lzySxqYLPFPTkXfUH4P3apjhZYMsrZ2mAngpimEWqRCDmRlkLI05W+wP6c60
	ysY91CLPvfn73rl7I0gAKIeCBMoNanJDLtS7iouUEexEnxQNx24y2Bwr0kuy69hC6/f5YrJguR2
	VxgccbIa1v6fayFEVu0YwdwHBiukWgPoV2D1tJwHemBsQck+H9FNdvkgo3ecMj9oQ2t4pcLKZI0
	xn9I1cGQ6BflAha/5VOqkN+LznbAisTPKYxXWARx0ANMHbNGfc8Heqv1g6Xaw2lZMZmt9qJo2X/
	URsaa7Qzi4ozI6h1Cn0zEOUbt35x8exdSbIG5sUBp7bJW+exaLojxrcaU1SHTg5dsW/W6lyvG++
	oOnQ58Ni7hRLyJAdSKdz5ud8eRw==
X-Received: by 2002:a17:903:40d1:b0:2a0:8972:d8ca with SMTP id d9443c01a7336-2a2f28367f5mr531839275ad.35.1767590088119;
        Sun, 04 Jan 2026 21:14:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFd3wxSUtjT+h6rvYwagDPer7eavr4w39r5bx55g7fir9t6zhlGDqsoGYgGYIrfpxmKWTP81Q==
X-Received: by 2002:a17:903:40d1:b0:2a0:8972:d8ca with SMTP id d9443c01a7336-2a2f28367f5mr531838955ad.35.1767590087540;
        Sun, 04 Jan 2026 21:14:47 -0800 (PST)
Received: from work ([120.56.194.222])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3c6a803sm430485715ad.6.2026.01.04.21.14.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jan 2026 21:14:47 -0800 (PST)
Date: Mon, 5 Jan 2026 10:44:39 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Taniya Das <quic_tdas@quicinc.com>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Shazad Hussain <quic_shazhuss@quicinc.com>,
        Sibi Sankar <sibi.sankar@oss.qualcomm.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Melody Olvera <quic_molvera@quicinc.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Taniya Das <taniya.das@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Imran Shaik <quic_imrashai@quicinc.com>,
        Abel Vesa <abelvesa@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rajendra Nayak <quic_rjendra@quicinc.com>, stable@vger.kernel.org
Subject: Re: [PATCH 0/7] clk: qcom: gcc: Do not turn off PCIe GDSCs during
 gdsc_disable()
Message-ID: <2lpx7rsko24e45gexsv3jp4ntwwenag47vgproqljqeuk4j7iy@zgh6hrln4h4e>
References: <20260102-pci_gdsc_fix-v1-0-b17ed3d175bc@oss.qualcomm.com>
 <a42f963f-a869-4789-a353-e574ba22eca8@oss.qualcomm.com>
 <edca97aa-429e-4a6b-95a0-2a6dfe510ef2@oss.qualcomm.com>
 <500313f1-51fd-450e-877e-e4626b7652bc@oss.qualcomm.com>
 <4d61e8b3-0d40-4b78-9f40-a68b05284a3d@oss.qualcomm.com>
 <e917e98a-4ff3-45b8-87a0-fe0d6823ac2e@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e917e98a-4ff3-45b8-87a0-fe0d6823ac2e@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA1MDA0NiBTYWx0ZWRfX4JYpErwP4MFK
 K30LilKFd6Pur2nodREyuNS/BEzeJFTPWwAJAWKi/4dYHGt+s2C7E1PrnPgyNXcXJd9aK/StRxB
 +9I7v0w9HPgtqaTsqEjbvdKGEmPDVq+2VZZ0Rp44GlXgv5LGHsKEWfIfmP8s9qr6xJMiA6EYgo/
 +7o/ean74F0GjIPXHp0lsUuCW0xXXBP+W6i3s6D5IPByifHwAmCr8cjKOFYlmK2bG0z3t/N/hh2
 ssVsccVLnQmsVOSDuHhBHdrFBY4vePy48P9qQYfo1j0jUqwkzJuqK+2xQcHrb8FJfu7emsAz5Ut
 ntRbUkVHVv8s5J77Hh4ug0x1DJhERBgdNToJcYOYADJ/wmpzwffrhFuBRrXrhjXPZ101eWd0WBC
 RrUt1jvvsm4HUs0dbEpGJsVRcS7O6pJ7ap5Uw0lkTvEvdUzeQqwhfgvPjeNybaeaGuRBCe0kc2y
 eV+oWNARKQhxDEuXoDw==
X-Proofpoint-ORIG-GUID: 6OZaQQk3eq7k5E0zi84wsBrm8qmAwisd
X-Authority-Analysis: v=2.4 cv=c4ymgB9l c=1 sm=1 tr=0 ts=695b48c9 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=3dEILRYKsVIWdVk4w2Qziw==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=wYrHME7Dk8E3MGYi6NoA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: 6OZaQQk3eq7k5E0zi84wsBrm8qmAwisd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-04_07,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 clxscore=1015 bulkscore=0
 impostorscore=0 priorityscore=1501 phishscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601050046

On Fri, Jan 02, 2026 at 02:57:56PM +0100, Konrad Dybcio wrote:
> On 1/2/26 2:19 PM, Krishna Chaitanya Chundru wrote:
> > 
> > 
> > On 1/2/2026 5:09 PM, Konrad Dybcio wrote:
> >> On 1/2/26 12:36 PM, Krishna Chaitanya Chundru wrote:
> >>>
> >>> On 1/2/2026 5:04 PM, Konrad Dybcio wrote:
> >>>> On 1/2/26 10:43 AM, Krishna Chaitanya Chundru wrote:
> >>>>> With PWRSTS_OFF_ON, PCIe GDSCs are turned off during gdsc_disable(). This
> >>>>> can happen during scenarios such as system suspend and breaks the resume
> >>>>> of PCIe controllers from suspend.
> >>>> Isn't turning the GDSCs off what we want though? At least during system
> >>>> suspend?
> >>> If we are keeping link in D3cold it makes sense, but currently we are not keeping in D3cold
> >>> so we don't expect them to get off.
> >> Since we seem to be tackling that in parallel, it seems to make sense
> >> that adding a mechanism to let the PCIe driver select "on" vs "ret" vs
> >> "off" could be useful for us
> > At least I am not aware of such API where we can tell genpd not to turn off gdsc
> > at runtime if we are keeping the device in D3cold state.
> > But anyway the PCIe gdsc supports Retention, in that case adding this flag here makes
> > more sense as it represents HW.
> > sm8450,sm8650 also had similar problem which are fixed by mani[1].
> 
> Perhaps I should ask for a clarification - is retention superior to
> powering the GDSC off? Does it have any power costs?
> 

In terms of power saving it is not superior, but that's not the only factor we
should consider here. If we keep GDSCs PWRSTS_OFF_ON, then the devices (PCIe)
need to be be in D3Cold. Sure we can change that using the new genpd API
dev_pm_genpd_rpm_always_on() dynamically, but I would prefer to avoid doing
that.

In my POV, GDSCs default state should be retention, so that the GDSCs will stay
ON if the rentention is not entered in hw and enter retention otherwise. This
requires no extra modification in the genpd client drivers. One more benefit is,
the hw can enter low power state even when the device is not in D3Cold state
i.e., during s2idle (provided we unvote other resources).

If the hw doesn't support retention like Makena PCIe GDSC, then PWRSTS_OFF_ON is
the only option.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

