Return-Path: <stable+bounces-216606-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id NxSYOqyRkWkNkAEAu9opvQ
	(envelope-from <stable+bounces-216606-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 15 Feb 2026 10:28:12 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F7A213E63F
	for <lists+stable@lfdr.de>; Sun, 15 Feb 2026 10:28:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2BCD13003830
	for <lists+stable@lfdr.de>; Sun, 15 Feb 2026 09:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C1321E834E;
	Sun, 15 Feb 2026 09:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="nmrI89n9"
X-Original-To: stable@vger.kernel.org
Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81DBF17ADE0;
	Sun, 15 Feb 2026 09:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771147687; cv=none; b=sFJ4did+RP2AuuHjvdJsqyecRWcw341bnLXusHUeTdtE/DmNFzXlZOVpXT3uJrvlpi68+SnrCTAlMLCBoA5HwaLlAewA9dkhZeZtsPT4QPuLqlmRqEEyhaMQHAbmQSQTXscqA90ZM6LKfjLGOB5t46guRWmMNDo+8Jy3rv+sLhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771147687; c=relaxed/simple;
	bh=C0H44V/77PoBqbHQWID2vzYJZg/RjwktuHel3C+HrYI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g3p0t6CUWesOutSkQXqon8FQyrKofShXxgxrcl7BRL3O8HuD/qhmxdyVkno5Rg/9enk3Pwshs3VvzyckbPmIIXIJaKYrSvn2TJ/zLxSh9nOaUdlbHN3OekGoJgI03FUyC0cixDpprzQF8W1YnA8HFwWMmIQ/ziKJ24Jo7d/AxDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=nmrI89n9; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id E369B14C2D6;
	Sun, 15 Feb 2026 10:28:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1771147684;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tY4YZyEw5GxWBlYlZZdYm+ln93eMRUDbVlzcSMzvuws=;
	b=nmrI89n9xgsq1K6iAvyqggRb7h0vexmNSwL6Bh1pWLCGJcHyU1rfJNHXg8FCNorfUMN9/k
	bMXEW09Oi6Kze22NS6Fl/tHXrXLRTnrtIoZzSawfGAmLAGTZRTnsu0fzpcRcoqhcBj7IP8
	tim7v6Qj+haIbpIZrHPTonmi/etJ5lpSl2YBWHqhU1unqCtbKo2EuO9uB3E/rrkxDrKjkq
	fcpcq9VeCExAoV/XVh9t8iZTYdwWNXs0vqVlf6bno+eN7CTKQCV7kI5wEU+vkpkBpQzEul
	NKEXP38UXmVOABhbvdiLejkh0MLS8+4N0ORwCSEaVaxzjLnasFWjwTK2PO0l5Q==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 24e3fc66;
	Sun, 15 Feb 2026 09:28:00 +0000 (UTC)
Date: Sun, 15 Feb 2026 18:27:45 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Breno Leitao <leitao@debian.org>
Cc: Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Eryu Guan <eguan@linux.alibaba.com>,
	Yiwen Jiang <jiangyiwen@huawei.com>, v9fs@lists.linux.dev,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] 9p: fix WARN_ON when dropping nlink on files with nlink=0
Message-ID: <aZGRkaFZPXfZW8a0@codewreck.org>
References: <20260126-9p-v1-1-dc234d53ae87@debian.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260126-9p-v1-1-dc234d53ae87@debian.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[codewreck.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[codewreck.org:s=2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[codewreck.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-216606-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[asmadeus@codewreck.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[codewreck.org:mid,codewreck.org:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6F7A213E63F
X-Rspamd-Action: no action

Breno Leitao wrote on Mon, Jan 26, 2026 at 02:23:37AM -0800:
> v9fs_dec_count() guards against decrementing nlink on directories that
> have nlink <= 2, but does not guard against decrementing nlink on
> regular files that already have nlink == 0.
> 
> In the 9p filesystem, the client caches inode metadata including nlink,
> but the server is the source of truth. During an unlink operation, the
> following race can occur:
>
>   1. Client initiates unlink, server processes it and sets nlink to 0
>   2. Client fetches updated inode metadata (nlink=0) before unlink returns
>   3. Client's v9fs_remove() completes successfully
>   4. Client calls v9fs_dec_count() which calls drop_nlink() on nlink=0

Thanks for the patch and sorry for the delay


hmm.. I'm not actually sure if we should call drop_nlink() at all in
cacheless mode, actually..
We don't really care about nlink in this context, as inode should be
gone immediately anyway, or does nlink hitting zero imply something
else?

So we could get the v9fs_session_info out of the inode
(v9fs_inode2v9ses) and just return if CACHE_META is set?

Others opinion would be great, but I get the feeling that just checking
before update only makes the race smaller, and not totally fixed.


> This race is easily triggered under heavy unlink workloads, such as
> stress-ng's unlink stressor, producing the following warning:
> 
>   WARNING: fs/inode.c:417 at drop_nlink+0x4c/0xc8
>   Call trace:
>    drop_nlink+0x4c/0xc8
>    v9fs_remove+0x1e0/0x250 [9p]
>    v9fs_vfs_unlink+0x20/0x38 [9p]
>    vfs_unlink+0x13c/0x258
>    ...
> 
> Fix this by returning early from v9fs_dec_count() if the inode's nlink
> is already zero, extending the protection that commit ac89b2ef9b55
> ("9p: don't maintain dir i_nlink if the exported fs doesn't either")
> added for directories to also cover regular files.
> 
> Fixes: ac89b2ef9b55 ("9p: don't maintain dir i_nlink if the exported fs doesn't either")
> Cc: stable@vger.kernel.org
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  fs/9p/vfs_inode.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
> index 97abe65bf7c1f..b75f656af4c98 100644
> --- a/fs/9p/vfs_inode.c
> +++ b/fs/9p/vfs_inode.c
> @@ -488,10 +488,16 @@ static int v9fs_at_to_dotl_flags(int flags)
>   * - ext4 (with dir_nlink feature enabled) sets nlink to 1 if a dir has more
>   *   than EXT4_LINK_MAX (65000) links.
>   *
> + * For regular files, the server may have already decremented nlink to 0
> + * before the client's unlink completes, so we must also guard against
> + * decrementing an already-zero nlink.
> + *
>   * @inode: inode whose nlink is being dropped
>   */
>  static void v9fs_dec_count(struct inode *inode)
>  {
> +	if (!inode->i_nlink)
> +		return;
>  	if (!S_ISDIR(inode->i_mode) || inode->i_nlink > 2)
>  		drop_nlink(inode);
>  }
> 
> ---
> base-commit: ca3a02fda4da8e2c1cb6baee5d72352e9e2cfaea
> change-id: 20260126-9p-50d206e2f6f6
> 
> Best regards,

-- 
Dominique Martinet | Asmadeus

