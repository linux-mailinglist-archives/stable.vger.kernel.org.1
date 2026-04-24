Return-Path: <stable+bounces-240975-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QJqPBL5562npNAAAu9opvQ
	(envelope-from <stable+bounces-240975-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 16:10:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 74961460065
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 16:10:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A805230376A3
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 14:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25BBA3DBD4F;
	Fri, 24 Apr 2026 14:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jFopmEP4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB8C3DB65B
	for <stable@vger.kernel.org>; Fri, 24 Apr 2026 14:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777039691; cv=none; b=Kt3tabkeKAK0c17QtDBcS4hG+JM5ueGmNxYHLSVSLqQ9hEsztIcx9ci6uDrSesumE/biYgrREkTrVpDWwiLJIHyw9EkWAlAmZPhDDw3zc5IVzbpO7u4HlYjVp2r+XXV9CYwsolB83jOi1ciSyfzIWQLLBXPftR2SjZ5MxHEJekQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777039691; c=relaxed/simple;
	bh=g/JXIFTyDHjjHj8g8aNY22D1ZLCWom3TjnpPTTVr+mY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oZU8tZ2aSwVIdoBJtX98KC1EPp/rOmcInCZdrCu9XvZHeXQKLUA9GfcMARF2wSvS5jbk3O5tUUbaOJNMQvXwv4J0QXCPmzCC+2/ee9J4VYfmNnmeZg0gI3O2iwrRyc8oReGH9KCV4rG3mWWSd1ufr7oZVlPMMJKAmDnXIfsOmtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jFopmEP4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1074C19425;
	Fri, 24 Apr 2026 14:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777039691;
	bh=g/JXIFTyDHjjHj8g8aNY22D1ZLCWom3TjnpPTTVr+mY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jFopmEP42I0dKMPLe5uthdWgv/eGp5WhtdUbLXZXAp6Pq+b+xdxKjn1uWHulLrzJD
	 zjYK6i8dfFwIQZziwv62PenhCIVBvYKzIl/y3GrGncQqX6mqM6EukViulM3KhchPp1
	 uBznidTncDcB4ryrq9LPlHGcHam1PwoEkvGb9LklH0iqH+Fd/fFMwqoI/rPyK9nG6v
	 GBedRvQTjR+bx9w03VfjEn+xjiKFII5YAUrpvCZQVOOmnx3jCssM7Co4cBVRGgJiS5
	 c3GwTAdd9sM8Thgp1r8G25IpSYaHmDjNCuoW86PVPzdi6uYykZyLcR9gNIjKdkp6F5
	 O/zkKt8aY9s/w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: DaeMyung Kang <charsyam@gmail.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] smb: server: fix max_connections off-by-one in tcp accept path
Date: Fri, 24 Apr 2026 10:08:09 -0400
Message-ID: <20260424140809.2152073-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026042408-reshuffle-engraved-f843@gregkh>
References: <2026042408-reshuffle-engraved-f843@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 74961460065
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,microsoft.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-240975-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

From: DaeMyung Kang <charsyam@gmail.com>

[ Upstream commit ce23158bfe584bd90d1918f279fdf9de57802012 ]

The global max_connections check in ksmbd's TCP accept path counts
the newly accepted connection with atomic_inc_return(), but then
rejects the connection when the result is greater than or equal to
server_conf.max_connections.

That makes the effective limit one smaller than configured. For
example:

- max_connections=1 rejects the first connection
- max_connections=2 allows only one connection

The per-IP limit in the same function uses <= correctly because it
counts only pre-existing connections. The global limit instead checks
the post-increment total, so it should reject only when that total
exceeds the configured maximum.

Fix this by changing the comparison from >= to >, so exactly
max_connections simultaneous connections are allowed and the next one
is rejected. This matches the documented meaning of max_connections
in fs/smb/server/ksmbd_netlink.h as the "Number of maximum simultaneous
connections".

Fixes: 0d0d4680db22 ("ksmbd: add max connections parameter")
Cc: stable@vger.kernel.org
Signed-off-by: DaeMyung Kang <charsyam@gmail.com>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ksmbd/transport_tcp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ksmbd/transport_tcp.c b/fs/ksmbd/transport_tcp.c
index 7ef201b7ddb57..e18bb05972aa6 100644
--- a/fs/ksmbd/transport_tcp.c
+++ b/fs/ksmbd/transport_tcp.c
@@ -246,7 +246,7 @@ static int ksmbd_kthread_fn(void *p)
 		}
 
 		if (server_conf.max_connections &&
-		    atomic_inc_return(&active_num_conn) >= server_conf.max_connections) {
+		    atomic_inc_return(&active_num_conn) > server_conf.max_connections) {
 			pr_info_ratelimited("Limit the maximum number of connections(%u)\n",
 					    atomic_read(&active_num_conn));
 			atomic_dec(&active_num_conn);
-- 
2.53.0


