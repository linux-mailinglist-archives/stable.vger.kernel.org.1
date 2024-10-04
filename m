Return-Path: <stable+bounces-81020-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B132F990DE6
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 21:22:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 727CF288E9D
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 19:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83F18216457;
	Fri,  4 Oct 2024 18:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q3JSKRY+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42584216451;
	Fri,  4 Oct 2024 18:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728066505; cv=none; b=PUKdIP5txQY5IlCV9jer+9Chn366yOF0NZ5ZJgxJ52d9Ap1htLoZ+IBsyisusYhn5sQowarmwlgdJ85sOIpyPav23wap3+zCKadCxmLy/pCDQRwleMSRFtnYyhzdhax2zwyVOBs7lbXJVXMTW7wQc+Dv7igb5xe/9fTt4u/gdFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728066505; c=relaxed/simple;
	bh=DWQabWJKDitGI6DPVVEbNb0mAI+6IODNNJT/UWWEGbk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qQASKfnBk3I532u+Q60y1idfih1UcHr0Yzb20hMtPJC9sBmVxR4/uhNyYwVUI66mcbpYUW3YFQOYp7QNITzmkRUyloKW0n0+qqh5rJX/mNAhEhL0gUGZ9bETiQi4RjE7sayQ0riLWxKVrGl4zBtbG0yCzG0JwP0QrYlSPhx+5IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q3JSKRY+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAA95C4CEC6;
	Fri,  4 Oct 2024 18:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728066504;
	bh=DWQabWJKDitGI6DPVVEbNb0mAI+6IODNNJT/UWWEGbk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q3JSKRY+zVJsBrdTVlXnhlqN2FZlUKPJJaAxQIqGCbESrzqT5Z8GvXCoQVd80TbRh
	 OEgu507cP20xtc1t73PZxsIbI2djWwGEM81NXsgyDp8SUJuM4w8DKBgHo85O2ChZEy
	 AIaJ7rx1QNdArn0M4eUkbuG0cNBgDf7JfvSK4i4lu0/olCy3BWWnlFWuFZ4wfSL/ai
	 GzHm8p6HyH/E+KEedPMy6jX1CYmc0/zx50rnzz3yOkdqD5oLVNaTDvE7KHJymFyfxh
	 p7qxsQ3S42+27drOOTiaacM+yHoRbJRJWCkHHpAJuONTgNLlX4BDycyXbn1i5pVXFU
	 BYGZAqJcptVVA==
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
Subject: [PATCH AUTOSEL 6.1 36/42] staging: vme_user: added bound check to geoid
Date: Fri,  4 Oct 2024 14:26:47 -0400
Message-ID: <20241004182718.3673735-36-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241004182718.3673735-1-sashal@kernel.org>
References: <20241004182718.3673735-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.112
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
index 1ee432c223e2b..0c4d60aa00ab2 100644
--- a/drivers/staging/vme_user/vme_fake.c
+++ b/drivers/staging/vme_user/vme_fake.c
@@ -1071,6 +1071,12 @@ static int __init fake_init(void)
 	struct vme_slave_resource *slave_image;
 	struct vme_lm_resource *lm;
 
+	if (geoid < 0 || geoid >= VME_MAX_SLOTS) {
+		pr_err("VME geographical address must be between 0 and %d (exclusive), but got %d\n",
+			VME_MAX_SLOTS, geoid);
+		return -EINVAL;
+	}
+
 	/* We need a fake parent device */
 	vme_root = __root_device_register("vme", THIS_MODULE);
 	if (IS_ERR(vme_root))
diff --git a/drivers/staging/vme_user/vme_tsi148.c b/drivers/staging/vme_user/vme_tsi148.c
index 0171f46d1848f..0e649c8b259d1 100644
--- a/drivers/staging/vme_user/vme_tsi148.c
+++ b/drivers/staging/vme_user/vme_tsi148.c
@@ -2261,6 +2261,12 @@ static int tsi148_probe(struct pci_dev *pdev, const struct pci_device_id *id)
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


