Return-Path: <stable+bounces-215224-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4AlJIuXyiWl+EwAAu9opvQ
	(envelope-from <stable+bounces-215224-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 15:44:53 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CEED110D50
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 15:44:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 997DE3015135
	for <lists+stable@lfdr.de>; Mon,  9 Feb 2026 14:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE27B37BE8F;
	Mon,  9 Feb 2026 14:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OZ7FHgP5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 920CE37AA87;
	Mon,  9 Feb 2026 14:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770648089; cv=none; b=OlbCkNYSV25PB/piQvKq2w+PvfCQZ5MYiy3e3DHaeVBaoucpb6hE5CROKsHx+DJPcJCnfeQoA+ZEr3SnjSY4yqdzKaTZjUP3Mg8Y+BFby0sWwEVsSbNdyTHfkDVAWKWlZBccr8UTmWJY1uMhRRPTXFogOUnIQhxTVHB5HKaV8Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770648089; c=relaxed/simple;
	bh=bvBRsn5Q5wJDrXaSTjzvPlVvvtqKyLZh9EHZCWNjsng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WS5rzgjMIeEGybVDLvgATehCzJzMmM+3bA+hvwIQdXjVntb40tv+Is7fBNwfvdNyUjCZtlmykAyse/f8FpxYVARA67dqaLREmb3V7eltTf+nepvCU1XVR/xGEbM8uZvxGyv+ZheYPyv+ARTUmIRBB0+Fc2NYfwVfSZhsObXiuFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OZ7FHgP5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05FC5C19422;
	Mon,  9 Feb 2026 14:41:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770648089;
	bh=bvBRsn5Q5wJDrXaSTjzvPlVvvtqKyLZh9EHZCWNjsng=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OZ7FHgP5rABTFbZrhzjaU89MFoSM8tcFYTDHQXzRaT27qmVY5lI5W2P/gvK2Wkv4p
	 2do9SBt4LygD39Y98QubJ0Nygk3W2QR3bcNqF1vdJCWbGgb0+8x994JfiCY3xpIqli
	 ILRc1s5++oTQN/DNgktTDfAPYEw7hr1QOxDm/xnc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+cb809def1baaac68ab92@syzkaller.appspotmail.com,
	Shigeru Yoshida <syoshida@redhat.com>,
	Fernando Fernandez Mancera <fmancera@suse.de>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 103/113] ipv6: Fix ECMP sibling count mismatch when clearing RTF_ADDRCONF
Date: Mon,  9 Feb 2026 15:24:12 +0100
Message-ID: <20260209142313.876787255@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260209142310.204833231@linuxfoundation.org>
References: <20260209142310.204833231@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-215224-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable,cb809def1baaac68ab92];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,suse.de:email,msgid.link:url,syzkaller.appspot.com:url,appspotmail.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2CEED110D50
X-Rspamd-Action: no action

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shigeru Yoshida <syoshida@redhat.com>

[ Upstream commit bbf4a17ad9ffc4e3d7ec13d73ecd59dea149ed25 ]

syzbot reported a kernel BUG in fib6_add_rt2node() when adding an IPv6
route. [0]

Commit f72514b3c569 ("ipv6: clear RA flags when adding a static
route") introduced logic to clear RTF_ADDRCONF from existing routes
when a static route with the same nexthop is added. However, this
causes a problem when the existing route has a gateway.

When RTF_ADDRCONF is cleared from a route that has a gateway, that
route becomes eligible for ECMP, i.e. rt6_qualify_for_ecmp() returns
true. The issue is that this route was never added to the
fib6_siblings list.

This leads to a mismatch between the following counts:

- The sibling count computed by iterating fib6_next chain, which
  includes the newly ECMP-eligible route

- The actual siblings in fib6_siblings list, which does not include
  that route

When a subsequent ECMP route is added, fib6_add_rt2node() hits
BUG_ON(sibling->fib6_nsiblings != rt->fib6_nsiblings) because the
counts don't match.

Fix this by only clearing RTF_ADDRCONF when the existing route does
not have a gateway. Routes without a gateway cannot qualify for ECMP
anyway (rt6_qualify_for_ecmp() requires fib_nh_gw_family), so clearing
RTF_ADDRCONF on them is safe and matches the original intent of the
commit.

[0]:
kernel BUG at net/ipv6/ip6_fib.c:1217!
Oops: invalid opcode: 0000 [#1] SMP KASAN PTI
CPU: 0 UID: 0 PID: 6010 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full)
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
RIP: 0010:fib6_add_rt2node+0x3433/0x3470 net/ipv6/ip6_fib.c:1217
[...]
Call Trace:
 <TASK>
 fib6_add+0x8da/0x18a0 net/ipv6/ip6_fib.c:1532
 __ip6_ins_rt net/ipv6/route.c:1351 [inline]
 ip6_route_add+0xde/0x1b0 net/ipv6/route.c:3946
 ipv6_route_ioctl+0x35c/0x480 net/ipv6/route.c:4571
 inet6_ioctl+0x219/0x280 net/ipv6/af_inet6.c:577
 sock_do_ioctl+0xdc/0x300 net/socket.c:1245
 sock_ioctl+0x576/0x790 net/socket.c:1366
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:583
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Fixes: f72514b3c569 ("ipv6: clear RA flags when adding a static route")
Reported-by: syzbot+cb809def1baaac68ab92@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=cb809def1baaac68ab92
Tested-by: syzbot+cb809def1baaac68ab92@syzkaller.appspotmail.com
Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
Reviewed-by: Fernando Fernandez Mancera <fmancera@suse.de>
Link: https://patch.msgid.link/20260204095837.1285552-1-syoshida@redhat.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv6/ip6_fib.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/ipv6/ip6_fib.c b/net/ipv6/ip6_fib.c
index ebfe2b9b11b7e..d83430f4a0eff 100644
--- a/net/ipv6/ip6_fib.c
+++ b/net/ipv6/ip6_fib.c
@@ -1138,7 +1138,8 @@ static int fib6_add_rt2node(struct fib6_node *fn, struct fib6_info *rt,
 					fib6_set_expires(iter, rt->expires);
 					fib6_add_gc_list(iter);
 				}
-				if (!(rt->fib6_flags & (RTF_ADDRCONF | RTF_PREFIX_RT))) {
+				if (!(rt->fib6_flags & (RTF_ADDRCONF | RTF_PREFIX_RT)) &&
+				    !iter->fib6_nh->fib_nh_gw_family) {
 					iter->fib6_flags &= ~RTF_ADDRCONF;
 					iter->fib6_flags &= ~RTF_PREFIX_RT;
 				}
-- 
2.51.0




