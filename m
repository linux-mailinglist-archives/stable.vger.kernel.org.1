Return-Path: <stable+bounces-203125-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A86ACCD24E1
	for <lists+stable@lfdr.de>; Sat, 20 Dec 2025 02:17:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4E0A8301D5A6
	for <lists+stable@lfdr.de>; Sat, 20 Dec 2025 01:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EC4D1FF61E;
	Sat, 20 Dec 2025 01:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZOEAPg9u";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eLedfgJD"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D5F3137C52
	for <stable@vger.kernel.org>; Sat, 20 Dec 2025 01:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766193434; cv=none; b=nYm/jr7qbWy2mbbFsSmy0rwh88tE5w9/h+XU7IJvdCyOrXkVZtfLgcCiLGYC42L9w/uDmOXInfyejtTFAYf4bz52AKCYcBcfRCMGEwfeHwPQmYRLDojEtWEYMc1qHEfXZ46DD2cdr9z2rEruOShzKOLfV4a/lR/A1AOAiIv1kJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766193434; c=relaxed/simple;
	bh=9/g3xrQYqQvMPlJ3kljgRwjOKDCzoA+fL+6rYoa+mko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BM8A7Xg1UnytaDzi5BErxK0cV0bnsUA0tEdZklhdtD8bGMNTVDGiQPgGBNZNlHJSeIelczF6f/Fgq96WWY/uGyU88u6oqDwdOIJopln0bosnK5LqUaFruBkE9Hy8HUTFPw1vmWJ+WbPPojPF8R1VPD4ktqIzwM70YD+k0j8iJyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZOEAPg9u; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=eLedfgJD; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BJNO1da3003708
	for <stable@vger.kernel.org>; Sat, 20 Dec 2025 01:17:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	IQVWVrHY06xpDTJeqnmla272fk+k3T3T7nR1IYSIQ+A=; b=ZOEAPg9uvWoAc6zD
	vwVU5YPIyLm1EYCApJLdXWtkZ5X8fx4t7nlgibTJk+ec+ZQLfC7dW6lPXewbYHWC
	MnzJFXvEN7C7bwMiGlQNieI7+r19eVqy6WiFXGTXSDIuNY9ZOT4AuNYfLyf0V6lj
	lQZkB4IvruG3W7jX8vCmXL1xzWz3JD2TTwW/716yO5GvIxqy9aw8nwfP80Vu0ru/
	quRdnKuBe5j5vrkJhLuptrgx3axvVlBN4NpZERqvaJ4ikToHOLgIQnLZoEXE2qHi
	1n03gGpUAzSc6RN6aFcEgSrMH3WTTIJ4dB5lHiuoj7WKbGys9AXyWgKyHa7WMS2s
	X0y4vA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b4r2ecfhn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Sat, 20 Dec 2025 01:17:11 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4ed82af96faso45534571cf.1
        for <stable@vger.kernel.org>; Fri, 19 Dec 2025 17:17:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766193431; x=1766798231; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IQVWVrHY06xpDTJeqnmla272fk+k3T3T7nR1IYSIQ+A=;
        b=eLedfgJDrCtf85m4QP5EL8P7Q88DrvggWROpLIaAGQt/HUo/v/53FN2+0NKjgK07jG
         zE/FdUdAMfD+IMJWpyCL8JdEWmau0yjOjenYcx7vUnx0omPJUn5Vryy53Ey5eTI4RbGG
         K4R844j0nEv+MMNg9bxkpXZ5dsHgNHA3wzD258IuUNBtjd/c0oNIR5J9+QoAs6BhwJ8s
         E3id+l0bpmcW3ldvJipOXKZ8cID4sDDtG0CTIubgDdUfPCKbnPBIbv7ZHWAAlZjXYkFJ
         ksoo9JAMuIKXPOFNm4RGShZKq1cGZnSKWXjOYDvKqNpFDGrqWlJ6jYsmy/Dpw2gyfjcm
         mGfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766193431; x=1766798231;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IQVWVrHY06xpDTJeqnmla272fk+k3T3T7nR1IYSIQ+A=;
        b=JjzsLkcOt23/dzjzKaghoJLLcV/78fWSNxy1cnVgxHRQTC3SuEfkGtDm5lncQr1dxh
         PMivs3NhbWg2Tj89QrGevwLHTaSZCzqvBmz9FBKgLBJbwmH3jM12UbDZHAH3Nwsz6I7I
         jZYu7LJ33JcJZtSPoZ7t1s70gWLG5OipfVe7u5dSz4yM+6GSPhjiNCRJXqKNxRjn9XEr
         1W3mbjW8dQ1uzKywKlgGHuCF+oOFsWhQLkXZTaABJJI9RNQQse47ihkl9YdEMBLiASv7
         HwzSYnzYIGAsOJAsgGTRfy+CBwyZDEsPVpYWlfh+3fHo6+N7UVfnr9Le7HXMShmVm+2Y
         ZKqA==
