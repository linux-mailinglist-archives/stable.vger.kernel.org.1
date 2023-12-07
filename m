Return-Path: <stable+bounces-4904-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE480807F91
	for <lists+stable@lfdr.de>; Thu,  7 Dec 2023 05:27:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 842B81F212A6
	for <lists+stable@lfdr.de>; Thu,  7 Dec 2023 04:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68E6D5693;
	Thu,  7 Dec 2023 04:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="YsiFWQF0"
X-Original-To: stable@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2051.outbound.protection.outlook.com [40.107.22.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69438A9
	for <stable@vger.kernel.org>; Wed,  6 Dec 2023 20:27:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UZTnXrOAFT7yd5pn8HmR6WORyiYYx92v54gTF4V3ax2dc1IeZdSVD+w8OwDQEYCnNfA29Fe+nJjO1QW0CgJRokYXAyrmn00PxThvRKHdDb11bgscjBnLjFGMLVXEq+RLbJFipFDCYjGjnzdmLFfNMRzWxFtqwUYzLgLylAdPkk+hlcQhHfHVnVfZNbQ+0HkWZHMniuZqC73/kh6INjDCC99VvljSt9LHvygKjfup54vosD+oyx6psH6Y7pj33Go5Tbxbxofjnholla6jup5qZ6YavX/goSmmCpTwjD1eG62/RxRO+oDSpvE3qGKCoytVmacPbR5yyEmnSD77YEbtWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OL5Y819qlfDwp4a57XDHMIV2KVl8xlV6AoajYMuWRwg=;
 b=l/VuOEVbX1DjcdmBEEIe/g31e5tfzj78/S/bkXHmMcv1SLwrC1Wg1ilsUj5jlH4cgfCwgT7Fpy/8AcS+IoLe42ZeK4+4RrUW5oSGKNh32zppkelalQO8fKPoLQrcNVJslxHjTEn3Z9MtPd7K9GOj4TNTHNM/URWBd4KEstlFgluV4g70+XjfE0BJUkEnlAZDxkKJ/eWs/1iVXhq/mAdMG/v7HGX4oxX7UgbNoeIuiGkfwiAUDqMqF2iDaRBYyP975qD2TPj2Tk+WhYe8Ag7vodi2xWW3aIeq/TJLpBqGETXwW/JI+8iPC19D//DYL89BZGNolP+GTVm3w6muYa6OEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OL5Y819qlfDwp4a57XDHMIV2KVl8xlV6AoajYMuWRwg=;
 b=YsiFWQF0SlAvZlYuv1lRyZqHJpD8lzDJ+DNL7b/0zCPjscREiSPkMDimIyDfY2LJMeSPEQEUfMw7gwTW3xeks4GahseYBa1WRIZ2Hb4zamPG9QIH+EMbgwtPlmCVGTYVlUwuWRZxKomEpDINyF6AAeLnZICvZVNHCnzkVoNGkdM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by AM9PR04MB8569.eurprd04.prod.outlook.com (2603:10a6:20b:434::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.27; Thu, 7 Dec
 2023 04:26:57 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::34dd:289e:9e8b:9c9b]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::34dd:289e:9e8b:9c9b%7]) with mapi id 15.20.7068.027; Thu, 7 Dec 2023
 04:26:57 +0000
From: David Lin <yu-hao.lin@nxp.com>
To: francesco@dolcini.it
Cc: tsung-hsien.hsieh@nxp.com,
	David Lin <yu-hao.lin@nxp.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] wifi: mwifiex: add extra delay for firmware ready
Date: Thu,  7 Dec 2023 12:26:15 +0800
Message-Id: <20231207042615.201793-1-yu-hao.lin@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0081.apcprd02.prod.outlook.com
 (2603:1096:4:90::21) To PA4PR04MB9638.eurprd04.prod.outlook.com
 (2603:10a6:102:273::20)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9638:EE_|AM9PR04MB8569:EE_
