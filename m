Return-Path: <stable+bounces-158191-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DA1BBAE5759
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 00:28:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7734D7B45B6
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 22:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FB6222422F;
	Mon, 23 Jun 2025 22:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hc6k1r2O"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C456B676;
	Mon, 23 Jun 2025 22:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750717708; cv=none; b=bP7RoTMiKf6AtOwp+w5NpqWQ5VDTAveTXLVK3afP/LdC8TBE+W/4Yjdr1zjAmRUHoCEH9lcF3l3OQMsGVgfZifSyh4ZiMgEx1d154l+MPteJShpy+tNUNt14q2plEuPZhp2a3qUr9k4KCoDPsi4vcauojRosc5o5tbFTfrOfx58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750717708; c=relaxed/simple;
	bh=C9Qy9upGbWEAtHBZV3IB493fLcPi4eRMqMIk4RB1vB4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZcmUbDlot6Rku7r76nWLS6L1BY2CeimdmFrNdqAZs+aa/pAyl0cgNc9VWrCYwloDQ4faFtrFFURFYQiLbQC+LYGuUCqxm1g1gSsZh5V5JGtakfHGiAP9FAUr7pwSx9ojQ4jb1cW9B4HP/mg2Zr9Ri5c4az/5X/bUcx/Q4aQbrfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hc6k1r2O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99145C4CEEA;
	Mon, 23 Jun 2025 22:28:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750717707;
	bh=C9Qy9upGbWEAtHBZV3IB493fLcPi4eRMqMIk4RB1vB4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hc6k1r2OaOuq7S3aUFDQx9TlqsmfQD6UhvKIatqlUQ4hqy46KI44gvVpSbHCaoKtA
	 G5W7vdviZeXU7tfvUfaLfRVX9+8BLH+hqGw8K3N2k1r0QmKvNR1zYKBEqNdt9/tXhU
	 o/KG/B5yB7ixfdb4cnN0WVlDxayhb0cQG0W+l3vs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dmitry Antipov <dmantipov@yandex.ru>,
	Christian Lamparter <chunkeey@gmail.com>,
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 481/508] wifi: carl9170: do not ping device which has failed to load firmware
Date: Mon, 23 Jun 2025 15:08:46 +0200
Message-ID: <20250623130656.903228855@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250623130645.255320792@linuxfoundation.org>
References: <20250623130645.255320792@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dmitry Antipov <dmantipov@yandex.ru>

[ Upstream commit 15d25307692312cec4b57052da73387f91a2e870 ]

Syzkaller reports [1, 2] crashes caused by an attempts to ping
the device which has failed to load firmware. Since such a device
doesn't pass 'ieee80211_register_hw()', an internal workqueue
managed by 'ieee80211_queue_work()' is not yet created and an
attempt to queue work on it causes null-ptr-deref.

[1] https://syzkaller.appspot.com/bug?extid=9a4aec827829942045ff
[2] https://syzkaller.appspot.com/bug?extid=0d8afba53e8fb2633217

Fixes: e4a668c59080 ("carl9170: fix spurious restart due to high latency")
Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
Acked-by: Christian Lamparter <chunkeey@gmail.com>
Link: https://patch.msgid.link/20250616181205.38883-1-dmantipov@yandex.ru
Signed-off-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/carl9170/usb.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/ath/carl9170/usb.c b/drivers/net/wireless/ath/carl9170/usb.c
index a5265997b5767..debac4699687e 100644
--- a/drivers/net/wireless/ath/carl9170/usb.c
+++ b/drivers/net/wireless/ath/carl9170/usb.c
@@ -438,14 +438,21 @@ static void carl9170_usb_rx_complete(struct urb *urb)
 
 		if (atomic_read(&ar->rx_anch_urbs) == 0) {
 			/*
-			 * The system is too slow to cope with
-			 * the enormous workload. We have simply
-			 * run out of active rx urbs and this
-			 * unfortunately leads to an unpredictable
-			 * device.
+			 * At this point, either the system is too slow to
+			 * cope with the enormous workload (so we have simply
+			 * run out of active rx urbs and this unfortunately
+			 * leads to an unpredictable device), or the device
+			 * is not fully functional after an unsuccessful
+			 * firmware loading attempts (so it doesn't pass
+			 * ieee80211_register_hw() and there is no internal
+			 * workqueue at all).
 			 */
 
-			ieee80211_queue_work(ar->hw, &ar->ping_work);
+			if (ar->registered)
+				ieee80211_queue_work(ar->hw, &ar->ping_work);
+			else
+				pr_warn_once("device %s is not registered\n",
+					     dev_name(&ar->udev->dev));
 		}
 	} else {
 		/*
-- 
2.39.5




