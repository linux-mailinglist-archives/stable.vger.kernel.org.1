Return-Path: <stable+bounces-46280-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB47D8CF9E2
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 09:21:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49118B20A8C
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 07:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E2061BDDF;
	Mon, 27 May 2024 07:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="PkjdCO2+"
X-Original-To: stable@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC94E2556F
	for <stable@vger.kernel.org>; Mon, 27 May 2024 07:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716794451; cv=none; b=AwrKDjitEWtB5P10VcDvlbrykEElL3m7Mizadfw4t8nhFgIZhPAEkG8CQss/U2TWWsa5ctFQm5SUVwbP4bTMjuMx5PR/9so0Kx5bRxy9BoEMzOBl7U+HMfgORu4m5qxEuko+hjNP2vtLYXk3fnJ7j7QtH0NlwctgHc6yhs7WMGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716794451; c=relaxed/simple;
	bh=J0CF/Zxx2OfDURCNT5Vg/Q1tEIrJciZjXwO7iuS8cqg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j/ky8lEgAWF6lDB2Kn9vhIaZehLcPJlcF0IIm4YnsuYbVUK+nPXxfjrQ1W3gbKRjWmn+zXl/JuNABQmFYPTXznEkeBD9nQ6fUkFy/fLfTKtWm8ijoT4mdQ93tK1BrEicAxIy5S2zIj/QJEHTdzCF9Bg1kiaq54bIIAYbA4AjfPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=PkjdCO2+; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id AC9C03F363
	for <stable@vger.kernel.org>; Mon, 27 May 2024 07:20:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1716794446;
	bh=J0CF/Zxx2OfDURCNT5Vg/Q1tEIrJciZjXwO7iuS8cqg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=PkjdCO2++3k9B/QGzG7oPgvj2tJy2EZryRX8nL4lv/PqFocZU6j5lyGGBpX+bRlc1
	 bcug8gilaodT0WXcWCcL+JDotB50OxzCoytvljqZ5bWgNflsjXuqopNLNoYfVPAjHi
	 q3VRDWvKbYdzn6C1o49imkq/lfBGx/GbOVUdUcXELz35E1y1ckGCurV69mBCo4AVxe
	 yhKSGhgEepx10r3LPF75b5l949mEMxV5kmjBybnq6umoGw+jD/JOlwNFwb97af85FF
	 Y3CnXLBL1x+2BS8Yg5ilQjHlGOf/mAyF9/yNSRgDDrU+mFWrE4JURNHvtLOQKXkGeL
	 byTwQDf2Dz5Rg==
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a629e32f5fdso69016366b.2
        for <stable@vger.kernel.org>; Mon, 27 May 2024 00:20:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716794446; x=1717399246;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J0CF/Zxx2OfDURCNT5Vg/Q1tEIrJciZjXwO7iuS8cqg=;
        b=SHV3BZtA4pRh7sbPxTtL5g1XaRDuXTBtlJ5srD6QhbVvt/ADmrsIgS1tTrGAWP5M1v
         3A+rAtHb7R+5RQCuXEuyuqsXcUKh2xICgbeDTrz1EMdRD6eAx+yrYj+mObNM4ClpQQPb
         R0sihtxRuwKYrCur49PdD9Yz9HFF16rO/Pt+lv2rZb86Y+rbwG1bHPBtzTdDyDeoUnQ4
         A4VxPkeD7elwKa2AJ7lFUGfBxpmSX25eJgXeAeQ7KfqlFNlE9KkMIcPMT0gyGURQ5mHP
         McPLO2iF7BDa32pnrE7bnLD9JsDXnuRafLCr/pcDUJVG4Cfn1AEVzNx5dSUvHfeVn/hg
         CJvg==
X-Gm-Message-State: AOJu0YxGdFppbArt2ZkfG/mOWX2bQAN23D+9G8OO9AxhQj2VdMVn+qBR
	uKaJhr+xQDdFvQ/XeSHowJB7V+uV7s1v1ElzAT3S8uwrDMRgtwklLAjSC02tyrDeh6mIrCNcjMb
	DEJRfCqriSdIg8X3JoB2lU6MEKOT4fPmZ4X5Iemr5n5OwHIyOZC7JClPYZD2wNz1g+tlNdqX11b
	yaDt01o7YkVzGBki3S3ZYa+flEEp6VM5h4Kdh+Watt6+3kowq8yeE6HHqVtA==
X-Received: by 2002:a17:906:63ca:b0:a59:a9c5:e73b with SMTP id a640c23a62f3a-a62647ce012mr498321566b.46.1716794446011;
        Mon, 27 May 2024 00:20:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHmw4VLWA0a24bjxblJSe5WRMYJ+9EroDGbosYsLw3G7eBxuW2EV0oOhmhXEwowPtjDctpJYo/2PbocToxCG2o=
X-Received: by 2002:a17:906:63ca:b0:a59:a9c5:e73b with SMTP id
 a640c23a62f3a-a62647ce012mr498320266b.46.1716794445611; Mon, 27 May 2024
 00:20:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240527063136.159616-1-chengen.du@canonical.com> <ZlQphdQLcOnGhCIR@64dafc7c46f7>
In-Reply-To: <ZlQphdQLcOnGhCIR@64dafc7c46f7>
From: Chengen Du <chengen.du@canonical.com>
Date: Mon, 27 May 2024 15:20:34 +0800
Message-ID: <CAPza5qcffDNUL+HXf0g2Kf2U9_nqsrbAaEwCf5gS7c5CH4c8dQ@mail.gmail.com>
Subject: Re: [PATCH v2] af_packet: Handle outgoing VLAN packets without
 hardware offloading
To: kernel test robot <lkp@intel.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi All,

I apologize for the mistake in this patch's commit message; it should
not have been sent to the stable tree directly.
I will send another patch.
Please kindly disregard this one.

Best regards,
Chengen Du

On Mon, May 27, 2024 at 2:35=E2=80=AFPM kernel test robot <lkp@intel.com> w=
rote:
>
> Hi,
>
> Thanks for your patch.
>
> FYI: kernel test robot notices the stable kernel rule is not satisfied.
>
> The check is based on https://www.kernel.org/doc/html/latest/process/stab=
le-kernel-rules.html#option-1
>
> Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to ha=
ve the patch automatically included in the stable tree.
> Subject: [PATCH v2] af_packet: Handle outgoing VLAN packets without hardw=
are offloading
> Link: https://lore.kernel.org/stable/20240527063136.159616-1-chengen.du%4=
0canonical.com
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
>
>
>

