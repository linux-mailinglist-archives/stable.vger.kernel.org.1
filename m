Return-Path: <stable+bounces-69600-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4C94956DCC
	for <lists+stable@lfdr.de>; Mon, 19 Aug 2024 16:47:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 154301C23088
	for <lists+stable@lfdr.de>; Mon, 19 Aug 2024 14:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2623E16C6A9;
	Mon, 19 Aug 2024 14:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sv9yp3pV"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E68C1BDCF
	for <stable@vger.kernel.org>; Mon, 19 Aug 2024 14:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724078844; cv=none; b=MKEFHD7nl+qW7jTkmCbA70Lr3vPIhVV3tT+GtOM/YmvRrM1dKbXLT+ujo1tfm7vS5h16YaIHCdCXBH+A7ZSWlEOmwgH+246UTXNfpQ6EgnfDr+2qxdK3hYKiSjmzlY/VxtpHQV4UwE0m0Bi+V1zpV0XGnCfrFpsJ62IEHer2JwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724078844; c=relaxed/simple;
	bh=LNWJB2QBA6KMPjATkJ4SgTGYhAcgrGcClYZNgtavaRQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PmTe2SWvLxlgKThtlRPRXef9Pgnzux6qqLILhN9Rxn9L20SM4fLAPpGNsdzOaltfqreF/w+1e6ACQL+tz+ItLqEpTPvSDiK9f+Ii1BUIJQf4/fmqWN9LlQYxw844Il0FwO4d30BFcR+4QXJhhRUPCz1hwy8lh+7Rn0+1WTwx57k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sv9yp3pV; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2f15dd0b489so62124431fa.3
        for <stable@vger.kernel.org>; Mon, 19 Aug 2024 07:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724078841; x=1724683641; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+hvQ3u52v0qJKkhIMSDWdBwGwmYs7vrpYpWLlGJR548=;
        b=Sv9yp3pVMVLhANLa4qoZMqCW1eM+GMI+jpMVAb+jL/bhLW7RRcnckInUcOmuQ2SF/O
         GGh8z44M8OpxhDhUruAfIwPXtxThNWtJNwcLF7BjjkqliUMGTxu++3wZ3HIJM71iPeQP
         EvfDffr+N58dl2nuSn2x8VIuw4XLYhJleoK45fPiNzcqVZs1Ne+sUXnMYKEHIvGlnKPw
         tv9j11ZJR3UjWNXiUNwvxawRkVWVuhQozU0pWnvz3OEntvj6yuGF2kipsBMIW99KeNid
         zgfhoNxy7Pk48Y8O7A56uVxagm1VZhwUP8FJfXkSdJDVGlAh1hX5rlHUaKfhgu5dXfbj
         +2Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724078841; x=1724683641;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+hvQ3u52v0qJKkhIMSDWdBwGwmYs7vrpYpWLlGJR548=;
        b=T2r0y67gB3Gyj2szYFZtTKR/nLbr3iejh9SIr22DP5+U5SCIn51wl8+UDZMHxSCHwB
         JmVlEWiQBHm6Uw0NeWOZuBqsf6WhtTBDKOZ4CDr+FBabATZGT82pdXTIXQqWzn7fP9cK
         92PnunT/lpSgUSL3e3shpqtSuOVFpLPp61tYTMlBODHGIT4jEwkqg8lR3Whh+IMCTOPM
         UdcLkbinAUKb0s0XAg6AP1OQ0+AXwJk81D5cE81XPg2QpuSyutTMYWiV+aCDMlT1HXQy
         XuNW9Rfo7MJzXLlYISodqrkaiKxOt0QG3DOBsuvGi6rVP93ksfiHFST9/yhr4JeolVdK
         iAWA==
X-Forwarded-Encrypted: i=1; AJvYcCXiQqgE+eMEyiLX1erVc075t9kW9hKGFsONYP+/MT7s0GKmzffsD/SDc6caS/KNrG5xb/UXC1p9Xnx+ebqek9zDsKOjoyG8
X-Gm-Message-State: AOJu0YwluRG44nnrUlxbMo5/eKV6fZeqXmamhAXhj+6yJMpLzKZ5VhGT
	APRtN8LOwIptBmKFa5zN3NPa8ndnxP9C2aSO7gqta6BKR5hwGve7focF765X93RHzH3v/Vda6Gf
	QFVNWZXR9LG3rAOEmonkCZpPLw7dF9xlf
X-Google-Smtp-Source: AGHT+IEs88zzlUiuNbET+7jZKVbZCJAg+gVxCpDfydrYqpD4f+qGR1PPXZpThAya2cO9HgynDqIUPpCO8CGLkUCkizw=
X-Received: by 2002:a05:651c:a0a:b0:2f3:cbc3:b093 with SMTP id
 38308e7fff4ca-2f3cf4caf48mr46052731fa.43.1724078840620; Mon, 19 Aug 2024
 07:47:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240819131120.746077-1-sunjunchao2870@gmail.com>
