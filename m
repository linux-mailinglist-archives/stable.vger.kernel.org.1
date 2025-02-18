Return-Path: <stable+bounces-116934-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C7D6A3ABAD
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 23:30:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F67716A61E
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 22:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57E511C3F1C;
	Tue, 18 Feb 2025 22:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="iFHyblut"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 039AB2862A5;
	Tue, 18 Feb 2025 22:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739917854; cv=none; b=BNSHWLgZNJXcFqaxqCGyaulwQ85vQv6FIaHYxssqrhDet+bdMK9pFAxy++HnrhCyujz/r6g+CdKWZm5XEH4/lB2cwon+7Q2ofAPZELv/LhyOk1zLktKrqyNHvXVEC3eolwKUw97LBQv5hLO26ZXzm1oTCWe3focf/Qx90kOEK6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739917854; c=relaxed/simple;
	bh=lGnuFFu6SOhWAc+x99/VErdwBRrTK3xG4wjC0+7AF2Q=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Rcn8lyqgHG9I3m0GFvbzgDG6tvQRt4G/VhdhMfpPVduZoZPO/Kdz9aOnQIm/cUfQ7D/vwk5JcBecUj078cWfwWk7xXLkU8LOASBHaCaxvOqRL6cLrJ4TS/kZPa5PpC42qC9d7H9dQGBrWpuYUlhJXw7V/2izoxP0e1j6AWl3oaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=iFHyblut; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AF3FC4CEE6;
	Tue, 18 Feb 2025 22:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1739917853;
	bh=lGnuFFu6SOhWAc+x99/VErdwBRrTK3xG4wjC0+7AF2Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iFHyblutgXjBPg47qld09qyWY1QhYZIywANQlM7x2awJiOJ0uyeNYyubg5HM9ha35
	 SusvXovWyYZ1R5+gjI2lm5fAjVmaDB5cTORPP1WGIQkEgp4q0yVOUZRJ7iQwOJmCZ1
	 PotFrfzUvHOUDpSRGwK96XcyfwbX8eBG0jAx4KX0=
Date: Tue, 18 Feb 2025 14:30:52 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
Cc: <mm-commits@vger.kernel.org>, <stable@vger.kernel.org>,
 <peterz@infradead.org>, <osalvador@suse.de>, <luto@kernel.org>,
 <dave.hansen@linux.intel.com>, <byungchul@sk.com>, <42.hyeyoo@gmail.com>
Subject: Re: +
 x86-vmemmap-use-direct-mapped-va-instead-of-vmemmap-based-va.patch added to
 mm-hotfixes-unstable branch
Message-Id: <20250218143052.6a46beed709b1ccec6a9b119@linux-foundation.org>
In-Reply-To: <f197ef17-641a-4ed5-9bdb-15fdbc10b86d@intel.com>
References: <20250218054551.344E2C4CEE6@smtp.kernel.org>
	<f197ef17-641a-4ed5-9bdb-15fdbc10b86d@intel.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 18 Feb 2025 12:06:29 +0200 Gwan-gyeong Mun <gwan-gyeong.mun@intel.com> wrote:

> As the description in the cover letter 
> (https://lkml.kernel.org/r/20250217114133.400063-2-gwan-gyeong.mun@intel.com) 
> is included in the commit message, the same explanation is included in 
> from here

Please avoid sending a [0/n] cover letter for a single patch - this was
my lazy attempt to undo that.

Feel free to send along a new standalone patch, or to send out suitable
changelog text for this as a standalone patch.

