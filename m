Return-Path: <stable+bounces-201154-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 47AAACC1AD8
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 10:00:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8198730053F6
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 09:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E8A73054EB;
	Tue, 16 Dec 2025 09:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hailo.ai header.i=@hailo.ai header.b="erOcJPKG"
X-Original-To: stable@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11021098.outbound.protection.outlook.com [52.101.65.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F087545948
	for <stable@vger.kernel.org>; Tue, 16 Dec 2025 09:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765875640; cv=fail; b=ATbE3qhzsS0dWhMiOlExve8yaFvq82i2IroPpdum5BG95ke/bDWzcOuqUIlDa3RUkORkAxm4Ir7I3r1WYW37tsYFj7SerHBGi3Vjg1Dacsv/t9xEKPiOGa5CGHYxpnuH6+3z7v92rGkyoUM9Zo8pJq8edNo1cnIieSwXU5OB1eA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765875640; c=relaxed/simple;
	bh=3WKFi/sFuIlBJpPVNgzy4PKRxNHCliGvzrLpYbujQ40=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Jji4kVl4RXQ3TMJg4navTByUr3oMAxK+QL1j1bptM/HjJIUeh+3TSM/YHEV/i8PU3wcjvVGJ406O9gNkR9Shju4xXirCL2kWE09D6HE0XHKwdfI4i/gWJrNQrsZQ67U7oG/Q28tZARYTMh270fhovkI1VPux/FOwuN2MtYW7iKg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hailo.ai; spf=pass smtp.mailfrom=hailo.ai; dkim=pass (1024-bit key) header.d=hailo.ai header.i=@hailo.ai header.b=erOcJPKG; arc=fail smtp.client-ip=52.101.65.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hailo.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hailo.ai
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J4CKhwoLBAoDF3RpnqvWablcwtJk9H7L792i/jplpcA/P9ehYzObclk4+S6Ah1luRdy96c9NoLd6pne2aKjBWLT4wbi4/jocn5qkn0+gyiukMH6bKEbh1kLZjDIHCGP+hb+egiU3ktvMukeirDQjz5Yic3d+mQa0SewYVZlHYs6eej/Q+DBM1QApTHvVwgpuZNayIXW55WDIljmIX6fWKgqOnaYPach3MLaTN3/iY2ETqI9aZg2dXpi35guxmoOOuBEw4GV9qnoZM0k9EtlUON2uUD1m8wxrPPEDLJ6Oe3Xq3ma7ZfceXbdviglGQA46ODyb4mfgjvQJRvDRdQnZ/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oDH13l0qgtckHXxKxJGRXtkCdrdrKhYfkT7PebVkwGg=;
 b=L5X6UMJu5HF+m08DGDD+GO0K0qApeEZn1ZaCYeuKzBIHiQijSPAFPfSHuJkXi7K3f8IMxgjKstT1KabXk+VArbSfUYQoINwq4Sggn58cuup2zUSPizzk4IAKyc4kvrOvhz6Lph4G3pE6jCR2hHsLscJLavir2aCRgyPdNEhwUu7KqYKuutxT8h1yatDR1ieTlIjTAkhj+9iez5P6tfXqbz1sDsm1/qd4wnHHxak6kZsyu6INKXWW5OKUNJFcoYqDNLqJIJbQfEB9V9Iqhdh5s6BMjD/leJ7bLKuOSZGMxG1/7dgtYySGyDZwSlqfidSnyZSPwcd0l5HhA5KK7+Iong==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hailo.ai; dmarc=pass action=none header.from=hailo.ai;
 dkim=pass header.d=hailo.ai; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hailo.ai; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oDH13l0qgtckHXxKxJGRXtkCdrdrKhYfkT7PebVkwGg=;
 b=erOcJPKGYpYjSu0O3DAW7hnC4591F+R9dMGchOr3BOjMqMVxu7Su+887FOKLvRI3DTSt9yrc6ARP0BIc9EqBNlNIkpA64bx9WzYpTUWnz4IVv3Kv1yrCysN/3h9gVbEtm+zNCL8x4RxdS6pOoxUXT4Yl18+fiosUBPTSqtNqrRg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hailo.ai;
Received: from DB9P194MB1356.EURP194.PROD.OUTLOOK.COM (2603:10a6:10:29e::14)
 by GV1P194MB1954.EURP194.PROD.OUTLOOK.COM (2603:10a6:150:87::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Tue, 16 Dec
 2025 09:00:32 +0000
Received: from DB9P194MB1356.EURP194.PROD.OUTLOOK.COM
 ([fe80::f805:511f:699c:7c1f]) by DB9P194MB1356.EURP194.PROD.OUTLOOK.COM
 ([fe80::f805:511f:699c:7c1f%6]) with mapi id 15.20.9412.011; Tue, 16 Dec 2025
 09:00:32 +0000
From: Amitai Gottlieb <amitaig@hailo.ai>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	sudeep.holla@arm.com,
	amitaigottlieb@gmail.com,
	Amitai Gottlieb <amitaig@hailo.ai>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Cristian Marussi <cristian.marussi@arm.com>
Subject: [PATCH] [STABLE ONLY] firmware: arm_scmi: Fix unused notifier-block in unregister
Date: Tue, 16 Dec 2025 11:00:09 +0200
Message-Id: <20251216090009.13435-1-amitaig@hailo.ai>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TL2P290CA0014.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::17) To DB9P194MB1356.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:10:29e::14)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9P194MB1356:EE_|GV1P194MB1954:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b417185-e698-4963-d57d-08de3c81913c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?reTphkZLzlqiPZt/0rKjyH6bfEmG7vAVEe+ju8z8nin6sdOPdd7GudpFwG1g?=
 =?us-ascii?Q?yEwkHfuF0IMWkCR/PbvzT3Y7tpKO3i9IUAtuEwRl4htQzAe5Nr2B3NO3Lobo?=
 =?us-ascii?Q?AYc6tZymxwnMj1/uFkZKLh2tiHr944dk34geJF776qZKltf0LJMcRPoQ0Eye?=
 =?us-ascii?Q?9lGfFsZo/kWU9P4ywirPRazw0X2sMwSRFvG2u3QlERmljNau2Z1slB3/+FNT?=
 =?us-ascii?Q?zoR5fpONn5Zlspb9FZPMB/MvgYqFn5RrPWfRgzrez86CFn2A8CP3h27pNkKE?=
 =?us-ascii?Q?oOyd/45yVLUjgLCrdo1zJfrly3ua2MCO6zXX2KTuj/yrPS6KdfreaxmdKWEh?=
 =?us-ascii?Q?u8SUSqCIRsA4+hwbnTBrg9GP6g6l1TqrH0ptts6TICMLWIMwl9PkAru6jNVX?=
 =?us-ascii?Q?XVuVlY5lk0dh3vvo8m8Dj0IzHwaWWhL0vNkppcjk/NlFHr4veUe9Fdv6EWc/?=
 =?us-ascii?Q?zGq6WdCVTDrWn0jR/NA3ju1QGBAve0gM0K8LrBgLBF7KB+rO76St0yc7kIK1?=
 =?us-ascii?Q?oI9zg0R1FgXUW3aNPtaWthfK8EJXAFFTX43eKe/JSbqB7l3K+FGuuUkuRBRC?=
 =?us-ascii?Q?sJ5nl9ijBk5NUdRVxdhhdMJSQ+Ase6Fkxy7wFi3zgbSA4vRIoGQFbnipRRj1?=
 =?us-ascii?Q?ZbTwGLrn6yPbugqkKc0hTcuaIMeXCX+Q7uc+M/qMppRzPVhwYQc5oH7B7HHR?=
 =?us-ascii?Q?gI9M1xksVcTktHCspXQ9juEW2Cg7QmKpPr4lZds67mECU6MTpb7P2V+WKwnf?=
 =?us-ascii?Q?HSayl9istYwlavD23FcoQjg9W+Rv2iRGqZgER6o+DsxPWhp8lWAUDgk8N9KZ?=
 =?us-ascii?Q?uuQ1AjTqTYVxd5in0wBjsQlpvlbqPGUqH1XL7dr3yJz0/3XZ7kx6Q+v59tsU?=
 =?us-ascii?Q?UI3jnFXJFg45y1OMZZAOfI9qRZsEs8hPcrHFc61UR4iKzebXPNswNsnOr2Ya?=
 =?us-ascii?Q?eQZaZk488M4yTwHzNjzrIQhPFQy9Ou42s+97XqsmNTCrawlwtPrxZiJrs6p9?=
 =?us-ascii?Q?dwaGS/EDJGRWZ/F2EygVDv3XLqRcgL+ja9+lrpl2lynnKEHg4G5Y3QQfRZ8K?=
 =?us-ascii?Q?K6YR0RT2j5ifNm0Lypab21b5Tq24NsK3BYNRCKpq0O8uNrd0rTPJc3BMldax?=
 =?us-ascii?Q?m13FUaLdQKhzZvl6CD+Qc/d5S0PWBXTtBd0Z0f50DkTCsJfq3FPlD3yuQRRk?=
 =?us-ascii?Q?x61WjRSiglrbOuQR79ojOy41vzkJ3HbVa46UE0oEEKpI5EONrONqCeBIDAEd?=
 =?us-ascii?Q?tS/sPWgskTRVKuXdviCZsZpf1BKYN8kfCeKtC8HvSD6GioSyiRZExFA7hELw?=
 =?us-ascii?Q?iQFSzonaar0JxhNYaF6+rHMGC5QfFzddNqY6aee2MyTm85TXWs9Bs6urHc+V?=
 =?us-ascii?Q?JcVnAGTeiZaDqtUHqaKocEQ+DiJ76kdBPHciYHa93JzKNcoVMnRDjeoJQq6/?=
 =?us-ascii?Q?07jj89WNC4iuug09XfELOUSrln6hzS65e+TQCEBsUPNBBvl/Enwn3PaZHYSE?=
 =?us-ascii?Q?1yL6NkBufvtzFhM6pMyIef3zak4mOUwSITWj?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9P194MB1356.EURP194.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/7kvc6puwxBN8qu8sDh7HaXcQfv+Z1LYFMt7q3SrMIOe2DFmUa4P4rgnfAcY?=
 =?us-ascii?Q?ZvabmLcILWnWdk9JmsNjJp1aX86U9LYfsuiqKB4+dU1CgNFlWPSRSb38Q3Wa?=
 =?us-ascii?Q?hXa/cPqCO+3SSIEn2lZMZGS2yEHBSvlI8MkBKzz/P5IKBAmMfsOYyU/y6hZb?=
 =?us-ascii?Q?EIF9hrGY5WVvgPouP6rp1qKfb2WI7VbOHpGNFI0dlEUCj1wN1zo8LSDW3mH6?=
 =?us-ascii?Q?gC/cuo5L65wzM5Kf9KR3WhzLdARLhM0xFJGDBTarQf/TJ08cMajrKNna5WBI?=
 =?us-ascii?Q?c/bv+bd6Rgzpu8ie/y6XRRldGLeMHlmX796oCfN/C60qrsQ/y1O9N2Fw+1kx?=
 =?us-ascii?Q?X58cXHQOk5RyMLadHwpIXs2DL703k9N8zjRAi3jIovTVbMJxB3ZVOziQFEUU?=
 =?us-ascii?Q?pqZ0fJAQbgbT/l+vDewEdm8MgYsuwF+4gS1GzsPlSoiaELctKoKn+9ggsl6O?=
 =?us-ascii?Q?stavsq2kut5yUmyfqWRc/0PdEfbhC+jIjqZ6ACh+8ZANJqMvvlAofIn4ZjIm?=
 =?us-ascii?Q?hyZn4bxbVqfw6g9I0gWcN3XRT8L9ZaH539hNL1u84tH6MaeSG88Co/mODzQe?=
 =?us-ascii?Q?M0AeLeAXvb5E6LUDZCw+HdZDDMl6q0gAYOdTGvx/3Y4Q7wY7LENO7bGHGItt?=
 =?us-ascii?Q?ZnB+9+3C99Tr+Gp47Hg7IZoRyCoOJaegu1+gKjkSuCOkUrrdv4w0NV/pewX0?=
 =?us-ascii?Q?ZtHUaNLz6rldK/PdMrDUEzETkOOAhexaJbj3FhVmn2deW551PKeTN/UeQQth?=
 =?us-ascii?Q?v9G9RJDr87wL/Bn9phK2i4V8xwQUjslDqvMWgpr56PnQij59rH6s9eVFBYnj?=
 =?us-ascii?Q?lH4jJe+EoY3nf3R5LwFO6VF/HLuuFmznMuCWij+4B6FeSmJBrGk7J/j543hQ?=
 =?us-ascii?Q?AvJVQsChJ+1r5vlzh3ItqVM778XTXxMR0DU2PmqwqUvkQg17tBclTgiUj3RS?=
 =?us-ascii?Q?zA0M3baIuJIjxenP2lJ5FMk2ZYvV2VZawIXEz5dt/3+M6hDjZMtp+x3/g9dq?=
 =?us-ascii?Q?jFMggVFT8MIsTHV1rbQLrf+lBUXeV0KXgpiYKOHKcAv+/+IVZ2u9ltpG9jtJ?=
 =?us-ascii?Q?VKzTkmLSeC++5lzJR0GTL3Ext2ox111KwTskl73/VsP1OsLs+87hRrhDxknk?=
 =?us-ascii?Q?3j8xst6Uu4xxJUpxN/sTwf/wAxauCfrbCuvlIAs7l339xBU9nOTwb6Uf0Ohc?=
 =?us-ascii?Q?RKmYkDZLSeJ9OK1QbPSCLEjcCJaI/8B1Ph/AUegKGzkramv/CX9UZVZiz3lF?=
 =?us-ascii?Q?7EUD/8ctNEzQ47Q8fr1nJUnt3AJFDLECH58VVJzJc5zrCofM9RqaK2PzYnmA?=
 =?us-ascii?Q?fuGoCDySEps7XGFWuJKRmoZ6aqafZiHKTUscMylzc+bTvlhDPBMA4PUoDUES?=
 =?us-ascii?Q?zMuJpXj/1viwF9BtDiQMZW1sT2ci165ob3xyBqyAkylsf5DDNMxhmueCr+qs?=
 =?us-ascii?Q?ITu0+d8BU/AbSJU4DATIrdRfJ0qqotWmHiFRnW/D0hKjNVc0DDhzh+OUO9DM?=
 =?us-ascii?Q?j4FjncgIlJwOZyMvssLmMDupouIEJ8DIFZGkJR0VI5S53B7hIrC5vC/wq/+S?=
 =?us-ascii?Q?c7+uFaN9XiWV98wg8WDDtksT9b+u1DqP2rUKPj3A?=
