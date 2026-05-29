Return-Path: <stable+bounces-256529-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UEsCA6c0GWqDsggAu9opvQ
	(envelope-from <stable+bounces-256529-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 08:39:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 075E85FE0C8
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 08:39:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 706433012E69
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 06:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 426003AA9E8;
	Fri, 29 May 2026 06:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="RyEmuu8v"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1003A3AA18B
	for <stable@vger.kernel.org>; Fri, 29 May 2026 06:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780036766; cv=pass; b=Ad0zvSf3agW0c1vEI88e66KoK1wygJLiyV6gZga6ruJSrdOWP99wsSf623vdC5bMn4tHwphEP+rPpU2kasQxil1+8v45h3fzhCsyXD9vu16AiD82Rz4qyxeoU0Hs5XlBOq1iSEYIV12xau/VzfNU290fQSkFtfNeOA7eQEoUROY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780036766; c=relaxed/simple;
	bh=U5pGGIgBsbfT2iDz1oVTC2NdzvnHgJCRf8Kw/K4DP9s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PLFK+wKHJ0/xVsu+CDgRfLVamo2SM/6ZK70Kq/4fSLwdTXYaqeGbomdTC5IPKssQ3goCKkpOCNpOsngBCYbHh8CcGoybixP+9xt8OAX9gHoGpAEnltZXu7WE5ANU4PMDOEQkJ8rDgUgrarh9BnBBpCNc/PEBjOSgxtW3/k1rZ7U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=RyEmuu8v; arc=pass smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4908b92904fso19863255e9.0
        for <stable@vger.kernel.org>; Thu, 28 May 2026 23:39:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780036761; cv=none;
        d=google.com; s=arc-20240605;
        b=GbM/7hFUIft2RVZKGVNB6UJsIoKHsku63zgVxoMEtlUhMjOwktT6x0J+NlfcbM6zDp
         XZzNmNbfxiFNkWdLKOJRNy3zHH1YiWJy2yd5rpOS5qB9zTDWfhGpPWSYKipEMVoeD6Mx
         yB/7JPuncFTMgn9/4MD9tL6h0OVrBcQAgDoio34ezboEdhv+sT7N5/YexeSymgjUYOrx
         fMvBGnq1U8UMwNHLK0D4OCLzy7N8VHjfsHvvCUM0Wxx0xdW5BripZmqReKAoJXhg5NWY
         ujuGsSNv/VPCngcbMS4sXTkAqFtzrJBz4ksGqg3qgpzah0FGCoI3nexEFy2XE0k3t6OW
         i7Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=0M9tEWd44B5wfjzjs0kSwo4GiNutlPsrp3val3j4oMU=;
        fh=fUIm+TlVUa6xTYIzqvyyLAMrG557BPYMKkTwxGnt7ho=;
        b=fTaQPmxM1IHB6xOmccgEfg4r/9YaraqJqLLe2lCv6Kd3f02EEjEk07CJ4FOnZK7S4C
         EVrrl/DR8KfJ/J4EnXTba8TUr2WY+uvhZyn/K+6QcPbmcEzvmp5ads3ny4Vc8wQBcAVI
         n3gttfYoCKsvNkVRNI45F5uwbbzMJj61BrVUNYPbRm//FXDIXKsad2VqczBpLZPPVx+I
         cLQgCUaY9przFpRmk3IzrRfwhI5etORGO8eI0YQUYDV67P6PkjOShf1UBSAlky7Bkirx
         rYmapt23UpfCPcAhai3TEMj4XP3WAWyq8G1y0pa7lS7A+x2hmbJ+riLu18OMnOdBhXmI
         NvmQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1780036761; x=1780641561; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0M9tEWd44B5wfjzjs0kSwo4GiNutlPsrp3val3j4oMU=;
        b=RyEmuu8vmCqKTJtFU/qZz3ahJuNqhrkV/bbjFeZWOKu5LYjSw6vlkQ8I/HdryrUxIQ
         QpnXmi8kfm+pc2aDzgdL59eYaZhF4UWFlv48QIfIEsAVhK1IUcMMdcjFAxNiPnc9CAnY
         gyw5tOtbaUhQFUeN2yUroYm8TmtMr0Lvohq/945dx5dOTPpFOcf66YUW5fg3C8fmyWSw
         ca4KyktJDkqzmPHzQ+lCwkRwBnUw1NYt9xlGgZW6T7ISryWR3u7g6+6vPTI41OoK8/tP
         ZnM9N/mOBvtoEAe3qYJpDj49dK6WQzFwTRAqnFFKzYUoTssFOz+FHLGdBRGwtn5sHO4g
         uwhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780036761; x=1780641561;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0M9tEWd44B5wfjzjs0kSwo4GiNutlPsrp3val3j4oMU=;
        b=sQtcmJ/bMYXxyr/YpKRnQ4za532zX3sQRqtGoTwW07m7LKlfzT3GcSzYno2gfoqn1a
         aYhgASLNhawh5daIvyGRkYNuo1duLruK9jt8/n2fNxZ054I0yPKYognhTxI5nv5s/TDn
         loC1rtIIpX81tpnq3yuXFFiflDtjUrCU/cJcDfxtjV3uLphY+9Qzbqn1zSZWQ470jjfK
         1t13Je8lB1Y1O4FzZQpirvYA3mR+olMPBU57+RFwLFJPKFoXBNUQAdOkOQdIdotVgN1X
         mx4eye43ZHPWiTN+ExpJqgKuV5db5sK1uK0akZiof/LG2/NsY/cL6sk1qlEn/s7O19bC
         Ih/Q==
X-Gm-Message-State: AOJu0YxHdLr6pa0XhO12C6t1qjPL8h9cFTPBX4NYNYag7pxnIp4YWCYD
	6hYDr4bDCf8RDm5+myliDpKL6LD/co2WjPdGcSmPzM2m4E1ey8z8/1TFm80KuZnBquN0wAWS+Ez
	8sWzaDpIfaJGMWY/bpsElBXB+RK/QsNOMFQ4dAtXyHPJ9E1CEbK0VZhk=
X-Gm-Gg: Acq92OGnUeh3eyP5Z8SubYoozM9JSK7yLwm0msL06nMPWIRWOyzOw9adgTcLcC66xSy
	z0hF3KMWSwiAATbpiK9P0LtHQpIZGAAXP0GjYUKSx/C3zfW+LiUC2xN0QXj9Y/O6ila50q48fhk
	2xowjQDyPdQGZYudNYu4DHXwd0Jh9xa3ZRQEoKWgDIOIm850EsK6eTcxWaluiaNIIwkTbPNc4gT
	GqMWW1L3+GUaoXQ+8EYF34R2y/ywrNayyWwY8TmdCfeA4alo0O/PGMAH+L5Iu6TF0/0HAY4Sk95
	+0Qg9nuO2tv7Y5Q42rx6TNXSKJF6Qh8wz2WALCnZvztWqIBwtmzNkJd3l4wa2saI9PvD/I+rEre
	+x+nApx7KnJHXPBw=
X-Received: by 2002:a5d:624c:0:b0:45e:9db6:89ab with SMTP id
 ffacd0b85a97d-45ef144d201mr1909429f8f.25.1780036761413; Thu, 28 May 2026
 23:39:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260528194638.371537336@linuxfoundation.org> <20260528194647.015775177@linuxfoundation.org>
In-Reply-To: <20260528194647.015775177@linuxfoundation.org>
From: Daniel Vacek <neelx@suse.com>
Date: Fri, 29 May 2026 08:39:10 +0200
X-Gm-Features: AVHnY4LzXZrnviXUAYv5jwpNYGW2RF4f9XnR-Hbr64WGSPyNVFs6kGFmNdIkT-Y
Message-ID: <CAPjX3Ff-a8JHxeMr1Hk83BmQX9YLGNR+g+7waygn43ZD7pWMHg@mail.gmail.com>
Subject: Re: [PATCH 6.18 299/377] btrfs: dont search back for dir inode item
 in INO_LOOKUP_USER
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	Johannes Thumshirn <johannes.thumshirn@wdc.com>, Josef Bacik <josef@toxicpanda.com>, 
	David Sterba <dsterba@suse.com>, Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-256529-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[neelx@suse.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,linuxfoundation.org:email]
X-Rspamd-Queue-Id: 075E85FE0C8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 28 May 2026 at 22:28, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> 6.18-stable review patch.  If anyone has any objections, please let me know.

Hi Greg.

This is not a bugfix, rather, it is a cleanup.
Even though it's kinda small and limited to a single function, I'm not
sure it's worth the stable backport.
Is there any specific reason you picked this patch?

--nX

> ------------------
>
> From: Josef Bacik <josef@toxicpanda.com>
>
> [ Upstream commit 70085399b1a1623ef488d96b4c2d0c67be1d0607 ]
>
> We don't need to search back to the inode item, the directory inode
> number is in key.offset, so simply use that.  If we can't find the
> directory we'll get an ENOENT at the iget().
>
> Note: The patch was taken from v5 of fscrypt patchset
> (https://lore.kernel.org/linux-btrfs/cover.1706116485.git.josef@toxicpanda.com/)
> which was handled over time by various people: Omar Sandoval, Sweet Tea
> Dorminy, Josef Bacik.
>
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Daniel Vacek <neelx@suse.com>
> Reviewed-by: David Sterba <dsterba@suse.com>
> [ add note ]
> Signed-off-by: David Sterba <dsterba@suse.com>
> Stable-dep-of: 1e92637722ae ("btrfs: check for subvolume before deleting squota qgroup")
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  fs/btrfs/ioctl.c | 23 +++--------------------
>  1 file changed, 3 insertions(+), 20 deletions(-)
>
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index c0691e93e0a58..41e549d37aac8 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -1832,7 +1832,7 @@ static int btrfs_search_path_in_tree_user(struct mnt_idmap *idmap,
>         struct btrfs_root_ref *rref;
>         struct btrfs_root *root = NULL;
>         struct btrfs_path *path;
> -       struct btrfs_key key, key2;
> +       struct btrfs_key key;
>         struct extent_buffer *leaf;
>         char *ptr;
>         int slot;
> @@ -1887,24 +1887,6 @@ static int btrfs_search_path_in_tree_user(struct mnt_idmap *idmap,
>                         read_extent_buffer(leaf, ptr,
>                                         (unsigned long)(iref + 1), len);
>
> -                       /* Check the read+exec permission of this directory */
> -                       ret = btrfs_previous_item(root, path, dirid,
> -                                                 BTRFS_INODE_ITEM_KEY);
> -                       if (ret < 0) {
> -                               goto out_put;
> -                       } else if (ret > 0) {
> -                               ret = -ENOENT;
> -                               goto out_put;
> -                       }
> -
> -                       leaf = path->nodes[0];
> -                       slot = path->slots[0];
> -                       btrfs_item_key_to_cpu(leaf, &key2, slot);
> -                       if (key2.objectid != dirid) {
> -                               ret = -ENOENT;
> -                               goto out_put;
> -                       }
> -
>                         /*
>                          * We don't need the path anymore, so release it and
>                          * avoid deadlocks and lockdep warnings in case
> @@ -1912,11 +1894,12 @@ static int btrfs_search_path_in_tree_user(struct mnt_idmap *idmap,
>                          * btree and lock the same leaf.
>                          */
>                         btrfs_release_path(path);
> -                       temp_inode = btrfs_iget(key2.objectid, root);
> +                       temp_inode = btrfs_iget(key.offset, root);
>                         if (IS_ERR(temp_inode)) {
>                                 ret = PTR_ERR(temp_inode);
>                                 goto out_put;
>                         }
> +                       /* Check the read+exec permission of this directory. */
>                         ret = inode_permission(idmap, &temp_inode->vfs_inode,
>                                                MAY_READ | MAY_EXEC);
>                         iput(&temp_inode->vfs_inode);
> --
> 2.53.0

