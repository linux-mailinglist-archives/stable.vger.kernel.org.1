Return-Path: <stable+bounces-188242-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95C2CBF34EE
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 21:59:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A93F3A80A0
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 19:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 409E62741C6;
	Mon, 20 Oct 2025 19:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="skNI6r4t"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90377D07D
	for <stable@vger.kernel.org>; Mon, 20 Oct 2025 19:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760990331; cv=none; b=GuC3dqsqFxzybeeSi8GwugE7VSZ6jOEfw1kP/po0z7jJNWCK2RZkvO3i198Fje41iZGWbKfaH/3STRyFuJ8QHcyHamUaB3FWN348WWTGwN55x+3wTsnNrrHb7n3gNAolkY60d8j3HOc12dsiFpkjob/tv0z06ZlMj5An2Jhl0Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760990331; c=relaxed/simple;
	bh=OZvzOb42xpo6joHbPbohA1f5okkRIV1Q0kUQ/PHq9aI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DF5nbhk0Ny7EYsJJDPWDhUhQJpvDGYyCkOOrZAPs3E5EuVHTKw9ruzJhuikIYIM4a9aM865LlrIIXH9NtpzU9ehm2z65wnbVlJi12ozAAOb5UTRrfZ61fquJOdBp8ANJboPdB+kH39fXj8hFyk7nBHlOfNAEiivYrmhrCglFfak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=skNI6r4t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA019C113D0;
	Mon, 20 Oct 2025 19:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760990331;
	bh=OZvzOb42xpo6joHbPbohA1f5okkRIV1Q0kUQ/PHq9aI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=skNI6r4t/EFijO9RuZvt6UuFcefQcBs1znPU5HEKWXe/bBvt7lQxBj+49vql2nbA4
	 fWIGfhEYeimJJL/npmFsCOxgZ4q+81+Odtyq4iQukC+774Uw7IfJptfbbcFxocEfqm
	 VoVOFuHnB5nH9NW4MMIsfZJtYYBuyVh6yK5HhLWEJTByoGAF+lVwJ6qqV99GVjcjEn
	 ltA1aCAFyvEEjLYta9lteEiaLRWYQY5jYUeT10vcVGvGWfzmgYQw/e/ee/tHXeJm8E
	 u1WL31JHWiZInKM4JamXAdxwJ+Pm2Sb3VVrQJLsbPHCkhtmNpzD7DjfI07ptXYXe7B
	 U/5TSxSGkxACQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Robert Morris <rtm@csail.mit.edu>,
	Thomas Haynes <loghyr@hammerspace.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.17.y 3/3] NFSD: Define a proc_layoutcommit for the FlexFiles layout type
Date: Mon, 20 Oct 2025 15:58:46 -0400
Message-ID: <20251020195846.1896208-3-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251020195846.1896208-1-sashal@kernel.org>
References: <2025102049-comic-carpentry-952e@gregkh>
 <20251020195846.1896208-1-sashal@kernel.org>
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


