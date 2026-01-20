Return-Path: <stable+bounces-210538-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gL35DsVIcGnXXAAAu9opvQ
	(envelope-from <stable+bounces-210538-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 04:32:21 +0100
X-Original-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E4065506E0
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 04:32:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B3DF668469A
	for <lists+stable@lfdr.de>; Tue, 20 Jan 2026 13:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10C3441B37A;
	Tue, 20 Jan 2026 13:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="YwuJvVR/"
X-Original-To: stable@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011014.outbound.protection.outlook.com [40.93.194.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7336C3491F6;
	Tue, 20 Jan 2026 13:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768914672; cv=fail; b=bX03w6EZ/nYJOvBFldgKc7/6pb/xBYudP5ORn8AXKQ297eY26gbBfsTbnjOioC2TYTVbzAt9zbub4NzxGqTkiwFTkPibqdZOoITECb9L1SoBGiYgME7FJE3t7Xomp2y2/rHE7mubJpWk4DZZbCgfoc/FidkQwb+Z0DJTTxxpwrk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768914672; c=relaxed/simple;
	bh=84/DJt/aFZ90cfcSQaLANoeOkeV0F9t2x2fqdW+Km8Q=;
	h=Message-ID:Subject:From:To:CC:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IR3Q8zbn+WB0Jtv7WUP/ileFcgzujLSspn1SWzQyItmFaelEIK1Vruf2aOOFNPbdnh7n2G9I1gHLxt6wequIzYZMydgfL5bFBzOaz0jswh0TIeVjfp/KUCmroDdBKePvxe3VRq5W5p+wH3AJesu8Fqx11xXTbDNUlSkcCdF/fc0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=YwuJvVR/; arc=fail smtp.client-ip=40.93.194.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kpIMl7nzI9aVC/8DiMZql42Eo4zz6hx/D7+H9/e6oel1Ey8UgY86NbPSeMr5f7dZrAPG4/yKrQrfyQL1mcJuurb2oCN2mCrTBrZ7lY0WGlHVYZEphyCEF7cuhK3fEcMIk0GhC/N7gPCDQyZVQLMNg2LFfa8FGbhVGQp17AR5L13Gkus55AVyswySeV4+ph3o0TJNGGom00bp0nfcgBx25vwS1ZrBTiy0zQMb2Lb+xsHlT8O+d0yfzu+ejTXRkWlg0wH+4fONftqLemtAy6o/d2rGYFjHJid/VlyP7emCLqRgmAGqMyDpzJUktOF5QCvO6eYpNiTCWtj8czAVXsAfFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=84/DJt/aFZ90cfcSQaLANoeOkeV0F9t2x2fqdW+Km8Q=;
 b=p2DTvXJ8us0JHV1BgzBN7ZOrVZO+d/0H/z+k/qhuRKStO8VY6v/7FzpHGi0qygvdDTcMfNoKseMQn29FHLJo1R53tU31+/HOzyNSuPr2OnKozdtqYW7nF93SMchIHfm+l88VaYpsX5zchAKBO/DQD8LgQn/m03Poltn2pCRD5jknczxxDmvopLEv7udntZllmzOmefuFzqWD/5SOlya/VkZ8oXTc1iZ0QDHZtm4fnNiiUOker6V5M3YdxLz64m3pc5U5uwAZ9zwDc6lYFS10OA4PgvdSQakIMIEGeMj/zaRpMErMqJYppPnTuxVJchyPn5QZdb98GQcp8ZGiOT+EXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=84/DJt/aFZ90cfcSQaLANoeOkeV0F9t2x2fqdW+Km8Q=;
 b=YwuJvVR/HOd/1aPdjsYrNznLmP/Y8GRpidMpvKzBfRq9Lo91aUD4RZKhoULrAF8I8WOjuXLJx0e54W/O2mC41Ewu2w8vBrJVeLzEA1iDPfmG5x/T1M87RDWsFiCj/L9izlWMQEK3AVx50usW2L23u0RcD4S73uF4Oh85i3oaGnY=
Received: from BY5PR04CA0013.namprd04.prod.outlook.com (2603:10b6:a03:1d0::23)
 by PH0PR10MB4743.namprd10.prod.outlook.com (2603:10b6:510:3e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Tue, 20 Jan
 2026 13:11:08 +0000
Received: from CO1PEPF000042AC.namprd03.prod.outlook.com
 (2603:10b6:a03:1d0:cafe::b7) by BY5PR04CA0013.outlook.office365.com
 (2603:10b6:a03:1d0::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.9 via Frontend Transport; Tue,
 20 Jan 2026 13:11:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 CO1PEPF000042AC.mail.protection.outlook.com (10.167.243.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Tue, 20 Jan 2026 13:11:05 +0000
Received: from DFLE210.ent.ti.com (10.64.6.68) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 20 Jan
 2026 07:11:01 -0600
Received: from DFLE205.ent.ti.com (10.64.6.63) by DFLE210.ent.ti.com
 (10.64.6.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 20 Jan
 2026 07:11:01 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 20 Jan 2026 07:11:01 -0600
Received: from [10.24.73.74] (uda0492258.dhcp.ti.com [10.24.73.74])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 60KDAuKu1108751;
	Tue, 20 Jan 2026 07:10:57 -0600
Message-ID: <d918d66a4fb7ae603eb1b67533fc0ae9cbf062dd.camel@ti.com>
Subject: Re: [PATCH] arm64: dts: ti: k3-am62d2-evm: Fix missing RX delay for
 DP83867 PHY
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Hari Prasath <gehariprasath@ti.com>, <nm@ti.com>, <vigneshr@ti.com>,
	<kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <bb@ti.com>, <afd@ti.com>, <p-bhagat@ti.com>
CC: <stable@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<srk@ti.com>, <s-vadapalli@ti.com>
Date: Tue, 20 Jan 2026 18:42:16 +0530
In-Reply-To: <6650770b-2e9c-4f9a-8310-1f335ffa69f8@ti.com>
References: <20260120061335.1497832-1-s-vadapalli@ti.com>
	 <6650770b-2e9c-4f9a-8310-1f335ffa69f8@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AC:EE_|PH0PR10MB4743:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a9c1dd0-5e10-4a29-486e-08de58255eb3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bUNFQm1aVEtOUVdXSUc2WDl1SEM4VWNFTS9sSGh5Vi8veXA2d0hKNWlMZksy?=
 =?utf-8?B?WUw3UVlTNnplVFh6NjdGZkY1VGdMMm13bUR5THM2NVQwbE82ejc2ZzU4eTln?=
 =?utf-8?B?b0VzUkhYdFVGQTE2Zkw3NDRYMks4VDBIeWtjSmYwV3BMK3FhaUFYb1lhUkNB?=
 =?utf-8?B?WUhvYk80SC8vVUtISEdOeDQ3Tzg4bkpISWNyd1piTXlscVdqZXFHdXZzbFdl?=
 =?utf-8?B?emdHdDRobjhGQllCZElMcHhZMkFDc1dkTDBCK1FDZ3A1Ti8ydUVIaW5qMWo2?=
 =?utf-8?B?U0dTR1BvdkZHZ0xaOXVzaERXSFo2L2ZXcDlwZ3pqQ1lCRkZBR0N5Z1c2R0hC?=
 =?utf-8?B?Sng0M252SWgvaENGM1dROFdmRWMwMENPUkFWRzluOU1RZXl1N2ZLcHZnai9w?=
 =?utf-8?B?emJxTFg3dEFacUgxRWhMVEhWaXp0Nko3NGhBWGFBZ3VGZ0JRa1lmM2U0WDZs?=
 =?utf-8?B?c01ISGpKejNMQmJMOGRyVGNCMjFMN2cxL0x5VDNZUlNUTGYzbzluNWp5QXZB?=
 =?utf-8?B?cVIzY01NNmgveGJ3bW1DUlJQUWFoaFNUNUxWWERaNVhxbFRFUDh2aElxYVg4?=
 =?utf-8?B?bHhZR211SVh1Ky9Pa01BVkFNV1ZzWS9kanFLa0tnSGZpaStXQ09VZXd0YWg4?=
 =?utf-8?B?Q0RBVWtVRVM3eW1ZZGxNcWxmOUo3N0NhaDNvZkNjTTMxSUdzTis4bTVzM1hN?=
 =?utf-8?B?Z2lKamRnM1c3UmZabTEyVWdEVHdmWVJaaDRndk9FTUtDODJpSEJVd3dqR3la?=
 =?utf-8?B?ZWRqUkxoYVg4SFJuMjdaMXI3U2sxYXcvQnFIRnFyZ1QrSTJRZFhFU2JFOGYz?=
 =?utf-8?B?emNQQ3BYQW5McW1odk41ZWNxYU5Nei9KMm9pZm4wWHJmbDJwbWJUbVRNSHVT?=
 =?utf-8?B?MmlkOGVHMUZiaGZvRWdLOFFHby91b2lSeWlGQy9ISEJqUmJVdWx4M3NaaHVZ?=
 =?utf-8?B?bkVBbGF1RGlzMlFrbVhWSmVCUllJdlNXUWFsRHlEN0R1L2N0TUI1UEpJL3dO?=
 =?utf-8?B?ZzUzb1dzSjJFNHZwRDRSVHpMdk1LKzlnUTZGU3FYbHJpTUJKNjhHY3Naa0RH?=
 =?utf-8?B?TytmR01CY2VLZFJOZGltUlJsQ2Z3cmZJMm1KSnlsbW54QkQzNVJheWlNNEIx?=
 =?utf-8?B?dythcnNrNGk2OE5zR2xqaEZ4QjE2Q0hoVUFXKzRVODBubTBQanZRUWVnT3JT?=
 =?utf-8?B?UG1FMmd1Smo0bUxjY3gxbHFwR1Y0TmZaWVlaTEpNTUVIUERHRzNDY3BwODZW?=
 =?utf-8?B?VVF5RXlFSUlLYXgvcEY0cU03UHA5NCtIM0k5U1ZOZERURnRNbFFGbFk1V291?=
 =?utf-8?B?YndpOGhMTWkyWU9OTDVrekg2MGpvOS9ONVdWL0Y1aysxYWgzNlRXeWtBbENB?=
 =?utf-8?B?Zmp3WElJVktzamNFT1RoOEFtejRXSEYySzIvSUh0YWIwenQ0UlpRU0RPOHR0?=
 =?utf-8?B?OSszVDlTT1MyS1NyVU8wc0ZiRVdadnM0NllSbHJlQzY2WXI5WjFuemQ2TElr?=
 =?utf-8?B?Ym9WYS9rSXh6R2REaW5qbDRRLzh2YWVHQVppZVVocHhZOVF1T2JJQncxS2Fa?=
 =?utf-8?B?R2hVeHdHWExDZndSaG01bnJ4cnhmaHkxNHovQ3BDcm1Tb0pDUklMMzYxMUEx?=
 =?utf-8?B?VXFPakdCRzdvTzRqMEZRemZyU0cwVlNNNDVPaDdXcjhvSDVrYVdZV3V1UE44?=
 =?utf-8?B?c2lUWWxqUEJqQ3F6T0E2R3NPQ0dqQU16U0wzS2RjbDJXTFYvSkp3WDVjdjVM?=
 =?utf-8?B?bUpFSm1pTWNqZEk2WkNUU200bmdTUjNiVkVBU1JnTFV1VU83aFJML01QcUE4?=
 =?utf-8?B?djdhL3NySklRUUVGLzBLS1E5TzBmTHBGNGMyWGRDTG5oUWlvcDRsbHQwUmF1?=
 =?utf-8?B?cENORGhvTHNmVFRldisvL0tGVnJPWndkbUcrd3I5LzNweTZuY3BlZWxpSTU2?=
 =?utf-8?B?QzkxdjFwVC9nMXNobStLSHVmRU14OTVkMEJsemozQnhOckdQSjEvRnNNR2tH?=
 =?utf-8?B?bitDMDhUbUZJcElOcWNDMUNPM09IZlpTSjZaWmtLV1pNeDQyS2drOVJpNXc2?=
 =?utf-8?B?V1I2YzIxZW4vUWxuVHpsWXd6Z1NoYndmcmhHbWpzWlhZeEtuUUdtbWg5emRR?=
 =?utf-8?B?TTdLby8rMkFnRUNJNVhIV0ZpcTdPQmFvNjNuNDRBQUxOakVkb3RzblpYdEpr?=
 =?utf-8?B?cW9SRFEwTFpjaDRib0JhNm0zUW9CWHhUY0YzcUQ2M0IvQjdRR3Y3MGlJOTA3?=
 =?utf-8?Q?yd+Ti2zWLDK1oGC5zyix41mqhiM3fynxPpVf+Cnjaw=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 13:11:05.7734
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a9c1dd0-5e10-4a29-486e-08de58255eb3
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042AC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4743
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[ti.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	DMARC_POLICY_ALLOW(0.00)[ti.com,quarantine];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-210538-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[ti.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,proofpoint.com:url,ti.com:email,ti.com:dkim,ti.com:mid];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[s-vadapalli@ti.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[stable,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	REDIRECTOR_URL(0.00)[proofpoint.com];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: E4065506E0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 2026-01-20 at 18:33 +0530, Hari Prasath wrote:
> On 20/01/26 11:43 am, Siddharth Vadapalli wrote:
> > MAC Ports 1 and 2 of the CPSW3G Ethernet Switch in the AM62D2 SoC are=
=20
> > both connected to different instances of the DP83867 Ethernet PHY on th=
e=20
> > AM62D2 EVM, with the 'phy-mode' set to 'rgmii-id'. The DP83867 Ethernet=
=20
> > PHY has to add a 2 nanosecond
> > ZjQcmQRYFpfptBannerStart
> > This message was sent from outside of Texas Instruments.
> > Do not click links or open attachments unless you recognize the source=
=20
> > of this email and know the content is safe.
> > Report=C2=A0Suspicious
> > <https://us-phishalarm-ewt.proofpoint.com/EWT/v1/G3vK!=20
> > uRdqXRfPtm07agZk_PPjvDYD9oe_mpoIkkjINUyRhGSu--0mQdy1pi4MPng-=20
> > ix3RK2L1V3y4DrnTdaCm8zj7QGx0QX2i$>
> > ZjQcmQRYFpfptBannerEnd
> >=20
> > MAC Ports 1 and 2 of the CPSW3G Ethernet Switch in the AM62D2 SoC are b=
oth
> > connected to different instances of the DP83867 Ethernet PHY on the AM6=
2D2
> > EVM, with the 'phy-mode' set to 'rgmii-id'. The DP83867 Ethernet PHY ha=
s to
> > add a 2 nanosecond delay on receive (from wire) based on the EVM design=
.
> >=20
> > Since the device driver for the DP83867 Ethernet PHY coincidentally ass=
umes
> > that the a 2 nanosecond receive delay has to be added in the absence of=
 the
>=20
> 'the' can be removed here.Verified this claim on default value in the=20
> driver without this DT property.

Thank you for pointing this out. While rephrasing the sentence, I forgot to
remove 'the'.

>=20
> Reviewed-by: Hari Prasath Gujulan Elango <gehariprasath@ti.com>

Thank you for reviewing the patch. I will fix the commit message and
include your tag in the v2 patch.

Regards,
Siddharth.

