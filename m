Return-Path: <stable+bounces-242821-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iOGnFhmy92mrlAIAu9opvQ
	(envelope-from <stable+bounces-242821-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 03 May 2026 22:37:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B33BC4B7569
	for <lists+stable@lfdr.de>; Sun, 03 May 2026 22:37:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 17C843005AE9
	for <lists+stable@lfdr.de>; Sun,  3 May 2026 20:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BB503A3E8B;
	Sun,  3 May 2026 20:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fI5E++54"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76CEB379991
	for <stable@vger.kernel.org>; Sun,  3 May 2026 20:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777840661; cv=pass; b=LoXJV4DRUZy+uTws7li6S1yMYycXFmxXLAFIFMR8ZNWURr+UuL5MlOZjqfan7OwaOQsamWoZTCNz/nQRaPpavXtuiBIDvl86lqD/NVhMxckEecqLPd24ee/lBKpho6do4fmiYqVsF3kguhRmY3ikXLPUKYVqI4VE8/De/HAXK9U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777840661; c=relaxed/simple;
	bh=ZK6kVE4aK4cIz4P0nuY6XGFvB37lYQqSEZxrRsUBqQQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BN5M1Nn/o3M98F/FyYxyL0EKOua54/x0BOOXBNubghv6g8N9U9VcyzO8eCSXN/g09yMAWAIcR3mQGdPAk+v+m1PGC2RhDHpYpd0aOEl+tfkVwnMioZDO3RKIifL5zZf2O4XsHaNgjjn0i7vwZeYNopPqJIvLSLuu4qAUPPkZRfA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fI5E++54; arc=pass smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ba699316b42so486346366b.3
        for <stable@vger.kernel.org>; Sun, 03 May 2026 13:37:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777840659; cv=none;
        d=google.com; s=arc-20240605;
        b=MClK1oupGugzPon05Xpml7IF0DZfhjkmpk1z+KMZMfghvK5Xw8AIh6agIsS1fnzCDL
         bpqFTKGs6NTeLqBLy49qdm2Bv7pnWiCXLuUcqa6807JZ4+eE6APOE29en7+e+AW92OoJ
         oBFzc8pu2yPXr1s+6hmFASmogt/xeseWbBLLVO0HiyNnU4QFsD2kRDTPnZZLKi698HyU
         Hyw01tbMIER6Q2Zv655go+tBPvMy0GXiElRRHrK63V4CI3ZVfiBe2ONOS74UEpLvD4Bz
         ze6yVMvQzobMwz89p02DnjCP73xkoZGX4yhz1pa9zyskIggEUwFtoQBTP+KIcDQ70TjB
         a1vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oYDjILYmC2Y2v1Vrp32Hw/02aE233hVhJfUp7KpMFnU=;
        fh=JFzgF41dhl2LKX9DjAjg2ebcZK+aizcESypHyrYB4dQ=;
        b=TmNqneRe/qEl0CazSJraErjRS+t/dWUWNInmirxhrfOzQ4TDwG3tjZRUL4899VbR4A
         B+4srzIGTz0X76B2VGuAvne0R3GC7BUAMUoe+Ge0qKExSChr7Kc+KYpTEMAFxP+REpht
         hujix8rfTX1JoD8SVt7p9mnjsExZqFC7jHwq/vPmksNna3gBOUuwp9MFs+AAOCBv2YMR
         tE2ibLEKJrrLmtUZpJgmx6tiJ/52AixGExqhT75IMEP7+gxyNhu4Fid3V59TNcv6+LAi
         hxhS5DtJVDf9OdPBKRPvRb9/CaXTCNauPmbwA1+y08FG1CEGFa5TmHf/ExPJWSBJE2ii
         Dztw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777840659; x=1778445459; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oYDjILYmC2Y2v1Vrp32Hw/02aE233hVhJfUp7KpMFnU=;
        b=fI5E++54Eh/Bu+4qAfNYX2HtpCshbg6DTZGQAAaZiGG3tPLsUCr3JvB+GlFFzisQ8w
         VOkRyn8FHwx2o3pW2Q8w+IfjtxIeDmU85TxaStFMbmwYoCogLlRsgVRbjMGLJbyVm5/P
         V740t1pxDs+XHbbJJCr0ao9SvBC79r2YDLFNWhSg4dbKRYb8e59Caq42iwfXtumJU8DG
         g7UdFIB0CYDQ/li9t2rNa62BqWTo6uR7pLzYacaT9kO0psn6WQHZMMrrltejIvtdDqc8
         aRuDDp+G0bMG9lQ56Ld358hHzq3Daptp5tjbYY4evR5PJMRZM2Af30HTWSt1bDy4lb9f
         uVSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777840659; x=1778445459;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oYDjILYmC2Y2v1Vrp32Hw/02aE233hVhJfUp7KpMFnU=;
        b=ZwhcuGJBIb0CdLzgnCYwUoU+/U5tuxlcM5VgBYKr89m74tCNumefZIBzdt+67FCLZJ
         FfsIgDZDbEKIwdT1B0QccAxRPyVXeSESQuvbG9/vpj4oYEx+BoQssr26tGWfTJILUSFK
         C45WCiZTSojKgewB3v0vLtlmiQtbnExwM0YFX+iUspseD4WACRTb8dW5MAZMb1rr4j2p
         dsa6JEFbLNW8Ghe93LL6+L2bTDBNsUis17QFivQ2iwWRq/e5cwHxfzVXmnJ//Q1fbhnA
         3i1gdM4jn+FZrYbM6dE1eMhYcuwV58TYnCFvoDyN6Sld6I6o1nXaEjP+vL+VyzfjB5MO
         I7pA==
X-Forwarded-Encrypted: i=1; AFNElJ+42r8yv/r6yvVl8/N+Ay5SGER1N9X1+T4lDyon99PpyXdIDpwneqoS7utJAFeze9GIh00p4qE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkKjjGRRUjhOsz/O4necBUxT1lrhPkuH3xFhIGHRRf2X+QjyYO
	gcUK3dRhBQbet2v5PL0gZwGLFBQn7ArjrDzSF9qNlUddxNnWCPlRS6/vJoZmkjUW+vQvZnkRm2B
	t18wdN0uApgs3ziF/8TBbsNISeBe6E9I=
X-Gm-Gg: AeBDietwLGfCfESExhxmjvHrlU6Vh86JxIDbz40sIov8XwkxODve/FX4SXqzOOZjOmE
	NEzXeo3YR5gIMId9GZ/+to8tSBT0jRxLi/a4vaHcXo6rNymE9X3N5u0/TtipJykkqrLev7SDARX
	mUNssFNeXO0sMPdB7NGUSJugQFcZhBcfI9i+C/8PkwaH9cFmHRhmb0VAWzaerVumceYZozL3tI1
	DSScJ4uN0oExso2Y7ihARLKJ/GUaccHJnP+oUshE4swZby1ojMnBAGCWcXIIwqV5/I2RluQgA5P
	3u9nNJdCVk8d3ErG+w==
X-Received: by 2002:a17:907:84c8:b0:bb8:fd88:f401 with SMTP id
 a640c23a62f3a-bbffb043992mr251200166b.25.1777840658652; Sun, 03 May 2026
 13:37:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260501232735.2610824-1-souvik@amlalabs.com>
In-Reply-To: <20260501232735.2610824-1-souvik@amlalabs.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sun, 3 May 2026 22:37:27 +0200
X-Gm-Features: AVHnY4IQ3DwkmtwigHf-eOErVpffi8TOS1hCi4QQA1RgX6m_dsBwKEfxps9aVY0
Message-ID: <CAOQ4uxh6YUJEh75sASqi1gOaQYKpWhftz4to1j8s2Y9Jef-XQg@mail.gmail.com>
Subject: Re: [PATCH] ovl: use linked upper dentry in copy-up tmpfile
To: Souvik Banerjee <souvik@amlalabs.com>, Christian Brauner <brauner@kernel.org>
Cc: miklos@szeredi.hu, linux-unionfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: B33BC4B7569
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-242821-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[amir73il@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid,amlalabs.com:email]

On Sat, May 2, 2026 at 1:27=E2=80=AFAM Souvik Banerjee <souvik@amlalabs.com=
> wrote:
>
> ovl_copy_up_tmpfile() stores the disconnected O_TMPFILE dentry as the
> overlay's upper dentry reference via ovl_inode_update().  vfs_tmpfile()
> allocated this dentry via d_alloc(parentpath->dentry, &slash_name), so
> d_name is "/" and d_parent is c->workdir.  Local upper filesystems
> (ext4, btrfs, xfs, ...) immediately rename it to "#<inum>" via
> d_mark_tmpfile() inside their ->tmpfile() op; FUSE and virtiofs do
> not, so both fields stay that way.  Neither identifies the destination
> directory and filename where ovl_do_link() actually linked the file.
>
> When the upper filesystem implements ->d_revalidate() (e.g. FUSE or
> virtiofs), ovl_revalidate_real() calls it with the dentry's parent
> inode and a snapshot of d_name.  The server tries to look up "/" inside
> c->workdir, fails, and overlayfs reports -ESTALE.
>
> This causes persistent ESTALE errors for any file that was copied up via
> the tmpfile path, breaking dpkg, apt, and other tools that do
> rename-over-existing on overlayfs with a FUSE/virtiofs upper.
>
> Before commit 6b52243f633e ("ovl: fold copy-up helpers into callers"),
> the tmpfile copy-up path used a dedicated helper ovl_link_tmpfile()
> that captured the linked destination dentry returned by ovl_do_link():
>
>     err =3D ovl_do_link(temp, udir, upper);
>     ...
>     if (!err)
>         *newdentry =3D dget(upper);
>
> and published it via ovl_inode_update(d_inode(c->dentry), newdentry).
> The fold inlined ovl_do_link() into ovl_copy_up_tmpfile() but dropped
> the dget(upper) capture, and rewrote the publish line as
> ovl_inode_update(d_inode(c->dentry), dget(temp)) =E2=80=94 where temp is =
the
> disconnected O_TMPFILE dentry.
>
> Fix by keeping a reference to the linked destination dentry after
> ovl_do_link() succeeds, and publishing that dentry at the existing
> ovl_inode_update() call site.  The non-tmpfile/workdir path continues to
> publish the renamed temporary dentry.
>
> Reproducer:
>   - Mount overlayfs with virtiofs (or a FUSE fs whose server advertises
>     FUSE_TMPFILE) as upper
>   - Run: dpkg -i <any .deb>
>   - Observe: "error installing new file '...': Stale file handle"
>
> Fixes: 6b52243f633e ("ovl: fold copy-up helpers into callers")
> Cc: stable@vger.kernel.org # v4.20+
> Signed-off-by: Souvik Banerjee <souvik@amlalabs.com>
> ---
>  fs/overlayfs/copy_up.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
> index 13cb60b52bd6..e963701b4c87 100644
> --- a/fs/overlayfs/copy_up.c
> +++ b/fs/overlayfs/copy_up.c
> @@ -853,7 +853,7 @@ static int ovl_copy_up_tmpfile(struct ovl_copy_up_ctx=
 *c)
>  {
>         struct ovl_fs *ofs =3D OVL_FS(c->dentry->d_sb);
>         struct inode *udir =3D d_inode(c->destdir);
> -       struct dentry *temp, *upper;
> +       struct dentry *temp, *upper, *newdentry =3D NULL;
>         struct file *tmpfile;
>         int err;
>
> @@ -889,6 +889,14 @@ static int ovl_copy_up_tmpfile(struct ovl_copy_up_ct=
x *c)
>         err =3D PTR_ERR(upper);
>         if (!IS_ERR(upper)) {
>                 err =3D ovl_do_link(ofs, temp, udir, upper);
> +               if (!err) {
> +                       /*
> +                        * Record the linked dentry -- not the disconnect=
ed
> +                        * O_TMPFILE dentry -- so that ->d_revalidate() o=
n
> +                        * the upper fs sees the real parent/name.
> +                        */
> +                       newdentry =3D dget(upper);
> +               }
>                 end_creating(upper);
>         }
>
> @@ -903,7 +911,7 @@ static int ovl_copy_up_tmpfile(struct ovl_copy_up_ctx=
 *c)
>
>         if (!c->metacopy)
>                 ovl_set_upperdata(d_inode(c->dentry));
> -       ovl_inode_update(d_inode(c->dentry), dget(temp));
> +       ovl_inode_update(d_inode(c->dentry), newdentry);
>
>  out:
>         ovl_end_write(c->dentry);
> --
> 2.51.1
>


Hi Souvik,

Thank you for the analysis and the fix.
Looks correct to me.

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

Christian,

Could you pick this up for vfs-fixes?
I do not have any other ovl fixes queued up.

Thanks,
Amir.

