Return-Path: <stable+bounces-189093-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C06FC0093F
	for <lists+stable@lfdr.de>; Thu, 23 Oct 2025 12:53:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB3D53A3A70
	for <lists+stable@lfdr.de>; Thu, 23 Oct 2025 10:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C6F9306B08;
	Thu, 23 Oct 2025 10:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="frWti8oe"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33426309DA1
	for <stable@vger.kernel.org>; Thu, 23 Oct 2025 10:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761216782; cv=none; b=LVDqz1FZn52TNIc7jUJOP4F4w2xtXDNG4YmLNxqNuYB7mKhGdjrfXs9s+5JB5p/FAjQxPrWCmKOotIN2Y1gdLpPuK+T4SdoXwBNoBbNKM9fJDwBfEXfSCfV6LgLYykwbOkkWtB23w18mx2kZujL7UXkwRm9wz9/+8Ilvu2Op+Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761216782; c=relaxed/simple;
	bh=+vMUjxVk+nS+BilhYa3CMtB+EET0zgU8rBG6KfAsYNI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=beT8xeF0W/7vExeLiIjsO2IEd6k0b7P/n1HJLGF24a5wnYGywCHDhBD0+gKBKFdhk8zZrlyEspL4NakxoF8hQc1iPd9KSlYm72w6zshAeMHEAJy62vEaHHKZxyLsLnBmkzM5IllyDtPFQ6zf/OkSOuNJSH9auHcAnwd1rOA5d3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=frWti8oe; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-470ffbf2150so11981195e9.1
        for <stable@vger.kernel.org>; Thu, 23 Oct 2025 03:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761216779; x=1761821579; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+vMUjxVk+nS+BilhYa3CMtB+EET0zgU8rBG6KfAsYNI=;
        b=frWti8oeRBLu+QB6bESi/iuVYjSFqXMBUwngM/QfNOF/e3Ng1iNKsMJXQHBuypa2B8
         zpF5RBc8CR175HiU9jLzYLIZz9IXjGL3r3n0fPSwJuGUgb11GsYQ77bYUOczAu8Lrg3A
         PMb5rcR9NhLkCivvZJhr8sy5cGTi0zLNH6lSWgAbhYHWe+jPomKYPY+dCWcgttLYSKPc
         1muu8SIhdCkJYlcYpITu29QL2/ng1avo4uMNvD4Xfp4S60j4Kex2lPc3+O87fbxRIvgz
         dJuQ+ms/Y0+qonH80kIhtpGhPrjpR6iefBYv3T0tYa0lV3VucJMSWMmhO3UNl+Z4aw9N
         dLQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761216779; x=1761821579;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+vMUjxVk+nS+BilhYa3CMtB+EET0zgU8rBG6KfAsYNI=;
        b=YP854VxJXhxXpJlBLD9lda4BLhU/LAEQQHalCdmv0hfpxPOxs4bja3OolrKrkbO8u9
         ExiwDNvqqwXpSw265IK35WtDj7RncHJCvv2mOFKuXS8P0amTtEZ5bSL58ll0epT/DITj
         XvUI3YLkbEkvME7VJZ0zgfx326pdnf8sl/hf6NPKDa7L7Auxn3q/CTYdIeJGI83VGeMB
         Hzr2TXsdo2Fk9+MsYEg/IvdetZx7Tc+5PkCSVY8p9m+5I+TYyAk6rSMScqJWpzk3L2Oa
         bcxWruu+XqvwYUGl79GVia07nTKpn5nCi8W3cczzFhMTaoQVWE7UK7w6EY5l7HYDHjE6
         XESw==
X-Forwarded-Encrypted: i=1; AJvYcCVEYPGKUIQTLpn0mDYp990pkmEe322TsIA6OHPC9e2umTYUXC+umYP3CZjP0kfqMpPTnddH0MA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzycAY4R3+tM4kDbok5VHrTBK63Z/ot6hUbVfusZ274x0bjhn2e
	eQ4/QED8L0iNP6KW+Xwq27JR7gIzkVhO4mHQWPappXA/n2TiIELdhlZw+ayI86mS7juRr9akQDR
	JPLCxQnIjsQFYW5Hv6YJZjVDJ3xvK2ZA=
X-Gm-Gg: ASbGncuuYAqsJ5DhNOfEzdPi3C6lnFkRlguy4UEH4VFIH+E6z4QBbs5hyYWnALe5KMf
	rcqbStRTANIXR409KbiYepRluWVQG+5m40Brm/mITEnWyDtTPRfHR8FETKTlA8QCYXqZYdThgnC
	eoMnoAEkH7SzFA5PIGupOr2UV9RX3mB4Ze1PDioz8KSv9C6LLAYKmORApi/PSl/n3GqEH3OJtpP
	Zhtmm1/deRY6LfqX9ECkyZG0KcjPYvnHz7NCmi4mGM72KTAsjlmfWtBDoETeg==
X-Google-Smtp-Source: AGHT+IEq+zNMHj9WPfjzhOgVqdeT8MY8s9ConstnjU+A+nm1h37hA1lLmbMQ890yX6bv5OV3H8gCIbax8AgydOiwcEc=
X-Received: by 2002:a05:6000:2312:b0:3e7:6424:1b47 with SMTP id
 ffacd0b85a97d-4285324c1ecmr5374774f8f.6.1761216779388; Thu, 23 Oct 2025
 03:52:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251017151830.171062-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20251017151830.171062-3-prabhakar.mahadev-lad.rj@bp.renesas.com> <20251022181348.1e16df68@kernel.org>
In-Reply-To: <20251022181348.1e16df68@kernel.org>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Thu, 23 Oct 2025 11:52:33 +0100
X-Gm-Features: AWmQ_bkmX85GH1EUjJGjidbFOCdBNnjQxmkV7py__nnaP17JZzd2tI33jtRLgQg
Message-ID: <CA+V-a8un_DQdQcg+kQUs_HCRK15H-K3dW_yBtWXWzH9RMARJ_Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] net: ravb: Allocate correct number of queues based
 on SoC support
To: Jakub Kicinski <kuba@kernel.org>
Cc: =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>, 
	Paul Barker <paul@pbarker.dev>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Mitsuhiro Kimura <mitsuhiro.kimura.kc@renesas.com>, netdev@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, stable@vger.kernel.org, 
	=?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jakub,

Thank you for the review.

On Thu, Oct 23, 2025 at 2:13=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Fri, 17 Oct 2025 16:18:28 +0100 Prabhakar wrote:
> > On SoCs that only support the best-effort queue and not the network
> > control queue, calling alloc_etherdev_mqs() with fixed values for
> > TX/RX queues is not appropriate. Use the nc_queues flag from the
> > per-SoC match data to determine whether the network control queue
> > is available, and fall back to a single TX/RX queue when it is not.
> > This ensures correct queue allocation across all supported SoCs.
>
> Same comment as on patch 1, what is the _real_ problem?
> Allocating a bit too much memory is not an stable-worthy issue.

Ok, I will drop the fixes tag and cc to stable and post it for net-next.

Cheers,
Prabhakar

