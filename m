Return-Path: <stable+bounces-224448-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oKPTM/cDsGkWegIAu9opvQ
	(envelope-from <stable+bounces-224448-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:43:51 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D701A24B6E4
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:43:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0CAEC3084523
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 11:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1408B38945A;
	Tue, 10 Mar 2026 11:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GFMn1a2d"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA5F4423A77;
	Tue, 10 Mar 2026 11:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773142180; cv=none; b=JsPsNdR4HL1e53scmj0oDFnfdLED4xOYj8HYIYsgixAgCszM+H6R8xpJf3woKlQJVaYjmjmyDh+1xu7VqUn08ctlHh/svT2K3Y7Q0+j2ovhgqXTqX6MOJBQyk/GSJzsBrs9Vvn7RULW8FFd2Kov3E8ugcXYUGQjZ+D9f6DEi9vI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773142180; c=relaxed/simple;
	bh=WrbT7uZZnXBi4WSfzECXDq2dBk1izeVomy206D2UMUI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OOGx9DaEtyJSbDID7fXY3FKpCrSfqrh7q5Jb1fQ6C7i1EekrZ4h+tduphVieWzUdLlB0gPujYHt6OEM5nCQHtVV2OTFUdFJhZw9zS4vu69xMiC6u73HfFVkyzccS7TkUE1g0gQzu/KIzHEQly4zPakxKe58ffFwMtrh9GP/a/H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GFMn1a2d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09811C2BC9E;
	Tue, 10 Mar 2026 11:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773142180;
	bh=WrbT7uZZnXBi4WSfzECXDq2dBk1izeVomy206D2UMUI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GFMn1a2dpoYSew0ZXoLEKYUhaJA0DYFYFCcNw09Fmv4IrUEO8BOxc4KkgKr3/xWgB
	 58D+VdpUPS4AGUYvYNYfbD0izhpUaZdOFE2UWqofQMpKkQ+kaOEgTzJTJOqa3YG2n4
	 6yY2eozep6EGuu7vdk1JMrueDoji1G/ibnC8gbuBjRW6Uyy+Wwj81joTMIYowGNKSD
	 B7VYP0J6j00ueQIUKEO71ZP2im0ujKt6WfH3+1O5xAq130dpnx3ev43gbv/g1jq+7U
	 5QqaCWZmp+gkYBjxo+exADGNsG+kylKuX0dZAzIGQRHDcDCl29i/QlHOMYOP9b21Me
	 mTtsO78SV5rkQ==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Yung Chih Su <yuuchihsu@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 269/314] net: ipv4: fix ARM64 alignment fault in multipath hash seed
Date: Tue, 10 Mar 2026 07:18:48 -0400
Message-ID: <3e464b63281180c71434c69b6fd2d5bf5a1cf001.1773141555.git.sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1773141554.git.sashal@kernel.org>
References: <cover.1773141554.git.sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D701A24B6E4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,google.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-224448-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

From: Yung Chih Su <yuuchihsu@gmail.com>

[ Upstream commit 4ee7fa6cf78ff26d783d39e2949d14c4c1cd5e7f ]

`struct sysctl_fib_multipath_hash_seed` contains two u32 fields
(user_seed and mp_seed), making it an 8-byte structure with a 4-byte
alignment requirement.

In `fib_multipath_hash_from_keys()`, the code evaluates the entire
struct atomically via `READ_ONCE()`:

    mp_seed = READ_ONCE(net->ipv4.sysctl_fib_multipath_hash_seed).mp_seed;

While this silently works on GCC by falling back to unaligned regular
loads which the ARM64 kernel tolerates, it causes a fatal kernel panic
when compiled with Clang and LTO enabled.

Commit e35123d83ee3 ("arm64: lto: Strengthen READ_ONCE() to acquire
when CONFIG_LTO=y") strengthens `READ_ONCE()` to use Load-Acquire
instructions (`ldar` / `ldapr`) to prevent compiler reordering bugs
under Clang LTO. Since the macro evaluates the full 8-byte struct,
Clang emits a 64-bit `ldar` instruction. ARM64 architecture strictly
requires `ldar` to be naturally aligned, thus executing it on a 4-byte
aligned address triggers a strict Alignment Fault (FSC = 0x21).

Fix the read side by moving the `READ_ONCE()` directly to the `u32`
member, which emits a safe 32-bit `ldar Wn`.

Furthermore, Eric Dumazet pointed out that `WRITE_ONCE()` on the entire
struct in `proc_fib_multipath_hash_set_seed()` is also flawed. Analysis
shows that Clang splits this 8-byte write into two separate 32-bit
`str` instructions. While this avoids an alignment fault, it destroys
atomicity and exposes a tear-write vulnerability. Fix this by
explicitly splitting the write into two 32-bit `WRITE_ONCE()`
operations.

Finally, add the missing `READ_ONCE()` when reading `user_seed` in
`proc_fib_multipath_hash_seed()` to ensure proper pairing and
concurrency safety.

Fixes: 4ee2a8cace3f ("net: ipv4: Add a sysctl to set multipath hash seed")
Signed-off-by: Yung Chih Su <yuuchihsu@gmail.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Link: https://patch.msgid.link/20260302060247.7066-1-yuuchihsu@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/ip_fib.h       | 2 +-
 net/ipv4/sysctl_net_ipv4.c | 5 +++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/net/ip_fib.h b/include/net/ip_fib.h
index b4495c38e0a01..318593743b6e1 100644
--- a/include/net/ip_fib.h
+++ b/include/net/ip_fib.h
@@ -559,7 +559,7 @@ static inline u32 fib_multipath_hash_from_keys(const struct net *net,
 	siphash_aligned_key_t hash_key;
 	u32 mp_seed;
 
-	mp_seed = READ_ONCE(net->ipv4.sysctl_fib_multipath_hash_seed).mp_seed;
+	mp_seed = READ_ONCE(net->ipv4.sysctl_fib_multipath_hash_seed.mp_seed);
 	fib_multipath_hash_construct_key(&hash_key, mp_seed);
 
 	return flow_hash_from_keys_seed(keys, &hash_key);
diff --git a/net/ipv4/sysctl_net_ipv4.c b/net/ipv4/sysctl_net_ipv4.c
index 24dbc603cc44d..0f1dd75dbf37b 100644
--- a/net/ipv4/sysctl_net_ipv4.c
+++ b/net/ipv4/sysctl_net_ipv4.c
@@ -484,7 +484,8 @@ static void proc_fib_multipath_hash_set_seed(struct net *net, u32 user_seed)
 			    proc_fib_multipath_hash_rand_seed),
 	};
 
-	WRITE_ONCE(net->ipv4.sysctl_fib_multipath_hash_seed, new);
+	WRITE_ONCE(net->ipv4.sysctl_fib_multipath_hash_seed.user_seed, new.user_seed);
+	WRITE_ONCE(net->ipv4.sysctl_fib_multipath_hash_seed.mp_seed, new.mp_seed);
 }
 
 static int proc_fib_multipath_hash_seed(const struct ctl_table *table, int write,
@@ -498,7 +499,7 @@ static int proc_fib_multipath_hash_seed(const struct ctl_table *table, int write
 	int ret;
 
 	mphs = &net->ipv4.sysctl_fib_multipath_hash_seed;
-	user_seed = mphs->user_seed;
+	user_seed = READ_ONCE(mphs->user_seed);
 
 	tmp = *table;
 	tmp.data = &user_seed;
-- 
2.51.0


