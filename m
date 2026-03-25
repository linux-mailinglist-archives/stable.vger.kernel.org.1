Return-Path: <stable+bounces-230381-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kKaiOusyxGkAxQQAu9opvQ
	(envelope-from <stable+bounces-230381-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 20:09:31 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A08932B087
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 20:09:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6B76C309265F
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 19:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 341C53542E5;
	Wed, 25 Mar 2026 19:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PJmscyi/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90FB33B6EA;
	Wed, 25 Mar 2026 19:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774465343; cv=none; b=HsBVozscsjN4qXNJ5mUCGhh41G/A0/vw2V3QQzDFvFLFtSjRWVAPrvSqszpfYrYQBKvJ0O440kvTHUcNb+KsS5B3NISwmZujyDJ2ghOi8it76FQU2+zXFicprtPhRVIKIDgItvYkcAR3I0N0yE97Rgob5nVh5UDjT17CtBlW7JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774465343; c=relaxed/simple;
	bh=+VWz5tWUvCsex+dbkwWF0LLb0MFPoXaOB8REka4tMV8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D4++SLlo7GEKokv+a+tSYB5ecs/3PnCqC63kDrktdgBHH8iNfahWcv34dGCNRMUoZut98RPmNP8f541MIs82XZ3t1MZQdiZaryCxXPJb3HPTl/cBnod48vCfnISg3Er89vFgPOrHoVedB/o2WDKqS+Aaqcmk75l0OCYrmUyr0Rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PJmscyi/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46CBFC19423;
	Wed, 25 Mar 2026 19:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774465342;
	bh=+VWz5tWUvCsex+dbkwWF0LLb0MFPoXaOB8REka4tMV8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PJmscyi/Idy7S9h1NBn1IL+49mdMhklSh9xur61g0VumrBhg9J7QWsKsVuMes69v5
	 yCTsxPp1kmOOLrgRdNhnaOf83qFghqzJwXkXHMFzILzdTt8toLqSXb8reo8XREfTxJ
	 v8NjofJDJiJ6p2ykVdL29HyUmXqaJsa2s39wGgUdjUlfamzMLZfLrpJhqXIyds73rc
	 f8GdYEzgK1o5psoiuSAJCoyJ8wZca27mcAprvqu/02FwbkDoda+8us2qfGUaD+Hn+Y
	 FcNlcuPQ+u8mkuYg5EShDzuSUzQuFwEzHeNxsuFHUzhWp+DYno1E5y5Vpd5C9iTjlk
	 dY8r1+DQgLU2g==
Date: Wed, 25 Mar 2026 21:02:13 +0200
From: Mike Rapoport <rppt@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Jianhui Zhou <jianhuizzzzz@gmail.com>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>, jane.chu@oracle.com,
	Peter Xu <peterx@redhat.com>,
	Andrea Arcangeli <aarcange@redhat.com>,
	Mike Kravetz <mike.kravetz@oracle.com>,
	SeongJae Park <sj@kernel.org>, Hugh Dickins <hughd@google.com>,
	Sidhartha Kumar <sidhartha.kumar@oracle.com>,
	Jonas Zhou <jonaszhou@zhaoxin.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	syzbot+f525fd79634858f478e7@syzkaller.appspotmail.com
Subject: Re: [PATCH v4] mm/userfaultfd: fix hugetlb fault mutex hash
 calculation
Message-ID: <acQxNa_VJNmaFkfy@kernel.org>
References: <20260306140332.171078-1-jianhuizzzzz@gmail.com>
 <20260310110526.335749-1-jianhuizzzzz@gmail.com>
 <12e822c4-a4f2-4447-80b9-2eec35a03188@oracle.com>
 <CAEgWzV5ryMBgJWH3QmWfr9LaZoihXcffFWKjK6OfJF=pDF6BtA@mail.gmail.com>
 <20260324170311.dc5b54fe0765f2e680e3cc90@linux-foundation.org>
 <1075f7a0-232f-4268-94b3-573d11c4203f@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1075f7a0-232f-4268-94b3-573d11c4203f@kernel.org>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-230381-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linux-foundation.org,gmail.com,linux.dev,suse.de,oracle.com,redhat.com,kernel.org,google.com,zhaoxin.com,kvack.org,vger.kernel.org,syzkaller.appspotmail.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rppt@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,f525fd79634858f478e7];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 7A08932B087
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 25, 2026 at 09:49:09AM +0100, David Hildenbrand (Arm) wrote:
> On 3/25/26 01:03, Andrew Morton wrote:
> > On Wed, 11 Mar 2026 18:54:26 +0800 Jianhui Zhou <jianhuizzzzz@gmail.com> wrote:
> > 
> >> On Tue, Mar 10, 2026 at 12:47:07PM -0700, jane.chu@oracle.com wrote:
> >>> Just wondering whether making the shift explicit here instead of
> >>> introducing another hugetlb helper might be sufficient?
> >>>
> >>>      idx >>= huge_page_order(hstate_vma(vma));
> >>
> >> That would work for hugetlb VMAs since both (address - vm_start) and
> >> vm_pgoff are guaranteed to be huge page aligned. However, David
> >> suggested introducing hugetlb_linear_page_index() to provide a cleaner
> >> API that mirrors linear_page_index(), so I kept this approach.
> >>
> > 
> > Thanks.
> > 
> > Would anyone like to review this cc:stable patch for us?
> 
> I would hope the hugetlb+userfaultfd submaintainers could have a
> detailed look! Moving them to "To:"

Wouldn't help much with something deeply buried in a thread :)
 
> One of the issue why this doesn't get more attention might be posting a
> new revision as reply to an old revision, which is an anti-pattern :)
 
Indeed.
 
-- 
Sincerely yours,
Mike.

