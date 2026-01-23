Return-Path: <stable+bounces-211413-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sCfDFPe8c2kmyQAAu9opvQ
	(envelope-from <stable+bounces-211413-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 23 Jan 2026 19:24:55 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 07DBF7992F
	for <lists+stable@lfdr.de>; Fri, 23 Jan 2026 19:24:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 430443017277
	for <lists+stable@lfdr.de>; Fri, 23 Jan 2026 18:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D3DA245008;
	Fri, 23 Jan 2026 18:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hPJJtKDy"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1849D238C3A
	for <stable@vger.kernel.org>; Fri, 23 Jan 2026 18:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769192689; cv=pass; b=V33xNVGXdKCaK0fhX3fc4FTNY8CyarbYBS+2P+Z6WFmHA+5TYinWJWu/kHCPe/KFXcVEiqSTokHJA7rUQLHZmyQYtUFhhDd/35dG3uAQqUykN4IWdutYYvyocH1EhNCFJRKE4rOIaz+jTsy562v+U8yKxgwokBfOb3Y16QGonbY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769192689; c=relaxed/simple;
	bh=ISxbKohTgkQkJLGb46Dr9mlK6gEmzyea73J5Js/irTg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h/2ojTmcnovZhPjrIIi7qaEKhTIpikOvvSP34PnU4TsI1J55Xxz1jG/cuecKF/0NWphFT4zL5Kee4FCraaRvAlyWjktWhMxcSVtZlfpcF0d7eMl4kMz315OMjj6pW+PPu1hqLhv2e352dNKOsWFbB1WIuTfowGeXa2Sy5e+Us+0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hPJJtKDy; arc=pass smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b885e8c6727so225043966b.1
        for <stable@vger.kernel.org>; Fri, 23 Jan 2026 10:24:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769192686; cv=none;
        d=google.com; s=arc-20240605;
        b=MtMCWDS70pSmO/4aOC/jPq/dal+p+Ys2RWSRu28tow/FZtlvcB1FWbmBdEaT1eDgww
         cDZFWcy5nS7EW+QQma3ZZAfmk22Pxa6vJo6UuzTbJeKhB6AQOQwVeWt7DVT6SEEADC+Q
         g4bD+lA5ySkbIDg0o8O/zYbrcy2ltexfVPeI0QZtAxdEtzCd14vdqBnlOZ5SbdwZ9Ubk
         EWErVaOzEdWIhvWd5TVr/vwqv7Q/X8QF1Jti/pLk+TQvozINCkW7R3XsuXrChFCvkjm4
         w1ItPUtTwb+wP+22lVFOFIpXpZy2PmAiM+xk5VRl7yYEaQwsx0VJ7kykqJOwy6gOrXAI
         M9fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5cVJF4hn7iik9B/ULbOnGHj/zoVgYkKufI/4cDYwvTM=;
        fh=uZlrsps+06wPzO1CFX4Ix8CzBfjB3fbGz3QSvZgqSbk=;
        b=Gc3a4QYMhm13pJU2RA+Tr3jedWxk1I4Kr8skbNtN1L4KiTFg8eCCzZeuUYq5KS3ytJ
         CPugfRubd29gEHIxnPFjO7ZndNvDbSO/z2SnttE548SN1CjS95JpiPSxvq4smteyst9L
         DKduEX4xHhIHtL4eC2naOcnUYIPAvHBtL4LOxiMPMh4irFRjXJQsxg1VE0Lr5tgtQusE
         iCCi87N1W1lWXQTHWiYdhOZIqhXXJ69gqDbif9lsV8icoiJ4VtMW+zvo2Jddrc9YLJcO
         YWr+sslxVA/XzZK9350+9mPmxp3NcbZoRPkuU/79hnksxaSd0vSSMpkySM2gUR46C214
         luQw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769192686; x=1769797486; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5cVJF4hn7iik9B/ULbOnGHj/zoVgYkKufI/4cDYwvTM=;
        b=hPJJtKDytPV6QLZ1HGEvgh84Szjf32pCdrMq/znLTVweXyZVHZgv6sQrwkAT90+5Cv
         cBGt7qP9n3KTdtJQfQU+I/NFeMv91QImHI20YR/aO9LmHyX4cyIiprtt22ZePVQcnI8m
         3z0Yb/Is5Z4bZ8JTJWbH+FI2NcSbE/q9r9Dq8ZxYGC2TUfp4mILGg+nI9CcETCJry5iV
         gsv9BrUxtGki53bWt6RCceNPv/9Rbs3w6a7hrkim8o/EDPD/RrVl1K0sAbZWzDzhvPap
         +NQyKskhp2htrvyKcLG/wib4X+hDetKg52ANbNAd/q1aatjxNUGnBig/TDANmgvHKmEM
         /ipQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769192686; x=1769797486;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5cVJF4hn7iik9B/ULbOnGHj/zoVgYkKufI/4cDYwvTM=;
        b=bfTU7yYEAekbcyEsIla7QYM7SjX4skyXYT6Y1Au4J4OBO6ePIUFVQUNiC2P514F/7l
         mwSOVFiqAsuOQRYYxE6j9sPJopcYDsJynooC2EPTVvj0qTzdB01pEtNc/yjX2/Te2DOy
         E59F+DhL/8R200k+31FA2Vk0g5tPsIIaicANfSD1PL2IAecbuinM2tz+MBjuuy61OH9M
         FZ3CKs5HRD/549t8CrppWoHy3uNT9gUPw0WYXFPvk8lmxSwewJfl9v/LtjPBPuQWNt+V
         LtbloZVqPZgatp7oAxwfbjqt257f+Xbvu+T5rokEoe+liklgOtwo3C7qpJ+24mHWAGZ8
         HaCQ==
X-Forwarded-Encrypted: i=1; AJvYcCUs1IJrZwzTmPX+Q6hQQ9sWW5lAvc8of/o5J4NtjLi8lXSTRq3H1Mo4N38zTPi6jC+N2ouTsj0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAfrB9ZdF6wMhmTmw4OzZUKcE3VKc1cL9r2LvMm8cEY4Pz9D8V
	hVldhL9IwmINUhKotPRlC7+We3VJqMDCSXRW6sBJ4Z/1otGK9XBwqJ1C1XJIHFvsQYypXon6jiB
	LjgJXAPexaVGY0VxFyU2YQVBNLZ7t1qcewjpXT+S5hQ==
X-Gm-Gg: AZuq6aJRw7I4pDdWSuSgRsKHh0HN+9ubJbrD5djNSaShj6gcqsPx8+lq+mdLy6S9Ebc
	abTwthGkB0GsCO7lk2tHz89jByL1Se2WBjzfu+jklYV6TolPNehIlORgJUxwYVQMNM4w3pkNtYW
	GPYdNGOikWFUV4ibTnc5Nc896YjMjSVL0WqDG/X8Z7SS2BhC184rBsXvvC58W/JD2ZORzBNb4TV
	xtTqJwldeFuc7UzHyo26jsFUoQ+RkDbxWlrpIwgtu+zQU2LTWkuAq8E/fPq8+PLu+qMkGA+ALMj
	xFzwjHBxU/rt1sYpI1QrVxTEM+yXyA==
X-Received: by 2002:a17:907:60d1:b0:b80:456d:bd99 with SMTP id
 a640c23a62f3a-b885a3b601emr295926766b.19.1769192684867; Fri, 23 Jan 2026
 10:24:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <176915153667.1677852.8049980969235323328.stgit@frogsfrogsfrogs> <176915153761.1677852.10364914654449283291.stgit@frogsfrogsfrogs>
In-Reply-To: <176915153761.1677852.10364914654449283291.stgit@frogsfrogsfrogs>
From: Jiaming Zhang <r772577952@gmail.com>
Date: Sat, 24 Jan 2026 02:24:08 +0800
X-Gm-Features: AZwV_Qhc7HQIx8Jldfe4gIdkQ3j2HOjmrFi9KHHJ6KCvEFTKTji6ltCzHRYXhV8
Message-ID: <CANypQFbhbXeM=WXqcSvR4n2=LY7a_6+HuTL8X2Vs5yK3sy17kw@mail.gmail.com>
Subject: Re: [PATCH 3/5] xfs: check return value of xchk_scrub_create_subord
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-211413-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 07DBF7992F
X-Rspamd-Action: no action

Darrick J. Wong <djwong@kernel.org> =E4=BA=8E2026=E5=B9=B41=E6=9C=8823=E6=
=97=A5=E5=91=A8=E4=BA=94 15:03=E5=86=99=E9=81=93=EF=BC=9A
>
> From: Darrick J. Wong <djwong@kernel.org>
>
> Fix this function to return NULL instead of a mangled ENOMEM, then fix
> the callers to actually check for a null pointer and return ENOMEM.
> Most of the corrections here are for code merged between 6.2 and 6.10.
>
> Cc: r772577952@gmail.com
> Cc: <stable@vger.kernel.org> # v6.12
> Fixes: 1a5f6e08d4e379 ("xfs: create subordinate scrub contexts for xchk_m=
etadata_inode_subtype")
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/xfs/scrub/common.c |    3 +++
>  fs/xfs/scrub/repair.c |    3 +++
>  fs/xfs/scrub/scrub.c  |    2 +-
>  3 files changed, 7 insertions(+), 1 deletion(-)
>
>
> diff --git a/fs/xfs/scrub/common.c b/fs/xfs/scrub/common.c
> index 5f9be4151d722e..ebabf3b620a2cf 100644
> --- a/fs/xfs/scrub/common.c
> +++ b/fs/xfs/scrub/common.c
> @@ -1399,6 +1399,9 @@ xchk_metadata_inode_subtype(
>         int                     error;
>
>         sub =3D xchk_scrub_create_subord(sc, scrub_type);
> +       if (!sub)
> +               return -ENOMEM;
> +
>         error =3D sub->sc.ops->scrub(&sub->sc);
>         xchk_scrub_free_subord(sub);
>         return error;
> diff --git a/fs/xfs/scrub/repair.c b/fs/xfs/scrub/repair.c
> index efd5a7ccdf624a..4d45d39e67f11e 100644
> --- a/fs/xfs/scrub/repair.c
> +++ b/fs/xfs/scrub/repair.c
> @@ -1136,6 +1136,9 @@ xrep_metadata_inode_subtype(
>          * setup/teardown routines.
>          */
>         sub =3D xchk_scrub_create_subord(sc, scrub_type);
> +       if (!sub)
> +               return -ENOMEM;
> +
>         error =3D sub->sc.ops->scrub(&sub->sc);
>         if (error)
>                 goto out;
> diff --git a/fs/xfs/scrub/scrub.c b/fs/xfs/scrub/scrub.c
> index 3c3b0d25006ff4..c312f0a672e65f 100644
> --- a/fs/xfs/scrub/scrub.c
> +++ b/fs/xfs/scrub/scrub.c
> @@ -634,7 +634,7 @@ xchk_scrub_create_subord(
>
>         sub =3D kzalloc(sizeof(*sub), XCHK_GFP_FLAGS);
>         if (!sub)
> -               return ERR_PTR(-ENOMEM);
> +               return NULL;
>
>         sub->old_smtype =3D sc->sm->sm_type;
>         sub->old_smflags =3D sc->sm->sm_flags;
>

After applying patches and running the reproducer for ~10 minutes, no
issues were triggered.

Tested-by: Jiaming Zhang <r772577952@gmail.com>

