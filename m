Return-Path: <stable+bounces-70284-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1C2195FDE1
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 02:02:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05C1028276A
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 00:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FE424414;
	Tue, 27 Aug 2024 00:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="njxG8zx6"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6299E621;
	Tue, 27 Aug 2024 00:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724716935; cv=none; b=ocxizn+jmIEBg2Xyw6BXYnuTVcBulgF44QtcVzMIXwwme1YMjizYOQLb1ftOEk70q4PlCG+aOBGor5DrlTB1+IvDNZ/SnuE6D2wcEGZjLDCaQPT+Y6tYcIfM/+aZWydA3Fjk0q8MHyjs7M0M8ccxhfmP9DKzfUGIJfnF+lgmnKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724716935; c=relaxed/simple;
	bh=3Lu2qvntF0LW0D6rPDpqRDqugVpTuyFFhTjrSXWCWNE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pp+5k34FUvffeeG/RiknFoZOfBqeCsZKNov0eKgWsN2ESYMKLo9bixaRUhWdnKgzoEhdHB2f7BSt9T46eDdN0Akr7iR9u7rTlk2z65/mnOmcyrWlWSMAnSIb7c2cE3o5J32Ii5imBYnERD6biXpilXC/88Kl6aHFjCbvPokkR7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=njxG8zx6; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4281ca54fd3so42279185e9.2;
        Mon, 26 Aug 2024 17:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724716932; x=1725321732; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Lu2qvntF0LW0D6rPDpqRDqugVpTuyFFhTjrSXWCWNE=;
        b=njxG8zx6muWAxT+dLD++zkt/KknfbWQiZyFfn72bisCBIBZSgpThKZAl1r90tDd/Fb
         tN6+Ohwbsp+2IF10SYovuXurEpxNpzEusB/Q1HAhDV5blhB+wXMTk/pO0I4wq56166qg
         e2215WAMelf6N4g8cdPpk+swlij4hZ+vhiDUnsOs65LKfFsUGW+L8douvvVLORrt6PGw
         aLpA9+nmt2InYnm8eow0GFngECCdkdkh5qVZZwzz97TEIYu+QRjNOz7RkRs9tf7Bpmph
         n2JaxfJVkMRtmQ5mi67PfrrqulnosdasWLFZRPnU4YFB/TZpSm0tvjvfZRKtKvIZtelQ
         cxcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724716932; x=1725321732;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3Lu2qvntF0LW0D6rPDpqRDqugVpTuyFFhTjrSXWCWNE=;
        b=gJ2bG3x71lJycslyfJGbRDbEttIX7eBW7f1btrb8a/tZ9PA35WgA3skkPj0e69lmFF
         2HSeGgZ39TSUfYGeh0YmS/JoifSebsY/9A/1OkET8hO++pzp9w+EXnfyqQyFulExWUfM
         AGs04UBfcOOPOM7wmg8Ml6vKeqW6+hwk2DFkWCoxxErrkZz/3CCVOgFpnCQo6sTDrYeG
         2u3C4sHBeUm7vz0SqsNYwLYyH9F6pUA6PYzd8U/DZHVwEMoUxZXyab93NXfIXZZOQBgg
         eMi+yWurMwdJsGk6etkf0TmN+DsGcdboFH9PKEYipdVdSKOIU+QE9eE3yRZKcZyXUQde
         k7Vw==
X-Forwarded-Encrypted: i=1; AJvYcCWLpsV/93QZfh9OquMrrMYuRtVhDzw9zAbmUoiEWNwHlPlJqV7lOQrzcbA8M1JiKKLcn9P4Y/Ehuf/2@vger.kernel.org, AJvYcCXOwrd8VrdV4VAosbioVU6+4JGoIysuL89mtX9kFXvkeosaej20kJvrqN5UCdmSWaOqv37CFSsFGOGHKHc=@vger.kernel.org, AJvYcCXsXZ+UbJXu/Row/VCJW5kPWx+VHfYghD9Rgi3jYkT4yLcWgIAWhegyVxLvPJhaR2e9WyQS9elz@vger.kernel.org
X-Gm-Message-State: AOJu0YzMJ40q3c9U+okCVntcqC7lYFLSI15Z6fW0v8+HZk/RiKUU6k7i
	x0L0cRR1Rn73t2/+pipLXVz1P38wESHldLyWJfqqdZs0X+kLLIrGOEqr5FSsMzYLsV0dV/9u55Y
	wqFsjPZ2naxGmI29fw2opO8YW3nU=
