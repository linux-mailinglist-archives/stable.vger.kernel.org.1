Return-Path: <stable+bounces-133982-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 59C35A928CA
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 20:38:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 791E64A3A4C
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 18:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69D912627E2;
	Thu, 17 Apr 2025 18:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Y70xIdul"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C63252915;
	Thu, 17 Apr 2025 18:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744914735; cv=none; b=gTo+aIoYaxWJgMDkYB1DQz7//t06ruas20ZDFHKWrHzVfKwY+wHxkzhKz3qMDklE0SEYqXGjCO7g2AN1R8RZoC5G1pDjTXoX/wNExwZoEf/LZPjLzldSnMlmP8EA2PVndsM4SpoYCbmMxI4+DtYNFbf7OejJ6iK+uS8WW70hL/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744914735; c=relaxed/simple;
	bh=VYR92gnzWPr09G8zgKietjH8/qS+5GwGLHldnuFGTH0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s7m40Zt5/kiPfYU3ICDaf17rpk4/8uuHXjc1cWu+rzbYzmdwZYZ7N9zKTLFXpwOjb8IKdjlaykc9FMHK8g1lbZ/pFvgjGRurctuHrE0TSehVmDOSJH4+J8thRCkgoNVBF1JWw7Ui+Gh8Zt7uMoT5i5CTmglBkmM2zaM+P+7cjuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Y70xIdul; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 292A7C4CEE4;
	Thu, 17 Apr 2025 18:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744914734;
	bh=VYR92gnzWPr09G8zgKietjH8/qS+5GwGLHldnuFGTH0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y70xIdulde6eOB7w4jYi5eHxDj/mySBPXfRECnMnZ5KG8URXd4ADCDks4pKXdJwmU
	 oZo05D1291sC6i0YBE9jo2VwsT/6e9xGf2tVDsUURh1/GYu/Th78eI5Hrb5p7x1jUB
	 mlf0J1n7dFnnY9HMIh5DUbWyADuTUJuF9A4YXGdM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chuck Lever <chuck.lever@oracle.com>,
	Olga Kornievskaia <okorniev@redhat.com>
Subject: [PATCH 6.13 283/414] svcrdma: do not unregister device for listeners
Date: Thu, 17 Apr 2025 19:50:41 +0200
Message-ID: <20250417175122.810512252@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250417175111.386381660@linuxfoundation.org>
References: <20250417175111.386381660@linuxfoundation.org>
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

6.13-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Olga Kornievskaia <okorniev@redhat.com>

commit 750037aa0a9f28d84df3dcf319a28423d69092fd upstream.

On an rdma-capable machine, a start/stop/start and then on a stop of
a knfsd server would lead kref underflow warning because svc_rdma_free
would indiscriminately unregister the rdma device but a listening
transport never calls the rdma_rn_register() thus leading to kref
going down to 0 on the 1st stop of the server and on the 2nd stop
it leads to a problem.

Suggested-by: Chuck Lever <chuck.lever@oracle.com>
Fixes: c4de97f7c454 ("svcrdma: Handle device removal outside of the CM event handler")
Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
Cc: stable@vger.kernel.org
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sunrpc/xprtrdma/svc_rdma_transport.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/net/sunrpc/xprtrdma/svc_rdma_transport.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_transport.c
@@ -621,7 +621,8 @@ static void __svc_rdma_free(struct work_
 	/* Destroy the CM ID */
 	rdma_destroy_id(rdma->sc_cm_id);
 
-	rpcrdma_rn_unregister(device, &rdma->sc_rn);
+	if (!test_bit(XPT_LISTENER, &rdma->sc_xprt.xpt_flags))
+		rpcrdma_rn_unregister(device, &rdma->sc_rn);
 	kfree(rdma);
 }
 



