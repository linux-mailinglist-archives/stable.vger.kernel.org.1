Return-Path: <stable+bounces-114974-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87727A31A67
	for <lists+stable@lfdr.de>; Wed, 12 Feb 2025 01:23:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39CFD3A57CB
	for <lists+stable@lfdr.de>; Wed, 12 Feb 2025 00:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68B791876;
	Wed, 12 Feb 2025 00:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4MLHbF/9"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8238F79F2
	for <stable@vger.kernel.org>; Wed, 12 Feb 2025 00:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739319794; cv=none; b=aX6AFcmvQNlMelnr3vys+nQ9XFY45TdNzEpbUCG8zHtDTkKs6M2HtUD63rN1Wx7IyLljJ/QZoHLPo71jW/6bkbLHHEDMRX0wjzPBF+8NRboDw6IhaP5SKK22rZpRK3Mv9BsuoEuj/vU/9JPK/o+WgJtZJZ3FkjjOJ98rIzaTN8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739319794; c=relaxed/simple;
	bh=qNR6Tk+GObHhwah3Z3S1fvOkyR0+TVEpjXojg1MVygE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uSLaaaXIwOvWsje3BoxKUriXWIZDGSsR4REFOxuy5FAJZHoMp932tMapOvA5a/iW4Flyt/PxVsLYJ7SSwjbfEA1Yn+84KIRmdn9GH9S2342+b1vzDimfKjh3hHYE23p8kRHp56SnzeYsbGGkRHVsypH4+Jk/XDooyiC13eb74Ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4MLHbF/9; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-545092d763cso1381e87.1
        for <stable@vger.kernel.org>; Tue, 11 Feb 2025 16:23:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739319790; x=1739924590; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mACifcoi2DxXepU+x0EutTWQzaMm/Sos4wROfYi3LJM=;
        b=4MLHbF/9MvyJlVpqwihOMAbZEWmHui6Y/YoJWyrTe3ADLmu+r/1qeP2PffGFmCCjkH
         lVzN9XgIIEY9qNvk5CC9opqfil8PdjAmo95Tyfy8Gz2cuvHLCxPHBgl8pfhH2zWCrA6A
         cPsZm97NxRE46U/R5gJ4Wm6lZNt7tniwC1XrnF69awagyBbcDGrxpOrXgDqAXGRaHfM2
         jq19A4MP2qwShRWVymA8MJ3+EbIlSH0OnCeFbUawsxhJueWPrTJGbtqZ+kf/nQmYl0Np
         tg3pc7m8G4SGPYZT3o+oEwtjyqyhjex00xKOo2Pm7ofOl+xrszNaJzG5M3B6PSxepz2/
         KFBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739319790; x=1739924590;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mACifcoi2DxXepU+x0EutTWQzaMm/Sos4wROfYi3LJM=;
        b=qaV6MEoLVpZMjPkmcuV+5NGloZoQ6S8Gf6GEFt9PnLl5uns/9Ab/D2KDGMx+P3vTaT
         mEteGhw6tkY4aV0b2e7+/wrYkWs5VQJE9fBzpEIWgkdjlg/dhw1/ixwLJyawPWZCbe9z
         XLksHHDcBsr5fIXmjmpO9U8BagpmyZVJz417J095/Yi1leD0JhBD5vU8KerDgJkrViKf
         f6e3mTwp7q5W3+LrTpQZxMBWpznYCJFrKsn3DpOTyhUWNX2ZnitKaSDUcUXUjXoncpLW
         OoUR2mJgMFCuhG2zBg8U99Mppi7MW6JGmtYxeqqkwEfg1Xs6wvHu4tiA3Ha0HcQ1iqOp
         1YYA==
