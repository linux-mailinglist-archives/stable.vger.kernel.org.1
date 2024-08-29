Return-Path: <stable+bounces-71527-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D0B7964B44
	for <lists+stable@lfdr.de>; Thu, 29 Aug 2024 18:16:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 138452851C2
	for <lists+stable@lfdr.de>; Thu, 29 Aug 2024 16:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB8491B3F0A;
	Thu, 29 Aug 2024 16:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=witekio.com header.i=@witekio.com header.b="r799F8oG"
X-Original-To: stable@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2120.outbound.protection.outlook.com [40.107.241.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A3211B4C30
	for <stable@vger.kernel.org>; Thu, 29 Aug 2024 16:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.120
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724948090; cv=fail; b=jIoO+aAZL6dZnhbiiXgCU1r+XODLgjWPI3Nuyvi52glr9auqdcO5hcyrcgUM0u9z9hiF+Afo75csxEfhIFMmXIUX0Is4IrD88i+OVWAj7AwP2jilMsOoOPBY5Td6EWRtbIX0oePs29Efykr0c7CRqyTTSuIcJGeGNqsueOcGi38=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724948090; c=relaxed/simple;
	bh=mS50oBUJUPv7TC5gcVKs43KT/aVOcQoiSkek6x80h7M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XaKkUeEhzfNnEXWLwmlZOetQnlDYQl6IHHTxvw1NNpS3rzAW1vjI4/iJ9KtLBBdWbjELM9DpdAaBipoJlxlfTNweX5wLFjJ6p+CplljkprVi//J2p9DEsGMW9fE0kg9zhevFWabWV9IlCqexjGcCla0iybhL9cejQPjIWZouIMY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=witekio.com; spf=pass smtp.mailfrom=witekio.com; dkim=pass (2048-bit key) header.d=witekio.com header.i=@witekio.com header.b=r799F8oG; arc=fail smtp.client-ip=40.107.241.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=witekio.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=witekio.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SRPdxcppGnyCj3CXgvH+sUP7AM6TVNHgxixggRw2uUhmhdCfGUzt3NZk6BMYx7KtzWEZ02DEPH/ccRVTeObgw4Fd/x0QUIzYwMezMtvQnitJ3LO2CrFQfqTFHjjBlLYBXWg8nVboCx6iMRbzFG7ZEtYvSbw7JPtBqpIVinq0GvkZ+5hTP+fCtTTHyYDWEDHIWcSHVXK2eTyy2VSfRKfBUr0TfCYz/byCWyOgIPHFcX5DyBr56CIsq5IK91b0ppBYuMSaX0hvZtS+hNVKl4pEtvdPnA4bZyCHQjsB7ZPimE5FWRR4n7/UzJD+bEsfijKNSaM+3I400r7zlS7/b/TwGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=975+0YqsHg0Wj6fSlrUsuFZcqPrjqNlpye1p+qKJI+4=;
 b=DzLZe/ah+DkZ8kE5TcbAxMa5Mofhb8/aWlvUaDdNrQTvLHyffi+t9MKeOPQ9wA1UTTFvErUBPgIg9aLbJgLB73JEyywiysh/JGcAbnSB4ogK9V6fRqNPHv0/noLtWZYGeeQYPxXJdWDryp0hDhu6pdCQhG1k2F8MXNK7Y6CODwSdJu+fRPXEPOqraEqgV0gWjq/Wy9YaBV377Jep4auKH/l1YQUNZxGBwb6y6l58SUKRZeIxv7DYIl035fjwiPJjKmxJEPSfDH0QXUkWasiVmZhEgW3EnnABXJlDMEKaHH2wRbUg8/E1z+cAxxSyOUI4oJoxMjY6lkSdIGiT70t+qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=witekio.com; dmarc=pass action=none header.from=witekio.com;
 dkim=pass header.d=witekio.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=witekio.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=975+0YqsHg0Wj6fSlrUsuFZcqPrjqNlpye1p+qKJI+4=;
 b=r799F8oG2+NrA3nsykeJYDVt+b9j6Y3T8ksLfbTbgo/oDcbHtfkUeUfV8IC6J5FfzpyEf+8Z2OUkezEZ66zxM7qKlHLkhCs2fX45efQ0nb9gY+8ls9PE57cXurt15+i1c8mnyHQpJuA1ix+aVJDWr+M9AVASJNh1I4y3udONaeEsfHrXYaAgjc9iZk5KHI7Xr4JqKQFZc1rZWtVMGYCQyqaI6f6A4OzUvDWH1xVMsxhc1LIv6OpF6HoF5gHJJPExfAnMRs82qokCqngN1Gzlto69R06o8K8bWQEkvYj26JWpQ2OvnRY+wRbxgcRWsvA4C3YSLzJt2E0lP9f+SC6rrQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=witekio.com;
Received: from PR3P192MB0714.EURP192.PROD.OUTLOOK.COM (2603:10a6:102:48::10)
 by AS2P192MB2094.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:5f3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.28; Thu, 29 Aug
 2024 16:14:38 +0000
Received: from PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
 ([fe80::345f:a9e9:d884:3091]) by PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
 ([fe80::345f:a9e9:d884:3091%5]) with mapi id 15.20.7918.019; Thu, 29 Aug 2024
 16:14:38 +0000
From: hsimeliere.opensource@witekio.com
To: stable@vger.kernel.org
Cc: Helge Deller <deller@gmx.de>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Hugo SIMELIERE <hsimeliere.opensource@witekio.com>
Subject: [PATCH 4.19 1/2] fbcon: Prevent that screen size is smaller than font size
Date: Thu, 29 Aug 2024 18:14:03 +0200
Message-ID: <20240829161419.17800-2-hsimeliere.opensource@witekio.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240829161419.17800-1-hsimeliere.opensource@witekio.com>
References: <20240829161419.17800-1-hsimeliere.opensource@witekio.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PR2P264CA0027.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:101:1::15) To PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:102:48::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PR3P192MB0714:EE_|AS2P192MB2094:EE_
X-MS-Office365-Filtering-Correlation-Id: 46697a11-b582-485b-1199-08dcc845adfe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?n7i9nZSZHwYmnJS7mnNPzqm3/03YjxYudD+EyzTq9P16pQmNEyXOeUMFAC4T?=
 =?us-ascii?Q?vgcTb7vcjRmkXDLl9/hkCKD1gVoUnybr3zHLkcOXdtTpDsPIUjqg7gMMKFf/?=
 =?us-ascii?Q?wgypD7BDMKutIJ71jh4T5nQ8DVOWi9/Z967oQ58VJO+40QP1c7hgM38Z8yvf?=
 =?us-ascii?Q?rPpMHyjmb65mCOLytP9S1e9HxNHnPQmr1eWyyEXp+0tS05W5bVRdtP0iCyKf?=
 =?us-ascii?Q?sGEfkZOiZj7mpIGJBQt944miZT5otQi4t6zUWld3Mr0j7/XtxuwOSMSggxi9?=
 =?us-ascii?Q?qQQ87luvK2K6Pc2mV16G/CNnZxpTg6G9RG4w6bpWUeq8zY8szQjwxyKSeWxe?=
 =?us-ascii?Q?+UYr5nxbTNwEhoKFNrpDOJ1fEaqF7qWQDOIq7lNFj1+UXqRsfhLejsErBmFv?=
 =?us-ascii?Q?ISKNyvPOoQRQqcH3Eu2RZfw/TC8c12CieZrZDkep87UBuEBf9kon/KuZ1Yp4?=
 =?us-ascii?Q?Vvpstr5nzrADVpJyUjFDeBLR4ZFK9kMXE2S23Gic4RpnF459pEZqgoNXTGpi?=
 =?us-ascii?Q?q0clbQaiXSs7QWtgGd9ConriH9T9iBDhuVckwh2ai6bl5Kn7k3PaaQF74c7j?=
 =?us-ascii?Q?Eypk+fwLZYlpEP2GTKtpmeQOisAzNTPrI9HsSepOzWQmChUPP/K3xXIyC0rz?=
 =?us-ascii?Q?+W43K+etrOu45kHj+U/Z/oVTYIGyqI7EKesG8IS4U4rZMdJ+4slVK0Ga5FqH?=
 =?us-ascii?Q?Eet9hOItORvGjSmFsVX7NPMraKMCQly7Rx92LX/RhQ3Pgt+cnaIrVd1QuJ2I?=
 =?us-ascii?Q?DEv3IaCUou6enVZAqxcfnxjZa1DfH4P0sN+r1EPJ4V66mHfDN05qwuOFcLf5?=
 =?us-ascii?Q?zM0L2jXqALFvM2jOZmLHu02vdAXFndqwgvMugsNWYVgE5RElttEuBm11AVMw?=
 =?us-ascii?Q?j9G+kZEX1si6Il8QIh0GKWAyHKzx1w5pbPo4rzDnQPndf9pAbC1ME5HDVohm?=
 =?us-ascii?Q?yfr158gtTVOk7HX7Y+gZQwNOJHs2QcnnVQbFsReJt6qmhFhJ1Aa1eWQPpHa+?=
 =?us-ascii?Q?hk7YGkXP+xe72uEF63GswD69ZMRiMdpDV+Ue/2PLD0BDp6DePQ83YNThHTgV?=
 =?us-ascii?Q?iX4WYL1MVeI8VZXio6D+grQF+fgC83mQRlM0myu/wMHKI8PgcWDgnKFTBh1/?=
 =?us-ascii?Q?yHScnqvc6ag1b/y60akX4DOg/FuTygvNnp0JZ3ycMtgzZinXw2U6yR9djCT3?=
 =?us-ascii?Q?w65uzR+t/qONYipC3PoXkutIaHn2H6kavHkyqtI9kyNd68gvFhEMISrJjiEf?=
 =?us-ascii?Q?pkQLaCc7MKcEB6IpcRbcXUID1SOK9lklSAudqcUTuBJlRPDJsFFXOdFPqw1e?=
 =?us-ascii?Q?BBXmB8eGhz1yhLtfrRqHPGp3QSxB6ycZqdurEvtOj4vBbup3NNN88niMx5NI?=
 =?us-ascii?Q?y+7huOuz9LFgvLIcK0TgpdQkBvW6yReZ1bjr4NpTIcJijny0kg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR3P192MB0714.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ydbcOs2wLcRJhStRCtEisymFjneEpjm8vhu52J+2Ul65LC/gM01qxQi40Dko?=
 =?us-ascii?Q?p1E3ghhcCOjdbWu+EEgzCJlOMVF90x6Dhbahx+738WH53FcQX26CVoVtwfxB?=
 =?us-ascii?Q?9aTwDTC7LuvEkqHhxyC1TkU9lIf1D0wiyZ+cIdg7PbitTyL6NWURAdpbRDBj?=
 =?us-ascii?Q?btQSfXSmTxJFYFB2z/YPJ+odK1pa9C09FgZwGN34bV5p8lbmSzvJ7e3CgI7N?=
 =?us-ascii?Q?wQu/u3/wUormz/TkKuEu/rI8QtgPV7bO9Q8dxyXig6BDnEKk3nIzVI+ZunN7?=
 =?us-ascii?Q?k/fPOKVy7LlH885Xz3/tv9bJQuMu8vsWMBrLJmVSdDSSPxLXKmKZ1ixunMkQ?=
 =?us-ascii?Q?sK3fguApuv4EFzu5i2MBturcSArj4wXVLtNbow+Zvw+nsuX03XFqJmfvF2JQ?=
 =?us-ascii?Q?QaJB6VlR9B78XPdfTvIv+52yhr4XWH8+slQrU+NF88CGCY77K7T1Z2e7dgXy?=
 =?us-ascii?Q?i20skTCrzKxWCnhyPGQDgxxy9zASCfWVNLQX9RDzE8QToc9tAUv/Mt3TFyOC?=
 =?us-ascii?Q?pQgnEPfghCj9H8h08kui6CGkXjRfCdqipYJfmCpnHSYccFuSaaw5VLfVE9iR?=
 =?us-ascii?Q?OUHtOITr+XEI19bnWTGCgEohMGolct1Gk/m5qlga6TJwfcAhhPm9hIEqwJpw?=
 =?us-ascii?Q?yHaamGe9wkn9lweStU2dFk43aORziuvtUJnPeC7FNPyRQrwlfLSX0HXIXleX?=
 =?us-ascii?Q?Rhhi+WE/KlJBURgqccRJWFXAGKOIIl92EzjhtbSPEOd/2O6ufuSv/HG5kNhN?=
 =?us-ascii?Q?tgBZCD5rwwSx8cm0IFgQca3BX7cvn19PoBjZvkhMEaswEVGQCfclyMo24At5?=
 =?us-ascii?Q?1HzeCHKJUNOKPyMzOIPsPdcaC0XpWFUkZnRs7/K3fWVrjSaGNWcRMDa1zBje?=
 =?us-ascii?Q?l1Fwu6YBu6jvVz9PtcsrFcjVNSoZju3ZFksIG+QSJhYo6wWKRaTnMyj9xFPi?=
 =?us-ascii?Q?t86Uezq4CKHfSes6MlqcouylypEVWRw+I+QPJBZb5yuqFZVj7+IvpCqLnNIN?=
 =?us-ascii?Q?r91TKeob8oK76xJ95xbiVpGaAEIJPCOnxHCqYYhkKpYend6CGB3YSvnfSetK?=
 =?us-ascii?Q?5Fta186pmeqC0rvt3BhGJviDOMPPesVK6Q9+hLV5I/GCJAhH5ERxglRbfByw?=
 =?us-ascii?Q?VzGbLLsTEqEL0q4qRj//rORMgeQt1/i3SRC7S5cHmAuuBPwy2dd751kT/j9N?=
 =?us-ascii?Q?h/SjdIm9cQ8dCzrG0FR13l4QUU74YvZUX5P7MVnZ6ESsK8HlTfgr60avKUHr?=
 =?us-ascii?Q?eRO4709IByPe02H4tmgSe4iKha3iJKH3NcpZg0cFNnZ4kq/DuAOt9H1Wwkiy?=
 =?us-ascii?Q?PVLTnsNs4V76S89fQd5gwpxNPNF69vQcN5De2esvoIIukdlpreYQSy8R+p4x?=
 =?us-ascii?Q?pfhoMpoNwCZL/RK7TBBxSZvSwawhs1Oj5TgU/DVF8fayFJL3liR6j/0bRRnB?=
 =?us-ascii?Q?/aGfz1mdliYu8sZ2J86xim2UlHNMnapiLIyvtzH65g2x2d2e8UoMgZw1vvfF?=
 =?us-ascii?Q?wJ8RqNnyuuIocvM2+/zmqK+jZt4Ogc7vuITRvg7qaD8rgNlkYZBow3mzDLXh?=
 =?us-ascii?Q?DJ22cAl3+x5+yq2nBay5iuQMK9zaOd4X7BXeuRicTWSkV+9h6t46Qh0wj16U?=
 =?us-ascii?Q?cw=3D=3D?=
