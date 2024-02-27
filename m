Return-Path: <stable+bounces-24008-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE45B869231
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 14:33:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DCB81F2BA9E
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 13:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A873313F01E;
	Tue, 27 Feb 2024 13:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yVp26D/q"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68FEF13A87C;
	Tue, 27 Feb 2024 13:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709040769; cv=none; b=jUNd8uvv359rip8JtYjSUFjx/jAiwf/3e5jox1xGvEIuxFesKVs+7uhEg1KU01AH7SYlaxL+NZ2HQyPoIIIulryzawIOGMOzBT/dt3g0NgM90aS5nbiWWUu9vA6EwZwg4OXWDcnZ6k+BjN0dLTY73pwy+I9SEj7DZnBIZOzX/6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709040769; c=relaxed/simple;
	bh=Wqy3uOm/BzW4HN5LjjV5JzDVGTp2rsqebcRSq0HSGzw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eaxi5AxxpuQMqu4z4RWUj5QhtjCIrLNRlVYu/f4yBk+XtZy0XQ+i806GQk8lgZJ0PVCsM9o3bjIwRMQRtahGTkYt2SxdQd3itMX2GN2JyQ3hEKV+7h8jGxZWStscwCG7mG6bicJbPGGWw7UzTfDCqStag5zLORjhB+YfTiHIec8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yVp26D/q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED0BAC433F1;
	Tue, 27 Feb 2024 13:32:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709040769;
	bh=Wqy3uOm/BzW4HN5LjjV5JzDVGTp2rsqebcRSq0HSGzw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=yVp26D/qwXz9aqQOH78ul6n/L5sbk/txp8dvVP6WlLiBxoJkuJasczPZqDdfWE7nV
	 WVjagf3W3HOG2y1wDKlAvXg1Y2QDHCvGReIhN3pmnRlhv9c0s9Syi3P+VD7nQVmr20
	 srop+lArFyBMplq9IuPsfWESIKxyPyWA3Apt7d2c=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 104/334] wifi: mac80211: adding missing drv_mgd_complete_tx() call
Date: Tue, 27 Feb 2024 14:19:22 +0100
Message-ID: <20240227131633.845537358@linuxfoundation.org>
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

[ Upstream commit c042600c17d8c490279f0ae2baee29475fe8047d ]

There's a call to drv_mgd_prepare_tx() and so there should
be one to drv_mgd_complete_tx(), but on this path it's not.
Add it.

Link: https://msgid.link/20240131164824.2f0922a514e1.I5aac89b93bcead88c374187d70cad0599d29d2c8@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mac80211/mlme.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index e5525dc174f4c..241e615189244 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -8105,6 +8105,7 @@ int ieee80211_mgd_deauth(struct ieee80211_sub_if_data *sdata,
 		ieee80211_report_disconnect(sdata, frame_buf,
 					    sizeof(frame_buf), true,
 					    req->reason_code, false);
+		drv_mgd_complete_tx(sdata->local, sdata, &info);
 		return 0;
 	}
 
-- 
2.43.0




