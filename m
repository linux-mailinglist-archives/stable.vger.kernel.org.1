Return-Path: <stable+bounces-155825-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB84DAE43DC
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 15:37:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06DEA189C5B6
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 13:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2847D255E27;
	Mon, 23 Jun 2025 13:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="v+9oofQE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D74BA2571AC;
	Mon, 23 Jun 2025 13:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750685425; cv=none; b=GjxjwhyWmvVW7DbpiVxwIgbROFOBGFKSx3OOEicY2kzkvKXlwtddKKT80tKNau8jaVUSudkAqBq+dHmotDDPB1qiaGOHfrf4Du/aXv/YzE5nDn7660JvfQPhRhui+zikBhTge7do5MDlse9Y0N3QxVTa4Bh1dRVKBVeSOTc8Y0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750685425; c=relaxed/simple;
	bh=BDpwLlMA1bOqkqF+N+7QODJWry7rt7WjYMbjbzmEhfU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tt4GGKaUeMd2kW4x9zZK00roJl60trAClTl4JLlXa8WkJ82EdNqS0a56x2LTb0rjxWESH3lHFocAgaqLHlCQLr67zIvwp9nXRrHswSgSLxGFeLPMM7gYB86wQY3U+vkS3diIgPkZhTK3e4mhR4BY3wlfgwuxHTBdOU9pFaMU6y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=v+9oofQE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1446AC4CEEA;
	Mon, 23 Jun 2025 13:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750685425;
	bh=BDpwLlMA1bOqkqF+N+7QODJWry7rt7WjYMbjbzmEhfU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=v+9oofQEnojvOMcsqn3mRUcT9zSyzgIceTOYPt/1Kb+f6d2XuHcrduz1hSCbvh4QN
	 JCVJHOOwLviVDOLWzQpN+al8tXqbcOQ5ZmrbqauplYWT1kSNJFuDjhUkYslhm5o208
	 YRQU8c6W0q4iLVkeLm23vr2r+6wISH6dlAYf9reQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+9c09fda97a1a65ea859b@syzkaller.appspotmail.com,
	Yi Yang <yiyang13@huawei.com>,
	GONG Ruiqi <gongruiqi1@huawei.com>,
	Helge Deller <deller@gmx.de>
Subject: [PATCH 5.4 119/222] vgacon: Add check for vc_origin address range in vgacon_scroll()
Date: Mon, 23 Jun 2025 15:07:34 +0200
Message-ID: <20250623130615.679599343@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250623130611.896514667@linuxfoundation.org>
References: <20250623130611.896514667@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: GONG Ruiqi <gongruiqi1@huawei.com>

commit 864f9963ec6b4b76d104d595ba28110b87158003 upstream.

Our in-house Syzkaller reported the following BUG (twice), which we
believed was the same issue with [1]:

==================================================================
BUG: KASAN: slab-out-of-bounds in vcs_scr_readw+0xc2/0xd0 drivers/tty/vt/vt.c:4740
Read of size 2 at addr ffff88800f5bef60 by task syz.7.2620/12393
...
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x72/0xa0 lib/dump_stack.c:106
 print_address_description.constprop.0+0x6b/0x3d0 mm/kasan/report.c:364
 print_report+0xba/0x280 mm/kasan/report.c:475
 kasan_report+0xa9/0xe0 mm/kasan/report.c:588
 vcs_scr_readw+0xc2/0xd0 drivers/tty/vt/vt.c:4740
 vcs_write_buf_noattr drivers/tty/vt/vc_screen.c:493 [inline]
 vcs_write+0x586/0x840 drivers/tty/vt/vc_screen.c:690
 vfs_write+0x219/0x960 fs/read_write.c:584
 ksys_write+0x12e/0x260 fs/read_write.c:639
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x59/0x110 arch/x86/entry/common.c:81
 entry_SYSCALL_64_after_hwframe+0x78/0xe2
 ...
 </TASK>

Allocated by task 5614:
 kasan_save_stack+0x20/0x40 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 ____kasan_kmalloc mm/kasan/common.c:374 [inline]
 __kasan_kmalloc+0x8f/0xa0 mm/kasan/common.c:383
 kasan_kmalloc include/linux/kasan.h:201 [inline]
 __do_kmalloc_node mm/slab_common.c:1007 [inline]
 __kmalloc+0x62/0x140 mm/slab_common.c:1020
 kmalloc include/linux/slab.h:604 [inline]
 kzalloc include/linux/slab.h:721 [inline]
 vc_do_resize+0x235/0xf40 drivers/tty/vt/vt.c:1193
 vgacon_adjust_height+0x2d4/0x350 drivers/video/console/vgacon.c:1007
 vgacon_font_set+0x1f7/0x240 drivers/video/console/vgacon.c:1031
 con_font_set drivers/tty/vt/vt.c:4628 [inline]
 con_font_op+0x4da/0xa20 drivers/tty/vt/vt.c:4675
 vt_k_ioctl+0xa10/0xb30 drivers/tty/vt/vt_ioctl.c:474
 vt_ioctl+0x14c/0x1870 drivers/tty/vt/vt_ioctl.c:752
 tty_ioctl+0x655/0x1510 drivers/tty/tty_io.c:2779
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:871 [inline]
 __se_sys_ioctl+0x12d/0x190 fs/ioctl.c:857
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x59/0x110 arch/x86/entry/common.c:81
 entry_SYSCALL_64_after_hwframe+0x78/0xe2

