Return-Path: <stable+bounces-1159-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A466D7F7E4D
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:31:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3CA31C21380
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 18:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFC253A8C3;
	Fri, 24 Nov 2023 18:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="W3wu5wWN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A97CB3A8C9;
	Fri, 24 Nov 2023 18:31:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 389DDC433C7;
	Fri, 24 Nov 2023 18:31:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700850706;
	bh=2GOdE/JN6gcHKTjbSPI7yEnGVG28J9fv3h6rFDB68Oo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W3wu5wWNMCyrp2aaojRqRNnTYLUh/Y1yOJ/Dm0yzgbbG1vPMceMmUrmYi7TkrtyxZ
	 q44XpAQuQ4xjD/dyFjYLtqI/hYpXSRKIiAulWGdPlxJZbbjvqvPi0lt7Ih7qy9Flen
	 IQLjyM2ieHhBgklRzARD97dNtbOggCdr/jRcHJfQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 156/491] SUNRPC: ECONNRESET might require a rebind
Date: Fri, 24 Nov 2023 17:46:32 +0000
Message-ID: <20231124172029.159829496@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124172024.664207345@linuxfoundation.org>
References: <20231124172024.664207345@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Trond Myklebust <trond.myklebust@hammerspace.com>

[ Upstream commit 4b09ca1508a60be30b2e3940264e93d7aeb5c97e ]

If connect() is returning ECONNRESET, it usually means that nothing is
listening on that port. If so, a rebind might be required in order to
obtain the new port on which the RPC service is listening.

Fixes: fd01b2597941 ("SUNRPC: ECONNREFUSED should cause a rebind.")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sunrpc/clnt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index 9fb0ccabc1a26..2e3b7b2c1b431 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -2169,6 +2169,7 @@ call_connect_status(struct rpc_task *task)
 	task->tk_status = 0;
 	switch (status) {
 	case -ECONNREFUSED:
+	case -ECONNRESET:
 		/* A positive refusal suggests a rebind is needed. */
 		if (RPC_IS_SOFTCONN(task))
 			break;
@@ -2177,7 +2178,6 @@ call_connect_status(struct rpc_task *task)
 			goto out_retry;
 		}
 		fallthrough;
-	case -ECONNRESET:
 	case -ECONNABORTED:
 	case -ENETDOWN:
 	case -ENETUNREACH:
-- 
2.42.0




