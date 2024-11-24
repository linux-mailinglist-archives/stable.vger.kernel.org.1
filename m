Return-Path: <stable+bounces-95287-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B7819D75F2
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 17:33:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40343B871D8
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 15:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B8F31E885F;
	Sun, 24 Nov 2024 13:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ECmpOnbf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B00249AF2;
	Sun, 24 Nov 2024 13:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732456590; cv=none; b=eQU53ejUXJkWDcp9RX+xO6h/8HpPzxm7ohishApTT7D1A8p9Ts4PEoMpWv8TcrvCefkFS9Rfm1jj9yXtEfmKu2RTL8i3wqIMr00VTsG0AkmsKPtCVOWoGong2+1A5Xhvea9GbbBo9ZFLas8wv+zvHtAeIoD0Usaw/DHlBSwY3Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732456590; c=relaxed/simple;
	bh=ZuN+1o3M97Mf3AbJMBHAkBqRzj9qrqO4emPidvwWQcE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ig6zxGCbm+clZa2D5YKWCFi5Sr3ONGWEuP8TOroylXgfZ3QKLwvNXMwKhmAXW0sES6eYHSrjnAA83KXATjbsBjEc2tDYllJyjaA8VcheDlH3Ic0ZTMSSGWKw9Z8g/zjtbVbfWfebk87jo7QFG1GIO/7omn7Vb83fVdkCCA0vdTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ECmpOnbf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5694C4CECC;
	Sun, 24 Nov 2024 13:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732456590;
	bh=ZuN+1o3M97Mf3AbJMBHAkBqRzj9qrqO4emPidvwWQcE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ECmpOnbf7W+OjsEjMarrA1ISz7DeO3TCGtajyeb0GDvEMkKXhgs34d5kkqbTWrz5s
	 dPzPDyF7fx9H9CAooHxqF6i8sPiOol3lGTOxE5vDGA9fh0QlVhj4aN+bQpVktsLDVk
	 ELuDRuGrX6TR6RZtiiFRXgtlEyJE8uKbbULFugS829xiwgN6op9JvpJZKNVl8B0ryL
	 L+7OyfwPlsiE9st7HZ4hGa2Z16H5IEi38QVe3QDzopOMcW7Gf6tIzEz/exI0Qwv1dT
	 LhevrIwuRWVBs588uktA7HVRpt7y2ALRxNnKVYw4OI3nOVMtvfaoGFBSbSOYlvj4/2
	 D6cqcv9sc5ehA==
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
	ghanshyam1898@gmail.com,
	rbrasga@uci.edu,
	jfs-discussion@lists.sourceforge.net
Subject: [PATCH AUTOSEL 5.4 19/28] jfs: add a check to prevent array-index-out-of-bounds in dbAdjTree
Date: Sun, 24 Nov 2024 08:55:19 -0500
Message-ID: <20241124135549.3350700-19-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124135549.3350700-1-sashal@kernel.org>
References: <20241124135549.3350700-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.286
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
index d83ac5f5888a4..812945c8e3840 100644
--- a/fs/jfs/jfs_dmap.c
+++ b/fs/jfs/jfs_dmap.c
@@ -2953,6 +2953,9 @@ static void dbAdjTree(dmtree_t *tp, int leafno, int newval, bool is_ctl)
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


