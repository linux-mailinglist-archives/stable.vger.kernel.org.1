Return-Path: <stable+bounces-115003-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39048A31E81
	for <lists+stable@lfdr.de>; Wed, 12 Feb 2025 07:13:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC9EF18896B4
	for <lists+stable@lfdr.de>; Wed, 12 Feb 2025 06:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 708AD1FBCA6;
	Wed, 12 Feb 2025 06:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tSCHCxWG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 229671FBC8C;
	Wed, 12 Feb 2025 06:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739340809; cv=none; b=BETcVDsTJ8xWRen1NHmnYqtMaBNEcLqBQqVE7zlf9w3ky3vbG3biklNQDKHGgZf2B6b5Zc2UBO9yoL9t6/RFilrkiLPgdO2YF73WyqWVeWVL0CKIysSpnB+breYnPuGmpQF9Wtq5d8QBZeft8ATRp1aqmtlvlP8VU/0akjT4ds0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739340809; c=relaxed/simple;
	bh=Q2n2L7drLejKZWief1GLgiaDi8zcqK17/orvNRzGfqA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CaeX/msLZ1moOBlftvcg2E6Ed2YCxBs76nlqHQTLSTiZL4BUhSoHZa+w9ArQ3TDT6AMUYj3L8lQ6IlcMmiXFXoGQ8JupbwmXCjRmfC4AFEUSrLFMXHaQ+JtSPJ1FJ2c2eO5ohE4UJLHMA0LvcWR1oyMYg4vi9/zAVfP8+2qBmSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tSCHCxWG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80257C4CEE4;
	Wed, 12 Feb 2025 06:13:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739340808;
	bh=Q2n2L7drLejKZWief1GLgiaDi8zcqK17/orvNRzGfqA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=tSCHCxWGZIA/a5Qd0sMtoNpEYpsDkQvDBqZZ1yzrua+bd6DqCM6b1UPoiUiCMH8KC
	 +cM7p3qagVUJcrij3JozhLhQQuh1TXoBrtFNUfnYGMahJPIZdwmjpo7ofAAM5ewbS4
	 1DXXLzaBoIivSltILPtL8v/5w5TsCs/AOdjriIOLpTZ6ZncLNKb4sKrwV8bK63bYlS
	 yaV5lBUQrZzhNQ9dVPb9NQOyq0fVT1DZzdpX4EREb8L5DLCQGnnwPxHcy9zb/XVrBo
	 xQMI1T09nbINii/AjCycQ1AVsj4ZGfBtzBV9MDsrrUNAy1GFnMBjM/RxDgQOj3P7hA
	 ZrjD+bdcP2zNQ==
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5dccc90a52eso10365034a12.0;
        Tue, 11 Feb 2025 22:13:28 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVXjESUW3JFRj6czlHTMjku3tOyKRddWrJ4jMa+Wl9HwGQZJR7qyXLOEKcZfpoIa5oTUL46Z7EvbYVBTIc=@vger.kernel.org, AJvYcCW3g0omEP9R+lb3ZDlBHoygtlXrEQOd5iK7Xkzd2ZFJ7CU5SqOe1ARrE4YQa14QNTNtVM6HfCnX@vger.kernel.org, AJvYcCXBIZqcM7xXKzv6ErII0qXmp3EMQ2FxtZQQv7UwgBV/2hj9A7iLCB2bc9JNrL4ZdzJhrwec0RcX@vger.kernel.org
X-Gm-Message-State: AOJu0YxPe3DnhdjVsdO1jwAFU9ePGo12YAHw5qiJ9Gt610A0vQq7oyh1
	4HMmc2s8nIvW+Tcw+jV19qGoZpiBfDY4OZUHuu6RkhEL8Csg0poyxGAxxfbhQOYPwN0lphgmPBe
	p1jqsRDx9zJSsHK3l6dJACn9oYzU=
X-Google-Smtp-Source: AGHT+IEJhoWFl0B4q/EurHfiRdKwpyjTEuXQGyI1KUIAgu6VYDgxiA1ICSJ87mafKbliIZMIdgftEGnT2vDgyRXpem0=
X-Received: by 2002:a05:6402:42c8:b0:5d3:cfd0:8d46 with SMTP id
 4fb4d7f45d1cf-5deade0a6c9mr1645295a12.30.1739340807021; Tue, 11 Feb 2025
 22:13:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250212023622.14512-1-zhaoqunqin@loongson.cn>
 <1def2434-9033-4c83-b7de-c6364b7d3003@kernel.org> <63882ba5-0b19-308c-d3d8-0dca7509c105@loongson.cn>
In-Reply-To: <63882ba5-0b19-308c-d3d8-0dca7509c105@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Wed, 12 Feb 2025 14:13:16 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5207Mf5QCHfT-Of-e=66snNrC9F-3T24JUaTGMf1xdcA@mail.gmail.com>
X-Gm-Features: AWEUYZlxxc4vXn4MSbFenkrvUBI50CIAeOo2v3NoRWN9gng5nZcpiW1XwYm8G1Y
Message-ID: <CAAhV-H5207Mf5QCHfT-Of-e=66snNrC9F-3T24JUaTGMf1xdcA@mail.gmail.com>
Subject: Re: [PATCH V2] net: stmmac: dwmac-loongson: Add fix_soc_reset() callback
To: Qunqin Zhao <zhaoqunqin@loongson.cn>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, kuba@kernel.org, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, 
	si.yanteng@linux.dev, fancer.lancer@gmail.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Huacai Chen <chenhuacai@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 12, 2025 at 2:03=E2=80=AFPM Qunqin Zhao <zhaoqunqin@loongson.cn=
> wrote:
>
>
> =E5=9C=A8 2025/2/12 =E4=B8=8B=E5=8D=881:42, Krzysztof Kozlowski =E5=86=99=
=E9=81=93:
> > On 12/02/2025 03:36, Qunqin Zhao wrote:
> >> Loongson's DWMAC device may take nearly two seconds to complete DMA re=
set,
> >> however, the default waiting time for reset is 200 milliseconds.
> >>
> >> Fixes: 803fc61df261 ("net: stmmac: dwmac-loongson: Add Loongson Multi-=
channels GMAC support")
> > You still miss cc-stable.
> OK, thanks.
You can copy-paste the error message to commit message since you need
V3, and the title should begin with [PATCH net V3].

Huacai

> >
> > Best regards,
> > Krzysztof
>

