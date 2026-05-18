Return-Path: <stable+bounces-249364-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cAvWMPZfC2pgGQUAu9opvQ
	(envelope-from <stable+bounces-249364-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 20:52:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 349F7572742
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 20:52:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 79DEA302E935
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 18:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDD9038C421;
	Mon, 18 May 2026 18:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iqN572yY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D10A38AC9A;
	Mon, 18 May 2026 18:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779130305; cv=none; b=Oh/XkMkRGghno5BhOCKTh4AKVK1WZtLW0dSxPIKbWzae8erY7UDlsW6SB2Lx9KsWUoZLKLn7qLlnBrOvPF78e2mvl2QO9sy2SR75PNHCrjxR25XsMCn5r4CKE/A6V+0ZvkJ21nD84YyPZFT7eQH+2Ewzh1AYNxj8VOu1jvCnJYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779130305; c=relaxed/simple;
	bh=6Lvgnhc6Xb8QPNlRI9znH0XN9rOqY6eKVRxMv6ll1RE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BkrHtX5xw1RbBn2Dn3yS5e7P+mDWBvdt9pMp5yRyaV0rg5tFc5DcC8lFf/zp92sjznBRNbMlh7R1ONTCU0VPkX6XAb8uiVhZENMGaAXjcmdK7uWeZbhLDRNqpr6gE9YcqGwgO4nJlhRFEbdazeciWOoFesHHQd8QKqfN1GbTP6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iqN572yY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1291C2BCB7;
	Mon, 18 May 2026 18:51:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1779130305;
	bh=6Lvgnhc6Xb8QPNlRI9znH0XN9rOqY6eKVRxMv6ll1RE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iqN572yYEGMeCn69DQxDp9wYtLvYTM8ekMp93jJJAmLa4XkiLpGAPMFOnBXjEQtaN
	 Jx9jaHfBynxZJYJ+a0h8AlkURkZxDoeXvHsnCM6vgENZ9P1qkroyeiwUr9yXGed0z2
	 eQy2Zi6onzK6AiHM44gOheTuyhd/00ko8eopapOU=
Date: Mon, 18 May 2026 20:50:58 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Vlad Poenaru <vlad.wing@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>,
	Joanne Koong <joannelkoong@gmail.com>,
	Breno Leitao <leitao@debian.org>,
	Josef Bacik <josef@toxicpanda.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 6.18.y] fuse: avoid 0x10 fault in fuse_readahead when
 max_pages == 0
Message-ID: <2026051846-amazingly-bacteria-ab37@gregkh>
References: <20260518182602.3107764-1-vlad.wing@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260518182602.3107764-1-vlad.wing@gmail.com>
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249364-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[szeredi.hu,gmail.com,debian.org,toxicpanda.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 349F7572742
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, May 18, 2026 at 11:26:02AM -0700, Vlad Poenaru wrote:
> When fc->max_read is smaller than PAGE_SIZE (common on aarch64 with
> 64K base pages if the FUSE server advertises a small max_read in INIT),
> max_pages = min(fc->max_pages, fc->max_read / PAGE_SIZE) is 0, so
> cur_pages is 0 on every outer iteration.
> 
> fuse_io_alloc(NULL, 0) then calls fuse_folios_alloc(0, ...), which
> calls kzalloc(0, ...) and gets back ZERO_SIZE_PTR == (void *)16.
> The "if (!ia->ap.folios)" guard in fuse_io_alloc does not catch
> ZERO_SIZE_PTR, so fuse_io_alloc happily returns an ia whose
> ap.folios is 0x10.
> 
> The inner "while (pages < cur_pages)" loop runs zero times, then
> fuse_send_readpages(ia, ...) dereferences ap->folios[0] in
> folio_pos(), faulting at virtual address 0x10:
> 
>   Unable to handle kernel NULL pointer dereference at virtual address
>   0000000000000010
>    fuse_readahead+0x14c/0x490
>    read_pages+0x80/0x318
>    page_cache_ra_unbounded+0x1c0/0x2b0
>    page_cache_ra_order+0xb8/0x368
>    page_cache_sync_ra+0x210/0x320
>    filemap_get_pages+0x290/0xdb0
>    generic_file_read_iter+0xd0/0x540
>    fuse_file_read_iter+0x8c/0x158
>    __arm64_sys_read+0x1a0/0x488
> 
> addr2line on the aarch64 vmlinux maps fuse_readahead+0x14c to
> fs/fuse/file.c:897 inlined into :999, i.e. "folio_pos(ap->folios[0])"
> inside fuse_send_readpages.  The faulting instruction "ldr x8, [x8]"
> loads ap->folios[0]; ap->folios was previously loaded as 0x10
> (ZERO_SIZE_PTR).
> 
> Without this fix the function would also spin forever, since
> "nr_pages -= pages" makes no progress when pages stays 0; in practice
> the NULL deref masks the spin.
> 
> Bail out of the outer loop if cur_pages is 0 -- there is no work we
> can issue via FUSE in this iteration, and remaining folios will be
> handled by read_pages() falling back to ->read_folio.
> 
> Note: this code was rewritten in mainline by commit 4ea907108a5c
> ("fuse: use iomap for readahead"), which switched fuse_readahead to
> iomap and removed the buggy loop entirely.  This patch therefore
> applies only to stable branches that still carry the pre-iomap
> readahead path.
> 
> Fixes: 3eab9d7bc2f4 ("fuse: convert readahead to use folios")
> Reported-by: Breno Leitao <leitao@debian.org>
> Cc: stable@vger.kernel.org
> Signed-off-by: Vlad Poenaru <vlad.wing@gmail.com>
> ---
>  fs/fuse/file.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>

