Return-Path: <stable+bounces-155727-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53FDEAE439F
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 15:34:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCF2117FC4E
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 13:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18C25253B58;
	Mon, 23 Jun 2025 13:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WKEGtVw+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C85E72517AF;
	Mon, 23 Jun 2025 13:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750685180; cv=none; b=oS35ym4xPxzYqzR5xVPEICGoW4lpmNUqef3lRlPCfdZr6JA5XEhaWiEbjSTAcJRs6hzEcnScQ2sKcQkl1oqtghg2qGuauuiOV8a6kA7Y0ORPSBfPuCaXa2UTntdgk8ukCAv2+35+HMThM8gOrDuZFSrU5wsHhzgThn+rxXVXG3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750685180; c=relaxed/simple;
	bh=ut+yHLwr/F+Tv6jgujG2AZj3UYok27ElMkJ1qkSbkEE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uOS2ZtoUsA0RsPKK/4cPh0yopLkt2xEBc3Egb+It9AdI5a9upHg5lUG5IVDs4bG822qqyTiGltyf3x0/yYuMZ1nm50kpohpDqdnvsKN/lGGdLnAJbnpQib8SV9ezg7/KsFn8L/vmTpsBFSWfbolXykl3MJHsnmE2mEy24ib8nu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WKEGtVw+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B7BFC4CEEA;
	Mon, 23 Jun 2025 13:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750685180;
	bh=ut+yHLwr/F+Tv6jgujG2AZj3UYok27ElMkJ1qkSbkEE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WKEGtVw+7QgktMpyN5VCXkojigFrA+qqLP4yiuRIZSBhgiAGQuUg8K+EtipS5TRle
	 QRNuDnuIBkKGRWRQQOt7+lVMJxAERNjVFlIvymjZ4+ZoE9GEuo+3wj7ML4ewdbo/Lt
	 ktAGYDMvnSKeBwPQNRQxqR2Dz4bFtRw/9D00JNgk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 072/222] pmdomain: core: Fix error checking in genpd_dev_pm_attach_by_id()
Date: Mon, 23 Jun 2025 15:06:47 +0200
Message-ID: <20250623130614.268710150@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250623130611.896514667@linuxfoundation.org>
References: <20250623130611.896514667@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Carpenter <dan.carpenter@linaro.org>

[ Upstream commit 0f5757667ec0aaf2456c3b76fcf0c6c3ea3591fe ]

The error checking for of_count_phandle_with_args() does not handle
negative error codes correctly.  The problem is that "index" is a u32 so
in the condition "if (index >= num_domains)" negative error codes stored
in "num_domains" are type promoted to very high positive values and
"index" is always going to be valid.

Test for negative error codes first and then test if "index" is valid.

Fixes: 3ccf3f0cd197 ("PM / Domains: Enable genpd_dev_pm_attach_by_id|name() for single PM domain")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/aBxPQ8AI8N5v-7rL@stanley.mountain
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/base/power/domain.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index eed4c865a4bf8..2ccd0c8003e24 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -2509,7 +2509,7 @@ struct device *genpd_dev_pm_attach_by_id(struct device *dev,
 	/* Verify that the index is within a valid range. */
 	num_domains = of_count_phandle_with_args(dev->of_node, "power-domains",
 						 "#power-domain-cells");
-	if (index >= num_domains)
+	if (num_domains < 0 || index >= num_domains)
 		return NULL;
 
 	/* Allocate and register device on the genpd bus. */
-- 
2.39.5




