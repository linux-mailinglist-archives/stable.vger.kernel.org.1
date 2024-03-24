Return-Path: <stable+bounces-30654-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C32178891C9
	for <lists+stable@lfdr.de>; Mon, 25 Mar 2024 07:48:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6393B1F2D30A
	for <lists+stable@lfdr.de>; Mon, 25 Mar 2024 06:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3CE01BB73D;
	Mon, 25 Mar 2024 00:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BglFJyU/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1923413C69D;
	Sun, 24 Mar 2024 23:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323501; cv=none; b=d70tAt2/GlH/A5oZcFIIM2O8WLEv9/Z1whRsuzuS7AWZVe6lR6ElszWCeO9u5/3dFOQbRRjTNezQj02BJrP5cZXhqjDmZ94YZh/1dYswIWZLBAuao13nF0Tk9VJKxyC0v+/Hv/wOYNEU/e7xLpy407ZikkzG/sqbx4O9B1oZHug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323501; c=relaxed/simple;
	bh=Mxp24LmxsCqh2e6gTaltUkJ8wrb/zpt0VG+Im8hGxx4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZB3rFkRi+bT6d5xxYU+h3btKcEgMa1MoQbkR9cz8/s6rIP+fMafe+w055kVQstcPRkV4McgZAoNcFbsmbfzrGGpcIShINzZwwespFslYjt8zNGdEE3BrKYMFT69HGG8roN2URfEtdhaDFi8+bsqHe6Z1BQuJpW3h8sQP2RTfYhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BglFJyU/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54270C43390;
	Sun, 24 Mar 2024 23:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323500;
	bh=Mxp24LmxsCqh2e6gTaltUkJ8wrb/zpt0VG+Im8hGxx4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BglFJyU/zOm5IFKvuBFfzr5hjsdioNUKaADWxvF0pU4T7PoBXMuNnNfd+6CRJGSh2
	 yRgcpOgYI7l0z5kOeecmDYbPD1JktmxQBwprUgBkAO6uMNtHR11lilLFFVS/PFS/AQ
	 vJHtcO0Blke89NH81jbGje329zAL6usLNN/pe+Q6WJSg642ZVS7zoK1DoCCQbeenxN
	 ZMQkTAIxBBTK4I/M9sUYmC71MOMFn6B1XyXH4ClyAf1rnbrhL6ujOTN+TDegKaqQE5
	 dzjm+aDVViHGgVcs9arnvMizPxhnkR+IMV0uOyrTWZa3dk8HNsrYl9FE2kDfB+0eCD
	 U0RmZ2/v2I1tw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: ruanjinjie <ruanjinjie@huawei.com>,
	Jon Mason <jdmason@kudzu.us>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 205/317] NTB: EPF: fix possible memory leak in pci_vntb_probe()
Date: Sun, 24 Mar 2024 19:33:05 -0400
Message-ID: <20240324233458.1352854-206-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324233458.1352854-1-sashal@kernel.org>
References: <20240324233458.1352854-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: ruanjinjie <ruanjinjie@huawei.com>

[ Upstream commit 956578e3d397e00d6254dc7b5194d28587f98518 ]

As ntb_register_device() don't handle error of device_register(),
if ntb_register_device() returns error in pci_vntb_probe(), name of kobject
which is allocated in dev_set_name() called in device_add() is leaked.

As comment of device_add() says, it should call put_device() to drop the
reference count that was set in device_initialize()
when it fails, so the name can be freed in kobject_cleanup().

Signed-off-by: ruanjinjie <ruanjinjie@huawei.com>
Signed-off-by: Jon Mason <jdmason@kudzu.us>
Stable-dep-of: aebfdfe39b93 ("NTB: fix possible name leak in ntb_register_device()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index 1466dd1904175..138742af51707 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -1249,6 +1249,7 @@ static int pci_vntb_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	return 0;
 
 err_register_dev:
+	put_device(&ndev->ntb.dev);
 	return -EINVAL;
 }
 
-- 
2.43.0


