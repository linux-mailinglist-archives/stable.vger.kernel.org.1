Return-Path: <stable+bounces-54438-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2449B90EE2A
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 15:26:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50893B24681
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 13:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCC5514601E;
	Wed, 19 Jun 2024 13:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2WYNCGbo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1B04D9EA;
	Wed, 19 Jun 2024 13:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718803580; cv=none; b=ApR9b6NtSVTGQwQuTn5n4Qdj1jUOXhlsvTDBT6nJAUXfdx7MFT6aAGZo5yMzM1vk64xdxEwV9k6fiiSpQOeWC+ngW/hjjFLmJFsjSYcD8U0I1BJ4GbRxhjhn6orxfT9Y+umvZE12Xr8io5TRoj5KaEH5a7LQiLs/9tEO/sKBPUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718803580; c=relaxed/simple;
	bh=Q98XYqB3xw86TJD6JtP2So2e3TwSW1HetVtST8OLTnM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h1wzaXnXx/Vp6JkhW7n81Q1jKKh1Hwr3CoxkR7xhtzPXcliuKezYf43fp1Gcb5p0Ae9ZYFOLPwxpSI/GguzTBf661r8/fPIhqFfOO7imf1hJxvPMaqJDOm9WVqOs5pQZQfbn4Yj4SgUlb9MIlYUD9J4yDocx+tmpsbsZqNH9Vlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2WYNCGbo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00AF4C2BBFC;
	Wed, 19 Jun 2024 13:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718803580;
	bh=Q98XYqB3xw86TJD6JtP2So2e3TwSW1HetVtST8OLTnM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=2WYNCGboFDsQ+6LxYj6A/b73gUFQd9MQGNEGwm0iFBtyFqaI60s2d9MNjmpsKo4lG
	 kO4gD1QPY1uCL8LK46vaXDd8w94Vkx5JmZoksTZ/XGaQXNIg6TngLnqBexuMyBXJXP
	 UMb2SA+oZlwbYz/99TY6E+3h7Xq5bG0cDc9RBu+U=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Remi Pommarel <repk@triplefau.lt>,
	Nicolas Escande <nico.escande@gmail.com>,
	Antonio Quartulli <a@unstable.cc>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 004/217] wifi: cfg80211: Lock wiphy in cfg80211_get_station
Date: Wed, 19 Jun 2024 14:54:07 +0200
Message-ID: <20240619125556.668099942@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240619125556.491243678@linuxfoundation.org>
References: <20240619125556.491243678@linuxfoundation.org>
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

From: Remi Pommarel <repk@triplefau.lt>

[ Upstream commit 642f89daa34567d02f312d03e41523a894906dae ]

Wiphy should be locked before calling rdev_get_station() (see lockdep
assert in ieee80211_get_station()).

This fixes the following kernel NULL dereference:

 Unable to handle kernel NULL pointer dereference at virtual address 0000000000000050
 Mem abort info:
   ESR = 0x0000000096000006
   EC = 0x25: DABT (current EL), IL = 32 bits
   SET = 0, FnV = 0
   EA = 0, S1PTW = 0
   FSC = 0x06: level 2 translation fault
 Data abort info:
   ISV = 0, ISS = 0x00000006
   CM = 0, WnR = 0
 user pgtable: 4k pages, 48-bit VAs, pgdp=0000000003001000
 [0000000000000050] pgd=0800000002dca003, p4d=0800000002dca003, pud=08000000028e9003, pmd=0000000000000000
 Internal error: Oops: 0000000096000006 [#1] SMP
 Modules linked in: netconsole dwc3_meson_g12a dwc3_of_simple dwc3 ip_gre gre ath10k_pci ath10k_core ath9k ath9k_common ath9k_hw ath
 CPU: 0 PID: 1091 Comm: kworker/u8:0 Not tainted 6.4.0-02144-g565f9a3a7911-dirty #705
 Hardware name: RPT (r1) (DT)
 Workqueue: bat_events batadv_v_elp_throughput_metric_update
 pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
 pc : ath10k_sta_statistics+0x10/0x2dc [ath10k_core]
 lr : sta_set_sinfo+0xcc/0xbd4
 sp : ffff000007b43ad0
 x29: ffff000007b43ad0 x28: ffff0000071fa900 x27: ffff00000294ca98
 x26: ffff000006830880 x25: ffff000006830880 x24: ffff00000294c000
 x23: 0000000000000001 x22: ffff000007b43c90 x21: ffff800008898acc
 x20: ffff00000294c6e8 x19: ffff000007b43c90 x18: 0000000000000000
 x17: 445946354d552d78 x16: 62661f7200000000 x15: 57464f445946354d
 x14: 0000000000000000 x13: 00000000000000e3 x12: d5f0acbcebea978e
 x11: 00000000000000e3 x10: 000000010048fe41 x9 : 0000000000000000
 x8 : ffff000007b43d90 x7 : 000000007a1e2125 x6 : 0000000000000000
 x5 : ffff0000024e0900 x4 : ffff800000a0250c x3 : ffff000007b43c90
 x2 : ffff00000294ca98 x1 : ffff000006831920 x0 : 0000000000000000
 Call trace:
  ath10k_sta_statistics+0x10/0x2dc [ath10k_core]
  sta_set_sinfo+0xcc/0xbd4
  ieee80211_get_station+0x2c/0x44
  cfg80211_get_station+0x80/0x154
  batadv_v_elp_get_throughput+0x138/0x1fc
  batadv_v_elp_throughput_metric_update+0x1c/0xa4
  process_one_work+0x1ec/0x414
  worker_thread+0x70/0x46c
  kthread+0xdc/0xe0
  ret_from_fork+0x10/0x20
 Code: a9bb7bfd 910003fd a90153f3 f9411c40 (f9402814)

This happens because STA has time to disconnect and reconnect before
batadv_v_elp_throughput_metric_update() delayed work gets scheduled. In
this situation, ath10k_sta_state() can be in the middle of resetting
arsta data when the work queue get chance to be scheduled and ends up
accessing it. Locking wiphy prevents that.

Fixes: 7406353d43c8 ("cfg80211: implement cfg80211_get_station cfg80211 API")
Signed-off-by: Remi Pommarel <repk@triplefau.lt>
Reviewed-by: Nicolas Escande <nico.escande@gmail.com>
Acked-by: Antonio Quartulli <a@unstable.cc>
Link: https://msgid.link/983b24a6a176e0800c01aedcd74480d9b551cb13.1716046653.git.repk@triplefau.lt
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/wireless/util.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/wireless/util.c b/net/wireless/util.c
index f433f3fdd9e94..73b3648e1b4c3 100644
--- a/net/wireless/util.c
+++ b/net/wireless/util.c
@@ -2202,6 +2202,7 @@ int cfg80211_get_station(struct net_device *dev, const u8 *mac_addr,
 {
 	struct cfg80211_registered_device *rdev;
 	struct wireless_dev *wdev;
+	int ret;
 
 	wdev = dev->ieee80211_ptr;
 	if (!wdev)
@@ -2213,7 +2214,11 @@ int cfg80211_get_station(struct net_device *dev, const u8 *mac_addr,
 
 	memset(sinfo, 0, sizeof(*sinfo));
 
-	return rdev_get_station(rdev, dev, mac_addr, sinfo);
+	wiphy_lock(&rdev->wiphy);
+	ret = rdev_get_station(rdev, dev, mac_addr, sinfo);
+	wiphy_unlock(&rdev->wiphy);
+
+	return ret;
 }
 EXPORT_SYMBOL(cfg80211_get_station);
 
-- 
2.43.0




