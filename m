Return-Path: <stable+bounces-242244-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yEWeNaxr9GkoBQIAu9opvQ
	(envelope-from <stable+bounces-242244-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 11:00:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 410F94AB265
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 11:00:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 931E8301C116
	for <lists+stable@lfdr.de>; Fri,  1 May 2026 09:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6AE1378D7F;
	Fri,  1 May 2026 09:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IGgDNO1A"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2FFC377EBC
	for <stable@vger.kernel.org>; Fri,  1 May 2026 09:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777626024; cv=pass; b=cyRGYN9tRYIm/AMBU7HwzSeZcdQzOSPbaCQPkbhBzKsvnaJZQ0WZVUQim18b/8EerXqGmmUHDbYfXq28yh7BYv7/MZqDxPPlX5qVNi509r2MCJ+tM/QJZyQa7+wrKUzElB9I0+I71R+w+e2MNEdO8J3rkVvMzc1XydIIdQIRI9Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777626024; c=relaxed/simple;
	bh=rMNKaelWNJ8TacIzkrZFc0W8S9f8+e3TIJL1mwoKk7g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RBA1uLsvJ/yRcZ/CQxROiMTq5pUX2Gq2U8+KLlnFs/ITMHDkNvOyZ+WtsFCK65980eJk7vIYf/6jOWRmhNlPKTkaF0zsNKsNiLC46SYyUd8oPPNqUz0P6xIgnZI1+U8QkGOWnuYEzjRO9owTFVaObouVWbkgLKTsh2A3USfi4Jk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IGgDNO1A; arc=pass smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-677f7c29af6so3275292a12.2
        for <stable@vger.kernel.org>; Fri, 01 May 2026 02:00:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777626021; cv=none;
        d=google.com; s=arc-20240605;
        b=aROpVUODqpjCslhnW+yyXP1LnH0qNoU/Uu4X3nP4mHahD6Op+hx7sDqblJdR7QQVlW
         K0p2HHM4nYPZAIBsLTHR4f/BAFIOBTUS5gtP3Yzzr+obUycBiaLmvu+0jRCBCJ44qAzA
         z0CbE/oMRAOLtJGuHs8xFCA4oy3yhchVNEF/XDzXOTqeO2KZYakFrTmbAFRCSeGA6kG2
         MD+82+lSx/rJnlrOkmJds5uZ06PNYU3uIm/a6RjynHyVAgo15zSxPPEPxUtE3u2PUFfs
         FIqnTLEPriCCQ/sGSf3j3ZJPxckIWKdNFBUHzbWXt2MfS30KR4oj9LJe5rvkr+VkUI7y
         KIpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2DNZL79JSBv3IL0MAKYq+jXCJbajoFW7/zvPIXUOZm4=;
        fh=DkofwfYNRnTDd0HAVUIbyDvE7+NO+FIUeWO7HyzA3zQ=;
        b=W5aRhtUqYXrqveYesVoYHbK9tx5wl37V4nNmt1/RDHHMIJKqrUCkv3D674BAKfRBTg
         pPKycZ/Vm3iS9letYgEp9/RuuD91YDuq9RgxKy0zHtCECmjbvZGPWc651RWraZ7Jv8E6
         00/zhqWEBGQeyU/f5Qcda7UNA/wZ9ApoTSWShwBmsmRt03o329iTEDc5iTcSyLgqTWsG
         v5hmH+VjoNGgyHkgUxUMh1R2D44ZJ39ni537NA+6OkzfBuP5dM2xz6ms6DU6DiH8796r
         BeQKjHNN+ldMr0uKQ6Mhfe68cWCcB1K5oHVv8qiUtBm/qiZarbgmgNcuZzliIYjyicrC
         aMcA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777626021; x=1778230821; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2DNZL79JSBv3IL0MAKYq+jXCJbajoFW7/zvPIXUOZm4=;
        b=IGgDNO1A8ftgxfowpPJ69+8kjNh3Aa5/vBE3lE+2JlQ2o60L2ocJLBkq1gdXp1LbnY
         ent5fqGWcyY0sq02OXiumWPb5Fg+syJF5ndKXBokqUAbnmu+15/mocbTtGnItIVq1j41
         SGRzx2t/S2YIKldX6BWtxIsXXCO2KaLPWFn8xJAl/qjR9vX3fuGXjf+beXo7BIH6FOOZ
         kcvWmMivpPOqipUkgqDBoLcOCsAnLCN12mZAlS7lrXhrOpQ22ID9A4uGivMImE6SZYB/
         Nsrti1RFU19Wz3of+iHYiO0TnXzKjX1D/Fj6S7CCt1yEcPxi9ygzw7zQa1SHUKw7DKJu
         XOHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777626021; x=1778230821;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2DNZL79JSBv3IL0MAKYq+jXCJbajoFW7/zvPIXUOZm4=;
        b=qZF2LBLo0jEwpDdjhXMCpNHl0etqFK5+BaoMgG34O5ozeI8+auFdc3gJk2mlIiE8Kz
         lrI1o+7J8dVjdOuxBT2dgB7uMDcsUyt+QaDyHASg62rVoVGDMUfMHy0LRH454U4Rakbh
         LoofFU5LT6fETDhTCkiKpSo6EvYTM+O9mKW6a7kb5X04yrI+VGdaY70Pmv5AZYZ1WsOd
         uQVJXIDmM6+yhTpuxnhcGRC9hKnnxgamg0UOMMzhjX61OJJvInBZVeC9D9J3qNCTLNsl
         HNnlO5AdXNruvk1CT2co0fqNpvKoxOv0iWPuL2kE9KzkuUQn49uXmLADWhFRuFeR5oSh
         pJgw==
X-Forwarded-Encrypted: i=1; AFNElJ/or1C/mhajv63Bt1AKDrPBvAamsytO8Z+8NZKKGL8ML4mfptbWLWAIDKve3ARVLSKnnB71C90=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPCsbtecIIf99+KiiuIBOMoQ2i/t4dKJAFDN1WTDCzfwde0d4E
	JEMw299J3ycqup2lQpYqCvyx6eO420qU3IW2abGr3ctKyTAiCxi+4CJu1oF27GyEdcv5qf8RSpE
	azKfG8Qil3JHdnaFCLO3VpGQDitwSaZs=
X-Gm-Gg: AeBDieslknKNo/eYkmh4h3bq3UmpIb+Dnn7PSTc9Sb2oi23ZjaHWrhWp/bSGXaA/07f
	7jjVLmii4k2I7g/Hnr8GeRxQrJTFWAoa37K8r+UjRoRMIwQD7eymAYjPxG8oK1/ceeaoh7Jp3Cb
	f3dJUrhrw/iUBrpIW7GmpjMzwjIA3YPqk4McFAlXUEQK+SCr9zBTBlGKbcIf7YwWBSVWrgofp9H
	1nZAsY8kZgO9s2Zp3wsU4K4RPFzj5+ho1xq/qN5ZzPmPCBe974kPtKuDOAubp81XL0a5Cegdp4J
	o9IXt1cvtt4wxG5N
X-Received: by 2002:a17:907:26c9:b0:bae:d29c:4e28 with SMTP id
 a640c23a62f3a-bbac4cd2331mr403876166b.12.1777626020162; Fri, 01 May 2026
 02:00:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260428160804.281745-1-sprasad@microsoft.com>
 <20260428160804.281745-3-sprasad@microsoft.com> <d43b1d1023d13746819a780f65da9341@manguebit.org>
In-Reply-To: <d43b1d1023d13746819a780f65da9341@manguebit.org>
From: Shyam Prasad N <nspmangalore@gmail.com>
Date: Fri, 1 May 2026 14:30:08 +0530
X-Gm-Features: AVHnY4IOoNnpCXPfdkS6WxhMvsIxS21lj0SdS3Rdi0XAOv0tNaGt6C4zzPChomg
Message-ID: <CANT5p=rMDk9nGPVeU8hKV6SUNWOo_kkL1uoRiOd845AEowgYyA@mail.gmail.com>
Subject: Re: [PATCH v3 03/19] cifs: invalidate cfid on unlink/rename/rmdir
To: Paulo Alcantara <pc@manguebit.org>
Cc: linux-cifs@vger.kernel.org, smfrench@gmail.com, bharathsm@microsoft.com, 
	dhowells@redhat.com, henrique.carvalho@suse.com, ematsumiya@suse.de, 
	Shyam Prasad N <sprasad@microsoft.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 410F94AB265
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-242244-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,microsoft.com,redhat.com,suse.com,suse.de];
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
	FROM_NEQ_ENVFROM(0.00)[nspmangalore@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,manguebit.org:email]

