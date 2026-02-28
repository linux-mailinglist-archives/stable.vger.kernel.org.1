Return-Path: <stable+bounces-220361-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KLuSG2I4o2lx+gQAu9opvQ
	(envelope-from <stable+bounces-220361-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:48:02 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E42CB1C644F
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:48:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6943133DCF6A
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A36FA39FEA3;
	Sat, 28 Feb 2026 17:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X0/koyQe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 665A939FE9B;
	Sat, 28 Feb 2026 17:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300258; cv=none; b=ezdC333u2t78ZJZksM1FS6QBFhbkK8PS61VseklJvCberYJ2S8LerHYZlZZcrGCrkOkv/+lAhPHMHMjzvXo7Nlsgrpfy44FEkCSIDO2eDC9y3zc6yiS/IHFSuf9l82CFgAW7ydAb/i/oWgZc41JxcMx5oSkTCOuFqK7YmMp1VC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300258; c=relaxed/simple;
	bh=uOGOIZr61Qo5YmxJYttOr2GDOKOLciM0HyzmGKXTOvM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fOjWaSsqa6ayj9eyQ2MLe5q25PSaEFWgs2YraSvZTeyvAr7JYI3bqbM+jgyVQdu70K3XtPWcOw+CZeanw8nzGkIjxz5Nmmf7cFUO4Babd8KdeTiOAAp1+FcX1SAfU3x+WyM5aHF8MynPPHwi0TFEkLEu/Pt2pU9wdOfvamId6Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X0/koyQe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B994C19423;
	Sat, 28 Feb 2026 17:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300258;
	bh=uOGOIZr61Qo5YmxJYttOr2GDOKOLciM0HyzmGKXTOvM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X0/koyQezxYN2sa92X37FggHeqElmUfxTZHK6wSWfpwCQmf/IeOui19hFApmuItQP
	 +KwWKkIgKffruoGKo8jeW6ZfGxv5RakLI2l/Rl06DFi7b8eYPOeJKE5/1UAU6Vx/m0
	 ++afw9wuZ4t6YUoD7QQMc+xOVY+zD89+2vBnuZ97rHLcSXzdTLdpNT+cSbMMD+ZWnU
	 I/0IA7qrtDDOFoZCpnYZJE6emVvqE6kcfImUFhFmd4N3/Y2MgT5CXYDWoSL0uon2C8
	 pLc0EQnlxcRO4FnRyNW1QCUyv0RUtqZ1YQNnjyLzT7OUTir0etkwQLkBGHDfGscLHP
	 xHJmhR6vOHLiw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 283/844] ipv6: annotate data-races in ip6_multipath_hash_{policy,fields}()
Date: Sat, 28 Feb 2026 12:23:16 -0500
Message-ID: <20260228173244.1509663-284-sashal@kernel.org>
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
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-220361-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: E42CB1C644F
X-Rspamd-Action: no action

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 03e9d91dd64e2f5ea632df5d59568d91757efc4d ]

Add missing READ_ONCE() when reading sysctl values.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/20260115094141.3124990-5-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/ipv6.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/net/ipv6.h b/include/net/ipv6.h
index 6a933690e0ff5..e759a00dbde19 100644
--- a/include/net/ipv6.h
+++ b/include/net/ipv6.h
@@ -1010,11 +1010,11 @@ static inline int ip6_default_np_autolabel(struct net *net)
 #if IS_ENABLED(CONFIG_IPV6)
 static inline int ip6_multipath_hash_policy(const struct net *net)
 {
-	return net->ipv6.sysctl.multipath_hash_policy;
+	return READ_ONCE(net->ipv6.sysctl.multipath_hash_policy);
 }
 static inline u32 ip6_multipath_hash_fields(const struct net *net)
 {
-	return net->ipv6.sysctl.multipath_hash_fields;
+	return READ_ONCE(net->ipv6.sysctl.multipath_hash_fields);
 }
 #else
 static inline int ip6_multipath_hash_policy(const struct net *net)
-- 
2.51.0


