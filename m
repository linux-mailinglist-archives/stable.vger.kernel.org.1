Return-Path: <stable+bounces-231228-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eHbJLqyFymkW9gUAu9opvQ
	(envelope-from <stable+bounces-231228-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 16:16:12 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CC4135CA90
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 16:16:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5E657300F115
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 14:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34A8C3D8911;
	Mon, 30 Mar 2026 14:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A5aQH+Cf"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC6683D34A3
	for <stable@vger.kernel.org>; Mon, 30 Mar 2026 14:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774880165; cv=pass; b=EolfgM3uY1h1mtAz9RxWKluarSfEAQzZeZ6WHsotD+mnACpKi7QAALzu22T13Mmg3iLzqxQ+KTU2qGtt373WK5E2qsfxjF2xcJ6hwWjpyaVQUMJyFLjVqtUs9p3SCIXdH8qjLy256eRK9QjYOp6oPiMs6NIh3o+qiba16lB/vGQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774880165; c=relaxed/simple;
	bh=lv5kxP9LSt1nwbNjYObmmGpcpfstee3j+udc8+FieW8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ozWbyI3wCEKp5dhCgc+3Z0Vzz76pCGPYzJU75TcfU3X3XpqNAu5a65VJ3Uw0SQ55nVwKhWpf1Skf1nGee6cRrNFQY/3EapuaD+rznKCiX/rs70UWR1AMXDDsggSu3IQL99qL8cD8SRssToANGQ6YDpy/SRwWvrtVYOT1D5Kkx0o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A5aQH+Cf; arc=pass smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-667de793310so7457612a12.0
        for <stable@vger.kernel.org>; Mon, 30 Mar 2026 07:16:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774880161; cv=none;
        d=google.com; s=arc-20240605;
        b=PM0PZxVat3qCxudmsw+uprCSlPdeIh2IaWG5zHUVxXq/QD4RKzbkWJz9zX5uEQUlVK
         FIpJEpoNz5QDjCbHALplEHKGuWq0i0SpCf9agNCIj81HsbwGVEyQuWC4FHvmdce5qIQg
         4mg4h80JwxJ2+1eNlyFZFOOceyKS5Ol6J6WJzhlgDYRkJrNLBmu4kOZaVNcTpOgt1CMz
         IXIqntqq21y4YTQFZ7xmnsq2NnBDy5GXqX8rFPed0SZuo9KueKl3VhxUmzpOdYPNXhrs
         r8jn/H4CJoFn5le2uyf74KscKN1zhVM62AXJj0CWI2+WzaV12h4UfQLTN0rl0iAmVe+F
         pfYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tG8EIWRB4WiOOQYvqxHOP6zTdkSzQZZWCRXCrRVv3Pg=;
        fh=OfVJXFNOv4/c0YqnzXB4Hmy30L6+rzFeblkSm1F2en4=;
        b=Aw3jCi7GcfkxOZYKoQNDcL5x8YGIEOO0m037DlNkXMUndHnQ7VfaKXrmedoY3Ngmsy
         sCXDrTVj/lffljGaqm3g/4rSm3cchQK23FCQfin5GPwzxzLkCb1C06UQLBk5u+ArGSAx
         r4ARwA6BNNDxThBMZsoN9nsxAguvLo4obYm8Nz7ucwuTA17H38JpZNKADKU5MHeJaG7y
         ar7CMpivR21e78X7ufZhOgJeNqUWniXvN/M/h91ZP9xSFjN6Vi55tx7Q/MoWroFI4rWD
         +uAUhozRb8DlT3WS9w2uuCK1O2203Hbo96VQCqGDDK6PxlKaFeU7WtsEgiJDk2rks7Ik
         BqiQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774880161; x=1775484961; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tG8EIWRB4WiOOQYvqxHOP6zTdkSzQZZWCRXCrRVv3Pg=;
        b=A5aQH+Cf/xE7DEiFBXesUJyanQLdwagf14Bo4BzPY15iOr6WA/2S2HhiXfx8bZ9lAQ
         YjUApKFR1fVMCKyJ/Tz8app7weYI4IL60nuDsH5y7RkL4afGCPCTLOQ46HaILE7/RzIG
         WWvqohzKmFvk1rjRwghuxLU0JGeAzshSzJa/o+zrQSlyY+6IMhYIuJJIBHfKQKarw9Ge
         gzFauCla4LHzcdSQhw4i/vHFucobj5NCZvrGHpUT+vVEhYXrbdd1YL4UisXMSw0sOuin
         F4rWZn+6l/r6g+LQdZVsi7HG7Z8tCx1zyaKYhgWWJlUs9U9LYxlO1qHBHEJragpiGjMM
         uXdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774880161; x=1775484961;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tG8EIWRB4WiOOQYvqxHOP6zTdkSzQZZWCRXCrRVv3Pg=;
        b=VE+OwEQ19u4eccO2tAQqvtWCy3LI4m4fZk6L6fHvrTQVF5vSs92xzu8EBxnYZxqQwH
         niyY6c2mTqddogEWRs8mYEVVtChaHJLGq5ib3MxNb2F4l8QvGegCSwWWwaYCHVOH11JY
         hgYyDhFrXkx7+TKAODTuDSm2xs/xswHW02Yw9tEcIkODMLGhvKTQ9Ue5X5AnRPJq6btz
         9wi1Owt5w+O6BID73U1WG/Y8KDTzkZEio+kqzNPJAWchaKn8WuXfAVBzJkuLLfissJgZ
         ECc/j4nPeAKFpPUNeMwKLl1qFpiWSSI7UEtu1b9K54B8SN5kkJ0lmGC58ZrDVXgVLVRX
         INvg==
X-Forwarded-Encrypted: i=1; AJvYcCVLwu6lJk4qfeTNgZU1r05G8zD41qoL1E8vZOwmIFJ9Ik0xZ4TJG6kvjyvEqLHjxd8kSkD6ACM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJaJq5+kYioGkO0hhhhAhVkq9exBliCBuhNgwz8Yg7sAhfQGkC
	bHLk49hfyXYoa85ns9CtfV5E9+BbWB240CSO7JSjAxieFLFkWc36O8hf9PbTjRl3zjvAPnx2/B4
	yIedzVA50iDGVZdMIEZC7fTWpnfQeS0s=
X-Gm-Gg: ATEYQzwDU6SM/kM/8vTiq8dV7vH0ehPTUXvxjoZUoSvJ8WIB1+Ulmf6xhxIechnbECM
	sbH5ads3QOqRko7J/8Vy8H+/CuvnDus0/RVlWSv5Z5S5AtqG2GU3NSxXoN8GFZ01t3nhx7i13Pr
	XT177yCW5xOJKx3kYUzgvRJkLfXI26f6S9L+jqjw9fJ1BZYjy6p+lbcJGqZ7w9nwI+hOp/VLiTR
	AbnL974vw8xWAtObh0c8Tgg+OOb0LCh23HEaL5pKNzWvWeYZ/5oBgS6VpeggLETQp5wcmIBHLJ1
	rN9VqkB6BCuALc1yIm1Au/+UoX00TXhv93thRB7x8A==
X-Received: by 2002:a05:6402:34cc:b0:669:cc03:334a with SMTP id
 4fb4d7f45d1cf-66b2846a19bmr7353005a12.11.1774880160523; Mon, 30 Mar 2026
 07:16:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2026033031-backpack-decorator-faaa@gregkh>
In-Reply-To: <2026033031-backpack-decorator-faaa@gregkh>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 30 Mar 2026 16:15:48 +0200
X-Gm-Features: AQROBzDAAqvTHwUwfH0UKDW5E9PwpSuoaquapzG7sLXFwXAJ-tPDoZf1LvWeZG4
Message-ID: <CAOQ4uxjUDHxSk8uauLrjou_E_D0N4Frv2ddQwkH7xbXK31B-fg@mail.gmail.com>
Subject: Re: FAILED: patch "[PATCH] ovl: make fsync after metadata copy-up
 opt-in mount option" failed to apply to 6.12-stable tree
To: gregkh@linuxfoundation.org
Cc: feilv@asrmicro.com, chenglongtang@google.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-231228-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[amir73il@gmail.com,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linuxfoundation.org:email]
X-Rspamd-Queue-Id: 4CC4135CA90
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 30, 2026 at 11:36=E2=80=AFAM <gregkh@linuxfoundation.org> wrote=
:
>
>
> The patch below does not apply to the 6.12-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
>
> To reproduce the conflict and resubmit, you may use the following command=
s:
>
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.gi=
t/ linux-6.12.y
> git checkout FETCH_HEAD
> git cherry-pick -x 1f6ee9be92f8df85a8c9a5a78c20fd39c0c21a95
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026033031-=
backpack-decorator-faaa@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..
>
> Possible dependencies:
>

Please apply this dependency patch as described in commit message:

Depends: 50e638beb67e0 ("ovl: Use str_on_off() helper in ovl_show_options()=
")

Should I describe the dependency using a different format in the future for
the scripts to catch it?

Thanks,
Amir.

>
>
> thanks,
>
> greg k-h
>
> ------------------ original commit in Linus's tree ------------------
>
> From 1f6ee9be92f8df85a8c9a5a78c20fd39c0c21a95 Mon Sep 17 00:00:00 2001
> From: Fei Lv <feilv@asrmicro.com>
> Date: Mon, 22 Jul 2024 18:14:43 +0800
> Subject: [PATCH] ovl: make fsync after metadata copy-up opt-in mount opti=
on
>
> Commit 7d6899fb69d25 ("ovl: fsync after metadata copy-up") was done to
> fix durability of overlayfs copy up on an upper filesystem which does
> not enforce ordering on storing of metadata changes (e.g. ubifs).
>
> In an earlier revision of the regressing commit by Lei Lv, the metadata
> fsync behavior was opt-in via a new "fsync=3Dstrict" mount option.
> We were hoping that the opt-in mount option could be avoided, so the
> change was only made to depend on metacopy=3Doff, in the hope of not
> hurting performance of metadata heavy workloads, which are more likely
> to be using metacopy=3Don.
>
> This hope was proven wrong by a performance regression report from Google
> COS workload after upgrade to kernel 6.12.
>
> This is an adaptation of Lei's original "fsync=3Dstrict" mount option
> to the existing upstream code.
>
> The new mount option is mutually exclusive with the "volatile" mount
> option, so the latter is now an alias to the "fsync=3Dvolatile" mount
> option.
>
> Reported-by: Chenglong Tang <chenglongtang@google.com>
> Closes: https://lore.kernel.org/linux-unionfs/CAOdxtTadAFH01Vui1FvWfcmQ8j=
H1O45owTzUcpYbNvBxnLeM7Q@mail.gmail.com/
> Link: https://lore.kernel.org/linux-unionfs/CAOQ4uxgKC1SgjMWre=3DfUb00v8r=
xtd6sQi-S+dxR8oDzAuiGu8g@mail.gmail.com/
> Fixes: 7d6899fb69d25 ("ovl: fsync after metadata copy-up")
> Depends: 50e638beb67e0 ("ovl: Use str_on_off() helper in ovl_show_options=
()")
> Cc: stable@vger.kernel.org # v6.12+
> Signed-off-by: Fei Lv <feilv@asrmicro.com>
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
>
> diff --git a/Documentation/filesystems/overlayfs.rst b/Documentation/file=
systems/overlayfs.rst
> index af5a69f87da4..eb846518e6ac 100644
> --- a/Documentation/filesystems/overlayfs.rst
> +++ b/Documentation/filesystems/overlayfs.rst
> @@ -783,6 +783,56 @@ controlled by the "uuid" mount option, which support=
s these values:
>      mounted with "uuid=3Don".
>
>
> +Durability and copy up
> +----------------------
> +
> +The fsync(2) system call ensures that the data and metadata of a file
> +are safely written to the backing storage, which is expected to
> +guarantee the existence of the information post system crash.
> +
> +Without an fsync(2) call, there is no guarantee that the observed
> +data after a system crash will be either the old or the new data, but
> +in practice, the observed data after crash is often the old or new data
> +or a mix of both.
> +
> +When an overlayfs file is modified for the first time, copy up will
> +create a copy of the lower file and its parent directories in the upper
> +layer.  Since the Linux filesystem API does not enforce any particular
> +ordering on storing changes without explicit fsync(2) calls, in case
> +of a system crash, the upper file could end up with no data at all
> +(i.e. zeros), which would be an unusual outcome.  To avoid this
> +experience, overlayfs calls fsync(2) on the upper file before completing
> +data copy up with rename(2) or link(2) to make the copy up "atomic".
> +
> +By default, overlayfs does not explicitly call fsync(2) on copied up
> +directories or on metadata-only copy up, so it provides no guarantee to
> +persist the user's modification unless the user calls fsync(2).
> +The fsync during copy up only guarantees that if a copy up is observed
> +after a crash, the observed data is not zeroes or intermediate values
> +from the copy up staging area.
> +
> +On traditional local filesystems with a single journal (e.g. ext4, xfs),
> +fsync on a file also persists the parent directory changes, because they
> +are usually modified in the same transaction, so metadata durability dur=
ing
> +data copy up effectively comes for free.  Overlayfs further limits risk =
by
> +disallowing network filesystems as upper layer.
> +
> +Overlayfs can be tuned to prefer performance or durability when storing
> +to the underlying upper layer.  This is controlled by the "fsync" mount
> +option, which supports these values:
> +
> +- "auto": (default)
> +    Call fsync(2) on upper file before completion of data copy up.
> +    No explicit fsync(2) on directory or metadata-only copy up.
> +- "strict":
> +    Call fsync(2) on upper file and directories before completion of any
> +    copy up.
> +- "volatile": [*]
> +    Prefer performance over durability (see `Volatile mount`_)
> +
> +[*] The mount option "volatile" is an alias to "fsync=3Dvolatile".
> +
> +
>  Volatile mount
>  --------------
>
> diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
> index 758611ee4475..13cb60b52bd6 100644
> --- a/fs/overlayfs/copy_up.c
> +++ b/fs/overlayfs/copy_up.c
> @@ -1146,15 +1146,15 @@ static int ovl_copy_up_one(struct dentry *parent,=
 struct dentry *dentry,
>                 return -EOVERFLOW;
>
>         /*
> -        * With metacopy disabled, we fsync after final metadata copyup, =
for
> +        * With "fsync=3Dstrict", we fsync after final metadata copyup, f=
or
>          * both regular files and directories to get atomic copyup semant=
ics
>          * on filesystems that do not use strict metadata ordering (e.g. =
ubifs).
>          *
> -        * With metacopy enabled we want to avoid fsync on all meta copyu=
p
> +        * By default, we want to avoid fsync on all meta copyup, because
>          * that will hurt performance of workloads such as chown -R, so w=
e
>          * only fsync on data copyup as legacy behavior.
>          */
> -       ctx.metadata_fsync =3D !OVL_FS(dentry->d_sb)->config.metacopy &&
> +       ctx.metadata_fsync =3D ovl_should_sync_metadata(OVL_FS(dentry->d_=
sb)) &&
>                              (S_ISREG(ctx.stat.mode) || S_ISDIR(ctx.stat.=
mode));
>         ctx.metacopy =3D ovl_need_meta_copy_up(dentry, ctx.stat.mode, fla=
gs);
>
> diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
> index cad2055ebf18..63b299bf12f7 100644
> --- a/fs/overlayfs/overlayfs.h
> +++ b/fs/overlayfs/overlayfs.h
> @@ -99,6 +99,12 @@ enum {
>         OVL_VERITY_REQUIRE,
>  };
>
> +enum {
> +       OVL_FSYNC_VOLATILE,
> +       OVL_FSYNC_AUTO,
> +       OVL_FSYNC_STRICT,
> +};
> +
>  /*
>   * The tuple (fh,uuid) is a universal unique identifier for a copy up or=
igin,
>   * where:
> @@ -656,6 +662,21 @@ static inline bool ovl_xino_warn(struct ovl_fs *ofs)
>         return ofs->config.xino =3D=3D OVL_XINO_ON;
>  }
>
> +static inline bool ovl_should_sync(struct ovl_fs *ofs)
> +{
> +       return ofs->config.fsync_mode !=3D OVL_FSYNC_VOLATILE;
> +}
> +
> +static inline bool ovl_should_sync_metadata(struct ovl_fs *ofs)
> +{
> +       return ofs->config.fsync_mode =3D=3D OVL_FSYNC_STRICT;
> +}
> +
> +static inline bool ovl_is_volatile(struct ovl_config *config)
> +{
> +       return config->fsync_mode =3D=3D OVL_FSYNC_VOLATILE;
> +}
> +
>  /*
>   * To avoid regressions in existing setups with overlay lower offline ch=
anges,
>   * we allow lower changes only if none of the new features are used.
> diff --git a/fs/overlayfs/ovl_entry.h b/fs/overlayfs/ovl_entry.h
> index 1d4828dbcf7a..80cad4ea96a3 100644
> --- a/fs/overlayfs/ovl_entry.h
> +++ b/fs/overlayfs/ovl_entry.h
> @@ -18,7 +18,7 @@ struct ovl_config {
>         int xino;
>         bool metacopy;
>         bool userxattr;
> -       bool ovl_volatile;
> +       int fsync_mode;
>  };
>
>  struct ovl_sb {
> @@ -120,11 +120,6 @@ static inline struct ovl_fs *OVL_FS(struct super_blo=
ck *sb)
>         return (struct ovl_fs *)sb->s_fs_info;
>  }
>
> -static inline bool ovl_should_sync(struct ovl_fs *ofs)
> -{
> -       return !ofs->config.ovl_volatile;
> -}
> -
>  static inline unsigned int ovl_numlower(struct ovl_entry *oe)
>  {
>         return oe ? oe->__numlower : 0;
> diff --git a/fs/overlayfs/params.c b/fs/overlayfs/params.c
> index 8111b437ae5d..c93fcaa45d4a 100644
> --- a/fs/overlayfs/params.c
> +++ b/fs/overlayfs/params.c
> @@ -58,6 +58,7 @@ enum ovl_opt {
>         Opt_xino,
>         Opt_metacopy,
>         Opt_verity,
> +       Opt_fsync,
>         Opt_volatile,
>         Opt_override_creds,
>  };
> @@ -140,6 +141,23 @@ static int ovl_verity_mode_def(void)
>         return OVL_VERITY_OFF;
>  }
>
> +static const struct constant_table ovl_parameter_fsync[] =3D {
> +       { "volatile",   OVL_FSYNC_VOLATILE },
> +       { "auto",       OVL_FSYNC_AUTO     },
> +       { "strict",     OVL_FSYNC_STRICT   },
> +       {}
> +};
> +
> +static const char *ovl_fsync_mode(struct ovl_config *config)
> +{
> +       return ovl_parameter_fsync[config->fsync_mode].name;
> +}
> +
> +static int ovl_fsync_mode_def(void)
> +{
> +       return OVL_FSYNC_AUTO;
> +}
> +
>  const struct fs_parameter_spec ovl_parameter_spec[] =3D {
>         fsparam_string_empty("lowerdir",    Opt_lowerdir),
>         fsparam_file_or_string("lowerdir+", Opt_lowerdir_add),
> @@ -155,6 +173,7 @@ const struct fs_parameter_spec ovl_parameter_spec[] =
=3D {
>         fsparam_enum("xino",                Opt_xino, ovl_parameter_xino)=
,
>         fsparam_enum("metacopy",            Opt_metacopy, ovl_parameter_b=
ool),
>         fsparam_enum("verity",              Opt_verity, ovl_parameter_ver=
ity),
> +       fsparam_enum("fsync",               Opt_fsync, ovl_parameter_fsyn=
c),
>         fsparam_flag("volatile",            Opt_volatile),
>         fsparam_flag_no("override_creds",   Opt_override_creds),
>         {}
> @@ -665,8 +684,11 @@ static int ovl_parse_param(struct fs_context *fc, st=
ruct fs_parameter *param)
>         case Opt_verity:
>                 config->verity_mode =3D result.uint_32;
>                 break;
> +       case Opt_fsync:
> +               config->fsync_mode =3D result.uint_32;
> +               break;
>         case Opt_volatile:
> -               config->ovl_volatile =3D true;
> +               config->fsync_mode =3D OVL_FSYNC_VOLATILE;
>                 break;
>         case Opt_userxattr:
>                 config->userxattr =3D true;
> @@ -800,6 +822,7 @@ int ovl_init_fs_context(struct fs_context *fc)
>         ofs->config.nfs_export          =3D ovl_nfs_export_def;
>         ofs->config.xino                =3D ovl_xino_def();
>         ofs->config.metacopy            =3D ovl_metacopy_def;
> +       ofs->config.fsync_mode          =3D ovl_fsync_mode_def();
>
>         fc->s_fs_info           =3D ofs;
>         fc->fs_private          =3D ctx;
> @@ -870,9 +893,9 @@ int ovl_fs_params_verify(const struct ovl_fs_context =
*ctx,
>                 config->index =3D false;
>         }
>
> -       if (!config->upperdir && config->ovl_volatile) {
> +       if (!config->upperdir && ovl_is_volatile(config)) {
>                 pr_info("option \"volatile\" is meaningless in a non-uppe=
r mount, ignoring it.\n");
> -               config->ovl_volatile =3D false;
> +               config->fsync_mode =3D ovl_fsync_mode_def();
>         }
>
>         if (!config->upperdir && config->uuid =3D=3D OVL_UUID_ON) {
> @@ -1070,8 +1093,8 @@ int ovl_show_options(struct seq_file *m, struct den=
try *dentry)
>                 seq_printf(m, ",xino=3D%s", ovl_xino_mode(&ofs->config));
>         if (ofs->config.metacopy !=3D ovl_metacopy_def)
>                 seq_printf(m, ",metacopy=3D%s", str_on_off(ofs->config.me=
tacopy));
> -       if (ofs->config.ovl_volatile)
> -               seq_puts(m, ",volatile");
> +       if (ofs->config.fsync_mode !=3D ovl_fsync_mode_def())
> +               seq_printf(m, ",fsync=3D%s", ovl_fsync_mode(&ofs->config)=
);
>         if (ofs->config.userxattr)
>                 seq_puts(m, ",userxattr");
>         if (ofs->config.verity_mode !=3D ovl_verity_mode_def())
> diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
> index d4c12feec039..0822987cfb51 100644
> --- a/fs/overlayfs/super.c
> +++ b/fs/overlayfs/super.c
> @@ -776,7 +776,7 @@ static int ovl_make_workdir(struct super_block *sb, s=
truct ovl_fs *ofs,
>          * For volatile mount, create a incompat/volatile/dirty file to k=
eep
>          * track of it.
>          */
> -       if (ofs->config.ovl_volatile) {
> +       if (ovl_is_volatile(&ofs->config)) {
>                 err =3D ovl_create_volatile_dirty(ofs);
>                 if (err < 0) {
>                         pr_err("Failed to create volatile/dirty file.\n")=
;
>

