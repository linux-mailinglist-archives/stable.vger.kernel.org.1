Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24E14775D7A
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 13:38:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234116AbjHILiA (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 07:38:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234111AbjHILiA (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 07:38:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 387EDE3
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 04:37:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B3E5C63579
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 11:37:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2105C433C8;
        Wed,  9 Aug 2023 11:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691581078;
        bh=5GIouYFCmv0HQgb8SZkpAKRNSu2SB7DIlRi1Hf5HaAo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HcN0Io2mnQIVPQkyxfx2hmq5tVimXU4XVBgFwN2Du3mlHKwQ5sDPucjNiN1i/ymtY
         rgzV7zSZdH64intcF5tajx7ZAvPxpLP7wr0NQwZlEmdnvzb62Bz6xqAbUU2blYLXFc
         ahm+7FQXF3WqkoTctfUV/jGdmOnIZJyibsN1maTI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 098/201] staging: rtl8712: Use constants from <linux/ieee80211.h>
Date:   Wed,  9 Aug 2023 12:41:40 +0200
Message-ID: <20230809103647.095434858@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103643.799166053@linuxfoundation.org>
References: <20230809103643.799166053@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

[ Upstream commit f179515da9780c4cd37bee76c3cbb6f7364451d6 ]

Some constants defined in wifi.h are already defined in <linux/ieee80211.h>
with some other (but similar) names.
Be consistent and use the ones from <linux/ieee80211.h>.

The conversions made are:
_SSID_IE_                -->  WLAN_EID_SSID
_SUPPORTEDRATES_IE_      -->  WLAN_EID_SUPP_RATES
_DSSET_IE_               -->  WLAN_EID_DS_PARAMS
_IBSS_PARA_IE_           -->  WLAN_EID_IBSS_PARAMS
_ERPINFO_IE_             -->  WLAN_EID_ERP_INFO
_EXT_SUPPORTEDRATES_IE_  -->  WLAN_EID_EXT_SUPP_RATES

_HT_CAPABILITY_IE_       -->  WLAN_EID_HT_CAPABILITY
_HT_EXTRA_INFO_IE_       -->  WLAN_EID_HT_OPERATION    (not used)
_HT_ADD_INFO_IE_         -->  WLAN_EID_HT_OPERATION

_VENDOR_SPECIFIC_IE_     -->  WLAN_EID_VENDOR_SPECIFIC

_RESERVED47_             --> (not used)

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Link: https://lore.kernel.org/r/fe35fb45323adc3a30f31b7280cec7700fd325d8.1617741313.git.christophe.jaillet@wanadoo.fr
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: ac83631230f7 ("staging: r8712: Fix memory leak in _r8712_init_xmit_priv()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/staging/rtl8712/ieee80211.c           | 12 ++++++------
 drivers/staging/rtl8712/rtl871x_ioctl_linux.c |  8 ++++----
 drivers/staging/rtl8712/rtl871x_mlme.c        | 10 +++++-----
 drivers/staging/rtl8712/rtl871x_xmit.c        |  3 ++-
 drivers/staging/rtl8712/wifi.h                | 15 ---------------
 5 files changed, 17 insertions(+), 31 deletions(-)

diff --git a/drivers/staging/rtl8712/ieee80211.c b/drivers/staging/rtl8712/ieee80211.c
index b4a099169c7c8..8075ed2ba61ea 100644
--- a/drivers/staging/rtl8712/ieee80211.c
+++ b/drivers/staging/rtl8712/ieee80211.c
@@ -181,25 +181,25 @@ int r8712_generate_ie(struct registry_priv *registrypriv)
 	sz += 2;
 	ie += 2;
 	/*SSID*/
-	ie = r8712_set_ie(ie, _SSID_IE_, dev_network->Ssid.SsidLength,
+	ie = r8712_set_ie(ie, WLAN_EID_SSID, dev_network->Ssid.SsidLength,
 			  dev_network->Ssid.Ssid, &sz);
 	/*supported rates*/
 	set_supported_rate(dev_network->rates, registrypriv->wireless_mode);
 	rate_len = r8712_get_rateset_len(dev_network->rates);
 	if (rate_len > 8) {
-		ie = r8712_set_ie(ie, _SUPPORTEDRATES_IE_, 8,
+		ie = r8712_set_ie(ie, WLAN_EID_SUPP_RATES, 8,
 				  dev_network->rates, &sz);
-		ie = r8712_set_ie(ie, _EXT_SUPPORTEDRATES_IE_, (rate_len - 8),
+		ie = r8712_set_ie(ie, WLAN_EID_EXT_SUPP_RATES, (rate_len - 8),
 				  (dev_network->rates + 8), &sz);
 	} else {
-		ie = r8712_set_ie(ie, _SUPPORTEDRATES_IE_,
+		ie = r8712_set_ie(ie, WLAN_EID_SUPP_RATES,
 				  rate_len, dev_network->rates, &sz);
 	}
 	/*DS parameter set*/
-	ie = r8712_set_ie(ie, _DSSET_IE_, 1,
+	ie = r8712_set_ie(ie, WLAN_EID_DS_PARAMS, 1,
 			  (u8 *)&dev_network->Configuration.DSConfig, &sz);
 	/*IBSS Parameter Set*/
-	ie = r8712_set_ie(ie, _IBSS_PARA_IE_, 2,
+	ie = r8712_set_ie(ie, WLAN_EID_IBSS_PARAMS, 2,
 			  (u8 *)&dev_network->Configuration.ATIMWindow, &sz);
 	return sz;
 }
diff --git a/drivers/staging/rtl8712/rtl871x_ioctl_linux.c b/drivers/staging/rtl8712/rtl871x_ioctl_linux.c
index 2a661b04cd255..15c6ac518c167 100644
--- a/drivers/staging/rtl8712/rtl871x_ioctl_linux.c
+++ b/drivers/staging/rtl8712/rtl871x_ioctl_linux.c
@@ -236,7 +236,7 @@ static char *translate_scan(struct _adapter *padapter,
 	start = iwe_stream_add_point(info, start, stop, &iwe,
 				     pnetwork->network.Ssid.Ssid);
 	/* parsing HT_CAP_IE */
-	p = r8712_get_ie(&pnetwork->network.IEs[12], _HT_CAPABILITY_IE_,
+	p = r8712_get_ie(&pnetwork->network.IEs[12], WLAN_EID_HT_CAPABILITY,
 			 &ht_ielen, pnetwork->network.IELength - 12);
 	if (p && ht_ielen > 0)
 		ht_cap = true;
@@ -567,7 +567,7 @@ static int r871x_set_wpa_ie(struct _adapter *padapter, char *pie,
 			while (cnt < ielen) {
 				eid = buf[cnt];
 
-				if ((eid == _VENDOR_SPECIFIC_IE_) &&
+				if ((eid == WLAN_EID_VENDOR_SPECIFIC) &&
 				    (!memcmp(&buf[cnt + 2], wps_oui, 4))) {
 					netdev_info(padapter->pnetdev, "r8712u: SET WPS_IE\n");
 					padapter->securitypriv.wps_ie_len =
@@ -609,7 +609,7 @@ static int r8711_wx_get_name(struct net_device *dev,
 	if (check_fwstate(pmlmepriv, _FW_LINKED | WIFI_ADHOC_MASTER_STATE) ==
 	    true) {
 		/* parsing HT_CAP_IE */
-		p = r8712_get_ie(&pcur_bss->IEs[12], _HT_CAPABILITY_IE_,
+		p = r8712_get_ie(&pcur_bss->IEs[12], WLAN_EID_HT_CAPABILITY,
 				 &ht_ielen, pcur_bss->IELength - 12);
 		if (p && ht_ielen > 0)
 			ht_cap = true;
@@ -1403,7 +1403,7 @@ static int r8711_wx_get_rate(struct net_device *dev,
 	i = 0;
 	if (!check_fwstate(pmlmepriv, _FW_LINKED | WIFI_ADHOC_MASTER_STATE))
 		return -ENOLINK;
-	p = r8712_get_ie(&pcur_bss->IEs[12], _HT_CAPABILITY_IE_, &ht_ielen,
+	p = r8712_get_ie(&pcur_bss->IEs[12], WLAN_EID_HT_CAPABILITY, &ht_ielen,
 			 pcur_bss->IELength - 12);
 	if (p && ht_ielen > 0) {
 		ht_cap = true;
diff --git a/drivers/staging/rtl8712/rtl871x_mlme.c b/drivers/staging/rtl8712/rtl871x_mlme.c
index 6074383ec0b50..250cb0c4ed083 100644
--- a/drivers/staging/rtl8712/rtl871x_mlme.c
+++ b/drivers/staging/rtl8712/rtl871x_mlme.c
@@ -1649,11 +1649,11 @@ unsigned int r8712_restructure_ht_ie(struct _adapter *padapter, u8 *in_ie,
 	struct ht_priv *phtpriv = &pmlmepriv->htpriv;
 
 	phtpriv->ht_option = 0;
-	p = r8712_get_ie(in_ie + 12, _HT_CAPABILITY_IE_, &ielen, in_len - 12);
+	p = r8712_get_ie(in_ie + 12, WLAN_EID_HT_CAPABILITY, &ielen, in_len - 12);
 	if (p && (ielen > 0)) {
 		if (pqospriv->qos_option == 0) {
 			out_len = *pout_len;
-			r8712_set_ie(out_ie + out_len, _VENDOR_SPECIFIC_IE_,
+			r8712_set_ie(out_ie + out_len, WLAN_EID_VENDOR_SPECIFIC,
 				     _WMM_IE_Length_, WMM_IE, pout_len);
 			pqospriv->qos_option = 1;
 		}
@@ -1667,7 +1667,7 @@ unsigned int r8712_restructure_ht_ie(struct _adapter *padapter, u8 *in_ie,
 				    IEEE80211_HT_CAP_DSSSCCK40);
 		ht_capie.ampdu_params_info = (IEEE80211_HT_AMPDU_PARM_FACTOR &
 				0x03) | (IEEE80211_HT_AMPDU_PARM_DENSITY & 0x00);
-		r8712_set_ie(out_ie + out_len, _HT_CAPABILITY_IE_,
+		r8712_set_ie(out_ie + out_len, WLAN_EID_HT_CAPABILITY,
 			     sizeof(struct rtl_ieee80211_ht_cap),
 			     (unsigned char *)&ht_capie, pout_len);
 		phtpriv->ht_option = 1;
@@ -1698,7 +1698,7 @@ static void update_ht_cap(struct _adapter *padapter, u8 *pie, uint ie_len)
 	/*check Max Rx A-MPDU Size*/
 	len = 0;
 	p = r8712_get_ie(pie + sizeof(struct NDIS_802_11_FIXED_IEs),
-				_HT_CAPABILITY_IE_,
+				WLAN_EID_HT_CAPABILITY,
 				&len, ie_len -
 				sizeof(struct NDIS_802_11_FIXED_IEs));
 	if (p && len > 0) {
@@ -1733,7 +1733,7 @@ static void update_ht_cap(struct _adapter *padapter, u8 *pie, uint ie_len)
 	}
 	len = 0;
 	p = r8712_get_ie(pie + sizeof(struct NDIS_802_11_FIXED_IEs),
-		   _HT_ADD_INFO_IE_, &len,
+		   WLAN_EID_HT_OPERATION, &len,
 		   ie_len - sizeof(struct NDIS_802_11_FIXED_IEs));
 }
 
diff --git a/drivers/staging/rtl8712/rtl871x_xmit.c b/drivers/staging/rtl8712/rtl871x_xmit.c
index fd99782a400a0..15491859aedae 100644
--- a/drivers/staging/rtl8712/rtl871x_xmit.c
+++ b/drivers/staging/rtl8712/rtl871x_xmit.c
@@ -22,6 +22,7 @@
 #include "osdep_intf.h"
 #include "usb_ops.h"
 
+#include <linux/ieee80211.h>
 
 static const u8 P802_1H_OUI[P80211_OUI_LEN] = {0x00, 0x00, 0xf8};
 static const u8 RFC1042_OUI[P80211_OUI_LEN] = {0x00, 0x00, 0x00};
@@ -709,7 +710,7 @@ void r8712_update_protection(struct _adapter *padapter, u8 *ie, uint ie_len)
 		break;
 	case AUTO_VCS:
 	default:
-		perp = r8712_get_ie(ie, _ERPINFO_IE_, &erp_len, ie_len);
+		perp = r8712_get_ie(ie, WLAN_EID_ERP_INFO, &erp_len, ie_len);
 		if (!perp) {
 			pxmitpriv->vcs = NONE_VCS;
 		} else {
diff --git a/drivers/staging/rtl8712/wifi.h b/drivers/staging/rtl8712/wifi.h
index 601d4ff607bc8..9bb310b245899 100644
--- a/drivers/staging/rtl8712/wifi.h
+++ b/drivers/staging/rtl8712/wifi.h
@@ -374,21 +374,6 @@ static inline unsigned char *get_hdr_bssid(unsigned char *pframe)
 
 #define _FIXED_IE_LENGTH_	_BEACON_IE_OFFSET_
 
-#define _SSID_IE_		0
-#define _SUPPORTEDRATES_IE_	1
-#define _DSSET_IE_		3
-#define _IBSS_PARA_IE_		6
-#define _ERPINFO_IE_		42
-#define _EXT_SUPPORTEDRATES_IE_	50
-
-#define _HT_CAPABILITY_IE_	45
-#define _HT_EXTRA_INFO_IE_	61
-#define _HT_ADD_INFO_IE_	61 /* _HT_EXTRA_INFO_IE_ */
-
-#define _VENDOR_SPECIFIC_IE_	221
-
-#define	_RESERVED47_		47
-
 /* ---------------------------------------------------------------------------
  *			Below is the fixed elements...
  * ---------------------------------------------------------------------------
-- 
2.40.1



