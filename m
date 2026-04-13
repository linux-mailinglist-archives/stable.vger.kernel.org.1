Return-Path: <stable+bounces-236808-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uMWdNM4b3WkJaAkAu9opvQ
	(envelope-from <stable+bounces-236808-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:37:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 450AF3EF683
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:37:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 99B4B303EFCE
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E74D238D27;
	Mon, 13 Apr 2026 16:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a4QGVJeX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1796226D18;
	Mon, 13 Apr 2026 16:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776097845; cv=none; b=J3pmvQilNteknTATJ9GB8D+8jVESb1zNDIhktPyaDThLSusZ5ZulisnW3iddJpq+pcB1Lw6pVVMbB+pBB+R16XrLJlnAXaPD4ZGq9ubqwoVT6KcpQ89NY37UP0oCUaF3cVjZWV2IrVvw5ElUsaom2kcC9FprVQ+bfnl+LSopnpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776097845; c=relaxed/simple;
	bh=PK7mbw5vK+PS7JS7cx0S0i5xX4pUE1edlP/rxkybuLc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F7PgD8MKeUw2wph6ukDG3Nwp6a6aea7MjMs1+UZOjYOp+rA1/tnBBo19J4/pNcTpsiRk8LYY1pK/nJX1vaE8TTok/tJRxsRFEf1lf3Q2zbZLASGYo43FqEJEo3wyNLThSX7k2CNZQROGDeIcxttp4Mkep29QpvYZNf0hHzfNAtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a4QGVJeX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7307C2BCB0;
	Mon, 13 Apr 2026 16:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776097844;
	bh=PK7mbw5vK+PS7JS7cx0S0i5xX4pUE1edlP/rxkybuLc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a4QGVJeXLXzU7ZLYG3BHpnOkpB2nMYj0t5KjrnwAcO+kTKOFZnIbObBGL96KjktDx
	 jsbHzhDeIiTk8S1g4zlNOGRl/s9idgMHNzFH2UwLkRu2BlvLpVJjmg7q2deef8PYzd
	 QxhP73q9rv20akIahd4y1/DYiQIV+WgcAO7Hweloqk1oh8e5mheAZexTELAOONQDRm
	 ZyPJocJ4yGDUwDvfc4s3uFAp67kerne9Z9a3o1ttcfOaHo9gsjsCE/PeKUtrGRnED6
	 zbQxCzrWVpJhEAOHTJc1CYmUYzLo//GhEEbTLJcFsT8KtkhfnldkcmH09eAymfurdQ
	 V7rjOBW+HpCkA==
Date: Mon, 13 Apr 2026 06:30:43 -1000
From: Tejun Heo <tj@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] writeback: Fix use after free in
 inode_switch_wbs_work_fn()
Message-ID: <ad0aM1nN4j2I9Zh_@slm.duckdns.org>
References: <20260413093618.17244-2-jack@suse.cz>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260413093618.17244-2-jack@suse.cz>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-236808-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tj@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,suse.cz:email,slm.duckdns.org:mid]
X-Rspamd-Queue-Id: 450AF3EF683
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 13, 2026 at 11:36:19AM +0200, Jan Kara wrote:
> inode_switch_wbs_work_fn() has a loop like:
> 
>   wb_get(new_wb);
>   while (1) {
>     list = llist_del_all(&new_wb->switch_wbs_ctxs);
>     /* Nothing to do? */
>     if (!list)
>       break;
>     ... process the items ...
>   }
> 
> Now adding of items to the list looks like:
> 
> wb_queue_isw()
>   if (llist_add(&isw->list, &wb->switch_wbs_ctxs))
>     queue_work(isw_wq, &wb->switch_work);
> 
> Because inode_switch_wbs_work_fn() loops when processing isw items, it
> can happen that wb->switch_work is pending while wb->switch_wbs_ctxs is
> empty. This is a problem because in that case wb can get freed (no isw
> items -> no wb reference) while the work is still pending causing
> use-after-free issues.
> 
> We cannot just fix this by cancelling work when freeing wb because that
> could still trigger problematic 0 -> 1 transitions on wb refcount due to
> wb_get() in inode_switch_wbs_work_fn(). It could be all handled with
> more careful code but that seems unnecessarily complex so let's avoid
> that until it is proven that the looping actually brings practical
> benefit. Just remove the loop from inode_switch_wbs_work_fn() instead.
> That way when wb_queue_isw() queues work, we are guaranteed we have
> added the first item to wb->switch_wbs_ctxs and nobody is going to
> remove it (and drop the wb reference it holds) until the queued work
> runs.
> 
> Fixes: e1b849cfa6b6 ("writeback: Avoid contention on wb->list_lock when switching inodes")
> CC: stable@vger.kernel.org
> Signed-off-by: Jan Kara <jack@suse.cz>

Oh man, that's too subtle.

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun

