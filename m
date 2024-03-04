Return-Path: <stable+bounces-25957-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DB49787080E
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 18:10:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58839B26CFF
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 17:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EA105FDB0;
	Mon,  4 Mar 2024 17:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ezqWCkgn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02F64E1DB;
	Mon,  4 Mar 2024 17:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709571982; cv=none; b=ZqFMESwLsa+mEkQw9xgB/jEfZSBewotPwkBFzCwVYZiPJcMSM6xuT+i8FZrr3Fbl/a+IYzPYza5jgbmsGT7CkoME4G63xiAJO+p/kekcxON4nPy9V57Jr5Ayghfuf2B1w8Ba1PHTgb9fJ/oQm0ek8vVz5taG2hVDni6VQtCS1P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709571982; c=relaxed/simple;
	bh=WZihb+6oGuYX/sUIJx4bJJTXPUMDkZlDE3EI6QfRI0c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZiBt+yvOid90OIxS939X3ogdAUmUWY+yZevBRcVKq/59iY3LVP+fAxzW/T+Ut6kg0sYr1+poWZ/3/Vftb768T9KhGyo31YO03iwLmcoP6YNi9wAn+FkiW8JOQd43521gnXgKO7uMluR9S7wcW08oY79HxqNjRKE28+QMSu4cOtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ezqWCkgn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 182C4C433C7;
	Mon,  4 Mar 2024 17:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709571981;
	bh=WZihb+6oGuYX/sUIJx4bJJTXPUMDkZlDE3EI6QfRI0c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ezqWCkgnG7RJudDLQks2ikBp7b8ttSB1WMqIySPNixRnjldCgiKSaxhV14cBMDoEB
	 DwsQxM8B0nx2ZKKFvRb/9N8z31MuHwpbVpV+PJbvpHQs7xAM02d8egPAeoJgZ1+FZb
	 RyyC+Xirp5nW9UgVyjcb4pAkqS8t59Xv9AmJRT35TzBUk2LDHmi+TH8DkV9DmRiBK3
	 RornT7PDuQbWRySX1Z3u9I14dVFx6wfmLdhlgD2049roRXwRIJ5H7rlmquFCTIzEAb
	 atwO40q2ITWTr7rRgJneAEfxjsbQ+eQ7WFeisPalYaWss1A7xOuHxMT8ZQZH9gNSMy
	 eTxQHBAc+TI9A==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>,
	Davide Caratti <dcaratti@redhat.com>,
	Mat Martineau <martineau@kernel.org>,
	Matthieu Baerts <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 5.10.y] mptcp: fix double-free on socket dismantle
Date: Mon,  4 Mar 2024 18:06:15 +0100
Message-ID: <20240304170614.2608800-2-matttbe@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2024030455-plausible-harmonics-a964@gregkh>
References: <2024030455-plausible-harmonics-a964@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7572; i=matttbe@kernel.org; h=from:subject; bh=B8eU2wOlMZzhlfykinS5qfdKEH99UcHBXWQ4CCNsnUU=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBl5f+G1bb1+vFwMRm1Os0P7Bpn9UBw4mI2gFAt+ VEujiQG3ieJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZeX/hgAKCRD2t4JPQmmg c9CeEADGZmQjHs5h68rPohDfTjHTKcOgZuinYqkj6jCNfAmH/uEcBVQpKKNhN1CFv4P7KxrsN31 DOUZBXWFntc9hWyNuigcPAim8zCLlcNX2XWpFT854eSzk0N83t6Upp11/fRRvFYrr0dDmQULrMm iDGsqMsry6Za308c56NiaJvUxgD0U1O+V763h37ZMUQcy4AzVQfpCLKQLUKSUSS/3/BySuGrdBs OmY53ys3eeI68US4DSZB/cfH1j0cF/SJOI7y0SmEJL8727u38spH9fA4iInzHAj6l39nXc0kP3Y G96LW2WJTTu+E4dCsb7g3aCvlHsi8Qgm9+sb8MH1l/fpGxoYgdvEtM+pLka+SMglm1Hj/Fyv7gm Y5oMAkdtWkdapszLvx7HHofLE2jNlVa/9SFtPjXvtcZrsQ0twQOT84eX9ciNSs7hOycYdD9pN2h eqaEjZ3XqcXj9a2S/Bn1u8SGg7jGUB2Xlxtk2AaRWwYUbapHf2kaW9/0OLVqMmcWcVzWNYEl6Ov /z9Hb4KeJAaPfaAXNpyXijx1DOazVWGRQxNw9nzJRpWYmAJ1THb+0i8tvriSOs87ZZYITk003A5 Auu2Y6ZUPfjDxjjuNOyArplzVlijkRIosU59wBKxS6WLwEP/2nM93TJK3cHeEyWsOyCe2RK2jx6 5Mvx9bm3NXlcwpQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

