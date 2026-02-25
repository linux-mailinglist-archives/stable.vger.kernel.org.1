Return-Path: <stable+bounces-219196-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kDywCoiTnmmXWQQAu9opvQ
	(envelope-from <stable+bounces-219196-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 07:15:36 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 89A8D1924AC
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 07:15:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1AA80303A933
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 06:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F4E22BEC2E;
	Wed, 25 Feb 2026 06:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="AIPi5Ie7"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439332C15AC
	for <stable@vger.kernel.org>; Wed, 25 Feb 2026 06:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772000131; cv=pass; b=pLDg6fB51+Diph0ss/8vHB8mE2Vou28maz9g1h8J8fmGLs7WbxPUEljIZYeAZpmrT91Kx6P+3yTem7t2PG9dvFN/SUPUVl+0+LyA3XJjGfg7YQCia1NwhD7XtjzEMllmjFoGTiywTgEXDFndZFvb3W6U8Z8c/f4xdrrWU2Y73V4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772000131; c=relaxed/simple;
	bh=6duiW9c2DU7z/mC6LK2GVzrYkzQjoQbV/lc0c0lQsek=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GKV5rfAIaN+xNxJ7dogbxC0TG5/5IKY5wtaMXAGFOQhbRmA4O0EynJnEZuXDU16Jk2ltYgtE8Bl/nnYvFVdl3rYe91470dBZYGjsdJCTjEZTKzvoiFPZaMs3LKjyRykXjAVAI9JJ43YZ+zzQFfCA9xYWWsryEWb/aQibHXkHn54=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=AIPi5Ie7; arc=pass smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-43987b97701so900292f8f.3
        for <stable@vger.kernel.org>; Tue, 24 Feb 2026 22:15:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772000128; cv=none;
        d=google.com; s=arc-20240605;
        b=SyTvrXE34cpsP+5q9SW8QNIG1mYALHZcsRzP4G6DRfVb0lhigKzoJfVKBCpOP6rzfX
         FEtkaIoNUm+tbA3umjtCKvGb1nk+sDjWMfGj6d2375HlpiI4jnpkHeL7FtmMSueiKzW3
         GQ7iVpJuPa8gQyWy96IVlpqF92EtpVnt6c34Y9vo5zjrCH89ddvUhnj4nOmQHhL/anBZ
         PmDfs+cGQOcpNt2tWS6DD7KxiO/AlagayD1o64WvfRADoWxNw4o8YG8syC4taAy4OHRL
         GYelB9uzLorpEEJjgbMZ7O3t9VRLPRY3pO8bzZ+LSaYOdXTJ1eU4em6FGUrASDDxaamk
         CXCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=fRp4t0j/86MYJauHT8JmZMZ8uXCSwHALvLOqAznr3r0=;
        fh=efS159zGPq++EsGm2Ghh2sPZHJzYq1vPAhQIQVhKbZo=;
        b=O41/3RhHgQChCJTgORhbEhD2c+TvhFtdGWJdmYo1O/UcHNAXxoJCI0YYbs0X3JK16f
         tvkhqxFQ2ChT/4bT0//p4Qf4SlEO8zDWkGOltPbs5c8dUMw+R2XBNB/zqnwIeMW+LqtK
         0qMApSehzb8m4rA9ABYsncSpoGhHsywABr5WcSUCyk45nKfuUbD7ywNryca4y+wHro2/
         J3sq1Kp3CVIypfMKMZTub+bwuIeNdqlJTDkmGzDH9D918LJZWo4yf1OGQ+Je8KQ+69kR
         BRJgsbe/PYNHUdX9OCBjQXXtpaJDzzjemjQSWzpwZ9im44xoZQT6Hp6ikOCig1ubGjkX
         ENFw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1772000128; x=1772604928; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fRp4t0j/86MYJauHT8JmZMZ8uXCSwHALvLOqAznr3r0=;
        b=AIPi5Ie7bJ3y+cWllCie/Qm4Koz8A4YxtokHvdhaaTGn8BLLU9LTfV68w7uKj/9doi
         W9t/BaYUjcXGpFjrc1684VrOC6h9axX/xloJgosQt+pREGCpNXHDalTxNFJHJGCKvdk4
         NxVuIig3TmQORKqD3YObHJ9J3QTggOF2ejoy1u9DlEEunpYY3LTtEvcLQn5PectAE7Mo
         CN+3i98IiXeFbufc6XD7s12sg6yQJQTB3bBBB4GzN23SLS0hqOYNRtUhKuUbI5+m9h+u
         eakzb+3ovSf/hbytwHIDNg/D7W+flM4hugmNeyVv8B7XvCfjr9oQ3EVBVJ2ge8W5U4VE
         WVyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772000128; x=1772604928;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fRp4t0j/86MYJauHT8JmZMZ8uXCSwHALvLOqAznr3r0=;
        b=Du5gwFewNAn9kyNMK7uDjOPHqA3b5oqMuCEScHigtRfMyu2PsXiZvH0CkzGd9zH0eq
         D+CPXUB9XaNWPxkuf+4O9h6wqHdjJkp1o7sTLJDcxrnRbdWgVkgvnLCjPphycLmMJRAA
         hv4iO5Zc78qJafJQvygtCEBjQILW7YgxAj+qGL8d5dP/SuqkYzCBXhEAyKV0jN1oFokI
         QgSN4kcsX5P1dxFwzgkO6TcoGH90hyo5/5639rtONJz1Rg3IX12wUIiJrPRz8fdmfs6u
         hNcJPUk09cVvRs8UbkpVo/RI08lMySaxYGurDIIUnDyYQUhA2Yo99LfMTVLAXR9Z/1gj
         p8qw==
X-Gm-Message-State: AOJu0YyvBy3DHBcYyq7GB3UFdA2ZQxsHlyhGWOApR80O64CV70Be+wh4
	x80pIuc566zfBRHfKxtDzXN4qmL4IDppJlrqCHVsRh+3iESSq6H9bHRjbG/1UTggG2Lm1AqpPw2
	MQBzXM1KMxNUs+2GMR3Q1SrZDFaEvtrk31+pyG2IP3g==
X-Gm-Gg: ATEYQzwLoU4oK0C1KEH+Ve3qduOgn4hZfhfmOpNzkDBmQhXaIaf32ZSQWPoUDwRJWXk
	e9UFVn88puvZGGm75tKu+bldNETgC03my+M+Q18qQKGcNBxjJuwr1oJRZZIy0meCOHpUOODAHZi
	XN1nZZi0H/BKOyTA0NugMowQ9qhAPMrZjoxpbvHuRHRoHNJP6fFrjZtHTa1D4xDVVLggwOp1JJW
	PSXVHMcdpwREPdTEecjliDbowpGJ4C8wdNb7xuJ9Lb7oP1By6PpLG/tJzQ6Jg6ZhqaUzxVeQ/t1
	f/kk0fLaL55ihT8Jv3747Qe6rDp//kSjbcZwVirVk2lIK1d8szG6qZa+hPEwlsOTD3f0ZYxVVG4
	0eIOy
X-Received: by 2002:a5d:5f82:0:b0:436:233c:c7c2 with SMTP id
 ffacd0b85a97d-4398fa8f511mr1672763f8f.16.1772000127528; Tue, 24 Feb 2026
 22:15:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260225012348.915798704@linuxfoundation.org> <20260225012349.617596661@linuxfoundation.org>
In-Reply-To: <20260225012349.617596661@linuxfoundation.org>
From: Daniel Vacek <neelx@suse.com>
Date: Wed, 25 Feb 2026 07:15:16 +0100
X-Gm-Features: AaiRm50BRHVY9dnqLA8QxSQ_aFijAWbIo40KFzJUtey0yViutItZBb79eS6PYcU
Message-ID: <CAPjX3Fe8XOkja2L8dv30s4pnzSQDsAExXY5Nh8MFQoPreQUeAQ@mail.gmail.com>
Subject: Re: [PATCH 6.18 026/641] btrfs: add orig_logical to btrfs_bio for encryption
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-219196-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[neelx@suse.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 89A8D1924AC
X-Rspamd-Action: no action

On Wed, 25 Feb 2026 at 02:42, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> 6.18-stable review patch.  If anyone has any objections, please let me know.

Hi Greg,

This one is a preparation for new feature development, it's not really
worth the stable branch. Backporting it makes no sense.

Have a nice day,
Daniel

> ------------------
>
> From: Josef Bacik <josef@toxicpanda.com>
>
> [ Upstream commit bd45e9e3f6232f76fa9bd0e40c1e3409e4449f5e ]
>
> When checksumming the encrypted bio on writes we need to know which
> logical address this checksum is for.  At the point where we get the
> encrypted bio the bi_sector is the physical location on the target disk,
> so we need to save the original logical offset in the btrfs_bio.  Then
> we can use this when checksumming the bio instead of the
> bio->iter.bi_sector.
>
> Note: The patch was taken from v5 of fscrypt patchset
> (https://lore.kernel.org/linux-btrfs/cover.1706116485.git.josef@toxicpanda.com/)
> which was handled over time by various people: Omar Sandoval, Sweet Tea
> Dorminy, Josef Bacik.
>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Daniel Vacek <neelx@suse.com>
> Reviewed-by: David Sterba <dsterba@suse.com>
> [ add note ]
> Signed-off-by: David Sterba <dsterba@suse.com>
> Stable-dep-of: b39b26e017c7 ("btrfs: zoned: don't zone append to conventional zone")
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  fs/btrfs/bio.c       | 10 ++++++++++
>  fs/btrfs/bio.h       |  2 ++
>  fs/btrfs/file-item.c |  2 +-
>  3 files changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
> index 1286c1ac19404..c3d860a2bca42 100644
> --- a/fs/btrfs/bio.c
> +++ b/fs/btrfs/bio.c
> @@ -94,6 +94,8 @@ static struct btrfs_bio *btrfs_split_bio(struct btrfs_fs_info *fs_info,
>         if (bbio_has_ordered_extent(bbio)) {
>                 refcount_inc(&orig_bbio->ordered->refs);
>                 bbio->ordered = orig_bbio->ordered;
> +               bbio->orig_logical = orig_bbio->orig_logical;
> +               orig_bbio->orig_logical += map_length;
>         }
>         bbio->csum_search_commit_root = orig_bbio->csum_search_commit_root;
>         atomic_inc(&orig_bbio->pending_ios);
> @@ -726,6 +728,14 @@ static bool btrfs_submit_chunk(struct btrfs_bio *bbio, int mirror_num)
>                 goto end_bbio;
>         }
>
> +       /*
> +        * For fscrypt writes we will get the encrypted bio after we've remapped
> +        * our bio to the physical disk location, so we need to save the
> +        * original bytenr so we know what we're checksumming.
> +        */
> +       if (bio_op(bio) == REQ_OP_WRITE && is_data_bbio(bbio))
> +               bbio->orig_logical = logical;
> +
>         map_length = min(map_length, length);
>         if (use_append)
>                 map_length = btrfs_append_map_length(bbio, map_length);
> diff --git a/fs/btrfs/bio.h b/fs/btrfs/bio.h
> index 9a44b86d561b1..488cdbdd9e2f8 100644
> --- a/fs/btrfs/bio.h
> +++ b/fs/btrfs/bio.h
> @@ -59,6 +59,7 @@ struct btrfs_bio {
>                  * - pointer to the checksums for this bio
>                  * - original physical address from the allocator
>                  *   (for zone append only)
> +                * - original logical address, used for checksumming fscrypt bios
>                  */
>                 struct {
>                         struct btrfs_ordered_extent *ordered;
> @@ -67,6 +68,7 @@ struct btrfs_bio {
>                         struct completion csum_done;
>                         struct bvec_iter csum_saved_iter;
>                         u64 orig_physical;
> +                       u64 orig_logical;
>                 };
>
>                 /* For metadata reads: parentness verification. */
> diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
> index 4b7c40f05e8f9..48f444bde5fa9 100644
> --- a/fs/btrfs/file-item.c
> +++ b/fs/btrfs/file-item.c
> @@ -815,7 +815,7 @@ int btrfs_csum_one_bio(struct btrfs_bio *bbio, bool async)
>         if (!sums)
>                 return -ENOMEM;
>
> -       sums->logical = bio->bi_iter.bi_sector << SECTOR_SHIFT;
> +       sums->logical = bbio->orig_logical;
>         sums->len = bio->bi_iter.bi_size;
>         INIT_LIST_HEAD(&sums->list);
>         bbio->sums = sums;
> --
> 2.51.0
>
>
>

