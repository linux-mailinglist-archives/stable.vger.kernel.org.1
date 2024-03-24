Return-Path: <stable+bounces-29989-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 66BED8891ED
	for <lists+stable@lfdr.de>; Mon, 25 Mar 2024 07:52:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D7FAB3AB0B
	for <lists+stable@lfdr.de>; Mon, 25 Mar 2024 05:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8351E204E36;
	Sun, 24 Mar 2024 23:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RzbpmKbN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F711353E1;
	Sun, 24 Mar 2024 23:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321474; cv=none; b=WOKLXtUB1zcSdxb64XwjJRbiBbIfTIFvsl8iFklYswHEZAvPkL39DPuIZMoAL9Cel3Q1+70+WSRxlg2iVBKhkUeqSt892CaUyRuV2VSDk05k7aHUKVkiZqqeczzGALiukjBe9AMG5zdFuefDDdlaVh40fn0akxvthVG2bfmyfco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321474; c=relaxed/simple;
	bh=Ko3Y46oUAKjs4NcPOC3rqp/iAteZ9BNi4PZcMKUCMkM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ko4/Fgy3w/OIB5Z4j8ZzgYtrDVw6IlqD/EVwlQDfHjnBHeXA2QPuyGvyXDEMepo94K/b/T/5Xt3FknBu8vKz0oQcIaFq+0JkxSYcHrRHi+UWmXgxYe27E53lnkiOVXQAdvr1FoH3G28lo2BABMJMpJ35nIA5q95iGIeVAbQPn9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RzbpmKbN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CD03C43394;
	Sun, 24 Mar 2024 23:04:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321473;
	bh=Ko3Y46oUAKjs4NcPOC3rqp/iAteZ9BNi4PZcMKUCMkM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RzbpmKbNDWD4fewy6UBnv1o3GVXSSjmeswkNXPapMoSZ8mSRxpCLPiun8a8yeR8K7
	 11023iA51JuicW0JbKfm4iisA6A/ycMLRwPwO2NG56CYjCQDKRiuDFe9WoybfhPehb
	 gXNPqMBBaDzrDj4IfWl/InKaWwmSilj7utyxorDPOQMTdlSESVELbVX0jF2r/Z8z3i
	 UzHiGTkqTHkpCuZoJ0rq8/kREhHMLM1e4XFzTYh9jnSRrEA5EyugNMJldP1iX8ucQz
	 CxZfJNhxJCGMnHefBrbmz9dVYHP26rqzGLkurN3I7eqzfXsyiKsVvh+LJ6RnKjDotY
	 pW5Udum8l7WoQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 198/638] wifi: iwlwifi: mvm: don't set replay counters to 0xff
Date: Sun, 24 Mar 2024 18:53:55 -0400
Message-ID: <20240324230116.1348576-199-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit d5bd4041cd70faf26fc9a54bd6f172537bbe77f3 ]

The firmware (later) actually uses the values even for keys
that are invalid as far as the host is concerned, later in
rekeying, and then only sets the low 48 bits since the PNs
are only 48 bits over the air. It does, however, compare the
full 64 bits later, obviously causing problems.

Remove the memset and use kzalloc instead to avoid any old
heap data leaking to the firmware. We already init all the
other fields in the struct anyway. This leaves the data set
to zero for any unused fields, so the firmware can look at
them safely even if they're not used right now.

Fixes: 79e561f0f05a ("iwlwifi: mvm: d3: implement RSC command version 5")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Link: https://msgid.link/20240206175739.462101146fef.I10f3855b99417af4247cff04af78dcbc6cb75c9c@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
index dcda7fbb5a7a5..cfc239b272eb7 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
@@ -461,12 +461,10 @@ static int iwl_mvm_wowlan_config_rsc_tsc(struct iwl_mvm *mvm,
 		struct wowlan_key_rsc_v5_data data = {};
 		int i;
 
-		data.rsc = kmalloc(sizeof(*data.rsc), GFP_KERNEL);
+		data.rsc = kzalloc(sizeof(*data.rsc), GFP_KERNEL);
 		if (!data.rsc)
 			return -ENOMEM;
 
-		memset(data.rsc, 0xff, sizeof(*data.rsc));
-
 		for (i = 0; i < ARRAY_SIZE(data.rsc->mcast_key_id_map); i++)
 			data.rsc->mcast_key_id_map[i] =
 				IWL_MCAST_KEY_MAP_INVALID;
-- 
2.43.0


