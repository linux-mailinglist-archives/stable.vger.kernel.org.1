Return-Path: <stable+bounces-110319-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EAE6A1A966
	for <lists+stable@lfdr.de>; Thu, 23 Jan 2025 19:08:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F2CE167077
	for <lists+stable@lfdr.de>; Thu, 23 Jan 2025 18:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C8971A00F8;
	Thu, 23 Jan 2025 18:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fVVBdm6K"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2B41990AE;
	Thu, 23 Jan 2025 18:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737655653; cv=none; b=KAx7xCSaQU8YDfMp+mqB2+0nIPjGEsgCliPZ8xfe2dEeYtLKUe8kf+ZZJD1Km54NqRDyN7Pt4qKVKXItNG+4/c+H3hXGNK0h1oyPoMuEa5ZG9N8oGfO+mgAVdcsCMAPVGJQfDeYaP1/wXv8tsFzJdoE1Dt4erwL1RgQngYymqqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737655653; c=relaxed/simple;
	bh=0SsF6HfMDWe4t3nDdp9eu6bgqCYsakwzwWaLGDc6vr0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Y7SJwQTYZUdQ0gKORKNgBtP6Y4bgY/8st8/z+OUic5dFXVnRKQCU4lIBhpgkj0HujA5l6gX4ZaB+HSCo/ZnKHESpYEC1k+sJatKzM386611JRyfmUx1NMKqs0S7QpUq5+m+1mfTjlnP/7FfQgPfLTjqlJ91CLnLNTTkPy1/lAoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fVVBdm6K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F939C4CEE2;
	Thu, 23 Jan 2025 18:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737655652;
	bh=0SsF6HfMDWe4t3nDdp9eu6bgqCYsakwzwWaLGDc6vr0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=fVVBdm6KaVpY45Xh6ExLwYSTe3Kg3LeDqqWLJnJkhBp+eNCOoAwhlHMFDmmEV3xd7
	 ZxooqA2VrPF3RobZ1Y3pA+Vago10mF4799/hd05HQ96vSQEqdAk1FdIXPidpNGEWyT
	 hLezH+1E1zLBuiAMSubtxU5jxmCN6x+NN9r7ctf2QLML+CtZAkGBr0ZMPG8Ablg8Hw
	 BDBCSnDLiCa7xg16Fntt8iFgb0irBtA3pDVsCl9lqB/X5TihwlOt0Pg47os13HCh+F
	 95IJBxFS1RkJcDISiYcm+qflcdaWzovaPJmCAQ79G2dt9vrSNJ31VaXkfWWFn1FW80
	 fYPDhU1bcqH0Q==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 23 Jan 2025 19:05:55 +0100
Subject: [PATCH net 2/3] mptcp: pm: only set fullmesh for subflow endp
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250123-net-mptcp-syzbot-issues-v1-2-af73258a726f@kernel.org>
References: <20250123-net-mptcp-syzbot-issues-v1-0-af73258a726f@kernel.org>
In-Reply-To: <20250123-net-mptcp-syzbot-issues-v1-0-af73258a726f@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, stable@vger.kernel.org, 
 syzbot+cd16e79c1e45f3fe0377@syzkaller.appspotmail.com
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5607; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=0SsF6HfMDWe4t3nDdp9eu6bgqCYsakwzwWaLGDc6vr0=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnkoVbpLaGZiQzQEGgHLRhkoDruVr2Mw671+Ih0
 0YPEXhRkh2JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ5KFWwAKCRD2t4JPQmmg
 cw7uEADf3wbj1CyuqKoOgyVHCukR6DpkRrDBCGd7x+tvA6XC9kk7fXYht9oNM9E9RqIAHriemSD
 CpLcvKTuwjl4hvXGe+UKR+MQ5Jym4yyF7nyJ39ZlBdPVaHSKgudXg919wNl76rU6FFff974sQXU
 ONfNv54AnnwkMzuzze4Rr7zoItgShy5rQVWzb3M9WoCgfqS9EFsxB0rsr1i7fBTSlKo+ShAOJlv
 SFSrGrkreHBKWrrfK6bCEVzWLl5aF+bzy+yu4mbwigzyJ2od4UUx4qCCYkl01S3u+CGqeq6raRd
 p6g8fwZ1ICVrso8cAG05KGGMlQrl9aFAhusdb1ekeVZUSvDP+qNdqGFMZBYh7pTbhI+vBVi4TZC
 QsA6AckuqAHECbTl3X7b10/T2JFqMAcI616C6Qib3P1JD/GretGYqFxKMSRKl1uqp/sODfaKYJp
 P/WHrKzmi6exrMh5FPHQqJNlHdJjVPjpXa832g0x65fpg63oB1fq22u66XEYtbPGXrJLD7MyfCn
 CWNq+uP6OL1N8SFi64LkyhHFZfkXi1YEYHBhxehjqaiBRW0Lkn+9pct7M6UeHPBzV6YPbcdjvBp
 t8BEe1x+IgpdBYvFn+0av4WPONhTOukwCKSHBWu7JLNSSs1JM96enOAj47KuHiAhT/WJ1WDTvmG
 DZbs3xaDKLJ79YQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

With the in-kernel path-manager, it is possible to change the 'fullmesh'
flag. The code in mptcp_pm_nl_fullmesh() expects to change it only on
'subflow' endpoints, to recreate more or less subflows using the linked
address.

Unfortunately, the set_flags() hook was a bit more permissive, and
allowed 'implicit' endpoints to get the 'fullmesh' flag while it is not
allowed before.