On Tue, Apr 28, 2026 at 10:58=E2=80=AFPM Paulo Alcantara <pc@manguebit.org>=
 wrote:
>
> nspmangalore@gmail.com writes:
>
> > From: Shyam Prasad N <sprasad@microsoft.com>
> >
> > Today we do not invalidate the cached_dirent or the entire
> > parent cfid when a dentry in a dir has been removed/moved.
> >
> > This change invalidates the parent cfid so that we don't serve
> > directory contents from the cache.
> >
> > Cc: <stable@vger.kernel.org>
> > Signed-off-by: Shyam Prasad N <sprasad@microsoft.com>
> > ---
> >  fs/smb/client/inode.c | 40 ++++++++++++++++++++++++++++++++++++++--
> >  1 file changed, 38 insertions(+), 2 deletions(-)
> >
> > diff --git a/fs/smb/client/inode.c b/fs/smb/client/inode.c
> > index 888f9e35f14b8..e077df844c819 100644
> > --- a/fs/smb/client/inode.c
> > +++ b/fs/smb/client/inode.c
> > @@ -28,6 +28,23 @@
> >  #include "cached_dir.h"
> >  #include "reparse.h"
> >
> > +static void cifs_invalidate_cached_dir(struct cifs_tcon *tcon,
> > +                                    struct dentry *parent)
> > +{
> > +     struct cached_fid *parent_cfid =3D NULL;
> > +
> > +     if (!tcon || !parent)
> > +             return;
>
> The NULL check for @tcon is unnecessary.  This seems to be called only
> with a valid @tcon.
>
Hi Paulo,
Thanks for the review.
I would let the null check be. For future callers who may miss the check.
> > +
> > +     if (!open_cached_dir_by_dentry(tcon, parent, &parent_cfid)) {
> > +             mutex_lock(&parent_cfid->dirents.de_mutex);
> > +             parent_cfid->dirents.is_valid =3D false;
> > +             parent_cfid->dirents.is_failed =3D true;
> > +             mutex_unlock(&parent_cfid->dirents.de_mutex);
> > +             close_cached_dir(parent_cfid);
> > +     }
> > +}
> > +
> >  /*
> >   * Set parameters for the netfs library
> >   */
> > @@ -322,7 +339,7 @@ cifs_unix_basic_to_fattr(struct cifs_fattr *fattr, =
FILE_UNIX_BASIC_INFO *info,
> >                               fattr->cf_uid =3D uid;
> >               }
> >       }
> > -
> > +
>
> Why are you adding a blank newline?
Looks like an empty line with a tab was removed. Will add back the tab.
>
> >       fattr->cf_gid =3D cifs_sb->ctx->linux_gid;
> >       if (!(sbflags & CIFS_MOUNT_OVERR_GID)) {
> >               u64 id =3D le64_to_cpu(info->Gid);
> > @@ -2067,6 +2084,9 @@ static int __cifs_unlink(struct inode *dir, struc=
t dentry *dentry, bool sillyren
> >               cifs_set_file_info(inode, attrs, xid, full_path, origattr=
);
> >
> >  out_reval:
> > +     if (!rc && dentry->d_parent)
> > +             cifs_invalidate_cached_dir(tcon, dentry->d_parent);
>
> The non-NULL check of @dentry->d_parent is unnecessary.
> cifs_invalidate_cached_dir() already handles it.
Will do this change.
>
> > +
> >       if (inode) {
> >               cifs_inode =3D CIFS_I(inode);
> >               cifs_inode->time =3D 0;   /* will force revalidate to get=
 info
> > @@ -2378,7 +2398,6 @@ int cifs_rmdir(struct inode *inode, struct dentry=
 *direntry)
> >       }
> >
> >       rc =3D server->ops->rmdir(xid, tcon, full_path, cifs_sb);
> > -     cifs_put_tlink(tlink);
> >
> >       cifsInode =3D CIFS_I(d_inode(direntry));
> >
> > @@ -2388,6 +2407,8 @@ int cifs_rmdir(struct inode *inode, struct dentry=
 *direntry)
> >               i_size_write(d_inode(direntry), 0);
> >               clear_nlink(d_inode(direntry));
> >               spin_unlock(&d_inode(direntry)->i_lock);
> > +             if (direntry->d_parent)
> > +                     cifs_invalidate_cached_dir(tcon, direntry->d_pare=
nt);
>
> Ditto.
>
> >       }
> >
> >       /* force revalidate to go get info when needed */
> > @@ -2402,6 +2423,7 @@ int cifs_rmdir(struct inode *inode, struct dentry=
 *direntry)
> >
> >       inode_set_ctime_current(d_inode(direntry));
> >       inode_set_mtime_to_ts(inode, inode_set_ctime_current(inode));
> > +     cifs_put_tlink(tlink);
> >
> >  rmdir_exit:
> >       free_dentry_path(page);
> > @@ -2501,6 +2523,8 @@ cifs_rename2(struct mnt_idmap *idmap, struct inod=
e *source_dir,
> >       struct cifs_sb_info *cifs_sb;
> >       struct tcon_link *tlink;
> >       struct cifs_tcon *tcon;
> > +     struct dentry *source_parent;
> > +     struct dentry *target_parent;
> >       bool rehash =3D false;
> >       unsigned int xid;
> >       int rc, tmprc;
> > @@ -2532,6 +2556,8 @@ cifs_rename2(struct mnt_idmap *idmap, struct inod=
e *source_dir,
> >       if (IS_ERR(tlink))
> >               return PTR_ERR(tlink);
> >       tcon =3D tlink_tcon(tlink);
> > +     source_parent =3D source_dentry->d_parent ? dget(source_dentry->d=
_parent) : NULL;
> > +     target_parent =3D target_dentry->d_parent ? dget(target_dentry->d=
_parent) : NULL;
>
> Why do you need to dget() ->d_parent?
Good point. Considering this is a rename callback, I think this dget
on parent is redundant. Will fix it.
>
> >       server =3D tcon->ses->server;
> >
> >       page1 =3D alloc_dentry_path();
> > @@ -2668,11 +2694,21 @@ cifs_rename2(struct mnt_idmap *idmap, struct in=
ode *source_dir,
> >       }
> >
> >       /* force revalidate to go get info when needed */
> > +     if (!rc) {
> > +             cifs_invalidate_cached_dir(tcon, source_parent);
> > +             if (target_parent !=3D source_parent)
> > +                     cifs_invalidate_cached_dir(tcon, target_parent);
> > +     }
> > +
> >       CIFS_I(source_dir)->time =3D CIFS_I(target_dir)->time =3D 0;
> >
> >  cifs_rename_exit:
> >       if (rehash)
> >               d_rehash(target_dentry);
> > +     if (target_parent)
> > +             dput(target_parent);
> > +     if (source_parent)
> > +             dput(source_parent);
>
> The non-NULL checks are unnecessary.  dput() already handles NULL
> dentries.



--=20
Regards,
Shyam

