Return-Path: <stable+bounces-242097-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SFh2L0tE82lDzAEAu9opvQ
	(envelope-from <stable+bounces-242097-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 14:00:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D5804A27C8
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 14:00:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 499D4300492A
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 12:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 087F23DA7EC;
	Thu, 30 Apr 2026 12:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="KA4JtDQJ"
X-Original-To: stable@vger.kernel.org
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 513293D7D97;
	Thu, 30 Apr 2026 12:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.157.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777550407; cv=none; b=jdS4U2MajvndU70PZZaWSPxOp9mpiXRVSnmUi2l8DcIMRbrL4vbWYtgnEr4KjfQNxdvD7aIfA2LIAIPIyNcKiTcC8/7JUgaTmz7cXfs+yqLkzCNn30/fCfA9Pq2CWnczPH/uW0TNPosmhS1D+FCYSXHMEqrfVSUgDp8XZ2ROg6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777550407; c=relaxed/simple;
	bh=PI2cjhb/3KcacCExd/6vKxC2gzBLk2mcGC3hEvREhkQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=LhoufvUmH43Eff/YGd/3ymf4nN7UujSCDYITQMyQJAYLWsIftcHCqHMyR74263bQAj7gmRFAMXooNJvGVaunMzfNOloenV6A1rGVkujFsujgApTIaLHXox2cDjOvlGSDRRocDJGIko2dfYrQW9/FALI1yoeGD4yWmV3wyef2cnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com; spf=pass smtp.mailfrom=paragon-software.com; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=KA4JtDQJ; arc=none smtp.client-ip=35.157.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paragon-software.com
Received: from relayfre-01.paragon-software.com (relayfre-01.paragon-software.com [176.12.100.13])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 5BFD91D27;
	Thu, 30 Apr 2026 12:00:12 +0000 (UTC)
Authentication-Results: relayaws-01.paragon-software.com;
	dkim=pass (1024-bit key; unprotected) header.d=paragon-software.com header.i=@paragon-software.com header.b=KA4JtDQJ;
	dkim-atps=neutral
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayfre-01.paragon-software.com (Postfix) with ESMTPS id 85536212D;
	Thu, 30 Apr 2026 12:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1777550404;
	bh=arH+TZXlxf4RQZVJ+YOBW34NcQMV9EYbc8/BX+MPDp8=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=KA4JtDQJMYRYR0hAtYc8hI3dmZyXX3q+Qy9ZEhukqoW+T5uwmp0Vibju3kk6DYj8k
	 fWgMv8zwNL+10fuTJRg99dAd6/nlcQeNITbpoT7+s4g2b1LznKeImnNfY/5JM2isAn
	 5HGjrWz7HvWyOg13gU7yWutLn85V3ATZ5MNu0tOE=
Received: from [192.168.95.128] (172.30.20.214) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Thu, 30 Apr 2026 15:00:03 +0300
Message-ID: <4435a979-e5cc-4b1d-9a6f-764bc48c2106@paragon-software.com>
Date: Thu, 30 Apr 2026 14:00:01 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ntfs3: bound to_move in indx_insert_into_root before
 hdr_insert_head
To: Michael Bommarito <michael.bommarito@gmail.com>
CC: <ntfs3@lists.linux.dev>, <linux-fsdevel@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
References: <20260417233305.1787096-1-michael.bommarito@gmail.com>
Content-Language: en-US
From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
In-Reply-To: <20260417233305.1787096-1-michael.bommarito@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: vobn-exch-01.paragon-software.com (172.30.72.13) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)
X-Rspamd-Queue-Id: 5D5804A27C8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[paragon-software.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[paragon-software.com:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-242097-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[paragon-software.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[almaz.alexandrovich@paragon-software.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[paragon-software.com:dkim,paragon-software.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

On 4/18/26 01:33, Michael Bommarito wrote:

> indx_insert_into_root() promotes a full resident $INDEX_ROOT into
> $INDEX_ALLOCATION and copies all non-last resident root entries into
> a newly allocated INDEX_BUFFER via hdr_insert_head(). The source
> byte count 'to_move' is summed from the on-disk resident entry sizes
> and is independent of the destination buffer size, which comes from
> root->index_block_size (via indx->index_bits).
>
> A crafted NTFS image that keeps a valid, full resident root but
> shrinks root->index_block_size down to 512 after the root has been
> populated makes hdr_insert_head() memcpy attacker-controlled resident
> entry bytes past the end of the kmalloc(1u << indx->index_bits)
> allocation returned by indx_new(). For a 512-byte destination and a
> resident root whose non-last entries total 560 bytes, the memcpy
> overruns by 120 bytes and a following memmove extends the highest
> written offset to 136 bytes past the allocation. The overflow bytes
> are a direct copy of on-disk entries (via kmemdup), so they are
> fully attacker-controlled.
>
> The write is reachable from unprivileged open(O_CREAT) on a mounted
> crafted NTFS image: a single sufficiently long create in a directory
> whose resident root is already full forces root promotion and
> triggers the copy.
>
> This is a controlled out-of-bounds write of 120-136 bytes past a
> kmalloc(index_block_size) allocation, with attacker-controlled
> content. It is a bounded adjacent-heap corruption primitive; it is
> not an arbitrary-address write. Successful exploitation into a named
> victim object depends on the surrounding slab layout.
>
> Reject the copy at the sink. The destination's INDEX_HDR already
> reports hdr_total (the payload capacity of the new buffer) and
> hdr_used (the bytes already consumed by the terminal END entry
> installed by indx_new()); require that to_move fits in the remaining
> payload before calling hdr_insert_head(). On mismatch, fail with
> -EINVAL and mark the filesystem as having a detected on-disk
> inconsistency, which is the same behaviour as the surrounding
> validation in this function.
>
> Fixes: 82cae269cfa9 ("fs/ntfs3: Add initialization of super block")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-4-7
> Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
> ---
>
>   - FYI, like the sp_size patch, I have a larger refactor that might
>     make this easier to avoid long term.  It's a mount-time variant
>     that adds the cross-check between root->index_block_size and
>     the resident root attribute size to indx_init() instead of the
>     sink, closing the whole "root entries do not fit declared
>     index_block_size" class for any future caller that reaches
>     hdr_insert_head from elsewhere.  Happy to send it as v2 if
>     you prefer the wider change;  otherwise, this minimal guard is
>     scoped to the minimal memcpy overrun site and is easier to
>     backport.
>
>   fs/ntfs3/index.c | 16 ++++++++++++++++
>   1 file changed, 16 insertions(+)
>
> diff --git a/fs/ntfs3/index.c b/fs/ntfs3/index.c
> index 2c43e7c27861..b7633b721d19 100644
> --- a/fs/ntfs3/index.c
> +++ b/fs/ntfs3/index.c
> @@ -1740,6 +1740,22 @@ static int indx_insert_into_root(struct ntfs_index *indx, struct ntfs_inode *ni,
>   	hdr_used = le32_to_cpu(hdr->used);
>   	hdr_total = le32_to_cpu(hdr->total);
>   
> +	/*
> +	 * The destination INDEX_BUFFER has 'hdr_total' bytes of payload
> +	 * available after the header, of which 'hdr_used' are already
> +	 * consumed by the single terminal END entry installed by
> +	 * indx_new(). A crafted image can present a resident root whose
> +	 * non-last entries (summing to 'to_move') exceed what fits in
> +	 * this buffer; copying them unchecked would overrun the
> +	 * kmalloc(1u << indx->index_bits) allocation backing the new
> +	 * buffer. Reject the copy in that case.
> +	 */
> +	if (to_move > hdr_total - hdr_used) {
> +		err = -EINVAL;
> +		ntfs_set_state(sbi, NTFS_DIRTY_ERROR);
> +		goto out_put_n;
> +	}
> +
>   	/* Copy root entries into new buffer. */
>   	hdr_insert_head(hdr, re, to_move);
>   

Hello,

Sorry for the delay.
Your patch is queued for the next merge window, thanks.

Regards,
Konstantin


