Return-Path: <stable+bounces-121254-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F779A54E4C
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 15:53:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 343AB164FF6
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 14:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4DE41DE4EC;
	Thu,  6 Mar 2025 14:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oiQkuxhB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C29502BE;
	Thu,  6 Mar 2025 14:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741272771; cv=none; b=ajBwqRMZcronOtiMmT9UnBBOxVzepOsor2q+U90pYjzAJLZNda4qnMg4bdk4tXUiozSk9oWGfzP8dMH/98BxHxDh5irpiutX8v0MbxTW3YLQLzcMQ9YLsHcIk0PccRcH/QqSyy20nVcHkflth1jOvVGpM3JfrD63Preb7/6Zdi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741272771; c=relaxed/simple;
	bh=SUL+ucWKrpjs4swUg+H65xiM1N2WpJde2yr8apUzAp0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PN4+FpyNK7r9emxwOy51cbMsx7GggT3fnMVD/T1Cc9yAKVXMmpsQFx3nHkqbR24hQHCdAr3+oIAn9utueIxTCjtPG40UrnIK115dSTfbPpRiwziRkpuqVrbEol2QSY7uTrpeNwXUob9O/JEsQu9fv9UFDG2T9AfytscPMIlgIjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oiQkuxhB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94E03C4CEE0;
	Thu,  6 Mar 2025 14:52:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741272771;
	bh=SUL+ucWKrpjs4swUg+H65xiM1N2WpJde2yr8apUzAp0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oiQkuxhB75KDwwkFO3GswIkPzYDS8WbA/cv9wsZm4WbaqQv/O73UGTWYcU29Pl/oS
	 Qnx1txDwoq498DkPIBwE95BsTOUGYaoIhHXN0uEcXwDf/LnFAvb2giVmwqAoh9QmC1
	 Ulu/qd5CPxlfCfPYCjU4xoUjlxUSnDszEmTs1JNY=
Date: Thu, 6 Mar 2025 15:52:48 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Mathias Nyman <mathias.nyman@linux.intel.com>
Cc: linux-usb@vger.kernel.org, Michal Pecio <michal.pecio@gmail.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH 03/15] usb: xhci: Don't skip on Stopped - Length Invalid
Message-ID: <2025030611-twister-synapse-8a99@gregkh>
References: <20250306144954.3507700-1-mathias.nyman@linux.intel.com>
 <20250306144954.3507700-4-mathias.nyman@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250306144954.3507700-4-mathias.nyman@linux.intel.com>

On Thu, Mar 06, 2025 at 04:49:42PM +0200, Mathias Nyman wrote:
> From: Michal Pecio <michal.pecio@gmail.com>
> 
> Up until commit d56b0b2ab142 ("usb: xhci: ensure skipped isoc TDs are
> returned when isoc ring is stopped") in v6.11, the driver didn't skip
> missed isochronous TDs when handling Stoppend and Stopped - Length
> Invalid events. Instead, it erroneously cleared the skip flag, which
> would cause the ring to get stuck, as future events won't match the
> missed TD which is never removed from the queue until it's cancelled.
> 
> This buggy logic seems to have been in place substantially unchanged
> since the 3.x series over 10 years ago, which probably speaks first
> and foremost about relative rarity of this case in normal usage, but
> by the spec I see no reason why it shouldn't be possible.
> 
> After d56b0b2ab142, TDs are immediately skipped when handling those
> Stopped events. This poses a potential problem in case of Stopped -
> Length Invalid, which occurs either on completed TDs (likely already
> given back) or Link and No-Op TRBs. Such event won't be recognized
> as matching any TD (unless it's the rare Link TRB inside a TD) and
> will result in skipping all pending TDs, giving them back possibly
> before they are done, risking isoc data loss and maybe UAF by HW.
> 
> As a compromise, don't skip and don't clear the skip flag on this
> kind of event. Then the next event will skip missed TDs. A downside
> of not handling Stopped - Length Invalid on a Link inside a TD is
> that if the TD is cancelled, its actual length will not be updated
> to account for TRBs (silently) completed before the TD was stopped.
> 
> I had no luck producing this sequence of completion events so there
> is no compelling demonstration of any resulting disaster. It may be
> a very rare, obscure condition. The sole motivation for this patch
> is that if such unlikely event does occur, I'd rather risk reporting
> a cancelled partially done isoc frame as empty than gamble with UAF.
> 
> This will be fixed more properly by looking at Stopped event's TRB
> pointer when making skipping decisions, but such rework is unlikely
> to be backported to v6.12, which will stay around for a few years.
> 
> Fixes: d56b0b2ab142 ("usb: xhci: ensure skipped isoc TDs are returned when isoc ring is stopped")
> Cc: stable@vger.kernel.org
> Signed-off-by: Michal Pecio <michal.pecio@gmail.com>
> Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>

Why is a patch cc: stable burried here in a series for linux-next?  It
will be many many weeks before it gets out to anyone else, is that
intentional?

Same for the other commit in this series tagged that way.

thanks,

greg k-h

