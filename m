Return-Path: <stable+bounces-88145-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BF249B0115
	for <lists+stable@lfdr.de>; Fri, 25 Oct 2024 13:21:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6756B216F0
	for <lists+stable@lfdr.de>; Fri, 25 Oct 2024 11:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CB561FCC63;
	Fri, 25 Oct 2024 11:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dgZYGt89"
X-Original-To: stable@vger.kernel.org
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C6391D54FE
	for <stable@vger.kernel.org>; Fri, 25 Oct 2024 11:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729855283; cv=none; b=B72IPHXrDjuLIxiCM5PpRiLHa1pHfS+e6EBIyFHmn65kJAgGZd7PwLVjE4V40c/RNv4+iS0XPh/G+d3fXm6TzOrCo214NxVlyGuPq8fiIWuryMWbmUagkyqxjwQh1vM2panpYu+WhpMtPtx07yqhrmoeqezeIKS/E1EfVa2IUaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729855283; c=relaxed/simple;
	bh=6sRf6jyLr7Lp7D8SrksXFJe24XLraz/lmXNXBNiv60s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=flwZMeQTxWRgqtJqLEvjNJvMJa+DvEM5tpzVGzIl+uWwoe/8qbe+MY+fPeeIuHMs+OzA2l249+U/lzY+HhFTLOZw4XGC/CBiAcYF2gg+1unmZcmcQ/dGEEchYrJe78ZbpniO0zZJC1g7eF+Q+2ZM+76QmL6f18tQ+0FvZeihT1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=dgZYGt89; arc=none smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-4a470d330a5so740402137.3
        for <stable@vger.kernel.org>; Fri, 25 Oct 2024 04:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1729855280; x=1730460080; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6sRf6jyLr7Lp7D8SrksXFJe24XLraz/lmXNXBNiv60s=;
        b=dgZYGt89DnwtWon5AqlfqrEyoRDGMnrEyXPIuK//Xe7dqb1i3z0MOQHNpTXpCf3X7y
         5lJ0bzsnhBo+WtTjqgHUL5xvEOJmru/CZ7/KvUz0BvnFS1Tkv/lj9xYC8uR3SIww61BQ
         xoZVD1SLn5FqtFczG9FThcTQPBVWBZZsSLXqk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729855280; x=1730460080;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6sRf6jyLr7Lp7D8SrksXFJe24XLraz/lmXNXBNiv60s=;
        b=HU+AwnITeRboT3v95mHtBx6o6/8JMUI5ZWl2reiQfOMKA1Dr3LpC+6Yy3/1dL1Kg36
         cHMuJ/XLRkxpxuWIyOUWOexc4+TvX8VRCnYOSKPWVKdWclUYOO07xDyVJLxN0F5M1EJb
         28EgtXt0E2AEfCj1SiV9LtOD9EgF15cu4jANdXW6RaG8gI6jlO63cn0VD3R6jBGu7LTk
         BdM0x0U9WacMqrXg1BiSI3gVOkHaWhSiiQ7l46UYOJ6hw6s5bEniIdUKlwWgcSHCNNPR
         66eE7MODvEuTuglZ++5NWKSWMUWiDKqU/rcb9V72GWWm4wmXNmE2MA7FxnSdEpQKTaSg
         xnjw==
X-Forwarded-Encrypted: i=1; AJvYcCWSGYgAsLf7ZZeYOevnTlTj2QIQ9uxqIpSsy7G++y6hbCTltEEAkGxNOxK+4jSvssXJGqizSTg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGTz5FOaxTKN5k5317e6CvWAe6j7y16Qcj/15fRWpoQi/jMWVA
	jK46j1lYXb1/1PcIQTjZXJ9Tez6H6WhW4XLNicr1YPvJFxZZsKKhGgYUtu2csSntZCed3Pw5GWc
	I0Q==
X-Google-Smtp-Source: AGHT+IGuQgeBfGJaEzSV7p/GoFDHoMrqeVFOODAK3zb08Pxtqj1oNnTcxQJe4jwRdRUs1ikRzRsinQ==
X-Received: by 2002:a05:6102:a47:b0:4a4:8346:186d with SMTP id ada2fe7eead31-4a751cbd6ffmr12043823137.26.1729855280025;
        Fri, 25 Oct 2024 04:21:20 -0700 (PDT)
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com. [209.85.222.42])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4a8c520989fsm171030137.3.2024.10.25.04.21.19
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Oct 2024 04:21:19 -0700 (PDT)
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-84fd057a993so686393241.3
        for <stable@vger.kernel.org>; Fri, 25 Oct 2024 04:21:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWEfMTjG88+di9zHkr8PhGybwODLnHOWAJ2ZEYa0C1DSLCkBdIJpZodgjcbwaYx94ilJh9KOjM=@vger.kernel.org
X-Received: by 2002:a05:6102:a47:b0:4a4:8346:186d with SMTP id
 ada2fe7eead31-4a751cbd6ffmr12043723137.26.1729855278733; Fri, 25 Oct 2024
 04:21:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241025075630.3917458-1-wenst@chromium.org> <20241025075630.3917458-2-wenst@chromium.org>
In-Reply-To: <20241025075630.3917458-2-wenst@chromium.org>
From: Fei Shao <fshao@chromium.org>
Date: Fri, 25 Oct 2024 19:20:42 +0800
X-Gmail-Original-Message-ID: <CAC=S1nip+CN=YEA7qWgZzx4wY666Qpn1-S2yMHw_jQTcjGcRDg@mail.gmail.com>
Message-ID: <CAC=S1nip+CN=YEA7qWgZzx4wY666Qpn1-S2yMHw_jQTcjGcRDg@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: dts: mediatek: mt8183: Disable DSI display
 output by default
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, devicetree@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 25, 2024 at 3:58=E2=80=AFPM Chen-Yu Tsai <wenst@chromium.org> w=
rote:
>
> Most SoC dtsi files have the display output interfaces disabled by
> default, and only enabled on boards that utilize them. The MT8183
> has it backwards: the display outputs are left enabled by default,
> and only disabled at the board level.
>
> Reverse the situation for the DSI output so that it follows the
> normal scheme. For ease of backporting the DPI output is handled
> in a separate patch.
>
> Fixes: 88ec840270e6 ("arm64: dts: mt8183: Add dsi node")
> Fixes: 19b6403f1e2a ("arm64: dts: mt8183: add mt8183 pumpkin board")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>

Reviewed-by: Fei Shao <fshao@chromium.org>

