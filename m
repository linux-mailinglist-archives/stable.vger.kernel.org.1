Return-Path: <stable+bounces-155425-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 27E09AE41FA
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 15:14:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD7FE1895CDD
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 13:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E7992522B1;
	Mon, 23 Jun 2025 13:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Mm4/XJLs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C67A24169B;
	Mon, 23 Jun 2025 13:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750684392; cv=none; b=He+ckCIbqZZLSMF766eknzk07BznD+QP7TI79iKN8DAmvIA0uImdL+hDduvPs0H1/CH3s0kvgTrmu92ae6oO3NmSHt2VfsoJKxCtGfIp9YPj2K8UKzeo4fIX8sE7WhxLYO2uzzv9lJs72at/a7kCPhwVdeNpay4ioCMx6ejuxSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750684392; c=relaxed/simple;
	bh=Q1ibDfqyfOq5ofPTEQmixLbQyz4OqOg+b/ndgiiDfik=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pbIQAnd7aKwU9sjUMaIrTHKUP5Q8jXyWwLpONRAU250fBoNVgltK9yP+cB7NNSj+PnvdnoFfzc4PpP+PhPHR2Hm63ItNXFZmjgj9LpYinu8rxY5DhA/4P3m4NEyC5QPy6WqO5tpKrunEC8mvXU4mYBDXeHtWvbArpb6v/VNJshA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Mm4/XJLs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 941DEC4CEF0;
	Mon, 23 Jun 2025 13:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750684391;
	bh=Q1ibDfqyfOq5ofPTEQmixLbQyz4OqOg+b/ndgiiDfik=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Mm4/XJLsx/K99Z7omUo0lh5cMVCv3yE/5kj9EJwmUwMmDk4b0xTu2d1maZUoq061c
	 LCfxZqMqc2Kwwak7Ew2JCTVuK8Hl1COljMh/N1e2hbNJEGJcRAlFHgsUnbUXqyBNME
	 odY/74esikg/GWIhXq0OjfHZMZyawSyv7PvdzR2k=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Zhu Yanjun <yanjun.zhu@linux.dev>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH 6.15 051/592] svcrdma: Unregister the device if svc_rdma_accept() fails
Date: Mon, 23 Jun 2025 15:00:09 +0200
Message-ID: <20250623130701.464919403@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250623130700.210182694@linuxfoundation.org>
References: <20250623130700.210182694@linuxfoundation.org>
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

6.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chuck Lever <chuck.lever@oracle.com>

commit 8ac6fcae5dc0e801f1c82a83f5ae2c0a4db19932 upstream.

To handle device removal, svc_rdma_accept() requests removal
notification for the underlying device when accepting a connection.
However svc_rdma_free() is not invoked if svc_rdma_accept() fails.
There needs to be a matching "unregister" in that case; otherwise
the device cannot be removed.

Fixes: c4de97f7c454 ("svcrdma: Handle device removal outside of the CM event handler")
Cc: stable@vger.kernel.org
Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sunrpc/xprtrdma/svc_rdma_transport.c |    1 +
 1 file changed, 1 insertion(+)

--- a/net/sunrpc/xprtrdma/svc_rdma_transport.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_transport.c
@@ -577,6 +577,7 @@ static struct svc_xprt *svc_rdma_accept(
 	if (newxprt->sc_qp && !IS_ERR(newxprt->sc_qp))
 		ib_destroy_qp(newxprt->sc_qp);
 	rdma_destroy_id(newxprt->sc_cm_id);
+	rpcrdma_rn_unregister(dev, &newxprt->sc_rn);
 	/* This call to put will destroy the transport */
 	svc_xprt_put(&newxprt->sc_xprt);
 	return NULL;



