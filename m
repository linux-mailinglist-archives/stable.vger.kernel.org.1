Return-Path: <stable+bounces-77887-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54CCD988032
	for <lists+stable@lfdr.de>; Fri, 27 Sep 2024 10:22:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E59D5281CC4
	for <lists+stable@lfdr.de>; Fri, 27 Sep 2024 08:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F5D6181339;
	Fri, 27 Sep 2024 08:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="JgPV0iML"
X-Original-To: stable@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 451591741EF
	for <stable@vger.kernel.org>; Fri, 27 Sep 2024 08:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727425363; cv=none; b=rYYPQnClKg2F6GJwZkbgibDn4Z+hqUKsxmiPggwBEZmRm45u/9A52KlVA7TY+4Uf1SMVFwlwLmDs/agDA6kIdqoD6o/DphOqNRoZ1D+aRmnnz8swBnjGyUsWWVLLeSHUABYLE0wpX3a31OVuPcYM4sCr4+TTFXXogbanzU4L9n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727425363; c=relaxed/simple;
	bh=nCofjQvqVmGPYIlxe6BoJ7pyKEd8n5AkGXr9/7mxEVc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GHWQoUZ6Ebw1/OCQ2qtn36d5EKHvB1Yn++wm+AOcIduXZpAXqGnQ3Vch7GNfzEBKwcvobTXcfHSjaRJFJ/xF9jF4ACH2vQlnyxyxq9tEE1KCulXJi8gH5nWbhxlLHWxW7Wn6PWRUviU/MynDwi7pKfal6cc4zGtNK2UKNXpEodw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=JgPV0iML; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com [209.85.221.200])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 8AA9C3F1BD
	for <stable@vger.kernel.org>; Fri, 27 Sep 2024 08:22:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1727425358;
	bh=6o4BzwXJTtkXK6Zwi1/UCNsYes9vFKCE8U5Ra86zWN0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=JgPV0iMLeCOjvu9M3A8tLzf2+9OXjsayLgON2dPU/uL7ERJkVkctlEftiinwU4LRw
	 UaQTDhktj99PXqm9dlCsFlxRNXacOHucL2Afes+AM28xMSqNxP57qhGsdhE7lpeviB
	 5sfBRV1Iogm3RXM5KSabekQDLek0RAbVGY/Xt48bAAXF8Y3hASm7K8aFi/dqP1qamY
	 LDmPug5lVSoGT3cYnnyJZt0vnRE6whZmtivw7V6+cxJUExTV+J5/bvDrZjI1U0cP37
	 l9b616LtbQXIKRWIr3bAGmsIEIU/NFSqOjwRKz1y+dcxqUYa7Pfv+UcAxhPj9PxpS0
	 M8ldQ3dVhB2OQ==
Received: by mail-vk1-f200.google.com with SMTP id 71dfb90a1353d-5011e38919dso544113e0c.2
        for <stable@vger.kernel.org>; Fri, 27 Sep 2024 01:22:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727425355; x=1728030155;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6o4BzwXJTtkXK6Zwi1/UCNsYes9vFKCE8U5Ra86zWN0=;
        b=tw5EXZY24CicMw0jN7Gja/6ok2WuUlxlllTBweqttPWHXZxLmjmLSswcq8URyrZ1ox
         lCzrXN0A2k6ZkK/9JPzZ5vdKyzK+JXcUjXnzFLEE84Zqv6C0d8XnzDY4KY2/bCUSnCex
         csb7PvgpM0BkKcJ5T9TVbQS12ihiHkI14140s1ap+EVVI9QHAymnMlZ0dV7a9/mHeu7F
         BfR38pSutsD2sHcFgF4e8VtTcNYMqrKYXD7py5pJmzItsgWn5uK4at2koUkPjHpHgWDN
         z8on2V8gfAswQYurq4Q3ppKqsM39kmD0cfyaY08+2osbKi9VtjBd//buKtpYrX3TVjHa
         U6og==
X-Forwarded-Encrypted: i=1; AJvYcCWE1s5/l5YugBByHn2zE7PDJgP078E2lX8bOLVSal8I7hGp7FZDwdkJpAqbF+hmhdeOcmKDmeI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMtGDNfhNy+sHta87cQaTHG10XWzTC/N5LsSAAhUoIRSgXKMOV
	DfjcmIT52QSfHd6lelAkyMKvz1p1llJxPwjTQ98YuLxukoc81yeb7rS5hF8trt7E/JiiKOfrGCZ
	kzdKjahEfnJUnI0XBqgoKzXtAnk0nzF1xM0kkdlsDtwou/qVz9saRmGdR1YRdO7HgAHP6+AJGp8
	EaV6h9QieGaLzbmQv5aqYAgnNzfR0oBzh4JoN+ZH8MbSUP
X-Received: by 2002:a05:6122:2210:b0:4f5:2276:137c with SMTP id 71dfb90a1353d-507818a2492mr1709921e0c.8.1727425354649;
        Fri, 27 Sep 2024 01:22:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFqpL30ZkblX/b944Huzx7lqUbyEFfDe+FJLlF1k9fhXsMfFJZLEfn4eshi1gmcIvh7QJhcfAr0c3paWnuNKZE=
