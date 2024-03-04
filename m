Return-Path: <stable+bounces-26533-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B5CE870F04
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 22:50:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAE37280E9C
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 21:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 255377992E;
	Mon,  4 Mar 2024 21:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="p2vux8ZN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D768D1EB5A;
	Mon,  4 Mar 2024 21:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709589004; cv=none; b=eyIsqMdRoOCN6W+sU8M31ImAiX2x8GbxWGTupPQT77v6RFivkYAPg0398sLq7s7SsY0h6OobgEqS99VO9i3HUaNN55gWLlz1cLSWu96JRPv8CBqv/mqd/vWew9hWkEE2eFmnjVWrv3PLGBJnVOGtZtRi4OpNN3eiX4cKNuYIH4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709589004; c=relaxed/simple;
	bh=u6p3HJfnMcUChog5gOo6oFjvBF/Ap18AihaZ8ADw6nU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TJBSZ0eRls9y9nxQ6+eQaXqrbtowd3PeM+yk+bBG0X6npBXLhb167UFzEgNrjnbQMfJXn+nf02YIZOriUBJ3DrXlkVF4+vAQxUqTaf8nhhXVnKyuuviLrPJAKuXElgbStnDQtIQ+6hsKLgJ2hRclKnkJgcTs1rrvc4zwMRdPx90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=p2vux8ZN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BE1DC433C7;
	Mon,  4 Mar 2024 21:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709589004;
	bh=u6p3HJfnMcUChog5gOo6oFjvBF/Ap18AihaZ8ADw6nU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p2vux8ZN7o94WGIf2G8+LrxuCo9VjMLKboJqYIgpcHElqSqLdkgMlRVhlrqs/L1Xx
	 p0ScR1hM0P1FTTsfnl/y1gHAxyEDqHPnk5nW/mv78bcw6BUwXmZDr/+acNoopo0/lC
	 rW+kzWb/LRrbrxplk8IQ7ok7wecaZq2vUbFrqZdI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Xiu Jianfeng <xiujianfeng@huawei.com>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH 6.1 165/215] NFSD: Use struct_size() helper in alloc_session()
Date: Mon,  4 Mar 2024 21:23:48 +0000
Message-ID: <20240304211602.203711875@linuxfoundation.org>
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

From: Xiu Jianfeng <xiujianfeng@huawei.com>

[ Upstream commit 85a0d0c9a58002ef7d1bf5e3ea630f4fbd42a4f0 ]

Use struct_size() helper to simplify the code, no functional changes.

Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/nfsd/nfs4state.c |    9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -1834,13 +1834,12 @@ static struct nfsd4_session *alloc_sessi
 	int numslots = fattrs->maxreqs;
 	int slotsize = slot_bytes(fattrs);
 	struct nfsd4_session *new;
-	int mem, i;
+	int i;
 
-	BUILD_BUG_ON(NFSD_MAX_SLOTS_PER_SESSION * sizeof(struct nfsd4_slot *)
-			+ sizeof(struct nfsd4_session) > PAGE_SIZE);
-	mem = numslots * sizeof(struct nfsd4_slot *);
+	BUILD_BUG_ON(struct_size(new, se_slots, NFSD_MAX_SLOTS_PER_SESSION)
+		     > PAGE_SIZE);
 
-	new = kzalloc(sizeof(*new) + mem, GFP_KERNEL);
+	new = kzalloc(struct_size(new, se_slots, numslots), GFP_KERNEL);
 	if (!new)
 		return NULL;
 	/* allocate each struct nfsd4_slot and data cache in one piece */



