Return-Path: <stable+bounces-9693-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EE88824494
	for <lists+stable@lfdr.de>; Thu,  4 Jan 2024 16:07:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1FB0BB2561D
	for <lists+stable@lfdr.de>; Thu,  4 Jan 2024 15:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF77A241E2;
	Thu,  4 Jan 2024 15:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="byJdWK6U"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893412C6A3
	for <stable@vger.kernel.org>; Thu,  4 Jan 2024 15:02:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0E5AC433C9;
	Thu,  4 Jan 2024 15:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704380577;
	bh=o61bvpvPbZ6oXupalweOfjX85PLubCw2RLxAX4K1Yos=;
	h=Subject:To:From:Date:From;
	b=byJdWK6U/+MczkWywuFkzmkhPhz9WYgw5wMF3yk6UMimm6wWOdRgiErt+2ImTBDV2
	 a0G//nCeL9yuGBlcggNtzeeAi+MPIzR6a1CGOp0yAp2daxyXZOjrqyRUVp7/KV/ViT
	 U2O5F2CmU16ZhOL0uc6npsztQ/51xKSiqh6Fux7E=
Subject: patch "usb: phy: mxs: remove CONFIG_USB_OTG condition for" added to usb-testing
To: xu.yang_2@nxp.com,gregkh@linuxfoundation.org,peter.chen@kernel.org,stable@vger.kernel.org
From: <gregkh@linuxfoundation.org>
Date: Thu, 04 Jan 2024 16:02:24 +0100
Message-ID: <2024010424-regular-dealmaker-34c3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    usb: phy: mxs: remove CONFIG_USB_OTG condition for

to my usb git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git
in the usb-testing branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will be merged to the usb-next branch sometime soon,
after it passes testing, and the merge window is open.

If you have any questions about this process, please let me know.


From ff2b89de471da942a4d853443688113a44fd35ed Mon Sep 17 00:00:00 2001
From: Xu Yang <xu.yang_2@nxp.com>
Date: Thu, 28 Dec 2023 19:07:53 +0800
Subject: usb: phy: mxs: remove CONFIG_USB_OTG condition for
 mxs_phy_is_otg_host()

When CONFIG_USB_OTG is not set, mxs_phy_is_otg_host() will always return
false. This behaviour is wrong. Since phy.last_event will always be set
for either host or device mode. Therefore, CONFIG_USB_OTG condition
can be removed.

Fixes: 5eda42aebb76 ("usb: phy: mxs: fix getting wrong state with mxs_phy_is_otg_host()")
cc:  <stable@vger.kernel.org>
Acked-by: Peter Chen <peter.chen@kernel.org>
Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
Link: https://lore.kernel.org/r/20231228110753.1755756-3-xu.yang_2@nxp.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/phy/phy-mxs-usb.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/usb/phy/phy-mxs-usb.c b/drivers/usb/phy/phy-mxs-usb.c
index acd46b72899e..920a32cd094d 100644
--- a/drivers/usb/phy/phy-mxs-usb.c
+++ b/drivers/usb/phy/phy-mxs-usb.c
@@ -388,8 +388,7 @@ static void __mxs_phy_disconnect_line(struct mxs_phy *mxs_phy, bool disconnect)
 
 static bool mxs_phy_is_otg_host(struct mxs_phy *mxs_phy)
 {
-	return IS_ENABLED(CONFIG_USB_OTG) &&
-		mxs_phy->phy.last_event == USB_EVENT_ID;
+	return mxs_phy->phy.last_event == USB_EVENT_ID;
 }
 
 static void mxs_phy_disconnect_line(struct mxs_phy *mxs_phy, bool on)
-- 
2.43.0



