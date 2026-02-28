Return-Path: <stable+bounces-220526-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mI1ANeo6o2nO+gQAu9opvQ
	(envelope-from <stable+bounces-220526-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:58:50 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 620241C67A0
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:58:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8A13E311B695
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F15F43CE21D;
	Sat, 28 Feb 2026 17:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VyJR7ZVt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B301F3CE215;
	Sat, 28 Feb 2026 17:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300409; cv=none; b=jQfE2gVy1r0Hwwf+YeBLV2sEJpmIzIFBFfc5R/O2v+R05yTcv6LxaM2+wcsryHF8Ay/BYqxepeEpS7dYNHcr5ENGt5RURlmZNyzs0PMrykYJENoRLHxSblw/UlJ7EJY8ppCpbOeCpbIF9JAf4nOJJ26ZsF7iT2U8OmylHhjnEII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300409; c=relaxed/simple;
	bh=nq9qkBe4okAHoTat6O8vzfoeylYqMxsyWvi3bxn5F+M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=it+H8RZWXMzuBhi8r7Dn52ODlEwJDwAc2nDFWGpQbMVF8M0Klgh35zFjUuWMkBLBbdBsqC7ZFmqiT00yzrDw6qAzBZt8VryYZ3lOt11hBknzJkP7cWydIcsbc48iQm/TNfF+sRGNMUq8xzyz3nQnADy+uSD1yzKNePLejNDA5LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VyJR7ZVt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8D0EC19423;
	Sat, 28 Feb 2026 17:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300409;
	bh=nq9qkBe4okAHoTat6O8vzfoeylYqMxsyWvi3bxn5F+M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VyJR7ZVtKWmAvQ1nCGMKrY2M49uHJ3a4za/bz2ctZ4KMf3bmfh1EfQjNShMoqK71A
	 hYjKfLr7N2zGgvl9Fj2+ggYpgTvrcxzNHriuWDs/hBiUhLJhmvclxXLtPkupDDGRVc
	 DsBgSHKTtzlvYGyW8riKZfDSDQRGxLV7LaeBs0Zer54AlSxninx172BCVkXf5dbCa8
	 N4qctfcYvUIMvXfpoSCboTqUTxnWiHJhQVPa53VZkPqVLczQb+AugcEOE6oMMVw8hV
	 /PFltgl0AKxKiTzIoa4xPNw1B7afyJpylMKiwwrL2XDH8qtKk8fpYvHTOQ5Ar4ncV7
	 skNloilRIYqZA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@shopee.com>,
	syzbot+e136d86d34b42399a8b1@syzkaller.appspotmail.com,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	Simon Horman <horms@kernel.org>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 447/844] xfrm6: fix uninitialized saddr in xfrm6_get_saddr()
Date: Sat, 28 Feb 2026 12:26:00 -0500
Message-ID: <20260228173244.1509663-448-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220526-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.983];
	TAGGED_RCPT(0.00)[stable,e136d86d34b42399a8b1];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,shopee.com:email,linux.dev:email,appspotmail.com:email,secunet.com:email]
X-Rspamd-Queue-Id: 620241C67A0
X-Rspamd-Action: no action

From: Jiayuan Chen <jiayuan.chen@shopee.com>

[ Upstream commit 1799d8abeabc68ec05679292aaf6cba93b343c05 ]

xfrm6_get_saddr() does not check the return value of
ipv6_dev_get_saddr(). When ipv6_dev_get_saddr() fails to find a suitable
source address (returns -EADDRNOTAVAIL), saddr->in6 is left
uninitialized, but xfrm6_get_saddr() still returns 0 (success).

This causes the caller xfrm_tmpl_resolve_one() to use the uninitialized
address in xfrm_state_find(), triggering KMSAN warning:

=====================================================
BUG: KMSAN: uninit-value in xfrm_state_find+0x2424/0xa940
 xfrm_state_find+0x2424/0xa940
 xfrm_resolve_and_create_bundle+0x906/0x5a20
 xfrm_lookup_with_ifid+0xcc0/0x3770
 xfrm_lookup_route+0x63/0x2b0
 ip_route_output_flow+0x1ce/0x270
 udp_sendmsg+0x2ce1/0x3400
 inet_sendmsg+0x1ef/0x2a0
 __sock_sendmsg+0x278/0x3d0
 __sys_sendto+0x593/0x720
 __x64_sys_sendto+0x130/0x200
 x64_sys_call+0x332b/0x3e70
 do_syscall_64+0xd3/0xf80
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Local variable tmp.i.i created at:
 xfrm_resolve_and_create_bundle+0x3e3/0x5a20
 xfrm_lookup_with_ifid+0xcc0/0x3770
=====================================================

Fix by checking the return value of ipv6_dev_get_saddr() and propagating
the error.

Fixes: a1e59abf8249 ("[XFRM]: Fix wildcard as tunnel source")
Reported-by: syzbot+e136d86d34b42399a8b1@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/68bf1024.a70a0220.7a912.02c2.GAE@google.com/T/
Signed-off-by: Jiayuan Chen <jiayuan.chen@shopee.com>
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv6/xfrm6_policy.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/ipv6/xfrm6_policy.c b/net/ipv6/xfrm6_policy.c
index 1f19b6f14484c..125ea9a5b8a08 100644
--- a/net/ipv6/xfrm6_policy.c
+++ b/net/ipv6/xfrm6_policy.c
@@ -57,6 +57,7 @@ static int xfrm6_get_saddr(xfrm_address_t *saddr,
 	struct dst_entry *dst;
 	struct net_device *dev;
 	struct inet6_dev *idev;
+	int err;
 
 	dst = xfrm6_dst_lookup(params);
 	if (IS_ERR(dst))
@@ -68,9 +69,11 @@ static int xfrm6_get_saddr(xfrm_address_t *saddr,
 		return -EHOSTUNREACH;
 	}
 	dev = idev->dev;
-	ipv6_dev_get_saddr(dev_net(dev), dev, &params->daddr->in6, 0,
-			   &saddr->in6);
+	err = ipv6_dev_get_saddr(dev_net(dev), dev, &params->daddr->in6, 0,
+				 &saddr->in6);
 	dst_release(dst);
+	if (err)
+		return -EHOSTUNREACH;
 	return 0;
 }
 
-- 
2.51.0


