Return-Path: <stable+bounces-206245-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D7D6D012D4
	for <lists+stable@lfdr.de>; Thu, 08 Jan 2026 06:58:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B1448300E035
	for <lists+stable@lfdr.de>; Thu,  8 Jan 2026 05:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A03BB33A703;
	Thu,  8 Jan 2026 05:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UIPrSe/N";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DEpzqP2r"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B69902459EA
	for <stable@vger.kernel.org>; Thu,  8 Jan 2026 05:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767851919; cv=none; b=qR/yndsGf5c92dlCk15bj+kc77hN1G/jqSYXoS4MH9zzwqKxgsZ1Qgi/VOlwmKEuQeJsrCaSoioVQ3oWIzll/kQtgUlnxT+2Efdbvy7yA3yl497yzXspfUT0qBLxTslNGM0AmbBpMNtQU8FCrIRNalSwfhU1stzn464nLpEWxxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767851919; c=relaxed/simple;
	bh=jmuRz7laWsvaVKWvXCL5E6YwClFXNXcylq9sPTclTPU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p35aF48YL2eRJVYJ4E3hA68tDIe/wsKIHf4fw0PC81NuIxjT8GPERMTptoK5yqh5OzI3EvqieR/gggSWpg+MiKCMPoJ10SVIOyZgilLeLKkR6tpo5zx+WUaFhgftokO1k+DxdnKNgRXWdCpuWBaCw/uCnq7z29BWa7DiK/raIOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UIPrSe/N; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DEpzqP2r; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6081EIqI878063
	for <stable@vger.kernel.org>; Thu, 8 Jan 2026 05:58:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KPYorIOVmCg/xCSHrscU+vX13wArRA8uiPCnnOt9eD4=; b=UIPrSe/NnwlzeUdy
	fdeCO4z9d8qcJLSYHLI3XqItHFFjrk88rCm/sHTFN6TSAcjNwVZSdih6qjvI/TkI
	LeiR4XhnZQpgFJhnNBRLWdhRnac23BGhq2l6xLcmsM5oZAiaOy60OcwWI0rmWrvB
	kK9+9zyTRm22a323Du6U9+F/Diy6rhdbUZtaLiBR2/Vz9yGxc/I5YAO/m0pBLztk
	GJdkFAZHefmpAFNxH4RyN76gaVIL2T3H1QwPWVNRY6VenFug1rqSlTnnJl4VP247
	/nQhOVu8r9zirj1RZ2KvmHTMS3Pa+rPyjDWBT3LnlmHqAEQtSECdN90bXx5LMH4I
	/4h3Yg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bj2r30qdx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 08 Jan 2026 05:58:36 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2a0bae9acd4so23588895ad.3
        for <stable@vger.kernel.org>; Wed, 07 Jan 2026 21:58:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767851915; x=1768456715; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KPYorIOVmCg/xCSHrscU+vX13wArRA8uiPCnnOt9eD4=;
        b=DEpzqP2rk6zQ8hzZJRpvSeOFF26EiBjCWjJJrQr4BWKWeELCtBolyGsiOlC7LY/uhV
         32m8j/uVkVe3JfmH/4RUT49bPe+8BoeyvMNGesvF0wVx2A8rcAUy3u3zJccAtehZGJSZ
         KYW5mM2mbbjBTFBSGhOHZ01JJrmLdND34AhB7Myz9Sez7uv9+GaiGNcalhTjrARx7F7m
         NiLa0tB9E6mvhW/3DnbpP3fkVAWxbuIQVbjeoYwv42MS4VasJhevXr19fzWx9Z0NACv2
         1/4GI6BYfHtSAktd2LsKgqzzo9QoJDpGgpQYmqErWRvAmIiUxGi8CPZ8GKajFkQT0dS9
         jQDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767851915; x=1768456715;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KPYorIOVmCg/xCSHrscU+vX13wArRA8uiPCnnOt9eD4=;
        b=OdQwJKCZOWybVynuAf2wZTVi8My4EqSQwOYDq0Gdt6twFabEZbPv+Mwh9UyoRiBnUu
         c5oyfv5K4QsM+MI5P3BPYm3nRg60/IH2OSJsPTqUiI3y117LdwjURyTsIrWUk0KrK6J7
         pELeyVJtb6WTsQapaH8+x3v5LMi60cvqdhK/r5K/zltGI6rEDFlIiLXRol0wdVbwfqI0
         PhOd40rpw+BllTGyrxjLzqr2vXEn6qE9QrLhmKW77l4cPSLarjz+2tqbIU39VjBzdMDq
         NxGWxDoR0wxfxhn28Wjhw6GeDre2IPLDX6jDOsTIJ3C8NW6vOGCtUJRVn9BOBH/fBX1G
         3zLw==
