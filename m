Return-Path: <stable+bounces-125948-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BF79A6E016
	for <lists+stable@lfdr.de>; Mon, 24 Mar 2025 17:44:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37731188A15E
	for <lists+stable@lfdr.de>; Mon, 24 Mar 2025 16:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B568D262D1D;
	Mon, 24 Mar 2025 16:44:32 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B9E261570
	for <stable@vger.kernel.org>; Mon, 24 Mar 2025 16:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742834672; cv=none; b=JawuB+/R+/XYS/iP01Ymkubva/lR8dl80cjILkORPKBkSZxLwE8hRBxuGAWVjiTWOOcK6gFVrOIwjkZEcAALNQ3aQJnBvi7eQqwSWl/DmYDalKFzS9+64mYfNGPyUgB++/vE8TJniOSAJpHci9GhMgM/J/FIPWIuNSdI9pDapNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742834672; c=relaxed/simple;
	bh=DjUACTu726dVWfgjHtXmNnMLdMsSKHPLE7cUPQbBk2Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ef2B/RaHCAyHxe6bJ9K6893RRxcd8VpNGUow+0Wfu1T/Mwvy6dP8xAcJtadNmOnLGRRDP9+IJAzubGkjKpcAA/HAeJ5Z9Hl38ZH6V5W2axe/fdmESpeAb+CPBd0QIzIR1bGCzt50pRYrawL0QIDhU87pyOmkkY98K0tn9IH1B3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-524168b16d3so4494406e0c.0
        for <stable@vger.kernel.org>; Mon, 24 Mar 2025 09:44:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742834668; x=1743439468;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=23D3dwxPLFvtu4gZWVM/aTYy4VGzkkiDc3PZ9HqBfL4=;
        b=udqbUvihSReJkyEogvT+DbtSq07hjMNyXj4Nim3rGxFVIGU4t7FdRovNNWT6bYs4JA
         5xLKY0CnGBnyf/pXtniu9c1ZDSieLajRaRv2T9bCVdXWOqHnAz94f6RGpI7syo8pteDR
         uAsSyf6aZTsJgFRn/p2OG828hkDiJBgeVCE2IJWlhm0J8PpAmRT2a2gVQscrE+N9maqj
         f/NMMTV7+Q2J+0Fl6LI5E8GNY5Gz2rR5APQOe7XSOynsDVkc7oWKv7vY9f+FCb8QELs9
         oog5zUYIsFOrr9KkQIbEFjAF0IxqFecgy/qHUay5EUWg2VtvMF7CwMp8MMkiPDCIBXUT
         5+/A==
X-Forwarded-Encrypted: i=1; AJvYcCVKTnnUPO5sDH9hzwotx/+zKrRM+6Pu+HMN1VUzHtGYLoVsIEZFAXYpFiIky3kI12N5P9LtpT4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCO2+V+Agp/HJ+JnEXnKdr3tbNKqoyxCglmsfFXjRsqbmmuPPx
	Zjd3k3PKUI2Mp9rBLqaBlUC789NeFgATXzXPAgKAHICwfTAC+bhWlmTPzNEL
X-Gm-Gg: ASbGncvyk+ta1RqbTCfMNBn4xE8U3+5c0Boa9mjgiuOl+/labF39BgD6N7s+HK3yMXl
	SV1liaFikQyhiOBYjGIOdahPfMHNk3pSn7VOGgodcmbHvo3fOC+DCchLhEvUevFKB5fDIT1j4qX
	lyoORW1jTOO/2a9xqBzUfOy+D0Nj1B8VSmXjmHRlSZkOq4Kxcu/217X4hqVcd+nE+hCs62Sf6Em
	aSyw3dVTWUNdToY7LX+IRMdi+gUKeuhyavOzsZOcNql4faLoOJoyn9pPiyJAEe/pm5Tm2nS2Xu1
	yS5xxOKSgjS+QAiqTv1QONanqBLPqTDWu1TB3aI1YlWyBalx88a5762EOu+8QiwCXIyN9FIOi86
	qClzqQww=
