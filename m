Return-Path: <stable+bounces-231317-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KJJgISlTy2lYGQYAu9opvQ
	(envelope-from <stable+bounces-231317-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 06:52:57 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DD2FF363F18
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 06:52:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 88BBF3021EA3
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 04:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF92C3624DE;
	Tue, 31 Mar 2026 04:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TYXXjUYG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A280345CDD;
	Tue, 31 Mar 2026 04:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774932768; cv=none; b=ij3Lm/3LjD6R09PbYBq2bXIMuCp9FKExwHa2QXPBFm1e5OCzyteqfap/Fl7bFENvKuHZzzqdxGQQv79tyTsnJHGhv+LWxeq7VB9C1VtlwYfKTraBk6ekmRZ6BH8x1fg3VykUus8JZ5Bzw7e/LngXu3YOj98r1gYzpKpegFAXdu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774932768; c=relaxed/simple;
	bh=W1sV0gG5y7v5xTcQdkLYhQC8LVNXIot5XhAZDvh9WtE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=elKHdslCQCGOYUmbDgBxj2hH+d3ypXbF1eofzTwZR2+bw2SGVNgUBS7vwlXSBMNQYt5Cvg0kob4uk7xINYM9b5BfmmCexyQ7NjfZwjT9h8m8Up+6wTv5hrRzaNsaN4XkbyNsG/SC+sYNKxmTTX5g3mLewnPalbbbsQWJ071Ac8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TYXXjUYG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C421C19423;
	Tue, 31 Mar 2026 04:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774932768;
	bh=W1sV0gG5y7v5xTcQdkLYhQC8LVNXIot5XhAZDvh9WtE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TYXXjUYGsygiFeTxc15ZdsIJXlkwr86dYuvCilb0aMIDAh38qnVxfos/7uroLY2PU
	 iWYOMO4QDA3gMPxE2alA8RkBjKU8Oo5jJffsQ9Y8izDZ/UlHADM8T7YHPRBS4AZnfb
	 SEEM7AJFtW9Y76p0FPK9IOtBohiB6NkBjXpEbjCJgymtOtS8vlmQjlkC8RjYA4l+IV
	 Qt0l1kNaXWlfLZrcyVKHs5OrJPe9Dt/ziF+OcBeg8MdY9RRH0U/jj2uOWkpPizFeDM
	 LzzrM+mpWPjqrT8WlBtVvGgCoJgBACt9VQ/vmYFICTi16MmCkuR9me4asjESYAsxDw
	 9BCXgjPOU1KYg==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Greg KH <gregkh@linuxfoundation.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	"# 5 . 19 . x" <stable@vger.kernel.org>,
	David Hildenbrand <david@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Roman Gushchin <roman.gushchin@linux.dev>
Subject: Re: (sashiko status) [PATCH 0/2] Docs/admin-guide/mm/damon: warn commit_inputs vs other params race
Date: Mon, 30 Mar 2026 21:52:45 -0700
Message-ID: <20260331045245.67438-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260330142205.e7c7d7b47ec15a634f6eebf4@linux-foundation.org>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-231317-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sj@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sashiko.dev:url,linuxfoundation.org:email]
X-Rspamd-Queue-Id: DD2FF363F18
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 30 Mar 2026 14:22:05 -0700 Andrew Morton <akpm@linux-foundation.org> wrote:

> On Sun, 29 Mar 2026 12:32:26 -0700 SeongJae Park <sj@kernel.org> wrote:
> 
> > On Sun, 29 Mar 2026 20:05:53 +0200 Greg KH <gregkh@linuxfoundation.org> wrote:
> > 
> > > On Sun, Mar 29, 2026 at 08:49:16AM -0700, SeongJae Park wrote:
> > > > Forwarding sashiko.dev review status for this thread.
> > > > 
> > > > # review url: https://sashiko.dev/#/patchset/20260329153052.46657-1-sj@kernel.org
> > > 
> > > Why are you doing this?  If we want to see the review, can't we just go
> > > and look at the tool itself?
> > 
> > We can.  But it is bit cumbersome to opening web browser and moving my focus to
> > there.  Reading everything on the mailing tool is easier for some people like
> > me.  Like some test bots send reports are replying to patches, or we sometimes
> > forwarding bugzilla reports to mailing lists in a form of a plain text mail.
> > 
> > Secondly, I have to share my opinions about the reviews, as many times AI
> > reviews need human's opinions.  There is no good way to do that on the web ui
> > of the tool (sashiko) for now, and I think this mail based flow is the best.
> 
> I do agree with Greg that it's all a bit excessive.  Thanks for your
> your diligence, but perhaps dial it back a bit?  It's OK - we're all
> trying to figure out how best to utilize this tool.

Thank you for your kind words, Andrew.  I understand and admit the fact that
this looks excessive.

> 
> I view Sashiko as primarily an author tool.  Sometimes I call it
> checkpatch++.

Thank you for sharing your perspective.  This is helpful at what you want from
the use of the tool, thank you.

My view of sashiko was a human reviewer that having very odd characteristic and
cannot answer to my feedback for a reason, but still being useful in many
cases.  Hence I wanted to help the special reviewer be able to communicate with
others on the mailing list.  And I was thinking anyway that's what sashiko will
do, because I saw sending review as mail as one of TODO items for sashiko, from
the public announcement, and I onboarded DAMON for that.

But apparently not everyone is sharing same view.  My understanding of the TODO
item in sashiko public announcement may also be biased.  Maybe being a
subsystem's sole maintainer that looking for a reviewer made such uncautiously
biased perspectives.

> In a better world, author would be able to sort out
> Sashiko issues before ever sending out the patchset.  But in this
> world, a public send is needed to obtain that review.
> 
> So what we're presently seeing is author development activity which is
> unfortunately and inappropriately being conducted on a public list.

Makes sense.  Now I understand why you and Roman were discussing having a
separate mailing list for sharing the reviews via mail as a path forward, and
I agree that could be a good option.

> 
> Personally, I pay only a little attention to author's Sashiko activity.
> Just enough to see whether I should pay more attention.  If author
> says "oops, let me redo" then fine, I'll await the next spin.  If
> author says "that was all nonsense" then fine, time to take a closer
> look.

Makes sense.  I will try to keep sharing necessary information, but for only
targetted audiences, with less traffic.


Thanks,
SJ

