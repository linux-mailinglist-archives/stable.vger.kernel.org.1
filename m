Return-Path: <stable+bounces-85044-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65CB999D36E
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 17:35:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11B3B1F22EF7
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 15:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0281A1AC8A2;
	Mon, 14 Oct 2024 15:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="V0RRm6T1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B480B1AC427;
	Mon, 14 Oct 2024 15:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728920110; cv=none; b=q5pCvzprefb3AF87mB71IVKugBYzKgQuD1wckzbr16NX5sqNAzNiAyMCruqoDp4fK6h+8YSio2hNFJuLlv/lZ0f0XiZwgjc7ZHjqXDpsgoftQzR+sWZ3yP5Sy4MEMgnDCCX/HSHia0HA2aMUhqCqoAwpIOpcVe4NcU1ndskFGXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728920110; c=relaxed/simple;
	bh=KG9xQB3E1idac/N5nwGjkF+5qV+5WOMPn/dTkWcjlOg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q0aQi4LwOzA8pr8jlqyDgP26WYcgPkTuAXFx5hAtRnHQXJh8vDReAU7a5yn0oQJU1THvKauL+tni15XKdEuQ6b6q/9p7DM5Fy3OYUtvPPRO3YN/TA022C70cJaMm0lYnXmLrz1BhTlzYcqkmYuTAYjOecBAbaEzW1H/kkpVxikA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=V0RRm6T1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB53EC4CEC7;
	Mon, 14 Oct 2024 15:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728920110;
	bh=KG9xQB3E1idac/N5nwGjkF+5qV+5WOMPn/dTkWcjlOg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V0RRm6T1a+G0GonZ+r/Q5w5Gp6gls2eoLASOqiBfXy6t+/N1LfecvaRvYacqvAuaE
	 5s/VkwQwlA8AuJue4NuE8lbPcE+xGQ/lQjOkWsameNJs988lFdUOrIK5rvD5JBR7Lp
	 QVD+nNoBqeTYqc7OLLqq0S+ZDKAORMO//jbdM0oY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kees Cook <kees@kernel.org>,
	Kenton Groombridge <concord@gentoo.org>,
	Johannes Berg <johannes.berg@intel.com>,
	Xiangyu Chen <xiangyu.chen@windriver.com>,
	Sasha Levin <sashal@kernel.org>,
	Kees Cook <keescook@chromium.org>
Subject: [PATCH 6.1 768/798] wifi: mac80211: Avoid address calculations via out of bounds array indexing
Date: Mon, 14 Oct 2024 16:22:02 +0200
Message-ID: <20241014141248.238508357@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241014141217.941104064@linuxfoundation.org>
References: <20241014141217.941104064@linuxfoundation.org>
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

From: Kenton Groombridge <concord@gentoo.org>

[ Upstream commit 2663d0462eb32ae7c9b035300ab6b1523886c718 ]

req->n_channels must be set before req->channels[] can be used.

This patch fixes one of the issues encountered in [1].

[   83.964255] UBSAN: array-index-out-of-bounds in net/mac80211/scan.c:364:4
[   83.964258] index 0 is out of range for type 'struct ieee80211_channel *[]'
[...]
[   83.964264] Call Trace:
[   83.964267]  <TASK>
[   83.964269]  dump_stack_lvl+0x3f/0xc0
[   83.964274]  __ubsan_handle_out_of_bounds+0xec/0x110
[   83.964278]  ieee80211_prep_hw_scan+0x2db/0x4b0
[   83.964281]  __ieee80211_start_scan+0x601/0x990
[   83.964291]  nl80211_trigger_scan+0x874/0x980
[   83.964295]  genl_family_rcv_msg_doit+0xe8/0x160
[   83.964298]  genl_rcv_msg+0x240/0x270
[...]

[1] https://bugzilla.kernel.org/show_bug.cgi?id=218810

Co-authored-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Kees Cook <kees@kernel.org>
Signed-off-by: Kenton Groombridge <concord@gentoo.org>
Link: https://msgid.link/20240605152218.236061-1-concord@gentoo.org
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
[Xiangyu: Modified to apply on 6.1.y and 6.6.y]
Signed-off-by: Xiangyu Chen <xiangyu.chen@windriver.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mac80211/scan.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/net/mac80211/scan.c b/net/mac80211/scan.c
index 0a6e40bd42f62..edbf468e0bea3 100644
--- a/net/mac80211/scan.c
+++ b/net/mac80211/scan.c
@@ -357,7 +357,8 @@ static bool ieee80211_prep_hw_scan(struct ieee80211_sub_if_data *sdata)
 	struct cfg80211_scan_request *req;
 	struct cfg80211_chan_def chandef;
 	u8 bands_used = 0;
-	int i, ielen, n_chans;
+	int i, ielen;
+	u32 *n_chans;
 	u32 flags = 0;
 
 	req = rcu_dereference_protected(local->scan_req,
@@ -367,34 +368,34 @@ static bool ieee80211_prep_hw_scan(struct ieee80211_sub_if_data *sdata)
 		return false;
 
 	if (ieee80211_hw_check(&local->hw, SINGLE_SCAN_ON_ALL_BANDS)) {
+		local->hw_scan_req->req.n_channels = req->n_channels;
+
 		for (i = 0; i < req->n_channels; i++) {
 			local->hw_scan_req->req.channels[i] = req->channels[i];
 			bands_used |= BIT(req->channels[i]->band);
 		}
-
-		n_chans = req->n_channels;
 	} else {
 		do {
 			if (local->hw_scan_band == NUM_NL80211_BANDS)
 				return false;
 
-			n_chans = 0;
+			n_chans = &local->hw_scan_req->req.n_channels;
+			*n_chans = 0;
 
 			for (i = 0; i < req->n_channels; i++) {
 				if (req->channels[i]->band !=
 				    local->hw_scan_band)
 					continue;
-				local->hw_scan_req->req.channels[n_chans] =
+				local->hw_scan_req->req.channels[(*n_chans)++] =
 							req->channels[i];
-				n_chans++;
+
 				bands_used |= BIT(req->channels[i]->band);
 			}
 
 			local->hw_scan_band++;
-		} while (!n_chans);
+		} while (!*n_chans);
 	}
 
-	local->hw_scan_req->req.n_channels = n_chans;
 	ieee80211_prepare_scan_chandef(&chandef, req->scan_width);
 
 	if (req->flags & NL80211_SCAN_FLAG_MIN_PREQ_CONTENT)
-- 
2.43.0




