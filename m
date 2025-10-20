Return-Path: <stable+bounces-188247-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2848EBF375D
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 22:33:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CB3818A66AC
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 20:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EAA92DF123;
	Mon, 20 Oct 2025 20:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S7btIAJ6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D2EC28489B
	for <stable@vger.kernel.org>; Mon, 20 Oct 2025 20:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760992430; cv=none; b=rJb6t4K3Cx7qG8bYL3v4YO8GydbIxIjLPwe1DrhA6YghZ01JQvQdcxd8lVUTlmasY9KIZg3gsdq20MWYcKYpdS9q+Uihy86kRcV2Y7kbvMSRSD8ukgmICh6wkWKV9TCUrBqnoLwVSEA6SRMxC3zTTnj+VMwPaebuzXVM74dibiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760992430; c=relaxed/simple;
	bh=OZvzOb42xpo6joHbPbohA1f5okkRIV1Q0kUQ/PHq9aI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t6JvGxw1J/NHgSuZ3ikYSqR7q5CB8LFP138fWRD+Z7gQD0kLqfyPkcNk2yZ/2vRmD2HwJYA9/UySo3qGFafYxPZ1J1DquSGC9gM4Kieb+fGebFsLk1bflRrRJlqBexIa0/29i+VhggY+fPvFjrEerh+0gXl04RF+73MafqtBNCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S7btIAJ6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26125C19421;
	Mon, 20 Oct 2025 20:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760992429;
	bh=OZvzOb42xpo6joHbPbohA1f5okkRIV1Q0kUQ/PHq9aI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S7btIAJ6sBfz7X+WAk8nNG9cE9Da97ARgXhciNBQUyDUi0kKTecwrwVaXDC4TbRXz
	 G+QfaQAxJHlp7AOqemMExO6zt2eyVjjblxIi0iKmP/V3nTxj3ohIZBW+1NbN2tB6sX
	 JtZWVLhGShZUCYS9SEHR2Q7eljSi1cfCurou6remEKG8KdqXkNfUGddu66lyGAiLuf
	 V//sx4dX4TH3kk5utsGUgGvYZkWP2gMzvncESLnIjERXScHGcRBNSEx+ED68Hd51Vm
	 436hRsUCcc5RCdAS0mUnc6yNkVdkruZGk1NfWwRjKVmhBU0ZikjqeHTOxLeWgKGkUQ
	 njk4d+7SR9Vwg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Robert Morris <rtm@csail.mit.edu>,
	Thomas Haynes <loghyr@hammerspace.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 5/5] NFSD: Define a proc_layoutcommit for the FlexFiles layout type
Date: Mon, 20 Oct 2025 16:33:43 -0400
Message-ID: <20251020203343.1907954-5-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251020203343.1907954-1-sashal@kernel.org>
References: <2025102008-childlike-sneezing-5892@gregkh>
 <20251020203343.1907954-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

[ Upstream commit 4b47a8601b71ad98833b447d465592d847b4dc77 ]

Avoid a crash if a pNFS client should happen to send a LAYOUTCOMMIT
operation on a FlexFiles layout.

Reported-by: Robert Morris <rtm@csail.mit.edu>
Closes: https://lore.kernel.org/linux-nfs/152f99b2-ba35-4dec-93a9-4690e625dccd@oracle.com/T/#t
Cc: Thomas Haynes <loghyr@hammerspace.com>
Cc: stable@vger.kernel.org
Fixes: 9b9960a0ca47 ("nfsd: Add a super simple flex file server")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/flexfilelayout.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/nfsd/flexfilelayout.c b/fs/nfsd/flexfilelayout.c
index 3ca5304440ff0..3c4419da5e24c 100644
--- a/fs/nfsd/flexfilelayout.c
+++ b/fs/nfsd/flexfilelayout.c
@@ -125,6 +125,13 @@ nfsd4_ff_proc_getdeviceinfo(struct super_block *sb, struct svc_rqst *rqstp,
 	return 0;
 }
 
+static __be32
+nfsd4_ff_proc_layoutcommit(struct inode *inode, struct svc_rqst *rqstp,
+		struct nfsd4_layoutcommit *lcp)
+{
+	return nfs_ok;
+}
+
 const struct nfsd4_layout_ops ff_layout_ops = {
 	.notify_types		=
 			NOTIFY_DEVICEID4_DELETE | NOTIFY_DEVICEID4_CHANGE,
@@ -133,4 +140,5 @@ const struct nfsd4_layout_ops ff_layout_ops = {
 	.encode_getdeviceinfo	= nfsd4_ff_encode_getdeviceinfo,
 	.proc_layoutget		= nfsd4_ff_proc_layoutget,
 	.encode_layoutget	= nfsd4_ff_encode_layoutget,
+	.proc_layoutcommit	= nfsd4_ff_proc_layoutcommit,
 };
-- 
2.51.0


