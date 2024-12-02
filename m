Return-Path: <stable+bounces-96063-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A022B9E08A8
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 17:35:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 016DEB33529
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 14:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BA4D209677;
	Mon,  2 Dec 2024 14:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1kZdNcg3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF89F209676
	for <stable@vger.kernel.org>; Mon,  2 Dec 2024 14:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733150840; cv=none; b=GPTT2D9iOzOS1b82LKebCMxsgIFVTEAemJQN4X5J9y9uRJrA7kg2dgsbWHJh7bLqrf2sEG5E9b9mlAwg1HALF7GD+3iZpbqeIQ89ciTOO81azOR9P7kZL/Aw5HPOlG3M3cteDVK69xa9chv+klHzWxC5M2qTlQcx5rfVb+7LYIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733150840; c=relaxed/simple;
	bh=MvTc/WBxg9xmJ67iX4+fiCpZy6XPDopakAv6l/p10aA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lLVnVk4ktRaZumwriBgVR6P13/fQcQhmVTUnfXd5Dj54IgPnYKXQNu/Woesq0SRIi5J4l0dbJgOLNr0xOnfSax+jGhPxXoP/0s7K82D2AuYqEJteivmzEsLWU/15rn1oHOgQxJ9/8B1E5P5P4QD9l5FVKmEYaAXyFjQCKvwKORo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1kZdNcg3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECE2CC4CED1;
	Mon,  2 Dec 2024 14:47:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733150837;
	bh=MvTc/WBxg9xmJ67iX4+fiCpZy6XPDopakAv6l/p10aA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=1kZdNcg3aQum0k9uabEh+Y/09AiKq1bBJLw/CB9XwpGMjVc3anVigvbV37zz6sFAe
	 9wOCs1x2t4JU2G4a5NpBJLBswP9SLYDnyuR2EYU2RxaZ8hHKpNWxxRZp49qwu3ap42
	 1dS03H7EZBctgOO4RrNoffMywc8N1TR48bk/IYQc=
Date: Mon, 2 Dec 2024 15:47:14 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Lucas De Marchi <lucas.demarchi@intel.com>
Cc: stable@vger.kernel.org, Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Suraj Kandpal <suraj.kandpal@intel.com>
Subject: Re: [PATCH 6.11 27/31] drm/xe/display: Do not suspend resume dp mst
 during runtime
Message-ID: <2024120254-xbox-record-1bb9@gregkh>
References: <20241122210719.213373-1-lucas.demarchi@intel.com>
 <20241122210719.213373-28-lucas.demarchi@intel.com>
 <2024120222-mammal-quizzical-087f@gregkh>
 <i5j7pmrgftg7tiqnmffpwzpgshix3km5syndcnqylenylylrki@wuh7zdqc5kse>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <i5j7pmrgftg7tiqnmffpwzpgshix3km5syndcnqylenylylrki@wuh7zdqc5kse>

On Mon, Dec 02, 2024 at 08:40:34AM -0600, Lucas De Marchi wrote:
> On Mon, Dec 02, 2024 at 10:50:14AM +0100, Greg KH wrote:
> > On Fri, Nov 22, 2024 at 01:07:15PM -0800, Lucas De Marchi wrote:
> > > From: Suraj Kandpal <suraj.kandpal@intel.com>
> > > 
> > > commit 47382485baa781b68622d94faa3473c9a235f23e upstream.
> > 
> > But this is not in 6.12, so why apply it only to 6.11?
> 
> oops, it should be in 6.12.
> 
> Rodrigo/Suraj why doesn't this patch have the proper Fixes trailer?
> 
> > 
> > We can't take patches for only one stable branch, so please fix this
> > series up for 6.12.y as well, and then we can consider it for 6.11.y.
> 
> all these patches should already be in 6.12... I will take a look again
> to make sure we aren't missing patches there.
> 
> > 
> > Also note that 6.11.y will only be alive for maybe one more week...
> 
> ok, then maybe the distros still using 6.11 will need to pick these
> downstream or move on.

I think most will have moved on by now, do you know any that are
sticking with 6.11.y?

thanks,

greg k-h