X-Google-Smtp-Source: AGHT+IGAM3TFs9NXhoHtmE3Cku2gMbd6wYRStVxQerrS1NZ8Nv7gH9pabCN8b2jcCBPPxX3JLq4ChV+hMWDv41wP16A=
X-Received: by 2002:a05:600c:5250:b0:425:7884:6b29 with SMTP id
 5b1f17b1804b1-42b9adf038dmr5996955e9.19.1724716931386; Mon, 26 Aug 2024
 17:02:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240729022316.92219-1-andrey.konovalov@linux.dev>
In-Reply-To: <20240729022316.92219-1-andrey.konovalov@linux.dev>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Tue, 27 Aug 2024 02:02:00 +0200
Message-ID: <CA+fCnZc7qVTmH2neiCn3T44+C-CCyxfCKNc0FP3F9Cu0oKtBRQ@mail.gmail.com>
Subject: Re: [PATCH] usb: gadget: dummy_hcd: execute hrtimer callback in
 softirq context
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alan Stern <stern@rowland.harvard.edu>, Marcello Sylvester Bauer <sylv@sylv.io>, 
	Dmitry Vyukov <dvyukov@google.com>, Aleksandr Nogikh <nogikh@google.com>, Marco Elver <elver@google.com>, 
	Alexander Potapenko <glider@google.com>, kasan-dev@googlegroups.com, 
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	syzbot+2388cdaeb6b10f0c13ac@syzkaller.appspotmail.com, 
	syzbot+17ca2339e34a1d863aad@syzkaller.appspotmail.com, stable@vger.kernel.org, 
	andrey.konovalov@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 29, 2024 at 4:23=E2=80=AFAM <andrey.konovalov@linux.dev> wrote:
>
> From: Andrey Konovalov <andreyknvl@gmail.com>
>
> Commit a7f3813e589f ("usb: gadget: dummy_hcd: Switch to hrtimer transfer
> scheduler") switched dummy_hcd to use hrtimer and made the timer's
> callback be executed in the hardirq context.
>
> With that change, __usb_hcd_giveback_urb now gets executed in the hardirq
> context, which causes problems for KCOV and KMSAN.
>
> One problem is that KCOV now is unable to collect coverage from
> the USB code that gets executed from the dummy_hcd's timer callback,
> as KCOV cannot collect coverage in the hardirq context.
>
> Another problem is that the dummy_hcd hrtimer might get triggered in the
> middle of a softirq with KCOV remote coverage collection enabled, and tha=
t
> causes a WARNING in KCOV, as reported by syzbot. (I sent a separate patch
> to shut down this WARNING, but that doesn't fix the other two issues.)
>
> Finally, KMSAN appears to ignore tracking memory copying operations
> that happen in the hardirq context, which causes false positive
> kernel-infoleaks, as reported by syzbot.
>
> Change the hrtimer in dummy_hcd to execute the callback in the softirq
> context.
>
> Reported-by: syzbot+2388cdaeb6b10f0c13ac@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D2388cdaeb6b10f0c13ac
> Reported-by: syzbot+17ca2339e34a1d863aad@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D17ca2339e34a1d863aad
> Fixes: a7f3813e589f ("usb: gadget: dummy_hcd: Switch to hrtimer transfer =
scheduler")
> Cc: stable@vger.kernel.org
> Signed-off-by: Andrey Konovalov <andreyknvl@gmail.com>

Hi Greg,

Could you pick up either this or Marcello's patch
(https://lkml.org/lkml/2024/6/26/969)? In case they got lost.

Thank you!

