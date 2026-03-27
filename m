Return-Path: <stable+bounces-230721-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UHMfBJ7uxmkIQQUAu9opvQ
	(envelope-from <stable+bounces-230721-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 21:54:54 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 60E2834B5A9
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 21:54:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5F1D630F1737
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 20:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D2F73845B3;
	Fri, 27 Mar 2026 20:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="fr1wjagh"
X-Original-To: stable@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11021086.outbound.protection.outlook.com [40.107.208.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B20933F8B1;
	Fri, 27 Mar 2026 20:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774644557; cv=fail; b=VPGYjOmkfF7FYjlAai76I0XaK1Tctxn3F3D2PHAxu1ojLiv9u6TQ81ZwU7yJFeIVUsDUbQbMyLM4E8ZDVZ4CQDaVyDu/wXwakYC/2gt/6kczb82c4J9aiWP2V4K+7QZ88mmHOZH886yk1voERLLPTwDY4xAloEpDbT+kHsjRgBw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774644557; c=relaxed/simple;
	bh=LDVoZ9RCrZaQKlKjbwiR/UOIRXgYNWjNSKmEfkOgzPw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=j9hCSXoNEgM+P3eGBHnNutBdM7yFePEv/upePCsm3MzFj3yvA9u4pmldp8nH9xaV6d1Pbf++12EXl0ok8rzgQMqaq0gSzzDkfoKEb9xRHIUbRmhLw42ExKri5lk/plZezf9GpUHwPZ2+BSxtk/DlxZtwCONXg0jKqc5sLauiDos=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=fr1wjagh; arc=fail smtp.client-ip=40.107.208.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ihlAazNndXBWzWy5V3aGijDf0XNjOsqKrL6LDTlGVxBVWT0GVvc1qZ2htExGoOSOXCrKYtSEjsv1CYEy9s7JziysFgzRpfVQ5p35a3U1fj3azYUkHtbBNCbeyIemDIyFGkG3OAZSkI5FeVdiwnjv0Op2r/x3y2YQK3fXvSCzGD8zuajt3y0cTNnGi7x8slyr9En1b6LwWvGv6s6jr5Mz/9OGf7ZiAUVDnkwVYeFxfc/zlQofBsivcMARwDCMlp7iDLDxyoeYnkIrQeD1kXuRZNvoT2Yiqg0jok1IVfdRZROO+JQznBTqe5o8vyIjEBdID4AAylh6p98nEA9UyYlt9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LDVoZ9RCrZaQKlKjbwiR/UOIRXgYNWjNSKmEfkOgzPw=;
 b=hDl3LoCzQM8wGl1S/hQTBZIaVuEHVLrzbSUMAsFNLUptXaeoQsR49XB4Ezw+yn+qw3hIK8semaor7y30EbmM/dI6fI/7g7VusFzRJ6QPvXg5F6T6D+SEALhtoMH4aZSSQJS+pjPMdmucPRDDjznCLtXljxeKuf9HgzgCTUXD8+BfOz3o8A0C+4HUSXE3oE6z2EkkA1Kk14PVSr6wJqXW3XqNWxG/GJsp1QcKXWwwtLbdJtaVa9S+nRNTYVMn+XkJkOV/mdMtjjNp/Yqm3WCngb6z0UU5Na3ffyU7b7wW7ef7Fh5U4FQJMoCntbNGZP/AHWBsUEAhjB6WAKiS2YATxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LDVoZ9RCrZaQKlKjbwiR/UOIRXgYNWjNSKmEfkOgzPw=;
 b=fr1wjagh/kRSMvai3o96LsOxd5lTmXmpRdLlUiqeNQ+ZU9TIuJZY0Eb2NlTPQr0oelLfoZ/ibjcSuB3iIpg0TMTNuNAqDS/pcDddFIXr7fZu8us1oKaWjOotBgnGxK/x9fe4jS1yeZUY41hoGxhOcoMIQx2MkJVVF9ozPaW0r1I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB6873.prod.exchangelabs.com (2603:10b6:610:112::22) by
 BY3PR01MB6611.prod.exchangelabs.com (2603:10b6:a03:36a::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.23; Fri, 27 Mar 2026 20:49:11 +0000
Received: from CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::46eb:64a3:667c:c1a0]) by CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::46eb:64a3:667c:c1a0%4]) with mapi id 15.20.9745.023; Fri, 27 Mar 2026
 20:49:10 +0000
Message-ID: <48e46666-3e2f-454b-b1a7-ddd8a7dc5774@os.amperecomputing.com>
Date: Fri, 27 Mar 2026 13:49:07 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/3] arm64: mm: Fix rodata=full block mapping support
 for realm guests
