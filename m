Return-Path: <stable+bounces-89944-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E87B9BDB3D
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 02:33:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDD2A284632
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 01:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 492D517DFF2;
	Wed,  6 Nov 2024 01:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lchHlTP9"
X-Original-To: stable@vger.kernel.org
Received: from out-175.mta0.migadu.com (out-175.mta0.migadu.com [91.218.175.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0B13D66
	for <stable@vger.kernel.org>; Wed,  6 Nov 2024 01:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730856787; cv=none; b=qxIDehao3mxRd4DDTGs97b9NblfjNJgccZKCKH1HA/FgP7g1nJLjkav6rf8gyDGTkHRqzp4JN31aCVw8x6lYqZWgDqzzpueMmjOYMiUvNKjs9gmpW1218WdNVqsIIPWRIGQmtdnPfWnQ0VdXcq/iuGvoLakY7mjzQTpnYDNlk4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730856787; c=relaxed/simple;
	bh=T8TSSH9vC+xuqwWLtvuSmsWAENczxGZF4Hk4GuT1PoE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hDy1okOEx8tdS2eIy7UMPAgzGUsLG6r0KWxaFNhx2VHRRLxLwhJ+ZvD67DV+6bCPHeRoApW3BEytO1eG5vrGXVfvgWUQYxQDZCVY2jNAosImvi0K83m9SAMeTx1he0TeTKWBU6mfaFXysN+5hIrZMwM1ZwG5wmwFuvsrAqfmIAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lchHlTP9; arc=none smtp.client-ip=91.218.175.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 6 Nov 2024 01:32:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1730856781;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UXENiiBPrtKGHgokfuDpSrDdZeSnPcm0OZeF9aDTtlk=;
	b=lchHlTP9AyPGZhl8bTdCCXBeyzBTnOI/tAYx3EnNg15TY7hLErpysQZpCplkXKcBkF+6on
	sPJsLLggrc9CwFqVxmeBNF6u4BoqVKIFHBf0Cs76ZpAKBzf0xOZKY+SJHeR1uRCCO+USJ2
	DpbgbDS3MsR+6eyUik+e6vOmE5BeTOw=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Sean Christopherson <seanjc@google.com>
Cc: Hugh Dickins <hughd@google.com>,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
	Shakeel Butt <shakeel.butt@linux.dev>
Subject: Re: [PATCH v2] mm: page_alloc: move mlocked flag clearance into
 free_pages_prepare()
Message-ID: <ZyrHSfS8Ro0l5VCP@google.com>
References: <20241021173455.2691973-1-roman.gushchin@linux.dev>
 <d50407d4-5a4e-de0c-9f70-222eef9a9f67@google.com>
 <ZxcK_Gkdn0fegRl6@google.com>
 <ZyrBuZPBjJi75gGU@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZyrBuZPBjJi75gGU@google.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Nov 05, 2024 at 05:09:13PM -0800, Sean Christopherson wrote:
> On Tue, Oct 22, 2024, Roman Gushchin wrote:
> > On Mon, Oct 21, 2024 at 12:49:28PM -0700, Hugh Dickins wrote:
> > > On Mon, 21 Oct 2024, Roman Gushchin wrote:
> > > I don't think there's any need to change your text, but
> > > let me remind us that any "Bad page" report stops that page from being
> > > allocated again (because it's in an undefined, potentially dangerous
> > > state): so does amount to a small memory leak even if otherwise harmless.
> > 
> > It looks like I need to post v3 as soon as I get a publicly available
> > syzkaller report, so I'll add this to the commit log.
> 
> Today is your lucky day :-)

I've been waiting for it for a long time :)
Thanks for forwarding it my way!

I'm still not sure what the conclusion of our discussion was. My understanding
is that my fix is not that pretty, but there are no better immediate ideas, only
long-term improvement projects. Does it matches everybody else's understanding?

If so, I'll prepare a v3 with an updated link. Otherwise, please, let me know.

Thanks!

