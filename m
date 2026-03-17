Return-Path: <stable+bounces-226750-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eLb6K1aOuWk5KQIAu9opvQ
	(envelope-from <stable+bounces-226750-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:24:38 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BC022AF7FD
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:24:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 485A03002E6D
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51B28331A49;
	Tue, 17 Mar 2026 17:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GYxrp/XU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1463B2459DC;
	Tue, 17 Mar 2026 17:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773768044; cv=none; b=mU3dsMrR3g7xw5F/zAow+C+KI+lzbhIp7tU4YFptSgwahjKcefwHer/d7Zlfrp2IkBBPJp4fszpF07LeY2V9e6pPj0bsMjVQ9/kJUudVnkq9xvO3IvTZZ7MRoP8N1Aot15uE7uDz58m2+Hxh6k3Fr80mBgehGAP3bFg09B/I23I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773768044; c=relaxed/simple;
	bh=XfoDR59MjLdS/o+PhimC68aV56tbAVhuh0RxqXQtibA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gtTmn/mXkGz11SUhf7pVWDUoHwyByCZI3YHQ/+u5Bno1H+Qq9rtL0jZ1ARvtrjyLJdWA+086JdfNieuzdtLlboPN3xOHNBoVY+iSgCHvb2NU1yG5dTVZs+1BawRtFZXu1boeycirHjPQPZuKgkXB8ZHHCjcS1y5hud1Ay42lEyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GYxrp/XU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1A50C2BCB1;
	Tue, 17 Mar 2026 17:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773768044;
	bh=XfoDR59MjLdS/o+PhimC68aV56tbAVhuh0RxqXQtibA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GYxrp/XUMkzZ9Vr1BpPV7VnapEy4MkUaNWwcMYD9cicb7e2ox2mxzDWWdUz+GyqK/
	 LRkZyV0PPr5V/CUskOfXWuTl0AacfZxnVGFsYqhSu928aOw/Qbxl69y+2m0vOwPRcD
	 BjautJgG/anwoN8HP0Ztkm8BBdTdEPQM8maH+v7c=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Eric Biggers <ebiggers@kernel.org>,
	Dmitry Safonov <0x7f454c46@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.18 219/333] net/tcp-ao: Fix MAC comparison to be constant-time
Date: Tue, 17 Mar 2026 17:34:08 +0100
Message-ID: <20260317163007.486723787@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260317162959.345812316@linuxfoundation.org>
References: <20260317162959.345812316@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-226750-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,kernel.org,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Queue-Id: 2BC022AF7FD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Biggers <ebiggers@kernel.org>

commit 67edfec516d30d3e62925c397be4a1e5185802fc upstream.

To prevent timing attacks, MACs need to be compared in constant
time.  Use the appropriate helper function for this.

Fixes: 0a3a809089eb ("net/tcp: Verify inbound TCP-AO signed segments")
Cc: stable@vger.kernel.org
Signed-off-by: Eric Biggers <ebiggers@kernel.org>
Reviewed-by: Dmitry Safonov <0x7f454c46@gmail.com>
Link: https://patch.msgid.link/20260302203600.13561-1-ebiggers@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/Kconfig  |    1 +
 net/ipv4/tcp_ao.c |    3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

--- a/net/ipv4/Kconfig
+++ b/net/ipv4/Kconfig
@@ -748,6 +748,7 @@ config TCP_SIGPOOL
 config TCP_AO
 	bool "TCP: Authentication Option (RFC5925)"
 	select CRYPTO
+	select CRYPTO_LIB_UTILS
 	select TCP_SIGPOOL
 	depends on 64BIT && IPV6 != m # seq-number extension needs WRITE_ONCE(u64)
 	help
--- a/net/ipv4/tcp_ao.c
+++ b/net/ipv4/tcp_ao.c
@@ -10,6 +10,7 @@
 #define pr_fmt(fmt) "TCP: " fmt
 
 #include <crypto/hash.h>
+#include <crypto/utils.h>
 #include <linux/inetdevice.h>
 #include <linux/tcp.h>
 
@@ -922,7 +923,7 @@ tcp_ao_verify_hash(const struct sock *sk
 	/* XXX: make it per-AF callback? */
 	tcp_ao_hash_skb(family, hash_buf, key, sk, skb, traffic_key,
 			(phash - (u8 *)th), sne);
-	if (memcmp(phash, hash_buf, maclen)) {
+	if (crypto_memneq(phash, hash_buf, maclen)) {
 		NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPAOBAD);
 		atomic64_inc(&info->counters.pkt_bad);
 		atomic64_inc(&key->pkt_bad);



