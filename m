Return-Path: <stable+bounces-223419-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kEAIGIIQrGlIjgEAu9opvQ
	(envelope-from <stable+bounces-223419-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 07 Mar 2026 12:48:18 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C4F1622B90D
	for <lists+stable@lfdr.de>; Sat, 07 Mar 2026 12:48:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E0999301CFD1
	for <lists+stable@lfdr.de>; Sat,  7 Mar 2026 11:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4755350D7F;
	Sat,  7 Mar 2026 11:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b="WViOKLxG"
X-Original-To: stable@vger.kernel.org
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11023090.outbound.protection.outlook.com [52.101.127.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577DC20A5F3;
	Sat,  7 Mar 2026 11:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772883977; cv=fail; b=Zl4h0k5AC82yxNLHyuR2jn+SMllUte8roOGbVQIuO7aczAEFOY0FpE9/qhkwC3CYYJiZsDCEOcA98F0lRtHold4+YVHXSCsCDejfYMy3g9RCz6B13J5oC9WPdNk95HTTDLA5GA5OY2X0BJgGE4CcU78/8CfBR8A/fauciALUDts=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772883977; c=relaxed/simple;
	bh=kKh1ynEaOugFp04Gbgb+B41bQzp2wkbuTtvcQUXl2Lo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tKFU13wJUQLbj3CGppWwWAts69F58xs8qlhkTdm808Q6xy2aHpCuKFe6j3zasDotUdL2ihCTBMnrvrJlj9CvsonhUO4v52RCgA1aMVKoMhRorUGNy8FDvJFN397JEhhqyspnygnuMRqO1R9/cOtlcY/s72smy43QPPBfMr2H6QQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com; spf=pass smtp.mailfrom=oppo.com; dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b=WViOKLxG; arc=fail smtp.client-ip=52.101.127.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oppo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nRqjEh6erSlmw2Z4jNmtmBakWIzFPJOxIN56SYUO7rOzQ+T+hBEyQYe1AO9NN+/06e5J1WdQfthgqBJF3gLfJYlzvDc6WWqSR/wzKzFvlOVyKyCD+Bchkf/2MedbFCl3rOyKHDxZraM/y3ViJ4CYqLoHXyRY54EE3evD9whMXxbKr8jHnDA9YmvH4s2PGCr4dObSFlwtq+XWmRint2ezVx0sNK+gytn6yBkEXtOwIdEhoY9BCDsu1FWGvgjXcleiuNjdtETqyVKAStKOgcERzLNlXjcc71wGMfj/KW9Z6jcab0nLLnYTY7F280eNvTW6U68VEfs2VNWBr2UgG2bbsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kKh1ynEaOugFp04Gbgb+B41bQzp2wkbuTtvcQUXl2Lo=;
 b=T/pVXhWZ649POOYH/SAFyETjfZ4Ns5Zct9V+zV4Sd44gohCWVoWmM1Yy8LnI8g/VGCDEcWF9kFVaid1z8r0gyY2apjsiZpr7Z9tCm0crL1Z047Juk8y2gaZBy6aMRBLcfVHn+SZo7R8y/5sOIl/SlHYwz0n3JRGvk6eUgy1oZo3Ob7KAdCw5cMvKEExgFXYkgaS8mPyQJAzZVaLzzIzOPhP08x0jQMnNNvUwskthnse0Zb2ruAIsUJ37NbtlJbR30KQRi0yD/R1qgllc1qHuAB9QjNW3gbMe6m3MYSh56XUc2IO26mzDKQySkqz2i2LCANQQUFgz3Y50Qxb98x5F9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 58.252.5.68) smtp.rcpttodomain=google.com smtp.mailfrom=oppo.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=oppo.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kKh1ynEaOugFp04Gbgb+B41bQzp2wkbuTtvcQUXl2Lo=;
 b=WViOKLxGURpnNrR5h1HyVU1OFlOM9eSt8RJc7tUGsV0kaGMWaIE8kqci/W2ZttODNjzI1FdJ+O85Qhdb38WL995wdEeOXio3LCxeInsG9qcD25+bGkUVoxX5X06cb8WIOKZo5UoqdSvH1NAXXWTMTIIC4sqjdM32G02azYdzJkk=
Received: from TYCP286CA0265.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:455::17)
 by SEYPR02MB6146.apcprd02.prod.outlook.com (2603:1096:101:b3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.20; Sat, 7 Mar
 2026 11:46:08 +0000
Received: from TY2PEPF0000AB84.apcprd03.prod.outlook.com
 (2603:1096:400:455:cafe::55) by TYCP286CA0265.outlook.office365.com
 (2603:1096:400:455::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.20 via Frontend Transport; Sat,
 7 Mar 2026 11:46:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 58.252.5.68)
 smtp.mailfrom=oppo.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=oppo.com;
Received-SPF: Pass (protection.outlook.com: domain of oppo.com designates
 58.252.5.68 as permitted sender) receiver=protection.outlook.com;
 client-ip=58.252.5.68; helo=mail.oppo.com; pr=C
Received: from mail.oppo.com (58.252.5.68) by
 TY2PEPF0000AB84.mail.protection.outlook.com (10.167.253.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9678.18 via Frontend Transport; Sat, 7 Mar 2026 11:46:08 +0000
Received: from PH80250894.adc.com (172.16.40.117) by mailappw31.adc.com
 (172.16.56.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Sat, 7 Mar
 2026 19:46:07 +0800
From: hailong <hailong.liu@oppo.com>
To: <guanyulin@google.com>
CC: <arnd@arndb.de>, <broonie@kernel.org>, <dan.carpenter@linaro.org>,
	<gregkh@linuxfoundation.org>, <harshit.m.mogalapalli@oracle.com>,
	<linux-kernel@vger.kernel.org>, <linux-sound@vger.kernel.org>,
	<linux-usb@vger.kernel.org>, <mathias.nyman@intel.com>, <perex@perex.cz>,
	<quic_wcheng@quicinc.com>, <stable@vger.kernel.org>, <tiwai@suse.com>,
	<wesley.cheng@oss.qualcomm.com>, Hailong Liu <hailong.liu@oppo.com>
Subject: Re [PATCH v1 1/2] usb: offload: move device locking to callers in offload.c
Date: Sat, 7 Mar 2026 19:45:59 +0800
Message-ID: <20260307114559.378132-1-hailong.liu@oppo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260225064601.270301-2-guanyulin@google.com>
References: <20260225064601.270301-2-guanyulin@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: mailappw30.adc.com (172.16.56.197) To mailappw31.adc.com
 (172.16.56.198)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY2PEPF0000AB84:EE_|SEYPR02MB6146:EE_
X-MS-Office365-Filtering-Correlation-Id: b06d805b-022d-4222-822e-08de7c3f1f95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|82310400026|36860700016;
X-Microsoft-Antispam-Message-Info:
	VU8mWweJnkqF+lGnEri7U/zBoxIGPR8d35QIjmqWhrUMfFC/n5wuflc0wjm8r/Uq9kY9sVyH/NNp/OEG+J3F1qCzs3pec/JtoAccwE0mNg2Sz5NV0EUsy63qXlS6XQ9H5LS+XUeeWB9SILnPoFmkMNm8U1Vph7FsZwR+2THReF8y307zvDM5w8NywZyKY6enJavu1/3qbUT/PWPBwhEunl118AlA/gmRcljDQ8MQTjWUOV22XJOriSecLNdP6xpYfjfDQC7joD872CJSssxuWIaNbMtErpjYeVWOsjYHQ7BUDYdpjnlPnDJDceNYd99CaW2zuyahjehdTs42m2PaVmY2S/vcXaWKupxpo2OcirA0OTwVaKOXTy9nikTgJWvfz6xlkj3vHdZuUNry7WEjc0hn1qG0teYaFAREpjGzA8fRl3Rlbb/etHfaZ9lSaPryr2bQnKyitawvt8CBk4KKdCp5XOuoTZJ/13C3gK493WRlBdKdhMwB904wdYjZYHo28+BzqdSwg6ijRDpjitl8TtZWBuSuX0B4drrLAUM+HRExH7GddWZl5b/X0rwbY13jDHYy56H8nhFnwSKIm2VKZCwuNecD6ILk9HHgqvo6i+oYqpoL+XYXXrWqkoqh5GDmRHOSsZRAMx0fcuqPse9dI3/5UOFmZWWXgWR6d/dtb5L3fLDs04TWPfjZlNOGhNRSR/z6AyMCu1AKwo6B6tvET5z8L4Eir1cclOoClBoM0xgBDwGcgOdnAja9b7mxZclzV/u3DW2TO52zdjJTxUq7Ng==
X-Forefront-Antispam-Report:
	CIP:58.252.5.68;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.oppo.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(82310400026)(36860700016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	fWm1WaIiZcP3zmH2RRSSsOVDMwOVAhVYAN8AoCKzLaMwUVopFGIcmE1cZN9nhf+71sXhKDL2HyLKU/UHNhHuglEcNliwX7R5oyaAM7YuxvRHr63Vwx7nk7YQsEbyFzFFx32Me8qjBL39M3JA0MwvXmI6SqkNR2tJ2q5KfMSbwj196lY85rLMYmAa1HC+FlBuoWeXSBCOwJUQdcXaFM9Uyzwzv+oU8l3Lg283GG5MMxMj7QoDerfq9F5Dkz6O8DVWMHy5Qh9g0r5TAKu5RTN3CCI4KVGeevGM+DRKjMEFv/fkfrCNh4+AkSWdGLaVPZfnFUlCTSODhqd6Gij/5/v4gOQYO4WnMRROm+jCBF0klTnB1dtftozh0d62zhukGhfocttzVk4VidgZE2yCAuH3HMqnS4QfbpsVJGjv5369069og0vWTEQ/AQXbvFJibJOn
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2026 11:46:08.5944
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b06d805b-022d-4222-822e-08de7c3f1f95
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f1905eb1-c353-41c5-9516-62b4a54b5ee6;Ip=[58.252.5.68];Helo=[mail.oppo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	TY2PEPF0000AB84.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR02MB6146
X-Rspamd-Queue-Id: C4F1622B90D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[oppo.com,quarantine];
	R_DKIM_ALLOW(-0.20)[oppo.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-223419-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hailong.liu@oppo.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[oppo.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oppo.com:dkim,oppo.com:email,oppo.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.990];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

Our OPPO team has tested this patch on an qcom8850 OPD2514 OnePlus
Pad 4 (arm64), based on Android 16 kernel 6.12.

Before adding this patch, the issue was always present after 100
electrostatic discharge tests on the headphone jack. With this patch,
the problem has been fixed on both tested devices. We hope this can
be merged into the final product list.

Tested-by: Hailong Liu <hailong.liu@oppo.com>

