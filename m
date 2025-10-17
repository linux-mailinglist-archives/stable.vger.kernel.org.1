Return-Path: <stable+bounces-186994-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A15ABE9FF6
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 17:38:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8A76258717B
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 15:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0F0623EA9E;
	Fri, 17 Oct 2025 15:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jIQbu1FY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA99A337100;
	Fri, 17 Oct 2025 15:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760714819; cv=none; b=tE74GoyTUTNmqQoZm1c6SGGBuzDqwIcFpj/nkAlpgxB6nno+svt/kDT1qXDqlbW8zN1iA+jqkHOkJSmJgYVV1RSNMsMWpep611SZapTgnFsM+OlAZfNnaSraxBQdFNr+sYdHp4qOG/N6IoPayzfmva78zW18c5tPBxEAPf7qSHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760714819; c=relaxed/simple;
	bh=N0e3IEKPA/mj6qZXp1hEuVuByPnH1/NkctpCG/R0wcw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SQrlR7Jt34YScSosOfSZq+UCLmqoTyIMMCtxRvcbnApk68hXnbf6PLv6orQTpjhnPpqE50ezene2p26oqjfrOfnBMI+cQJH5Xqgk6JZ9YT6Dm7ds87R8JoW+Tc3wPnvI2nL1TJKYO2UB/m10069dBd5UTYQ1mRxMJS/6HMBDmdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jIQbu1FY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F2A6C4CEE7;
	Fri, 17 Oct 2025 15:26:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760714819;
	bh=N0e3IEKPA/mj6qZXp1hEuVuByPnH1/NkctpCG/R0wcw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jIQbu1FYuWZnSYsQlMsR2YDNudp0zlUykvLiC1QXUYzUzB0AkcvgEwnEJrJYQVWpP
	 zOGogZ/WZG2V6+gFI5AE9n3pMyCvCVTRVDahqauGI4ac96Wnkn0rzSwPcrbP2DteyN
	 Z9IyP4DO2ZgQ4rO6bWqRcAzCe/sj/J/31jtc8UbE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Olga Kornievskaia <okorniev@redhat.com>,
	NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH 6.12 276/277] nfsd: fix access checking for NLM under XPRTSEC policies
Date: Fri, 17 Oct 2025 16:54:43 +0200
Message-ID: <20251017145157.237029632@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017145147.138822285@linuxfoundation.org>
References: <20251017145147.138822285@linuxfoundation.org>
User-Agent: quilt/0.69
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

From: Olga Kornievskaia <okorniev@redhat.com>

commit 0813c5f01249dbc32ccbc68d27a24fde5bf2901c upstream.

When an export policy with xprtsec policy is set with "tls"
and/or "mtls", but an NFS client is doing a v3 xprtsec=tls
mount, then NLM locking calls fail with an error because
there is currently no support for NLM with TLS.

Until such support is added, allow NLM calls under TLS-secured
policy.

Fixes: 4cc9b9f2bf4d ("nfsd: refine and rename NFSD_MAY_LOCK")
Cc: stable@vger.kernel.org
Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
Reviewed-by: NeilBrown <neil@brown.name>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/nfsd/export.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/fs/nfsd/export.c
+++ b/fs/nfsd/export.c
@@ -1115,7 +1115,8 @@ __be32 check_nfsd_access(struct svc_expo
 		    test_bit(XPT_PEER_AUTH, &xprt->xpt_flags))
 			goto ok;
 	}
-	goto denied;
+	if (!may_bypass_gss)
+		goto denied;
 
 ok:
 	/* legacy gss-only clients are always OK: */



