Return-Path: <stable+bounces-196851-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 337A8C8351A
	for <lists+stable@lfdr.de>; Tue, 25 Nov 2025 05:16:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1D8574E1ACB
	for <lists+stable@lfdr.de>; Tue, 25 Nov 2025 04:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42C21242D70;
	Tue, 25 Nov 2025 04:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ys6F+Th1"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A49512CDBE
	for <stable@vger.kernel.org>; Tue, 25 Nov 2025 04:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764044208; cv=none; b=hlVib9FET8rxtpHkMSC7BVDMxex3Bkfb+WNjF4ecgbYKD3TD/B2bJlLLSdPGtZ/xuHFzhrg7PEpseUovPO6jUWT+mXe5b0fpASrnqCovs/e9XQK99x4GbOtCwgozFYJ1+4WqyKwEWbePm4q50eVeSOZA4mEl7ORxIkO1Auue0Fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764044208; c=relaxed/simple;
	bh=NeGsHXXqkQBhjBRMCMNYyKEJl2UrV7eEIZSrvpIe4QA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GRl8et487WTPQtuZpJ6CC24zM3FCLGjtE5iDCzPC4X7FhQAaNdk9XiRXSi2nEzKLcM+IFt5bvwJOWwCANvRp50UpnC5yxvS4Ea/YJFzgy+3uYDN9CQWck4aYFVPGqeT7aU2hVWRFaugvfaVufnaC0o9JcxxSCWLEATR08k+M8zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ys6F+Th1; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-8804ca2a730so74197876d6.2
        for <stable@vger.kernel.org>; Mon, 24 Nov 2025 20:16:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764044205; x=1764649005; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rHxT7dW0oNeC3uXtloBt3o68++L2zXJqZdUBfY79wO4=;
        b=Ys6F+Th11iSf1u9WqzWLrr3A1qMHaQtcr3NdCKF2Q2E7f907XuT/5Pj+ebtxUXB/Bj
         vGJoWjpGd/t6zOWT7GR5JK7Fa/z0/b/wQcfzMvoNyRRyL4hS5oVLxjU9jjfU26H6sscX
         n0G5Z07zJbnNRkK8pFQU82jw0aqFVLugODqXEdlwu8cng+o+p2Mib9HitRL6F5Opdgk1
         3i+tXvFMJIyoU6gsfFjLgJ4mXXdNgYypHaMUWlHb0sfW/16WLqb83sVVAw4TmiJ5aVfW
         z7AOHrB1WpSc4tH/11xm0L/i7gyRhkF8nmroCDgVF7tcIboCT9RBCvXG8T8tlLw1IALq
         dnqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764044205; x=1764649005;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rHxT7dW0oNeC3uXtloBt3o68++L2zXJqZdUBfY79wO4=;
        b=rT3mkP3tWkzjNjfVRpaCm4wjG6oI8nN88Xfv8OaFm7wvCev16hgdnKPJmeP7XFzvvV
         qBc0TVK16y6MgRPsxW2bd/yvY4XW3ngx63J830MGQ0qCDQ+bEwQe5qmWqpdqN6SXmeSZ
         k/m2YLWkpO4TuOT9PSmBNwEwNCvolker51qiroP+4mRD4WlwvYYHRv0OWs5Gl22Wlhzo
         ROHGH8kLKsAItZ1CyKyLre1k74ZLiYyKZ82lF2bpDKGqLDhENe+d+CZ/N3AghRheOjw7
         oIeBO9KizYZIsuF6mRzHXFN5rDrs4z7l+SSPpTFZg2xLXRb36j4Iyvzct01xZsjB39ws
         xLRQ==
X-Forwarded-Encrypted: i=1; AJvYcCUp1jsjNk3MKu3RMTUxLkPc4WhO20+vrdFN11DLTQ3xHOWrKtW1UkB+j2qiq+pVTVC8cFk6nTk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwqqoekGX/KWQM3Edf3oyE0qZLDd9FRYdAaMAyLybT5j9FJpj0
	mZwW5GdYknnlrjinuUGuftzmLg+ikJjB4I3cgBfhZkJaMMOQTbCNnSHJJxf+05t4hFVVSNU5VgU
	jYme8RpSfocIa1/Tlv88X33HtnpTjYygiPgem
