Return-Path: <stable+bounces-44199-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 456E18C51B4
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 13:31:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 000DA2828BF
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 11:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D3D213AD27;
	Tue, 14 May 2024 11:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nsyjdqlC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D7913AD1F;
	Tue, 14 May 2024 11:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715684899; cv=none; b=kuEKQ9TaWVLylvVqanVEWJSSOHTWAZimzEwQDyK12DAT/gwDUj+Etp1fc1E6Z2/SqrWF16TrcQATSqB9VhYKR0KO2W8RtwurdoWrcxW5nZX17pOXB3m5g5XoKELGBovFYEOFQkq3yw0Yu+jC+DJWu+IO0pMTRmYIiWcVMKCST3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715684899; c=relaxed/simple;
	bh=CMZfMhiE6S/H2o+b9RR7SAnTqhXZty5YWR1OGf4e+/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y/EZStJChvkHGYcvgXlIefsFxtL8COeWQgfWr57omhFFFmD1tN23vWx/AU0U+qc7h7ZNVyFNZxu4DEj4f7oyTIYOggoYdF80Vs4oHwaQ+3xywltSoMVm8oqc3JPed0zghFm38RFQpyZdl30xIJnBAmEpx0N7wq+HT38Po6Iu6aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nsyjdqlC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F46CC2BD10;
	Tue, 14 May 2024 11:08:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715684898;
	bh=CMZfMhiE6S/H2o+b9RR7SAnTqhXZty5YWR1OGf4e+/Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nsyjdqlCAix5W4Zha8JDbrkg7SmwZnaf1E45d1YtLA7Fj69BW00nHIKZ11uaYESIj
	 wINBnAnE7TBJQMu8i5A8AcGwG26EixmkRndOECQClzGUzaJ2zWdxBImncbdcOVZLrt
	 AJIDR3oZA4dflrUcSqAfTUpOM+rAHbtxabZXEiT4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Johannes Berg <johannes.berg@intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 106/301] wifi: mac80211: fix prep_connection error path
Date: Tue, 14 May 2024 12:16:17 +0200
Message-ID: <20240514101036.252303329@linuxfoundation.org>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240514101032.219857983@linuxfoundation.org>
References: <20240514101032.219857983@linuxfoundation.org>
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

[ Upstream commit 2e6bd24339a6ff04413b2e49c0f2672d6f0edfa5 ]

If prep_channel fails in prep_connection, the code releases
the deflink's chanctx, which is wrong since we may be using
a different link. It's already wrong to even do that always
though, since we might still have the station. Remove it
only if prep_channel succeeded and later updates fail.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Link: https://msgid.link/20240318184907.2780c1f08c3d.I033c9b15483933088f32a2c0789612a33dd33d82@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mac80211/mlme.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 6e574e2adc22e..cf01f1f298a3b 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -7080,7 +7080,7 @@ static int ieee80211_prep_connection(struct ieee80211_sub_if_data *sdata,
 			sdata_info(sdata,
 				   "failed to insert STA entry for the AP (error %d)\n",
 				   err);
-			goto out_err;
+			goto out_release_chan;
 		}
 	} else
 		WARN_ON_ONCE(!ether_addr_equal(link->u.mgd.bssid, cbss->bssid));
@@ -7091,8 +7091,9 @@ static int ieee80211_prep_connection(struct ieee80211_sub_if_data *sdata,
 
 	return 0;
 
+out_release_chan:
+	ieee80211_link_release_channel(link);
 out_err:
-	ieee80211_link_release_channel(&sdata->deflink);
 	ieee80211_vif_set_links(sdata, 0, 0);
 	return err;
 }
-- 
2.43.0




