Return-Path: <stable+bounces-4913-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2374F80837D
	for <lists+stable@lfdr.de>; Thu,  7 Dec 2023 09:47:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8FF9BB21C03
	for <lists+stable@lfdr.de>; Thu,  7 Dec 2023 08:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DABC313FF8;
	Thu,  7 Dec 2023 08:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="NRRpHSDg"
X-Original-To: stable@vger.kernel.org
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2055.outbound.protection.outlook.com [40.107.8.55])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26F0E10F9
	for <stable@vger.kernel.org>; Thu,  7 Dec 2023 00:47:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X3yeQNSL6xSSP+4T2rns6QQv8V9II11Lv/gFCqH37zZ9R+sn+nkabglHAIAIHEmqcTC43oEHvrRgbYn+850hByA0qDkBoqhkJDtfQDYcFna1aYz62vjd2WjH18/ALQG99vQ1n8LtjsKa9AP6ffgwlPALUYyO5wcBgp/B+CoCPH2nRSqy23ERMSV3fUsKHk3GxFixm51gaHBuA1+2DSI8Fy50Ws4+XRJT1hdPoo4UVrOGsJ2/uLuf18Kb6WeczQCM/STxgLAKT/23gSueQ5qtXTGbHRt6pQfNtvckN879aTUa8Y5e44m4KS0C5bjfHq2nj5ZlFNEF32R97hA93Jiztw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vGgJvTPaF4Pq7UcgbvsviolCQTxAgZi2SSDB6JuW250=;
 b=Fs5ykrY+h+3xUQVZmmFcG18i5LmReTnaVapF18eX8yM7Ep3E906xknKvskcPvICDMgG2K1V6HLvmT4zfH+EWl5fBbwicKakpl0ntWjhlIYqCLUFqnlSocdexmq/sd3PYnabrJDuzq5EsxVK5MXsR6istkxOZ9RIlO//rzMKyds0kBKM+L/gdMPueI025U8xwggpvkOHVnN2GmfGkGWw/f78TUkWtGS6QwAiQbFPFYtFxBbDjCQYp34iH5BQjE/z22tVwQ1qW+pIFP+nDTYW5ibsDcpdOf6FgYf2pXTpihlTnDrkveC0cSvEpOqYFWqV4Qazk2vQLFlMuLJPPsYIwoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vGgJvTPaF4Pq7UcgbvsviolCQTxAgZi2SSDB6JuW250=;
 b=NRRpHSDg9PjP5JUP/y16Il5T405cIDFOvnxWHmR09VNnG3spjZlmNOEc+HyIPF3wyIuj2cEhq5UFns0LXzV4NnmoiOaRBQkBeKYLn+428eM5efem/MuWDUrSuaZqLVmrbN6PReKh+xIeENn22wE7W6z6ZkAjfH33qdbs/oIwKpc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by PAXPR04MB9218.eurprd04.prod.outlook.com (2603:10a6:102:221::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.27; Thu, 7 Dec
 2023 08:47:00 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::34dd:289e:9e8b:9c9b]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::34dd:289e:9e8b:9c9b%7]) with mapi id 15.20.7068.027; Thu, 7 Dec 2023
 08:47:00 +0000
From: David Lin <yu-hao.lin@nxp.com>
To: yu-hao.lin@nxp.com
Cc: dlin_m@hotmail.com,
	stable@vger.kernel.org
Subject: [PATCH] wifi: mwifiex: fix STA cannot connect to AP
Date: Thu,  7 Dec 2023 16:46:51 +0800
Message-Id: <20231207084651.267233-1-yu-hao.lin@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0021.apcprd02.prod.outlook.com
 (2603:1096:3:17::33) To PA4PR04MB9638.eurprd04.prod.outlook.com
 (2603:10a6:102:273::20)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9638:EE_|PAXPR04MB9218:EE_
