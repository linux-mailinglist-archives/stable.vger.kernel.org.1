Return-Path: <stable+bounces-108875-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57FC2A120BB
	for <lists+stable@lfdr.de>; Wed, 15 Jan 2025 11:48:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A87E37A071D
	for <lists+stable@lfdr.de>; Wed, 15 Jan 2025 10:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2AFE156644;
	Wed, 15 Jan 2025 10:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xO03CROC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A88B2248BB2;
	Wed, 15 Jan 2025 10:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736938099; cv=none; b=uKrRnMtX4AOSVPEJjiszV3YGoupc86I6ySmFtasPmTwvzQ9eWhoPlDOnBPhArPARBOQHSB6WbadjMOTARiR8CysWcOQl2r9YDju+jWLLcrsitoXCboeanCnqJb/XfWEclWcOnwxzkGYC0x/2dRjnPhv8GeG+soUraLlptGUDP/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736938099; c=relaxed/simple;
	bh=vnScDa3TYqfUJu6ok+5Wm4alEJNBuHVIX18vUOd0CiE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FsNWdE6R1foLKo6kdw08NFbRY95o3mcNNuFQ0GFx297xafBWFr8N5JQZaQk+K5NU12LvJCaW2JYzGbFcrPTJkEHd7yT/pBnPDfAF9kS0dyfetk6RJ74x7BJ1JfBRRqbWYmr7tqRvDHAMVjjGlukYH04/OvASYJ5jip+s30oYGLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xO03CROC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0391C4CEDF;
	Wed, 15 Jan 2025 10:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1736938099;
	bh=vnScDa3TYqfUJu6ok+5Wm4alEJNBuHVIX18vUOd0CiE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=xO03CROCmXNJSOGrKXu09mlHnMOKuKSLI+lN2Abz/+QVMccZvYGgzrfH67fJazqwL
	 MkKlZCifAWrI5UIaF2hjramFtHw+lLdYn54ZzgvaL/5tIdgtEW0kmZrSZ0qrr7UAzy
	 kTuvFlRtuytScKLi5SUMnIEXF7eVFJgLM6JCk/4Y=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	David Howells <dhowells@redhat.com>,
	Jeff Layton <jlayton@kernel.org>,
	netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 082/189] netfs: Fix read-retry for fs with no ->prepare_read()
Date: Wed, 15 Jan 2025 11:36:18 +0100
Message-ID: <20250115103609.617676141@linuxfoundation.org>
X-Mailer: git-send-email 2.48.0
In-Reply-To: <20250115103606.357764746@linuxfoundation.org>
References: <20250115103606.357764746@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Howells <dhowells@redhat.com>

[ Upstream commit 904abff4b1b94184aaa0e9f5fce7821f7b5b81a3 ]

Fix netfslib's read-retry to only call ->prepare_read() in the backing
filesystem such a function is provided.  We can get to this point if a
there's an active cache as failed reads from the cache need negotiating
with the server instead.

Fixes: ee4cdf7ba857 ("netfs: Speed up buffered reading")
Signed-off-by: David Howells <dhowells@redhat.com>
Link: https://lore.kernel.org/r/529329.1736261010@warthog.procyon.org.uk
cc: Jeff Layton <jlayton@kernel.org>
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/netfs/read_retry.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/netfs/read_retry.c b/fs/netfs/read_retry.c
index 2701f7d45999..48fb0303f7ee 100644
--- a/fs/netfs/read_retry.c
+++ b/fs/netfs/read_retry.c
@@ -149,7 +149,8 @@ static void netfs_retry_read_subrequests(struct netfs_io_request *rreq)
 			BUG_ON(!len);
 
 			/* Renegotiate max_len (rsize) */
-			if (rreq->netfs_ops->prepare_read(subreq) < 0) {
+			if (rreq->netfs_ops->prepare_read &&
+			    rreq->netfs_ops->prepare_read(subreq) < 0) {
 				trace_netfs_sreq(subreq, netfs_sreq_trace_reprep_failed);
 				__set_bit(NETFS_SREQ_FAILED, &subreq->flags);
 			}
-- 
2.39.5




