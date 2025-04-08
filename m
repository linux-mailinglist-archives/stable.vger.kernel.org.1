Return-Path: <stable+bounces-129027-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2C58A7FDAA
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 13:05:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9790119E27DB
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 11:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F20C3268683;
	Tue,  8 Apr 2025 10:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="btjQRINn"
X-Original-To: stable@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2057.outbound.protection.outlook.com [40.107.105.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69DE1268C42
	for <stable@vger.kernel.org>; Tue,  8 Apr 2025 10:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744109920; cv=fail; b=jSYeIQpYoPrGwDH4hhuv1xwghX1XPSlwLX+T1WXFZPAgP/83sHbojW0uDzguSIJ3cR4KOEuFHjgz+Kv59YicwdkcUdYvhAo6B1GiGp0M5yuN5OkKNlvt4/48U0MGg0Fk/Dd/JrPzw7cW/HyfrZ3Z9/aBF6w5oeKmEMkSutXifXE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744109920; c=relaxed/simple;
	bh=N2RpxOkYsABOzLQYJ7puCEldHj+tw/ahPFYjbJ8Q75o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sHX0Nx9H+si9CGRohEgVnGIh18bkodjLE+EA/nPeM0vvJp4H9slp9eFPUgW+1ku+TyypTWYKOXZw0RB75je55ldTZqGGQ0CvG37zpSwcQhr5TRYgZch0awji2IuMfZGnuMbiHLxh3jT5aGRUoFqMR9UXkcYTHN8f9pEqtKyAHWE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=btjQRINn; arc=fail smtp.client-ip=40.107.105.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rUR3sjFpctJRbks/s2Za7qinru4v5Irr+l8Y9C/+ikf9BCIjvqPkxymqyumaLOGDHIRj1j0TBOnpqhGgfW77HKgX822TiI5MiM+CwQD8k1n4z8FC6mj+KptVUkU8F3r/iyyoZpBIc2l87JMMIDOfa/HdtFBNx4C4i57gSqlo+aqJEk7nZDDAkZYTIAdVWufHfeY60swNA902qjYWQ9xj5pYVdo+YgKcMNPuv55Q6wWIhLEOt9Ig7gH7+lEAZo/z+L7Bdh7uTswl8jO8onSr73dIHfQoLKYvfh1e0qknWPLfd+4Snmj96kpX3XoMhsP1uIxVNJKVC76Kq4G9VdBBygw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1je5Ay8Aivv6UdL/qiJ1h2zxoE6KsYnrqzyMUts7qWE=;
 b=MIe+OqkF+Q43XBvG4LCJ2GyHVHwZDur6v8/J/dNegK8wM96LElSvM4aVJ3vN8kzjMdLP+40v7qKV9MFfsma0zVNDHYHASXbyMlK75En2yQCOfvWB8PE25irZA+mr7kYU/STCCn6tRLJvfAIhH0IWI24kIMKijh02/xL75LSx0M0VlNlSa/q+1e4YMYH23PppYEWXyasQ4DXS66fpaGAGExMjD1B6yno/pkcqFEwn/ZrA8fHTN5/SACaIE14pT+x9fpCuv5j+lY02bkzzRcavsX5KRmCAPTv/OCh/ZMcgl5dageesTcnJuin5bPbMMfavDJEiFKJGtKZHiLq+QCUQTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1je5Ay8Aivv6UdL/qiJ1h2zxoE6KsYnrqzyMUts7qWE=;
 b=btjQRINnbH0ryTa6XxkFyF+EWzG2LoP5XcsWdRsnqknrlUpUvzdy3LZv1n8fwxBDi4ILA+iwCd1wbS/ShR8SEY3cY/ENjy9SNyh06K2bO6wNgBpmtbhR3vi72zBJOCf1CJ+LqAJyZXrwO+i1OgzEx2Tav1PuWmJ6BWN01b5S6WkEQhYMHNApGWJdNhw1PSLwzp0X3aKJ/vBFPRO3Dhf7RXQrOwTfakN6ojPY1nONWhoswN2bGwPCUEfBjufI+ItK797tnIvAiAv3xclLePK7gVeRo7eKsHaaHLJYBwIAWp1RfyERfBVnP6thyeowMPqLf2UfkofTWIrTmzuPxQPHLQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8868.eurprd04.prod.outlook.com (2603:10a6:20b:42f::6)
 by AS8PR04MB9176.eurprd04.prod.outlook.com (2603:10a6:20b:44b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.33; Tue, 8 Apr
 2025 10:58:36 +0000
Received: from AS8PR04MB8868.eurprd04.prod.outlook.com
 ([fe80::b317:9c26:147f:c06e]) by AS8PR04MB8868.eurprd04.prod.outlook.com
 ([fe80::b317:9c26:147f:c06e%5]) with mapi id 15.20.8606.029; Tue, 8 Apr 2025
 10:58:36 +0000
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	christophe.leroy@csgroup.eu,
	stable@vger.kernel.org
Subject: [PATCH 2/6] bus: fsl-mc: do not add a device-link for the UAPI used DPMCP device
Date: Tue,  8 Apr 2025 13:58:10 +0300
Message-Id: <20250408105814.2837951-3-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250408105814.2837951-1-ioana.ciornei@nxp.com>
References: <20250408105814.2837951-1-ioana.ciornei@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P250CA0011.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:5df::13) To AS8PR04MB8868.eurprd04.prod.outlook.com
 (2603:10a6:20b:42f::6)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8868:EE_|AS8PR04MB9176:EE_
X-MS-Office365-Filtering-Correlation-Id: b08f5f1f-79dc-418d-775d-08dd768c4f94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bz0oBNpLjzApSeoJzLRN2zCM/fm7XA6PU0owCNbl+pkLEVsPtNVnbBSYGYR0?=
 =?us-ascii?Q?F4Xy1SdtRpFTJ0prr12OY9Ss85Rhq35A8xRUdi3tSroDesZ55qxcfirlF1Ok?=
 =?us-ascii?Q?MKv29RaOtV9YQU5fXr5J5RFAWjcAOwIIwyCr/RKrM9mIlIaIYNHShL3cV5Vk?=
 =?us-ascii?Q?0LplUsL+eNt5CJkaV9788wBCEfXAIqDwVWero+g8lMzo9/f/29GPgeh45kgN?=
 =?us-ascii?Q?smh1FIf8xFL2zcRtC9BaKJz5GcJ4R+itWK5uCtuXBSeJQG0DpLDdp9SpiKp2?=
 =?us-ascii?Q?K0LubE0gXIVdjx4IwaV+tv1CY8y25t+1A38+4lmxcSOjfIxnbbVcMjbH9lmr?=
 =?us-ascii?Q?GTGLwWEDYQg90tog1aZ99Lc8UlUnSRBQ7/yooKvqT8GflEU5DMQpSP8D/RBJ?=
 =?us-ascii?Q?VdmjPH9JCTrBEnhTtjfIil57bTV9TT1R5Gs/7TJcEhMECagPGcK6/jAOjniJ?=
 =?us-ascii?Q?Z46XzA3MX2IVPR6p2x7AHI324sOT8agTvDS+5Ld6g8iclfL22yH6bIi0zdgF?=
 =?us-ascii?Q?/D0LVC7xqSOPQ+TMfcAhv6LZJNn4JgnyRB6au0o53hYIAIptvDOg0iNpfbC7?=
 =?us-ascii?Q?mmppNTGx2UjVBu4o2/QWal84NYjlD1WSpc6njL867Onc+pT7XC5gHl5qCVc8?=
 =?us-ascii?Q?MQ/TZsTvO/3dnwA4OyMofT9w3Bx2Tgx0JW/JHDQuULPVkXOPCeogys1cXIwg?=
 =?us-ascii?Q?+E2X0+ptutGfJgt3jyx8NBy5t2pozfVz2b4do2fTQJU8FhK1sqHrLVcjiL6q?=
 =?us-ascii?Q?11wYTSiy7ms5J67jZxf3kHlO2/Gkabu4ueRSEpf+dCeOPbV57B1Vr2V5lgWV?=
 =?us-ascii?Q?PMiMmwkipfmzk9xpCmFrnJYoI+4zfBHMDnghc2NwN6/WRT0byWxgyUWF9sMl?=
 =?us-ascii?Q?2rYypfqcMy5y1WCibWmQZ9x5EAiD0frv3xYCfhTa+/FnXidMgVH76LQjM3le?=
 =?us-ascii?Q?i/C7KsCZMKyNoxcZujlrYT7deYFW88KrH8CwbW9KhUhijpBOHDLXBbBp/EHN?=
 =?us-ascii?Q?NQ4kqYKxuCWpe0rvRc2i25CA9AEX70bqaryltjFJeNePPwL57l4YzIPDhIfU?=
 =?us-ascii?Q?czXHyoX+lYFGiNIuYj27wYh82Iwo4xmI8DtFllwcHq5WlNwHoi24BDHLerrW?=
 =?us-ascii?Q?Sr7yT5/W5g3ChGi7rm88Zd1SgDZBWvQNcgF34D3rsySwqi7Di1jEzScaA1G/?=
 =?us-ascii?Q?7CNTF0RZoPzEb4MlEzPG4tcbQtLFVUyibDSwcTZPP/fwD+Ubuh8riOiA3Qxw?=
 =?us-ascii?Q?FuN0K+sb5Vf/gzTKodP4Xw7uzPZ42wNo3kSUUP9ffupGa1HoMAVUI9oNoNLq?=
 =?us-ascii?Q?0o4qI21OneWsHz7QvZI3MGD1rkRuIZu4a6gu+3im1WetjsKNknFDZvxLMYBs?=
 =?us-ascii?Q?z0Iz4Xm0fQUbvlyohPTzR/zT5vnl?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8868.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XRDQpcRINPMGKU44T7kyLziFJ+m88+fITYrY1UMh+dU25eRVhxOVOlIipNWT?=
 =?us-ascii?Q?uJJ5i5g3kS0a1BwmZ0G8fWJ9KykXI58QjHkYqspytwPPzfzdtoyPq6bqKayH?=
 =?us-ascii?Q?XUX0js1cvKh4wr/S8ruqKK/q6qjLc3ztGqqIvy5AoPm8ZmUIlkG3f2NVM4+t?=
 =?us-ascii?Q?ZjRV0OHOrjNd+aJ4gRMiQ7/04+QAexdaBHLSLkAff/l7sy764lGw4uhsXCKD?=
 =?us-ascii?Q?yRMOW9RvXEUmr6m1hqAZ6W/lZxxulxj1OPiOvGAJNkQvZEiHmfvG+Tv125zn?=
 =?us-ascii?Q?iOJ1D682Yhloodz58g3+u7RambPHh66+4ZjpZJJCFxeXYjdx84jCGUWWG14Q?=
 =?us-ascii?Q?ArTKtzaDe/J2neT/VijGBAfOgtHj3trLWXi6fIdnVunZ75DsNGnA+I0VuWP6?=
 =?us-ascii?Q?H9DKHBqJKdIieMWdkKotcGRO2qULgyShX542hQupt9GTs+USWvq8zEKOjSXh?=
 =?us-ascii?Q?AFsq3ZWB0G9o7ctTuY2yoUAPG/r5xI1IA/K2dfuXvhbtqeKs+ot89+klMca1?=
 =?us-ascii?Q?3eJOKeHuEl4wHJQOsG6dOubr3lj1jGnFB5fG9r9KM7Rv7tpBKFB/+mQYll7c?=
 =?us-ascii?Q?GcQXkOQzq/P0mseTXwcjULcYCdymMyOeMsoft+kMuFAjzrwDwHEumSu8ep/L?=
 =?us-ascii?Q?0h7bqGBn608v4lVOAKSOmez2ws4q7mjQZEqlC0XNH4M6x05/RcTaAaYL4ehI?=
 =?us-ascii?Q?/4WtpskCvEcOiDpHN6DcTqmA/x8P/EWf72Vbc1aNrdEGo+pg8vBcy2guZ/KQ?=
 =?us-ascii?Q?iOD0LUYQpyPiptMTUs+5h7GxXBME5LZh/pPv3HCI+yWbKNBxnjzq3Fqg3qI8?=
 =?us-ascii?Q?bYI/D7Mo1GxL1m6dSdljLtUL+3PhCKvaHSDbqra2CXH6427laTG7otJCygvY?=
 =?us-ascii?Q?K59z4+Re2UThJUaWxYFw1sdja+EjPZWWFSMMLFqPwbAYSx0fvqeaZnxRioA4?=
 =?us-ascii?Q?h2LHEkqPPLlwgZcWX6DQskz6TB+B0To9ApeGC8tJfxnL2ZilbyN3sTcIVC1S?=
 =?us-ascii?Q?StzyazejFhscwVetL4bskXGjoAe/MbGsGC1yhIsHAUafYcT4fFIe7kAeupXJ?=
 =?us-ascii?Q?0Ua9aY3vfvoGoW5LidbRJGEMz6msnfVfdz9hFAU0KHE+Ri/oE/BhPYYWkLEG?=
 =?us-ascii?Q?IP1KpV+lCCKSSjgZr/Etcke+R+P1i/PWl4a1d1prryx2PvLXcCbTYSsDZ9TW?=
 =?us-ascii?Q?0cs0riJEo1x0XwTKwjjuONTW2Y/Pa2++fFrrViTXUI4KEx1BtEWf/SzjHjsz?=
 =?us-ascii?Q?UZ4tZGygChh1ZG6GyKIFTjcvdfeuoHYtYOJna+rh7rJaeI8kmz7r5e6xeDCk?=
 =?us-ascii?Q?t4M/9o5hcG930v9TdEDzPMEyGKdyEN68qDumt5kqut64O9XEQRWLnNC2S4ui?=
 =?us-ascii?Q?FCWGNRyX3eMiqz3URRsl8nhIFXOv9Zmt6RXTjjBtfV/Wr6fKLLDiZG9cy/KR?=
 =?us-ascii?Q?CLzDHb8cRlONwwYR4MsEE03Cdx5JXw5mqp3PQefx43Wf9S9gk6exM6AfNmut?=
 =?us-ascii?Q?G2o311XNnxGyhQqfVKVoqNhf5yyNqxGO7E7KeFtAvPOGrRfmQH3f1nKh2Fhh?=
 =?us-ascii?Q?9SQgRFAaOzqJvf6a+WKXZ65WGVZ/F+q/VUvvhUPh?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b08f5f1f-79dc-418d-775d-08dd768c4f94
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8868.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2025 10:58:36.0247
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IRKf+iu/jQ/LDDfOEfinXQUx0IGUt08If8zdk/00lWbBO6kH7HJXhpikCOO/Hr4A2evV0zDxsqHNRmtnVcBw7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9176

The fsl-mc bus associated to the root DPRC in a DPAA2 system exports a
device file for userspace access to the MC firmware. In case the DPRC's
local MC portal (DPMCP) is currently in use, a new DPMCP device is
allocated through the fsl_mc_portal_allocate() function.

In this case, the call to fsl_mc_portal_allocate() will fail with -EINVAL
when trying to add a device link between the root DPRC (consumer) and
the newly allocated DPMCP device (supplier). This is because the DPMCP
is a dependent of the DPRC device (the bus).

Fix this by not adding a device link in case the DPMCP is allocated for
the root DPRC's usage.

Fixes: afb77422819f ("bus: fsl-mc: automatically add a device_link on fsl_mc_[portal,object]_allocate")
Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
Cc: stable@vger.kernel.org
---
 drivers/bus/fsl-mc/mc-io.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/bus/fsl-mc/mc-io.c b/drivers/bus/fsl-mc/mc-io.c
index a0ad7866cbfc..cd8754763f40 100644
--- a/drivers/bus/fsl-mc/mc-io.c
+++ b/drivers/bus/fsl-mc/mc-io.c
@@ -214,12 +214,19 @@ int __must_check fsl_mc_portal_allocate(struct fsl_mc_device *mc_dev,
 	if (error < 0)
 		goto error_cleanup_resource;
 
-	dpmcp_dev->consumer_link = device_link_add(&mc_dev->dev,
-						   &dpmcp_dev->dev,
-						   DL_FLAG_AUTOREMOVE_CONSUMER);
-	if (!dpmcp_dev->consumer_link) {
-		error = -EINVAL;
-		goto error_cleanup_mc_io;
+	/* If the DPRC device itself tries to allocate a portal (usually for
+	 * UAPI interaction), don't add a device link between them since the
+	 * DPMCP device is an actual child device of the DPRC and a reverse
+	 * dependency is not allowed.
+	 */
+	if (mc_dev != mc_bus_dev) {
+		dpmcp_dev->consumer_link = device_link_add(&mc_dev->dev,
+							   &dpmcp_dev->dev,
+							   DL_FLAG_AUTOREMOVE_CONSUMER);
+		if (!dpmcp_dev->consumer_link) {
+			error = -EINVAL;
+			goto error_cleanup_mc_io;
+		}
 	}
 
 	*new_mc_io = mc_io;
-- 
2.34.1


