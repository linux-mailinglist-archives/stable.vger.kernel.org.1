Return-Path: <stable+bounces-216605-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QNJoAst/kWl9jQEAu9opvQ
	(envelope-from <stable+bounces-216605-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 15 Feb 2026 09:11:55 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7558613E475
	for <lists+stable@lfdr.de>; Sun, 15 Feb 2026 09:11:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 266CC3004414
	for <lists+stable@lfdr.de>; Sun, 15 Feb 2026 08:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20066231A41;
	Sun, 15 Feb 2026 08:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xt2M0ZoW"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C929A3FCC
	for <stable@vger.kernel.org>; Sun, 15 Feb 2026 08:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771143105; cv=pass; b=P+wdYg/NGfmUtFEM1j/qRywAc4kJKndD49ALhxXWh9KgZ7YwHHmCewKDxoh/Ec/pKYXxG+Gkw69qRVSTn2Rn3IlRUlwmW81hseqG1FjohnGOI6fI/e6oOo0SKgV0S/bljosHbz2N3zC4Lar292UTTHsQR7mBK6QseTuKlYeAe78=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771143105; c=relaxed/simple;
	bh=DTDk7K5Zkqtnt5fprRdhYF0zEccC1vT/ncnySQAaQkE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mKa2CwXdGJJug/SvJBYuUhpviiUSPMuotIqymvXOHieTElPzVteRhncz4NnsDgxyxdzALMmIb9IYa2XdrQUfS+SeahSAX4BvK0kWgbh0XRniVfr5pvnW3Y2XiPGZlqIt88GntJi0eW40zWxkOSgQ0AL2oo5s3nwqFzkPVrm2ekQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xt2M0ZoW; arc=pass smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b8fa7e3672eso306347866b.2
        for <stable@vger.kernel.org>; Sun, 15 Feb 2026 00:11:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771143102; cv=none;
        d=google.com; s=arc-20240605;
        b=dztiaZUDf353Xgkq6uUmvu+JWPEYIxJH4km1moqua9sky8rDZ0zpBGumdKVOf9QBPC
         thwcDFfqoS2tnCiRVQ9KM+xLA+fpAzzFOv0l1sHmlYvCidXNy8kIv5c49i6ocf5ITNb8
         PB0Z1TwO1k4yozFqJJUE6KuU00KPYQNIjFcK3C5kat0lede9cwxzCfYTOmV+Sx1erYLo
         PgQZmS3Jt8bEyFR93ntDGUWVltTVNRtVZpSTp42Fc3EiVMjyQwh4vt8OQi1EiCAvOAbk
         Ec0Is+tCyXnau8qWMCdiVpW8T76ooy9MYKoD+JnfeXN352bOLQ4FqucgEvW84r13URCY
         ttgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BrfHxdFp7u7ABi54dc0wXHkIQMX2y/VUZ8anXPNSims=;
        fh=3fFwbAPnsvSB4IsL5HH9izGncefauUSHBo87xWeKCvQ=;
        b=FvRKom0OMATzw5Hz47aRl933Fg4FYJw++aFrtf6gqbBGfEjFOaeHfhdatA33VVCXzz
         JsWPm4Je4sT1BEidGiWYCUtJ2Yq79r4HAi1zH6bUIbTbPH5pIbCHZTMLrnaDH2Mp/s4w
         AlokWAYNEu4wZIDjDnWkHGYJgI44pdPEoKYF+k0tCFO6Tc/E6XEX/2T9R+HZ5FzC3n3y
         YvDVVD6IQIeMXKGptDKbkom4fIV8EX7lFcUeZr73lVGoDfRizynddigl8xqQv4gmqbVQ
         rMFQ8tnA1uIS7bMhGf3Vru9a8fdg9n0lzjvlvYUT9AsGJ2I3f8sgZusbYh1pmfLp5NLK
         KOEg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771143102; x=1771747902; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BrfHxdFp7u7ABi54dc0wXHkIQMX2y/VUZ8anXPNSims=;
        b=Xt2M0ZoWWQIkYKU675MIq2NiyvF5zm3oAhVTSRcJjVJI9xJAQmwinHKYmDEutmJ80l
         oLiEw6Fggx4auTa2P6eKfL+noaG9VlJXveG+s+OPeqDBjrOeBLxUSqme8VqG5+kct522
         Fw96lz2KMVs5zTtOazVyqZ+natmsNtlRHBJba2t8Ok5MugBik+VWwSKlp5EN+VDZri73
         77lSqXGpq6KUR/0ptO84KHwMvYhl7K8fnFdiTSz8G/nrYfUMhjJZoWr/hJJbS40YP1l/
         sV18Ua556gCbQ1NagFWAa1JVHivl/7Z9ZpvTZFoAhS3wncX0ZnykqQrkBixiMrDoO9ty
         YznA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771143102; x=1771747902;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BrfHxdFp7u7ABi54dc0wXHkIQMX2y/VUZ8anXPNSims=;
        b=TWw8FxO1KjXHJa7tXim5PdpNAby+S2CVSasJxjG1y+7H0udT3kcwGzhf1NspvBge7c
         e+Oetw4aIl8ajogz84dBM9ypX7k0+L6eHw1By3qCDKt4T3t3invz8dkHUWACWGhP8omQ
         egTkCk5FaWjK+pxj4Hvb7ePyWLvVnX1SMSmLon7V8/crmh8Pye1mDQm7/bXLPti8diqw
         bwyH6Q8BLwVQpFpKslD4zsCUjohGkp+q79r8UvVbZtsowFs19hz5NUcnUdu9fMbPVUva
         X2B91RGK6/lqGziXajVumvcxAdNLdVCbdJi7Vak+FTV28zCCOe46cMRo1IqoQO4R3tJI
         Squw==
X-Forwarded-Encrypted: i=1; AJvYcCWFHXLAuJ4Ut9mC7+IPtzbae4N8/mEp2Yai7um/Q7qm3BLQncvghZ4VaZ4CAgvccXSYllQvuPg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnBFEO628z5HUBSVIb9gQvuQ37fnAYbqOaowygN1+Jfey5I2qV
	1vQo7wgWvEOVXm0DWFpwhMe4ZCeGAL+z7rAy8Xl9uW1uQsA3UdSSf5TxSJ0QLXr8GqBEzcd/u0P
	gUw+foizCZO+7vIz8GAdmvq+styggLHM=
X-Gm-Gg: AZuq6aKEywbwWSb11HiWBbzg0Ax7CLr54nHMlR6XGPMwdkuE11Q7sXjzpf4qhgzQ+eb
	MfK/GLqhxHAb0X1eTrRIZqvb+Is7LB5hkfUDdh1GL+SKTIGl3/IwPemGpJay4ohu0ieYNIQl9tN
	sIhzDUS+QMaP2ej38paCQmQu6ARSvT4Rncr6saG49pQyMJ64w4KDDA8Uk4JTRv+rQZ+vuiugwHX
	swjjn//JvOvGKqEtSRnQDCGxlFJbTFEiMx+sKuW/M/ceiytEo8UPifeQqzutcY33Z7Z9SFCoZCm
	Sga7z+iM9NOmRk8HdBkx0rsFz+FUk9oEsSnhdVbTUQ==
X-Received: by 2002:a17:907:3d9e:b0:b8f:a724:8704 with SMTP id
 a640c23a62f3a-b8fc3c7d456mr241918966b.42.1771143101677; Sun, 15 Feb 2026
 00:11:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260214212452.782265-1-sashal@kernel.org> <20260214212452.782265-85-sashal@kernel.org>
In-Reply-To: <20260214212452.782265-85-sashal@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sun, 15 Feb 2026 09:11:30 +0100
X-Gm-Features: AaiRm50iIi5RwEAw9dxYIy_zWbg5mNMrBSmlP3CQ0mExJK-TzLN3fgMTeFhoPa4
Message-ID: <CAOQ4uxgKwp2FSAUwqhHN-kTBcy0DsFmLstGUY+zJWppOzTAmHA@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 6.19-5.15] fsnotify: Shutdown fsnotify before
 destroying sb's dcache