X-MS-Office365-Filtering-Correlation-Id: 97a90ff0-e682-43fe-9f5b-08dbf6dcbfd1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	v3ypPfce+1TNWbqa8Ro1cx7qOwJwrvUrHVum2AyjmGJaWsnRP5FlXslEMsk6jPb/2QdI95oxH0eHGvS0TQ3KdPbaW8KXchngMKbKEk++CF5pyUgviLsS8qtR6tkv9ZzVMThK5kTvfXRCLwluAsVbDG3UZ7Y3LPmI2S9K/KvvxRSs3ZXFrhhfOXiqkJ+pA65Yv4g6O8qlByVWD0FvG1AjhuixcivbNd1vvRTCuKkrWR5SDuUIaRSkmQqQslg4QByBGn/RmyKOiESOYMrfhMLkhrgqiw4DQ/sXX1k6xYg/WjPG79Zh+WrSzOAi+UD1Ec6nwaRas4cx1ca25cIDBktO5lzdkz4ieNr9TRJCKEbkFtAp4B5N4zS1qtTg3WfEE6f/n+SdhT2ECExx50GhPbAI/11oQNVuwm7jbuUTXm4x+x8BrqvQ9BqO4tReRy9ht3ng+F1m+NI6osWRlm0wAY1qKxJK4j0NqnMxQS6fBdOGZGreaxij9Wizrrgu/RpjbRWRwFbybGQGrTdiXXDhgiXu5BBq3MPsza/ukbwD0/FKdpW4rEsbIuH6HvqPBFfVBi8PrDTrpe4k/m60PrJnIhUbBg/ZJzAMqlrbuEWeqj44bC6ZvCPoYulDz38bUIH/6NqQ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(136003)(346002)(376002)(39860400002)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(8936002)(8676002)(4326008)(38100700002)(316002)(66946007)(66476007)(6916009)(66556008)(41300700001)(86362001)(36756003)(5660300002)(2906002)(2616005)(1076003)(26005)(6512007)(478600001)(6486002)(6506007)(52116002)(6666004)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4VrqmIkJmlRwBFxqI3GC5X/un5fxQUlkyOOn1QEoWUTFAUflzGPGI1AB/EFz?=
 =?us-ascii?Q?jmWvfL89juhZWAYcO4dVXF722Zt2KPr4nuRJkZ0RWFzuRsiLuZH9Y1yU9SOP?=
 =?us-ascii?Q?KyKWQgQRqWAZyXj0XP2D7q2/5ibVL/mNrL2lTHN25D98jP9GQF1zAr+P7WhN?=
 =?us-ascii?Q?rpcIbcZqeY/QT4J3WZA0xEjtRjjtD0mUsqwwkzckrD6ZU41KJSILU+8lc9hJ?=
 =?us-ascii?Q?oJdMJCez2soBjHyafkm2xsRGVYi4MJ4KwDMAJFS7LBk5MANvTiYTkFyVF90W?=
 =?us-ascii?Q?eM9+BbgXEXbWqaOrW6pihCQNr9kRpSAc9jaSoYZStbdj1jzb2Dn04hzrg3Mo?=
 =?us-ascii?Q?vmYy8dlT1h3kLiRYJojw1+7WRDIc6rXq4HgG2lMBPMA9S/u7cpKotCXQECAm?=
 =?us-ascii?Q?2yuNp9bpok49dDyUNxcYq3NdmQO9s9pcQ1hw1TacKbI/GO3XmOG0UAl7/jrF?=
 =?us-ascii?Q?je5TghbJBXsDU09S06tSS86tmhA9uIfRU0knumL87rNt9CmWrpAKYAmOgehX?=
 =?us-ascii?Q?rwMm3OjBAfUaF//3M69tz6RgGEvItv8Yb2zrRKKCQzS7fnDAwqfT9EUULIpb?=
 =?us-ascii?Q?F4/B2UrEoCzGgwNmWgRAFG+MldmvvBi4JEofC8Y/HIEu/E/wIcmggyfJcbmb?=
 =?us-ascii?Q?t64zaVM3rdcbvxrCNgdVM145opOvZDI1ORWqAkabXy6G59VCigxftSObrXsU?=
 =?us-ascii?Q?tZA2VrZURqx9bzBknabj/etv5XJ3ncmMiTdkiwTujXvC7OMPcpjx7hZekz6Q?=
 =?us-ascii?Q?lpMVrSo/sJ3eHX/0/C44OiKGbNh6RfK6xUjtvySPi8AQl2xT5r+glP1QJJm1?=
 =?us-ascii?Q?AXLOZM7GJHBb7ueqs+Twj36Xwt8ZHOdriF2PfQb0ij46mBxx0O8Dc4BtPITs?=
 =?us-ascii?Q?sl97NULybIairEpjtdJe6q4A1EuNjXmCWj7Tv0kJfqKoQc5bhUJqC32Oh93a?=
 =?us-ascii?Q?EumucwD8Ng38dqy2JCgAj5osYfAGTWmi0tFjMxr2Sir6VcHAMKmSDUmpkd9M?=
 =?us-ascii?Q?gF/hV9Q2dRog29xIfP/a4xVak34QBbJfmnSmnwOq4Ldt/pGKjdjwOnqvOmdz?=
 =?us-ascii?Q?JssZvmHg7Xj3M92useiQdcE+1t74tq61y/lCsSC3ckIV1nOwJiH5tMAUu6Yb?=
 =?us-ascii?Q?KIAvHHqtcXtlStbRwMGdIJYxuT8I7AR7zO8Y5CytRUDtERyE9yYb9u8C9kl3?=
 =?us-ascii?Q?dY5eTx7bdR4dMkR62ClmJAYqOSZWY7NAyQ9VvhXr7fZHYMpPPGaR+PgpMAYx?=
 =?us-ascii?Q?nZbLDtrE0Mo50iuEc5xC8yHlFio88lsU8coGlaWo8BF5evt0vwiAYaDtkwf0?=
 =?us-ascii?Q?t3XoYyPy1m5R/rRwombVpdRX3sCVns0O8kwiqPjBWQjuwAu1Jph7fejQm8t2?=
 =?us-ascii?Q?dKrltW5XmtQJX6ZoNWixuzm0xo8M14oTVBJN3dLpf5ciPzO7R7qsSyBxmRKE?=
 =?us-ascii?Q?AaxvCRPGH0a36e3z6G2pitfKmTZS0f75tn4nTjIV0p2fBuzAmGmJEgVaHxK7?=
 =?us-ascii?Q?twjmtyikV3flstEm+9iD/A6zyzJl3g4i5Ab+Lf7fbiHuoUL8On28JGiozCSK?=
 =?us-ascii?Q?c2VaXyBxLH9N6mwP4cySA8eciEMXLnKGUPNiQghE?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97a90ff0-e682-43fe-9f5b-08dbf6dcbfd1
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2023 04:26:57.6503
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aiL4ohsEjgTBHx4tivSVQdg8KOQmp1sjQN9NANiWZkI4VXni2DjSCAOSakHMxJ4VBzrRg15MNlDvhHOlQtpaIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8569

