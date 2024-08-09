Return-Path: <stable+bounces-66106-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C348E94C970
	for <lists+stable@lfdr.de>; Fri,  9 Aug 2024 06:57:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E857BB20D8E
	for <lists+stable@lfdr.de>; Fri,  9 Aug 2024 04:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5376167265;
	Fri,  9 Aug 2024 04:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="NhaHZGYH"
X-Original-To: stable@vger.kernel.org
Received: from AUS01-ME3-obe.outbound.protection.outlook.com (mail-me3aus01olkn2167.outbound.protection.outlook.com [40.92.63.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B20D124B34
	for <stable@vger.kernel.org>; Fri,  9 Aug 2024 04:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.63.167
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723179450; cv=fail; b=J7vx5caNSzYHsxsaEzOuXUw4HwEZyFUetyLnpKQMfZDpYia6aLTqmayUrgxcxcotD4ySXzBhA5T3AfF3qqxsPDws/GX/VpLivIIl0628yUUUB78WRuL4Ej05v+6pK0LDR9BsJRe/ZRGVqGkgf7tCfFV2vMlOTeQUEruQiDE7vsk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723179450; c=relaxed/simple;
	bh=kjYq/I+FSFn18TwOQR6g7zC+7BOpPdAQD127TM9pitI=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=PjdrM5P0TQ/ku/2+B1+FoR953nbegtd02ptqY4r3nwSH+XHHLfYw6Ux/wYP6gVjsHRQXoJt1mIhOMVx+30XfX/tZr5TaiqiFaSW5FSyhjzuXxlSpSbk6CU2/M53dX4tNOIVA9DX3OuboRVB9SsqRCFEQiexxPbQDhdztpeaXchM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=NhaHZGYH; arc=fail smtp.client-ip=40.92.63.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bRcelKMkCaPud9D9H5ScOzva7qdhZ2ZLXEoIE1frJA13RJmhKQo+qKCorzQml0h+0kWE3C7dbxfXfL01yFdiY0KfROIe89+XOxQ6yARgfqCnYgLOWi8cCMuXiuCyViL5GkRfIwB85KgdazyiiyeokwEkQOk6u2ECqQW3fLuH2n4MqLFcHa1y+isuOrus9Yxx9nQ9RYYOEmInNBrL4ZKJx2SuhIw9Ys0u6RPSFmLB1OdTjaCW2pLM1CyZqIKOnpFumXk6GasORzT6P4U5FeLgIYP66RrDXS7e8v5aPU5SLzqoEQfcV157jORUTSTAFRM9FQq0og3owJpIPnb/CNb/dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BCawfo+zm0pKiSncRw6Hh/PRbLv3qOx2RVNyJD3YIC4=;
 b=nYoKSL9TXTt8XCXMVyypgAXIJeNs1qqggO5YJb2pDRfetyd6fmma0afWXl/Y2Sci2XBKPC+Jb17ppc1Hthi9atZ0QdjNHQ6yI/NRyvlFa0BZjEXx/i7V1KXS9uUHo/auhiZ/Vmis43aSAktjnIKklHLUcKngAZKN9brQ4giuOQEyTqs/0sIpgPETqdo6drLSIDbw99786SmlItHneKyLCt5+O2qkSCmCAPeCsAD69BEd81FAkE2o+/FJrLElziQ3xYotvYhwnhyDl+MaZF+27R2ILczQB3xYalyB66+qUUhIFINj+/23C7zN5AEkUs8SkwvaIHXi8P/PwW3/EqkzHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BCawfo+zm0pKiSncRw6Hh/PRbLv3qOx2RVNyJD3YIC4=;
 b=NhaHZGYH8UP6Zq+NQdLGcQuVdYvG4s2iJmkXFnzmnoq4V88+Azgzgy3l3hXeeXDgaoEi9fP0HWr+5FwbtzmQK6hubJLJapTTMhgJLOhVT62fpO3AMzcAr/8hG6ncy9pXjhdIz5k780fE8t+GNrE61NWMr+KP92r/XJX+VaZXch6lJ68QrLsYu7m/NLStqaKy6wcAXuN1MiKbw9JrT/ojzXKnbnuUQ/a1UalssGDlCFiSffSb4nIjF3LFsBM0q/IyBzJsxBzX0oBJ/1TPegob2SRdr8D2oiH4p/dLsEwTJvM8pD7OFNO+Sb3/BZOklbDM2XJCcA/IESa6OE3/60JeXQ==
Received: from SY8P300MB0460.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:297::10)
 by SY7P300MB0605.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:28e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.15; Fri, 9 Aug
 2024 04:57:25 +0000
Received: from SY8P300MB0460.AUSP300.PROD.OUTLOOK.COM
 ([fe80::14bc:d68f:122:f4f2]) by SY8P300MB0460.AUSP300.PROD.OUTLOOK.COM
 ([fe80::14bc:d68f:122:f4f2%4]) with mapi id 15.20.7849.014; Fri, 9 Aug 2024
 04:57:23 +0000
From: Gui-Dong Han <hanguidong02@outlook.com>
To: hanguidong02@outlook.com
Cc: stable@vger.kernel.org
Subject: [PATCH] ice: Fix improper handling of refcount in ice_sriov_set_msix_vec_count()
Date: Fri,  9 Aug 2024 12:57:09 +0800
Message-ID:
 <SY8P300MB046050B6F1ED04DC44FB2BF5C0BA2@SY8P300MB0460.AUSP300.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [l0kRpR4hL1VphaFmxzYcCdA4zzQqQST3aQbZZ99bArFWf209en5XQeWsJL2RRhlI]
X-ClientProxiedBy: SI1PR02CA0043.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::19) To SY8P300MB0460.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:297::10)
X-Microsoft-Original-Message-ID:
 <20240809045709.4916-1-hanguidong02@outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SY8P300MB0460:EE_|SY7P300MB0605:EE_
