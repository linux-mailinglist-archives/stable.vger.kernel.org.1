Return-Path: <stable+bounces-53348-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C136A90D13B
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 15:40:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5364E287E1F
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 13:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 374331586C0;
	Tue, 18 Jun 2024 13:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wyb90hDN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B4C19F473;
	Tue, 18 Jun 2024 13:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718716062; cv=none; b=JvGWePmPzoFt68y4WfxWPcwMidPKiABJMLojTRrptDLbm6m7zXmYXefFKfzjG4a45YxeJjXodhwY7TkbnfEhZtE0LV3g/sb+Kn+M6oBrMlGFabhpw5C8TMoDVd7EJLPdtFoVJxXMIZXY/ra4ESb+2ItQDhDDunxJADrn453uQ1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718716062; c=relaxed/simple;
	bh=TrmeXlHgNIeJTxN/oTlDM5d5aoMVSzGeP85+hKX4b1w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UHSir7UzA6gDS1Dn1F4spGZhddygwS0ki6wDjZXA1tHLLwyBzMiRTnkftVT5EzW8N2BF6QT2DG7WvRpC6a2CWOMXVWuVwmD+xH0eo3QUkD2n6VrzDnfxaszwF16d0PRidYoLGMBl65Datbqsukpye3I55W2JSYDVm6pWhW2WB10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wyb90hDN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74A0FC32786;
	Tue, 18 Jun 2024 13:07:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718716061;
	bh=TrmeXlHgNIeJTxN/oTlDM5d5aoMVSzGeP85+hKX4b1w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=wyb90hDNG2AOol1IguIwkjZUAnChynjonRqh0t9GdD6O81FFqw2/jpALHJ8hsGrW+
	 XrgGVZ9rPkddSEwOoI7xZNs+1UI1hetZKavmV56ZbeWm5r2QuMdFOUCWfCAR5oZxCd
	 JV4D22WGZdwPk+84wWOQuCr3HyQsJv+y2SvaNc9Q=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 478/770] SUNRPC: Rename svc_close_xprt()
Date: Tue, 18 Jun 2024 14:35:31 +0200
Message-ID: <20240618123425.766227884@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240618123407.280171066@linuxfoundation.org>
References: <20240618123407.280171066@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chuck Lever <chuck.lever@oracle.com>

[ Upstream commit 4355d767a21b9445958fc11bce9a9701f76529d3 ]

Clean up: Use the "svc_xprt_<task>" function naming convention as
is used for other external APIs.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/nfsctl.c                           | 2 +-
 include/linux/sunrpc/svc_xprt.h            | 2 +-
 net/sunrpc/svc.c                           | 2 +-
 net/sunrpc/svc_xprt.c                      | 9 +++++++--
 net/sunrpc/xprtrdma/svc_rdma_backchannel.c | 2 +-
 5 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 8fec779994f7b..16920e4512bde 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -790,7 +790,7 @@ static ssize_t __write_ports_addxprt(char *buf, struct net *net, const struct cr
 out_close:
 	xprt = svc_find_xprt(nn->nfsd_serv, transport, net, PF_INET, port);
 	if (xprt != NULL) {
-		svc_close_xprt(xprt);
+		svc_xprt_close(xprt);
 		svc_xprt_put(xprt);
 	}
 out_err:
diff --git a/include/linux/sunrpc/svc_xprt.h b/include/linux/sunrpc/svc_xprt.h
index cba9559bba6ff..f614f8e248e11 100644
--- a/include/linux/sunrpc/svc_xprt.h
+++ b/include/linux/sunrpc/svc_xprt.h
@@ -135,7 +135,7 @@ void	svc_xprt_received(struct svc_xprt *xprt);
 void	svc_xprt_enqueue(struct svc_xprt *xprt);
 void	svc_xprt_put(struct svc_xprt *xprt);
 void	svc_xprt_copy_addrs(struct svc_rqst *rqstp, struct svc_xprt *xprt);
-void	svc_close_xprt(struct svc_xprt *xprt);
+void	svc_xprt_close(struct svc_xprt *xprt);
 int	svc_port_is_privileged(struct sockaddr *sin);
 int	svc_print_xprts(char *buf, int maxlen);
 struct	svc_xprt *svc_find_xprt(struct svc_serv *serv, const char *xcl_name,
diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index 709118bac4c32..9126e1b7d0769 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -1403,7 +1403,7 @@ svc_process_common(struct svc_rqst *rqstp, struct kvec *argv, struct kvec *resv)
 	svc_authorise(rqstp);
 close_xprt:
 	if (rqstp->rq_xprt && test_bit(XPT_TEMP, &rqstp->rq_xprt->xpt_flags))
-		svc_close_xprt(rqstp->rq_xprt);
+		svc_xprt_close(rqstp->rq_xprt);
 	dprintk("svc: svc_process close\n");
 	return 0;
 
diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
index 20baa0de70174..ee4a6d57056f5 100644
--- a/net/sunrpc/svc_xprt.c
+++ b/net/sunrpc/svc_xprt.c
@@ -1056,7 +1056,12 @@ static void svc_delete_xprt(struct svc_xprt *xprt)
 	svc_xprt_put(xprt);
 }
 
-void svc_close_xprt(struct svc_xprt *xprt)
+/**
+ * svc_xprt_close - Close a client connection
+ * @xprt: transport to disconnect
+ *
+ */
+void svc_xprt_close(struct svc_xprt *xprt)
 {
 	trace_svc_xprt_close(xprt);
 	set_bit(XPT_CLOSE, &xprt->xpt_flags);
@@ -1071,7 +1076,7 @@ void svc_close_xprt(struct svc_xprt *xprt)
 	 */
 	svc_delete_xprt(xprt);
 }
-EXPORT_SYMBOL_GPL(svc_close_xprt);
+EXPORT_SYMBOL_GPL(svc_xprt_close);
 
 static int svc_close_list(struct svc_serv *serv, struct list_head *xprt_list, struct net *net)
 {
diff --git a/net/sunrpc/xprtrdma/svc_rdma_backchannel.c b/net/sunrpc/xprtrdma/svc_rdma_backchannel.c
index c5154bc38e129..feac8c26fb87d 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_backchannel.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_backchannel.c
@@ -186,7 +186,7 @@ static int xprt_rdma_bc_send_request(struct rpc_rqst *rqst)
 
 	ret = rpcrdma_bc_send_request(rdma, rqst);
 	if (ret == -ENOTCONN)
-		svc_close_xprt(sxprt);
+		svc_xprt_close(sxprt);
 	return ret;
 }
 
-- 
2.43.0




