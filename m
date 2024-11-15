Return-Path: <stable+bounces-93419-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 207049CD92B
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 07:57:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC6321F22C0F
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 06:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75D4118872A;
	Fri, 15 Nov 2024 06:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Aexr92f4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32160185924;
	Fri, 15 Nov 2024 06:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731653863; cv=none; b=A4ol4CTJxoFmu1GPiKklT/yepjosuDhpS4ImeAki650FJES9tc75/7LOWzEApv9I5Aasf2ymDJfMTUMJpwQa/0YuHmUU6gVs/UXyPP/E/aeNRmdEXJrRSeeLIpwNGiwAQTZGhrqimM3TTezOHgNiKrxu8KOEBD82FGV6ZWDaHD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731653863; c=relaxed/simple;
	bh=c+0ftBtWslPt6+ogan5UW0cI12RrQnbt/qaXyH365XM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qj5I58QRbgZk52FlohZgCFayb2e81VcG144Sx6+ATFPjy8qZpiB8DMdCyiTGY017DIE1JrOYFadC2wUf+osEHk22an3lO7CerkPhyPXgkeTqX2EGgvGiO8x3br0UDLf9bZcpLVB1crot/HF29OxRMbfCT6iLza1xAKAUaIbOF6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Aexr92f4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A08B9C4CECF;
	Fri, 15 Nov 2024 06:57:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731653863;
	bh=c+0ftBtWslPt6+ogan5UW0cI12RrQnbt/qaXyH365XM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Aexr92f4yn/VW9svHdKrh5gCngKsm/rDiAXb0JKGFy8SkzOpiMcCNLUTyzuH+L/UW
	 Pp4pjHE9lQs6Ou/tDgI6XponGsjkOZ4UTXTUJmtoKHe2eCie1k7jj0Zw2P2GQN9NsB
	 EXlJNcR+WEohBTo/kFe6d/CwIhJLrYxggOIz6Acs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Zijun Hu <quic_zijuhu@quicinc.com>
Subject: [PATCH 5.10 56/82] usb: musb: sunxi: Fix accessing an released usb phy
Date: Fri, 15 Nov 2024 07:38:33 +0100
Message-ID: <20241115063727.577971152@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241115063725.561151311@linuxfoundation.org>
References: <20241115063725.561151311@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zijun Hu <quic_zijuhu@quicinc.com>

commit 498dbd9aea205db9da674994b74c7bf8e18448bd upstream.

Commit 6ed05c68cbca ("usb: musb: sunxi: Explicitly release USB PHY on
exit") will cause that usb phy @glue->xceiv is accessed after released.

1) register platform driver @sunxi_musb_driver
// get the usb phy @glue->xceiv
sunxi_musb_probe() -> devm_usb_get_phy().

2) register and unregister platform driver @musb_driver
musb_probe() -> sunxi_musb_init()
use the phy here
//the phy is released here
musb_remove() -> sunxi_musb_exit() -> devm_usb_put_phy()

3) register @musb_driver again
musb_probe() -> sunxi_musb_init()
use the phy here but the phy has been released at 2).
...

Fixed by reverting the commit, namely, removing devm_usb_put_phy()
from sunxi_musb_exit().

Fixes: 6ed05c68cbca ("usb: musb: sunxi: Explicitly release USB PHY on exit")
Cc: stable@vger.kernel.org
Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
Link: https://lore.kernel.org/r/20241029-sunxi_fix-v1-1-9431ed2ab826@quicinc.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/musb/sunxi.c |    2 --
 1 file changed, 2 deletions(-)

--- a/drivers/usb/musb/sunxi.c
+++ b/drivers/usb/musb/sunxi.c
@@ -286,8 +286,6 @@ static int sunxi_musb_exit(struct musb *
 	if (test_bit(SUNXI_MUSB_FL_HAS_SRAM, &glue->flags))
 		sunxi_sram_release(musb->controller->parent);
 
-	devm_usb_put_phy(glue->dev, glue->xceiv);
-
 	return 0;
 }
 



