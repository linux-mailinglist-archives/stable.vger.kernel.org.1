Return-Path: <stable+bounces-211414-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SF40Jcm9c2l7yQAAu9opvQ
	(envelope-from <stable+bounces-211414-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 23 Jan 2026 19:28:25 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 376AA79A3E
	for <lists+stable@lfdr.de>; Fri, 23 Jan 2026 19:28:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 99F9030E07A6
	for <lists+stable@lfdr.de>; Fri, 23 Jan 2026 18:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E98D29C325;
	Fri, 23 Jan 2026 18:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TfSaWHo2"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F039E23A99F
	for <stable@vger.kernel.org>; Fri, 23 Jan 2026 18:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769192735; cv=pass; b=eSy9reRR7KqwvP+ZvjdEL4yH6/RgzwzW5uIHpqBjBk4VItEyCPftKiyiED7tHhbckVTxGWEXm/wTBiNsie28t6g3C7a1NR9Iwbik4koByvFQrSds59Au35+F4zDmiVsCFlp+bkj6oApAMGOJ0xGE7rVWyz9fvTv46LBNXWjO+2I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769192735; c=relaxed/simple;
	bh=LLlr6qFPhQrpLskHiNTpWVP7M5Yl+G9ssNDzD/bnoX4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GLiR/PiXSnHbjGshsqCxWaqsOegBFS21EWF33CCfrmsI/ZZguecnKFT1gCJ7wKMrXTE4ntLe/eueWOzBJFpHuS951Sj3DA3rId6z2twwdukfL+ZFULV34/EdTEsQAXgcbjwzZehLB6/gkj0SDYHvBXOLBE+JviZP8c7vWWFOITU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TfSaWHo2; arc=pass smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-65063a95558so3604965a12.0
        for <stable@vger.kernel.org>; Fri, 23 Jan 2026 10:25:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769192732; cv=none;
        d=google.com; s=arc-20240605;
        b=KYlvqw6sKTRhSqkSpCQxbWQUxokS6SXsllEnrvE/7oRh9dy8hTOYizfYi6+m4GwjVV
         0uhVU6YekPE7YdSAgDH3Vdfo4hDVTq+doC9usOJMHLhvI+McfE/HQSHUcCNTJ/RCvyg0
         g65dCzT8vWuz6HIozD980EMLsSKonZ+Tuz7mbCm1x9FWYfHcSmCrGKDuDATseDSpvdYO
         NsFmbdhNTAEMybBU1H+bkrA8qzdu8BNMWQkdvmbtur0e6P94FHp4SsXQYJh4yiyGQXtS
         Dmh3o722uXPbxhnF3WLXOGrpx79uDjZO0nTTek1G4gb/fi4Oudzkl2f6/shEKLHqGzVG
         PDcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=U46WO/6V9JCyZE4jICWmEWW2GU9FvLsO66woYhkM8CQ=;
        fh=OZLdMsLM6j0DciIKN0lU3Kf0T+2+Eox0SYWT5/lDoI8=;
        b=dMaI5uLW/SVN3aWdRgu8IBoT+gnhCsaOu/6YhWZWfJ7kkAf/h8lWzRJgoWMYPjVuao
         DnLrLlY3EXhX4v6grkkLwNRCLmw5+K75XUs0OI4lUDF2lsdUWEwQX3mtLLPMCcT9wXlV
         238Wx0r6n7vavzTF/PDXsbnbA5B6JbLvqNT7u2mFsoT4+ztUfs9LiwjrFbk8iXmauykB
         wEJzBbcVx37rQ58GX2c9RQ+43+nVb+RE/EAF1V79+CofLZWzHqbmcJ5iNHwGRH18R/C7
         JOk+mVNNviudqB0+tsv42Otz9PY6DT9DoBavVt2ms/auxINvSb8FjADh3aLlQrB81aa8
         EUlQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769192732; x=1769797532; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U46WO/6V9JCyZE4jICWmEWW2GU9FvLsO66woYhkM8CQ=;
        b=TfSaWHo2OH+VcCe2IYxm87sLGWS3/T49+l445pVclWfSQjW1n1Fuj49TVQk2coRcIg
         5OEgLXo0vRBFOkS3wG57oMlD55IkKiPlPI9IdBN7valwzIlq2ijjPTrr1A5np1vvg+KQ
         rtjgDYDdfE79d55B7GpXo2uGjmz/PqllkcrKnSg/mnMCDAAUFOZOOaS9gspRobcHoa/t
         6v5odz8kpbjbo07uik+1g6cTTPmpsmaG6eZLl8t5cnk4BRJOjoFms4tYnBNk+jNjC0Cf
         EoeCa0skQTnhULxFW/hu5+IhHcSl6v0J4H2wVyvIJsx97ajYzU92AITDdw7vF0xyA7PY
         S27g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769192732; x=1769797532;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=U46WO/6V9JCyZE4jICWmEWW2GU9FvLsO66woYhkM8CQ=;
        b=P5jin9SjkfK2LSJ4fH4moQFpnA1xgdQIePHHdH6L/sELGsJlNxNyO6Nx3Rett61QLZ
         BpQzkgYeYB7I29/UfzDiJ0MraEX0FwgAm1B3oxTjAqQ/NJN4KVyNt8ZLKRRoe5/34daz
         FZisDlVblICjbpFF8xTUYO38B9ysWWzZq651WxFHZcD3WRULadjcuKX6MiCVNDkJOqv8
         rRQS7rjk62E530D5CwSB3T0byUtHjEbmJ+hBsWPnlNJtOIRvIBfQGtkgMZF/iCm7hEqR
         4Hq+Jo0M66akkA0s9/+O1DnH1OlMcxkbQnqXlWCZdPtdHP/NHp4+H932jHWCzOibBf8N
         ZACQ==
X-Forwarded-Encrypted: i=1; AJvYcCXDOcD7QPAp7+AaG/jsCeVoGxc3iOtz/Q6rQ7NJLURTYi2XiyOtT7AQZCHKUWNwvGYajy2SmQE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4MzTeat+kbS750K29N3/igUwe4X0scmJOtYf+A2CIzcJmTvhb
	ssAg+7LeWlx74ujD5+0j5oQRsb9dlSMgtHHNkceWPV7ubmsic0rlML8UJgNf4bMJgwATge38ele
	HO6ETbpZxuh0tPDtche4LuHvB7eCfifY=
X-Gm-Gg: AZuq6aJs6K0NLknANiLm8gOUdwB4URRmMcN3VjvYTzSDc/pp7ZJr7kNlmH2TTvTaP+J
	eZYfXHUihjRCeK4i1h6vkQJswYxjNR4Imn5jgLq33PGocidNCG08iKSzPquUqMqtKvSkxwxJI9s
	pNk6ppCN1iwt8T3Cf4DjyBVB3X5615uf90HUv870lhme9jcwasUh5tQBrzRYsZ+COA3Yg+Cc6eu
	rjTIW34u0DPwYHfCm5KswxZev2OamYvlLAWhGzo/y8DBqZZ5OTdP1FnN3gZ6PBXT7MwVoloKUKg
	A2hYkTuesXzoBLO5aC3DA7gutoVN4Q==
X-Received: by 2002:a17:907:7f8c:b0:b87:322d:a8bc with SMTP id
 a640c23a62f3a-b885ae332e3mr271805566b.31.1769192731569; Fri, 23 Jan 2026
 10:25:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <176915153667.1677852.8049980969235323328.stgit@frogsfrogsfrogs> <176915153782.1677852.511726226065469460.stgit@frogsfrogsfrogs>
In-Reply-To: <176915153782.1677852.511726226065469460.stgit@frogsfrogsfrogs>
From: Jiaming Zhang <r772577952@gmail.com>
Date: Sat, 24 Jan 2026 02:24:53 +0800
X-Gm-Features: AZwV_Qgr0Zs4bqzv5ANNnDbFK2WKMm696RJGslpy5VAD19tTvor6GaE9fd4dcyU
Message-ID: <CANypQFbNw52qkirN9cKma2Xw-CLjLumq8gqF=Utn47fCcr6Lgg@mail.gmail.com>
Subject: Re: [PATCH 4/5] xfs: fix UAF in xchk_btree_check_block_owner
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: cem@kernel.org, hch@lst.de, stable@vger.kernel.org, 
	linux-xfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-211414-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,lst.de:email]
