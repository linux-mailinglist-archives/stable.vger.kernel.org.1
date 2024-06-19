Return-Path: <stable+bounces-53842-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9FCB90EA59
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 14:05:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97F542813D6
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 12:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 464A113DDC7;
	Wed, 19 Jun 2024 12:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iIJCj/Fe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0583913D242
	for <stable@vger.kernel.org>; Wed, 19 Jun 2024 12:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718798731; cv=none; b=PMwGe1o7xM1AXQ3gPdurgmfIzcC03hcp0ZZflisKMk67bamNEwQy5hjekjhRCCqf0mE6Jrj1yBGjXt6+LEe200hktiiws7Z6y1cDPFz2AuZ//fzSNoFHD9tnKXCw1n7Y9OSBzPjMv2DEu+tz6WBeXtp6tNNqDEOmRCvAaIQfjBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718798731; c=relaxed/simple;
	bh=/1nYD6qQcbscp7Bm1iftdGhfBtwHwIUjd23sT6Qquok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kBKGIDi+21LQIh/b/TcJEdKxyEOEoKqVav4hAxpl+j39wam4PCIvOeRRQx9tTALU+Ql/yITVyK0QB+4FPDSwD079VhF6EKMn0ZktbvraW0qfRK7vKiugwltVlVi+jagY4S7N2PSceF7fIAEscY5oylE4v3QGoAkCYZkoYNwM3qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iIJCj/Fe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33CF7C2BBFC;
	Wed, 19 Jun 2024 12:05:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718798730;
	bh=/1nYD6qQcbscp7Bm1iftdGhfBtwHwIUjd23sT6Qquok=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iIJCj/FeLVeyYY+ZezrQtM8YYvMiwiA3rMfMjEq215BTmvkVcGA1FCXzltgzvXi1w
	 /PSYh/tXPteJzbLh2SJ1iXdz2qMLy5Wb1NLhLXFMzDt4jy9V56mtdoDje9zfNBMVmi
	 0oj1znW5ZR1ZN3T/RJxrtyjOAlwD/3ucZYq59zvI=
Date: Wed, 19 Jun 2024 14:05:27 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Ronnie Sahlberg <rsahlberg@ciq.com>
Cc: stable@vger.kernel.org
Subject: Re: Candidates for stable v6.9..v6.10-rc1 Deadlock
Message-ID: <2024061917-ruined-retype-2167@gregkh>
References: <CAK4epfz9B58Dfz=wwNP2PJQzeqvT3J_kjY9d7PNY_VPKDKE=dA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK4epfz9B58Dfz=wwNP2PJQzeqvT3J_kjY9d7PNY_VPKDKE=dA@mail.gmail.com>

On Mon, Jun 03, 2024 at 04:48:56PM -0400, Ronnie Sahlberg wrote:
> These commits reference Deadlock between v6.9 and v6.10-rc1
> 
> These commits are not, yet, in stable/linux-rolling-stable.
> Let me know if you would rather me compare to a different repo/branch.
> The list has been manually pruned to only contain commits that look like
> actual issues.
> If they contain a Fixes line it has been verified that at least one of the
> commits that the Fixes tag(s) reference is in stable/linux-rolling-stable
> 
> 
> 56c35f43eef013579c76
> eec7620800081e27dbf8
> 4268254a39484fc11ba9
> 0a46ef234756dca04623
> ecf0b2b8a37c84641866
> e03a5d3e95f22d15d8df
> 4d3421e04c5dc38baf15
> 9cc6290991e6cfc9a644
> 77e619a82fc384ae3d1d

I just grabbed one of these at random, and this commit message says:
	This patch brings no functional change.

and in reading it, it's just a "let's quiet the tools for now, but
really, all is good".  So that's not something we should be applying,
right?

thanks,

greg k-h

