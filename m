Return-Path: <stable+bounces-118527-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CB04A3E834
	for <lists+stable@lfdr.de>; Fri, 21 Feb 2025 00:17:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6AC23B9780
	for <lists+stable@lfdr.de>; Thu, 20 Feb 2025 23:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74432264616;
	Thu, 20 Feb 2025 23:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rkj/tpqS"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9A426561C
	for <stable@vger.kernel.org>; Thu, 20 Feb 2025 23:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740093446; cv=none; b=NMLt+3Vy6sLkysxr7hE8fRRikip42CWp/hExR4AYZ+ZT14+bDUsVQ1+JAqyYw0AQ9MVGl7SCQxmuj6u5RDDW5TzUfamFHt1Xx3ycbcbWPY/CVnRJGMFgIWjgpxZS8MTjXUEImRAWTCAEs/vWX8uKV+DSumm1rOQ3WG7c/IOiMSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740093446; c=relaxed/simple;
	bh=1cIjuvp4munwp36O0Su27G+k3yaY66vxM/AalS2J9ro=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M2bf7scXE/4FC7A5viTg1l3S12OQi2IjSkD08WNtbuNRupMLsOhM43No/M8SHIAPpSR3L/lyU6ST7N9jmHFsYZsb1LMR3yjIl/PY1FiI5JDJ9G0ydXV5ZOrVlQc2LYGbykJuerIL/zXQia6fEXd5SSvKh8mBgwBffIjPRxlqMz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rkj/tpqS; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-54522e82e7dso2944e87.0
        for <stable@vger.kernel.org>; Thu, 20 Feb 2025 15:17:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740093442; x=1740698242; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yRORyKgcdd4uVm+XGlcno7rV+y967/k6WA8VcDaJDCw=;
        b=rkj/tpqSLFpjBs0dxR8qkkahDlYqKH/YXlwJaxKghOqYy8beHOre+cqReO0jFT5+HK
         C7MYN3247mdFm4Mg+XOMABhcWgBCsqwBWvsr18Uh4RXFNY7Mr4hEn1rt0x+EP156OhRj
         zv+/PqqiLu4XJWlkgOzk3jOhnZog23aBMD7vvytTr8XTa9Cqe5jchjql+YhOpQFx/x8/
         oJ7QKXIE2NT4tzSIk19kZ3SDzPhI9nidDVZa5Ie2v8aoL+qaMFbdg9OqxIOfhCIqrRcS
         luGMRxCeEiMtVISXNNpjWFImMCSQUirFI4dxJUXI0HSSu4vGgnKkGyRBRbIOz9x02E3V
         v3Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740093442; x=1740698242;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yRORyKgcdd4uVm+XGlcno7rV+y967/k6WA8VcDaJDCw=;
        b=Cdz08unen8q6QPDdG6Oz2YqiADlaTYYfBuWVUf+bHuNP9lqmYEUJB+c++ltSKv3qaa
         QstnNT9bwxwOjeJSQq2iitCbnJ5dDBuhAZsZ2R4MjIJoqoIhpeIPnx4US6OYes0350PM
         ofouXQ6Jr8OeyN6mFFr8bkwXML24PWKQQ5GCulMhxxgLhzBjY9AJGVHgVUh4yPgg4/tf
         gb5gw3ST6/3fsT+SCNMwTTQUdbBvNRJYWDLoM4lOI83dSOevFz8PUuPNgqqr2hB4gfxk
         AopYEI27gF8Y3MWTjw6AEJW/VjdHQA9qpS05rFiWgllTwNcidwQANec4Dk1sClkrZDrv
         EJJA==
X-Forwarded-Encrypted: i=1; AJvYcCWk/ojm/id3LDbwn7OikD4zJ8ybNPvVy+BzSstfxl9VV9SlBL3mP+/j6zOeA3jsAj5P2bWM3Cc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNEt1BhQUF6R37/+CZxkRm/GH9ckYYLU4MB6wTBewPr3tC8xiB
	ymIMcyyFLTMZx3eipLJ72CAHiAQt7neXLtF6eXqXYiJQJKQX/mK1B7qzyefoKVkgbnEhmg7FJ7G
	U3ELJyO07WyzxyrEZQXf8dvA5I+jWLkanlQBr
