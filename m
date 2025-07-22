Return-Path: <stable+bounces-163641-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F648B0CFF3
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 05:04:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18CE4188C2EC
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 03:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E1A028B4EC;
	Tue, 22 Jul 2025 03:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uMPA1BEo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CACFD2877FA;
	Tue, 22 Jul 2025 03:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753153474; cv=none; b=bgrEpiqVlbXRP7FO9QnNsP8VcnV5rWnjPd951oOJQHSSJaJBnWsnfE9mmCMDWPHDWDqFyxlaGMaWJj0vUtCkHCTvi7CmiKf4Mh23A1pw/ANY/redIjmip9wcwZDrEypKJAPHsEVNWz+Ugp+EaaapvB1U24DFtxviX6Euswdz/4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753153474; c=relaxed/simple;
	bh=1vu1a22AWWwZkHho/rnSIgq17cO+xwEhtZK2Cpr3X8A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SFTk7+OlUa1AxYyEZP7qv03CEf1JhwuNWHEP95N3gZsQmZPM1sxEe3EWryIjTCz1/RjEWl9oISA11oyZI1lc1WqgizpSRK3hDOeBEmCr/u5q+y0ch9ZJDzVvGxKuZzzIy4d14h9lqs5ydEVr7xTTTVkVRiVsEKTtP39m/sIjKfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uMPA1BEo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83EF6C4CEED;
	Tue, 22 Jul 2025 03:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753153474;
	bh=1vu1a22AWWwZkHho/rnSIgq17cO+xwEhtZK2Cpr3X8A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uMPA1BEoE0LY9kjEl/GoVYAvIUSlIA+ToqWKUWbCxRNxVoZKSNofX0m2mClGpnLnt
	 twggXxhe4aSrhPWFZsJCyWWrPo1NaUUSQhMAEg2/OL0Gc0PLe3fkl9rtDJbC2/JjXI
	 JL3CRlG/WjD2ilLPCtL+Me2tcgguGVpJYurgTjtv1obzf//LBriPxuNMjunihyt3zl
	 IDfT4z67gV07G5hNGLx0PlGH9QYbcvlYNaC8gyNTITKoVzuWAATu10iTswVq7vR9o7
	 kHhFFKQ3Bt4PlB9ex+bTZasNdngo4NroA0YbsAKkvCEtYXuDV82MxdnTPBVPgJKbfW
	 ZQjfH9zsCl6LA==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Honggyu Kim <honggyu.kim@sk.com>,
	Hyeongtak Ji <hyeongtak.ji@sk.com>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] mm/damon/ops-common: ignore migration request to invalid nodes
Date: Mon, 21 Jul 2025 20:04:31 -0700
Message-Id: <20250722030431.56507-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250721195658.935f5e2436045cc311575c9c@linux-foundation.org>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 21 Jul 2025 19:56:58 -0700 Andrew Morton <akpm@linux-foundation.org> wrote:

> On Sun, 20 Jul 2025 11:58:22 -0700 SeongJae Park <sj@kernel.org> wrote:
> 
[...]
> > Add a target node validity check in damon_migrate_pages().  The validity
> > check is stolen from that of do_pages_move(), which is being used for
> > move_pages() system call.
> > 
> > Fixes: b51820ebea65 ("mm/damon/paddr: introduce DAMOS_MIGRATE_COLD action for demotion") # 6.11.x
> > Cc: stable@vger.kernel.org
> >
> > ...
> >
> > --- a/mm/damon/ops-common.c
> > +++ b/mm/damon/ops-common.c
> > @@ -383,6 +383,10 @@ unsigned long damon_migrate_pages(struct list_head *folio_list, int target_nid)
> >  	if (list_empty(folio_list))
> >  		return nr_migrated;
> >  
> > +	if (target_nid < 0 || target_nid >= MAX_NUMNODES ||
> > +			!node_state(target_nid, N_MEMORY))
> > +		return nr_migrated;
> > +
> >  	noreclaim_flag = memalloc_noreclaim_save();
> >  
> >  	nid = folio_nid(lru_to_folio(folio_list));
> > 
> 
> OK.  damon_migrate_pages() exists only in mm.git thanks to 13dde31db71f
> ("mm/damon: move migration helpers from paddr to ops-common").  I
> assume that you'll send the -stable people a patch which adds this check into
> damon_pa_migrate_pages() when called upon to do so.

That's very correct, Andrew.  I am planning to do so as soon as this is merged
into the mainline :)


Thanks,
SJ

