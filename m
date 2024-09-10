Return-Path: <stable+bounces-74422-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5F4A972F3C
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 11:50:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1948FB2358C
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 09:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A791A187325;
	Tue, 10 Sep 2024 09:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="T3ZCPv2e"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C0613B2B0;
	Tue, 10 Sep 2024 09:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725961758; cv=none; b=H/vchilLPjyiNkzd9Hf4gfr9J8as1wvBl74/dTSalVkdRQxs/+INRP67AoyKOsEmbYBusqVEESfL7ZQdG3RzkP5ptj5/yBw81hY9l8NNpNaSpxpK7jAFnQfG/9zRarxP1uXa6X5J+o59Of/FWSNcndvkzLyHBleMRanVyEfKRpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725961758; c=relaxed/simple;
	bh=yjOFxmmsvCTYSEFpsZBhKemS1sMWk57hDTSoF7BQvhg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pA+TFB1bmtqSJTP5HOyAGvnv8xL2iOyr0Dk1KBPw9GXh9rOc44CClYrDHTu0AYBSaV/r/X4aAkNa1c5WxWygITCgsyi4xuAxqpnQrN24OFlmcaRxI7huCNBWfIapM6WD6c5z9UgcOpTAPm6RTaFHH8cGMXkOYc8JhhrKl+Om4Es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=T3ZCPv2e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4C77C4CED7;
	Tue, 10 Sep 2024 09:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725961758;
	bh=yjOFxmmsvCTYSEFpsZBhKemS1sMWk57hDTSoF7BQvhg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T3ZCPv2eHy8eDDhtTgOVq0UlweO/58HO3zI3Ww5IBIzcLqvmrN0/FKT3beNJqBL6N
	 DALhq0+MX/WXDdTrfUECBv9/r33cjhz1+qYQusEVb44o4ccqF4EBfqvOuRC0omHdcw
	 5pxZJqlscza4swzMR+7AE5snwTbjw+7uUK9dEBCM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Jinjie Ruan <ruanjinjie@huawei.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.10 179/375] net: phy: Fix missing of_node_put() for leds
Date: Tue, 10 Sep 2024 11:29:36 +0200
Message-ID: <20240910092628.496870865@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240910092622.245959861@linuxfoundation.org>
References: <20240910092622.245959861@linuxfoundation.org>
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

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jinjie Ruan <ruanjinjie@huawei.com>

[ Upstream commit 2560db6ede1aaf162a73b2df43e0b6c5ed8819f7 ]

The call of of_get_child_by_name() will cause refcount incremented
for leds, if it succeeds, it should call of_node_put() to decrease
it, fix it.

Fixes: 01e5b728e9e4 ("net: phy: Add a binding for PHY LEDs")
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Link: https://patch.msgid.link/20240830022025.610844-1-ruanjinjie@huawei.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/phy/phy_device.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 6c6ec9475709..2c0ee5cf8b6e 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -3346,11 +3346,13 @@ static int of_phy_leds(struct phy_device *phydev)
 		err = of_phy_led(phydev, led);
 		if (err) {
 			of_node_put(led);
+			of_node_put(leds);
 			phy_leds_unregister(phydev);
 			return err;
 		}
 	}
 
+	of_node_put(leds);
 	return 0;
 }
 
-- 
2.43.0




