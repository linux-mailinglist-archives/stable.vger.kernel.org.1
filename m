Return-Path: <stable+bounces-131601-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41E11A80AFE
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 15:11:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E69D71B86B0B
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 13:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BDD126E172;
	Tue,  8 Apr 2025 12:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1rokN2oV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA0F26E165;
	Tue,  8 Apr 2025 12:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744116838; cv=none; b=CcnPH7i4wN0G3XlnkjbEHteCyGpKLGi3eXnINSRsQYNygf+PDYCtlNEIA+E3l9EpM0O+SivQUvfbz9muG6tbZ+KZ6UMI4o4dkFKWrcpxN+q4COIuHgdRPamU3SU/Rq8GACT4iTD/w/ChlPTFj3QmghsgrS2VBq4uGu9ljWUyEWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744116838; c=relaxed/simple;
	bh=fNXvy3eA+W2vJm9Jbfn6qFcpLe61f8t4SxZWcWxyXXI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KKd+7dHVwoQqLdpqvfZe8njEZkNp05z1Ta2NNc85wLtSeLUY87Uh3TTyLZ7vYsdngKLYLcsQPP3yXI8/XQC1LwcMuF/tanglTiHpHUF5TsXRQHjgvKG8beUd6FCkIHQyKDv9ctilg3Dn1dSHcNXQikdwsK63B6RhlSQte0Lmebs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1rokN2oV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E81EAC4CEE5;
	Tue,  8 Apr 2025 12:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744116838;
	bh=fNXvy3eA+W2vJm9Jbfn6qFcpLe61f8t4SxZWcWxyXXI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=1rokN2oVfsY5CygsgIji8lyqV24BfkqD60WHy+K+dLAqPJv6dVjgyzIFFxLn8ljy6
	 9Urt0Ayk3atCHon5zM9fS24B8XAOmoI4eB5tuF5RYK5BXjkZ9jiboKstsAqlfkUxpS
	 2eZysuafp/JgeOjFTNo3RTYFMZt0BficBCJmKmE4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 287/423] wifi: mac80211: flush the station before moving it to UN-AUTHORIZED state
Date: Tue,  8 Apr 2025 12:50:13 +0200
Message-ID: <20250408104852.463604757@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408104845.675475678@linuxfoundation.org>
References: <20250408104845.675475678@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

[ Upstream commit 43e04077170799d0e6289f3e928f727e401b3d79 ]

We first want to flush the station to make sure we no longer have any
frames being Tx by the station before the station is moved to
un-authorized state. Failing to do that will lead to races: a frame may
be sent after the station's state has been changed.

Since the API clearly states that the driver can't fail the sta_state()
transition down the list of state, we can easily flush the station
first, and only then call the driver's sta_state().

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Link: https://patch.msgid.link/20250306123626.450bc40e8b04.I636ba96843c77f13309c15c9fd6eb0c5a52a7976@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mac80211/sta_info.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index aa22f09e6d145..49095f19a0f22 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -4,7 +4,7 @@
  * Copyright 2006-2007	Jiri Benc <jbenc@suse.cz>
  * Copyright 2013-2014  Intel Mobile Communications GmbH
  * Copyright (C) 2015 - 2017 Intel Deutschland GmbH
- * Copyright (C) 2018-2023 Intel Corporation
+ * Copyright (C) 2018-2024 Intel Corporation
  */
 
 #include <linux/module.h>
@@ -1317,9 +1317,13 @@ static int _sta_info_move_state(struct sta_info *sta,
 		sta->sta.addr, new_state);
 
 	/* notify the driver before the actual changes so it can
-	 * fail the transition
+	 * fail the transition if the state is increasing.
+	 * The driver is required not to fail when the transition
+	 * is decreasing the state, so first, do all the preparation
+	 * work and only then, notify the driver.
 	 */
-	if (test_sta_flag(sta, WLAN_STA_INSERTED)) {
+	if (new_state > sta->sta_state &&
+	    test_sta_flag(sta, WLAN_STA_INSERTED)) {
 		int err = drv_sta_state(sta->local, sta->sdata, sta,
 					sta->sta_state, new_state);
 		if (err)
@@ -1395,6 +1399,16 @@ static int _sta_info_move_state(struct sta_info *sta,
 		break;
 	}
 
+	if (new_state < sta->sta_state &&
+	    test_sta_flag(sta, WLAN_STA_INSERTED)) {
+		int err = drv_sta_state(sta->local, sta->sdata, sta,
+					sta->sta_state, new_state);
+
+		WARN_ONCE(err,
+			  "Driver is not allowed to fail if the sta_state is transitioning down the list: %d\n",
+			  err);
+	}
+
 	sta->sta_state = new_state;
 
 	return 0;
-- 
2.39.5




