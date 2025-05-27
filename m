Return-Path: <stable+bounces-146527-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66B29AC5387
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 18:48:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 830D83B7BC5
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 16:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EA2F263F5E;
	Tue, 27 May 2025 16:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="m2SPyWcT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1CA32CCC0;
	Tue, 27 May 2025 16:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748364495; cv=none; b=FNp5AfUAcUoxcAootWym5mfq8kjeDOcOI8yUVXMzIU5Bdt32I+IrAU+yqb3PVTojXpDJp2EjIDaMLCQrWmZP+nlihQUzvyXH5FUHKSGfCBk034aYw7t00MvwEQlms1XUh0LkkxoFnV4jl1aMO56jLUuLEMtWjvEU8xqfauDQc2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748364495; c=relaxed/simple;
	bh=cuejeLGWlWHO/UWpXI0pcMLs64DfRkVqbwvH/YrDNeA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DDmyGWwksDHXGWTzESeEwmbS0pGDJazl3mML/n9Hpzppk1YX0SXqw+ZIn/piafSPgm4sHNR7rrGuZn5pTZTcM+FOo5jJpGcEWnLHlJpLSnGvwEzj1ghpWxnS0r426KMnM/G4BhlhPLpdYEKCrOAm0ixUC4HbwM6Qyl6j/vp9WJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=m2SPyWcT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2AFCC4CEE9;
	Tue, 27 May 2025 16:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748364494;
	bh=cuejeLGWlWHO/UWpXI0pcMLs64DfRkVqbwvH/YrDNeA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m2SPyWcTbZStKykGyWnFKVqD9bOAsR3Ha+V8X1/hV14Qdl+Yh4JgouhbqYGapsXBp
	 QbrOk5wcuc7VMKj3xLMSK1gPn9Bk1XO36VyR/02gfRV5vgtx9tOZCc4yhRf1fbum83
	 c5RDHvC/AIChKr9ChNXb6Mo//s2eShwvEM68/giQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jeff Layton <jlayton@kernel.org>,
	Benjamin Coddington <bcodding@redhat.com>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 073/626] SUNRPC: rpcbind should never reset the port to the value 0
Date: Tue, 27 May 2025 18:19:26 +0200
Message-ID: <20250527162448.013483129@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250527162445.028718347@linuxfoundation.org>
References: <20250527162445.028718347@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Trond Myklebust <trond.myklebust@hammerspace.com>

[ Upstream commit 214c13e380ad7636631279f426387f9c4e3c14d9 ]

If we already had a valid port number for the RPC service, then we
should not allow the rpcbind client to set it to the invalid value '0'.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Reviewed-by: Benjamin Coddington <bcodding@redhat.com>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sunrpc/rpcb_clnt.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/sunrpc/rpcb_clnt.c b/net/sunrpc/rpcb_clnt.c
index 102c3818bc54d..53bcca365fb1c 100644
--- a/net/sunrpc/rpcb_clnt.c
+++ b/net/sunrpc/rpcb_clnt.c
@@ -820,9 +820,10 @@ static void rpcb_getport_done(struct rpc_task *child, void *data)
 	}
 
 	trace_rpcb_setport(child, map->r_status, map->r_port);
-	xprt->ops->set_port(xprt, map->r_port);
-	if (map->r_port)
+	if (map->r_port) {
+		xprt->ops->set_port(xprt, map->r_port);
 		xprt_set_bound(xprt);
+	}
 }
 
 /*
-- 
2.39.5




