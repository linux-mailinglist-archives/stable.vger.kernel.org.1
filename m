Return-Path: <stable+bounces-165780-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2067B188CC
	for <lists+stable@lfdr.de>; Fri,  1 Aug 2025 23:34:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E22E8566CAB
	for <lists+stable@lfdr.de>; Fri,  1 Aug 2025 21:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41E7728EA63;
	Fri,  1 Aug 2025 21:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ZJk/CQkN"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D553474059
	for <stable@vger.kernel.org>; Fri,  1 Aug 2025 21:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754084078; cv=none; b=P834M+BMdO6WXnzjlll0+k+vlahH2P2WWPzBRUHwMy7o2w2DsXaLPNr4pZUTl32LN2R93rVIM8Fu4iJ/CgqxMm0J72QHSrAULXvxlt/Sva1s60TC9AL9ZHiffaNHNHv5u8zwft8nfcefUjXWeLeZpAnHXDE+R214bSa3AgrK03o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754084078; c=relaxed/simple;
	bh=IZkwXQkh8YxYF6KhegHig00grekwiuruDFNARhibles=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T1Nq8AJvu1iqTLTT5YtD7B55+pG5Rjg6Bzt2JY6awfgkvmRIwtFdOlKhZpMg6PPRNB4kz5zLIoSDL0MZQI/zhhjNV6cbbvakHGMPYa66VJLQa392KP3dnAbENpXAFFzFlqRdpPdZbI5rraMkzVkqB0JtaspIakMF0yP1W/xmqHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ZJk/CQkN; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-af93381a1d2so188481266b.3
        for <stable@vger.kernel.org>; Fri, 01 Aug 2025 14:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1754084074; x=1754688874; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WLFHL6fOZFPNrc7teT5UWCBGBPE4FkQnF2Ru0J7QGa4=;
        b=ZJk/CQkNn759zW48a2JZ+wnGAeFYF/65D4MSSLPZwRDZrb4H2z29VBipHbl/UpS9qM
         zM/NJ2LyQta0RPM94ipgCU7SJ6pKOHzTcl10VrKjt9Tua628qDUKWg7ZiVjYmaEZeSD6
         +MdGPgCmO1YSZCIMlC9v6WH/bJ3tyyR2voquc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754084074; x=1754688874;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WLFHL6fOZFPNrc7teT5UWCBGBPE4FkQnF2Ru0J7QGa4=;
        b=t0rvBKtcogN46kRi1lNeMUlUWQuTXLKDa7kLxB5Iq5wWVSUG6I2RHIwGAfuXfDbCY7
         zYjcl0WjTphO0WkrD/h6hVNAxx7ieDhD7lJb1INogphs9ICPuCG9FIHXZsns8MCq4Y/v
         V83bHo4wRvdiOkF0i3Jp/gm5BIFr2lFb8pvJOXRFvI6BWFPdS5LFHNazvoOD3t0c+TsF
         ul3Rkj5PyXMKM6PAQxCy9KLggFqxUzNl5fD4jVUJSvF976lrsIMluGHILitHV+YQZYJr
         NucNeNlZPYYS8ATOPZHRO0wkFHkF5FDgOlWumEM3ndzR+Q/NvtRjYAG/p2EsDWtsGkH/
         y0Uw==
X-Forwarded-Encrypted: i=1; AJvYcCWFtFoRwI3hasFLIYIrLAkrEwWlwh/mzqBLraus0CTHfOpctOZkt2wi4bS7EWIPDllEKsY9Jk0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrLlFTEHv5E6j8povYK1aniLsE54yzYnsYQjgVXEb1PQwCR9Y5
	ewdRyAOOsB+NjRsVQamOWT2Z2vZ2g7Ld3Fle1ez623h0sH5Ne5FzZFWv1yBnWbIuAvQ1cOiyHdd
	hHxUArJw=
