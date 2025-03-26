Return-Path: <stable+bounces-126648-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AADACA70E3B
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 01:32:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31674176494
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 00:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87F9D12E7E;
	Wed, 26 Mar 2025 00:32:39 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59129376;
	Wed, 26 Mar 2025 00:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742949159; cv=none; b=quM9ZDPnqToi3zX6OYYkj98eAW0AA0guWiZW4njdYB4fRh8Ts0GuGrohGZA+cF9pkuugmH30BiFThbwZOTzvoY6m7LgguQ5+tkSkONvGMtiAgsEQgylOO5sINr33Uy5Oceus8dVC6l1sbXmuqEWckN0hqiGIg96wenTHkQ9456E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742949159; c=relaxed/simple;
	bh=6icXaq94kKqtddya0iw8dvRY1nQB7T8bbKkC1k2Jg8U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KnFDB4YaaGY30U5S6awh0fUs07HBGQAkGaX+U7bnGn+rPX9NUkNRtudyAGrp716I8S/uCwGts8HHol4oX8vg+s2qBaRFw8ar2Byjr9BL44rVok6s46VQ3k1CQTZzYTIWoc4Oxjt151OYGUhZLbH8buaM3pGbjlAVqnGNjxIcfi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20E31C4CEED;
	Wed, 26 Mar 2025 00:32:38 +0000 (UTC)
Date: Tue, 25 Mar 2025 20:32:36 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Sahil Gupta <s.gupta@arista.com>, stable@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Dmitry Safonov <dima@arista.com>, Kevin
 Mitchell <kevmitch@arista.com>
Subject: Re: [PATCH 6.1 6.6 6.12 6.13] scripts/sorttable: fix ELF64
 mcount_loc address parsing when compiling on 32-bit
Message-ID: <20250325203236.3c6a19f4@batman.local.home>
In-Reply-To: <2025032553-celibacy-underpaid-faeb@gregkh>
References: <CABEuK17=Y8LsLhiHXgcr7jOp2UF3YCGkQoAyQu8gTVJ5DHPN0w@mail.gmail.com>
	<20250326001122.421996-2-s.gupta@arista.com>
	<2025032553-celibacy-underpaid-faeb@gregkh>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 25 Mar 2025 20:23:31 -0400
Greg KH <gregkh@linuxfoundation.org> wrote:

> On Tue, Mar 25, 2025 at 05:06:56PM -0700, Sahil Gupta wrote:
> > The ftrace __mcount_loc buildtime sort does not work properly when the host is
> > 32-bit and the target is 64-bit. sorttable parses the start and stop addresses
> > by calling strtoul on the buffer holding the hexadecimal string. Since the
> > target is 64-bit but unsigned long on 32-bit machines is 32 bits, strtoul,
> > and by extension the start and stop addresses, can max out to 2^32 - 1.
> > 
> > This patch adds a new macro, parse_addr, that corresponds to a strtoul
> > or strtoull call based on whether you are operating on a 32-bit ELF or
> > a 64-bit ELF. This way, the correct width is guaranteed whether or not
> > the host is 32-bit. This should cleanly apply on all of the 6.x stable
> > kernels.
> > 
> > Manually verified that the __mcount_loc section is sorted by parsing the
> > ELF and verified tests corresponding to CONFIG_FTRACE_SORT_STARTUP_TEST
> > for kernels built on a 32-bit and a 64-bit host.
> > 
> > Signed-off-by: Sahil Gupta <s.gupta@arista.com>
> > ---
> >  scripts/sorttable.h | 7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)  
> 
> What is the upstream git commit of this?
> 
> If it's not upstream, then you need to document the heck out of why we
> can't take whatever is upstream already, which I don't see here :(

I guess it is loosely based on 4acda8edefa1 ("scripts/sorttable: Get
start/stop_mcount_loc from ELF file directly"), which may take a bit of
work to backport (or we just add everything that this commit depends on).

-- Steve

