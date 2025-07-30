Return-Path: <stable+bounces-165234-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E32CAB15C3C
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 11:40:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE5323AC662
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 09:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7013F26D4F9;
	Wed, 30 Jul 2025 09:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nNybK0DF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A53526980D;
	Wed, 30 Jul 2025 09:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753868329; cv=none; b=uzjiCNDE/obhFRuOxauzEobv21Lm0edHkuRnuhPeeFojCEIl9X6op1bslpQy9aTa8HlqZ93ktUwApiuoN+IafGN4X3rcPs2mlEzYIl3UoKpV13PrN8EKwSCBna5KkbJLeHxT6G6u+ThvYOk3/BcE47KNlxv69GHlgNPypEZUSss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753868329; c=relaxed/simple;
	bh=kMGypcpcDZUP9NcvPKFisXGTz1EHwKnsBxEPAVRhdqc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qGLPFGfMwqfepuEbtAqqiIiOL2819eKmsWW77SBMwj/Bmyk/LaTOpOvlgYqBy7T81IVKIUcXGfQX9kRu8j3qGjvwgIkt635bQb5pcol75ENAqAuCWOcwAUWaeV1yvWmUX211WSfBvEHoJcEyuOA1OmArpLCfA4SEI8CEu+R1ljo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nNybK0DF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7773CC4CEE7;
	Wed, 30 Jul 2025 09:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753868329;
	bh=kMGypcpcDZUP9NcvPKFisXGTz1EHwKnsBxEPAVRhdqc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nNybK0DF0RQXDd4SeDIwYi1P1c+IBM1MqxSFvCNoohqKVsvIV6R+kqJ26JCKaHR2z
	 ymun2SsZED1fbJxTjVWwoT2DmYphGk3o9IokjCCz44ZBrySbzsl4MPULlR5VmSdjNx
	 J9WcN6tISFK1lZyI4A3ygQ+CJkyytL6tCbb053KI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ma Ke <make24@iscas.ac.cn>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.6 36/76] dpaa2-eth: Fix device reference count leak in MAC endpoint handling
Date: Wed, 30 Jul 2025 11:35:29 +0200
Message-ID: <20250730093228.237209419@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250730093226.854413920@linuxfoundation.org>
References: <20250730093226.854413920@linuxfoundation.org>
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

From: Ma Ke <make24@iscas.ac.cn>

commit ee9f3a81ab08dfe0538dbd1746f81fd4d5147fdc upstream.

The fsl_mc_get_endpoint() function uses device_find_child() for
localization, which implicitly calls get_device() to increment the
device's reference count before returning the pointer. However, the
caller dpaa2_eth_connect_mac() fails to properly release this
reference in multiple scenarios. We should call put_device() to
decrement reference count properly.

As comment of device_find_child() says, 'NOTE: you will need to drop
the reference with put_device() after use'.

Found by code review.

Cc: stable@vger.kernel.org
Fixes: 719479230893 ("dpaa2-eth: add MAC/PHY support through phylink")
Signed-off-by: Ma Ke <make24@iscas.ac.cn>
Tested-by: Ioana Ciornei <ioana.ciornei@nxp.com>
Reviewed-by: Ioana Ciornei <ioana.ciornei@nxp.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/20250717022309.3339976-2-make24@iscas.ac.cn
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c |   15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
@@ -4654,12 +4654,19 @@ static int dpaa2_eth_connect_mac(struct
 		return PTR_ERR(dpmac_dev);
 	}
 
-	if (IS_ERR(dpmac_dev) || dpmac_dev->dev.type != &fsl_mc_bus_dpmac_type)
+	if (IS_ERR(dpmac_dev))
 		return 0;
 
+	if (dpmac_dev->dev.type != &fsl_mc_bus_dpmac_type) {
+		err = 0;
+		goto out_put_device;
+	}
+
 	mac = kzalloc(sizeof(struct dpaa2_mac), GFP_KERNEL);
-	if (!mac)
-		return -ENOMEM;
+	if (!mac) {
+		err = -ENOMEM;
+		goto out_put_device;
+	}
 
 	mac->mc_dev = dpmac_dev;
 	mac->mc_io = priv->mc_io;
@@ -4693,6 +4700,8 @@ err_close_mac:
 	dpaa2_mac_close(mac);
 err_free_mac:
 	kfree(mac);
+out_put_device:
+	put_device(&dpmac_dev->dev);
 	return err;
 }
 



