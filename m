Return-Path: <stable+bounces-80913-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB560990CAB
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 20:54:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 570C21F22814
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 18:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27D7B1DD9CD;
	Fri,  4 Oct 2024 18:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sp9RKLor"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D634A1DD9C8;
	Fri,  4 Oct 2024 18:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728066232; cv=none; b=SNojXzKXBdWomnNKbMGrL2G3eybMGwZOb+05pW5dvModJmoT42jMZpWxpE3m99jyW+6r9yHSm3QerK7JQrKHgbMf7EkUjrtgAqXMJQgISDQPlzquOlIm7vAqHYBKhfuYw6jlIIsnuxD5hK2/HzgCAa+x/XPcE9Sad1bIfcHALb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728066232; c=relaxed/simple;
	bh=I43N8VamydTRQfZg02WHwUJugou2zgn+e1JtOSyuupA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c6vIWClHZ6RHDVnn3mavfT0q2jKQy+qg6sQ+fesWVMY+6tubDsbNqeSLU+kDjnsrisQlkCBsT7WwUw0KQB0bRO5e+JBa6kghfJj2vmPGAx0Y7Jo8xMEkfdls050AMvxh+bzYO5ikLYN7puMUyqe8HmuxqrXBpe6Wrxr5A3/0OD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sp9RKLor; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E898C4CEC6;
	Fri,  4 Oct 2024 18:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728066232;
	bh=I43N8VamydTRQfZg02WHwUJugou2zgn+e1JtOSyuupA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sp9RKLorTWZx5/5ZhjF60KZup3rQpPQlD+9Qo/OFfyDE07PnRiQo/cOeddNXsVLAe
	 KWAVbsCD7c3pyRLhOtw/T9mST6IIAN9OGMLUTHeY9TKFExuFr5kjOp39nkv/6Ekzks
	 DwMRN+DyxbWSSQrnFt7bIhSX3X7xoKec6oOq83r+PKwL1ckCPZnLAsd68LiXnAKSrs
	 LCLFPEbT82DqS/9g1IPIl8H8oTw1XbF9dkHy0Bc9p6ygjzAGdGzznIkj4iQ0dYBMsh
	 V4NTs+fhH3uHT9Ek+Jv5cz8dMR/xFPrFYsf3GAspRcMVVKMLcjBKZa8JUzBhfD/CAE
	 gyl70YENVCShA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Riyan Dhiman <riyandhiman14@gmail.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	calvncce@gmail.com,
	straube.linux@gmail.com,
	soumya.negi97@gmail.com,
	linux-staging@lists.linux.dev
Subject: [PATCH AUTOSEL 6.10 57/70] staging: vme_user: added bound check to geoid
Date: Fri,  4 Oct 2024 14:20:55 -0400
Message-ID: <20241004182200.3670903-57-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241004182200.3670903-1-sashal@kernel.org>
References: <20241004182200.3670903-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.13
Content-Transfer-Encoding: 8bit

From: Riyan Dhiman <riyandhiman14@gmail.com>

[ Upstream commit a8a8b54350229f59c8ba6496fb5689a1632a59be ]

The geoid is a module parameter that allows users to hardcode the slot number.
A bound check for geoid was added in the probe function because only values
between 0 and less than VME_MAX_SLOT are valid.

Signed-off-by: Riyan Dhiman <riyandhiman14@gmail.com>
Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>
Link: https://lore.kernel.org/r/20240827125604.42771-2-riyandhiman14@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/staging/vme_user/vme_fake.c   | 6 ++++++
 drivers/staging/vme_user/vme_tsi148.c | 6 ++++++
 2 files changed, 12 insertions(+)

diff --git a/drivers/staging/vme_user/vme_fake.c b/drivers/staging/vme_user/vme_fake.c
index 7f84d1c86f291..c4fb2b65154c7 100644
--- a/drivers/staging/vme_user/vme_fake.c
+++ b/drivers/staging/vme_user/vme_fake.c
@@ -1059,6 +1059,12 @@ static int __init fake_init(void)
 	struct vme_slave_resource *slave_image;
 	struct vme_lm_resource *lm;
 
+	if (geoid < 0 || geoid >= VME_MAX_SLOTS) {
+		pr_err("VME geographical address must be between 0 and %d (exclusive), but got %d\n",
+			VME_MAX_SLOTS, geoid);
+		return -EINVAL;
+	}
+
 	/* We need a fake parent device */
 	vme_root = root_device_register("vme");
 	if (IS_ERR(vme_root))
diff --git a/drivers/staging/vme_user/vme_tsi148.c b/drivers/staging/vme_user/vme_tsi148.c
index 2ec9c29044041..e40ca4870d704 100644
--- a/drivers/staging/vme_user/vme_tsi148.c
+++ b/drivers/staging/vme_user/vme_tsi148.c
@@ -2253,6 +2253,12 @@ static int tsi148_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	struct vme_dma_resource *dma_ctrlr;
 	struct vme_lm_resource *lm;
 
+	if (geoid < 0 || geoid >= VME_MAX_SLOTS) {
+		dev_err(&pdev->dev, "VME geographical address must be between 0 and %d (exclusive), but got %d\n",
+			VME_MAX_SLOTS, geoid);
+		return -EINVAL;
+	}
+
 	/* If we want to support more than one of each bridge, we need to
 	 * dynamically generate this so we get one per device
 	 */
-- 
2.43.0


