Return-Path: <stable+bounces-205776-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C65FCFA557
	for <lists+stable@lfdr.de>; Tue, 06 Jan 2026 19:53:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3013D325785B
	for <lists+stable@lfdr.de>; Tue,  6 Jan 2026 18:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C224B3612F9;
	Tue,  6 Jan 2026 17:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wE2WKO2m"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E2023612F7;
	Tue,  6 Jan 2026 17:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767721823; cv=none; b=obh42oTpxNRVIzEw2E7ipoBivvMguEKzPHNZQFv8u3umbS/LltsHxSKmWNHx+MuOT8HGxUqSvHDKPQIYqpCQZ0Ns1E+PVa3/tRgVvW1YUfTNgTNzWe5U5t+uQGunffNYjjC30jln1SY4pnZv9Vo1+VOC/hl1dPSBFpKfY6P1nRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767721823; c=relaxed/simple;
	bh=eVqmPwSmZxJ0hqevvCWfPjNSSW2sbbz/ywSHcybxVH0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gI1HCQRlX3mbEZ4NjhZy2mwPcM4G7VyUWouHqpqeCv4wvg7OJbvyKy6F1VKpk7+ANgw+t+1dMNP14Sl9qvY0X/vFQoyvwe0DFcCwb80M7q33byhvKmqK6vpMSl7frSS7RaebChMKNieekbbYOB8obLaSi59D5mUqR3TGIN9NpIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wE2WKO2m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04F4AC116C6;
	Tue,  6 Jan 2026 17:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767721823;
	bh=eVqmPwSmZxJ0hqevvCWfPjNSSW2sbbz/ywSHcybxVH0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=wE2WKO2mW1GP/r+udN90Y3eTtB14JHHtPwDc+h/6+svQcw01k/BP0CPCdImUz4e0W
	 yzXTbtyGJ5BwhbTGP2ijEnCG6vcVolmSKO31NBKK7tRxnh1zla/k68dtj+lH9IDtbX
	 IKsuNw3yUT48aq/YT8Ei8L4knEN2Uuyg34h3Jibk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Zilin Guan <zilin@seu.edu.cn>,
	Alex Williamson <alex@shazbot.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 055/312] vfio/pds: Fix memory leak in pds_vfio_dirty_enable()
Date: Tue,  6 Jan 2026 18:02:09 +0100
Message-ID: <20260106170549.842885203@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260106170547.832845344@linuxfoundation.org>
References: <20260106170547.832845344@linuxfoundation.org>
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

From: Zilin Guan <zilin@seu.edu.cn>

[ Upstream commit 665077d78dc7941ce6a330c02023a2b469cc8cc7 ]

pds_vfio_dirty_enable() allocates memory for region_info. If
interval_tree_iter_first() returns NULL, the function returns -EINVAL
immediately without freeing the allocated memory, causing a memory leak.

Fix this by jumping to the out_free_region_info label to ensure
region_info is freed.

Fixes: 2e7c6feb4ef52 ("vfio/pds: Add multi-region support")
Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
Link: https://lore.kernel.org/r/20251225143150.1117366-1-zilin@seu.edu.cn
Signed-off-by: Alex Williamson <alex@shazbot.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/vfio/pci/pds/dirty.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/vfio/pci/pds/dirty.c b/drivers/vfio/pci/pds/dirty.c
index 481992142f79..4915a7c1c491 100644
--- a/drivers/vfio/pci/pds/dirty.c
+++ b/drivers/vfio/pci/pds/dirty.c
@@ -292,8 +292,11 @@ static int pds_vfio_dirty_enable(struct pds_vfio_pci_device *pds_vfio,
 	len = num_ranges * sizeof(*region_info);
 
 	node = interval_tree_iter_first(ranges, 0, ULONG_MAX);
-	if (!node)
-		return -EINVAL;
+	if (!node) {
+		err = -EINVAL;
+		goto out_free_region_info;
+	}
+
 	for (int i = 0; i < num_ranges; i++) {
 		struct pds_lm_dirty_region_info *ri = &region_info[i];
 		u64 region_size = node->last - node->start + 1;
-- 
2.51.0




