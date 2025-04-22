Return-Path: <stable+bounces-135118-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83A55A96A56
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 14:43:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C56E4005D3
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 12:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 370C581720;
	Tue, 22 Apr 2025 12:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="otd6e5Ys"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76551E3774
	for <stable@vger.kernel.org>; Tue, 22 Apr 2025 12:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745325672; cv=none; b=YcgywqOT9fjhFJsZmp6AtRCFJAiFk1tfMUA+mqwukUW5BWHY/ZjTLIJh5AWyTSwZT7ZhjPgz5cVVvrWL9V1P7NZUIakoNhLpYm5hrRSHFRWsXYaHOA1MKtDH21DcxNNhcgDYJk6vWxbopWOzxx23iXS9doGaQceH+cKz1VNIGUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745325672; c=relaxed/simple;
	bh=ENlVpz1R0ydeUX54tZxVjiNShAhqfRuCsAD0fBLLqO0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T7zHCyL56RYnhZmMGYw4FhtNpaBbfm3mkoxRB6cZJp/zZs/e4NTI2LyZhs5eLtDmQLdEcZWtCmOEemkA5dIcqzHnem/+u+A/z0as6NSGkJFqBXtE0sf6SJ8U1BjaIrgM2v+Ty6y2vNhXCQy1qZiCkQ/PCMP9AMrohHqMmfP+Ugo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=otd6e5Ys; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D464BC4CEE9;
	Tue, 22 Apr 2025 12:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745325670;
	bh=ENlVpz1R0ydeUX54tZxVjiNShAhqfRuCsAD0fBLLqO0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=otd6e5YsdFfGHc4WlklLQ4brQ93YhU3GwS6bmA8Q8590+XD5u/meJF0cN6FfXMwui
	 k7qMTBJKepEuTkiw6medbAp/W3cyNcknKg5K53GWgFkDBGSK18ibQgOqN/cE+X/IUj
	 OHPeWq06jpk+ir0d1aJe8y/fLZx8AG80KwFfBJuc=
Date: Tue, 22 Apr 2025 14:41:07 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Qingfang Deng <dqfext@gmail.com>
Cc: David Hildenbrand <david@redhat.com>, Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org, linux-mm@kvack.org, Zi Yan <ziy@nvidia.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Brendan Jackman <jackmanb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Liu Xiang <liu.xiang@zlingsmart.com>
Subject: Re: Please apply d2155fe54ddb to 5.10 and 5.4
Message-ID: <2025042256-unnerve-doorway-7cb7@gregkh>
References: <CALW65jbBY3EyRD-5vXz6w87Q+trxaod-QVy2NhVxLNcQHVw0hg@mail.gmail.com>
 <2025042251-energize-preorder-31cd@gregkh>
 <CALW65jbNq76JJsa9sH2GhRzn=Fe=+bBicW8XWmcj-rzjJSjCQg@mail.gmail.com>
 <2025042237-express-coconut-592c@gregkh>
 <CALW65jbEq250E1T=DpGWnP+_1QnPmfQ=q92NK8vo8n+jdqbDLg@mail.gmail.com>
 <7bf68ddd-7204-4a8c-b7df-03ecb6aa2ad2@redhat.com>
 <CALW65jaLXR3rjcTZN-uojuym6uCT8pMRnTHoY_OqCWJ+Yq0ggw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALW65jaLXR3rjcTZN-uojuym6uCT8pMRnTHoY_OqCWJ+Yq0ggw@mail.gmail.com>

On Tue, Apr 22, 2025 at 05:58:26PM +0800, Qingfang Deng wrote:
> Hi David,
> 
> 
> On Tue, Apr 22, 2025 at 3:04 PM David Hildenbrand <david@redhat.com> wrote:
> > > Let me post it again:
> > >
> > > Please consider applying d2155fe54ddb ("mm: compaction: remove
> > > duplicate !list_empty(&sublist) check") to 5.10 and 5.4, as it
> > > resolves a -Wdangling-pointer warning in recent GCC versions:
> > >
> > > In function '__list_cut_position',
> > >      inlined from 'list_cut_position' at ./include/linux/list.h:400:3,
> > >      inlined from 'move_freelist_tail' at mm/compaction.c:1241:3:
> > > ./include/linux/list.h:370:21: warning: storing the address of local
> > > variable 'sublist' in '*&freepage_6(D)->D.15621.D.15566.lru.next'
> > > [-Wdangling-pointer=]
> >
> > The commit looks harmless. But I don't see how it could fix any warning?
> >
> > I mean, we replace two !list_empty() checks by a single one ... and the
> > warning is about list_cut_position() ?
> 
> I have no idea, actually. Maybe the double !list_empty() confuses the
> compiler, making it think `sublist` can be referenced out of the
> scope?

That is odd, are you sure this isn't a compiler bug?

