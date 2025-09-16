Return-Path: <stable+bounces-179706-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FD3CB591BE
	for <lists+stable@lfdr.de>; Tue, 16 Sep 2025 11:08:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 514812A5010
	for <lists+stable@lfdr.de>; Tue, 16 Sep 2025 09:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F1D928DB46;
	Tue, 16 Sep 2025 09:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="FT/W+ex6"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2B9288C81
	for <stable@vger.kernel.org>; Tue, 16 Sep 2025 09:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758013676; cv=none; b=T3iQNCB3d4fzea5bd3jvRnFl1XvPUro3MPUMukr0+//rUhvR1cgL8U1rI2VbDKLWTSzAHkM9Lrk6uSZjk4LIHG1zeeJFhDQXEbEE9Fn+h1bWTIsZ2pOYIM7IIbCMNoEDWGdkPxE8YygOdXMhSgLvLWSbLL4iWUOdwGYSWlPlgRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758013676; c=relaxed/simple;
	bh=fM1QW+UFz5zHOwXNyLvYeTnh6QmXecM50gjhKcitTM4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=a680wZhikH3Dx8xRLAMmYYqpZDMYiLqUDd8RAUDYu+7jLgFezia9W5Qjbcfrfv9wtEmappFMzahzgudS6jqUbD1i4VPN36yi3UrwLrb3tlnB0McQwzZEKYINH8wWUAVJq+tFAxqkaAK8eT7ReED+JI+QlSn8ZOJb/oa8tR5G9gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=FT/W+ex6; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b0418f6fc27so878005766b.3
        for <stable@vger.kernel.org>; Tue, 16 Sep 2025 02:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1758013673; x=1758618473; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wGPJfwEdnpfBh17k0uP4IdtgceOjAvM9dH/m5dD76YA=;
        b=FT/W+ex663OkQapBdsdZfiqLbYPbkbzVnog3Xs3mpz4Xgconp9x/dpGRHaPDtPNLW9
         ixh2cYtm4JWK60nHEFL7C90FMizD4O9NDpm0XgjKKbAKa6MQGVYIZKXtIyVNXEvXdPll
         xO78MacI3EikAFs5oCbgOJss/QVWcWRQP37/48n+Z1+GtSUaCGDnsrnrlVrWG8si7O1r
         94TOul6Ohbll7vJbAvAdeUmX/1lwebJ6Um7OcSVt28412nyHT+Czd6S3q0zXW3S+rlON
         zm0+nbxhnU6V+vNzOee64mcGan0mFlRda++wgZ4vaBj70pcHlZQrlVQPf/U9b0edpf2T
         khMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758013673; x=1758618473;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wGPJfwEdnpfBh17k0uP4IdtgceOjAvM9dH/m5dD76YA=;
        b=VpzG8qvyUv456k6yX4bryH6ZcG+FumRRMHWzeIWqX43o3xG/T/hnnJrjU2COkTCrZa
         DEtGmPnYHD2kcM3I6VS7Hp8+795tD71ApVyzV/xGZQkLziZH/NqDxYPb2/b3jRvyP/LW
         8sly61x37ivG24QdzLkYEYOqV6HMOTxixZQV43VB+KLPKc72QhSergdyqRTTT1bC8zr6
         OFyIq0s+MGZO9jRfp8GDGdqUihsPc9k1RYOtuDKN/Wf5mXyOvhnddRNG0ACLvDapjRaj
         6pG6bDAmHdHx7mvjjcTTDcIH2RlZNVY3i0E8RKLXmJNFk3aaUWJfA2Re4wScOK914+ti
         iG8w==
X-Forwarded-Encrypted: i=1; AJvYcCV/BnAT/ATaX3etqEZ5RSisEiYxq+/DHMD0aD4uQQ6Zg3b8nznOsMMvtf19GENFpZUl2ng79Hk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzvJL9oHv1sZ9kVX8wGf4t13hhAxs2jBmknuayYmI7gPfqCO1M
	mxR+w/p0GMhECv+LYJdjHgs7z5AaSYFnhIUAiRWhXWltLJiRXhs4abM8aZ7e1qwblfU=
