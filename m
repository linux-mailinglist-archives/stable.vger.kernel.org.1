Return-Path: <stable+bounces-50973-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C599F906DA9
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 14:02:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED8791C23034
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 12:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55FC1145FF1;
	Thu, 13 Jun 2024 11:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RNoBInqp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E741448E0;
	Thu, 13 Jun 2024 11:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718279933; cv=none; b=rdNUQ5p8e8vED/SskeZlCabE9nhWVd6aikoUUnpzWdYz0NbqrprI5Bz2X3U5Nf+htgcfjYYdSiDLg41YE7zFe444gszquJj0xQYBsYX/340X2Zpw4hx4GzCsdvqCTePISTC2rGQUbwILMbDHtEgcPCM8uOa4+2iXDznVVvPcPq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718279933; c=relaxed/simple;
	bh=sOrCuLG/3OQ6gTtO5l5qVwuIVqtc2IjNAmVT4sEvrhQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ptgWiPwqD/h67RBIdcyl9rLfdjsC8ggyVwDiHxjY3Y8wFcCvsYsSWmqdsx50BG6EMWs1G5701PAK0AKXDPL9TOToda8/1TEOlTIKpz3h3TwzugTxA+pd5PKquDz2CdQCexN/qmvrXloYTtFx3xJRITKBONRl+E1Sfdr2G+4lAk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RNoBInqp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48BF2C2BBFC;
	Thu, 13 Jun 2024 11:58:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718279932;
	bh=sOrCuLG/3OQ6gTtO5l5qVwuIVqtc2IjNAmVT4sEvrhQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RNoBInqp5rzuu2x8sS/Oq2AJIE2mrjFVrpserzV5GleEtz+vNJ6I0o03nLiXr1KKk
	 J/gRMnc9KBMEceFZwrJnmx+U+XF9FoNbNop+zwm3sI9w3Ti58mV7zrL2m7DMhhlU4T
	 H9jaspHcKvo0BW2oo1s64J0ckcZPlw3z1C2+CeCQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Aleksandr Aprelkov <aaprelkov@usergate.com>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 084/202] sunrpc: removed redundant procp check
Date: Thu, 13 Jun 2024 13:33:02 +0200
Message-ID: <20240613113231.013439794@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240613113227.759341286@linuxfoundation.org>
References: <20240613113227.759341286@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

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
index 1741f114e8ff7..1b82a7b0df4d3 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -1255,8 +1255,6 @@ svc_generic_init_request(struct svc_rqst *rqstp,
 	if (rqstp->rq_proc >= versp->vs_nproc)
 		goto err_bad_proc;
 	rqstp->rq_procinfo = procp = &versp->vs_proc[rqstp->rq_proc];
-	if (!procp)
-		goto err_bad_proc;
 
 	/* Initialize storage for argp and resp */
 	memset(rqstp->rq_argp, 0, procp->pc_argsize);
-- 
2.43.0




