Return-Path: <stable+bounces-112339-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6470DA28C3B
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 14:47:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F06831684AD
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 13:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB91D139D1B;
	Wed,  5 Feb 2025 13:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IgLOoLg3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87811B640;
	Wed,  5 Feb 2025 13:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738763238; cv=none; b=TSsu8oTiqWpN7cgThYYLUeTwU91TJQA/6EXHv6GH/5m35pCJZtnjgTNyo0ijfBxkxZME+hUDn5Z5n/ryIEJdumLQsBxMaE6PtTQPbMcWIiqnUvjTgpzdMKdTWYuD8lVynYsoBPPM9VoFRGx6UsL3iCPb6/bay6PizC04U8f0L0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738763238; c=relaxed/simple;
	bh=yCt83+PIXF2ne+wjvu01vOSd2aECRZOgAq0Cc8s6RYo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=glMJiLGW959GGw67OigFu7QAk20u9Tr+IG9xu8siVAdrBB1gEg4wZCP4R/5bvjb9YfvHjJ60HF7Y/r9UuHKhhS/ifK3zoBd22z8lT5UfvoP3NcfWPCCd0GNn3TskBVHhFsIAfN01eyVurwXfPHxA/NZ0n8CkIpMmzJ9yXoCIzSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IgLOoLg3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88B2EC4CED1;
	Wed,  5 Feb 2025 13:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738763236;
	bh=yCt83+PIXF2ne+wjvu01vOSd2aECRZOgAq0Cc8s6RYo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IgLOoLg3ZmECJrnmXIGEMAb/TA+y6R4gt7+QX3eNbTPwSreeenNZzRw+4EqTpDSPj
	 yYOA+XSDYJs/Fm7ARefXEMsAc2+q6rqlqQyKxl+0SoJQiGDS6SiJh6bwwE6u1XXLVS
	 nGrFTkLJskzkTj1WabtGjXL0scn51cviyxIAmblg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	linux-afs@lists.infradead.org,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 016/393] afs: Fix the fallback handling for the YFS.RemoveFile2 RPC call
Date: Wed,  5 Feb 2025 14:38:55 +0100
Message-ID: <20250205134420.915956842@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250205134420.279368572@linuxfoundation.org>
References: <20250205134420.279368572@linuxfoundation.org>
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

From: David Howells <dhowells@redhat.com>

[ Upstream commit e30458d690f35abb01de8b3cbc09285deb725d00 ]

Fix a pair of bugs in the fallback handling for the YFS.RemoveFile2 RPC
call:

 (1) Fix the abort code check to also look for RXGEN_OPCODE.  The lack of
     this masks the second bug.

 (2) call->server is now not used for ordinary filesystem RPC calls that
     have an operation descriptor.  Fix to use call->op->server instead.

Fixes: e49c7b2f6de7 ("afs: Build an abstraction around an "operation" concept")
Signed-off-by: David Howells <dhowells@redhat.com>
Link: https://lore.kernel.org/r/109541.1736865963@warthog.procyon.org.uk
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/afs/yfsclient.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/afs/yfsclient.c b/fs/afs/yfsclient.c
index 11571cca86c19..01f333e691d64 100644
--- a/fs/afs/yfsclient.c
+++ b/fs/afs/yfsclient.c
@@ -655,8 +655,9 @@ static int yfs_deliver_fs_remove_file2(struct afs_call *call)
 static void yfs_done_fs_remove_file2(struct afs_call *call)
 {
 	if (call->error == -ECONNABORTED &&
-	    call->abort_code == RX_INVALID_OPERATION) {
-		set_bit(AFS_SERVER_FL_NO_RM2, &call->server->flags);
+	    (call->abort_code == RX_INVALID_OPERATION ||
+	     call->abort_code == RXGEN_OPCODE)) {
+		set_bit(AFS_SERVER_FL_NO_RM2, &call->op->server->flags);
 		call->op->flags |= AFS_OPERATION_DOWNGRADE;
 	}
 }
-- 
2.39.5




