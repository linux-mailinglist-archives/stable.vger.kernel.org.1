Return-Path: <stable+bounces-144494-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B5ADAB816F
	for <lists+stable@lfdr.de>; Thu, 15 May 2025 10:51:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79980867139
	for <lists+stable@lfdr.de>; Thu, 15 May 2025 08:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4470428C2BF;
	Thu, 15 May 2025 08:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="XV6gUVBo"
X-Original-To: stable@vger.kernel.org
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F33293725
	for <stable@vger.kernel.org>; Thu, 15 May 2025 08:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747298977; cv=none; b=X9CnOitn0QZRvPXK6mfVQ3vqVCEVzJflRGAFROJZvxZODXQlOEpN0XMY2958x4+5vgEfE5IS6PmXpehGN9sOkHwEbs8KrcFI37hjh4YsxFlU7B+Ts5YKuaG+M3ArmpGpWmpgFbk5wcxCI4q7W2Qn5HKq38WPWHlmnnucRECGrOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747298977; c=relaxed/simple;
	bh=xxODzj0GTz4Tn/pQiVGquj+QDkHJ+U8GF5SgIRPZp2c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j/1c1KeM3N1QxNrAWLhRF2Zx3nUuUj2lYZNLQvNN5LLfM/k84mkpuF/VySMt7HCqX6l2NbTQv/ChFAazflJpIcPxyrRiRRR8gsTT2RFD28f+ojtkTjBtRhlZK6n+JFVROxW+fhftqZGaXV5BqjjkkMDsjF2LOIVVlxWtCL21hDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=XV6gUVBo; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-6049acb776bso492265eaf.3
        for <stable@vger.kernel.org>; Thu, 15 May 2025 01:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1747298974; x=1747903774; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GLIGbBPEYFKG0tprCyA8AtjgNY9PBs8yJbpI5XvRmAs=;
        b=XV6gUVBodPcxvPGCpFBOGHGYjNZD33MvfeCIslgyOhhAlGF1HIX6pi3OYKZZXaxVJq
         J1mLqaPqQnjb4JCBScXnMuAkmq7x42XNyxU6oFgbhpk1yGETM+bXOfQU6y9D0+Gi6Yf0
         FJYy/LB0aH1/HIY1y3ehUDV+KsXPAU025WhSgt/PEaxcRilpLb4cI3vXR7bGI2sihr19
         jU82Y0NjqJu0QIeDReOKm3CLdoMZCtry6Z/PSAfIjGXX+VlY6AvWh98a5gYEtuCJ1ubp
         OfL5w9mfmbL7Lxji22RjTz20RW828TEuQpp2lhItoZ60+lfmO6/elEdN4wsAyCmZ4TmN
         byPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747298974; x=1747903774;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GLIGbBPEYFKG0tprCyA8AtjgNY9PBs8yJbpI5XvRmAs=;
        b=vpqOgl5ffbw41huEjs6qNLJeFkrARZODTCRnXR0UKTUsCOgmFWWwO9MXIMCwfxjAAS
         W7eE61IzOJ82I7DsHYLsjkmTCL7TeR8N0loGVaVK49IVGmiUlnlCxo6k21WuUnjL8vUb
         vrmcnzAVlJJf6MV2CovIJiCFuU2puZqz6gy9qSMp/AZmsJSG3vvm9QYQRGkfIab6zls7
         ytK1x8ZosS4x1dBESNmLespjb8UsY2ZYtL2aRkLxG3AS1c2x8XC5Ls+SJKl1c6jcjJXd
         ljwXBXlRtEEyBDnqPGaujMTqbQj/MVfaOQe/N6IIFWGSyanzMTL+lrY4UQD8U2zUth4+
         A+Rw==
X-Gm-Message-State: AOJu0Yy0vFnmvrn25/6UPd9CFclcEyddzPPlG2/9fFg4RXb3j1L7C0jL
	kNj+L/hOnTHeO6+lWqc4SAhVFiSdPTquOZqOq87PmuxaNs12UO+7tRkCH1+Sl+EPcUSUexWMjig
	Q5OnKzDq++ecLWpH8lDh9iSMzrpyqmw5f+zyaSC93Acj+qKAwCKI=
X-Gm-Gg: ASbGncuf+RQzCry4aIilYhDofWu1al55xHPNs3FQ2LukbILHdyCnvWV8XjxYmLMgtiS
	VO0B6eIQWjVFb4ClZG50e8/3ukPQEFk8zi5Z61msSddXgDV9t+T9Aox1n1jTIayT8QLwSKjnvBy
	A6OVKs2yptiJXXE6f1AFOL0gwTbevH4pzcVo8=
X-Google-Smtp-Source: AGHT+IFX7d4RhXh/zLSkITcaO1WmDzYWZ9jYr8sEmd2cVC7MG/56sW5ZS+SLjeYB27JyBFSfSiGhVyPRQoBVeLgxYyk=
X-Received: by 2002:a05:6820:270a:b0:607:ae77:59f3 with SMTP id
 006d021491bc7-609df17967emr3260500eaf.2.1747298974267; Thu, 15 May 2025
 01:49:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250513112804.18731-1-changfengnan@bytedance.com> <20250514090341-9d3c0ac40275ccdb@stable.kernel.org>
In-Reply-To: <20250514090341-9d3c0ac40275ccdb@stable.kernel.org>
From: Fengnan Chang <changfengnan@bytedance.com>
Date: Thu, 15 May 2025 16:49:23 +0800
X-Gm-Features: AX0GCFvVv9gsvNBvK4FQPe01KY4jB2fSWS4JgBYJ_VGUD8Bi8emj8UuuRbNesxY
Message-ID: <CAPFOzZviM5i49hMAF4MBbXe=cm_JzaHmffiFUsb9cPuV2uUK_Q@mail.gmail.com>
Subject: Re: [External] Re: [PATCH 5.15.y] block: fix direct io NOWAIT flag
 not work
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi sashal,
I'm not sure what I need to do. This bug only exists at 5.15.y, so I
use the commit id  at 5.15.y branch, not upstream commit.
Should I use upstream commit or just ignore this warning?

Sasha Levin <sashal@kernel.org> =E4=BA=8E2025=E5=B9=B45=E6=9C=8815=E6=97=A5=
=E5=91=A8=E5=9B=9B 04:14=E5=86=99=E9=81=93=EF=BC=9A
>
> [ Sasha's backport helper bot ]
>
> Hi,
>
> Summary of potential issues:
> =E2=9A=A0=EF=B8=8F Could not find matching upstream commit
>
> No upstream commit was identified. Using temporary commit for testing.
>
> Results of testing on various branches:
>
> | Branch                    | Patch Apply | Build Test |
> |---------------------------|-------------|------------|
> | stable/linux-5.15.y       |  Success    |  Success   |

