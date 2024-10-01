Return-Path: <stable+bounces-78579-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ADAB398C4FB
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 20:01:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A4371F23CEE
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 18:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36B7D1CC146;
	Tue,  1 Oct 2024 18:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lIxuHDCz"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361A91B3725
	for <stable@vger.kernel.org>; Tue,  1 Oct 2024 18:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727805678; cv=none; b=Y1WTxM8FotsoqOiHK39bMz6Dd92djbo0jUe1iLKhldvUfjFwrkPUQY9ZPULsMTOl0RzcqX14XcGXZfczY8AlfpDweC48c3qIDmPksk8ktAIj6R4dTxqI6LCZTiFWDlC5Z85seDFfp/4u5gaKUGCvtP8gtMu+o0oJK+40BkLNYnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727805678; c=relaxed/simple;
	bh=9opfw5OJisVf3HyMd+OR4HHKd7kdf6Gf9d54RuKdt0k=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=jmx8/QP5MOUC8DQ7Op4YlGkdQGMTeaZUQQj/N1aCEWh6aOqyJcQDEYT4zH6Pq2LM2gLVFx1U8TzN1xtJBehG7SyYYZW5gTZZwSRLIeck8iDZRMNVbk6ZG9tbvV1+4MAjKxP/G5NscB3Bpgz6eJev2FFtZ7kSdGtb977E3DzcN1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lIxuHDCz; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5c87ab540b3so99125a12.1
        for <stable@vger.kernel.org>; Tue, 01 Oct 2024 11:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727805674; x=1728410474; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jptlZ50vNnkPMBXPAhGWdUP4XKEwnHdYTuJjE+Q5IPM=;
        b=lIxuHDCzlFUZqYGAAidMwitvHUzvUIZYoX5DhakpIiB/2Ksk+7dUPj6ewKvzIgctw2
         1rY1y40m1rWwaWxbB2f6Zl6eRXm+Tk6HnHvyhWi3B40xR8B4rTH4WGrfoWjPYgDD15iP
         CT/grV8gYbAVqUwRKCyLr3hSGp+flQE8+mToC2iSnzyXxrE228EX88CA2nIr2e53Li9K
         hir76ebOlVneRhKmT96DQB4ztegZ8DerdqamfMAvZtgnLV3AYlRvb+zp3evU2S8Ih22i
         kFfNKT4pMxY0cmzqxN/kX6JvWhiwX09DlzRUvO3EkCPLfrvgS9dDWoL3hhInbzgfmv7r
         z11A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727805674; x=1728410474;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jptlZ50vNnkPMBXPAhGWdUP4XKEwnHdYTuJjE+Q5IPM=;
        b=kxOljWIwVeCjias5dFeiy76tIROM1kBjwXApMu6Mxnh1VpMoJfH5pfRHWNLNlkhuuo
         PaoD3CpYD6SfgzQ7OArpLEByLGCFugNbk+5XJn6Y8fxETq62HzLlXShGcmZ7LFsTTAzA
         ivxkqwf9/m44E4zwIcafjsia26YgJxslYN7dUJ/AUQq5ilJLABFUbYw0WjGOV7gdYwCQ
         I9jDpqVpvCkmoNH1FwcjulxnG4PHA/cI9oDooA7h0Z6agunmtqeDl472mkgg0wGQRaul
         ZEgYGIzVJQOl3+Y4s9z8wqXYnqyDypfZf1lnXhi2JIUcY5ffUX86rQ+7tGNxLdUqhMde
         klTA==
X-Gm-Message-State: AOJu0YyYg3Dv9c2Hba628eb/Wcp6xMmulx+q7ZcUp7jwzc8XgnRd0/5b
	z8wq3dXqvtVwtpDXcEe/t+iv2XPDML9iHx6Oj8F11g4w9ZXooH+L6T10fgCWdFM=
X-Google-Smtp-Source: AGHT+IGCr+0ApwlkapkpKYOKNPQiSoHfsxeAKoCUk5AOKVznJjFx8qEFLq+28yh+N27Q7W7VO79Cpw==
X-Received: by 2002:a17:907:f1df:b0:a86:9fac:6939 with SMTP id a640c23a62f3a-a98f8387b16mr45918466b.30.1727805674417;
        Tue, 01 Oct 2024 11:01:14 -0700 (PDT)
Received: from [127.0.0.1] ([37.155.79.147])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c27cafc8sm745435966b.84.2024.10.01.11.01.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Oct 2024 11:01:13 -0700 (PDT)
Date: Tue, 01 Oct 2024 21:01:09 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Sumit Semwal <sumit.semwal@linaro.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: stable@vger.kernel.org, patches@lists.linux.dev,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_6=2E1_033/440=5D_arm64=3A_dts=3A_qcom=3A_sm82?=
 =?US-ASCII?Q?50=3A_switch_UFS_QMP_PHY_to_new_style_of_bindings?=