X-MS-Office365-Filtering-Correlation-Id: 30eab782-2c10-43b4-cf26-08dbf70113f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	3Ep6OGyfmREx1PpxbxlZPvrxcurj1o3j/j2UShLaU9pknLkfMOlB18V1iiEnFFr/EoyjPZ1Z8vwMKvq0E8ngPKZnSwNQaa13b9C6WqJF1rqLbw/XwFtFp1L9kIngx1i7pCL1i6BWVw2W8LSAPKSe8H0/IIhjlc+jt7acgd7RcrjGHaI/CbsaQOCiPAUoCSaOgWgw5F75YKsjX+Fehc9UhhHS5+Xp9hvyW4HypqGW6bb1A8cYLeHIlpBwV7TjfpvRhgXm3F+J+y1jf2gM5euS4cGxR0eO3v2zHbqtrCROrrDCUgkWViZS8+NndvEXyGLSa+1cXR/BOyOnGFvYJCutZAbf5rDUAfNUx8phrBv/I+UbsRSsHgy7Ir8iSQpVDUVKe8ur+zCIG08lGZ4/nkswXClv/lwox/AmEwpvzDvKd8Z4c/eJ8FREGBG0V5vV+QkLHr1Moyfi5rx4rCNcDK4sdH2yc3DY+OwQGU9Av8/p8vJhNM9DE4pu6jKkv48UXwj9xGnrrm/e8VDtzVU3Or7VVb1c7Yccjik33+20IF5amU6a5w4css+fV8EcEKcGma1g5nNJp5zHeMe3qJoBxyibZlx9tQhKLcu5/hy9n9bF5/MjgiNrm+gVA7oD79PQWBXU
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(376002)(396003)(346002)(366004)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(2616005)(38100700002)(66899024)(5660300002)(34206002)(4326008)(66476007)(66946007)(8676002)(8936002)(66556008)(37006003)(316002)(86362001)(52116002)(2906002)(6666004)(478600001)(6506007)(6512007)(36756003)(6486002)(41300700001)(38350700005)(1076003)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xeOLh+F7oB2DQxypHEhs6RhDtSAKIyVgZf9pu/neYWT9iRXx4fpRDTs3AhSE?=
 =?us-ascii?Q?BV/AgGJ8wtKbnujVaGV/HY2tsN4KSlV1d/FSjLthiO2QywjoHIOk9AS8b5Mn?=
 =?us-ascii?Q?xtbg5HUQiM9AWylFn/SSMX8+e2t0/6oMnat1vbMLVtpU/AfyL80A19aEfsfq?=
 =?us-ascii?Q?qaHZunHU2WwFFXMMQN4qmrm3IF9VZTEY++xIT2UxnxQRTPp+o/Q7s9Gcu653?=
 =?us-ascii?Q?phwwrhS5jT968fDnHwkKJsxUmSJ2MrYQVloV77cl3pVKEk4jWvrnjdLBcrgX?=
 =?us-ascii?Q?TmVr+rmlHuKmoCfrhjgNxeJJufvxX7MNR4DbNQW1xcGM8+iWIAZzBOl0GuqZ?=
 =?us-ascii?Q?dqaeXqEULGG5U13L9ed+t/2OoegaQmsQ7Vc1WYKXcUeDMRU/b4cOwLBCot/A?=
 =?us-ascii?Q?gmDdm3UMx8fw3L/Jr/HyX4HMDCpQllzsj82Ags7++TnPE8TgI5EWMNCdvmqH?=
 =?us-ascii?Q?RchjIQ+K7VkD4z4P+6phY25BUpr6yn2O6gxJjl9bVC6B2+NmgBhfhsfloMDb?=
 =?us-ascii?Q?gLhZJF4/jWTiADLkrSKiwtxB9fqEVDs70PKABQ9PBynnpSo/NWFQ2G3bsSRv?=
 =?us-ascii?Q?tVE1lceyyHPSlrrypl6tFW0TUFjh9WghpRUAaopbvBQ+mkitNcmmJ23rtUVz?=
 =?us-ascii?Q?/Set2E++LwSyIXqX9CBWHrIJdhsJAWhICB3Eg+OJAVBp4JsQpkg63NbdNFGX?=
 =?us-ascii?Q?ESzNFMNp+wGkgF5/9FxqSj1pccIwTt6/7gKictjkM+5CWFRY2zjcL0VOPPFe?=
 =?us-ascii?Q?di72lqYq0/Y3WuT5TUfBF9rnjnj4tXIT+cW1LCjhO7edRlQ1mch6BUgQdigG?=
 =?us-ascii?Q?isuSWzt+LLnGSAfHhOTy/QnwU9fHYzz240EV2JsgSBCbOGz7CvP4zlcaIxap?=
 =?us-ascii?Q?DBQl0m/2mAvch2zPC4RfrX6UtMPN+0UPjfzlaSX9l+uPLQR5gY53yqMlEGQF?=
 =?us-ascii?Q?S2227Ch0P5qs2pFZuwfSfvvo7BaSUJXHj5TVMnsz04vCBAOWegwp9//pX2rD?=
 =?us-ascii?Q?gEcs9sl5I0G/h8KSiJx7o9D267QDRwqxUY8S9UYTS3ib847ezrE7Xcr+da6n?=
 =?us-ascii?Q?nvSNdfVIJu4ZBf9Kt6l5YmzEoavb3KcU8KjCsdqifACNLFjTwFPTYpogduJK?=
 =?us-ascii?Q?fH2CKQ6bBMYp3yDTrXYcBT0b1sshEqK5fLIvMfXRV3S6OX1t2qJJMJ+pX41G?=
 =?us-ascii?Q?8XW/qd/xh9YA1eM/NbBVFcNseZTiOkuZBa0uAXB9yqzjjXqeu4ajatQrkAEN?=
 =?us-ascii?Q?SvvZG7Cw7s9ug7EM0Oigjp05d2GHhWdRL9gh/iP1t8QguCrUdig8+9mN48Cg?=
 =?us-ascii?Q?UYYuZNx0fobo1HjjQDauA9QS+oBJSwM+ZeVmsDfptzneJ0Szr5CJhdu7ebei?=
 =?us-ascii?Q?2wEO2XpGwlhvdGYA0WrJsxVGlVI8wJQlfFg8zLuxFgWSFGKf4bkkbG2Tguqy?=
 =?us-ascii?Q?9iZAXKiz6shE0mvJY+rGxGbZ6Xj32oQhmdmnUKXBF6QPzSJ4qEFw1ud1Vc9w?=
 =?us-ascii?Q?tTgqq7KcPMhqFvw+Lvcy+cLiK4tqyexA8MmUkvRpbxcAVVe7wj1zt18d+qV9?=
 =?us-ascii?Q?h7B1AcBsK/4Kat57AhmRs5K+5ORFu5iSZFKF+Nut?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30eab782-2c10-43b4-cf26-08dbf70113f7
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2023 08:47:00.7413
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ri7d85aOGa1LSjxCdTxcphJwlryvq2gEJ7uK4Io/lih1qqTqBQSko9e1fNblyIaaJHaLPhqzsabvxyqmZiiK2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9218

