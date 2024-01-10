Return-Path: <stable+bounces-9888-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 03BBC8255DD
	for <lists+stable@lfdr.de>; Fri,  5 Jan 2024 15:43:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 960381F268AC
	for <lists+stable@lfdr.de>; Fri,  5 Jan 2024 14:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B468B2D051;
	Fri,  5 Jan 2024 14:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Iwmsa3an"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E4F528DDA;
	Fri,  5 Jan 2024 14:43:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03370C433C8;
	Fri,  5 Jan 2024 14:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704465807;
	bh=PXy98luYCABltjRli1YXOl0JB3Z1vgcfoFMzNh5idVM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Iwmsa3anru7eeR6zMLChnqExrtlyuh1dqNBXzDB/NVlwnwztUsCQiOkqszFXLd2La
	 cAtqW/ysMbr9w+MGRqkchh13M9IQ/jTzCSXn7ePxDI3THoi1PlAv05pGIijmZ6/YYf
	 b2L+AZ9fFojHxJ384H6CUxULdzEb6prKcMnubm08=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Johannes Berg <johannes.berg@intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 06/47] wifi: mac80211: mesh_plink: fix matches_local logic
Date: Fri,  5 Jan 2024 15:38:53 +0100
Message-ID: <20240105143815.758702742@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240105143815.541462991@linuxfoundation.org>
References: <20240105143815.541462991@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit 8c386b166e2517cf3a123018e77941ec22625d0f ]

During refactoring the "else" here got lost, add it back.

Fixes: c99a89edb106 ("mac80211: factor out plink event gathering")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Link: https://msgid.link/20231211085121.795480fa0e0b.I017d501196a5bbdcd9afd33338d342d6fe1edd79@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mac80211/mesh_plink.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/mac80211/mesh_plink.c b/net/mac80211/mesh_plink.c
index 737c5f4dbf520..def34c843f290 100644
--- a/net/mac80211/mesh_plink.c
+++ b/net/mac80211/mesh_plink.c
@@ -1044,8 +1044,8 @@ mesh_plink_get_event(struct ieee80211_sub_if_data *sdata,
 	case WLAN_SP_MESH_PEERING_OPEN:
 		if (!matches_local)
 			event = OPN_RJCT;
-		if (!mesh_plink_free_count(sdata) ||
-		    (sta->mesh->plid && sta->mesh->plid != plid))
+		else if (!mesh_plink_free_count(sdata) ||
+			 (sta->mesh->plid && sta->mesh->plid != plid))
 			event = OPN_IGNR;
 		else
 			event = OPN_ACPT;
@@ -1053,9 +1053,9 @@ mesh_plink_get_event(struct ieee80211_sub_if_data *sdata,
 	case WLAN_SP_MESH_PEERING_CONFIRM:
 		if (!matches_local)
 			event = CNF_RJCT;
-		if (!mesh_plink_free_count(sdata) ||
-		    sta->mesh->llid != llid ||
-		    (sta->mesh->plid && sta->mesh->plid != plid))
+		else if (!mesh_plink_free_count(sdata) ||
+			 sta->mesh->llid != llid ||
+			 (sta->mesh->plid && sta->mesh->plid != plid))
 			event = CNF_IGNR;
 		else
 			event = CNF_ACPT;
-- 
2.43.0




