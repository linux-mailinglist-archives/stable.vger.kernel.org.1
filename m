Return-Path: <stable+bounces-211415-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kKFIHO69c2mHyQAAu9opvQ
	(envelope-from <stable+bounces-211415-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 23 Jan 2026 19:29:02 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 17BBB79A79
	for <lists+stable@lfdr.de>; Fri, 23 Jan 2026 19:29:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3B6E530638F7
	for <lists+stable@lfdr.de>; Fri, 23 Jan 2026 18:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BCDA270EC1;
	Fri, 23 Jan 2026 18:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KagMOtgB"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCACF23E350
	for <stable@vger.kernel.org>; Fri, 23 Jan 2026 18:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769192770; cv=pass; b=apo7KL2vlmeD+BUsTbVYmnlQKf8zjHgduRezN2LzXfHkGQLKDwrSIMVi5eYaFGiAX1rhJrWMTChnXy7khbM3j46OrEDTYqyv/7A2L3XH9b1W3gV0XjcnsrzaN2Js0vg6LMqPqEe5Qrm5Rf4QpPp1ADvAyEY1T4OTm9ZsUSrAyKM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769192770; c=relaxed/simple;
	bh=lw7xRpFw2x/KE4Twuxal1PcgEtMfTSjH8L5ZPbFVCDA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mNlTbaqtH6ZL1JYSOjIEJOkmk5hVDyuKIyKO+PdYPO5NxcVaWKoOT4gA1v/5Fl71BbPHNBI2EmRibmeUl2/ttzKBk/Rqv4Xp09sNTPthEo4l0XT4oEZK7RKBrrYsf2gTWqgLQwjuWYOkxb6kjin4xAX74UOb0pfTP8uTPWTfFwU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KagMOtgB; arc=pass smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-64c893f3a94so5927059a12.0
        for <stable@vger.kernel.org>; Fri, 23 Jan 2026 10:26:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769192767; cv=none;
        d=google.com; s=arc-20240605;
        b=hy6rmosLxaha476H3v0625upUNxZxg21bpe3cpSnOaKySjAbL08iNhrDWU0KIh4HRu
         YDsfowyXpLQGkYNPlZTaynn2WOn8VVEvBn0Lt/Ks8iN4/EZFsuEZFbGLMumi6dsAVHxq
         hqeVWVbAJjzffmQ/irXIYXkCEYC0lBy2U1TJdGumePFAG0Fy7tPJr/VICQ0tOrGA0kDs
         o/1tgkcjdkuuQ457cPazhf5Hu1R0AK5jTZ6XgcSNhj4IhXfEeZbvqnBce9LUUUT6BiO3
         JUQFUonUZCyHHFnjzNjV8tL2GY9V06ie1rwIkcq5g77rNdKPVAL9tOPNq2tZWq0vcox0
         3YwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=plAFLPhHQxvfWQb9q1LZY3VXdudAWiQZEI4FNJSvCFk=;
        fh=nuxRI3VA+6NQvYoM+pGjf3JTFwyMk+GvErqcYwAGUg4=;
        b=MSnZr1lt73WSgtGc/OWE8PrgEZrRClNNlLSre/oi/Z4SGSVWpKx1ikyQ72Ay5NAsGo
         XHX0b5VxS28qGr6PsHbcAIFQKwUj7zZoaw7TRMVahRxAkBOZywCaiilVuk7wwBYV6Fva
         0pBc3QyB/aVmKyw3P9A0eJ7fG70g+7i3atWtwM0/7M3nCSCyhnWTvMTSQKsrQbxy/gXo
         LfgA9lKREjGZPtuoCa0VFK0PqVM5gq3EUuIPcrdCImB1xeItFwZ/5nzV8oSmDXVFa54a
         Zp7z/awLqOFwNB/QBnbhcdgXwvgXNbzDGtXH2/vEL1XtMz3aWOd+jcvApO1cS81Jwtmk
         uyYQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769192767; x=1769797567; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=plAFLPhHQxvfWQb9q1LZY3VXdudAWiQZEI4FNJSvCFk=;
        b=KagMOtgBIzNT19/IwggUARHTCuAFoMwuZUw+R9oQt4HQh98o25YIDuGjqrY3G1lsoK
         D8ERwZRhXa0VHkVajyQ5rxeYKThHJcQKtHB3an4wYOZ4XmEVdCACA4nLTMxQq6OSzvbB
         fX77tdtkN2x47NxCuinyNzh+tZQglwuv7Q/7Rrl9SvLX5L7bgmihy+IDlNrR6rginXnC
         pTIiXIcNZ8Ag5fvNpIxdPkhnXnX2JL/0PQYODNwLWkLtT8rrEh0WWRaPu414ZG60BYAP
         GAaR5TmX8tQaV/Qb2YxK5+6Tgk/pZbFrfoKO61vM+9ecZA72YcVRz51rgCnQ7Mo1peeH
         Qu5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769192767; x=1769797567;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=plAFLPhHQxvfWQb9q1LZY3VXdudAWiQZEI4FNJSvCFk=;
        b=FWjpIpp2OgS4DfB/96d0VxsdGt5J0ROXQpqxdREKp4+YLOfu4PlBZ9UeMHWjCq5hiZ
         fxmFGy+0/GnGwUwTODpGtIZ40qUHbXnTxFtFx2vxodi37fIvVkHUj9LFQDWidxzqvNtg
         AHqeeL0MCT+J3VzxurlqgPa7cvmkCkMoClhAM0Twb046m3Lt2GeWwnBSCe1VrjoIwP83
         4aBfbieOuk6EvcAflleMW+ACxGwq3X2rAQwgUCvIs3o+hd6YsnWZL576LTeOe31k+5zC
         7cR5g2UzABH9BlOadCfCgEiQMSmpRKyUwn0K31cRIycoKmy8IOhKjD/32CfzmHQQ7EcN
         M3yw==
X-Forwarded-Encrypted: i=1; AJvYcCUZv5l4fBQNUQ/N9CSIj5w9pXUaWDpi2hKtUYsXYJtJ9VmBNPcL+kD09K/ujKf/LjMPRXKjixU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx55c5Tk31Kfsp4p6WVAhBjivVUsj7cmXsOiMgUNLonsCs4a11b
	aeg9YIa0dS8/R7ZTjfrAN6axRIfrj+B/L+ck83Yb8jZeXX8DRI8qR0AoK0QY/PU9j047wLcSi1w
	UVli/OUIadtLpchDPkOVy9YGO31g9nNI=
X-Gm-Gg: AZuq6aJTurmj2qcGJAZijy8xsMgF6u3iItvTRcv569EYWVQJvw/Eu1io2p22ZHYa9uC
	zV55wCwWgTfrZLvaeC+IUWHX2xsB/mg9M/370o4xOin0VWpEQwVE2X7DncrhNfmEAzHW7gZ9eWx
	6Em5TMDkTotW+NP29w6qFAn6ZgSsMHoU22BGCGH1BZeG2abbtfpj/jkSPBurwi3pBY0x7CmteS3
	AwnCZvTFQ+jkvsv9bRW7tjqm/jYam5y3d9C9uF+ab16WXzUuU/fZw8IUXF0IFwTBCDsUsDYMV7r
	rtslJkJClfe3gXL38UA14f3Zv/Wrfw==
X-Received: by 2002:a17:907:6e92:b0:b87:19ae:eb36 with SMTP id
 a640c23a62f3a-b8831afe0b1mr459407666b.7.1769192766467; Fri, 23 Jan 2026
 10:26:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <176915153667.1677852.8049980969235323328.stgit@frogsfrogsfrogs> <176915153803.1677852.3768821466518761768.stgit@frogsfrogsfrogs>
In-Reply-To: <176915153803.1677852.3768821466518761768.stgit@frogsfrogsfrogs>
From: Jiaming Zhang <r772577952@gmail.com>
Date: Sat, 24 Jan 2026 02:25:28 +0800
X-Gm-Features: AZwV_QhbBhNCqFRaVEpuVLVGT8TSdILJLLQjzRGbrx3OvtrdQbvkTuWAsYL6jVU
Message-ID: <CANypQFa-_VsQjs7Ep4USA_YHC6cD0kH8K_eBV2SjKm1yPH2J7A@mail.gmail.com>
Subject: Re: [PATCH 5/5] xfs: check for deleted cursors when revalidating two btrees
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: cem@kernel.org, stable@vger.kernel.org, linux-xfs@vger.kernel.org, 
	hch@lst.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-211415-lists,stable=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[r772577952@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 17BBB79A79
X-Rspamd-Action: no action

Darrick J. Wong <djwong@kernel.org> =E4=BA=8E2026=E5=B9=B41=E6=9C=8823=E6=
=97=A5=E5=91=A8=E4=BA=94 15:04=E5=86=99=E9=81=93=EF=BC=9A
>
> From: Darrick J. Wong <djwong@kernel.org>
>
> The free space and inode btree repair functions will rebuild both btrees
> at the same time, after which it needs to evaluate both btrees to
> confirm that the corruptions are gone.
>
> However, Jiaming Zhang ran syzbot and produced a crash in the second
> xchk_allocbt call.  His root-cause analysis is as follows (with minor
> corrections):
>
>  In xrep_revalidate_allocbt(), xchk_allocbt() is called twice (first
>  for BNOBT, second for CNTBT). The cause of this issue is that the
>  first call nullified the cursor required by the second call.
>
>  Let's first enter xrep_revalidate_allocbt() via following call chain:
>
>  xfs_file_ioctl() ->
>  xfs_ioc_scrubv_metadata() ->
>  xfs_scrub_metadata() ->
>  `sc->ops->repair_eval(sc)` ->
>  xrep_revalidate_allocbt()
>
>  xchk_allocbt() is called twice in this function. In the first call:
>
>  /* Note that sc->sm->sm_type is XFS_SCRUB_TYPE_BNOPT now */
>  xchk_allocbt() ->
>  xchk_btree() ->
>  `bs->scrub_rec(bs, recp)` ->
>  xchk_allocbt_rec() ->
>  xchk_allocbt_xref() ->
>  xchk_allocbt_xref_other()
>
>  since sm_type is XFS_SCRUB_TYPE_BNOBT, pur is set to &sc->sa.cnt_cur.
>  Kernel called xfs_alloc_get_rec() and returned -EFSCORRUPTED. Call
>  chain:
>
>  xfs_alloc_get_rec() ->
>  xfs_btree_get_rec() ->
>  xfs_btree_check_block() ->
>  (XFS_IS_CORRUPT || XFS_TEST_ERROR), the former is false and the latter
>  is true, return -EFSCORRUPTED. This should be caused by
>  ioctl$XFS_IOC_ERROR_INJECTION I guess.
>
>  Back to xchk_allocbt_xref_other(), after receiving -EFSCORRUPTED from
>  xfs_alloc_get_rec(), kernel called xchk_should_check_xref(). In this
>  function, *curpp (points to sc->sa.cnt_cur) is nullified.
>
>  Back to xrep_revalidate_allocbt(), since sc->sa.cnt_cur has been
>  nullified, it then triggered null-ptr-deref via xchk_allocbt() (second
>  call) -> xchk_btree().
>
> So.  The bnobt revalidation failed on a cross-reference attempt, so we
> deleted the cntbt cursor, and then crashed when we tried to revalidate
> the cntbt.  Therefore, check for a null cntbt cursor before that
> revalidation, and mark the repair incomplete.  Also we can ignore the
> second tree entirely if the first tree was rebuilt but is already
> corrupt.
>
> Apply the same fix to xrep_revalidate_iallocbt because it has the same
> problem.
>
> Cc: r772577952@gmail.com
> Link: https://lore.kernel.org/linux-xfs/CANypQFYU5rRPkTy=3DiG5m1Lp4RWasSg=
rHXAh3p8YJojxV0X15dQ@mail.gmail.com/T/#m520c7835fad637eccf843c7936c20058942=
7cc7e
> Cc: <stable@vger.kernel.org> # v6.8
> Fixes: dbfbf3bdf639a2 ("xfs: repair inode btrees")
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> ---
>  fs/xfs/scrub/alloc_repair.c  |   15 +++++++++++++++
>  fs/xfs/scrub/ialloc_repair.c |   20 +++++++++++++++++---
>  2 files changed, 32 insertions(+), 3 deletions(-)
>
>
> diff --git a/fs/xfs/scrub/alloc_repair.c b/fs/xfs/scrub/alloc_repair.c
> index b6fe1f23819eb2..35035d02a23163 100644
> --- a/fs/xfs/scrub/alloc_repair.c
> +++ b/fs/xfs/scrub/alloc_repair.c
> @@ -923,7 +923,22 @@ xrep_revalidate_allocbt(
>         if (error)
>                 goto out;
>
> +       /*
> +        * If the bnobt is still corrupt, we've failed to repair the file=
system
> +        * and should just bail out.
> +        *
> +        * If the bnobt fails cross-examination with the cntbt, the scan =
will
> +        * free the cntbt cursor, so we need to mark the repair incomplet=
e
> +        * and avoid walking off the end of the NULL cntbt cursor.
> +        */
> +       if (sc->sm->sm_flags & XFS_SCRUB_OFLAG_CORRUPT)
> +               goto out;
> +
>         sc->sm->sm_type =3D XFS_SCRUB_TYPE_CNTBT;
> +       if (!sc->sa.cnt_cur) {
> +               xchk_set_incomplete(sc);
> +               goto out;
> +       }
>         error =3D xchk_allocbt(sc);
>  out:
>         sc->sm->sm_type =3D old_type;
> diff --git a/fs/xfs/scrub/ialloc_repair.c b/fs/xfs/scrub/ialloc_repair.c
> index b1d00167d263f4..f28459f58832f4 100644
> --- a/fs/xfs/scrub/ialloc_repair.c
> +++ b/fs/xfs/scrub/ialloc_repair.c
> @@ -863,10 +863,24 @@ xrep_revalidate_iallocbt(
>         if (error)
>                 goto out;
>
> -       if (xfs_has_finobt(sc->mp)) {
> -               sc->sm->sm_type =3D XFS_SCRUB_TYPE_FINOBT;
> -               error =3D xchk_iallocbt(sc);
> +       /*
> +        * If the inobt is still corrupt, we've failed to repair the file=
system
> +        * and should just bail out.
> +        *
> +        * If the inobt fails cross-examination with the finobt, the scan=
 will
> +        * free the finobt cursor, so we need to mark the repair incomple=
te
> +        * and avoid walking off the end of the NULL finobt cursor.
> +        */
> +       if (!xfs_has_finobt(sc->mp) ||
> +           (sc->sm->sm_flags & XFS_SCRUB_OFLAG_CORRUPT))
> +               goto out;
> +
> +       sc->sm->sm_type =3D XFS_SCRUB_TYPE_FINOBT;
> +       if (!sc->sa.fino_cur) {
> +               xchk_set_incomplete(sc);
> +               goto out;
>         }
> +       error =3D xchk_iallocbt(sc);
>
>  out:
>         sc->sm->sm_type =3D old_type;
>

After applying patches and running the reproducer for ~10 minutes, no
issues were triggered.

Tested-by: Jiaming Zhang <r772577952@gmail.com>

