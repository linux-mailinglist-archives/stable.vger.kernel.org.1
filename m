Return-Path: <stable+bounces-172881-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6FE4B34AC5
	for <lists+stable@lfdr.de>; Mon, 25 Aug 2025 21:09:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A6AE7A622D
	for <lists+stable@lfdr.de>; Mon, 25 Aug 2025 19:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86959284B36;
	Mon, 25 Aug 2025 19:09:04 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.uniroma2.it (smtp.uniroma2.it [160.80.4.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04AC22836BE;
	Mon, 25 Aug 2025 19:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.80.4.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756148944; cv=none; b=cYurWlLNTNtEWT2DsETFaIfpvOv7c6yWqHuZzvB/xrWiI3FnSqbOfxhh6lrmkuuxRXdfruzr7rR+AZV+hD5RZlpONf3siG+xWbE2Ng7iunFUDhXOFhROJlCpIZMB0/a9miFjlgEX+P7OiwkMyFeiGR6UafBoZ4sfuNCrOvi0ChY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756148944; c=relaxed/simple;
	bh=9Nn5ZXTPqHydySEm+Aq/8KSWqV9NKz7RWl79tb4PImI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kIbgbAfwd9WoC1nZ4uAvLA94mz2llm6NK4e5ERzoonw0RZv3QAOf3OPaaUPf8N+hkfe2vDqr1KKcjWzeXJUN7O2JkfeSX85hehCE80uE/hxrlL7ghEdl7X1j8/FtBbLEvHS/ws/JwZO/8PlSZ/r6dyYEilPwF3yd1k5YVOkLXNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it; spf=pass smtp.mailfrom=uniroma2.it; arc=none smtp.client-ip=160.80.4.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniroma2.it
Received: from localhost.localdomain ([160.80.103.126])
	by smtp-2015.uniroma2.it (8.14.4/8.14.4/Debian-8) with ESMTP id 57PJ8NAK007054
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 25 Aug 2025 21:08:24 +0200
From: Andrea Mayer <andrea.mayer@uniroma2.it>
To: "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>,
        Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Cc: Eric Biggers <ebiggers@kernel.org>, David Lebrun <dlebrun@google.com>,
        Stefano Salsano <stefano.salsano@uniroma2.it>,
        Paolo Lungaroni <paolo.lungaroni@uniroma2.it>,
        Ahmed Abdelsalam <ahabdels.dev@gmail.com>,
        Andrea Mayer <andrea.mayer@uniroma2.it>, stable@vger.kernel.org
Subject: [PATCH net] ipv6: sr: fix destroy of seg6_hmac_info to prevent HMAC data leak
Date: Mon, 25 Aug 2025 21:07:15 +0200
Message-Id: <20250825190715.1690-1-andrea.mayer@uniroma2.it>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.100.0 at smtp-2015
X-Virus-Status: Clean

The seg6_hmac_info structure stores information related to SRv6 HMAC
configurations, including the secret key, HMAC ID, and hashing algorithm
used to authenticate and secure SRv6 packets.

When a seg6_hmac_info object is no longer needed, it is destroyed via
seg6_hmac_info_del(), which eventually calls seg6_hinfo_release(). This
function uses kfree_rcu() to safely deallocate memory after an RCU grace
period has elapsed.
The kfree_rcu() releases memory without sanitization (e.g., zeroing out
the memory). Consequently, sensitive information such as the HMAC secret
and its length may remain in freed memory, potentially leading to data
leaks.

To address this risk, we replaced kfree_rcu() with a custom RCU
callback, seg6_hinfo_free_callback_rcu(). Within this callback, we
explicitly sanitize the seg6_hmac_info object before deallocating it
safely using kfree_sensitive(). This approach ensures the memory is
securely freed and prevents potential HMAC info leaks.
Additionally, in the control path, we ensure proper cleanup of
seg6_hmac_info objects when seg6_hmac_info_add() fails: such objects are
freed using kfree_sensitive() instead of kfree().

Fixes: 4f4853dc1c9c ("ipv6: sr: implement API to control SR HMAC structure")
Fixes: bf355b8d2c30 ("ipv6: sr: add core files for SR HMAC support")
Cc: stable@vger.kernel.org
Signed-off-by: Andrea Mayer <andrea.mayer@uniroma2.it>
---
 net/ipv6/seg6.c      |  2 +-
 net/ipv6/seg6_hmac.c | 10 +++++++++-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/net/ipv6/seg6.c b/net/ipv6/seg6.c
index 180da19c148c..88782bdab843 100644
--- a/net/ipv6/seg6.c
+++ b/net/ipv6/seg6.c
@@ -215,7 +215,7 @@ static int seg6_genl_sethmac(struct sk_buff *skb, struct genl_info *info)
 
 	err = seg6_hmac_info_add(net, hmackeyid, hinfo);
 	if (err)
-		kfree(hinfo);
+		kfree_sensitive(hinfo);
 
 out_unlock:
 	mutex_unlock(&sdata->lock);
diff --git a/net/ipv6/seg6_hmac.c b/net/ipv6/seg6_hmac.c
index fd58426f222b..19cdf3791ebf 100644
--- a/net/ipv6/seg6_hmac.c
+++ b/net/ipv6/seg6_hmac.c
@@ -57,9 +57,17 @@ static int seg6_hmac_cmpfn(struct rhashtable_compare_arg *arg, const void *obj)
 	return (hinfo->hmackeyid != *(__u32 *)arg->key);
 }
 
+static void seg6_hinfo_free_callback_rcu(struct rcu_head *head)
+{
+	struct seg6_hmac_info *hinfo;
+
+	hinfo = container_of(head, struct seg6_hmac_info, rcu);
+	kfree_sensitive(hinfo);
+}
+
 static inline void seg6_hinfo_release(struct seg6_hmac_info *hinfo)
 {
-	kfree_rcu(hinfo, rcu);
+	call_rcu(&hinfo->rcu, seg6_hinfo_free_callback_rcu);
 }
 
 static void seg6_free_hi(void *ptr, void *arg)
-- 
2.20.1


