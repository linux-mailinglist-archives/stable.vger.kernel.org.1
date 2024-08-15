Return-Path: <stable+bounces-68908-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1493953491
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 16:28:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C77828496C
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 14:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 209991A76AE;
	Thu, 15 Aug 2024 14:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="p0akDgWB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37881A7068;
	Thu, 15 Aug 2024 14:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723732047; cv=none; b=pT9GGup1od8TLcl5tDDvOaKoDe/QgOqJTtznaK0+Y6K+JYDWtJzSApJ0atRPjazYuEvBFNzu3+1cbQmesw0oqTPIuoF/IsoMLx0VWRLTWqdUGrLdE4wJ+L6ffKeGgQcvEBaEvjCNxcgH7N5EM1uPp8tXawinriQ0rWLecr+bU/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723732047; c=relaxed/simple;
	bh=uVykLrzmSHnx6WVosBnGDThZ3i1vqZaATH2+LRHfhas=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u2/1IQ1AeaiM4HJsV50+u7WfPD8dlxyqriFKJfTBUbIp7BPRJQqEo3PuP7Mi9x3Q0r76OOqj/sKvLj6LFvSd9ptWXfP6scWaY7gfraZlaUE3rJTjvhkIIz/lICfdO1/er8ntAL+If5FjPou+5oN3ws9WSwaX4hld4jx7gMNfqHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=p0akDgWB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 568B1C32786;
	Thu, 15 Aug 2024 14:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723732047;
	bh=uVykLrzmSHnx6WVosBnGDThZ3i1vqZaATH2+LRHfhas=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p0akDgWBOANCSAds+ZAU/nIaHv9It2sOsIxq6gewKjIw0UVNT3ASFnEkUq3bmjJ3g
	 /mRvT/twQZgeeJJMiJcGfYR6TWXbNiTfnrCSklslMMoGYd5UxBLZK+nammjwQ70OT3
	 2i0/gGuxDNw6gyxeUy4vuLap0TmNoELb6sXXmJlw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	kernel test robot <lkp@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 059/352] wifi: virt_wifi: dont use strlen() in const context
Date: Thu, 15 Aug 2024 15:22:05 +0200
Message-ID: <20240815131921.522479857@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240815131919.196120297@linuxfoundation.org>
References: <20240815131919.196120297@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

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
index ec730bc44adc1..dd6675436bda6 100644
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




