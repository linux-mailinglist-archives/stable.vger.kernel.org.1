Return-Path: <stable+bounces-168857-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F308BB23712
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 21:07:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92F151A20E82
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 19:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86CDD285043;
	Tue, 12 Aug 2025 19:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TbZFMHjz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D3D23182D;
	Tue, 12 Aug 2025 19:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755025565; cv=none; b=Nhh9ctzHNjvW9FhWfGRMMcECMX8W6MIkSjWZLlLJ+nFMi92fyrI1g1H6TXcrjvjRoNf9QDE/S0Bou0JpJedsO9Pc6R1mwMuLUgViwbo6P/PW5BMGGodymipwpC1gE3ocRq6/gHQrzZWZwKkPjtafkE/7xcKLDKeQq6VTiFzg2UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755025565; c=relaxed/simple;
	bh=EMsefOc34Is7PVNnyuD+eveK8Yw8gI+OZZYrWkKGN7c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u44lnZ0I1u10f4ZZr7zMtnIB+R4sOUa4Ec2P54t0HdhPJUM9WTFc0BgHphL6G+5Gj90Jnipj8nId3XEZzGQrMaEwQL+GO3Ukn67Wg45tO/fO0MBGvDDnppMp/tzhYVXxQz/ul0vSErOzrcCOlWOUGTuCuQxWG8IQHpPxxaIxW9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TbZFMHjz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1A2DC4CEF0;
	Tue, 12 Aug 2025 19:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755025565;
	bh=EMsefOc34Is7PVNnyuD+eveK8Yw8gI+OZZYrWkKGN7c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TbZFMHjzlEip4OygLKyaXft27pEPrGRF3DTVKib4oOBuAzrq46WJki8N7xebMVMte
	 Yfv2tgdDgxCAN8VnCWUYeZ3oYklaYtpS4l+AjM455bBSdtzxs7cupHaSwLL6qJb2fL
	 MlAsJuIEJC0Z/4Zshoxj4vYpFxEwFsyDyPFCpSds=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Seungjin Bae <eeodqql09@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.15 045/480] usb: host: xhci-plat: fix incorrect type for of_match variable in xhci_plat_probe()
Date: Tue, 12 Aug 2025 19:44:13 +0200
Message-ID: <20250812174359.261417745@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250812174357.281828096@linuxfoundation.org>
References: <20250812174357.281828096@linuxfoundation.org>
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

6.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Seungjin Bae <eeodqql09@gmail.com>

[ Upstream commit d9e496a9fb4021a9e6b11e7ba221a41a2597ac27 ]

The variable `of_match` was incorrectly declared as a `bool`.
It is assigned the return value of of_match_device(), which is a pointer of
type `const struct of_device_id *`.

Fixes: 16b7e0cccb243 ("USB: xhci-plat: fix legacy PHY double init")
Signed-off-by: Seungjin Bae <eeodqql09@gmail.com>
Link: https://lore.kernel.org/r/20250619055746.176112-2-eeodqql09@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/host/xhci-plat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
index 619481dec8e8..87f173392a01 100644
--- a/drivers/usb/host/xhci-plat.c
+++ b/drivers/usb/host/xhci-plat.c
@@ -152,7 +152,7 @@ int xhci_plat_probe(struct platform_device *pdev, struct device *sysdev, const s
 	int			ret;
 	int			irq;
 	struct xhci_plat_priv	*priv = NULL;
-	bool			of_match;
+	const struct of_device_id *of_match;
 
 	if (usb_disabled())
 		return -ENODEV;
-- 
2.39.5




