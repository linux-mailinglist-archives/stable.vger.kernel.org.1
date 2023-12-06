Return-Path: <stable+bounces-4782-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABB51806377
	for <lists+stable@lfdr.de>; Wed,  6 Dec 2023 01:33:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD2521C2117E
	for <lists+stable@lfdr.de>; Wed,  6 Dec 2023 00:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C4B5652;
	Wed,  6 Dec 2023 00:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RbrxDNOk"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFA219A
	for <stable@vger.kernel.org>; Tue,  5 Dec 2023 16:33:39 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id 3f1490d57ef6-d9b9adaf291so3900436276.1
        for <stable@vger.kernel.org>; Tue, 05 Dec 2023 16:33:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701822819; x=1702427619; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5xu9oRa8BSfMv9BLhUnnloC2Q8CY9EL7xXo54kO5COc=;
        b=RbrxDNOkM2IQb9GiF0JOyHt2ynyoDPiS+4xeGzzb9MFhjwiIE7MrbPqIVq7mfUxOCA
         XUgBtI9hBI1Vs2LZ+Rqd9LDMn6IRHYGq0dtB6kxrGKOL9BuC+dU9twsTUu4LuhJ/+KNu
         DQ9VcvmzYFdMBrEnIy6TOzrWmhBCK93bQHseRwaVT5uaGkHVTV3GVsd8syGk0JvBLSul
         psMTSr0tUXeIFUtZVYrugp+ZS/BQFmiT1b9EFVdQDLVes3kV6FoLtkQzLqSrUyLg+MWA
         kjovrfvhnXKcltznUQFsaWHTA8JYbP+A/0szDZnAlzN0DnwIZ80opv7rSW2SyoNzlLB5
         8Baw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701822819; x=1702427619;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5xu9oRa8BSfMv9BLhUnnloC2Q8CY9EL7xXo54kO5COc=;
        b=artI+rgVuwnQ61EVVSm4sgBH76wI2l/hs4MahotYpPbmZ8fDr6Lve9SdEXmzOeson3
         n2litRSHv6B/gsQ4w+wA3qRVmJvN0PcPytPR4Zleq/3mOMRjiOgxraR4AKS48yJ2fNo7
         qvBSVZjnq57WgQtvLD9g2mDCjf6NSOumh30clQBs1PlFNSF3xQxtY5MzMBEG99HF5/fQ
         ayhFpvsVCLlT9xxl3g3TmK1+wi5svSublQoL184IZS+Q4VUDWer54H0o2Ov6ekC2+9IZ
         /iZzp17UT2ZzR71PpHsVoar0OXNx4iCXEkM0UCI6/WyCG8i8p8H4mEukO2ROYrOYua4q
         9T4w==
X-Gm-Message-State: AOJu0Yx4G9S0ZkpPAMOTkSVbPWt1cakOujQzwn1NnJ7P+N/JAfA6HDKS
	VQG4MQT3/McW5TRIKADMQRn113bNOd9foXHzPuE=
X-Google-Smtp-Source: AGHT+IHonzzibf5ZZHh+7K/UVAPqQEw4hM4dQz6l5XubBlwFnIEoIIT4on/J7koxoWBpFJgXUSsCIh4tsFdmii6I7B8=
X-Received: by 2002:a25:e613:0:b0:db7:dacf:4d6f with SMTP id
 d19-20020a25e613000000b00db7dacf4d6fmr1791ybh.107.1701822818959; Tue, 05 Dec
 2023 16:33:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231205031531.426872356@linuxfoundation.org> <20231205031534.517148119@linuxfoundation.org>
In-Reply-To: <20231205031534.517148119@linuxfoundation.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 6 Dec 2023 01:33:27 +0100
Message-ID: <CANiq72kuK9cFDNWszsR1jSAiQo6qV9cjduYNm+oAooGtE6mRkw@mail.gmail.com>
Subject: Re: [PATCH 6.1 051/107] auxdisplay: hd44780: move cursor home after
 clear display command
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	Hugo Villeneuve <hvilleneuve@dimonoff.com>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	David Reaver <me@davidreaver.com>, Miguel Ojeda <ojeda@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 5, 2023 at 4:31=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> 6.1-stable review patch.  If anyone has any objections, please let me kno=
w.
>
> ------------------
>
> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
>
> commit 35b464e32c8bccef435e415db955787ead4ab44c upstream.
>
> The DISPLAY_CLEAR command on the NewHaven NHD-0220DZW-AG5 display
> does NOT change the DDRAM address to 00h (home position) like the
> standard Hitachi HD44780 controller. As a consequence, the starting
> position of the initial string LCD_INIT_TEXT is not guaranteed to be
> at 0,0 depending on where the cursor was before the DISPLAY_CLEAR
> command.
>
> Extract of DISPLAY_CLEAR command from datasheets of:
>
>     Hitachi HD44780:
>         ... It then sets DDRAM address 0 into the address counter...
>
>     NewHaven NHD-0220DZW-AG5 datasheet:
>         ... This instruction does not change the DDRAM Address
>
> Move the cursor home after sending DISPLAY_CLEAR command to support
> non-standard LCDs.
>
> Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Tested-by: David Reaver <me@davidreaver.com>
> Link: https://lore.kernel.org/r/20230722180925.1408885-1-hugo@hugovil.com
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

The commit enables more hardware to work, so it is a "feature" in
sense. It does not break the current supported hardware (as far as we
know -- David's `Tested-by` was on HD44780), but as usual, there is
always a risk with any change.

If it is OK to take commits like this into stable or somebody wanted
to use that hardware in 6.1, then I assume it is fine, but I wanted to
point it out just in case.

Thanks!

Cheers,
Miguel

