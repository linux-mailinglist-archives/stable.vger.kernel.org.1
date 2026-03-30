Return-Path: <stable+bounces-231284-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SN2BJqbpymkkBQYAu9opvQ
	(envelope-from <stable+bounces-231284-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 23:22:46 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 09AD5361680
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 23:22:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 406A6302DF76
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 21:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 384543A0B31;
	Mon, 30 Mar 2026 21:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="TlMRVBcn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2CAC325704;
	Mon, 30 Mar 2026 21:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774905727; cv=none; b=oUmGZyWuibLH557+JPrQhIXa7d1SSsbbaprGSrl/Mkj0cXlyTPamcoyArlSvMG4M6Pip7LlNPx7h7QslC8ShKlEcPl82Ftie8Z8o4xZ2XH+flqc1bUrV4NRPFUegtHyaRw0mCR4lxU0MrtRUMqwzlu+PK9n9S72jXY3ZW3MSaRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774905727; c=relaxed/simple;
	bh=MEWRnboV2bNkwQiahJ5k+v6T4kmH5A38Tmwfekx5+Z8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=IfzcYS/C7hkPrCH2OdBNyak5QZjx7KVTTLCC7EZVJYyqEud+twHPDQ6TQ1phwz4CEq3qYxhS4134A/U7a6862s/DBaQ//Aa+p3bW6EcSNqpprzCgl1ksAP0u9IYwolDfXLO2FGo3ew8Z4SMU2WfEPk/0W9OyLqd9IIwX2hRDbkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=TlMRVBcn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA31FC4CEF7;
	Mon, 30 Mar 2026 21:22:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1774905726;
	bh=MEWRnboV2bNkwQiahJ5k+v6T4kmH5A38Tmwfekx5+Z8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TlMRVBcnpychpAEroWbQz7/sAYailQgoeMk8W8f0z1h/YGHYywR6Bt3lOAXDRsq0q
	 A0jJ/r6ZD23d96zmJTcG5wWHOjnAu4ikN297Kfk3Kc6loPxpro/ziWHHloQMnFbS/P
	 Y00IMW9Oh84qfrPXQfXH2tjBThYn173ju1hh6ZTo=
Date: Mon, 30 Mar 2026 14:22:05 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: SeongJae Park <sj@kernel.org>
Cc: Greg KH <gregkh@linuxfoundation.org>, "Liam R. Howlett"
 <Liam.Howlett@oracle.com>, "# 5 . 19 . x" <stable@vger.kernel.org>, David
 Hildenbrand <david@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Lorenzo
 Stoakes <ljs@kernel.org>, Michal Hocko <mhocko@suse.com>, Mike Rapoport
 <rppt@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, Suren
 Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@kernel.org>,
 damon@lists.linux.dev, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, Roman Gushchin
 <roman.gushchin@linux.dev>
Subject: Re: (sashiko status) [PATCH 0/2] Docs/admin-guide/mm/damon: warn
 commit_inputs vs other params race
Message-Id: <20260330142205.e7c7d7b47ec15a634f6eebf4@linux-foundation.org>
In-Reply-To: <20260329193226.59025-1-sj@kernel.org>
References: <2026032915-library-embolism-b48c@gregkh>
	<20260329193226.59025-1-sj@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-231284-lists,stable=lfdr.de];
	DMARC_NA(0.00)[linux-foundation.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sashiko.dev:url]
X-Rspamd-Queue-Id: 09AD5361680
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, 29 Mar 2026 12:32:26 -0700 SeongJae Park <sj@kernel.org> wrote:

> On Sun, 29 Mar 2026 20:05:53 +0200 Greg KH <gregkh@linuxfoundation.org> wrote:
> 
> > On Sun, Mar 29, 2026 at 08:49:16AM -0700, SeongJae Park wrote:
> > > Forwarding sashiko.dev review status for this thread.
> > > 
> > > # review url: https://sashiko.dev/#/patchset/20260329153052.46657-1-sj@kernel.org
> > 
> > Why are you doing this?  If we want to see the review, can't we just go
> > and look at the tool itself?
> 
> We can.  But it is bit cumbersome to opening web browser and moving my focus to
> there.  Reading everything on the mailing tool is easier for some people like
> me.  Like some test bots send reports are replying to patches, or we sometimes
> forwarding bugzilla reports to mailing lists in a form of a plain text mail.
> 
> Secondly, I have to share my opinions about the reviews, as many times AI
> reviews need human's opinions.  There is no good way to do that on the web ui
> of the tool (sashiko) for now, and I think this mail based flow is the best.

I do agree with Greg that it's all a bit excessive.  Thanks for your
your diligence, but perhaps dial it back a bit?  It's OK - we're all
trying to figure out how best to utilize this tool.

I view Sashiko as primarily an author tool.  Sometimes I call it
checkpatch++.  In a better world, author would be able to sort out
Sashiko issues before ever sending out the patchset.  But in this
world, a public send is needed to obtain that review.

So what we're presently seeing is author development activity which is
unfortunately and inappropriately being conducted on a public list.

Personally, I pay only a little attention to author's Sashiko activity.
Just enough to see whether I should pay more attention.  If author
says "oops, let me redo" then fine, I'll await the next spin.  If
author says "that was all nonsense" then fine, time to take a closer
look.

