Return-Path: <stable+bounces-136911-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73BB9A9F621
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 18:47:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E47FF1890166
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 16:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F166927C862;
	Mon, 28 Apr 2025 16:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="W4n7zcBn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0A627D794
	for <stable@vger.kernel.org>; Mon, 28 Apr 2025 16:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745858865; cv=none; b=TLrS9fGfOh2qws8Lb1afgkGlyPNU3tHunEd0gID0xEEAk5nNeb/bwVmq7HoFVARI0JSmD4CNHS70Z4WGcwzyhz2GH+GBcbkk/rbje8H6yvuuDbDlGwotJuwtTvyQN3j9g8kWQG3AbJU2VMrDL1CaTLl+bBSJvfklEVK8ss5fRWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745858865; c=relaxed/simple;
	bh=pLIKPkYkAYFWjul/dixDmB/IX+Ra49x6GttopOloGGc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jJhnkE7hJDzsQlc0xVKOVgmYgGAx9vsR698uSW+lw5yUXJQ+MbwJDomNKkyN8Dk1iKl5gAe0r2ih8ki7TUspz3ytbhqK+jUr4ZE5KFLRVjVEeV8bh/AahBizSot5MKJyMnEYkmBbmbZ7D+YnM4Mrg1yy2ho6fpl0NZL19H8MUtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=W4n7zcBn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1CDAC4CEE4;
	Mon, 28 Apr 2025 16:47:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745858865;
	bh=pLIKPkYkAYFWjul/dixDmB/IX+Ra49x6GttopOloGGc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W4n7zcBnJTOfNREiujSG5JRLOwv9Wz0RHy4U+fu8Uo1i9pc5KbX8XdMGZL7VQa35N
	 jC21Ep0iMBai2Gdkk3PIjmbvK1VIE/GxYp3lswRM6xBUT8IqiKCiF/dGBmftsOs6wr
	 vC6SlJnKj4GBywGXYTJneSN14YMga40EqFbTSOSM=
Date: Mon, 28 Apr 2025 18:47:41 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Chris Clayton <chris2553@googlemail.com>
Cc: stable@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>,
	adobriyan@gmail.com
Subject: Re: GCC 15 and stable kernels
Message-ID: <2025042802-cozily-caddy-8625@gregkh>
References: <fb4cce81-1e36-4887-a1e0-0cfd1a26693e@googlemail.com>
 <2025042814-sly-caring-8f38@gregkh>
 <c6867c6c-bc47-4e3c-9676-70184baf21db@googlemail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c6867c6c-bc47-4e3c-9676-70184baf21db@googlemail.com>

On Mon, Apr 28, 2025 at 04:08:27PM +0100, Chris Clayton wrote:
> On 28/04/2025 12:22, Greg Kroah-Hartman wrote:
> > On Mon, Apr 28, 2025 at 12:14:09PM +0100, Chris Clayton wrote:
> >> Hi Greg,
> >>
> >> I've built the four stable kernels that were released on 25 April. I found that to successfully build with GCC-15, each
> >> of them required backports of one or both of two upstream commits. Those commits are:
> >>
> >> Title		Commit						Author	
> >> nonstring 	9d7a0577c9db35c4cc52db90bc415ea248446472  	Linus
> >> gnu11		b3bee1e7c3f2b1b77182302c7b2131c804175870	Alexey Dobriyan
> >>
> >> 6.14.4 and 6.12.25 required only nonstring. 6.6.87 required only gnu11, 6.1.35 required both.
> >>
> >> Additionally, chasing down why my new Bluetooth mouse doesn't work, I also had cause to build 5.15.180 and found that it
> >> needed gnull.
> >>
> >> I have TO dash out now, but I could send you a zip archive of the patches later today, if that would help.
> > 
> > Please send backported patches of the above, as they do not apply
> > 
> 
> The patches are in the attached tarball.

Please submit them as a proper patch, with the original changelog and
authorship information intact.  We have thousands of examples of this on
the stable mailing list for how this should be done.

thanks,

greg k-h

