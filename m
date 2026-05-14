Return-Path: <stable+bounces-247234-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ADzvFaPtBWpWdgIAu9opvQ
	(envelope-from <stable+bounces-247234-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 17:43:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C53A9544320
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 17:43:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 41963314CE33
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 15:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EB68427A0A;
	Thu, 14 May 2026 15:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CNXNmTSb"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C25DD427A07
	for <stable@vger.kernel.org>; Thu, 14 May 2026 15:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778772392; cv=pass; b=dMuX7OEJMoVNy9vO82COV8IDW/Ab2smWdYtXws9vNtTFYZspC9O1+QpXZzH1TQhG/9Sk4pvfqG6Qe4GNzXLR/XyF7LSM0U6cUHhdn0f86fJG4ug8EBGUfkfVWZzPvNNClOpHfQHQxYYOInIm3F8OkfRAxgZx5Kx10IOL/W0EpXk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778772392; c=relaxed/simple;
	bh=wSqKrrrDJv6S24jh7HYsIvkQ509CP2H8PTcBm6YTBUY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l778Pn4kH9Ae5e7yjXZUqacxDqXtvAsf6jFF/N8ksf8NPux4xmxFzmCeae3Ocq0qFrgNeqoOG++NvTb+0Wks4Omf7t7joDQc/3Fp3nGjTEJosJffs48qv9MmjY27EciXOks1nwU2PIAeCe2OBksLFWmbl3v8pZqvg9j6l3diryI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CNXNmTSb; arc=pass smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-672645dbfeaso8058460a12.0
        for <stable@vger.kernel.org>; Thu, 14 May 2026 08:26:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778772389; cv=none;
        d=google.com; s=arc-20240605;
        b=QXntyPscGKqZO/IwRmE13NrIDV/f6EF+lT/R482qrFzJtR0lPl5OxSEgjwQbt/891Y
         imPS4LWpeAtdf7CPtB5q6BRVFJHpaPYo2d6WcY04BlHUZQjKKtk1dZizV7PWMEEFandc
         scThgLxs0ztaRy3X4C/g9he31bqpTEjocLv9kh7LfkcLCNoJnmt5KGGlj/s4m6ZGG2uo
         LkphNHMgVtFet9wO5DWpQ0hABqj6wp7Gj0a47ugsPeWuXyRK/Xd9N1zGPbwm4nWoJXV+
         ZQ6GXYr/kbbLoz5rNxpwgk2SZPWZ5uZ278Qr8olNAmyoEV1tE+DIsVFTW2jXiuKWF+CM
         PeJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=et82wCJVpQm7zm0J7X2OOILXIBLEXqjgb7LZdRr5Uno=;
        fh=dpD2o9Ot2W4qyJMKEAQitp+HY9dhhNWHcb1ricFZl+0=;
        b=Ef3wrmaVAWYR+fblTMnutrgQAbVRprhKlCad0EOCsmzS+52U+3OgGXhBrRBt68Fc37
         EUUV3ecBf6iW6peFtKxJROnTBgati7nfUrhpdWLlE2yDi7NgVqYY2PkZSYNQVvy+r3ur
         Dm8pHtEIvQLGEBR/d5dzuZEhDCyrLgDcOlXNPAB3aKcJCCY695peqV0jmWp+3q1wROqo
         FBWmbiBN8HM7dEo72ZwSRw0keqn5BSm5x+yE1LY2YOrHEE5ZXYvtKbnXYiScsqdlCR2P
         WTOlDn2J7a+s7t0TZBGX7/vyGZwcUK9/sT1dYVBZGhmvT8Iw+YjzUOr9pq9Ptle7XAXh
         49Aw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778772389; x=1779377189; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=et82wCJVpQm7zm0J7X2OOILXIBLEXqjgb7LZdRr5Uno=;
        b=CNXNmTSbF7bRd7gWeBWIlgln3SNTpY+ITfLZzQ63tcG0dOn6TQeDejr6doSqVGjrNr
         9uPTeVL72ObndkyHXCT7IUXD4spHZAPudoz0mvUS4Er10iPrXNV9n2vxLANxWHJKYR3A
         ijYhLQDWcmhkIPsecsZSjpEIgj7GnBms2RE0jfw3uCCKUkSoGQM41LBKxHGF6foxqiqC
         UXSYDm7qWpMKT5VCg75YlIrW7WkOlzX1MCblvl20ZJpR9U3gSGuTDpnVgeA0VdOZJ48x
         As4HJjC7Q2GvhWcwTlLRj/85h2duJIEivBijF6bWn4SpaxL4eqyaHRvV+h2/4HU8yJuX
         LD2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778772389; x=1779377189;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=et82wCJVpQm7zm0J7X2OOILXIBLEXqjgb7LZdRr5Uno=;
        b=Gh3mxhbVXYzAG+jFOz2YswCWbFKlXojjQFdYXOXiSn5jriEPOTFqMPJf6ZFwttHCFR
         mW2lHcIbWYANWphr+JKaYtOm0NX8QJpXdqIyT7OXWeAmN71xe+5bzt7FIE+kYEMF5SKD
         fnbpXeleNGvzwflld76Um2nsYp9cKD2gR3ADbZV6jzoHVZmJaipWquhb+8kPsq6kAWc/
         Jhu7M9pIVgfi0eGNGcY3J3k30MBj9bzbGjn9Y+4zd9+QWGOmpjkLiigGThl+Ba7SLkDZ
         Q+XO1mWb/zG9UBr3IEZKFQafFpQkOo4yBzMikRtBm/b3DvF9BGMzOf6vC8Su75ZU4Ie7
         EO1Q==
X-Forwarded-Encrypted: i=1; AFNElJ+4n1I85FjwqHobCjY4mfwNfxTppjIFSRPTDa94FVmVkc4eH3hiEah016EPQO3H7xV9ibVVy9Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxzriBE2QUxgF0sHTSUUUrgOAcew8DstO9Ck+ckInbwq8IPwWI
	8LwfEIWl0QDzvVEgYP/Wpe0ptSDwI5wL2EffUKC7Bxko1bGe9QWHZNUMzTR00QW77c52wPGCTMc
	2UYBhJN3n02oFMFAdtHU9+V9WRZyNsYk=
X-Gm-Gg: Acq92OHAIEWniFrbAeltn86qkdQeXDD0TJjlRFJe7HBN+GQpDquu4LaPsJ8soiprZIC
	spDALqzIx9RKYP0TwRgGzuIId/Y89fFVV3GdIpYaAqOguZu4QfSj9miZGut4q01dCKTt/ohd8Xk
	9c2uZcthQcH54oC8qyp3GzuKnLXOScGaBZMHKm5UAkviO4Gm+bM0X9sUOit4VK7HwtLoHXro7ao
	7izt4nmylyXrqkeRvLSdIjhxDtwaMM5PawFmAqOYVAHh9NT4+MANesrmkQPITNBGwdBLfKJARVN
	TthIhPGZ5GkaVLvosxDf8PAL7aXUgdD/BVPV0fEpKQ==
X-Received: by 2002:a05:6402:1f47:b0:67f:99d8:868 with SMTP id
 4fb4d7f45d1cf-682a7602ccdmr4453157a12.16.1778772388900; Thu, 14 May 2026
 08:26:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260514111354.3552538-1-nirmoyd@nvidia.com> <20260514144258.3068715-1-nirmoyd@nvidia.com>
In-Reply-To: <20260514144258.3068715-1-nirmoyd@nvidia.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 14 May 2026 17:26:16 +0200
X-Gm-Features: AVHnY4L-JBFwFIdc3-A0BeyC6XBW6KDz4ezIcvKQvqzLS1_LBW__OFjiX3LlQNE
Message-ID: <CAOQ4uxjGhRLnuU_=m=P-omUMM=0F+Mxs1O=zTasVnLdLz8ut3A@mail.gmail.com>
Subject: Re: [PATCH v2] ovl: keep err zero after successful ovl_cache_get()
To: Nirmoy Das <nirmoyd@nvidia.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Christian Brauner <brauner@kernel.org>, linux-unionfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	syzbot+a16fb0cce329a320661c@syzkaller.appspotmail.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: C53A9544320
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-247234-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[amir73il@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable,a16fb0cce329a320661c];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,appspotmail.com:email,mail.gmail.com:mid]
X-Rspamd-Action: no action

