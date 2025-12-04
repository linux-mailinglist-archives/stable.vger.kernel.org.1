Return-Path: <stable+bounces-199978-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D684CA2F3E
	for <lists+stable@lfdr.de>; Thu, 04 Dec 2025 10:21:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4E437310EF6C
	for <lists+stable@lfdr.de>; Thu,  4 Dec 2025 09:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08D2D33B6E7;
	Thu,  4 Dec 2025 09:11:43 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cmccmta2.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 342B433B6D8;
	Thu,  4 Dec 2025 09:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764839502; cv=none; b=ELM83qaM8naDaULkYfQGLG+796fi/euYKhz0fkwtR93qxFhfY7Gu9WLZg4j3hAU8RNVI/HODPszUUceDBLsaiDSEN+6GCzMpdg0cHz1fpOOn8ueZypNiUVozMtmsAfpj5tsdlza2qdgPNB3xag6VfdpW9azntYW/ot+qaRpuY/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764839502; c=relaxed/simple;
	bh=viIUBCUxUrQIU+KRE+rcobyjD9sts35NOjZEYvyj3fA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BtdMiKD2mvhQ5/Xt5qtPQhqXvR7Q1Ifl+iHp+yzo5Rn6Anl2U+iwtRAulxVd08NlKeaFAdcSJsSU9POlY7Jt7vYWDDFFd+7KLnAxGg+GJl1KqrUW4qTlfR87HP6OtigBOHkJmaN2V5ErpRujhUY8Gyte2gimBtwHmzncJ3zvOlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app05-12005 (RichMail) with SMTP id 2ee569315049525-ac64e;
	Thu, 04 Dec 2025 17:11:37 +0800 (CST)
X-RM-TRANSID:2ee569315049525-ac64e
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[10.55.1.72])
	by rmsmtp-syy-appsvr01-12001 (RichMail) with SMTP id 2ee169315046302-d1b52;
	Thu, 04 Dec 2025 17:11:37 +0800 (CST)
X-RM-TRANSID:2ee169315046302-d1b52
From: caoping <caoping@cmss.chinamobile.com>
To: chuck.lever@oracle.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	kernel-tls-handshake@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	caoping <caoping@cmss.chinamobile.com>
Subject: [PATCH v3] net/handshake: restore destructor on submit failure
Date: Thu,  4 Dec 2025 01:10:58 -0800
Message-ID: <20251204091058.1545151-1-caoping@cmss.chinamobile.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

handshake_req_submit() replaces sk->sk_destruct but never restores it when
submission fails before the request is hashed. handshake_sk_destruct() then
returns early and the original destructor never runs, leaking the socket.
Restore sk_destruct on the error path.

Fixes: 3b3009ea8abb ("net/handshake: Create a NETLINK service for handling handshake requests")
Reviewed-by: Chuck Lever <chuck.lever@oracle.com>
Cc: stable@vger.kernel.org
Signed-off-by: caoping <caoping@cmss.chinamobile.com>
---
 net/handshake/request.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/handshake/request.c b/net/handshake/request.c
index 274d2c89b6b2..89435ed755cd 100644
--- a/net/handshake/request.c
+++ b/net/handshake/request.c
@@ -276,6 +276,8 @@ int handshake_req_submit(struct socket *sock, struct handshake_req *req,
 out_unlock:
 	spin_unlock(&hn->hn_lock);
 out_err:
+	/* Restore original destructor so socket teardown still runs on failure */
+	req->hr_sk->sk_destruct = req->hr_odestruct;
 	trace_handshake_submit_err(net, req, req->hr_sk, ret);
 	handshake_req_destroy(req);
 	return ret;

base-commit: 4a26e7032d7d57c998598c08a034872d6f0d3945
-- 
2.47.3




