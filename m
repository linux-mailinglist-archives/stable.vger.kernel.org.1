Return-Path: <stable+bounces-249892-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CBI/GsGgDWqC0AUAu9opvQ
	(envelope-from <stable+bounces-249892-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 13:53:37 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BFDC58CFFA
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 13:53:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7F72D305596A
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 11:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0BB9371063;
	Wed, 20 May 2026 11:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="rg65UGkh"
X-Original-To: stable@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDCBB233925;
	Wed, 20 May 2026 11:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779277269; cv=none; b=U1v7oz1e8rCcq2b1YZ91u9Wvv8fVLV158alvI1JF0pPPR9ysAsh+b66v0/KI3n2GS5QndqOEvW7r3UZ1VSw1as++5k5ZX3+4C6DXxIBWK7r5plobliVdOtacQo+5+aLgIiYoWEV2PTA5zfeTaE7ceTpg3tYJ869l8Ux5DnVJqz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779277269; c=relaxed/simple;
	bh=cv2lOd1UJWlI1mRmvVecDPY4PRJV3tpIzSZp0gC+Iu4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sgoyJrhhS9wUg1VC1rPRDtbNDm9e8Sv9FwCxT7Pim16WdTjJwMgxQCrcxoAjWyj16tgQAxgMaM0ev1cy35b/f5NkEdN963STyNh920ftrn9Hu7yi+IsHeqFq27wo2bQyoBUf7eelWHcBIEX+HYCsUDuba/ZhfXXEFwZNVUYrcHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=rg65UGkh; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=5o+AiB6F2MAUPShPtLDrGv9fJP8sUM6Y8Mgl6QxOoE4=; b=rg65UGkhq3YJ26dobMGxmuy4yu
	d7w06SMpuJr+8zqfcA84554pAUVaOD1SvC/p6Bfrpdms5hyFTvET9erS5X7x6lHU0S5yCk8ooqV6S
	/CHJoWBLwUOy7exR5x3xQCZAtu5kOCnZIKzDG6AN0Q5wNDWhG53UCykpS4CnYKmuYRdJ1yj331FNW
	P0Kk4GsiC7OIlhHMkglKHJvinKOo61nVpVWtbTQw66AuKoNStImjIEzJkOMRkezSqf9WS9FkAgNHc
	ImGV8IZCZXi02yCreocfK4ly6X+3sXyA8GQG7kC7eCmQmV+oWOwAterwdvTQrN1a2fvgydZPYv5+8
	iC2ZYKig==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wPfIJ-0034Ui-1T;
	Wed, 20 May 2026 11:40:59 +0000
Date: Wed, 20 May 2026 04:40:49 -0700
From: Breno Leitao <leitao@debian.org>
To: Vlad Poenaru <vlad.wing@gmail.com>
Cc: stable@vger.kernel.org, gregkh@linuxfoundation.org, miklos@szeredi.hu, 
	joannelkoong@gmail.com, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 6.18.y v2] fuse: avoid 0x10 fault in fuse_readahead when
 max_pages == 0
Message-ID: <ag2dqkvYw6cKntDs@gmail.com>
References: <20260518182602.3107764-1-vlad.wing@gmail.com>
 <20260519174816.3983940-1-vlad.wing@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260519174816.3983940-1-vlad.wing@gmail.com>
X-Debian-User: leitao
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_RHS_MATCH_TO(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[debian.org,none];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249892-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[debian.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,linuxfoundation.org,szeredi.hu,gmail.com];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 2BFDC58CFFA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 19, 2026 at 10:48:16AM -0700, Vlad Poenaru wrote:
> [ Upstream commit 4ea907108a5c ("fuse: use iomap for readahead") ]
> 
> The upstream fix is the iomap conversion in commit 4ea907108a5c
> ("fuse: use iomap for readahead"), which rewrote fuse_readahead()
> entirely and removed the buggy loop along with it.  That refactor
> is too invasive to backport to the pre-iomap readahead path still
> used by 6.18.y (and earlier stable branches), so this is a minimal,
> equivalent fix to the same bug on those branches.
> 
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
> Fixes: 3eab9d7bc2f4 ("fuse: convert readahead to use folios")
> Reported-by: Breno Leitao <leitao@debian.org>
> Reviewed-by: Joanne Koong <joannelkoong@gmail.com>
> Signed-off-by: Vlad Poenaru <vlad.wing@gmail.com>

Thanks for the fix, Vlad.

Acked-by: Breno Leitao <leitao@debian.org>

