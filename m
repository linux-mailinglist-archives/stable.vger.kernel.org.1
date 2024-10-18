Return-Path: <stable+bounces-86745-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DD149A34F6
	for <lists+stable@lfdr.de>; Fri, 18 Oct 2024 08:00:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 763D11C2351E
	for <lists+stable@lfdr.de>; Fri, 18 Oct 2024 06:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F1B4185B69;
	Fri, 18 Oct 2024 05:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oqMt8tR4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EAE8183098
	for <stable@vger.kernel.org>; Fri, 18 Oct 2024 05:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729231126; cv=none; b=ox4y15YOaWP6gb2PAefUK/Ve5GsoIuERdZIiX0xY9HE4UMnjP32gMYqfX4MtAgZKJhRXDmfmVBMkOlcx8VBAoR4qbEcJVmtAyGd3V4LurCjcKYkDCYB7sFQuURdpbe46CmExdjUWuYL3oAQy72E+We1i5c0wYTG2hNoMw+ba7Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729231126; c=relaxed/simple;
	bh=QlIdjFAIqIbD4qsBaTam2HdBz1fsfrVeUscEMIiRS+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UhXiQyS/o+iVhs2QnLIP3QaWOPRT7C495J9+CHUW5bu+XYVL4bb0mgv8oMzVRhmMgk5jrPkwecnUSm1N94w/dO1ifroEe540gHthWrB1oFZQFD6RIvvkNWdlXYRy094/Orhg1qFjSd0VZlGTUbMWF60CyT32x53WfJXd9FY8D+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oqMt8tR4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BCA1C4CECF;
	Fri, 18 Oct 2024 05:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1729231125;
	bh=QlIdjFAIqIbD4qsBaTam2HdBz1fsfrVeUscEMIiRS+g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oqMt8tR4gBmcH+SVpZeR3udRSAzoLND37ym5Vt5g9KNj3JbOhcnJb/0mFvEZJ+K2M
	 8u8TCIIRWaMwwTLHvlD0MSaZsaMcDgd7nLIZZwqiAgfmJ2iaqfG3c4oyo9LFbYCRSM
	 YwJCYqkUdqtNrWYEqTXJ57zt2qKPL++ClE0ER9gw=
Date: Fri, 18 Oct 2024 07:58:41 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: chrisl@kernel.org
Cc: stable@vger.kernel.org, Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Yu Zhao <yuzhao@google.com>, Suren Baghdasaryan <surenb@google.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Vlastimil Babka <vbabka@suse.cz>,
	kernel test robot <oliver.sang@intel.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Marc Hartmayer <mhartmay@linux.ibm.com>
Subject: Re: [PATCH 6.11.y 0/3] : Yu Zhao's memory fix backport
Message-ID: <2024101856-avoid-unsorted-fc33@gregkh>
References: <20241017-stable-yuzhao-v1-0-3a4566660d44@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241017-stable-yuzhao-v1-0-3a4566660d44@kernel.org>

On Thu, Oct 17, 2024 at 02:58:01PM -0700, chrisl@kernel.org wrote:
> A few commits from Yu Zhao have been merged into 6.12.
> They need to be backported to 6.11.

Why?

> - c2a967f6ab0ec ("mm/hugetlb_vmemmap: don't synchronize_rcu() without HVO")
> - 95599ef684d01 ("mm/codetag: fix pgalloc_tag_split()")
> - e0a955bf7f61c ("mm/codetag: add pgalloc_tag_copy()")

For mm changes, we need an explicit ack from the mm maintainers to take
patches into the stable tree.  Why were these not tagged with the normal
"cc: stable@" tag in the first place?

thanks,

greg k-h

