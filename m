Return-Path: <stable+bounces-232714-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AErrOALWzGnnWwYAu9opvQ
	(envelope-from <stable+bounces-232714-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 10:23:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 31EA7376B77
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 10:23:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 17B3B3007AC0
	for <lists+stable@lfdr.de>; Wed,  1 Apr 2026 08:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46153392C23;
	Wed,  1 Apr 2026 08:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YWNBL9Sk"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F14DE3A1687
	for <stable@vger.kernel.org>; Wed,  1 Apr 2026 08:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775030999; cv=pass; b=dUWyT2/q+WeN+DK3r75uYdCmD6qDOAVxy/y55q7iBN79ynDM0SKZZ2asBQVoO0FIowU6DWKJj56oEzqD2GlfKyzQyxiKxksfpsNs9DEJjof/7ZELfs9usSCsgxnoEuAHy7Cy13TF03/V8Um2oEX0i6AqHxxc2XPWCiVhTHsZRes=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775030999; c=relaxed/simple;
	bh=jzUrClyX8cx2Dl1XB0LjoIRE3MInfsdiP6asEc2NveM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nrY8QLVCB1lp/XR5Gy90rRB3traPU9Weuv+rg93jOal+slSfzVj5mTGdrpn1vyykXfTMnBlOHdVjWkn/aVi798HYAVCn7Q/m8C1VyTaFoiS/uId3AvClFfxPrDzfkVQC+o/FfqY6F/sLDE8atv+MQpv9Bp0Vo+XTr/BNhNok7cc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YWNBL9Sk; arc=pass smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-6501e465a8eso1094284d50.1
        for <stable@vger.kernel.org>; Wed, 01 Apr 2026 01:09:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775030996; cv=none;
        d=google.com; s=arc-20240605;
        b=dX0wpsgupM5tC4jIR2Cp5lGvpeHKSF/0qP4eHQFLaeKeJS7VVeq8J44Zwr+eOs0QYM
         W5Pr59/qRfUeFmxCtTnU96TCaOOR6JnP3Ek8jOc1rQyLmOZbVQi6Jj54uCSghqg9Cyfm
         qNbrX3m9AyTsnNCbZ64+44QfChbjPhlffjafEmHdLT+ne2zNFlh3u0Kkk1Iv+GMCMApN
         K7IpI4a8ORFxhsAcBVjR7dXxy0U7AENRbDwBiLhcS0s6DIPg4B1nEkaLavJbJjKP4KE2
         qIBiQcfnACWLTFCA3iDT36/whc8j3eEKG+L1a+yYeBDbNQUDYl+nHIfQpeCBTvSii2a3
         pyoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QGJ43lTmGm7tqVbmRpoI+e40OCefs4+iqftR/DXmG04=;
        fh=++bwsOrtBvq49/DdN6SBgYIVyBAD1veUQxxN0zlJOEY=;
        b=eB0yHFPD995sHjbDzWdsaRVUXa4pGWR7X5rmoMz9X8cnwS0vHZFM5pH5sE7pscd5Ud
         OT+IPf+AHLDOlbpQnQ2qHdbe/aHfHNmOeOJrIV726muizaNeFJp01iLjLIZF3VytDusL
         QfqRlYinp4AZDyRVoYZKkNQKKuVKnFmcDWzufgYmxJGR5EXJ3PMbE7XyHQNUXPDyKLsV
         /KJkhFzS0KNQqY+uoPo4zzRmKUyj6CgaYtOqEl44kLZFUp34qNDFi5NuuLwr3EMc796n
         cH2ia9rQVTyTz7avkUPIn9ZRWN6XDqQf33bsKO2kK+PmJ+makGdjrv7e3TcD6CFAmscg
         7GBw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775030996; x=1775635796; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QGJ43lTmGm7tqVbmRpoI+e40OCefs4+iqftR/DXmG04=;
        b=YWNBL9SklJpd38K47jKt1TkJceOl669WXPs0ubICzKjcnaLtteexPYoFzOn4JJPQ8J
         r8bBzqB4Jpq6VHCaVw7NzdlQG9kfQnpHeO6xvL+cPPzKOx18p5EmyUmERmTl8lggMi45
         gq1U69ef36WBCf4Zr3qHlo8R378ZXYVYd4pkJ4yU5Zp4Ze/eguKx3L432jHCAmNcVwTS
         DWrnve0uvdOHz72DbiVsh8DIdTsL2HL51t2XnPgWXgvoaMfaRGwsfA4yfzoj87i+eRec
         rj7REBVGHw/6qZoswN8l0+BTmvFPRjHTIwhuVO79y45Dgej7lWbyAwSqr4VC+ie7MZUl
         koDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775030996; x=1775635796;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QGJ43lTmGm7tqVbmRpoI+e40OCefs4+iqftR/DXmG04=;
        b=mRfFXbIsZM61VEP7Auw1fzJMKI63ZAsl21AvcfCQhuyveCLrU/eqKNtzc7ldnimd+Q
         z1GJuEG1Udm4lJzVYHomWZ8e2oCtP5UtZbGr4AjCUt62MUDd+JIbg0P0rkic1aDsOxjp
         7yM73QSKuRhJEm8sWy5xrGSRvcOT9/ctgOjvZMoSXNhJV0RmpIzAOnkRku7qbj/s5zNE
         7rskbOfGJNUhxygnfc3e8tRUOQwBi/NOyoF90IxrqGF6ah+xZYMvoOFpEHI8WonGunl/
         ir+x2Xg9CDVaPWmJGb3ErFDNTFh/NM0taoWH3HJBY892Tzl51uDHE5dBtPuKGTphlPkb
         fiOg==
X-Forwarded-Encrypted: i=1; AJvYcCV4LTaRyFlQCgFyjHr9zDlQ8DadinGAp1PbjViNagl4p6WpGsPE7XY2yko/qB5BAOILaOhTZ6E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZjftmtX2IK4+xbH2cAJqmZ1ZZVnq855Fn91TI+sNxTLxG/+fE
	lPgIqoCfIhMWn/MGseRUciuOKG00/Fc7bzK9igc83qnbxJ8HmIXzVemSJaN2aEU007gAyW49gjT
	P8PFxpykLlJk1vf7OdpDbNySn0LREhcg=
X-Gm-Gg: ATEYQzz5zoaMNfLR5QqIIZxktn+pQjgFldHvXNNy+1fNf5q/qHPT2Gh19KWY8/CWD75
	Vbt4oDARJKa7yj7+eEVSOYo/EdMU8XGa9C8M++FDDu51t/n+O7Q+XczQ1dmbaYHfwHDqQMxJLm4
	sLvhRkGRmZuBZmvpObWBV9c+fXcOZO/eU9nOcwNB64xMtyL9lixDwFViJiefXZhCc3OroHZMn3F
	qj5Oqs/b0FYIGrvUwqQfaxsanHEWRvzqlEOsKlB5Lyj/oZQoLZWy9sQYyV1OKu5nleodDqTP5Gl
	uVrG/XioKg==
X-Received: by 2002:a53:acd7:0:20b0:650:2257:e052 with SMTP id
 956f58d0204a3-650265fda6cmr5036099d50.17.1775030995799; Wed, 01 Apr 2026
 01:09:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260401031339.1418417-1-lgs201920130244@gmail.com> <aa8c074d-fdce-460f-a9b7-8644880eebb5@suse.com>
In-Reply-To: <aa8c074d-fdce-460f-a9b7-8644880eebb5@suse.com>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Wed, 1 Apr 2026 16:09:45 +0800
X-Gm-Features: AQROBzD9iqdOf-hjodNWRwd7n_vljJpSJ53rYJAa0xgydMeLcbvf8YxBXgvWfQg
Message-ID: <CANUHTR_ZgLHj8COyE8S_J+nqUUunxMTH9TcOMsDuN=Y1hPXPEg@mail.gmail.com>
Subject: Re: [PATCH] btrfs: fix double free in create_space_info() error path
To: Qu Wenruo <wqu@suse.com>
Cc: Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>, 
	Jiasheng Jiang <jiashengjiangcool@gmail.com>, linux-btrfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-232714-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[fb.com,suse.com,gmail.com,vger.kernel.org];
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
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 31EA7376B77
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Qu,

Thanks for looking at this.

I checked this on my tree at:

`v6.19-rc8-214-ge7aa57247700`

My understanding of the failure path is as follows.

In `create_space_info()`:

```c
ret =3D btrfs_sysfs_add_space_info_type(space_info);
if (ret)
goto out_free;
...
out_free:
kfree(space_info);
return ret;
```

And in `btrfs_sysfs_add_space_info_type()`:

```c
ret =3D kobject_init_and_add(&space_info->kobj, &space_info_ktype,
   space_info->fs_info->space_info_kobj, "%s",
   alloc_name(space_info));
if (ret) {
kobject_put(&space_info->kobj);
return ret;
}
```

The `kobj_type` has:

```c
.release =3D space_info_release,
```

and:

```c
static void space_info_release(struct kobject *kobj)
{
struct btrfs_space_info *sinfo =3D to_space_info(kobj);
kfree(sinfo);
}
```

So the call chain I had in mind is:

`create_space_info()`
-> `btrfs_sysfs_add_space_info_type()`
-> `kobject_init_and_add()`
-> failure
-> `kobject_put(&space_info->kobj)`
-> `space_info_release()`
-> `kfree(space_info)`

and then control returns to `create_space_info()`:

`btrfs_sysfs_add_space_info_type()` returns error
-> `goto out_free`
-> `kfree(space_info)`

So my concern was that after `kobject_init_and_add()` has been called,
the cleanup is already handed to `kobject_put()` /
`space_info_release()`, and the later `kfree(space_info)` in
`create_space_info()` becomes a second free.

If my understanding of the `kobject_init_and_add()` failure path here
is incorrect, please let me know. I may be missing something.

Thanks,
Guangshuo

Qu Wenruo <wqu@suse.com> =E4=BA=8E2026=E5=B9=B44=E6=9C=881=E6=97=A5=E5=91=
=A8=E4=B8=89 12:34=E5=86=99=E9=81=93=EF=BC=9A
>
>
>
> =E5=9C=A8 2026/4/1 13:43, Guangshuo Li =E5=86=99=E9=81=93:
> > When kobject_init_and_add() fails, btrfs_sysfs_add_space_info_type()
> > calls kobject_put(&space_info->kobj).
> >
> > The kobject release callback space_info_release() frees space_info,
> > but the current error path in create_space_info() then calls
> > kfree(space_info) again, causing a double free.
>
> Can you give an example call chain of where such space_info_release() is
> triggered?
>
> >
> > Keep the direct kfree(space_info) for the earlier failure path, but
> > after btrfs_sysfs_add_space_info_type() has called kobject_put(), let
> > the kobject release callback handle the cleanup.
> >
> > Fixes: a11224a016d6d ("btrfs: fix memory leaks in create_space_info() e=
rror paths")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> > ---
> >   fs/btrfs/space-info.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
> > index 3f08e450f796..d7176eb2fcbf 100644
> > --- a/fs/btrfs/space-info.c
> > +++ b/fs/btrfs/space-info.c
> > @@ -311,7 +311,7 @@ static int create_space_info(struct btrfs_fs_info *=
info, u64 flags)
> >
> >       ret =3D btrfs_sysfs_add_space_info_type(space_info);
> >       if (ret)
> > -             goto out_free;
> > +             return ret;
> >
> >       list_add(&space_info->list, &info->space_info);
> >       if (flags & BTRFS_BLOCK_GROUP_DATA)
>