X-OriginatorOrg: witekio.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46697a11-b582-485b-1199-08dcc845adfe
X-MS-Exchange-CrossTenant-AuthSource: PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 16:14:37.7909
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 317e086a-301a-49af-9ea4-48a1c458b903
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hHA/gEkr8gX8IdLknvfnic8IA5Y1nTKZz9Dw5waaLLfcmif4p8HH2+S2YXET5IwtPiC9qkbAVmN591/G8+tzGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2P192MB2094

From: Helge Deller <deller@gmx.de>

commit e64242caef18b4a5840b0e7a9bff37abd4f4f933 upstream.

We need to prevent that users configure a screen size which is smaller than the
currently selected font size. Otherwise rendering chars on the screen will
access memory outside the graphics memory region.

This patch adds a new function fbcon_modechange_possible() which
implements this check and which later may be extended with other checks
if necessary.  The new function is called from the FBIOPUT_VSCREENINFO
ioctl handler in fbmem.c, which will return -EINVAL if userspace asked
for a too small screen size.

Signed-off-by: Helge Deller <deller@gmx.de>
Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: stable@vger.kernel.org # v5.4+
Signed-off-by: Hugo SIMELIERE <hsimeliere.opensource@witekio.com>
---
 drivers/video/fbdev/core/fbcon.c | 28 ++++++++++++++++++++++++++++
 drivers/video/fbdev/core/fbmem.c |  9 ++++++---
 include/linux/fbcon.h            |  4 ++++
 3 files changed, 38 insertions(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index dea5275254ef..402020776a3c 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -2734,6 +2734,34 @@ static void fbcon_set_all_vcs(struct fb_info *info)
 		fbcon_modechanged(info);
 }
 