X-Forwarded-Encrypted: i=1; AJvYcCXEYAwgyo4pogHjAsVLe8TnKCsV70cItvbwqZ2tV9q8xtQVCxFgg5742duxSOozkQ6TIVhkPmU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZQIGn/volCNfJDM8UCm0ggWcIMlCSfKRexhGXjN8VJR6ga+x2
	k02cbUcfuQMVPd/UBiqbS+9YEw936CeTWfekzPaMLFvt/H2H/hgIrEcx+/gvJynB0fLEl+9d9t7
	hj6yPRW+Unk5W4piPU/rjgN2hG8uG7rAdHwz2WWqpZHMiQhffM3tEFNhZ0Rk=
X-Gm-Gg: AY/fxX6QlXA/SRLJzVL691HYo/RlNvg7tvhBMBHBoQlCcohXm5YIO9W1o+BBYtsYoYg
	eQ0uB85v5Kt/WlcOIjLuXE8D6g0hBihlBsTuDNpvBGgfHxVwLW2vpSqfcIMzg8yW4b0Y1cQfE1Z
	TGp6wu/xE2ZiWseDRaDB2IAgwmi5izqrf9+FJq6Jj5WG/WzmpDt0i4pztr0fRCmOtPkbS9IJXrW
	gNieU6PVon6QFI0YD+RDDefHCZybaSZekpwC/AcpcaRJeJehapPEuvhOvmbBFUn+/QoByfA8+p2
	erkkvnLIGyW7wtilLoNqZZyUIlRUjf1FHsJkQvtElTUCEsB+tJ+G3GNAzWC8PuBfQJQvpyg8v4q
	ioSZin2fXPQH4O7E+86xOGQ==
X-Received: by 2002:a17:903:248:b0:2a0:fb1c:144c with SMTP id d9443c01a7336-2a3ee40ee95mr46423435ad.5.1767851915338;
        Wed, 07 Jan 2026 21:58:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHVWFzdCH0NvCqAqzFjiQJZqOIin8TQmPH0h0f7iHo4faS2uHD2sRCtyN4+GHqvUTWJPMNp0Q==
X-Received: by 2002:a17:903:248:b0:2a0:fb1c:144c with SMTP id d9443c01a7336-2a3ee40ee95mr46422955ad.5.1767851914736;
        Wed, 07 Jan 2026 21:58:34 -0800 (PST)
