Return-Path: <stable+bounces-63253-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 37843941814
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 18:19:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 691051C22FC1
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 16:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40C1B184535;
	Tue, 30 Jul 2024 16:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="s4AW1HiY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFCDD1A6189;
	Tue, 30 Jul 2024 16:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722356224; cv=none; b=qYcSF93poc6kw7hkV94i9GA/Xteb7qeS0YvzMYwCJdI0qLUPc3hw2zQ6Y7Jy/6AjlXsnoxQCIJKrzns72SbhLvPNgmw112QlvTzFALSyhvhBs2VvhfL99KsTke+D4wY9XWM39MixVSBjDU/s3uXToecE5eTrWc1NuNWPH6Yj6jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722356224; c=relaxed/simple;
	bh=V3InshDAA1+YvbJgV7xBnfSHdK7NdwGf6vqquoPp64E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eolTUgkzrLrppEWQey4v4gam0nQ2zH/U/XLSDdUyPmTdbzUcvEN/mytLwIrSD6zCqcMv0TuwSF/vmQoxxmfd9/BlVIiXECRIBBoLFhmDWNbp+oUjLuMmB8MsqdTMhonNjPOzXJYnwqFnP9f8/RnhK70+erHy4ZmUevIrvuRBG64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=s4AW1HiY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FAFBC32782;
	Tue, 30 Jul 2024 16:17:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722356223;
	bh=V3InshDAA1+YvbJgV7xBnfSHdK7NdwGf6vqquoPp64E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s4AW1HiYSkMRkSfHrX5PBQllB2/KyV3e+RKGo1SMvWtIivAa24bI7hU7M56AtvTDS
	 +5pyW9U9S72iyeOqul1mN1I9i2QCfxECe8aGbM3p43xYLAeGvkMITJkceDt3QYkIDa
	 jHqNF2TSWXfRP9TLvXrtySXNbpmB2enTce7ziUj4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chuck Lever <chuck.lever@oracle.com>,
	Anna Schumaker <Anna.Schumaker@Netapp.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 170/440] xprtrdma: Fix rpcrdma_reqs_reset()
Date: Tue, 30 Jul 2024 17:46:43 +0200
Message-ID: <20240730151622.509206283@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240730151615.753688326@linuxfoundation.org>
References: <20240730151615.753688326@linuxfoundation.org>
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

From: Chuck Lever <chuck.lever@oracle.com>

[ Upstream commit acd9f2dd23c632568156217aac7a05f5a0313152 ]

Avoid FastReg operations getting MW_BIND_ERR after a reconnect.

rpcrdma_reqs_reset() is called on transport tear-down to get each
rpcrdma_req back into a clean state.

MRs on req->rl_registered are waiting for a FastReg, are already
registered, or are waiting for invalidation. If the transport is
being torn down when reqs_reset() is called, the matching LocalInv
might never be posted. That leaves these MR registered /and/ on
req->rl_free_mrs, where they can be re-used for the next
connection.

Since xprtrdma does not keep specific track of the MR state, it's
not possible to know what state these MRs are in, so the only safe
thing to do is release them immediately.

Fixes: 5de55ce951a1 ("xprtrdma: Release in-flight MRs on disconnect")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sunrpc/xprtrdma/frwr_ops.c |  3 ++-
 net/sunrpc/xprtrdma/verbs.c    | 16 +++++++++++++++-
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/net/sunrpc/xprtrdma/frwr_ops.c b/net/sunrpc/xprtrdma/frwr_ops.c
index ffbf99894970e..47f33bb7bff81 100644
--- a/net/sunrpc/xprtrdma/frwr_ops.c
+++ b/net/sunrpc/xprtrdma/frwr_ops.c
@@ -92,7 +92,8 @@ static void frwr_mr_put(struct rpcrdma_mr *mr)
 	rpcrdma_mr_push(mr, &mr->mr_req->rl_free_mrs);
 }
 
-/* frwr_reset - Place MRs back on the free list
+/**
+ * frwr_reset - Place MRs back on @req's free list
  * @req: request to reset
  *
  * Used after a failed marshal. For FRWR, this means the MRs
diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
index 4f71627ba39ce..cb909329a5039 100644
--- a/net/sunrpc/xprtrdma/verbs.c
+++ b/net/sunrpc/xprtrdma/verbs.c
@@ -897,6 +897,8 @@ static int rpcrdma_reqs_setup(struct rpcrdma_xprt *r_xprt)
 
 static void rpcrdma_req_reset(struct rpcrdma_req *req)
 {
+	struct rpcrdma_mr *mr;
+
 	/* Credits are valid for only one connection */
 	req->rl_slot.rq_cong = 0;
 
@@ -906,7 +908,19 @@ static void rpcrdma_req_reset(struct rpcrdma_req *req)
 	rpcrdma_regbuf_dma_unmap(req->rl_sendbuf);
 	rpcrdma_regbuf_dma_unmap(req->rl_recvbuf);
 
-	frwr_reset(req);
+	/* The verbs consumer can't know the state of an MR on the
+	 * req->rl_registered list unless a successful completion
+	 * has occurred, so they cannot be re-used.
+	 */
+	while ((mr = rpcrdma_mr_pop(&req->rl_registered))) {
+		struct rpcrdma_buffer *buf = &mr->mr_xprt->rx_buf;
+
+		spin_lock(&buf->rb_lock);
+		list_del(&mr->mr_all);
+		spin_unlock(&buf->rb_lock);
+
+		frwr_mr_release(mr);
+	}
 }
 
 /* ASSUMPTION: the rb_allreqs list is stable for the duration,
-- 
2.43.0




