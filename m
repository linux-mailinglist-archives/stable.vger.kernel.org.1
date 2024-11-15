Return-Path: <stable+bounces-93296-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 571049CD86E
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 07:50:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 189E3283BC6
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 06:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3A70187848;
	Fri, 15 Nov 2024 06:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="k5HhDHeo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810F7EAD0;
	Fri, 15 Nov 2024 06:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731653446; cv=none; b=LsIi59Lv9AQEjm7IfTZ54K2tq7YfrIrOXlqqZQ4LdDUI04XHz7/u+VAL8X54nSPsKaU4yC318bG4f5FiN2YSnDEmTjZnvblPFu2ddfw/bjpTnyaItOG1fgd69w49b9JZroxulIyAPNxGcnWmQf6hhELuhQM0oCy9XvwDdWMjhfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731653446; c=relaxed/simple;
	bh=afj5x5GiNYBbRaQTkO+p6r3fDGl9lRCHHNzsi1uXs1E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sTkNhSazL3v0sJHPiSh3ZDeQneD0L612xHQOjCO8YG6LvN+vkTC8dXfer0JZFuhaXiTtecRGRstPfHDKgWa5kEiQ2+IusGK4/4tORThC+BxVNw1d69RfRfUN7pk1OcHnRmw7Y2/6LzvM9HQfk8fngbaBY+CpxdtqBhyMmkOebUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=k5HhDHeo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E42B2C4CECF;
	Fri, 15 Nov 2024 06:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731653446;
	bh=afj5x5GiNYBbRaQTkO+p6r3fDGl9lRCHHNzsi1uXs1E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k5HhDHeoAJXeLHFvecVkvnzC3oDkTY8nTODC3F+erlQKBJ6YNmplq0OWmQR0G664n
	 kD5xrlkZD+IcITopEdbjD5usqVtGMjIav87YoG6qwDp82cxfBTvTk71rpMoCfWjqov
	 1bsGJGmef+/2jdAizxNAQYrUGA/PwAd7djKnGk6M=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Tom Talpey <tom@talpey.com>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 24/48] smb: client: Fix use-after-free of network namespace.
Date: Fri, 15 Nov 2024 07:38:13 +0100
Message-ID: <20241115063723.836857660@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241115063722.962047137@linuxfoundation.org>
References: <20241115063722.962047137@linuxfoundation.org>
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

From: Kuniyuki Iwashima <kuniyu@amazon.com>

[ Upstream commit ef7134c7fc48e1441b398e55a862232868a6f0a7 ]

Recently, we got a customer report that CIFS triggers oops while
reconnecting to a server.  [0]

The workload runs on Kubernetes, and some pods mount CIFS servers
in non-root network namespaces.  The problem rarely happened, but
it was always while the pod was dying.

The root cause is wrong reference counting for network namespace.

CIFS uses kernel sockets, which do not hold refcnt of the netns that
the socket belongs to.  That means CIFS must ensure the socket is
always freed before its netns; otherwise, use-after-free happens.

The repro steps are roughly:

  1. mount CIFS in a non-root netns
  2. drop packets from the netns
  3. destroy the netns
  4. unmount CIFS

We can reproduce the issue quickly with the script [1] below and see
the splat [2] if CONFIG_NET_NS_REFCNT_TRACKER is enabled.

When the socket is TCP, it is hard to guarantee the netns lifetime
without holding refcnt due to async timers.

Let's hold netns refcnt for each socket as done for SMC in commit
9744d2bf1976 ("smc: Fix use-after-free in tcp_write_timer_handler().").

Note that we need to move put_net() from cifs_put_tcp_session() to
clean_demultiplex_info(); otherwise, __sock_create() still could touch a
freed netns while cifsd tries to reconnect from cifs_demultiplex_thread().

Also, maybe_get_net() cannot be put just before __sock_create() because
the code is not under RCU and there is a small chance that the same
address happened to be reallocated to another netns.

[0]:
CIFS: VFS: \\XXXXXXXXXXX has not responded in 15 seconds. Reconnecting...
CIFS: Serverclose failed 4 times, giving up
Unable to handle kernel paging request at virtual address 14de99e461f84a07
Mem abort info:
  ESR = 0x0000000096000004
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x04: level 0 translation fault
Data abort info:
  ISV = 0, ISS = 0x00000004
  CM = 0, WnR = 0
