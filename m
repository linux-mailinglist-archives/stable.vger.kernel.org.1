Return-Path: <stable+bounces-259994-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fp/KHfXpH2pRsQAAu9opvQ
	(envelope-from <stable+bounces-259994-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 03 Jun 2026 10:46:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 19B29635D67
	for <lists+stable@lfdr.de>; Wed, 03 Jun 2026 10:46:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=Ylk9yKwp;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-259994-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-259994-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 662D2304F4FA
	for <lists+stable@lfdr.de>; Wed,  3 Jun 2026 08:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D84E144E05B;
	Wed,  3 Jun 2026 08:41:34 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011033.outbound.protection.outlook.com [52.101.65.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BAAE44D013;
	Wed,  3 Jun 2026 08:41:32 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780476094; cv=fail; b=QAnsVLMbXL1mnea+BH1LyHTlx4pL64KskML9g6Zd/qHvGruZDciPmnyiQXDJKAFj+fAg5jRsmSfr4QIgSSfRQ1OYgqKSka5s+5hGF64C88AybFovRv2wileh/2q9EpZV0COA03oKh5q07WmDU4Ev0p2SZIFP6deJJefBSeOh4m4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780476094; c=relaxed/simple;
	bh=jdpdd/mZrd4UoFAzOrYTod13JK+mjw4LO966eGJsBzs=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=ED/xY20osBhVaX0a1Mon1AkmM5vFo2UDbymxpRzGa4R5CKWkBFHaz941mDu057NiLHeXVc7OSLkLYCkQ1Sbp65W29pmj6KKb648FmocU27fhsCLjM7N1NMAt1+05FFJUxWHauHPLCxCgXqQb0uie0ys+49GiFLUkuDZz25rh9Ws=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=Ylk9yKwp; arc=fail smtp.client-ip=52.101.65.33
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o4jdeNuzx+4ssS8VmunO1ni/ocz5ay7nYbyqze8wiV2Jwf/K+xRUSZneyK1qE3QJVy0BWYRUbAxX/ne7QRNVq6LVL+Fi0iPIF6QWpo1qm1xCsJbUK+CHH2x+kXkgNnKLbX+nRYvIfeSRBDZ71f79rYwizBGxMCCkt2/o4nzxW24euLMxWVPoHuaUyL3s5gxCO+2NCWkfPn92VqFNdLqTJIjogM5FcMLT0QmRVCzetjB+HvHJqLkFqwFoaSZK3boRiM61ZKR/S4kpM+W8qf7R4LtpTE6HMJkSVEwQDkLQaF7QrsRuK5UbzmQdu/9ZQSLkv2ur3LTfokElvXpz2uhpcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qk1Nu+g3Sju6e+mraphLhiuegPw9x0acWj9g6HoOvFE=;
 b=Y0uLsEYFtczSIUUwb0W2k9UgTmlFkjSWT9yxNobKj+WjYM9EFdmrdYDzEB3UbZlqUikUz2Wgr6nxPsDtFmF9oVerZeg9g6/kG6bgx/DjevTRAj6WrF2lGXMAILdPvt9DqgAj0aEC0/UVrhyQbnBRac7FrKe33sWS9wzrZBJOer6zpVyL2H1TXtHubeidtV60peUfgf298V8Qfa5UfjbB7OaOmlS19xSgePOluRkuoQlRSTTyatFb5x/GIfUj8LejB3P+nOfeJ3kkzIqzvvs+eWS5FjbwsaXsQpQt/QvdrBzQLYP4HIAm36OiIQBhXzx7YOJ/bzxqY/u36gfklM5V6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qk1Nu+g3Sju6e+mraphLhiuegPw9x0acWj9g6HoOvFE=;
 b=Ylk9yKwpEacpFokOXozxQXGmihhrlnu2fmFsLgf0AbvILTF1G9savHiAwLhy+4i1ce9keqYhHuQ0Mn/SR6+FAQNs1o4AaV73MIFIRFTrt5pVo+u6iWyRrPkJh6RO6sCAV0dBCuqHhMZ5ZpBfuEh6BDn2cs/c7eGMTI3RUGsudylV4kbjMHVzPAxn0Xy+deSbg3JryQcb2VJKAVnQPWL6M/IpHq2JI0W9VL0VrmJtw5aHn0vhe/G0y+FawEqdWli195g6ieLIS08l761tjIFMTCh+Q8jR1vSNjqdp3nF7LNu3vem83IJxd5IZaQcCMgQYkT83I6XbrikTEKEyM8RlJQ==
Received: from PAXPR04MB9422.eurprd04.prod.outlook.com (2603:10a6:102:2b4::21)
 by GV4PR04MB11902.eurprd04.prod.outlook.com (2603:10a6:150:2e6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 08:41:27 +0000
Received: from PAXPR04MB9422.eurprd04.prod.outlook.com
 ([fe80::54e:28bf:aa85:d25d]) by PAXPR04MB9422.eurprd04.prod.outlook.com
 ([fe80::54e:28bf:aa85:d25d%4]) with mapi id 15.21.0071.015; Wed, 3 Jun 2026
 08:41:27 +0000
From: Xu Yang <xu.yang_2@oss.nxp.com>
Subject: [PATCH v2 0/2] device property: fix child iteration issues with
 secondary fwnodes
Date: Wed, 03 Jun 2026 16:44:30 +0800
Message-Id: <20260603-fixes_fwnode_iteration-v2-0-0ae381f8b7b9@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAG7pH2oC/4WNQQ6DIBBFr2JmXRoYIyld9R7GGNShzqJgwFAb4
 91LvUCX7+e//3dIFJkS3KsdImVOHHwBvFQwztY/SfBUGFCilg02wvFGqXdvHybqeaVo16KIwTq
 N002rWjZQ5CXS2Sxu2xWeOa0hfs6frH7p38mshBRWoZG1G9Ao8/Dbch3DC7rjOL4dvTvFugAAA
 A==
X-Change-ID: 20260525-fixes_fwnode_iteration-baf62d861305
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Daniel Scally <djrscally@gmail.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-acpi@vger.kernel.org, driver-core@lists.linux.dev, 
 linux-kernel@vger.kernel.org, Xu Yang <xu.yang_2@nxp.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780476273; l=1671;
 i=xu.yang_2@nxp.com; s=20250815; h=from:subject:message-id;
 bh=jdpdd/mZrd4UoFAzOrYTod13JK+mjw4LO966eGJsBzs=;
 b=BugBVYIMGTDl2Qmxggc0b/HNyVGjmf9nxYb/3wJMe2Z/Td9MhX/dfdqK8KkxgngAxDr3ZpZz6
 5iDCHdL+TapCY34jS5mFhE/ReNdyT0XFMq4qv4KA7aN1cifSu/bd2E6
X-Developer-Key: i=xu.yang_2@nxp.com; a=ed25519;
 pk=5c2HwftfKxFlMJboUe40+xawMtfnp5F8iEiv5CiKS+4=
X-ClientProxiedBy: SI3PR01CA0005.apcprd01.prod.exchangelabs.com
 (2603:1096:4:296::13) To PAXPR04MB9422.eurprd04.prod.outlook.com
 (2603:10a6:102:2b4::21)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9422:EE_|GV4PR04MB11902:EE_
X-MS-Office365-Filtering-Correlation-Id: 39007991-4c68-4bed-4cb2-08dec14be664
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|366016|19092799006|376014|7416014|6133799003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
 TfD7BVKTygomGA4j5LOLWywfNhn1/nqyB7+wFtUV3TS83l5jNV1aoOyv1dzuc6lP/HuhvlphTquSrgcFvieixZVlO2uJVhDdAPxqy7SMP7YCzFbzSWU65nuLYoqxfTIuyt82tJIybQ6YmfZzbw83bosuXeVhqWUmOAAl0fNG01sjx6/Isu6n6HC0JL1Y5wLYRnYmvMGtnxX5nnKglG25CmFn24pAjxQlz1YjrfHpmf9WBQ0XpfSHd4oWqxcVXqx9lzoO63pmW2pR19RpLxs6zJPzaUXvuBh/v7v+PGgxymHg5/gtWdCRiwEA5n8/1LsUtzyWOjdM+LjiOgo/aDVscS+UUzM8OG8vTzedYnwd3emW9qsYZV0PkCCEIUbx/dg46sEk4m9r1Gju85LvmA33mozph4ZAAoIqwL+J+VDUipcGmqKKx7+ny0MEqBcYY7Vz+PImeSWWBXZTe0Fbs/ztqoCOmy9RznqauqfTzzcfSYVaXw3TtXFY2u8d4+2skmslIkdqCBwHIKv+Lvwr74LBRPH9Lomo5fHkKSKVnj1lVm8UX1mVXAT4oLH6M/ppY6KKDQaVdgP+umqpGo3MxfD+5lG2/9D+jGusK3khHVebwjRBzPdlgibnxwekHc75KxDOnCL7KM1mqWm+pWm9NomKr6DwxkucwC2DVmvzIVPQDc8avYvpnMU2LZ4IEal7RijEW3dzathXdTcUkGMBN76z5A==
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9422.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(7416014)(6133799003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?MmlaT1BCdWNLckxoY3pKMEhkSk53UFNqalZLL1lEMzhySWZjZXFuc3VEeDZV?=
 =?utf-8?B?YXVzcnh0VEFOa2xyeUdIMnVoSnptR2ZZNjdZZ0ZEVjJXcWZJMngwZk5qS2Y0?=
 =?utf-8?B?UFVidll2N0hmdUt4TDkwYTU4Z3VWQ01VekNoNlJEeDNIZmlBRDdiV1NuTzhB?=
 =?utf-8?B?UlFLMHBJSTZMSDBtdlpIcENTZCs1Y1RReEcvL0xaU29jekdVNllmSFZHOFJF?=
 =?utf-8?B?a1JZZXJCWHlNV1FyelY5UjE5TDdtcjRVY2lReStJUnpXRng4VVROZFB6K2NE?=
 =?utf-8?B?QVNlSE5ML2p2bU5IcFdhdlhZVVV5TEpoQ1BhYm9LemVaUW1ycFFGYW1nMW5Z?=
 =?utf-8?B?Y3hoaFJCZVVJNnpHUzY2ZGxoOG9LbkxIQTJqci9IbTlJMVpWU09nYkgySG93?=
 =?utf-8?B?QktJc0hjL3NUV2pIMDM3RW1jS0VsT3pVT3JvWmY1MTZWdGNXSVJXaW9XaXV1?=
 =?utf-8?B?OU1XV2c1cmhBclB1N0FWZHNKY1dJTzNsUzBjSVdpczg3UG1CaW1mRGthME5s?=
 =?utf-8?B?bVA4eHN2UTFRSTNBbDVLTGM1UUlENWViaWtGNkQ0UEYySXFPeThEdEVVRHNt?=
 =?utf-8?B?QlRGWnpJdCs0RHgzeEpSY0VDdFhlV3BDUEEwNC9iN0hJNVByT3VoOVRqV0U3?=
 =?utf-8?B?L1NaanJaWFExRjRQTVJ2M0MyZC9HV2tTWjVWbFkrTFYvMWtEMTAvd3FVZE4z?=
 =?utf-8?B?UnR2QmdMa0hEWWt3cXZNUWJybGYyaC9JaWhIOU9HbWtJSU9YSFhhRW41dUYv?=
 =?utf-8?B?NWpOK09naFFBbUtMam5penFzb3dmclpiVy8yYnNGYjFTellvS2VGcVcyekVP?=
 =?utf-8?B?MllzVGJSd0krS0FqbCs0UFhKTVkwYjEyLzBDV3RIMEFpZ2RENzNmZTdnb1Nm?=
 =?utf-8?B?YUVoRG1DWnFjZm1tQWk3MjV4NmZENThFWk9SaFh6aTNjTjlOQ3lwaGNFZElT?=
 =?utf-8?B?UDFRb0hSUFlNelduZHh0cWZrMDB5cDJTWjZ2K3p2N282UlplYmZJRkhzaEVz?=
 =?utf-8?B?QThxN3RWd1JyeTljQXp0Y04wYWxCOFFmWmxOQ0krTFJRR3lsQ3NjVllhS1Uv?=
 =?utf-8?B?cVZQbTFnc05CWVA5WFh6V2pCbFN5UGswWXJRNnRrNHY2TXhZZHZwRDQrZ0Z4?=
 =?utf-8?B?aCtCbjVCTGo3WFI0STE0N0dXY1RZOHFhVEV0RTUyc1NjOXUzaEsvNWw0b1Jv?=
 =?utf-8?B?V21HNTFJa0Y5cy9WT0d5ZWdxVHNFV2dDYlh2T01kQVFRY3dicWtwc3lyUEcz?=
 =?utf-8?B?U3ZNSkx6Yy9LOVhjZmZWTkQxdm5OVmRKOUZoUmNTbDZlZmllaCtiZnVtV1JF?=
 =?utf-8?B?dlA3ZFFwZUtJOTBWUlVxV1pFR092K280NGZRdS9NYUhDdk8xeXZwOHkzamsw?=
 =?utf-8?B?Wk05dVhwd01ETWE2eXBPczlzRzZYdWtuZTh1cG8waUhsMitxaVoyS08zK3FC?=
 =?utf-8?B?L0VnWi9BN21PWmlEY3hseDRCVkRDUXZhTlNTU2U2cUpxRXl6cUZtMFE0eHo4?=
 =?utf-8?B?RnU1QkYvbis5ZmRRc0JwQ1R5WUxycWwwUDBBVjBvYXJCT2RYMS90YXVxYkFi?=
 =?utf-8?B?elZMdHVMd3hJNDFCSDFOZGNnMDdPMnpLTUttSm5NTFBaTFRrUHBXSnhTOGgw?=
 =?utf-8?B?ZWhRRE9HZDREOFlrZGNPTWt5dzJXTTJXcE51VjRaZDFzNGRBLzdibFR4UnVY?=
 =?utf-8?B?S0FyY3prMjBrVklCaWlENlJjbG9WdUFORXBPOG8rQjl1NnY1WmdTcEhUUGZV?=
 =?utf-8?B?eS94OE9DWmFIM04rNmJPdXdJS0xaWDVBdnNKam9nZU5SbVFSbE0rNUZDakdX?=
 =?utf-8?B?MktPcjNzRWUrOEkycWdQY2JZUXMyMVBjYWhxbG8wZ1dDcnVCVldkMlRtYmVo?=
 =?utf-8?B?M21rSExXcStHM09vVkVrRGZhVXg0ZGtkb2xRYTJFa2pHL3VBV0dxdmVCdFVr?=
 =?utf-8?B?RVVTUGR4OVR2Ky81cXEwOGlyeElDZmw1SWtaVHo1Ti90NXBNOWpaMXUrdVVy?=
 =?utf-8?B?czJzazk0RGttNXl6U3Y4bUt2QzFzSkhUL01uck4yOGthdG8yVUxFUnJRY2xQ?=
 =?utf-8?B?WGpaWVhBOURyV2dZYzB0UlQ1d0ZNYUsvYXFHUmR2NmFVNjJwQmkxMVNoazRV?=
 =?utf-8?B?WDF0MHNIdGpDYnJFZVpUSU53WTdBU0gwNzJtQjVGVzA1K0pTbXIxVEpvM3d0?=
 =?utf-8?B?Z3QwRU5NV2R4ZVJNczNLd3pNTjIyMjN2U1RSbE9EOUNJMEJtajY0QVdQWmZo?=
 =?utf-8?B?RUV1bmJtbUEvVUN6cGZoWG9xSnp6blVKMjFDSm4xOVBPVVFOM2tDTHlacTVX?=
 =?utf-8?B?UTN1QUFCSmtkNSt6eTMzNEpDcnlSUzZLK1owdkNON1JTMTRDTTFHM1pIblJN?=
 =?utf-8?Q?eMRpcv1bjp2eBP+JbD13FRdEYs6Wf1HRcheXJ?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39007991-4c68-4bed-4cb2-08dec14be664
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9422.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 08:41:26.9646
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QoolOU6aBhoV0FX19Opcz4vIKie5NSLN1IXekkYHx0iHUtyTrdWWb/y5Mu8VGPAZP3+oLgJ7VRCJuG7wDMe66C+onUUotcCHNBJGXeBxc+721kCLYNKBa9IF2hqoNZy+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR04MB11902
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.94 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259994-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:andriy.shevchenko@linux.intel.com,m:djrscally@gmail.com,m:heikki.krogerus@linux.intel.com,m:sakari.ailus@linux.intel.com,m:gregkh@linuxfoundation.org,m:rafael@kernel.org,m:dakr@kernel.org,m:mchehab+huawei@kernel.org,m:laurent.pinchart@ideasonboard.com,m:linux-acpi@vger.kernel.org,m:driver-core@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:xu.yang_2@nxp.com,m:stable@vger.kernel.org,m:mchehab@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[linux.intel.com,gmail.com,linuxfoundation.org,kernel.org,ideasonboard.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[xu.yang_2@oss.nxp.com,stable@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xu.yang_2@oss.nxp.com,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable,huawei];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nxp.com:mid,nxp.com:email,NXP1.onmicrosoft.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 19B29635D67

This series fixes two issues in the fwnode child iteration logic when
a secondary fwnode is present.

The first patch addresses a refcount imbalance in
software_node_get_next_child(). When a software node is used as a
secondary fwnode, the iteration code may incorrectly decrement the
refcount of child nodes that do not belong to the software node
hierarchy. This results in refcount underflow and possible use-after-free.

The second patch fixes an infinite loop in
fwnode_for_each_child_node(), caused by improper handling of iteration
state across primary and secondary fwnodes. When iterating over children
from both primary and secondary fwnodes, the code may incorrectly
resume iteration from the primary fwnode even when the current child
belongs to the secondary, leading to repeated traversal and a loop.

Both issues are triggered when mixing different fwnode types through the
secondary mechanism, and stem from incorrect assumptions about ownership
and traversal context of child nodes.

---
Changes in v2:
- use __free() to cleanup parent fwnode
- Link to v1: https://lore.kernel.org/r/20260525-fixes_fwnode_iteration-v1-0-a12903fb2919@nxp.com

---
Xu Yang (2):
      software node: fix refcount leak in software_node_get_next_child()
      device property: fix infinite loop in fwnode_for_each_child_node()

 drivers/base/property.c | 18 +++++++++++++++---
 drivers/base/swnode.c   | 14 +++++++-------
 2 files changed, 22 insertions(+), 10 deletions(-)
---
base-commit: b7bee4ca5688e30ca50fbc87b1b8f7eed7006c17
change-id: 20260525-fixes_fwnode_iteration-baf62d861305

Best regards,
--  
Xu Yang <xu.yang_2@nxp.com>


