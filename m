Return-Path: <stable+bounces-195470-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B27C9C779E0
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 07:55:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BA3DE35DF78
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 06:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F5F3334690;
	Fri, 21 Nov 2025 06:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AGUd0mIj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94BA27A469;
	Fri, 21 Nov 2025 06:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763708063; cv=none; b=ZNQkxjZzZmmvgkgD+2Pk8QaI3dJ6IjkcxGY63+Jj6EkcP3/SATzZVvoPgHoVg0iGT/ysxJjG4pHmq8CnP5y9msFMHSNdbVuq9mfYhTRCiUH+ha8hzZrXCdR+CalvLoMdXKbBsfvwvltq723pZd8vtKssNKIwyJhJLPX2kQNBP4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763708063; c=relaxed/simple;
	bh=SIA8KL/skpcWLjHvQsGU1XUYv3kPg0VT/ASJ9uIo6ZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UqJqG+K1iQNwMAzZmoXj5M6HftKRZI1i6ZKEF4KGku3UOoXEylLgXKNj1tvwZwK0pcPHrOb+5hPZ1F8YbkTW4AoaYray6UZQxIoMZVg9Z83FN/UpifHLP23P5wK7HMiSkHYaKqafr3jUqD7iLtqgqljr2ph0qLoJdqM74n4MbcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AGUd0mIj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7C25C4CEF1;
	Fri, 21 Nov 2025 06:54:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1763708063;
	bh=SIA8KL/skpcWLjHvQsGU1XUYv3kPg0VT/ASJ9uIo6ZU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AGUd0mIjDeS+w8/jIDbBlZR6mKsA+CFDjxYiEhXkGWsAhbV6fXd8P36bLr8QuRJgc
	 Cy75b1XLL8vLMrmgKpepBAUapLcwY91++0ETlHdB0Ol2FvrOe5fx+idssth+WFMNeR
	 8b5tTL05gDWaaxgwg4jdmF2cVskNyLfoRtNNtMx0=
Date: Fri, 21 Nov 2025 07:54:12 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: "Naik, Avadhut" <avadnaik@amd.com>
Cc: Borislav Petkov <bp@alien8.de>, Avadhut Naik <avadhut.naik@amd.com>,
	stable@vger.kernel.org, sashal@kernel.org,
	linux-kernel@vger.kernel.org,
	Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
	Tony Luck <tony.luck@intel.com>,
	Yazen Ghannam <yazen.ghannam@amd.com>,
	Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Subject: Re: [PATCH] x86/mce: Handle AMD threshold interrupt storms
Message-ID: <2025112104-hamstring-aftermost-31f4@gregkh>
References: <20251120214139.1721338-1-avadhut.naik@amd.com>
 <20251120215305.GDaR-NwYmw4XkOd57L@fat_crate.local>
 <161a0863-7cda-42aa-a462-c327276b3e26@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <161a0863-7cda-42aa-a462-c327276b3e26@amd.com>

On Thu, Nov 20, 2025 at 07:59:57PM -0600, Naik, Avadhut wrote:
> 
> 
> On 11/20/2025 15:53, Borislav Petkov wrote:
> > On Thu, Nov 20, 2025 at 09:41:24PM +0000, Avadhut Naik wrote:
> >> From: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
> > 
> > You need to put here
> > 
> > "Commit <sha1> upstream."
> > 
> Will add that.
> 
> Also, does this need to have a Fixes tag?
> 
> Didn't add one here as the original patch committed to tip didn't have one.

Then there's no need.

