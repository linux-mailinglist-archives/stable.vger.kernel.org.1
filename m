Return-Path: <stable+bounces-238265-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MNq6NS2O4Gl6jwAAu9opvQ
	(envelope-from <stable+bounces-238265-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 09:22:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F86440AFC4
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 09:22:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8C540306FC32
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 07:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51E0C3822A5;
	Thu, 16 Apr 2026 07:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="fzrz/Bg/"
X-Original-To: stable@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011071.outbound.protection.outlook.com [40.93.194.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A493738228C;
	Thu, 16 Apr 2026 07:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776324137; cv=fail; b=DcHSWg2EIbKvTh+xDnMvJshYW9iEpm4qfrkNkwZfDHrVX1SzCLF5pL0Y5xkH5juE6YZwXDHKVjeBZ9ppQtnTnSm1cleRpElkj3WmQeJNbtp1+oCSh+RhkgLMdy5+fyAuH2P9EKPwWeEJCO8YFiE+OEtUqdEIlX6/tg8MZe6r+kc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776324137; c=relaxed/simple;
	bh=4HZmKs9yo9BVnYxb5NP05DCdXR5csIoeVir0Ju4Ux1w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZUPPJ4v/UUZVPQ0vEh8QdS2A/znQKzYSmkgct+f6K9QWbRP/C48/d9bMeP5WVBQ9U4HLvciC2EYPSYodm8r4EECcs2jstN8tvDn2XLanqqivGZKQiid1/Mhn9ZW+IKCMGG3D3ObrbNdcZ7JetcquXKIhN56vEqpzfC8lrNwa1/M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=fzrz/Bg/; arc=fail smtp.client-ip=40.93.194.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SHZL6sjZb7/lcb0gVte4Xd4E5P2KXPR31DcNoW1HNT9XDCfVASK5BMwnww+lS51InysPo/jOHUzYmJkmG5bxQwP1DkWKzZk+Irk5dezEkUbEBaZVxmXEZrxFvaNBw/JA+d4Bs5slZ5BZqJXSahDzEauNelh276BB21rSxbL/DQDjwGShHek+39h4mtjHZ8gL+a58DcWeioyspMCU+MlOLRiVX1U/Ku0mQgkkjJPGLRPGcCi8D+4KaMqvn8G0rL4fsPES+OlaHqPcz8BZjUQL2iEQpY8fVV4FtdWDpdkvdOn+EQY9DgLy1rkd7+Iyf1cvXNUTFHRGB+78bqSOzmME7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=93/fuW3IXcQ7Yc7lcoE/OBFH/3cCv6qH47KmwUI5RnA=;
 b=aVqDZP0OqrYjnsv4z6OCZ7tVc7uS38c4BjlTUJCL1n/JbJXRs1Fg0+oD3hwiu6wv4YVdWJ/HmnmB0zV9ssKxXlevlBg1M/1keGF1RbZuvqa3hxMGDiKCIVYkc0BncfdLTTAumMbvbh/BOb+vyBhchUXGRhPWwVt/YfflKMyx+QpbDZ+VNAwFrybz5cQU4u9ZB+aNLy7RUADXxZhoe5K1fQTgTSHRHKLz5qxQOHPX8KrdLHpT2boA25gFkYKF+dzpG3LSOdDECNFT60D7tbA9kZJO2fF/4673+A7hXSFNMJeMqnfwgYeGlRxIA26cSmLvwfzoT8/OYxb3foNS4VrALw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=93/fuW3IXcQ7Yc7lcoE/OBFH/3cCv6qH47KmwUI5RnA=;
 b=fzrz/Bg/L28GxOzHCyzggTa7hZPJ//sDAWYeJw+nD+R91YtLEIPK3L8ZgSG1x65nR27dkr4fPx5g4YytENKe5p08bNZQD4IjrFaBIjMaqTZyuIo+wXkaARasxby3jGfmYv9LhW0f1Ne26ZpzJ9wqQiJX7/6iSWBSEytkFqLjJ12dgxiXqsG76Pa0yFtgENO+WEkH1DyZWhouqA1jIVLkYHuyT2ADyZ2H7Bh0c4pRtl/nZK4n4yIeUoavWPEkdQl6UYTczQ//g89T1FDn7w45lN3qYQXM/7BlsFWg/P9VKR/D/4+44GC0mbfrtieBixW1DEth1233UTM45hj0UfDXOQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BLAPR03MB5458.namprd03.prod.outlook.com (2603:10b6:208:29d::17)
 by MW4PR03MB7011.namprd03.prod.outlook.com (2603:10b6:303:1a6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Thu, 16 Apr
 2026 07:22:13 +0000
Received: from BLAPR03MB5458.namprd03.prod.outlook.com
 ([fe80::7eda:fa34:15f9:e656]) by BLAPR03MB5458.namprd03.prod.outlook.com
 ([fe80::7eda:fa34:15f9:e656%6]) with mapi id 15.20.9769.046; Thu, 16 Apr 2026
 07:22:13 +0000
From: Muhammad Amirul Asyraf Mohamad Jamian <muhammad.amirul.asyraf.mohamad.jamian@altera.com>
To: Dinh Nguyen <dinguyen@kernel.org>
Cc: Mahesh Rao <mahesh.rao@altera.com>,
	Matthew Gerlach <matthew.gerlach@altera.com>,
	Anders Hedlund <anders.hedlund@windriver.com>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 2/2] firmware: stratix10-svc: Don't fail probe when async ops unsupported
Date: Thu, 16 Apr 2026 00:22:07 -0700
Message-Id: <20260416072207.27074-3-muhammad.amirul.asyraf.mohamad.jamian@altera.com>
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
X-MS-Office365-Filtering-Correlation-Id: e8410a79-e65f-4e0c-91f2-08de9b88e16a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|22082099003|18002099003|56012099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	ZCovWRgikW2ctgde5ilNK/XZZEJbTRqseahD9NfLbAtkoYUIqp6OAs5UZ0Tj7RxXCSK93dVKdOJ7/sJNx+vCA0ZBifc8mmMTk1yu1ccCSZjzyCy4OPSzSejHdzokbTj1Qm+iWLJCXJ+eYsmlfA4J8wygEn/XBRXEbSwSX7FpSVZXBeueoBPtJZLbkN5FRdwwn3QZhaZv22Oxg8Rj869dUmWsUIb1UCsGdob8z2xOeWFxO/yhPKEN9OCqmjnaD4YkDwIXKnxI2fm/HSbgsD5miMhYZN3LNnw50diX0UcwAvHJbkoupx+DTqLi7P7xO/BmwkeauBmUdyDRS8R8utfD7osoOZ/vwM+NokygrDT4tlIMfG21fmTjzGuLtUG4fveE3eRVQ0zjaD04KdsDseuLf9HVjeJKLg62ka5PsW5yD+yjfdaWRNHWw2shPJxow3jQHkAPk6/t+VplsTFmwFUtZ3z+RLg4IXWzjRQ4vqdhiTv7rReby8pWRIrM3VOvwx6PL5rsKxO2czDdqxh3zuGxCunozyYkxc2iGgY/IN2T00fUkoUht6DVwCZmUcJXtTLARtMEh0tVN+ZVNJX/eRLSh/RyDUCUt9HLyO0qe6oV1RA0F6rQBasHqexK7wC+TV2SH6TGBxZcYG5/BWZ3mVzFnndkejC/60yp1FzPj+BcrfvOwWHsIm4dg/d6pn+tCBX79gELYXJJa+ToUeKwJNdLl0wof152njIxsOumuwg6M1U=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR03MB5458.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(22082099003)(18002099003)(56012099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZuNlRKvZ1+jAtdpY7MFwE3gorsbBBv3iWriJ2Hau6es/2CefXdvVlyuHCEFc?=
 =?us-ascii?Q?eiUSqnJvSpc3UvncI0Tj/vSL0yXuRz5iNvcoWeQtQKtk5zXX1rf7jRhgRDcC?=
 =?us-ascii?Q?TaaDysjq0HyjLjoGK51QWyiC30g4hqrzss+YPjC3Uco+4fZivezh43KS0JrG?=
 =?us-ascii?Q?RnB37H1A1FGoLd8RTlrDLLi+wQ8VJGHxNjAza5uX4HGQiMHXNUdyvPXU1iHJ?=
 =?us-ascii?Q?1VWPFuWure/FYkoHgvekL+5h8vqqtNijYOtCTBEznw8tdw145JrNjHSOy7NT?=
 =?us-ascii?Q?gA203NEgOtTZTyD91nXSs8UuHDT3KRsA+Fu2Dgu7YM238XC4tuvC4XyaCi6v?=
 =?us-ascii?Q?cdNUTlbUDaCiW1rLkjKFGyAxsqe8ZdY7dL5O5WxZaGiLKO0e2BEigvhqfq0a?=
 =?us-ascii?Q?GdTiSrEUX2pwu+vx2+baQl0UU6Isit92lQprNaOmS2EZ8jnZaOE7IX0qZdTy?=
 =?us-ascii?Q?NtFveXavC9mAzirdHHhnLuYqsR0yZXa8rNIMHfSbd7p7RlNLRN0aPtFjQsby?=
 =?us-ascii?Q?U/pFMgDs/7dWZdjMNyC1JJAyT1VbvTzNX+Gi1d0pZHibW1uUHlzbPyXj2ayg?=
 =?us-ascii?Q?GSfe4Cm/43zzMEM7llXsC3EfO9raZorOMBFcF/xiI6rfeZC94yIFwlNJiaE7?=
 =?us-ascii?Q?ccrIBOEMaoDv3n32Bk48405bvekKFJ6EFqlYgeDklesTEZd0k5xd6YMIDweT?=
 =?us-ascii?Q?xtj/6GDTXes3Zlwz2aAINJ8FltyYVP1Jnfmkb+Vaa4FnqvSCgsEsqUh3IYDU?=
 =?us-ascii?Q?3bcTqJphPI2+bCesO5N892N21VA75sdB/wHlObwyD5JYks0rid3SuMEcUyvk?=
 =?us-ascii?Q?k4wR/Sf/lnx/Xztu/AyJR8g2TCAoV6QISnsiamyCDBxcp2IH1r31J8RmTtxZ?=
 =?us-ascii?Q?3Eaq6uZJpKUu6HwXEjr/PUFy4wbCId+iv3nGatifvxhV67CRH7nlzgSFH4Qo?=
 =?us-ascii?Q?jBruFMEBWgkfDXZxA905MZ1oEoejjlhOURax9Lx3Bfhfa6ypqBqhsCCDapCb?=
 =?us-ascii?Q?soOvupSKlKgPpF2q5flWTT5llr7pQ53WQ6CnRbbUleSMFyfb5JUrJA7CFXZX?=
 =?us-ascii?Q?V5ZzeeRBVBjChZlU0LBTbHuHZjEe/sapPZPCYtcg+s8OK4USsoaE5/vHqRpI?=
 =?us-ascii?Q?DD9C3VjkOqilhn9uvlX0v5Vdygtru7maaqkMa43gbUbJlHkh1qVPwTqcs2Hd?=
 =?us-ascii?Q?Dkmq3RYLMibTjKZvZ8udup2u1QOX5vBy/bSN8+p5GaltQvfydodNOzO/3PNM?=
 =?us-ascii?Q?Dgi0bMz0RmLzgqGm4EhhCvQ0VVU15yzLHbbr6UKrsFebKjkj0EF/FfHLEq3z?=
 =?us-ascii?Q?YDcPT2b14LABmXI360f87VnLGa/4bW1+fuucB8pi+nEgt8lf319fT6fIjhnN?=
 =?us-ascii?Q?IDWSvH7p2d3eYIDGeza38ffCv0Nux7Y5jacdhlDLKDmAsMz9U0V9yxKERBsG?=
 =?us-ascii?Q?qm6blp/x2jDsNr0BytsquLcJjGmvB2GWsEkDd66to02iPBqJvDFSgRts9cAw?=
 =?us-ascii?Q?yvjfTtalbRhbv68aTmTOHrPP3rGBuhM6EitAmlumPcMi+hlNR983gtWwn2h8?=
 =?us-ascii?Q?4dsrm1eEQewz0VLvyBwXPK4DXDsCWE9TM8ZaZizw3kJOb+skm5hvDoUwlDor?=
 =?us-ascii?Q?5TcsE+Z5h5iSYuSx2+w3McExaUl6IbsXMTefU6UD6E6ipE1q1zKZ9AcKbRS/?=
 =?us-ascii?Q?lnAWDgEXyx8kNLnigLzouba+KVGBYo+RH3rUTNuVOHxLXghxbMCLNchFQB6C?=
 =?us-ascii?Q?17wqn8oGBxhvJwOprHmeMpLlt86GXURXlAe81gJwYngKW8N1Fxw40Mw5+Dur?=
X-MS-Exchange-AntiSpam-MessageData-1: 40B4GIHVv8IZHQBEwU/Vq9j8u01Zu9MR2gk=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8410a79-e65f-4e0c-91f2-08de9b88e16a
X-MS-Exchange-CrossTenant-AuthSource: BLAPR03MB5458.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2026 07:22:13.4557
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RVaH0U4YBgSfFzvdyxvQtVwv+mYo3OtNCzmor1CuFf5mpkOLZMWUh6QQDN5XnxJahkcKztttWgneCPWDmAfZuoVJxwQtHNFTRNGZaa1PwXoTPpWPA8fRzupxdNLG3VxdY2g2DOGjQ5+IHpkZAKiHeKRlIit243iX6M9Q/GVxe2E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR03MB7011
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[altera.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[altera.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-238265-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN_FAIL(0.00)[114.105.105.172.asn.rspamd.com:server fail];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[altera.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[muhammad.amirul.asyraf.mohamad.jamian@altera.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,altera.com:email,altera.com:dkim,altera.com:mid]
X-Rspamd-Queue-Id: 5F86440AFC4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When the ATF version is too old to support SIP SVC v3 asynchronous
operations (e.g. ATF 2.5), stratix10_svc_async_init() returns
-EOPNOTSUPP. The probe function currently treats any non-zero return
as fatal and aborts, logging:

  stratix10-svc firmware:svc: Intel Service Layer Driver: ATF version \
    is not compatible for async operation
  stratix10-svc firmware:svc: probe with driver stratix10-svc failed \
    with error -95

This prevents the SVC driver from loading entirely, causing all
dependent client drivers (hwmon, RSU, FCS) to also fail to probe even
though they can operate correctly via the synchronous V1 SMC path.

Fix this by treating -EOPNOTSUPP from stratix10_svc_async_init() as a
non-fatal degraded condition. The driver loads in sync-only mode and
logs:

  stratix10-svc firmware:svc: Intel Service Layer Driver Initialized \
    (sync-only mode)

Fixes: bcb9f4f07061 ("firmware: stratix10-svc: Add support for async communication")
Cc: stable@vger.kernel.org
Signed-off-by: Muhammad Amirul Asyraf Mohamad Jamian <muhammad.amirul.asyraf.mohamad.jamian@altera.com>
---
 drivers/firmware/stratix10-svc.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/stratix10-svc.c b/drivers/firmware/stratix10-svc.c
index 739642923ac6..4924f6402d00 100644
--- a/drivers/firmware/stratix10-svc.c
+++ b/drivers/firmware/stratix10-svc.c
@@ -1953,10 +1953,14 @@ static int stratix10_svc_drv_probe(struct platform_device *pdev)
 	init_completion(&controller->complete_status);
 
 	ret = stratix10_svc_async_init(controller);
-	if (ret) {
+	if (ret == -EOPNOTSUPP) {
+		dev_info(dev, "Intel Service Layer Driver Initialized (sync-only mode)\n");
+	} else if (ret) {
 		dev_dbg(dev, "Intel Service Layer Driver: Error on stratix10_svc_async_init %d\n",
 			ret);
 		goto err_destroy_pool;
+	} else {
+		dev_info(dev, "Intel Service Layer Driver Initialized\n");
 	}
 
 	fifo_size = sizeof(struct stratix10_svc_data) * SVC_NUM_DATA_IN_FIFO;
-- 
2.43.7