X-OriginatorOrg: hailo.ai
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b417185-e698-4963-d57d-08de3c81913c
X-MS-Exchange-CrossTenant-AuthSource: DB9P194MB1356.EURP194.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2025 09:00:31.9814
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6ae4a5f7-5467-4189-8f6a-f2928ed536de
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UzHdBuSb62/nOY3/2H44A59Fj44J4Cw7VpglxgdRvgsA6uwQCgx3UIGOQyq8DQSDCoCPT+x7CPCQCImYAY8wjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1P194MB1954

In function `scmi_devm_notifier_unregister` the notifier-block parameter
was unused and therefore never passed to `devres_release`. This causes
the function to always return -ENOENT and fail to unregister the
notifier.

In drivers that rely on this function for cleanup this causes
unexpected failures including kernel-panic.

This is not needed upstream becaues the bug was fixed
in a refactor by commit 264a2c520628 ("firmware: arm_scmi: Simplify
scmi_devm_notifier_unregister").  It is needed for the 5.15, 6.1 and
6.6 kernels.

Cc: <stable@vger.kernel.org> # 5.15.x, 6.1.x, and 6.6.x
Fixes: 5ad3d1cf7d34 ("firmware: arm_scmi: Introduce new devres notification ops")
Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>
Reviewed-by: Cristian Marussi <cristian.marussi@arm.com>
Signed-off-by: Amitai Gottlieb <amitaig@hailo.ai>
---

 drivers/firmware/arm_scmi/notify.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/firmware/arm_scmi/notify.c b/drivers/firmware/arm_scmi/notify.c
index 0efd20cd9d69..4782b115e6ec 100644
--- a/drivers/firmware/arm_scmi/notify.c
+++ b/drivers/firmware/arm_scmi/notify.c
@@ -1539,6 +1539,7 @@ static int scmi_devm_notifier_unregister(struct scmi_device *sdev,
 	dres.handle = sdev->handle;
 	dres.proto_id = proto_id;
 	dres.evt_id = evt_id;
+	dres.nb = nb;
 	if (src_id) {
 		dres.__src_id = *src_id;
 		dres.src_id = &dres.__src_id;
-- 
2.34.1