In-Reply-To: <20240819131120.746077-1-sunjunchao2870@gmail.com>
From: Julian Sun <sunjunchao2870@gmail.com>
Date: Mon, 19 Aug 2024 22:47:07 +0800
Message-ID: <CAHB1NaijrAA999WMG=XsSCKhnvvhYR4qqzJ8uOf58Tnk9ms-xQ@mail.gmail.com>
Subject: Re: [PATCH] ocfs2: fix null-ptr-deref when journal load failed.
To: ocfs2-devel@lists.linux.dev
Cc: joseph.qi@linux.alibaba.com, jlbec@evilplan.org, mark@fasheh.com, 
	syzbot+05b9b39d8bdfe1a0861f@syzkaller.appspotmail.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

CC stable

Julian Sun <sunjunchao2870@gmail.com> =E4=BA=8E2024=E5=B9=B48=E6=9C=8819=E6=
=97=A5=E5=91=A8=E4=B8=80 21:11=E5=86=99=E9=81=93=EF=BC=9A
>
> During the mounting process, if the jbd2_journal_load()
> call fails, it will internally invoke journal_reset()
> ->journal_fail_superblock(), which sets journal->j_sb_buffer
> to NULL. Subsequently, ocfs2_journal_shutdown() calls
> jbd2_journal_flush()->jbd2_cleanup_journal_tail()->
> __jbd2_update_log_tail()->jbd2_journal_update_sb_log_tail()
> ->lock_buffer(journal->j_sb_buffer), resulting in a
> null-pointer dereference error.
>
> To resolve this issue, a new state OCFS2_JOURNAL_INITED
> has been introduced to replace the previous functionality
> of OCFS2_JOURNAL_LOADED, the original OCFS2_JOURNAL_LOADED
> is only set when ocfs2_journal_load() is successful.
> The jbd2_journal_flush() function is allowed to be called
> only when this flag is set. The logic here is that if the
> journal has even not been successfully loaded, there is
> no need to flush the journal.
>
> Link: https://syzkaller.appspot.com/bug?extid=3D05b9b39d8bdfe1a0861f
> Reported-by: syzbot+05b9b39d8bdfe1a0861f@syzkaller.appspotmail.com
> Signed-off-by: Julian Sun <sunjunchao2870@gmail.com>
> ---
>  fs/ocfs2/journal.c | 9 ++++++---
>  fs/ocfs2/journal.h | 1 +
>  2 files changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/fs/ocfs2/journal.c b/fs/ocfs2/journal.c
> index 530fba34f6d3..6f837296048f 100644
> --- a/fs/ocfs2/journal.c
> +++ b/fs/ocfs2/journal.c
> @@ -968,7 +968,7 @@ int ocfs2_journal_init(struct ocfs2_super *osb, int *=
dirty)
>
>         ocfs2_set_journal_params(osb);
>
> -       journal->j_state =3D OCFS2_JOURNAL_LOADED;
> +       journal->j_state =3D OCFS2_JOURNAL_INITED;
>
>         status =3D 0;
>  done:
> @@ -1039,6 +1039,7 @@ void ocfs2_journal_shutdown(struct ocfs2_super *osb=
)
>         int status =3D 0;
>         struct inode *inode =3D NULL;
>         int num_running_trans =3D 0;
> +       enum ocfs2_journal_state state;
>
>         BUG_ON(!osb);
>
> @@ -1047,8 +1048,9 @@ void ocfs2_journal_shutdown(struct ocfs2_super *osb=
)
>                 goto done;
>
>         inode =3D journal->j_inode;
> +       state =3D journal->j_state;
>
> -       if (journal->j_state !=3D OCFS2_JOURNAL_LOADED)
> +       if (state !=3D OCFS2_JOURNAL_INITED)
>                 goto done;
>
>         /* need to inc inode use count - jbd2_journal_destroy will iput. =
*/
> @@ -1076,7 +1078,7 @@ void ocfs2_journal_shutdown(struct ocfs2_super *osb=
)
>
>         BUG_ON(atomic_read(&(osb->journal->j_num_trans)) !=3D 0);
>
> -       if (ocfs2_mount_local(osb)) {
> +       if (ocfs2_mount_local(osb) && state =3D=3D OCFS2_JOURNAL_LOADED) =
{
>                 jbd2_journal_lock_updates(journal->j_journal);
>                 status =3D jbd2_journal_flush(journal->j_journal, 0);
>                 jbd2_journal_unlock_updates(journal->j_journal);
> @@ -1174,6 +1176,7 @@ int ocfs2_journal_load(struct ocfs2_journal *journa=
l, int local, int replayed)
>                 }
>         } else
>                 osb->commit_task =3D NULL;
> +       journal->j_state =3D OCFS2_JOURNAL_LOADED;
>
>  done:
>         return status;
> diff --git a/fs/ocfs2/journal.h b/fs/ocfs2/journal.h
> index e3c3a35dc5e0..a80f76a8fa0e 100644
> --- a/fs/ocfs2/journal.h
> +++ b/fs/ocfs2/journal.h
> @@ -15,6 +15,7 @@
>
>  enum ocfs2_journal_state {
>         OCFS2_JOURNAL_FREE =3D 0,
> +       OCFS2_JOURNAL_INITED,
>         OCFS2_JOURNAL_LOADED,
>         OCFS2_JOURNAL_IN_SHUTDOWN,
>  };
> --
> 2.39.2
>


--=20
Julian Sun <sunjunchao2870@gmail.com>

