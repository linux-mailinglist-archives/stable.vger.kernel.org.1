Return-Path: <stable+bounces-156040-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2F99AE44C6
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 15:45:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B7391BC2F22
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 13:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F71B250BEC;
	Mon, 23 Jun 2025 13:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="x6NO0gAP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB8916419;
	Mon, 23 Jun 2025 13:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750685989; cv=none; b=N5tyNWI6MlkhbrdQUq08e4xSktZkQqIvFtznTRN61S7TpSNSBMSEEj+zuIWXDVVy6yLxvraHMqceHuzOi3R8ZKjOrRjmQce8xd6K1Z0ojMCIzbbdeRLLrGAOp/0zf2yxYD2sz9kCziMsuqspLijrLY78eJJDmf9VPwZZN9TTamM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750685989; c=relaxed/simple;
	bh=rcq9ebGQ+6JE+iwX5+esHIGnMNdF6d/rVSb9QaCfQBA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oyRMJtQKcGNjCBzKVP/yYTON0hSruYJMvqifd57LHFsP4lBAWV7wOxmmZX50qQjQ+/kzcByxe4rQQm3whVuv+zfyLHY/5lX2ZO9zRx+uxF4TsF01Iwp9+KpzAOB+fkbVk9HtOPbhQApGNjqD8d1vlBpiiYKXxV9zleNtTQENyoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=x6NO0gAP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD0DBC4CEEA;
	Mon, 23 Jun 2025 13:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750685989;
	bh=rcq9ebGQ+6JE+iwX5+esHIGnMNdF6d/rVSb9QaCfQBA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=x6NO0gAPke7Yl72sQySKfeYjjFNrJ4pc6pduYCeLyqWfNz14r1W8BvtcMr4OYv5ux
	 4uh/pM/++4d/6rG2GVpm499l46Olo5o5SurZ5hUokeDFyR8hUg7WJ8QSHY7eLtz2u4
	 K5KCOWYGm2ceLR+HoXUNQhIkBAqyXKhyyDzRiWwY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Olga Kornievskaia <okorniev@redhat.com>,
	Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neil@brown.name>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH 6.6 016/290] nfsd: nfsd4_spo_must_allow() must check this is a v4 compound request
Date: Mon, 23 Jun 2025 15:04:37 +0200
Message-ID: <20250623130627.473590907@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250623130626.910356556@linuxfoundation.org>
References: <20250623130626.910356556@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: NeilBrown <neil@brown.name>

commit 1244f0b2c3cecd3f349a877006e67c9492b41807 upstream.

If the request being processed is not a v4 compound request, then
examining the cstate can have undefined results.

This patch adds a check that the rpc procedure being executed
(rq_procinfo) is the NFSPROC4_COMPOUND procedure.

Reported-by: Olga Kornievskaia <okorniev@redhat.com>
Cc: stable@vger.kernel.org
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: NeilBrown <neil@brown.name>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/nfsd/nfs4proc.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -3580,7 +3580,8 @@ bool nfsd4_spo_must_allow(struct svc_rqs
 	struct nfs4_op_map *allow = &cstate->clp->cl_spo_must_allow;
 	u32 opiter;
 
-	if (!cstate->minorversion)
+	if (rqstp->rq_procinfo != &nfsd_version4.vs_proc[NFSPROC4_COMPOUND] ||
+	    cstate->minorversion == 0)
 		return false;
 
 	if (cstate->spo_must_allowed)



