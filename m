Return-Path: <stable+bounces-113952-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B95E7A297CE
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 18:46:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD98D169598
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 17:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 372991FDE0A;
	Wed,  5 Feb 2025 17:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M+DXVKsq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE19E1FC108;
	Wed,  5 Feb 2025 17:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738777233; cv=none; b=Gbq0CEob8MLDCWQfnGRmoIi7N003Y8YRECnFY3nV+mTLEooaoSLtSW55eSd4tdjZOZUzIuHl31YDJkfwEnRdmIYYg9Q4z7A5qI35oNudEFRuS+FDEk+xDhPVprG34Tb5mAuf7hDMJpGXS2GOYSFlmEZ9a/nhK3Yq9skEYVeVzy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738777233; c=relaxed/simple;
	bh=I4jW9o/4B+Z8UC6sywEnjRYy1f2QJpfv+cAZ+qa4pnw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I6jO4fF0NW92lL06wZMIaGaxLuFrbzYc6Ic9WPHgUZtJ7P9IxKUet9vx1DXCo+ZxrWLRcOypFGh7rZGa1xGtJsoD1E4gP2kWXPEEa2+kjE88txkbgcXoXr8VesO8xjCLVdJmAW09kWObI/0XDfXEWEs78xrIMMk3KUSPdewgE1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M+DXVKsq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53C9CC4CEE2;
	Wed,  5 Feb 2025 17:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738777232;
	bh=I4jW9o/4B+Z8UC6sywEnjRYy1f2QJpfv+cAZ+qa4pnw=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
	b=M+DXVKsqzuEqwi8PgguM2uouwIcSnsgTqEJs/U/Ab4o/wHhEsrjT3DkDeTfRsLxKF
	 UKf+bY9qowD5PyJTJakWcXUQNxDljxBAF0iSYLe21Y+d+0ZAqcPJix4TT/6hWvloMm
	 KQeZ4MpJai34ciLaaMamAn1Y8Kgg02hgH3DIlZdyxaP1EmXnisBBOGNpDHQJcRW3W5
	 uGXV0xZTbILmebKO+XcZXeW7G5hRbHDsNsdgMpu+M8N3qiTeztV9hI4I/GqsL+HBjH
	 tpKbyYHTdMD5GqZwtf3bp/bUy2fcmaTs4T5x90Pp4HsxkLRIFe4qLACrQghtHCDAHK
	 xOTA1hogj174Q==
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-543e49a10f5so11551e87.1;
        Wed, 05 Feb 2025 09:40:32 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUOjjMLcE1nMuhpArRFnZP5GgyhTwnFrgW96wx3NvPQvs3wsT2M4Iqm5RVAOFxK0wxQE+/jdyE/@vger.kernel.org, AJvYcCVzHSV7lgLPV5UwssHKzaqlRzu5M32SzIE5hTx8mvL3SzmyDifgX+xk6YQ4Gem5Ml9NovHzRzCnSym0v74=@vger.kernel.org, AJvYcCXyS2J/J8Wayadjcf0snmt4UKb49vNuwkANC/dcAGvRLs4BVkwOUG5jv8yphFSfCLpcN0LFHwQB@vger.kernel.org
X-Gm-Message-State: AOJu0YwaG8mygbF5L0nm4lXnlb2FE065pe5a4ZDN81yH+g800jVLTof3
	Kt5+pULgbp54J2Oua5zHVIrRrSwgwrpytI8f5IBJPA7wfLJkinWtKAQUAwoFTxaCn3ToH346r3X
	KxnrDJQnLIAqS0WTeebFsN3SXlAI=
X-Google-Smtp-Source: AGHT+IG8lhakou025la5Jappucv8WLtdehhFKE96djLZ79QU2Y1TtjR/MkLvLzNVVS5NW5nvfFdoY99dvlkSP3I4BEQ=
X-Received: by 2002:a05:6512:3e03:b0:543:e3e2:879e with SMTP id
 2adb3069b0e04-54405a7b6c1mr1242587e87.51.1738777230659; Wed, 05 Feb 2025
 09:40:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250204161359.3335241-1-wens@kernel.org> <20250204134331.270d5c4e@kernel.org>
 <CAGb2v641vvtVKv8QbiEfHnMWngcKYTJZAgfH5k+G_nOvZcbC9g@mail.gmail.com> <20250205173824.GJ554665@kernel.org>
In-Reply-To: <20250205173824.GJ554665@kernel.org>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Thu, 6 Feb 2025 01:40:17 +0800
X-Gmail-Original-Message-ID: <CAGb2v64CZWZwC7T9NNN7Re8pkCLQZEh3bcraYjcQRyVxtJgS5w@mail.gmail.com>
X-Gm-Features: AWEUYZksuSbRuZZAzWd77ituAitD1pgvI4pAn_LVLBqoUUFzO5mWdzzigczPLts
Message-ID: <CAGb2v64CZWZwC7T9NNN7Re8pkCLQZEh3bcraYjcQRyVxtJgS5w@mail.gmail.com>
Subject: Re: [PATCH netdev] net: stmmac: dwmac-rk: Provide FIFO sizes for
 DWMAC 1000
To: Simon Horman <horms@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Heiko Stuebner <heiko@sntech.de>, 
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, Steven Price <steven.price@arm.com>, 
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, netdev@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-rockchip@lists.infradead.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 6, 2025 at 1:38=E2=80=AFAM Simon Horman <horms@kernel.org> wrot=
e:
>
> On Wed, Feb 05, 2025 at 11:45:17AM +0800, Chen-Yu Tsai wrote:
> > On Wed, Feb 5, 2025 at 5:43=E2=80=AFAM Jakub Kicinski <kuba@kernel.org>=
 wrote:
> > >
> > > On Wed,  5 Feb 2025 00:13:59 +0800 Chen-Yu Tsai wrote:
> > > > Since a fix for stmmac in general has already been sent [1] and a r=
evert
> > > > was also proposed [2], I'll refrain from sending mine.
> > >
> > > No, no, please do. You need to _submit_ the revert like a normal patc=
h.
> > > With all the usual details in the commit message.
> >
> > Mine isn't a revert, but simply downgrading the error to a warning.
> > So... yet another workaround approach.
>
> I think the point is that someone needs to formally
> submit the revert. And I assume it should target the net tree.

Russell sent one a couple hours ago, so I think we're covered.