For SDIO IW416, in a corner case FW may return ready before complete
full initialization.
Command timeout may occur at driver load after reboot.
Workaround by adding 100ms delay at checking FW status.

Signed-off-by: David Lin <yu-hao.lin@nxp.com>
Cc: stable@vger.kernel.org

---

V1->V2:

1. Changed check condition for extra delay with clear comments.
2. Added flag to struct mwifiex_sdio_device / mwifiex_sdio_sd8978 to
   enable extra delay only for IW416.
---
 drivers/net/wireless/marvell/mwifiex/sdio.c | 19 +++++++++++++++++++
 drivers/net/wireless/marvell/mwifiex/sdio.h |  2 ++
 2 files changed, 21 insertions(+)

diff --git a/drivers/net/wireless/marvell/mwifiex/sdio.c b/drivers/net/wireless/marvell/mwifiex/sdio.c
index 6462a0ffe698..54db79888de5 100644
--- a/drivers/net/wireless/marvell/mwifiex/sdio.c
+++ b/drivers/net/wireless/marvell/mwifiex/sdio.c
@@ -331,6 +331,7 @@ static const struct mwifiex_sdio_device mwifiex_sdio_sd8786 = {
 	.can_dump_fw = false,
 	.can_auto_tdls = false,
 	.can_ext_scan = false,
+	.fw_ready_extra_delay = false,
 };
 
 static const struct mwifiex_sdio_device mwifiex_sdio_sd8787 = {
@@ -346,6 +347,7 @@ static const struct mwifiex_sdio_device mwifiex_sdio_sd8787 = {
 	.can_dump_fw = false,
 	.can_auto_tdls = false,
 	.can_ext_scan = true,
+	.fw_ready_extra_delay = false,
 };
 
 static const struct mwifiex_sdio_device mwifiex_sdio_sd8797 = {
@@ -361,6 +363,7 @@ static const struct mwifiex_sdio_device mwifiex_sdio_sd8797 = {
 	.can_dump_fw = false,
 	.can_auto_tdls = false,
 	.can_ext_scan = true,
+	.fw_ready_extra_delay = false,
 };
 
 static const struct mwifiex_sdio_device mwifiex_sdio_sd8897 = {
@@ -376,6 +379,7 @@ static const struct mwifiex_sdio_device mwifiex_sdio_sd8897 = {
 	.can_dump_fw = true,
 	.can_auto_tdls = false,
 	.can_ext_scan = true,
+	.fw_ready_extra_delay = false,
 };
 
 static const struct mwifiex_sdio_device mwifiex_sdio_sd8977 = {
@@ -392,6 +396,7 @@ static const struct mwifiex_sdio_device mwifiex_sdio_sd8977 = {
 	.fw_dump_enh = true,
 	.can_auto_tdls = false,
 	.can_ext_scan = true,
+	.fw_ready_extra_delay = false,
 };
 
 static const struct mwifiex_sdio_device mwifiex_sdio_sd8978 = {
@@ -408,6 +413,7 @@ static const struct mwifiex_sdio_device mwifiex_sdio_sd8978 = {
 	.fw_dump_enh = true,
 	.can_auto_tdls = false,
 	.can_ext_scan = true,
+	.fw_ready_extra_delay = true,
 };
 
 static const struct mwifiex_sdio_device mwifiex_sdio_sd8997 = {
@@ -425,6 +431,7 @@ static const struct mwifiex_sdio_device mwifiex_sdio_sd8997 = {
 	.fw_dump_enh = true,
 	.can_auto_tdls = false,
 	.can_ext_scan = true,
+	.fw_ready_extra_delay = false,
 };
 
 static const struct mwifiex_sdio_device mwifiex_sdio_sd8887 = {
@@ -440,6 +447,7 @@ static const struct mwifiex_sdio_device mwifiex_sdio_sd8887 = {
 	.can_dump_fw = false,
 	.can_auto_tdls = true,
 	.can_ext_scan = true,
+	.fw_ready_extra_delay = false,
 };
 
 static const struct mwifiex_sdio_device mwifiex_sdio_sd8987 = {
@@ -456,6 +464,7 @@ static const struct mwifiex_sdio_device mwifiex_sdio_sd8987 = {
 	.fw_dump_enh = true,
 	.can_auto_tdls = true,
 	.can_ext_scan = true,
+	.fw_ready_extra_delay = false,
 };
 
 static const struct mwifiex_sdio_device mwifiex_sdio_sd8801 = {
@@ -471,6 +480,7 @@ static const struct mwifiex_sdio_device mwifiex_sdio_sd8801 = {
 	.can_dump_fw = false,
 	.can_auto_tdls = false,
 	.can_ext_scan = true,
+	.fw_ready_extra_delay = false,
 };
 
 static struct memory_type_mapping generic_mem_type_map[] = {
@@ -563,6 +573,7 @@ mwifiex_sdio_probe(struct sdio_func *func, const struct sdio_device_id *id)
 		card->fw_dump_enh = data->fw_dump_enh;
 		card->can_auto_tdls = data->can_auto_tdls;
 		card->can_ext_scan = data->can_ext_scan;
+		card->fw_ready_extra_delay = data->fw_ready_extra_delay;
 		INIT_WORK(&card->work, mwifiex_sdio_work);
 	}
 
@@ -766,6 +777,7 @@ mwifiex_sdio_read_fw_status(struct mwifiex_adapter *adapter, u16 *dat)
 static int mwifiex_check_fw_status(struct mwifiex_adapter *adapter,
 				   u32 poll_num)
 {
+	struct sdio_mmc_card *card = adapter->card;
 	int ret = 0;
 	u16 firmware_stat;
 	u32 tries;
@@ -783,6 +795,13 @@ static int mwifiex_check_fw_status(struct mwifiex_adapter *adapter,
 		ret = -1;
 	}
 
+	if (card->fw_ready_extra_delay &&
+	    firmware_stat == FIRMWARE_READY_SDIO)
+		/* IW416 firmware might pretend to be ready, when it's not.
+		 * Wait a little bit more as a workaround.
+		 */
+		msleep(100);
+
 	return ret;
 }
 
diff --git a/drivers/net/wireless/marvell/mwifiex/sdio.h b/drivers/net/wireless/marvell/mwifiex/sdio.h
index b86a9263a6a8..cb63ad55d675 100644
--- a/drivers/net/wireless/marvell/mwifiex/sdio.h
+++ b/drivers/net/wireless/marvell/mwifiex/sdio.h
@@ -255,6 +255,7 @@ struct sdio_mmc_card {
 	bool fw_dump_enh;
 	bool can_auto_tdls;
 	bool can_ext_scan;
+	bool fw_ready_extra_delay;
 
 	struct mwifiex_sdio_mpa_tx mpa_tx;
 	struct mwifiex_sdio_mpa_rx mpa_rx;
@@ -278,6 +279,7 @@ struct mwifiex_sdio_device {
 	bool fw_dump_enh;
 	bool can_auto_tdls;
 	bool can_ext_scan;
+	bool fw_ready_extra_delay;
 };
 
 /*

base-commit: 783004b6dbda2cfe9a552a4cc9c1d168a2068f6c
-- 
2.25.1


