Return-Path: <stable+bounces-9813-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6368C82558D
	for <lists+stable@lfdr.de>; Fri,  5 Jan 2024 15:40:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BDAB2817F0
	for <lists+stable@lfdr.de>; Fri,  5 Jan 2024 14:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D393C2E624;
	Fri,  5 Jan 2024 14:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2S7g1ArA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C3A2E626;
	Fri,  5 Jan 2024 14:39:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0337C433C8;
	Fri,  5 Jan 2024 14:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704465596;
	bh=yymYHzNiwwJGbnieXIpJ5VzMmYVc8VnqWVG58x9T3zI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=2S7g1ArARb2yMatbGLsKZ0r5WFTdYIafXK2TsuHdT2g7xCjLaLKDxOR5TqPOFo8cB
	 Via0n1vWGQXcZ0aVd5zzyID1U251OEEzIhxLTvX79ZAEN9nlDsMrU4mpMRwhS/qIvn
	 43EXzFi41NAzKURwUeX835NosYP8UxT/GE21rOOo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Johannes Berg <johannes.berg@intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 03/21] wifi: mac80211: mesh_plink: fix matches_local logic
Date: Fri,  5 Jan 2024 15:38:50 +0100
Message-ID: <20240105143811.699337722@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240105143811.536282337@linuxfoundation.org>
References: <20240105143811.536282337@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

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
index f69c6c38ca439..ab46de4536c46 100644
--- a/net/mac80211/mesh_plink.c
+++ b/net/mac80211/mesh_plink.c
@@ -1025,8 +1025,8 @@ mesh_plink_get_event(struct ieee80211_sub_if_data *sdata,
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
@@ -1034,9 +1034,9 @@ mesh_plink_get_event(struct ieee80211_sub_if_data *sdata,
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




