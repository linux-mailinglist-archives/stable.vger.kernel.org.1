Return-Path: <stable+bounces-60823-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C6BF93A595
	for <lists+stable@lfdr.de>; Tue, 23 Jul 2024 20:26:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 397B51C220B2
	for <lists+stable@lfdr.de>; Tue, 23 Jul 2024 18:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 929AF158A09;
	Tue, 23 Jul 2024 18:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MK2TkOjN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE32158A03;
	Tue, 23 Jul 2024 18:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721759158; cv=none; b=MA/CuUn6WcaFO+ZMZPqZOWdfU+9VWXYAFecihua+SIafMnbiza7wf18H2OuAM6UGcoA86oyQPm0/bjqDhUlzlu7pPqDpL5r/j6tLUXWvz88ah9EPefMJj8iGNpgwEb6GmPjkmAaQ8Twawo4Nk0zyMad2iRcASTW2s8AsGCKwl8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721759158; c=relaxed/simple;
	bh=jcyjuQg2K9OJgYf7UrhRFE64ShrNDsxjlmEETHi/7AY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PwbPdeYAu+IfuQlFF1p86mRtExxasQKOdHsSg8y4lIY9zk2kR34ZPImhMfZVL7DSWrVc6DRfmrBm/y8Yni3xJr3E/hl2A9lj+XT78WAe383iQ95PGB4F6LynD14m+vvURxHySFptGdUBh9LF35Bflf/YMMs/Z2BmzbE6SH5kK18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MK2TkOjN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 692EAC4AF0B;
	Tue, 23 Jul 2024 18:25:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721759157;
	bh=jcyjuQg2K9OJgYf7UrhRFE64ShrNDsxjlmEETHi/7AY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MK2TkOjN+K2BG1fQsBD2DV2d8blDSr85saK40v00zSUGODJZUVF8A1nOz7zHA4R+B
	 nLS931PGwwIvST3ooaSD2cTsKazWkKkN4NGIqWfq59pK7Rse8Jt/j/y7ZHAFZoJySo
	 /BLnXG98TXB8k6OGxKX49rTTefH7me9S0ZGhdJHI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Ilan Peer <ilan.peer@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 021/105] wifi: cfg80211: fix 6 GHz scan request building
Date: Tue, 23 Jul 2024 20:22:58 +0200
Message-ID: <20240723180403.778048350@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240723180402.490567226@linuxfoundation.org>
References: <20240723180402.490567226@linuxfoundation.org>
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

[ Upstream commit f7a8b10bfd614d7a9a16fbe80d28ead4f063cb00 ]

The 6 GHz scan request struct allocated by cfg80211_scan_6ghz() is
meant to be formed this way:

 [base struct][channels][ssids][6ghz_params]

It is allocated with [channels] as the maximum number of channels
supported by the driver in the 6 GHz band, since allocation is
before knowing how many there will be.

However, the inner pointers are set incorrectly: initially, the
6 GHz scan parameters pointer is set:

 [base struct][channels]
                        ^ scan_6ghz_params

and later the SSID pointer is set to the end of the actually
_used_ channels.

 [base struct][channels]
                  ^ ssids

If many APs were to be discovered, and many channels used, and
there were many SSIDs, then the SSIDs could overlap the 6 GHz
parameters.

Additionally, the request->ssids for most of the function points
to the original request still (given the struct copy) but is used
normally, which is confusing.

Clear this up, by actually using the allocated space for 6 GHz
parameters _after_ the SSIDs, and set up the SSIDs initially so
they are used more clearly. Just like in nl80211.c, set them
only if there actually are SSIDs though.

Finally, also copy the elements (ie/ie_len) so they're part of
the same request, not pointing to the old request.

Co-developed-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Link: https://msgid.link/20240510113738.4190692ef4ee.I0cb19188be17a8abd029805e3373c0a7777c214c@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/wireless/rdev-ops.h |  6 +++++-
 net/wireless/scan.c     | 47 +++++++++++++++++++++++++++--------------
 2 files changed, 36 insertions(+), 17 deletions(-)