X-Forwarded-Encrypted: i=1; AJvYcCW3/SEWx6ObS6nMAJ58eELBMvn5B//X0oanrgqXopy3Q61uGBInhyHLIprT/aWCQG36YI7oRZs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+mUJCcYDY5pJw+682zQZnqTAX6rd69lxSG9l0K0SI2Z266bkK
	Jog1FSyGg4pydgCyWsKCKAYk8ZPZ0RLDa/MPdVCruMTaUabIuqpX3lJy4dhGdxzD0qtRgdh5xt6
	rLiXYB24nS7Woi2F/72sFnxLhGiIBIWqDpVQL
X-Gm-Gg: ASbGncvdf3i2yqNynZEdNKeMjH+LMc5rMTVdGutnOv23xeENELMNYf3CZ/PtnV1zRhl
	nAcDo8VWdR2fWPZfIbHg9BfsSJuzxNkTvMko1oRcJ3aPhKWQRvcXlgn9PhSmlEeP0Ix22jtou1e
	DZK/rpmieHgNWS6Fe46srlW4XMr1RUnw==
X-Google-Smtp-Source: AGHT+IFPKhZm0/EPYURfMy8o2OglVh9zff4nbrdv9CblcFNVpZjWo90EpnyStQulFiUbZl+EMuN5argcpQNCmKAOnj4=
X-Received: by 2002:a05:6512:3d90:b0:545:34e:16c0 with SMTP id
 2adb3069b0e04-54518de9606mr49823e87.5.1739319790362; Tue, 11 Feb 2025
 16:23:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250206222714.1079059-1-vannapurve@google.com>
 <wra363f7ye6mwv2papahmpgmybi45yqyzeohunbqju3zsf22td@zcutpjluiury> <c07fa2b7-d453-4a9d-b1fc-e3e96514a8d3@intel.com>
In-Reply-To: <c07fa2b7-d453-4a9d-b1fc-e3e96514a8d3@intel.com>
From: Vishal Annapurve <vannapurve@google.com>
Date: Tue, 11 Feb 2025 16:22:59 -0800
X-Gm-Features: AWEUYZlkk-jh9FqHHuYl2log-YQTJzWr98PHa1jkE8VtQRSzVdPYb1_-7Dq2dlc
Message-ID: <CAGtprH_4Z15UdPDDCYg=pnroS41fX7c7VzK_ziPMsk=UgQYfgw@mail.gmail.com>
Subject: Re: [PATCH V3 1/2] x86/tdx: Route safe halt execution via tdx_safe_halt()
To: Dave Hansen <dave.hansen@intel.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, x86@kernel.org, 
	linux-kernel@vger.kernel.org, pbonzini@redhat.com, seanjc@google.com, 
	erdemaktas@google.com, ackerleytng@google.com, jxgao@google.com, 
	sagis@google.com, oupton@google.com, pgonda@google.com, kirill@shutemov.name, 
	dave.hansen@linux.intel.com, linux-coco@lists.linux.dev, 
	chao.p.peng@linux.intel.com, isaku.yamahata@gmail.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 11, 2025 at 3:46=E2=80=AFPM Dave Hansen <dave.hansen@intel.com>=
 wrote:
>
> On 2/11/25 00:32, Kirill A. Shutemov wrote:
> >> If CONFIG_PARAVIRT_XXL is disabled, "sti;hlt" sequences can still get
> >> executed from TDX VMs via paths like:
> >>         acpi_safe_halt() =3D>
> >>         raw_safe_halt()  =3D>
> >>         arch_safe_halt() =3D>
> >>      native_safe_halt()
> >> There is a long term plan to fix these paths by carving out
> >> irq.safe_halt() outside paravirt framework.
> > I don't think it is acceptable to keep !PARAVIRT_XXL (read no-Xen) conf=
ig
> > broken.
>
> Oh, I thought it took PARAVIRT_XXL=3Dy to even trigger this issue. Was I
> just confused?

Original issue with unsafe "sti;hlt" execution for TDX VMs doesn't
need PARAVIRT_XXL to be enabled in theory. Any caller just needs to
reach native*halt() to trigger the issue.

