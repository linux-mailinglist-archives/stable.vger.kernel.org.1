Return-Path: <stable+bounces-165156-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B09DEB156F6
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 03:27:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F221A1690D3
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 01:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EFEE189F20;
	Wed, 30 Jul 2025 01:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dX6s5/kz"
X-Original-To: stable@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EACEC288A2;
	Wed, 30 Jul 2025 01:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753838870; cv=none; b=UtZV14v/HEiVGMhqurMR7nL1lBkHRx1Q8Y08zjm7BcpvSgMBWWzN8lc7/ucpzW6IChFlsZVuglMt3BOv9olwLmro2PO4bDCd/m9NxcKCxFaIsvyULMVLQ5HclGt2mEI82FnOzX3der53I9jXu5bYlm7RuWckdVAdR/2OGitDI6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753838870; c=relaxed/simple;
	bh=PFhGrtG3EPPnYRmiWWw71wZOLBIpKvv027UovuoBJAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=txtMxckoMa6AEtCVibW9IhCXroZ3YI809Pd5v0dZzULG6o3IblcUF3Me6OiCvM7LYdiOOcZ/sAG1XASFzADaBBhwF7BCHe1DvWI2zAYZMMKuo4qSNuKnZLA5HjAtswGCKKVLQmV2mkaZ/9bzHJDGDrwOQMZrGpwJwmTktdI5t+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=dX6s5/kz; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=BqJo0Y4jq0wed5EnAFkc9W+LR5gtcBNRm3C9RAj6lqM=; b=dX6s5/kzKLlo0cGDY7TRaTBZmf
	ETcOMMlGUJ/zvUN0FuXvvQFnD0S0NhP15hWiCtPjGzBSGUyhANiaptZ5jrhR/pmeHSSbPXbYP3RH6
	IvVgL3E54W7KroseoPMOaBWf35LWmiahGrkNpmrCvvfP81njyFE2siROdpapawtH7GMKTDBINMf6y
	/E57+5sHe0V9uj1O6bBJ3hFKh+GU6iNWerZt3x7iua7UFYE1GPkheIymYpbitRX84zWmiNme8P4cj
	FX7i07Sf/at1CyrtF/uxuRRucnlbQl1R4BRIEgSmXga3a7xYxltw1zu7K3lsn6xcsScGRJiYBG0ju
	2vJPn+TQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ugvbN-000000040Mh-31AT;
	Wed, 30 Jul 2025 01:27:29 +0000
Date: Wed, 30 Jul 2025 02:27:29 +0100
From: Matthew Wilcox <willy@infradead.org>
To: "Isaac J. Manjarres" <isaacmanjarres@google.com>
Cc: lorenzo.stoakes@oracle.com, gregkh@linuxfoundation.org,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@redhat.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Kees Cook <kees@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
	Hugh Dickins <hughd@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>, aliceryhl@google.com,
	stable@vger.kernel.org, kernel-team@android.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 5.4.y 0/3] Backport series: "permit write-sealed memfd
 read-only shared mappings"
Message-ID: <aIl1AbmESlTruw7K@casper.infradead.org>
References: <20250730005818.2793577-1-isaacmanjarres@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250730005818.2793577-1-isaacmanjarres@google.com>

On Tue, Jul 29, 2025 at 05:58:05PM -0700, Isaac J. Manjarres wrote:
> Lorenzo's series [2] fixed that issue and was merged in kernel version
> 6.7, but was not backported to older kernels. So, this issue is still
> present on kernels 5.4, 5.10, 5.15, 6.1, and 6.6.
> 
> This series backports Lorenzo's series to the 5.4 kernel.

That's not how this works.  First you do 6.6, then 6.1, then 5.15 ...

Otherwise somebody might upgrade from 5.4 to 6.1 and see a regression.

