Return-Path: <stable+bounces-91094-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EB659BEC6E
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 14:05:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33EF32846CA
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 13:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F31521FBF7C;
	Wed,  6 Nov 2024 12:55:20 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602D21FBF70
	for <stable@vger.kernel.org>; Wed,  6 Nov 2024 12:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730897720; cv=none; b=KgD7g0H1jt5mYwvjpibM4OuLDUp3EEBadCaglFVQp+cUpUqEc7ZxnJheEsHykz5aHtTOdu23zyPpIO0PwAyBleZPJDsRnpgOoaV+nY162r29lI0Mi/IstsCit7JG8mAadqCsXxmHxHEohq75LTmy8fEWqq9GmKVJ9Grcm1xY2hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730897720; c=relaxed/simple;
	bh=jPS72vFYByANsMtQSh1fpS6SGvlLlwpt9xCT2EBhmRo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jg8GMN15+WGj9GXzB/uyWytjfZjGkQNxcyPgJtrIM5n3gXb4Zg6JXMFugPzYm079+lg9RGl6165HhyCb5/qYQPp2uHMAuMddmvmQabkt514aJCHiCaJoRZYGpHgPM0A7LJ5pws1nkmlMkeTAMRIjHKc3iFkMgguDieB1mA5b1Fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6e2e41bd08bso70101377b3.2
        for <stable@vger.kernel.org>; Wed, 06 Nov 2024 04:55:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730897716; x=1731502516;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R+1YO9BxHmGu247QfteLcFUKWAlVNvpvoScbnZ5mn3g=;
        b=DedEv/L0iYKggTBdQwac6STry1gvF03oUMIT5DRy187vys8h8/cvwVsvWk2jIULzYc
         iR3fOL46+32XpvQPlbUVJhYGk0TdmqbYXRyKxJwJU6y9fubp8lskVnGPiAwHEBZqlj8m
         B1i/1d6JENDeAlUUe3aQMb2d4u/rhrvcJaPvD/79kUdDr4I0ZUXCTpxGPHdQIiM+SHxF
         o4UrLW89lcgipXkR9GXym1AGQ5NHCTqhlDmp/LE8p45GUOwyf2ux72eT4o2kC0ls8Lme
         c1/qUK1KBZBybCw8S+TzKWKPYIxAET1B/hpeMNO6OvNyoZKEoe+yAMTK5wZM46die1uA
         xedw==
X-Gm-Message-State: AOJu0Yywm3VPzdroGlzoMJF1OGFgGNImpVCoBuTFjRmnVkKvYvFJNuB6
	m8hKMbGlTXusR6okpLiRsGiHLtsUETOW5Fov7ZstQKQgXM2/1iUMMoneJkVu
X-Google-Smtp-Source: AGHT+IGYwEcWxuzqxARYeSohgQo4vtZbFPSpgEOasWonV9On6ebaMyFOAQwGX5RrCYKxXFNbYKMJtQ==
X-Received: by 2002:a05:690c:380a:b0:65f:a0e5:8324 with SMTP id 00721157ae682-6ea64a9d88emr198123437b3.4.1730897716503;
        Wed, 06 Nov 2024 04:55:16 -0800 (PST)
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com. [209.85.219.174])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6ea6f5bd147sm22019747b3.10.2024.11.06.04.55.15
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Nov 2024 04:55:15 -0800 (PST)
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e29687f4cc6so5461978276.2
        for <stable@vger.kernel.org>; Wed, 06 Nov 2024 04:55:15 -0800 (PST)
X-Received: by 2002:a0d:e903:0:b0:6ea:6871:f6a8 with SMTP id
 00721157ae682-6ea6871f6f0mr118100397b3.36.1730897715363; Wed, 06 Nov 2024
 04:55:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241106120320.865793091@linuxfoundation.org> <20241106120328.478044780@linuxfoundation.org>
In-Reply-To: <20241106120328.478044780@linuxfoundation.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 6 Nov 2024 13:55:03 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWoAOzMtFWEukAfAOz-eGub2=7P0hyH2PkZKN6Pkv4LWQ@mail.gmail.com>
Message-ID: <CAMuHMdWoAOzMtFWEukAfAOz-eGub2=7P0hyH2PkZKN6Pkv4LWQ@mail.gmail.com>
Subject: Re: [PATCH 4.19 312/350] dt-bindings: power: Add r8a774b1 SYSC power
 domain definitions
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	Biju Das <biju.das@bp.renesas.com>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Greg,

On Wed, Nov 6, 2024 at 1:22=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> 4.19-stable review patch.  If anyone has any objections, please let me kn=
ow.
>
> ------------------
>
> From: Biju Das <biju.das@bp.renesas.com>
>
> [ Upstream commit be67c41781cb4c06a4acb0b92db0cbb728e955e2 ]
>
> This patch adds power domain indices for the RZ/G2N (a.k.a r8a774b1)
> SoC.

Why is this being backported?
It is (only a small subset of) new hardware support.

> Signed-off-by: Biju Das <biju.das@bp.renesas.com>
> Link: https://lore.kernel.org/r/1567666326-27373-1-git-send-email-biju.da=
s@bp.renesas.com
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Stable-dep-of: 8a7d12d674ac ("net: usb: usbnet: fix name regression")

This is completely unrelated?

> Signed-off-by: Sasha Levin <sashal@kernel.org>

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