X-Google-Smtp-Source: AGHT+IF4MkU+lWEPZExd55qqDN8agiEVHx94Zw6Og7HQ/T2DfjWN2Xk+pzepUYfD3sWIgPGv4hxsiQ==
X-Received: by 2002:a05:6122:894:b0:523:91e8:324c with SMTP id 71dfb90a1353d-525a8546202mr9403280e0c.8.1742834667716;
        Mon, 24 Mar 2025 09:44:27 -0700 (PDT)
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com. [209.85.222.44])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-525a735bfaasm1452885e0c.2.2025.03.24.09.44.27
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Mar 2025 09:44:27 -0700 (PDT)
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-86ba07fe7a4so3965056241.2
        for <stable@vger.kernel.org>; Mon, 24 Mar 2025 09:44:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXNjZmjsXZ6OYhPrH7k8TPgS3jL6PvqH7Es5u1xE1tsr8edDkRa5YdIKwpI/0y4pqooPkfPxYU=@vger.kernel.org
X-Received: by 2002:a05:6102:3e8b:b0:4c1:7be4:eb61 with SMTP id
 ada2fe7eead31-4c50d626249mr9254121137.25.1742834667104; Mon, 24 Mar 2025
 09:44:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2025032438-fanatic-tubular-1dae@gregkh>
In-Reply-To: <2025032438-fanatic-tubular-1dae@gregkh>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 24 Mar 2025 17:44:15 +0100
X-Gmail-Original-Message-ID: <CAMuHMdX9X8iTgYGHPw+TuEA-OiWnqGU3zzZGev3RYYkP=QNFdQ@mail.gmail.com>
X-Gm-Features: AQ5f1JopA_1t_I2IWEsI7ouw6aAF_CFT8vJDaO-WY2GPNpNVkUpDGKtM6tT1jVU
Message-ID: <CAMuHMdX9X8iTgYGHPw+TuEA-OiWnqGU3zzZGev3RYYkP=QNFdQ@mail.gmail.com>
Subject: Re: FAILED: patch "[PATCH] can: rcar_canfd: Fix page entries in the
 AFL list" failed to apply to 5.15-stable tree
To: gregkh@linuxfoundation.org
Cc: biju.das.jz@bp.renesas.com, mkl@pengutronix.de, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Greg,

On Mon, 24 Mar 2025 at 16:28, <gregkh@linuxfoundation.org> wrote:
> The patch below does not apply to the 5.15-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.

The issue fixed by this patch only shows up with more than two channels.
Given support for more than two channels was only added in commit
45721c406dcf50d4 ("can: rcar_canfd: Add support for r8a779a0 SoC")
in v5.18, I think backporting to v5.10 and earlier is not needed.
CiP uses v6.1, which is receiving the backport.

Biju: please correct me if I'm wrong.

Thanks!

> ------------------ original commit in Linus's tree ------------------
>
> From 1dba0a37644ed3022558165bbb5cb9bda540eaf7 Mon Sep 17 00:00:00 2001
> From: Biju Das <biju.das.jz@bp.renesas.com>
> Date: Fri, 7 Mar 2025 17:03:27 +0000
> Subject: [PATCH] can: rcar_canfd: Fix page entries in the AFL list
>
> There are a total of 96 AFL pages and each page has 16 entries with
> registers CFDGAFLIDr, CFDGAFLMr, CFDGAFLP0r, CFDGAFLP1r holding
> the rule entries (r = 0..15).
>
> Currently, RCANFD_GAFL* macros use a start variable to find AFL entries,
> which is incorrect as the testing on RZ/G3E shows ch1 and ch4
> gets a start value of 0 and the register contents are overwritten.
>
> Fix this issue by using rule_entry corresponding to the channel
> to find the page entries in the AFL list.
>
> Fixes: dd3bd23eb438 ("can: rcar_canfd: Add Renesas R-Car CAN FD driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Link: https://patch.msgid.link/20250307170330.173425-3-biju.das.jz@bp.renesas.com
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