Received: from work ([120.60.56.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3cd492esm67610355ad.98.2026.01.07.21.58.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 21:58:34 -0800 (PST)
Date: Thu, 8 Jan 2026 11:28:27 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
To: Stephan Gerhold <stephan.gerhold@linaro.org>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
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
Message-ID: <oysexostrdzcyapwpf2ele22lje4limgdknz3xcjgbs5tpvr46@cxzefx6ep477>
References: <20260102-pci_gdsc_fix-v1-0-b17ed3d175bc@oss.qualcomm.com>
 <a42f963f-a869-4789-a353-e574ba22eca8@oss.qualcomm.com>
 <edca97aa-429e-4a6b-95a0-2a6dfe510ef2@oss.qualcomm.com>
 <500313f1-51fd-450e-877e-e4626b7652bc@oss.qualcomm.com>
 <4d61e8b3-0d40-4b78-9f40-a68b05284a3d@oss.qualcomm.com>
 <e917e98a-4ff3-45b8-87a0-fe0d6823ac2e@oss.qualcomm.com>
 <2lpx7rsko24e45gexsv3jp4ntwwenag47vgproqljqeuk4j7iy@zgh6hrln4h4e>
 <aVuIsUR0pinI0Wp7@linaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aVuIsUR0pinI0Wp7@linaro.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA4MDAzNSBTYWx0ZWRfXx+H44k5LxBQ6
 YWFfYdPQISU8s2uUoIbKpB3v53mlhu5RZP5S7VRNV9smv5021yu8ehCT80vaMuNoOAP4dj2KL75
 34dUMwtYrKWnqL4k2MyFyNWndWn5n2wS2cz0mhdwnRszXiEbrIt6CnXeYEBJVi0wvt8nzhk1rbj
 Le6WXR3iw7HGnZODKk4gZWR/YIbPywCKRSQKe6iRJ5d7rR7dYtDmxtH4/Wrjp4JhgcshHcTn2es
 sUhum3vyVFL1A21nWfg/iluHcJHSurY9oMba+PMRaH4+bgzZh4p80hxV7edZ9Cr9de0JlYpibpp
 q2WINWgkbsRPjH+eRFbW7lmUOQm7aiSqodHCFnzue5gn05X+7vGPTtK9nHVLacP70MPQXQQC2HC
 48Sp5WapLwpZFuq9av6oqdy5GI1RN1nLWKxbTzhpCDvL0atD2PHpA56UDVMLB0nhYW8XjPa7z5u
 +rpNmd9CUTGJjYItQDQ==
X-Proofpoint-ORIG-GUID: E1jd74miDnth2PFpKWBdzAfRW0nTJav9
X-Proofpoint-GUID: E1jd74miDnth2PFpKWBdzAfRW0nTJav9
X-Authority-Analysis: v=2.4 cv=S4nUAYsP c=1 sm=1 tr=0 ts=695f478c cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=RufU61fwOX414azV3ffNTg==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=gMOyne7U4qER8HjkPQQA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-08_01,2026-01-07_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 clxscore=1015 priorityscore=1501 spamscore=0
 lowpriorityscore=0 adultscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601080035

On Mon, Jan 05, 2026 at 10:47:29AM +0100, Stephan Gerhold wrote:
> On Mon, Jan 05, 2026 at 10:44:39AM +0530, Manivannan Sadhasivam wrote:
> > On Fri, Jan 02, 2026 at 02:57:56PM +0100, Konrad Dybcio wrote:
> > > On 1/2/26 2:19 PM, Krishna Chaitanya Chundru wrote:
> > > > On 1/2/2026 5:09 PM, Konrad Dybcio wrote:
> > > >> On 1/2/26 12:36 PM, Krishna Chaitanya Chundru wrote:
> > > >>> On 1/2/2026 5:04 PM, Konrad Dybcio wrote:
> > > >>>> On 1/2/26 10:43 AM, Krishna Chaitanya Chundru wrote:
> > > >>>>> With PWRSTS_OFF_ON, PCIe GDSCs are turned off during gdsc_disable(). This
> > > >>>>> can happen during scenarios such as system suspend and breaks the resume
> > > >>>>> of PCIe controllers from suspend.
> > > >>>> Isn't turning the GDSCs off what we want though? At least during system
> > > >>>> suspend?
> > > >>> If we are keeping link in D3cold it makes sense, but currently we are not keeping in D3cold
> > > >>> so we don't expect them to get off.
> > > >> Since we seem to be tackling that in parallel, it seems to make sense
> > > >> that adding a mechanism to let the PCIe driver select "on" vs "ret" vs
> > > >> "off" could be useful for us
> > > > At least I am not aware of such API where we can tell genpd not to turn off gdsc
> > > > at runtime if we are keeping the device in D3cold state.
> > > > But anyway the PCIe gdsc supports Retention, in that case adding this flag here makes
> > > > more sense as it represents HW.
> > > > sm8450,sm8650 also had similar problem which are fixed by mani[1].
> > > 
> > > Perhaps I should ask for a clarification - is retention superior to
> > > powering the GDSC off? Does it have any power costs?
> > > 
> > 
> > In terms of power saving it is not superior, but that's not the only factor we
> > should consider here. If we keep GDSCs PWRSTS_OFF_ON, then the devices (PCIe)
> > need to be be in D3Cold. Sure we can change that using the new genpd API
> > dev_pm_genpd_rpm_always_on() dynamically, but I would prefer to avoid doing
> > that.
> > 
> > In my POV, GDSCs default state should be retention, so that the GDSCs will stay
> > ON if the rentention is not entered in hw and enter retention otherwise. This
> > requires no extra modification in the genpd client drivers. One more benefit is,
> > the hw can enter low power state even when the device is not in D3Cold state
> > i.e., during s2idle (provided we unvote other resources).
> > 
> 
> What about PCIe instances that are completely unused? The boot firmware
> on X1E for example is notorious for powering on completely unused PCIe
> links and powering them down in some half-baked off state (the &pcie3
> instance, in particular). I'm not sure if the GDSC remains on, but if it
> does then the unused PD cleanup would also only put them in retention
> state. I can't think of a good reason to keep those on at all.
>

This is a good point. I didn't think of it.

> The implementation of PWRSTS_RET_ON essentially makes the PD power_off()
> callback a no-op. Everything in Linux (sysfs, debugfs, ...) will tell
> you that the power domain has been shut down, but at the end it will
> remain fully powered until you manage to reach a retention state for the
> parent power domain. Due to other consumers, that will likely happen
> only if you reach VDDmin or some equivalent SoC-wide low-power state,
> something barely any (or none?) of the platforms supported upstream is
> capable of today.
> 

Unfortunately, that's the current state of retention today. It is only a
firmware visible state. Ofc, the OS could query SMEM and figure out after
resume, but there is no way currently to translate that to individual power
domains.

> PWRSTS_RET_ON is actually pretty close to setting GENPD_FLAG_ALWAYS_ON,
> the only advantage of PWRSTS_RET_ON I can think of is that unused GDSCs
> remain off iff you are lucky enough that the boot firmware has not
> already turned them on.
> 
> IMHO, for GDSCs that support OFF state in the hardware, PWRSTS_RET_ON is
> a hack to workaround limitations in the consumer drivers. They should
> either save/restore registers and handle the power collapse or they
> should vote for the power domain to stay on. That way, sysfs/debugfs
> will show the real votes held by Linux and you won't be mislead when
> looking at those while trying to optimize power consumption.
>

Maybe we should just use dev_pm_genpd_rpm_always_on() in the client drivers if
they know for sure that the device context should be preserved and keep
PWRSTS_OFF_ON flag.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