That's what syzbot found, triggering the following warning:

  WARNING: CPU: 0 PID: 6499 at net/mptcp/pm_netlink.c:1496 __mark_subflow_endp_available net/mptcp/pm_netlink.c:1496 [inline]
  WARNING: CPU: 0 PID: 6499 at net/mptcp/pm_netlink.c:1496 mptcp_pm_nl_fullmesh net/mptcp/pm_netlink.c:1980 [inline]
  WARNING: CPU: 0 PID: 6499 at net/mptcp/pm_netlink.c:1496 mptcp_nl_set_flags net/mptcp/pm_netlink.c:2003 [inline]
  WARNING: CPU: 0 PID: 6499 at net/mptcp/pm_netlink.c:1496 mptcp_pm_nl_set_flags+0x974/0xdc0 net/mptcp/pm_netlink.c:2064
  Modules linked in:
  CPU: 0 UID: 0 PID: 6499 Comm: syz.1.413 Not tainted 6.13.0-rc5-syzkaller-00172-gd1bf27c4e176 #0
  Hardware name: Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
  RIP: 0010:__mark_subflow_endp_available net/mptcp/pm_netlink.c:1496 [inline]
  RIP: 0010:mptcp_pm_nl_fullmesh net/mptcp/pm_netlink.c:1980 [inline]
  RIP: 0010:mptcp_nl_set_flags net/mptcp/pm_netlink.c:2003 [inline]
  RIP: 0010:mptcp_pm_nl_set_flags+0x974/0xdc0 net/mptcp/pm_netlink.c:2064
  Code: 01 00 00 49 89 c5 e8 fb 45 e8 f5 e9 b8 fc ff ff e8 f1 45 e8 f5 4c 89 f7 be 03 00 00 00 e8 44 1d 0b f9 eb a0 e8 dd 45 e8 f5 90 <0f> 0b 90 e9 17 ff ff ff 89 d9 80 e1 07 38 c1 0f 8c c9 fc ff ff 48
  RSP: 0018:ffffc9000d307240 EFLAGS: 00010293
  RAX: ffffffff8bb72e03 RBX: 0000000000000000 RCX: ffff88807da88000
  RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
  RBP: ffffc9000d307430 R08: ffffffff8bb72cf0 R09: 1ffff1100b842a5e
  R10: dffffc0000000000 R11: ffffed100b842a5f R12: ffff88801e2e5ac0
  R13: ffff88805c214800 R14: ffff88805c2152e8 R15: 1ffff1100b842a5d
  FS:  00005555619f6500(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: 0000000020002840 CR3: 00000000247e6000 CR4: 00000000003526f0
  DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
  DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
  Call Trace:
   <TASK>
   genl_family_rcv_msg_doit net/netlink/genetlink.c:1115 [inline]
   genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
   genl_rcv_msg+0xb14/0xec0 net/netlink/genetlink.c:1210
   netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2542
   genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
   netlink_unicast_kernel net/netlink/af_netlink.c:1321 [inline]
   netlink_unicast+0x7f6/0x990 net/netlink/af_netlink.c:1347
   netlink_sendmsg+0x8e4/0xcb0 net/netlink/af_netlink.c:1891
   sock_sendmsg_nosec net/socket.c:711 [inline]
   __sock_sendmsg+0x221/0x270 net/socket.c:726
   ____sys_sendmsg+0x52a/0x7e0 net/socket.c:2583
   ___sys_sendmsg net/socket.c:2637 [inline]
   __sys_sendmsg+0x269/0x350 net/socket.c:2669
   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
   do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
   entry_SYSCALL_64_after_hwframe+0x77/0x7f
  RIP: 0033:0x7f5fe8785d29
  Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
  RSP: 002b:00007fff571f5558 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
  RAX: ffffffffffffffda RBX: 00007f5fe8975fa0 RCX: 00007f5fe8785d29
  RDX: 0000000000000000 RSI: 0000000020000480 RDI: 0000000000000007
  RBP: 00007f5fe8801b08 R08: 0000000000000000 R09: 0000000000000000
  R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
  R13: 00007f5fe8975fa0 R14: 00007f5fe8975fa0 R15: 00000000000011f4
   </TASK>

Here, syzbot managed to set the 'fullmesh' flag on an 'implicit' and
used -- according to 'id_avail_bitmap' -- endpoint, causing the PM to
try decrement the local_addr_used counter which is only incremented for
the 'subflow' endpoint.

Note that 'no type' endpoints -- not 'subflow', 'signal', 'implicit' --
are fine, because their ID will not be marked as used in the 'id_avail'
bitmap, and setting 'fullmesh' can help forcing the creation of subflow
when receiving an ADD_ADDR.

Fixes: 73c762c1f07d ("mptcp: set fullmesh flag in pm_netlink")
Cc: stable@vger.kernel.org
Reported-by: syzbot+cd16e79c1e45f3fe0377@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/6786ac51.050a0220.216c54.00a6.GAE@google.com
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/540
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_netlink.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 98ac73938bd8196e196d5ee8c264784ba8d37645..572d160edca33c0a941203d8ae0b0bde0f2ef3e2 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -2020,7 +2020,8 @@ int mptcp_pm_nl_set_flags(struct sk_buff *skb, struct genl_info *info)
 		return -EINVAL;
 	}
 	if ((addr.flags & MPTCP_PM_ADDR_FLAG_FULLMESH) &&
-	    (entry->flags & MPTCP_PM_ADDR_FLAG_SIGNAL)) {
+	    (entry->flags & (MPTCP_PM_ADDR_FLAG_SIGNAL |
+			     MPTCP_PM_ADDR_FLAG_IMPLICIT))) {
 		spin_unlock_bh(&pernet->lock);
 		GENL_SET_ERR_MSG(info, "invalid addr flags");
 		return -EINVAL;

-- 
2.47.1