To: Sasha Levin <sashal@kernel.org>
Cc: patches@lists.linux.dev, stable@vger.kernel.org, Jan Kara <jack@suse.cz>, 
	Jakub Acs <acsjakub@amazon.de>, Christian Brauner <brauner@kernel.org>, viro@zeniv.linux.org.uk, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-216605-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[amir73il@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amazon.de:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,suse.cz:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 7558613E475
X-Rspamd-Action: no action

On Sat, Feb 14, 2026 at 11:27=E2=80=AFPM Sasha Levin <sashal@kernel.org> wr=
ote:
>
> From: Jan Kara <jack@suse.cz>
>
> [ Upstream commit 74bd284537b3447c651588101c32a203e4fe1a32 ]
>
> Currently fsnotify_sb_delete() was called after we have evicted
> superblock's dcache and inode cache. This was done mainly so that we
> iterate as few inodes as possible when removing inode marks. However, as
> Jakub reported, this is problematic because for some filesystems
> encoding of file handles uses sb->s_root which gets cleared as part of
> dcache eviction. And either delayed fsnotify events or reading fdinfo
> for fsnotify group with marks on fs being unmounted may trigger encoding
> of file handles during unmount.

In retrospect, the text "Now that we iterate inode connectors..."
would have helped LLM (as well as human) patch backports understand
that this is NOT a standalone patch.

Sasha,

I am very for backporting this fix, but need to backport the series
https://lore.kernel.org/linux-fsdevel/20260121135513.12008-1-jack@suse.cz/

I don't expect major backport issues to kernel >=3D 6.10 with commit
07a3b8d0bf726 ("fsnotify: lazy attach fsnotify_sb_info state to sb")

Backporting below 6.10 will require more dependencies.

Thanks,
Amir.

> So move shutdown of fsnotify subsystem
> before shrinking of dcache.
>
> Link: https://lore.kernel.org/linux-fsdevel/CAOQ4uxgXvwumYvJm3cLDFfx-TsU3=
g5-yVsTiG=3D6i8KS48dn0mQ@mail.gmail.com/
> Reported-by: Jakub Acs <acsjakub@amazon.de>
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> Reviewed-by: Christian Brauner <brauner@kernel.org>
> Signed-off-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>
> LLM Generated explanations, may be completely bogus:
>
> The function is present and the code structure in the current tree
> matches what we see in the diff. This function has been in
> `generic_shutdown_super()` for a long time and would exist in all active
> stable trees.
>
> ### 8. SUMMARY
>
> | Criteria | Assessment |
> |----------|-----------|
> | Fixes real bug | YES =E2=80=94 NULL deref / crash during unmount |
> | Obviously correct | YES =E2=80=94 simple reorder, reviewed by 2 top
> maintainers |
> | Small and contained | YES =E2=80=94 1 file, ~6 lines, moving 1 function=
 call |
> | No new features | Correct =E2=80=94 pure bug fix |
> | Risk of regression | Very low =E2=80=94 only slight performance impact =
|
> | User impact | HIGH =E2=80=94 affects any system with fsnotify watches d=
uring
> unmount |
> | Reported by real user | YES (Jakub Acs) |
>
> This is an excellent stable candidate: a small, well-reviewed fix for a
> real crash that affects common operations (filesystem unmount with
> inotify/fanotify watches). The fix is trivial to understand (reorder one
> function call), reviewed by the subsystem and VFS maintainers, and
> carries essentially no risk of regression.
>
> **YES**
>
>  fs/super.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/fs/super.c b/fs/super.c
> index 3d85265d14001..9c13e68277dd6 100644
> --- a/fs/super.c
> +++ b/fs/super.c
> @@ -618,6 +618,7 @@ void generic_shutdown_super(struct super_block *sb)
>         const struct super_operations *sop =3D sb->s_op;
>
>         if (sb->s_root) {
> +               fsnotify_sb_delete(sb);
>                 shrink_dcache_for_umount(sb);
>                 sync_filesystem(sb);
>                 sb->s_flags &=3D ~SB_ACTIVE;
> @@ -629,9 +630,8 @@ void generic_shutdown_super(struct super_block *sb)
>
>                 /*
>                  * Clean up and evict any inodes that still have referenc=
es due
> -                * to fsnotify or the security policy.
> +                * to the security policy.
>                  */
> -               fsnotify_sb_delete(sb);
>                 security_sb_delete(sb);
>
>                 if (sb->s_dio_done_wq) {
> --
> 2.51.0
>