X-Forwarded-Encrypted: i=1; AJvYcCVwgOzGsthDz7jQJbhPgY9JS5kopS6/DbKRz3SELhDLql5iwWmAm3TXPO91tM/GNixbQS/vS/8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdwHJ0DMQFWRudLG1+yMvGRGppUOzQR6PxtGoXr4RFHe46IAGO
	8Pjrum4KPK3Nli9vx0GRbgiZUgnHo3eT+DH64ugl9nhhHj3NwkuoeKM0rVTloq4rfNjF8bErRru
	ivKXEfj/Jch3MD4/c2lnFik2jGfbDwIaM2xYVZwbec37xPm2ffO6/uIqKgvM=
X-Gm-Gg: AY/fxX4AW4uOJDAZN70/Yszj4H0bncWYeCuO4XLyb/b9O9ekC+xi8zWKpLw8SFaP+IY
	kKoLSAsMmtjOEHnGbYh5vTbL9/n6GLyrLkQ5F05Riz3yu1p9Sun1QbBzMTkBxYasw7DzkgUJ/J5
	1WBsNBNhui0TlBl2Cslm6af8yL+IZfms8PbisbXOs/SgXlC5pHMW++V/7gYOnWI2/4Wsl6uXJ53
	P3e+7ylkX6UoO8gRisOrtUEhqliNSuei80gqJLT0fCnkHEMzSSItcCqj40Sb1ECLPIoVJeEiYon
	RpK5in76VZ5Cf9LkWGyb6ITIIqIX0Qn+rrbl6MjkeBn0U5a+DPmgV8uuzpQctqPNUarsx9IEKdc
	okUKprSTj4TnWOxzdVMWkas/tXliJwhGii2ihyMaQFC6zzA7JN3Sg1+Zvvc2SJC/p7FYqMKmEf+
	6yEYHEQwttb36uu8CPKPjYmy8=
X-Received: by 2002:a05:622a:1aaa:b0:4ee:1227:479a with SMTP id d75a77b69052e-4f4abdd1c34mr68412461cf.84.1766193431292;
        Fri, 19 Dec 2025 17:17:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGNyb2GSLwsAw/pta9mYsYp5q9qFNHtpu2mBuIG6LjDM9jgAmqavK8BCblWkeR+YYk0Gz8yig==
X-Received: by 2002:a05:622a:1aaa:b0:4ee:1227:479a with SMTP id d75a77b69052e-4f4abdd1c34mr68412201cf.84.1766193430807;
        Fri, 19 Dec 2025 17:17:10 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59a1861ffffsm1102998e87.81.2025.12.19.17.17.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Dec 2025 17:17:08 -0800 (PST)
Date: Sat, 20 Dec 2025 03:17:06 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Christopher Obbard <christopher.obbard@linaro.org>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] Revert "clk: qcom: cpu-8996: simplify the
 cpu_clk_notifier_cb"
