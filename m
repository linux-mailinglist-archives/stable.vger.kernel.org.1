Return-Path: <stable+bounces-19743-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E598F8533C6
	for <lists+stable@lfdr.de>; Tue, 13 Feb 2024 15:56:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 819131F2CBA7
	for <lists+stable@lfdr.de>; Tue, 13 Feb 2024 14:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A82F58105;
	Tue, 13 Feb 2024 14:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xVsOjqGB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0995FDC4
	for <stable@vger.kernel.org>; Tue, 13 Feb 2024 14:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707836138; cv=none; b=am5+g/N60dlLCwY5UyNxRn4UyiV32EVCEOvAK+dLE/pewLnUMZsd37n41H/4JJVih5qVr0ilca7c0SlZaSW8z0klswymLJcYjPJsUmKl6q2+DQs6D1ag0jrhfAlhHGuHcuytQlge6DRMM40BgmCzRLP/kZ++KkOqxKbK2NHO42s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707836138; c=relaxed/simple;
	bh=r8Mh4ca9rAZ97DwnNOs0vNtsz8aDyVwYb2EAd3PGy6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n+RsInS0lLHwDTm6nzF+8iHBQklAtn5y81OyirZhj2MlUhFZGMT9Hhr3+Fht/uKZ/C+nMEHnJm6isusFkccAueJwrLix6/Mj9VY2R82kCLLldWZByDT00dsucBRGGW4LR8YkUxlTDHVMeFjJhCYrflH8AdUllQ7Pmjwl/0ww9AI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xVsOjqGB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2C7BC433C7;
	Tue, 13 Feb 2024 14:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707836137;
	bh=r8Mh4ca9rAZ97DwnNOs0vNtsz8aDyVwYb2EAd3PGy6E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=xVsOjqGBMdomFIyZbigNwlG/6mnRs/yX5NdAhe6UCrqgX6sn5jYPF5bbD9A2eepaf
	 BF0ifHnZlg6V503dTGOML0jb/QnmXoJJe4OVJv5aAlm3oPEEezD3SlHupVCoh6lWqZ
	 sUtsP9i4JKc3AH0JXtkGw2LqJcLompJqYfevC+nA=
Date: Tue, 13 Feb 2024 15:55:34 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: "Marciniszyn, Mike" <mike.marciniszyn@intel.com>
Cc: Sasha Levin <sashal@kernel.org>,
	"Saleem, Shiraz" <shiraz.saleem@intel.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH 6.1.y] RDMA/irdma: Ensure iWarp QP queue memory is OS
 paged aligned
Message-ID: <2024021314-predator-scientist-84cd@gregkh>
References: <20240207163240.433-1-shiraz.saleem@intel.com>
 <Zcj1JyNJww8njJFv@sashalap>
 <SA1PR11MB6895D85EBD4BEFDCEC57AAD286482@SA1PR11MB6895.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SA1PR11MB6895D85EBD4BEFDCEC57AAD286482@SA1PR11MB6895.namprd11.prod.outlook.com>

On Mon, Feb 12, 2024 at 01:02:52PM +0000, Marciniszyn, Mike wrote:
> > >Fixes: e965ef0e7b2c ("RDMA/irdma: Split QP handler into
> > >irdma_reg_user_mr_type_qp")
> > 
> > Is this fixes tag incorrect? there's no e965ef0e7b2c in 6.1.
> > 
> 
> The fixes was correct for upstream.   The context change forced the re-port of patch and the Fixes is not appropriate for the older context.

I do not understand, what context change?

> You can drop if you want.

Is it needed for 6.1.y or not?

confused,

greg k-h