+/* let fbcon check if it supports a new screen resolution */
+int fbcon_modechange_possible(struct fb_info *info, struct fb_var_screeninfo *var)
+{
+	struct fbcon_ops *ops = info->fbcon_par;
+	struct vc_data *vc;
+	unsigned int i;
+
+	WARN_CONSOLE_UNLOCKED();
+
+	if (!ops)
+		return 0;
+
+	/* prevent setting a screen size which is smaller than font size */
+	for (i = first_fb_vc; i <= last_fb_vc; i++) {
+		vc = vc_cons[i].d;
+		if (!vc || vc->vc_mode != KD_TEXT ||
+			   registered_fb[con2fb_map[i]] != info)
+			continue;
+
+		if (vc->vc_font.width  > FBCON_SWAP(var->rotate, var->xres, var->yres) ||
+		    vc->vc_font.height > FBCON_SWAP(var->rotate, var->yres, var->xres))
+			return -EINVAL;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(fbcon_modechange_possible);
+
 static int fbcon_mode_deleted(struct fb_info *info,
 			      struct fb_videomode *mode)
 {
diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
index 2297dfb494d6..4449c1fa9f76 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -1121,9 +1121,12 @@ static long do_fb_ioctl(struct fb_info *info, unsigned int cmd,
 			console_unlock();
 			return -ENODEV;
 		}
-		info->flags |= FBINFO_MISC_USEREVENT;
-		ret = fb_set_var(info, &var);
-		info->flags &= ~FBINFO_MISC_USEREVENT;
+		ret = fbcon_modechange_possible(info, &var);
+		if (!ret) {
+			info->flags |= FBINFO_MISC_USEREVENT;
+			ret = fb_set_var(info, &var);
+			info->flags &= ~FBINFO_MISC_USEREVENT;
+		}
 		unlock_fb_info(info);
 		console_unlock();
 		if (!ret && copy_to_user(argp, &var, sizeof(var)))
diff --git a/include/linux/fbcon.h b/include/linux/fbcon.h
index f68a7db14165..39939d55c834 100644
--- a/include/linux/fbcon.h
+++ b/include/linux/fbcon.h
@@ -4,9 +4,13 @@
 #ifdef CONFIG_FRAMEBUFFER_CONSOLE
 void __init fb_console_init(void);
 void __exit fb_console_exit(void);
+int  fbcon_modechange_possible(struct fb_info *info,
+			       struct fb_var_screeninfo *var);
 #else
 static inline void fb_console_init(void) {}
 static inline void fb_console_exit(void) {}
+static inline int  fbcon_modechange_possible(struct fb_info *info,
+				struct fb_var_screeninfo *var) { return 0; }
 #endif
 
 #endif /* _LINUX_FBCON_H */
-- 
2.43.0


