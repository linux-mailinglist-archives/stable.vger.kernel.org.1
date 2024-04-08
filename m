Return-Path: <stable+bounces-37567-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15F7589C57A
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 15:58:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C44722844F9
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 13:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 448397CF17;
	Mon,  8 Apr 2024 13:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bJaBizq5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02FBD7BB17;
	Mon,  8 Apr 2024 13:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712584612; cv=none; b=khZWuL4gmiqo6GbLVVviWwWmid57QREclEZdMbFwf/qQBiiBsl+muf6vVZFKedPxmSadnPxEhAoBDyklpHkg+I9GWt20ZgKbx/h7k87wCGtgzyF9d9LU1uSZ4+F+eitZf0sAdyusFeN7eUP30XMsQEJSXh28AaByQ1ELFpd3pU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712584612; c=relaxed/simple;
	bh=S+Gre6jP/FKNvB+hey9Jq8Ri5r58DcGwZwe32mT6aOE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZYivqY+o7oSJGWgFAEhqIdhWnXz99YqrjQYFRts/oyeEzATifanAlPMouQjrDo3qb1AhMnVuU/JMC0q3TcUeeAwtPVpRfCLPuOP/QrmAcClVS5MjncwkOKPPUqE77eGIjMwnQCuYV6tl5V4wwQu3ycOobs1KhajHrW3l+9p0q9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bJaBizq5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E721C433C7;
	Mon,  8 Apr 2024 13:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712584611;
	bh=S+Gre6jP/FKNvB+hey9Jq8Ri5r58DcGwZwe32mT6aOE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bJaBizq5+0/Ii5eY0IxneZy6ZRgRgProGJF4rtpAnGpidZE3j79Uke3Iz/IEPV2MI
	 8QfFmRcVtpCswWbZ/ZNZGeDMR29BT2a9UPXfutjEEOCJOn1eA/pZMtP2VMpw+I0YWJ
	 OBRnsBiAZ+Gxq9Hs/pFgrOV8RaAw4eIQbeL2uXPQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Xiu Jianfeng <xiujianfeng@huawei.com>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH 5.15 498/690] NFSD: Use struct_size() helper in alloc_session()
Date: Mon,  8 Apr 2024 14:56:04 +0200
Message-ID: <20240408125417.683753705@linuxfoundation.org>
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

From: Xiu Jianfeng <xiujianfeng@huawei.com>

[ Upstream commit 85a0d0c9a58002ef7d1bf5e3ea630f4fbd42a4f0 ]

Use struct_size() helper to simplify the code, no functional changes.

Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4state.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 39b315e3471f5..524865c7211ef 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -1833,13 +1833,12 @@ static struct nfsd4_session *alloc_session(struct nfsd4_channel_attrs *fattrs,
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
-- 
2.43.0




