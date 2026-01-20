Return-Path: <stable+bounces-210512-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6PIQD5BIcGnXXAAAu9opvQ
	(envelope-from <stable+bounces-210512-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 04:31:28 +0100
X-Original-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D9905506AC
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 04:31:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B45C966C29A
	for <lists+stable@lfdr.de>; Tue, 20 Jan 2026 13:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B586423150;
	Tue, 20 Jan 2026 13:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="sBbt3Ui3"
X-Original-To: stable@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010042.outbound.protection.outlook.com [40.93.198.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 066F519F40A;
	Tue, 20 Jan 2026 13:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768914204; cv=fail; b=oAi+1xnpgSfG0l+Bm2XuOW4eOqm85N0MpJvMBrUXdOcHciV7bP8kwOZEAmOZxno6pYLIYmEbLKKaDkoCySxeXmpqoPM3PhPzbsoYUq7LDFVnyMHOSwz1PZ5wuAiiWT/EqLqJ34zuGiWC54fykHbNOf+6/gUaAiLalfuBFE28eHY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768914204; c=relaxed/simple;
	bh=eRtGSWSpoMaYGpWY2OnANL/HCdZQ2Khu3C5B5re/Svk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Z+fjZ1NyBsA9FzQ4hGQejQQBwNxQ3EDgLfelRLjcB1F4krAc9xgCuiBC7nORHRzjnSntdTj5MP43nvPm83diRpZKudnvLG5c24Cke2ATz9Znvqn/5+dTcZ2bP/xTBeTKz4ChT/goWVAPkZcAQ/6x8SZNOMfQX0w49bSptJUtca0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=sBbt3Ui3; arc=fail smtp.client-ip=40.93.198.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XeeBqA4jp9IAue0RkqgY51cBavX4rcX0gn90uN3wWYq71a/VK1YpS3l0nVP5yW53gd7yvU9i0pkSXjlAgp226sWsoH3Ljf+V4cXlKXPy6uI8DbCpy3x/HJsEhriY86rPuPhZorxuqdE1h1pkJ0Ywd7P/wvWlZE43NJcWmHs1vMsDEr+ER6AOKxfjZ+jNQjme5HN6GOBXl0u5wLzMq8nOS3FmewIzHoWl+7Cnjzt6R9mkRFh2MtNRLkJn/+1uJzp7WUPXI1BHHdlJDxd68H6kxjMmLLi/zDPA7yjkAzP4Pduk5K1tWC+km/BOGs6Nz13eUrAcYHoXOZQolpQf5gXhuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AyEJsJH21bCq1c4N9h+e2+MA2d0oOhSoH5ulC5Ze9Jk=;
 b=ZEuJAwsfAlT2lQTpHGN07Ou97pPwS8tvXgG3kpdT9oo8heUwRFZKiN5IVz33qRpUZXbJYKbMTroee8H5V1B49xytoa4XWhINoCQRUwmBNUr7jZ/lvReBVGDlwP1VaDgvtZsw83bGZLbvbRFuCqfdVEm9/W9nDpMoGnIpMELIfyz6ViQQCOvMHYC1Yptmx3xXOUSeziWgRcCwDTNnHxUybsQxQ2fwHwV/JAqqINa6K4+68nyVi9zurMZZ3Vp3TPXbp7UuZjzjw218hxW+ewsLnfm9Z5STVOZrZUJkoPVX+mJubK3n7jW0CaR550CZ+VBulorVrgYgWG2j9eQ2P6xncg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AyEJsJH21bCq1c4N9h+e2+MA2d0oOhSoH5ulC5Ze9Jk=;
 b=sBbt3Ui38DcLe0Qxa/pfJuvyNjA/sVLZEuEs2/CeLVvFk/Bpi91oi5qy1Gg8sKd4Or7OUYeWVTEnuXcOCR7ObkBJmzI5QSVu9vmU2YK9kccpQy6qPToAaxTQDpG7EOnb8UXXPTYq+KNOYETiq6vEmelKs3hAgcNmSoBH0xE5RyI=
Received: from DS7PR03CA0291.namprd03.prod.outlook.com (2603:10b6:5:3ad::26)
 by IA1PR10MB7113.namprd10.prod.outlook.com (2603:10b6:208:3fb::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Tue, 20 Jan
 2026 13:03:18 +0000
Received: from DS1PEPF00017095.namprd03.prod.outlook.com
 (2603:10b6:5:3ad:cafe::fb) by DS7PR03CA0291.outlook.office365.com
 (2603:10b6:5:3ad::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.12 via Frontend Transport; Tue,
 20 Jan 2026 13:03:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 DS1PEPF00017095.mail.protection.outlook.com (10.167.17.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Tue, 20 Jan 2026 13:03:17 +0000
Received: from DFLE203.ent.ti.com (10.64.6.61) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 20 Jan
 2026 07:03:17 -0600
Received: from DFLE215.ent.ti.com (10.64.6.73) by DFLE203.ent.ti.com
 (10.64.6.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 20 Jan
 2026 07:03:16 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE215.ent.ti.com
 (10.64.6.73) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 20 Jan 2026 07:03:16 -0600
Received: from [172.24.235.213] (gehariprasath.dhcp.ti.com [172.24.235.213])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 60KD39mf1099956;
	Tue, 20 Jan 2026 07:03:09 -0600
Message-ID: <6650770b-2e9c-4f9a-8310-1f335ffa69f8@ti.com>
Date: Tue, 20 Jan 2026 18:33:08 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [EXTERNAL] [PATCH] arm64: dts: ti: k3-am62d2-evm: Fix missing RX
 delay for DP83867 PHY
To: Siddharth Vadapalli <s-vadapalli@ti.com>, <nm@ti.com>, <vigneshr@ti.com>,
	<kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <bb@ti.com>, <afd@ti.com>, <p-bhagat@ti.com>
CC: <stable@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<srk@ti.com>
References: <20260120061335.1497832-1-s-vadapalli@ti.com>
Content-Language: en-US
From: Hari Prasath <gehariprasath@ti.com>
In-Reply-To: <20260120061335.1497832-1-s-vadapalli@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017095:EE_|IA1PR10MB7113:EE_
X-MS-Office365-Filtering-Correlation-Id: 51c62ece-cfc3-422a-1bc8-08de582447a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M1ZnVVFQTkp3eFZOcFg0ZEh2SlBiUmd6aFZnNTRPRjZxNTE1UjdQckk4YVh1?=
 =?utf-8?B?SDN1VXlHMFFZOHY2QnFEb24rbGo0SDBCb3ZJbE8zKytCNjI2YWFoK3BHcTBu?=
 =?utf-8?B?ajF0cFdDVTR3dmpTRDY1bnVacDRhTUZqeFFNemxWa1RJT3o5WHFyU2JaY1hI?=
 =?utf-8?B?d2l4QUZtV1h6U293Yko4Vmw1T2tIcWwwTXRNNE5yVEFkUzRQZmRIQzZkU3BN?=
 =?utf-8?B?YjhTZE1mRllEbytjS0RweDNTN1RuYUdYQjFnSnN6Nk1EaHRNdklIZ05CblBa?=
 =?utf-8?B?dWFIWU5PSWxKMWdxNmZFNTNZYm1ZS1U1emNYbTkwTmo4Q2svUmRrZURuQTVI?=
 =?utf-8?B?VHovbnVIcmVMT1VzWlNpVFY4N3BrL3dsakhPM01NZS9DdkNudktZNDllanRx?=
 =?utf-8?B?NWFCTE81b1U0WElIV1hLNkpOSjVXdVhzRDd4MVFUc1Z4bHRaOTdET00wL3Qx?=
 =?utf-8?B?d21YeEFzc01oVUo0UVlGdWdVUjUzc2hxRzBTd1ZpcWdweGVGNm01S1Y3UXRY?=
 =?utf-8?B?MUxkZlIweEpiVjkzZmRKbHhiRGVuQzBPWjV0ZTdUYkhJWmc1TTNqeXpacUVp?=
 =?utf-8?B?Q2ZRT0M2dnFjTmg1c2VJdk5YdEtBMFIvZy9uUllnTVovSkxDeHJ1enc3MnVp?=
 =?utf-8?B?WnB4MkpaRGNTZVNCMVFvN0hwb0w2ZnFicGxyVTY4NUVtNVZ6VFlZNm9aNGYy?=
 =?utf-8?B?NU1MdG5UNUtydkNhcVBRUjVhbWVYbUxyTzNObG5oZ1llNEVJYVVvckdCNFBu?=
 =?utf-8?B?b0JpSjQ4S1c3eFY0eWJia09Wa0tzclhoZWg3alpYSFRScmNIQmFIZHJGdVND?=
 =?utf-8?B?NkN3dVpBaDNWamswNitZRDZERW9kbVlvaVl3V3VySEJYODV2K3lKckRTVlNX?=
 =?utf-8?B?VkRQc1N1TUpoQlFiK2tTWXVBRUxsbDBoQkJIRk82QS9ESVhWSFYwV2lsL0tU?=
 =?utf-8?B?dE4xbE1xTVVKRHAveE5QOXpRb3BNZ3BSdCtXTDdidTZ0d3BrdGVDUndpcEln?=
 =?utf-8?B?ZlVlbVk1Z3ZsOHVBbXpEMGNISUJxbXpHWG56TFpBdnh6YnNpaGJzN3RLeWtj?=
 =?utf-8?B?bVlLcnYwQWtJdlFRTmYyN1piY1RuK2I0RXpWSktTV0lRZkN1T0lVV3h3ZU5I?=
 =?utf-8?B?WnJ5cndqd3RVeWVENm8zMS9WZmNJRExhOUxBUkc1Q0lIK1psM0wzZnBDQ3RC?=
 =?utf-8?B?NEJrVnZNVXBWenhUN0VtWG9HL2hMcVdnVkVLNzRoUVpyUnJIdFhYYW1CSVJq?=
 =?utf-8?B?TngxRzd5UW9FV0lLZmMvVUhQYnJNbUM1c3cwRjdVRkZmYW5RWnBGYnNiZGtr?=
 =?utf-8?B?VmRvcE4vaXZOQWpBbWFGeHB3SkFXdTdORVErbXJCWmF4VXNWY0ZFbDRCa0Np?=
 =?utf-8?B?M2xRcWdKQTFGTTNXZjdEWGErWWNoQVJENDJRaEd4TVFBRG1ZdEVPNGd3N0VI?=
 =?utf-8?B?bGU5ZWJmMjlEWnR1WXhwY0lpblhmb213a2VpcGcyUyszQ3l0N1lmUktpUi9P?=
 =?utf-8?B?V3d1Wm5Fc3MvODAzZ3JWUEFxcFJkelhYZmZ3Umx0UzJzN0c2T2xDSStTTUNH?=
 =?utf-8?B?cFZjWEFqSnZlM3M2ZjRVMG9wdWx2OWEvVUdIb0srV2pUUjZpak5SYmdhdGow?=
 =?utf-8?B?ZmZHK2ZIU2E5eURtZWVrVjhjdUVRc3Z1SW9QUGMxa3VNMHZaZGtQeTNZcHFW?=
 =?utf-8?B?QUpwUjlsUlg0a0J5dlZGeEthaW80VEQ3MjN0RXNMZm9CVk0yUkRlTTl0Z0JT?=
 =?utf-8?B?M1lVOU1sNGNvM29DSStwUGxyUlU3SHA0TmxkczdiZHN4WWgvSkhkaW5BM0wz?=
 =?utf-8?B?eWpFWFlxMW1LdHYyd0RNcFVRandyaEFiZlNyY24wZ3BRQWZlcGNUSzVZZll5?=
 =?utf-8?B?NTVPU1dZamM2REtrOWZMbTQ0a3FjRlFSQzVJUEZXOUlVRUdiSTFSblZRNHdv?=
 =?utf-8?B?dGFuTHJQSVpNamlJakNER1ZvODdZNkx0NzdWZE1jK0U0QUdWTVArMDJiQUx2?=
 =?utf-8?B?SzdkaFhlWEs2WmNmL21WMVRLK1RkNjlabVZIVEZpeURMY3h4ZWE2YzJxR0lK?=
 =?utf-8?B?bE0wREJ0U0U5aGJmcVdOYmZ3SytPelU0M1V1UlJ3UXA2VEx3TlNyNHNETklS?=
 =?utf-8?B?VnpacW9TVGsxSm90S2RmMHFvWktxUG9MeFJ1M0VrUnpYUUQ5QmZCZ2FzcDIr?=
 =?utf-8?Q?xzZ6i1GPBhKAjmUmudX0FDXjSkXFO6dmGkPbA8Es8Na8?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 13:03:17.6051
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 51c62ece-cfc3-422a-1bc8-08de582447a3
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017095.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7113
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[ti.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	DMARC_POLICY_ALLOW(0.00)[ti.com,quarantine];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-210512-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[ti.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,0.0.0.0:email,proofpoint.com:url,ti.com:email,ti.com:dkim,ti.com:mid,urldefense.com:url,0.0.0.3:email];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gehariprasath@ti.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[stable,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	REDIRECTOR_URL(0.00)[proofpoint.com,urldefense.com];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: D9905506AC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 20/01/26 11:43 am, Siddharth Vadapalli wrote:
> MAC Ports 1 and 2 of the CPSW3G Ethernet Switch in the AM62D2 SoC are 
> both connected to different instances of the DP83867 Ethernet PHY on the 
> AM62D2 EVM, with the 'phy-mode' set to 'rgmii-id'. The DP83867 Ethernet 
> PHY has to add a 2 nanosecond
> ZjQcmQRYFpfptBannerStart
> This message was sent from outside of Texas Instruments.
> Do not click links or open attachments unless you recognize the source 
> of this email and know the content is safe.
> Report Suspicious
> <https://us-phishalarm-ewt.proofpoint.com/EWT/v1/G3vK! 
> uRdqXRfPtm07agZk_PPjvDYD9oe_mpoIkkjINUyRhGSu--0mQdy1pi4MPng- 
> ix3RK2L1V3y4DrnTdaCm8zj7QGx0QX2i$>
> ZjQcmQRYFpfptBannerEnd
> 
> MAC Ports 1 and 2 of the CPSW3G Ethernet Switch in the AM62D2 SoC are both
> connected to different instances of the DP83867 Ethernet PHY on the AM62D2
> EVM, with the 'phy-mode' set to 'rgmii-id'. The DP83867 Ethernet PHY has to
> add a 2 nanosecond delay on receive (from wire) based on the EVM design.
> 
> Since the device driver for the DP83867 Ethernet PHY coincidentally assumes
> that the a 2 nanosecond receive delay has to be added in the absence of the

'the' can be removed here.Verified this claim on default value in the 
driver without this DT property.

Reviewed-by: Hari Prasath Gujulan Elango <gehariprasath@ti.com>

> 'ti,rx-internal-delay' property, Ethernet is functional.
> 
> However, since the device-tree is intended to describe the Hardware, and,
> the device driver for the DP83867 Ethernet PHY may change in the future,
> add the 'ti,rx-internal-delay' property and assign it the value
> 'DP83867_RGMIIDCTL_2_00_NS' which corresponds to a 2 nanosecond
> delay.
> 
> Fixes: 1544bca2f188 ("arm64: dts: ti: Add support for AM62D2-EVM")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> ---
> 
> Hello,
> 
> This patch is based on commit
> 24d479d26b25 Linux 6.19-rc6
> of Mainline Linux.
> 
> Patch has been tested on the AM62D2 EVM verifying Ethernet functionality in
> the form of NFS (Network File System) mounted using the CPSW3G Ethernet
> interface 'eth0'. Test Logs:
> https://urldefense.com/v3/__https://gist.github.com/Siddharth-Vadapalli- 
> at-TI/04c51da22c0a05f7fc930afc98997571__;!!G3vK! 
> QTTK5TlfaumfenDPi727EMMDEuWq4go3k_u6HRWdaWchECwvYWQxiJzQtxgzKNMLr3FEjTj7x-zpSSw3CA$ <https://urldefense.com/v3/__https://gist.github.com/Siddharth-Vadapalli-at-TI/04c51da22c0a05f7fc930afc98997571__;!!G3vK!QTTK5TlfaumfenDPi727EMMDEuWq4go3k_u6HRWdaWchECwvYWQxiJzQtxgzKNMLr3FEjTj7x-zpSSw3CA$>
> 
> Regards,
> Siddharth.
> 
>   arch/arm64/boot/dts/ti/k3-am62d2-evm.dts | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am62d2-evm.dts b/arch/arm64/boot/dts/ti/k3-am62d2-evm.dts
> index 2b233bc0323d..17c64af4f97b 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62d2-evm.dts
> +++ b/arch/arm64/boot/dts/ti/k3-am62d2-evm.dts
> @@ -649,12 +649,14 @@ &cpsw3g_mdio {
>   
>   	cpsw3g_phy0: ethernet-phy@0 {
>   		reg = <0>;
> +		ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;
>   		ti,fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
>   		ti,min-output-impedance;
>   	};
>   
>   	cpsw3g_phy1: ethernet-phy@3 {
>   		reg = <3>;
> +		ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;
>   		ti,fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
>   		ti,min-output-impedance;
>   	};
> -- 
> 2.51.1
> 
> 


