Return-Path: <stable+bounces-142712-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3B0FAAEBE2
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 21:11:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CA92525C03
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 19:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1624428C2B3;
	Wed,  7 May 2025 19:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cpJFfY6i"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C797F2144C1;
	Wed,  7 May 2025 19:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746645097; cv=none; b=S8vmChZA1kKFWZ9Pc01x/iTfhOsNmq4R7anxNin4lHZn6H9I9senJ+/D8g8IOF0kQQRq1Nk1OpopRgBASw0tgrRvILCbRUkr01lpLObAeeOJpl2+OD3Gnu9Pwki1vcKDgj5cG7ocoI/lptZepK37aS1JfF5I9B89NUleyzHg3XU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746645097; c=relaxed/simple;
	bh=psQwQmVgwy/q8XxL8LDJBAXnjPuYURs87y8KOfh30hc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bjfWBcSX4ZPvQsAmvkyejZAh581SqnbdDK3MFfC1UlSYUPHc/Ky6I3PU3M4f/b2loCvNxhrKsGEG0CiOaXfxbhVvzmrLpBJdY2/rgIoUyBGNaWP/qGjl26kDVEbgzfCAP1v/Dop0Xn/RDenA7uK8wZcsh0eTCNzw0oZwOzSfqJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cpJFfY6i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2411C4CEE2;
	Wed,  7 May 2025 19:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1746645097;
	bh=psQwQmVgwy/q8XxL8LDJBAXnjPuYURs87y8KOfh30hc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cpJFfY6iQiMgQClYmYGuzaZBtCKdIICY6wkxJSGKRgqLEKLq9RT/r4nc/f+T5fVGD
	 40oXPTjZ1DMa2tiqWZ4gjat+cLNFLfsJUt6vZ4xPMMZuGSwP/5ALGMvjha3O9xNqtB
	 3c8+2Mp/fwFQozGBTsmaCJdUvb8/jXzHFkFc8JnQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Stefan Wahren <wahrenst@gmx.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 093/129] net: vertexcom: mse102x: Fix LEN_MASK
Date: Wed,  7 May 2025 20:40:29 +0200
Message-ID: <20250507183817.265388959@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250507183813.500572371@linuxfoundation.org>
References: <20250507183813.500572371@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stefan Wahren <wahrenst@gmx.net>

[ Upstream commit 74987089ec678b4018dba0a609e9f4bf6ef7f4ad ]

The LEN_MASK for CMD_RTS doesn't cover the whole parameter mask.
The Bit 11 is reserved, so adjust LEN_MASK accordingly.

Fixes: 2f207cbf0dd4 ("net: vertexcom: Add MSE102x SPI support")
Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Link: https://patch.msgid.link/20250430133043.7722-3-wahrenst@gmx.net
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/vertexcom/mse102x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/vertexcom/mse102x.c b/drivers/net/ethernet/vertexcom/mse102x.c
index 45f4d2cb5b31a..55f34d9d111c4 100644
--- a/drivers/net/ethernet/vertexcom/mse102x.c
+++ b/drivers/net/ethernet/vertexcom/mse102x.c
@@ -33,7 +33,7 @@
 #define CMD_CTR		(0x2 << CMD_SHIFT)
 
 #define CMD_MASK	GENMASK(15, CMD_SHIFT)
-#define LEN_MASK	GENMASK(CMD_SHIFT - 1, 0)
+#define LEN_MASK	GENMASK(CMD_SHIFT - 2, 0)
 
 #define DET_CMD_LEN	4
 #define DET_SOF_LEN	2
-- 
2.39.5




