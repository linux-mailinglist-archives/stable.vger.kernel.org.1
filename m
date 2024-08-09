Return-Path: <stable+bounces-66276-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98BD894D23C
	for <lists+stable@lfdr.de>; Fri,  9 Aug 2024 16:32:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 422951F22A50
	for <lists+stable@lfdr.de>; Fri,  9 Aug 2024 14:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45EC9192B9A;
	Fri,  9 Aug 2024 14:32:19 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from air.basealt.ru (air.basealt.ru [194.107.17.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C8C3197A76
	for <stable@vger.kernel.org>; Fri,  9 Aug 2024 14:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.107.17.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723213939; cv=none; b=XAMjGqoi3vUPHG6ZY8/ZMFbchUFZETnySlj9WHJaNi0hhaa91dQlo1eFAZWg1RZh0zHaS6xtkkEib6jUv9B8KwSgSmv6EBRbBAZwL2AIXArRqohPk/QCj/bFhHmfMuXeOWV3vYY2wZvzAl6FflafEEXsW8R28DjQavGfd71ERT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723213939; c=relaxed/simple;
	bh=D7BrfeSltrCH0avDP7QS/TjumZjqfLCIg9JFiWEDlbo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CjnIDW3sXlqQuQUVlTliidTREGgEnFeDSu1gAScsaXHjAn/LxYYnShUVSmzys78HvCGyokAbTuLxHecLoCX7zckpzMKjwmMIAyueJglIi5YPzvKhxUAm3661bsb71JlpgGVX5flhCb2uWuIwSirAPQfK644AWwqnpnH/d9Plres=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=194.107.17.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: by air.basealt.ru (Postfix, from userid 490)
	id A512C2F2026A; Fri,  9 Aug 2024 14:24:13 +0000 (UTC)
X-Spam-Level: 
Received: from dutyrok-pc.ipa.basealt.ru (unknown [194.247.22.88])
	by air.basealt.ru (Postfix) with ESMTPSA id 443792F20265;
	Fri,  9 Aug 2024 14:24:13 +0000 (UTC)
From: Alexandr Shashkin <dutyrok@altlinux.org>
To: stable@vger.kernel.org
Cc: Alexandr Shashkin <dutyrok@altlinux.org>,
	lvc-project@linuxtesting.org,
	Johannes Berg <johannes@sipsolutions.net>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	kovalev@altlinux.org,
	syzbot+de87c09cc7b964ea2e23@syzkaller.appspotmail.com,
	Johannes Berg <johannes.berg@intel.com>,
	Alexander Ofitserov <oficerovas@altlinux.org>
Subject: [PATCH v2 5.10/5.15] wifi: mac80211: apply mcast rate only if interface is up
Date: Fri,  9 Aug 2024 17:23:48 +0300
Message-ID: <20240809142348.534379-1-dutyrok@altlinux.org>
X-Mailer: git-send-email 2.42.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Upstream commit 02c665f048a439c0d58cc45334c94634bd7c18e6 ]

If the interface isn't enabled, don't apply multicast
rate changes immediately.

Reported-by: syzbot+de87c09cc7b964ea2e23@syzkaller.appspotmail.com
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
[oficerovas: Backported to 5.10 and 5.15]
Signed-off-by: Alexander Ofitserov <oficerovas@altlinux.org>
Signed-off-by: Alexandr Shashkin <dutyrok@altlinux.org>
---
Changes in v2:
- edit comment of oficerovas and add upstream commit
---
 net/mac80211/cfg.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 0c3da7771b48..13ac16026129 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -2560,7 +2560,8 @@ static int ieee80211_set_mcast_rate(struct wiphy *wiphy, struct net_device *dev,
 	memcpy(sdata->vif.bss_conf.mcast_rate, rate,
 	       sizeof(int) * NUM_NL80211_BANDS);
 
-	ieee80211_bss_info_change_notify(sdata, BSS_CHANGED_MCAST_RATE);
+	if (ieee80211_sdata_running(sdata))
+		ieee80211_bss_info_change_notify(sdata, BSS_CHANGED_MCAST_RATE);
 
 	return 0;
 }
-- 
2.42.2


