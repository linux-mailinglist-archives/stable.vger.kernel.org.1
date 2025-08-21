Return-Path: <stable+bounces-172084-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48194B2FA6E
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 15:31:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A2DD1CE0536
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 13:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06B88334723;
	Thu, 21 Aug 2025 13:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jFoZzZMB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB97C334727
	for <stable@vger.kernel.org>; Thu, 21 Aug 2025 13:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755782843; cv=none; b=nxJ6dX8AGkjjhqlKTEvPtpB0DMFBH+lSsEeJ0j91AuwMmHFHnVCIg7wiU/eEaGdpbF7uGakneNDVheB9RVsMHK/wtez8crFUJlJiWTy4zVl7Jw6R3baeWaq9J5o+IMhcQ6qjjw0PFfP4WzhYJIa5jxPesTnQEbufJzltd79HAZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755782843; c=relaxed/simple;
	bh=oujdaHitD/FwvuqZal0ZE+bWeCeeB2950cCrigkZlec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ptwjaktE33PUrGIduFmOcIOqDzW3/y3MP+R7FxM3MlZUcyW9KPEehjjIC9qy9e6K0Kucdx8SixgJRLFlsMM2pN2OjVmbGhE6UMFBcb7z8F0zd3pKjDHi3t3xyDFN/Vuny6XHGqUO+lbvuDvsq13f6p588ziPUBZa1Y/77fZsgtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jFoZzZMB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0347C4CEEB;
	Thu, 21 Aug 2025 13:27:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755782843;
	bh=oujdaHitD/FwvuqZal0ZE+bWeCeeB2950cCrigkZlec=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jFoZzZMBqfBnxj4h8rcmwugQuAlzElQpWZrySN2awTIVRpSSCuEBL4x0V9kMmnQx6
	 3lZV2TvlyBK2bxFOyoxJzxz7BAf0IMBx6LGN+LbCSGjBDcMHSF84d7e2Q7kFX/qRvj
	 MA0razmFNcJDet1/TjM6b26/N0N47UE3UA4FDSnPWiw9jAQQ2/Z7AghnbpWiPavUBq
	 59m4lHYmyPXJSmLMUFCgfCmMHAzE54S/yMs5mg59LpHIQMZ6CI9po6J3zTB4SDlk0c
	 gDtgCi5ER0soRyMLaeiYv48ix1SXUR1RLTN5BXc6psJDOcip/0yt99NKVlmuMobDna
	 lXDp6f23zMbaw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Tzung-Bi Shih <tzungbi@kernel.org>,
	Benson Leung <bleung@chromium.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 3/3] platform/chrome: cros_ec: Unregister notifier in cros_ec_unregister()
Date: Thu, 21 Aug 2025 09:27:19 -0400
Message-ID: <20250821132719.713502-3-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250821132719.713502-1-sashal@kernel.org>
References: <2025082112-exemplary-explode-1646@gregkh>
 <20250821132719.713502-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tzung-Bi Shih <tzungbi@kernel.org>

[ Upstream commit e2374953461947eee49f69b3e3204ff080ef31b1 ]

The blocking notifier is registered in cros_ec_register(); however, it
isn't unregistered in cros_ec_unregister().

Fix it.

Fixes: 42cd0ab476e2 ("platform/chrome: cros_ec: Query EC protocol version if EC transitions between RO/RW")
Cc: stable@vger.kernel.org
Reviewed-by: Benson Leung <bleung@chromium.org>
Link: https://lore.kernel.org/r/20250722120513.234031-1-tzungbi@kernel.org
Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/chrome/cros_ec.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/platform/chrome/cros_ec.c b/drivers/platform/chrome/cros_ec.c
index 6d997c59376d..fec99cdf6127 100644
--- a/drivers/platform/chrome/cros_ec.c
+++ b/drivers/platform/chrome/cros_ec.c
@@ -311,6 +311,9 @@ EXPORT_SYMBOL(cros_ec_register);
  */
 void cros_ec_unregister(struct cros_ec_device *ec_dev)
 {
+	if (ec_dev->mkbp_event_supported)
+		blocking_notifier_chain_unregister(&ec_dev->event_notifier,
+						   &ec_dev->notifier_ready);
 	platform_device_unregister(ec_dev->pd);
 	platform_device_unregister(ec_dev->ec);
 	mutex_destroy(&ec_dev->lock);
-- 
2.50.1


