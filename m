Return-Path: <stable+bounces-203617-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 71DA4CE7114
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 15:37:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EF6083016EE7
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 14:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6790329379;
	Mon, 29 Dec 2025 14:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Z45BnTYH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743F02D6E53
	for <stable@vger.kernel.org>; Mon, 29 Dec 2025 14:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767018648; cv=none; b=T/PZ6grEIr7t4du4Idv2W5btPKg0WdEjf5xjh/NOCkHMZNUZZB9Yst6LmgowNoFtpYA4Gn0Yr2BjAQlwsXuKFP6toWRk41ptTOZfbC3b+boxJYtNzTZtc0/j79Bl8jeZ12UEtr6lvHD1EeK2QRmiQuXMKVDTmu4oAXyC4Xa5e5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767018648; c=relaxed/simple;
	bh=tFM4C0nhq9pUJMg7woAeWOcsWO5LcC5e3jttUSNVkFE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=TSjr/gaRmhrMZea9KreymQQCO1+24oGsP7yU8oCmUIp9Zs3xjMWqor2wsieB0CLqFhaWCv3oBZ7lOPf/2jwOuP8Fk9+pM7+Z6KmttqDkCZPrQdwgjJtwZ7vmul/J4HXz3D+M5yeiHMp2ngw6ABFxd49mWHjq/LQYr8uOKH3NrG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Z45BnTYH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC256C4CEF7;
	Mon, 29 Dec 2025 14:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767018648;
	bh=tFM4C0nhq9pUJMg7woAeWOcsWO5LcC5e3jttUSNVkFE=;
	h=Subject:To:Cc:From:Date:From;
	b=Z45BnTYHmKgoY0lfW0CeN6W7xtetgX0Vv8KQ3PoNkazWBWr7x4GvMvAAT5lZN0JkF
	 D8q54b0FWS/Pcf9uj8/CMPcyaJvXeD/tWiSTkxzMMpZ1J9UckBtv9XaAhlfhS2PXZm
	 1jqCLPu0XA9fn3Etl6S87H8VxJ0tvBRvFxfHLqHQ=
Subject: FAILED: patch "[PATCH] r8169: fix RTL8117 Wake-on-Lan in DASH mode" failed to apply to 5.15-stable tree
To: rene@exactco.de,hkallweit1@gmail.com,kuba@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 29 Dec 2025 15:30:45 +0100
Message-ID: <2025122945-mold-ducktail-63db@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x dd75c723ef566f7f009c047f47e0eee95fe348ab
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025122945-mold-ducktail-63db@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From dd75c723ef566f7f009c047f47e0eee95fe348ab Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Ren=C3=A9=20Rebe?= <rene@exactco.de>
Date: Tue, 2 Dec 2025 19:41:37 +0100
Subject: [PATCH] r8169: fix RTL8117 Wake-on-Lan in DASH mode
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Wake-on-Lan does currently not work for r8169 in DASH mode, e.g. the
ASUS Pro WS X570-ACE with RTL8168fp/RTL8117.

Fix by not returning early in rtl_prepare_power_down when dash_enabled.
While this fixes WoL, it still kills the OOB RTL8117 remote management
BMC connection. Fix by not calling rtl8168_driver_stop if WoL is enabled.

Fixes: 065c27c184d6 ("r8169: phy power ops")
Signed-off-by: René Rebe <rene@exactco.de>
Cc: stable@vger.kernel.org
Reviewed-by: Heiner Kallweit <hkallweit1@gmail.com>
Link: https://patch.msgid.link/20251202.194137.1647877804487085954.rene@exactco.de
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 405e91eb3141..755083852eef 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -2655,9 +2655,6 @@ static void rtl_wol_enable_rx(struct rtl8169_private *tp)
 
 static void rtl_prepare_power_down(struct rtl8169_private *tp)
 {
-	if (tp->dash_enabled)
-		return;
-
 	if (tp->mac_version == RTL_GIGA_MAC_VER_32 ||
 	    tp->mac_version == RTL_GIGA_MAC_VER_33)
 		rtl_ephy_write(tp, 0x19, 0xff64);
@@ -4812,7 +4809,7 @@ static void rtl8169_down(struct rtl8169_private *tp)
 	rtl_disable_exit_l1(tp);
 	rtl_prepare_power_down(tp);
 
-	if (tp->dash_type != RTL_DASH_NONE)
+	if (tp->dash_type != RTL_DASH_NONE && !tp->saved_wolopts)
 		rtl8168_driver_stop(tp);
 }
 


