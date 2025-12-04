Return-Path: <stable+bounces-199971-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A084CA2DB9
	for <lists+stable@lfdr.de>; Thu, 04 Dec 2025 09:48:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E8D3A301C65D
	for <lists+stable@lfdr.de>; Thu,  4 Dec 2025 08:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A75D330B14;
	Thu,  4 Dec 2025 08:48:46 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cmccmta2.chinamobile.com (cmccmta4.chinamobile.com [111.22.67.137])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F43F1D6BB;
	Thu,  4 Dec 2025 08:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764838126; cv=none; b=Omrm7b0K+3Uf43rbsmM59qMWe2lO3uuz8bGbWbdZuq0+TQyQsg31eHujJsERjqk6WgzzaCjY1/SzjZAgVFrDYZh2neOgJ99ZBwnKmlue8BWyUeWpldlzeyNO5K78WZZvj9Ikv/3ixCTPjmMfMA6rNtIfwZ8iLca09yFOxuB9U60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764838126; c=relaxed/simple;
	bh=vlILOzbZNY3COdT0kEPHK07pGdodIaGsMkBzzQC1QLo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZnOq6+3wi+7sGPoau/FaTDBgp8qqjkHiVCYEeQmRN6Vgvf6x5Wfz1V0vZ2ARyxT1YLZJVUDYVLs9XfZprnPNu10Htw6HU3K8yL+FKDuTfGg27p1M120jki5TCfzWwCRpIv3IlkopCOZpDZP/k1ZGgeHEeO6fBUgw4CSUeLUbnzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app08-12008 (RichMail) with SMTP id 2ee869314ae5fd3-45080;
	Thu, 04 Dec 2025 16:48:37 +0800 (CST)
X-RM-TRANSID:2ee869314ae5fd3-45080
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[10.55.1.72])
	by rmsmtp-syy-appsvr10-12010 (RichMail) with SMTP id 2eea69314ae33bb-d0125;
	Thu, 04 Dec 2025 16:48:37 +0800 (CST)
X-RM-TRANSID:2eea69314ae33bb-d0125
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
Subject: [PATCH v2] net/handshake: restore destructor on submit failure
Date: Thu,  4 Dec 2025 00:47:56 -0800
Message-ID: <20251204084757.1536523-1-caoping@cmss.chinamobile.com>
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