X-Gm-Gg: ASbGnctjfql172TJA1iRBNvZVuKdgVITcVGWdNfv3aJEgwl1Wd/5WtFc/QvwYu0Av4I
	Hro6aJsDRrkP8bhXFiynLRpAidoXFT19PU2iiDcAfYEfeOVGxjuFuMwLbU8U7fMm2wN7NOVxUy0
	t00qRdq9UGOj5US85AJWo16082OJ39Xr19OZuEGFVeP92UpEVd6NfFMbq8WDM/lFiYPDkTrlRgm
	jc22LQ+jJHTtge/OCex9Hl26YkTL7vFXYRek226aNKR3H0dPoXqBQptUvdtmKYN3zlTWZ9Kx6JY
	R3kMZpMsuR+jR39Xnny5wrLoq3xZm9e8eaiAbkea+XGMSAeb5Tfiv4TF296pcDwWNhmEqO2CMFZ
	jTkfCvC36oCabwtfzeKy2YZAmDYvH8nunM/3fcirxynFxJM3bsBKT/0SWfm2ew0PrtliF7NlQ
X-Google-Smtp-Source: AGHT+IHA9LiKucoC7oo094c7V34AebTb2uscCufej9Q6FqTs5j5yAPTu+KeZYPQq8wVskldEmNuvdw==
X-Received: by 2002:a17:906:d554:b0:af9:2bb9:ea57 with SMTP id a640c23a62f3a-af940029b0fmr129938766b.12.1754084073786;
        Fri, 01 Aug 2025 14:34:33 -0700 (PDT)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a218ab4sm339381266b.92.2025.08.01.14.34.32
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Aug 2025 14:34:32 -0700 (PDT)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-615d1865b2dso1733211a12.0
        for <stable@vger.kernel.org>; Fri, 01 Aug 2025 14:34:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXUGq68YjzkedNbsGln9o6AtsrujYtbAH25VJ/0W5RdegRfZfYrjSo/W/ZaeYU1qwpwHAcKUWM=@vger.kernel.org
X-Received: by 2002:a05:6402:2790:b0:615:cc03:e6a2 with SMTP id
 4fb4d7f45d1cf-615e6ebec77mr689309a12.1.1754084072420; Fri, 01 Aug 2025
 14:34:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250801091318-mutt-send-email-mst@kernel.org>
 <CAHk-=whgYijnRXoAxbYLsceWFWC8B8in17WOws5-ojsAkdrqTg@mail.gmail.com>
 <aI0rDljG8XYyiSvv@gallifrey> <CAHk-=wi1sKCKxzrrCKii9zjQiTAcChWpOCrBCASwRRi3KKXH3g@mail.gmail.com>
In-Reply-To: <CAHk-=wi1sKCKxzrrCKii9zjQiTAcChWpOCrBCASwRRi3KKXH3g@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 1 Aug 2025 14:34:16 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgRtKY+tk0mhnHzrC0YMXef0GtVUFQ6cGW0-4XS30mQ5A@mail.gmail.com>
X-Gm-Features: Ac12FXyaANs0webz-gagQ0r78-lvtho7QphOSO_s_LZu61Rm94DR5P3bHuE7Emw
Message-ID: <CAHk-=wgRtKY+tk0mhnHzrC0YMXef0GtVUFQ6cGW0-4XS30mQ5A@mail.gmail.com>
Subject: Re: [GIT PULL v2] virtio, vhost: features, fixes
To: "Dr. David Alan Gilbert" <linux@treblig.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, kvm@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, alok.a.tiwari@oracle.com, 
	anders.roxell@linaro.org, dtatulea@nvidia.com, eperezma@redhat.com, 
	eric.auger@redhat.com, jasowang@redhat.com, jonah.palmer@oracle.com, 
	kraxel@redhat.com, leiyang@redhat.com, lulu@redhat.com, 
	michael.christie@oracle.com, parav@nvidia.com, si-wei.liu@oracle.com, 
	stable@vger.kernel.org, viresh.kumar@linaro.org, wangyuli@uniontech.com, 
	will@kernel.org, wquan@redhat.com, xiaopei01@kylinos.cn
Content-Type: text/plain; charset="UTF-8"

On Fri, 1 Aug 2025 at 14:15, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> My apologies - they are indeed there, and I was simply looking at stale state.
>
> So while it's recently rebased, the commits have been in linux-next
> and I was just wrong.

Pulled and pushed out. Sorry again for blaming Michael for my own incompetence.

            Linus

