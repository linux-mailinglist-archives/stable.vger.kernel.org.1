Return-Path: <stable+bounces-237606-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +GlEJz4n3WlpaQkAu9opvQ
	(envelope-from <stable+bounces-237606-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 19:26:22 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 415803F161F
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 19:26:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 74322301BE99
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 17:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 428BF34B1AD;
	Mon, 13 Apr 2026 17:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="l+l4bQQI";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="fmxin4ZA";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="RwyBqOMT";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="9+JvvdM8"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A9B3368B5
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 17:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776101178; cv=none; b=HAxL8sOqHh6OMSD4u6Pgl+Fx6p9sl4dhWOwUxINU9znXD/4QZLJNs/g9mNXYqCReH7lXwvAEOwvK7yIqJXvGA18m6BBQ/7mKNgeRLu7WyVe2XXKUNRgvlxGmrobYoziwlQpUQfbJSQrTC01knPAD1yrJHRB8b+g7p+uce66auBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776101178; c=relaxed/simple;
	bh=gk/d0vDHy1G4zVjJc8QkWV0zxa8oNGe4HoqoGbMDLwU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SjMc14vZEqcZfP/YX8yn18xTvDQnfuc9cIO/CZ1QMU8jC2cwe1qcTaJM32XROf+b9GTWXGfflXJOk9KEwNa4dauHegMGCX4sEQ4zCfpXtZGV1DL61pYFJJR0M7eml61FxAZ9g7LTXXw3DXaXRkhhhJpQ1lDIFwkabOHNzXEM9fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=l+l4bQQI; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=fmxin4ZA; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=RwyBqOMT; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=9+JvvdM8; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E02046A8AE;
	Mon, 13 Apr 2026 17:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1776101175; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=o7aw8J/j07FwLbBY8fhKkEl8gN1ZFsU/i8nNYo+FjrQ=;
	b=l+l4bQQISeg4R6PuteS0WR9jpy6T0t8zFTUS1bYFM9C2z19YHKTcWu8ZklcN3zCQdBbZFF
	y7sgY3LjhCZ4BJmk5n2w3p0Wqz4vS3qzjzD2tKefVnt4axpQK9i/aRBb8HlABnwNysEpAK
	Njbubfpv1ErqwbzUpplpyCPJgDYQTD4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1776101175;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=o7aw8J/j07FwLbBY8fhKkEl8gN1ZFsU/i8nNYo+FjrQ=;
	b=fmxin4ZAyQAh9iR1x2GLZDO9hSKqk6pubAdgr45syO17S+IEU6BLfI5LxZrtpzzjPPTzAx
	TbnHVbscjazmtrBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1776101174; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=o7aw8J/j07FwLbBY8fhKkEl8gN1ZFsU/i8nNYo+FjrQ=;
	b=RwyBqOMTYaIxPvzNelBN/SjXGqZpM8EIHUNnVFKr4o5BfT8+fFBONbBpumTgzclFweWKZt
	W51L/ifiMHFyTZdQPpSvinbmIAcFbWTgSM0MXYTVSvdCXwwJkdrfAclnWJRDcnNcsLWZ/t
	dKh7EOja5K29rBeIsPjyPQB4bQRASRM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1776101174;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=o7aw8J/j07FwLbBY8fhKkEl8gN1ZFsU/i8nNYo+FjrQ=;
	b=9+JvvdM8wn+MVzhnBn6KdCsxI1+iDeQ/Js4Uk5GqsLcg89KlIOnhpWovFzFiiYK/lxrNc6
	VBcQt3O3HmtlSAAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D6B704AFD3;
	Mon, 13 Apr 2026 17:26:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0OVoNDYn3WmlLwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 13 Apr 2026 17:26:14 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 98C42A0B44; Mon, 13 Apr 2026 19:26:14 +0200 (CEST)
Date: Mon, 13 Apr 2026 19:26:14 +0200
From: Jan Kara <jack@suse.cz>
To: Tejun Heo <tj@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>, 
	linux-fsdevel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] writeback: Fix use after free in
 inode_switch_wbs_work_fn()
Message-ID: <acw7s5offdtioyzijg5wpuwzxcytrovadfdcqqh6l5dsyfwbvr@exd3emeqpjze>
References: <20260413093618.17244-2-jack@suse.cz>
 <ad0aM1nN4j2I9Zh_@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad0aM1nN4j2I9Zh_@slm.duckdns.org>
X-Spam-Score: -3.80
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,suse.com:email];
	DMARC_NA(0.00)[suse.cz];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-237606-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.cz:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jack@suse.cz,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 415803F161F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon 13-04-26 06:30:43, Tejun Heo wrote:
> On Mon, Apr 13, 2026 at 11:36:19AM +0200, Jan Kara wrote:
> > inode_switch_wbs_work_fn() has a loop like:
> > 
> >   wb_get(new_wb);
> >   while (1) {
> >     list = llist_del_all(&new_wb->switch_wbs_ctxs);
> >     /* Nothing to do? */
> >     if (!list)
> >       break;
> >     ... process the items ...
> >   }
> > 
> > Now adding of items to the list looks like:
> > 
> > wb_queue_isw()
> >   if (llist_add(&isw->list, &wb->switch_wbs_ctxs))
> >     queue_work(isw_wq, &wb->switch_work);
> > 
> > Because inode_switch_wbs_work_fn() loops when processing isw items, it
> > can happen that wb->switch_work is pending while wb->switch_wbs_ctxs is
> > empty. This is a problem because in that case wb can get freed (no isw
> > items -> no wb reference) while the work is still pending causing
> > use-after-free issues.
> > 
> > We cannot just fix this by cancelling work when freeing wb because that
> > could still trigger problematic 0 -> 1 transitions on wb refcount due to
> > wb_get() in inode_switch_wbs_work_fn(). It could be all handled with
> > more careful code but that seems unnecessarily complex so let's avoid
> > that until it is proven that the looping actually brings practical
> > benefit. Just remove the loop from inode_switch_wbs_work_fn() instead.
> > That way when wb_queue_isw() queues work, we are guaranteed we have
> > added the first item to wb->switch_wbs_ctxs and nobody is going to
> > remove it (and drop the wb reference it holds) until the queued work
> > runs.
> > 
> > Fixes: e1b849cfa6b6 ("writeback: Avoid contention on wb->list_lock when switching inodes")
> > CC: stable@vger.kernel.org
> > Signed-off-by: Jan Kara <jack@suse.cz>
> 
> Oh man, that's too subtle.
> 
> Acked-by: Tejun Heo <tj@kernel.org>

Thanks for review! I forgot to mention in the changelog that these UAF
issues were actually reliably hit in practice by one user on a Kubernetes
cluster. So it is subtle but actually practical issue...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