X-MS-Office365-Filtering-Correlation-Id: 0544dde0-ab0c-477e-6c57-08dcb82fc1ee
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|15080799003|19110799003|8060799006|5072599009|3412199025|440099028|3430499032|1710799026;
X-Microsoft-Antispam-Message-Info:
	aiPZUz8CjbHekSnzFt5iH94iAh23zyUuhBTUZut9moBJErzR/LcH8VnMEPBDNPzVnVYdxGAHkrxy/1Duv7KsircdmjyUhqC/X7F6ZaE/8Ogff4sS1/kwDuN2gjbaZxoF3m7rTa6fslzBJVypeqBeJUifc86d359D+q3DP6/oU1G1dvRvBlCDvtI9LIdb4tY0acsSXU8Qg3N0aubMgl7ShPoHq9Xepl/OdKhJ/q4wzcH9/csz39H0Wrw+eAW16f+Nl77nUBdqTlX4pWrdKVImMTQ+QzV/wzYnz2mbuztO+pvK09hyXD+aoy6uTKbBtLo3fBUGMg+ab/dFA2SQfXpxptLjm27gDLKxPzCSlBjeFx9+lFMtTQdg7YDHUkkk2iMOXOqcYq2qo+ZzHG15btY5gFNzs69mV+rQbHnhV5I5Qq02Jh18JdlSi23yyIgW+VvQsi7G9mfdtjfqY/wqgyAq8MPvNmnRT51KexPnDMuQ+VGxOsXr4gFmBVbH6/k/6l9rlZoZlaqrfCuyNkCw/CR89UmkMXhRp+zYyq8OucPHUwQVe8FYYraQz61mnyoM7vkUbfeM6nrp3ZjNfKNGc8jk5uS9L7OPYsyf9CuRs0By7EjnneSiMU89W4BobwuREgYkd/qdQPrhZ79dV7T5RBi88/zKgzivRVHrKSGzX8VlD3++mLHtwMZDunsfwLoazAdZf8Sf6xnlV/CWkw0VRpcabSA52TriLyiJLSGdVxd+ccI=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?c9fKuHLFpu6yDHy/mj/ixXlPW68nKefFsJIGFU3uGVVTql8Ij+35QNoPkvB1?=
 =?us-ascii?Q?TLVPHlXz4d3pAmqg0N/YnkKbatahdocWbnZUI7c2PLJc9dG6T+ZPIFtAeF69?=
 =?us-ascii?Q?9UOAJ9KT2DRqJbqWKB1ZsWmyz31nZe5HBTOojDS4fi9Zg9stlNAg7BLyhjzb?=
 =?us-ascii?Q?BF4DZ+Ak0gJCYaX6CTffXNw4nowT4fN4qj6G86AJK/Gsk22QbQNTbnGNQ2Ui?=
 =?us-ascii?Q?HnHW8yr/pFBkDZtJ310WN7ybHJBv4GkFgidcpMME+UMircIdXwwVGvGcCkn0?=
 =?us-ascii?Q?Xy1kGaGKCD/RxWDXH+kkza7vgBldrFT18rubA4j7g71iViINxn1CfbVcs4fi?=
 =?us-ascii?Q?Z9AxqOZWqN8XJKmG+n8VNkYlzNtpn4I4wE4oVbnlskq/SalAAUh5zf3y+oSn?=
 =?us-ascii?Q?vKScJv4bTz7119kGrdE9WPPMhp3FrbSCwKCfLaRSwRyqupl6BK9HN+wdswMl?=
 =?us-ascii?Q?x9MdZC6pUq9D90NOsIyGRbKIh23hF6EXcRMSQM2mKs5V63ateGrzs2vrJxmg?=
 =?us-ascii?Q?+jhLBLrGXF5jF/zEdttZpEXQD5tRN8bRmeek8CSPu57xjpa2n6WL1xqBdy4l?=
 =?us-ascii?Q?lGAXLuKODwDa6j3INFrRL+G33wm2QfOK1YiiijhYMcsZq6avl3kPTLkdMM3H?=
 =?us-ascii?Q?z1pNhGFSmOe2h7jRmaJ5BTMe5rHd3E7FUAqYJXwgTt6E4Tn+MIXpco7B8bm2?=
 =?us-ascii?Q?ncHe51rSSTqDCh5zGKMvIQl4St5oTUEqWcz+NRmdrwc0TuQs5ZRn1hOIFQDA?=
 =?us-ascii?Q?NyoscOjq19JpVp2wUqUbQ0Z1zF+C7PI+0Pd3M1TmSbBWn5BHmIEufj8lxXl2?=
 =?us-ascii?Q?qmFTOUpDtFgH/LQYRIAmezvqTcPCnNs1irBL37HplKqda+qL2ZypWCmO3TW/?=
 =?us-ascii?Q?fXxFp9WwcvO2nzEa92uSjPJ8U6zmKFlHR6jJLVS0taJBU1juCZi65abneDtL?=
 =?us-ascii?Q?bMas6HG8m+G568YqmX9veFOpWMyQBMcTGGXlVBFu23NcFIajNbfMPFk3sO4F?=
 =?us-ascii?Q?DG4r51oQTMH2jnd+XDiiK0a5dzYCy606/zd0DYcJVRjHzhQVmp/LaB8wFDW0?=
 =?us-ascii?Q?z6graev7MFZRegjQgVNxYl5WFmNlbxMu01/hKyx0d6ynzFUUCA+xTRkP7BE7?=
 =?us-ascii?Q?beXjX6Hmpp3qvf0XrNLb42/1Gon0uObwvoEMw89xsSLKm016Fd734sZkGjKt?=
 =?us-ascii?Q?hv1Ht/Ndq1ZIxfkkmWFmI19a/bTaaowcnMCk+rYslf7edxyFPMFKycx9eipR?=
 =?us-ascii?Q?fc6mhNX5cwRh2nOcDZvHAq+WJf+Me5+GUtbwlHYBjF2yD9TMMh3fJVc3LbpP?=
 =?us-ascii?Q?bqqpuu8lFwLrHyrhGL28Bgqu?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0544dde0-ab0c-477e-6c57-08dcb82fc1ee
