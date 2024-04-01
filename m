Return-Path: <stable+bounces-34804-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A4F98940EA
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 18:35:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6DB30B21A88
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 16:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0538238DD8;
	Mon,  1 Apr 2024 16:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="M7pgJqag"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A351C0DE7;
	Mon,  1 Apr 2024 16:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711989353; cv=none; b=OGtdbmImjF9TuccT+TrWzJfqdrHPIlBSOeUx7+Cf4q+a+Q1VkGEtMsrTuTupC/arkDy4nV5MVfMQLdkzYA9vZKhP3jCUVB4joQUlQnyHeOIJH9VXo2H7lUSrf39XuBM7DiL9AwTJ/FCCzoa0/XRRyiJdM1a6avYUAN58/FS4tOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711989353; c=relaxed/simple;
	bh=5cmLqPFqSCc6hQCRS12QoBL3mWAAzwePMo7mt5aBvxg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GNy7iDdqR+PqMVDy2Uwpi82WgVeNuddNO0+d6fNuRQDnUYJS2kuHlhtd2Fcr/B8vriMi6RtUqUVkqGzOu+OD9WUhkPfBxxOqPeexitKTOp/jWYziI1GL1ZF6aE8FiLMA05aV5v0MNYlnorBJc7DSi5BQd8kYOOqVi4oPOFL20yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=M7pgJqag; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F0E5C433F1;
	Mon,  1 Apr 2024 16:35:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711989353;
	bh=5cmLqPFqSCc6hQCRS12QoBL3mWAAzwePMo7mt5aBvxg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M7pgJqagfVq5VPbKqQuseCt+KCp52RGhvl8RgTrclGlHrC9igC7cAhM8+dfiupBfS
	 sQxJW1a7pjwT2ar80MGpQM2kqUKIYbPztYkuLuCU4Qy3MduW2MpdgX/LdnfTBTSohR
	 IqrdI2Ewg0b1ovNgImctzIMb7tU6/Asg1zt245i8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Zack Rusin <zack.rusin@broadcom.com>,
	Stefan Hoffmeister <stefan.hoffmeister@econos.de>,
	Martin Krastev <martin.krastev@broadcom.com>,
	Maaz Mombasawala <maaz.mombasawala@broadcom.com>,
	Ian Forbes <ian.forbes@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	dri-devel@lists.freedesktop.org,
	Javier Martinez Canillas <javierm@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 003/396] drm/vmwgfx: Unmap the surface before resetting it on a plane state
Date: Mon,  1 Apr 2024 17:40:52 +0200
Message-ID: <20240401152547.978750789@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240401152547.867452742@linuxfoundation.org>
References: <20240401152547.867452742@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zack Rusin <zack.rusin@broadcom.com>

[ Upstream commit 27571c64f1855881753e6f33c3186573afbab7ba ]

Switch to a new plane state requires unreferencing of all held surfaces.
In the work required for mob cursors the mapped surfaces started being
cached but the variable indicating whether the surface is currently
mapped was not being reset. This leads to crashes as the duplicated
state, incorrectly, indicates the that surface is mapped even when
no surface is present. That's because after unreferencing the surface
it's perfectly possible for the plane to be backed by a bo instead of a
surface.

Reset the surface mapped flag when unreferencing the plane state surface
to fix null derefs in cleanup. Fixes crashes in KDE KWin 6.0 on Wayland:

