Return-Path: <stable+bounces-5313-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DC9B80CA15
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 13:45:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D8371C21002
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 12:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 625383B7BF;
	Mon, 11 Dec 2023 12:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rn4o6Zze"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AEFE1D6A2
	for <stable@vger.kernel.org>; Mon, 11 Dec 2023 12:45:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CD9CC433C7;
	Mon, 11 Dec 2023 12:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702298723;
	bh=Nr4+KcoI6Y0IGHVAol/9RaZj49fZ84J+GJ8rOA0hV4M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rn4o6ZzeQONUH0vukXhg+4Ngf4NXyWdwwMA7vw0qtJaa//eufPqfUI6j5wNrMZLnM
	 2aU81Y58LA4UFuWtXb3b/mbAJtAvv09wW57VLxzRtGNrVVpej3BHtLKmR/Km+pbGRb
	 Cjphb3/3RF9dxcqM79WQm5fMfqnlIkxq1Gj3SkWE=
Date: Mon, 11 Dec 2023 13:45:21 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: =?iso-8859-1?B?TOlv?= Lam <leo@leolam.fr>
Cc: stable@vger.kernel.org
Subject: Re: [PATCH] wifi: nl80211: fix deadlock in nl80211_set_cqm_rssi
 (6.6.x)
Message-ID: <2023121147-estrogen-reviver-afb4@gregkh>
References: <20231210213930.61378-1-leo@leolam.fr>
 <2023121135-unwilling-exception-0bcc@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2023121135-unwilling-exception-0bcc@gregkh>

On Mon, Dec 11, 2023 at 07:47:32AM +0100, Greg KH wrote:
> On Sun, Dec 10, 2023 at 09:39:30PM +0000, Léo Lam wrote:
> > Commit 4a7e92551618f3737b305f62451353ee05662f57 ("wifi: cfg80211: fix
> > CQM for non-range use" on 6.6.x) causes nl80211_set_cqm_rssi not to
> > release the wdev lock in some situations.
> > 
> > Of course, the ensuing deadlock causes userland network managers to
> > break pretty badly, and on typical systems this also causes lockups on
> > on suspend, poweroff and reboot. See [1], [2], [3] for example reports.
> > 
> > The upstream commit, 7e7efdda6adb385fbdfd6f819d76bc68c923c394
> > ("wifi: cfg80211: fix CQM for non-range use"), does not trigger this
> > issue because the wdev lock does not exist there.
> > 
> > Fix the deadlock by releasing the lock before returning.
> > 
> > [1] https://bugzilla.kernel.org/show_bug.cgi?id=218247
> > [2] https://bbs.archlinux.org/viewtopic.php?id=290976
> > [3] https://lore.kernel.org/all/87sf4belmm.fsf@turtle.gmx.de/
> > 
> > Fixes: 4a7e92551618 ("wifi: cfg80211: fix CQM for non-range use")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Léo Lam <leo@leolam.fr>
> > ---
> >  net/wireless/nl80211.c | 18 ++++++++++++------
> >  1 file changed, 12 insertions(+), 6 deletions(-)
> 
> So this is only for the 6.6.y tree?  If so, you should at least cc: the
> other wireless developers involved in the original fix, right?
> 
> And what commit actually fixed this issue upstream, why not take that
> instead?

I've reverted the offending commit in the last 6.1.y and 6.6.y release,
so can you send this as a patch series, first one being the original
backport, and the second one this one, AFTER it has been tested?

thanks,

greg k-h

