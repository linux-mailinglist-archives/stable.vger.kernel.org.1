Return-Path: <stable+bounces-222836-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4Ix9LhqlpmkTSQAAu9opvQ
	(envelope-from <stable+bounces-222836-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 10:08:42 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A9D91EBA5C
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 10:08:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C0F583014A30
	for <lists+stable@lfdr.de>; Tue,  3 Mar 2026 09:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D261B38BF6D;
	Tue,  3 Mar 2026 09:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SQnPyT6q"
X-Original-To: stable@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013000.outbound.protection.outlook.com [40.93.201.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74DD834F48C
	for <stable@vger.kernel.org>; Tue,  3 Mar 2026 09:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772528919; cv=fail; b=BmGAthBbuO4kYqiTqlY6gM4fIBrVzCUKkBbyDYHq6/bV3YOajf8i8QCoQRYibz3OChRS58ZQYaFUaqzCAozYkayQ6ZW70Z6F4K+ZrR+YFBD7/neHH/RlqRnJ4Oj60lNQ254C8M8qQ87uOW6S69W2SBWXLeY0A/dNBREmIJOcmu8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772528919; c=relaxed/simple;
	bh=KGP2DN6WIO1FHHEfijrcU9cj2FeLSMIj8bo5Vu72m0A=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BvC2YJ57tjk5hnaR9KDeBnZWP4wadOljUx80oOTMuVP3cWYOn8sfOC8YKc+c3F3DJDDBQMeuo0AGH87/KGDVaRjPY5WGG1K+o+zSRIMbBDFf/VUoPuENTmmghbA90lo9b/UsEWJavjGbPHgXZ6ExwdQITq6Gg58yXHxZY6b9Zts=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SQnPyT6q; arc=fail smtp.client-ip=40.93.201.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=niuaqjkEj7Id0AfV8BBkKqXU/0BG1ix8bUu2pChrhDWyr8qjtsQQq91BVwdI7MQx2Ml+NF7ub7j1swOkzxCQ8TPxcz4UB+u5rnYJE9Vmfe0snRPPkxRGZCDXRaBwohC6xBCXZk8cAbVBE5BVv8UmCMI38ELrcgmgbKVNvZHmfoe2Z9iI/sk4rZG7m8q5GJGB1pWQzZFXzDKFh5wUQlkcGednKYNNKwKVQU71Zp5+ATrljV9L4p3qhNhXQ39DBPxC8K7oxi5gts5UgvW67IvkoVur4mGZfvVb9u0PYeMKmPnbh5n95aFZAzUD8LToXzPT97atlUYKvK4kQjCstjtw5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iSqJftoRTHc8HepBkB0N8f8iTS0b/ne8vSDwhpwEOKk=;
 b=uwHBcUq1uCtX0PPvpOy7alisOe0CqAkOq6+zjP5hRxgx1nM1SDWR6qippCX3fVObLFTjvJjb00lzND/CY0YujtOPhvbucHJILQPBO98rMn3706KHneejROdLuOf+Tu2a6gMBA0PAP25UeX3nT4cUfNawRM4Ub6fk+luMyusuzbs3PIHLHKUV+SCVw6NITo8ZXmCfYWVhkOtzgeyPvbjlHKNZOvhJdq1VZzA2IWju+B37JC22/rJEnHnMbBxicIlwrIv2EuCcyc8csJbCjnR18r18ZliMs5DK7y/FRo0qG/PeQCM+1vUaD3EM9n8lWZ46LTNyOAb2dCd3/7z9Y6ZTqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iSqJftoRTHc8HepBkB0N8f8iTS0b/ne8vSDwhpwEOKk=;
 b=SQnPyT6qSRWewd/9ZnCPyIU3u37K1XqOBavlorplDrBu4F2lwFL1c3wF0orDJzGjN7703fRR069oOrbT9a7RXpoq2D8frZxdyEqtiOuH6iB6aipvKWFjbp0XL+1BIiIO4YVIHxc8llhT+7KjNZIlg2Eg1dIIndj6PONq12JMy9A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB5761.namprd12.prod.outlook.com (2603:10b6:208:374::6)
 by MW6PR12MB8833.namprd12.prod.outlook.com (2603:10b6:303:23f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.21; Tue, 3 Mar
 2026 09:08:35 +0000
Received: from MN0PR12MB5761.namprd12.prod.outlook.com
 ([fe80::b0f2:27be:4ba6:3288]) by MN0PR12MB5761.namprd12.prod.outlook.com
 ([fe80::b0f2:27be:4ba6:3288%4]) with mapi id 15.20.9654.015; Tue, 3 Mar 2026
 09:08:35 +0000
Message-ID: <eda00619-86a8-491f-9990-160ff9c77a11@amd.com>
Date: Tue, 3 Mar 2026 14:38:27 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rc 1/2] iommu: Do not call drivers for empty gathers
To: Jason Gunthorpe <jgg@nvidia.com>, iommu@lists.linux.dev,
 Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>,
 Will Deacon <will@kernel.org>
Cc: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
 Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>,
 Joerg Roedel <joerg.roedel@amd.com>, Kevin Tian <kevin.tian@intel.com>,
 Pasha Tatashin <pasha.tatashin@soleen.com>, patches@lists.linux.dev,
 Samiullah Khawaja <skhawaja@google.com>, stable@vger.kernel.org
References: <1-v1-13a02eb0e031+a5-iommu_gather_jgg@nvidia.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <1-v1-13a02eb0e031+a5-iommu_gather_jgg@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0210.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1ab::16) To MN0PR12MB5761.namprd12.prod.outlook.com
 (2603:10b6:208:374::6)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB5761:EE_|MW6PR12MB8833:EE_
X-MS-Office365-Filtering-Correlation-Id: 15a41ecf-f31e-44d1-3a48-08de79047310
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	2U4a4C5BO7Tx5c7UpWL8o1dbuVGI5B+8gphpdHCzmQJWu2xsWiPEOTN8BPRX/oipKPEy07p5MgIXLhxtC+ufUknYyJr3vn8CKfcqY90zMWM8NP071tyuI9LX+OJBwNu3NO9j2qIrFk5dZY9piABh5rR1s1goWLkruGNTTKL2S/TTJskZP3vBIbAWzq/xqIJ6WTMTWFTtFzqZE/wJ+yOCgcrNA62ntkzvWBQkArHBRpxJY/4xV6YoBLoX6Tyh/QQepsCThsHp9SLfhpn3go9bWCmsGK5jX92hosLM1qNla58pMMoNrxxUHbPUUVzzHERU0ko44idTcyOFP0byZtRBGE8MyPSkFFP8p1bbkrQj704f90EGZFK1/b95mtkUDMofxFCriIXEoBnxgyBGKNoLCqgH2VkN14HV0FkvD/gbtGuTGVVPwMs2L4V9Dg5Kl52OjsvvfdZJe+QiBcBP8ifjL7oe4tFdtYx5uz39K1if32sANgQ5yDfxib47S9usNmxGanKpDP1OmdDO/gvL6SeDYDTOrXwxOauclNQBMxzJLAZwkBbEhft2IKdXyXJF/NV4y8rQ39dx1KZSF2E2SGW1Cxn3yXF4vI/CoRcEuXisei6gnWhmn6KQEJ3Ac2p3wkUmwGbkcmt1coR+iMBQGyT244Li5w41XqZ4gLkulEdPMqz6o4jeIunL2BkC9A4Ew327Z9pkmlnuxcCj/vKUPFGsN9V3Qe/wsru4MIEAFX3g+GI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5761.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SDF3Y253ckRiTEJ5d2xKS1RDNVpYdGxOemxzVTRsaHZwN0VBeHhLUXE4VmNr?=
 =?utf-8?B?cmFuUytrS0wvanlQK2tUNmc2UHBZb1V3Y3NYYVZHS3RmRU5XWWd6Z1pjYkRC?=
 =?utf-8?B?SFhObU1GdGc1ellBeSt0dUxjQWl3Y296N1RlcSsrQ1pQL1Y0UzhJQ0FtNm1z?=
 =?utf-8?B?ZGlNUUNJL1NkYTMrY1R6OURQaUY3SjNTYjE0Q0d0QWlCUUc5RUxRTUlVclcv?=
 =?utf-8?B?ZDNBaXRMMXlLYlVYaklKd2FUeTB2cytuYXlyRkF1b3J6aGtQUmxxbEx6TGNw?=
 =?utf-8?B?TXljVXd2dEVOY3hyNlVpN3RpV2l0ZlM1T0xTTUdMcTE3VXovWUZzYmhQbWNh?=
 =?utf-8?B?UENBanJXNVM2WllqSlVCL1owaDBNdjQycmpXMmwyd3FleFFVa25iVUVoa1dF?=
 =?utf-8?B?MW9zcStya1ZCQ3FvWEtTbDVDWXRIcmVKWnFNN2VLZy9CdldFL3lveE9XUFpi?=
 =?utf-8?B?YmpWOFRqUGdxWXppei9TTFFWWlRETTFqMnV3NVV5ZEZaUDhiY0FPM1FxaW1Q?=
 =?utf-8?B?ald0Y3BHOUx4VkNxNFZORm1nMnJCTE40VmxlM2tsb0hkeW9NM0JUVkFVdG9K?=
 =?utf-8?B?bnYwa25rK1kyYjdaWm9WRXBzYmVxbWxUSUU4SFk3MStYTU82UXJ0SndhQUFJ?=
 =?utf-8?B?NmY5eWFjaGNuOThtUmowYURYeGtDK2ZJYVJkU1Vlb29FMTFBWWE1Vkx2TjU1?=
 =?utf-8?B?NVVOMzFHSG53NHYyYVJHMFlmbVNtYWt2c3Nvc0hibDRIV1d4TklvOG12cWxC?=
 =?utf-8?B?YU1qUGpkQmhVNXlleHRsZVgzcFY1TS9ibDh5SW9LdzNvamloY3dMc3lFcVp5?=
 =?utf-8?B?bk5kdlVuNGhWUmp4dkV0dGxMWHlSbTMrVlZBbDQvNndZaWxjcFlOcWhWVlZv?=
 =?utf-8?B?KzJEMlBiOU0rMUtVckVnSThXeEJkVXVoNzd1bDhwN2hyS1ZFYUZpTFFmYkpP?=
 =?utf-8?B?WCtLS2o1Mlh3TTFDYXVUd0ZvOVhUMnd1c3N1UzllRjlwU2JDcHVOWmwyb0Zp?=
 =?utf-8?B?N2g0blpuT2UzRkc3Ly9mc2dsQnRITm5GenFxektQOExuN04ramQ4TGo0SFBu?=
 =?utf-8?B?dlE1MDl0ZWw1aFJnTDVrSzUzT1VhckNNRXFIRzZTbGkxTWhvNlB6RktJOVhr?=
 =?utf-8?B?RnVYbFhSSzlCRW5zbFBvVlZLSWpHTnVSWjQwK05ja2k4ZTF1RUxsekRHbkRG?=
 =?utf-8?B?MGMrQ3B4b01XZFdqVFE3dkE4WThVbitaNkRPb0hmUnV0d2N6L1ZuSGZSeUMy?=
 =?utf-8?B?ZHAvdW1EblpEcU5TdWlyTS95dm1Id243WDRjZnFpSHhQZWp5cHFzQ1pDRHVV?=
 =?utf-8?B?N2RIS3JzUTF2M2NLUGdKbEsxRmhmYmx0UUwwcTRrdXF4MHNIZTZyQmJkMnJJ?=
 =?utf-8?B?OUJIeW5RaVQxUldxR09yUDBaK0MxR1V2TGZxUVlwaVZSQlBRSHA5RHF3R1lq?=
 =?utf-8?B?Ny9xWXVuUUpQYlpHYjBJMGdhY2hGYmVpWTdSVURxTjVPZWJJb1NmLzBSdDBO?=
 =?utf-8?B?YTB5SmhlQlVuNXJkS0lFMVhSU3ovYm5rWTkrLzNERCt0emNJVC95YmdpeFZQ?=
 =?utf-8?B?ZjZLV2RXOVRSV0ZIVnk5Qm8zRjZSWS9vdUowa0dMTVN0d2k5SGpzcE85bG9D?=
 =?utf-8?B?a095ZFhWZ1EzZDBrcjVyWFNvQmJ1YkFnMDR4WkFSdHl6MTRGYnJTYUNCMmpO?=
 =?utf-8?B?SERjbDJGZUd5dGpWYmhOMDdJS3MyWitCMU5BN3V3NnZvc0J2bnM2M2t5UTNT?=
 =?utf-8?B?SmcrVXM2Q0kvSzNEM2d5SHo3NmlQTzEycFAzSXZiQ2loaUY5ajRCYU1NL3hZ?=
 =?utf-8?B?RmxRNXpGMGpRVnluQWU3TW93TWxYL3grNjQxbUxTVmdnZlpnK0loUmFpTmFi?=
 =?utf-8?B?bU9SSUNCcFYxeWlMODd6ckxOMFMxRTNrYnArK1JjL0V4NTV6Wk01QzFBeEhn?=
 =?utf-8?B?enZ3VjFYVlNjL2RyTGhpMEF4bWJtUVFsNE9yZFdOaDJPajN5SklzZzNDYkpm?=
 =?utf-8?B?Z0NPajNnVlRlVG1SQlFmNVJ5TDN3OVpnRGo2b3VzUFN0b0QxSW4xQTAxQ3hV?=
 =?utf-8?B?d3hoTEpWYmRsc0RoTlVIdEF6cFdTNUNXNkFPN0IzVHI4Tm1OR2sxYytybDBT?=
 =?utf-8?B?UTdmbHdCN2ZzZnRoMWxKb1YvNEk0N0E0bXU5YXlCNG9PVld1ekxWMmkvM1FQ?=
 =?utf-8?B?VlVmWSs5SThRak0rTzF5eGhtbDd5WElHcVpmejczUEpZcEFaUjNSNmFHeG4r?=
 =?utf-8?B?V05PcDFHWlhWTk9ZRTZQTkI4VG9aQXdZVXkrS0lPbGFQaUpNTFFTK1hyTjFW?=
 =?utf-8?B?KzcxL25zcU44Y2VMRVcxT09kbHU0QWlYUlBTYisrd1FhY2Z1ZFZjdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15a41ecf-f31e-44d1-3a48-08de79047310
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5761.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 09:08:35.2194
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3iwrZLgy3et3b67LHDYY2CzflKJDo4nvWrPBgDygwE43uUM8GzCRhvhp3J3rgoT4pw59924dM65S2UbnTwvkHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8833
X-Rspamd-Queue-Id: 6A9D91EBA5C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-222836-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[amd.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vasant.hegde@amd.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,nvidia.com:email,intel.com:email,amd.com:dkim,amd.com:email,amd.com:mid]
X-Rspamd-Action: no action

On 3/3/2026 3:52 AM, Jason Gunthorpe wrote:
> An empty gather is coded with start=U64_MAX, end=0 and several drivers go
> on to convert that to a size with:
> 
>  end - start + 1
> 
> Which gives 2 for an empty gather. This then causes Weird Stuff to
> happen (for example an UBSAN splat in VT-d) that is hopefully harmless,
> but maybe not.
> 
> Prevent drivers from being called right in iommu_iotlb_sync().
> 
> Auditing shows that AMD, Intel, Mediatek and RSIC-V drivers all do things
> on these empty gathers.
> 
> Further, there are several callers that can trigger empty gathers,
> especially in unusual conditions. For example iommu_map_nosync() will call
> a 0 size unmap on some error paths. Also in VFIO, iommupt and other
> places.
> 
> Cc: stable@vger.kernel.org
> Reported-by: Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
> Closes: https://lore.kernel.org/r/11145826.aFP6jjVeTY@jkrzyszt-mobl2.ger.corp.intel.com
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>

-Vasant


