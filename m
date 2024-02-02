Return-Path: <stable+bounces-17641-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ED4684659E
	for <lists+stable@lfdr.de>; Fri,  2 Feb 2024 03:05:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10E44289072
	for <lists+stable@lfdr.de>; Fri,  2 Feb 2024 02:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 538EA53A1;
	Fri,  2 Feb 2024 02:05:01 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from lechuck.jsg.id.au (jsg.id.au [193.114.144.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B38BE55
	for <stable@vger.kernel.org>; Fri,  2 Feb 2024 02:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.114.144.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706839501; cv=none; b=nF8WxgpCgL8ID8e7rOnhg/8sl92x4Z0+TdwvfRpXrYz0guCVzjw0KhzPrM/5fiNa02GaeOI33hvGLc+oW5JYK8ixW9b0ald38KSPAWcA2+AiTmNX53zkLTsJXoGXluhJ1+LilgIt3M7VWCKJ/YXSZKWhZliR2yeBqiELf80zLns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706839501; c=relaxed/simple;
	bh=4HU9ndBLckzwGalOYxmuhz0nRfBdkJEAYsEPEYFfFMQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MoCp/5fRCu8Moi3G1a/YQaJGm4ml5Bt5nvrgFvabF/GsnYewMjoU9cYg4g979+aU3I9P4UGSRd48yJHTH/EiXmjlhfBXOPl4zspI5wLruUnliO2cGBPKQuCmfmnXdB7tGrmnUQ0++IhJoQj+Sq2PB7ojDTLqWPxrwLnrdB8WCcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jsg.id.au; spf=pass smtp.mailfrom=jsg.id.au; arc=none smtp.client-ip=193.114.144.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jsg.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jsg.id.au
Received: from largo.jsg.id.au (largo.jsg.id.au [192.168.1.43])
	by lechuck.jsg.id.au (OpenSMTPD) with ESMTPS id 485a4604 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 2 Feb 2024 13:04:48 +1100 (AEDT)
Received: from largo.jsg.id.au (localhost [127.0.0.1])
	by largo.jsg.id.au (OpenSMTPD) with ESMTP id 8645b3ae;
	Fri, 2 Feb 2024 13:04:48 +1100 (AEDT)
From: Jonathan Gray <jsg@jsg.id.au>
To: gregkh@linuxfoundation.org
Cc: mario.limonciello@amd.com,
	stable@vger.kernel.org
Subject: [PATCH 6.1.y] Revert "drm/amd/display: Disable PSR-SU on Parade 0803 TCON again"
Date: Fri,  2 Feb 2024 13:04:47 +1100
Message-Id: <20240202020447.79371-1-jsg@jsg.id.au>
X-Mailer: git-send-email 2.40.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit 85d16c03ddd3f9b10212674e16ee8662b185bd14.

duplicated a change made in 6.1.69
20907717918f0487258424631b704c7248a72da2

Cc: stable@vger.kernel.org # 6.1
Signed-off-by: Jonathan Gray <jsg@jsg.id.au>
---
 drivers/gpu/drm/amd/display/modules/power/power_helpers.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/modules/power/power_helpers.c b/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
index e2f436dea565..67287ad07226 100644
--- a/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
+++ b/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
@@ -818,8 +818,6 @@ bool is_psr_su_specific_panel(struct dc_link *link)
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


