Return-Path: <stable+bounces-222326-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QEj2A+2jo2mRIwUAu9opvQ
	(envelope-from <stable+bounces-222326-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 03:26:53 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CE7BB1CD8D7
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 03:26:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 25ED9353B718
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 02:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C44F52FFFB5;
	Sun,  1 Mar 2026 02:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KdVZqCj6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8763B13B58A;
	Sun,  1 Mar 2026 02:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772330603; cv=none; b=B1gYa9CtxVKsgcEYNgfTbxobQRz+SM6YptAL2Z71MQY2xxIWu/SVNCLXFtkpJiW2c8EogHiVONeLDCrZYVJ3kfJ/8LZLNcqGneo8xWzg+fOgc6QMp3sef3cCG9O5ZqICW9KWYvGLWixE9SOfXRAO6I5K8whvlqfKrf2nxHLAsO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772330603; c=relaxed/simple;
	bh=E6ay04JXmb9ouQdJZG3fdJbHaKk8TguAyUv+NUeOPgM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=im25SrrUZ8kUGzchz+nZQA1thVDHASWXy6m5O9G8853F30H+9vhw7b108YySo3ytvOFISGQQiCJE9rl8qZ8uY3Nc30RLOMRpkhwrJkOx38pPXHdhGGzVva0zFr+eDHW2TALo/XOgHlKO/e8rwXwB1932IIfhfbsEe9Bq1w1pmno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KdVZqCj6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA12EC19421;
	Sun,  1 Mar 2026 02:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772330603;
	bh=E6ay04JXmb9ouQdJZG3fdJbHaKk8TguAyUv+NUeOPgM=;
	h=From:To:Cc:Subject:Date:From;
	b=KdVZqCj64y+wTdZ3mbvsYX/CVkpx05IgZiAsw207sZI+1PkjxjzGWWdtcwV/kHy4N
	 pke5m70vpFFZufJ9VNTwdeL+VJB0KtyOIUi2DzZb67VAsUtKYd/CZSNogvR5HyLFyh
	 ami0TYdn16ouLshAN/qigc2Mjuc05bGiZBnBcnWVOXCBelrvMh16GcK6XXLQiG67CS
	 XAdHanYZrZ7gY1/KC9a7oJHsp4MOvMfR35N3NU4t3EfEsptkdKfeEoklB5l32vT05X
	 qwOwqNVkJxDkymM6wyjNj/kZDV9EJPQGuF8QJGAkHKnxNRn1X/lDUKRLGrwJAasVHg
	 yjrIMOs0EI/gQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	hodgesd@meta.com
Cc: Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net
Subject: FAILED: Patch "tipc: fix RCU dereference race in tipc_aead_users_dec()" failed to apply to 5.10-stable tree
Date: Sat, 28 Feb 2026 21:03:21 -0500
Message-ID: <20260301020321.1731402-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-222326-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: CE7BB1CD8D7
X-Rspamd-Action: no action

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 6a65c0cb0ff20b3cbc5f1c87b37dd22cdde14a1c Mon Sep 17 00:00:00 2001
From: Daniel Hodges <hodgesd@meta.com>
Date: Tue, 3 Feb 2026 09:56:21 -0500
Subject: [PATCH] tipc: fix RCU dereference race in tipc_aead_users_dec()

tipc_aead_users_dec() calls rcu_dereference(aead) twice: once to store
in 'tmp' for the NULL check, and again inside the atomic_add_unless()
call.

Use the already-dereferenced 'tmp' pointer consistently, matching the
correct pattern used in tipc_aead_users_inc() and tipc_aead_users_set().

Fixes: fc1b6d6de220 ("tipc: introduce TIPC encryption & authentication")
Cc: stable@vger.kernel.org
Reviewed-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Daniel Hodges <hodgesd@meta.com>
Link: https://patch.msgid.link/20260203145621.17399-1-git@danielhodges.dev
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 net/tipc/crypto.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/tipc/crypto.c b/net/tipc/crypto.c
index 970db62bd029b..a3f9ca28c3d53 100644
--- a/net/tipc/crypto.c
+++ b/net/tipc/crypto.c
@@ -460,7 +460,7 @@ static void tipc_aead_users_dec(struct tipc_aead __rcu *aead, int lim)
 	rcu_read_lock();
 	tmp = rcu_dereference(aead);
 	if (tmp)
-		atomic_add_unless(&rcu_dereference(aead)->users, -1, lim);
+		atomic_add_unless(&tmp->users, -1, lim);
 	rcu_read_unlock();
 }
 
-- 
2.51.0





