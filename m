Return-Path: <stable+bounces-77703-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36D3B9861BD
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 17:00:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB95C289405
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 15:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9825618C93F;
	Wed, 25 Sep 2024 14:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="mD1W8heg"
X-Original-To: stable@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EDAD18C939
	for <stable@vger.kernel.org>; Wed, 25 Sep 2024 14:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727274846; cv=none; b=dPih6F6EEL4jOczuIx+NztCeDLXmyYYOp2nyLvl5Bl+jp8fxptGDKm5F52V09L4J5b/btL8abUQ9qVRp6RDClTb1oTY3KcEyVW0J5uxFHpaLwqu0k3sAWuhmASZTilnLcTcaJvJvX2woE6YDNE5wXtkAUsrdarOWh3BrctKO+J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727274846; c=relaxed/simple;
	bh=diAMlwEmIc31dAh/E1f912CF6mSdX3qEXeARlvF6e+4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=hw+bHA/QckoInV2DkJhrsnZcy3HqclhYVSrz4BahXgrjOFYixpVKU8CGIQjibLhZvpgjTlS5mF14W+w04o8Hsdtp0Z3IS0BRcuFIxAsRty0O/cwug3ejlWyTTjPuTdNj02dXpJsloLUYVxVx3jTDEQp1+haDNn9VkxFvRHLE2kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=mD1W8heg; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 9683C3F231
	for <stable@vger.kernel.org>; Wed, 25 Sep 2024 14:34:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1727274841;
	bh=IOx8To2TCRCnkrRgvwNDKzzd5Ho7q0DXUkJ0rDtdRMQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type;
	b=mD1W8hegvL//QmKV2KV0OS4pWAYim6WjAAP9rFKztW/SEMOF4ZFAKXWjN27rkrNnL
	 6aS6BzYh/YwnE32vh3h7T/C2hMMsZ11hi3Ut8IMor4DoAxuO66Zd/sF8aP3xCN7pbr
	 VY5Yuy9AUWaczy9JezTwPcUEzjE+nA3FXCl8N8X0Ko1a5taE1Z1rq+x7it9tIDZYkt
	 gquAxCS6gx4eCzXdwrKcAX7qh1AplzKFOqK3JsHygao2/fn2lGqAaN36811U9s34F5
	 NnMKyLH8ges1OlUay9HxLG6hI1g85zG0z/o3ldKMxIG8R2mLqapEtcRr4IUiR+Kqcv
	 xxNLIy4StRmmA==
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a8a84b60255so536415266b.1
        for <stable@vger.kernel.org>; Wed, 25 Sep 2024 07:34:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727274841; x=1727879641;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IOx8To2TCRCnkrRgvwNDKzzd5Ho7q0DXUkJ0rDtdRMQ=;
        b=HLRV1j+rn+APEuf3cdb4V6uBqK0PM6uc7K6qzvFbmRFVdEV2zr+0+nAdiA+b2C4nFO
         9S8GLZM+qanoN3E51snLjh6i81dds2s9jPClABYPeWgmwBrIMkuXYZQ8mkrNQOCm3ZRV
         O/CV7/S8ovjO5fXaHmz1cYEu3XwVYwPmIZzZgozqNYE6lDndz+PLsgHymUXR/h2mcn/p
         jlN6Ful8zsLj2uFXPuSfZWGOoOjFKeokKEvgKHwc18i03N6299NrLjk3gElLoIQWOybs
         lNDmAJp1vnkcoYBcrPbhFAry5kyVQcVEMJk82+nqWB93ByLqSN0p3ADFJG548doDl70j
         4NUw==
X-Gm-Message-State: AOJu0YyIMUJ5LLwaC13ttl3KusCBwUklv+h8YUYmBUXOXyWZbiDaMULn
	XmKUk5kVGRJOQcqCH/OTMN9wOZudlXR48FzHoANN15/raVFpp76XCuSFeu64Z0mIcNUA8zBKh6w
	gH/eiCWIi22auOLpoULR0L2ZhAI50DZ9gaVjT8mqipDt+QGoAUh5RvYZ9YTDy9O1gimb4bA==
X-Received: by 2002:a17:907:9444:b0:a8d:29b7:ecf3 with SMTP id a640c23a62f3a-a93a0325da2mr338062066b.13.1727274840868;
        Wed, 25 Sep 2024 07:34:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFFLsEUWtGKMVnsB9Bpth1JGRAwgTtpINOh/ia+dJ5By5L1JL7Z5+0zfg0sxlhc2JUbuJhAHQ==
X-Received: by 2002:a17:907:9444:b0:a8d:29b7:ecf3 with SMTP id a640c23a62f3a-a93a0325da2mr338059266b.13.1727274840409;
        Wed, 25 Sep 2024 07:34:00 -0700 (PDT)