User-Agent: K-9 Mail for Android
In-Reply-To: <CAO_48GGH0J9z3NCq=jH5PKQewPdrhUiNk-Bu9yKvX8yhsTWDtQ@mail.gmail.com>
References: <20240730151615.753688326@linuxfoundation.org> <20240730151617.057892121@linuxfoundation.org> <CAO_48GGH0J9z3NCq=jH5PKQewPdrhUiNk-Bu9yKvX8yhsTWDtQ@mail.gmail.com>
Message-ID: <F1136AC5-0860-4070-B4FA-86BAEFC070FB@linaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On October 1, 2024 8:27:55 PM GMT+03:00, Sumit Semwal <sumit=2Esemwal@linar=
o=2Eorg> wrote:
>Hello Greg,
>
>On Tue, 30 Jul 2024 at 21:25, Greg Kroah-Hartman
><gregkh@linuxfoundation=2Eorg> wrote:
>>
>> 6=2E1-stable review patch=2E  If anyone has any objections, please let =
me know=2E
>>
>> ------------------
>>
>> From: Dmitry Baryshkov <dmitry=2Ebaryshkov@linaro=2Eorg>
>>
>> [ Upstream commit ba865bdcc688932980b8e5ec2154eaa33cd4a981 ]
>>
>> Change the UFS QMP PHY to use newer style of QMP PHY bindings (single
>> resource region, no per-PHY subnodes)=2E
>
>This patch breaks UFS on RB5 - it got caught on the merge with
>android14-6=2E1-lts=2E
>
>Could we please revert it? [Also on 5=2E15=2E165+ kernels]=2E

Not just this one=2E All "UFS newer style is bindings" must be reverted fr=
om these kernels=2E


>>
>> Reviewed-by: Konrad Dybcio <konrad=2Edybcio@linaro=2Eorg>
>> Signed-off-by: Dmitry Baryshkov <dmitry=2Ebaryshkov@linaro=2Eorg>
>> Link: https://lore=2Ekernel=2Eorg/r/20231205032552=2E1583336-8-dmitry=
=2Ebaryshkov@linaro=2Eorg
>> Signed-off-by: Bjorn Andersson <andersson@kernel=2Eorg>
>> Stable-dep-of: 154ed5ea328d ("arm64: dts: qcom: sm8250: add power-domai=
n to UFS PHY")
>> Signed-off-by: Sasha Levin <sashal@kernel=2Eorg>
>> ---
>>  arch/arm64/boot/dts/qcom/sm8250=2Edtsi | 20 ++++++--------------
>>  1 file changed, 6 insertions(+), 14 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sm8250=2Edtsi b/arch/arm64/boot/d=
ts/qcom/sm8250=2Edtsi
>> index 3d02adbc0b62f=2E=2E194fb00051d66 100644
>> --- a/arch/arm64/boot/dts/qcom/sm8250=2Edtsi
>> +++ b/arch/arm64/boot/dts/qcom/sm8250=2Edtsi
>> @@ -2125,7 +2125,7 @@ ufs_mem_hc: ufshc@1d84000 {
>>                                      "jedec,ufs-2=2E0";
>>                         reg =3D <0 0x01d84000 0 0x3000>;
>>                         interrupts =3D <GIC_SPI 265 IRQ_TYPE_LEVEL_HIGH=
>;
>> -                       phys =3D <&ufs_mem_phy_lanes>;
>> +                       phys =3D <&ufs_mem_phy>;
>>                         phy-names =3D "ufsphy";
>>                         lanes-per-direction =3D <2>;
>>                         #reset-cells =3D <1>;
>> @@ -2169,10 +2169,8 @@ ufs_mem_hc: ufshc@1d84000 {
>>
>>                 ufs_mem_phy: phy@1d87000 {
>>                         compatible =3D "qcom,sm8250-qmp-ufs-phy";
>> -                       reg =3D <0 0x01d87000 0 0x1c0>;
>> -                       #address-cells =3D <2>;
>> -                       #size-cells =3D <2>;
>> -                       ranges;
>> +                       reg =3D <0 0x01d87000 0 0x1000>;
>> +
>>                         clock-names =3D "ref",
>>                                       "ref_aux";
>>                         clocks =3D <&rpmhcc RPMH_CXO_CLK>,
>> @@ -2180,16 +2178,10 @@ ufs_mem_phy: phy@1d87000 {
>>
>>                         resets =3D <&ufs_mem_hc 0>;
>>                         reset-names =3D "ufsphy";
>> -                       status =3D "disabled";
>>
>> -                       ufs_mem_phy_lanes: phy@1d87400 {
>> -                               reg =3D <0 0x01d87400 0 0x16c>,
>> -                                     <0 0x01d87600 0 0x200>,
>> -                                     <0 0x01d87c00 0 0x200>,
>> -                                     <0 0x01d87800 0 0x16c>,
>> -                                     <0 0x01d87a00 0 0x200>;
>> -                               #phy-cells =3D <0>;
>> -                       };
>> +                       #phy-cells =3D <0>;
>> +
>> +                       status =3D "disabled";
>>                 };
>>
>>                 ipa_virt: interconnect@1e00000 {
>> --
>> 2=2E43=2E0
>>
>>
>>
>>
>
>Best,
>Sumit=2E


--=20
With best wishes
Dmitry

