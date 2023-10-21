Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF0AB7D1B8E
	for <lists+stable@lfdr.de>; Sat, 21 Oct 2023 09:48:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbjJUHsk (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 21 Oct 2023 03:48:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjJUHsj (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 21 Oct 2023 03:48:39 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8411ED63
        for <stable@vger.kernel.org>; Sat, 21 Oct 2023 00:48:37 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-6be0277c05bso1316044b3a.0
        for <stable@vger.kernel.org>; Sat, 21 Oct 2023 00:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697874517; x=1698479317; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=r1xutz7LTe5p5IDnyXEAa0PDO2uLfF5dfuTg07KPHWI=;
        b=h+IS9OU4jnhthWe+mRziTCYairQ5II4O6VaEYafzzBQi7qQsl77hGT1bhfoX+Y6Dm1
         cJyhfWSs4az+SOHTQnDHW2paIbJKTOYznG7ehd/S3HEU+yHCQ4VIcvFdFtKipCQurr/k
         bnwNnB0zU8gkGfDSNOg7IqP2CBC9b2m6lcvw7oyRqiH3QYxkP3e2KPodVxELZoqAdsUQ
         5tHxKnJzYL8vvjlKzAv0ADld2DslC403I+iUZWfFII8jz9RRO73wu2mBeblHmq4UrveF
         1uj6btS4fzzLfjLikYSu8Ej1qIGJqn6D2i6r1h7DNlHDXe1eDqo14fSj2TsPzWh3gNJL
         2wlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697874517; x=1698479317;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r1xutz7LTe5p5IDnyXEAa0PDO2uLfF5dfuTg07KPHWI=;
        b=GWPbYq/feHxwWOtXFj9zSPbFLLco05HXWqNrB2gRUZ2xaGYJzYNox0+GB1UsUwpMwO
         gfvP4IyRTlNzFLdPt9HiF1/2xkJ09H7rhBzXauhtIMXapS/xcLy+85sfUG3rmWeRpYQS
         PfL05/lIDEAX8EgKoqnGaoqCDxXcj1dh8UA8HNtUQkcQvrFSpz1+UDdYSQ+XjKyj+iw9
         Ni1j8aRYev2mrXvSOPJ/G7mRXIgcr92BCD+3NuaCMWxDw58AFnrw7fWf+Lh8KZ9/qqKH
         +ob3Umkfvr111dvZccEnDUpw5ifOSwQiQMVfQPtqggSllMdbNeJNi8yE81OjTNMOYI/w
         LkbA==
X-Gm-Message-State: AOJu0YzhjH8fTTaEKWF64nu64ol6g/E5KhImUBESf6fM+68/3oxv7f2r
        RMRkqK3kXO6hNlsSEVc+TzE=
X-Google-Smtp-Source: AGHT+IHp0C7v9zAaRMiDa0QGAa97lQxgTzpCkqPHLq7nuq2uDV7eNEg4YMelxUJpWlFkL3BJ50qYGA==
X-Received: by 2002:a05:6a20:cea3:b0:174:af85:954b with SMTP id if35-20020a056a20cea300b00174af85954bmr3748696pzb.22.1697874516795;
        Sat, 21 Oct 2023 00:48:36 -0700 (PDT)
Received: from debian.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id fz3-20020a17090b024300b002609cadc56esm2495699pjb.11.2023.10.21.00.48.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Oct 2023 00:48:36 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id E27368C33F88; Sat, 21 Oct 2023 14:48:32 +0700 (WIB)
Date:   Sat, 21 Oct 2023 14:48:32 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= 
        <marmarek@invisiblethingslab.com>,
        Linux Stable <stable@vger.kernel.org>
Cc:     Linux Regressions <regressions@lists.linux.dev>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Linux Devicemapper <dm-devel@redhat.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: Intermittent storage (dm-crypt?) freeze - regression 6.4->6.5
Message-ID: <ZTOCUJdgDDBX-ecp@debian.me>
References: <ZTNH0qtmint/zLJZ@mail-itl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xP1ESvUMC2jiSn8l"
Content-Disposition: inline
In-Reply-To: <ZTNH0qtmint/zLJZ@mail-itl>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


--xP1ESvUMC2jiSn8l
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 21, 2023 at 05:38:58AM +0200, Marek Marczykowski-G=C3=B3recki w=
rote:
> Hi,
>=20
> Since updating from 6.4.13 to 6.5.5 occasionally I hit a storage
> subsystem freeze - any I/O ends up frozen. I'm not sure what exactly
> triggers the issue, but often it happens when doing some LVM operations
> (lvremove, lvrename etc) on a dm-thin volume together with bulk data
> copy to/from another LVM thin volume with ext4 fs.
>=20
> The storage stack I use is:
>   nvme -> dm-crypt (LUKS) -> dm-thin (LVM thin pool) -> ext4
>=20
> And this whole thing running in a (PV) dom0 under Xen, on Qubes OS 4.2 to=
 be
> specific.
>=20
> I can reproduce the issue on at least 3 different machines. I did tried
> also 6.5.6 and the issue is still there. I haven't checked newer
> versions, but briefly reviewed git log and haven't found anything
> suggesting a fix to similar issue.
>=20
> I managed to bisect it down to this commit:
>=20
>     commit 5054e778fcd9cd29ddaa8109077cd235527e4f94
>     Author: Mikulas Patocka <mpatocka@redhat.com>
>     Date:   Mon May 1 09:19:17 2023 -0400
>=20
>     dm crypt: allocate compound pages if possible
>    =20
>     It was reported that allocating pages for the write buffer in dm-crypt
>     causes measurable overhead [1].
>    =20
>     Change dm-crypt to allocate compound pages if they are available. If
>     not, fall back to the mempool.
>    =20
>     [1] https://listman.redhat.com/archives/dm-devel/2023-February/053284=
=2Ehtml
>    =20
>     Suggested-by: Matthew Wilcox <willy@infradead.org>
>     Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
>     Signed-off-by: Mike Snitzer <snitzer@kernel.org>
>=20
> TBH, I'm not sure if the bug is in this commit, or maybe in some
> functions it uses (I don't see dm-crypt functions directly involved in
> the stack traces I collected). But reverting this commit on top of 6.5.6
> seems to fix the issue.
>=20
> I tried also CONFIG_PROVE_LOCKING, but it didn't show any issue.
>=20
> I managed to collect "blocked tasks" dump via sysrq below. Few more can
> be found at https://github.com/QubesOS/qubes-issues/issues/8575
>=20
>     [ 4246.558313] sysrq: Show Blocked State
>     [ 4246.558388] task:journal-offline state:D stack:0     pid:8098  ppi=
d:1      flags:0x00000002
>     [ 4246.558407] Call Trace:
>     [ 4246.558414]  <TASK>
>     [ 4246.558422]  __schedule+0x23d/0x670
>     [ 4246.558440]  schedule+0x5e/0xd0
>     [ 4246.558450]  io_schedule+0x46/0x70
>     [ 4246.558461]  folio_wait_bit_common+0x13d/0x350
>     [ 4246.558475]  ? __pfx_wake_page_function+0x10/0x10
>     [ 4246.558488]  folio_wait_writeback+0x2c/0x90
>     [ 4246.558498]  mpage_prepare_extent_to_map+0x15c/0x4d0
>     [ 4246.558512]  ext4_do_writepages+0x25f/0x770
>     [ 4246.558523]  ext4_writepages+0xad/0x180
>     [ 4246.558533]  do_writepages+0xcf/0x1e0
>     [ 4246.558543]  ? __seccomp_filter+0x32a/0x4f0
>     [ 4246.558554]  filemap_fdatawrite_wbc+0x63/0x90
>     [ 4246.558567]  __filemap_fdatawrite_range+0x5c/0x80
>     [ 4246.558578]  file_write_and_wait_range+0x4a/0xb0
>     [ 4246.558588]  ext4_sync_file+0x88/0x380
>     [ 4246.558598]  __x64_sys_fsync+0x3b/0x70
>     [ 4246.558609]  do_syscall_64+0x5c/0x90
>     [ 4246.558621]  ? exit_to_user_mode_prepare+0xb2/0xd0
>     [ 4246.558632]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
>     [ 4246.558644] RIP: 0033:0x7710cf124d0a
>     [ 4246.558654] RSP: 002b:00007710ccdfda40 EFLAGS: 00000293 ORIG_RAX: =
000000000000004a
>     [ 4246.558668] RAX: ffffffffffffffda RBX: 000064bb92f67e60 RCX: 00007=
710cf124d0a
>     [ 4246.558679] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00000=
00000000028
>     [ 4246.558691] RBP: 000064bb92f72670 R08: 0000000000000000 R09: 00007=
710ccdfe6c0
>     [ 4246.558702] R10: 00007710cf0adfee R11: 0000000000000293 R12: 00006=
4bb92505940
>     [ 4246.558713] R13: 0000000000000002 R14: 00007ffc05649500 R15: 00007=
710cc5fe000
>     [ 4246.558728]  </TASK>
>     [ 4246.558836] task:lvm             state:D stack:0     pid:7835  ppi=
d:5665   flags:0x00004006
>     [ 4246.558852] Call Trace:
>     [ 4246.558857]  <TASK>
>     [ 4246.558863]  __schedule+0x23d/0x670
>     [ 4246.558874]  schedule+0x5e/0xd0
>     [ 4246.558884]  io_schedule+0x46/0x70
>     [ 4246.558894]  dm_wait_for_bios_completion+0xfc/0x110
>     [ 4246.558909]  ? __pfx_autoremove_wake_function+0x10/0x10
>     [ 4246.558922]  __dm_suspend+0x7e/0x1b0
>     [ 4246.558932]  dm_internal_suspend_noflush+0x5c/0x80
>     [ 4246.558946]  pool_presuspend+0xcc/0x130 [dm_thin_pool]
>     [ 4246.558968]  dm_table_presuspend_targets+0x3f/0x60
>     [ 4246.558980]  __dm_suspend+0x41/0x1b0
>     [ 4246.558991]  dm_suspend+0xc0/0xe0
>     [ 4246.559001]  dev_suspend+0xa5/0xd0
>     [ 4246.559011]  ctl_ioctl+0x26e/0x350
>     [ 4246.559020]  ? __pfx_dev_suspend+0x10/0x10
>     [ 4246.559032]  dm_ctl_ioctl+0xe/0x20
>     [ 4246.559041]  __x64_sys_ioctl+0x94/0xd0
>     [ 4246.559052]  do_syscall_64+0x5c/0x90
>     [ 4246.559062]  ? do_syscall_64+0x6b/0x90
>     [ 4246.559072]  ? do_syscall_64+0x6b/0x90
>     [ 4246.559081]  ? xen_pv_evtchn_do_upcall+0x54/0xb0
>     [ 4246.559093]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
>     [ 4246.559104] RIP: 0033:0x7f1cb77cfe0f
>     [ 4246.559112] RSP: 002b:00007fff870f2560 EFLAGS: 00000246 ORIG_RAX: =
0000000000000010
>     [ 4246.559141] RAX: ffffffffffffffda RBX: 00005b8d13c16580 RCX: 00007=
f1cb77cfe0f
>     [ 4246.559152] RDX: 00005b8d144a2180 RSI: 00000000c138fd06 RDI: 00000=
00000000003
>     [ 4246.559164] RBP: 00005b8d144a2180 R08: 00005b8d132b1190 R09: 00007=
fff870f2420
>     [ 4246.559175] R10: 0000000000000000 R11: 0000000000000246 R12: 00000=
0000000000c
>     [ 4246.559186] R13: 00005b8d132aacf0 R14: 00005b8d1324414d R15: 00005=
b8d144a21b0
>     [ 4246.559199]  </TASK>
>     [ 4246.559207] task:kworker/u8:3    state:D stack:0     pid:8033  ppi=
d:2      flags:0x00004000
>     [ 4246.559222] Workqueue: writeback wb_workfn (flush-253:4)
>     [ 4246.559238] Call Trace:
>     [ 4246.559244]  <TASK>
>     [ 4246.559249]  __schedule+0x23d/0x670
>     [ 4246.559260]  schedule+0x5e/0xd0
>     [ 4246.559270]  io_schedule+0x46/0x70
>     [ 4246.559280]  folio_wait_bit_common+0x13d/0x350
>     [ 4246.559290]  ? __pfx_wake_page_function+0x10/0x10
>     [ 4246.559302]  mpage_prepare_extent_to_map+0x309/0x4d0
>     [ 4246.559314]  ext4_do_writepages+0x25f/0x770
>     [ 4246.559324]  ext4_writepages+0xad/0x180
>     [ 4246.559334]  do_writepages+0xcf/0x1e0
>     [ 4246.559344]  ? find_busiest_group+0x42/0x1a0
>     [ 4246.559354]  __writeback_single_inode+0x3d/0x280
>     [ 4246.559368]  writeback_sb_inodes+0x1ed/0x4a0
>     [ 4246.559381]  __writeback_inodes_wb+0x4c/0xf0
>     [ 4246.559393]  wb_writeback+0x298/0x310
>     [ 4246.559403]  wb_do_writeback+0x230/0x2b0
>     [ 4246.559414]  wb_workfn+0x5f/0x260
>     [ 4246.559424]  ? _raw_spin_unlock+0xe/0x30
>     [ 4246.559434]  ? finish_task_switch.isra.0+0x95/0x2b0
>     [ 4246.559447]  ? __schedule+0x245/0x670
>     [ 4246.559457]  process_one_work+0x1df/0x3e0
>     [ 4246.559466]  worker_thread+0x51/0x390
>     [ 4246.559475]  ? __pfx_worker_thread+0x10/0x10
>     [ 4246.559484]  kthread+0xe5/0x120
>     [ 4246.559495]  ? __pfx_kthread+0x10/0x10
>     [ 4246.559504]  ret_from_fork+0x31/0x50
>     [ 4246.559514]  ? __pfx_kthread+0x10/0x10
>     [ 4246.559523]  ret_from_fork_asm+0x1b/0x30
>     [ 4246.559536]  </TASK>
>=20

Thanks for the regression report. I'm adding it to regzbot:

#regzbot ^introduced: 5054e778fcd9cd

--=20
An old man doll... just what I always wanted! - Clara

--xP1ESvUMC2jiSn8l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZTOCSwAKCRD2uYlJVVFO
o+9DAQD/hlJHvre0E/h+22cx3o3yGrUHq6WPPxN9xEE5ZPt4TQEAnYaoflGIMqVd
lLqq+l+m8jicHbq7WT2C9GKiR0PtKQ8=
=jmdP
-----END PGP SIGNATURE-----

--xP1ESvUMC2jiSn8l--