X-MS-Exchange-CrossTenant-AuthSource: SY8P300MB0460.AUSP300.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2024 04:57:23.8748
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY7P300MB0605

This patch addresses an issue with improper reference count handling in the
ice_sriov_set_msix_vec_count() function. Specifically, the function calls
ice_get_vf_by_id(), which increments the reference count of the vf pointer.
If the subsequent call to ice_get_vf_vsi() fails, the function currently
returns an error without decrementing the reference count of the vf
pointer, leading to a reference count leak.

The correct behavior, as implemented in this patch, is to decrement the
reference count using ice_put_vf(vf) before returning an error when vsi
is NULL.
 
This bug was identified by an experimental static analysis tool developed
by our team. The tool specializes in analyzing reference count operations
and identifying potential mismanagement of reference counts. In this case,
the tool flagged the missing decrement operation as a potential issue,
leading to this patch.

Fixes: 4035c72dc1ba ("ice: reconfig host after changing MSI-X on VF")
Cc: stable@vger.kernel.org
Signed-off-by: Gui-Dong Han <hanguidong02@outlook.com>
---
 drivers/net/ethernet/intel/ice/ice_sriov.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_sriov.c b/drivers/net/ethernet/intel/ice/ice_sriov.c
index 55ef33208456..eb5030aba9a5 100644
--- a/drivers/net/ethernet/intel/ice/ice_sriov.c
+++ b/drivers/net/ethernet/intel/ice/ice_sriov.c
@@ -1096,8 +1096,10 @@ int ice_sriov_set_msix_vec_count(struct pci_dev *vf_dev, int msix_vec_count)
 		return -ENOENT;
 
 	vsi = ice_get_vf_vsi(vf);
-	if (!vsi)
+	if (!vsi) {
+		ice_put_vf(vf);
 		return -ENOENT;
+	}
 
 	prev_msix = vf->num_msix;
 	prev_queues = vf->num_vf_qs;
-- 
2.25.1