X-Gm-Gg: ASbGncvg/eDYRkbc+zL6eM6ox6xUJPIHH1sdEQWgEoKDRTsSD1vP/gruK/Cbzw3PFwC
	9xle2vS2eonnN+d0KR0nmls3arKRwooVgZSwASBb9LLHkAePmG5wXaAH1S38lA1H8bQBH/dMAxe
	1JO9n8x6EQY0k1fXEl7XSfBnS/7Rxr
X-Google-Smtp-Source: AGHT+IEWQiBc288yYrLCTppIrbxa3qN0HBmgiL7WK6l/eN2zlTxhCP/B74cPGse/0Iz95hyG2RtMrjG+GdCe2cYgGKw=
X-Received: by 2002:a05:6512:124f:b0:545:2301:b1c6 with SMTP id
 2adb3069b0e04-54839f9c24dmr36007e87.7.1740093442260; Thu, 20 Feb 2025
 15:17:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250220211628.1832258-1-vannapurve@google.com>
 <20250220211628.1832258-2-vannapurve@google.com> <9120e074-52af-4ae5-a08c-e62a879c7ebb@intel.com>
In-Reply-To: <9120e074-52af-4ae5-a08c-e62a879c7ebb@intel.com>
From: Vishal Annapurve <vannapurve@google.com>
Date: Thu, 20 Feb 2025 15:17:10 -0800
X-Gm-Features: AWEUYZlcMEtt0DdUpswWfn-2RnJ9b7h7OlP4aU2QsZo74T1M7MMOMNFwfs29_Zg
Message-ID: <CAGtprH-utPk=u938odDYAWAFLSZj+OhVH_k_RCHc87k3eqm0jQ@mail.gmail.com>
Subject: Re: [PATCH V5 1/4] x86/paravirt: Move halt paravirt calls under CONFIG_PARAVIRT
To: Dave Hansen <dave.hansen@intel.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, 
	virtualization@lists.linux.dev, pbonzini@redhat.com, seanjc@google.com, 
	erdemaktas@google.com, ackerleytng@google.com, jxgao@google.com, 
	sagis@google.com, oupton@google.com, pgonda@google.com, kirill@shutemov.name, 
	dave.hansen@linux.intel.com, chao.p.peng@linux.intel.com, 
	isaku.yamahata@gmail.com, sathyanarayanan.kuppuswamy@linux.intel.com, 
	jgross@suse.com, ajay.kaher@broadcom.com, alexey.amakhalov@broadcom.com, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, stable@vger.kernel.org, 
	Andi Kleen <ak@linux.intel.com>, Tony Luck <tony.luck@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 20, 2025 at 1:47=E2=80=AFPM Dave Hansen <dave.hansen@intel.com>=
 wrote:
>
> On 2/20/25 13:16, Vishal Annapurve wrote:
> > Since enabling CONFIG_PARAVIRT_XXL is too bloated for TDX guest
> > like platforms, move HLT and SAFE_HLT paravirt calls under
> > CONFIG_PARAVIRT.
>
> I guess it's just one patch, but doesn't this expose CONFIG_PARAVIRT=3Dy
> users to what _was_ specific to CONFIG_PARAVIRT_XXL=3Dy? According to the
> changelog, TDX users shouldn't have to use use PARAVIRT_XXL, so
> PARAVIRT=3Dy and PARAVIRT_XXL=3Dn must be an *IMPORTANT* configuration fo=
r
> TDX users.
>
> Before this patch, those users would have no way to hit the
> unsafe-for-TDX pv_native_safe_halt(). After this patch, they will hit it.

Before this patch, those users had access to arch_safe_halt() ->
native_safe_halt() path. With this patch, such users can execute
arch_safe_halt -> pv_native_safe_halt() -> native_safe_halt(), so this
patch doesn't cause any additional regression.

>
> So, there are two possibilities:
>
>  1. This patch breaks bisection for an important TDX configuration
>  2. This patch's conjecture that PARAVIRT_XXL=3Dn is important for TDX
>     is wrong and it is not necessary in the first place.
>
> What am I missing?

