Return-Path: <stable+bounces-203805-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E701CE76A2
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 17:23:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 91AB83031A2C
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 16:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A36A3314C0;
	Mon, 29 Dec 2025 16:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VRRJ774G"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D697F33121F;
	Mon, 29 Dec 2025 16:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767025216; cv=none; b=mrl1KLbJiZZ97YWVlfPe/l0+L7O4LvCeaz9n7A42GOjjXOTeCWxp5y8TZ9ItkXHu47KW1ya6oY0CGnjzO3Z2a0SRWekpCkyPzA8WePVy8vPHLRVvoS/KXBZJQpxe+4OwQx6+Z0e8rflg2d3qvvq78Hc/Z/ntf2JmHySkC4NqnZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767025216; c=relaxed/simple;
	bh=XYjc1y4mLK/cwPfjV2IY7jneKJ9Dtb6TapaixMrkpoc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HTvcnCogDTGv0loOzyG244L/lFvOFmC1cbnU6VcZraO0S8xLc7BD076xwKxU1SUE1bWUcZeopH0esZIy5SGe6dytzYnvV0Nba4g2Q8UqN6ZxTlzmWbrGWmPGFmVQXHNZL8jeNvDjuuwb6GiiYO4edFPS2K52cTBL1o+rzX0+JjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VRRJ774G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62D45C4CEF7;
	Mon, 29 Dec 2025 16:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767025216;
	bh=XYjc1y4mLK/cwPfjV2IY7jneKJ9Dtb6TapaixMrkpoc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VRRJ774GEx/04kjRLrLaYL4Y4aY54HD9evOyRDZ/J13bnXz3W0oM1e4vTRdDIQBYx
	 dM0fVABd6oMP5499xzgrwUNbJJKpSd4bi7MqtvEjnk79tk0IR+4guxJtgwt4k6rgLK
	 57CwhkIJ0FC5fjTTKFNOIik1e/omSpgfVwVjSJiI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jian Shen <shenjian15@huawei.com>,
	Jijie Shao <shaojijie@huawei.com>,
	Simon Horman <horms@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 102/430] net: hns3: using the num_tqps in the vf driver to apply for resources
Date: Mon, 29 Dec 2025 17:08:24 +0100
Message-ID: <20251229160728.122295073@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251229160724.139406961@linuxfoundation.org>
References: <20251229160724.139406961@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jian Shen <shenjian15@huawei.com>

[ Upstream commit c2a16269742e176fccdd0ef9c016a233491a49ad ]

Currently, hdev->htqp is allocated using hdev->num_tqps, and kinfo->tqp
is allocated using kinfo->num_tqps. However, kinfo->num_tqps is set to
min(new_tqps, hdev->num_tqps);  Therefore, kinfo->num_tqps may be smaller
than hdev->num_tqps, which causes some hdev->htqp[i] to remain
uninitialized in hclgevf_knic_setup().

Thus, this patch allocates hdev->htqp and kinfo->tqp using hdev->num_tqps,
ensuring that the lengths of hdev->htqp and kinfo->tqp are consistent
and that all elements are properly initialized.

Fixes: e2cb1dec9779 ("net: hns3: Add HNS3 VF HCL(Hardware Compatibility Layer) Support")
Signed-off-by: Jian Shen <shenjian15@huawei.com>
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/20251211023737.2327018-2-shaojijie@huawei.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
index 8fcf220a120d2..70327a73dee32 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
@@ -368,12 +368,12 @@ static int hclgevf_knic_setup(struct hclgevf_dev *hdev)
 	new_tqps = kinfo->rss_size * num_tc;
 	kinfo->num_tqps = min(new_tqps, hdev->num_tqps);
 
-	kinfo->tqp = devm_kcalloc(&hdev->pdev->dev, kinfo->num_tqps,
+	kinfo->tqp = devm_kcalloc(&hdev->pdev->dev, hdev->num_tqps,
 				  sizeof(struct hnae3_queue *), GFP_KERNEL);
 	if (!kinfo->tqp)
 		return -ENOMEM;
 
-	for (i = 0; i < kinfo->num_tqps; i++) {
+	for (i = 0; i < hdev->num_tqps; i++) {
 		hdev->htqp[i].q.handle = &hdev->nic;
 		hdev->htqp[i].q.tqp_index = i;
 		kinfo->tqp[i] = &hdev->htqp[i].q;
-- 
2.51.0




