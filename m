Return-Path: <stable+bounces-239995-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oDh5AwiL5mkGyAEAu9opvQ
	(envelope-from <stable+bounces-239995-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 22:22:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CAA7433A56
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 22:22:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 04FF63009CF2
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 20:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A92D3CF02B;
	Mon, 20 Apr 2026 20:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C7ffKQy4"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916CA383C74
	for <stable@vger.kernel.org>; Mon, 20 Apr 2026 20:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776716378; cv=pass; b=ie7UZ6Q8esM9VtaUshb/O3Zzn7JanfUWO2GWSpEdOo264hUBEDyLCYlEQlYbEJ53c2wi96tfWdEW/E6Y9KRRjjG5h0RKVZKd4TG4SFFkvXCAddhFqb4g7hRJoOZk06l14Zkjmk1zieg/JWmpNoNv2wq9vRT/QHjrbjLUBJuWIEI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776716378; c=relaxed/simple;
	bh=n6ym533tI9X4A+vTCccKlmH4/q2ObDK27zNE5dOfzKQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dt/xOglb+6uXeIwfijsb7ljV8/IEEMQolonb8OeXdMP0IcaHe5USI/fLbYveAsfuVyvtuRPfBkzZ26Wob1Y76noDhygJMm/64PZ7pEc12VmqUeT0bhMBaZOuHwVqdJTbytk6z3b8bdt6OhKa9/a8Rnw89xLo+KYKWgepg+yBPys=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C7ffKQy4; arc=pass smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-12c7212836bso9160991c88.0
        for <stable@vger.kernel.org>; Mon, 20 Apr 2026 13:19:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776716377; cv=none;
        d=google.com; s=arc-20240605;
        b=cUSwYHZ736jnM9UqPZa0fjFlCcmCZVRTpcsNSqm4CLQZLIYWinW771nMyHNSmzyhSc
         GQxe4w2vIPSLOm9Qa2ZYDyaBbPGvd/B6eC4ART074/yXC7TtZuTNIVnu5zxAKs/+nl2l
         nPApl0/qac6ocY0/Y4R94O87XKGHBbVGd17A0CZTFQYfOGwLxEVyQcq7b4O+/iFzUAZ0
         iS57Bk/u23fNPnPF3t0T0fOtMM/vJqrV6Vq8+fiwa8Vg1/pjYpoQiRd/F5Tb6cInGwq+
         q2eu3CXN1r/d4IcFPHuebZZQO9W2eStM2QuxF55f1e17lji9bb1AmV6VIweJGMFz5fMJ
         /6Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FDLi2AIEvf/8R/CKyK1q6WR933rqVLVDLFbXt/wFzeE=;
        fh=/0ArM7Jrq8YfYLk0bduQyu9pKFKQuxCrOy/lGiuDTBM=;
        b=atRDmfOOkZZv1ivWlD+DK3B9ou7y9ll9NGMvVivaR3qLSDhtwUNkmq6QAlNd9H2EUI
         bLyTLXa2ZljddSQkfEAMgmb5w94r/LQLuZnQeGtdZ0GbCFEQgAwCa+k44NeWSOoDPCkt
         3WA6mczFVthvD2NiJoLS94JIfGuBZFgeKbK3o2BhCSwY/sYODQlnVM1zUkZLs2XpIz/L
         2hWZ3MjYbI7xSBTqFru958m587bJkzT1IcaV8fSFqtx+GgraUUSmH3SPFA9b9EMOpYD7
         jYke8sZAVqHEwWMZbWp0gIEZKD/fOeBa/an/8jkINVm+E37N/dozLDpaF8d4fsyjS5c5
         UngA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776716377; x=1777321177; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FDLi2AIEvf/8R/CKyK1q6WR933rqVLVDLFbXt/wFzeE=;
        b=C7ffKQy44m4ZxbpuAU5mPeNwWgUwzmXO7L5cLcQ72XyL9K2REzPgFaZVYwBz+Imo9k
         3kCcUZBLYZVYwZ0E9/DXoRIQelEPss6G9vbrQ70maGYmDmAV/jeFBOwO/SAWgsW2UDO3
         KizEnyRxHU3UiW9Yl3We4RlWSoYWmOSZw9swqb7BTN6SL3t4cHziCSVHbIqA1ALwl6EQ
         m54g8pHAwzMnBIeOfr4ncTtxDIcixXgtbyMx31gyh/9Kd6p5mNlaYIJIQAj0W2YuJpSL
         yquBk+tn17bSblysF2CP3Rly02NFXHdrL2R1Dishkto7BK3XtjmZxKayBx1IxhdEcYWT
         eB5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776716377; x=1777321177;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FDLi2AIEvf/8R/CKyK1q6WR933rqVLVDLFbXt/wFzeE=;
        b=EtrXqzbcpZBQ61PhGUl7fl0vobHvlpNePmwafyzGMWLV5ABmV8lTo+Q/oKMLFUx48q
         F/6meVqwiFulb5vUhvyV/H6LUDMVgPSrO5+OVYkn39nP+qHUr0YFxD0Y2LqHTVYkdtGg
         IdLlIFAaxgADbF+cSwBEV0I8rsWA53yzY0EyKr8FI0oapDqZRQUox0h8eDM0LThyTbsA
         ZpBOejbzM6djyeAWxqeKtvrWZF8hAEPe99Cuf6ct07XV2MCl8FaDazUgi8ufKqTyO3np
         SUz40fovr7g9jcWHypTs6ZUkJFGvFwniJ7+Ee8EF5IJ9jHeXyv5+cdq/9uudw7lHaWVc
         1kDQ==
X-Forwarded-Encrypted: i=1; AFNElJ/r+JPpmXd0rQVdsUzgdzJU4fwl6lv7OmTOvRCgXn4fQkdmgmkqtOzQ9uIsolw2Eim6Yeg5VZM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbT/4L4TED7Q3sF869M2ydkKMSQWfky36a6GSwu5Exw/CHPNfn
	Idqr9Xzc0Xex64xkqlHQYTDzBunp7nfFkSVbWa5ulyTtkWqRi2hwsV2MwalJ7ZzvHykSwuUdRkn
	lkop6K6Q288m8BR4dYZghghU+E9nxOaI=
X-Gm-Gg: AeBDiesZG5sX8cpfrT9TtsL+UQLeSZacrQNkP7pcnfTvAtTv8QNS15N4nmrWeVrqlnR
	MOY0aLJOEpSjPsE1HfPrfHGUmD2RonJNSqASyrJXjZoY05bfLs/ULrI5Gm4qx/dRuLShNh035oM
	3ko5JQWbu9pcIL8vKttI9MmO9nyojskP4jw4XITKr9IOnySWS6WlnGhKDgstYbegPaLsA0PpMxS
	HnDnSzQ7IgLbgINQZmewxQP50lWV0OFvMPwiFIf/JAp+2i/yF7IAAxvPbO+sSvK4dCCiGTxyXN+
	4KD2nAznETZx3vVKMw==
X-Received: by 2002:a05:7022:388f:b0:123:348d:8576 with SMTP id
 a92af1059eb24-12c73f6d905mr8911688c88.6.1776716376624; Mon, 20 Apr 2026
 13:19:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260419090348.1817082-1-dawei.feng@seu.edu.cn>
In-Reply-To: <20260419090348.1817082-1-dawei.feng@seu.edu.cn>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Mon, 20 Apr 2026 22:19:24 +0200
X-Gm-Features: AQROBzDaUIcoZgaW9hqmajL0d6VdpXPApMsC-41ShvD5oOsBEcAdne8_Gp_irWE
Message-ID: <CAOi1vP9haWQQ5UAGuz1GrtL68Yc=w_od4a9GV8gfVoqKMyVn3Q@mail.gmail.com>
Subject: Re: [PATCH] rbd: fix null-ptr-deref when device_add_disk() fails
To: Dawei Feng <dawei.feng@seu.edu.cn>
Cc: axboe@kernel.dk, dongsheng.yang@linux.dev, mcgrof@kernel.org, 
	ceph-devel@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, jianhao.xu@seu.edu.cn, stable@vger.kernel.org, 
	Zilin Guan <zilin@seu.edu.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-239995-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idryomov@gmail.com,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Queue-Id: 5CAA7433A56
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, Apr 19, 2026 at 11:05=E2=80=AFAM Dawei Feng <dawei.feng@seu.edu.cn>=
 wrote:
>
> do_rbd_add() publishes the device with device_add() before calling
> device_add_disk(). If device_add_disk() fails after device_add()
> succeeds, the error path calls rbd_free_disk() directly and then later
> falls through to rbd_dev_device_release(), which calls rbd_free_disk()
> again. This double teardown can leave blk-mq cleanup operating on
> invalid state and trigger a null-ptr-deref in
> __blk_mq_free_map_and_rqs(), reached from blk_mq_free_tag_set().
>
> Fix this by following the normal remove ordering: call device_del()
> before rbd_dev_device_release() when device_add_disk() fails after
> device_add(). That keeps the teardown sequence consistent and avoids
> re-entering disk cleanup through the wrong path.
>
> The bug was first flagged by an experimental analysis tool we are
> developing for kernel memory-management bugs while analyzing
> v6.13-rc1. The tool is still under development and is not yet publicly
> available.
>
> We reproduced the bug on v7.0 with a real Ceph backend and a QEMU x86_64
> guest booted with KASAN and CONFIG_FAILSLAB enabled. The reproducer
> confines failslab injections to the __add_disk() range and injects
> fail-nth while mapping an RBD image through
> /sys/bus/rbd/add_single_major.
>
> On the unpatched kernel, fail-nth=3D4 reliably triggered the fault:
>
>         Oops: general protection fault, probably for non-canonical addres=
s 0xdffffc0000000000: 0000 [#1] SMP KASAN NOPTI
>         KASAN: null-ptr-deref in range [0x0000000000000000-0x000000000000=
0007]
>         CPU: 0 UID: 0 PID: 273 Comm: bash Not tainted 7.0.0-01247-gd60bc1=
401583 #6 PREEMPT(lazy)
>         Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.15.0-1=
 04/01/2014
>         RIP: 0010:__blk_mq_free_map_and_rqs+0x8c/0x240
>         Code: 00 00 48 8b 6b 60 41 89 f4 49 c1 e4 03 4c 01 e5 45 85 ed 0f=
 85 0a 01 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 e9 48 c1 e9 03 <80> 3c =
01 00 0f 85 31 01 00 00 4c 8b 6d 00 4d 85 ed 0f 84 e2 00 00
>         RSP: 0018:ff1100000ab0fac8 EFLAGS: 00000246
>         RAX: dffffc0000000000 RBX: ff1100000c4806a0 RCX: 0000000000000000
>         RDX: 0000000000000002 RSI: 0000000000000000 RDI: ff1100000c4806f4
>         RBP: 0000000000000000 R08: 0000000000000001 R09: ffe21c000189001b
>         R10: ff1100000c4800df R11: ff1100006cf37be0 R12: 0000000000000000
>         R13: 0000000000000000 R14: ff1100000c480700 R15: ff1100000c480004
>         FS:  00007f0fbe8fe740(0000) GS:ff110000e5851000(0000) knlGS:00000=
00000000000
>         CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>         CR2: 00007fe53473b2e0 CR3: 0000000012eef000 CR4: 00000000007516f0
>         PKRU: 55555554
>         Call Trace:
>          <TASK>
>          blk_mq_free_tag_set+0x77/0x460
>          do_rbd_add+0x1446/0x2b80
>          ? __pfx_do_rbd_add+0x10/0x10
>          ? lock_acquire+0x18c/0x300
>          ? find_held_lock+0x2b/0x80
>          ? sysfs_file_kobj+0xb6/0x1b0
>          ? __pfx_sysfs_kf_write+0x10/0x10
>          kernfs_fop_write_iter+0x2f4/0x4a0
>          vfs_write+0x98e/0x1000
>          ? expand_files+0x51f/0x850
>          ? __pfx_vfs_write+0x10/0x10
>          ksys_write+0xf2/0x1d0
>          ? __pfx_ksys_write+0x10/0x10
>          do_syscall_64+0x115/0x690
>          entry_SYSCALL_64_after_hwframe+0x77/0x7f
>         RIP: 0033:0x7f0fbea15907
>         Code: 10 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 f3=
 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 01 00 00 00 0f 05 <48> 3d =
00 f0 ff ff 77 51 c3 48 83 ec 28 48 89 54 24 18 48 89 74 24
>         RSP: 002b:00007ffe22346ea8 EFLAGS: 00000246 ORIG_RAX: 00000000000=
00001
>         RAX: ffffffffffffffda RBX: 0000000000000058 RCX: 00007f0fbea15907
>         RDX: 0000000000000058 RSI: 0000563ace6c0ef0 RDI: 0000000000000001
>         RBP: 0000563ace6c0ef0 R08: 0000563ace6c0ef0 R09: 6b6435726d694141
>         R10: 5250337279762f78 R11: 0000000000000246 R12: 0000000000000058
>         R13: 00007f0fbeb1c780 R14: ff1100000c480700 R15: ff1100000c480004
>          </TASK>
>
> With this fix applied, rerunning the reproducer over fail-nth=3D1..256
> yields no KASAN reports.
>
> Fixes: 27c97abc30e2 ("rbd: add add_disk() error handling")
> Cc: stable@vger.kernel.org # 5.16+
> Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
> Signed-off-by: Dawei Feng <dawei.feng@seu.edu.cn>
> ---
>  drivers/block/rbd.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index e7da06200c1e..d92730d8c342 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -7165,7 +7165,7 @@ static ssize_t do_rbd_add(const char *buf, size_t c=
ount)
>
>         rc =3D device_add_disk(&rbd_dev->dev, rbd_dev->disk, NULL);
>         if (rc)
> -               goto err_out_cleanup_disk;
> +               goto err_out_device_del;
>
>         spin_lock(&rbd_dev_list_lock);
>         list_add_tail(&rbd_dev->node, &rbd_dev_list);
> @@ -7179,8 +7179,8 @@ static ssize_t do_rbd_add(const char *buf, size_t c=
ount)
>         module_put(THIS_MODULE);
>         return rc;
>
> -err_out_cleanup_disk:
> -       rbd_free_disk(rbd_dev);
> +err_out_device_del:
> +       device_del(&rbd_dev->dev);
>  err_out_image_lock:
>         rbd_dev_image_unlock(rbd_dev);
>         rbd_dev_device_release(rbd_dev);
> --
> 2.34.1
>

Applied.

Thanks,

                Ilya

