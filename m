Return-Path: <stable+bounces-72464-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5219967ABC
	for <lists+stable@lfdr.de>; Sun,  1 Sep 2024 19:00:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73A06281BD0
	for <lists+stable@lfdr.de>; Sun,  1 Sep 2024 17:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F53B183CAB;
	Sun,  1 Sep 2024 17:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AxLShZdp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29D517B50B;
	Sun,  1 Sep 2024 17:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725210010; cv=none; b=esEavgSQS+laxlAwR5Lc6GGTPyokY176VmDlf9J2zc2ZwcVKXs+eFRuWmFfOICqWSvdpkIEqjemJpoBokVLLgvnVLBLQ6gfjacnJWfyXhE7c0QaSAMIGmfyrf7WDVXn6R8jClc4B1WMsthiGQgA2N8MlRkSGjO/uCu/7P4XU/aA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725210010; c=relaxed/simple;
	bh=3kUNCAqIXL/M6l00jj7Yh6uI9H/KFpe21QdQvdM2LCw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZgVS3HnphSC/MCChlnXARDWwND0ftuLrLwEgFbEoswIXJfpfltYrucJKa9lSvPLCD+1ZQ3cr8MoZK8mYeQwEhICVUC04+FImpRIPRg2+84jwWYD/8UTBPhV1MvY6DdpT+VI7iQ5F8twX9BX5cm94j7ED7Jf67MDQ+7fNwoyKtcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AxLShZdp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33DDFC4CEC3;
	Sun,  1 Sep 2024 17:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725210010;
	bh=3kUNCAqIXL/M6l00jj7Yh6uI9H/KFpe21QdQvdM2LCw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AxLShZdpgRRPpd5OFV7vRa/ZX1QBl7ZT9wJdfo8/MNbYa+JwWBZD0T8r19P2P4zge
	 e3N9YSOTjFMf2wIM91fzyCzsvX8QZ1COCNFf4Dymu2cILPm07Htiiq1l97r9Jc666z
	 HcwN6e+rScRxsDAsv/tbq8Spqi8/AbPCv5MR81MA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Gregory Greenman <gregory.greenman@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 060/215] wifi: iwlwifi: abort scan when rfkill on but device enabled
Date: Sun,  1 Sep 2024 18:16:12 +0200
Message-ID: <20240901160825.624612805@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240901160823.230213148@linuxfoundation.org>
References: <20240901160823.230213148@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

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
index 8179a7395bcaf..4bab14ceef5f5 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
@@ -3068,7 +3068,7 @@ int iwl_mvm_scan_stop(struct iwl_mvm *mvm, int type, bool notify)
 	if (!(mvm->scan_status & type))
 		return 0;
 
-	if (iwl_mvm_is_radio_killed(mvm)) {
+	if (!test_bit(STATUS_DEVICE_ENABLED, &mvm->trans->status)) {
 		ret = 0;
 		goto out;
 	}
-- 
2.43.0




