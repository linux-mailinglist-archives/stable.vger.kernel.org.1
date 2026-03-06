Return-Path: <stable+bounces-223362-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yOXeGEAAq2lxZQEAu9opvQ
	(envelope-from <stable+bounces-223362-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 06 Mar 2026 17:26:40 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CE975224DFD
	for <lists+stable@lfdr.de>; Fri, 06 Mar 2026 17:26:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F266F307BAAB
	for <lists+stable@lfdr.de>; Fri,  6 Mar 2026 16:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8AED3ED5B9;
	Fri,  6 Mar 2026 16:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="PkUekvBo"
X-Original-To: stable@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013025.outbound.protection.outlook.com [52.101.72.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6DF2DCF58;
	Fri,  6 Mar 2026 16:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772814036; cv=fail; b=MWKPikuGBtOydo7B7ltRFwBF46PIuz6v+hS7/1BmXED10U4mf86p2gtyicMaUcWgjqaDjQxB8pKdjqE01k0xIW9kNDkl8S0er6Fj53z9GQ4BuH1TtEFjegGix7Pq5sMWxsG2imQmueXv/7ecHmchYRce+bjCsHc2p1VidsDx55I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772814036; c=relaxed/simple;
	bh=1zm2pUonX9Ni8jVgQoo9jaYBue+1gz8kvoLkqpqtYbo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 Content-Type:MIME-Version; b=XRWmPsNE/KGB/YZ0KT/o1+mV4KNVqnEhRi1/I05Zj6wOYrzAapzQEiWM9PRbZhnIK43Emj08sKY1NbGHioZt1f4kQKMHv6tXP4LsjgdP8VqhYDEV8oKcKJyMWMOJTuxl7SZmgm8aqp6+YhVXJGJrsnNkaJraAWflSlstfQ9EPbs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=PkUekvBo; arc=fail smtp.client-ip=52.101.72.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PAUnvBxKn/8HZd784+aYYaMv7jRBgjqUgJPmCIDjAWZVSx061i/qOIwvHT6mkKfV9Zl0dDaqTDpRxc7SY+HNM7t7JhRWTCppyxWEU4cWYYzxik0sgYaIoN95wZEogpmwPb610cuY+bwwmj4YQsJniPcOMn1xS7lhffMOaxfT3uW6JDsgLUWw2k3ljNI9H9VTmOYkebmIKT+wvjpr8Wltfr1PKc6Xw5TQeg9uw9SvKKxG8uH0B+rqrO11jcw3+ZRyugXZV2A2otAzh1fdHvE2QCmIwEyeDFaN6/AjIhbINdYmiQ0I0Pr1InhSj6wJP2Sq4FwMUy5NqvHA26yvDVTQMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lzgNOoxmeS5cbOceGORsyQOlEgSuSV3Q+vAdlRNZXr0=;
 b=HsKXJNUDb60182IeeCaq+0uWIU1iTHsIXmp+aJCxXidFXFoO7o7ookE2Jt5KD/LjBw6Iu7FEU8YrTwngEy62fW4WDEYa1H0Gw0NwkcvCXrwFpr2IxFQoRHng4AatxhQWXQmiXl6Gc0jGoRFH9qmhGshs59AMV1jU/up76YUcvw3PH70YN+Ye5lA9n8Cijbp/IML9y0NA/70mII6kV25FwL1tm0cq+rXdF8e88wCQdHlxz66w5uh4Ggk9bhYhdqx0jAklhpXyhqcMuDEpKqq2a5x2wC3ezNxX0esnhe9ARyaAKqMGDvPfgGWloLjJ3wbi/Oh0m3RIlOuPjRnd30SaDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lzgNOoxmeS5cbOceGORsyQOlEgSuSV3Q+vAdlRNZXr0=;
 b=PkUekvBo+JXHw3FkqxR9zxPX1sgY4wtLFcuGa4V3RTkVR4aygtNDuOWl/UL9/po8G/ZuM/4lromP1SR7an/l+BE9qk+7tyr91f6f6n2EBmDU+VcMe8WCdvahTwvWDuIPXQG3hiUv1oOzAlADutmlSdnqyj43R8ZAKf/jU/70jSw5Qod/i3zgYwxkkLJB8YNvsEQq4mrR0nuCEGFVLxqdwt6Kb9lZyHSGq3lWShEGw2P63QQ3lzNdnUsTVeaLWhfYTJRuse3rfG+a7gBgBAR+ymBPaCAPomyimKpNu6wzsnbqOuZXGrlE5xy4cCetHqq7wVuZeHx8vcmjGohLIDkqPw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by VI1PR04MB9977.eurprd04.prod.outlook.com (2603:10a6:800:1d9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.18; Fri, 6 Mar
 2026 16:20:30 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9654.020; Fri, 6 Mar 2026
 16:20:30 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 Martin Kepplinger <martin.kepplinger@puri.sm>, 
 Shawn Guo <shawnguo@kernel.org>, "Angus Ainslie (Purism)" <angus@akkea.ca>, 
 Daniel Baluta <daniel.baluta@nxp.com>, 
 Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>
Cc: kernel@puri.sm, devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>, stable@vger.kernel.org
In-Reply-To: <20260221-l5-voltages-v2-0-dd8885bb9331@puri.sm>
References: <20260221-l5-voltages-v2-0-dd8885bb9331@puri.sm>
Subject: Re: [PATCH v2 0/2] arm64: dts: imx8mq-librem5: PMIC voltage
 changes
Message-Id: <177281402574.274832.8827991300002279379.b4-ty@nxp.com>
Date: Fri, 06 Mar 2026 11:20:25 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
X-ClientProxiedBy: BYAPR04CA0007.namprd04.prod.outlook.com
 (2603:10b6:a03:40::20) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|VI1PR04MB9977:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b7b9f3a-9f25-4158-06eb-08de7b9c48e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|366016|7416014|52116014|376014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	4Kxfjqls1de4wiKR51b+rjW/zAEeQ2YZ9nLM4xGt1TJWQgSe9Hopo0NgexBPiyoO0uFt+9LmxIpT+kFXHmR+DypcEMfSxqhBMTJrkujYEqbgm5wX0dg9NmOTqpgq+Js1pZ0PCGkRtE3fnfGpzi7dtxp++a54qfYczXIEU8RfmS2yzSYItvjO4znlXkDJk6d6vZSnnOYrFv2nWoE3Z3ZtifGfem/7upQfS/F/3wWbEThOfuZyg8PPPMu4Xb/YtZ/4kg7Gnq0IvSIWQSJ3FdSMA+d0dri8q7SCdIM48UlPL/IjRV3wTT5xf1ti1Sh+mW7pnDkwwcdXm8uqwzH9ZJnUE8K8vBve5rU4iBTxWunqG0+vsPMU8KFFbOaHuPDobJhhj3ulnEQhUrCwnChNS0gVQLDHcpcbrA0wj+5oJKDMDOvIiIUvIK1qAO4dMF5lQUSs8Mk4S5k2WRxmTVftYzYd6vPXpByzu0Qhwd2Gr+UmerKWmEuHfD2UqphBg0RXA8q0RdPwQibk14WPcg9hN5TvfzG6EJ9gv7a+wb84wFNgQxgvJnnaQAtPLopH0tEsvZTBVuitv2TSqZlBTnpEnKgPS9rWc47kSITceeHA3YiItFPUL63+bjlB1/BYQfiV3i3O5XSOH6KIU/aihfbB4vXLxhMAHsdBPNFMk3SY9+eJJEiycmOxuBFFcph/jp+gJDGhMGBeQD01sb9swoIUo9jc4UmiSffDqoQRb6+tPbb4gi8gkhOaS6H3IfQSpIGJg68vCwAJxTRw4XFinsjcK+AKLbu2keHL8Q1Eu18/AjlA6WFAKn6BI/Pncg7zgcIPMiMp
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(366016)(7416014)(52116014)(376014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZzUxS1VuOEF5dUlPVW1jNEQ5ejkwZ2l2QXlEempjRERwRHN6TDZkUlRQQnVI?=
 =?utf-8?B?RTZReVJ2RU1NR2M1VHlXT0FLUnpLYXdzQjVya01FTlJTZDlqQjJWcWlwUFlG?=
 =?utf-8?B?bTFETXBjc1JKUytaYWFaeHpYS21zdTA2OUNKaTl2eEJtSmJ6TElGZlptRGh2?=
 =?utf-8?B?d3o1UjdwK0RoNCt4MDNRcFk2eEtSOXBRbzRWQjU0TXViaHNEc251cU5SUEZK?=
 =?utf-8?B?TG5wVlhZRXI0SmpSemJ4OGxzaFB4eUtldDFnQU4wd1JaeU9sYmx4cHhyL01U?=
 =?utf-8?B?bHBjZTBTSWpiZFhETnllZUxuS2dySkdFUnVSaUhRK3hMUk91TzZibk9XTHlO?=
 =?utf-8?B?cStkZFBpNDg1czJCM2UxSW5HMk1yS2hDdXU3cUhDVm1KUnZDbXliV1U4Y1ZI?=
 =?utf-8?B?Z2FnQ3B1cDFYY0VtM1hONzRpWUU0MWl1TGM1ZkVLeUxWTDUrRHJaNCs4THRi?=
 =?utf-8?B?clhPYzhHRGRRVldnK0NXZGFFdlQ0dXhJSFpRVjRDem9xN0xBaVYxOEw3Mkhp?=
 =?utf-8?B?VmJaZFNZenVOcmgvTlpWVUkraFZqRTNJL0hnSVZvUVNaekxVdWJQbzJDN1VU?=
 =?utf-8?B?WVdJSDlTd1hUY3FrY0ZGbXVPNnhtbnI0L2tSUENwS3JUNGNHSFZFb0FqUnZN?=
 =?utf-8?B?aXI4VXArcFBwdUlMOU9aZWhSZWdEOVpESm5Ya09mdjZCZGIwbVVVam9oK2RX?=
 =?utf-8?B?bXIrY1FJYzRKYTdTblZlVDlqQlBkbFdvdXNtMUlMOS9VRi94NWVwQlFyQzdC?=
 =?utf-8?B?bEtGcDA3TGF1eVZQaHhwT1lTWWJ1eHJERC9rY3lTU2lrTUtna3NoL1Q1WFA3?=
 =?utf-8?B?SkJpSzBoSE1sWVlWRHRlM0ZtbTk0WEFldnlMUGlJK2lOUU8wZnNCbXlnekcw?=
 =?utf-8?B?WVl2ZGEvK0hKTWpUK0crU1Y2V1diR21oU2l3b2hucVB5blZWZHJTMGNFcG16?=
 =?utf-8?B?K1l6WWwrMnpzU1hrR1VHdXBJNEwrRXl0aGR4ZEFmeHpVV1l0VkRtYndia0dI?=
 =?utf-8?B?WFBjb0hYcDFlTGhRUTRpN0RJR2tDbnpMVTNmK3RmU3F4QzRvN0gzSjdRcUVs?=
 =?utf-8?B?dEdDcHRZSjVUZUJJTzZQNWRkTVVXWi96bklwYU12aVBETnRjS0U0WnpqQ0Rr?=
 =?utf-8?B?SW44WVo0dnVvMnBsR0c4RHdRNmU0VFZkZWNBUXV1R2JtYVFMQ3A2UDFNQTI1?=
 =?utf-8?B?RzFudlRRYzhDUWpab2dlZ0k2akJ6aHpGVmJkU2tMWldzZmk5b2JJWGJZY1Ri?=
 =?utf-8?B?ZUtMaGdUd2FkRmZaWWdCQTlNTXZtRnF1b0ZVamxaWTlnRCtreWh0ejhweFVX?=
 =?utf-8?B?bDA0Ymo3bEVKOXhmQU5GTFJBY3FmNU43YXc4a1JraWZpc2F4QTR6MzlGL250?=
 =?utf-8?B?RDBQK3dCdlVZZU9qcjYramhlanYwdGIrWmRxTlpuZmk4cmxiOFpSbVU4N3Y2?=
 =?utf-8?B?bzF3Mkc1QkhKdFBsM283NTZmR2hvejM4NWFESFdxaDhNekdid1RZL3Y0U0g0?=
 =?utf-8?B?eUlUcHpkS0t4ak4rN2Z5aDNwYkJBanlpQTVrVjlUOFNXdVp6N0dmMC9sdktj?=
 =?utf-8?B?UTdPMEYyWCtuMEtONGdPWUs3M1VNNVEzNnpnTEQ2ZGxQSUZ1VWJGOEw0UEdB?=
 =?utf-8?B?bGRHRWRnYnJtVmc2UEpYYUtkNFBQYW1ZY2tIQU5LTE92RHp4ckR0bjVLbEVY?=
 =?utf-8?B?bU82SmFpZlVITkh2d0NOUzlNRm8renZaelFpelM5TW1JeFEwTHpvS0dGc1FO?=
 =?utf-8?B?cXNOVGhzM3ZFZlFqUjRFMWlNTHFsdk1RWGpQQ3l5anlTYTVxYmpsbURmUWl6?=
 =?utf-8?B?QmF1SzBtbkJ4N3JKczhrS096aDJqMDRveWw2RVdUZzlhNzdudktiQlFIaVJm?=
 =?utf-8?B?bDVnempyVzlMZThMTjIzYmZDTVUzWkhGRGJ0MzZDR29RZDBIbUE2b0g4VGlT?=
 =?utf-8?B?TUxNUWI3NEhSaDlJZ29ycU1ZWDVnc3NqYThpRVV5V0FzV2hsaEVlM2NUM1Uv?=
 =?utf-8?B?SE9Sb09qYk5tbEFQNTZOS0Z4b2REbExPa05HRGZ5ZkxFV0FJYTBzRVQyaWZP?=
 =?utf-8?B?dFQrdXNuZUVYbVRhbmJ1S3I4MTlkSU5iVzA2QjdpWVJPUTdxSnluZUtDQjY0?=
 =?utf-8?B?dkErVjErWU96QmtmMk8rNDNyUnpVK0I4OHNrOFMxTnhBWTU2UzJ0R095L21K?=
 =?utf-8?B?U05ONEtYdlF0RnBEbnVsVnMvK3czZmZjSzhPWVdZY2JwMWJKOUg2YTBuQ3Rv?=
 =?utf-8?B?dHZSbk52Z2tJdWRiMVZCb0cxTXVQdndLZ3R2SGhmWUhNcWRSOTZFNE1MUkJP?=
 =?utf-8?B?cXRSUWhCOCtvMHhldFpHMWpOMElKYTBvS2ltbGNpLytQbDhlYzBxZz09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b7b9f3a-9f25-4158-06eb-08de7b9c48e0
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 16:20:30.1858
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IYDnve+BPskIn2G60on4cGn41MErSoPKXF01EDNH6ISb2hEATxYmNuMm14l2UGes074C1m+7yLsaA88BgI8fAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9977
X-Rspamd-Queue-Id: CE975224DFD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-223362-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,pengutronix.de,gmail.com,puri.sm,akkea.ca,nxp.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.Li@nxp.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	NEURAL_HAM(-0.00)[-0.978];
	TAGGED_RCPT(0.00)[stable,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,nxp.com:dkim,nxp.com:email,nxp.com:mid]
X-Rspamd-Action: no action


On Sat, 21 Feb 2026 19:15:17 +0100, Sebastian Krzyszkowiak wrote:
> Simple changes to bump the voltages up to their nominal values to ensure
> stable operation across all units.
> 
> 

Applied, thanks!

[1/2] Revert "arm64: dts: imx8mq-librem5: Set the DVS voltages lower"
      commit: b2be99061601c19a56747890262d6adb37ed67cb
[2/2] arm64: dts: imx8mq-librem5: Bump BUCK1 suspend voltage up to 0.85V
      commit: 04d00f57c168153758d2c6a2395d20aadc785e3e

Best regards,
-- 
Frank Li <Frank.Li@nxp.com>


