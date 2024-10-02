Return-Path: <stable+bounces-79362-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EDFF98D7D8
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 15:53:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4377A1C229AE
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 13:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BF721D04B4;
	Wed,  2 Oct 2024 13:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="19WtNLb8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E20D29CE7;
	Wed,  2 Oct 2024 13:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727877221; cv=none; b=oqwhU0LOyfYOU1ZwxzYdJWyPODGoHyZ1kK+Ih9HXrq/baRoGkmun3VbQzD+R/tDqyu/5otJ8tp2qX36MIXboRYrVq+g+yDDyK9heTXNDuQxBJ5CFnEX7aw9Epr0/mF64Ueh32Ats3A1KjByAJLMm/UvQ1w4e+MWxamU3YwZx/Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727877221; c=relaxed/simple;
	bh=wmIOh8r6K8fI+cwjxTOjKN5aOC5juZt3FDSfe9sDhaA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nwpth8WSNqN5IT744gT+rpaZF6UtJX+1Tv7gFenYFMtvB8q7tbW2gg8meJzlj9s1rN49RlxkV/zciq1PEG1mlUP+ZWqGgRYvZOcD42yO15r8ywQa+jSlnSGv4eltd+s9+ot4nOfEG47goMRXz6XP7IWkFdtYQAeUn+nq/ld1uNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=19WtNLb8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99866C4CEC5;
	Wed,  2 Oct 2024 13:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727877221;
	bh=wmIOh8r6K8fI+cwjxTOjKN5aOC5juZt3FDSfe9sDhaA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=19WtNLb8dypswjM27Bm96fPsBW53Ts7JduviaS3dQUk+LzA7BVgzqh/Q8BiVth1Hu
	 C8SXfQNnQcnCQUR+ycQFpPdjrK2h94Jp+VgYknccPCyj1O5gSCICZaHqhr95a73Sj1
	 xMoiVhVH3j18xypwX6P01+50ENdDsWROgd4+5JRs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Su Hui <suhui@nfschina.com>,
	Arend van Spriel <arend.vanspriel@broadcom.com>,
	Kalle Valo <kvalo@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.10 010/634] wifi: brcmfmac: introducing fwil query functions
Date: Wed,  2 Oct 2024 14:51:50 +0200
Message-ID: <20241002125811.498394976@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241002125811.070689334@linuxfoundation.org>
References: <20241002125811.070689334@linuxfoundation.org>
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

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arend van Spriel <arend.vanspriel@broadcom.com>

[ Upstream commit c6002b6c05f3edfa12fd25990cc637281f200442 ]

When the firmware interface layer was refactored it provided various
"get" and "set" functions. For the "get" in some cases a parameter
needed to be passed down to firmware as a key indicating what to
"get" turning the output parameter of the "get" function into an
input parameter as well. To accommodate this the "get" function blindly
copies the parameter which in some places resulted in an uninitialized
warnings from the compiler. These have been fixed by initializing the
input parameter in the past. Recently another batch of similar fixes
were submitted to address clang static checker warnings [1].

Proposing another solution by introducing a "query" variant which is used
when the (input) parameter is needed by firmware. The "get" variant will
only fill the (output) parameter with the result received from firmware
taking care of proper endianess conversion.

[1] https://lore.kernel.org/all/20240702122450.2213833-1-suhui@nfschina.com/

Fixes: 81f5dcb80830 ("brcmfmac: refactor firmware interface layer.")
Reported-by: Su Hui <suhui@nfschina.com>
Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
Signed-off-by: Kalle Valo <kvalo@kernel.org>
Link: https://patch.msgid.link/20240727185617.253210-1-arend.vanspriel@broadcom.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../broadcom/brcm80211/brcmfmac/btcoex.c      |  2 +-
 .../broadcom/brcm80211/brcmfmac/cfg80211.c    | 30 +++++++-------
 .../broadcom/brcm80211/brcmfmac/core.c        |  2 +-
 .../broadcom/brcm80211/brcmfmac/feature.c     |  2 +-
 .../broadcom/brcm80211/brcmfmac/fwil.h        | 40 ++++++++++++++-----
 5 files changed, 48 insertions(+), 28 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/btcoex.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/btcoex.c
index 7ea2631b80692..00794086cc7c9 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/btcoex.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/btcoex.c
@@ -123,7 +123,7 @@ static s32 brcmf_btcoex_params_read(struct brcmf_if *ifp, u32 addr, u32 *data)
 {
 	*data = addr;
 
-	return brcmf_fil_iovar_int_get(ifp, "btc_params", data);
+	return brcmf_fil_iovar_int_query(ifp, "btc_params", data);
 }
 
 /**
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
index 826b768196e28..ccc069ae5e9d8 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -663,8 +663,8 @@ static int brcmf_cfg80211_request_sta_if(struct brcmf_if *ifp, u8 *macaddr)
 	/* interface_create version 3+ */
 	/* get supported version from firmware side */
 	iface_create_ver = 0;
