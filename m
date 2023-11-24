Return-Path: <stable+bounces-2519-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F5AE7F8491
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 20:28:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1DA51C27E12
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C700335F1A;
	Fri, 24 Nov 2023 19:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dpFhddND"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 850372FC36;
	Fri, 24 Nov 2023 19:28:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 104BEC433C8;
	Fri, 24 Nov 2023 19:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700854084;
	bh=uFK4aF1vzOTHEIipGUSFMBrqpPN4+M/cNO4IoX/FVgM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dpFhddNDXrxisZG3gIFWxV6eglnOzjo8WYnNOuKUbJkJh8btnEK386Mahlj394bwA
	 t0MFM98leNHTeuR8qjELvxsGoYhU1MANn7GHerKRBINgdqOXD2Ti4kKm7w7qw3QoKZ
	 MnSdxcSRhMdIJr+PYR5l1AU/ZRonRyR800nRegSs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mahmoud Adam <mngyadam@amazon.com>,
	Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neilb@suse.de>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH 5.4 125/159] nfsd: fix file memleak on client_opens_release
Date: Fri, 24 Nov 2023 17:55:42 +0000
Message-ID: <20231124171947.033728353@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124171941.909624388@linuxfoundation.org>
References: <20231124171941.909624388@linuxfoundation.org>
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

From: Mahmoud Adam <mngyadam@amazon.com>

commit bc1b5acb40201a0746d68a7d7cfc141899937f4f upstream.

seq_release should be called to free the allocated seq_file

Cc: stable@vger.kernel.org # v5.3+
Signed-off-by: Mahmoud Adam <mngyadam@amazon.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Fixes: 78599c42ae3c ("nfsd4: add file to display list of client's opens")
Reviewed-by: NeilBrown <neilb@suse.de>
Tested-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/nfsd/nfs4state.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -2571,7 +2571,7 @@ static int client_opens_release(struct i
 
 	/* XXX: alternatively, we could get/drop in seq start/stop */
 	drop_client(clp);
-	return 0;
+	return seq_release(inode, file);
 }
 
 static const struct file_operations client_states_fops = {



