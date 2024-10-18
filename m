Return-Path: <stable+bounces-86796-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EF6B9A396C
	for <lists+stable@lfdr.de>; Fri, 18 Oct 2024 11:08:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBF0E28238A
	for <lists+stable@lfdr.de>; Fri, 18 Oct 2024 09:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23D5118FDDC;
	Fri, 18 Oct 2024 09:08:04 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-out.aladdin-rd.ru (mail-out.aladdin-rd.ru [91.199.251.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495B25674E;
	Fri, 18 Oct 2024 09:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.199.251.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729242484; cv=none; b=d6mg+na+XATlkqSp9avCCNU40LacLWaGj/mtMif8LmOg6iebL1dWra5Uw3sAhO80H/Ki4NuCHWKmEDTtOvhPpJp086UON/3KpLDaaSPJXAFC0hnBfRznkL+GPDvzUKph9Rr+GRMyWmT6rI8hEh/qW6eQSJG1Dfkg/UpNRZ0aVhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729242484; c=relaxed/simple;
	bh=TT/Z8roXUv+CIl4XMwPuOonF5RLHtqCyRlLckPzMurs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B27DNdBcyL+39IRmvjjTs5EFPt+vUAaWGzQ96vc17tM1eMiNOrK/zhy2Lmvm+eHvdUbgjUNhO6oTVjk4xarnRZ7zzen8bzHh2OSEqZLq9HEbjmM5NjRm3GhUObBvUwxYICtMVEBcYyr9GJtHe5+0lK5aNumGqA/iKDuS6tYExNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aladdin.ru; spf=pass smtp.mailfrom=aladdin.ru; arc=none smtp.client-ip=91.199.251.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aladdin.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aladdin.ru
From: Daniil Dulov <d.dulov@aladdin.ru>
To: <stable@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Daniil Dulov <d.dulov@aladdin.ru>, Vinod Koul <vkoul@kernel.org>, Bard
 Liao <yung-chuan.liao@linux.intel.com>, Pierre-Louis Bossart
	<pierre-louis.bossart@linux.intel.com>, Sanyog Kale
	<sanyog.r.kale@intel.com>, <alsa-devel@alsa-project.org>,
	<linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>, Richard
 Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH 5.10 1/1] soundwire: cadence: Fix error check in cdns_xfer_msg()
Date: Fri, 18 Oct 2024 12:07:14 +0300
Message-ID: <20241018090714.399076-2-d.dulov@aladdin.ru>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241018090714.399076-1-d.dulov@aladdin.ru>
References: <20241018090714.399076-1-d.dulov@aladdin.ru>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EXCH-2016-03.aladdin.ru (192.168.1.103) To
 EXCH-2016-02.aladdin.ru (192.168.1.102)

From: Richard Fitzgerald <rf@opensource.cirrus.com>

commit 7f6bad4dfde0ec1d479fdcbbb62bccdbf3a93bb4 upstream.

_cdns_xfer_msg() returns an sdw_command_response value, not a
negative error code.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/20220917154822.690472-1-rf@opensource.cirrus.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Daniil Dulov <d.dulov@aladdin.ru>
---
 drivers/soundwire/cadence_master.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
index d3e9cd3faadf..2492250ad1bd 100644
--- a/drivers/soundwire/cadence_master.c
+++ b/drivers/soundwire/cadence_master.c
@@ -692,7 +692,7 @@ cdns_xfer_msg(struct sdw_bus *bus, struct sdw_msg *msg)
 	for (i = 0; i < msg->len / CDNS_MCP_CMD_LEN; i++) {
 		ret = _cdns_xfer_msg(cdns, msg, cmd, i * CDNS_MCP_CMD_LEN,
 				     CDNS_MCP_CMD_LEN, false);
-		if (ret < 0)
+		if (ret != SDW_CMD_OK)
 			goto exit;
 	}
 
-- 
2.25.1