-	err = brcmf_fil_bsscfg_int_get(ifp, "interface_create",
-				       &iface_create_ver);
+	err = brcmf_fil_bsscfg_int_query(ifp, "interface_create",
+					 &iface_create_ver);
 	if (err) {
 		brcmf_err("fail to get supported version, err=%d\n", err);
 		return -EOPNOTSUPP;
@@ -756,8 +756,8 @@ static int brcmf_cfg80211_request_ap_if(struct brcmf_if *ifp)
 	/* interface_create version 3+ */
 	/* get supported version from firmware side */
 	iface_create_ver = 0;
-	err = brcmf_fil_bsscfg_int_get(ifp, "interface_create",
-				       &iface_create_ver);
+	err = brcmf_fil_bsscfg_int_query(ifp, "interface_create",
+					 &iface_create_ver);
 	if (err) {
 		brcmf_err("fail to get supported version, err=%d\n", err);
 		return -EOPNOTSUPP;
@@ -2101,7 +2101,8 @@ brcmf_set_key_mgmt(struct net_device *ndev, struct cfg80211_connect_params *sme)
 	if (!sme->crypto.n_akm_suites)
 		return 0;
 
-	err = brcmf_fil_bsscfg_int_get(netdev_priv(ndev), "wpa_auth", &val);
+	err = brcmf_fil_bsscfg_int_get(netdev_priv(ndev),
+				       "wpa_auth", &val);
 	if (err) {
 		bphy_err(drvr, "could not get wpa_auth (%d)\n", err);
 		return err;
@@ -2680,7 +2681,7 @@ brcmf_cfg80211_get_tx_power(struct wiphy *wiphy, struct wireless_dev *wdev,
 	struct brcmf_cfg80211_info *cfg = wiphy_to_cfg(wiphy);
 	struct brcmf_cfg80211_vif *vif = wdev_to_vif(wdev);
 	struct brcmf_pub *drvr = cfg->pub;
-	s32 qdbm = 0;
+	s32 qdbm;
 	s32 err;
 
 	brcmf_dbg(TRACE, "Enter\n");
@@ -3067,7 +3068,7 @@ brcmf_cfg80211_get_station_ibss(struct brcmf_if *ifp,
 	struct brcmf_scb_val_le scbval;
 	struct brcmf_pktcnt_le pktcnt;
 	s32 err;
-	u32 rate = 0;
+	u32 rate;
 	u32 rssi;
 
 	/* Get the current tx rate */
@@ -7046,8 +7047,8 @@ static int brcmf_construct_chaninfo(struct brcmf_cfg80211_info *cfg,
 			ch.bw = BRCMU_CHAN_BW_20;
 			cfg->d11inf.encchspec(&ch);
 			chaninfo = ch.chspec;
-			err = brcmf_fil_bsscfg_int_get(ifp, "per_chan_info",
-						       &chaninfo);
+			err = brcmf_fil_bsscfg_int_query(ifp, "per_chan_info",
+							 &chaninfo);
 			if (!err) {
 				if (chaninfo & WL_CHAN_RADAR)
 					channel->flags |=
@@ -7081,7 +7082,7 @@ static int brcmf_enable_bw40_2g(struct brcmf_cfg80211_info *cfg)
 
 	/* verify support for bw_cap command */
 	val = WLC_BAND_5G;
-	err = brcmf_fil_iovar_int_get(ifp, "bw_cap", &val);
+	err = brcmf_fil_iovar_int_query(ifp, "bw_cap", &val);
 
 	if (!err) {
 		/* only set 2G bandwidth using bw_cap command */
@@ -7157,11 +7158,11 @@ static void brcmf_get_bwcap(struct brcmf_if *ifp, u32 bw_cap[])
 	int err;
 
 	band = WLC_BAND_2G;
-	err = brcmf_fil_iovar_int_get(ifp, "bw_cap", &band);
+	err = brcmf_fil_iovar_int_query(ifp, "bw_cap", &band);
 	if (!err) {
 		bw_cap[NL80211_BAND_2GHZ] = band;
 		band = WLC_BAND_5G;
-		err = brcmf_fil_iovar_int_get(ifp, "bw_cap", &band);
+		err = brcmf_fil_iovar_int_query(ifp, "bw_cap", &band);
 		if (!err) {
 			bw_cap[NL80211_BAND_5GHZ] = band;
 			return;
@@ -7170,7 +7171,6 @@ static void brcmf_get_bwcap(struct brcmf_if *ifp, u32 bw_cap[])
 		return;
 	}
 	brcmf_dbg(INFO, "fallback to mimo_bw_cap info\n");
-	mimo_bwcap = 0;
 	err = brcmf_fil_iovar_int_get(ifp, "mimo_bw_cap", &mimo_bwcap);
 	if (err)
 		/* assume 20MHz if firmware does not give a clue */
@@ -7266,10 +7266,10 @@ static int brcmf_setup_wiphybands(struct brcmf_cfg80211_info *cfg)
 	struct brcmf_pub *drvr = cfg->pub;
 	struct brcmf_if *ifp = brcmf_get_ifp(drvr, 0);
 	struct wiphy *wiphy = cfg_to_wiphy(cfg);
-	u32 nmode = 0;
+	u32 nmode;
 	u32 vhtmode = 0;
 	u32 bw_cap[2] = { WLC_BW_20MHZ_BIT, WLC_BW_20MHZ_BIT };
-	u32 rxchain = 0;
+	u32 rxchain;
 	u32 nchain;
 	int err;
 	s32 i;
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
index bf91b1e1368f0..df53dd1d7e748 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
@@ -691,7 +691,7 @@ static int brcmf_net_mon_open(struct net_device *ndev)
 {
 	struct brcmf_if *ifp = netdev_priv(ndev);
 	struct brcmf_pub *drvr = ifp->drvr;
-	u32 monitor = 0;
+	u32 monitor;
 	int err;
 
 	brcmf_dbg(TRACE, "Enter\n");
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/feature.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/feature.c
index f23310a77a5d1..0d9ae197fa1ec 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/feature.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/feature.c
@@ -184,7 +184,7 @@ static void brcmf_feat_wlc_version_overrides(struct brcmf_pub *drv)
 static void brcmf_feat_iovar_int_get(struct brcmf_if *ifp,
 				     enum brcmf_feat_id id, char *name)
 {
-	u32 data = 0;
+	u32 data;
 	int err;
 
 	/* we need to know firmware error */
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwil.h b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwil.h
index a315a7fac6a06..31e080e4da669 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwil.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwil.h
@@ -96,15 +96,22 @@ static inline
 s32 brcmf_fil_cmd_int_get(struct brcmf_if *ifp, u32 cmd, u32 *data)
 {
 	s32 err;
-	__le32 data_le = cpu_to_le32(*data);
 
-	err = brcmf_fil_cmd_data_get(ifp, cmd, &data_le, sizeof(data_le));
+	err = brcmf_fil_cmd_data_get(ifp, cmd, data, sizeof(*data));
 	if (err == 0)
-		*data = le32_to_cpu(data_le);
+		*data = le32_to_cpu(*(__le32 *)data);
 	brcmf_dbg(FIL, "ifidx=%d, cmd=%d, value=%d\n", ifp->ifidx, cmd, *data);
 
 	return err;
 }
+static inline
+s32 brcmf_fil_cmd_int_query(struct brcmf_if *ifp, u32 cmd, u32 *data)
+{
+	__le32 *data_le = (__le32 *)data;
+
+	*data_le = cpu_to_le32(*data);
+	return brcmf_fil_cmd_int_get(ifp, cmd, data);
+}
 
 s32 brcmf_fil_iovar_data_set(struct brcmf_if *ifp, const char *name,
 			     const void *data, u32 len);
@@ -120,14 +127,21 @@ s32 brcmf_fil_iovar_int_set(struct brcmf_if *ifp, const char *name, u32 data)
 static inline
 s32 brcmf_fil_iovar_int_get(struct brcmf_if *ifp, const char *name, u32 *data)
 {
-	__le32 data_le = cpu_to_le32(*data);
 	s32 err;
 
-	err = brcmf_fil_iovar_data_get(ifp, name, &data_le, sizeof(data_le));
+	err = brcmf_fil_iovar_data_get(ifp, name, data, sizeof(*data));
 	if (err == 0)
-		*data = le32_to_cpu(data_le);
+		*data = le32_to_cpu(*(__le32 *)data);
 	return err;
 }
+static inline
+s32 brcmf_fil_iovar_int_query(struct brcmf_if *ifp, const char *name, u32 *data)
+{
+	__le32 *data_le = (__le32 *)data;
+
+	*data_le = cpu_to_le32(*data);
+	return brcmf_fil_iovar_int_get(ifp, name, data);
+}
 
 
 s32 brcmf_fil_bsscfg_data_set(struct brcmf_if *ifp, const char *name,
@@ -145,15 +159,21 @@ s32 brcmf_fil_bsscfg_int_set(struct brcmf_if *ifp, const char *name, u32 data)
 static inline
 s32 brcmf_fil_bsscfg_int_get(struct brcmf_if *ifp, const char *name, u32 *data)
 {
-	__le32 data_le = cpu_to_le32(*data);
 	s32 err;
 
-	err = brcmf_fil_bsscfg_data_get(ifp, name, &data_le,
-					sizeof(data_le));
+	err = brcmf_fil_bsscfg_data_get(ifp, name, data, sizeof(*data));
 	if (err == 0)
-		*data = le32_to_cpu(data_le);
+		*data = le32_to_cpu(*(__le32 *)data);
 	return err;
 }
+static inline
+s32 brcmf_fil_bsscfg_int_query(struct brcmf_if *ifp, const char *name, u32 *data)
+{
+	__le32 *data_le = (__le32 *)data;
+
+	*data_le = cpu_to_le32(*data);
+	return brcmf_fil_bsscfg_int_get(ifp, name, data);
+}
 
 s32 brcmf_fil_xtlv_data_set(struct brcmf_if *ifp, const char *name, u16 id,
 			    void *data, u32 len);
-- 
2.43.0




