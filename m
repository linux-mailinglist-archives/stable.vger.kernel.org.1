Return-Path: <stable+bounces-13677-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5652C837D5F
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 02:25:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88CCB1C283BB
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 01:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AE9F5731D;
	Tue, 23 Jan 2024 00:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uF7gz5pV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF4B52F7C;
	Tue, 23 Jan 2024 00:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705969911; cv=none; b=izELV0DArMDErI/wuDR2SaYSYp1ipdjFijfGwz7HANdhSyyFWPFsen9AbFayqTfNSVM91stCnfmjIZr0TQojnUF5T/UdupK9VOaKmvIQe4PzCtT5SF1ditsGDepNQM7NhhjlBclf+Y+bPvtodyfu1ETh+VPkGDpfCeIY+tuHFO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705969911; c=relaxed/simple;
	bh=hhN7vgVbCdZWrtbZ8yY/7xcW9CRuOhmEvpg/NDK84+g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I2xtTAjqbr5GgPUHZJ9faygRN5SngMGknw/VjBJYQ/jvGZCh45gO851Wb8XijKXkfJ6sl1XD/PnoCQjovBQObegpJrB4hhhhSWh1FRrFI+9SfDkx3zFnd/OZ+6+cyjSQSr55SVWNDQ8NUy9E7qMeFJDT8tTNl86Qn7S8ENpmDeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uF7gz5pV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96305C433C7;
	Tue, 23 Jan 2024 00:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705969911;
	bh=hhN7vgVbCdZWrtbZ8yY/7xcW9CRuOhmEvpg/NDK84+g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uF7gz5pVp8CmaEoKx0phV4822BIb79qCnf46dwNdcuz3gn4kGIvXmi9ntQGBqSthb
	 efzBo44yLISZuJGTJNNqfZluHoh+8EVrM7+wOpTU1knkoMsS456b7lxhZiq0LtFAVv
	 5N9oVJ594N6PFju4NXJcnYicR8d/cGJKKKat/xls=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Gregory Price <gregory.price@memverge.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 520/641] base/node.c: initialize the accessor list before registering
Date: Mon, 22 Jan 2024 15:57:04 -0800
Message-ID: <20240122235834.366536743@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122235818.091081209@linuxfoundation.org>
References: <20240122235818.091081209@linuxfoundation.org>
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

6.7-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gregory Price <gourry.memverge@gmail.com>

[ Upstream commit 48b5928e18dc27e05cab3dc4c78cd8a15baaf1e5 ]

The current code registers the node as available in the node array
before initializing the accessor list.  This makes it so that
anything which might access the accessor list as a result of
allocations will cause an undefined memory access.

In one example, an extension to access hmat data during interleave
caused this undefined access as a result of a bulk allocation
that occurs during node initialization but before the accessor
list is initialized.

Initialize the accessor list before making the node generally
available to the global system.

Fixes: 08d9dbe72b1f ("node: Link memory nodes to their compute nodes")
Signed-off-by: Gregory Price <gregory.price@memverge.com>
Link: https://lore.kernel.org/r/20231030044239.971756-1-gregory.price@memverge.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/base/node.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/base/node.c b/drivers/base/node.c
index 493d533f8375..4d588f4658c8 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -868,11 +868,15 @@ int __register_one_node(int nid)
 {
 	int error;
 	int cpu;
+	struct node *node;
 
-	node_devices[nid] = kzalloc(sizeof(struct node), GFP_KERNEL);
-	if (!node_devices[nid])
+	node = kzalloc(sizeof(struct node), GFP_KERNEL);
+	if (!node)
 		return -ENOMEM;
 
+	INIT_LIST_HEAD(&node->access_list);
+	node_devices[nid] = node;
+
 	error = register_node(node_devices[nid], nid);
 
 	/* link cpu under this node */
@@ -881,7 +885,6 @@ int __register_one_node(int nid)
 			register_cpu_under_node(cpu, nid);
 	}
 
-	INIT_LIST_HEAD(&node_devices[nid]->access_list);
 	node_init_caches(nid);
 
 	return error;
-- 
2.43.0




