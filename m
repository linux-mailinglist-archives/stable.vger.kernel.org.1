Return-Path: <stable+bounces-24007-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FE9C869230
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 14:33:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49F61293E47
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 13:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03833141995;
	Tue, 27 Feb 2024 13:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gJCgYLHc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4CC313B2BF;
	Tue, 27 Feb 2024 13:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709040766; cv=none; b=cJTDEQzOiQJgHJmQRuz1kTh0dUAhQeRynRM/KOKU7kWi9eStec2UH+zb1fztPYANgc54msdOVLWuJgBq7ijmmcpfCpttmLVkwzPfnq09sAgkfIV0GEK9exGqsHNQ1HmRAjq43PYqJQ1bMaCMNtTPzdYl6wGps2RMLgCNiLEmbVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709040766; c=relaxed/simple;
	bh=xrqg1OgDzEZVdfKfBSM1aLIKo4qf7JlNIDAiJ0fMl9c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nvxVdVjZVzMVEhBRtYI9mh67GfqzQIeLhDmVhCS1j+5oFkX9g7JzMZgS0FP/hpUuHO6WhnB+Goh47uJdvxUdeRXTmKslPYplDMYYl0klXi3rcycqOweiHe64y5c1EydKx6DLDJ1mSeootiXCjeAekTfcbQPwEtIF8EfT0okiiJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gJCgYLHc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 393BBC433C7;
	Tue, 27 Feb 2024 13:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709040766;
	bh=xrqg1OgDzEZVdfKfBSM1aLIKo4qf7JlNIDAiJ0fMl9c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gJCgYLHcocufhIE+CpfCe5WR7k/3u3Gp6pFuTaE5JZuTT+AIXif/9HCL+KwG+Rv7x
	 KiRWv5ulrv1IXteP5AbqMnpiKwg33rpFTfkMYOZMeZt/fdx0G3Pl4GtbturHw7gXow
	 e37EAJpqzvn37s3WXQ7uZcwE/kmUviATBniLnU9A=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 103/334] wifi: mac80211: initialize SMPS mode correctly
Date: Tue, 27 Feb 2024 14:19:21 +0100
Message-ID: <20240227131633.815958136@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240227131630.636392135@linuxfoundation.org>
References: <20240227131630.636392135@linuxfoundation.org>
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

6.7-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit 86b2dac224f963be92634a878888222e1e938f48 ]

The SMPS mode is currently re-initialized too late, since
ieee80211_prep_channel() can be called again after we've
already done ieee80211_setup_assoc_link(), in case there's
some override of the channel configuration. Fix this.

Link: https://msgid.link/20240129195405.d6d74508be18.I0a7303b1ce4d8e5436011951ab624372a445c069@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mac80211/mlme.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 5a03bf1de6bb7..e5525dc174f4c 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -8,7 +8,7 @@
  * Copyright 2007, Michael Wu <flamingice@sourmilk.net>
  * Copyright 2013-2014  Intel Mobile Communications GmbH
  * Copyright (C) 2015 - 2017 Intel Deutschland GmbH
- * Copyright (C) 2018 - 2023 Intel Corporation
+ * Copyright (C) 2018 - 2024 Intel Corporation
  */
 
 #include <linux/delay.h>
@@ -2903,6 +2903,7 @@ static void ieee80211_set_disassoc(struct ieee80211_sub_if_data *sdata,
 
 	/* other links will be destroyed */
 	sdata->deflink.u.mgd.bss = NULL;
+	sdata->deflink.smps_mode = IEEE80211_SMPS_OFF;
 
 	netif_carrier_off(sdata->dev);
 
@@ -5030,9 +5031,6 @@ static int ieee80211_prep_channel(struct ieee80211_sub_if_data *sdata,
 	if (!link)
 		return 0;
 
-	/* will change later if needed */
-	link->smps_mode = IEEE80211_SMPS_OFF;
-
 	/*
 	 * If this fails (possibly due to channel context sharing
 	 * on incompatible channels, e.g. 80+80 and 160 sharing the
@@ -7075,6 +7073,7 @@ void ieee80211_mgd_setup_link(struct ieee80211_link_data *link)
 	link->u.mgd.p2p_noa_index = -1;
 	link->u.mgd.conn_flags = 0;
 	link->conf->bssid = link->u.mgd.bssid;
+	link->smps_mode = IEEE80211_SMPS_OFF;
 
 	wiphy_work_init(&link->u.mgd.request_smps_work,
 			ieee80211_request_smps_mgd_work);
-- 
2.43.0




