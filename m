Return-Path: <stable+bounces-95225-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D9929D7458
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 16:06:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D72F165C39
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 15:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A251723EABE;
	Sun, 24 Nov 2024 13:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ekejzFzG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D26723EAAA;
	Sun, 24 Nov 2024 13:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732456397; cv=none; b=Iprw5UWWFHEr1x+r+jDc+gXFHpTk5eRwFjW6FGnhz20P5Tp2K80rA/8sF1cUFCjhmeUTuRJjhRr2EEitQJt8P7Dhb2ntChqB00VlrXAGaxepFo7RqReRCxo/tEruQ3WjFw1LtcxurwbXsvcbVnWj+JZy8lCapqb//HrEUmDoOoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732456397; c=relaxed/simple;
	bh=wU1lV5x1DqABeBkIN760bwN7A+8t7vaaiSCLMST9W48=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aLlZDYw2xnFhrl1PzZZ2fCy2WbFXuaj9KtpQQg7hv37OqGccOdYRev3pMKHckBVhDFIROczV029t83b9dhGk28E3A1N4W82ff0MYGAL3L8NoxVNGqVNaM+M2tM/R3Duc3IVu9tFYVTkA9gmqqItsVYGC8sK8NQgMMrOBHZ6JBV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ekejzFzG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9100C4CECC;
	Sun, 24 Nov 2024 13:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732456397;
	bh=wU1lV5x1DqABeBkIN760bwN7A+8t7vaaiSCLMST9W48=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ekejzFzGBwWxFZSPnVzPn+CuNWBlCZ7Vcx1pMdEEXlAv71PYlElhGoNN4i7HCcEHr
	 OtW3xrslDRxvk4MwyDuwG9zKwCDjhP2hWWycP7qm7+E5tiVc9mf0U3G8nayM1H2DVw
	 6tJHHZD5nQBzU5MITQQ5pM2AHmopVS2DFboEunC21TjbBvplT9VqLetqx/BqERB1k+
	 51UV72bX3dfmmUBeo2e3a6xqbkWcJ75Mb6OROJ2uQYgDIB3b1B3MZXyGNMA4VfPG9Y
	 uXzhGGAjqAcn+yT2CXJvFM6oecR+lQm313hb/quhyto1zOuwCJsaQVDkYVuduvYRWI
	 iYdWbN6A0Msrg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Nihar Chaithanya <niharchaithanya@gmail.com>,
	syzbot+412dea214d8baa3f7483@syzkaller.appspotmail.com,
	Dave Kleikamp <dave.kleikamp@oracle.com>,
	Sasha Levin <sashal@kernel.org>,
	shaggy@kernel.org,
	peili.dev@gmail.com,
	rbrasga@uci.edu,
	aha310510@gmail.com,
	ghanshyam1898@gmail.com,
	eadavis@qq.com,
	jfs-discussion@lists.sourceforge.net
Subject: [PATCH AUTOSEL 5.15 26/36] jfs: add a check to prevent array-index-out-of-bounds in dbAdjTree
Date: Sun, 24 Nov 2024 08:51:40 -0500
Message-ID: <20241124135219.3349183-26-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124135219.3349183-1-sashal@kernel.org>
References: <20241124135219.3349183-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.173
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
index 7486c79a5058b..e6cbe4c982c58 100644
--- a/fs/jfs/jfs_dmap.c
+++ b/fs/jfs/jfs_dmap.c
@@ -2957,6 +2957,9 @@ static void dbAdjTree(dmtree_t *tp, int leafno, int newval, bool is_ctl)
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