From: Davide Caratti <dcaratti@redhat.com>

when MPTCP server accepts an incoming connection, it clones its listener
socket. However, the pointer to 'inet_opt' for the new socket has the same
value as the original one: as a consequence, on program exit it's possible
to observe the following splat:

  BUG: KASAN: double-free in inet_sock_destruct+0x54f/0x8b0
  Free of addr ffff888485950880 by task swapper/25/0

  CPU: 25 PID: 0 Comm: swapper/25 Kdump: loaded Not tainted 6.8.0-rc1+ #609
  Hardware name: Supermicro SYS-6027R-72RF/X9DRH-7TF/7F/iTF/iF, BIOS 3.0  07/26/2013
  Call Trace:
   <IRQ>
   dump_stack_lvl+0x32/0x50
   print_report+0xca/0x620
   kasan_report_invalid_free+0x64/0x90
   __kasan_slab_free+0x1aa/0x1f0
   kfree+0xed/0x2e0
   inet_sock_destruct+0x54f/0x8b0
   __sk_destruct+0x48/0x5b0
   rcu_do_batch+0x34e/0xd90
   rcu_core+0x559/0xac0
   __do_softirq+0x183/0x5a4
   irq_exit_rcu+0x12d/0x170
   sysvec_apic_timer_interrupt+0x6b/0x80
   </IRQ>
   <TASK>
   asm_sysvec_apic_timer_interrupt+0x16/0x20
  RIP: 0010:cpuidle_enter_state+0x175/0x300
  Code: 30 00 0f 84 1f 01 00 00 83 e8 01 83 f8 ff 75 e5 48 83 c4 18 44 89 e8 5b 5d 41 5c 41 5d 41 5e 41 5f c3 cc cc cc cc fb 45 85 ed <0f> 89 60 ff ff ff 48 c1 e5 06 48 c7 43 18 00 00 00 00 48 83 44 2b
  RSP: 0018:ffff888481cf7d90 EFLAGS: 00000202
  RAX: 0000000000000000 RBX: ffff88887facddc8 RCX: 0000000000000000
  RDX: 1ffff1110ff588b1 RSI: 0000000000000019 RDI: ffff88887fac4588
  RBP: 0000000000000004 R08: 0000000000000002 R09: 0000000000043080
  R10: 0009b02ea273363f R11: ffff88887fabf42b R12: ffffffff932592e0
  R13: 0000000000000004 R14: 0000000000000000 R15: 00000022c880ec80
   cpuidle_enter+0x4a/0xa0
   do_idle+0x310/0x410
   cpu_startup_entry+0x51/0x60
   start_secondary+0x211/0x270
   secondary_startup_64_no_verify+0x184/0x18b
   </TASK>

  Allocated by task 6853:
   kasan_save_stack+0x1c/0x40
   kasan_save_track+0x10/0x30
   __kasan_kmalloc+0xa6/0xb0
   __kmalloc+0x1eb/0x450
   cipso_v4_sock_setattr+0x96/0x360
   netlbl_sock_setattr+0x132/0x1f0
   selinux_netlbl_socket_post_create+0x6c/0x110
   selinux_socket_post_create+0x37b/0x7f0
   security_socket_post_create+0x63/0xb0
   __sock_create+0x305/0x450
   __sys_socket_create.part.23+0xbd/0x130
   __sys_socket+0x37/0xb0
   __x64_sys_socket+0x6f/0xb0
   do_syscall_64+0x83/0x160
   entry_SYSCALL_64_after_hwframe+0x6e/0x76

  Freed by task 6858:
   kasan_save_stack+0x1c/0x40
   kasan_save_track+0x10/0x30
   kasan_save_free_info+0x3b/0x60
   __kasan_slab_free+0x12c/0x1f0
   kfree+0xed/0x2e0
   inet_sock_destruct+0x54f/0x8b0
   __sk_destruct+0x48/0x5b0
   subflow_ulp_release+0x1f0/0x250
   tcp_cleanup_ulp+0x6e/0x110
   tcp_v4_destroy_sock+0x5a/0x3a0
   inet_csk_destroy_sock+0x135/0x390
   tcp_fin+0x416/0x5c0
   tcp_data_queue+0x1bc8/0x4310
   tcp_rcv_state_process+0x15a3/0x47b0
   tcp_v4_do_rcv+0x2c1/0x990
   tcp_v4_rcv+0x41fb/0x5ed0
   ip_protocol_deliver_rcu+0x6d/0x9f0
   ip_local_deliver_finish+0x278/0x360
   ip_local_deliver+0x182/0x2c0
   ip_rcv+0xb5/0x1c0
   __netif_receive_skb_one_core+0x16e/0x1b0
   process_backlog+0x1e3/0x650
   __napi_poll+0xa6/0x500
   net_rx_action+0x740/0xbb0
   __do_softirq+0x183/0x5a4

  The buggy address belongs to the object at ffff888485950880
   which belongs to the cache kmalloc-64 of size 64
  The buggy address is located 0 bytes inside of
   64-byte region [ffff888485950880, ffff8884859508c0)

  The buggy address belongs to the physical page:
  page:0000000056d1e95e refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff888485950700 pfn:0x485950
  flags: 0x57ffffc0000800(slab|node=1|zone=2|lastcpupid=0x1fffff)
  page_type: 0xffffffff()
  raw: 0057ffffc0000800 ffff88810004c640 ffffea00121b8ac0 dead000000000006
  raw: ffff888485950700 0000000000200019 00000001ffffffff 0000000000000000
  page dumped because: kasan: bad access detected

  Memory state around the buggy address:
   ffff888485950780: fa fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
   ffff888485950800: fa fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
  >ffff888485950880: fa fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
                     ^
   ffff888485950900: fa fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
   ffff888485950980: 00 00 00 00 00 01 fc fc fc fc fc fc fc fc fc fc

