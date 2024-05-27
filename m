Return-Path: <stable+bounces-46691-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42D038D0ADA
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 21:04:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A514EB224AD
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 19:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 136E815FCF0;
	Mon, 27 May 2024 19:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LslM40Jt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6777D518;
	Mon, 27 May 2024 19:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716836606; cv=none; b=XBOWEXYPeGFUuMpeeX2t59wPE1Z+ZQ5S2+66YI65xiu02IVsmFzCuMyqP6rJKXIUJx3CffDMeCzhDOcHw0KR5tPcSwHz2wLllbnIt+avy4WH2VeUCZRuG0Izm/pKG6VQtiwnKdfBJMw1/y8G9hR3Qe+TK1XHuwxMBTwVKmryy6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716836606; c=relaxed/simple;
	bh=26fOH7Z1GlvvlbQvbwX4wBiuqGyhs38zj5RWvKpMLY0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rfywF65yn3H92HkVJUfD9nTPaM1AultM3JfLbX7RyE6TG9cXH3NJZChMGBg3kq7CQ7vuK7VgA4sCJ/MAu40f2r/IGZ3M049eSPT2s0o7ipOdte0Rk3KZi7sadlmK2qYwMjd8CB9Ilx/FlqJTWYBExXd1Em0VzMFD3Vuu4p4U2tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LslM40Jt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4829FC2BBFC;
	Mon, 27 May 2024 19:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716836605;
	bh=26fOH7Z1GlvvlbQvbwX4wBiuqGyhs38zj5RWvKpMLY0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LslM40JtbHKf1Fn6my98KNkgWQI+1IAbeo7VRt1ZpoXxlo3eHUNnaTIT0mgYu9evS
	 Eszu79dudFAks1uFZsMeZmScnsxq4l9K4NcomDoHKqvUv1EyN7gQKwtRs7XLtPMUhi
	 pSGPauCt4OV9rjfzFoCp6Fl/hPcVVVeoUJq7HO7k=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Baochen Qiang <quic_bqiang@quicinc.com>,
	Kalle Valo <quic_kvalo@quicinc.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.9 092/427] wifi: ath11k: dont force enable power save on non-running vdevs
Date: Mon, 27 May 2024 20:52:19 +0200
Message-ID: <20240527185610.306105869@linuxfoundation.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240527185601.713589927@linuxfoundation.org>
References: <20240527185601.713589927@linuxfoundation.org>
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

6.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Baochen Qiang <quic_bqiang@quicinc.com>

[ Upstream commit 01296b39d3515f20a1db64d3c421c592b1e264a0 ]

Currently we force enable power save on non-running vdevs, this results
in unexpected ping latency in below scenarios:
	1. disable power save from userspace.
	2. trigger suspend/resume.

With step 1 power save is disabled successfully and we get a good latency:

PING 192.168.1.1 (192.168.1.1) 56(84) bytes of data.
64 bytes from 192.168.1.1: icmp_seq=1 ttl=64 time=5.13 ms
64 bytes from 192.168.1.1: icmp_seq=2 ttl=64 time=5.45 ms
64 bytes from 192.168.1.1: icmp_seq=3 ttl=64 time=5.99 ms
64 bytes from 192.168.1.1: icmp_seq=4 ttl=64 time=6.34 ms
64 bytes from 192.168.1.1: icmp_seq=5 ttl=64 time=4.47 ms
64 bytes from 192.168.1.1: icmp_seq=6 ttl=64 time=6.45 ms

While after step 2, the latency becomes much larger:

PING 192.168.1.1 (192.168.1.1) 56(84) bytes of data.
64 bytes from 192.168.1.1: icmp_seq=1 ttl=64 time=17.7 ms
64 bytes from 192.168.1.1: icmp_seq=2 ttl=64 time=15.0 ms
64 bytes from 192.168.1.1: icmp_seq=3 ttl=64 time=14.3 ms
64 bytes from 192.168.1.1: icmp_seq=4 ttl=64 time=16.5 ms
64 bytes from 192.168.1.1: icmp_seq=5 ttl=64 time=20.1 ms

The reason is, with step 2, power save is force enabled due to vdev not
running, although mac80211 was trying to disable it to honor userspace
configuration:

ath11k_pci 0000:03:00.0: wmi cmd sta powersave mode psmode 1 vdev id 0
Call Trace:
 ath11k_wmi_pdev_set_ps_mode
 ath11k_mac_op_bss_info_changed
 ieee80211_bss_info_change_notify
 ieee80211_reconfig
 ieee80211_resume
 wiphy_resume

This logic is taken from ath10k where it was added due to below comment:

	Firmware doesn't behave nicely and consumes more power than
	necessary if PS is disabled on a non-started vdev.

However we don't know whether such an issue also occurs to ath11k firmware
or not. But even if it does, it's not appropriate because it goes against
userspace, even cfg/mac80211 don't know we have enabled it in fact.

Remove it to fix this issue. In this way we not only get a better latency,
but also, and the most important, keeps the consistency between userspace
and kernel/driver. The biggest price for that would be the power consumption,
which is not that important, compared with the consistency.

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.30

Fixes: b2beffa7d9a6 ("ath11k: enable 802.11 power save mode in station mode")
Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
Link: https://msgid.link/20240309113115.11498-1-quic_bqiang@quicinc.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath11k/mac.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 9f4bf41a3d41e..2fca415322aec 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -1231,14 +1231,7 @@ static int ath11k_mac_vif_setup_ps(struct ath11k_vif *arvif)
 
 	enable_ps = arvif->ps;
 
-	if (!arvif->is_started) {
-		/* mac80211 can update vif powersave state while disconnected.
-		 * Firmware doesn't behave nicely and consumes more power than
-		 * necessary if PS is disabled on a non-started vdev. Hence
-		 * force-enable PS for non-running vdevs.
-		 */
-		psmode = WMI_STA_PS_MODE_ENABLED;
-	} else if (enable_ps) {
+	if (enable_ps) {
 		psmode = WMI_STA_PS_MODE_ENABLED;
 		param = WMI_STA_PS_PARAM_INACTIVITY_TIME;
 
-- 
2.43.0




