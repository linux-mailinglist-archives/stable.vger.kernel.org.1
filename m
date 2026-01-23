Return-Path: <stable+bounces-211412-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iKQyBda8c2kmyQAAu9opvQ
	(envelope-from <stable+bounces-211412-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 23 Jan 2026 19:24:22 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 549BE7991A
	for <lists+stable@lfdr.de>; Fri, 23 Jan 2026 19:24:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B15C930060BA
	for <lists+stable@lfdr.de>; Fri, 23 Jan 2026 18:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 220A9283C9D;
	Fri, 23 Jan 2026 18:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f4Z4jyV3"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46FA126E6FB
	for <stable@vger.kernel.org>; Fri, 23 Jan 2026 18:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769192643; cv=pass; b=jIig1V38+s7DVItCYwaCc4oaIEiXsBcmXPKlA6oMwsYQ/65DeGQuFroQl1INT5hW0ltJYXRAlc4ubg701WGjJ4lC6KxsGiTlwkc0ZkRZtI96jJLuKT4Tl7y/HanYq4Q56RfWWFnFEYi/2dbbNuyrb/cNjkHN9fc3HoFcmgM708w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769192643; c=relaxed/simple;
	bh=n4YhPse98qUd9LwH4JiO0SDXD4jOD4zJ7XyPkwTyoTc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Je8ZQPqqNuoMgslbpzV+pWoQDCsYaF6nbhAVvzAl/RZ7OeNAoH3cSBULTDgdgOQBHleTlTDGluuWwod+Awe8tkvxY5lS0IauaGCNwfJpTs/sz+f4AIjH0MG1HBEg4NTk1secBOhNm8wJB+MGhTulUD/haUYNyS2eAOb2ijJtaVA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f4Z4jyV3; arc=pass smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b8849dc12f6so337831466b.1
        for <stable@vger.kernel.org>; Fri, 23 Jan 2026 10:24:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769192640; cv=none;
        d=google.com; s=arc-20240605;
        b=B5D7OEDWujc3dnB/VfVz5KVnJybnUCGNzfUyhiuYYQoKXver05mDmc2ZpzmG0zduqx
         Xu08GBvsu8F35TTqBIsMMG2KB0d0qBMBz3bqzDbBJBeirEBtESmUqzaemkWgLSP08+ml
         TNFKVyySAU3NjayKa0qYdEai0W+CugLUEt2XB3mcGg/r05ePqqseLbVoYO2nAD4cjaux
         WTqAIwMGQ9CjkT+sOjPsBJlI3MSV2WUAbMFFIy2q7oa1t16GVwLFo1MRduZ6ClnjQTBP
         89u7OTSQPKn4BRf/IrHl2KTDB0NCxUdpW9g84UnrNQG1Wg828FIrlrk0YMfT/HQPck+J
         Tt1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+wIr5X9WIZrYU1MaHy3YriH4HYquJi6PoX16TeqzI1c=;
        fh=lUvtzM+u2duCGplRaSJT7OPi53dW6GF+MkhHFyFKWn4=;
        b=bptzQ3OGBbxKBYK6c+xoGS13okkAQdtt6LwqDWbm+3dLvd55Il/v9e39dAP8ppc6wI
         vC/yI9LeYwaFyvzX7uRojF4BlyB4EXclXeOIlyCogkPV2+VhrDFgXwYcW33Po0ovdQfG
         nFuxdC1lal/65p3XQgVc2X007F/+PdHXwcADSLUHkn91eWlo0hGRCK6KgRNLI7p/s1Xs
         o4cb+2epDB0dACY6zRkBjy/QPYiQOXdUqpQhd0j6bYqK9h++eVmzJoViIPTb7FTVnuZX
         8GuRsQWrvSesIFWSMEPWKoJo693R4jSzzbEMqU1zt4SJEyelJjm9Fi1Vbwokt1qVHyck
         tGyA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769192640; x=1769797440; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+wIr5X9WIZrYU1MaHy3YriH4HYquJi6PoX16TeqzI1c=;
        b=f4Z4jyV3RuH3LLIqsWjxtmK7+BFXMdGZUjdXdgrewhOyDs74L49h6Wd1KATx5V3/nK
         6zCajBjnHiCsTigrklCeY+gzRDLWCW9I7NzXBOuPL22KKbIS20Uj3BlV+aC95wl7K/Zo
         ByN5qK6piofRVpMEf3z2bH+rnD3p5c6/7iGEyWCha5VzqvFdnHdtGdqLhm1vChOnrNAt
         IlLkKYxq9zi6/RRYxIG/UWjpFjJI4r8N/IvlKdPchqEwnZX+c39wOd8CZBe1cWO2S3EC
         JWclgDyCynkZPqdEbf57o/GTxPLhfvVl7n8DPy5sLdLM1CCVWUOxIc+u+o0pxgD1gfLE
         dKuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769192640; x=1769797440;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+wIr5X9WIZrYU1MaHy3YriH4HYquJi6PoX16TeqzI1c=;
        b=oNvH/HdGyvYkIY6MTVcNlAsL01JGAr+aqKJeGgtTaiB4Xv7vsXGrKTPQEalwsg7o5J
         xh6EfgfbAysABv/nT1sClBLPBsj9CAt5Yy/DAtnUgXRYAUXWNDtp1r/ElD0hcZQYS+Ci
         dk7AaJhQxlNRG7qcS8CG00aOuk85jXU4cU7FMtZzJgemofk5hXBQiKZmEgn/+hMifWkA
         4dw0KNz+OeBxzA0/PmYTAUtXHBJbBmBpHzzADNgX649agND8+4quUFJUWYWERvKG7oOa
         gjNCEk2HKn2Py9vuUe35idnzE5LBXypmVWL1jA5eO5cVpwmnOBFIxVBPx6IuuwSZrvwZ
         vMaA==
X-Forwarded-Encrypted: i=1; AJvYcCUyXYfj2ZJrGQwKGcZr1j8ONRcYLJycQ5qLmdPMgrncHAM0cvPRSrUPKxfP1yHlk1RvW47LoTQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzKiXCQ+LODrbP3MMahSrdnIv7s1nXGg7r++RyuM7LELHFowsU
	TjAZgH5iylgR4ybfB68cz+lY+O9QkqmYUbgQB3jSkkxzcJhc9vvxaWa0DtyBSMsY15gFqNZ9DQo
	n+PkcMi1ReWddtQjWDj192v+GGXzAwEU=
X-Gm-Gg: AZuq6aIrwPgjAfQBau3izvoO+Ba0e0UWPngPWBJliZwYDCB2QlNpeY3K8hnEz3ckWeN
	S3uSMWu8OYt5qbE2NqIeZgwlrtxBocdYoXutLLictwUC600xZIQfVws2765fww87WqxeyI3qJxs
	s4hlhGtRH6kd8uYU6/AKFz2Ky5TEGD23xEVgj5k1j5rxGDtPXgG+4IkUq6TGPI7vY79LlgkFFRR
	1ObayFJML5uZs9MOWpfGuzof8l3UbyJ71w1yUs0JOW7izHwGFYHVjywlZiPRjRvWmpKLhhEZZwc
	I7XuB4UHvvMdjcYqpi9LzL4DU4GOWzYUEJJtI8I=
X-Received: by 2002:a17:906:6a15:b0:b87:778b:89ba with SMTP id
 a640c23a62f3a-b885ae2f822mr262423966b.39.1769192639597; Fri, 23 Jan 2026
 10:23:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <176915153667.1677852.8049980969235323328.stgit@frogsfrogsfrogs> <176915153740.1677852.8895419964139371863.stgit@frogsfrogsfrogs>
In-Reply-To: <176915153740.1677852.8895419964139371863.stgit@frogsfrogsfrogs>
From: Jiaming Zhang <r772577952@gmail.com>
Date: Sat, 24 Jan 2026 02:23:23 +0800
X-Gm-Features: AZwV_QhvSCiBKwr8rSfXJUUH6fzV-C--pFB8GgtShUXMTLgDumF6WFVBo8FabM8
Message-ID: <CANypQFZ0dhuk869-tbXBQ8-RbPHrPwMvew7NHKePqJT9sAX_yg@mail.gmail.com>
Subject: Re: [PATCH 2/5] xfs: only call xf{array,blob}_destroy if we have a
 valid pointer
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-211412-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 549BE7991A
X-Rspamd-Action: no action

Darrick J. Wong <djwong@kernel.org> =E4=BA=8E2026=E5=B9=B41=E6=9C=8823=E6=
=97=A5=E5=91=A8=E4=BA=94 15:03=E5=86=99=E9=81=93=EF=BC=9A
>
> From: Darrick J. Wong <djwong@kernel.org>
>
> Only call the xfarray and xfblob destructor if we have a valid pointer,
> and be sure to null out that pointer afterwards.  Note that this patch
> fixes a large number of commits, most of which were merged between 6.9
> and 6.10.
>
> Cc: r772577952@gmail.com
> Cc: <stable@vger.kernel.org> # v6.12
> Fixes: ab97f4b1c03075 ("xfs: repair AGI unlinked inode bucket lists")
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> ---
>  fs/xfs/scrub/agheader_repair.c |    8 ++++++--
>  fs/xfs/scrub/attr_repair.c     |    6 ++++--
>  fs/xfs/scrub/dir_repair.c      |    8 ++++++--
>  fs/xfs/scrub/dirtree.c         |    8 ++++++--
>  fs/xfs/scrub/nlinks.c          |    3 ++-
>  5 files changed, 24 insertions(+), 9 deletions(-)
>
>
> diff --git a/fs/xfs/scrub/agheader_repair.c b/fs/xfs/scrub/agheader_repai=
r.c
> index a2f6a7f71d8396..6e3fef36d6614a 100644
> --- a/fs/xfs/scrub/agheader_repair.c
> +++ b/fs/xfs/scrub/agheader_repair.c
> @@ -837,8 +837,12 @@ xrep_agi_buf_cleanup(
>  {
>         struct xrep_agi *ragi =3D buf;
>
> -       xfarray_destroy(ragi->iunlink_prev);
> -       xfarray_destroy(ragi->iunlink_next);
> +       if (ragi->iunlink_prev)
> +               xfarray_destroy(ragi->iunlink_prev);
> +       ragi->iunlink_prev =3D NULL;
> +       if (ragi->iunlink_next)
> +               xfarray_destroy(ragi->iunlink_next);
> +       ragi->iunlink_next =3D NULL;
>         xagino_bitmap_destroy(&ragi->iunlink_bmp);
>  }
>
> diff --git a/fs/xfs/scrub/attr_repair.c b/fs/xfs/scrub/attr_repair.c
> index eded354dec11ee..dd24044c44efd3 100644
> --- a/fs/xfs/scrub/attr_repair.c
> +++ b/fs/xfs/scrub/attr_repair.c
> @@ -1516,8 +1516,10 @@ xrep_xattr_teardown(
>                 xfblob_destroy(rx->pptr_names);
>         if (rx->pptr_recs)
>                 xfarray_destroy(rx->pptr_recs);
> -       xfblob_destroy(rx->xattr_blobs);
> -       xfarray_destroy(rx->xattr_records);
> +       if (rx->xattr_blobs)
> +               xfblob_destroy(rx->xattr_blobs);
> +       if (rx->xattr_records)
> +               xfarray_destroy(rx->xattr_records);
>         mutex_destroy(&rx->lock);
>         kfree(rx);
>  }
> diff --git a/fs/xfs/scrub/dir_repair.c b/fs/xfs/scrub/dir_repair.c
> index 7a21b688a47158..d5a55eabf68012 100644
> --- a/fs/xfs/scrub/dir_repair.c
> +++ b/fs/xfs/scrub/dir_repair.c
> @@ -172,8 +172,12 @@ xrep_dir_teardown(
>         struct xrep_dir         *rd =3D sc->buf;
>
>         xrep_findparent_scan_teardown(&rd->pscan);
> -       xfblob_destroy(rd->dir_names);
> -       xfarray_destroy(rd->dir_entries);
> +       if (rd->dir_names)
> +               xfblob_destroy(rd->dir_names);
> +       rd->dir_names =3D NULL;
> +       if (rd->dir_entries)
> +               xfarray_destroy(rd->dir_entries);
> +       rd->dir_names =3D NULL;
>  }
>
>  /* Set up for a directory repair. */
> diff --git a/fs/xfs/scrub/dirtree.c b/fs/xfs/scrub/dirtree.c
> index f9c85b8b194fa4..3e0bbe75c44cff 100644
> --- a/fs/xfs/scrub/dirtree.c
> +++ b/fs/xfs/scrub/dirtree.c
> @@ -81,8 +81,12 @@ xchk_dirtree_buf_cleanup(
>                 kfree(path);
>         }
>
> -       xfblob_destroy(dl->path_names);
> -       xfarray_destroy(dl->path_steps);
> +       if (dl->path_names)
> +               xfblob_destroy(dl->path_names);
> +       dl->path_names =3D NULL;
> +       if (dl->path_steps)
> +               xfarray_destroy(dl->path_steps);
> +       dl->path_steps =3D NULL;
>         mutex_destroy(&dl->lock);
>  }
>
> diff --git a/fs/xfs/scrub/nlinks.c b/fs/xfs/scrub/nlinks.c
> index 2ba686e4de8bc5..dec3b9b47453ea 100644
> --- a/fs/xfs/scrub/nlinks.c
> +++ b/fs/xfs/scrub/nlinks.c
> @@ -971,7 +971,8 @@ xchk_nlinks_teardown_scan(
>
>         xfs_dir_hook_del(xnc->sc->mp, &xnc->dhook);
>
> -       xfarray_destroy(xnc->nlinks);
> +       if (xnc->nlinks)
> +               xfarray_destroy(xnc->nlinks);
>         xnc->nlinks =3D NULL;
>
>         xchk_iscan_teardown(&xnc->collect_iscan);
>

After applying patches and running the reproducer for ~10 minutes, no
issues were triggered.

Tested-by: Jiaming Zhang <r772577952@gmail.com>

