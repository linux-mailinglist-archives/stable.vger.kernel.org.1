Return-Path: <stable+bounces-73587-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DCD9596D588
	for <lists+stable@lfdr.de>; Thu,  5 Sep 2024 12:11:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD47E1C25244
	for <lists+stable@lfdr.de>; Thu,  5 Sep 2024 10:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82FB319924E;
	Thu,  5 Sep 2024 10:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GKcG1iTK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A2F7199247;
	Thu,  5 Sep 2024 10:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725531048; cv=none; b=f8iGCS9ooCFEVvIYVbpCI2vppIFSvdIhIDNv6VqSKmO1E7CYFv68CUQ/MQqaD/Kj14plk5HEsd7VdSRFYBou8vRa8nKMtOlU01VpRRcTnRH4pekkod+Dx6oBR43f3Fdl/NBdqTqTcF+pB+h2FI33p8ueULkU0to3/eocrj30VIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725531048; c=relaxed/simple;
	bh=t2ttgurPaxTfVfdfFRuyPYqDcCpXcKjakwWq614y0KY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J8xl1SPpoJqyoPmp6Vwf90gUNQtiJqhYKkh9A+ha6vQMIFnybgnmrb/2+Fgh60hMxG1On8wUty0a1ltxLjf2troOI9hodwuf7RfDUteqkvz3aZdSFfbjFm0k2MwIfmMdEGwZqoDcOi687niU3xoPQOhGL6JSvdM7VZRYAHWJ9JE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GKcG1iTK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F390C4CEC6;
	Thu,  5 Sep 2024 10:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725531047;
	bh=t2ttgurPaxTfVfdfFRuyPYqDcCpXcKjakwWq614y0KY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GKcG1iTKBqXhdCfoe8rRbnqNZNCEkzudW5Azc3ZmnKNrEXZOiaISswBWRb7WUmVx7
	 AxiEXgzJbzT/GsxU6X1qp3q8lMz8oFZ3J6vdAI7qiaSdZcRpqqCn8/maltG+Dwg9H4
	 M5I2wBRNQfdQvdC7O60nSjt1dV1RmjrUzW7PWW3I=
Date: Thu, 5 Sep 2024 12:10:44 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: stable@vger.kernel.org, MPTCP Upstream <mptcp@lists.linux.dev>,
	Mat Martineau <martineau@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y] selftests: mptcp: join: validate event numbers
Message-ID: <2024090523-antler-errant-b403@gregkh>
References: <2024083026-attire-hassle-e670@gregkh>
 <20240904111338.4095848-2-matttbe@kernel.org>
 <2024090420-passivism-garage-f753@gregkh>
 <fc21db4a-508d-41db-aa45-e3bc06d18ce7@kernel.org>
 <2024090556-skewed-factoid-250c@gregkh>
 <2024090541-bride-marbled-f248@gregkh>
 <23b49a68-476d-4c3d-b2c8-9e0dc4514c74@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23b49a68-476d-4c3d-b2c8-9e0dc4514c74@kernel.org>

On Thu, Sep 05, 2024 at 11:42:21AM +0200, Matthieu Baerts wrote:
> On 05/09/2024 11:36, Greg KH wrote:
> > On Thu, Sep 05, 2024 at 11:33:46AM +0200, Greg KH wrote:
> >> On Wed, Sep 04, 2024 at 05:20:59PM +0200, Matthieu Baerts wrote:
> >>> Hi Greg,
> >>>
> >>> On 04/09/2024 16:38, Greg KH wrote:
> >>>> On Wed, Sep 04, 2024 at 01:13:39PM +0200, Matthieu Baerts (NGI0) wrote:
> >>>>> commit 20ccc7c5f7a3aa48092441a4b182f9f40418392e upstream.
> >>>>>
> >>>>
> >>>> This did not apply either.
> >>>>
> >>>> I think I've gone through all of the 6.1 patches now.  If I've missed
> >>>> anything, please let me know.
> >>> It looks like there are some conflicts with the patches Sasha recently
> >>> added:
> >>>
> >>> queue-6.1/selftests-mptcp-add-explicit-test-case-for-remove-re.patch
> >>> queue-6.1/selftests-mptcp-join-check-re-adding-init-endp-with-.patch
> >>> queue-6.1/selftests-mptcp-join-check-re-using-id-of-unused-add.patch
> >>>
> >>> >From commit 0d8d8d5bcef1 ("Fixes for 6.1") from the stable-queue tree:
> >>>
> >>>
> >>> https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/commit/?id=0d8d8d5bcef1
> >>>
> >>> I have also added these patches -- we can see patches with almost the
> >>> same name -- but I adapted them to the v6.1 kernel: it was possible to
> >>> apply them without conflicts, but they were causing issues because they
> >>> were calling functions that are not available in v6.1, or taking
> >>> different parameters.
> >>>
> >>> Do you mind removing the ones from Sasha please? I hope that will not
> >>> cause any issues. After that, the two patches you had errors with should
> >>> apply without conflicts:
> >>
> >> Ok, I've now dropped them, that actually fixes an error I was seeing
> >> where we had duplicated patches in the tree.
> >>
> >>>  - selftests: mptcp: join: validate event numbers
> >>>  - selftests: mptcp: join: check re-re-adding ID 0 signal
> >>
> >> I'll go add these now, thanks!
> > 
> > I just tried, and they still fail to apply.  How about we wait for this
> > next 6.1.y release to happen and then you rebase and see what I messed
> > up and send me the remaining ones as this is getting confusing on my
> > end...
> 
> Thank you for having tried!
> 
> Sure, no problem, I can wait.
> 
> I just hope the previous patches I sent have been applied properly. I
> mean: I don't know how quilt handled the duplicated patches with
> different content.
> 
> If you prefer, we can also drop all the MPTCP related patches -- or only
> the ones related to the selftests -- and I send the whole series I have
> on my side: it is still on top of the v6.1.108-rc1, so without the
> patches Sasha backported yesterday.

Let's see how this -rc release looks, if it's broken or messed up, I can
easily drop patches as needed.

thanks,

greg k-h

