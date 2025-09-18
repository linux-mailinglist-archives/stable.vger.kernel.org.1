Return-Path: <stable+bounces-180488-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 41027B83274
	for <lists+stable@lfdr.de>; Thu, 18 Sep 2025 08:35:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CCADD7ABCF1
	for <lists+stable@lfdr.de>; Thu, 18 Sep 2025 06:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 867FC2D8DBD;
	Thu, 18 Sep 2025 06:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AdRlBb9B"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208B71E51E0
	for <stable@vger.kernel.org>; Thu, 18 Sep 2025 06:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758177298; cv=none; b=rC9BAc5Dm9nMJbiEWqk861igucsMVv2euvtvr9So21IvH9t/QJYktg/e6dvD7iSA9YjLhn589UUnoRBnlJyh2b7MsOGkw9CQItI6WK6b1tQcKWQ4Is2ywMLcC0r1YAKsytWyn2iezVfMJNC9hw0iajgOheb9VPIE5l00vXlbcvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758177298; c=relaxed/simple;
	bh=+0vSdZmOwq8F/9R/kI0phGtqmphJwJ5lflmVHUCDqVc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QjzspJ/7mclENujvFyZVQzcYkNb1j//4M5yDXn96e3T0GRUjODaBTprp/G/WJ20KlMBzXGemx+8IORZBAYRJGuGMKRgIWTJ0h/Enild8+UV2Wnc/r4w1uDkBdiZDmviPmjB4yZHWkUYODdsi+mpQ7WX+4Ckl4xAruXKZG/PG/Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AdRlBb9B; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58I3fxD0014401
	for <stable@vger.kernel.org>; Thu, 18 Sep 2025 06:34:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LJ+vHFzBs1wUhjHtKO42xRexrj+VJ9lROsx9KC1ozbQ=; b=AdRlBb9BSGouk+ms
	L2026v4vGXrH1CFsu+CRBdl0yTJfQLwpXnopG/j1TbCnmNx9FoZawSH+J6cE4WZk
	jjoZYjkYCRVWdzAmikYXDrpYNUrIRjsNWz78Cet2XOCpoEQ6xkMD6uF6760MhiGe
	eAtxIUwGNmg7z2BGflHcY0bHfDVntUpHJcK3gjkDbciuta1hqoK1wRIJSSjXJp1+
	anZewHoIa2YXlOk4oqPyo0vcrwm8dWGDcrTjJuOdVbXxbY/Y9X5aitKXqr+OQQW6
	gOSrS3VQFmPazpgzHAhP/JIYcBIXAIwsB07Qd1LKLac8xKq5ihOaDXfEkGsJWu4D
	BuEr9w==
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com [209.85.128.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 497fxu57xp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 18 Sep 2025 06:34:55 +0000 (GMT)
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-72e98443055so7954187b3.2
        for <stable@vger.kernel.org>; Wed, 17 Sep 2025 23:34:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758177294; x=1758782094;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LJ+vHFzBs1wUhjHtKO42xRexrj+VJ9lROsx9KC1ozbQ=;
        b=cdderU28QSeqz0KvqTWiD7REvyz80n6ysSqe4awOMiWn2O4Zw4zlk9AZ/636h7r9Cw
         TKpMe/SIcLjCKXJB3hghWi4HOUW3NwB/FwrY9Rwd5tKVIUJueaA3LbqQ7fqE/Gm0WWJQ
         Yi2sYirBVrhheNrziVJPAqeNo/32P7Fm52nVeFCpeiKLIhKNwimNC5M5O5at8wRabs3e
         YplNcUI6CPHEGD8YBQvLBmWCWmK2OZkgDmO6YqxNvHYofnb8LjTValhhuvchLvsD+iZM
         fBmBeTqf9X6PrQO2hTfhg2di4SKPnLheGA+Uf5kN1xwEGTNVL5Mt24Koqz1j85zxorQR
         avhQ==
X-Forwarded-Encrypted: i=1; AJvYcCXJ4MYAj/EikvxvFsIwEFgOxKG7EOmNyqrsVs+ZMeM7jThzusWUWekMvK00m3Q7e6KQSDQDeZw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJeQekiZ65I7LT2VXk921VIo6fHcTSpR2hpEJ9lKCQ/32M6Q4i
	0mVWiDpGcEfthCbDZCNlEunIR5FmxsLIzKVvstdKZOodmiiC0ePlrqPoP1c+3yWurXW5cg8jNb7
	2d63TQ5jkmFfB3tft2UtmS3joi0bdB0eJaCgtOC2udMOrvjSvqejGiyiv2+W/sE7FmRochrGuTv
	DIJajS5WKgFjGqIXBXWUI/9fSCdiBQOtYaUw==
X-Gm-Gg: ASbGncs5j7bcz0F8KIwjdXGxvQ/8l/I/H2Y7y8m4ZOV3p8ymPrrXURUstIqYRMO/iOf
	CN/NUhFeDmlM/K2EbxBGIgWD6Bk0MlbJkLm/SZspaI5TpX7Ff8kXqSKVLq9sdlCMhb2D0+9Gqnz
	xsCGpdRxq9lXn9tPmpZayku6Y=
X-Received: by 2002:a05:690c:87:b0:723:be18:e6de with SMTP id 00721157ae682-73891b87043mr37498807b3.29.1758177294173;
        Wed, 17 Sep 2025 23:34:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF359T+ynH7B0YBVHYdIUSznowf26uiydfg4Xsq82Eyh2GFZoEJFfVFBb/Vop9pNIb3aRomnhYSHj8mNK6v8TE=
X-Received: by 2002:a05:690c:87:b0:723:be18:e6de with SMTP id
 00721157ae682-73891b87043mr37498627b3.29.1758177293634; Wed, 17 Sep 2025
 23:34:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916093957.4058328-1-anup.kulkarni@oss.qualcomm.com> <2025091701-glamorous-financial-b649@gregkh>
In-Reply-To: <2025091701-glamorous-financial-b649@gregkh>
From: Anup Kulkarni <anup.kulkarni@oss.qualcomm.com>
Date: Thu, 18 Sep 2025 12:04:42 +0530
X-Gm-Features: AS18NWCwmtfeqFQcg9i-B4xEmvRecUhlo2PrXpNtE39W8_lbS3jp3t7HmtTXQys
Message-ID: <CAP0YdSqCD8MZPrj0ekDHG4LhoGm4s3qs_z0xubD5hQ=vBOv9_g@mail.gmail.com>
Subject: Re: [PATCH v1] tty: serial: qcom_geni_serial: Fix error handling for
 RS485 mode
To: Greg KH <gregkh@linuxfoundation.org>
Cc: jirislaby@kernel.org, johan+linaro@kernel.org, dianders@chromium.org,
        quic_ptalari@quicinc.com, bryan.odonoghue@linaro.org,
        quic_zongjian@quicinc.com, quic_jseerapu@quicinc.com,
        quic_vdadhani@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        mukesh.savaliya@oss.qualcomm.com, viken.dadhaniya@oss.qualcomm.com,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfX2LHvH2zfjb9g
 Ig40wlEn+rEMLVaLafwalW75xbIxr0iM8XSX4FLmwWDdaaakYRwP/1mjFwFhwQKeIXgu0O+Tadh
 Yxequ9AQFKKGRQpGC9FRS3sPTRqbXdXxVEMxeOfJ1CbOsxOj4PctLvjP7+hL+Xo2tcg9aCqm20V
 w93fs+w+YgDbgVp5RgjFkz4c+6Xesbd+/cxpwlHD1QcO+P8NHcX1SNyPtJSL1C6whabicGsa33C
 K46a1RWhoHP+tJRGRc9rfAvYB+gi40JyG45KGynmrYQy2U2bMcvwJlLbW2AMRn59M/+Y6n2+zrh
 6Vyege08IpDLKdzqHQGmB0AxGK0qjYMgVzzHgUxz0d6G5vTJ2ijMzNmZhVZcRJM0Pd4fQRmzLU9
 aMPuss2O
X-Proofpoint-ORIG-GUID: VkNPQLAndp_xCSi3ESBRHPHVSUFrXiWW
X-Authority-Analysis: v=2.4 cv=R+UDGcRX c=1 sm=1 tr=0 ts=68cba80f cx=c_pps
 a=g1v0Z557R90hA0UpD/5Yag==:117 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10
 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=ag1SF4gXAAAA:8 a=EUspDBNiAAAA:8
 a=oPvcWFQ82zTIPni4Ta8A:9 a=QEXdDO2ut3YA:10 a=MFSWADHSvvjO3QEy5MdX:22
 a=cvBusfyB2V15izCimMoJ:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-Proofpoint-GUID: VkNPQLAndp_xCSi3ESBRHPHVSUFrXiWW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-18_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 adultscore=0 clxscore=1015 priorityscore=1501
 bulkscore=0 malwarescore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509160202

On Wed, Sep 17, 2025 at 4:45=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Tue, Sep 16, 2025 at 03:09:57PM +0530, Anup Kulkarni wrote:
> > If uart_get_rs485() fails, the driver returns without detaching
> > the PM domain list.
> >
> > Fix the error handling path in uart_get_rs485_mode() to ensure the
> > PM domain list is detached before exiting.
> >
> > Fixes: 86fa39dd6fb7 ("serial: qcom-geni: Enable Serial on SA8255p Qualc=
omm platforms")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Anup Kulkarni <anup.kulkarni@oss.qualcomm.com>
> > ---
> >  drivers/tty/serial/qcom_geni_serial.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
>
> I've taken
> https://lore.kernel.org/r/20250917010437.129912-2-krzysztof.kozlowski@lin=
aro.org
> instead, so this shouldn't be needed anymore.
>
Agree. It's not required now.
> thanks,
>
> greg k-h

thanks,

Anup

