Return-Path: <stable+bounces-45372-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B6E08C84F2
	for <lists+stable@lfdr.de>; Fri, 17 May 2024 12:37:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B67F1F213FD
	for <lists+stable@lfdr.de>; Fri, 17 May 2024 10:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 154FE39ACD;
	Fri, 17 May 2024 10:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aooNHHqd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B94CF2E852;
	Fri, 17 May 2024 10:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715942248; cv=none; b=Dm9FEr+KQIdX3UAhOeSwDKoA8WAzJDmbq4JRb5h1e/qp+ai1m6PgrWtA2XiCDf2lD+nwJuolbGCIKzmFTu1KvdAWUxBbUDR76gAhvsQnFeE37Od174gLkNYN07TZDIwk6vqMFggqrrXaS0DSYt8aR9wGwWFFj/YGevtKm6sRC68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715942248; c=relaxed/simple;
	bh=d5E76zfP3E0SHs8WUgh0FmgpKxv/WsJK3P6aN0GbnU0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bb8rK69uyd+1IX9axTCadzyKq/Q+WW5cpElQwuwOvOOq1jBW1BP7fT+RBhxV3eQgE56wdJ34focDMgGJCRQyouo4acrgEb31Z6Blwmy3YFV5IG4ZF5PWNFOb7MEGs1L4BpjFHLOkCM4NUKJPvugdG6nc06S2yIpOSpoMPQ17Nes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aooNHHqd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4E41C2BD10;
	Fri, 17 May 2024 10:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715942248;
	bh=d5E76zfP3E0SHs8WUgh0FmgpKxv/WsJK3P6aN0GbnU0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aooNHHqde0cqMrfTRwq/b2sMdrcXrdYV3JHneEzavO1I9/KMrSG47hYxIjMVqKD9j
	 NnyElFF3JvKbv8nxRo21hcHy/L0VqTaaXXxWgyTBuClNBoqjsRuH8NujMNcSVrUMNc
	 b6EfbhSjNI9qvn5i5SK2X+7kmm5Zka/SjgVobgnA=
Date: Fri, 17 May 2024 12:37:15 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>,
	Linux kernel regressions list <regressions@lists.linux.dev>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: three commits you might or might not want to pick up for 6.9.y
Message-ID: <2024051709-pretty-rambling-fc7e@gregkh>
References: <9e40badb-c4fa-4828-a4c5-3a170f624215@leemhuis.info>
 <2024051501-dropkick-landmark-5db0@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2024051501-dropkick-landmark-5db0@gregkh>

On Wed, May 15, 2024 at 04:09:17PM +0200, Greg KH wrote:
> On Wed, May 15, 2024 at 03:49:30PM +0200, Thorsten Leemhuis wrote:
> > Hi Greg. Here are three reports for regressions introduced during the
> > 6.9 cycle that were not fixed for 6.9 for one reason or another, but are
> > fixed in mainline now. So they might be good candidates to pick up early
> > for 6.9.y -- or maybe not, not sure. You are the better judge here. I
> > just thought you might wanted to know about them.
> > 
> > 
> > * net: Bluetooth: firmware loading problems with older firmware:
> > https://lore.kernel.org/lkml/20240401144424.1714-1-mike@fireburn.co.uk/
> > 
> > Fixed by 958cd6beab693f ("Bluetooth: btusb: Fix the patch for MT7920 the
> > affected to MT7921") – which likely should have gone into 6.9, but did
> > not due to lack of fixes: an stable tags:
> > https://lore.kernel.org/all/CABBYNZK1QWNHpmXUyne1Vmqqvy7csmivL7q7N2Mu=2fmrUV4jg@mail.gmail.com/
> > 
> > 
> > * leds/iwlwifi: hangs on boot:
> > https://lore.kernel.org/lkml/30f757e3-73c5-5473-c1f8-328bab98fd7d@candelatech.com/
> > 
> > Fixed by 3d913719df14c2 ("wifi: iwlwifi: Use request_module_nowait") –
> > not sure if that one is worth it, the regression might be an exotic
> > corner case.
> > 
> > 
> > * Ryzen 7840HS CPU single core never boosts to max frequency:
> > https://bugzilla.kernel.org/show_bug.cgi?id=218759
> > 
> > Fixed by bf202e654bfa57 ("cpufreq: amd-pstate: fix the highest frequency
> > issue which limits performance") – which was broken out of a patch-set
> > by the developers to send it in for 6.9, but then was only merged for
> > 6.10 by the maintainer.
> 
> Nice, thanks for these!  I'll look at them after this round of -rcs is
> out.

All now queued up.

greg k-h