To: Ryan Roberts <ryan.roberts@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 "David Hildenbrand (Arm)" <david@kernel.org>, Dev Jain <dev.jain@arm.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Jinjiang Tu <tujinjiang@huawei.com>, Kevin Brodsky <kevin.brodsky@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260323130317.1737522-1-ryan.roberts@arm.com>
 <20260323130317.1737522-2-ryan.roberts@arm.com>
 <a3766dfc-06ed-4cdc-9c55-0dcc3638746e@os.amperecomputing.com>
 <47d033cc-33dd-4fb2-9e8a-bc5762db6b6a@arm.com>
Content-Language: en-US
From: Yang Shi <yang@os.amperecomputing.com>
In-Reply-To: <47d033cc-33dd-4fb2-9e8a-bc5762db6b6a@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CY5PR22CA0098.namprd22.prod.outlook.com
 (2603:10b6:930:65::21) To CH0PR01MB6873.prod.exchangelabs.com
 (2603:10b6:610:112::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB6873:EE_|BY3PR01MB6611:EE_
X-MS-Office365-Filtering-Correlation-Id: f50192d7-ca1b-4cd8-800e-08de8c424c32
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|1800799024|376014|18002099003|22082099003|56012099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	NekaVM26ESG81qVD48fInqD5IZT6u1EkrYS23aA372xgDeh4/VbVvJ4e58q7ewI7enwnZWAYfZVyOLRg+1AM2/HdD5jPNBTPb5upnPslFdk9TSgnF2AKqe10PZGZe7pIGDRDByhDcJq1ZO7H1SfgUHymbHQYpXifCO9Ho+fuLW367GDu8dM4j11QkVVNQOMdW61uVGHnOFDMkGJ2Z9SPa/AjUy0CQ4eVADb0cSHh0ADJ9pvSB8FozzyOfxycq3Wuz/JgGT1ptV2sN7nxCFXOz8RrlDWJIZZTkq+5Kk7ZgUEVKTf8uR07t43VFKTKqd8LBzrUIUpSsW6yEM5Sz8ysyvNK8D78nDj6gRDNlRX2yDHcQrY3wtO+Njh5UdLFSv66u+AfK7iocaINs6DV4eRgogJN8TMoNBXH3hZ5rjFFKbHk6lfgOl/V7bdGo6XgVlrSkARjlR/k3pps5ZFsIvO3iXBIkPwm1KH+OiFlHqRN8SfqJKEOep07qqKwOGei+K8nvcRBwWyKFPx9OZ383LWQuhnzkDics7SFMw4EkoJeRzv+2Qs5t44TCOWosfCgM/UuAnLTnWPNmc3gtN4dgy7LPZQ7ZEmvk/toR450LpcX7hinJEcYTgHhjgu3aaCo5FObFbMwIkosrmiBuvpf0OiX+Hup07jBCQDww6IoiaTDzA1qh4rwE+oo+tWn+kG/o7RN5oDOqflUkVidYXkb2y48NRIdGB2z8KyP/ITR1ofIp7g=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB6873.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014)(18002099003)(22082099003)(56012099003)(55112099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bjkrVTF2bHR0b2FnbFljSk5mMnJUbHVKMHAxSDkrZUNxNGM2OUtNVEVuc1BV?=
 =?utf-8?B?MXRMenBvbEpDTkJCeW0rMVlITy9XM29yTXVCL29HQWw5TWJDc3VKeVZURzE2?=
 =?utf-8?B?cTRJT2ovVHl2R2VVNzF2Z2JGRThOYUNBWVpsaCtOWDllU0wwS2xKSW4rU0Rk?=
 =?utf-8?B?NThBbERvZWppVml5Q1BWNm0vM3NyQ0ZTT0FURjhzb1h5VTNRaHZPWHZGZkY2?=
 =?utf-8?B?ekQyRDEzS29jSzBCVmxBMEhySk44dnNDR0FnVksrZXpqeER5dy9BaXNXZEVQ?=
 =?utf-8?B?V1FCdjNpWXd4U2tRNmZCdGVYS3MwWW1ROHhiRHJqRHZYd0wyRzNZSVQwbFlz?=
 =?utf-8?B?ODdWb1ZoczBNN2xxM0pOQ3VUTjFKcGxtdTdCUlE4aGlESEgwcVJuQXVJVkFw?=
 =?utf-8?B?UjNGQmhUbmZMVWlQWXNFcDVmNktUN0Y1ZWtENjVZUDVpaVR1MGxwSG54b0Fw?=
 =?utf-8?B?a3lmYU9OL082ZlR0QjVSZUEra1FBZ1VoRE1kVnFQdXovV0tEeXcrZlhUSVdD?=
 =?utf-8?B?OEFIbUMwdElVaVJlYzQ2NndoZFlQQy9KNGJSc2x2bTcrSnRMdFF4K0YxTmJl?=
 =?utf-8?B?RHBkWGVJdmtQWFBvU3ZDU05HWnFieTBrWUw5UjlpOWc0bDdSZFM3MzlBQlVr?=
 =?utf-8?B?SW11blllMkxuM1BOV0l6eFcwTEQ5YTdlUFZ6Y3dhY2lzdGhTdzBoL3g3bXJT?=
 =?utf-8?B?SFc4c3VrRHJNY2NIWmtDSTJXbkxjMWhzS2ZYcTJDR0lycFA0bW53Q3RNcjNS?=
 =?utf-8?B?VExXVHVlSWc4RVk2a2R3R0MrNndsZlRvR0xLS2QvYWdNSmJONVhsejU2UTEy?=
 =?utf-8?B?K2tLTmR5YlhmZjB5QkNFSXFQcXk5cGpBNDVieWRUQXBWK1hIRlhVeUgwdDMw?=
 =?utf-8?B?RnRtN3Zva1ZIdEZLMTloRllpY0hGUjM5M2IrUzVHbEFpME8yamdoS1huc2J1?=
 =?utf-8?B?bDhVRG45ZWdBdjEzWWR1OHZSbTFaOUZsbVJodlVWa3cwTTJPaXQrYndVN2Vs?=
 =?utf-8?B?SEtDSm14SmFTNURNbkNja09nT0tjT3M2M1JDcHQrRUlxcFFKM2V0UFN0U0gw?=
 =?utf-8?B?RndKRWRlZ0M4OEpiSXY1TXBRSzhnQkJzK3phTXIyUEN0cFVrYVZ6S1lPYVRl?=
 =?utf-8?B?cERnSk9MN2lmTVA4TXNqOHk0MWlNZldzMllXdHZ6TUp5ZkEyWGNTUlYrNUtK?=
 =?utf-8?B?M0NQYUtUTzVVUVlBVVVEbU15L2U4d044WW9UUHlhWTZ1aERwcy9Rb21CWXlh?=
 =?utf-8?B?TnY1blFvSUdNL05Cc3I2SXV3WEYwVnhUdGZ4QkcvWG03MllEelJYelNNbVNm?=
 =?utf-8?B?VUZRcmxiQ3NndEpRTzVkbUxxb0ZZeWtlbGt2bkFPdnpsWmRDVU42SE43ZEpP?=
 =?utf-8?B?K1JiWnhTOWt2UDFOakJCQkd6ZGh3cVVKSzlCS2Q5NlEyRHI0MVp4dDJPM0Nn?=
 =?utf-8?B?eEw4WERMd2I1OEJNRXJxam0yaTNEYVl2VUZWWXVLdW40bXB1WUZDem52WHlH?=
 =?utf-8?B?TldxUzlpamFxakZRVTAzK21tTlpxczdBR0NWZUJ4TndDbGp0R3VQZ29hTmpY?=
 =?utf-8?B?dmx1eWNEQjVDZ2hUTDBhZnpUenozc2pLd3E0eUl3a21UdXZvSUoyMHNQRWFR?=
 =?utf-8?B?UnBVM1IrMjJuWC9JRWdmcC9SdklPM2ZJYXMrdC8zVVpjUDRGWWJpM0RTdkdk?=
 =?utf-8?B?TzUrUnJrRXlJTzRpa1pjYXlaV2paSmxrMktXekhoTXZjTzZBa1FZTEVsbEtR?=
 =?utf-8?B?YWwyN1N3L01QWkRDZkYyQjI5SjlBMFZiMFRyNnpBbU9nWDQ5M3FJUHArcS9t?=
 =?utf-8?B?bmlDOFhSd3B0djJ3SjlBWkNXTDBFRGFjT1RFUDBTRmNJQ1BaT29jNVVKWnZS?=
 =?utf-8?B?VjJYdDh6TWNRMllsRXJrYWEwZjlRY0J1MWdLOVBCMmJxMWNLNTdRdGZmaDFo?=
 =?utf-8?B?bmRBbmFWc05tZ1pXRXRxcjFKbVovclNqR2JzZWhvWGtLckVOZEJNTzlwV2JV?=
 =?utf-8?B?UjZzbFJjRmpmMlZrdGdaQUlMZzd0Tm9lRXhRTHlhRXBlbTI2SmxOYlozY3E3?=
 =?utf-8?B?V29LeFdON0xwOFJoTXZyY1FFaU8wU2dMa1E3RXJQZkEvRVM5eWZqYmovN3FU?=
 =?utf-8?B?a3pjc3dNZ3dxNE5qQlU3c2pZUGtvUUVoK2Z0dldodVBHWFd3SWEzYlZNQ2Nv?=
 =?utf-8?B?QVlHczh5eEFuRCtZaXJ4YnJ2ZXdTbVo4Z3phUG9yblZmaHpMZktRbGF2SzZC?=
 =?utf-8?B?QkR5eFJjNlRaK0FBVkNIVFRNNmdkaS85RCswVjhSRXZKR2VFNW5RWWRBTEFr?=
 =?utf-8?B?VmkxSEYzN2hDY3JIR1kycTNhWDNKZjk1enpZa3VadGtsQUhhZklKTHZIQy9j?=
 =?utf-8?Q?x8TpNi+N4/UuUv1Y=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f50192d7-ca1b-4cd8-800e-08de8c424c32
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB6873.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2026 20:49:10.8611
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DGNloX0vfpc4q5xLJdW0gPgJCn6xdhIo2k+7Lz8J9JnzWlZwFJTTnsj28GNC0GzRy2DQhX34Fo9x+Q1/mvZcwi1O0PUO1FHuxbrDJYp6kYo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR01MB6611
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amperecomputing.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[os.amperecomputing.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-230721-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[os.amperecomputing.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yang@os.amperecomputing.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[os.amperecomputing.com:dkim,os.amperecomputing.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 60E2834B5A9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 3/25/26 10:29 AM, Ryan Roberts wrote:
> On 23/03/2026 21:34, Yang Shi wrote:
>>
>> On 3/23/26 6:03 AM, Ryan Roberts wrote:
>>> Commit a166563e7ec37 ("arm64: mm: support large block mapping when
>>> rodata=full") enabled the linear map to be mapped by block/cont while
>>> still allowing granular permission changes on BBML2_NOABORT systems by
>>> lazily splitting the live mappings. This mechanism was intended to be
>>> usable by realm guests since they need to dynamically share dma buffers
>>> with the host by "decrypting" them - which for Arm CCA, means marking
>>> them as shared in the page tables.
>>>
>>> However, it turns out that the mechanism was failing for realm guests
>>> because realms need to share their dma buffers (via
>>> __set_memory_enc_dec()) much earlier during boot than
>>> split_kernel_leaf_mapping() was able to handle. The report linked below
>>> showed that GIC's ITS was one such user. But during the investigation I
>>> found other callsites that could not meet the
>>> split_kernel_leaf_mapping() constraints.
>>>
>>> The problem is that we block map the linear map based on the boot CPU
>>> supporting BBML2_NOABORT, then check that all the other CPUs support it
>>> too when finalizing the caps. If they don't, then we stop_machine() and
>>> split to ptes. For safety, split_kernel_leaf_mapping() previously
>>> wouldn't permit splitting until after the caps were finalized. That
>>> ensured that if any secondary cpus were running that didn't support
>>> BBML2_NOABORT, we wouldn't risk breaking them.
>>>
>>> I've fix this problem by reducing the black-out window where we refuse
>>> to split; there are now 2 windows. The first is from T0 until the page
>>> allocator is inititialized. Splitting allocates memory for the page
>>> allocator so it must be in use. The second covers the period between
>>> starting to online the secondary cpus until the system caps are
>>> finalized (this is a very small window).
>>>
>>> All of the problematic callers are calling __set_memory_enc_dec() before
>>> the secondary cpus come online, so this solves the problem. However, one
>>> of these callers, swiotlb_update_mem_attributes(), was trying to split
>>> before the page allocator was initialized. So I have moved this call
>>> from arch_mm_preinit() to mem_init(), which solves the ordering issue.
>>>
>>> I've added warnings and return an error if any attempt is made to split
>>> in the black-out windows.
>>>
>>> Note there are other issues which prevent booting all the way to user
>>> space, which will be fixed in subsequent patches.
>> Hi Ryan,
>>
>> Thanks for putting everything to together to have the patches so quickly. It
>> basically looks good to me. However, I'm thinking about whether we should have
>> split_kernel_leaf_mapping() call for different memory allocators in different
>> stages. If buddy has been initialized, it can call page allocator, otherwise,
>> for example, in early boot stage, it can call memblock allocator. So
>> split_kernel_leaf_mapping() should be able to be called anytime and we don't
>> have to rely on the boot order of subsystems.
> I considered that, but ultimately we would just be adding dead code. I've added
> a warning that will catch this usage. So I'd prefer to leave it as is for now
> and only add this functionality if we identify a need.

OK, fine to me. I don't have strong preference for either.

Thanks,
Yang

>
> Thanks,
> Ryan
>
>
>> Thanks,
>> Yang
>>