Message-ID: <jhdl6aqh7cbb4t6uqhafxcgn4efxn3tzqo7haivle6olkpmvxf@yafk363lady4>
References: <20251202-wip-obbardc-qcom-msm8096-clk-cpu-fix-downclock-v1-1-90208427e6b1@linaro.org>
 <8d769fb3-cd2a-492c-8aa3-064ebbc5eee4@oss.qualcomm.com>
 <CACr-zFD_Nd=r1Giu2A0h9GHgh-GYPbT1PrwBq7n7JN2AWkXMrw@mail.gmail.com>
 <CACr-zFA=4_wye-uf3NP6bOGTnV7_Cz3-S3eM_TYrg=HDShbkKg@mail.gmail.com>
 <f902ebd4-4b4a-47c3-afd7-2018facdaad6@oss.qualcomm.com>
 <e2eg3zk2sc7pzzlybf6wlauw7fsks3oe6jy3wvbxkgicbo3s2g@tks2pgigtbza>
 <5e255831-3e84-4f3f-8b4f-c66d05e6be09@oss.qualcomm.com>
 <CAO9ioeVBk0CLGcdUdbixVGwGfheOaVwX=i39JovHa740mO4kRg@mail.gmail.com>
 <CACr-zFA0vkn_a=a1LNn_rqrSsKPUsuf+jt8_a3MsHg8Ao30qOg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACr-zFA0vkn_a=a1LNn_rqrSsKPUsuf+jt8_a3MsHg8Ao30qOg@mail.gmail.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjIwMDAwOCBTYWx0ZWRfX/W4ZJeKykmps
 XELz9ZhZx2TKx7zh5wI4hYQebuQ1qDJwsiBI6il2P45G2CtpCRGgmJUTMjUZTyqgZjKuV0e7s/z
 C3Crgc55l2Y/MvQVO61JtEh/A7JygHYg312qaBYP72BjQDC4Ks4p3fE/u7RiHHG0SCs5WxpAuwb
 vYEgXWQK8HW9KhV41EYgLLtFRsqCVJgungC+sj5lOAzJ96+ch15IOV4MD3w65t6iGSP6O+kpNNy
 mYxmz32EFVcocACohjYvnytBXL1FvVk+p/YrmYJTEH+tx0F/jdo7/Kb1XdjjRnLMIxXHVezCkHP
 F33rSxisREhbMokGcr7fH4EotahFjr+tJHpUMkoL5e1wGLLOzhrJq5CdIOuhIdwvAP5V+H3vktA
 8ymIRM13aqSgst4VI1ozI5eP5DkYN2jEZTKUIxKKBy43rmQS+njPyEXlZbe4m340BCJeSxUYiVW
 QSMjx6YoOsmmGsnv5gw==
X-Authority-Analysis: v=2.4 cv=W+c1lBWk c=1 sm=1 tr=0 ts=6945f917 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=cfdu8vdO5y-rE6AAjPwA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: St4nzMz5S7FQ0tektRyPHgb0pihXCVMr
X-Proofpoint-GUID: St4nzMz5S7FQ0tektRyPHgb0pihXCVMr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-19_08,2025-12-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 suspectscore=0
 clxscore=1015 bulkscore=0 impostorscore=0 spamscore=0 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2512200008

