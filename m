Return-Path: <stable+bounces-230685-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qMtlCNewxmmiNgUAu9opvQ
	(envelope-from <stable+bounces-230685-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 17:31:19 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FC67347793
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 17:31:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E1975310EB32
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 16:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BDC73612FE;
	Fri, 27 Mar 2026 16:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="clsEIBUb"
X-Original-To: stable@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013040.outbound.protection.outlook.com [52.101.83.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691A635F5ED;
	Fri, 27 Mar 2026 16:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774628574; cv=fail; b=o2hjZBtwjIU+aq1yAgLi5C/hIgC+dB1q0oR1GEaYSo8o/sebSD9K/m0FiOSkOay8vv47zvoTdqC0QOQXpfhsyCx8fR5OVwenK87V/bPbPuG5PnlTGGx8BQi8UvnREnfBjUTspNhy4CoHDn/yud8GA11VGstLeIu+qA8gsIr1t+U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774628574; c=relaxed/simple;
	bh=LwgG8TU7vsXVwsc3teABNDYGCRomwC53j0Gf0s2JTYQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GmB78T/MmOXpY0spb3FV+LjVs+OBoJHt6b2XAgEWIiO5qdQuAU1YMmK6fT9OcbSq5NADJ7zYBp9oGmLO8gj+nRwWz2P4nFqSPouu9OfK3M3A2GaJ/bDhRffMrcIemudgjwvGaVk0MCgYN3JOiProqzO0ynLJZr2EQKur3wIbK9Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=clsEIBUb; arc=fail smtp.client-ip=52.101.83.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eii1W1KlUrmns2LtdBo3H41QlVYcm4rHgROvy7jdAPVo0jsrN/h6GPsTNnTSeod22peUALBmpV5EFycrYHuDfy9f9eL0fUU1yJA2zc05r7Th12o2ohHB+XcnXhHvfJuWuizOrEaZfglAxRe7kPgewctf6igC9gPEidAIywWoVkznI3r99clBLL8upz+xzH7rmIMzc/bATaKlq+EZj29HSPG/+a6vGLGum4CjC/AX0Mx/81b4nAQcpxoXtTv0gReLqe6ZKn+HYpUCkYsqKWSCC6b/GPQHOd3afGr1n+XzwEVcJOizSoKyq1sGyAUQqEMs5smbdMOXGlLLAvPEZA0y+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y7Nob2cvqQMgVv8m0k5at0xHQgEtfA40XCp8AXq2fMY=;
 b=xluzkkW8R+WJj1TYMz3+K1zCcVl2YkEovJ6LCiFbukUB6QPnJSmLXqQdc/MUo5Dnf227VXthYEFXbR+0HGgE1xproeHqvqMHuxQx3x+EYyktzo259uAWvkRlKlylme1+amyb1CYJwnSgEf7VNNqVn2saVnlmZMm2lV0holKttcO2ZxYEjps+f0RdwjT0zsxxQfWuMZ97lG1GiEQ27Z82ArLYeFW2j4yJ8UzYQ52mMnCzMuCB7icqMIUt9Ncmcf6/oCqJEwLNKguJrPhVwytHl7w4gAH6OZB1UAiaPKNKCFN7wEhti1VRciCqL87ljES9T4N5VxdzWn+8QYDh/Pxh2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y7Nob2cvqQMgVv8m0k5at0xHQgEtfA40XCp8AXq2fMY=;
 b=clsEIBUb0e2NC0nAduvci/eVL3jCJGWoqZB0cYQXVjXzy3snA+dF4aoRyYS4xVGcm1p7J7YhUv/yvSTKPasWsB834LZVvTyYENG6HwHV+W1zSUKVx+xKWrYjxUCEpq9nDKDH6nJZksxLe/1UojbB4GEhE5xSIHxDq7+dMtGalbgP5HMKyrZmy+yaFXHyz+XT563k2Si/gAuZ0ZaktBItwk3VRgQnr1bsZiUvrseUIOdXJszAlasaUTtNV1reQ/3QHcshY4O5csf/YWM8HVqKhoGA9+QuY4gQvVVIvMu/zWn7Ev2hvadpHGogML/alP2OGSVI27oxLRVjhuqs7Tgs6A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by DBAPR04MB7367.eurprd04.prod.outlook.com (2603:10a6:10:1aa::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.23; Fri, 27 Mar
 2026 16:22:49 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9745.023; Fri, 27 Mar 2026
 16:22:49 +0000
Date: Fri, 27 Mar 2026 12:22:42 -0400
From: Frank Li <Frank.li@nxp.com>
To: Hongxing Zhu <hongxing.zhu@nxp.com>
Cc: "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"kwilczynski@kernel.org" <kwilczynski@kernel.org>,
	"mani@kernel.org" <mani@kernel.org>,
	"robh@kernel.org" <robh@kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>,
	"festevam@gmail.com" <festevam@gmail.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v2] PCI: imx6: Don't remove MSI capability For
 i.MX7D/i.MX8M
Message-ID: <acau0qZNUqEQmGKS@lizhi-Precision-Tower-5810>
References: <20260319091823.446030-1-hongxing.zhu@nxp.com>
 <abwFVpxrriV7Bt2L@lizhi-Precision-Tower-5810>
 <AS8PR04MB883306406390FCB4106C3A978C57A@AS8PR04MB8833.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AS8PR04MB883306406390FCB4106C3A978C57A@AS8PR04MB8833.eurprd04.prod.outlook.com>
X-ClientProxiedBy: SA0PR11CA0071.namprd11.prod.outlook.com
 (2603:10b6:806:d2::16) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|DBAPR04MB7367:EE_
X-MS-Office365-Filtering-Correlation-Id: a48d8f03-20c5-4653-5b89-08de8c1d1638
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|52116014|366016|376014|7416014|1800799024|38350700014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	hKcF9hXmrjJkiT05o8hyXl7NFpWkG6Lm0hkUsKhCPJMnuIrWMRbGDUG9GwoAYGW9/SjgePqEb3pwrtLDM+bheQP/iquUD+uJggMfS1W0t31pGkwname+IpFu7hC745s9Ax68A7z37eVCsP6tp+3UOgtpxL0xWEAu7D2sFHaPvP6mQw+kyjTWPhdifaV89CL4AmnfUZDCQ0NHKARm3IiYcgwfKtk99fnoNirMU49UY7DmC3/0KK5yc3emzBJQfJwEZWKqVnNMx0/KvpYrEwzQepO+gK+D1Fz4Rw4f75HBekzvwIqt/FH0oUHkU5ZVwkpx6wdntRVim6KVXWFAD/RYKHBHwxLtc5f9uLCQvdH3+KQNCA72bNs6XhhFtZIUYB/1ftwGkdcS+fu+xGiJqcK10v3w4G1PcCvLy61G1Cmuwnf+iVwLkY87Z0JKrLIfeiXr4yxY5+Hef2s3az0P3dLuK+qXN2wBqtzquQP2UyUHunayMCqK7zEIvfvkrOOu/cKGGdNQkUDy6MVys3VCAyOf4I6Dc3LiwFrejSBUW4W0IzpEAwDLYQo7QgfkFgLO1XIAJzUANZfBZHOy10AUvR1eJYVn/L8+TaieqAg6JZR7aVO7Bg5hSPM7Ztp6y3qiZMltDgivuG+llP644hBDzOKFThBmyX67cofy6wAtkcuNGbFDiub/QGoANvemSzoO5tWKorGact392RZCsqc2ADCoKGjIzz4SDgKSr2qSY1izAnwSDLjYEURemv0BXQiQNrpRACMeisvhJYBP6Mjf+6608HN10lqRiBXMW9rJziULQCc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(52116014)(366016)(376014)(7416014)(1800799024)(38350700014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c3RkbXp6SGp2VllqSmJmQmZ3UUh5c0lUVkUvbGgrdGtBcnlIQ3hHS25jaGlk?=
 =?utf-8?B?Ulo4SUJzTlhrL3lkbzFLZmVOTGNVckRYTktYS0ZJYUtxemFsbERXUERHYjhy?=
 =?utf-8?B?RXFraWdMSGdyR1gxT1VKaE1FUU8xUnV5Y3dsZzNsOU9jR1cxSWxTL1pJSjY3?=
 =?utf-8?B?emN5UktveVJHd3dRczdXMTc1eHE5d0c3cEdvZWduMnFHZ1YyYVFrcTdIdVJB?=
 =?utf-8?B?U0ZWbW1oaktwMmpFakU4SHBwTWtxZEcydnNsVTFvL2ZjUzlPNkVhWGw0QUt4?=
 =?utf-8?B?Z1U0Wk53cndPMFh2U1JNd0daZDN5dVA3dHVkbUd2a1JmdTlma2FlVDNBb2xq?=
 =?utf-8?B?MHF0b2FjazJQZ1o0S2JuUlZrMGw0clF2QUsxbjhHU0MrMFdwRFVDKzlJMWd5?=
 =?utf-8?B?dGZPUjlvRlhtWk1maWtuTyt3SjBzV0VXYmVXWDZpTndqU2FEc1NMTXJrOFZY?=
 =?utf-8?B?dlRlaUswZHJwREtoS3NxUWhPVGVQRzhhZEg5RExRYXRuMkx1eVZQdUx6ZEU0?=
 =?utf-8?B?Y2tXcnFtK1RZeVdIeWhlYmxPUUhtY2M3TXl4UDRhVlIxQ0hTekJZdFhVRlc0?=
 =?utf-8?B?dCszcDg5dS9UM0V4K0NCbTlLRG9wZ2VUM3hhd2VuTjFHNTNSQlVkSUNGbHNk?=
 =?utf-8?B?Snh6c1R5K3kyeGc3bUI3R1lvT1RKZDg1ZEhGbXg5emZna0JwL0cyWGpEWkFn?=
 =?utf-8?B?SWpJSWhZNkM3ZnNidnA1bHNJd2YyeUhZeXJYY2FnejJJazBNZjVNYmJJOXhQ?=
 =?utf-8?B?UkpRS2IvakRkU2swUkRNekovVUN3Tm80V1RGaEhzRmFlRCtBNURVVWg4eElR?=
 =?utf-8?B?bXpkVGxoRCs0a0NZeGRkSC9NZ1BaYVBkcFVLMGdscS92VlJoaWM1ak94dGhO?=
 =?utf-8?B?RDlQenVLeStrM3dvUlpjQ09TK1dsYitvZksxT092NWtySWZIb3UzUi9oVnRG?=
 =?utf-8?B?L3lVc2dtVGx1NWdvem5ObFg2cTVlODM2R0FrNmFOT3FZZHBxQjlOZ2s3N09U?=
 =?utf-8?B?YVFYSDRHSnVRMG9iZmxjYXBzZ2xkdkxTYmpyL3Z4a0ZrTjJ4WnRhd1kyTzFS?=
 =?utf-8?B?QUF5ZDRDRWJZbmw2bnpOa29TMHdkSXRFZStrRFFYNEVkeWlxeDZ5VVdsNFJT?=
 =?utf-8?B?VDFBQ21MUTlHUG1JODVzZzdSV0o2aVR4cGM1TllJZFRld0xwU3Q5WEdvc3Vp?=
 =?utf-8?B?dzdodXdUSWpXYUFheGV2cXM5SUlkZG96TVlwZTNpZk9sR1B6UGhBViswTDVw?=
 =?utf-8?B?VzBkU0pYaVQwWlJCYW9UOE9RRmUxVGt0dkwzb2ZHN2JFK3RrNW01YUtrbEJ6?=
 =?utf-8?B?dUYwcVRucFB6U1RER2Niei9mbHFYYlBNQlh3a3RXYVpJYVh4aVdyQWRHMkhU?=
 =?utf-8?B?VWRqK1NyVGRZSHAxemJKU0JYYmtvenp3YUowYmp2VFlJeHEvblpTaDRYQ29T?=
 =?utf-8?B?K1RrZExYWURXcFk1SlVhbUwvYnpsbTJMQ1hjWFJzQnhmcFJHbDk0WENPWjZw?=
 =?utf-8?B?Y2hkdmR2aXhDTXVYVFY5YWFzaEJYYUhEbXN4WlZZR3dQbVR4ekhFTy9yWmND?=
 =?utf-8?B?SWd0eVgxRGNGbmtQeEdQTVlIMFBLVlF6M3FEeUE5REorNDE4KytMUUhuQlNh?=
 =?utf-8?B?dHp2K0UxVm02SkxnaVFjbzdTRTdpditOcWY2OEx4TjBiUE5QUW1NcUoxT09k?=
 =?utf-8?B?dVp6VnVmeTNuWFpDbGI0Q1kxQThPTFZmMFJKSjU4YTNUT0pXVXAydVBuRmpZ?=
 =?utf-8?B?VlV5MmhmdVRWMHZhWkVGNUZSWWpsdjhVaUZhZ0VoZlEvZFJtWDZhL2w0bHoz?=
 =?utf-8?B?VmhiN1J5WG1UWXVpOVhuajlTTW4rQU5vbWE3UmlQV09hY09NbG5CTE5Cd29J?=
 =?utf-8?B?S241UXYrU0xUOHhYN0VPVUczR1R5M3FmY2NqUW5MMkJ0SXl5ZTIyckVQUHNY?=
 =?utf-8?B?MUFjMldwc1BPVFpGeTV2VjJ1RjAxNnN3NGdPZWVjRCtZOEZNbHpFN1RxZmNv?=
 =?utf-8?B?Y3lQU1JUWkVkYjBkekx2T3E2TU1BTHcrZXNhY0QvWU9XN0QvN2FMa1hrRjAx?=
 =?utf-8?B?bmdjbXlTYkRCQjFBVm1EaUtzdDdNTVJ2Qll1TkVUNGx1UEFteVhQMmJqZExp?=
 =?utf-8?B?dGlabEJPMGNaUUlsdnF4TzNycVE2d01DL0ErZzlpMUZqZzZhS1V5eGZ1OWFU?=
 =?utf-8?B?YjhUR2hTMGhrazJ5NEdtcFNzTzV0MWV4NmRrU1R1SHN4WXMxQkphRDZqSS9I?=
 =?utf-8?B?ZVFJYmlDdmZQRWc0ZEQ5NlkzTXZxbHVqaGJORVBUNkRpOFZuWHA3ZGZiMCtl?=
 =?utf-8?Q?QMs/ua5+wFvih+6jft?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a48d8f03-20c5-4653-5b89-08de8c1d1638
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2026 16:22:48.9553
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IlUI5orc2QLtoq5s0l0LKTgz9lrme/rJ0cr40HirU7EFEhMsS0/NkZVNDl6HeENsMms+ZjlJYKa074RnOR3Csg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7367
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-230685-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[pengutronix.de,kernel.org,google.com,gmail.com,vger.kernel.org,lists.infradead.org,lists.linux.dev];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nxp.com:dkim,nxp.com:email,infradead.org:email,linux.dev:email,pengutronix.de:email]
X-Rspamd-Queue-Id: 9FC67347793
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 27, 2026 at 08:12:29AM +0000, Hongxing Zhu wrote:
> > -----Original Message-----
> > From: Frank Li <frank.li@nxp.com>
> > Sent: 2026年3月19日 22:17
> > To: Hongxing Zhu <hongxing.zhu@nxp.com>
> > Cc: l.stach@pengutronix.de; lpieralisi@kernel.org; kwilczynski@kernel.org;
> > mani@kernel.org; robh@kernel.org; bhelgaas@google.com;
> > s.hauer@pengutronix.de; kernel@pengutronix.de; festevam@gmail.com;
> > linux-pci@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> > imx@lists.linux.dev; linux-kernel@vger.kernel.org; stable@vger.kernel.org
> > Subject: Re: [PATCH v2] PCI: imx6: Don't remove MSI capability For
> > i.MX7D/i.MX8M
> >
> > On Thu, Mar 19, 2026 at 05:18:23PM +0800, Richard Zhu wrote:
> > > The MSI trigger mechanism for endpoint devices connected to i.MX7D,
> > > i.MX8MM, and i.MX8MQ PCIe root complex ports depends on the MSI
> > > capability register settings in the root complex. Removing the MSI
> > > capability breaks MSI functionality for these endpoints.
> > >
> > > Preserve the MSI capability for i.MX7D/i.MX8M PCIe root complex to
> > > maintain MSI functionality.
> > >
> > > Cc: stable@vger.kernel.org
> > > Fixes: f5cd8a929c825 ("PCI: dwc: Remove MSI/MSIX capability for Root
> > > Port if iMSI-RX is used as MSI controller")
> >
> > I think it'd better add another varible to check in f5cd8a929c825 if
> > (pp->has_msi_ctrl && !pp->xxx_broken) or direct use IP version, which
> > already auto detected.
> >
> > Previous patch have not consider this old version controller.
> Hi Frank:
> From what I've observed, this behavior seems tied to the specific controller
> design. For example, neither the i.MX6Q nor the i.MX6SX exhibit this issue.

Yes, should rename has_msi_ctrl -> disable_msi_ctrl. Set it according to
difference condition, such as has_msi_ctrl or skip it for problem platform
such as i.MX8MM and i.MX8MQ.

Disable it and overwrite later will cause confuse.

>
> The intention of commit f5cd8a929c825 is to remove the MSI capability from the
> Root Complex (RC). From the author's perspective, this change should not
> affect the  Endpoint's (EP) MSI functionality.

Yes, your patch fix  RC  mode?

Frank
>
> I'm not sure do this check (pp->has_msi_ctrl && !pp->msi_broken) is proper or not.
> Best Regards
> Richard Zhu
> > >

