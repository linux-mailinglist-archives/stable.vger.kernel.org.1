Return-Path: <stable+bounces-91705-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A5D49BF4CA
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 19:04:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 172C61F24581
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 18:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F8AE20822A;
	Wed,  6 Nov 2024 18:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="uwYzySPa"
X-Original-To: stable@vger.kernel.org
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32643208233
	for <stable@vger.kernel.org>; Wed,  6 Nov 2024 18:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730916263; cv=none; b=VVtTLrL950yeRMviBgD7DWCVScN1blArPpwETxHp7mG7/vkaAchSxGaaVy4PFzwryW9DFAzUD9DfMuE8g5xKSoHE5s6MQhL3x7dIwvRlPrm8FKalpETDXZ8du5Bh7Bl8QaY0LBaQ0uEg0VhxtBflSsJtD1VMGOHn7ql5Ynv/p9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730916263; c=relaxed/simple;
	bh=sBSIobfEptnuiR+FyuAucSaxwnt5VnYig/YepY1sJpY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SWW9r+YKMJYP8s9Ykhx0sl4YbeMLpbedp5nc63eg5toHx63gjhoOJMLpfqrWZR0oKeLzgk2awl/gNdlf3T1AaJPYZLmSF8UkimiCbjgp1yFI+CLvXNA9fv3+TkenXfUibWgQgWbZH2UMG2Yc15gIMRWE9MUmC4Y2wu5p9y3RH/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=uwYzySPa; arc=none smtp.client-ip=52.119.213.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1730916262; x=1762452262;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=qUtsCtHDtbeB/50MaBv7qu+Q0WmzSWBjHXEx4WqpTfI=;
  b=uwYzySPaExT8enJffoX1wgBSrlagNRtEEkY3Ty+ln5wcavQ7uBoTiUMR
   pULy9XGeMb53LOWURSWlR88YPbAcblK1WDsUfk9hcdZoR5jUwmtDIjw1B
   11BvPPIooJa/RRU3eZquTU3Fz1HgZq5EXnFZHgcMXff+SMyWQA0f9VxcJ
   c=;
X-IronPort-AV: E=Sophos;i="6.11,263,1725321600"; 
   d="scan'208";a="245414304"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2024 18:04:06 +0000
Received: from EX19MTAEUC001.ant.amazon.com [10.0.43.254:16949]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.40.73:2525] with esmtp (Farcaster)
 id b6dd717a-22fb-468e-b911-0e2456d1ee88; Wed, 6 Nov 2024 18:04:04 +0000 (UTC)
X-Farcaster-Flow-ID: b6dd717a-22fb-468e-b911-0e2456d1ee88
Received: from EX19D016EUC003.ant.amazon.com (10.252.51.244) by
 EX19MTAEUC001.ant.amazon.com (10.252.51.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Wed, 6 Nov 2024 18:04:01 +0000
Received: from EX19MTAUEA002.ant.amazon.com (10.252.134.9) by
 EX19D016EUC003.ant.amazon.com (10.252.51.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Wed, 6 Nov 2024 18:04:00 +0000
Received: from email-imr-corp-prod-iad-1box-1a-6851662a.us-east-1.amazon.com
 (10.43.8.2) by mail-relay.amazon.com (10.252.134.34) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1258.34 via Frontend Transport; Wed, 6 Nov 2024 18:04:00 +0000
Received: from dev-dsk-kareemem-1c-885b5fe7.eu-west-1.amazon.com (dev-dsk-kareemem-1c-885b5fe7.eu-west-1.amazon.com [10.13.243.223])
	by email-imr-corp-prod-iad-1box-1a-6851662a.us-east-1.amazon.com (Postfix) with ESMTPS id F1E3E404A7;
	Wed,  6 Nov 2024 18:03:59 +0000 (UTC)
From: Abdelkareem Abdelsaamad <kareemem@amazon.com>
To: <stable@vger.kernel.org>
CC: Eric Dumazet <edumazet@google.com>, Naresh Kamboju
	<naresh.kamboju@linaro.org>, Linux Kernel Functional Testing
	<lkft@linaro.org>, Xin Long <lucien.xin@gmail.com>, Steffen Klassert
	<steffen.klassert@secunet.com>, Paolo Abeni <pabeni@redhat.com>, "Abdelkareem
 Abdelsaamad" <kareemem@amazon.com>
Subject: [PATCH 6.1.y 5.15.y 5.10.y] net: do not delay dst_entries_add() in dst_release()
Date: Wed, 6 Nov 2024 18:03:52 +0000
Message-ID: <20241106180352.91893-1-kareemem@amazon.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Eric Dumazet <edumazet@google.com>

commit ac888d58869bb99753e7652be19a151df9ecb35d upstream.

dst_entries_add() uses per-cpu data that might be freed at netns
dismantle from ip6_route_net_exit() calling dst_entries_destroy()

Before ip6_route_net_exit() can be called, we release all
the dsts associated with this netns, via calls to dst_release(),
which waits an rcu grace period before calling dst_destroy()

dst_entries_add() use in dst_destroy() is racy, because
dst_entries_destroy() could have been called already.

Decrementing the number of dsts must happen sooner.

Notes:

1) in CONFIG_XFRM case, dst_destroy() can call
   dst_release_immediate(child), this might also cause UAF
   if the child does not have DST_NOCOUNT set.
   IPSEC maintainers might take a look and see how to address this.

2) There is also discussion about removing this count of dst,
   which might happen in future kernels.

