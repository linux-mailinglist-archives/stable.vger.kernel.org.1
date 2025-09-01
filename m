Return-Path: <stable+bounces-176888-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D038B3EB79
	for <lists+stable@lfdr.de>; Mon,  1 Sep 2025 17:51:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D12B7A8C8C
	for <lists+stable@lfdr.de>; Mon,  1 Sep 2025 15:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F94332F760;
	Mon,  1 Sep 2025 15:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WYSPr4Uj"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E5981DEFE8
	for <stable@vger.kernel.org>; Mon,  1 Sep 2025 15:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756741908; cv=none; b=shWyiTT5dpXKMP6hQup+5lnD6rEM31BaXfQF3LdP5rALDZ1/DOOntdiJ4nZU0bCK37VlR6usXrBDXx3Unevc/oYMe9X0uEpVhMeo9fmMUnnljq13vLXjHAiLjbodqUxVoaQiMtXYXNaBR4I8MXhFWQEtqRpUfZBBu1CDBhuhv5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756741908; c=relaxed/simple;
	bh=/jLC13p1UfHX/Jun6DFb6+nQkt41NAZpmU+QfmuYwYk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uMf7laG+j0vjdN+1evcoxWBNsnzeM3OzZZttRowrmozOHwpxt+HiGSpCBD/DTenh7U20L1JB8xBvV7B+QganNVrercDah9ztgEcr6dubi/WsGSU/udnPk2PZF5GPCfxUNoEqaGVTg3yi4FWjBhSzfjzL3/Ph840HyFzdlSldrhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WYSPr4Uj; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-61e8fdfd9b4so2530124a12.1
        for <stable@vger.kernel.org>; Mon, 01 Sep 2025 08:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756741905; x=1757346705; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lgE2BW3tdEH4mYdXv2PHYAbIA1sC1sxuDVStuycYb3I=;
        b=WYSPr4UjPRgtlmf86/knh9zRCM6Qrdx7zjJtTfmYDSb2rFYlyPvjxaozyBruhHYu4U
         KrbOz6W0Hdv6eXu9BXhsxFSQj9V0pHRk1dRmXRe9BrgD6Grc9NhTXXRaSzZqt9YzJ2t4
         j98qzgSCW/JQdmWqLFuBnngc9ppzJLmKypsovwjsNKgHkAv5JcuRcqGPm5NxRC/aKtQ1
         sJ3Sxv2FxzWR2sUa2MJey/JL0Mz3aOvP91RimXec9a+URuD7uI6P6/GxtOF2Lwi0DJAo
         UZvs+G4q93OLMSQ/M1jbXgAx2ru8mV4bR5QkM11ItXhCpz+omMfnG9WvYxY05tcong7C
         zmJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756741905; x=1757346705;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lgE2BW3tdEH4mYdXv2PHYAbIA1sC1sxuDVStuycYb3I=;
        b=gtWHBjVScrCvd9r0MGidorEf7zHUb5NNuDKCldm5tFXcmr6X6Ksey7W5WABa15uQni
         MsBF/M62miPjanj5yYHYjV+yFo+45oz/NsXDs0A8nqnA57BXW+VSZAJsb1jRtt4zvXxw
         A2QAcPr1h3chfatY6v6JAPrPySBHOg7N/4ttkWv1RpU1gE8LucFCpg/QRPReqX2EgnaZ
         9jQsuGb9is6aJ8gI2+daH2/tYawtU9n5QS5kYsLfjH6amyWA9li9yDlS1SPtLDQ3y1sS
         nymiMSbpxz1WJ4XK6iHz4SMAUnNA2KhqRxSShjZ6H5k5j+FCA4ibEs4pUYNBTCdRj6dJ
         7SOA==
