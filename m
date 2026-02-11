Return-Path: <stable+bounces-215768-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UIG8IZJEjGlxkQAAu9opvQ
	(envelope-from <stable+bounces-215768-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 09:57:54 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E1DBE122759
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 09:57:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 83813301AF61
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 08:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8019735294E;
	Wed, 11 Feb 2026 08:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gUVcwaIG"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F3481BBBE5
	for <stable@vger.kernel.org>; Wed, 11 Feb 2026 08:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770800259; cv=pass; b=O8EHYULXaCMEvcKHwsFFwYaOrEGNDE9bKN5lMaluHGIR2/9EodSaKtDhccBn0kP19kK7j/1vh2YpGzxE/Pv6fw3F2J22e8MlWwAgXm3fqAn8vlS4A7OWlKGisvdGgq2jAidTrfCuqyYgawpY4DaKpkGI7YQUY8bafuyyEl/7CsM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770800259; c=relaxed/simple;
	bh=CnJdoUqw+NNkumwonbn2O7O4fLspWMM1fKB6A3EqAJk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pvNTW6DOu3GDBEFz/Slo1ZA3BjPorrUE5sY4FJOQdPnQ8n6pri0KPqsmDAwSMDWTb3MflehhyGeEbWpcFCSSdMk2Af1GbhzkG4tgmAzWaE+tJiuUX4ptDEBy/ILQZKEWnijHwRtMwdRyxFgDVfuvpawXjKblzklNg0LdbQHgfq0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gUVcwaIG; arc=pass smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-658ad86082dso7390426a12.0
        for <stable@vger.kernel.org>; Wed, 11 Feb 2026 00:57:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770800256; cv=none;
        d=google.com; s=arc-20240605;
        b=Je0iXL1u0Qzl8V8xxg2ECwVPIAcyjNzO1H5Mbxy8ffZyhHZwVRj4RGp5YQV+vxhLUW
         5LyfQUNJDU9yyanBr78mNSc5bT3Xxss7qBo63QouVvQS9YDYhAbiz4YoCJR717ImKaHY
         x8jwlmLHrvQxsa+1Mg3rBHKNUwdxnkx6KuheDlpaCRKDbPpoYeIlIe5Wi2mf220IApQk
         0JVHzf1qzAOBoZRvxLqNzTRRzVIQUW2904Q9eB3RAiL7692UYfJoln3OfJH8jz7PQ7pQ
         KjkS3/xiXeUlvq5P/RnitTYkjSKyiDAzIXcDpMd1TgTDQeHmwoUj6g1UU9uLmAKBmxcW
         HzGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=o4A7oKwEiC9tREor63KRS1zCNiVlkxcuV2TlnBTX3Wg=;
        fh=G5kuo53120+tU4g/mB8tTvnpiYczKv5BDRezl9sJglk=;
        b=NjGrQkqLbs9h/VlA4SwTP5wrJL/UCJ6ZEt9VkzQXij7Q425Pr+wqyYV4LYu47SXPFn
         SGPaydXDJbcw76xxcTPhDN0aazF+oXdXy0N2fXM/dPVi6XOQdW1bCHJvDgaa6uH/XqWk
         nO8Vji2+p1azey+hvekCVSgtXLuBaWeWnoQGR3IQij7S8JYXBWvHOxrVAeqh1QrPzXE5
         Jv3MSNVfHE68dhPQYSJVNelAetoMas5pr5GjDkrST9R6VUzvciqvrJBT3pjVJD1euRwp
         PqAEdMq8fHJDQazZyU9j2ZjCfExSUQTtwhH1wMFtE9Jp0aPrg60/zBO7d5cB+SBa0msU
         QqHQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770800256; x=1771405056; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o4A7oKwEiC9tREor63KRS1zCNiVlkxcuV2TlnBTX3Wg=;
        b=gUVcwaIGn0aDWUmLHalWJqvJvPwlosY1Biw/m+75rP7ViPxIrS18gQzhM4jFWIMPnh
         lE8xl8CT0wXiVbCWXAPe4OnqdvhWmgOcySvP4ML0Sr7L5y6u+UcDfxCbbhfgXmtYx+yY
         pCfVXjmAE6WNh7u/bmr+sKz18v7AYrfeP5EmV5rKST17lj3VTunAm0dBJuJNzapnAOU2
         Zm/MyqRWA8qUAmqRuguFXHEQqVmYnYmX81huBayme1rG//ktn6WpbHuX0x/XetmzXuVN
         bp0c6IoOkQxzNHdvc1mQl6Qdvs1uv/bhuqPfaHbbMRMLKR8lfrS8JUTFZeZIZpOR5Xfc
         5+3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770800256; x=1771405056;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=o4A7oKwEiC9tREor63KRS1zCNiVlkxcuV2TlnBTX3Wg=;
        b=sZI9qhA1sO5FRGEqtowyueDBZPesHK9Cr4c89PKf9xeRTkxmL8KjhQaAmlOiKHSpx2
         FPbsOFcpBP4os6jYnFxOvm3NTV40ztpT4sbEt4bqCaYkfC3PZGtLYvgGeMNCVDiRBHAj
         qabX6SACkj6BdTN6fOYQ/q5Uc+L6/exGRzTZSYLR6VJA1NlO+EqZv7A0gXvtZxbU597w
         box6d4a+ub9MX8VqXGfzQZTr4qxl85R6bbKmyZ5P+73fUcUJFGXSMDYJ1hWNQ9tl1k9+
         1gaXELqD6HJP+BySu9LBM0mS07XBgBBE9zYg9Y9XKX8dknsAYagPtrB1IEuApAw7J5/M
         /FjQ==
X-Forwarded-Encrypted: i=1; AJvYcCVSWDlamWiecDj+pZsEB/tgyOt6YJw1p4e4OqhMzTqdSlnVokC4xGXlbvijY4VwItfTVyxUODI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvVg9s6JrIzH0LzWgTzgtwOc4NoqT57fL0TAI3vJaMeGXE25yK
	IZbV66qHopxz9P0P4F0fa6wDYDkk4WvIgysWceVrXOTt5hA+V/7ILKYO5+T/TP88AD44zjKTwKQ
	x85Mi8JFk3WoKrzRgN5FKx9/408jf8yA=
X-Gm-Gg: AZuq6aJV4sYrT34fNg7cPg4AwK0HWM6b9se6EnnTQh0gIVImNRWU5mZVca3QOQ/y8Dd
	pmaopf1LjCsvuzBNvLSoCsGqWybQmoJ3krtMNH4uh0ni9KLFdYBmjy13xiBYAX6d8yho1liZUS1
	JUoF73PS+Wpy0PY/9YFwn4b4lOtUvxu5atvX40pxApNFBtpq20F3HZ81D70D0GNbVs2EOPLx7Hl
	tIBXSMRCxB/EEfNFu86LMncugm9Ub++TP02558wA1wDYHfpu6eLmVo8shO949ZP56gzIT2BkqGA
	I8bBFDj3c7rI+/g+28qCrliNMCu6VFbBENoxJ6QT4A==
X-Received: by 2002:a05:6402:440b:b0:65a:390a:2070 with SMTP id
 4fb4d7f45d1cf-65a39d77b56mr877040a12.32.1770800256118; Wed, 11 Feb 2026
 00:57:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260210095042.506707-1-amir73il@gmail.com> <bc7dga4oxvoqevokdzffl25mh7uawx3rfvz5q2goyz4z76l65r@bp4vpjmzmbhk>
In-Reply-To: <bc7dga4oxvoqevokdzffl25mh7uawx3rfvz5q2goyz4z76l65r@bp4vpjmzmbhk>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 11 Feb 2026 09:57:24 +0100
X-Gm-Features: AZwV_QitR5W3f8iFDVsYJmYjvRxXqh09fxnrYIv9SScVINHDL8Ucz3R_YFw9jvI
Message-ID: <CAOQ4uxgVhPCxc2369purMTSU9sQuPuR+xBXBYoAbZ7ugVufSmA@mail.gmail.com>
Subject: Re: [PATCH] fs: set fsx_valid hint in file_getattr() syscall
To: Andrey Albershteyn <aalbersh@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>, Jan Kara <jack@suse.cz>, 
	"Darrick J . Wong" <djwong@kernel.org>, linux-fsdevel@vger.kernel.org, 
	syzbot+fa79520cb6cf363d660d@syzkaller.appspotmail.com, 
	Andrey Albershteyn <aalbersh@kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-215768-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[amir73il@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable,fa79520cb6cf363d660d];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: E1DBE122759
X-Rspamd-Action: no action

On Tue, Feb 10, 2026 at 6:45=E2=80=AFPM Andrey Albershteyn <aalbersh@redhat=
.com> wrote:
>
> On 2026-02-10 10:50:42, Amir Goldstein wrote:
> > The vfs_fileattr_get() API is a unification of the two legacy ioctls
> > FS_IOC_GETFLAGS and FS_IOC_FSGETXATTR.
> >
> > The legacy ioctls set a hint flag, either flags_valid or fsx_valid,
> > which overlayfs and fuse may use to convert back to one of the two
> > legacy ioctls.
> >
> > The new file_getattr() syscall is a modern version of the ioctl
> > FS_IOC_FSGETXATTR, but it does not set the fsx_valid hint leading to
> > uninit-value KMSAN warning in ovl_fileattr_get() as is also expected
> > to happen in fuse_fileattr_get().
> >
> > Reported-by: syzbot+fa79520cb6cf363d660d@syzkaller.appspotmail.com
> > Closes: https://lore.kernel.org/r/698ad8b7.050a0220.3b3015.008b.GAE@goo=
gle.com/
> > Fixes: be7efb2d20d67 ("fs: introduce file_getattr and file_setattr sysc=
alls")
> > Cc: Andrey Albershteyn <aalbersh@kernel.org>
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > ---
> >  fs/file_attr.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/fs/file_attr.c b/fs/file_attr.c
> > index 53b356dd8c33a..910c346d81bcd 100644
> > --- a/fs/file_attr.c
> > +++ b/fs/file_attr.c
> > @@ -379,7 +379,7 @@ SYSCALL_DEFINE5(file_getattr, int, dfd, const char =
__user *, filename,
> >       struct filename *name __free(putname) =3D NULL;
> >       unsigned int lookup_flags =3D 0;
> >       struct file_attr fattr;
> > -     struct file_kattr fa;
> > +     struct file_kattr fa =3D { .fsx_valid =3D true }; /* hint only */
> >       int error;
> >
> >       BUILD_BUG_ON(sizeof(struct file_attr) < FILE_ATTR_SIZE_VER0);
> > --
> > 2.52.0
> >
>
> There's same patch a bit earlier from Edward
> https://lore.kernel.org/linux-fsdevel/tencent_B6C4583771D76766D71362A3686=
96EC3B605@qq.com/
>

Nice. I'm fine with taking Edward's patch.
With addition of the Fixes: and cc: stable tags.

Thanks,
Amir.

