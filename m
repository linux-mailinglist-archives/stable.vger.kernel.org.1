Return-Path: <stable+bounces-230382-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YPGVIjwzxGkAxQQAu9opvQ
	(envelope-from <stable+bounces-230382-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 20:10:52 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E9C0E32B0B5
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 20:10:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B29A6304972B
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 19:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A70FD31F993;
	Wed, 25 Mar 2026 19:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M6BRRpGN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B25F3B2BA;
	Wed, 25 Mar 2026 19:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774465728; cv=none; b=QsU1ci8WYPpt9/OnpcDzoSd6b4y24/18sVQICOZvNhprQZQ3vxFPR2dJEdsJ6mOuOLqA87+5D03o23MxfqF9ZQ5MGIR7CT7d7vcO7aLK9dzTNPErNUE8Wrqg1tEZhfHhG+vrXtrakFehoP32R3W+16cKptV2DttwMZe+k5vCVUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774465728; c=relaxed/simple;
	bh=Qo41yGMXvFJziS9alU9r9/+sGjFxjt4T2tB+BRTnfmI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YT7au5GAwVRyXr0vk9e9fiWEZip3YexNB7hE/nzBzCq741ucE9KwRtX7U5EnUNsFPvBTwPEEjyyeYz+bzDyNI7qXnftLHB5Wbsn+3opkDMvIU1drW7gi8zN+DWUA+2ZneERBjjawbMS8JwyKAKosz4NhMxoD1OqabaAp/8NQnVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M6BRRpGN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DCC1C4CEF7;
	Wed, 25 Mar 2026 19:08:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774465727;
	bh=Qo41yGMXvFJziS9alU9r9/+sGjFxjt4T2tB+BRTnfmI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M6BRRpGNU+l+t/1WP2LzJARmGEBxhq/iSy4M7oAGkbTjXmU+7qIXz/CXlnURUJZDs
	 TGHiVbNkwtNLGM2foEPW7gFvzL+zlA2JZTkKG+Q5FGEMO1FI89Z3WEDMAStSUc+JKL
	 Ut+u74RH6/EzWcvqBk0QYi0qAmEcXOxXPqPz0LCgZHn7kC1xF4jSygmwAhJM3YncyC
	 GKdiuUAefSRfuhb9BQtP2ajY2FAC1p1bdLzeAu8Da0y3ym91sFhk0oic+nqgklU0GB
	 V/KCvC/5WKUJcxtJAaeqin4+SifD9kCzGujMle1it0FmoUZA4DRuPy80iF13OiKmpb
	 7cLwwhH1VvjzA==
Date: Wed, 25 Mar 2026 21:08:38 +0200
From: Mike Rapoport <rppt@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Jianhui Zhou <jianhuizzzzz@gmail.com>, SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>, jane.chu@oracle.com,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>, Peter Xu <peterx@redhat.com>,
	Andrea Arcangeli <aarcange@redhat.com>,
	Mike Kravetz <mike.kravetz@oracle.com>,
	Hugh Dickins <hughd@google.com>,
	Sidhartha Kumar <sidhartha.kumar@oracle.com>,
	Jonas Zhou <jonaszhou@zhaoxin.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	syzbot+f525fd79634858f478e7@syzkaller.appspotmail.com
Subject: Re: [PATCH v4] mm/userfaultfd: fix hugetlb fault mutex hash
 calculation
Message-ID: <acQytk1sO0EGBTH5@kernel.org>
References: <20260324170311.dc5b54fe0765f2e680e3cc90@linux-foundation.org>
 <20260325010618.85366-1-sj@kernel.org>
 <CAEgWzV5vp7bfr8=W6aVXNBFqxd9nVc-BGtG1jFUXJ_-+WWmPPg@mail.gmail.com>
 <af90838e-bef4-46d6-9bc1-c6185793ea62@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af90838e-bef4-46d6-9bc1-c6185793ea62@kernel.org>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-230382-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,linux-foundation.org,oracle.com,linux.dev,suse.de,redhat.com,google.com,zhaoxin.com,kvack.org,vger.kernel.org,syzkaller.appspotmail.com];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: E9C0E32B0B5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 25, 2026 at 09:49:54AM +0100, David Hildenbrand (Arm) wrote:
> On 3/25/26 07:07, Jianhui Zhou wrote:
> > On Tue, Mar 25, 2026 at 01:06:00AM +0000, SeongJae Park wrote:
> >> Seems userfaulfd.c is the only caller of the new helper function.  Why don't
> >> you define the function in userfaultfd.c ?
> > I kept hugetlb_linear_page_index() in include/linux/hugetlb.h because
> > this is hugetlb-specific logic, not userfaultfd-specific logic.
> 
> Yes, and see my comment about either removing it entirely again next, or
> actually also using it in hugetlb.c.

I think it's better to move large piece of mfill_atomic_hugetlb() to
hugetlb.c and git rid of the helper then. 
And now keep it simple for easier backporting.
 
> -- 
> Cheers,
> 
> David

-- 
Sincerely yours,
Mike.

