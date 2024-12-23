Return-Path: <stable+bounces-105724-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 730B89FB15B
	for <lists+stable@lfdr.de>; Mon, 23 Dec 2024 17:05:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BEB0A7A03C4
	for <lists+stable@lfdr.de>; Mon, 23 Dec 2024 16:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65524188006;
	Mon, 23 Dec 2024 16:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lO4xzqNS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 233C312D1F1;
	Mon, 23 Dec 2024 16:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734969927; cv=none; b=ISb8XekhgBeHvFv9kt7VLIy5k6tGLKQyo63nVcJLoxC9KFixmhRzJiewort0MhrhEgcNIneMeXsplJSgtPIucI1q7tJltoFTDv9YDBLzOECcK2tHABWODy/X+Gy4+xhlBpxbJARV2wfbdnzL2/Gqd0n6KHMSqxHOOBa0DqfzhvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734969927; c=relaxed/simple;
	bh=h2iJtfjmAA/scvpyJ3gcblJDCXhCn0KUvApTiD/tCN4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AZL08l/aaeAX+AkTWmbrTWjfP9xQiZrVJe8CM+kkEeavXxnQKk6vFTIcLScUEzAx+jypAdZgB6aoZ15yolwVvPfvuTkTaJvy6mjjAJc8iqmCLnaRQ9GgT1Mrq0SP1dnItkD+1oVLi6co0VUmpUe7sfIkxyXGyGVdVjp/gayFHUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lO4xzqNS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86076C4CED3;
	Mon, 23 Dec 2024 16:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734969927;
	bh=h2iJtfjmAA/scvpyJ3gcblJDCXhCn0KUvApTiD/tCN4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lO4xzqNS5RQzuaGnJMnDitSjdoEvhbHgyCJgQns5dZ9i7DWbd3rsxzEnBRDA8SC/Z
	 spcKqNQx3aX7jLIyhlbRVRfhWIWluwuiVavT60maurtbtzJWCHrPWQ3e3qNQgurpLy
	 qDZbTjP6iScgDq1O+UrFvlVwe1TzIuoTiJoYN9ec=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yang Yingliang <yangyingliang@huawei.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 094/160] drm/panel: novatek-nt35950: fix return value check in nt35950_probe()
Date: Mon, 23 Dec 2024 16:58:25 +0100
Message-ID: <20241223155412.321831494@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241223155408.598780301@linuxfoundation.org>
References: <20241223155408.598780301@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yang Yingliang <yangyingliang@huawei.com>

[ Upstream commit f8fd0968eff52cf092c0d517d17507ea2f6e5ea5 ]

mipi_dsi_device_register_full() never returns NULL pointer, it
will return ERR_PTR() when it fails, so replace the check with
IS_ERR().

Fixes: 623a3531e9cf ("drm/panel: Add driver for Novatek NT35950 DSI DriverIC panels")
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Link: https://lore.kernel.org/r/20241029123957.1588-1-yangyingliang@huaweicloud.com
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20241029123957.1588-1-yangyingliang@huaweicloud.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/panel/panel-novatek-nt35950.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-novatek-nt35950.c b/drivers/gpu/drm/panel/panel-novatek-nt35950.c
index b036208f9356..08b22b592ab0 100644
--- a/drivers/gpu/drm/panel/panel-novatek-nt35950.c
+++ b/drivers/gpu/drm/panel/panel-novatek-nt35950.c
@@ -481,9 +481,9 @@ static int nt35950_probe(struct mipi_dsi_device *dsi)
 			return dev_err_probe(dev, -EPROBE_DEFER, "Cannot get secondary DSI host\n");
 
 		nt->dsi[1] = mipi_dsi_device_register_full(dsi_r_host, info);
-		if (!nt->dsi[1]) {
+		if (IS_ERR(nt->dsi[1])) {
 			dev_err(dev, "Cannot get secondary DSI node\n");
-			return -ENODEV;
+			return PTR_ERR(nt->dsi[1]);
 		}
 		num_dsis++;
 	}
-- 
2.39.5




