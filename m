Return-Path: <stable+bounces-166665-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C391DB1BDB9
	for <lists+stable@lfdr.de>; Wed,  6 Aug 2025 02:05:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A51C04E2F07
	for <lists+stable@lfdr.de>; Wed,  6 Aug 2025 00:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E5173C01;
	Wed,  6 Aug 2025 00:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gnuweeb.org header.i=@gnuweeb.org header.b="DHMYWxAz"
X-Original-To: stable@vger.kernel.org
Received: from server-vie001.gnuweeb.org (server-vie001.gnuweeb.org [89.58.62.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C558D136E;
	Wed,  6 Aug 2025 00:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.62.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754438741; cv=none; b=jaSSSOc2o6hie7yOasOBCK9wdVCwo7OqPKggQEjRt4EeTLIm8aFXzeRXhbb1kqQJzSP1dNZvmKhswDPaQN/akGrwICZb+eP9DHY/F9rvCUkh+TD3/UmVNJ9R1vb4IVRGJXye0FYkd14IXEMWXiRi2J6ieDoT+6iDXTNCXKSjOCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754438741; c=relaxed/simple;
	bh=bj+RZzaHVNpoliwAGa9XYm5UNfnwharwglOw4U7Tgek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KuKH9lZ8XL1+Vl7cT25KeXbatugXLAbNE3wp0T9g+ChhS0gEFL/KVWspRRrQJVal63LBQGomavPjPjp57D9kN3IXTW1PaEFzp5a29phvw+xpISNKrva5cN2BADPulDE5Q0CMyF7kAEqXlKkQUWmLtvwwjA5CunLA43mTPiaM3Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gnuweeb.org; spf=pass smtp.mailfrom=gnuweeb.org; dkim=pass (2048-bit key) header.d=gnuweeb.org header.i=@gnuweeb.org header.b=DHMYWxAz; arc=none smtp.client-ip=89.58.62.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gnuweeb.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gnuweeb.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
	s=new2025; t=1754438735;
	bh=bj+RZzaHVNpoliwAGa9XYm5UNfnwharwglOw4U7Tgek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To:Message-ID:Date:From:Reply-To:Subject:To:
	 Cc:In-Reply-To:References:Resent-Date:Resent-From:Resent-To:
	 Resent-Cc:User-Agent:Content-Type:Content-Transfer-Encoding;
	b=DHMYWxAzEHmz4jrtg4O2K9dt+cvr7lk8rcZbxE7YxjADTg88lqrB0djeyOMu8zMbl
	 7QydPwCg4ew9mpGnnokAdOBscZ9CCVFk7mUlUVVL4pj/mv7IdmZc3FsS2VHCPseB02
	 mdEeOw0aeX1EG5pOH5zHWD2HbdQOBpPqtd2re1Si1JsAw7iIc87jDeG/XsmDEZlwJX
	 2GCMUGkDDoP7MyEY7QvLtC1gq52P8+0W+znBjcEKdnucdiWYMgmURuu/Q1aIVCrrT7
	 p9L90MNfz3R5WAA3t1FGqC44hyPwGQFSvs4516pCBVXMt6fvprekpkUO7bAUhLzIAV
	 E6wm0DosSW6kA==
Received: from linux.gnuweeb.org (unknown [182.253.126.229])
	by server-vie001.gnuweeb.org (Postfix) with ESMTPSA id 3F29A3127C24;
	Wed,  6 Aug 2025 00:05:32 +0000 (UTC)
X-Gw-Bpl: wU/cy49Bu1yAPm0bW2qiliFUIEVf+EkEatAboK6pk2H2LSy2bfWlPAiP3YIeQ5aElNkQEhTV9Q==
Date: Wed, 6 Aug 2025 07:05:29 +0700
From: Ammar Faizi <ammarfaizi2@gnuweeb.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Simon Horman <horms@kernel.org>, Oliver Neukum <oneukum@suse.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Linux Netdev Mailing List <netdev@vger.kernel.org>,
	Linux USB Mailing List <linux-usb@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Armando Budianto <sprite@gnuweeb.org>, gwml@vger.gnuweeb.org,
	stable@vger.kernel.org, John Ernberg <john.ernberg@actia.se>
Subject: Re: [PATCH net v2] net: usbnet: Fix the wrong netif_carrier_on()
 call placement
Message-ID: <aJKcSZCirArmH2/c@linux.gnuweeb.org>
References: <20250801190310.58443-1-ammarfaizi2@gnuweeb.org>
 <20250804100050.GQ8494@horms.kernel.org>
 <20250805202848.GC61519@horms.kernel.org>
 <CAHk-=wjqL4uF0MG_c8+xHX1Vv8==sPYQrtzbdA3kzi96284nuQ@mail.gmail.com>
 <aJKaHfLteSF842IY@linux.gnuweeb.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJKaHfLteSF842IY@linux.gnuweeb.org>
X-Machine-Hash: hUx9VaHkTWcLO7S8CQCslj6OzqBx2hfLChRz45nPESx5VSB/xuJQVOKOB1zSXE3yc9ntP27bV1M1

On Wed, Aug 06, 2025 at 06:56:20AM +0700, Ammar Faizi wrote:
> Apart from moving it outside that if-statement, unlink_urbs() call
> should probably also be guarded as we agreed it makes no sense to call
> it when we're turning the link on.

Oh, no.

I just realized, it does need to be guarded because if netif_carrier_on()
is placed before the if (!netif_carrier_ok(dev->net)), it already clears
__LINK_STATE_NOCARRIER.

-- 
Ammar Faizi


