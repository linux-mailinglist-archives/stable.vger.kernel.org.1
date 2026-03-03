Return-Path: <stable+bounces-222897-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SHQ8KsP5pmk7bgAAu9opvQ
	(envelope-from <stable+bounces-222897-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 16:09:55 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 442E01F218F
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 16:09:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D7051310D0AA
	for <lists+stable@lfdr.de>; Tue,  3 Mar 2026 15:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6FC73D75C2;
	Tue,  3 Mar 2026 15:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=guidelinegeo.com header.i=@guidelinegeo.com header.b="c4idO/cu"
X-Original-To: stable@vger.kernel.org
Received: from MM0P280CU009.outbound.protection.outlook.com (mail-swedensouthazon11021076.outbound.protection.outlook.com [52.101.76.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F7633E373;
	Tue,  3 Mar 2026 14:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.76.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772550000; cv=fail; b=lwWZdmZmi3FOeBRN2ClBlJOU++U8WqML4SFcYLq6knKxHBJ/wc/WSFNDcLs8UAfeyH5c86V/IL9v2JRirpsJJckYODAb+ZhAsLalpjfFF5eL2HQbeFwNVWe9y+SViCzqvgdIK8B1Xiv+VVK+fMmZ/LYEiQZEdpXuVRhI4crVGEg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772550000; c=relaxed/simple;
	bh=vZqgWX3o9CbZ9nRKquaNO+aQeSw1XRci7M1brfqbLoc=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=SuZiIG+gHLiODfRh5bOsvmCQoLuS5dhmtyZEFKAkrR3yrfBYIO7TpKcXd++8CwjxnhNKyWLz8ya3wh37ZKhUOdl/jtJPAOAyvD0WGQbuOus7uF874ggBJjs01lJ5Vuo7/mVIj4KmGOg7f6BkUNXOvbnTSj+XZrfduL1ZmQFQN7M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=guidelinegeo.com; spf=pass smtp.mailfrom=guidelinegeo.com; dkim=pass (1024-bit key) header.d=guidelinegeo.com header.i=@guidelinegeo.com header.b=c4idO/cu; arc=fail smtp.client-ip=52.101.76.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=guidelinegeo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=guidelinegeo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YARZWhoneTn5G0z2d7QWFevsOvedO0vf9LNhsu7Hma95sgBMorT89uCcj9skNKQ8gjpa15CRiFUH5tFavBQmlqdbYVQ7eitaVpYtENOg3LmcU+eHzBcFV2934orOTPOV+l7oBb6RUThtkJhbm92YlWybfdocctJdM26bVdpL9gbYymG/txWiHxFkKmDNy4+sFEarWnZLqRGIScO3CDR+4x17z6FtdFmeY4DXja5AQMh0sKTLChopZvUAwJ64mhn2HfMjex1kJqorDcmreltDfjOb/x1qvj7ji7BcU22hsa+8IJm7nZAupBpTqm5Suon9DD0YtA4C+9/FYtuKgUHyPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LEkQ9dNY1XnxCyA9bBuiMFcOlaPpCMruxRKUrc6o1t8=;
 b=yq9h7wU061yUOI3s+PcJFouT+I3dnYHhNtULJMz0tT+qWtHWv0QlXotPp7n/pODulNKrr6ZmyaugMCORNHbjz8U/BHP3rx80Q4etFA6BTD5z4eBrOLdZ8XBL9HTCER6bfGteXPzwJIOZfEItqbNtTJUTdR1uCqa3FA0VyxR4tzthbldzJrhAAuT7X/i4hvAQyoSCo3XV0kB5yMRqu8sWrez3Puk53kTXMh83yAfQQA0CcxDUHygxbBJmLMWZqh2HBbxqRf4Ly0gu/NwQagEvDshFDSHlCsjnxhFwWAsWCLxobArzxzbOzzbfYvPtVCE3YahYpLiOkUDJQcpB4UiXhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=guidelinegeo.com; dmarc=pass action=none
 header.from=guidelinegeo.com; dkim=pass header.d=guidelinegeo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=guidelinegeo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LEkQ9dNY1XnxCyA9bBuiMFcOlaPpCMruxRKUrc6o1t8=;
 b=c4idO/cuDAtkfktx/SlofPKvMk1oD59t0mHdYPDrgIT2pzqPlRMHpMcY1o37IdPPPNcfCC1gATrOapGSCOMo1G6UIjaC2uOnpo9j8Cn2oSzy907Ii8BAFK4KsHJSP436W0Hfzjt1CwS3+UeKGDApxqOeqrw3G8TEcs/Jmdgk298=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=guidelinegeo.com;
Received: from GV3P280MB0065.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:14::9) by
 GVZP280MB0329.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:44::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.22; Tue, 3 Mar 2026 14:59:51 +0000
Received: from GV3P280MB0065.SWEP280.PROD.OUTLOOK.COM
 ([fe80::5a42:b24d:f94f:a5ec]) by GV3P280MB0065.SWEP280.PROD.OUTLOOK.COM
 ([fe80::5a42:b24d:f94f:a5ec%3]) with mapi id 15.20.9654.022; Tue, 3 Mar 2026
 14:59:52 +0000
From: Christofer Jonason <christofer.jonason@guidelinegeo.com>
To: jic23@kernel.org
Cc: lars@metafoo.de,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	michal.simek@amd.com,
	victor.jonsson@guidelinegeo.com,
	linux-iio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Christofer Jonason <christofer.jonason@guidelinegeo.com>
Subject: [PATCH] iio: adc: xilinx-xadc: Fix sequencer mode in postdisable for dual mux
Date: Tue,  3 Mar 2026 15:58:43 +0100
Message-ID: <20260303145843.1712811-1-christofer.jonason@guidelinegeo.com>
X-Mailer: git-send-email 2.47.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV3P280CA0045.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:9::18) To GV3P280MB0065.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:14::9)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV3P280MB0065:EE_|GVZP280MB0329:EE_
X-MS-Office365-Filtering-Correlation-Id: 71c1248c-b6ff-4b45-592f-08de79358642
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	pgcoMLFaHCdpyU5+PN2RjXwgU3AnmOja4LRVYM1rdDWOczDYAUzEdNdUlGAoXsXlBuQLPi9zTaIWx7VSl9KatoKXhNQTE+8hxicJdg6aENhGrXOnSCUMjey/4tYvxIl/P92hEDKXeVRT0CE6+079ADU246lOmzMaPWBL5Rv3EVs+i+Ex2Jj2/5fUYbmstV3WzziMWFQMyqR+FeQBoT5qgiBtjLnCl79m+2SPducrY3MVf+oIwkW9u7grXfUajPgNpiOnVw+5mHiWA2w8xBnuZyYbtj+jrN4wapYR5UBPTyEgCACFKUFS98qqutjVa0M2/qbSyo+0gqvmcZ6PhHPNqBkhEyfrdjEy6J8GfzuEmqETzdgqw7uvbBKYDu6vNebdmQYrzcBKj9V2crPQxs2PXBv7YvoMMvqJga8JC8PGIaeuwV4wW/SvYPLC4Rnl+zL1pk1mKRFjptO5J7WeVIURmpI0C1pxMj5ZsFvHvjWT1QrW90SGKeC7Ibbi8FKbHBHPShJ8PHR7m01PdE7sJsXypRL6+GQB0jdc1oMEYqqeWZAsRu4FQR/Xq7Yx8u1noLskMsGXCkzeFUTujMmk1tbBOSoHxxeFY04DwCKB9/vmuetSjbA1ISf2BwrxyJWx/yjC8TFLS9beA7nC+lAYURqhsCfPkPQCcbpUOXCgr3+Jhk3u73egMfDBLNp2WbGzYX5MJXasCJT9bynXUyIcH4MU33rZSROs+4DnC/2xwr4aR4svRgq6ICQ38G5Z2cZkwTY4KxD6zyZjToc6MOl5Ti1G8p0koV4dbNC5MOZCqdDuXDI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV3P280MB0065.SWEP280.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JldqWuT3obxtRf9kDopme8nUXQiBZjLqPooMbxwUhfC9hnMBV6cIzRjmZYFa?=
 =?us-ascii?Q?0Ehvbzl1C/GHzsaBIeHbzKAq6BgD7JkRzDmD8BvwnhHhzbhEIm37TQJ1SqVI?=
 =?us-ascii?Q?HW00vvs6OPVVR8oYNpw9VLG457gDPDrc/tX+NUwoe7R0BF95JCe6hhsTSz1X?=
 =?us-ascii?Q?XZrcgzkFbafHe6KHuj0/HOFQCUqXFJdpoIyjUuEYlo7T85IkVDuPa+hr/aP1?=
 =?us-ascii?Q?gKGtoiOkZaNM6DuJxv2wUq4qCIGFWJcjizgyPPGaCK4yQ9yBBPN+/XRnEHb7?=
 =?us-ascii?Q?dCBbUbx8VP+jB/BnDfl996h1IgEfILDyRaTAPKs2x6T+yy4MvprrjRv+DY1x?=
 =?us-ascii?Q?knYBiSojxGgH8u1RLgV5tgiQ/9c9EREac4efFijijB5bYypXrAdPhdgjsMA8?=
 =?us-ascii?Q?34MmTjniygLfQ9Fgd289dc1B4Dmce60oBjFoV1HoCF+vfXCKZjwvK7EAmz/F?=
 =?us-ascii?Q?A/+HcEo7jEPb9KeR9Gya3eGS186oUFFGK9WoQRJCtblElPDCY8OQFdUgz1/Y?=
 =?us-ascii?Q?93+gfmLGh4AS+3x2KV5wXBbbm6nO8oT9zAnT4myJkcFnMEVq7NpGYT6jhWwy?=
 =?us-ascii?Q?sM4XSTjGJ8JoCIrNIk4oUUS9Og2kRUZoFW45dAHFdRhOh64ETJtn61jMXQd3?=
 =?us-ascii?Q?OwV6AftpPRLTPt3kgCqg3A47f6IbRfi90aEg7B+3U7XfMniZM7IK8kqeMFw+?=
 =?us-ascii?Q?Zqy5Ij0BZMiW1WC8ldjVdcw4hQQomaoVHWYr3kEzP8DdmvPlGP5s9MtpRPQE?=
 =?us-ascii?Q?FAo0uplRSdiQgpslVd3cj+h5WriVMzvlRgXqX+0qfqurwVsuXo1pm9l796NH?=
 =?us-ascii?Q?Xe1k8tgI4DwtCoKb2LaMmAHPN7r8HVMQr+UKj/hbVGgLwkceU2grfAMYa6fi?=
 =?us-ascii?Q?mzlpMo7y2wtUjPlDHHGyI85w63LSHxXW8VTZRoTaJkO++Fj0VgU7M47wl/0f?=
 =?us-ascii?Q?gV98j5NqpcKAaV5BUCLkfFDhsoIYNPHYqj1dzdWYW63Tu1447hWTGDfVm2oi?=
 =?us-ascii?Q?Px4JLCYiBiZ0jcNKrWmjh6uaQkbivf/4bwquFE84xQVGRg9FChZ7d9nA5+S+?=
 =?us-ascii?Q?a3wdObIjpPT8CmnrBK0VD44xosy0tE30Qhj60r3Yo2MYJV+bbrIVDicZJB4B?=
 =?us-ascii?Q?ou/08oqDQIrlp2HqaE49e0r0QzDOmIp4qxh1x83NuYWYMp9ntdukLFIU/DFW?=
 =?us-ascii?Q?QeE2yj63wKdmlJYWZ2ze4s+F5jLEaUBcpQVS9QXWI9eCwkIS8r0SRPkjn419?=
 =?us-ascii?Q?l6Wpg6oUzkkG11gxlKObSF6ULfk/1H/HjtOOSn30zJJdO2gUUdTrMxJ9qcMd?=
 =?us-ascii?Q?UnK7B5Q46wWrMuNjviwyhEtu7snX7j9FIU8L7rt+fO0ZTNE66kAaVEe3+wCU?=
 =?us-ascii?Q?DsUHHUlstmZYOG0C6h5i10yHEGrdneIqvxkfD8Q1fgKr4wTExe4gHKefUAKV?=
 =?us-ascii?Q?eQWLU7LbJbN4v8iW2bx+wIZm1ThOIwQfZu2Vszh6ZsdBHnfUz9AUk+btB9mq?=
 =?us-ascii?Q?1xj845kKcIhvRvelXKlhhg/kkb4mGwNgTcm4JUMUTkJYfP0hq48v5+y1/z6q?=
 =?us-ascii?Q?LjFePdlGygp3sOgNoRxS31l87f+lmYasduyOY1bpTG3kWUJtZRdiH/V30oSl?=
 =?us-ascii?Q?sHKnn9+xYQ90QzswMeKTxut0bUze3FHXD6yf9PtPwdvBV8Rep5SRvaHF6T6i?=
 =?us-ascii?Q?ewVHv2Jst6+KoJzHWQgiWJAXGMOe/7+JIalbc6f4qrGB12fH3ASrbUY6pDGf?=
 =?us-ascii?Q?0RoXCgjdH8Ib+MFKLvKzJonOVcjTIIW6UCRnbdSNuF+26LyxM36i?=
