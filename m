Return-Path: <stable+bounces-230806-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qIUWJY4UyGksgwUAu9opvQ
	(envelope-from <stable+bounces-230806-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Mar 2026 18:49:02 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AFA334F73B
	for <lists+stable@lfdr.de>; Sat, 28 Mar 2026 18:49:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3A10B302D13F
	for <lists+stable@lfdr.de>; Sat, 28 Mar 2026 17:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61A58344D90;
	Sat, 28 Mar 2026 17:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CSnA9ZUk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC2F2F6160;
	Sat, 28 Mar 2026 17:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774720134; cv=none; b=K66UFyTtNcIBAOA+p2boiZMKcmr7V2x+vxvdzLZlOdS+bTjQru+U9pCwW/vKENS9HarikBO3GJHyClyjflIFUQ4zCahWmZg+7TyWQ5hM4USppr2Li1tZGYAAbWytcXr18X9qMPIfmBqnZi3l7zzeZOu+AabXEHhvudGQWEqi4l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774720134; c=relaxed/simple;
	bh=Sg6x97ANd8tIFA08/jJ7hgyZ6IOOblhEz9ehxsJhHE4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LuFC5qCAiqbiWYOvZMYXFuFih10eEyuQLYVJvmY8/HsvOw8eGhWFdxYgl3oX8nkblFgb/72K6ECbEKqEEV5ltacQ9mLrMGrAcnnAn9Q5sxRw4SsW25VZBoMtiJrp0zOJRFb8fQlvFRdNlDaMtN5xcdZ2fiFDCDSPg7Y/PR0Kws0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CSnA9ZUk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51C1CC4CEF7;
	Sat, 28 Mar 2026 17:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774720133;
	bh=Sg6x97ANd8tIFA08/jJ7hgyZ6IOOblhEz9ehxsJhHE4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CSnA9ZUkXUKgtI3r1nzkCgxnw3E+Ro571tGR8EixYrLYzvCdHdVOhSDusXh0Qwl8N
	 o9peR2Fib9N7nsvBHy9XjVrzsQOBkbSoK0hPExVvWMR36AzLy/F7hxfKRItBe4om5w
	 D0wr8BgX7DJcDwmENuxCtrZOdpdxw9deOOTykhvYA0o06mnA8Wj5m8lcNvWG5Gn7D2
	 aEsEYvhFcGmQvriiHQeW6oxRpXJTf3TTqO6icqJCdzSpz4SyJWvLJPdikz5WXHOczt
	 zzsNO/T+hQBePKxLMs0xHrnvmLngBxNEZdp6XKwhERI6mnoWrCLMUbay7uvDEBQ5qx
	 oNeXUHXD49PmQ==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
	"# 5 . 19 . x" <stable@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
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
	Liew Rui Yan <aethernet65535@gmail.com>
Subject: Re: (sashiko review) [RFC PATCH 1/2] Docs/admin-guide/mm/damon/reclaim: warn commit_inputs vs param updates race
Date: Sat, 28 Mar 2026 10:48:51 -0700
Message-ID: <20260328174852.53338-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260328173446.53021-1-sj@kernel.org>
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
	FREEMAIL_CC(0.00)[oracle.com,vger.kernel.org,linux-foundation.org,kernel.org,lwn.net,suse.com,linuxfoundation.org,google.com,lists.linux.dev,kvack.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-230806-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sj@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sashiko.dev:url]
X-Rspamd-Queue-Id: 3AFA334F73B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, 28 Mar 2026 10:34:45 -0700 SeongJae Park <sj@kernel.org> wrote:

> Forwarding Sashiko review for doing discussions via mails.
> 
> # review url: https://sashiko.dev/#/patchset/20260328172415.49940-2-sj@kernel.org
> # start of sashiko.dev inline review
> commit 8b189801fc104c5ecc412454a3d8db6a3faf27d6
> Author: SeongJae Park <sj@kernel.org>
>     
> Docs/admin-guide/mm/damon/reclaim: warn commit_inputs vs param updates race
> 
> This commit adds documentation warning users not to write to module
> parameters while commit_inputs is in progress. This warning is intended to
> help users avoid a race condition that can cause undefined kernel behavior.
> 
> Link: https://lore.kernel.org/20260319161620.189392-3-objecting@objecting.org
> 
> > diff --git a/Documentation/admin-guide/mm/damon/reclaim.rst b/Documentation/admin-guide/mm/damon/reclaim.rst
> > --- a/Documentation/admin-guide/mm/damon/reclaim.rst
> > +++ b/Documentation/admin-guide/mm/damon/reclaim.rst
> > @@ -71,6 +71,10 @@ of parametrs except ``enabled`` again.  Once the re-reading is done, this
> >  parameter is set as ``N``.  If invalid parameters are found while the
> >  re-reading, DAMON_RECLAIM will be disabled.
> >  
> > +Once ``Y`` is written to this parametr, the user must not write to any
> 
> This isn't a bug, but there is a typo ("parametr") in this line.

Good eye, I will fix this in the next revision.

> 
> > +parameters until reading ``commit_inputs`` again returns ``N``.  If users
> > +violate this rule, the kernel can do undefined behaviors.
> 
> Is it acceptable to document a race condition that leads to undefined
> behavior instead of fixing it?
> 
> Even if the module parameter interface is restricted to root, user space
> shouldn't be able to trigger kernel undefined behavior (which could lead to
> memory corruption or crashes) simply by writing to module parameters
> concurrently.
> 
> Should the underlying race condition in DAMON_RECLAIM be fixed with proper
> synchronization rather than relying on userspace adherence to a documentation
> warning?

Good callout.  In short, I agree for mainline kernel, but I'd argue this may be
enough for stable kernels.

That is, I was also thinking in a way similar to sashiko.  But, from the work I
realized the amount of changes for fixing those in stable-backporting-easy way
is not small.  Also, given the age of the broken commits (5.19!), I don't think
this is urgent.  And again arguably, as long as it is well documented, letting
users break kernel when they want (e.g., sysrq-trigger) is ok...?  Let me know
if other humans have different opinion, though.

But for future (mainline), surely this have to be fixed in the code.  And
Liew's patch [1] was initially started not for exactly this patch, but will fix
this together.  Cc-ing Liew.

So, I'm suggesting to add this documentation for stable kernels, and continue
helping Liew's patch for cleanly removing this awkward behavior in the mianline
and future kernels.

> 
> This isn't a bug, but the phrasing "can do undefined behaviors" is slightly
> awkward. Rephrasing to "may exhibit undefined behavior" might be more natural.

Good catch.  I will update so in the next version.

[1] https://lore.kernel.org/20260328084524.5451-1-aethernet65535@gmail.com


Thanks,
SJ

[...]

