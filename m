Return-Path: <stable+bounces-87037-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0B749A6057
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 11:40:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99FAF1F2236F
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 09:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF9A01E283D;
	Mon, 21 Oct 2024 09:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="12d9n+j1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7049A31A60;
	Mon, 21 Oct 2024 09:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729503614; cv=none; b=ZdRqLJN0ZTFF6iNS2u93KnP2Fh1T2vqb8trqjqo0/xS43RB8jV4IJWq3pkaoJlqfFFmXl2+TNK7Hdv7UFp/B1JCV96rO/Ns0uobf2H33ETVv3COTrIV+RiB8j/nfbYQUWRUrn3byQM5et2uriCBouhbM5vxSmV2PmbJYXf6cYmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729503614; c=relaxed/simple;
	bh=zW2NWRZP84TLje6Ee6y+/EEWz36ypvzglUaza4b4nEU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mNAIfjZPVJtw4MlRWCLe7ETW0NsbdEvqiNoOa14M4wWUWqRdlc39Pm26p1o1t2v0MOnVGJgAcfMNYHZPqPXFBJJPhYdcVEZ1g//HmTkoJQlkBFA34/E0gkcHeDv1qHaRwSiva1ojjX1ObPzYQn+dL2BA+n1uUMhFa/Bq28c9HFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=12d9n+j1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76A7FC4CEC3;
	Mon, 21 Oct 2024 09:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1729503614;
	bh=zW2NWRZP84TLje6Ee6y+/EEWz36ypvzglUaza4b4nEU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=12d9n+j12E+yjd0SQ7nyo3Nh5fetseqndoIpJ5WpdmHhVM/siFO6x7qaH0hJsLrzi
	 MzGyp44GqZFPL0m5QFQDIde01omvTjQ5Vm0F5DBnd2wrmm3XfNKkWK5JqFQdWa9fQY
	 DJbad+L72pRxdhJk5qV8RL/paxOErxNljH64TU3c=
Date: Mon, 21 Oct 2024 11:40:11 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Hardik Gohil <hgohil@mvista.com>
Cc: stable@vger.kernel.org, netdev@vger.kernel.org,
	Kenton Groombridge <concord@gentoo.org>,
	Kees Cook <kees@kernel.org>,
	Johannes Berg <johannes.berg@intel.com>,
	Xiangyu Chen <xiangyu.chen@windriver.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH v5.10.277] wifi: mac80211: Avoid address calculations via
 out of bounds array indexing
Message-ID: <2024102147-paralyses-roast-0cec@gregkh>
References: <1729316200-15234-1-git-send-email-hgohil@mvista.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1729316200-15234-1-git-send-email-hgohil@mvista.com>

On Sat, Oct 19, 2024 at 11:06:40AM +0530, Hardik Gohil wrote:
> From: Kenton Groombridge <concord@gentoo.org>
> 
> [ Upstream commit 2663d0462eb32ae7c9b035300ab6b1523886c718 ]

We can't take patches for 5.10 that are not already in 5.15.  Please fix
up and resend for ALL relevent trees.

thanks,

greg k-h

