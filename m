Return-Path: <stable+bounces-5219-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A7D680BD68
	for <lists+stable@lfdr.de>; Sun, 10 Dec 2023 22:47:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A575B207DA
	for <lists+stable@lfdr.de>; Sun, 10 Dec 2023 21:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02D321CFAF;
	Sun, 10 Dec 2023 21:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=leolam.fr header.i=@leolam.fr header.b="Y8q6aSP5"
X-Original-To: stable@vger.kernel.org
X-Greylist: delayed 477 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 10 Dec 2023 13:47:32 PST
Received: from smtp-bc0c.mail.infomaniak.ch (smtp-bc0c.mail.infomaniak.ch [IPv6:2001:1600:4:17::bc0c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BD99CD
	for <stable@vger.kernel.org>; Sun, 10 Dec 2023 13:47:32 -0800 (PST)
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4SpJDf3SSCzMqKGL;
	Sun, 10 Dec 2023 21:39:30 +0000 (UTC)
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4SpJDf03mqzMpp9s;
	Sun, 10 Dec 2023 22:39:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leolam.fr;
	s=20210220; t=1702244370;
	bh=WJlZL56ffwYy6XwE5X4p1IcwpQ1ZzaknRnS6NkBRZUc=;
	h=From:To:Cc:Subject:Date:From;
	b=Y8q6aSP5zohAHl+CIkkqp/tMLznvT3L3RWB3mF7XtzZMHYzV829leToknw03trIeL
	 7tUvhG0/C7Hc2IN70zCKcDwgrFK3FtiT31uuwUC3Br3DeZWc94i5gTqGDcUM4fyAV/
	 s/6UzUFOk3d0DbIcK7fedhvpR5s302rakg6JwFWo=
From: =?UTF-8?q?L=C3=A9o=20Lam?= <leo@leolam.fr>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?L=C3=A9o=20Lam?= <leo@leolam.fr>
Subject: [PATCH] wifi: nl80211: fix deadlock in nl80211_set_cqm_rssi (6.6.x)
Date: Sun, 10 Dec 2023 21:39:30 +0000
Message-ID: <20231210213930.61378-1-leo@leolam.fr>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Commit 4a7e92551618f3737b305f62451353ee05662f57 ("wifi: cfg80211: fix
CQM for non-range use" on 6.6.x) causes nl80211_set_cqm_rssi not to
release the wdev lock in some situations.

Of course, the ensuing deadlock causes userland network managers to
break pretty badly, and on typical systems this also causes lockups on
on suspend, poweroff and reboot. See [1], [2], [3] for example reports.

The upstream commit, 7e7efdda6adb385fbdfd6f819d76bc68c923c394
("wifi: cfg80211: fix CQM for non-range use"), does not trigger this
issue because the wdev lock does not exist there.

Fix the deadlock by releasing the lock before returning.

[1] https://bugzilla.kernel.org/show_bug.cgi?id=218247
[2] https://bbs.archlinux.org/viewtopic.php?id=290976
[3] https://lore.kernel.org/all/87sf4belmm.fsf@turtle.gmx.de/

Fixes: 4a7e92551618 ("wifi: cfg80211: fix CQM for non-range use")
Cc: stable@vger.kernel.org
Signed-off-by: Léo Lam <leo@leolam.fr>
---
 net/wireless/nl80211.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 6a82dd876f27..0b0dfecedc50 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -12906,17 +12906,23 @@ static int nl80211_set_cqm_rssi(struct genl_info *info,
 					lockdep_is_held(&wdev->mtx));
 
 	/* if already disabled just succeed */
-	if (!n_thresholds && !old)
-		return 0;
+	if (!n_thresholds && !old) {
+		err = 0;
+		goto unlock;
+	}
 
 	if (n_thresholds > 1) {
 		if (!wiphy_ext_feature_isset(&rdev->wiphy,
 					     NL80211_EXT_FEATURE_CQM_RSSI_LIST) ||
-		    !rdev->ops->set_cqm_rssi_range_config)
-			return -EOPNOTSUPP;
+		    !rdev->ops->set_cqm_rssi_range_config) {
+			err = -EOPNOTSUPP;
+			goto unlock;
+		}
 	} else {
-		if (!rdev->ops->set_cqm_rssi_config)
-			return -EOPNOTSUPP;
+		if (!rdev->ops->set_cqm_rssi_config) {
+			err = -EOPNOTSUPP;
+			goto unlock;
+		}
 	}
 
 	if (n_thresholds) {
-- 
2.43.0


