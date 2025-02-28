Return-Path: <stable+bounces-119978-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DF81A4A5A4
	for <lists+stable@lfdr.de>; Fri, 28 Feb 2025 23:06:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F7547AB991
	for <lists+stable@lfdr.de>; Fri, 28 Feb 2025 22:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFED41DE4D7;
	Fri, 28 Feb 2025 22:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nPmoMjVp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A691DE3A3;
	Fri, 28 Feb 2025 22:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740780236; cv=none; b=CAoMGZvSY6dyofpvt0sUUbqozGo9L7Z6mzkWrqMt3Z0TYsry/IjtmJA1rzmfNFeaqnrlBeHgiKQJ37oQkWMK3ibzMC5RVaXx02o1BAWmG/yEDtYcYL/QMtwStKd9xbWu7jX8IZT9sCSNz/7x/pOWgwzUbdPdSrF3yqYFmy/GSmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740780236; c=relaxed/simple;
	bh=AJB89FzkhwSIbHXzs/7zaZZGPG1GIi2QRgI16BLxGOI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t/lTkV/XGlP5nk7ANIr3tanNURzJboqd8ate8o2UAWwj6tjFdLbFTbrnYdbnXJD56HXJjkhiEBXOJ+k3DdPPztsf+y3+i+x/Z0Id/bevkSJM8weeclAyUIYA1w8D4qyRRO4JaXUU3Zn5kXqnwKYBdg0qIEMrmrEiA70+bOjmr6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nPmoMjVp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82329C4CED6;
	Fri, 28 Feb 2025 22:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740780236;
	bh=AJB89FzkhwSIbHXzs/7zaZZGPG1GIi2QRgI16BLxGOI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nPmoMjVplmDLnKgNTdpJMp/9BWvtz7PIMQNubFIwAKooZsBFcs95QFMcHEN3Gw4E4
	 tQ9I9TkSCDYsmwxSTmFR47mVCJ2OxmjbRmQy35IxMG0mMlc4/+fyxRI/UdZtE5/vUM
	 s/yTKfRDh3Pyt8I0Fjg1DAXB28K0qCpne2/RwUs352zf1hiN4VC5xdL1aSWedb0duq
	 ZLnkRxRZCb868YrJcV98HI6Vmd8vrIOWk9nil4mtHZ4LoNfjy+xCGK4Ey3fC+lYpDw
	 3Y7gmah0vMhqUxDcAnehiDwhVSb6Qi8CGoDkLnortrZ5WNgXXUB+WPqeYNyKN2dbsa
	 +hUgvlML+AP1g==
Date: Fri, 28 Feb 2025 14:03:54 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Philipp Stanner <pstanner@redhat.com>
Cc: Philipp Stanner <phasta@kernel.org>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Maxime
 Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Huacai Chen <chenhuacai@kernel.org>,
 Yanteng Si <si.yanteng@linux.dev>, Yinggang Gu <guyinggang@loongson.cn>,
 Feiyang Chen <chenfeiyang@loongson.cn>, Jiaxun Yang
 <jiaxun.yang@flygoat.com>, Qing Zhang <zhangqing@loongson.cn>,
 netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, Henry Chen
 <chenx97@aosc.io>
Subject: Re: [PATCH net-next v4 1/4] stmmac: loongson: Pass correct arg to
 PCI function
Message-ID: <20250228140354.5efff3fd@kernel.org>
In-Reply-To: <a7720a091ea02a6bbaa88c7311d7a642f9c7fdff.camel@redhat.com>
References: <20250226085208.97891-1-phasta@kernel.org>
	<20250226085208.97891-2-phasta@kernel.org>
	<20250227183545.0848dd61@kernel.org>
	<a7720a091ea02a6bbaa88c7311d7a642f9c7fdff.camel@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 28 Feb 2025 10:26:24 +0100 Philipp Stanner wrote:
> > Since you sent this as a fix (which.. yea.. I guess.. why not..)
> > I'll apply it to the fixes tree. But then the other patches have=20
> > to wait and be reposted next Thu. The fixes are merged with net-next
> > every Thu, but since this series was tagged as net-next I missed
> > it in today's cross merge :(
>=20
> Oh OK, I see =E2=80=93 I'm not very familiar with the net subsystem proce=
ss. So
> far I always had it like this: fire everything into Linus's master and
> Greg & Sasha then pick those with Fixes tags into the stable trees
> automatically :)

Admittedly the fixes vs linux-next material routing is a little tricky.

> Anyways, I interpret your message so that this series is done and I
> don't have to do anything about it anymore. Correct me if I'm wrong.

You need to repost patches 2,3,4 once the first patch appears in:
https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/