Something similar (a refcount underflow) happens with CALIPSO/IPv6. Fix
this by duplicating IP / IPv6 options after clone, so that
ip{,6}_sock_destruct() doesn't end up freeing the same memory area twice.

Fixes: cf7da0d66cc1 ("mptcp: Create SUBFLOW socket for incoming connections")
Cc: stable@vger.kernel.org
Signed-off-by: Davide Caratti <dcaratti@redhat.com>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://lore.kernel.org/r/20240223-upstream-net-20240223-misc-fixes-v1-8-162e87e48497@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
(cherry picked from commit 10048689def7e40a4405acda16fdc6477d4ecc5c)
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Notes:
 - Conflicts in protocol.c because mptcp_sk_clone() has been renamed to
   mptcp_sk_clone_init() in commit 7e8b88ec35ee ("mptcp: consolidate
   passive msk socket initialization") which has not been backported to
   v5.10 due to a too long list of dependences.
 - This is the same patch as the one sent earlier for v5.15.
---
 net/mptcp/protocol.c | 49 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 72d944e6a641..adbe6350f980 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2052,8 +2052,50 @@ static struct ipv6_pinfo *mptcp_inet6_sk(const struct sock *sk)
 
 	return (struct ipv6_pinfo *)(((u8 *)sk) + offset);
 }
+
+static void mptcp_copy_ip6_options(struct sock *newsk, const struct sock *sk)
+{
+	const struct ipv6_pinfo *np = inet6_sk(sk);
+	struct ipv6_txoptions *opt;
+	struct ipv6_pinfo *newnp;
+
+	newnp = inet6_sk(newsk);
+
+	rcu_read_lock();
+	opt = rcu_dereference(np->opt);
+	if (opt) {
+		opt = ipv6_dup_options(newsk, opt);
+		if (!opt)
+			net_warn_ratelimited("%s: Failed to copy ip6 options\n", __func__);
+	}
+	RCU_INIT_POINTER(newnp->opt, opt);
+	rcu_read_unlock();
+}
 #endif
 
+static void mptcp_copy_ip_options(struct sock *newsk, const struct sock *sk)
+{
+	struct ip_options_rcu *inet_opt, *newopt = NULL;
+	const struct inet_sock *inet = inet_sk(sk);
+	struct inet_sock *newinet;
+
+	newinet = inet_sk(newsk);
+
+	rcu_read_lock();
+	inet_opt = rcu_dereference(inet->inet_opt);
+	if (inet_opt) {
+		newopt = sock_kmalloc(newsk, sizeof(*inet_opt) +
+				      inet_opt->opt.optlen, GFP_ATOMIC);
+		if (newopt)
+			memcpy(newopt, inet_opt, sizeof(*inet_opt) +
+			       inet_opt->opt.optlen);
+		else
+			net_warn_ratelimited("%s: Failed to copy ip options\n", __func__);
+	}
+	RCU_INIT_POINTER(newinet->inet_opt, newopt);
+	rcu_read_unlock();
+}
+
 struct sock *mptcp_sk_clone(const struct sock *sk,
 			    const struct mptcp_options_received *mp_opt,
 			    struct request_sock *req)
@@ -2073,6 +2115,13 @@ struct sock *mptcp_sk_clone(const struct sock *sk,
 
 	__mptcp_init_sock(nsk);
 
+#if IS_ENABLED(CONFIG_MPTCP_IPV6)
+	if (nsk->sk_family == AF_INET6)
+		mptcp_copy_ip6_options(nsk, sk);
+	else
+#endif
+		mptcp_copy_ip_options(nsk, sk);
+
 	msk = mptcp_sk(nsk);
 	msk->local_key = subflow_req->local_key;
 	msk->token = subflow_req->token;
-- 
2.43.0