Received: from amikhalitsyn.. ([188.192.113.77])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93930cad0asm213137366b.118.2024.09.25.07.33.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 07:33:59 -0700 (PDT)
From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To: tytso@mit.edu
Cc: stable@vger.kernel.org,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Jan Kara <jack@suse.cz>,
	Baokun Li <libaokun1@huawei.com>,
	=?UTF-8?q?St=C3=A9phane=20Graber?= <stgraber@stgraber.org>,
	Christian Brauner <brauner@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	Wesley Hershberger <wesley.hershberger@canonical.com>,
	Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Subject: [PATCH 0/1] ext4: fix crash on BUG_ON in ext4_alloc_group_tables
Date: Wed, 25 Sep 2024 16:33:23 +0200
Message-Id: <20240925143325.518508-1-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

A long story behind this one, first of all, we (LXD project folks) started to see issues
in our tests on GitHub Actions ubuntu22.04 runners after they've got updated from 6.5 to 6.8-based kernel
and this was reported on Launchpad tracker [1] by Wesley Hershberger.

At the same time, Stéphane Graber from LXC containers project saw the same problem on Incus testsuite (also
on Github Actions).

Then we had a debugging session together with Stéphane and he found a quite minimalistic reproducer:
curl https://pkgs.zabbly.com/get/incus-daily | sudo sh
sudo apt-get install lvm2 --yes
sudo incus storage create default lvm volume.size=25MiB size=1GiB
sudo incus image copy images:alpine/edge local: --alias testimage
sudo incus profile device add default root disk pool=default path=/ size=3GiB
sudo incus create testimage a1

this thing produces the following output in kernel logs:

[   33.882936] EXT4-fs (dm-5): mounted filesystem 8aaf41b2-6ac0-4fa8-b92b-77d10e1d16ca r/w with ordered data mode. Quota mode: none.
[   33.888365] EXT4-fs (dm-5): resizing filesystem from 7168 to 786432 blocks
[   33.888740] ------------[ cut here ]------------
[   33.888742] kernel BUG at fs/ext4/resize.c:324!
[   33.889075] Oops: invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
[   33.889503] CPU: 9 UID: 0 PID: 3576 Comm: resize2fs Not tainted 6.11.0+ #27
[   33.890039] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
[   33.890705] RIP: 0010:ext4_resize_fs+0x1212/0x12d0
[   33.891063] Code: b8 45 31 c0 4c 89 ff 45 31 c9 31 c9 ba 0e 08 00 00 48 c7 c6 68 75 65 b8 e8 2b 79 01 00 41 b8 ea ff ff ff 41 5f e9 8d f1 ff ff <0f> 0b 48 83 bd 70 ff ff ff 00 75 32 45 31 c0 e9 53 f1 ff ff 41 b8
[   33.892701] RSP: 0018:ffffa97f413f3cc8 EFLAGS: 00010202
[   33.893081] RAX: 0000000000000018 RBX: 0000000000000001 RCX: 00000000fffffff0
[   33.893639] RDX: 0000000000000017 RSI: 0000000000000016 RDI: 00000000e8c2c810
[   33.894197] RBP: ffffa97f413f3d90 R08: 0000000000000000 R09: 0000000000008000
[   33.894755] R10: ffffa97f413f3cc8 R11: ffffa2c1845bfc80 R12: 0000000000000000
[   33.895317] R13: ffffa2c1843d6000 R14: 0000000000008000 R15: ffffa2c199963000
[   33.895877] FS:  00007f46efd17000(0000) GS:ffffa2c89fc40000(0000) knlGS:0000000000000000
[   33.896524] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   33.896954] CR2: 00005630a4a1cc88 CR3: 000000010532c000 CR4: 0000000000350eb0
[   33.897516] Call Trace:
[   33.897638]  <TASK>
[   33.897728]  ? show_regs+0x6d/0x80
[   33.897942]  ? die+0x3c/0xa0
[   33.898106]  ? do_trap+0xe5/0x110
[   33.898311]  ? do_error_trap+0x6e/0x90
[   33.898555]  ? ext4_resize_fs+0x1212/0x12d0
[   33.898844]  ? exc_invalid_op+0x57/0x80
[   33.899101]  ? ext4_resize_fs+0x1212/0x12d0
[   33.899387]  ? asm_exc_invalid_op+0x1f/0x30
[   33.899675]  ? ext4_resize_fs+0x1212/0x12d0
[   33.899961]  ? ext4_resize_fs+0x745/0x12d0
[   33.900239]  __ext4_ioctl+0x4e0/0x1800
[   33.900489]  ? srso_alias_return_thunk+0x5/0xfbef5
[   33.900832]  ? putname+0x5b/0x70
[   33.901028]  ? srso_alias_return_thunk+0x5/0xfbef5
[   33.901374]  ? do_sys_openat2+0x87/0xd0
[   33.901632]  ? srso_alias_return_thunk+0x5/0xfbef5
[   33.901981]  ? srso_alias_return_thunk+0x5/0xfbef5
[   33.902324]  ? __x64_sys_openat+0x59/0xa0
[   33.902595]  ext4_ioctl+0x12/0x20
[   33.902802]  ? ext4_ioctl+0x12/0x20
[   33.903031]  __x64_sys_ioctl+0x99/0xd0
[   33.903277]  x64_sys_call+0x1206/0x20d0
[   33.903534]  do_syscall_64+0x72/0x110
[   33.903771]  ? srso_alias_return_thunk+0x5/0xfbef5
[   33.904115]  ? irqentry_exit+0x3f/0x50
[   33.904362]  ? srso_alias_return_thunk+0x5/0xfbef5
[   33.904707]  ? exc_page_fault+0x1aa/0x7b0
[   33.904979]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   33.905349] RIP: 0033:0x7f46efe3294f
[   33.905579] Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 00 00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05 <41> 89 c0 3d 00 f0 ff ff 77 1f 48 8b 44 24 18 64 48 2b 04 25 28 00
[   33.907321] RSP: 002b:00007ffe9b8833a0 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
[   33.907926] RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007f46efe3294f
[   33.908487] RDX: 00007ffe9b8834a0 RSI: 0000000040086610 RDI: 0000000000000004
[   33.909046] RBP: 00005630a4a0b0e0 R08: 0000000000000000 R09: 00007ffe9b8832d7
[   33.909605] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000004
[   33.910165] R13: 00005630a4a0c580 R14: 00005630a4a10400 R15: 0000000000000000
[   33.910740]  </TASK>
[   33.910837] Modules linked in:
[   33.911049] ---[ end trace 0000000000000000 ]---
[   33.911428] RIP: 0010:ext4_resize_fs+0x1212/0x12d0
[   33.911810] Code: b8 45 31 c0 4c 89 ff 45 31 c9 31 c9 ba 0e 08 00 00 48 c7 c6 68 75 65 b8 e8 2b 79 01 00 41 b8 ea ff ff ff 41 5f e9 8d f1 ff ff <0f> 0b 48 83 bd 70 ff ff ff 00 75 32 45 31 c0 e9 53 f1 ff ff 41 b8
[   33.913928] RSP: 0018:ffffa97f413f3cc8 EFLAGS: 00010202
[   33.914313] RAX: 0000000000000018 RBX: 0000000000000001 RCX: 00000000fffffff0
[   33.914909] RDX: 0000000000000017 RSI: 0000000000000016 RDI: 00000000e8c2c810
[   33.915482] RBP: ffffa97f413f3d90 R08: 0000000000000000 R09: 0000000000008000
[   33.916258] R10: ffffa97f413f3cc8 R11: ffffa2c1845bfc80 R12: 0000000000000000
[   33.917027] R13: ffffa2c1843d6000 R14: 0000000000008000 R15: ffffa2c199963000
[   33.917884] FS:  00007f46efd17000(0000) GS:ffffa2c89fc40000(0000) knlGS:0000000000000000
[   33.918818] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   33.919322] CR2: 00005630a4a1cc88 CR3: 000000010532c000 CR4: 0000000000350eb0
[   44.072293] ------------[ cut here ]------------

This patch is attempt to fix it and I can confirm that after applying it everything works just fine.
At the same time, I'm not knowledgable in ext4 filesystem code so careful review is required here.

Kind regards,
Alex

Cc: stable@vger.kernel.org # v6.8+
Fixes: 665d3e0af4d3 ("ext4: reduce unnecessary memory allocation in alloc_flex_gd()")
Link: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2081231 [1]
Cc: "Theodore Ts'o" <tytso@mit.edu>
Cc: Andreas Dilger <adilger.kernel@dilger.ca>
Cc: Jan Kara <jack@suse.cz>
Cc: Baokun Li <libaokun1@huawei.com>
Cc: Stéphane Graber <stgraber@stgraber.org>
Cc: Christian Brauner <brauner@kernel.org>
Cc: <linux-kernel@vger.kernel.org>
Cc: <linux-fsdevel@vger.kernel.org>
Cc: <linux-ext4@vger.kernel.org>
Reported-by: Wesley Hershberger <wesley.hershberger@canonical.com>
Reported-by: Stéphane Graber <stgraber@stgraber.org>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>

Alexander Mikhalitsyn (1):
  ext4: fix BUG at fs/ext4/resize.c

 fs/ext4/resize.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

-- 
2.34.1


