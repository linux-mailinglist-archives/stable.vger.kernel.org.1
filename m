Return-Path: <stable+bounces-72296-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D156967A0F
	for <lists+stable@lfdr.de>; Sun,  1 Sep 2024 18:51:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB5B01F22EFF
	for <lists+stable@lfdr.de>; Sun,  1 Sep 2024 16:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D63417E900;
	Sun,  1 Sep 2024 16:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2IzxPkB0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A8171C68C;
	Sun,  1 Sep 2024 16:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725209465; cv=none; b=OHYDOoL/9K8MLrmmsWB1q5YzFi/zHhsVu0K/hmDxp/IlkDh9DSiN2wl0ZcgOP25nZTvV0BI7W2TrFnrvK+uZjLjjEPNvZ9RxJL16ueEd66fnNz8z1QEis0LT9HrvYJkvoMDXw8QY8mNgQ3WSlMUmSkXjNbgoFIUvatn5lwTEj1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725209465; c=relaxed/simple;
	bh=FjD8XP88TQwtf7F6zFACmdjcuHGE240j6QyiMOeDQG4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tOfllkOYR/5STyFNqHSkDLgOoUFri8r8ehKNozyISEaJSFIpk4nI2419VU1i2GHuKFi+e4zaC54HL7m9mJsW8zBywleUGAF/iv80MoC+tYnGyU+2TmiZ6Uowwzmz5snns9Zsy0E0nNG0/yjWqj7F3GK7+9CtRSM094JxCKd33c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2IzxPkB0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C360C4CEC3;
	Sun,  1 Sep 2024 16:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725209465;
	bh=FjD8XP88TQwtf7F6zFACmdjcuHGE240j6QyiMOeDQG4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=2IzxPkB07DhEd8yH74tM+T0vMoagFEXFXR0QLprDXne688Zz6t0hWXSoPImW0Blv4
	 PqlosCozX+6RXk8sCC8V8XlJxZ9tlC1w6WOowOwyIbwgbyWJhhmxXCEFHDRih0p1UO
	 BRWK+xjVNTCJDS0vfL9nwZ7S3wwqEn0+km4iYH9A=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Gregory Greenman <gregory.greenman@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 045/151] wifi: iwlwifi: abort scan when rfkill on but device enabled
Date: Sun,  1 Sep 2024 18:16:45 +0200
Message-ID: <20240901160815.803597336@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240901160814.090297276@linuxfoundation.org>
References: <20240901160814.090297276@linuxfoundation.org>
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

From: Miri Korenblit <miriam.rachel.korenblit@intel.com>

[ Upstream commit 3c6a0b1f0add72e7f522bc9145222b86d0a7712a ]

In RFKILL we first set the RFKILL bit, then we abort scan
(if one exists) by waiting for the notification from FW
and notifying mac80211. And then we stop the device.
But in case we have a scan ongoing in the period of time between
rfkill on and before the device is stopped - we will not wait for the
FW notification because of the iwl_mvm_is_radio_killed() condition,
and then the scan_status and uid_status are misconfigured,
(scan_status is cleared but uid_status not)
and when the notification suddenly arrives (before stopping the device)
we will get into the assert about scan_status and uid_status mismatch.
Fix this by waiting for FW notif when rfkill is on but the device isn't
disabled yet.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
Link: https://lore.kernel.org/r/20231004123422.c43b69aa2c77.Icc7b5efb47974d6f499156ff7510b786e177993b@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
index a9df48c75155b..a52af491eed58 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
@@ -2675,7 +2675,7 @@ int iwl_mvm_scan_stop(struct iwl_mvm *mvm, int type, bool notify)
 	if (!(mvm->scan_status & type))
 		return 0;
 
-	if (iwl_mvm_is_radio_killed(mvm)) {
+	if (!test_bit(STATUS_DEVICE_ENABLED, &mvm->trans->status)) {
 		ret = 0;
 		goto out;
 	}
-- 
2.43.0




