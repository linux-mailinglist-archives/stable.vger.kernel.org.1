Return-Path: <stable+bounces-172167-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56575B2FDFA
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 17:15:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94DAD625C21
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 15:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFF4B287503;
	Thu, 21 Aug 2025 15:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KcaZSuoC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA0F287276
	for <stable@vger.kernel.org>; Thu, 21 Aug 2025 15:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755788930; cv=none; b=dCqoKMXR20pfFB6S2lWY17b+laFGJv9Gk2D8J43R2RoA6mucERwj82OtjHr/Nfg3SgeOdrPvGoGkfhiYNNB3CyHRaeO6/KislnZ/d5vP64TA0M+yfvNRhVNWGG7VHV3YljTpbNHTCmKyVAlbN8v7k8MoDBjp9XI4jlZDKwvKDhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755788930; c=relaxed/simple;
	bh=RH/TD0T81CakKXbif9UkBDFwTuChf9tlClILNRqcnz8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OsxLY5SNbJaVZI0KxJ5PHwyRLkeeeXepID3yuv8mqdMhStlUN8BvwGHVkkG4HKXB2ezZXtUXil3JTSiFFU3NRQwHWC0r7+Oxxvlo3SRMa3Yr4/qC4jUhj+XXrjdkaQ4Xr9KUs62mKiYtkrEJSdVFzc/3DRJiwHrrwJnCZhOx1po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KcaZSuoC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 217D5C4CEF4;
	Thu, 21 Aug 2025 15:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755788930;
	bh=RH/TD0T81CakKXbif9UkBDFwTuChf9tlClILNRqcnz8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KcaZSuoCtk19RZutHsgNYxnBAzvK95Q4A58XricRlVQHK+QD2E7qjhd9/C/5YwHaq
	 vvDoCBCb65XQX/HeLHGHCzliG9opwFQFIoS9N97N5DwYsvtiV3p6gVTt8WDekkG/nB
	 14Tp/HxwcdtbK8UZF1urXwyeb1Ooo88sVQL614bnccesQi8ig5u50K+qKuzoF59JA7
	 8yACT7LmEutownWFlpI/wCBo83opmFoii8aTKxP47IWNBrsM0uZbfVEc4ieOK7vH1+
	 Oqazgg1AwyeeOPEK0x9omjrrXytTNGveau71kLFntVSPpv0hZF5rYHa2sxe9wxMk/z
	 fbp0u86K5uq/g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Tzung-Bi Shih <tzungbi@kernel.org>,
	Benson Leung <bleung@chromium.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 4/4] platform/chrome: cros_ec: Unregister notifier in cros_ec_unregister()
Date: Thu, 21 Aug 2025 11:08:44 -0400
Message-ID: <20250821150844.754065-4-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250821150844.754065-1-sashal@kernel.org>
References: <2025082112-freight-pesticide-c276@gregkh>
 <20250821150844.754065-1-sashal@kernel.org>
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
index f75b735b36ef..2a92adfa1958 100644
--- a/drivers/platform/chrome/cros_ec.c
+++ b/drivers/platform/chrome/cros_ec.c
@@ -313,6 +313,9 @@ EXPORT_SYMBOL(cros_ec_register);
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


