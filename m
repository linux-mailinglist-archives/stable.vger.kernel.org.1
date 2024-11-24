Return-Path: <stable+bounces-95131-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C6EA9D738E
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 15:42:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC57F1667C7
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 14:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42C871F6834;
	Sun, 24 Nov 2024 13:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D9Wfa0us"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0167B1F682F;
	Sun, 24 Nov 2024 13:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732456100; cv=none; b=cM+Y/SiFeP0xzlzMUwgCoG3hTz0i/cEGV0iDyc1Vm7V5IF5bapOWx7P7L1/pmSsoOXZeONmM0lrfXBfMGcgvEvoJ9QAtPdQBibajJVXSG9PpiE1B692D/T+ZQuqxVPbp3CWHJx67Zlz2amfo/dmSODPGCfD4JXbPTh1KknqDuMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732456100; c=relaxed/simple;
	bh=BO6XiJPNfT8ipKf07nKW33xa4VrXBD/jl7rU5wBBQJI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hEBafTMflx3/QsNQIZ5K76diJ3cq1UBO7jv+QZrrPtGIMnwouHaBLc5UU0Ql+I0Q4mfuSeE1ZsFBZcLu481jCCfQeuTT8w/WU5seTnmlGofPiOEBuwgKPHvaXb30dxMYSGdiya0fVM1uo+wHKVfMHUchDc/gDyHvGE6LVUImG1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D9Wfa0us; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78241C4CED3;
	Sun, 24 Nov 2024 13:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732456099;
	bh=BO6XiJPNfT8ipKf07nKW33xa4VrXBD/jl7rU5wBBQJI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D9Wfa0usv0Yp0N2DAjttH1PBzAbuDN8d1NqicoUt9IWit2lD6l+kjLoEhnbtLECgp
	 xKgTl5PmrUohAlIAGTw5uNQgIpXYaWgYYle+iQC861rTqOT3qG1jLC+cOUI1k7ejtA
	 5+SOWDm36oRNPU06X3VzVhrXHtRyqNzT9OcMEbaVM/ez2NM/7jR+KW1/+tqbqQGBwU
	 uvwfoPpnw8iftyoayMJzxT5sdw7Y5Gj0HZKzWSyk667EsGrVMhflDFcJm2GKzdeK2m
	 EWc/FIXaI+kNYX3z8hEXf04eGG7xN8IgQ7H13vpHBNSV9lw2zMioy3jwc/UX5bL5tc
	 AnNBfLP3vlJjA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Nihar Chaithanya <niharchaithanya@gmail.com>,
	syzbot+412dea214d8baa3f7483@syzkaller.appspotmail.com,
	Dave Kleikamp <dave.kleikamp@oracle.com>,
	Sasha Levin <sashal@kernel.org>,
	shaggy@kernel.org,
	eadavis@qq.com,
	aha310510@gmail.com,
	peili.dev@gmail.com,
	rbrasga@uci.edu,
	ghanshyam1898@gmail.com,
	jfs-discussion@lists.sourceforge.net
Subject: [PATCH AUTOSEL 6.6 41/61] jfs: add a check to prevent array-index-out-of-bounds in dbAdjTree
Date: Sun, 24 Nov 2024 08:45:16 -0500
Message-ID: <20241124134637.3346391-41-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124134637.3346391-1-sashal@kernel.org>
References: <20241124134637.3346391-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.63
Content-Transfer-Encoding: 8bit

From: Nihar Chaithanya <niharchaithanya@gmail.com>

[ Upstream commit a174706ba4dad895c40b1d2277bade16dfacdcd9 ]

When the value of lp is 0 at the beginning of the for loop, it will
become negative in the next assignment and we should bail out.

Reported-by: syzbot+412dea214d8baa3f7483@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=412dea214d8baa3f7483
Tested-by: syzbot+412dea214d8baa3f7483@syzkaller.appspotmail.com
Signed-off-by: Nihar Chaithanya <niharchaithanya@gmail.com>
Signed-off-by: Dave Kleikamp <dave.kleikamp@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/jfs/jfs_dmap.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/jfs/jfs_dmap.c b/fs/jfs/jfs_dmap.c
index 39957361a7eed..f9009e4f9ffd8 100644
--- a/fs/jfs/jfs_dmap.c
+++ b/fs/jfs/jfs_dmap.c
@@ -2891,6 +2891,9 @@ static void dbAdjTree(dmtree_t *tp, int leafno, int newval, bool is_ctl)
 	/* bubble the new value up the tree as required.
 	 */
 	for (k = 0; k < le32_to_cpu(tp->dmt_height); k++) {
+		if (lp == 0)
+			break;
+
 		/* get the index of the first leaf of the 4 leaf
 		 * group containing the specified leaf (leafno).
 		 */
-- 
2.43.0