diff --git a/net/wireless/rdev-ops.h b/net/wireless/rdev-ops.h
index ee853a14a02de..5f210686c4110 100644
--- a/net/wireless/rdev-ops.h
+++ b/net/wireless/rdev-ops.h
@@ -2,7 +2,7 @@
 /*
  * Portions of this file
  * Copyright(c) 2016-2017 Intel Deutschland GmbH
- * Copyright (C) 2018, 2021-2023 Intel Corporation
+ * Copyright (C) 2018, 2021-2024 Intel Corporation
  */
 #ifndef __CFG80211_RDEV_OPS
 #define __CFG80211_RDEV_OPS
@@ -446,6 +446,10 @@ static inline int rdev_scan(struct cfg80211_registered_device *rdev,
 			    struct cfg80211_scan_request *request)
 {
 	int ret;
+
+	if (WARN_ON_ONCE(!request->n_ssids && request->ssids))
+		return -EINVAL;
+
 	trace_rdev_scan(&rdev->wiphy, request);
 	ret = rdev->ops->scan(&rdev->wiphy, request);
 	trace_rdev_return_int(&rdev->wiphy, ret);
diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index 3ad4c1032c038..ee4ef32f39b37 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -778,6 +778,7 @@ static int cfg80211_scan_6ghz(struct cfg80211_registered_device *rdev)
 	LIST_HEAD(coloc_ap_list);
 	bool need_scan_psc = true;
 	const struct ieee80211_sband_iftype_data *iftd;
+	size_t size, offs_ssids, offs_6ghz_params, offs_ies;
 
 	rdev_req->scan_6ghz = true;
 
@@ -806,10 +807,15 @@ static int cfg80211_scan_6ghz(struct cfg80211_registered_device *rdev)
 		spin_unlock_bh(&rdev->bss_lock);
 	}
 
-	request = kzalloc(struct_size(request, channels, n_channels) +
-			  sizeof(*request->scan_6ghz_params) * count +
-			  sizeof(*request->ssids) * rdev_req->n_ssids,
-			  GFP_KERNEL);
+	size = struct_size(request, channels, n_channels);
+	offs_ssids = size;
+	size += sizeof(*request->ssids) * rdev_req->n_ssids;
+	offs_6ghz_params = size;
+	size += sizeof(*request->scan_6ghz_params) * count;
+	offs_ies = size;
+	size += rdev_req->ie_len;
+
+	request = kzalloc(size, GFP_KERNEL);
 	if (!request) {
 		cfg80211_free_coloc_ap_list(&coloc_ap_list);
 		return -ENOMEM;
@@ -817,8 +823,26 @@ static int cfg80211_scan_6ghz(struct cfg80211_registered_device *rdev)
 
 	*request = *rdev_req;
 	request->n_channels = 0;
-	request->scan_6ghz_params =
-		(void *)&request->channels[n_channels];
+	request->n_6ghz_params = 0;
+	if (rdev_req->n_ssids) {
+		/*
+		 * Add the ssids from the parent scan request to the new
+		 * scan request, so the driver would be able to use them
+		 * in its probe requests to discover hidden APs on PSC
+		 * channels.
+		 */
+		request->ssids = (void *)request + offs_ssids;
+		memcpy(request->ssids, rdev_req->ssids,
+		       sizeof(*request->ssids) * request->n_ssids);
+	}
+	request->scan_6ghz_params = (void *)request + offs_6ghz_params;
+
+	if (rdev_req->ie_len) {
+		void *ie = (void *)request + offs_ies;
+
+		memcpy(ie, rdev_req->ie, rdev_req->ie_len);
+		request->ie = ie;
+	}
 
 	/*
 	 * PSC channels should not be scanned in case of direct scan with 1 SSID
@@ -906,17 +930,8 @@ static int cfg80211_scan_6ghz(struct cfg80211_registered_device *rdev)
 
 	if (request->n_channels) {
 		struct cfg80211_scan_request *old = rdev->int_scan_req;
-		rdev->int_scan_req = request;
 
-		/*
-		 * Add the ssids from the parent scan request to the new scan
-		 * request, so the driver would be able to use them in its
-		 * probe requests to discover hidden APs on PSC channels.
-		 */
-		request->ssids = (void *)&request->channels[request->n_channels];
-		request->n_ssids = rdev_req->n_ssids;
-		memcpy(request->ssids, rdev_req->ssids, sizeof(*request->ssids) *
-		       request->n_ssids);
+		rdev->int_scan_req = request;
 
 		/*
 		 * If this scan follows a previous scan, save the scan start
-- 
2.43.0