AP BSSID configuration is missing at AP start.
Without this fix, FW returns STA interface MAC address after first init.
When hostapd restarts, it gets MAC address from netdev before driver
sets STA MAC to netdev again. Now MAC address between hostapd and net
interface are different causes STA cannot connect to AP.
After that MAC address of uap0 mlan0 become the same. And issue
disappears after following hostapd restart (another issue is AP/STA MAC
address become the same).
This patch fixes the issue cleanly.

Signed-off-by: David Lin <yu-hao.lin@nxp.com>
Fixes: 277b024e5e3d ("mwifiex: move under marvell vendor directory")
Cc: stable@vger.kernel.org
---
 drivers/net/wireless/marvell/mwifiex/cfg80211.c | 2 ++
 drivers/net/wireless/marvell/mwifiex/fw.h       | 1 +
 drivers/net/wireless/marvell/mwifiex/ioctl.h    | 1 +
 drivers/net/wireless/marvell/mwifiex/uap_cmd.c  | 8 ++++++++
 4 files changed, 12 insertions(+)

diff --git a/drivers/net/wireless/marvell/mwifiex/cfg80211.c b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
index 7a15ea8072e6..3604abcbcff9 100644
--- a/drivers/net/wireless/marvell/mwifiex/cfg80211.c
+++ b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
@@ -2047,6 +2047,8 @@ static int mwifiex_cfg80211_start_ap(struct wiphy *wiphy,
 
 	mwifiex_set_sys_config_invalid_data(bss_cfg);
 
+	memcpy(bss_cfg->mac_addr, priv->curr_addr, ETH_ALEN);
+
 	if (params->beacon_interval)
 		bss_cfg->beacon_period = params->beacon_interval;
 	if (params->dtim_period)
diff --git a/drivers/net/wireless/marvell/mwifiex/fw.h b/drivers/net/wireless/marvell/mwifiex/fw.h
index 8e6db904e5b2..62f3c9a52a1d 100644
--- a/drivers/net/wireless/marvell/mwifiex/fw.h
+++ b/drivers/net/wireless/marvell/mwifiex/fw.h
@@ -165,6 +165,7 @@ enum MWIFIEX_802_11_PRIVACY_FILTER {
 #define TLV_TYPE_STA_MAC_ADDR       (PROPRIETARY_TLV_BASE_ID + 32)
 #define TLV_TYPE_BSSID              (PROPRIETARY_TLV_BASE_ID + 35)
 #define TLV_TYPE_CHANNELBANDLIST    (PROPRIETARY_TLV_BASE_ID + 42)
+#define TLV_TYPE_UAP_MAC_ADDRESS    (PROPRIETARY_TLV_BASE_ID + 43)
 #define TLV_TYPE_UAP_BEACON_PERIOD  (PROPRIETARY_TLV_BASE_ID + 44)
 #define TLV_TYPE_UAP_DTIM_PERIOD    (PROPRIETARY_TLV_BASE_ID + 45)
 #define TLV_TYPE_UAP_BCAST_SSID     (PROPRIETARY_TLV_BASE_ID + 48)
diff --git a/drivers/net/wireless/marvell/mwifiex/ioctl.h b/drivers/net/wireless/marvell/mwifiex/ioctl.h
index 091e7ca79376..8be3a2714bf7 100644
--- a/drivers/net/wireless/marvell/mwifiex/ioctl.h
+++ b/drivers/net/wireless/marvell/mwifiex/ioctl.h
@@ -83,6 +83,7 @@ struct wep_key {
 #define MWIFIEX_OPERATING_CLASSES		16
 
 struct mwifiex_uap_bss_param {
+	u8 mac_addr[ETH_ALEN];
 	u8 channel;
 	u8 band_cfg;
 	u16 rts_threshold;
diff --git a/drivers/net/wireless/marvell/mwifiex/uap_cmd.c b/drivers/net/wireless/marvell/mwifiex/uap_cmd.c
index e78a201cd150..491e36611909 100644
--- a/drivers/net/wireless/marvell/mwifiex/uap_cmd.c
+++ b/drivers/net/wireless/marvell/mwifiex/uap_cmd.c
@@ -468,6 +468,7 @@ void mwifiex_config_uap_11d(struct mwifiex_private *priv,
 static int
 mwifiex_uap_bss_param_prepare(u8 *tlv, void *cmd_buf, u16 *param_size)
 {
+	struct host_cmd_tlv_mac_addr *mac_tlv;
 	struct host_cmd_tlv_dtim_period *dtim_period;
 	struct host_cmd_tlv_beacon_period *beacon_period;
 	struct host_cmd_tlv_ssid *ssid;
@@ -487,6 +488,13 @@ mwifiex_uap_bss_param_prepare(u8 *tlv, void *cmd_buf, u16 *param_size)
 	int i;
 	u16 cmd_size = *param_size;
 
+	mac_tlv = (struct host_cmd_tlv_mac_addr *)tlv;
+	mac_tlv->header.type = cpu_to_le16(TLV_TYPE_UAP_MAC_ADDRESS);
+	mac_tlv->header.len = cpu_to_le16(ETH_ALEN);
+	memcpy(mac_tlv->mac_addr, bss_cfg->mac_addr, ETH_ALEN);
+	cmd_size += sizeof(struct host_cmd_tlv_mac_addr);
+	tlv += sizeof(struct host_cmd_tlv_mac_addr);
+
 	if (bss_cfg->ssid.ssid_len) {
 		ssid = (struct host_cmd_tlv_ssid *)tlv;
 		ssid->header.type = cpu_to_le16(TLV_TYPE_UAP_SSID);

base-commit: 783004b6dbda2cfe9a552a4cc9c1d168a2068f6c
-- 
2.25.1


