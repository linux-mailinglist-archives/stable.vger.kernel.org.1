Return-Path: <stable+bounces-244262-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SI80NSFP+mndMAMAu9opvQ
	(envelope-from <stable+bounces-244262-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 22:12:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D0ED4D3801
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 22:12:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 11BD030E87FC
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 20:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7253E3D890E;
	Tue,  5 May 2026 20:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="jzkx340U"
X-Original-To: stable@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013061.outbound.protection.outlook.com [52.101.72.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689703DD525;
	Tue,  5 May 2026 20:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778011501; cv=fail; b=Dx75VqA/fjzJWDfx290pT/GwCxFEMuJ10CszTbd+wWGYXeLI2BLhqBpVSzVy3Yyo0x8G7RobB7f6UEldTj8J1Lk77VLRNiJ2DaOuFjOfR678mfH0eqy5Jw3pzNCzYrJWM44ffXwVbLRyOSsPo1lnC1nRcd5qs7cDHKccacJA+cE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778011501; c=relaxed/simple;
	bh=AcQWw8+6VFpVkshYZdDfdZU3FBcg1J96PZRmkcXRI0s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 Content-Type:MIME-Version; b=gqZX8scwWmv3lXxWBo8xvkgCOR3NASO63IZd9bMj/iMjadKX7NmacYLVk27b1qpKx45HaZWWvGZi1xV/KuTyc273gOZK5KhyqtTFsQaPKEHJyyTjp+5/Vmg1xosVIuoprRyrDglS+KP3dK1kL7hNn77xf//y52p0fase8bu8yiU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=jzkx340U; arc=fail smtp.client-ip=52.101.72.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yr4SyN9duOrTii1VFGehdO3HXYvJHGaqEG5I6CQW5fX0FCKHpoj1jYctVTe+4mxF9ESEWQgTHgNR+7XSE3mPyA7uyDIpYoftk0fn4QFeAnsEKyQ8OEKOdCxlykgILdv5DrtqQtAJlNtyfetfp98gCDPTtl53Fo8o5hqzU5dxxhYSoQKFU5KHFgG1HTDWU8tWNQMITakiAb5Ejed0XNrVNT3yY6O9n3tzqZLuULoi52kybP/4YIMTUzRm0R0MyU8ipCUhCe2tlomT7FdyFivB0wxsAYeqFvsdAroMiGLXqY4mzp+ucaGFx/pQ2sUKc2oSJ6ZDm2FoHgs4j8INu1SDig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g/QMRVhlg2sH3GmxPUc+yjz3+7zml/1LDVgxBYViRt0=;
 b=c/uLimkSSvcyhSKl4nCbdLaeBohnwDiOSaapEMVHo6RF5GhPvoOfO/4nib3wx9N2mM04afcwvb4sOk+T8a122Eo7vWCaS1Hp94Al0V/UsQfcC02lMqdoDBno1uVOz8vSDsdOvAUZJfroGVPkYrlYlaUuJaDA0G3UMYqC8V68xsiZP1KFU1YM7Ftm3iBc8tqNVDJpqVPS99jptbSVRiNdbtpupXSZXiDEWo63XQ3sulVjR7WxICfYrTVd0AZNB6HmZcu1IlKr4Au9ScxoTim5sc5tKHkM//p6dzNNIwQl4AOhbXepZwqHet841m7LadOu8Xok0xLCnCc3aN/FHr8bAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g/QMRVhlg2sH3GmxPUc+yjz3+7zml/1LDVgxBYViRt0=;
 b=jzkx340UrG/Ho/WthDIfQ1qmjUOBg6R5l5aoWYgZ5H7AopGXcf/ZnGMXKskoXldLORclKU0FpYObwS2QjahyLFiGQvHLIrFpJqTFmq5klZVYQJ+6v8n4Xr+0ztdHwOQH79xXms1al3YvjADFiCfc0KH7goifmyWxzH8ZBYd52/iDiVjJ38lY2IHOzoCmZ3IFUyeODVhYr5v0rpFTjP5+N1hC2jBZZGvBXytJ+EP+8EYC/7Xhx4H3NTI+v2+uyS6XXKXo1GS5ek2Zd6JBU00bfR739ZvDMQHUxOjsJgqTrexn9mjnResqpqE7nv8KxrxuYQ/Q/LHiaYrym3OEy3qGbg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by AS8PR04MB7976.eurprd04.prod.outlook.com (2603:10a6:20b:2af::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 5 May
 2026 20:04:55 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9870.023; Tue, 5 May 2026
 20:04:55 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Shawn Guo <shawnguo@kernel.org>, 
 Xu Yang <xu.yang_2@nxp.com>, devicetree@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: stable@vger.kernel.org
In-Reply-To: <20260413090723.53277-2-krzysztof.kozlowski@oss.qualcomm.com>
References: <20260413090723.53277-2-krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: [PATCH] arm64: dts: imx8ulp-evk: Correct Type-C int GPIO flags
Message-Id: <177801149261.2051112.9881722282246082285.b4-ty@nxp.com>
Date: Tue, 05 May 2026 16:04:52 -0400
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
X-ClientProxiedBy: SN7PR04CA0181.namprd04.prod.outlook.com
 (2603:10b6:806:126::6) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|AS8PR04MB7976:EE_
X-MS-Office365-Filtering-Correlation-Id: d6722ae3-ff76-43c6-a219-08deaae19346
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|52116014|19092799006|18002099003|56012099003|22082099003|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	LSp9ksdwsZ1+yRV2gmlOE4QBtovjeuG9mdo2gQBxZ0l0Eks8nmvfeJKWquZxWFQviikKGVi8uCqESMwVsTXupLDjHBaQQjK/T0BZATXfGCa67GY7C6MILkuvbgMssy3PrSki/W4FKYYM0Ug/A5G212kVq2oovzr84yUsttRuUp/e8gVKpTQeC51PN7t+HZfsyIRjhk0UA4UebrlGQVG0Tyx9AZBLnRReCVZfPr8kMQg9Qkzr+F1NLcH9aGoPReiVDp0ohuib5St3Z7GiO0LIX8vQkgbwCD2KATGZKq0h5QcLtZNd+J23Ncz79K0e4ZWFNp0t+uFM0fDsRuL/wONEcqEBEL4p6gRlcPmje6SbiH7eIatmMyld0zWEjuwRxGjYDkaGU3/R17yJ4gQWYjbtJhNj1Vvnbdl84w85+oy1cxQVPrjra0U9GZWH5QWtd4tB4fOo9rEu7lZVYn+XaTumMdt0YQ5pv+88ugf2xvqp1EAhOkfYDcinvOC9rlcWPgoZLtrzJRZjkVyz4wTn879LoJkcFmqHi/PgDER+RDk5N91LBSfSD/vvlvuJjjWH/67Ut+7D5AoOvrIzVrmE4l9yAUx3uVB2U4puQCEC3L7MC0v+7D02OP2IH1H9AbmuRst61sf4ITZBIzRFCEjJdhMYq3VZIcy2WzheZz6GSLPy7qkRbKTTl4uccQAQ/pPM1VteH74Nbp2MfgyGHXxl8mWnLw2w1YJZJ/7HeaEyXc/N2VAYQ5bdvgamBEp7wDpV8EZQ9xG37bVvr9Fq4+J0c6xteQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(52116014)(19092799006)(18002099003)(56012099003)(22082099003)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M0tyenVpR1V4OUxtUFdoUlN6YktyamVkdlNpRFVqR2RUeDVYT3UrY1pDV3Q0?=
 =?utf-8?B?TGQ2M2lZc3FZR2F4KzBMZ1h6dDVZS1FrU0VzWWVEUzdJWWRwRXJWTnFYVTNm?=
 =?utf-8?B?alBmQjJjUmxuK1pCVFEvbmVxbUNucktrMDlIV1d6V1Y2bWlTZDVnblcxQUp3?=
 =?utf-8?B?OFU3ejNUenhBUlpaVGgzVlJmR0Zvc0FWWmU5YmZxZU11R3J5Ri9GRjNuK1Vh?=
 =?utf-8?B?aW5NOUxQcFNiSGM4UWN4YkxZK1JZSGRWOHBRQ2tqU3VFcGxHMlhxcDZYQzJv?=
 =?utf-8?B?N3dhL3pYUDhvM0ZBRDhQSE4rZWg2aTlKRlM3a1pBemEvMG9PaXZlNWQraitm?=
 =?utf-8?B?bW1RbDgrczdXVm9LM0N1a2l3WDJEeXV5NzdNbyt5ZW1ZeUFYejJubFMvY1VB?=
 =?utf-8?B?YUcrLzBacFZqdDd5dERra0xOSEYwZE5heUhPVndSZ1BMZ25RUTU0elFQYWta?=
 =?utf-8?B?MWNhWUZCT3JqZEtrRmRUeERQM25oYno4Vkx6aGxPaFhkZ25Tb1d4cGJwZk05?=
 =?utf-8?B?a2tlVGZodmk3RnRSMnpOaksvZDZOWlBOdHpXOE9VS0prS1pxblBhWllBU1hF?=
 =?utf-8?B?Uzh3a0o0bnJqTmhhY3R1d3ZDV3M2WUdHdkxPQlkyZmFDMTArYndIVzhONGV2?=
 =?utf-8?B?MDg4aE84d0Uxb1FDbENDcjFwTjNUWWFaTGc5MTVvejdteUwwRHU1YWJUeW9P?=
 =?utf-8?B?c2lzajBTVExEbldFOVQ1VXBCU1ZwazgyOTZDc0Q3cmlwSUNpTXc1ZlZZRzdt?=
 =?utf-8?B?YWgzR2h6a1J4Q0ZqUFJmYmFFd2VwL0pPQlFrSjJ4dHVoeXU1eUxCVk5GNUVC?=
 =?utf-8?B?bkdOTmgraGIzQmhIUXcrSitvZ0hFZ1pzay96VHZkZW56b1hYckdrVmkvakw2?=
 =?utf-8?B?VnF5VlVUdXZyWWVSTWJ5L01zdkNqMWp3eGVzRWV6S05uamc4Yi9JZ25TaUI0?=
 =?utf-8?B?bTI1R1ZsM1gvWncyK0wzNGZrdkd4dXA1MThnVVI5WXpVZU5HQWE3cm43ODZU?=
 =?utf-8?B?YnN3Yjg2T0ViVGc3TzB1bEFXVkVWNklUbGdCbmZNVXNkd1FHTXBLZjF2MDFV?=
 =?utf-8?B?UldqbWN5aHF1VXpCZHAyeXZucFBrclJuSzJvZnZET2xvVUE0K1lpSE4wS3Ro?=
 =?utf-8?B?WTJxeWlQU3dLRG9kMVcrTHZlRE96Q0xnd2FpTE5BUDBSamlKSS9DS2RDblBI?=
 =?utf-8?B?cjFDbmt2OUF0aks3a0J6SGh3R2tNeUtKQkxUY0o1ZzVaQzJrcmovSUp5Q2FT?=
 =?utf-8?B?aUlHOVZNTnpiYTZyUkxUSkNXZllBRmwxb2EzdWhJWlZQVXNUdkpMU3RLTVNI?=
 =?utf-8?B?Smp0YXM1eGdYOWxncnlhT1lNTWQ1M21hbnZ0SVdxTHhDdnNIWGoxbG9OVHFW?=
 =?utf-8?B?MmpSMWlsV21yamRxNW90YjdzQ1NGQ1JFNVZzc0JFRXI1YmEweVdRWDJJWGk5?=
 =?utf-8?B?VnYydkxHcjNZUTUwa1oya1U4L1NTZzJWT21FQmFEVHZ1RlZWbkczcHhZRWJp?=
 =?utf-8?B?TVc5YmVwUHRtU0lWc0gwYzM4RGY2UDdrL3RxM004c2N6WG9Wc2drTzRRelRV?=
 =?utf-8?B?aSs2c2loaHp1R0VueWYydVA1ZmIwRklGNmdJcU96bExFMk9XVTFpR29hbG5E?=
 =?utf-8?B?T1dFQkU2Vk1iU3VIak5aaWJBQUpjakJXRkFuNU81Nno0eHRwOVVpYUVicUpH?=
 =?utf-8?B?aEZrNVFsRGkybjVJVlNSeTlOZUxPSlNabFo2cjN1dWRSWS9BL3JOV3ZBQmdO?=
 =?utf-8?B?cTREVHEyc01MaGQxWEN1ci9wY0NoTzJVWnIvK28zTDNHWUl2N0VnbW02cDVP?=
 =?utf-8?B?TGxKdjM0NzdkV2tydFlWSElqMmNxWW95UEp3SmZMb245RFFnN1JzcCtrTUtP?=
 =?utf-8?B?cG1KNkRLK1dDL2lVODJQendURFMvYkNKLytvcXV2WVhjajlDdXMvQTlNRk1s?=
 =?utf-8?B?M1pndFR6MGVHVGFsSVAwTXNJQXFUMU5MZ2lNeC85VHBBSjF3SENaYm1TQ0ZY?=
 =?utf-8?B?NkY0VThXRG1qTHAyNjEvL0gxemEySUtrdlNVOEVhUkZXRTEwQXVVT1hjalhN?=
 =?utf-8?B?TWRlTUorVkpmZHhJbWliVWFTalBvODBabnpRWUZ1NG5aMWhGalNYNHJCN0Nq?=
 =?utf-8?B?aUYwT0hyWkhnYitLZm5taFd6dW1WbVFzQmZRUVVvc0paWXQ5a2R5MEN4K2hX?=
 =?utf-8?B?Q0h5d2tkUUo0cEZTZGQ4V1AzaU1ycjFyTU9yRzh5RVBUdWJzTEs2RGRpbmdC?=
 =?utf-8?B?ZUdiM3BVbUo3MG5RSEZLK3EzeVBZd1MwL3JXTEx1VFRPTlVRSys1MVFPUXNz?=
 =?utf-8?B?YnRrU0VzVEE0a29yNVBuM0FvbG9WZTNBS21XZFJoL1NWems3RVhLUT09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6722ae3-ff76-43c6-a219-08deaae19346
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 20:04:55.0339
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wPA8Z68/jP+u6ja57gNuXiMch2dsJ6R20am24jLA+AAkKI9CIYQaEvbrtupc52I5zGkZ0fpn5jM+X5T2QqTDWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7976
X-Rspamd-Queue-Id: 3D0ED4D3801
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244262-lists,stable=lfdr.de];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,pengutronix.de,gmail.com,nxp.com,vger.kernel.org,lists.linux.dev,lists.infradead.org,oss.qualcomm.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.Li@nxp.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	BLOCKLISTDE_FAIL(0.00)[100.90.174.1:server fail,2603:10a6:102:2a9::8:server fail,52.101.72.61:server fail,172.234.253.10:server fail];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,nxp.com:dkim,nxp.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]


On Mon, 13 Apr 2026 11:07:24 +0200, Krzysztof Kozlowski wrote:
> IRQ_TYPE_xxx flags are not correct in the context of GPIO flags.
> These are simple defines so they could be used in DTS but they will not
> have the same meaning: IRQ_TYPE_EDGE_FALLING = 2 = GPIO_SINGLE_ENDED.
> 
> Correct the Type-C int-gpios to use proper flags, assuming the author of
> the code wanted similar logical behavior:
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: imx8ulp-evk: Correct Type-C int GPIO flags
      commit: 4dfcb78ced35e01dd00d2ca65a92a2794be30d3e

Best regards,
-- 
Frank Li <Frank.Li@nxp.com>


