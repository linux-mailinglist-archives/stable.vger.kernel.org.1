Return-Path: <stable+bounces-11157-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0FDA82E5D8
	for <lists+stable@lfdr.de>; Tue, 16 Jan 2024 01:56:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A6B21C2248B
	for <lists+stable@lfdr.de>; Tue, 16 Jan 2024 00:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FD743D3A5;
	Tue, 16 Jan 2024 00:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZmjExgQB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3578A3D0CA;
	Tue, 16 Jan 2024 00:25:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E26D9C433C7;
	Tue, 16 Jan 2024 00:25:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705364742;
	bh=JFQbJFMvGhf8e9rSpxhY9AEA9zlgddvr471jGSTbkx8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZmjExgQBJKHWyNGycmlf6/vLtEvWboEERW5nsABT1fRM0NTRLCsa4V5NbeDpge8/N
	 H2+9uzDJOB4CMuj1kfRAAd0VN41IaqzGa4icSqJ+glYzzoK51Yu4zoApGK0hR6hPKE
	 MFEc11zl1sr5X9oy/648GwD17uhi/9xBbp0Uu4NCU5RCtdbhtMVf8L5Ip1b7du9UDa
	 3OqJQo1Ah9EWM4PpPn6GFI6wvkmD2HSNdXnV+XL6wVQPuiFpAlfG7SjaFkrSsyLd5V
	 kXk+H7DlKrFUOjAUFzGoD+mPRC4yO5OSQrPKJTsXIgdI3Eyb3wh4SN/+w22mYXTWUD
	 4/KLBVEUPbVcA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Oleg Nesterov <oleg@redhat.com>,
	David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	linux-afs@lists.infradead.org,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 6.1 11/14] afs: fix the usage of read_seqbegin_or_lock() in afs_lookup_volume_rcu()
Date: Mon, 15 Jan 2024 19:24:53 -0500
Message-ID: <20240116002512.215607-11-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116002512.215607-1-sashal@kernel.org>
References: <20240116002512.215607-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.73
Content-Transfer-Encoding: 8bit

From: Oleg Nesterov <oleg@redhat.com>

[ Upstream commit 4121b4337146b64560d1e46ebec77196d9287802 ]

David Howells says:

 (2) afs_lookup_volume_rcu().

     There can be a lot of volumes known by a system.  A thousand would
     require a 10-step walk and this is drivable by remote operation, so I
     think this should probably take a lock on the second pass too.

Make the "seq" counter odd on the 2nd pass, otherwise read_seqbegin_or_lock()
never takes the lock.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
Link: https://lore.kernel.org/r/20231130115606.GA21571@redhat.com/
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/afs/callback.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/afs/callback.c b/fs/afs/callback.c
index a484fa642808..90f9b2a46ff4 100644
--- a/fs/afs/callback.c
+++ b/fs/afs/callback.c
@@ -110,13 +110,14 @@ static struct afs_volume *afs_lookup_volume_rcu(struct afs_cell *cell,
 {
 	struct afs_volume *volume = NULL;
 	struct rb_node *p;
-	int seq = 0;
+	int seq = 1;
 
 	do {
 		/* Unfortunately, rbtree walking doesn't give reliable results
 		 * under just the RCU read lock, so we have to check for
 		 * changes.
 		 */
+		seq++; /* 2 on the 1st/lockless path, otherwise odd */
 		read_seqbegin_or_lock(&cell->volume_lock, &seq);
 
 		p = rcu_dereference_raw(cell->volumes.rb_node);
-- 
2.43.0


