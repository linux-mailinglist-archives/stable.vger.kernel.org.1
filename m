Return-Path: <stable+bounces-230565-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GAEYKdDbxWneCQUAu9opvQ
	(envelope-from <stable+bounces-230565-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 02:22:24 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 22DE633DCBE
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 02:22:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F3D9830374BF
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 01:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 816A22C375A;
	Fri, 27 Mar 2026 01:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="imXgyYWA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443B84F881;
	Fri, 27 Mar 2026 01:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774574539; cv=none; b=YzMdtCxUr5v2ngDSFDOL0MoQflswPBYHEcQvHKfW/eNj/JRUkB8DVAquO8y9Kjjt4kVElVqqsUeUHH8YufZ0mwQKBPHzJmiauS9BsdrEWww3HgVjddiWw1oEhZz7LDqOKaGAPM25u52UsWqm9N9S6GMpW4l8tumzTS6v0PfoQ7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774574539; c=relaxed/simple;
	bh=ptJUWvPNGK94YQ89lMNnnFafMWg0AR2vxZSfEMXpOEk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WFzwcMOb+Fr+gq+ivuSuuqG2GCZIcmr3H+d8qQbzA8h1wctKdOxPjabMkD8e6WUvsAuQSGuRoLeGPLS5eLwTPlFCHbwzRQPQrP3F8WU8QPBrlxHy5FapDOkpt7qknNEM6zDs6XRcZtaJK0FBvFiUiTuSHohhJx0PC7EoM8dB7u4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=imXgyYWA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C26E8C116C6;
	Fri, 27 Mar 2026 01:22:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774574538;
	bh=ptJUWvPNGK94YQ89lMNnnFafMWg0AR2vxZSfEMXpOEk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=imXgyYWAGdQqTNjfLLfY4Sl3qrRvkUWanFtm6ASO9QlyWBBVezX0L4R24t6kFmFGf
	 dbsByDHFA6Vn6zEHEce4qDI62K8Y+KFHA/I5RmgfRf7b9go/yD2tx9cJsrTADYMW5Q
	 R/5BFPqFfV+qxERxs/K/qqtzgH9KOlJcpQhJ9xaTP5SWf1Z49bM45U4ANY7WEunKZq
	 7JJ/1jLFIR/a8YWRRicXhTVKFyyf2wj8N3/+0IpXTox8iBQDOc43+1SAGzbrvXlgX6
	 MxwvubmeQl7eAK6ygDUO6fWO0E/g/I6yTXLCMQQYYBD9ZZQsuFddeeApf5QXo4yYXU
	 c4Rg73WDrzmmw==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	"# 6 . 17 . x" <stable@vger.kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: (sashiko review) [PATCH] mm/damon/sysfs: dealloc repeat_call_control if damon_call() fails
Date: Thu, 26 Mar 2026 18:22:16 -0700
Message-ID: <20260327012217.66272-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260327011747.66127-1-sj@kernel.org>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-230565-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sj@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 22DE633DCBE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

TL; DR: nice finding but orthogonal to this patch.

On Thu, 26 Mar 2026 18:17:47 -0700 SeongJae Park <sj@kernel.org> wrote:

> Forwarding Sashiko review for doing discussions via mails.
> 
> # review url: https://sashiko.dev/#/patchset/20260327003224.55752-1-sj@kernel.org
> # start of sashiko.dev inline review
> commit aba7f94d0accfda5ab9b573157f691de9e9acf00
> Author: SeongJae Park <sj@kernel.org>
> 
> mm/damon/sysfs: dealloc repeat_call_control if damon_call() fails
> 
> This commit attempts to fix a memory leak where repeat_call_control is
> not deallocated if damon_call() fails because the kdamond stopped before
> the invocation. It adds a check to free repeat_call_control when
> damon_call() returns an error.
> 
> Link: https://lore.kernel.org/20260320020630.962-1-sj@kernel.org
> 
> > diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
> > index 6a44a2f3d8fc..eefa959aa30a 100644
> > --- a/mm/damon/sysfs.c
> > +++ b/mm/damon/sysfs.c
> > @@ -1670,7 +1670,8 @@ static int damon_sysfs_turn_damon_on(struct damon_sysfs_kdamond *kdamond)
> >  	repeat_call_control->data = kdamond;
> >  	repeat_call_control->repeat = true;
> >  	repeat_call_control->dealloc_on_cancel = true;
> > -	damon_call(ctx, repeat_call_control);
> > +	if (damon_call(ctx, repeat_call_control))
> > +		kfree(repeat_call_control);
> 
> Does this fully resolve the leak of repeat_call_control?
> 
> If a sysfs writer thread calls damon_call() during kdamond shutdown,
> after the worker thread in kdamond_fn() flushes pending controls but
> before it sets ctx->kdamond = NULL:
> 
> kdamond_fn()
>    kdamond_call(ctx, true);
>    ...
>    // Before ctx->kdamond = NULL
> 
> Would damon_call() add the new request to ctx->call_controls and return 0
> since ctx->kdamond is not yet NULL and repeat is true?
> 
> If so, does this leave repeat_call_control in the queue and leaked since
> the worker is already exiting and this check is bypassed?
> 
> Could this same window also cause a deadlock for synchronous commands like
> DAMON_SYSFS_CMD_UPDATE_SCHEMES_STATS?
> 
> If a synchronous command with repeat = false is added to the queue during
> this same window, would the caller hang indefinitely on
> wait_for_completion() since the worker thread will never process the queue
> again?

Nice catch, but orthogonal to this patch.

I'm working on fixing the race with a separate patch:
https://lore.kernel.org/20260327004952.58266-1-sj@kernel.org

The patch would fix the two issues at once.

Nonetheless, the seaprate patch was motivated for only the deadlock issue.
Finding of the leak possibility is a good call.


Thanks,
SJ

[...]

