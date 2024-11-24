Return-Path: <stable+bounces-94969-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FF609D7573
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 16:42:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0BE1B46D91
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 13:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 985021E2605;
	Sun, 24 Nov 2024 13:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YosMuW1l"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 537611E231F;
	Sun, 24 Nov 2024 13:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732455449; cv=none; b=cI1vCsfS2/pAwB1RHeCdd59w+2QJcQsHVPiUZ+Fv//aFOshpzTH3TnQQJKVOgndz7psXLcE/cNLmkIcyqNwbcnuLEy/T9Ca19/vt8m7h9g7Y0eQMMacZ/6OiAruJwl5AgT+DmYbHEVO379Y0JnraIzKgjwE+1/LSDigSYvIEPZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732455449; c=relaxed/simple;
	bh=BO6XiJPNfT8ipKf07nKW33xa4VrXBD/jl7rU5wBBQJI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R3MvNTkNF7Y/AyjW/535eRYUVeEBhndcCbjfnH72rvp3vnMSaOTA1I9ODH2RW+hb7X5r8gbIq9/qWFX/EmQvcTzetdMA8jBcInrHW0b4Ygtxlql6QzxdPi5pS76Sb0UzoyuKH0EXaT6ObP61lkyeAEztB0c74dREp8DSsfv4C60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YosMuW1l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66C8BC4CECC;
	Sun, 24 Nov 2024 13:37:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732455447;
	bh=BO6XiJPNfT8ipKf07nKW33xa4VrXBD/jl7rU5wBBQJI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YosMuW1l+/wUcnpNUUG/LQzRyizMKb2eM7UjhK8kBnDSAZ++iAByFrstNTt7NpJF5
	 Xcpx7UJOEKGluxzh6mwuIraXyrU6qgbJXF1dJRS5eK4XUl6cMgPu+ypExK0GKDuz/Z
	 K36G25Dq4BmLE7z5l8eA52oFmMXhZN6XGZNMSdNAZ+p8xHk1B4C+tF23/xOxktO7Tb
	 suTSXPbw18BEsa1u41yeOl5SC2ZEtteHr/6fG1PsUceDevk0sUoTeGa6OXggIgQeJB
	 PdhM2Tpx39E1TZNqw8BMBAXoLJA0IBfu2tY78m3Th543thhej6j3mLdhSCu6k6eO9r
	 fM51OVkwAdvzw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Nihar Chaithanya <niharchaithanya@gmail.com>,
	syzbot+412dea214d8baa3f7483@syzkaller.appspotmail.com,
	Dave Kleikamp <dave.kleikamp@oracle.com>,
	Sasha Levin <sashal@kernel.org>,
	shaggy@kernel.org,
	rbrasga@uci.edu,
	aha310510@gmail.com,
	eadavis@qq.com,
	peili.dev@gmail.com,
	ghanshyam1898@gmail.com,
	jfs-discussion@lists.sourceforge.net
Subject: [PATCH AUTOSEL 6.12 073/107] jfs: add a check to prevent array-index-out-of-bounds in dbAdjTree
Date: Sun, 24 Nov 2024 08:29:33 -0500
Message-ID: <20241124133301.3341829-73-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124133301.3341829-1-sashal@kernel.org>
References: <20241124133301.3341829-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.1
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


