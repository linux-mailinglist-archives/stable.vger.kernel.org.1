Return-Path: <stable+bounces-111516-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FC04A22F82
	for <lists+stable@lfdr.de>; Thu, 30 Jan 2025 15:22:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAE0E1669F1
	for <lists+stable@lfdr.de>; Thu, 30 Jan 2025 14:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBD131DDC22;
	Thu, 30 Jan 2025 14:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="w7FhA14/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A7501E522;
	Thu, 30 Jan 2025 14:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738246963; cv=none; b=j3OGUYtbhpeb/PfT27WCcJMs2ZroiJG+fAYj62u+v887FrSR+FNkoOBdQ2rfWaYDmdJsdNQOxQrVBOS2rnyuaz1AaIABv2LuJzJQglr5QZmFSRYF3DIgKSJeLlcwAtcIAxfFr599EVd7WKiUDJyqXSwOqu375couex3rZNBLDF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738246963; c=relaxed/simple;
	bh=Z2AGetgKDSJALKaXz6nKcXy4ecjYvQUJHIamIkTRd28=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QGhn7YYYjA/5l1C/z9EiD0EMJzmU1edCDoTOiQWSE1FGK+yK7N7i1Sjkn8yCPg64cDjTU1ahB8iH8vEY+FVQLCsP31LdF6e3rmVmAPg1BbiLwGS2NITFRKtgFbjY1QqZRKceGEKU0NQj2flFTFnUCGNpp4wdog3fXn+UdQcFkk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=w7FhA14/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 253B6C4CED2;
	Thu, 30 Jan 2025 14:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738246963;
	bh=Z2AGetgKDSJALKaXz6nKcXy4ecjYvQUJHIamIkTRd28=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=w7FhA14/uLB2lMp317ACcxxXZs0Ol3B3tfwZnpg4urZJ358nc5zOR215pRLV11Kdi
	 xOMnFBezRxfY2BeivKFeAWK52xik3IhDPpAdbpNRHL8yJ7hPRKl3LKwFCHbK9Bg/8o
	 9wYzfJcGJEwP5FHOh62DfbMejrbbxpQWmiU7ZXq4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Keisuke Nishimura <keisuke.nishimura@inria.fr>,
	Simon Horman <horms@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Stefan Schmidt <stefan@datenfreihafen.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 009/133] ieee802154: ca8210: Add missing check for kfifo_alloc() in ca8210_probe()
Date: Thu, 30 Jan 2025 14:59:58 +0100
Message-ID: <20250130140142.869512324@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250130140142.491490528@linuxfoundation.org>
References: <20250130140142.491490528@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Keisuke Nishimura <keisuke.nishimura@inria.fr>

[ Upstream commit 2c87309ea741341c6722efdf1fb3f50dd427c823 ]

ca8210_test_interface_init() returns the result of kfifo_alloc(),
which can be non-zero in case of an error. The caller, ca8210_probe(),
should check the return value and do error-handling if it fails.

Fixes: ded845a781a5 ("ieee802154: Add CA8210 IEEE 802.15.4 device driver")
Signed-off-by: Keisuke Nishimura <keisuke.nishimura@inria.fr>
Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
Link: https://lore.kernel.org/20241029182712.318271-1-keisuke.nishimura@inria.fr
Signed-off-by: Stefan Schmidt <stefan@datenfreihafen.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ieee802154/ca8210.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ieee802154/ca8210.c b/drivers/net/ieee802154/ca8210.c
index 0ce426c0c0bf..9a082910ec59 100644
--- a/drivers/net/ieee802154/ca8210.c
+++ b/drivers/net/ieee802154/ca8210.c
@@ -3125,7 +3125,11 @@ static int ca8210_probe(struct spi_device *spi_device)
 	spi_set_drvdata(priv->spi, priv);
 	if (IS_ENABLED(CONFIG_IEEE802154_CA8210_DEBUGFS)) {
 		cascoda_api_upstream = ca8210_test_int_driver_write;
-		ca8210_test_interface_init(priv);
+		ret = ca8210_test_interface_init(priv);
+		if (ret) {
+			dev_crit(&spi_device->dev, "ca8210_test_interface_init failed\n");
+			goto error;
+		}
 	} else {
 		cascoda_api_upstream = NULL;
 	}
-- 
2.39.5




