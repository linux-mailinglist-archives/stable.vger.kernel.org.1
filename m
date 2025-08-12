Return-Path: <stable+bounces-167340-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E370B22F9A
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 19:42:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81E9B17C915
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 17:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 103B82F7461;
	Tue, 12 Aug 2025 17:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0qGAQp3u"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32BC2FA0FD;
	Tue, 12 Aug 2025 17:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755020485; cv=none; b=h+EIiGKhycPeTjbhyoaNgYZh7DeJ1C8zlUNJPXyqk9hPMhNKUNXF3bqKddXZXUp9lphJDfQ1fAEVetgevVAIeV80vm+8rDPQGKdEMLxJm5LTvR3BkC7iDFINAA3CXdSs9fdqwWl+0JavKfbie/ZLQpc0iVNGYNIyBG8R4B10whE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755020485; c=relaxed/simple;
	bh=rc8DpxktdHJSmeMnYKoBSsjfp3rcyrWxo6QF+N9/9js=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X1LB5dr2MVsRm1NLmz6imPSILBegTuIc61FSYZ3oqTJtqfjsNprMKke1obgYewpn7HtISZ3zNs8HIz77oYoEBRkFcyJdj/j0eX9aFrGsT8JOGrFEyL0M4xFcSrXtfFmBr5nDxTaZdAWQMLcESukYdv/id7Sa0x+FWk5GJ8AM3tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0qGAQp3u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E837EC4CEF0;
	Tue, 12 Aug 2025 17:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755020485;
	bh=rc8DpxktdHJSmeMnYKoBSsjfp3rcyrWxo6QF+N9/9js=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=0qGAQp3uR/X2hQZJE5QrBxaAp3eY68xUo8FJG1psGlUA5dwh1iapxWEBF54S1wmvg
	 8I00uF1rtGkjYFNaP6JyvR2ERh28GWIZO70Ya0lWHfumIdpeUoRiCuzSWGtW/r7439
	 FXlwsCx0JCUHTTtr2tMHqvQWws+2c+Ijr3QnWW+k=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Xu Yang <xu.yang_2@nxp.com>,
	Peter Chen <peter.chen@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 060/253] usb: phy: mxs: disconnect line when USB charger is attached
Date: Tue, 12 Aug 2025 19:27:28 +0200
Message-ID: <20250812172951.278820379@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250812172948.675299901@linuxfoundation.org>
References: <20250812172948.675299901@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Xu Yang <xu.yang_2@nxp.com>

[ Upstream commit 87ed257acb0934e08644568df6495988631afd4c ]

For mxs PHY, if there is a vbus but the bus is not enumerated, we need
to force the dp/dm as SE0 from the controller side. If not, there is
possible USB wakeup due to unstable dp/dm, since there is possible no
pull on dp/dm, such as there is a USB charger on the port.

Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
Acked-by: Peter Chen <peter.chen@kernel.org>
Link: https://lore.kernel.org/r/20230627110353.1879477-3-xu.yang_2@nxp.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/phy/phy-mxs-usb.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/phy/phy-mxs-usb.c b/drivers/usb/phy/phy-mxs-usb.c
index 160c9264339f..f3075ff6cd20 100644
--- a/drivers/usb/phy/phy-mxs-usb.c
+++ b/drivers/usb/phy/phy-mxs-usb.c
@@ -394,6 +394,7 @@ static bool mxs_phy_is_otg_host(struct mxs_phy *mxs_phy)
 static void mxs_phy_disconnect_line(struct mxs_phy *mxs_phy, bool on)
 {
 	bool vbus_is_on = false;
+	enum usb_phy_events last_event = mxs_phy->phy.last_event;
 
 	/* If the SoCs don't need to disconnect line without vbus, quit */
 	if (!(mxs_phy->data->flags & MXS_PHY_DISCONNECT_LINE_WITHOUT_VBUS))
@@ -405,7 +406,8 @@ static void mxs_phy_disconnect_line(struct mxs_phy *mxs_phy, bool on)
 
 	vbus_is_on = mxs_phy_get_vbus_status(mxs_phy);
 
-	if (on && !vbus_is_on && !mxs_phy_is_otg_host(mxs_phy))
+	if (on && ((!vbus_is_on && !mxs_phy_is_otg_host(mxs_phy))
+		|| (last_event == USB_EVENT_VBUS)))
 		__mxs_phy_disconnect_line(mxs_phy, true);
 	else
 		__mxs_phy_disconnect_line(mxs_phy, false);
-- 
2.39.5




