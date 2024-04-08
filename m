Return-Path: <stable+bounces-37276-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C5E989C42B
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 15:47:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEC0F282610
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 13:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96E2F85659;
	Mon,  8 Apr 2024 13:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XxkSOBoW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D272DF73;
	Mon,  8 Apr 2024 13:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712583763; cv=none; b=lbxlBt6ie1aryFKF51MCDwDLT4Mt/RjYzDUcc9JDxvZE6YbpsWGLLanwYURv6i97fKrfpki53Qv9DbxgHFItahsXC5BR+EHcHuY5oSZI3Ug8XVeXefU1WkYGGWqQP4WXUsPFG6qKvrtxl9b63EePhStZaoDfZV7kvSteDRINVjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712583763; c=relaxed/simple;
	bh=fzwbhfsKYp/oOERJ8VN442ewgT+cLGYI+DLh7Gw2bbc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QIkvPUSknFvm98QeMrXLIgyCv4eOvVw2g0rgCg3ox/OjSesl2jm0u+KfTobdFYxhoyI0QRPhl33mziMvi/tljyjJcsd25lR75nAAE4GOBZvaF3gLonfG8JI37O3Z4FDLlmDJRptz9F0wLLvnZOhJogkiYEJyETDXwG308yh3UsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XxkSOBoW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D21A6C433C7;
	Mon,  8 Apr 2024 13:42:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712583763;
	bh=fzwbhfsKYp/oOERJ8VN442ewgT+cLGYI+DLh7Gw2bbc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XxkSOBoWevBpOITNGkih3ulgFz09B4qHzewFLIcgZQAuqCBYMJy3iUb5859yotynC
	 wO+x70c0xjn+OvKWGTDuvmL4A4n8Tp/qc6fla8l+OtFPNGjx2/+LU/QAdn8l9WvZOm
	 2hJHxkQ0+2dMjQx6pMw2mI43DxUuxuPGjyeqETHE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jakob Koschel <jakobkoschel@gmail.com>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH 5.15 282/690] nfsd: fix using the correct variable for sizeof()
Date: Mon,  8 Apr 2024 14:52:28 +0200
Message-ID: <20240408125409.826782911@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240408125359.506372836@linuxfoundation.org>
References: <20240408125359.506372836@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jakob Koschel <jakobkoschel@gmail.com>

[ Upstream commit 4fc5f5346592cdc91689455d83885b0af65d71b8 ]

While the original code is valid, it is not the obvious choice for the
sizeof() call and in preparation to limit the scope of the list iterator
variable the sizeof should be changed to the size of the destination.

Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4layouts.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4layouts.c b/fs/nfsd/nfs4layouts.c
index 2673019d30ecd..7018d209b784a 100644
--- a/fs/nfsd/nfs4layouts.c
+++ b/fs/nfsd/nfs4layouts.c
@@ -421,7 +421,7 @@ nfsd4_insert_layout(struct nfsd4_layoutget *lgp, struct nfs4_layout_stateid *ls)
 	new = kmem_cache_alloc(nfs4_layout_cache, GFP_KERNEL);
 	if (!new)
 		return nfserr_jukebox;
-	memcpy(&new->lo_seg, seg, sizeof(lp->lo_seg));
+	memcpy(&new->lo_seg, seg, sizeof(new->lo_seg));
 	new->lo_state = ls;
 
 	spin_lock(&fp->fi_lock);
-- 
2.43.0