Fixes: f88649721268 ("ipv4: fix dst race in sk_dst_get()")
Closes: https://lore.kernel.org/lkml/CANn89iLCCGsP7SFn9HKpvnKu96Td4KD08xf7aGtiYgZnkjaL=w@mail.gmail.com/T/
Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>
Tested-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Xin Long <lucien.xin@gmail.com>
Cc: Steffen Klassert <steffen.klassert@secunet.com>
Reviewed-by: Xin Long <lucien.xin@gmail.com>
Link: https://patch.msgid.link/20241008143110.1064899-1-edumazet@google.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>

[Conflict due to
bc9d3a9f2afc ("net: dst: Switch to rcuref_t reference counting")
is not in the tree]
Signed-off-by: Abdelkareem Abdelsaamad <kareemem@amazon.com>
---
 net/core/dst.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/net/core/dst.c b/net/core/dst.c
index 453ec8aafc4a..5bb143857336 100644
--- a/net/core/dst.c
+++ b/net/core/dst.c
@@ -109,9 +109,6 @@ struct dst_entry *dst_destroy(struct dst_entry * dst)
 		child = xdst->child;
 	}
 #endif
-	if (!(dst->flags & DST_NOCOUNT))
-		dst_entries_add(dst->ops, -1);
-
 	if (dst->ops->destroy)
 		dst->ops->destroy(dst);
 	if (dst->dev)
@@ -162,6 +159,12 @@ void dst_dev_put(struct dst_entry *dst)
 }
 EXPORT_SYMBOL(dst_dev_put);
 
+static void dst_count_dec(struct dst_entry *dst)
+{
+	if (!(dst->flags & DST_NOCOUNT))
+		dst_entries_add(dst->ops, -1);
+}
+
 void dst_release(struct dst_entry *dst)
 {
 	if (dst) {
@@ -171,8 +174,10 @@ void dst_release(struct dst_entry *dst)
 		if (WARN_ONCE(newrefcnt < 0, "dst_release underflow"))
 			net_warn_ratelimited("%s: dst:%p refcnt:%d\n",
 					     __func__, dst, newrefcnt);
-		if (!newrefcnt)
+		if (!newrefcnt){
+			dst_count_dec(dst);
 			call_rcu(&dst->rcu_head, dst_destroy_rcu);
+		}
 	}
 }
 EXPORT_SYMBOL(dst_release);
@@ -186,8 +191,10 @@ void dst_release_immediate(struct dst_entry *dst)
 		if (WARN_ONCE(newrefcnt < 0, "dst_release_immediate underflow"))
 			net_warn_ratelimited("%s: dst:%p refcnt:%d\n",
 					     __func__, dst, newrefcnt);
-		if (!newrefcnt)
+		if (!newrefcnt){
+			dst_count_dec(dst);
 			dst_destroy(dst);
+		}
 	}
 }
 EXPORT_SYMBOL(dst_release_immediate);
-- 
2.40.1


