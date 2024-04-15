Return-Path: <stable+bounces-39546-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 787548A5329
	for <lists+stable@lfdr.de>; Mon, 15 Apr 2024 16:25:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D75DCB2187B
	for <lists+stable@lfdr.de>; Mon, 15 Apr 2024 14:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19D0A757E5;
	Mon, 15 Apr 2024 14:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pET67DxQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCCCE69D0A;
	Mon, 15 Apr 2024 14:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713191091; cv=none; b=lcVqHjNWjtUI5lxmlTXx9M8h4NPHfQH8wucskCqd6MxO/rFDlrbuIhF5LO7pLc5rbKIhHDCenptPLVyAPgbswD2zsBK9xPhaPpAsFCKTPOqyZbQ4YQiwHOnJd7u8x+0UshzBUHFF/SnMoKhY5RU11/9pMcKwUlIl1q0eLwUA2Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713191091; c=relaxed/simple;
	bh=3CqgNF32sfgwYXgEd1iOqdLAw0YFvvOFsCBjCV7he5s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=keC9yo8DVuzvYoVAm9rQ6xvJAUkngEAJx094caLbS8SyehLg4nVPzta6/C8/mKsoJttW4sNqcymVf13+l4NFUe9qq2DpzTJQaYap0MU0aHeYcx8vHqOTIGLU/eyB+adx/f1XPU0Gz0pv5iZClAdzf0vw58PxYFtNGf/sybuzNPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pET67DxQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53DF2C113CC;
	Mon, 15 Apr 2024 14:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713191091;
	bh=3CqgNF32sfgwYXgEd1iOqdLAw0YFvvOFsCBjCV7he5s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pET67DxQUvi2zZtQvi12DM0me2rKVAdS9wUIzmpELo6QTRQBzxhBcyiyPYbKuidYL
	 w0zHgIrxlka2VwOVvvhT8j56730XR3Q1P36OY2p1EiIRx6d97oDhbXCop+5MABuKMo
	 Xd2EzDCLqNAgskebk0BWflvrxiGZ6u78VI8UGISE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dan Williams <dan.j.williams@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Dave Jiang <dave.jiang@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 029/172] cxl/core/regs: Fix usage of map->reg_type in cxl_decode_regblock() before assigned
Date: Mon, 15 Apr 2024 16:18:48 +0200
Message-ID: <20240415142001.308240324@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240415141959.976094777@linuxfoundation.org>
References: <20240415141959.976094777@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.8-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dave Jiang <dave.jiang@intel.com>

[ Upstream commit 5c88a9ccd4c431d58b532e4158b6999a8350062c ]

In the error path, map->reg_type is being used for kernel warning
before its value is setup. Found by code inspection. Exposure to
user is wrong reg_type being emitted via kernel log. Use a local
var for reg_type and retrieve value for usage.

Fixes: 6c7f4f1e51c2 ("cxl/core/regs: Make cxl_map_{component, device}_regs() device generic")
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/cxl/core/regs.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
index 372786f809555..3c42f984eeafa 100644
--- a/drivers/cxl/core/regs.c
+++ b/drivers/cxl/core/regs.c
@@ -271,6 +271,7 @@ EXPORT_SYMBOL_NS_GPL(cxl_map_device_regs, CXL);
 static bool cxl_decode_regblock(struct pci_dev *pdev, u32 reg_lo, u32 reg_hi,
 				struct cxl_register_map *map)
 {
+	u8 reg_type = FIELD_GET(CXL_DVSEC_REG_LOCATOR_BLOCK_ID_MASK, reg_lo);
 	int bar = FIELD_GET(CXL_DVSEC_REG_LOCATOR_BIR_MASK, reg_lo);
 	u64 offset = ((u64)reg_hi << 32) |
 		     (reg_lo & CXL_DVSEC_REG_LOCATOR_BLOCK_OFF_LOW_MASK);
@@ -278,11 +279,11 @@ static bool cxl_decode_regblock(struct pci_dev *pdev, u32 reg_lo, u32 reg_hi,
 	if (offset > pci_resource_len(pdev, bar)) {
 		dev_warn(&pdev->dev,
 			 "BAR%d: %pr: too small (offset: %pa, type: %d)\n", bar,
-			 &pdev->resource[bar], &offset, map->reg_type);
+			 &pdev->resource[bar], &offset, reg_type);
 		return false;
 	}
 
-	map->reg_type = FIELD_GET(CXL_DVSEC_REG_LOCATOR_BLOCK_ID_MASK, reg_lo);
+	map->reg_type = reg_type;
 	map->resource = pci_resource_start(pdev, bar) + offset;
 	map->max_size = pci_resource_len(pdev, bar) - offset;
 	return true;
-- 
2.43.0




