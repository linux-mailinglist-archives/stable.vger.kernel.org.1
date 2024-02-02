Return-Path: <stable+bounces-17642-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2554584659F
	for <lists+stable@lfdr.de>; Fri,  2 Feb 2024 03:05:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5628DB22419
	for <lists+stable@lfdr.de>; Fri,  2 Feb 2024 02:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D28C88464;
	Fri,  2 Feb 2024 02:05:04 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from lechuck.jsg.id.au (jsg.id.au [193.114.144.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44676FDD
	for <stable@vger.kernel.org>; Fri,  2 Feb 2024 02:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.114.144.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706839504; cv=none; b=NiYfB0MeUACJPehxJ5k4qOlsfqJMy+U4SHsQ8Ay2MzyADR6ER54XLdLEATXQQVmfbyNNuPGYlbM+P8RLsqih8HTlGr0V9dLUCHo4I9MzDhpcCb8dRJ4jlH7GL+FfmnZJBRFThUoX/JLGCm70B7jRi9rF/5mXFJXBcwJg+EATP6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706839504; c=relaxed/simple;
	bh=wQw9a7jGVf1WiqLScKipbKT1HX03dnzSD6gQVhvugts=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Er76NFo6CQ58cQbswhB3QmIX3PSg382dUnOA2CxoXDwOzO1QoRrB3nGLuBZPFI2OYErSVG5X5W58L3aSrmY1Q+GaVvoqgFTtSSbASUZkfXoeICI0N/HzN7YP1GHDafrnxLiIXjd9h/VJdHfo18mNnaijC63+vcxXDRK3v3S9e3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jsg.id.au; spf=pass smtp.mailfrom=jsg.id.au; arc=none smtp.client-ip=193.114.144.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jsg.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jsg.id.au
Received: from largo.jsg.id.au (largo.jsg.id.au [192.168.1.43])
	by lechuck.jsg.id.au (OpenSMTPD) with ESMTPS id 61eca157 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 2 Feb 2024 13:04:58 +1100 (AEDT)
Received: from largo.jsg.id.au (localhost [127.0.0.1])
	by largo.jsg.id.au (OpenSMTPD) with ESMTP id 1576563d;
	Fri, 2 Feb 2024 13:04:57 +1100 (AEDT)
From: Jonathan Gray <jsg@jsg.id.au>
To: gregkh@linuxfoundation.org
Cc: mario.limonciello@amd.com,
	stable@vger.kernel.org
Subject: [PATCH 6.6.y] Revert "drm/amd/display: Disable PSR-SU on Parade 0803 TCON again"
Date: Fri,  2 Feb 2024 13:04:57 +1100
Message-Id: <20240202020457.29708-1-jsg@jsg.id.au>
X-Mailer: git-send-email 2.40.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit 107a11637f43e7cdcca96c09525481e38b004455.

duplicated a change made in 6.6.8
a8f922ad2f76a53383982132ee44d123b72533c5

Cc: stable@vger.kernel.org # 6.6
Signed-off-by: Jonathan Gray <jsg@jsg.id.au>
---
 drivers/gpu/drm/amd/display/modules/power/power_helpers.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/modules/power/power_helpers.c b/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
index 3af67b729f6c..2b3d5183818a 100644
--- a/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
+++ b/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
@@ -841,8 +841,6 @@ bool is_psr_su_specific_panel(struct dc_link *link)
 				isPSRSUSupported = false;
 			else if (dpcd_caps->sink_dev_id_str[1] == 0x08 && dpcd_caps->sink_dev_id_str[0] == 0x03)
 				isPSRSUSupported = false;
-			else if (dpcd_caps->sink_dev_id_str[1] == 0x08 && dpcd_caps->sink_dev_id_str[0] == 0x03)
-				isPSRSUSupported = false;
 			else if (dpcd_caps->psr_info.force_psrsu_cap == 0x1)
 				isPSRSUSupported = true;
 		}
-- 
2.43.0