X-Received: by 2002:a05:6122:2210:b0:4f5:2276:137c with SMTP id
 71dfb90a1353d-507818a2492mr1709910e0c.8.1727425354306; Fri, 27 Sep 2024
 01:22:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240927063620.2630898-1-libaokun@huaweicloud.com>
In-Reply-To: <20240927063620.2630898-1-libaokun@huaweicloud.com>
From: Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Date: Fri, 27 Sep 2024 10:22:23 +0200
Message-ID: <CAEivzxej-DiXpkcQeYrVVPXbXXnCf=4d3EWyhw8euwBjuB8S9w@mail.gmail.com>
Subject: Re: [PATCH] ext4: fix off by one issue in alloc_flex_gd()
To: libaokun@huaweicloud.com
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca, 
	jack@suse.cz, linux-kernel@vger.kernel.org, yi.zhang@huawei.com, 
	yangerkun@huawei.com, Baokun Li <libaokun1@huawei.com>, 
	Wesley Hershberger <wesley.hershberger@canonical.com>, 
	=?UTF-8?Q?St=C3=A9phane_Graber?= <stgraber@stgraber.org>, 
	Eric Sandeen <sandeen@redhat.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 27, 2024 at 8:39=E2=80=AFAM <libaokun@huaweicloud.com> wrote:
>
> From: Baokun Li <libaokun1@huawei.com>
>
> Wesley reported an issue:
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> EXT4-fs (dm-5): resizing filesystem from 7168 to 786432 blocks
> ------------[ cut here ]------------
> kernel BUG at fs/ext4/resize.c:324!
> CPU: 9 UID: 0 PID: 3576 Comm: resize2fs Not tainted 6.11.0+ #27
> RIP: 0010:ext4_resize_fs+0x1212/0x12d0
> Call Trace:
>  __ext4_ioctl+0x4e0/0x1800
>  ext4_ioctl+0x12/0x20
>  __x64_sys_ioctl+0x99/0xd0
>  x64_sys_call+0x1206/0x20d0
>  do_syscall_64+0x72/0x110
>  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> While reviewing the patch, Honza found that when adjusting resize_bg in
> alloc_flex_gd(), it was possible for flex_gd->resize_bg to be bigger than
> flexbg_size.
>
> The reproduction of the problem requires the following:
>
>  o_group =3D flexbg_size * 2 * n;
>  o_size =3D (o_group + 1) * group_size;
>  n_group: [o_group + flexbg_size, o_group + flexbg_size * 2)
>  o_size =3D (n_group + 1) * group_size;
>
> Take n=3D0,flexbg_size=3D16 as an example:
>
>               last:15
> |o---------------|--------------n-|
> o_group:0    resize to      n_group:30
>
> The corresponding reproducer is:
>
> img=3Dtest.img
> truncate -s 600M $img
> mkfs.ext4 -F $img -b 1024 -G 16 8M
> dev=3D`losetup -f --show $img`
> mkdir -p /tmp/test
> mount $dev /tmp/test
> resize2fs $dev 248M
>
> Delete the problematic plus 1 to fix the issue, and add a WARN_ON_ONCE()
> to prevent the issue from happening again.
>
> Reported-by: Wesley Hershberger <wesley.hershberger@canonical.com>
> Closes: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2081231
> Reported-by: St=C3=A9phane Graber <stgraber@stgraber.org>
> Closes: https://lore.kernel.org/all/20240925143325.518508-1-aleksandr.mik=
halitsyn@canonical.com/
> Tested-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
> Tested-by: Eric Sandeen <sandeen@redhat.com>
> Fixes: 665d3e0af4d3 ("ext4: reduce unnecessary memory allocation in alloc=
_flex_gd()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

Thanks, Baokun!

JFYI, I'm on the way to submit a test to xfstests suite.

Kind regards,
Alex

> ---
>  fs/ext4/resize.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/fs/ext4/resize.c b/fs/ext4/resize.c
> index e04eb08b9060..397970121d43 100644
> --- a/fs/ext4/resize.c
> +++ b/fs/ext4/resize.c
> @@ -253,9 +253,9 @@ static struct ext4_new_flex_group_data *alloc_flex_gd=
(unsigned int flexbg_size,
>         /* Avoid allocating large 'groups' array if not needed */
>         last_group =3D o_group | (flex_gd->resize_bg - 1);
>         if (n_group <=3D last_group)
> -               flex_gd->resize_bg =3D 1 << fls(n_group - o_group + 1);
> +               flex_gd->resize_bg =3D 1 << fls(n_group - o_group);
>         else if (n_group - last_group < flex_gd->resize_bg)
> -               flex_gd->resize_bg =3D 1 << max(fls(last_group - o_group =
+ 1),
> +               flex_gd->resize_bg =3D 1 << max(fls(last_group - o_group)=
,
>                                               fls(n_group - last_group));
>
>         flex_gd->groups =3D kmalloc_array(flex_gd->resize_bg,
> --
> 2.46.0
>

