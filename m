Return-Path: <stable+bounces-271704-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id SoAEJKmDR2qjZwAAu9opvQ
	(envelope-from <stable+bounces-271704-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 03 Jul 2026 11:40:57 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 814E7700BB9
	for <lists+stable@lfdr.de>; Fri, 03 Jul 2026 11:40:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=mssola.com header.s=MBO0001 header.b=OWSowzB0;
	dmarc=pass (policy=none) header.from=mssola.com;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-271704-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-271704-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 185E5300380C
	for <lists+stable@lfdr.de>; Fri,  3 Jul 2026 09:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A6BE37E2EB;
	Fri,  3 Jul 2026 09:31:42 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD4F380FE7;
	Fri,  3 Jul 2026 09:31:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783071102; cv=none; b=JjAF3ctgF/vBXoBAd10YT4EBmVu/7dqbKXzDEG8h0d9IMLfR9CDdsQVq9XwPjfiOxU3EcIyTxo71BZEMFR3xUaVdSYWcE99DQ+/SJQf6SyjcaNSwjs2QCk7PW06VifD0HDONOsMT5glCAN+uRodRRc3zXMCADyX3UA9NW4EE5iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783071102; c=relaxed/simple;
	bh=YHHKWsmEnYu6f+EzP+fFma932GKNTO838Py+7GUDkbA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=P2xdozpPG/o9B6amu9EUSKY334jvLBHc/HJXoydxGSwNpqNgg++68Agw4SGwCjJw+T821Z8eOg/F8XSpN7AxNcFPC8DGmVMhQdLbNb7OzjDy9PU3y6Nnc7PbhZCwptCnvrrLMpid3Kw/oS9Q1SsCJoNwyzl2/7XefKli16eFvUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mssola.com; spf=fail smtp.mailfrom=mssola.com; dkim=pass (2048-bit key) header.d=mssola.com header.i=@mssola.com header.b=OWSowzB0; arc=none smtp.client-ip=80.241.56.152
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4gs7mb213Kz9tnp;
	Fri,  3 Jul 2026 11:31:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mssola.com; s=MBO0001;
	t=1783071087;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=a5p45KqoXJdvijyqQAIgyUwPQfVbYZsMXYSOsqZuXZY=;
	b=OWSowzB0kPILGBkXJVN1CkelFTfC2sRZzGZn+FvS5ljcqYTLeY/OX+/VicBf+Zf44H9ei1
	A1ENNm+Tqp+dBkk4pTkUC6opNNulYFEKb6HHtIbFni0nzxK/gPqNEbTNdFpSoG1EYMoGfc
	aDnZpqm6FlikZMUh39aYiaxgZTNsWC6QGkR2jJfEdRfGP0UGi/l71pxED1gCFniXIALd8m
	KnokWfAVTD/k5b+4s0uKc0Fbc8TTsnEtsBcBUYwHwtQQWVPfEYjG3yQhFrGdxpoc3JION8
	AoEEhcQ/Bd0OY7QGdfZ9fWavqMmn2BBDC2T/57s2NIN5AaOMvgAr1uaNofAboQ==
From: =?utf-8?Q?Miquel_Sabat=C3=A9_Sol=C3=A0?= <mssola@mssola.com>
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc: linux-btrfs@vger.kernel.org,  stable@vger.kernel.org
Subject: Re: [PATCH] btrfs: zoned: reset active_meta_bg on zone finish
In-Reply-To: <20260703084559.136605-1-johannes.thumshirn@wdc.com> (Johannes
	Thumshirn's message of "Fri, 3 Jul 2026 10:45:59 +0200")
References: <20260703084559.136605-1-johannes.thumshirn@wdc.com>
Date: Fri, 03 Jul 2026 11:31:24 +0200
Message-ID: <87y0fs772r.fsf@>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.79 / 15.00];
	SIGNED_PGP(-2.00)[];
	INVALID_MSGID(1.70)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MIXED_CHARSET(0.77)[subject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[mssola.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[mssola.com:s=MBO0001];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271704-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[mssola@mssola.com,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:johannes.thumshirn@wdc.com,m:linux-btrfs@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mssola@mssola.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[mssola.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mssola.com:from_mime,mssola.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 814E7700BB9

--=-=-=
Content-Type: text/plain

Hi,

If you don't mind, a couple of questions from a newcomer that is trying
to grok this part of the code :)

Johannes Thumshirn @ 2026-07-03 10:45 +02:

> do_zone_finish() clears BLOCK_GROUP_FLAG_ZONE_IS_ACTIVE and removes the
> block group from zone_active_bgs, but only the path in
> check_bg_is_active() resets fs_info->active_meta_bg / active_system_bg.
> Any other finish path leaves active_meta_bg / active_system_bg pointing
> at an inactive, fully written block group.
>
> Reset the corresponding active_{meta,system}_bg pointer in do_zone_finish()
> so it can never go stale.
>
> Fixes: 13bb483d32ab ("btrfs: zoned: activate metadata block group on write time")
> Cc: stable@vger.kernel.org
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>  fs/btrfs/zoned.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> index 44a13ed6b8b2..c8c850de1702 100644
> --- a/fs/btrfs/zoned.c
> +++ b/fs/btrfs/zoned.c
> @@ -2539,6 +2539,7 @@ static int do_zone_finish(struct btrfs_block_group *block_group, bool fully_writ
>  	const bool is_metadata = (block_group->flags &
>  			(BTRFS_BLOCK_GROUP_METADATA | BTRFS_BLOCK_GROUP_SYSTEM));
>  	struct btrfs_dev_replace *dev_replace = &fs_info->dev_replace;
> +	struct btrfs_block_group **active_bg = NULL;
>  	int ret = 0;
>  	int i;
>
> @@ -2636,6 +2637,20 @@ static int do_zone_finish(struct btrfs_block_group *block_group, bool fully_writ
>  	/* For active_bg_list */
>  	btrfs_put_block_group(block_group);
>
> +	if (block_group->flags & BTRFS_BLOCK_GROUP_SYSTEM)
> +		active_bg = &fs_info->active_system_bg;
> +	else if (block_group->flags & BTRFS_BLOCK_GROUP_METADATA)
> +		active_bg = &fs_info->active_meta_bg;
> +
> +	if (active_bg) {
> +		btrfs_zoned_meta_io_lock(fs_info);

If you need to lock/unlock in order call btrfs_put_block_group() and
then reset *active_bg, couldn't the previous if statement be written
like so?

if (active_bg && (*active_bg == block_group)) {

This would then only lock/unlock just in the case we really want to
touch this 'block_group', no?

> +		if (*active_bg == block_group) {
> +			btrfs_put_block_group(block_group);

Also, hasn't 'block_group' already been put before your patch? Won't
this try to double-free this pointer? Or it is about decreasing the
reference twice for this block group?

> +			*active_bg = NULL;
> +		}
> +		btrfs_zoned_meta_io_unlock(fs_info);
> +	}
> +
>  	clear_and_wake_up_bit(BTRFS_FS_NEED_ZONE_FINISH, &fs_info->flags);
>
>  	return 0;

Thanks,
Miquel

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJiBAEBCgBMFiEEG6U8esk9yirP39qXlr6Mb9idZWUFAmpHgWwbFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwyEhxtc3NvbGFAbXNzb2xhLmNvbQAKCRCWvoxv2J1l
ZdArEACvaz+Zl25HHwVBuw94kYt6yA7wSBHzYs6QqDeWZHUZpkO9Ij9wTBH/HEM2
+4tE1HlhbY+Fn+/IhhyTWgMMgYKSFAKThhe//v2oX7VKfFPCAP6W9wWkvPkf/w5l
ZAWPflN49xN0X4VGXBvqOT5Y58zF/HN0d1wVkDLa+OKmFfGmQL/4xcwyXBBKHhSU
OuwTV5MB/yb+nF4274citrBb1IUbzZnhSlhXyKdVax+vLu4AuKju9E64XVWuz8w9
6iVOKLpd9zm50r53cLoTDuVVuw++EpmpY3dIniAkNsEZLwyIkyAJnoNyxW5bO3Y1
2yLZLcs107ovIx/rPQgFJLRGp2dpDhzHDsutWJIieZe/F6yGlCE8w9fDhVWFll51
KzKYafFIdbEfV1w3z2JOcxwVSb/b9n7/Nq/MvRZi3lBuGkVBngyMdb0jXDC3QOOX
4SuYT4JkqhouWxuQ0Eulw4OnvB14UU/2KkJd3UTE86lZINvFzvQQsWX5lKIT3qZG
gvpXT1UAUoSr+MfGTLiuL31xMpcY/T1Y7d4rfvQFF4k7N+ZY4WUMaCTme8Nm6yhy
o21PYFDTcqkfaoHvPotV+GEyLRyFFXvJL0mHVPMOrUtcRs0kFyB+QkMxHJ9cq67z
IjBarQKwybf31+tgaOmthWnGAbQgfLJMh3j4H50pryl6qZiVnw==
=MF0k
-----END PGP SIGNATURE-----
--=-=-=--

