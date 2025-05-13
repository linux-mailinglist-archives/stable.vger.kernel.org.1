Return-Path: <stable+bounces-144100-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EE37AB4AEB
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 07:22:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2AF64671A2
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 05:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A5221E5B97;
	Tue, 13 May 2025 05:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="jmukUYDt"
X-Original-To: stable@vger.kernel.org
Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19011024.outbound.protection.outlook.com [52.103.68.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C4231E5B8A
	for <stable@vger.kernel.org>; Tue, 13 May 2025 05:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747113727; cv=fail; b=XrGXn+4CuyiOUWGHF40GQCdSvziAXMFq/MIxoMZX60gVVc7kDimr/oMxWOyoqIdCyXDuDbJxcdcwZNRz2O/hgHQq8Cg42q3+VxFexg/flovQMsv6WdrxlDR/mrGXtlqdU+KueKCBjktOc6FXMNVVZFro2PLMFia/1GLjDnydibU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747113727; c=relaxed/simple;
	bh=6iIanAVatHeyKZPyA+MOW44t2U7To3p9UqMpw/Pzf0o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rZwpobvfkn8nzg+TmmrTcXpiU9yZP/2xG+LpUGI1IU/WgV9CwnVVo/SBPE/djn0WMQkA2SwSW7bEtAvZQLXOM4RAiHLh7LcSgbXNhkTB+ZN9KPvuKwzfuI0rMRWqiGnYE5sGVrseKfG8mBvfLnIBhbU3kB23n6fORNaV0pD1VjM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=jmukUYDt; arc=fail smtp.client-ip=52.103.68.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L0AlBKNk8VG/6Y3AAibUzuG8T4435fKKzo7X9joThA5Jc6mVUY1ld1QWKx4sk8/IwlhTN38Cc1evZih/CeGAWfIwNkqc567vPGy26r8/cNxcegS9VBaDZYlP0d1HloF1H90mXuVRAQPJ0JBPewLgdkw+VRKkTIUqx8UMS3URDHSEtf8nSlYFlWLu2O324K8tUXFKU97cIa9w/CuNiFGS1wbnhzz+FjPtF6at/wY+m4+qwshSZWlVBf+/+fFHp7tY/Zq4pssqamlViMlhHBLsufg5iBkYuqoNO/m1Un/4pWIQdDzAqYeHTJP6oronLatqBjt1W9cpXgdn1/lujwc0yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d3RHLWvkNf8r9MYIjnhyy++d5EEwOW9F7+KjVW9GIUQ=;
 b=KXHox+7nWyfa00XYJmAKMiXI281HLePF22tyeiZp8hGfQRLkqSnP2xUq/GWtbqPW3gYgWBxU6+2ix/x++VonNqtely9BLqu9Sdyf7hEkIAzsR/Ud0KAVX1eCTutbxfrwuK+oKI95iOnZY3Xros+IdQyVGn7pCb8yRcE7unKxznawzNgYE031Ejfuk2RKSeDFhCNm+hyIxKv6t0XyNqWT97nYnAfpaEqjL1GJtwdQzHiaPL+Y+Y2yoEG2HQrelThd4pveCQ8mK1x91EtQ1nB8p5WYsGCOWapGvkFwiUWelZJfJZx3m8+tYfqZM83Kl5cCcAWeefqiiHDQTy+9t+JzKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d3RHLWvkNf8r9MYIjnhyy++d5EEwOW9F7+KjVW9GIUQ=;
 b=jmukUYDta8caGW2y+hLyP+ErrJdZl5Xtdn0Tgda0qasyCN3VI6OLAfE9eor/sOp4XK8auq3iD051ZU+9wTJdb3kqjbnXX0xAvCXpe/zygmvnAu+SQgksBO0s1J9foCr8w2rw097NYOl1EslG+hMjwRGq65n2Lg/FDpOmG/c90cPVelc0pOgpvbztqJnUtPeTdC+wgIKyhGt3Yoa0lx5pxijS7HkXk3W3gYrHvT/P7mTe15m4jGNGjr3lwEGU8Ro9eEsQlWvQj12+1Zd49zpUHLmx7sEmK9U4SJm7YgytFiUHOoNo6H4OTtoRcNTPvJuYzfAtRdZOxMK/NmbrnXH0dw==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN2PR01MB10258.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:1f2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Tue, 13 May
 2025 05:21:59 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8722.027; Tue, 13 May 2025
 05:21:59 +0000
From: Aditya Garg <gargaditya08@live.com>
To: gregkh@linuxfoundation.org
Cc: dmitry.torokhov@gmail.com,
	kernel.hias@eilert.tech,
	enopatch@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH RESEND 1/2] Input: synaptics - enable SMBus for HP Elitebook 850 G1