On Fri, Dec 19, 2025 at 08:50:58PM +0000, Christopher Obbard wrote:
> Hi Dmitry, Konrad,
> 
> On Thu, 18 Dec 2025 at 13:33, Dmitry Baryshkov
> <dmitry.baryshkov@oss.qualcomm.com> wrote:
> >
> > On Thu, 18 Dec 2025 at 15:09, Konrad Dybcio
> > <konrad.dybcio@oss.qualcomm.com> wrote:
> > >
> > > On 12/17/25 5:39 PM, Dmitry Baryshkov wrote:
> > > > On Wed, Dec 17, 2025 at 01:22:59PM +0100, Konrad Dybcio wrote:
> > > >> On 12/14/25 8:26 PM, Christopher Obbard wrote:
> > > >>> Hi Konrad,
> > > >>>
> > > >>> On Mon, 8 Dec 2025 at 22:36, Christopher Obbard
> > > >>> <christopher.obbard@linaro.org> wrote:
> > > >>>> Apologies for the late response, I was in the process of setting some
> > > >>>> more msm8096 boards up again in my new workspace to test this
> > > >>>> properly.
> > > >>>>
> > > >>>>
> > > >>>>> It may be that your board really has a MSM/APQ8x96*SG* which is another
> > > >>>>> name for the PRO SKU, which happens to have a 2 times wider divider, try
> > > >>>>>
> > > >>>>> `cat /sys/bus/soc/devices/soc0/soc_id`
> > > >>>>
> > > >>>> I read the soc_id from both of the msm8096 boards I have:
> > > >>>>
> > > >>>> Open-Q™ 820 µSOM Development Kit (APQ8096)
> > > >>>> ```
> > > >>>> $ cat /sys/bus/soc/devices/soc0/soc_id
> > > >>>> 291
> > > >>>> ```
> > > >>>> (FWIW this board is not in mainline yet; but boots with a DT similar
> > > >>>> enough to the db820c. I have a patch in my upstream backlog enabling
> > > >>>> that board; watch this space)
> > > >>>>
> > > >>>> DragonBoard™ 820c (APQ8096)
> > > >>>> ```
> > > >>>> $ cat /sys/bus/soc/devices/soc0/soc_id
> > > >>>> 291
> > > >>>> ```
> > > >>>
> > > >>> Sorry to nag, but are you able to look into this soc_id and see if
> > > >>> it's the PRO SKU ?
> > > >>
> > > >> No, it's the "normal" one
> > > >>
> > > >> Maybe Dmitry would know a little more what's going on
> > > >
> > > > Unfortunately, no.
> > > >
> > > > Maybe, the best option would be to really land the revert.
> > > >
> > > >
> > > > Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> > >
> > > Is there a chance that this removal:
> > >
> > > -       case POST_RATE_CHANGE:
> > > -               if (cnd->new_rate < DIV_2_THRESHOLD)
> > > -                       ret = clk_cpu_8996_pmux_set_parent(&cpuclk->clkr.hw,
> > > -                                                          SMUX_INDEX);
> > > -               else
> > > -                       ret = clk_cpu_8996_pmux_set_parent(&cpuclk->clkr.hw,
> > > -                                                          ACD_INDEX);
> > >
> > > could have been the cause?
> > >
> > > On one hand, we're removing this explicit "set ACD as parent" path, but
> > > OTOH determine_rate should have taken care of this..
> >
> > My idea was that we switch to SMUX temporarily, then CLK framework
> > fixes that for us while performing the actual reparenting.
> >
> > Christopher, as a quick check, could possibly revert just this chunk?
> 
> Do you mean something like this diff? I thought I'd ask and confirm
> first, to be really sure.
> This leaves the handlers present for the other two events
> (PRE_RATE_CHANGE and ABORT_RATE_CHANGE).
> I didn't bother checking the calls to clk_cpu_8996_pmux_set_parent for
> errors as it's just a quick hack.
> If you think this diff is good for a test, I will check it in the next few days.

Yes, something like this.

> 
> diff --git a/drivers/clk/qcom/clk-cpu-8996.c b/drivers/clk/qcom/clk-cpu-8996.c
> index 21d13c0841ed0..5d7f42a86a923 100644
> --- a/drivers/clk/qcom/clk-cpu-8996.c
> +++ b/drivers/clk/qcom/clk-cpu-8996.c
> @@ -565,6 +565,14 @@ static int cpu_clk_notifier_cb(struct
> notifier_block *nb, unsigned long event,
>                         clk_cpu_8996_pmux_set_parent(&cpuclk->clkr.hw,
> SMUX_INDEX);
> 
>                 break;
> +       case POST_RATE_CHANGE:
> +               if (cnd->new_rate < DIV_2_THRESHOLD)
> +                        clk_cpu_8996_pmux_set_parent(&cpuclk->clkr.hw,
> +                                                          SMUX_INDEX);
> +               else
> +                       clk_cpu_8996_pmux_set_parent(&cpuclk->clkr.hw,
> +                                                          ACD_INDEX);
> +               break;
>         case ABORT_RATE_CHANGE:
>                 /* Revert manual change */
>                 if (cnd->new_rate < DIV_2_THRESHOLD &&
> 
> 
> Cheers!
> 
> Christopher Obbard

-- 
With best wishes
Dmitry