X-Gm-Gg: ASbGncsFoeQgF7RipA55+Pub7DNy+oTRgXkQ6vxJNK+01BcGXvVpzx/nvCafk17CWEg
	w5PRGsM3vbZJJjn38cmWM9NondznRve8pEeY1RTj1LtM5FINz/YLirxv2pKHxxqcRxVy5aAgmzv
	RxuRzRmPMBdWCI4lXfDEdhUEif5F32Fr/kBXvWhnl5jiLd4EXgl8BVvkEDgEzUelj+1wCtWOcqP
	puQHZBtwmLJVDVI6HMEGePJMsUHphZk6qKozXLNRQCFkSGUpB8BagCr2evH7MvKZdmNHXTRBWjG
	Azco/sogrWj1BFhk7s5GeeKIbIZOexZP/DYBigZnWHxIzmQ6+1qNHH87o9BdBcKEhreCmsmFgk/
	u1mTNfj6IKMkX1hHjdYv+AHXXxUqbQQrcqboFSZRkBlhvH6ZEBN3oerp9NSUsHjTeH6zsPuGEJr
	m4/RfoSvIj
X-Google-Smtp-Source: AGHT+IFbO/6EFAorrW1zgGw6rlA4h/XKkcBaBAXDf2HlzTpoasTjL7792zKktcesPTVdmvhPTX9BVupPDrwO4lcSOnU=
X-Received: by 2002:a05:6214:3a8c:b0:882:4e18:a7bd with SMTP id
 6a1803df08f44-8847c53b629mr226318906d6.62.1764044205093; Mon, 24 Nov 2025
 20:16:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251124200036.1582605-1-pc@manguebit.org>
In-Reply-To: <20251124200036.1582605-1-pc@manguebit.org>
From: Steve French <smfrench@gmail.com>
Date: Mon, 24 Nov 2025 22:16:33 -0600
X-Gm-Features: AWmQ_bkxZIT6q5NRZ0g4gnM85LcXBIkn7fMGtKAwa-lCe9Ns1o21md6Nwp6AddE
Message-ID: <CAH2r5mttOuyQKEDWjv6hEDeytW2GFzMtFvLO+kNNBJC1vu9m4g@mail.gmail.com>
Subject: Re: [PATCH] smb: client: fix memory leak in cifs_construct_tcon()
To: Paulo Alcantara <pc@manguebit.org>
Cc: Jay Shin <jaeshin@redhat.com>, stable@vger.kernel.org, linux-cifs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

merged into cifs-2.6.git for-next pending additional review/testing

On Mon, Nov 24, 2025 at 2:00=E2=80=AFPM Paulo Alcantara <pc@manguebit.org> =
wrote:
>
> When having a multiuser mount with domain=3D specified and using
> cifscreds, cifs_set_cifscreds() will end up setting @ctx->domainname,
> so it needs to be freed before leaving cifs_construct_tcon().
>
> This fixes the following memory leak reported by kmemleak:
>
>   mount.cifs //srv/share /mnt -o domain=3DZELDA,multiuser,...
>   su - testuser
>   cifscreds add -d ZELDA -u testuser
>   ...
>   ls /mnt/1
>   ...
>   umount /mnt
>   echo scan > /sys/kernel/debug/kmemleak
>   cat /sys/kernel/debug/kmemleak
>   unreferenced object 0xffff8881203c3f08 (size 8):
>     comm "ls", pid 5060, jiffies 4307222943
>     hex dump (first 8 bytes):
>       5a 45 4c 44 41 00 cc cc                          ZELDA...
>     backtrace (crc d109a8cf):
>       __kmalloc_node_track_caller_noprof+0x572/0x710
>       kstrdup+0x3a/0x70
>       cifs_sb_tlink+0x1209/0x1770 [cifs]
>       cifs_get_fattr+0xe1/0xf50 [cifs]
>       cifs_get_inode_info+0xb5/0x240 [cifs]
>       cifs_revalidate_dentry_attr+0x2d1/0x470 [cifs]
>       cifs_getattr+0x28e/0x450 [cifs]
>       vfs_getattr_nosec+0x126/0x180
>       vfs_statx+0xf6/0x220
>       do_statx+0xab/0x110
>       __x64_sys_statx+0xd5/0x130
>       do_syscall_64+0xbb/0x380
>       entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> Fixes: f2aee329a68f ("cifs: set domainName when a domain-key is used in m=
ultiuser")
> Signed-off-by: Paulo Alcantara (Red Hat) <pc@manguebit.org>
> Cc: Jay Shin <jaeshin@redhat.com>
> Cc: stable@vger.kernel.org
> Cc: linux-cifs@vger.kernel.org
> ---
>  fs/smb/client/connect.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/fs/smb/client/connect.c b/fs/smb/client/connect.c
> index 55cb4b0cbd48..2f94d93b95e9 100644
> --- a/fs/smb/client/connect.c
> +++ b/fs/smb/client/connect.c
> @@ -4451,6 +4451,7 @@ cifs_construct_tcon(struct cifs_sb_info *cifs_sb, k=
uid_t fsuid)
>
>  out:
>         kfree(ctx->username);
> +       kfree(ctx->domainname);
>         kfree_sensitive(ctx->password);
>         kfree(origin_fullpath);
>         kfree(ctx);
> --
> 2.51.1
>


--=20
Thanks,

Steve

