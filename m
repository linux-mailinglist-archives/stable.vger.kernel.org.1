Return-Path: <stable+bounces-230954-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ePzcNWZLyWk3xQUAu9opvQ
	(envelope-from <stable+bounces-230954-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 17:55:18 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 45354352B81
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 17:55:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CF4CE300D466
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 15:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B8593750DC;
	Sun, 29 Mar 2026 15:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EPoyftJl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DAEC3176E4;
	Sun, 29 Mar 2026 15:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774799645; cv=none; b=eOfFEAFV4qQYWzqiDGyEr5Z+moTZXWZMt7BzvAnBA7Wu36z0Z9zdJ8GG7rxkz3wr/vGdMLvmAl5sZ8XTb/5/p3Fu4vB5gA7bzFFVAEGRQStCg+xt9XEN7fOotW4Jzm3emu+bRGUjIQQFt+bpLIsRMeVPphwaN4t/mo6vxKuB5Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774799645; c=relaxed/simple;
	bh=EDzwBK7rJZWYtDV8j7S0PnDhvIIk/m3ub74/HBxXJas=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HlZHA6kGxEJ/khV/R8F1V525Jw+P20VkfuyjavBFy5hUxsv5QFhypfKXLbZgSbLbgHWtysW/wkQyP8S+RxMxoQSy+54p5IlgvI0RQfAdz2ymLaW9mvtubbv809wHMEa78kgyLV7i7ZTjihJQc3gOow4a3EV+2qCg851bvFujKOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EPoyftJl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87671C116C6;
	Sun, 29 Mar 2026 15:54:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774799644;
	bh=EDzwBK7rJZWYtDV8j7S0PnDhvIIk/m3ub74/HBxXJas=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EPoyftJlHI1QqrbHl8YzmsnvqpkqhBPv/5/8RBrLZeat2ecTEFhaXMRZDzXopLZGB
	 zinTNIhkwXqxrE0qBJF6zZgDdscvT63F8oLxuJpwWz0+kl1f0rLIURld9KQsmo39yW
	 RA7YdD7K6CozsvaZvtC0Hy5CUOiFke+ThLsb460g1G+7bgtpES/KiYPUljWOShcF50
	 7Dp2IOpweimUFJGys8ADnS3NjK21lS3jqBSr3ZZ5CE16dE3ggtiPutMimLbRpHij4v
	 jusExFkpQKiSlWWdf9t/mk7nlsNkhDyqxzwN337JO+cWs+vBrT+QVxM7xAYd4UPnjt
	 kxIbFFjcSDsmQ==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
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
	linux-mm@kvack.org
Subject: Re: (sashiko review) [PATCH 1/2] Docs/admin-guide/mm/damon/reclaim: warn commit_inputs vs param updates race
Date: Sun, 29 Mar 2026 08:54:02 -0700
Message-ID: <20260329155403.48037-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260329154937.47706-1-sj@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-230954-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 45354352B81
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, 29 Mar 2026 08:49:36 -0700 SeongJae Park <sj@kernel.org> wrote:

> Forwarding Sashiko review for doing discussions via mails.
> 
> # review url: https://sashiko.dev/#/patchset/20260329153052.46657-2-sj@kernel.org
> # start of sashiko.dev inline review
> commit 140a828ed89f6ed59d7b68f9bb0f1ec9b051eec7
> Author: SeongJae Park <sj@kernel.org>
> 
> Docs/admin-guide/mm/damon/reclaim: warn commit_inputs vs param updates race
> 
> This commit adds documentation warning users not to update DAMON reclaim
> module parameters while a commit_inputs request is in progress. It notes
> that doing so can cause undefined behavior due to races with the kdamond
> thread reading those parameters.
> 
> Link: https://lore.kernel.org/20260319161620.189392-3-objecting@objecting.org
> 
> > diff --git a/Documentation/admin-guide/mm/damon/reclaim.rst b/Documentation/admin-guide/mm/damon/reclaim.rst
> > index 47854c461706..d7a0225b4950 100644
> > --- a/Documentation/admin-guide/mm/damon/reclaim.rst
> > +++ b/Documentation/admin-guide/mm/damon/reclaim.rst
> [ ... ]
> > @@ -71,6 +71,10 @@ of parametrs except ``enabled`` again.  Once the re-reading is done, this
> >  parameter is set as ``N``.  If invalid parameters are found while the
> >  re-reading, DAMON_RECLAIM will be disabled.
> >  
> > +Once ``Y`` is written to this parameter, the user must not write to any
> > +parameters until reading ``commit_inputs`` again returns ``N``.  If users
> > +violate this rule, the kernel may exhibit undefined behavior.
> 
> Is it acceptable to rely on documentation to prevent undefined behavior
> triggered by userspace?
> 
> If users write to sysfs parameters concurrently, can it still crash the
> kernel? For example, in damon_reclaim_apply_parameters(), the code verifies
> if (!damon_reclaim_mon_attrs.aggr_interval) to prevent division by zero. If
> a user concurrently writes 0 to the parameter via sysfs immediately after
> this check but before damon_reclaim_new_scheme() executes, wouldn't the
> subsequent .min_age_region = min_age / damon_reclaim_mon_attrs.aggr_interval
> calculation result in a divide-by-zero kernel panic?
> 
> Should this race be fixed in the code using synchronization primitives
> rather than adding a documentation warning?

I answered the questions on the previous version.  In short, I believe this is
ok for stable kernels.  For mainline, Liew's patch [1] that can also fix this
issue is on the way.

[1] https://lore.kernel.org/20260329075415.36775-1-aethernet65535@gmail.com


Thanks,
SJ

[...]

