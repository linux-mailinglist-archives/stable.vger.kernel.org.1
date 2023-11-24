Return-Path: <stable+bounces-1614-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 425E57F808C
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:50:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F33A52812AF
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 18:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85DEF3307D;
	Fri, 24 Nov 2023 18:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lBnmloSI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4670928DBB;
	Fri, 24 Nov 2023 18:50:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9A96C433C8;
	Fri, 24 Nov 2023 18:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700851841;
	bh=kB20QdPK6DZb6sN+o9iurqV9/hcRov7nCjgImlPEKuI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lBnmloSIKZGa6EtXT91MFH1wmgrP5G8qahIVsfzMdFAIrjn8qWMn47gspgiGvSJx0
	 Ic3jz1xdmHOfXqllGrwUdNE/OcjRzzL2rOkS0GI2Pzy31XZ12NUnQT21q4vJAS7T8u
	 NiYl9s4rT0CDAkTpT1c3JS785ChobzszBr7NLkgw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 117/372] SUNRPC: ECONNRESET might require a rebind
Date: Fri, 24 Nov 2023 17:48:24 +0000
Message-ID: <20231124172014.380644932@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124172010.413667921@linuxfoundation.org>
References: <20231124172010.413667921@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

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
index 2b803383c7b31..f0bbd6cb4e39b 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -2157,6 +2157,7 @@ call_connect_status(struct rpc_task *task)
 	task->tk_status = 0;
 	switch (status) {
 	case -ECONNREFUSED:
+	case -ECONNRESET:
 		/* A positive refusal suggests a rebind is needed. */
 		if (RPC_IS_SOFTCONN(task))
 			break;
@@ -2165,7 +2166,6 @@ call_connect_status(struct rpc_task *task)
 			goto out_retry;
 		}
 		fallthrough;
-	case -ECONNRESET:
 	case -ECONNABORTED:
 	case -ENETDOWN:
 	case -ENETUNREACH:
-- 
2.42.0




