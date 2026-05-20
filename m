Return-Path: <stable+bounces-249799-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ELTNDiKKDWpdygUAu9opvQ
	(envelope-from <stable+bounces-249799-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 12:17:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id AEA0758B8FB
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 12:16:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 467B53065206
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 10:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 101D93D47DE;
	Wed, 20 May 2026 10:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="FEUPZOga"
X-Original-To: stable@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012019.outbound.protection.outlook.com [52.101.66.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF613D3CEE;
	Wed, 20 May 2026 10:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779271995; cv=fail; b=FvxtaWlSaz7//46EN7gWARqhKTd5iI9rt2SDOcI9xPtKVGAkCN5HWG9iJ2D7MEofvtsZ+6MeOiYgpQyK87bUrvXcwdy0hiMb55qC52bJah1EhOg8npYMFfqbyWHzlEFC1Vn1ABNKsnB7qc+CSv7sN5lHKgn10Hk2Cm26yGbdeaU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779271995; c=relaxed/simple;
	bh=kvMnWTyUwDZnPkBfngriN4lDAOMtBe9jb5PlLGiKk2o=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=AWOuwSyDvf7u2Xz/65giw0Xpvbqcul1SbAMQtr9MIJwJX6YAuUFDVBOzLbzlewtyQtOi6ttJ2t3edVKEUJ85c7zZDbp4blfqHKELyDvvs4J/dRu2BJKJIfqW30ZrObIdx61j4sLXtXOICcILVyTDnsb/cDUoewXDWYi6ASsU0kk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=FEUPZOga; arc=fail smtp.client-ip=52.101.66.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=acWBQJH/Rt/qzC98JidIPtedNv7RcHHT29V58zogqBRxGXJQBZ5Uds27tOOjTqqSw+GMGfysAXrfheVVCroscKJDiJZ4RCghqGSKMeP6gSyk+N/s36VGi83bHKIqkvA9v+xlqEHQYz6pRYWt8cHdJR1OYveOUIyhmpBcvHIZnKJAdJ+5g5IczwuZNWwRLTYIFlE3Qrdb2C7PiRR1oZaf0dru6hKJu2xwuVREWNDC+Y7jw0aiJKsO+ASVGNc8uXgxTLOtiqAxBR7jOL6/kZssHq+89oQSvml1jTS8fofbNyDAAHr2LD3UACdGJCUlVbWUMu5+G4dkwfFqwSs+UCUgCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IM5aHDmdHUaLMeolZDnNUMi1Lfky8OYfS7KhD0kGMmw=;
 b=y7uQVS/O/COCAmVZXZ3KqUL+2retTgqorqHH+ElZJA01VQF4VcyTo+Vw2vRUYGOBzBQgBavYorED1H8uA6ep79xYffl04a7Bj8cAVeAu7A66xP7XxGtY1dYHFChGa5lsWXGpgRwJnY9xWQbtc+f9bUDtSprAPwqhKxm7TdJ2FkT9SKIEDN2AC9bAhfQ1RU7zoM7atSTSJFD8FQWJFf1Zh8I+eEG4oVIbj2CUiwwhRVofV2F/+uh1ogXp9RbMXXGmmiNIGoxGflZxx56TNELWhLUUakmRjNr68wP4eQK+ZFr7f+abaQyi0Da54wWP5FLyXw8Db2+lTWYT10PAQ0dHyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IM5aHDmdHUaLMeolZDnNUMi1Lfky8OYfS7KhD0kGMmw=;
 b=FEUPZOgalJndUhvGPPQzC6Jic+bFT/+LEDdBpBOUMXvhiWI3d+j7at+prKRkWpg9AGPqGTfoo8RM8CLyfuF6XDEz2s8yhy44KPWG34QI7ftKGkYaRbX+5mcvVTBV0xZcajOcWkgfJ33SdStACgr+uh9bqU6qbuOczrNRZy72wZu5h5q3P+aw/fz5Aa7HId96ncsnhPz/aGAPlSf26CXJIoTtg1xuSF6KB+i7/tTl3rLFHbGDOK/uZkjppeJystAIFM+dU70a1GGPS82875un3GWy1pirBo+IYix/+Ek0TohZfAQKh9BriZ9Vg8GXVULVz75ekn5eU+sNS6zFMvv6ZQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM0PR04MB6802.eurprd04.prod.outlook.com (2603:10a6:208:184::17)
 by VI0PR04MB11892.eurprd04.prod.outlook.com (2603:10a6:800:305::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Wed, 20 May
 2026 10:13:05 +0000
Received: from AM0PR04MB6802.eurprd04.prod.outlook.com
 ([fe80::dc36:17b6:e5b1:fa51]) by AM0PR04MB6802.eurprd04.prod.outlook.com
 ([fe80::dc36:17b6:e5b1:fa51%4]) with mapi id 15.21.0048.013; Wed, 20 May 2026
 10:13:05 +0000
From: "Carlos Song (OSS)" <carlos.song@oss.nxp.com>
To: o.rempel@pengutronix.de,
	kernel@pengutronix.de,
	andi.shyti@kernel.org,
	Frank.Li@nxp.com,
	s.hauer@pengutronix.de,
	festevam@gmail.com,
	carlos.song@nxp.com,
	haibo.chen@nxp.com
Cc: linux-i2c@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v3] i2c: imx: mark I2C adapter when hardware is powered down
Date: Wed, 20 May 2026 18:15:04 +0800
Message-ID: <20260520101504.2885873-1-carlos.song@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P195CA0013.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:5e2::16) To AM0PR04MB6802.eurprd04.prod.outlook.com
 (2603:10a6:208:184::17)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6802:EE_|VI0PR04MB11892:EE_
X-MS-Office365-Filtering-Correlation-Id: 098f2bf4-90b2-40bf-cb8a-08deb65861e8
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|7416014|376014|19092799006|366016|18002099003|56012099003|11063799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	dB1aQSjnaQzEKj6XQ6UNTOe37U9cDa+L9UOIRJhyuA4ybEHJrzO2fP1OqZCFUPh1OO2rkyawLGoFW/hIpi3K7YKpPV0HbFpUZZsVck1nWlx3WNrQrLzF/IWeSQ8PtvdrISefL7+kZqH1fVcMuE4RDSbyUEIQassHMY+vmw/42gCt0//IMI/fZOagQfEuLf8jebT92ESSLaF1q9VDPWNagp0Us8Cjt/ggXpUZnXNUmAGY6frVYHfTz9g2MB+Kq1QsnjfqC/DynvnmTw2oA1HDWfLEEVQ/JPm+1rT0iZ1LeT0N62lvasJk0ADG153jlCKAa/f0VppbbZygM8vVKNQc8sYLi5JsMkFcFHlzi54yWV/Zq4xTsnKlx8paRSyX+h+YJ8KnP8XZADCdhxw+sdAq7kX3FhoFJ7SDQY/zSH+56fXkzau2lcdo2b6HzDODHvlct8ztdWPkxNBDsKlWCUub2FivJ+Za+9Vwh28awf6HTWEdZuujtt33SrTSMhkYW1i45nzN8hR8bzfq2w6RQIkWhYjAQrF0GMyOH/qGCKleSa/V9RQ2UyEeXqK22uB4ugZcngi+lvzzVa5oN1xOAxO5f1E3oEU3rAKrl71iFslG91b+F5dbRxFpa8hp7zHERKX1IO1jaRQ6aaRHB4oazlHXbODMyXsqyQf0hTbgcqBvzkyeCuKIzA1fhTCuTRf+CTkqZytyZ3dv2V/2ZmVRF2fE6o4lHb4VOhWNcwU5+X773IkXrwzqdvoF7Sgq35diuPSc
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6802.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(7416014)(376014)(19092799006)(366016)(18002099003)(56012099003)(11063799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wI1/SyppS9DFuTvDoiOggamCMRnWcipfBBXQHvGQbUHwlIaxAb/188rYc4Xp?=
 =?us-ascii?Q?V340zSDEIwxkEd6SQJIVVaGEVNZoZ/fYK+u8KkWRJwUIhWrTy6dIRMJ0/jAH?=
 =?us-ascii?Q?nzKHy2ScR2v+yAFCvsNfd7CZMoAKUsFOi3AGBZW+mH6W+C88YbgEzcVlPyIv?=
 =?us-ascii?Q?oJTTLjdPQ0Qxpg0PmSBtBYNB1tK38jDSBA1ocvIJ9L8//togzzH/HEY7Ykq6?=
 =?us-ascii?Q?8rXUz+hXN8B9XgpSlnhfoMpVXRNdlg4h6Vr0e+tp0vT01BkBrnpvziMs/45i?=
 =?us-ascii?Q?Zf6912ISELmoGtVn05cpAgQHwhcTQXuiIy7wKEWnHbTixSWDrXRPixKMW6dh?=
 =?us-ascii?Q?C81iqh/2Pt1nhYTA4U29EaxXrm3PiI+OFgd9yODVUCQNzdJO1SBXWJqCdykP?=
 =?us-ascii?Q?4z8GRwEFOPCh+JorRx/z2ZEzYEObuQNWPY4yWQ+7MPww5fAxhe44XEu36W5Y?=
 =?us-ascii?Q?hWYVI+1zhQn2bsiCfXai/2LJAz8n+yWNMtdOfU2ltXFiMOAQuFUvx9xlVkMw?=
 =?us-ascii?Q?gltJX9rA2PNHSvtP2lzsW1ZlQLoSJFrxMUqjnLD8bpDnxlxHlBzXwObE835o?=
 =?us-ascii?Q?VTKMYALBojMzsoAI88rXGqosANg9ONG68Rpa4VtNyZzMYOscF7zInkP502lS?=
 =?us-ascii?Q?0TpSdbFZREoFP3pPQupowjq+iyqFz41Hd7NSq4jRjk+VDniJb0mSQTrCfvSY?=
 =?us-ascii?Q?PC5eprUJAUy1jbZrBW9wu5LZFLj3E9qpi4zkxInnZAPVgRXqToIvcqpDWq2j?=
 =?us-ascii?Q?SJnkTEtCvLj7b9h90ykmydDkNxVvDfrlk++ro8DrvMoOzX7uK8YNJv8Q+918?=
 =?us-ascii?Q?kstpUrnO9uUtooclNq7fGy3jsR33Up4VpF5CfC1cfm5cvYZHcveK9MPF5Rxz?=
 =?us-ascii?Q?5MIpOv++8YalkSixeZlECLtX1vDvl4uQKHHkK6ZBIXYveYaYkHpCXcFImo5l?=
 =?us-ascii?Q?6TZs/i5GPmg1iXy/xO8JsxUFlvLufF+7xl+EsMY3FUCff/hglL2AO/gED5DF?=
 =?us-ascii?Q?vAQlPAqAhAn4x5kn0MYCGnvJ/u1AKtxMKxk1scR0mJUjJGN6pf8CvHRa2Jvb?=
 =?us-ascii?Q?bdHWffoKcfLVK+gR+uSjn9rRLrskwCSzWyTdUO54EWBET88oWzQvF11WrpMS?=
 =?us-ascii?Q?n/PGqPU73Ybz2BMlW5yXPbXBiN+p0kndrlqpsgibcXqS7TG+mLLSgjUahKJi?=
 =?us-ascii?Q?6BZoA0EhJGG0oCzphQMOdFbIhvGp0VbQx05tGa2BQAZOkqFJmo3rxaCJoO5b?=
 =?us-ascii?Q?vOF5+WL1D0B5ih9O3yKcNkEmB6tnUZmM6N3/63zigaKGClfslFFP7w6M9Q8t?=
 =?us-ascii?Q?O4vYmlD96uBe6+kZ99y/IHk04EK629bn/V86vZSEesIwhGPrtP+UQ+y0iMic?=
 =?us-ascii?Q?CspNjdVtaGcOqXpuWhtv9gPYhqqO5OOaKbeIi8uFv+Z53FfNXNZyeqa6VGN8?=
 =?us-ascii?Q?4Sxi+gPFCLKBRqcL11z8mlDIGbrVlNzEqW7isy2dhrC+QBkcjuEj8UhUUL9I?=
 =?us-ascii?Q?Hh9oS8y1G73+2Yt9DkGpzqMGKmnQNqs3jpMBUERcNpUpKQFvt6+1ZIpFOejo?=
 =?us-ascii?Q?hkEldQTEFkqZJh1namqLAV1f/rf9qQsfrq80wzeKfHvXolRLgzLHhj0Yx1sT?=
 =?us-ascii?Q?uXFRr9Gga9t/IzCyqnBWExD+KuTdEfT8hOIqpnnezVf0NE2uP88JNhW5vXjz?=
 =?us-ascii?Q?BgUdjX4+xnGJLkRBpNFeCLQBbeEsWOKxQqAkYMzy3eLcF1MA7C+ARMvK++3X?=
 =?us-ascii?Q?okw7ouZIeg=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 098f2bf4-90b2-40bf-cb8a-08deb65861e8
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6802.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 10:13:05.2953
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 93sIP7fuGtt7P0xnZvbOXdhcNVybqbEIyYKhHlo9dAfotJlPH4LrTFQa7OHiwfafi2VWoQzd8kMPt7MwjOlvZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11892
X-Spamd-Result: default: False [1.94 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-249799-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[pengutronix.de,kernel.org,nxp.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[13];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[carlos.song@oss.nxp.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,oss.nxp.com:mid,NXP1.onmicrosoft.com:dkim]
X-Rspamd-Queue-Id: AEA0758B8FB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Carlos Song <carlos.song@nxp.com>

Mark the I2C adapter as suspended during system suspend to block further
transfers, and resume it on system resume. This prevents potential hangs
when the hardware is powered down but clients still attempt I2C transfers.

Fixes: 358025ac091e ("i2c: imx: make controller available until system suspend_noirq() and from resume_noirq()")
Cc: stable@vger.kernel.org
Signed-off-by: Carlos Song <carlos.song@nxp.com>
---
Change for v3:
  - Add hrtimer_cancel in i2c_imx_suspend_noirq to cancel slave_timer for
    safe suspend in i2c slave mode.
Change for v2:
  - Call i2c_mark_adapter_suspended() before pm_runtime_force_suspend()
    to prevent potential deadlock if a transfer is active during suspend.
  - Roll back with i2c_mark_adapter_resumed() if pm_runtime_force_suspend()
    fails.
---
 drivers/i2c/busses/i2c-imx.c | 41 ++++++++++++++++++++++++++++++++++--
 1 file changed, 39 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
index a208fefd3c3b..d651ade86267 100644
--- a/drivers/i2c/busses/i2c-imx.c
+++ b/drivers/i2c/busses/i2c-imx.c
@@ -1913,6 +1913,43 @@ static int i2c_imx_runtime_resume(struct device *dev)
 	return ret;
 }
 
+static int __maybe_unused i2c_imx_suspend_noirq(struct device *dev)
+{
+	struct imx_i2c_struct *i2c_imx = dev_get_drvdata(dev);
+	int ret;
+
+	i2c_mark_adapter_suspended(&i2c_imx->adapter);
+
+	/*
+	 * Cancel the slave timer before powering down to prevent
+	 * i2c_imx_slave_timeout() from accessing hardware registers
+	 * while the clock is disabled.
+	 */
+	hrtimer_cancel(&i2c_imx->slave_timer);
+
+	ret = pm_runtime_force_suspend(dev);
+	if (ret) {
+		i2c_mark_adapter_resumed(&i2c_imx->adapter);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int __maybe_unused i2c_imx_resume_noirq(struct device *dev)
+{
+	struct imx_i2c_struct *i2c_imx = dev_get_drvdata(dev);
+	int ret;
+
+	ret = pm_runtime_force_resume(dev);
+	if (ret)
+		return ret;
+
+	i2c_mark_adapter_resumed(&i2c_imx->adapter);
+
+	return 0;
+}
+
 static int i2c_imx_suspend(struct device *dev)
 {
 	/*
@@ -1946,8 +1983,8 @@ static int i2c_imx_resume(struct device *dev)
 }
 
 static const struct dev_pm_ops i2c_imx_pm_ops = {
-	NOIRQ_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
-				  pm_runtime_force_resume)
+	NOIRQ_SYSTEM_SLEEP_PM_OPS(i2c_imx_suspend_noirq,
+				  i2c_imx_resume_noirq)
 	SYSTEM_SLEEP_PM_OPS(i2c_imx_suspend, i2c_imx_resume)
 	RUNTIME_PM_OPS(i2c_imx_runtime_suspend, i2c_imx_runtime_resume, NULL)
 };
-- 
2.43.0


