Return-Path: <stable+bounces-238264-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sI97KweP4Gl6jwAAu9opvQ
	(envelope-from <stable+bounces-238264-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 09:25:59 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FA1940B022
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 09:25:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3EF96312A01C
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 07:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFC203822A5;
	Thu, 16 Apr 2026 07:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="WL4rRjrG"
X-Original-To: stable@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011071.outbound.protection.outlook.com [40.93.194.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD18F37E2E7;
	Thu, 16 Apr 2026 07:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776324135; cv=fail; b=nE/QljwwaSxXfS1pjk9bpQ63f8E5V6bKFl+HgQk0nPhnImZxlX39tDte/jZ46obJlkhyyiSe8MvhX5Pd0H77dBFaP6XkEFa0cWFzZUcAK3FQ5BVby14Ihs0YZm3zHjziOMYYvcqayUCa+oXo3cUB3EL8jWGj61XJ83maItQJVhk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776324135; c=relaxed/simple;
	bh=pkNeg2elSOzrkiK7egsavmH3sCXesC1uliM896U4gKs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IsvjUfHbXBpa/HvAJmoQv9Hs7/lt2uTyU7EmeuHt3Fn9TkMQgychZZBgD9RMtboytf1WQ6zt1RBIU5vJdiA9J2gVZjYIdiPFvqhgx0xtCgmwc4DhZRcAp8bQTB4SGahDVZsYDWLg6gOj1O75SwxzcuTuI2acr9RXAgQNSkmj3GI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=WL4rRjrG; arc=fail smtp.client-ip=40.93.194.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YaKvEoXoj0lJYGp8iE1/vxlXr2eGba+oKcCR6MX+j9sBPqxvBteeTgWidGdd2bz2G6MX+2Vo0FtjC0ksXbbMtChdVtHNAdnmOUc6fMZCCw/nktQTJAqy6zIX4KSgRiBwTgZW5CA5ZcHQJF0HalFX2S4vAn4Kdn7hoAip0KwpMn/cJGa3GrX35JW6FuTlTLGDLDPkjm65yw1hd/jkfZ6//Lf1vUQlcG9ZsNnxlH6d8eGYzltHV2QKjxERQzwTxBiHscJQP+VogX2LpOT3m3vOmgPwFCIMtiOlDDH66prHvkp4Y/i6BsMwFLUKLw4rf/9TEd91s2WoCJyhJ6qagaw99Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NF6agQjYaAKkWyO0ZWyQTvCgMSS5thyqle4j+DPYXbI=;
 b=KUrKLgWrg4lmRb95jNSW+/QrVx5LrUCjRGpk6kpvD37CTLfkVnCUG+yiI1saFy1Df4g8TIk3t16p9mTB9U0N1MCs/vunyoXYMbbPKShoRwxzK+sgeDSsJKtJ85jQ9dDvA+pFNKmP6bmD3EJxDvxTO5afUlPNgBGX+Fv9VIBCVanv2EaZtAvuT01I16miUOEVH6tQyoPj2/z8K2PHFMEwFA2TEtBcMvq3SdItq4sNqPetwa4Sl2XLOoGqtV2Fmfz9wVoMbKA21X5VqBGMW3TSup+GJHa1E1fD9jAJbZidMwop7OemPGE2qDx4sStELadEtb02ibiip/J158KG/36xkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NF6agQjYaAKkWyO0ZWyQTvCgMSS5thyqle4j+DPYXbI=;
 b=WL4rRjrGE25b+pJ10K2yr3NiuZj661APYw53cmc6nMXnl+yA1Eo72k5m+f3fIOwcGyrMSS6PbeDz8Kbo8+ExcCwDt5Jt7erao+967MDQWAlsTDg2aX/crsTxAX9HDsRHqepoBY6RQR+bqAULwwsqYxzxUhfyqECKCmC59MsTOORXYStCZFEc6jSSFUN+Q9/D3NuNptJBTBizANUyxQqvGyBvY9lMWnZKvoKTzTpra2SpqkC6o9NRSOVgmDLVorhOSlm2d0P0se5JFUISMYf0ySADGnUlpxM5KwdDnMwbb6ferJnZndG3mBYhHqNGwScsPb0ssuah3caJwC8zwIvvTw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BLAPR03MB5458.namprd03.prod.outlook.com (2603:10b6:208:29d::17)
 by MW4PR03MB7011.namprd03.prod.outlook.com (2603:10b6:303:1a6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Thu, 16 Apr
 2026 07:22:11 +0000
Received: from BLAPR03MB5458.namprd03.prod.outlook.com
 ([fe80::7eda:fa34:15f9:e656]) by BLAPR03MB5458.namprd03.prod.outlook.com
 ([fe80::7eda:fa34:15f9:e656%6]) with mapi id 15.20.9769.046; Thu, 16 Apr 2026
 07:22:11 +0000
From: Muhammad Amirul Asyraf Mohamad Jamian <muhammad.amirul.asyraf.mohamad.jamian@altera.com>
To: Dinh Nguyen <dinguyen@kernel.org>
Cc: Mahesh Rao <mahesh.rao@altera.com>,
	Matthew Gerlach <matthew.gerlach@altera.com>,
	Anders Hedlund <anders.hedlund@windriver.com>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 1/2] firmware: stratix10-svc: Return -EOPNOTSUPP when ATF async unsupported
Date: Thu, 16 Apr 2026 00:22:06 -0700
Message-Id: <20260416072207.27074-2-muhammad.amirul.asyraf.mohamad.jamian@altera.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20260416072207.27074-1-muhammad.amirul.asyraf.mohamad.jamian@altera.com>
References: <20260416072207.27074-1-muhammad.amirul.asyraf.mohamad.jamian@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0181.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::6) To BLAPR03MB5458.namprd03.prod.outlook.com
 (2603:10b6:208:29d::17)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR03MB5458:EE_|MW4PR03MB7011:EE_
X-MS-Office365-Filtering-Correlation-Id: cbcef418-2afe-4c5a-25a8-08de9b88e03d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|22082099003|18002099003|56012099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	HjPUleMGEBRpaPFkQlNhxCkmuSfxk6EBAtF2F6cWkbePKBjwcFTFIsTrls4oR2Rai/4hAqpSEZ6B6+9xA9CqKBb/IOiwPkFNmqiq611yKm4Wggyc/lkcKjbtWdYNLUuQ96uUounegovHGiKdJgjnEF4idpW35hOFj/gUaqQOeL7Jon8MFi4vgrueBdlIUzZ17hooJR6aomwKf5wUCQjNq6kQ5BGzP7tYJuroPOmiuSdVpeifLPQyfl8xl2JaQvcCdVNYJ/e+S6A/NkqRKbAvlamqAH68w5xPa1tJKWoQgT3LfOo/urmQBANjKJu6qMfgknCuKde83oK2n8D3wVrN9zWsC2xsyJlhKqDFWPTr9QGsqm+iLq1QMbSTvoWfAAqCEEf3HFzDpbDOvnNjJD4wBiWuK5HN268tTP8OwUddthsI9vqKrNUJ/Tfkmys/kItQnZiiRtPKSB7wtl4Nx3Z6LgMDxBJvz7FaEAonSXSKXDz1y8tK2kQ0StgfksZFZm6/ZhOwQ9EkOVThAXX8sREXsOlgaiKOPH98mZEbI7+25C81LiytAVpz4d8ryXgVTmdHdRkAYUWZl6JB7YlDgfUW0+CGbRtZp86EHJvfWGzBQnmJudIIatFqdZoU/uj0RF5qzvbrnrPpsDcZKeRaJD8BCt/T2CtEEPHEQ6s2nzumPDkAMz/mXR7HkIlg2wkXovJei81Zn1mMkpP9JWyFqvvSyfEIxUMzg/t9jsVMzdtdsFE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR03MB5458.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(22082099003)(18002099003)(56012099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wKYiosGDwjk3O0/+tdFOeatqOZe9zhSVAQzXTQcuF1B861innU/8g/hv2z0z?=
 =?us-ascii?Q?jz95HcvRtiNyAUeMmxiMUZ7wPfK1EsBuch8l0Y6iMGZ2J6boMtRsWLaW63RM?=
 =?us-ascii?Q?6iCL/dotFifM3MDpavgtpjHgfdw7ZgOcrFefZOgngnV7aTQOENKzTDZqcV4Q?=
 =?us-ascii?Q?Y/zBMIpjhknSTpfCLBgGesTQ7JUCWvS2Rh2Ii3Z+DOLmlf6M9e3D6Es5c503?=
 =?us-ascii?Q?ln+Iodv4Vez9sIFIemnIJhMCC4NgzjHQL4S+EVgxumAWXuOOYSJIzFDWHsCF?=
 =?us-ascii?Q?gP7WJMYFoEaeImRqhNviY0e44E12hH24rV96dq+O/Ten5DZ92M8a+VkAmi2x?=
 =?us-ascii?Q?USF5lOquv1OMQ3Df4MkhqcRNllZk9RpU5kTQJDZXZVv8L2Pz4VKhpxodNFhi?=
 =?us-ascii?Q?r9vUJGpfw28N7IUunEKH48p7h7lKlk8zKTjUDnHkkvA+6ZeMxD8NanqYFCae?=
 =?us-ascii?Q?MwFyn82XD321vbpHj1x7Ma828wPKtLLUdUfXwNWIX+yJzZgZk1TiagCQVKPR?=
 =?us-ascii?Q?+2JE9m/pAD0CtWr2zwRemEFKoeDnJ7ewKAyYqW7U/ER+KwAYeqXbqLizrlyG?=
 =?us-ascii?Q?8lk+4feN5hLviXsakkYAMwssiCKmDhNGVFG/W82ypaq6IZ3cmIpjiJ5SEykp?=
 =?us-ascii?Q?iZHGHlxsZ+ImnHcnbj4fay1Yx+W7kElZV/W8B6SekkMW/Yw968euF+qquFSE?=
 =?us-ascii?Q?CsOKIDXZEiCp2ChcnUA8DeotghosuCE9vH5OZI0Mxib5NFUKHe7Es3UqxRbo?=
 =?us-ascii?Q?nAlJ3OlhtSNDddtLwEpg4bBpliWRVITCTDMrz/A+U6Einf6ndTmsRcoy99I7?=
 =?us-ascii?Q?8MbsK9poqZjX7/Zl27z2/whXwBychwERAWt74rTKHrBXaG9E0U9H/zXhFHDq?=
 =?us-ascii?Q?Znyz1FHLrs341soW2yoUA+LJRHVsLC+w+8v8Grim7QLwcUporMrCcAWrNua0?=
 =?us-ascii?Q?nn1QvIJFO0C4ON7NzlM6tLBPxzeOw3Ox8Su6uhZuzFBZ4kSiZJIcfTVw4/ya?=
 =?us-ascii?Q?rstIqQS/Zs6SwFJUyVi90qPxi/wPRyjK/D/yylSWGD4r5KlvP2IOQ1Q9mBT3?=
 =?us-ascii?Q?sa0E0X1kMdtR0lg6Lx78BOH3GAe5W1eJ1QtCwCK5fYuaOmgeG6DcKvaXS7Pp?=
 =?us-ascii?Q?iXIdzYICeglKoAEA6QoC7maloJJ5Dx63Veo+kJwbRgyTGv8jIJWeihFgnZl/?=
 =?us-ascii?Q?dLFjok6a8SbbKpyTtgwe+C8Adn+g6MSNklTCqW5U12gPYQHKJaNrbGbBPVue?=
 =?us-ascii?Q?hkGnbc3ocUklKeNT/0AG5f3oKZzo6T42ZHlh2+gZcFxw2XS0roAY5YnUlUw/?=
 =?us-ascii?Q?L9sWKmHShVUTz8K97I08gzDhYZQR5PGu+1w+YTypwm6qrn3XJmrjGjkGN1BR?=
 =?us-ascii?Q?aKWubhtyhy2KyV6mEIFJSP3Bx347NK5dlR3M5Q1UmS45IsWDLSPiE1l3NAjL?=
 =?us-ascii?Q?yEDjK+3VGSDHw6nMcTOxB/uIPPdy9Kn9z2+g8mqUCs3EtHnvqKLEQAmlnrO1?=
 =?us-ascii?Q?D7JB7whUuCz7L7SFWOmvDa/+8kfPYrO0pb315542wWw4a2T7PMooGAg4jWz5?=
 =?us-ascii?Q?lEG7b+b2pJtas/g6FK1WO6t4li+ZG6G1nz26kF3EixRsMkIALCIYg2KF1y4D?=
 =?us-ascii?Q?39iITe81BsdupFEIT6nUENlEhIQ84vmSCczxmhKbdVlnxIrU+k/xoLfIWGcH?=
 =?us-ascii?Q?2adbDOIX/rgo1D2Ek/d2ne9KiaWjkP6Q4jCktMOWNjiIfHkuwfgcIrrPgktW?=
 =?us-ascii?Q?46s7UWwXEIt+D0qKritAN7EgSn7U9Z0TwDqlt9u0IiV4xvZQWkIZ+nZX8wOT?=
X-MS-Exchange-AntiSpam-MessageData-1: B5PhEnUuV2sM4VC85qSbcFyjHoHhEAtqrnA=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbcef418-2afe-4c5a-25a8-08de9b88e03d
X-MS-Exchange-CrossTenant-AuthSource: BLAPR03MB5458.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2026 07:22:11.4543
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oNohv0h2+sQdkRc8AB5rBO9OnQBJ+FXpBM9k+KdryObX5Nqo6u2WQRh7Mc1mbA/5mk7n75H9VS7rt6Q60SsHVi4qe0MP+hUWmBL5Uz3YhzUcI8MzJ/D26NhJ4BTn18mg5MY3v/0kbalndG27gjMgWDYqj6IAD+CT0TUrPa92vFE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR03MB7011
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[altera.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[altera.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-238264-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN_FAIL(0.00)[1.2.3.5.c.f.2.1.0.0.0.0.0.0.0.0.b.d.0.0.1.0.0.e.a.0.c.3.0.0.6.2.asn6.rspamd.com:server fail];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[altera.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[muhammad.amirul.asyraf.mohamad.jamian@altera.com,stable@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,altera.com:email,altera.com:dkim,altera.com:mid,windriver.com:email]
X-Rspamd-Queue-Id: 4FA1940B022
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add a 'supported' flag to struct stratix10_async_ctrl to indicate
whether the secure firmware supports SIP SVC v3 asynchronous
communication. When the ATF version check in stratix10_svc_async_init()
fails, set supported=false and return -EOPNOTSUPP instead of -EINVAL.

This allows callers to distinguish between "async not supported by this
ATF version" (-EOPNOTSUPP) and "programming error / bad argument"
(-EINVAL), and take appropriate action (e.g. fall back to synchronous
V1 SMC path) rather than treating both as fatal.

Also update stratix10_svc_add_async_client() to return -EOPNOTSUPP
immediately when async is not supported, rather than -EINVAL from the
!actrl->initialized check, so client drivers receive a consistent and
meaningful error code.

This patch is a prerequisite for the following fix and must be applied
together with it to correctly restore functionality on old ATF versions.

Fixes: bcb9f4f07061 ("firmware: stratix10-svc: Add support for async communication")
Cc: stable@vger.kernel.org
Suggested-by: Anders Hedlund <anders.hedlund@windriver.com>
Signed-off-by: Mahesh Rao <mahesh.rao@altera.com>
Signed-off-by: Muhammad Amirul Asyraf Mohamad Jamian <muhammad.amirul.asyraf.mohamad.jamian@altera.com>
---
 drivers/firmware/stratix10-svc.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/stratix10-svc.c b/drivers/firmware/stratix10-svc.c
index 5a76cf3fc83a..739642923ac6 100644
--- a/drivers/firmware/stratix10-svc.c
+++ b/drivers/firmware/stratix10-svc.c
@@ -212,6 +212,7 @@ struct stratix10_async_chan {
 /**
  * struct stratix10_async_ctrl - Control structure for Stratix10
  *                               asynchronous operations
+ * @supported: Flag indicating whether the system supports async operations
  * @initialized: Flag indicating whether the control structure has
  *               been initialized
  * @invoke_fn: Function pointer for invoking Stratix10 service calls
@@ -228,6 +229,7 @@ struct stratix10_async_chan {
  */
 
 struct stratix10_async_ctrl {
+	bool supported;
 	bool initialized;
 	void (*invoke_fn)(struct stratix10_async_ctrl *actrl,
 			  const struct arm_smccc_1_2_regs *args,
@@ -1103,6 +1105,7 @@ EXPORT_SYMBOL_GPL(stratix10_svc_request_channel_byname);
  * Return: 0 on success, or a negative error code on failure:
  *         -EINVAL if the channel is NULL or the async controller is
  *         not initialized.
+ *         -EOPNOTSUPP if async operations are not supported.
  *         -EALREADY if the async channel is already allocated.
  *         -ENOMEM if memory allocation fails.
  *         Other negative values if ID allocation fails.
@@ -1121,6 +1124,9 @@ int stratix10_svc_add_async_client(struct stratix10_svc_chan *chan,
 	ctrl = chan->ctrl;
 	actrl = &ctrl->actrl;
 
+	if (!actrl->supported)
+		return -EOPNOTSUPP;
+
 	if (!actrl->initialized) {
 		dev_err(ctrl->dev, "Async controller not initialized\n");
 		return -EINVAL;
@@ -1562,6 +1568,7 @@ static inline void stratix10_smc_1_2(struct stratix10_async_ctrl *actrl,
  *         initialized, -ENOMEM if memory allocation fails,
  *         -EADDRINUSE if the client ID is already reserved, or other
  *         negative error codes on failure.
+ *         -EOPNOTSUPP if system doesn't support async operations.
  */
 static int stratix10_svc_async_init(struct stratix10_svc_controller *controller)
 {
@@ -1585,10 +1592,12 @@ static int stratix10_svc_async_init(struct stratix10_svc_controller *controller)
 	    !(res.a1 > ASYNC_ATF_MINIMUM_MAJOR_VERSION ||
 	      (res.a1 == ASYNC_ATF_MINIMUM_MAJOR_VERSION &&
 	       res.a2 >= ASYNC_ATF_MINIMUM_MINOR_VERSION))) {
-		dev_err(dev,
-			"Intel Service Layer Driver: ATF version is not compatible for async operation\n");
-		return -EINVAL;
+		dev_info(dev,
+			 "Intel Service Layer Driver: ATF version is not compatible for async operation\n");
+		actrl->supported = false;
+		return -EOPNOTSUPP;
 	}
+	actrl->supported = true;
 
 	actrl->invoke_fn = stratix10_smc_1_2;
 
-- 
2.43.7


