Return-Path: <stable+bounces-51351-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8F97906F8A
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 14:21:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB0891C2257D
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 12:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A778B142E9D;
	Thu, 13 Jun 2024 12:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oh23qeGx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6567881AA7;
	Thu, 13 Jun 2024 12:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718281042; cv=none; b=eJnH4iIPiTc4uQDEvIKRfsCRiIp+ZyVG85+bdWo4XYDaqteTc08ecKToLtvoabn2NtEHuNmXuw+YmKQliIrxVagWE2Rh4A8zBg/baUBtAExuPlSxIfuV5tPF8I2n/DwSoElAbkm4wReFYPOllUOOS5gPVHDluM2tN1cK3PbSwVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718281042; c=relaxed/simple;
	bh=mE5Vnw7Or0uU6cn+eT6l9tdeDXoFiW2+tEFeJr8uDWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hQKRD4RHKef5e7HGV7vmoJztoiBiPYlt+8znxVGyVvYyKe28iJk3/VWxfJPTeth3kZw5s8+0eHmaYepSEjljnrMi6pw+D8HTmigwB86OROH0Wq+7f57dfMH8201zPp0wsCCKdifZcD0fmH6PPmaDEYCVdy/eiZDuzsPSgg/9SH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oh23qeGx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6F6BC32786;
	Thu, 13 Jun 2024 12:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718281042;
	bh=mE5Vnw7Or0uU6cn+eT6l9tdeDXoFiW2+tEFeJr8uDWQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oh23qeGxfaTlwneKvLCj5oHIECDfgq5I1DT3S0FbLEMX7vMAadVNJx7JWOe2nF4/r
	 6T6qNpv29hwncVPJa+OFg/kKBQf7n5qFd3LS3v8O/af9oILaq+b0vjfIgwEbzXjSNR
	 aGog89VN9TbmazYAeG5wqV4MYucXeOZYBC/17WT0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Aleksandr Aprelkov <aaprelkov@usergate.com>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 120/317] sunrpc: removed redundant procp check
Date: Thu, 13 Jun 2024 13:32:18 +0200
Message-ID: <20240613113252.193390352@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240613113247.525431100@linuxfoundation.org>
References: <20240613113247.525431100@linuxfoundation.org>
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

From: Aleksandr Aprelkov <aaprelkov@usergate.com>

[ Upstream commit a576f36971ab4097b6aa76433532aa1fb5ee2d3b ]

since vs_proc pointer is dereferenced before getting it's address there's
no need to check for NULL.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 8e5b67731d08 ("SUNRPC: Add a callback to initialise server requests")
Signed-off-by: Aleksandr Aprelkov <aaprelkov@usergate.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sunrpc/svc.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index 495ebe7fad6dd..cfe8b911ca013 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -1248,8 +1248,6 @@ svc_generic_init_request(struct svc_rqst *rqstp,
 	if (rqstp->rq_proc >= versp->vs_nproc)
 		goto err_bad_proc;
 	rqstp->rq_procinfo = procp = &versp->vs_proc[rqstp->rq_proc];
-	if (!procp)
-		goto err_bad_proc;
 
 	/* Initialize storage for argp and resp */
 	memset(rqstp->rq_argp, 0, procp->pc_argsize);
-- 
2.43.0