Oops: 0000 [#1] PREEMPT SMP PTI
CPU: 4 PID: 2533 Comm: kwin_wayland Not tainted 6.7.0-rc3-vmwgfx #2
Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 11/12/2020
RIP: 0010:vmw_du_cursor_plane_cleanup_fb+0x124/0x140 [vmwgfx]
Code: 00 00 00 75 3a 48 83 c4 10 5b 5d c3 cc cc cc cc 48 8b b3 a8 00 00 00 48 c7 c7 99 90 43 c0 e8 93 c5 db ca 48 8b 83 a8 00 00 00 <48> 8b 78 28 e8 e3 f>
RSP: 0018:ffffb6b98216fa80 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffff969d84cdcb00 RCX: 0000000000000027
RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffff969e75f21600
RBP: ffff969d4143dc50 R08: 0000000000000000 R09: ffffb6b98216f920
R10: 0000000000000003 R11: ffff969e7feb3b10 R12: 0000000000000000
R13: 0000000000000000 R14: 000000000000027b R15: ffff969d49c9fc00
FS:  00007f1e8f1b4180(0000) GS:ffff969e75f00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000028 CR3: 0000000104006004 CR4: 00000000003706f0
Call Trace:
 <TASK>
 ? __die+0x23/0x70
 ? page_fault_oops+0x171/0x4e0
 ? exc_page_fault+0x7f/0x180
 ? asm_exc_page_fault+0x26/0x30
 ? vmw_du_cursor_plane_cleanup_fb+0x124/0x140 [vmwgfx]
 drm_atomic_helper_cleanup_planes+0x9b/0xc0
 commit_tail+0xd1/0x130
 drm_atomic_helper_commit+0x11a/0x140
 drm_atomic_commit+0x97/0xd0
 ? __pfx___drm_printfn_info+0x10/0x10
 drm_atomic_helper_update_plane+0xf5/0x160
 drm_mode_cursor_universal+0x10e/0x270
 drm_mode_cursor_common+0x102/0x230
 ? __pfx_drm_mode_cursor2_ioctl+0x10/0x10
 drm_ioctl_kernel+0xb2/0x110
 drm_ioctl+0x26d/0x4b0
 ? __pfx_drm_mode_cursor2_ioctl+0x10/0x10
 ? __pfx_drm_ioctl+0x10/0x10
 vmw_generic_ioctl+0xa4/0x110 [vmwgfx]
 __x64_sys_ioctl+0x94/0xd0
 do_syscall_64+0x61/0xe0
 ? __x64_sys_ioctl+0xaf/0xd0
 ? syscall_exit_to_user_mode+0x2b/0x40
 ? do_syscall_64+0x70/0xe0
 ? __x64_sys_ioctl+0xaf/0xd0
 ? syscall_exit_to_user_mode+0x2b/0x40
 ? do_syscall_64+0x70/0xe0
 ? exc_page_fault+0x7f/0x180
 entry_SYSCALL_64_after_hwframe+0x6e/0x76
RIP: 0033:0x7f1e93f279ed
Code: 04 25 28 00 00 00 48 89 45 c8 31 c0 48 8d 45 10 c7 45 b0 10 00 00 00 48 89 45 b8 48 8d 45 d0 48 89 45 c0 b8 10 00 00 00 0f 05 <89> c2 3d 00 f0 ff f>
RSP: 002b:00007ffca0faf600 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 000055db876ed2c0 RCX: 00007f1e93f279ed
RDX: 00007ffca0faf6c0 RSI: 00000000c02464bb RDI: 0000000000000015
RBP: 00007ffca0faf650 R08: 000055db87184010 R09: 0000000000000007
R10: 000055db886471a0 R11: 0000000000000246 R12: 00007ffca0faf6c0
R13: 00000000c02464bb R14: 0000000000000015 R15: 00007ffca0faf790
 </TASK>
Modules linked in: snd_seq_dummy snd_hrtimer nf_conntrack_netbios_ns nf_conntrack_broadcast nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_ine>
CR2: 0000000000000028
---[ end trace 0000000000000000 ]---
RIP: 0010:vmw_du_cursor_plane_cleanup_fb+0x124/0x140 [vmwgfx]
Code: 00 00 00 75 3a 48 83 c4 10 5b 5d c3 cc cc cc cc 48 8b b3 a8 00 00 00 48 c7 c7 99 90 43 c0 e8 93 c5 db ca 48 8b 83 a8 00 00 00 <48> 8b 78 28 e8 e3 f>
RSP: 0018:ffffb6b98216fa80 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffff969d84cdcb00 RCX: 0000000000000027
RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffff969e75f21600
RBP: ffff969d4143dc50 R08: 0000000000000000 R09: ffffb6b98216f920
R10: 0000000000000003 R11: ffff969e7feb3b10 R12: 0000000000000000
R13: 0000000000000000 R14: 000000000000027b R15: ffff969d49c9fc00
FS:  00007f1e8f1b4180(0000) GS:ffff969e75f00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000028 CR3: 0000000104006004 CR4: 00000000003706f0

Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
Fixes: 485d98d472d5 ("drm/vmwgfx: Add support for CursorMob and CursorBypass 4")
Reported-by: Stefan Hoffmeister <stefan.hoffmeister@econos.de>
Closes: https://gitlab.freedesktop.org/drm/misc/-/issues/34
Cc: Martin Krastev <martin.krastev@broadcom.com>
Cc: Maaz Mombasawala <maaz.mombasawala@broadcom.com>
Cc: Ian Forbes <ian.forbes@broadcom.com>
Cc: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: dri-devel@lists.freedesktop.org
Cc: <stable@vger.kernel.org> # v5.19+
Acked-by: Javier Martinez Canillas <javierm@redhat.com>
Reviewed-by: Maaz Mombasawala <maaz.mombasawala@broadcom.com>
Reviewed-by: Martin Krastev <martin.krastev@broadcom.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20231224052540.605040-1-zack.rusin@broadcom.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
index b51578918cf8d..496ff2a6144c1 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
@@ -703,6 +703,10 @@ vmw_du_cursor_plane_prepare_fb(struct drm_plane *plane,
 	int ret = 0;
 
 	if (vps->surf) {
+		if (vps->surf_mapped) {
+			vmw_bo_unmap(vps->surf->res.guest_memory_bo);
+			vps->surf_mapped = false;
+		}
 		vmw_surface_unreference(&vps->surf);
 		vps->surf = NULL;
 	}
-- 
2.43.0