X-Rspamd-Queue-Id: 376AA79A3E
X-Rspamd-Action: no action

Darrick J. Wong <djwong@kernel.org> =E4=BA=8E2026=E5=B9=B41=E6=9C=8823=E6=
=97=A5=E5=91=A8=E4=BA=94 15:04=E5=86=99=E9=81=93=EF=BC=9A
>
> From: Darrick J. Wong <djwong@kernel.org>
>
> We cannot dereference bs->cur when trying to determine if bs->cur
> aliases bs->sc->sa.{bno,rmap}_cur after the latter has been freed.
> Fix this by sampling before type before any freeing could happen.
> The correct temporal ordering was broken when we removed xfs_btnum_t.
>
> Cc: r772577952@gmail.com
> Cc: <stable@vger.kernel.org> # v6.9
> Fixes: ec793e690f801d ("xfs: remove xfs_btnum_t")
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/xfs/scrub/btree.c |    7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
>
> diff --git a/fs/xfs/scrub/btree.c b/fs/xfs/scrub/btree.c
> index c440f2eb4d1a44..b497f6a474c778 100644
> --- a/fs/xfs/scrub/btree.c
> +++ b/fs/xfs/scrub/btree.c
> @@ -372,12 +372,15 @@ xchk_btree_check_block_owner(
>  {
>         xfs_agnumber_t          agno;
>         xfs_agblock_t           agbno;
> +       bool                    is_bnobt, is_rmapbt;
>         bool                    init_sa;
>         int                     error =3D 0;
>
>         if (!bs->cur)
>                 return 0;
>
> +       is_bnobt =3D xfs_btree_is_bno(bs->cur->bc_ops);
> +       is_rmapbt =3D xfs_btree_is_rmap(bs->cur->bc_ops);
>         agno =3D xfs_daddr_to_agno(bs->cur->bc_mp, daddr);
>         agbno =3D xfs_daddr_to_agbno(bs->cur->bc_mp, daddr);
>
> @@ -400,11 +403,11 @@ xchk_btree_check_block_owner(
>          * have to nullify it (to shut down further block owner checks) i=
f
>          * self-xref encounters problems.
>          */
> -       if (!bs->sc->sa.bno_cur && xfs_btree_is_bno(bs->cur->bc_ops))
> +       if (!bs->sc->sa.bno_cur && is_bnobt)
>                 bs->cur =3D NULL;
>
>         xchk_xref_is_only_owned_by(bs->sc, agbno, 1, bs->oinfo);
> -       if (!bs->sc->sa.rmap_cur && xfs_btree_is_rmap(bs->cur->bc_ops))
> +       if (!bs->sc->sa.rmap_cur && is_rmapbt)
>                 bs->cur =3D NULL;
>
>  out_free:
>

After applying patches and running the reproducer for ~10 minutes, no
issues were triggered.

Tested-by: Jiaming Zhang <r772577952@gmail.com>

