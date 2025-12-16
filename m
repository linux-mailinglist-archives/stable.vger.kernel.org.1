Return-Path: <stable+bounces-201458-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2196DCC2574
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 12:39:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5E61C30ACC98
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 11:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C22B341650;
	Tue, 16 Dec 2025 11:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Kih6ArlJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED853341078;
	Tue, 16 Dec 2025 11:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765884704; cv=none; b=PUO6TuPHuVwxPOdRq+FjrXD2O+dxBV5pOhXAYwkPajuovdGcqXgEtnCGG09pSTVCyRs9Xuway267NkquBh9up0SO91Hg1MzF/H+saGTaSAk0qsVCaln4QH8RTJ3PvCL907Cyeo/1Xd5rWMd6FnI5RvT0O7Ft3NUT7kpOGy7oNlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765884704; c=relaxed/simple;
	bh=fTYaGtO+voAbJB3LygTT0mtLciwEiXTLbceiq6yN55E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ihgvYeLiag6t5dlszhR1/Iv8/IIVjC4hB6M9A2nacf06TQHEXIaL1xdxc2Ysa7/IJZEjs208WEkmfUMU0t0deZtZUPkAVDSCse0do9pUXM+sBLVz9E6WqOmMLMBcoV1cbFTtnF9Fenrwk7yC0zfejT7M84dMRmM9rpX96zPedzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Kih6ArlJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17735C4CEF1;
	Tue, 16 Dec 2025 11:31:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1765884703;
	bh=fTYaGtO+voAbJB3LygTT0mtLciwEiXTLbceiq6yN55E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Kih6ArlJcyuIbHie0waB3M7QNs/ykLwtcVzNAyVO39cAIkkLfW/yr+efAvxwc5iAK
	 Tc/VRbcc+YpokO+fb3dmzoABN94/rzTAGp9hd2yoLwgRHqAOPYkC5MJd3gA0OsiLke
	 JAPiHBvHoKO/iKjuXj94X3HXH76vnDHwDlJh06wM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Robert Marko <robimarko@gmail.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 272/354] net: phy: aquantia: check for NVMEM deferral
Date: Tue, 16 Dec 2025 12:13:59 +0100
Message-ID: <20251216111330.770693274@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251216111320.896758933@linuxfoundation.org>
References: <20251216111320.896758933@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Robert Marko <robimarko@gmail.com>

[ Upstream commit a6c121a2432eee2c4ebceb1483ccd4a50a52983d ]

Currently, if NVMEM provider is probed later than Aquantia, loading the
firmware will fail with -EINVAL.

To fix this, simply check for -EPROBE_DEFER when NVMEM is attempted and
return it.

Fixes: e93984ebc1c8 ("net: phy: aquantia: add firmware load support")
Signed-off-by: Robert Marko <robimarko@gmail.com>
Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Link: https://patch.msgid.link/20251127114514.460924-1-robimarko@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/phy/aquantia/aquantia_firmware.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/phy/aquantia/aquantia_firmware.c b/drivers/net/phy/aquantia/aquantia_firmware.c
index dab3af80593f5..33b8c7676fb36 100644
--- a/drivers/net/phy/aquantia/aquantia_firmware.c
+++ b/drivers/net/phy/aquantia/aquantia_firmware.c
@@ -368,7 +368,7 @@ int aqr_firmware_load(struct phy_device *phydev)
 		 * assume that, and load a new image.
 		 */
 		ret = aqr_firmware_load_nvmem(phydev);
-		if (!ret)
+		if (ret == -EPROBE_DEFER || !ret)
 			return ret;
 
 		ret = aqr_firmware_load_fs(phydev);
-- 
2.51.0




