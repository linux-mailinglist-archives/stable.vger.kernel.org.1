Return-Path: <stable+bounces-1372-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B62937F7F56
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:40:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E61C41C214A1
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 18:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 006D8364CB;
	Fri, 24 Nov 2023 18:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KlclaWje"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C12C33075;
	Fri, 24 Nov 2023 18:40:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0A54C433C7;
	Fri, 24 Nov 2023 18:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700851234;
	bh=oZBDgy+384IfvhR5QuMMVinnlTq0cR9C/jYn+hvL6gc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KlclaWje0OQxnb6Cj3D7uqlDdy1L0BAzXCJq95ai3WEqJuQiKx6uC8oHIEXhi27b1
	 zjrJxc3BaJlLoLoKAxsIRGNpf7tos3+0RsEZqPLu5OF9EDLDNdqQ/jhE07K+SEtQyG
	 tOlV+y7ZNVnJ5VdVLxbBeJACL2xjAbXoFTvN0e44=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Pengfei Li <pengfei.li_1@nxp.com>,
	Emil Kronborg <emil.kronborg@protonmail.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 367/491] pmdomain: imx: Make imx pgc power domain also set the fwnode
Date: Fri, 24 Nov 2023 17:50:03 +0000
Message-ID: <20231124172035.606560597@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124172024.664207345@linuxfoundation.org>
References: <20231124172024.664207345@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pengfei Li <pengfei.li_1@nxp.com>

[ Upstream commit 374de39d38f97b0e58cfee88da590b2d056ccf7f ]

Currently, The imx pgc power domain doesn't set the fwnode
pointer, which results in supply regulator device can't get
consumer imx pgc power domain device from fwnode when creating
a link.

This causes the driver core to instead try to create a link
between the parent gpc device of imx pgc power domain device and
supply regulator device. However, at this point, the gpc device
has already been bound, and the link creation will fail. So adding
the fwnode pointer to the imx pgc power domain device will fix
this issue.

Signed-off-by: Pengfei Li <pengfei.li_1@nxp.com>
Tested-by: Emil Kronborg <emil.kronborg@protonmail.com>
Fixes: 3fb16866b51d ("driver core: fw_devlink: Make cycle detection more robust")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20231020185949.537083-1-pengfei.li_1@nxp.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/soc/imx/gpc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/imx/gpc.c b/drivers/soc/imx/gpc.c
index 90a8b2c0676ff..419ed15cc10c4 100644
--- a/drivers/soc/imx/gpc.c
+++ b/drivers/soc/imx/gpc.c
@@ -498,6 +498,7 @@ static int imx_gpc_probe(struct platform_device *pdev)
 
 			pd_pdev->dev.parent = &pdev->dev;
 			pd_pdev->dev.of_node = np;
+			pd_pdev->dev.fwnode = of_fwnode_handle(np);
 
 			ret = platform_device_add(pd_pdev);
 			if (ret) {
-- 
2.42.0