On Thu, May 14, 2026 at 4:43=E2=80=AFPM Nirmoy Das <nirmoyd@nvidia.com> wro=
te:
>
> ovl_iterate_merged() stores PTR_ERR(cache) in err before checking
> IS_ERR(cache). On success err holds the truncated cache pointer and
> can be returned as a bogus non-zero error.
>
> The syzbot reproducer reaches this through overlay-on-overlay readdir:
>
>   getdents64
>     iterate_dir(outer overlay file)
>       ovl_iterate_merged()
>         ovl_cache_get()
>           ovl_dir_read_merged()
>             ovl_dir_read()
>               iterate_dir(inner overlay file)
>                 ovl_iterate_merged()
>
> Only compute PTR_ERR(cache) on the error path.
>
> Fixes: d25e4b739f83 ("ovl: refactor ovl_iterate() and port to cred guard"=
)
> Reported-by: syzbot+a16fb0cce329a320661c@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3Da16fb0cce329a320661c
> Cc: stable@vger.kernel.org
> Signed-off-by: Nirmoy Das <nirmoyd@nvidia.com>
> ---
> v2:
>  - Drop the now-redundant 'int err =3D 0' initializer and the trailing
>    'return err' in ovl_iterate_merged(); err is only used inside the
>    loop's update-check, so the function can just return 0 on success.
>    (Amir Goldstein)
>  - Link to v1:
>    https://lore.kernel.org/all/20260514111354.3552538-1-nirmoyd@nvidia.co=
m/
>

I queue this up and will work on fortifying patches.

Thanks for the thorough investigation and for nailing this!
Amir.

>  fs/overlayfs/readdir.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
> index 1dcc75b3a90f9..e7fe29cb6028b 100644
> --- a/fs/overlayfs/readdir.c
> +++ b/fs/overlayfs/readdir.c
> @@ -838,15 +838,14 @@ static int ovl_iterate_merged(struct file *file, st=
ruct dir_context *ctx)
>         struct ovl_dir_file *od =3D file->private_data;
>         struct dentry *dentry =3D file->f_path.dentry;
>         struct ovl_cache_entry *p;
> -       int err =3D 0;
> +       int err;
>
>         if (!od->cache) {
>                 struct ovl_dir_cache *cache;
>
>                 cache =3D ovl_cache_get(dentry);
> -               err =3D PTR_ERR(cache);
>                 if (IS_ERR(cache))
> -                       return err;
> +                       return PTR_ERR(cache);
>
>                 od->cache =3D cache;
>                 ovl_seek_cursor(od, ctx->pos);
> @@ -869,7 +868,7 @@ static int ovl_iterate_merged(struct file *file, stru=
ct dir_context *ctx)
>                 od->cursor =3D p->l_node.next;
>                 ctx->pos++;
>         }
> -       return err;
> +       return 0;
>  }
>
>  static bool ovl_need_adjust_d_ino(struct file *file)
> --
> 2.43.0
>