X-Gm-Message-State: AOJu0YygKd9K9ZVJVuw4rlEHSP+apXPVXz8GbDFZ6EMJy2t/bhx9TMm1
	7qonmz43YV3Fms752sApragaTrX3yGHe9xpgcUGhyMNt7LpuGYrwroDguu7nQJJ7tAPCakEqHab
	2vA3/Z9bNmHPJoLwT/tW78XKPtjI3zEPOUcB8Q54=
X-Gm-Gg: ASbGncvy1/zNNOX0xyUguNBdiakmY7ZlejzbX9QCwaM/YZ7qO35gTOD/au5SIy3nVJ7
	z2/9IPCWuY88T6Qk/5krVKgqy9W4VbqVIuf3Zdo9e1C6qVVAKnyu7MUiu0xiFgZvM7iMt9YO7Oq
	RwcU1uenu9VKapBO7sVkUFiJaAM79U4+Pkqz2MMc8Y+081hvAWqhRIzYpFSyIxXaxKbeWXdgkrq
	KfbHT8=
X-Google-Smtp-Source: AGHT+IE/CJml4v9U2XujhECEp3ReQaPIYyIn0R4gwlu6Y/3O2jiJLEt/yXnA0EZbQNW4EkFNio2CDhil5HayK/TIiIw=
X-Received: by 2002:a05:6402:24da:b0:61c:c9f0:643b with SMTP id
 4fb4d7f45d1cf-61d229beaeamr6731428a12.0.1756741904396; Mon, 01 Sep 2025
 08:51:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2025011112-racing-handbrake-a317@gregkh> <20250901153559.14799-1-nmanthey@amazon.de>
 <20250901153559.14799-2-nmanthey@amazon.de>
In-Reply-To: <20250901153559.14799-2-nmanthey@amazon.de>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 1 Sep 2025 17:51:31 +0200
X-Gm-Features: Ac12FXxtA9y_BFOuPysgaJP4JuNik4ldDyun0wrbpawvWOAiSemrEIqe2yg7O94
Message-ID: <CAOQ4uxh=MZdcbPQ7VOit33rTgSRkPnpZdQ0ZnyQFjmiDGb-ahw@mail.gmail.com>
Subject: Re: [PATCH 6.1.y 1/1] fs: relax assertions on failure to encode file handles
To: Norbert Manthey <nmanthey@amazon.de>
Cc: stable@vger.kernel.org, 
	syzbot+ec07f6f5ce62b858579f@syzkaller.appspotmail.com, 
	Dmitry Safonov <dima@arista.com>, Christian Brauner <brauner@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?UTF-8?B?w5ZtZXIgRXJkaW7DpyBZYcSfbXVybHU=?= <oeygmrl@amazon.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 1, 2025 at 5:36=E2=80=AFPM Norbert Manthey <nmanthey@amazon.de>=
 wrote:
