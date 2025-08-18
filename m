Return-Path: <stable+bounces-170281-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80C54B2A3BE
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 15:13:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A74217512D
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 13:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE02F31B11A;
	Mon, 18 Aug 2025 13:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Zc3NTU5G"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 681EE1F462D;
	Mon, 18 Aug 2025 13:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755522127; cv=none; b=K7ZEWkSYsc50NseWvsY/D8cuGaCZ5yt1cwncIcExdi0ftgnzvAWnF1JhxxKICM8Tt/xcH9jH2wBmqxGuvrm9kHC2TMXwvk10+4YMTeTlmJHozKEu78SIhHDFSAUhTZ+D3MUUIkKWKt/cGzd0bqINbXdOdyeHa0k5oQt7Dxied38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755522127; c=relaxed/simple;
	bh=7TVdYu8t87gsewO/0MG1BwcgxYfbzdiCTufkYnjwOmA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OauaPKpjrMDDhi/xlgDdMtl7Az6mnLIWb3+9Py3tSwp91YxJ0WZW/hIe01ZhZnn842pNinELhZex7NA1pSViHLX9aEVebPJ17t1v8KbNWF4n3ybFc+T7YKDrCk6TUe0JbZHZSCFZoA7E6N5R0N053K5TVRw+nKJWG99NK9RZpd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Zc3NTU5G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9D38C4CEEB;
	Mon, 18 Aug 2025 13:02:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755522127;
	bh=7TVdYu8t87gsewO/0MG1BwcgxYfbzdiCTufkYnjwOmA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Zc3NTU5GRoo+PaNyRWgvWXWL9tIePaltBv+Rp4cfQHuyq+MeivCRulTjmo6CXq6Ia
	 b5PIP6BXZk4CLTn1KncAshFRyNOj/WhUx34jW8A6ydjuLiNs4DA4r+xqxgOoZ+/CX0
	 PWAZvPyoPX4IX1/GNKqZUAn1nbjsFoFYHyGPasoE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Johannes Berg <johannes.berg@intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 190/444] wifi: mac80211: dont unreserve never reserved chanctx
Date: Mon, 18 Aug 2025 14:43:36 +0200
Message-ID: <20250818124455.991616928@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250818124448.879659024@linuxfoundation.org>
References: <20250818124448.879659024@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit a6d521bafcb290294128a51b13dbf4baae5748fc ]

If a link has no chanctx, indicating it is an inactive link
that we tracked CSA for, then attempting to unreserve the
reserved chanctx will throw a warning and fail, since there
never was a reserved chanctx. Skip the unreserve.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Link: https://patch.msgid.link/20250709233537.022192f4b1ae.Ib58156ac13e674a9f4d714735be0764a244c0aae@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mac80211/mlme.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index fd7434995a47..1bcd4eef73e6 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -2243,7 +2243,8 @@ ieee80211_sta_abort_chanswitch(struct ieee80211_link_data *link)
 	if (!local->ops->abort_channel_switch)
 		return;
 
-	ieee80211_link_unreserve_chanctx(link);
+	if (rcu_access_pointer(link->conf->chanctx_conf))
+		ieee80211_link_unreserve_chanctx(link);
 
 	ieee80211_vif_unblock_queues_csa(sdata);
 
-- 
2.39.5




