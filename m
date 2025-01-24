Return-Path: <stable+bounces-110358-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8254A1B042
	for <lists+stable@lfdr.de>; Fri, 24 Jan 2025 07:13:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7CFE167003
	for <lists+stable@lfdr.de>; Fri, 24 Jan 2025 06:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD8C71D9598;
	Fri, 24 Jan 2025 06:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JwJ2E3Qt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60ECA1D8DF6;
	Fri, 24 Jan 2025 06:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737699191; cv=none; b=s2Ow0I6BJOpm+nVWgWMUsHuSPQvMxvE/hCEQKbJAZB2BKGHpVQLVne1MKdsw37lq6dTn3tJeWvJ3CRm3MrOd+rRvdl6FSShVD435WqTw9xG+1GPBmVvg5ep9ByKOtQETmMACfR5DrfM7awLjt1/UPfhjCpbLxcTXyefRydac0nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737699191; c=relaxed/simple;
	bh=qGxtlaDPGI4qgJEfU1CzjFFIez57BNjY9kaJckOvRqs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tAssmeO/4URAvVl/IDoU6a0N5yr6WrDgGT0+96YsxiHxgmp8EQzIPc9OiraDTpKJttYwfaIstyaXDsmwp7S3yED5bnCAtdIwktH4/Lk6YuKQ40lRPCiAwM7pb/1lvlr6uv6+StWLOxRnuUPKvIYhbcM0gHoeVDY//KxhGAXPxZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JwJ2E3Qt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 489E7C4CED2;
	Fri, 24 Jan 2025 06:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1737699190;
	bh=qGxtlaDPGI4qgJEfU1CzjFFIez57BNjY9kaJckOvRqs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JwJ2E3Qtz1w+5Q/ZBNjeosZEZkZ6Hh4ZFpVsbrpgz5SDqHcis7tvlLJ1VVaG7ocMB
	 iIrkNSKs9q3Mr/z2QPAlEUKezDlgVRZAggibTAw8qkwjVYRDIBIH6HCuYfCzyXNEez
	 V8ZtWjkWuTf2fGTLvSHyqb8y//mIrXIde3IhyPvw=
Date: Fri, 24 Jan 2025 07:13:07 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Keerthana Kalyanasundaram <keerthana.kalyanasundaram@broadcom.com>
Cc: stable@vger.kernel.org, marcel@holtmann.org, johan.hedberg@gmail.com,
	luiz.dentz@gmail.com, davem@davemloft.net, kuba@kernel.org,
	linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com, vasavi.sirnapalli@broadcom.com,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	syzbot <syzkaller@googlegroups.com>,
	Eric Dumazet <edumazet@google.com>, Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH v5.10-v5.15] Bluetooth: RFCOMM: Fix not validating
 setsockopt user input
Message-ID: <2025012441-march-yiddish-2df5@gregkh>
References: <20250120064647.3448549-1-keerthana.kalyanasundaram@broadcom.com>
 <2025012010-manager-dreamlike-b5c1@gregkh>
 <CAM8uoQ8pb+or9ptdvg6q5MpRskH5Xu8x=rTm-tdcLifDSmQ8=g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM8uoQ8pb+or9ptdvg6q5MpRskH5Xu8x=rTm-tdcLifDSmQ8=g@mail.gmail.com>

On Fri, Jan 24, 2025 at 11:13:53AM +0530, Keerthana Kalyanasundaram wrote:
> On Mon, Jan 20, 2025 at 9:11 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Mon, Jan 20, 2025 at 06:46:47AM +0000, Keerthana K wrote:
> > > From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > >
> > > [ Upstream commit a97de7bff13b1cc825c1b1344eaed8d6c2d3e695 ]
> > >
> > > syzbot reported rfcomm_sock_setsockopt_old() is copying data without
> > > checking user input length.
> > >
> > > BUG: KASAN: slab-out-of-bounds in copy_from_sockptr_offset
> > > include/linux/sockptr.h:49 [inline]
> > > BUG: KASAN: slab-out-of-bounds in copy_from_sockptr
> > > include/linux/sockptr.h:55 [inline]
> > > BUG: KASAN: slab-out-of-bounds in rfcomm_sock_setsockopt_old
> > > net/bluetooth/rfcomm/sock.c:632 [inline]
> > > BUG: KASAN: slab-out-of-bounds in rfcomm_sock_setsockopt+0x893/0xa70
> > > net/bluetooth/rfcomm/sock.c:673
> > > Read of size 4 at addr ffff8880209a8bc3 by task syz-executor632/5064
> > >
> > > Fixes: 9f2c8a03fbb3 ("Bluetooth: Replace RFCOMM link mode with security level")
> > > Fixes: bb23c0ab8246 ("Bluetooth: Add support for deferring RFCOMM connection setup")
> > > Reported-by: syzbot <syzkaller@googlegroups.com>
> > > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > > Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > > Signed-off-by: Sasha Levin <sashal@kernel.org>
> > > Signed-off-by: Keerthana K <keerthana.kalyanasundaram@broadcom.com>
> > > ---
> > >  net/bluetooth/rfcomm/sock.c | 14 +++++---------
> > >  1 file changed, 5 insertions(+), 9 deletions(-)
> >
> > This breaks the build on 5.15.y systems, did you test it?
> >
> > I'm dropping both patches now, please be more careful.
> >
> Apologies for the build breakage. I will be more careful in the future.
> v5.15.y:
> one patch is missing in v5.15.y. I have added that patch
> https://lore.kernel.org/stable/20250124053306.5028-1-keerthana.kalyanasundaram@broadcom.com/T/#t
> v5.10.y:
> No changes needed. you can pick the same patch from the email chain for v5.10.y

From what "email chain"?  Please just send a v5.10.y patch as well to
make it obvious what we are supposed to do here.

confused,

greg k-h

