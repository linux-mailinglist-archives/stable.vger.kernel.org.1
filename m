Return-Path: <stable+bounces-121409-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57204A56CE3
	for <lists+stable@lfdr.de>; Fri,  7 Mar 2025 17:00:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A5933B7FE3
	for <lists+stable@lfdr.de>; Fri,  7 Mar 2025 15:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C185221733;
	Fri,  7 Mar 2025 15:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JO3QSCwc"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 953C6220683
	for <stable@vger.kernel.org>; Fri,  7 Mar 2025 15:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741363110; cv=none; b=FdR8JbKL545XbG2hzKJDUaF+rzw6l3Hg8JemnTiwv2/MbeUBdkgO1ADAlzDHUxYNY2RdlXWtZ4Wrqbc3oknl4y02GtD0WK5dvitoZm5lvIa9BnZ1kjRlM0JH7rb+WvWH51eqD1Qr2bNHByCAfvd6rLc0iaEg+IZvbtjs0m62c2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741363110; c=relaxed/simple;
	bh=AcckhsdEDurBCMHdp8sfsPt8qxRWQG2gQW56j1P0KoA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YPYJDwrDxGbeJIiLZAyj9lU1lMtIbvVmT3gFuX6e9Yx7naXcgK+kIm6xg6bkZyaOmjVohksbedmx+bYjwn0HnCpYmK2/+cjMuiKPBS+V1YJKiVwShqj0rm+f7BcWe9Ypsyd97n8LZpA6DDRdtFHiXxVuASrmOE6yppiacPbbduM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=JO3QSCwc; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2ff611f2ed1so508010a91.0
        for <stable@vger.kernel.org>; Fri, 07 Mar 2025 07:58:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1741363108; x=1741967908; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UI8e46S2yWfYcj/T52R3/b/Frn7ea8qY/mcH1E24aWo=;
        b=JO3QSCwcmNAJmBEQKG4+GDNS6OfApXxtZcPS43auQTOwwk/+ctHe+Bs6DoC4im21R2
         lg9/BUKyInMD8uteYNqrfmtBKaWDL8RGAIN7yf7BScdByUaNudmEkRINOUh0tBqz3Per
         vXt24Hf7royg0GWsEyDbPDinFBDmWsTM7OlEg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741363108; x=1741967908;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UI8e46S2yWfYcj/T52R3/b/Frn7ea8qY/mcH1E24aWo=;
        b=UAv5tODXM1OGIeI1SJq/mzzlf6m5MsPizvEB/G3M1GVgDwifXYirTJYa1+qDVBzCmG
         2IBkinQYCRPO8syU20Bot6Sbi2zElizi7K1l36ShQqJDfz9V1BjTjhliGv00DvI9aRRm
         414WC9uCg+URtOBWrTsCFI610zxCN+0JKrBJKUxrqJRlGX40w6o3PNIpoO4BbxY+Sm3U
         ksPOaXSuNkPel1cDAzPk8Czqq6Kxi6OEeHdjaKeWU2bpMw+fL3smc/AbazfYpNCxWW8+
         ip+a4MaUsHgfHso1w3jedVK1LriDiAKC73Q7G5E6Iswipeum8wEJIIcixO9UIuIHj45Y
         tNoA==
X-Forwarded-Encrypted: i=1; AJvYcCUzQWMtOsr1nR2SnmXQls3dKKTBWiAt5nbRli0h4+QzUKGRVSVbkoImkIPy25dwbfHnEWlDOb8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOYWfYjhGZJMCtTbYtG1N9UTUjx3+Z9qu391ffEVErtNNECf9T
	1BS4YwmdNM0U2Cng+3G8TGdE74WU65WPEG1YYJtjRMwC3kaTUjm0ziN1WoSCw49RLTG24xjeXfp
	8BJqLOOA7ipEjpQl4Ber87EEGP04DYXJbof4Gxt618FzqZg0t7A==
X-Gm-Gg: ASbGncu+iCiRSRQ0MOU37A5wm7GIz64Fe8dbtxsziRHGLE1ax9icqmP97B5aWqjoAjt
	IMk1KIAfDp1ksW5QdZk0MGjwOlYUTw6YxQJ2sHL9EHT5PtIT9zdtdoTU6QC0NYLWJPFMAwAocGX
	IOFxX6OIABIuv6F6vFbEIcf3lcJlwDcW85dN4hCHGVto2jnEPyktdhRg==
X-Google-Smtp-Source: AGHT+IHfPYow2NUntpPpIaQhkzXo83RMjEk+IKawbklkvht8jh5w5gHM6dY4QepLbZKNmWFvdikG7QxoZTS1MuYhAPw=
X-Received: by 2002:a17:90b:1649:b0:2ff:682b:b754 with SMTP id
 98e67ed59e1d1-2ff8f792223mr97221a91.2.1741363107942; Fri, 07 Mar 2025
 07:58:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250307131243.2703699-1-revest@chromium.org> <2cf9798f-1a89-46e1-b1a4-7deec9cb7e40@intel.com>
In-Reply-To: <2cf9798f-1a89-46e1-b1a4-7deec9cb7e40@intel.com>
From: Florent Revest <revest@chromium.org>
Date: Fri, 7 Mar 2025 16:58:16 +0100
X-Gm-Features: AQ5f1JoOeNiCbcT1L7sO-nThLlOiB-LfC116xQ2r0anke6Xo2-0vka868ZEFs6g
Message-ID: <CABRcYmLcXosu62EbTMQNGCEa+mmNtRKCQX8oL=WDrgP-UH6B_g@mail.gmail.com>
Subject: Re: [PATCH] x86/microcode/AMD: Fix out-of-bounds on systems with
 CPU-less NUMA nodes
To: Dave Hansen <dave.hansen@intel.com>
Cc: bp@alien8.de, linux-kernel@vger.kernel.org, tglx@linutronix.de, 
	mingo@redhat.com, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 7, 2025 at 3:55=E2=80=AFPM Dave Hansen <dave.hansen@intel.com> =
wrote:
>
> On 3/7/25 05:12, Florent Revest wrote:
> >       for_each_node(nid) {
> > -             cpu =3D cpumask_first(cpumask_of_node(nid));
> > +             mask =3D cpumask_of_node(nid);
> > +             if (cpumask_empty(mask))
> > +                     continue;
> > +
> > +             cpu =3D cpumask_first(mask);
>
> Would for_each_node_with_cpus() trim this down a bit?

Oh nice, I didn't notice this macro, thanks for pointing it out! :)
I'm happy to respin a v2 using for_each_node_with_cpus(), I'll just
leave a bit more time in case there are other comments.

One thing I'm not entirely sure about is that
for_each_node_with_cpus() is implemented on top of
for_each_online_node(). This differs from the current code which uses
for_each_node(). I can't tell if iterating over offline nodes is a bug
or a feature of load_microcode_amd() so this would be an extra change
to the business logic which I can't really explain/justify.