Date: Tue, 13 May 2025 05:19:49 +0000
Message-ID:
 <PN3PR01MB9597BAE0F2CA6845408AAD36B896A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
X-Mailer: git-send-email @GIT_VERSION@
In-Reply-To: <PN3PR01MB9597A25E7A73E2034C4C07C0B896A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References: <PN3PR01MB9597A25E7A73E2034C4C07C0B896A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PNYP287CA0088.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:2b6::8) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID: <20250513052135.7997-2-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|PN2PR01MB10258:EE_
X-MS-Office365-Filtering-Correlation-Id: 5dee7182-309e-4d39-929b-08dd91de15a7
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|19110799006|7092599006|8060799009|8022599003|15080799009|5072599009|1602099012|3412199025|4302099013|440099028|10035399007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bzHvbqdQ75YA2PiGtbi5UW68kj+cl+Ja7ieTSmL9Max3nyEGiIxznIOepwao?=
 =?us-ascii?Q?A/qHT7O4Dlo0el/a8VEKVVv23IQFcR4BCYYlbN5YiyWC7FGREq4zzo32BTo0?=
 =?us-ascii?Q?n+J9udzn9QJFODg5y1KO/E7RLpV9H/w+2cu/tnpM5Qf8+bwpcjspayW9RyQR?=
 =?us-ascii?Q?wuBOLEtwmvD9XTeOwLkONk/W/yA9Hj3wxXerTk+0D4PcPwGnm69mZ1E6Fych?=
 =?us-ascii?Q?qoVcfZw39KEoWHE47f5eqLzhI9kl/k7Sj4TROvJ1LDndelkZzbjRPVdJX6zF?=
 =?us-ascii?Q?QLu7L680vzDmG2APIUhCAAFS56UXr9QTqiyZUcm2Ze1xQt3Md7FFnaniUazg?=
 =?us-ascii?Q?8aIaKXZxoPrXohwmkkbOjOXioJC2W1dwm1Wh3C6mBcNH5IQn6ppNA6WGlRlu?=
 =?us-ascii?Q?HL63AB6ktnl8R8uEBcphm0jDN6qnXhLvJvwz803QmM39uJSUL7rQdjSRPZTa?=
 =?us-ascii?Q?LtOJ8o7Y9YlhzYeEU4AP6DwlNANCVmgP0Zy/I0M2ftwnKJLwXHLc7c1OdWVC?=
 =?us-ascii?Q?Xfpr6pmt+KHzfLh+SXvzH6j6PIHDCz+mxpGRtmfY1fmGt15DNS65m9kq7RqX?=
 =?us-ascii?Q?1gzQgbaoBKSw+mxkzsDF7f5G++DlBEoRfC8/Ng0qau14G54kpzLbz1bisXtU?=
 =?us-ascii?Q?bLm2U8/o38r1ykbdgwpB4PUjqnEDuHOnYDqT/I1ykw8zhWMart9QlLwO0bfN?=
 =?us-ascii?Q?kyRwZCkQQ85ueQa797pYBfZ2ROwKNzCNl/v2q9MRofPlCvEdU4CIwPyRVqj0?=
 =?us-ascii?Q?2EuDP7CWljF5lGRewSeCf5SD/TpJmStm8oxuvUAb1wcCA094Adz3r0LzhSTH?=
 =?us-ascii?Q?WC8e+LSeIugQF4NPfBAmFS5+TIm8+pLJN+R2k29HU2Xk5GBL5c0srvjgnUx3?=
 =?us-ascii?Q?qr55lQxSVXkI++U+a5RktenRdWYlYlDkXPsDe+ejaWXULWzahKBjs4odJndH?=
 =?us-ascii?Q?lnbdtg0RIQlljCnVNsOjaXjR2MS0iB2T53EvF/42M18tAhn9Y8zYFdsMpYxI?=
 =?us-ascii?Q?V1IvYdluZEXNt+L1+kbTNWMDwBiG8ufLlVIPEVn1Re0w8nuckWjS3Ldcv1IC?=
 =?us-ascii?Q?jOhaYOi8YJX5wOMb4qH5QJanZ0FReXClN4fhrN2AxRx/df9DX8lT87gIg5gY?=
 =?us-ascii?Q?SGthSIZboMiwSFUrPofaOiFXhjAqnQ6x9wQ1WoluOj8N82NXTtq+4wVcxPzQ?=
 =?us-ascii?Q?w5k5Rck7ywNTaCFk3ezDq9SRXUjcYPHX5crlSIkI0XIe9eKd2VfA7QG+NmQE?=
 =?us-ascii?Q?TBzmoh8wZcSgvjUZ/UK2?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vWmAio3+XoQN3nU+YohA47evY5r2C4pxJ1Aq5vDbVMakqo70uI/qsYYHbs9t?=
 =?us-ascii?Q?7x9++c5UVnuP6TZJsvCQe6IA7/TiQ9zAh2Mt6zpumiXmlmFtBqB3Mlk3xAa0?=
 =?us-ascii?Q?B0uP6AiPYzpCkuZPrY3RGbp0AAM+uhgXz6eI94V6Nr1OnzmL9wgJjNOrW3FD?=
 =?us-ascii?Q?y9jjje8NqJfOptgSENkRtEz5W/2tWlAZQbGoE3Rlu4/zsWS6/ftL2WnmhMDc?=
 =?us-ascii?Q?4ildXkBnIagVrxRag1w7FTpJbY9ta/DSnoGIKlIEfpY1lDRrnW24Zpd7FF9s?=
 =?us-ascii?Q?M4Xx95vxME45XvijMn6Mu06IheNTXIwJSpMOAQEe+8+BeE0pEauj8V5c4pgR?=
 =?us-ascii?Q?dRftABml4/Y5QiToSr+dH1kf9Ep68Dnv4R6/FPOpvIdvkkA/rl3uJkWP4W0l?=
 =?us-ascii?Q?4rKDK9g26LdKuI2GCDmNrKeM8WnpaG8ZTdz7gxdKf4tC6nwgiR0rshmM9Gbt?=
 =?us-ascii?Q?cB7Luq1QcMHFLSLnzCMqFSMZFbSdNk7QWxwyTTI2ZH4wsxx05RjY+Nmw+SHY?=
 =?us-ascii?Q?IPn+E8qTbphggToDoW0h1XEceZ7RNLRG8A517/go6LDhV3CsWmIWg/Jq8/PD?=
 =?us-ascii?Q?UR/JNTR83hdtVK5XeB5yKrRF4YXtAGHJKkyOMpd6yDarrJZlxevAMF9iILbS?=
 =?us-ascii?Q?pdMuaVkqatYNnAVHP+ihOz+VS1MtrLhDgmdVgndoAVU7UlkuNolyGeXLptVq?=
 =?us-ascii?Q?oxPevmWY41tib92OhYpkWy+5zWPzq0BnqioA0y/Aj1ojrtYuNHGmB7ix2EHO?=
 =?us-ascii?Q?WtCLcj0lRZvaQp0IWSP4GAIPsb2IfvRQT1L6Ds2THrRImVzCfTBrM9+HazXp?=
 =?us-ascii?Q?SY8qEy0TqoMvxIv06XM6l6w5CJSy7dfQogZ2OkDpJVVIGNiHg1PwkKO3Jdve?=
 =?us-ascii?Q?pImWMr32Q1DavnGswf0oLxvGajQ+YT9Gv+WsaRA4Yyc5wB1kfgiWASUcAItW?=
 =?us-ascii?Q?OLTGxxVbYEw7cGwp12RBUGgIAsCtSz/LWqmlyDdt6dlJiD71SFXQc1FcMKMf?=
 =?us-ascii?Q?LkXne+SX0AnTCyTtE9GlYN6z2w4DlNiDfTTXufR1aP4/Q5uZiUL94fhP3aVA?=
 =?us-ascii?Q?34KpttYCPMw0/hnIGdHbgq2MycP4Q0QeeNcG37GeMzSD3fd6tCpSqojBZQ0t?=
 =?us-ascii?Q?KGJ4bgaYIa0pqhrhl6elFTfa/TdscT3eBPEJffx7BYtqO8iAODzv4jNmT35S?=
 =?us-ascii?Q?0woBxN0HtNda7goOQ1TgMmYLJvW6uPfovXKhpiMn0X1wBbniLIcVw8fIdsk?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-ae5c4.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dee7182-309e-4d39-929b-08dd91de15a7
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2025 05:21:59.3833
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2PR01MB10258

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

commit f04f03d3e99bc8f89b6af5debf07ff67d961bc23 upstream.

The kernel reports that the touchpad for this device can support
SMBus mode.

Reported-by: jt <enopatch@gmail.com>
Link: https://lore.kernel.org/r/iys5dbv3ldddsgobfkxldazxyp54kay4bozzmagga6emy45jop@2ebvuxgaui4u
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Aditya Garg <gargaditya08@live.com>
---
 drivers/input/mouse/synaptics.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index 9cfd2c1d4..b1adc0f3d 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -185,6 +185,7 @@ static const char * const smbus_pnp_ids[] = {
 	"LEN2044", /* L470  */
 	"LEN2054", /* E480 */
 	"LEN2055", /* E580 */
+	"SYN3003", /* HP EliteBook 850 G1 */
 	"SYN3052", /* HP EliteBook 840 G4 */
 	"SYN3221", /* HP 15-ay000 */
 	"SYN323d", /* HP Spectre X360 13-w013dx */
-- 
2.49.0