X-OriginatorOrg: guidelinegeo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71c1248c-b6ff-4b45-592f-08de79358642
X-MS-Exchange-CrossTenant-AuthSource: GV3P280MB0065.SWEP280.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 14:59:52.7302
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f3403a73-63c2-4dc7-b628-287972076881
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y2eKDNpluZ1fBE/UJsPEODq1acfbTJWt2B6MEEex8NAKg79YyzWln6r3rG2pDyRAFBPRVgy1Y1xFQRMDYrHKoDjwGO9w2kH4JHWGHVdViYBFenpqtBXhFPPcy2WfvoPl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVZP280MB0329
X-Rspamd-Queue-Id: 442E01F218F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[guidelinegeo.com,none];
	R_DKIM_ALLOW(-0.20)[guidelinegeo.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-222897-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[christofer.jonason@guidelinegeo.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[guidelinegeo.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,guidelinegeo.com:dkim,guidelinegeo.com:email,guidelinegeo.com:mid]
X-Rspamd-Action: no action

xadc_postdisable() unconditionally sets the sequencer to continuous
mode. For dual external multiplexer configurations this is incorrect:
simultaneous sampling mode is required so that ADC-A samples through
the mux on VAUX[0-7] while ADC-B simultaneously samples through the
mux on VAUX[8-15]. In continuous mode only ADC-A is active, so
VAUX[8-15] channels return incorrect data.

Since postdisable is also called from xadc_probe() to set the initial
idle state, the wrong sequencer mode is active from the moment the
driver loads.

The preenable path already uses xadc_get_seq_mode() which returns
SIMULTANEOUS for dual mux. Fix postdisable to do the same.

Fixes: bdc8cda1d010 ("iio:adc: Add Xilinx XADC driver")
Cc: stable@vger.kernel.org
Signed-off-by: Christofer Jonason <christofer.jonason@guidelinegeo.com>
---
 drivers/iio/adc/xilinx-xadc-core.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
index e257c1b94..89d435d72 100644
--- a/drivers/iio/adc/xilinx-xadc-core.c
+++ b/drivers/iio/adc/xilinx-xadc-core.c
@@ -817,6 +817,7 @@ static int xadc_postdisable(struct iio_dev *indio_dev)
 {
 	struct xadc *xadc = iio_priv(indio_dev);
 	unsigned long scan_mask;
+	int seq_mode;
 	int ret;
 	int i;
 
@@ -824,6 +825,12 @@ static int xadc_postdisable(struct iio_dev *indio_dev)
 	for (i = 0; i < indio_dev->num_channels; i++)
 		scan_mask |= BIT(indio_dev->channels[i].scan_index);
 
+	/*
+	 * Use the correct sequencer mode for the idle state: simultaneous
+	 * mode for dual external mux configurations, continuous otherwise.
+	 */
+	seq_mode = xadc_get_seq_mode(xadc, scan_mask);
+
 	/* Enable all channels and calibration */
 	ret = xadc_write_adc_reg(xadc, XADC_REG_SEQ(0), scan_mask & 0xffff);
 	if (ret)
@@ -834,11 +841,11 @@ static int xadc_postdisable(struct iio_dev *indio_dev)
 		return ret;
 
 	ret = xadc_update_adc_reg(xadc, XADC_REG_CONF1, XADC_CONF1_SEQ_MASK,
-		XADC_CONF1_SEQ_CONTINUOUS);
+		seq_mode);
 	if (ret)
 		return ret;
 
-	return xadc_power_adc_b(xadc, XADC_CONF1_SEQ_CONTINUOUS);
+	return xadc_power_adc_b(xadc, seq_mode);
 }
 
 static int xadc_preenable(struct iio_dev *indio_dev)
-- 
2.47.3


