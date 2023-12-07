Return-Path: <stable+bounces-4911-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06878808351
	for <lists+stable@lfdr.de>; Thu,  7 Dec 2023 09:39:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFCEE283C43
	for <lists+stable@lfdr.de>; Thu,  7 Dec 2023 08:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C9B51E48D;
	Thu,  7 Dec 2023 08:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="KhnfhHDG"
X-Original-To: stable@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2083.outbound.protection.outlook.com [40.107.22.83])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CBC4126
	for <stable@vger.kernel.org>; Thu,  7 Dec 2023 00:39:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aNkATmy0YI1ToPUu56ZUCdv4qOUbYIqCOay01CjXrweXbfc4fD5EqO+od9jEj3f716oRioOCQSyD+ROTmkVatRn6VWiaYlyP2aXAkYu6bP70RY8ysg3nW6ZQEKoe1sjrKGo7j8hgLmRCCMA+m50puxMm7e4BUzKC2fc/d1iXIcE6MLkMXd98IaSIuu8SxQnkC/To/byJF7hnwcNgqbQ30UuUdrJ9QcDY9BarE2jF6Oc2JDGDoWry6F08R0ToOGA7msrpBSSGK/UzEoUSFroSHY/mII6wUabJrb7WcMLAGYBnFWyzzRxIhEtndYGFsHGaDcPFz4H4+pjfhQLHigi2gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vGgJvTPaF4Pq7UcgbvsviolCQTxAgZi2SSDB6JuW250=;
 b=BhrdCFuCzAmc6PKc7/ZRJ6X9Hh7PPYd8COwF5JzUP0Ky/49psEs14b2wRIQz0GzPb6e0BNYewoa8MUZTGiIc26iFqAR4zON9zVOowUEgGIDvNJlKnQAJLh5+hlWXI0tzWU4SNrNXX9DI519D7eCvmIpO89qB1PhPEJDvap1av2LR1aeWY7daPWOI5fyu/55dM7poqM2Ia5Dr9iHECRUY6s8DNP1NnTXeuEMyhp2Y6Wufu2J1jYWWSfoCI6cqzBqewQL3Ywgrv3cvVfah1nwM7VXm+msktafTn2FtEahkSeLneKY1tZdsMt2eh9IXqX0EicN/dKFiHlRUch7rwxbbLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vGgJvTPaF4Pq7UcgbvsviolCQTxAgZi2SSDB6JuW250=;
 b=KhnfhHDGTFZbuBuXxWblWZzCcxpIS/GhiCUZyRe8Xc7dGsoV3wXsnRvmpZLpU04pbx9qbQIfL+VE9Rk0R8XOn24TZzlpuzTEkzl+DBA5kL6hM2fMdPLzSOj320uKf7C73qPDnyIXCCCoIMp3Rj7dKMpN63DS4GwGJboDaJLRUTU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by DU2PR04MB8647.eurprd04.prod.outlook.com (2603:10a6:10:2de::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.26; Thu, 7 Dec
 2023 08:39:27 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::34dd:289e:9e8b:9c9b]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::34dd:289e:9e8b:9c9b%7]) with mapi id 15.20.7068.027; Thu, 7 Dec 2023
 08:39:26 +0000
From: David Lin <yu-hao.lin@nxp.com>
To: francesco@dolcini.it
Cc: tsung-hsien.hsieh@nxp.com,
	David Lin <yu-hao.lin@nxp.com>,
	stable@vger.kernel.org
Subject: [PATCH] wifi: mwifiex: fix STA cannot connect to AP
Date: Thu,  7 Dec 2023 16:39:16 +0800
Message-Id: <20231207083916.267108-1-yu-hao.lin@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0029.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::16)
 To PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9638:EE_|DU2PR04MB8647:EE_
