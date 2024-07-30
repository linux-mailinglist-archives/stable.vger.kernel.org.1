Return-Path: <stable+bounces-63152-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C0AC94179D
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 18:13:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B44371F217C7
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 16:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45B671898FE;
	Tue, 30 Jul 2024 16:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zFp92soA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0057918A92F;
	Tue, 30 Jul 2024 16:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722355840; cv=none; b=t6px63klpjjrEdLtLp+iNb73xiPfBCgBXkXrYsw5JEfMnTmBeGZhI++HA68+EJYqt/KhTUcqsJfl33vJ6dGi2AJ5E26g/qe6WqIDWk2WVAs7I5jbvdL8DoD0oewkgzkgDIkKML1TgQqQ7DXtmqlGR2uwU38VsPo+b13cA1tj+x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722355840; c=relaxed/simple;
	bh=YMYqgsBI6zJDjIbLMm6fFUo2s7EbWB/KgsaP35ZZXfQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fApzPOgCSTPMeCwjqvtZEy2Oa0ADZaYCJG7A4AF2X/F/Jgs/6obvjxQq5unLXtZAazpyuXXH83PPlmUchHPqbWBFB7gvOq1ArnxtEI00t2noczvaA72GV1pISVDizzT9pl960Ivs+toAxA802nzRzsJ7gp03vBoGOjq324slA7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zFp92soA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13644C32782;
	Tue, 30 Jul 2024 16:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722355839;
	bh=YMYqgsBI6zJDjIbLMm6fFUo2s7EbWB/KgsaP35ZZXfQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=zFp92soA/PGJdySNvRh3+qZI5/vgAwpnryhiLKH5awFUVSMndvcP4YQB5uZe0bd7n
	 UE+SBg/ghNjTbfHPii/rm46nlzhTFnfVlLtXZjd7+LV3L4aKYZQa0ENuyJpF8ST9ag
	 rJqP7f/UFsPYw/YPmnMjceSrX3rcdm1ZmrGYmtaQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	kernel test robot <lkp@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 117/440] wifi: virt_wifi: dont use strlen() in const context
Date: Tue, 30 Jul 2024 17:45:50 +0200
Message-ID: <20240730151620.460164668@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240730151615.753688326@linuxfoundation.org>
References: <20240730151615.753688326@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit 6e909f489191b365364e9d636dec33b5dfd4e5eb ]

Looks like not all compilers allow strlen(constant) as
a constant, so don't do that. Instead, revert back to
defining the length as the first submission had it.

Fixes: b5d14b0c6716 ("wifi: virt_wifi: avoid reporting connection success with wrong SSID")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202407090934.NnR1TUbW-lkp@intel.com/
Closes: https://lore.kernel.org/oe-kbuild-all/202407090944.mpwLHGt9-lkp@intel.com/
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/virt_wifi.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/virt_wifi.c b/drivers/net/wireless/virt_wifi.c
index cf1eb41e282a9..fb4d95a027fef 100644
--- a/drivers/net/wireless/virt_wifi.c
+++ b/drivers/net/wireless/virt_wifi.c
@@ -137,6 +137,7 @@ static struct ieee80211_supported_band band_5ghz = {
 static u8 fake_router_bssid[ETH_ALEN] __ro_after_init = {};
 
 #define VIRT_WIFI_SSID "VirtWifi"
+#define VIRT_WIFI_SSID_LEN 8
 
 static void virt_wifi_inform_bss(struct wiphy *wiphy)
 {
@@ -148,7 +149,7 @@ static void virt_wifi_inform_bss(struct wiphy *wiphy)
 		u8 ssid[8];
 	} __packed ssid = {
 		.tag = WLAN_EID_SSID,
-		.len = strlen(VIRT_WIFI_SSID),
+		.len = VIRT_WIFI_SSID_LEN,
 		.ssid = VIRT_WIFI_SSID,
 	};
 
@@ -262,7 +263,7 @@ static void virt_wifi_connect_complete(struct work_struct *work)
 		container_of(work, struct virt_wifi_netdev_priv, connect.work);
 	u8 *requested_bss = priv->connect_requested_bss;
 	bool right_addr = ether_addr_equal(requested_bss, fake_router_bssid);
-	bool right_ssid = priv->connect_requested_ssid_len == strlen(VIRT_WIFI_SSID) &&
+	bool right_ssid = priv->connect_requested_ssid_len == VIRT_WIFI_SSID_LEN &&
 			  !memcmp(priv->connect_requested_ssid, VIRT_WIFI_SSID,
 				  priv->connect_requested_ssid_len);
 	u16 status = WLAN_STATUS_SUCCESS;
-- 
2.43.0