>
> From: Amir Goldstein <amir73il@gmail.com>
>
> commit 974e3fe0ac61de85015bbe5a4990cf4127b304b2 upstream.
>
> Encoding file handles is usually performed by a filesystem >encode_fh()
> method that may fail for various reasons.
>
> The legacy users of exportfs_encode_fh(), namely, nfsd and
> name_to_handle_at(2) syscall are ready to cope with the possibility
> of failure to encode a file handle.
>
> There are a few other users of exportfs_encode_{fh,fid}() that
> currently have a WARN_ON() assertion when ->encode_fh() fails.
> Relax those assertions because they are wrong.
>
> The second linked bug report states commit 16aac5ad1fa9 ("ovl: support
> encoding non-decodable file handles") in v6.6 as the regressing commit,
> but this is not accurate.
>
> The aforementioned commit only increases the chances of the assertion
> and allows triggering the assertion with the reproducer using overlayfs,
> inotify and drop_caches.
>
> Triggering this assertion was always possible with other filesystems and
> other reasons of ->encode_fh() failures and more particularly, it was
> also possible with the exact same reproducer using overlayfs that is
> mounted with options index=3Don,nfs_export=3Don also on kernels < v6.6.
> Therefore, I am not listing the aforementioned commit as a Fixes commit.
>
> Backport hint: this patch will have a trivial conflict applying to
> v6.6.y, and other trivial conflicts applying to stable kernels < v6.6.
>
> Reported-by: syzbot+ec07f6f5ce62b858579f@syzkaller.appspotmail.com
> Tested-by: syzbot+ec07f6f5ce62b858579f@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/linux-unionfs/671fd40c.050a0220.4735a.024=
f.GAE@google.com/
> Reported-by: Dmitry Safonov <dima@arista.com>
> Closes: https://lore.kernel.org/linux-fsdevel/CAGrbwDTLt6drB9eaUagnQVgdPB=
mhLfqqxAf3F+Juqy_o6oP8uw@mail.gmail.com/
> Cc: stable@vger.kernel.org
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> Link: https://lore.kernel.org/r/20241219115301.465396-1-amir73il@gmail.co=
m
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>
> (fuzzy picked from commit f47c834a9131ae64bee3c462f4e610c67b0a000f)
> Applied with LLM-adjusted hunks for 1 functions from us.amazon.nova
> - Changed the function call from `exportfs_encode_fid` to `exportfs_encod=
e_inode_fh` to match the destination code.
> - Removed the warning message as per the patch.
>
> Signed-off-by: Norbert Manthey <nmanthey@amazon.de>
> Tested-by: =C3=96mer Erdin=C3=A7 Ya=C4=9Fmurlu <oeygmrl@amazon.de>
Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> ---
>  fs/notify/fdinfo.c     | 4 +---
>  fs/overlayfs/copy_up.c | 5 ++---
>  2 files changed, 3 insertions(+), 6 deletions(-)
>
> diff --git a/fs/notify/fdinfo.c b/fs/notify/fdinfo.c
> index 55081ae3a6ec0..dd5bc6ffae858 100644
> --- a/fs/notify/fdinfo.c
> +++ b/fs/notify/fdinfo.c
> @@ -51,10 +51,8 @@ static void show_mark_fhandle(struct seq_file *m, stru=
ct inode *inode)
>         size =3D f.handle.handle_bytes >> 2;
>
>         ret =3D exportfs_encode_inode_fh(inode, (struct fid *)f.handle.f_=
handle, &size, NULL);
> -       if ((ret =3D=3D FILEID_INVALID) || (ret < 0)) {
> -               WARN_ONCE(1, "Can't encode file handler for inotify: %d\n=
", ret);
> +       if ((ret =3D=3D FILEID_INVALID) || (ret < 0))
>                 return;
> -       }
>
>         f.handle.handle_type =3D ret;
>         f.handle.handle_bytes =3D size * sizeof(u32);
> diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
> index 203b88293f6bb..ced56696beeb3 100644
> --- a/fs/overlayfs/copy_up.c
> +++ b/fs/overlayfs/copy_up.c
> @@ -361,9 +361,8 @@ struct ovl_fh *ovl_encode_real_fh(struct ovl_fs *ofs,=
 struct dentry *real,
>         buflen =3D (dwords << 2);
>
>         err =3D -EIO;
> -       if (WARN_ON(fh_type < 0) ||
> -           WARN_ON(buflen > MAX_HANDLE_SZ) ||
> -           WARN_ON(fh_type =3D=3D FILEID_INVALID))
> +       if (fh_type < 0 || fh_type =3D=3D FILEID_INVALID ||
> +           WARN_ON(buflen > MAX_HANDLE_SZ))
>                 goto out_err;
>
>         fh->fb.version =3D OVL_FH_VERSION;
> --
> 2.34.1
>
>
>
>
> Amazon Web Services Development Center Germany GmbH
> Tamara-Danz-Str. 13
> 10243 Berlin
> Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
> Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
> Sitz: Berlin
> Ust-ID: DE 365 538 597

