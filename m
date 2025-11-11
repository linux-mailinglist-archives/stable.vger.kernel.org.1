Return-Path: <stable+bounces-193950-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 48FB0C4A95F
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 02:33:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 613CB344A2C
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 01:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A05E23C4F2;
	Tue, 11 Nov 2025 01:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pi0R+DmR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 236B026E146;
	Tue, 11 Nov 2025 01:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762824448; cv=none; b=hbmr+qWj5u+moZSJzS6KkhPWe//Ae8y0feVLrSjNWup6WB+/Qt9qqOuaxxu1Xqj2hlqmcPJrmvv6CTkVCbr0qnhJVlcoq1ZFQFkVdxGAwukuHIQHYG1SfR3cxdjy8jcvddrQcKERBQWtryBC0aEkSN7GOw/Xqh81TL0kuBcSjGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762824448; c=relaxed/simple;
	bh=1JaIySDXTn5wr+Ll4OW9Glkus8qj88oqQg6/5Mi0ozY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NSlMYNuEZ5DrOdjGQnoN82lVgRf6ojB9G1r0kOcsFgeKc7IXiFIpAAFN6dEZ0GoXeDZL5ojtu09snR+fJfLFW8rD+EMm+QghSij40jhUPLGoZHN/T7xXBWcf/32nuAlqRKs1nnLWUDTpvUjLGLs3kY8CbcZ8EMxJ2SwR+uDBQ30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pi0R+DmR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4F6EC16AAE;
	Tue, 11 Nov 2025 01:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1762824448;
	bh=1JaIySDXTn5wr+Ll4OW9Glkus8qj88oqQg6/5Mi0ozY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pi0R+DmR95WFYVdZpG2VukpK30mP38okC5OAp3Gfk+zMb4GfHl3NaiI1YGX/SfRxc
	 /5i+vbe4bKJvyPlFcyoZUGsqfvAnYSo76ah0k0CVEpD7BpSBIgX8u7FJbRlViFLWTM
	 aIvGYwDjexyhvO/K64Aka1JNvT7649efMdatc6gM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ilan Peer <ilan.peer@intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.17 502/849] wifi: mac80211: Fix HE capabilities element check
Date: Tue, 11 Nov 2025 09:41:12 +0900
Message-ID: <20251111004548.569938646@linuxfoundation.org>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251111004536.460310036@linuxfoundation.org>
References: <20251111004536.460310036@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ilan Peer <ilan.peer@intel.com>

[ Upstream commit ea928544f3215fdeac24d66bef85e10bb638b8c1 ]

The element data length check did not account for the extra
octet used for the extension ID. Fix it.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Link: https://patch.msgid.link/20250907115109.8da0012e2286.I8c0c69a0011f7153c13b365b14dfef48cfe7c3e3@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mac80211/mlme.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index c1b13b3411cdb..24a35fccca9de 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -5733,7 +5733,7 @@ static u8 ieee80211_max_rx_chains(struct ieee80211_link_data *link,
 	he_cap_elem = cfg80211_find_ext_elem(WLAN_EID_EXT_HE_CAPABILITY,
 					     ies->data, ies->len);
 
-	if (!he_cap_elem || he_cap_elem->datalen < sizeof(*he_cap))
+	if (!he_cap_elem || he_cap_elem->datalen < sizeof(*he_cap) + 1)
 		return chains;
 
 	/* skip one byte ext_tag_id */
-- 
2.51.0




