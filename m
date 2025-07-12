Return-Path: <stable+bounces-161735-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2930B02B65
	for <lists+stable@lfdr.de>; Sat, 12 Jul 2025 16:26:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0833E4A2B4B
	for <lists+stable@lfdr.de>; Sat, 12 Jul 2025 14:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C9DA27EFF9;
	Sat, 12 Jul 2025 14:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WDGY6Mn3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E15C3275AFB
	for <stable@vger.kernel.org>; Sat, 12 Jul 2025 14:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752330404; cv=none; b=iDMMOetkam2dXNl1XBIBCGPaPH1IPI9fOlbK4NyKAC35vWIQ4dt0rF74uSKh5u6C4NHwQ8YIXNj6G+ExNIjELQoJ1KtvIOyk7SISnXoU3WLykCtgusk1tE8dQvhCihppI70T/xnFegh9z0I7ypen+gmuPKreZ/xg3y4j9V8IAyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752330404; c=relaxed/simple;
	bh=NR76gTZZCvAa1xNLtGabwJZ1wfA6tNcKTQCeH4iRbZI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=JZwVdyRIbaxrMme29AoSSbzoNpxPYfHv3bAp8H+RW//4FEfwkPgxhwM1R44Gbbq+QAyOVvqF4E8fZD1ZBcQxJ39cX95WQgKc/MO91OPxIxV2gODj2NQf+P3bjlDmY1rq//WQ9PaH0aqwQ0Hx4VcP0mfXSxrtzamWJPudyRKfrhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WDGY6Mn3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73408C4CEEF;
	Sat, 12 Jul 2025 14:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752330403;
	bh=NR76gTZZCvAa1xNLtGabwJZ1wfA6tNcKTQCeH4iRbZI=;
	h=Subject:To:Cc:From:Date:From;
	b=WDGY6Mn3UcMJxz3Krdf0+DZBWRMZKjCXCxc3xu65uNUE+d3sGumKK4gxqQ4Dl0Bhm
	 rWIKOYmq/zx/cx/Gwud6UrTOb3IW4MW1c1iuJK7/pbAQ+2CbplYIg3SUKOY7aDmPOV
	 5FSgjiuutHfD9ysf3ne4+kSnBZWqBk6nMjBYRWdM=
Subject: FAILED: patch "[PATCH] wifi: mt76: mt7921: prevent decap offload config before STA" failed to apply to 6.6-stable tree
To: deren.wu@mediatek.com,nbd@nbd.name
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 12 Jul 2025 16:26:31 +0200
Message-ID: <2025071231-projector-jubilance-2909@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 7035a082348acf1d43ffb9ff735899f8e3863f8f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025071231-projector-jubilance-2909@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 7035a082348acf1d43ffb9ff735899f8e3863f8f Mon Sep 17 00:00:00 2001
From: Deren Wu <deren.wu@mediatek.com>
Date: Sun, 25 May 2025 14:11:22 +0800
Subject: [PATCH] wifi: mt76: mt7921: prevent decap offload config before STA
 initialization

The decap offload configuration should only be applied after the STA has
been successfully initialized. Attempting to configure it earlier can lead
to corruption of the MAC configuration in the chip's hardware state.

Add an early check for `msta->deflink.wcid.sta` to ensure the station peer
is properly initialized before proceeding with decapsulation offload
configuration.

Cc: stable@vger.kernel.org
Fixes: 24299fc869f7 ("mt76: mt7921: enable rx header traslation offload")
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
Link: https://patch.msgid.link/f23a72ba7a3c1ad38ba9e13bb54ef21d6ef44ffb.1748149855.git.deren.wu@mediatek.com
Signed-off-by: Felix Fietkau <nbd@nbd.name>

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index 1fffa43379b2..77f73ae1d7ec 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -1180,6 +1180,9 @@ static void mt7921_sta_set_decap_offload(struct ieee80211_hw *hw,
 	struct mt792x_sta *msta = (struct mt792x_sta *)sta->drv_priv;
 	struct mt792x_dev *dev = mt792x_hw_dev(hw);
 
+	if (!msta->deflink.wcid.sta)
+		return;
+
 	mt792x_mutex_acquire(dev);
 
 	if (enabled)


