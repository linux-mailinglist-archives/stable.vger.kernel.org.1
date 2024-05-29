Return-Path: <stable+bounces-47636-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C6A1F8D35EE
	for <lists+stable@lfdr.de>; Wed, 29 May 2024 14:03:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64A291F25F8A
	for <lists+stable@lfdr.de>; Wed, 29 May 2024 12:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0CA2180A7C;
	Wed, 29 May 2024 12:03:10 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from air.basealt.ru (air.basealt.ru [194.107.17.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 111B9819
	for <stable@vger.kernel.org>; Wed, 29 May 2024 12:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.107.17.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716984190; cv=none; b=RSvE2Qwaz9pkk6O2uBnYLEmNrS2Qjl2LlRNYneLgjgNkgeNZgKXRclcaed7aLzS4wVWzqlkkuSKUpYo/pt2eNNU+k7Hx0uDynjuXxO9fFXKIppYINPGbOAqk8YD9gJxtEPGVWyx/WEJP3XmFjjxNN+3qsGV+5bXKRJDViolz28E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716984190; c=relaxed/simple;
	bh=Fc3rT+cB+dR4DgjK3zj5c7xKdCKtSQoG/hry9rlBFDA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ydi8asHZGx0g/wOinAvfCbYo4CEvZmFptEfGZ2Y2bg0YRTMSV81wpjyFt6BcUri53L7uee8pASXYseYQ75w6hXbBXeP9p1C9o1ThsR+pGTdtuDXfbRNoymv/4VHhidsmhLnPLHL4IE1Ae49wXi38J+px7kDmC6k1Bos1wfd0Hmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=194.107.17.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: by air.basealt.ru (Postfix, from userid 490)
	id EAAE62F2023D; Wed, 29 May 2024 11:56:34 +0000 (UTC)
X-Spam-Level: 
Received: from shell.ipa.basealt.ru (unknown [176.12.98.74])
	by air.basealt.ru (Postfix) with ESMTPSA id BDB922F20231;
	Wed, 29 May 2024 11:56:34 +0000 (UTC)
From: Alexander Ofitserov <oficerovas@altlinux.org>
To: oficerovas@altlinux.org,
	gregkh@linuxfoundation.org,
	Johannes Berg <johannes@sipsolutions.net>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>
Cc: lvc-project@linuxtesting.org,
	dutyrok@altlinux.org,
	kovalev@altlinux.org,
	stable@vger.kernel.org,
	syzbot+de87c09cc7b964ea2e23@syzkaller.appspotmail.com,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 5.10 5.15] wifi: mac80211: apply mcast rate only if interface is up
Date: Wed, 29 May 2024 14:56:32 +0300
Message-ID: <20240529115632.4072486-1-oficerovas@altlinux.org>
X-Mailer: git-send-email 2.42.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

If the interface isn't enabled, don't apply multicast
rate changes immediately.

Reported-by: syzbot+de87c09cc7b964ea2e23@syzkaller.appspotmail.com
Signed-off-by: Johannes Berg <johannes.berg@intel.com>

Backported to 5.10 and 5.15

Signed-off-by: Alexander Ofitserov <oficerovas@altlinux.org>
---
 net/mac80211/cfg.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 45bb6f2755987..ccd60c59b3d87 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -2561,7 +2561,8 @@ static int ieee80211_set_mcast_rate(struct wiphy *wiphy, struct net_device *dev,
 	memcpy(sdata->vif.bss_conf.mcast_rate, rate,
 	       sizeof(int) * NUM_NL80211_BANDS);
 
-	ieee80211_bss_info_change_notify(sdata, BSS_CHANGED_MCAST_RATE);
+	if (ieee80211_sdata_running(sdata))
+		ieee80211_bss_info_change_notify(sdata, BSS_CHANGED_MCAST_RATE);
 
 	return 0;
 }
-- 
2.42.1


