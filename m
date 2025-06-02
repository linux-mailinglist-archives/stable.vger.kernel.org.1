Return-Path: <stable+bounces-150444-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC75FACB795
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 17:29:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F317944C17
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 15:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B4BB227E8E;
	Mon,  2 Jun 2025 15:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PmwMtcTb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 547CF1C84DC;
	Mon,  2 Jun 2025 15:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748877143; cv=none; b=IsKGCK7qeOpTaS8tkTUl+BySOZiaZ+bMYZxzHjIZZ6JXR+kdJPkvZCc1vBlninOfNozNGv0fUsCOz4AqHeSstS1W+4k5Jk65vm8odl9w1Jlaa6Wd2Ud+U4B3KQjc9SKXhXyr82+DpjKEYwft54/uezNHHlWWizN3OKckUQP6kK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748877143; c=relaxed/simple;
	bh=8hdhj9sOibrqLjRmG2S/wNVbk3hm4ZKJeDhwRqZMY6U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eoipIRl7bqtcWKVcD8ujeK7e8oy+RvXm40JwXOZDAiPbT6StFumjQmr18VCu5hkxtiR2Eeec43UuQlfJJ/RTGiUpxv7sHB6LtbBKIO52X9gcJXxs5bQP02CMsf77JvpLlNb8b7bOkx3/bPENo+AdJLViYK8ijqZj1ztGBoSUdUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PmwMtcTb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88694C4CEEE;
	Mon,  2 Jun 2025 15:12:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748877143;
	bh=8hdhj9sOibrqLjRmG2S/wNVbk3hm4ZKJeDhwRqZMY6U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PmwMtcTbVqfwSHfAIbY36PUi0IUVcX8flrEunYciRV5nWMRZb59HOjlgC2pk43giA
	 5kfIB5r/N/qfl8P7rmd8E/cd/1JZUyjGQFPtF9TST/+fJ8pZsgVwaduc49ZgSGJ+d2
	 1u8LBpV2A7/6Tcq17fJmUL0BbkvBLXsD2Sxnfi+A=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Johannes Berg <johannes.berg@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 186/325] wifi: mac80211: dont unconditionally call drv_mgd_complete_tx()
Date: Mon,  2 Jun 2025 15:47:42 +0200
Message-ID: <20250602134327.365177546@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250602134319.723650984@linuxfoundation.org>
References: <20250602134319.723650984@linuxfoundation.org>
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

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit 1798271b3604b902d45033ec569f2bf77e94ecc2 ]

We might not have called drv_mgd_prepare_tx(), so only call
drv_mgd_complete_tx() under the same conditions.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Reviewed-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Link: https://patch.msgid.link/20250205110958.e091fc39a351.Ie6a3cdca070612a0aa4b3c6914ab9ed602d1f456@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mac80211/mlme.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 9a5530ca2f6b2..8f0e6d7fe7167 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -2896,7 +2896,8 @@ static void ieee80211_set_disassoc(struct ieee80211_sub_if_data *sdata,
 	if (tx)
 		ieee80211_flush_queues(local, sdata, false);
 
-	drv_mgd_complete_tx(sdata->local, sdata, &info);
+	if (tx || frame_buf)
+		drv_mgd_complete_tx(sdata->local, sdata, &info);
 
 	/* clear AP addr only after building the needed mgmt frames */
 	eth_zero_addr(sdata->deflink.u.mgd.bssid);
-- 
2.39.5




