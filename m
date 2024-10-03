Return-Path: <stable+bounces-80687-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67AF898F88F
	for <lists+stable@lfdr.de>; Thu,  3 Oct 2024 23:08:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E02191F226F9
	for <lists+stable@lfdr.de>; Thu,  3 Oct 2024 21:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 282CE1C232D;
	Thu,  3 Oct 2024 21:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lKqt2VKt"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A3B1C1ADE
	for <stable@vger.kernel.org>; Thu,  3 Oct 2024 21:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727989562; cv=none; b=tJPFNo/hDb/nLO6nuxhna27zGQYOXO6w+uLHirev3C5S764fu7JrRf1Owo2/EjsKlf4BH1iWNdGG2cm+0vl7uZOBIAWnnoeDRay8tY91MxBaLGDdbWcXHibd/YVrYffxwMFA48JSPg8TWQMNBz3HdOLJZZv0ZfovxzCOivdmrnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727989562; c=relaxed/simple;
	bh=DjjcLb0zldRjw3VlI1nsDssX0csRwTyctgRrUyMIskE=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=klRSh/DXzzuAN1Dfu3R1Hsdq05YFhLnhTvkLl7fOS9Sq3DeCBN94nW2wxy9xC2fda2fqj45kedmT64NJhv9KMUWg+dMyHRK1maZ2xs6oDV0Ev2PbkTt1h8C65KmN+/vDgLc8/q30P8WRX/VbHj212S3KMuPV1Htg2hoVDTSHgCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lKqt2VKt; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a8d0d0aea3cso193411266b.3
        for <stable@vger.kernel.org>; Thu, 03 Oct 2024 14:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727989560; x=1728594360; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8syhsHxRK4yyfAod4n4jN48GcJ5d5jKRHHTAes7XE6k=;
        b=lKqt2VKtdD7kWcamJ+viEocTIJkVVhC71SGvOMqII3RQ0Ka+oM5aknwwm89rVoJd6A
         Nhr7uNRTFDePQMuZwhHC4L2Y5ntIu1PyVJ8vxJIB4a4PY4XAeuW8fKOlKH3h8ZzNV55v
         dev3J/oAtIh1zB0pVm3f3TGclmvk0qaCAff5tsuACd9i8Yat/elQflb8jBfhPp4+hJwK
         tcacQEO+HHhzlECsEzBtuE/fM/TjVfCIzWLQdsYKoSA8XIAxQL87rT4w7B91vjPQ+igk
         4EabEdbEAxRpc4Ykf8eOsRpLtU4y/6ZuSzbpD7UyKIC1Va/InygxcWtbeWeny3IXIcuN
         c4iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727989560; x=1728594360;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8syhsHxRK4yyfAod4n4jN48GcJ5d5jKRHHTAes7XE6k=;
        b=RF43TrHF7oJeQssRlCT2UAy2LaIgdeSCwE6NoMf6GVJo9vaDkw+SM1KFa5oAzaAtoY
         WuZOgLWWeQqsoq4NNLySxOoMsSvW0WwQVwPR0o6bHCvqdGx3Gpo1y2Q7H9mnEmfPm/82
         2S2i6FHkTWzbBxwYq9/VwI8zxbhGps8V1yBELZRlaYEJnR5Um3p9M6nGKi2c0BzmJIwR
         co9oFfSrhyTueta/0o/dYjdWGaMQAhaxz3iskAkUuFmp7w5NUZ4DuaqeANEyZiYSduyu
         1a7kBGmcKuCOzpfYgiKFp/0BjS/R/B+TYYKBsbKnh56rB2vIUbxFCRDyhV3x/gp6FLKd
         IUag==
X-Gm-Message-State: AOJu0Yx8eIihCCM5Eu6G4SB3uUKbWpLjDYclcW4E5lQLiBjttE6vRj43
	/PVFFCnzSUB+zomduoHytNc/gPepQorxe/dQ1RIufGKb9zpJliGtbWmuONPOI4s=