Last potentially related work creation:
 kasan_save_stack+0x20/0x40 mm/kasan/common.c:45
 __kasan_record_aux_stack+0x94/0xa0 mm/kasan/generic.c:492
 __call_rcu_common.constprop.0+0xc3/0xa10 kernel/rcu/tree.c:2713
 netlink_release+0x620/0xc20 net/netlink/af_netlink.c:802
 __sock_release+0xb5/0x270 net/socket.c:663
 sock_close+0x1e/0x30 net/socket.c:1425
 __fput+0x408/0xab0 fs/file_table.c:384
 __fput_sync+0x4c/0x60 fs/file_table.c:465
 __do_sys_close fs/open.c:1580 [inline]
 __se_sys_close+0x68/0xd0 fs/open.c:1565
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x59/0x110 arch/x86/entry/common.c:81
 entry_SYSCALL_64_after_hwframe+0x78/0xe2

Second to last potentially related work creation:
 kasan_save_stack+0x20/0x40 mm/kasan/common.c:45
 __kasan_record_aux_stack+0x94/0xa0 mm/kasan/generic.c:492
 __call_rcu_common.constprop.0+0xc3/0xa10 kernel/rcu/tree.c:2713
 netlink_release+0x620/0xc20 net/netlink/af_netlink.c:802
 __sock_release+0xb5/0x270 net/socket.c:663
 sock_close+0x1e/0x30 net/socket.c:1425
 __fput+0x408/0xab0 fs/file_table.c:384
 task_work_run+0x154/0x240 kernel/task_work.c:239
 exit_task_work include/linux/task_work.h:45 [inline]
 do_exit+0x8e5/0x1320 kernel/exit.c:874
 do_group_exit+0xcd/0x280 kernel/exit.c:1023
 get_signal+0x1675/0x1850 kernel/signal.c:2905
 arch_do_signal_or_restart+0x80/0x3b0 arch/x86/kernel/signal.c:310
 exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x1b3/0x1e0 kernel/entry/common.c:218
 do_syscall_64+0x66/0x110 arch/x86/entry/common.c:87
 entry_SYSCALL_64_after_hwframe+0x78/0xe2

The buggy address belongs to the object at ffff88800f5be000
 which belongs to the cache kmalloc-2k of size 2048
The buggy address is located 2656 bytes to the right of
 allocated 1280-byte region [ffff88800f5be000, ffff88800f5be500)

...

Memory state around the buggy address:
 ffff88800f5bee00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88800f5bee80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff88800f5bef00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
                                                       ^
 ffff88800f5bef80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88800f5bf000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
==================================================================

By analyzing the vmcore, we found that vc->vc_origin was somehow placed
one line prior to vc->vc_screenbuf when vc was in KD_TEXT mode, and
further writings to /dev/vcs caused out-of-bounds reads (and writes
right after) in vcs_write_buf_noattr().

Our further experiments show that in most cases, vc->vc_origin equals to
vga_vram_base when the console is in KD_TEXT mode, and it's around
vc->vc_screenbuf for the KD_GRAPHICS mode. But via triggerring a
TIOCL_SETVESABLANK ioctl beforehand, we can make vc->vc_origin be around
vc->vc_screenbuf while the console is in KD_TEXT mode, and then by
writing the special 'ESC M' control sequence to the tty certain times
(depends on the value of `vc->state.y - vc->vc_top`), we can eventually
move vc->vc_origin prior to vc->vc_screenbuf. Here's the PoC, tested on
QEMU:

```
int main() {
	const int RI_NUM = 10; // should be greater than `vc->state.y - vc->vc_top`
	int tty_fd, vcs_fd;
	const char *tty_path = "/dev/tty0";
	const char *vcs_path = "/dev/vcs";
	const char escape_seq[] = "\x1bM";  // ESC + M
	const char trigger_seq[] = "Let's trigger an OOB write.";
	struct vt_sizes vt_size = { 70, 2 };
	int blank = TIOCL_BLANKSCREEN;

	tty_fd = open(tty_path, O_RDWR);

	char vesa_mode[] = { TIOCL_SETVESABLANK, 1 };
	ioctl(tty_fd, TIOCLINUX, vesa_mode);

	ioctl(tty_fd, TIOCLINUX, &blank);
	ioctl(tty_fd, VT_RESIZE, &vt_size);

	for (int i = 0; i < RI_NUM; ++i)
		write(tty_fd, escape_seq, sizeof(escape_seq) - 1);

	vcs_fd = open(vcs_path, O_RDWR);
	write(vcs_fd, trigger_seq, sizeof(trigger_seq));

	close(vcs_fd);
	close(tty_fd);
	return 0;
}
```

To solve this problem, add an address range validation check in
vgacon_scroll(), ensuring vc->vc_origin never precedes vc_screenbuf.

Reported-by: syzbot+9c09fda97a1a65ea859b@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=9c09fda97a1a65ea859b [1]
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Co-developed-by: Yi Yang <yiyang13@huawei.com>
Signed-off-by: Yi Yang <yiyang13@huawei.com>
Signed-off-by: GONG Ruiqi <gongruiqi1@huawei.com>
Signed-off-by: Helge Deller <deller@gmx.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/video/console/vgacon.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/video/console/vgacon.c
+++ b/drivers/video/console/vgacon.c
@@ -1198,7 +1198,7 @@ static bool vgacon_scroll(struct vc_data
 				     c->vc_screenbuf_size - delta);
 			c->vc_origin = vga_vram_end - c->vc_screenbuf_size;
 			vga_rolled_over = 0;
-		} else
+		} else if (oldo - delta >= (unsigned long)c->vc_screenbuf)
 			c->vc_origin -= delta;
 		c->vc_scr_end = c->vc_origin + c->vc_screenbuf_size;
 		scr_memsetw((u16 *) (c->vc_origin), c->vc_video_erase_char,



