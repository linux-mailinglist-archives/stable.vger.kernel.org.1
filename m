Return-Path: <stable+bounces-89856-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7517F9BD206
	for <lists+stable@lfdr.de>; Tue,  5 Nov 2024 17:15:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D0131F225EB
	for <lists+stable@lfdr.de>; Tue,  5 Nov 2024 16:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 975BAB640;
	Tue,  5 Nov 2024 16:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YUWQQiaQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584A013E3EF
	for <stable@vger.kernel.org>; Tue,  5 Nov 2024 16:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730823339; cv=none; b=HxF8xFwpf3HViuqZEK3H5ZIcGmrczjeFSjVFWSYtEjs5AZ4lmmS205Bq0v+Xzwemlu6QK7KMW7d7XWqyaO3nviuOQyuNYHCDgY34TTR3mZKVIsRwg+JzljUW3xWSBWQy1XSZghkFw4PFy3OZPpbNz0L12CGR3ASUWMk48L35UEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730823339; c=relaxed/simple;
	bh=Tl0vIuqEejTMx0RfmDKIG2lgkdQ1YfIyxJy9fbVflmo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=unvSfih32CAWS1lraUH3ektqRoWfAoB3fq9Z0JtxDG5ZbnQjzWzlYwu2KAzmS4Ek5OF6VMdfH9Y/b3KSeenFUKvx5R57mQ+Oogcq59TZnfrw96L8HfgQpgqC0xaTLNaIIbdmfd9u4dPGDtMj7l3VM3K85bG+chfM6DHyxL8inQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YUWQQiaQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 818F7C4CECF;
	Tue,  5 Nov 2024 16:15:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730823338;
	bh=Tl0vIuqEejTMx0RfmDKIG2lgkdQ1YfIyxJy9fbVflmo=;
	h=Subject:To:Cc:From:Date:From;
	b=YUWQQiaQ+nT/YjFg/p243a94jx/ltvNsdS8LV3nIuOw35avOVMLfTx9MbwUr7DCFo
	 rJQ5iH3Ap2CoHAdccY5yCKLRcA24kW5nL9BGtPwGcQCGf5C7fcq5lh+Uzc2MjaP2Ib
	 /V6JQi3RCg0zVkSyj7gufFIYhCkF6OWuhJxEjG7k=
Subject: FAILED: patch "[PATCH] wifi: iwlwifi: mvm: fix 6 GHz scan construction" failed to apply to 6.6-stable tree
To: johannes.berg@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 05 Nov 2024 17:15:21 +0100
Message-ID: <2024110521-antler-uneatable-d873@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 7245012f0f496162dd95d888ed2ceb5a35170f1a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024110521-antler-uneatable-d873@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 7245012f0f496162dd95d888ed2ceb5a35170f1a Mon Sep 17 00:00:00 2001
From: Johannes Berg <johannes.berg@intel.com>
Date: Wed, 23 Oct 2024 09:17:44 +0200
Subject: [PATCH] wifi: iwlwifi: mvm: fix 6 GHz scan construction

If more than 255 colocated APs exist for the set of all
APs found during 2.4/5 GHz scanning, then the 6 GHz scan
construction will loop forever since the loop variable
has type u8, which can never reach the number found when
that's bigger than 255, and is stored in a u32 variable.
Also move it into the loops to have a smaller scope.

Using a u32 there is fine, we limit the number of APs in
the scan list and each has a limit on the number of RNR
entries due to the frame size. With a limit of 1000 scan
results, a frame size upper bound of 4096 (really it's
more like ~2300) and a TBTT entry size of at least 11,
we get an upper bound for the number of ~372k, well in
the bounds of a u32.

Cc: stable@vger.kernel.org
Fixes: eae94cf82d74 ("iwlwifi: mvm: add support for 6GHz")
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219375
Link: https://patch.msgid.link/20241023091744.f4baed5c08a1.I8b417148bbc8c5d11c101e1b8f5bf372e17bf2a7@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
index 3ce9150213a7..ddcbd80a49fb 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
@@ -1774,7 +1774,7 @@ iwl_mvm_umac_scan_cfg_channels_v7_6g(struct iwl_mvm *mvm,
 			&cp->channel_config[ch_cnt];
 
 		u32 s_ssid_bitmap = 0, bssid_bitmap = 0, flags = 0;
-		u8 j, k, n_s_ssids = 0, n_bssids = 0;
+		u8 k, n_s_ssids = 0, n_bssids = 0;
 		u8 max_s_ssids, max_bssids;
 		bool force_passive = false, found = false, allow_passive = true,
 		     unsolicited_probe_on_chan = false, psc_no_listen = false;
@@ -1799,7 +1799,7 @@ iwl_mvm_umac_scan_cfg_channels_v7_6g(struct iwl_mvm *mvm,
 		cfg->v5.iter_count = 1;
 		cfg->v5.iter_interval = 0;
 
-		for (j = 0; j < params->n_6ghz_params; j++) {
+		for (u32 j = 0; j < params->n_6ghz_params; j++) {
 			s8 tmp_psd_20;
 
 			if (!(scan_6ghz_params[j].channel_idx == i))
@@ -1873,7 +1873,7 @@ iwl_mvm_umac_scan_cfg_channels_v7_6g(struct iwl_mvm *mvm,
 		 * SSID.
 		 * TODO: improve this logic
 		 */
-		for (j = 0; j < params->n_6ghz_params; j++) {
+		for (u32 j = 0; j < params->n_6ghz_params; j++) {
 			if (!(scan_6ghz_params[j].channel_idx == i))
 				continue;
 


