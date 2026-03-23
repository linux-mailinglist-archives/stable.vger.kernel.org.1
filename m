Return-Path: <stable+bounces-227959-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WGdKN7QmwWmbRAQAu9opvQ
	(envelope-from <stable+bounces-227959-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 12:40:36 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 370AE2F157E
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 12:40:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AFC5B302803F
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 11:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE8CA31DDBB;
	Mon, 23 Mar 2026 11:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rFNlnfqd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5490933FE15
	for <stable@vger.kernel.org>; Mon, 23 Mar 2026 11:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774265452; cv=none; b=geEaFrDD9uo/MvqjgrnErhXDylsiBsjBkTBzgkgchGO2zF2lIueY778MIWUFYsrbteKHgLH19WZuZ57+4VYFmL/g5VTiE+SOhalovH8jLBqY/VjH/wHiMgvNNbHs7Bl30B18PdKXCdcsbLxrFnCXyFKpPU+NnLB2j96i4wT3qSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774265452; c=relaxed/simple;
	bh=GVqRiVt4osew0umooFSc4o0FjQ98ZlGWz4FE2h8vSdU=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=e3eN/dSAe8VJuI62B8ihqtudgD4wcldCyjn3DTexK6Vw5fbR+gE/tXAGAMNIdGlcgMS1odZRrUdX9KQgjSkVWNIv4Hc4vsRznfoov4OWBR9pMco2/IQuy8UKddkKxY4d78SAMkimU6ptB9R0Oxc48uHJSpzvKXX1Ete02QIKiCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rFNlnfqd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D8D8C2BC87;
	Mon, 23 Mar 2026 11:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774265451;
	bh=GVqRiVt4osew0umooFSc4o0FjQ98ZlGWz4FE2h8vSdU=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=rFNlnfqdQbCuBiYbm7N3zKwMzDDZeG0hgAbV0i9MkiyRV78p6jjzdJKXjwZVOf/N9
	 PsQqvAMeY8gIc+lmIz2qmR+ZTg1CRe8Rm7Et5xVHgtRgrcerIG2PjbjE2mq9TgKzO+
	 Ln+CL+lyOpbv6sIj2JKKQCyxHAl6TUdK+6I4FC50NAEchECLeWFZzjwkHgWsYV0mfj
	 /HxvTyV5q28bTE67l9jIolmzceKuU9qwEtbMOdYKuHHP1+UIG7ol2psEbulbTjFA2a
	 M7Am5N6GcuwSlPHb7FpOXC6q9qpkLOq/0Kb7qMyxRywIB0x/JbScIh1hwtJ/bOLGRe
	 FDQAxJidbcrmw==
Message-ID: <f1c0344d-ac65-4e16-85dd-70697d8836a1@kernel.org>
Date: Mon, 23 Mar 2026 19:30:48 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
 linux-f2fs-devel@lists.sourceforge.net, stable@vger.kernel.org
Subject: Re: [PATCH v4] f2fs: fix use-after-free of sbi in
 f2fs_compress_write_end_io()
To: George Saad <geoo115@gmail.com>, Greg KH <gregkh@linuxfoundation.org>
References: <2026032354-country-saddlebag-5331@gregkh>
 <20260323112123.786090-1-geoo115@gmail.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20260323112123.786090-1-geoo115@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com,linuxfoundation.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227959-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chao@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 370AE2F157E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/23/26 19:21, George Saad wrote:
> In f2fs_compress_write_end_io(), dec_page_count(sbi, type) can bring
> the F2FS_WB_CP_DATA counter to zero, unblocking
> f2fs_wait_on_all_pages() in f2fs_put_super() on a concurrent unmount
> CPU. The unmount path then proceeds to call
> f2fs_destroy_page_array_cache(sbi), which destroys
> sbi->page_array_slab via kmem_cache_destroy(), and eventually
> kfree(sbi). Meanwhile, the bio completion callback is still executing:
> when it reaches page_array_free(sbi, ...), it dereferences
> sbi->page_array_slab — a destroyed slab cache — to call
> kmem_cache_free(), causing a use-after-free.
> 
> This is the same class of bug as CVE-2026-23234 (which fixed the
> equivalent race in f2fs_write_end_io() in data.c), but in the
> compressed writeback completion path that was not covered by that fix.
> 
> Fix this by moving dec_page_count() to after page_array_free(), so
> that all sbi accesses complete before the counter decrement that can
> unblock unmount. For non-last folios (where atomic_dec_return on
> cic->pending_pages is nonzero), dec_page_count is called immediately
> before returning — page_array_free is not reached on this path, so
> there is no post-decrement sbi access. For the last folio,
> page_array_free runs while the F2FS_WB_CP_DATA counter is still
> nonzero (this folio has not yet decremented it), keeping sbi alive,
> and dec_page_count runs as the final operation.
> 
> Fixes: 4c8ff7095bef ("f2fs: support data compression")
> Cc: stable@vger.kernel.org
> Signed-off-by: George Saad <geoo115@gmail.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

