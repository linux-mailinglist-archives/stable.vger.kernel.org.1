Return-Path: <stable+bounces-218731-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SBBAOqxYnmkjUwQAu9opvQ
	(envelope-from <stable+bounces-218731-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 03:04:28 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 702D11907AE
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 03:04:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 65CBC31E5554
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB5D82652A2;
	Wed, 25 Feb 2026 01:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tEDMgJTB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA8E1E2834;
	Wed, 25 Feb 2026 01:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771983596; cv=none; b=OzQq9riWmCjxVK0KtG4uWXbL5prt9kyCBMpEv3xmTjGAhWLW+S7kysSOxg+65IV+T2CV0+4dfWyheD/ENd6SA8ZR0GPgPOXCzyrwbySLv/AWmCYfS8NHBOEMXmwGeaDbyqIfHByuTxdE+0qtWSgx72GqVUx/rSAt8/s3PGZtitU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771983596; c=relaxed/simple;
	bh=OHMeOpJ12LTDZ0nXuf+fxEPQ7wME1Ny1SZfra1qTmfQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dOGV1OAnfsleQ90KZishy+JOIIHm0im+YcGN+EN0wT6OdxSviWDkkWzLragO2N6/1I9hUP/RuzIbRnjle2tMRmhjEkhGCk+v9X5dK0r0R0xz4lxD5Zy7QW0Pq2xRtvr+N9RmfIUPOicCRtZCmNfFpYeel1AdYyiSbGoXZimPp24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tEDMgJTB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35B86C116D0;
	Wed, 25 Feb 2026 01:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771983596;
	bh=OHMeOpJ12LTDZ0nXuf+fxEPQ7wME1Ny1SZfra1qTmfQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tEDMgJTB1q/PY8NLM3pM/mJ6ZI8w25GLg2Zt0YYdowl3F97eWeG6tgLfcwkTDb4Fl
	 Lp+AVfbTmeocIhoos9f8tSGafA73adSI6VE7lQsWFdKeG/5TPHvGJD+lcTBJKHFMdg
	 GImf+qMApH2wz6tG1zn2zP34tkAHOBCUGeaPRCew=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Eric Dumazet <edumazet@google.com>,
	Simon Horman <horms@kernel.org>,
	Fernando Fernandez Mancera <fmancera@suse.de>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 669/781] ipv6: fix a race in ip6_sock_set_v6only()
Date: Tue, 24 Feb 2026 17:22:58 -0800
Message-ID: <20260225012416.192849925@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225012359.695468795@linuxfoundation.org>
References: <20260225012359.695468795@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-218731-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,linuxfoundation.org:mid,linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.de:email]
X-Rspamd-Queue-Id: 702D11907AE
X-Rspamd-Action: no action

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 452a3eee22c57a5786ae6db5c97f3b0ec13bb3b7 ]

It is unlikely that this function will be ever called
with isk->inet_num being not zero.

Perform the check on isk->inet_num inside the locked section
for complete safety.

Fixes: 9b115749acb24 ("ipv6: add ip6_sock_set_v6only")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Fernando Fernandez Mancera <fmancera@suse.de>
Link: https://patch.msgid.link/20260216102202.3343588-1-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/ipv6.h | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/include/net/ipv6.h b/include/net/ipv6.h
index 74fbf1ad8065a..6a933690e0ff5 100644
--- a/include/net/ipv6.h
+++ b/include/net/ipv6.h
@@ -1280,12 +1280,15 @@ int ipv6_sock_mc_drop(struct sock *sk, int ifindex,
 
 static inline int ip6_sock_set_v6only(struct sock *sk)
 {
-	if (inet_sk(sk)->inet_num)
-		return -EINVAL;
+	int ret = 0;
+
 	lock_sock(sk);
-	sk->sk_ipv6only = true;
+	if (inet_sk(sk)->inet_num)
+		ret = -EINVAL;
+	else
+		sk->sk_ipv6only = true;
 	release_sock(sk);
-	return 0;
+	return ret;
 }
 
 static inline void ip6_sock_set_recverr(struct sock *sk)
-- 
2.51.0




