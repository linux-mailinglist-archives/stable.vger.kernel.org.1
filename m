Return-Path: <stable+bounces-77143-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C85E8985900
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 13:49:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F2521F243A6
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 11:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 496EA193415;
	Wed, 25 Sep 2024 11:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gvIIvAvx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0145B193401;
	Wed, 25 Sep 2024 11:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727264298; cv=none; b=XnRwtWXN4JuLRqDvw8HYUWcrCXyeD6KP6cIQ2Hr78oTo8cePhgul0TwIpG2HyULYhmfwth4WsSM0tMBU1YcG6A/cVKLOPDYeSgFBTqWnHuTwnoYL60Bub17KVh1xWY2GzyTGhGFwMLkzxOC359v1YUlwXUh/Nh9sNSJkX1U9j4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727264298; c=relaxed/simple;
	bh=FxsmB/ytBWAkiA19KmoIi1TEz9LzoVEwRNgdhKtXGqg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oY5Cz4UiGp4ZyY1bj+EQGD9kkULmimxRkgzdPo3McjTLONhNz9tzdDYm5KY16Gk/ZSkBwewSInKwmea053ZDJ4SUFU6Iw1oWyioODA+vnVCNzpg+4RsKWQ7yCSIva67NfWf9QPSDt50zvbWF2nzkjwcI1uWoOaL/BoVGMWwQvBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gvIIvAvx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DB19C4CECD;
	Wed, 25 Sep 2024 11:38:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727264297;
	bh=FxsmB/ytBWAkiA19KmoIi1TEz9LzoVEwRNgdhKtXGqg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gvIIvAvxhmowMubwy15iqQZouCD5eIghFs6twZ2P4KmhhgK7Y7lcPi3EwOnTbNyei
	 mzp1SQS2UVQ9z7+VGxhyhqDBV8/7HeU1TI+dKHsYNRDJgKdOkzMEcgDHMO5d9Aj4DW
	 XFHiQHb3AUx2ucNto/y4xI4aQddY9IrVnmU/YXkyZQyKVIjJTJGhbU7Lru8BmZlM4X
	 uf2eNShwfNfG+LfvMxmuWnlo4jH0pnR8Ueb5DBzDYgLgQebyb73wB6YXix0BLb+tv5
	 fJujz1qHJiwUo0/wOqKzr8KFIj1EaVXg4evleXm+VnaRb/+XNlCL8jpby8rRfmyB/h
	 Y3VzVNo31Af8g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Simon Horman <horms@kernel.org>,
	Michael Chan <michael.chan@broadcom.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.11 045/244] bnxt_en: Extend maximum length of version string by 1 byte
Date: Wed, 25 Sep 2024 07:24:26 -0400
Message-ID: <20240925113641.1297102-45-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925113641.1297102-1-sashal@kernel.org>
References: <20240925113641.1297102-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11
Content-Transfer-Encoding: 8bit

From: Simon Horman <horms@kernel.org>

[ Upstream commit ffff7ee843c351ce71d6e0d52f0f20bea35e18c9 ]

This corrects an out-by-one error in the maximum length of the package
version string. The size argument of snprintf includes space for the
trailing '\0' byte, so there is no need to allow extra space for it by
reducing the value of the size argument by 1.

Found by inspection.
Compile tested only.

Signed-off-by: Simon Horman <horms@kernel.org>
Reviewed-by: Michael Chan <michael.chan@broadcom.com>
Link: https://patch.msgid.link/20240813-bnxt-str-v2-1-872050a157e7@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index 4cf9bf8b01b09..ac06f4a4cf97c 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -4157,7 +4157,7 @@ static void bnxt_get_pkgver(struct net_device *dev)
 
 	if (!bnxt_get_pkginfo(dev, buf, sizeof(buf))) {
 		len = strlen(bp->fw_ver_str);
-		snprintf(bp->fw_ver_str + len, FW_VER_STR_LEN - len - 1,
+		snprintf(bp->fw_ver_str + len, FW_VER_STR_LEN - len,
 			 "/pkg %s", buf);
 	}
 }
-- 
2.43.0


