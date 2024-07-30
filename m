Return-Path: <stable+bounces-63688-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 456D2941A25
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 18:40:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E45971F220E4
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 16:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A2DE183CDB;
	Tue, 30 Jul 2024 16:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BKtwJrCT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C451A6192;
	Tue, 30 Jul 2024 16:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722357637; cv=none; b=jE04V+8EPiVmOOkO1+3x7RthmvIM+Tgm7Ktj2a9yZhdTle08KMgeCa9cjBlgA1Y5w/Y38HpAXQJO/BuuD7OabEIhI1YVbv+3HTLCT7l5m+7WsUadCGVxX8pTnimx2t0ObR4rapk9widmmUcSekBkgeir87Rtv/ezdQ/yx4VmGas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722357637; c=relaxed/simple;
	bh=rNoXfqTp40M3xyf8FM8085RuMp1UTDNNBbFmpJxN/Xc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nX1udXSyR6iBcx9A95EjY9Nkf8U2pDzdViHzszuYuNtljEoIN9OqOsSLnBNcR0hdIQLd8PyjMgOs6QystMWyvIZ3CAkhsfSQClx4/O4kO+RC56CXM4tBNhTBge7aRkCgxGoVcx+DmWDVosLYfMgR/BHNaxaD7V6z8Kopn8i9xdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BKtwJrCT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A507C4AF0A;
	Tue, 30 Jul 2024 16:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722357637;
	bh=rNoXfqTp40M3xyf8FM8085RuMp1UTDNNBbFmpJxN/Xc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BKtwJrCT/HjY6h0FcdSdQun3bpL0F5p/D31jiy0E11y4KNpHVq6amQN81qzcEcyMU
	 y6ljoYbaq9K4lTXryQJbTcp1uNObTsSKh5SHLkvSv+OabfXnftqNQyZ/XFvMXvtlUx
	 Ws1/xrhzaCC86edKP1QWeXN4JTULKGU6y0V1koXo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Pavel Machek <pavel@ucw.cz>,
	Lee Jones <lee@kernel.org>
Subject: [PATCH 6.1 311/440] leds: mt6360: Fix memory leak in mt6360_init_isnk_properties()
Date: Tue, 30 Jul 2024 17:49:04 +0200
Message-ID: <20240730151627.971883275@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240730151615.753688326@linuxfoundation.org>
References: <20240730151615.753688326@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Javier Carrasco <javier.carrasco.cruz@gmail.com>

commit e41d574b359ccd8d99be65c6f11502efa2b83136 upstream.

The fwnode_for_each_child_node() loop requires manual intervention to
decrement the child refcount in case of an early return.

Add the missing calls to fwnode_handle_put(child) to avoid memory leaks
in the error paths.

Cc: stable@vger.kernel.org
Fixes: 679f8652064b ("leds: Add mt6360 driver")
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Acked-by: Pavel Machek <pavel@ucw.cz>
Link: https://lore.kernel.org/r/20240611-leds-mt6360-memleak-v1-1-93642eb5011e@gmail.com
Signed-off-by: Lee Jones <lee@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/leds/flash/leds-mt6360.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/drivers/leds/flash/leds-mt6360.c
+++ b/drivers/leds/flash/leds-mt6360.c
@@ -637,14 +637,17 @@ static int mt6360_init_isnk_properties(s
 
 			ret = fwnode_property_read_u32(child, "reg", &reg);
 			if (ret || reg > MT6360_LED_ISNK3 ||
-			    priv->leds_active & BIT(reg))
+			    priv->leds_active & BIT(reg)) {
+				fwnode_handle_put(child);
 				return -EINVAL;
+			}
 
 			ret = fwnode_property_read_u32(child, "color", &color);
 			if (ret) {
 				dev_err(priv->dev,
 					"led %d, no color specified\n",
 					led->led_no);
+				fwnode_handle_put(child);
 				return ret;
 			}
 