[14de99e461f84a07] address between user and kernel address ranges
Internal error: Oops: 0000000096000004 [#1] SMP
Modules linked in: cls_bpf sch_ingress nls_utf8 cifs cifs_arc4 cifs_md4 dns_resolver tcp_diag inet_diag veth xt_state xt_connmark nf_conntrack_netlink xt_nat xt_statistic xt_MASQUERADE xt_mark xt_addrtype ipt_REJECT nf_reject_ipv4 nft_chain_nat nf_nat xt_conntrack nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 xt_comment nft_compat nf_tables nfnetlink overlay nls_ascii nls_cp437 sunrpc vfat fat aes_ce_blk aes_ce_cipher ghash_ce sm4_ce_cipher sm4 sm3_ce sm3 sha3_ce sha512_ce sha512_arm64 sha1_ce ena button sch_fq_codel loop fuse configfs dmi_sysfs sha2_ce sha256_arm64 dm_mirror dm_region_hash dm_log dm_mod dax efivarfs
CPU: 5 PID: 2690970 Comm: cifsd Not tainted 6.1.103-109.184.amzn2023.aarch64 #1
Hardware name: Amazon EC2 r7g.4xlarge/, BIOS 1.0 11/1/2018
pstate: 00400005 (nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : fib_rules_lookup+0x44/0x238
lr : __fib_lookup+0x64/0xbc
sp : ffff8000265db790
x29: ffff8000265db790 x28: 0000000000000000 x27: 000000000000bd01
x26: 0000000000000000 x25: ffff000b4baf8000 x24: ffff00047b5e4580
x23: ffff8000265db7e0 x22: 0000000000000000 x21: ffff00047b5e4500
x20: ffff0010e3f694f8 x19: 14de99e461f849f7 x18: 0000000000000000
x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
x14: 0000000000000000 x13: 0000000000000000 x12: 3f92800abd010002
x11: 0000000000000001 x10: ffff0010e3f69420 x9 : ffff800008a6f294
x8 : 0000000000000000 x7 : 0000000000000006 x6 : 0000000000000000
x5 : 0000000000000001 x4 : ffff001924354280 x3 : ffff8000265db7e0
x2 : 0000000000000000 x1 : ffff0010e3f694f8 x0 : ffff00047b5e4500
Call trace:
 fib_rules_lookup+0x44/0x238
 __fib_lookup+0x64/0xbc
 ip_route_output_key_hash_rcu+0x2c4/0x398
 ip_route_output_key_hash+0x60/0x8c
 tcp_v4_connect+0x290/0x488
 __inet_stream_connect+0x108/0x3d0
 inet_stream_connect+0x50/0x78
 kernel_connect+0x6c/0xac
 generic_ip_connect+0x10c/0x6c8 [cifs]
 __reconnect_target_unlocked+0xa0/0x214 [cifs]
 reconnect_dfs_server+0x144/0x460 [cifs]
 cifs_reconnect+0x88/0x148 [cifs]
 cifs_readv_from_socket+0x230/0x430 [cifs]
 cifs_read_from_socket+0x74/0xa8 [cifs]
 cifs_demultiplex_thread+0xf8/0x704 [cifs]
 kthread+0xd0/0xd4
Code: aa0003f8 f8480f13 eb18027f 540006c0 (b9401264)

[1]:
CIFS_CRED="/root/cred.cifs"
CIFS_USER="Administrator"
CIFS_PASS="Password"
CIFS_IP="X.X.X.X"
CIFS_PATH="//${CIFS_IP}/Users/Administrator/Desktop/CIFS_TEST"
CIFS_MNT="/mnt/smb"
DEV="enp0s3"

cat <<EOF > ${CIFS_CRED}
username=${CIFS_USER}
password=${CIFS_PASS}
domain=EXAMPLE.COM
EOF

unshare -n bash -c "
mkdir -p ${CIFS_MNT}
ip netns attach root 1
ip link add eth0 type veth peer veth0 netns root
ip link set eth0 up
ip -n root link set veth0 up
ip addr add 192.168.0.2/24 dev eth0
ip -n root addr add 192.168.0.1/24 dev veth0
ip route add default via 192.168.0.1 dev eth0
ip netns exec root sysctl net.ipv4.ip_forward=1
ip netns exec root iptables -t nat -A POSTROUTING -s 192.168.0.2 -o ${DEV} -j MASQUERADE
mount -t cifs ${CIFS_PATH} ${CIFS_MNT} -o vers=3.0,sec=ntlmssp,credentials=${CIFS_CRED},rsize=65536,wsize=65536,cache=none,echo_interval=1
touch ${CIFS_MNT}/a.txt
ip netns exec root iptables -t nat -D POSTROUTING -s 192.168.0.2 -o ${DEV} -j MASQUERADE
"

umount ${CIFS_MNT}

[2]:
ref_tracker: net notrefcnt@000000004bbc008d has 1/1 users at
     sk_alloc (./include/net/net_namespace.h:339 net/core/sock.c:2227)
     inet_create (net/ipv4/af_inet.c:326 net/ipv4/af_inet.c:252)
     __sock_create (net/socket.c:1576)
     generic_ip_connect (fs/smb/client/connect.c:3075)
     cifs_get_tcp_session.part.0 (fs/smb/client/connect.c:3160 fs/smb/client/connect.c:1798)
     cifs_mount_get_session (fs/smb/client/trace.h:959 fs/smb/client/connect.c:3366)
     dfs_mount_share (fs/smb/client/dfs.c:63 fs/smb/client/dfs.c:285)
     cifs_mount (fs/smb/client/connect.c:3622)
     cifs_smb3_do_mount (fs/smb/client/cifsfs.c:949)
     smb3_get_tree (fs/smb/client/fs_context.c:784 fs/smb/client/fs_context.c:802 fs/smb/client/fs_context.c:794)
     vfs_get_tree (fs/super.c:1800)
     path_mount (fs/namespace.c:3508 fs/namespace.c:3834)
     __x64_sys_mount (fs/namespace.c:3848 fs/namespace.c:4057 fs/namespace.c:4034 fs/namespace.c:4034)
     do_syscall_64 (arch/x86/entry/common.c:52 arch/x86/entry/common.c:83)
     entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)

Fixes: 26abe14379f8 ("net: Modify sk_alloc to not reference count the netns of kernel sockets.")
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Acked-by: Tom Talpey <tom@talpey.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/connect.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/fs/smb/client/connect.c b/fs/smb/client/connect.c
index e325e06357ffb..1df0a6edcc216 100644
--- a/fs/smb/client/connect.c
+++ b/fs/smb/client/connect.c
@@ -1054,6 +1054,7 @@ clean_demultiplex_info(struct TCP_Server_Info *server)
 		 */
 	}
 
