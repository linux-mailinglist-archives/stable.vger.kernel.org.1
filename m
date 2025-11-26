Return-Path: <stable+bounces-196938-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7094DC878A7
	for <lists+stable@lfdr.de>; Wed, 26 Nov 2025 01:02:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B971E3ABF2E
	for <lists+stable@lfdr.de>; Wed, 26 Nov 2025 00:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EDA34A0C;
	Wed, 26 Nov 2025 00:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nqKmY651"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6949510FD
	for <stable@vger.kernel.org>; Wed, 26 Nov 2025 00:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764115321; cv=none; b=IfQ3GexOtKYafbnOQJXsduizMps1p/RIslFANucds/9HqOtPAY9nugSX5jsQ9VzWH8x+Ka5K0bU9rKn7Yxs1aoNbeGOy/YzSsstSk6vIbb4driv5qEgn1LQBDwqfkd7Mgg2ync4xH7TBtG1H/IzqY7XBN8hTdTS9icxBvM8932I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764115321; c=relaxed/simple;
	bh=+XDXpyBZS1sTODjc5N9yid75ggmhqCspW2eKXF8HKtM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j2MwYdW3YYW35oWvVOKe5m8sWUvKnx58ew0mi7PEH2bGihEgbZgHk0pQS3kpIIBzgLEXb9f6sRr+psfOqwLAeSFISeMypGzGwgX6jMaAeP8QRE2htDNsT4Y8IKiQH3YLIpAsNT5K9KqGJzTngv9iqvZ6gajcdF/56aKVy1kr+Oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nqKmY651; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-880576ebe38so70080446d6.2
        for <stable@vger.kernel.org>; Tue, 25 Nov 2025 16:01:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764115318; x=1764720118; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YaSSSTOEdPXrwvpfE69f6cHaGVAff9hm8HrlgzHFCzY=;
        b=nqKmY651V5PrFucjB22nupw4R0cfivCSxNTWadBAU5TetTKby8zT1IfkdBXxqmGVGR
         Lk9Rx0HW7NyVkqibDvQjQMpeEveSsRTdT66VF4E7mjrBsiE1QIC7KzDvDCcZGlAZ4+hG
         O47EuliwokqYi6fItKuwAsmOPSvoqN2aBMigWLS1irXPB2MI/eKxWERsTqnUuMfPFaZW
         NfiiAzpC1mVLFTpNvKeZJCMv7NQk5xgXhZTdAfA6ke5yJ7xsEWy1ogQF65ugBNdejLqV
         L2ESwHYCYfw1OC6wnl57zudSvrkdohcwAT3OsqzBIvyNBdls8U4puO+Ax+l3gHPu0nMx
         /9vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764115318; x=1764720118;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YaSSSTOEdPXrwvpfE69f6cHaGVAff9hm8HrlgzHFCzY=;
        b=IZ957guKDMBLPw6TcSzYS0g0Sxzd3QzJ6rGayUbtCE/Asd6CY0HpH155fYvTih3yw4
         BtX7ZlI28gf64nmq+ydCDHUSyQzMov3u0a4b4dqcsv4+ov4zx3+dYRYYgo7kteBfMY+4
         O0tKWaqWD8c2rC1d4dZ0O7ViPvihhqhfTsARx4fuLzkmVGF1RS4bQseERC4EKXr6luir
         yu4+T3jbqbAISHBeXZCW0F2cn5XXEX/t4iUDOCrWT/co1SPL8W2ze2KU5jAGb/+hiKJz
         YnT3kjDbjC7ij04supuhdSLIVQ4V4+u7NTHyXpvdaSAJPU9VSTFNDTcuKRabrCGOnjJ9
         GD3A==
X-Forwarded-Encrypted: i=1; AJvYcCWYjullHhEm/ApS72pX/MyzbmSlMLYhMQGOlqVy1wOfLUHz7t+mNxVPghGRwi2XkDuWEp2J/Fc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjHm+MZezV0Zcaj0yhYk3jmrcoZeg0fVvkcZnvlbUVFW4xsPhW
	yVAMuDXC+NbXAb2M0aovLC5oB5sKWJNm+j1EscetpKYQ3SjBtuZreFqyTQ1+3wsW60ul+A5oG1J
	sM2aTAv8IUW6c0eomvIbTA2l4QzUaR3w=
X-Gm-Gg: ASbGnctQuNYCyMluCht3kcWp7jQrz8314utG7NX4oo2ZsyGNKXTtnC38qqtGklUr7W7
	kgYHfz1cDP4ytEI6OfBAbuQjtOdpXJr0S0JEWrJaU1KRG/v/rTMtQUsyhKmvYF+uc9QyTMcYs7J
	zKT5ZxuSE5hSnJqH2Y2xNVYfsjQ1o6n9MhtQviwY7Ohy7GxfpqVNsKFEWqbQ7LA2w9jmOf18PXX
	5weH2oHP1qXusyLb4xW9xEWC/J7ZovKxtbwlbyMhtZqnuw4sALEHw1PBvtho4FU0RuvCmuCTMiW
	1J5i+4YzAJXBh+JcNOSlu7zYDx7IGCw55IkAkoPJ+GkUYf07yz3NI7stoJUnpBhUG0RMqhBwQwq
	mfedQruBVL0kSbrV6CMc3z+W9hxqiAQpJqg11STBtXzdpZjPIrfPRGQcxUgpfShqNf59KR3Lh+c
	6bsaAcAvFtIg==
X-Google-Smtp-Source: AGHT+IH51IPA7dnzkdqYSZ2c+m1BcbaD/LmQCjY7kHofERYTrCSZPA7X/dmVToNHWejPwJa3FQbJ9WQmLnwdKf1qxmQ=
X-Received: by 2002:a05:6214:4a8a:b0:880:2b54:2b91 with SMTP id
 6a1803df08f44-8863af6db9fmr78215956d6.36.1764115318151; Tue, 25 Nov 2025
 16:01:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251124200036.1582605-1-pc@manguebit.org>
In-Reply-To: <20251124200036.1582605-1-pc@manguebit.org>
From: Steve French <smfrench@gmail.com>
Date: Tue, 25 Nov 2025 18:01:44 -0600
X-Gm-Features: AWmQ_bmIm9Tjjon9TNUad3lCMSQ-ZuPZ7ZMab0WfcYrr7nwCar7ff1kHCRms3Zg
Message-ID: <CAH2r5mvMrSxG+qmUz80XXDR-x0XNukdpRBP88KuG0n9mJtxrbw@mail.gmail.com>
Subject: Re: [PATCH] smb: client: fix memory leak in cifs_construct_tcon()
To: Paulo Alcantara <pc@manguebit.org>
Cc: Jay Shin <jaeshin@redhat.com>, stable@vger.kernel.org, linux-cifs@vger.kernel.org, 
	David Howells <dhowells@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

merged into cifs-2.6.git for-next and added RB from David Howells

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