X-MS-Office365-Filtering-Correlation-Id: 08feedb7-942c-4e5d-5eb1-08dbf700057d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	QELNwEclg3OLY44Pvz1ZbIaa6VkNh8hnjGIraylZVsIvMDcQCO7rHdfwv+37BIwUJ5E6PxdzKUyNCIojtL2FwAu+d1WnSrsnBPHVwYgQma5EyzROaIiJeFOqqeK8HPcD4Ixkcc08CztbipmCZA0vGHtv2l3VL6f8jV5FCle21UYzZVQ939dGPCjJp+xgWUsfwrcnvQ9PIuy1CT1CJ8RhIinm51u9n4OqJL4v37jPgpUzDgvEQQcuZxABFR/s9Yh8Nam+0LSVAHRNsTl+4itSW6NdRdFPLXR1xVMqif0F0Ao9Yqv3Vh21PerHoBc+v2ZpGEW3mEcy4ou1I/tQLFqG+yfQdpd02ao045z1klV2ufW8GWZeOOznult+IesvCP9vXCJKJtqL7yh0kapHkshgS7ZzESVVLshgusoxhQWreEHpb9lapzdd3h1QtiA01e1ZSOflSoXlqokJvfGiz59zOuyCoTpCkoII9jZhM48e/iJYH/hmwNElKF6B0zpRUTDQ3J6pxaXKsRBTPed+iTMDyfvv7+iIIzBXUMujYQ5H/5zBYsmh0ExvsY0uFD8K84mWQCiQeNKq2nuQ+A7dO+9zdKZej9zmUF2FteYOakXnsNB+au4XLRq8R+SdHSv/9eVI
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(376002)(396003)(366004)(136003)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(5660300002)(1076003)(66946007)(316002)(66899024)(66476007)(6916009)(66556008)(2616005)(38350700005)(36756003)(26005)(8936002)(8676002)(4326008)(52116002)(6506007)(6666004)(2906002)(41300700001)(38100700002)(6486002)(478600001)(86362001)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZDKmrJnIQ+q/Ew+IDQawMNtcOIK2/hDq3ewVSDWLxy/mMWl96ZXIGJOIzswc?=
 =?us-ascii?Q?bWs7/81dxlEgiBl3dbkPgtriNKZYqXmWphhYLn0BQytoz8ALbFtepyFHvuKO?=
 =?us-ascii?Q?BIYMI9JE7F+vAI09t5QNP9ow3sbBUMis9HrnOhzxWqfBCSIOQI7rdtgsAskj?=
 =?us-ascii?Q?PHOxvZVgYPwu/i7C6j0HXioO9XvdPWiKD9vlrFG5HLx0/AYek3usOKO7furu?=
 =?us-ascii?Q?uebgUPS9pIRVe8QryTms+nPDcq9j08wETeRExhNYxCcU0VGVZFqXc/94n5oQ?=
 =?us-ascii?Q?xpqLG4FVxi9aeTWD5NUKkcw+WqUAL1qefF9ydvHs5QX5TmpJO8GjHCWyGrue?=
 =?us-ascii?Q?Ku6rjhGFozr8zwbmxv5Bfuyg+RQOBn+wdCzpOMeW9R1JLE7U/HpfhdhrC1GV?=
 =?us-ascii?Q?xG0v8wjiSOTljzTniZqKfCT8IKgJX+zVK/xXO548igjcanCmOxXnY9y5SyL2?=
 =?us-ascii?Q?qi9i3CCiCo/8b2MZ8cQ5To2WGnvpe84IuT/96kmPI5Kz3OirnQSRnsmKIwJb?=
 =?us-ascii?Q?BT06L4tYfAykJmnxCGnsktEKh2g0ZxLMNQdocl0d4qOHCI7DmJllwLQd4XOE?=
 =?us-ascii?Q?tmjbfbmq29o172maXAb0/Cc22qndUSlp55m8Yx7oXOAArnPjaVKGTBpfI4yN?=
 =?us-ascii?Q?iVL+bZ+AGFbmqM/y1zKj+pq0VlS9BhfGhLpjfcDyIKo/swmCkGeshz4yjHkS?=
 =?us-ascii?Q?XBmPnNSvXHNFkr9gSz5MucUgj1WYA/qhinPWArTJIS3BG1ydw3S2PMGtl1bP?=
 =?us-ascii?Q?M798Hl8Z5k+ofpQ5vPymXc/vLgxL1M+V40S7wOijvV7kiir1xIbfzwGNJPQt?=
 =?us-ascii?Q?2ct+HUDr0yp3YcGS1m7rBlsX/tifZvLwRt2o4WMrWBFqmOnBpHZxm6epdSTW?=
 =?us-ascii?Q?txD2WKOtMoceXyrMTG8g9dAqdoKyyH/BVc2s2CfnMArs2HOZoJeRexoYUDdh?=
 =?us-ascii?Q?pTmU2AIM0TZ3k3/KZFgw18PTH/o8hVYMTBOFh183klT0Dm5BYaTSsSYoezgL?=
 =?us-ascii?Q?ivB2aVvEVMPF5xxGFnqMNn8ekMUuSNnkHDBVuYz8YI2APImDUUrLJrTZ+i8M?=
 =?us-ascii?Q?rZilyNdu1u1A8Q5GnUEaJW3obGIipgsD9nCBW6w1+m4tfmhgwHioRXfhRYd/?=
 =?us-ascii?Q?aXAt1Ts9Qu22iM7Fu2V1K956UC0KxV1/fPaMlSiSgJWq3kuGgZ7NahdZnLsU?=
 =?us-ascii?Q?BQcTD+kDXZI9+abo7DL6Mb2APvWdoezSH5iufIX8HMloYHoTuvSAc3vk8+p7?=
 =?us-ascii?Q?mPYDTUK1nH2CCSoYOvC8S6MSMlZ2pJpLfL36v1pdE/UO7Dm0gmI7yO+b03w3?=
 =?us-ascii?Q?FyTf7Rv5BpHTE3zX+6q8GsllZd38oEEXgGQZFUxgMuCSsMburQ+rSCEtjiIm?=
 =?us-ascii?Q?lodrSoxdNuI37+eKWGnhYbOL2V/936lnsB8RwOVN6JjKUF+PIKue9ydgwDcK?=
 =?us-ascii?Q?6AzfPGuAdWra355g0b6HuklA17G5/pbfgwQ6onaZRJIvJDyoszUG/9EFqqdl?=
 =?us-ascii?Q?Ddgy5S9F4O0W4Ri7WMd/9Cj/H4sxacBsfuBvsVoWce+YWbHC55ORyNgsvS+L?=
 =?us-ascii?Q?t1t9LbijzaWrPvCpOb/98xLh/Xr7x3yhItN9W7F1?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08feedb7-942c-4e5d-5eb1-08dbf700057d
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2023 08:39:26.9076
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GyO/OOKFAXByldWm0KN5jZ3TcP1Jk95gqoG3zENPhur8agfM2FuFuknz9MRZTBdWWYH4M70BmAm3heR0Cot3rA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8647

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