+	put_net(cifs_net_ns(server));
 	kfree(server->leaf_fullpath);
 	kfree(server);
 
@@ -1649,8 +1650,6 @@ cifs_put_tcp_session(struct TCP_Server_Info *server, int from_reconnect)
 	/* srv_count can never go negative */
 	WARN_ON(server->srv_count < 0);
 
-	put_net(cifs_net_ns(server));
-
 	list_del_init(&server->tcp_ses_list);
 	spin_unlock(&cifs_tcp_ses_lock);
 
@@ -3077,13 +3076,22 @@ generic_ip_connect(struct TCP_Server_Info *server)
 	if (server->ssocket) {
 		socket = server->ssocket;
 	} else {
-		rc = __sock_create(cifs_net_ns(server), sfamily, SOCK_STREAM,
+		struct net *net = cifs_net_ns(server);
+		struct sock *sk;
+
+		rc = __sock_create(net, sfamily, SOCK_STREAM,
 				   IPPROTO_TCP, &server->ssocket, 1);
 		if (rc < 0) {
 			cifs_server_dbg(VFS, "Error %d creating socket\n", rc);
 			return rc;
 		}
 
+		sk = server->ssocket->sk;
+		__netns_tracker_free(net, &sk->ns_tracker, false);
+		sk->sk_net_refcnt = 1;
+		get_net_track(net, &sk->ns_tracker, GFP_KERNEL);
+		sock_inuse_add(net, 1);
+
 		/* BB other socket options to set KEEPALIVE, NODELAY? */
 		cifs_dbg(FYI, "Socket created\n");
 		socket = server->ssocket;
-- 
2.43.0