X-Google-Smtp-Source: AGHT+IF8SP7YMciB5jdn3uzWyp2F/BxhL0ga8DmoKHlGXXKrPUpcT1e/351YeAk6qB4g2x0fbw1hMg==
X-Received: by 2002:a17:907:e61d:b0:a8d:510b:4f48 with SMTP id a640c23a62f3a-a991bd0d019mr57152166b.22.1727989559652;
        Thu, 03 Oct 2024 14:05:59 -0700 (PDT)
Received: from [127.0.0.1] ([85.106.96.107])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99102a625asm131713066b.87.2024.10.03.14.05.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Oct 2024 14:05:58 -0700 (PDT)
Date: Fri, 04 Oct 2024 00:05:55 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Sumit Semwal <sumit.semwal@linaro.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: stable@vger.kernel.org, patches@lists.linux.dev,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_6=2E1_033/440=5D_arm64=3A_dts=3A_qcom=3A_sm82?=
 =?US-ASCII?Q?50=3A_switch_UFS_QMP_PHY_to_new_style_of_bindings?=
User-Agent: K-9 Mail for Android
In-Reply-To: <CAO_48GE-bQ2ZcdXNKsRS6U+4+opkXi0osSEodMUdW+fo0jNACw@mail.gmail.com>
References: <20240730151615.753688326@linuxfoundation.org> <20240730151617.057892121@linuxfoundation.org> <CAO_48GGH0J9z3NCq=jH5PKQewPdrhUiNk-Bu9yKvX8yhsTWDtQ@mail.gmail.com> <F1136AC5-0860-4070-B4FA-86BAEFC070FB@linaro.org> <2024100238-margarine-strongbox-d096@gregkh> <CAO_48GE-bQ2ZcdXNKsRS6U+4+opkXi0osSEodMUdW+fo0jNACw@mail.gmail.com>
Message-ID: <C7E275C7-77D7-492D-9699-FC5B9D32C339@linaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On October 3, 2024 5:51:07 PM GMT+03:00, Sumit Semwal <sumit=2Esemwal@linar=
o=2Eorg> wrote:
>On Wed, 2 Oct 2024 at 15:21, Greg Kroah-Hartman
><gregkh@linuxfoundation=2Eorg> wrote:
>>
>> On Tue, Oct 01, 2024 at 09:01:09PM +0300, Dmitry Baryshkov wrote:
>> > On October 1, 2024 8:27:55 PM GMT+03:00, Sumit Semwal <sumit=2Esemwal=
@linaro=2Eorg> wrote:
>> > >Hello Greg,
>> > >
>> > >On Tue, 30 Jul 2024 at 21:25, Greg Kroah-Hartman
>> > ><gregkh@linuxfoundation=2Eorg> wrote:
>> > >>
>> > >> 6=2E1-stable review patch=2E  If anyone has any objections, please=
 let me know=2E
>> > >>
>> > >> ------------------
>> > >>
>> > >> From: Dmitry Baryshkov <dmitry=2Ebaryshkov@linaro=2Eorg>
>> > >>
>> > >> [ Upstream commit ba865bdcc688932980b8e5ec2154eaa33cd4a981 ]
>> > >>
>> > >> Change the UFS QMP PHY to use newer style of QMP PHY bindings (sin=
gle
>> > >> resource region, no per-PHY subnodes)=2E
>> > >
>> > >This patch breaks UFS on RB5 - it got caught on the merge with
>> > >android14-6=2E1-lts=2E
>> > >
>> > >Could we please revert it? [Also on 5=2E15=2E165+ kernels]=2E
>> >
>> > Not just this one=2E All "UFS newer style is bindings" must be revert=
ed from these kernels=2E
>>
>> How many got backported?
>So far, only this one=2E

Just to note, [1] also needs to be reverted=2E=20
I'm currently OoO, could you please also handle it?

[1] https://git=2Ekernel=2Eorg/pub/scm/linux/kernel/git/stable/linux=2Egit=
/commit/arch/arm64/boot/dts/qcom?h=3Dlinux-6=2E1=2Ey&id=3D86225a63467a07047=
487f37c877277af20a9bf85

> I've sent a revert patch - if you could please
>apply it to both 6=2E1 and 5=2E15 LTS branches!
>>
>> thanks,
>>
>> greg k-h
>
>Best,
>Sumit=2E


--=20
With best wishes
Dmitry

