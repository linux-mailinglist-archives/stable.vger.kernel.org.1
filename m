Return-Path: <stable+bounces-164500-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A40F6B0FA47
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 20:28:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A836A3B90A7
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 18:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C78F422A80D;
	Wed, 23 Jul 2025 18:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cS31vF9X"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D1F1E7C38
	for <stable@vger.kernel.org>; Wed, 23 Jul 2025 18:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753295276; cv=none; b=UY7n2gf5P0nD08fJAN5870/888FU33chMb+89W9S5IJJNLFjfCaaBfBjNLx0RuH5qPLJKWhaC1chddxh08yVi806O9RFOg91paOj8FRSsu54W52HcaYno/+Atrg2F/XKluf/RvXKBx1bjyVZ3oovdDjjqrkTL/mbpyci4aoOPpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753295276; c=relaxed/simple;
	bh=XJX4MJo+UILzfw79icIxhYTrIZ2ncufBfsnKkQeK5rI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AVqNLDuIwz05fYmVmPT5TqjLGrHSZKwMRFi6bmD1mBlTMlg7Pv2WfvpI9gKTOP+VEB5S5Dr5te5gGruQ6jQZ1pC6orILrSKGq8ZaUv+EWWg9RLiZmL/kx1Knz5JTG1oQpkdzefA4eFYUVJKdEyOhjAWmQKAySMYPrn9rUbyS5es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cS31vF9X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41C1BC4CEE7;
	Wed, 23 Jul 2025 18:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753295276;
	bh=XJX4MJo+UILzfw79icIxhYTrIZ2ncufBfsnKkQeK5rI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cS31vF9XZ97nYb8oC463rA8gaRKOO4/EdwpinXoCkmY+pyHQH0x6Pg1peV8Wm3ZuD
	 qm6pga88ph3R2fbNEcgZkZtpE+DRqJZvwkafxPLLNlisb7O2PcOjSWFL1MYfiBIKhd
	 mJiKb4rFe6uCWDvylIzcrWRwQic4JT3oxSs3yaBjV0xmU9jQ0voZuSHLBTmSYV4/vc
	 OpXQ/4oifdUtBvoDaht1fKFm75nvnxEfGwnTOWWbtSIgcZh9aL8NJqy0JjyW0LtrvJ
	 Srk4SykVXCUofZZhYReMZavdIDlKKgWR+2taH9mn3rttFoLZzjGHASK7Yyz02IxbMR
	 d2OvrUMNVtBVw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Deren Wu <deren.wu@mediatek.com>,
	Felix Fietkau <nbd@nbd.name>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] wifi: mt76: mt7921: prevent decap offload config before STA initialization
Date: Wed, 23 Jul 2025 14:27:51 -0400
Message-Id: <20250723182751.1096863-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <2025071231-projector-jubilance-2909@gregkh>
References: <2025071231-projector-jubilance-2909@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Deren Wu <deren.wu@mediatek.com>

[ Upstream commit 7035a082348acf1d43ffb9ff735899f8e3863f8f ]

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
[ Changed msta->deflink.wcid.sta to msta->wcid.sta ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7921/main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index 8e2ec39563317..15b7d22d3639f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -1087,6 +1087,9 @@ static void mt7921_sta_set_decap_offload(struct ieee80211_hw *hw,
 	struct mt792x_sta *msta = (struct mt792x_sta *)sta->drv_priv;
 	struct mt792x_dev *dev = mt792x_hw_dev(hw);
 
+	if (!msta->wcid.sta)
+		return;
+
 	mt792x_mutex_acquire(dev);
 
 	if (enabled)
-- 
2.39.5


