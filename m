Return-Path: <stable+bounces-237693-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aDMEHw6W3WnHgAkAu9opvQ
	(envelope-from <stable+bounces-237693-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 03:19:10 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BECF73F4C46
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 03:19:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4EA003026C89
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 01:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A78F31F3BA4;
	Tue, 14 Apr 2026 01:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ovNRTZ06"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B2C31F92E
	for <stable@vger.kernel.org>; Tue, 14 Apr 2026 01:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776129547; cv=none; b=OJep4AI+sbHiWzoLkAZ9TaLm+x04Vvt/yLPIQ76IP++MEhse8qmgGqvU4IDjsnEDIdoo2b9UnpKfhWDxRoAoRVJYTkEHNdiExJsmaXGQ2YVXTEvypgj8yw9zN3NA7vEFOofhUdxsPFLq527Ja2hnQrm4H7EZcNxZ/wONN6SANps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776129547; c=relaxed/simple;
	bh=Qwgu/i4hE/uex+/yo4TbxSU2WE1DOGlu7dUBkceoB94=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ce6vEkRJu/VUvQg6fshOCsKAwrXWC4KG9I6SBs9jzAOISI3JtdZ2hwkiCqvP/M3+dJCIwmJYjUjJ7aj+wK9A796/R6ihUzUMXzLIKv9jiratkzPqzi8Do6VUkarE8STtFWBVkthhGEWZgYpfep9weQFPWTNEgA0vsGAzj+z3RAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ovNRTZ06; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99121C2BCAF;
	Tue, 14 Apr 2026 01:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776129547;
	bh=Qwgu/i4hE/uex+/yo4TbxSU2WE1DOGlu7dUBkceoB94=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ovNRTZ065gc32u1h9PFat9jg/xrsIhFgSZnEbHQ0m8+OuquuRtdhUqAMJ7O/Wzf8H
	 T7JND+Ty5/z6+z4gZgVd04eFk6QIiO8SAl7W94+5kJPhVveewfXsSOVuMPbgGQodZO
	 y6mc3iBTA4tzosxp9uMOB5gmzVQ0Im2QjcMdyeUu6rhum1KYe1CXQ4gF0g2I7+TC2C
	 s82RijrdjKDZ2IYTPHxAqmrN0FxAiKzInVDTk80a4FW0euOd2fMDx+HZvy1gOwfCds
	 oIzVa56JgqiNJPwPcE8a78OuAZt8isTXJLizuNd12m7y0oV2VQaa4+pPqpWodvin9e
	 Z4hEfs2v7noSA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Luxiao Xu <rakukuip@gmail.com>,
	Yifan Wu <yifanwucs@gmail.com>,
	Juefei Pu <tomapufckgml@gmail.com>,
	Yuan Tan <yuantan098@gmail.com>,
	Xin Liu <bird@lzu.edu.cn>,
	Ren Wei <enjou1224z@gmail.com>,
	Ren Wei <n05ec@lzu.edu.cn>,
	David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Simon Horman <horms@kernel.org>,
	linux-afs@lists.infradead.org,
	stable@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] rxrpc: fix reference count leak in rxrpc_server_keyring()
Date: Mon, 13 Apr 2026 21:19:03 -0400
Message-ID: <20260414011903.3831717-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026041355-flap-narrow-9fea@gregkh>
References: <2026041355-flap-narrow-9fea@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,lzu.edu.cn,redhat.com,auristor.com,kernel.org,lists.infradead.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-237693-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,msgid.link:url,lzu.edu.cn:email,auristor.com:email]
X-Rspamd-Queue-Id: BECF73F4C46
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Luxiao Xu <rakukuip@gmail.com>

[ Upstream commit f125846ee79fcae537a964ce66494e96fa54a6de ]

This patch fixes a reference count leak in rxrpc_server_keyring()
by checking if rx->securities is already set.

Fixes: 17926a79320a ("[AF_RXRPC]: Provide secure RxRPC sockets for use by userspace and kernel both")
Reported-by: Yifan Wu <yifanwucs@gmail.com>
Reported-by: Juefei Pu <tomapufckgml@gmail.com>
Co-developed-by: Yuan Tan <yuantan098@gmail.com>
Signed-off-by: Yuan Tan <yuantan098@gmail.com>
Suggested-by: Xin Liu <bird@lzu.edu.cn>
Tested-by: Ren Wei <enjou1224z@gmail.com>
Signed-off-by: Luxiao Xu <rakukuip@gmail.com>
Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: Simon Horman <horms@kernel.org>
cc: linux-afs@lists.infradead.org
cc: stable@kernel.org
Link: https://patch.msgid.link/20260408121252.2249051-15-dhowells@redhat.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ applied patch to net/rxrpc/key.c instead of net/rxrpc/server_key.c ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/rxrpc/key.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/rxrpc/key.c b/net/rxrpc/key.c
index 979338a64c0ca..0144155d02e05 100644
--- a/net/rxrpc/key.c
+++ b/net/rxrpc/key.c
@@ -933,6 +933,9 @@ int rxrpc_server_keyring(struct rxrpc_sock *rx, sockptr_t optval, int optlen)
 
 	_enter("");
 
+	if (rx->securities)
+		return -EINVAL;
+
 	if (optlen <= 0 || optlen > PAGE_SIZE - 1)
 		return -EINVAL;
 
-- 
2.53.0


