Return-Path: <stable+bounces-214115-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wM6hJKNmg2nQmQMAu9opvQ
	(envelope-from <stable+bounces-214115-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 16:32:51 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 17F4AE8D4F
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 16:32:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 060C230A6758
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 15:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11BF34219E3;
	Wed,  4 Feb 2026 15:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JymdOBIf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA5524218AB;
	Wed,  4 Feb 2026 15:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770218615; cv=none; b=OHTU+ZrpnggoP7pyAgXZcdj3NKHNAX+URSomRlR85wxWY/ZMA57SZmUZdM6j7Fu7MjXCq0JBO8YwJY6NuS9iufmyPnUEIK8XxRH1U7fkkNbKpd82cEBL27XMK8PbwOWJzOCEDgul8W9Z7RfefK9OLF+IiqFA5gnlFuZN5LjFqMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770218615; c=relaxed/simple;
	bh=s9uDNbDp1JFkvaIFp9rXqirWqcXb21X4YPM7DNgCl2E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WRdgrsdoHKGN2sgT8YQLOodsnvPGhGtoXSaS/k/aU/PxEKLmqyZW3pFxvNu9iAb7vg8WMSRbvXz7jMtbMqgcDPZpaJD01wg5T5MUtUROCJWQN6QcuUfsrrQELN6Lhbw0ob1FvzviU/yx+fMlpt0N11dhfFejavd5hPX2SyDgXSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JymdOBIf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4544FC4CEF7;
	Wed,  4 Feb 2026 15:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770218615;
	bh=s9uDNbDp1JFkvaIFp9rXqirWqcXb21X4YPM7DNgCl2E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JymdOBIfLd9eTuw7AR1vUmckYlx18ZlaeK0LYBZwyvkG12uEm3rR8o1aosA3PaAEH
	 SR9hoZtjSq25YIRT9RNfVUk1cLaGW2dqQgBDXvO+ZJKUILhnUaltKJcdWm+JaBiLGd
	 ZeSLTozi8NhTh/fiy5+VR+NU6pXBXH/LTiI4ACs0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Fernando Fernandez Mancera <fmancera@suse.de>,
	David Ahern <dsahern@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 10/87] ipv6: use the right ifindex when replying to icmpv6 from localhost
Date: Wed,  4 Feb 2026 15:40:08 +0100
Message-ID: <20260204143847.283911905@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260204143846.906385641@linuxfoundation.org>
References: <20260204143846.906385641@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-214115-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,suse.de:email,msgid.link:url]
X-Rspamd-Queue-Id: 17F4AE8D4F
X-Rspamd-Action: no action

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Fernando Fernandez Mancera <fmancera@suse.de>

[ Upstream commit 03cbcdf93866e61beb0063392e6dbb701f03aea2 ]

When replying to a ICMPv6 echo request that comes from localhost address
the right output ifindex is 1 (lo) and not rt6i_idev dev index. Use the
skb device ifindex instead. This fixes pinging to a local address from
localhost source address.

$ ping6 -I ::1 2001:1:1::2 -c 3
PING 2001:1:1::2 (2001:1:1::2) from ::1 : 56 data bytes
64 bytes from 2001:1:1::2: icmp_seq=1 ttl=64 time=0.037 ms
64 bytes from 2001:1:1::2: icmp_seq=2 ttl=64 time=0.069 ms
64 bytes from 2001:1:1::2: icmp_seq=3 ttl=64 time=0.122 ms

2001:1:1::2 ping statistics
3 packets transmitted, 3 received, 0% packet loss, time 2032ms
rtt min/avg/max/mdev = 0.037/0.076/0.122/0.035 ms

Fixes: 1b70d792cf67 ("ipv6: Use rt6i_idev index for echo replies to a local address")
Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
Reviewed-by: David Ahern <dsahern@kernel.org>
Link: https://patch.msgid.link/20260121194409.6749-1-fmancera@suse.de
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv6/icmp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/ipv6/icmp.c b/net/ipv6/icmp.c
index 8117c17845967..13a796bfc2f93 100644
--- a/net/ipv6/icmp.c
+++ b/net/ipv6/icmp.c
@@ -770,7 +770,9 @@ static enum skb_drop_reason icmpv6_echo_reply(struct sk_buff *skb)
 	fl6.daddr = ipv6_hdr(skb)->saddr;
 	if (saddr)
 		fl6.saddr = *saddr;
-	fl6.flowi6_oif = icmp6_iif(skb);
+	fl6.flowi6_oif = ipv6_addr_loopback(&fl6.daddr) ?
+			 skb->dev->ifindex :
+			 icmp6_iif(skb);
 	fl6.fl6_icmp_type = type;
 	fl6.flowi6_mark = mark;
 	fl6.flowi6_uid = sock_net_uid(net, NULL);
-- 
2.51.0




