Return-Path: <stable+bounces-249361-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MAp/FPxbC2ppGAUAu9opvQ
	(envelope-from <stable+bounces-249361-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 20:35:40 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id F0FC057258F
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 20:35:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4118D3023E5C
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 18:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5684438F623;
	Mon, 18 May 2026 18:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jdR80rO4"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 759DF38D400
	for <stable@vger.kernel.org>; Mon, 18 May 2026 18:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779129310; cv=pass; b=O83e0euhiRYC6jcpVo58X0Bd4HGJOSE3Wb1dqydw6xzjR0FfS9tn1O8qdYj1wtAWE7YdLbUb+MDLr/sTXipR/LemaWP2DPtyurnuIAswqXbi8XVwheF13k0j1cehSr5t8cPMROzhAPi4/cz4Sw1vh/Ssjw7Cd2nm3TUnTFOJ7DQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779129310; c=relaxed/simple;
	bh=zfBc4eLvgZETNVCwaMjtmiLlWfDM9HXuPjNpKwFyRoI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P69IotDXSJRTVjPIIyQnDX53we2WPhSKN4dMNoT/b2Yk1ksGuGo3kTxmJdSBaYd930wsLDMH/qTJaPz7zSL38Xyn9wpdY5YjaKm2qFem4BgTA9K7ZcAwhf+cY+IUSPLschzJ/U6EyfvkJ+TGRIqVBknhQS5cYCyY1bNiwGi9bmI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jdR80rO4; arc=pass smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-488b0e1b870so39613485e9.2
        for <stable@vger.kernel.org>; Mon, 18 May 2026 11:35:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779129307; cv=none;
        d=google.com; s=arc-20240605;
        b=Dbl3EBuC2fjT7j5R2ycXmrC2CJULj2MqHSybZBPeTgGGiOnOnyc7/S0KYyH2hb1tZM
         +VRClbSxNMCHFTulBcY1xSnpNE8kiir8fLvXmLUP1JKkfueifhqzXuwRwYmyXAKP7473
         odL3HmZcUEzmqInNKtFGcS9RYDxDovTy+JmRF4WhYxYMyBQ78t1JlbSfRcaPeomdY6e9
         Gd9p1ca6//buFB+VKxgIEgYphztkjRfGtzOy7ZdHNOC7TmplyZg4jUFVnPU7MxIKc5Ke
         D2oItesV2DdrrGSV7AoJiNYvVb7ArbYAeguqiQ46V/mQNGq40tmOi9tc+ehmfm/GqSKw
         W++Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=E8btY24TAcxNFeMHHWwcrKm/g35Z5vhN3GDcpOLQS4U=;
        fh=5AoCqzTLbHZu2rp2Zs+TW1SaMgJVcvb+vkw9gfSFNXk=;
        b=Zvi9l64nHQtw/KwutFYfkLpwERZgvSd4JZM9OMSAJ/wpzfdBW/Yid9uZv0NXq/vuBx
         wiC3fLBlxAYxGo/ZyBWorbT48Wb+YIanxDtjPZDZMeVY5hW6h/ZVye78A7Bbm/Tk1pj4
         oelDhaxr15OKsPhq+mdyFbROxB90GI3n0jltp2AR2HMuSdgEz+KMUDS6gX72wejQ9A36
         BqtR/SuuN/as+BArt7M2qm0QxSuXIVA3Xys2DKH/XWpG4IH8txPYxsQPDId9ys8Ht8a6
         m5soz6ov8T4aMP/9KMm+4KqwBnWkNH9CUQLd2QPIOeaskkbTSzZjAnsh17Cod4VuGfDR
         MFBQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779129307; x=1779734107; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E8btY24TAcxNFeMHHWwcrKm/g35Z5vhN3GDcpOLQS4U=;
        b=jdR80rO4BjRcbOCWaEbrRxJWS261dlaD1bKeW5/1lZW0eI922o2+oPuOXPN5U2BK3L
         h3R5QiYda2+fVBekWbVg0JC/rUUzBq0RstW5gx/KrYLkm8Ofpj2LIgYAiKxik3I2VVKd
         4+VVVfmXCkvUvznsm5r2w/Dx99/wFOWEu5EQgRgm5DRaPRLggJrPE5oW09utVgIk9GB0
         0h5zXUnxhY2lM/KL0F18GdbfnlbX/rfgK3LeuJ7B/tprKMvfeoOWq/o8Yva12Scv3iYV
         /VYCffMbten2P6oFgxSeaeDB+FxUpXaKq/anHP+ZOP+kZHxgZGQiaYC/7RBI3K3PBs7x
         0J9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779129307; x=1779734107;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=E8btY24TAcxNFeMHHWwcrKm/g35Z5vhN3GDcpOLQS4U=;
        b=I4jk0Uq218OJHEhOSBokWlBVx91hbU82OlvrSd4Bd8Evm703yWX9yuiSf00HVpahRA
         /Q489Kbksyu70hMPvP9OLhsWHjg2mEXNv98xZn08z7UK3antXEJ8YbnzhBxbGBstt2TT
         jRSnG675LOFDrFSkg7E1+Cw/mb7VnM31r80QiXmrbfhz5t+0QDBfDPhyzjEUFM29b1UL
         xTQ/9ryTF8Eyo/907paoM2cK2yKM77Z0xokiiothgZ6O1eQRheG8BRwDwex8py+Mj9Ah
         IHw4yf8nJ9ndyiL6w4nLtLjYExhXDx/M7sD3jDq3sCo4JQ+kyp2N/CiFBjLe5KejFHFz
         HQKw==
X-Forwarded-Encrypted: i=1; AFNElJ9dcMhUITpw8ANrr0dvHD5v+XS/xDKtvZXMSC5Cl6GLf7Nc5S5a0v0SYGQCBqT5RFgQTtWs8zM=@vger.kernel.org
X-Gm-Message-State: AOJu0YznPxPCRd2ObeJjlS7iC3+4jx1YIFZ6UlxR8s7NNXHfARB4E3kZ
	G5EIgJEVStL+/RLH3Q3G+o/F8twDevzJpJxmwS4X1CgyS9yudC1n6TIWsnU+/oQsrtbFx5JUsbz
	IjlCObJyLCXIRJd3u82ytMyqYKNIK2so=
X-Gm-Gg: Acq92OHnSKs5BS74BQe/kFVw/ScLYshnMoRowVi1ry3ibFEvuBEGrel3Pu2JHXT2s6Q
	TDWO874Z8Za+zZwi7+iEo278/dnkdHyqO1rDMk/3H+62Y2F7IvrBIfXO9ihglg3lkz1oFmF2YU2
	NE5Af93F8M6yms9UydB67M9/4Dl9AMbM1Dl+/cumapoxMd6qh5XDav5XBqRjrefIeyR9Zsq8lit
	SEnYXElvRDhDB0seBqq4L0NoS87FxhzoihQeW09GNbiYpaKMOZ1D9rEk4l+4Tw61IX4fHhXAgoL
	l1Kxpg==
X-Received: by 2002:a05:600c:3e1b:b0:48d:46a:6e5b with SMTP id
 5b1f17b1804b1-48fe60de6b2mr247664865e9.7.1779129306765; Mon, 18 May 2026
 11:35:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260518182602.3107764-1-vlad.wing@gmail.com>
In-Reply-To: <20260518182602.3107764-1-vlad.wing@gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 18 May 2026 11:34:55 -0700
X-Gm-Features: AVHnY4J3xr2Gvp52xK2OIEcQt9FQCDBFKVIWkl5crcafzqFIXkmK8ZECoQZjAbQ
Message-ID: <CAJnrk1b9ZDH11+0Eq9ZqkoeiU3t_qxs1SUGTmPUB==gmyENZ-Q@mail.gmail.com>
Subject: Re: [PATCH 6.18.y] fuse: avoid 0x10 fault in fuse_readahead when
 max_pages == 0
To: Vlad Poenaru <vlad.wing@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Breno Leitao <leitao@debian.org>, 
	Josef Bacik <josef@toxicpanda.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	fuse-devel <fuse-devel@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249361-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joannelkoong@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Queue-Id: F0FC057258F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

[adding fuse-devel list to cc]

On Mon, May 18, 2026 at 11:26=E2=80=AFAM Vlad Poenaru <vlad.wing@gmail.com>=
 wrote:
>
> When fc->max_read is smaller than PAGE_SIZE (common on aarch64 with
> 64K base pages if the FUSE server advertises a small max_read in INIT),
> max_pages =3D min(fc->max_pages, fc->max_read / PAGE_SIZE) is 0, so
> cur_pages is 0 on every outer iteration.
>
> fuse_io_alloc(NULL, 0) then calls fuse_folios_alloc(0, ...), which
> calls kzalloc(0, ...) and gets back ZERO_SIZE_PTR =3D=3D (void *)16.
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
> "nr_pages -=3D pages" makes no progress when pages stays 0; in practice
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

Reviewed-by: Joanne Koong <joannelkoong@gmail.com>

> ---
>  fs/fuse/file.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index 6014d588845c..782178124512 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -974,6 +974,16 @@ static void fuse_readahead(struct readahead_control =
*rac)
>                 unsigned cur_pages =3D min(max_pages, nr_pages);
>                 unsigned int pages =3D 0;
>
> +               /*
> +                * If max_pages =3D=3D 0 (e.g. fc->max_read < PAGE_SIZE o=
n a
> +                * 64K-page kernel), cur_pages is 0 and we cannot make
> +                * progress.  Bailing here avoids passing 0 to fuse_io_al=
loc,
> +                * which would return an ia whose ap.folios is ZERO_SIZE_=
PTR
> +                * (0x10) -- later dereferenced by fuse_send_readpages.
> +                */
> +               if (!cur_pages)
> +                       break;
> +
>                 if (fc->num_background >=3D fc->congestion_threshold &&
>                     rac->ra->async_size >=3D readahead_count(rac))
>                         /*
> --
> 2.53.0-Meta
>

