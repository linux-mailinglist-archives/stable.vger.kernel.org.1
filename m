Return-Path: <stable+bounces-73437-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33E4C96D4DD
	for <lists+stable@lfdr.de>; Thu,  5 Sep 2024 11:57:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 676CC1C248B6
	for <lists+stable@lfdr.de>; Thu,  5 Sep 2024 09:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22E9D198841;
	Thu,  5 Sep 2024 09:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2bIRCF+W"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D4519755E;
	Thu,  5 Sep 2024 09:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725530227; cv=none; b=jXOD1viPj1+okUJM9DQ8Blt2DXmj8OKZV11pIELZcAW3/8UQOAbJnamjFOq9jlcBXgPobZ5Rtwii4bVyAtkYqChEjTk/58cAHc0k/jUiRyE+HWP0oitLJmTx6qMpa8048EN9pb5Can11WlWGBKUOvyCW0q2WV81EW2A54CabY60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725530227; c=relaxed/simple;
	bh=N5Ws0LrBrAaysssaZTfSqwrAa1LLYX4u0YL/W7jkj2I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fjq5DU6SN7AD5bOKZCjqsA5WVkbcd8ZuhxBFszOkiYPPUk6ayceD1orGm9FF6/e9eR/BrfKWeVFsiPGmrn7FRkTEobPiMy99CxjV5ia7OK3YQg2LJEZDRmVdLP7IVeLsEr9WK92z2HAa85er0IEJE5zYYXkksyr0uvMB7oNqw1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2bIRCF+W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FDB7C4CEC3;
	Thu,  5 Sep 2024 09:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725530227;
	bh=N5Ws0LrBrAaysssaZTfSqwrAa1LLYX4u0YL/W7jkj2I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=2bIRCF+WpUdktqvzGRQuKLj43YkJnm4X8eyX2UGGBam41iSCU41FoBs2EwKmyj1rT
	 TD65ZeuDfNBmMA8GHb3mcDXOfUP/Ien0wlnhxKdlze6PwC7L05KT0GlyBCGtrpENmN
	 m/l3hdY6s3ukHmm9nySufmn6z6cW1Uw0OAFg+9cc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 092/132] wifi: mac80211: check ieee80211_bss_info_change_notify() against MLD
Date: Thu,  5 Sep 2024 11:41:19 +0200
Message-ID: <20240905093725.821837481@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240905093722.230767298@linuxfoundation.org>
References: <20240905093722.230767298@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit a0ca76e5b7d550fcd74753d5fdaaf23f1a9bfdb4 ]

It's not valid to call ieee80211_bss_info_change_notify() with
an sdata that's an MLD, remove the FIXME comment (it's not true)
and add a warning.

Reviewed-by: Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Link: https://msgid.link/20240523121140.97a589b13d24.I61988788d81fb3cf97a490dfd3167f67a141d1fd@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mac80211/main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/main.c b/net/mac80211/main.c
index 066424e62ff0..71d60f57a886 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -215,6 +215,8 @@ void ieee80211_bss_info_change_notify(struct ieee80211_sub_if_data *sdata,
 
 	might_sleep();
 
+	WARN_ON_ONCE(ieee80211_vif_is_mld(&sdata->vif));
+
 	if (!changed || sdata->vif.type == NL80211_IFTYPE_AP_VLAN)
 		return;
 
@@ -247,7 +249,6 @@ void ieee80211_bss_info_change_notify(struct ieee80211_sub_if_data *sdata,
 	if (changed & ~BSS_CHANGED_VIF_CFG_FLAGS) {
 		u64 ch = changed & ~BSS_CHANGED_VIF_CFG_FLAGS;
 
-		/* FIXME: should be for each link */
 		trace_drv_link_info_changed(local, sdata, &sdata->vif.bss_conf,
 					    changed);
 		if (local->ops->link_info_changed)
-- 
2.43.0




