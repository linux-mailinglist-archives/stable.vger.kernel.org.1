Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88D357D1AA7
	for <lists+stable@lfdr.de>; Sat, 21 Oct 2023 05:39:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbjJUDjN (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 20 Oct 2023 23:39:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjJUDjM (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 20 Oct 2023 23:39:12 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61A09D76
        for <stable@vger.kernel.org>; Fri, 20 Oct 2023 20:39:07 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 5F40D3200978;
        Fri, 20 Oct 2023 23:39:03 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Fri, 20 Oct 2023 23:39:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        invisiblethingslab.com; h=cc:cc:content-type:content-type:date
        :date:from:from:in-reply-to:message-id:mime-version:reply-to
        :sender:subject:subject:to:to; s=fm2; t=1697859542; x=
        1697945942; bh=zVbJ+wFYY/DoumS/OitFWr8hsA8VR19M9UBfP0ubQEI=; b=x
        yoShA+Yx5aTXOZ+47kyPuQBAFdQuLwY5HfRhMhjsK93XBwbxqa16zk+YPqC1C1um
        xMZbYM/LFYKrDlvVVH77S2nCy/HXFjRf3nzQYQWM5Ih3RecFzDucCBPTBnBKYn22
        0YTXm4djdmys5a8XQSATUpWgZ/sPpEv07hNjEEYyM+e6lebdCfWCY5ms82Ostm1h
        THJgS900fZaP7+WGZf/5ncjMYm25CqLbpm8cXkUCmyvlAA6GsH6z7LqfG0ZKk/Hk
        LcCY4IEtjyuXGPDS0RmbeHHxoJB7wXBw0uGUHwOmaSHgCkCclFasCgXwr0D9gi8P
        CsJnsHsuR8JA6DNZ9wa9w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1697859542; x=1697945942; bh=zVbJ+wFYY/DoumS/OitFWr8hsA8VR19M9UB
        fP0ubQEI=; b=fZXI+hNE+WutI4LUedjhqXC/69FL3/cYj9fB1E2vdJgLX5NndJ5
        h5EunKLYXxdHHG2KAgt8UpHoiz3n+n0lThHqkmB0SaP5LOwaHrPmZ51Ma1CM8Wyt
        8oJboOnq7mSbWfy5FcjpluJD3Fh3LXv9qx2Y+vRhpOerwuGyUHZ3xAFopz9A45fX
        pzEVmeukTsev8VOzcLYtJpDVcRglaNDYzswO6bwQXuPF/iRiAMouxnquXOU4FAF6
        xEVwMijCoDnySfSBIQHXgTTzqJbrXkBwFFGUmYpdE8d+WkqV84KPrXLC/EwcfIfu
        Roh88qUVN0qDQrsfwSNVm/5ODpVlFbPrKuA==
X-ME-Sender: <xms:1kczZQSvaErUeyaNeOrKp-d4dIAKM92yx_JWAP6fgl6RCBW47hqAJw>
    <xme:1kczZdw4dtOPYzM_HaiH51WPx02BAthxvbIBOBinzt9VkdnHjjl7kFt-L_tqKFFhd
    6UjM4ZhEEkJ0Q>
X-ME-Received: <xmr:1kczZd01nGpxlIKbubuzIwwRSUIB2kzMHrq0PuXWlMif9m5S_GdYCnHr37avQ5_MfKt4hdfx_mrA6iQLiCFIW-JM428Or46A5eQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrjeelgdejtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfggtggusehgtderredttdejnecuhfhrohhmpeforghrvghkucfo
    rghrtgiihihkohifshhkihdqifpkrhgvtghkihcuoehmrghrmhgrrhgvkhesihhnvhhish
    hisghlvghthhhinhhgshhlrggsrdgtohhmqeenucggtffrrghtthgvrhhnpeehfeffvddt
    vddthfdvgfetfeduleekhfegvdfhledtheehgeefgfejheelgfdtveenucffohhmrghinh
    eprhgvughhrghtrdgtohhmpdhgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigv
    pedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmrghrmhgrrhgvkhesihhnvhhishhisg
    hlvghthhhinhhgshhlrggsrdgtohhm
X-ME-Proxy: <xmx:1kczZUDphk9ycCeVR32ttvFa3qoahnBmeid2BUlCGfD_n4IgcP3deQ>
    <xmx:1kczZZiURNWdQzy3NkUaBkFN7P0kV5zj86En3-MmqVBfLtUUY9F12A>
    <xmx:1kczZQpxurjX1MSSvdlVoXgBmKLi6zpcCsXJ83moexcqVpuStJLSYA>
    <xmx:1kczZestWA4EPcM-FMOpxTAsni5MLLXxtF9Beov5-_pKoC9_HufvoA>
Feedback-ID: i1568416f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Oct 2023 23:39:01 -0400 (EDT)
Date:   Sat, 21 Oct 2023 05:38:58 +0200
From:   Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= 
        <marmarek@invisiblethingslab.com>
To:     stable@vger.kernel.org
Cc:     regressions@lists.linux.dev, Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Mikulas Patocka <mpatocka@redhat.com>, dm-devel@redhat.com
Subject: Intermittent storage (dm-crypt?) freeze - regression 6.4->6.5
Message-ID: <ZTNH0qtmint/zLJZ@mail-itl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="iPOYppGVnXEUhkm5"
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


--iPOYppGVnXEUhkm5
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Sat, 21 Oct 2023 05:38:58 +0200
From: Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>
To: stable@vger.kernel.org
Cc: regressions@lists.linux.dev, Alasdair Kergon <agk@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>, dm-devel@redhat.com
Subject: Intermittent storage (dm-crypt?) freeze - regression 6.4->6.5

Hi,

Since updating from 6.4.13 to 6.5.5 occasionally I hit a storage
subsystem freeze - any I/O ends up frozen. I'm not sure what exactly
triggers the issue, but often it happens when doing some LVM operations
(lvremove, lvrename etc) on a dm-thin volume together with bulk data
copy to/from another LVM thin volume with ext4 fs.

The storage stack I use is:
  nvme -> dm-crypt (LUKS) -> dm-thin (LVM thin pool) -> ext4

And this whole thing running in a (PV) dom0 under Xen, on Qubes OS 4.2 to be
specific.

I can reproduce the issue on at least 3 different machines. I did tried
also 6.5.6 and the issue is still there. I haven't checked newer
versions, but briefly reviewed git log and haven't found anything
suggesting a fix to similar issue.

I managed to bisect it down to this commit:

    commit 5054e778fcd9cd29ddaa8109077cd235527e4f94
    Author: Mikulas Patocka <mpatocka@redhat.com>
    Date:   Mon May 1 09:19:17 2023 -0400

    dm crypt: allocate compound pages if possible
   =20
    It was reported that allocating pages for the write buffer in dm-crypt
    causes measurable overhead [1].
   =20
    Change dm-crypt to allocate compound pages if they are available. If
    not, fall back to the mempool.
   =20
    [1] https://listman.redhat.com/archives/dm-devel/2023-February/053284.h=
tml
   =20
    Suggested-by: Matthew Wilcox <willy@infradead.org>
    Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
    Signed-off-by: Mike Snitzer <snitzer@kernel.org>

TBH, I'm not sure if the bug is in this commit, or maybe in some
functions it uses (I don't see dm-crypt functions directly involved in
the stack traces I collected). But reverting this commit on top of 6.5.6
seems to fix the issue.

I tried also CONFIG_PROVE_LOCKING, but it didn't show any issue.

I managed to collect "blocked tasks" dump via sysrq below. Few more can
be found at https://github.com/QubesOS/qubes-issues/issues/8575

    [ 4246.558313] sysrq: Show Blocked State
    [ 4246.558388] task:journal-offline state:D stack:0     pid:8098  ppid:=
1      flags:0x00000002
    [ 4246.558407] Call Trace:
    [ 4246.558414]  <TASK>
    [ 4246.558422]  __schedule+0x23d/0x670
    [ 4246.558440]  schedule+0x5e/0xd0
    [ 4246.558450]  io_schedule+0x46/0x70
    [ 4246.558461]  folio_wait_bit_common+0x13d/0x350
    [ 4246.558475]  ? __pfx_wake_page_function+0x10/0x10
    [ 4246.558488]  folio_wait_writeback+0x2c/0x90
    [ 4246.558498]  mpage_prepare_extent_to_map+0x15c/0x4d0
    [ 4246.558512]  ext4_do_writepages+0x25f/0x770
    [ 4246.558523]  ext4_writepages+0xad/0x180
    [ 4246.558533]  do_writepages+0xcf/0x1e0
    [ 4246.558543]  ? __seccomp_filter+0x32a/0x4f0
    [ 4246.558554]  filemap_fdatawrite_wbc+0x63/0x90
    [ 4246.558567]  __filemap_fdatawrite_range+0x5c/0x80
    [ 4246.558578]  file_write_and_wait_range+0x4a/0xb0
    [ 4246.558588]  ext4_sync_file+0x88/0x380
    [ 4246.558598]  __x64_sys_fsync+0x3b/0x70
    [ 4246.558609]  do_syscall_64+0x5c/0x90
    [ 4246.558621]  ? exit_to_user_mode_prepare+0xb2/0xd0
    [ 4246.558632]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
    [ 4246.558644] RIP: 0033:0x7710cf124d0a
    [ 4246.558654] RSP: 002b:00007710ccdfda40 EFLAGS: 00000293 ORIG_RAX: 00=
0000000000004a
    [ 4246.558668] RAX: ffffffffffffffda RBX: 000064bb92f67e60 RCX: 0000771=
0cf124d0a
    [ 4246.558679] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000=
000000028
    [ 4246.558691] RBP: 000064bb92f72670 R08: 0000000000000000 R09: 0000771=
0ccdfe6c0
    [ 4246.558702] R10: 00007710cf0adfee R11: 0000000000000293 R12: 000064b=
b92505940
    [ 4246.558713] R13: 0000000000000002 R14: 00007ffc05649500 R15: 0000771=
0cc5fe000
    [ 4246.558728]  </TASK>
    [ 4246.558836] task:lvm             state:D stack:0     pid:7835  ppid:=
5665   flags:0x00004006
    [ 4246.558852] Call Trace:
    [ 4246.558857]  <TASK>
    [ 4246.558863]  __schedule+0x23d/0x670
    [ 4246.558874]  schedule+0x5e/0xd0
    [ 4246.558884]  io_schedule+0x46/0x70
    [ 4246.558894]  dm_wait_for_bios_completion+0xfc/0x110
    [ 4246.558909]  ? __pfx_autoremove_wake_function+0x10/0x10
    [ 4246.558922]  __dm_suspend+0x7e/0x1b0
    [ 4246.558932]  dm_internal_suspend_noflush+0x5c/0x80
    [ 4246.558946]  pool_presuspend+0xcc/0x130 [dm_thin_pool]
    [ 4246.558968]  dm_table_presuspend_targets+0x3f/0x60
    [ 4246.558980]  __dm_suspend+0x41/0x1b0
    [ 4246.558991]  dm_suspend+0xc0/0xe0
    [ 4246.559001]  dev_suspend+0xa5/0xd0
    [ 4246.559011]  ctl_ioctl+0x26e/0x350
    [ 4246.559020]  ? __pfx_dev_suspend+0x10/0x10
    [ 4246.559032]  dm_ctl_ioctl+0xe/0x20
    [ 4246.559041]  __x64_sys_ioctl+0x94/0xd0
    [ 4246.559052]  do_syscall_64+0x5c/0x90
    [ 4246.559062]  ? do_syscall_64+0x6b/0x90
    [ 4246.559072]  ? do_syscall_64+0x6b/0x90
    [ 4246.559081]  ? xen_pv_evtchn_do_upcall+0x54/0xb0
    [ 4246.559093]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
    [ 4246.559104] RIP: 0033:0x7f1cb77cfe0f
    [ 4246.559112] RSP: 002b:00007fff870f2560 EFLAGS: 00000246 ORIG_RAX: 00=
00000000000010
    [ 4246.559141] RAX: ffffffffffffffda RBX: 00005b8d13c16580 RCX: 00007f1=
cb77cfe0f
    [ 4246.559152] RDX: 00005b8d144a2180 RSI: 00000000c138fd06 RDI: 0000000=
000000003
    [ 4246.559164] RBP: 00005b8d144a2180 R08: 00005b8d132b1190 R09: 00007ff=
f870f2420
    [ 4246.559175] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000=
00000000c
    [ 4246.559186] R13: 00005b8d132aacf0 R14: 00005b8d1324414d R15: 00005b8=
d144a21b0
    [ 4246.559199]  </TASK>
    [ 4246.559207] task:kworker/u8:3    state:D stack:0     pid:8033  ppid:=
2      flags:0x00004000
    [ 4246.559222] Workqueue: writeback wb_workfn (flush-253:4)
    [ 4246.559238] Call Trace:
    [ 4246.559244]  <TASK>
    [ 4246.559249]  __schedule+0x23d/0x670
    [ 4246.559260]  schedule+0x5e/0xd0
    [ 4246.559270]  io_schedule+0x46/0x70
    [ 4246.559280]  folio_wait_bit_common+0x13d/0x350
    [ 4246.559290]  ? __pfx_wake_page_function+0x10/0x10
    [ 4246.559302]  mpage_prepare_extent_to_map+0x309/0x4d0
    [ 4246.559314]  ext4_do_writepages+0x25f/0x770
    [ 4246.559324]  ext4_writepages+0xad/0x180
    [ 4246.559334]  do_writepages+0xcf/0x1e0
    [ 4246.559344]  ? find_busiest_group+0x42/0x1a0
    [ 4246.559354]  __writeback_single_inode+0x3d/0x280
    [ 4246.559368]  writeback_sb_inodes+0x1ed/0x4a0
    [ 4246.559381]  __writeback_inodes_wb+0x4c/0xf0
    [ 4246.559393]  wb_writeback+0x298/0x310
    [ 4246.559403]  wb_do_writeback+0x230/0x2b0
    [ 4246.559414]  wb_workfn+0x5f/0x260
    [ 4246.559424]  ? _raw_spin_unlock+0xe/0x30
    [ 4246.559434]  ? finish_task_switch.isra.0+0x95/0x2b0
    [ 4246.559447]  ? __schedule+0x245/0x670
    [ 4246.559457]  process_one_work+0x1df/0x3e0
    [ 4246.559466]  worker_thread+0x51/0x390
    [ 4246.559475]  ? __pfx_worker_thread+0x10/0x10
    [ 4246.559484]  kthread+0xe5/0x120
    [ 4246.559495]  ? __pfx_kthread+0x10/0x10
    [ 4246.559504]  ret_from_fork+0x31/0x50
    [ 4246.559514]  ? __pfx_kthread+0x10/0x10
    [ 4246.559523]  ret_from_fork_asm+0x1b/0x30
    [ 4246.559536]  </TASK>

--=20
Best Regards,
Marek Marczykowski-G=C3=B3recki
Invisible Things Lab

--iPOYppGVnXEUhkm5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhrpukzGPukRmQqkK24/THMrX1ywFAmUzR9IACgkQ24/THMrX
1ywjnQf/STVhcR61Xl3XJqBHfPauuZAJRAWuK5P49L/qIO05tOsL8HGfwAnkX8+m
Jo+0Xs4mxpixFVN4sw5rTyNQyPUkQw2nB4ccp2Js0TBlxAO7RzPzcs8W2xFFnIml
cWQjiPiouqjtdU4KpFh0i30OzeB+Xzt5br5aLOGuj/MO1EuNEsDPPQuCSDuNJ6wd
I7IbEdHsAf3nrqtScjDlfH3QzkHfl5aWnXAcAhh7+Xglm2qC+kIZ4v6Yd6RREPw6
zxS/gs7Or8Br1QmA97bFhwEXIoYq3+EXXGuQdiMWOcjtfJbn3N7j10vcwFugk/2d
lpuK19zMRstmsvyJR7MNyONxLJrHwA==
=Cwt+
-----END PGP SIGNATURE-----

--iPOYppGVnXEUhkm5--
