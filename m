Return-Path: <stable+bounces-26551-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ED90870F19
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 22:51:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D380B280E8A
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 21:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E06C67B3E7;
	Mon,  4 Mar 2024 21:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zhEHh1EC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A037A7A70D;
	Mon,  4 Mar 2024 21:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709589049; cv=none; b=b2xusveg6RVlefm6+7ErOtQkxobVVjgqDMzQ9CDa0E4dqkYcCAZg1PZQ2OtA5xMrkBs7rO7ZCQRz8W5yWOI3bmYtO9EsxHKwpMoCOcPv5O4D39ImRDLsySSi96R2KTLBfyLhuk3QgyuPW75qfQYE1+KQnrCWqDiWdeYJny/MkHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709589049; c=relaxed/simple;
	bh=ZoSxpb+lyF/y3Nqjs1vxPoRXBQniLlKRjSJ6L/G5LTk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aEOPdcmwFtUfKDe9x4/RvcS4Bl39zqHQ3ZJmYyqeF388C45X8WpBZ/tSp+M3J4RNL/8jjnSZuyllQfI1P/FClBRVyb+2yBm3FkA8uCqMkBqEr/v+75cxCzHgTMPEFa616U82UDxW6Qt13T0GiXbY/zCKedDrHxhxAK1mcnEtE78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zhEHh1EC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30F95C433F1;
	Mon,  4 Mar 2024 21:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709589049;
	bh=ZoSxpb+lyF/y3Nqjs1vxPoRXBQniLlKRjSJ6L/G5LTk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=zhEHh1ECLFKytkFYMrAU2wqJtIYvR/ErmOPHkXHTYrRAhyrxOwC7uNJ0coL2g6bU8
	 7YASQpitDQkStvbpXWdlnlMEClR0oFDP7LvYVUoV9XtklGgPMsX/VuCgGz8Z/iGrae
	 YMOkmoEQ+3ZqbdTuBwlYjOI3/2tCpUSLeh+1fS6k=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Subject: [PATCH 6.1 174/215] NFSD: Use only RQ_DROPME to signal the need to drop a reply
Date: Mon,  4 Mar 2024 21:23:57 +0000
Message-ID: <20240304211602.459071110@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240304211556.993132804@linuxfoundation.org>
References: <20240304211556.993132804@linuxfoundation.org>
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

[ Upstream commit 9315564747cb6a570e99196b3a4880fb817635fd ]

Clean up: NFSv2 has the only two usages of rpc_drop_reply in the
NFSD code base. Since NFSv2 is going away at some point, replace
these in order to simplify the "drop this reply?" check in
nfsd_dispatch().

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/nfsd/nfsproc.c |    4 ++--
 fs/nfsd/nfssvc.c  |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

--- a/fs/nfsd/nfsproc.c
+++ b/fs/nfsd/nfsproc.c
@@ -211,7 +211,7 @@ nfsd_proc_read(struct svc_rqst *rqstp)
 	if (resp->status == nfs_ok)
 		resp->status = fh_getattr(&resp->fh, &resp->stat);
 	else if (resp->status == nfserr_jukebox)
-		return rpc_drop_reply;
+		__set_bit(RQ_DROPME, &rqstp->rq_flags);
 	return rpc_success;
 }
 
@@ -246,7 +246,7 @@ nfsd_proc_write(struct svc_rqst *rqstp)
 	if (resp->status == nfs_ok)
 		resp->status = fh_getattr(&resp->fh, &resp->stat);
 	else if (resp->status == nfserr_jukebox)
-		return rpc_drop_reply;
+		__set_bit(RQ_DROPME, &rqstp->rq_flags);
 	return rpc_success;
 }
 
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -1071,7 +1071,7 @@ int nfsd_dispatch(struct svc_rqst *rqstp
 
 	nfs_reply = xdr_inline_decode(&rqstp->rq_res_stream, 0);
 	*statp = proc->pc_func(rqstp);
-	if (*statp == rpc_drop_reply || test_bit(RQ_DROPME, &rqstp->rq_flags))
+	if (test_bit(RQ_DROPME, &rqstp->rq_flags))
 		goto out_update_drop;
 
 	if (!proc->pc_encode(rqstp, &rqstp->rq_res_stream))



