Return-Path: <stable+bounces-238384-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cXBHJeyO4WliuwAAu9opvQ
	(envelope-from <stable+bounces-238384-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 03:37:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 072E541603C
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 03:37:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 231C93012CC8
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 01:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F59B2641FC;
	Fri, 17 Apr 2026 01:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YNO0aZ7B"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1681FC0EA
	for <stable@vger.kernel.org>; Fri, 17 Apr 2026 01:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776389862; cv=pass; b=gtbq1RiS5lqOW6kW7YKty8XduzpiR7XJxRo84N7mT/BVtpw3axhZK/dPOjWlFIwRcU1xFpVPo7yYmsI9t7jD72R/ILFQVVZOA7RnnS3tUFLKsfgdxoxaKfVlueq75wvvUCi/uP3Aa0vsGkAmXORfyjmEPTF0BwGxpRgQcAFdUjo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776389862; c=relaxed/simple;
	bh=c8ZBS+V8jEtDvPVR1JijwtduvD5q8yXfJTgYKDWL6rA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=knYL6doVLjrfMIkWilt+jHWPBdNiMnG9lf5VGs8eqVbOdJh+HrZ8pJM3wS2EzhlXd72l7jHZ5pD21k4x3JQc5b1nwxhfPhdJJmso7sG7Rhjq9UL96VcH0H+kI3a165KIkXzWPyusDuYl3+vjQMddb5YrczPEF7ABvtF7Yl+YWnI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YNO0aZ7B; arc=pass smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-8a068db9989so12215096d6.0
        for <stable@vger.kernel.org>; Thu, 16 Apr 2026 18:37:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776389859; cv=none;
        d=google.com; s=arc-20240605;
        b=KW1ZyOjtjpQ3qLyhpCdme7nCcXet60H3Wnp7t0LltDQqmvp1SFd6dxK201pkzOJdrc
         eZFdeKzdldw6bSChWTyr4/KwpZ2Jk3x9jhKQTmTZXS9aQm5HcQPYxVprNMcerS3x9P60
         H15g1baKX03pKBhec6KDXM82WmupMThvoACHIrrNDvCBLjBRxfqX+HfX9u/vIzN7wKaB
         LfcSuEhZEeSOJuROEnMTJ/rxJjJavS8O1ZKL7Z4RiGlRsztD1BGvpDd5UC2oAz9zZ+bi
         EkAqkZr4e4uZzVz+Pq8Ge1ddDX/rrPm98mY6jys/LHX/u05AJC3ncaF9RSgJfh/BC/yF
         MJUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AdTij6DUQxjWdvtMNHhYJ/o6hImRsree6psuIVyyW6Q=;
        fh=7O3VPS0XRTGlKTbyj+1uwf4yXaNxakEn2Lt1bWDl7bU=;
        b=Ljnx7P7NQHEnBqsymmDQvGkvBJfdGITeMcYe5MMWETymbIApHoUU8mflA+gaL/TKVz
         CXFgZsui0VmpbJck9MG3LHp1GIzSQ//CZuBk0hzAYz4NiEr5KpMbmMURZBKEbs8hzxk+
         amAF8akSbJ8efBQp2eFJ8cGnJtkN18rao/MRgtOxWv6ehmRIL4KnxO05F3dkowAl7T/t
         tpdOr22MoubIz2TFAT3JE0h+qsGzZdHsSuIZ9+86IPEw2q2RURcSos4NO8LswCsgSNhX
         TWTjcAK9uMJjPTZ+B82x/l2J6kRLBkx3V9n2JQB/xzMACyHM+sFD6IYQHf+tyj1F5oBB
         Qtnw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776389859; x=1776994659; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AdTij6DUQxjWdvtMNHhYJ/o6hImRsree6psuIVyyW6Q=;
        b=YNO0aZ7BKl21SLO/YFdlsehEzBtrgzcw4K5vaQwa1Nb3vKnwDpM8anUGliFHnSAc07
         c6fcX4SKo0U+tfvxk+BiG6WoQExLcS1h7Onw9vvXuf9vkOpJD7srYTfdCAT1r17d2WrM
         npIdFOVy7Ql0RLGXalqEPb1sa7mmersHLf9EBF0NDr7gFSy5Q7sOq09q65+fiB0fnHPU
         MaanNS8ciOClCKi3TKOP4N7X+2fvmsiefbWIlt013V7/twPbnx/NlOkYKNXgivjxzDQE
         1L7wR5nICWFPhFeGEpeUPXReoCgjEcGZ/XVepUWmnD/y+ZrMviuV4zpXkoR9ui34NDjx
         64Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776389859; x=1776994659;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AdTij6DUQxjWdvtMNHhYJ/o6hImRsree6psuIVyyW6Q=;
        b=DrQHJTm13obMRvlkKdluYc62p+8OdZ0L5FO/P/fX6Nca7imt/gzntuw9MGNKKjfbsC
         2hN93jPKNt1rOdRlhpmXlHxzykcDyfeGMvKF4RD+kK8+alXzdeOPW7uxHpqSM1D2bLvr
         K+lrYS9CT1iIlmU96LXbxow7eTc+i3QsjcWMDcVDVeqJ/rMYw4IcZMD8PQVIr3UBW6XI
         H0UVUlgsFF3vS5FbIHptb6Zx7KyCSy7xbPQVEgQx2Oogtmjxuy46cKoADxqLNbWPMCwc
         hamZ8S/lpPEgNAr9gZPUKQn6/ESVW4xQpRarmH0CAXxsfe7qZGVmZKpzNIKTtrj3eDSR
         e4Pw==
X-Forwarded-Encrypted: i=1; AFNElJ+T3DDEIBCIUtIOLspNmQyuKm4X0K9G+FBfqk4qlw2Yvph9dlQNOAMzcmjMxffmEgqkT5dvr+g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXwFvT4x/b2yAv61X/QNNjeVlAaQYBRbmoqOiTbsFQ1afJPnPK
	0wQVMFLjIxKqExnUumHDrbE4rKM+RlQTkkKHQRNfKCZIuiMT+nt3Yv6nG+Kro/8JZbxhFvhbd9/
	wR4kHapX5nIEln1UEsVN40s79D/kD5aSObg==
X-Gm-Gg: AeBDiesB+8mailqarTgswj66cldcHgkXEceoeaRj/6ZiLgkXaXqiDq9dRoAkNkyRmcF
	QwtweJKT7XSUqbl+IGrivP7/E6ZfP/gSM3as1ae8GjtEbNNZYVqLugmoaxKrkV8/PaKlXMik9+Z
	ueWE/XFteXf0wXVyiiHnUwR9o41oYuUzwzfJtsY15s/NSz5jPAt/Ivg2pzpgxjTXDNnBbhrLujt
	0XS84tIBceelxr4/tYecTi+CPe1phObmogAq+sMO8cuy3x03lkhVj/oOwxT5cjqukYaWMePYnx5
	7wpokaIT/rGVQo2DiKADtm3k6zerTNrp+WHlbaOxwl3qdTrZdhYaH7G24wgxqeKBJLUMFhgIj2I
	3XYwb6WoqCqtczdWRaMfuWbp7I7itvRNj02GMctSRolbVxoFNveZxVtnYpcfoS6CRvYxwrtrVZS
	Jjm2Wn5N8zrwOOXZDNS7mWBWPT6mM1vWc=
X-Received: by 2002:a05:6214:459d:b0:8ac:dd87:b5b2 with SMTP id
 6a1803df08f44-8b028449ed8mr12457736d6.11.1776389859572; Thu, 16 Apr 2026
 18:37:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260417001550.1301260-1-pc@manguebit.org>
In-Reply-To: <20260417001550.1301260-1-pc@manguebit.org>
From: Steve French <smfrench@gmail.com>
Date: Thu, 16 Apr 2026 20:37:26 -0500
X-Gm-Features: AQROBzA7pmGYPnGr8dfpwgDqbhVLgCR2YE9UKmwwY9P7HtfxqYl92b86f-VG8E4
Message-ID: <CAH2r5muqeJnStj+0GYJxy-TbaKB4k+zrJraYKobHFUCb0W0caA@mail.gmail.com>
Subject: Re: [PATCH] smb: client: fix dir separator in SMB1 UNIX mounts
To: Paulo Alcantara <pc@manguebit.org>
Cc: "Kris Karas (Bug Reporting)" <bugs-a21@moonlit-rail.com>, David Howells <dhowells@redhat.com>, 
	linux-cifs@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-238384-lists,stable=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[smfrench@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[moonlit-rail.com:email,mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,manguebit.org:email]
X-Rspamd-Queue-Id: 072E541603C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

merged into cifs-2.6.git for-next

On Thu, Apr 16, 2026 at 7:15=E2=80=AFPM Paulo Alcantara <pc@manguebit.org> =
wrote:
>
> When calling cifs_mount_get_tcon() with SMB1 UNIX mounts,
> @cifs_sb->mnt_cifs_flags needs to be read or updated only after
> calling reset_cifs_unix_caps(), otherwise it might end up with missing
> CIFS_MOUNT_POSIXACL and CIFS_MOUNT_POSIX_PATHS bits.
>
> This fixes the wrong dir separator used in paths caused by the missing
> CIFS_MOUNT_POSIX_PATHS bit in cifs_sb_info::mnt_cifs_flags.
>
> Reported-by: "Kris Karas (Bug Reporting)" <bugs-a21@moonlit-rail.com>
> Closes: https://lore.kernel.org/r/f758f4ff-4d54-4244-931d-38f469c3ff14@mo=
onlit-rail.com
> Fixes: 4fc3a433c139 ("smb: client: use atomic_t for mnt_cifs_flags")
> Signed-off-by: Paulo Alcantara (Red Hat) <pc@manguebit.org>
> Cc: David Howells <dhowells@redhat.com>
> Cc: linux-cifs@vger.kernel.org
> Cc: stable@vger.kernel.org
> ---
>  fs/smb/client/connect.c | 10 +++++-----
>  fs/smb/client/smb1ops.c | 19 ++++++++-----------
>  2 files changed, 13 insertions(+), 16 deletions(-)
>
> diff --git a/fs/smb/client/connect.c b/fs/smb/client/connect.c
> index 69b38f0ccf2b..e9eeb9f8a561 100644
> --- a/fs/smb/client/connect.c
> +++ b/fs/smb/client/connect.c
> @@ -3610,7 +3610,6 @@ int cifs_mount_get_tcon(struct cifs_mount_ctx *mnt_=
ctx)
>         server =3D mnt_ctx->server;
>         ctx =3D mnt_ctx->fs_ctx;
>         cifs_sb =3D mnt_ctx->cifs_sb;
> -       sbflags =3D cifs_sb_flags(cifs_sb);
>
>         /* search for existing tcon to this server share */
>         tcon =3D cifs_get_tcon(mnt_ctx->ses, ctx);
> @@ -3625,9 +3624,10 @@ int cifs_mount_get_tcon(struct cifs_mount_ctx *mnt=
_ctx)
>          * path (i.e., do not remap / and \ and do not map any special ch=
aracters)
>          */
>         if (tcon->posix_extensions) {
> -               sbflags |=3D CIFS_MOUNT_POSIX_PATHS;
> -               sbflags &=3D ~(CIFS_MOUNT_MAP_SFM_CHR |
> -                            CIFS_MOUNT_MAP_SPECIAL_CHR);
> +               atomic_or(CIFS_MOUNT_POSIX_PATHS, &cifs_sb->mnt_cifs_flag=
s);
> +               atomic_andnot(CIFS_MOUNT_MAP_SFM_CHR |
> +                             CIFS_MOUNT_MAP_SPECIAL_CHR,
> +                             &cifs_sb->mnt_cifs_flags);
>         }
>
>  #ifdef CONFIG_CIFS_ALLOW_INSECURE_LEGACY
> @@ -3651,6 +3651,7 @@ int cifs_mount_get_tcon(struct cifs_mount_ctx *mnt_=
ctx)
>  #endif /* CONFIG_CIFS_ALLOW_INSECURE_LEGACY */
>                 tcon->unix_ext =3D 0; /* server does not support them */
>
> +       sbflags =3D cifs_sb_flags(cifs_sb);
>         /* do not care if a following call succeed - informational */
>         if (!tcon->pipe && server->ops->qfs_tcon) {
>                 server->ops->qfs_tcon(mnt_ctx->xid, tcon, cifs_sb);
> @@ -3675,7 +3676,6 @@ int cifs_mount_get_tcon(struct cifs_mount_ctx *mnt_=
ctx)
>
>  out:
>         mnt_ctx->tcon =3D tcon;
> -       atomic_set(&cifs_sb->mnt_cifs_flags, sbflags);
>         return rc;
>  }
>
> diff --git a/fs/smb/client/smb1ops.c b/fs/smb/client/smb1ops.c
> index 9694117050a6..e198e3dda917 100644
> --- a/fs/smb/client/smb1ops.c
> +++ b/fs/smb/client/smb1ops.c
> @@ -49,7 +49,6 @@ void reset_cifs_unix_caps(unsigned int xid, struct cifs=
_tcon *tcon,
>
>         if (!CIFSSMBQFSUnixInfo(xid, tcon)) {
>                 __u64 cap =3D le64_to_cpu(tcon->fsUnixInfo.Capability);
> -               unsigned int sbflags;
>
>                 cifs_dbg(FYI, "unix caps which server supports %lld\n", c=
ap);
>                 /*
> @@ -76,29 +75,27 @@ void reset_cifs_unix_caps(unsigned int xid, struct ci=
fs_tcon *tcon,
>                 if (cap & CIFS_UNIX_TRANSPORT_ENCRYPTION_MANDATORY_CAP)
>                         cifs_dbg(VFS, "per-share encryption not supported=
 yet\n");
>
> -               if (cifs_sb)
> -                       sbflags =3D cifs_sb_flags(cifs_sb);
> -
>                 cap &=3D CIFS_UNIX_CAP_MASK;
>                 if (ctx && ctx->no_psx_acl)
>                         cap &=3D ~CIFS_UNIX_POSIX_ACL_CAP;
>                 else if (CIFS_UNIX_POSIX_ACL_CAP & cap) {
>                         cifs_dbg(FYI, "negotiated posix acl support\n");
> -                       if (cifs_sb)
> -                               sbflags |=3D CIFS_MOUNT_POSIXACL;
> +                       if (cifs_sb) {
> +                               atomic_or(CIFS_MOUNT_POSIXACL,
> +                                         &cifs_sb->mnt_cifs_flags);
> +                       }
>                 }
>
>                 if (ctx && ctx->posix_paths =3D=3D 0)
>                         cap &=3D ~CIFS_UNIX_POSIX_PATHNAMES_CAP;
>                 else if (cap & CIFS_UNIX_POSIX_PATHNAMES_CAP) {
>                         cifs_dbg(FYI, "negotiate posix pathnames\n");
> -                       if (cifs_sb)
> -                               sbflags |=3D CIFS_MOUNT_POSIX_PATHS;
> +                       if (cifs_sb) {
> +                               atomic_or(CIFS_MOUNT_POSIX_PATHS,
> +                                         &cifs_sb->mnt_cifs_flags);
> +                       }
>                 }
>
> -               if (cifs_sb)
> -                       atomic_set(&cifs_sb->mnt_cifs_flags, sbflags);
> -
>                 cifs_dbg(FYI, "Negotiate caps 0x%x\n", (int)cap);
>  #ifdef CONFIG_CIFS_DEBUG2
>                 if (cap & CIFS_UNIX_FCNTL_CAP)
> --
> 2.53.0
>


--=20
Thanks,

Steve

