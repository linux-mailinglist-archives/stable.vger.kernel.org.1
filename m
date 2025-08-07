Return-Path: <stable+bounces-166751-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 07993B1D023
	for <lists+stable@lfdr.de>; Thu,  7 Aug 2025 03:37:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB6FB18A531D
	for <lists+stable@lfdr.de>; Thu,  7 Aug 2025 01:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C55BA19DF6A;
	Thu,  7 Aug 2025 01:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gnuweeb.org header.i=@gnuweeb.org header.b="oJCW887q"
X-Original-To: stable@vger.kernel.org
Received: from server-vie001.gnuweeb.org (server-vie001.gnuweeb.org [89.58.62.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C3EEC4;
	Thu,  7 Aug 2025 01:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.62.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754530663; cv=none; b=Dk0JLkpb12/r9D5o1l5GUwHZ5PYIdTSpXiUae4ag7GoC/MU8hEGYvP/ROSWgH+eowLfgsxyYp+2QHphqXjHnMfT3BuMlXB3n9axv+VMK8eqHBSxBp1HHt/ObCdCDyV6wjCqt4FjjL1F7dhvfOhpWzCl4Ib6yxJrXf/2rU+B/sUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754530663; c=relaxed/simple;
	bh=ce65IqiN2VyqeISLJNiRFdmLyT7oo1QL65dXx6+DtR8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cR5V3WJrLRz9fBn41oywVgeUwYOeoX1Sv4fGyrzdz+/GKobP19q41BNFHosBfnexnrL+rlGhJJ4Xjh8NcyczWzjom7ccOgUahE3h9EL5Sqb3xAAg9JZh+9xvb0WmDdhZqYSBRYSy8YLt+gieY0foDU0UnnOy/GoL6LYv3A8z+WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gnuweeb.org; spf=pass smtp.mailfrom=gnuweeb.org; dkim=pass (2048-bit key) header.d=gnuweeb.org header.i=@gnuweeb.org header.b=oJCW887q; arc=none smtp.client-ip=89.58.62.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gnuweeb.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gnuweeb.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
	s=new2025; t=1754530653;
	bh=ce65IqiN2VyqeISLJNiRFdmLyT7oo1QL65dXx6+DtR8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To:Message-ID:Date:From:Reply-To:Subject:To:
	 Cc:In-Reply-To:References:Resent-Date:Resent-From:Resent-To:
	 Resent-Cc:User-Agent:Content-Type:Content-Transfer-Encoding;
	b=oJCW887qTh75G6bKT8AkskQKWDq5I394sVFXgJxcRQlDOFBbKOmaZLu1+c8YDFzwP
	 g5hhi+5tLzUqXFqE53vK5Bl78/c9XxnmOpKUafIlS5WU7JQvp1z3/NCkrfgTSpUtam
	 PjcDbaY4KBj2ZcvFAlDjEi25rOX8T5xmowiOEvc52mj/fnB56E6IXsngj/jKRy575Z
	 009c+xVYceZLs0Hfs6APlA4+m1yv/PayC0WnnUXrXfCRcekP/Due8fQHIP9LmdgZy9
	 dX71rpkwIv80eHPlgdcGISIoee1XSJZb4A19XXvZZTxiO9NW+5yTxHoWiEO602IWWC
	 KhEgX4qj2QaPg==
Received: from linux.gnuweeb.org (unknown [182.253.126.227])
	by server-vie001.gnuweeb.org (Postfix) with ESMTPSA id 7E4CD3127C48;
	Thu,  7 Aug 2025 01:37:30 +0000 (UTC)
X-Gw-Bpl: wU/cy49Bu1yAPm0bW2qiliFUIEVf+EkEatAboK6pk2H2LSy2bfWlPAiP3YIeQ5aElNkQEhTV9Q==
Date: Thu, 7 Aug 2025 08:37:27 +0700
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
Message-ID: <aJQDV5eQTVzVNg9y@linux.gnuweeb.org>
References: <20250801190310.58443-1-ammarfaizi2@gnuweeb.org>
 <20250804100050.GQ8494@horms.kernel.org>
 <20250805202848.GC61519@horms.kernel.org>
 <CAHk-=wjqL4uF0MG_c8+xHX1Vv8==sPYQrtzbdA3kzi96284nuQ@mail.gmail.com>
 <CAHk-=wh+bnqPjL=9oq3uEkyZ7WB8=F_QMOHsGjHLj98oYk-X3Q@mail.gmail.com>
 <CAHk-=wjedw0vsfByNOrxd-QMF9svfNjbSo1szokEZuKtktG7Lw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjedw0vsfByNOrxd-QMF9svfNjbSo1szokEZuKtktG7Lw@mail.gmail.com>
X-Machine-Hash: hUx9VaHkTWcLO7S8CQCslj6OzqBx2hfLChRz45nPESx5VSB/xuJQVOKOB1zSXE3yc9ntP27bV1M1

On Wed, Aug 06, 2025 at 04:54:36AM +0300, Linus Torvalds wrote:
> Anyway, I've applied Ammar's v3 that ended up the same patch that I also tested,

Yesterday, I synced with your tree, but couldn't boot. Crashed with
this call trace:

  https://gist.githubusercontent.com/ammarfaizi2/3ba41f13517be4bae70cde869347d259/raw/0ac09b3e1d90d51c3fed14ca9f837f45d7730f0a/crash.jpg

This morning, I synced with your tree again, still the same result.

I'll try to bisect it and report to approriate subsystem once I get the
first bad commit. I suspect it's related to pci or nvme (based on that
call trace).

-- 
Ammar Faizi


