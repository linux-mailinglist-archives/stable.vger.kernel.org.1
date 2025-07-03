Return-Path: <stable+bounces-160009-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AD70AF7BE7
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 17:29:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF1F81CC13BF
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 15:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FE652F0C65;
	Thu,  3 Jul 2025 15:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IzBWcaRn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25FB2EFD8B;
	Thu,  3 Jul 2025 15:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751556077; cv=none; b=axwC4BUL/WkPAP4SrunfcxZFrZOTv+bdtlRXH+hvD83fW4gCB4ceiaSgK+p1LxWarrFueo6aSdGE352wVgthW1S2Es6IopydZn2Og4BX1EUvukhdXUtXL9B3dDEQH1HRgh2WFV3O8mMjU6a9efzrY1tTK4AoGr32YoaKUkS+jSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751556077; c=relaxed/simple;
	bh=8vqwsErNCD8HcTa4Gj0/ilWsOvaLRTlPfNIx4LrJzxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=II7ATJGL8SwDhNZp+DaoJdAC9YFHRkvAngP8Orn5E6r4CWubYjA8Youu3xcY5moPNxGCMBI2WoXw7Xswj7CgJUAd9Ie2iLwwMvy+kFq4JZH3dsHVjxcAk6t3haWjPlPq4oMWmQi36vcSvzFr0Up+63RBHe7Ol04lh99NLgPH9sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IzBWcaRn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4245EC4CEE3;
	Thu,  3 Jul 2025 15:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751556077;
	bh=8vqwsErNCD8HcTa4Gj0/ilWsOvaLRTlPfNIx4LrJzxE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IzBWcaRn4moHYrZnIL8Xd6A6aSo+x3Ti+IsdfBjaLfBKWsf33gCjpXfvXIq4BOofJ
	 PvXpsc86ODAgvXGKbbcrNZamcm5eY+I7slWDhQQNvp26c4Lqeou/RHnce+5Id60oAe
	 aH/uBP1n3FVzEvwrH7rwwKlSgBySLytop+Tdc1XM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Long Li <longli@microsoft.com>,
	Michael Kelley <mhklinux@outlook.com>,
	Wei Liu <wei.liu@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 060/132] uio_hv_generic: Align ring size to system page
Date: Thu,  3 Jul 2025 16:42:29 +0200
Message-ID: <20250703143941.773341427@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250703143939.370927276@linuxfoundation.org>
References: <20250703143939.370927276@linuxfoundation.org>
User-Agent: quilt/0.68
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

From: Long Li <longli@microsoft.com>

[ Upstream commit 0315fef2aff9f251ddef8a4b53db9187429c3553 ]

Following the ring header, the ring data should align to system page
boundary. Adjust the size if necessary.

Cc: stable@vger.kernel.org
Fixes: 95096f2fbd10 ("uio-hv-generic: new userspace i/o driver for VMBus")
Signed-off-by: Long Li <longli@microsoft.com>
Reviewed-by: Michael Kelley <mhklinux@outlook.com>
Link: https://lore.kernel.org/r/1746492997-4599-4-git-send-email-longli@linuxonhyperv.com
Signed-off-by: Wei Liu <wei.liu@kernel.org>
Message-ID: <1746492997-4599-4-git-send-email-longli@linuxonhyperv.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/uio/uio_hv_generic.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/uio/uio_hv_generic.c b/drivers/uio/uio_hv_generic.c
index 8cb724095be6d..2cfe0087abc19 100644
--- a/drivers/uio/uio_hv_generic.c
+++ b/drivers/uio/uio_hv_generic.c
@@ -260,6 +260,9 @@ hv_uio_probe(struct hv_device *dev,
 	if (!ring_size)
 		ring_size = HV_RING_SIZE * PAGE_SIZE;
 
+	/* Adjust ring size if necessary to have it page aligned */
+	ring_size = VMBUS_RING_SIZE(ring_size);
+
 	pdata = devm_kzalloc(&dev->device, sizeof(*pdata), GFP_KERNEL);
 	if (!pdata)
 		return -ENOMEM;
-- 
2.39.5




