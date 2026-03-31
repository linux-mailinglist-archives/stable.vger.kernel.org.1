Return-Path: <stable+bounces-231316-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qEaJHutOy2l3FwYAu9opvQ
	(envelope-from <stable+bounces-231316-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 06:34:51 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 12106363E37
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 06:34:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1A797303CC0D
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 04:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57E2C2C11F9;
	Tue, 31 Mar 2026 04:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O4rVCzDJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15574253B42;
	Tue, 31 Mar 2026 04:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774931684; cv=none; b=WYnvW2mnBygHlFHvipW2X6KzIe6owqMOARAGBQQkg/HXarjcpwFc3L3mGcrkcy4HfDvOyfjbLb1P68Y0BiRigy4m2Xg9eQ2I7kPrm1KryJ9YL6XbwrQJpaFDEVk533ZXiDstOdJkGgXZo7cDEdxJln4YOQHPaOHKA7EkMLRaOO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774931684; c=relaxed/simple;
	bh=iddzIyo57Gf5sB0Ovre3TYWjXksr2WHRb+oWFdACaHY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cbWtJ3U8Ax0Gi4nThWBpYywMzk9ntm6n9nWEXRPMJaaq85tRHc6jS9Ay+AG+dhqznck/htGeW3CFGrnYuTpK3RUJ308ie7tcqfmBAtmK5A3hQkjWoBJrYamyFdY7u1nPej3ys3fNL1LLS86lZcsWsOtFwe3TI/mQvKdKjfVtXPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O4rVCzDJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF161C19423;
	Tue, 31 Mar 2026 04:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774931683;
	bh=iddzIyo57Gf5sB0Ovre3TYWjXksr2WHRb+oWFdACaHY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O4rVCzDJK1ThAOnYIY1hZm0cimOvsWGzC7jzqOQOpp0+6Qj1GjD0Lyl93L4BwFnXl
	 PPLlzaJgLmyJybeLdOhmLBiuVFnBD/OKEvKZnQztwVaApQ1ZDd6J71rLogh6nltF60
	 m+ccBJDJf2Ym1vgj6/8djkTkxhjN2BOTSPlO+wRMnRs2flSosMwqCScgxGyyroyztR
	 0HoUIY1wS0XwOvccFAwoUvXuIck6Ydat5gjLp6e3BIZ8s7JcHhbUdEVKVyzP10TJI2
	 b7dpVo996xAYbEiFR0vsAy0fqKxrtJKtU15TzihpYJbYXFUOjHJ0qemOvNmexynzy1
	 o2l7lHEmDa04g==
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
Date: Mon, 30 Mar 2026 21:34:41 -0700
Message-ID: <20260331043441.67196-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2026033013-drainage-stylized-43d6@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-231316-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sj@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,sashiko.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 12106363E37
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 30 Mar 2026 07:47:54 +0200 Greg KH <gregkh@linuxfoundation.org> wrote:

> On Sun, Mar 29, 2026 at 12:32:26PM -0700, SeongJae Park wrote:
> > + Roman for a case he has any opinion about my sashiko usage.
> > 
> > Hello Greg,
> > 
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
> 
> Sure, but are you going to now forward all random tool reviews that are
> run on your subsystem to all of these lists (your distribution cc: is
> quite large here)?

Obviously not for random tools.  But if there are a few tools that (nearly)
everyone agrees useful and worthy to integrate with the mailing lists workflow,
I would like to.

Now it seems I was much more optimistic that others.

> 
> > Secondly, I have to share my opinions about the reviews, as many times AI
> > reviews need human's opinions.  There is no good way to do that on the web ui
> > of the tool (sashiko) for now, and I think this mail based flow is the best.
> 
> That is assuming that you can fix up the AI reviews, is that happening
> here?

What I mean with the required human opinions for the AI reviews are not
necessarily only for fixups, but also sharing of reviews that the human and the
tool are aligned.

But in this case, I was sharing the review results seems incorrect, or doesn't
need deep dive at least:
https://lore.kernel.org/20260329163102.58683-1-sj@kernel.org

> 
> > And anyway I'm supposed to share at least my review of AI reviews, in mm
> > community.  If I ignore, I will only make Andrew have to reply asking that.
> > 
> > I used to share only my review of the AI reviews as replies, instead of
> > forwarding AI reviews and then replies to those.  But it was
> > 1. cumbersome for me (should summarize AI review and then my review; feeling
> >    doing work twice), and
> > 2. feeling not optimal at sharing all concerning comments with others.  My
> >    summary might miss some points of AI review but other reviewers might just
> >    believe me and don't read the full review due to the additional web browser
> >    opening work.  Also some other reivewers might kindly review AI reviews
> >    before I do, and save my (or their) time.
> > 
> > Hence I ended up to do this bit odd workflow:  Forwarding the full AI review on
> > the mailing list first, then reply my responses.
> > 
> > > sending it back to all of us feels odd,
> > 
> > If this is polluting your inbox and/or distract you, I'm so sorry for that.
> > Please let me know if this is distracting you.  Maybe I can filtering people
> > who don't want this kind of replies out of the recipients for the forwarding
> > mails.  Or, if you have a suggestion about what need to be changed, please let
> > me know.
> 
> It just seemed odd, and might get crazy over time if this happens for
> all random AI tools that happen to be popping up now, right?

As I also mentioned above, I agree.  And seems in this case I was much more
optimistic that others, or hallucinated ;)

> If this is
> the "official" one for -mm, that's fine, but consider the distribution
> and intended audience a bit please.

Andrew replied this is not such official and recommended action for mm.  I once
thought this could be the official one for DAMON only.  But in any case, I now
understand this can look crazy, odd or excessive to some people including those
that I believe.  I will think about a better way to use this tool, while
keeping your inputs in my mind.

Thank you so much for sharing your opinions, Greg.


Thanks,
SJ

[...]

