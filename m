Return-Path: <stable+bounces-68290-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95B01953184
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 15:55:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0A091C2351F
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 13:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE26819F49B;
	Thu, 15 Aug 2024 13:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="foKvLrok"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CC6918D630;
	Thu, 15 Aug 2024 13:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723730101; cv=none; b=J8jgcy7ZSSkSwBX5RYhOfpph1QtHXN6tSgtx4JJSnTJvEw0pMRDs4vHX0is1QmmuL6NmO1I9e2NOiidP2Wf2IrIpXzIGL9M7DQjISYqC9Ki09icfMwnyk/9wEGQq9n3rM9SPQm//lY3txHv4jiWNgm1nw9LgNQZwr0tuiAotdfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723730101; c=relaxed/simple;
	bh=3o9kaZXZecxFVM+eadTESP3bdRyuBt6EWU59TVw3kw4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ast+igD1eRYQ8QD0UkHYg66bb1HlYmt5vnwoD5kFI5bPTWmAY1ob+UaiPEOozGmSt/qurpl85fEyIEpX795HtWxpUt799vERRXKXeE6n4XhRJcGxvVk3x+NvXEMx8utvEjHQZD6rHflGx6LA1K0N39hmloFjSDO6SuA522fZX2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=foKvLrok; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F29DDC32786;
	Thu, 15 Aug 2024 13:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723730101;
	bh=3o9kaZXZecxFVM+eadTESP3bdRyuBt6EWU59TVw3kw4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=foKvLrokCF1X3U8WU8DBseUSsyrx1lQGX0jwWOaB05wsIPJIGWV/TCisijOQcQKYU
	 wuuGIuLUoTMq3kiBB8oJKZHPKLZcgp2CyclRRIlfWul73ncfjy1Eeot9qHGVuuFeFj
	 w3i1KNJtsN355ypYYF3zCJrxIqI/9zdkwV7l76jE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ma Ke <make24@iscas.ac.cn>,
	Roger Quadros <rogerq@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 264/484] phy: cadence-torrent: Check return value on register read
Date: Thu, 15 Aug 2024 15:22:02 +0200
Message-ID: <20240815131951.598991517@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240815131941.255804951@linuxfoundation.org>
References: <20240815131941.255804951@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ma Ke <make24@iscas.ac.cn>

[ Upstream commit 967969cf594ed3c1678a9918d6e9bb2d1591cbe9 ]

cdns_torrent_dp_set_power_state() does not consider that ret might be
overwritten. Add return value check of regmap_read_poll_timeout() after
register read in cdns_torrent_dp_set_power_state().

Fixes: 5b16a790f18d ("phy: cadence-torrent: Reorder few functions to remove function declarations")
Signed-off-by: Ma Ke <make24@iscas.ac.cn>
Reviewed-by: Roger Quadros <rogerq@kernel.org>
Link: https://lore.kernel.org/r/20240702032042.3993031-1-make24@iscas.ac.cn
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/phy/cadence/phy-cadence-torrent.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/phy/cadence/phy-cadence-torrent.c b/drivers/phy/cadence/phy-cadence-torrent.c
index 415ace64adc5c..8f23146d62bf0 100644
--- a/drivers/phy/cadence/phy-cadence-torrent.c
+++ b/drivers/phy/cadence/phy-cadence-torrent.c
@@ -1056,6 +1056,9 @@ static int cdns_torrent_dp_set_power_state(struct cdns_torrent_phy *cdns_phy,
 	ret = regmap_read_poll_timeout(regmap, PHY_PMA_XCVR_POWER_STATE_ACK,
 				       read_val, (read_val & mask) == value, 0,
 				       POLL_TIMEOUT_US);
+	if (ret)
+		return ret;
+
 	cdns_torrent_dp_write(regmap, PHY_PMA_XCVR_POWER_STATE_REQ, 0x00000000);
 	ndelay(100);
 
-- 
2.43.0