X-Gm-Gg: ASbGncsIEFZ6xg096JZzVLirlZ4ddKfO8zFnAQsxbzVff1KzGPJBrMmM/Elkl0cUc5z
	jHvqQLzGEfPN26xFGz8fex7WkPanB/kpdY4zmyzeurAIj03W+Ef+wIZTyn1+J29fKs/4uSIOLmS
	UhyH2xAXokE6jStEv2i1WWEXm1Pps+X5TP/poAcW+gh5xEPU5jinBWUePUkAZcFvowSP9LIUdg9
	oAVd52Fi4Ed6sssGKVt68E/ap/DmMbVOc9zAxrxhO9oV/1kmhmBsuQKqHigE75yhYB7YEuaNMlK
	sdcqqlhuvDPim27jYQD/l14DXoA7kYcpQVlNjO9TQXcIG+vbpeS/2WlyvxBax8yjO+XcsyhnxML
	Vl/IwprZ/3I0y+JSO+571IU12y1x1zUmJKYXf6uo8AsjwjTb0sUc/KcKBtwFdpRt58PBk
X-Google-Smtp-Source: AGHT+IEnV71DLjZiRWk5j6jXx0pnqls19vN1Qen2T1tQxSI6t57/t1s9FzfJ1We13UaEvDdr4m6msw==
X-Received: by 2002:a17:906:6d13:b0:b09:c230:12dc with SMTP id a640c23a62f3a-b09c23013dbmr778396666b.8.1758013673277;
        Tue, 16 Sep 2025 02:07:53 -0700 (PDT)
Received: from localhost (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07c7159e6csm899506666b.33.2025.09.16.02.07.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Sep 2025 02:07:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 16 Sep 2025 11:07:52 +0200
Message-Id: <DCU3U3SF3ZRT.ATK17JG93309@fairphone.com>
Cc: <~postmarketos/upstreaming@lists.sr.ht>, <phone-devel@vger.kernel.org>,
 "Krzysztof Kozlowski" <krzk@kernel.org>, <linux-arm-msm@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <stable@vger.kernel.org>
Subject: Re: [PATCH 0/3] Fixes/improvements for SM6350 UFS
From: "Luca Weiss" <luca.weiss@fairphone.com>
To: "Luca Weiss" <luca.weiss@fairphone.com>, "Bjorn Andersson"
 <andersson@kernel.org>, "Konrad Dybcio" <konradybcio@kernel.org>, "Rob
 Herring" <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
 "Conor Dooley" <conor+dt@kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20250314-sm6350-ufs-things-v1-0-3600362cc52c@fairphone.com>
 <DBDAMGN9UQA0.J6KJJ48PLJ2L@fairphone.com>
In-Reply-To: <DBDAMGN9UQA0.J6KJJ48PLJ2L@fairphone.com>

Hi Bjorn,

On Wed Jul 16, 2025 at 9:15 AM CEST, Luca Weiss wrote:
> Hi Bjorn,
>
> On Fri Mar 14, 2025 at 10:17 AM CET, Luca Weiss wrote:
>> Fix the order of the freq-table-hz property, then convert to OPP tables
>> and add interconnect support for UFS for the SM6350 SoC.
>>
>> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
>> ---
>> Luca Weiss (3):
>>       arm64: dts: qcom: sm6350: Fix wrong order of freq-table-hz for UFS
>>       arm64: dts: qcom: sm6350: Add OPP table support to UFSHC
>>       arm64: dts: qcom: sm6350: Add interconnect support to UFS
>
> Could you please pick up this series? Konrad already gave his R-b a
> while ago.

Another ping on this series, haven't heard anything in the last 2 months
on this.

Regards
Luca

>
> Regards
> Luca
>
>>
>>  arch/arm64/boot/dts/qcom/sm6350.dtsi | 49 ++++++++++++++++++++++++++++-=
-------
>>  1 file changed, 39 insertions(+), 10 deletions(-)
>> ---
>> base-commit: eea255893718268e1ab852fb52f70c613d109b99
>> change-id: 20250314-sm6350-ufs-things-53c5de9fec5e
>>
>> Best regards,


