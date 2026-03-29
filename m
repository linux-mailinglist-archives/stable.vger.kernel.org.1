Return-Path: <stable+bounces-230972-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8OODApx+yWnbyQUAu9opvQ
	(envelope-from <stable+bounces-230972-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 21:33:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 57D83353CDF
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 21:33:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 612F7300A604
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 19:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 735352F7445;
	Sun, 29 Mar 2026 19:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ncKYXgRy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 358071AAE28;
	Sun, 29 Mar 2026 19:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774812748; cv=none; b=HkBgaPje9VC5SMdI+fyJXwK3nYA5ecC93TbsFlEjUms6jwHY/fn4YW2BRHHhxJnrupIlYWI96Vp2aKFSSovVD8NI72zL8AfiuYCMAXEKhbcV+JQqzp7f3pWmCzcSUXSdEfuZG96DxaZpYpkahAK2N99RavLjz0NZ4LS6Dr8TnBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774812748; c=relaxed/simple;
	bh=GidK0k6cqcWgrzXgE0fU2eP8/imjAJ8bcJ7Zp2Lqr5g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TeN+d6RJ/c7ji0iGZUhJKCNA3HqFqKs3BXM1IDbhOYCapKjQI8PIoB9R3Ncp3fSoLI4dM3ZzD0GyI7bLciv3Xd/FoQFnpRfWBcbbiOh2OkM7//V5GzTSrH9yLIgTzi1kaElSKSXBCs9ftSXq5ZyfAA4yQHTfvjCyGTqNsl2HIFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ncKYXgRy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD943C116C6;
	Sun, 29 Mar 2026 19:32:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774812748;
	bh=GidK0k6cqcWgrzXgE0fU2eP8/imjAJ8bcJ7Zp2Lqr5g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ncKYXgRyzWHynpOrDPnHrj+O6t9H6BeAxrX059m1yw2sgIDmrmPGb+/TUNE2fRvWn
	 O3BEIdceoCWej4V7yLD6l6L6Rm8anVlCQGTp/1XQA9w62BAbIGaDRetS8IuFa63p9K
	 IAo4yIe5dX/iuaqQHHuVDwrBwxm/Pf9G1XaDiil7YbwGsC6StWtGDwjYHOV6x0zTmd
	 UVL4f7889EAORb/JXtscFG/m90EQ5IAeVKOjrAUE3ku7oFPBJTghiQx5QuqBGX55iT
	 F9EyHtUY3myDQewG3geUgCzNu8Heb9UTgKPwKsRMTltmEA6pvtFqgb4w6xtXBRV4KY
	 fUoxN1oiV5pJw==
From: SeongJae Park <sj@kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
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
Date: Sun, 29 Mar 2026 12:32:26 -0700
Message-ID: <20260329193226.59025-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2026032915-library-embolism-b48c@gregkh>
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
	TAGGED_FROM(0.00)[bounces-230972-lists,stable=lfdr.de];
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
X-Rspamd-Queue-Id: 57D83353CDF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

+ Roman for a case he has any opinion about my sashiko usage.

Hello Greg,

On Sun, 29 Mar 2026 20:05:53 +0200 Greg KH <gregkh@linuxfoundation.org> wrote:

> On Sun, Mar 29, 2026 at 08:49:16AM -0700, SeongJae Park wrote:
> > Forwarding sashiko.dev review status for this thread.
> > 
> > # review url: https://sashiko.dev/#/patchset/20260329153052.46657-1-sj@kernel.org
> 
> Why are you doing this?  If we want to see the review, can't we just go
> and look at the tool itself?

We can.  But it is bit cumbersome to opening web browser and moving my focus to
there.  Reading everything on the mailing tool is easier for some people like
me.  Like some test bots send reports are replying to patches, or we sometimes
forwarding bugzilla reports to mailing lists in a form of a plain text mail.

Secondly, I have to share my opinions about the reviews, as many times AI
reviews need human's opinions.  There is no good way to do that on the web ui
of the tool (sashiko) for now, and I think this mail based flow is the best.

And anyway I'm supposed to share at least my review of AI reviews, in mm
community.  If I ignore, I will only make Andrew have to reply asking that.

I used to share only my review of the AI reviews as replies, instead of
forwarding AI reviews and then replies to those.  But it was
1. cumbersome for me (should summarize AI review and then my review; feeling
   doing work twice), and
2. feeling not optimal at sharing all concerning comments with others.  My
   summary might miss some points of AI review but other reviewers might just
   believe me and don't read the full review due to the additional web browser
   opening work.  Also some other reivewers might kindly review AI reviews
   before I do, and save my (or their) time.

Hence I ended up to do this bit odd workflow:  Forwarding the full AI review on
the mailing list first, then reply my responses.

> sending it back to all of us feels odd,

If this is polluting your inbox and/or distract you, I'm so sorry for that.
Please let me know if this is distracting you.  Maybe I can filtering people
who don't want this kind of replies out of the recipients for the forwarding
mails.  Or, if you have a suggestion about what need to be changed, please let
me know.

> especially when it is your own patches.

Unfortuantely sashiko cannot send email on its own (yet).  So I'm doing that
until it can.

> 
> confused,

I hope my above explanation helps you.


Thanks,
SJ

[...]

