Return-Path: <stable+bounces-91768-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6023C9C0024
	for <lists+stable@lfdr.de>; Thu,  7 Nov 2024 09:38:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91FEF1C20F86
	for <lists+stable@lfdr.de>; Thu,  7 Nov 2024 08:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26EEF1D5CCD;
	Thu,  7 Nov 2024 08:38:08 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A915C2ED;
	Thu,  7 Nov 2024 08:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730968688; cv=none; b=nnXTSwMdndwO1ai9WQrCa5YRKbb/Jviuwgp0OBrsILxRixfqAblWzKGRG4oxqok9AuVBa9cabTgD2jdDoLwjla6jUJA6TYw7j1S6VyYnOFmY4uMwyBwthUG4dz/pWKv2hgxcARrRfMdtzIU6sx388y0KELCTalGq2iLz1mPGrJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730968688; c=relaxed/simple;
	bh=5K9RBw/syKo/ToA0mTS9h7O9ZvRiBwpEZbv4gIcFtbU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uOHmyzkDXlIUCFwAWJ8EbeFdw+7g9OrytIFHmkOZJkyqmFoLNIjxzgKBUSBiPnmWh57jp1SwLTCEVRUFPXjnNBv41tAZwPuxoN2hOnm+4cnt031FtuT2ZhdSQLJoeTR7f+J10oQ5zZgzzO5Tv4CSXJQqv4W8q4++E/U/ppMbYZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e30eca40dedso660773276.3;
        Thu, 07 Nov 2024 00:38:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730968684; x=1731573484;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5qIkpxX8mie6S98MLU//bN6Dn5DgRJ3nz9AaO+MRWEA=;
        b=TSigyAEcQMrRkAKRc61iKelsmqofoSXq3TU/O0KksqXMtjlB/GqFlpc/YRd8Sit7Pz
         //8tyL93hjtntoLbTYDJQEOcWqrVSUYJyRcMu/xckLIx+jAAsZWTfeRv2Gg1qdzEk0wi
         NfMyjHNAsejoXm6UU6S71xwfj7uqvPAmQfZG+NhTgQiOT/WbJlJIOYgw55Gt//GB3q15
         F3w99jWgDeO3RjsqJIl92PxinyzKGwPwctwZX4lNYSEBReS1Ks8kJdUiQ/0gFzZfB5w+
         7257k5n27SZbjlwEn9ZbPvxy080TxMJyQyQ2hQEHPOzX9pPTT5NR1XzKQAfrgvtDASom
         7FTQ==
X-Forwarded-Encrypted: i=1; AJvYcCWiEej7tA95R1Fkc8mz4GIVp54lQ3NpW+6T/rhL0GIHrjrdM429tXUEKr4OQqEGG/cXm85hBqv1nquUEDQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzA9yT2GHbpsMn36vaGbQlENQEhchlqpF7q62AjXJVS+Bc/To/C
	v7xjpwMTK6EVEiGA9CTRVJ5pdk0MUB4SBlNdyBeFz+6HYm14PJOpV8pHgp9P
X-Google-Smtp-Source: AGHT+IG2olxERWCpX331xNjCDkE9qS3jern++gAIXhaBDRTMTteLQ2i5oXbyIVmOHyUJmt4WC//tyQ==
X-Received: by 2002:a05:6902:70d:b0:e33:1717:ebb0 with SMTP id 3f1490d57ef6-e331717ece6mr17128311276.52.1730968684555;
        Thu, 07 Nov 2024 00:38:04 -0800 (PST)
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com. [209.85.128.179])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e336f1ed085sm181566276.52.2024.11.07.00.38.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Nov 2024 00:38:03 -0800 (PST)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6ea5003deccso7200567b3.0;
        Thu, 07 Nov 2024 00:38:03 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWuy3jN5F6lECvKsBVCpLmdav89zPtqq+gYG0hSpcmxrTLiDHlLBDnIcgRyQJLdWoZWmz/Ii9WeoJy2mG0=@vger.kernel.org
X-Received: by 2002:a05:690c:6f8e:b0:685:3ca1:b9d8 with SMTP id
 00721157ae682-6ea64bdd307mr238656597b3.30.1730968683252; Thu, 07 Nov 2024
 00:38:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241107063342.964868073@linuxfoundation.org>
In-Reply-To: <20241107063342.964868073@linuxfoundation.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 7 Nov 2024 09:37:51 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUi=gLLJp2zLgq4bQ-PMXdB1hOZus-5zRSKYS-71cQJsA@mail.gmail.com>
Message-ID: <CAMuHMdUi=gLLJp2zLgq4bQ-PMXdB1hOZus-5zRSKYS-71cQJsA@mail.gmail.com>
Subject: Re: [PATCH 4.19 000/349] 4.19.323-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hagar@microsoft.com, 
	broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Greg,

On Thu, Nov 7, 2024 at 7:47=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> This is the start of the stable review cycle for the 4.19.323 release.
> There are 349 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 09 Nov 2024 06:33:12 +0000.
> Anything received after that time might be too late.

> Biju Das <biju.das@bp.renesas.com>
>     dt-bindings: power: Add r8a774b1 SYSC power domain definitions

Same question as yesterday: why is this being backported (to multiple
stable trees)? It is (only a small subset of) new hardware support.

> Stable-dep-of: 8a7d12d674ac ("net: usb: usbnet: fix name regression")

This is completely unrelated?

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

