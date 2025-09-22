Return-Path: <stable+bounces-180914-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B0E6DB8FE67
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 12:05:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8D371892A8B
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 10:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18DA223D7E0;
	Mon, 22 Sep 2025 10:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="bWF/IWJ0"
X-Original-To: stable@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010014.outbound.protection.outlook.com [40.93.198.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F1A728726A
	for <stable@vger.kernel.org>; Mon, 22 Sep 2025 10:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758535522; cv=fail; b=eqVrS8jsCLKmzk1rpzs+tz+VpWxFwxV9aE4R2uyUa8zBmANd/6eI9TH9KXD2bfmpjFZkfPj8ALV7MLoLPlwcBoj2GCDXXKTbILPjqN/JTdAUsEPts0NgTb1ogcRfR7seXQ4FX0DQxLsNcXHqdfLJ+y7Hlbs/ptb1WL4+ufqxb0Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758535522; c=relaxed/simple;
	bh=ln7MRphRQu2aGqT/LKq8eIhclIy/4tcEmQHu/knQDFk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZrJB9FU9awfA3BAW2H0xip4xMmAwjN9bBxEZlZJgmLkcmJ66EnBbUBoes+fPPEhUS8k0Eq9mRLUSaOmBVOOEFgXcF4z3uKsB6F1akqvAMN+LNFxVRCUZQt4K5dyXpn7ziJT44Njduc/Mq0MH/8woukOt2nEUfCOYe0cHICkiVLg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=bWF/IWJ0; arc=fail smtp.client-ip=40.93.198.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JOMQ1upZXJkvLqr/aefGrhUlaRgv4jaC4cWxf2glvkiyJ9CHu5F+19buHZYFh2lrYsh+80gbaePAMFnOBGLVDlP2z6Yq39l29nKUzfUKb5PJtGkvFw+yDU/C65EYHNu+4Wa3juMl1qG6u68G2vFXOE9W/rFog7jHYjifbz4Yh6dNM/UXfkhkO+UW7qIkrJzldd2oJXsZhqJQXoRELFexff0PLoifHDAAn6zR04xP9si5JXOqEI4lAswGWYtMHr8h2WflZW8KoihliJWv0i/qJMMYauj5ifTYhk1mpO2InEDgKPKqROKo85YEjy/hKgwhwm+qSP1M+TNWRU/dTlUjfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f17TtRsvSMXkvYrjJ0TChW/ROq884wYulCvmO4F+v9I=;
 b=bYLlUlxI4Qq7Xf628t0IdzFSJ/D2yyGIk/ezkNCh1PyOcjsuKKoef6uAh/POx7DGRfuX7t+9Uc/LG+fIrZo31JsE5KfofZ+bGdw1IJre/vaB+t/YXBJsinIfA4Q5THtEhEiU29oErvnmCo5404pB1cFDzA3bo1iGnCpzvvfd8pQ7ljoTOXVioZ9wfhsWyvn8DPYgBMjtYVh9z+CCHaUXFpO+gvCrFrG4YRiCp6luE7reH0JmLkmW29v8oroIvtMJosVSWTsK6xQWImYXTv17FMdGjizh3nZ5csRZg/uPI3413+4A0odRbz+XEJNZpbdca8GGG8Ccmfmk8H4Lp2o8hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f17TtRsvSMXkvYrjJ0TChW/ROq884wYulCvmO4F+v9I=;
 b=bWF/IWJ0AO1hDlFUmNRXR1ERxpY1yv/o97dhmclYhDFQJ19B/oahtiVNPpQygWJLEjbJ0hG1ZXTEfKsHp/+jekF0qxIMP4PHwWXjvqujrOiJGDbIjZibNMdxIlDbSbvSNcYhO5Z+KIl40QJrTdauFt/uekmcw49D9LcogWaZIWU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 DM4PR12MB7574.namprd12.prod.outlook.com (2603:10b6:8:10e::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.19; Mon, 22 Sep 2025 10:05:16 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%7]) with mapi id 15.20.9137.018; Mon, 22 Sep 2025
 10:05:16 +0000
Message-ID: <c09b3679-00f9-43e8-a620-1a6051cc6db3@amd.com>
Date: Mon, 22 Sep 2025 15:35:07 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/amd/pgtbl: Fix possible race while increase page
 table level
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: iommu@lists.linux.dev, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com, suravee.suthikulpanit@amd.com,
 Alejandro Jimenez <alejandro.j.jimenez@oracle.com>, stable@vger.kernel.org,
 Joao Martins <joao.m.martins@oracle.com>
References: <20250911121416.633216-1-vasant.hegde@amd.com>
 <20250918141737.GP1326709@ziepe.ca>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20250918141737.GP1326709@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0220.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:ea::18) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|DM4PR12MB7574:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ab6c166-4a80-45db-6826-08ddf9bf86f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y3VZMmZUUGJrdXRSYWIwcEwrbHd1ajJ0UFI2M3RsOG1vaGhFWHVwR0JzQ2NG?=
 =?utf-8?B?WVV5Uzl4aWJERTBLSGl4UnpIaXR4dy9XWHlqMkJlNGpUMW1CdmJEZG8wVDNZ?=
 =?utf-8?B?RnJTVWFDekgwRGlFUTdWMVdjSDF6emxNWk1nbnJ2dUc2QWg4V1VyR2FMN3Jh?=
 =?utf-8?B?aFh1YzkyWkwxNzdLU29LQjVBUURLZFl2TnNtZVdPaXRzSnZwTS93aDkyMlVl?=
 =?utf-8?B?SWtzTlFjb0JHOUtVSlNacGkwUGs1cmpJajNXYi9kV3BZN1hPL2VsTGVzcG93?=
 =?utf-8?B?eVFiTllUNHZLN1Z2eitiTmVRRUpFamo4Sm81dXVzSDlXWWVoZ0RKbG83N0RY?=
 =?utf-8?B?bTNzRkxtOEFVV3QwOUhKaUdUYlgzZVVaY1d4ZGc4bGFGMDI5OWFyWjQyL3JF?=
 =?utf-8?B?dGJuS2RCd3M1bnJQSXZWcjZ6OXVqeGF0U3M1UlNqQjg3ZGkxZkNnN2gzWU90?=
 =?utf-8?B?MDRFZHBKRXFnRFlnaFhZQ1M5aDBsN2VrK1VvV2kyaUpMYTc2bG1TamtKaWtU?=
 =?utf-8?B?bVlPK0poemR0dnJLdkl5NUdtL0NqSkxYRFpZeFBreHo1a1ZZUzhwU3I1QWZV?=
 =?utf-8?B?bWFlVmRBVEppTFNlMTQ1clBmd3pzWEZHM3A5TmpNbXUwWXRvMCtaWGljMWVZ?=
 =?utf-8?B?bXA5RVhKZXFIMHFTTmx2Tmc1aVd3WmlRbGlZRGNVM3F6dFl5Y1hqQml3N1VI?=
 =?utf-8?B?K2d3TlFQQStkOHA1elVHaStDc1ZYK1pXK3FiSWwvT1U1SnZkSlAzSjNjTlhr?=
 =?utf-8?B?SHF6b0NkR1J0bUFmRFc0UkpmVHJkenZuVk52SEZiWGdnSGZPd0FWYXp4OGl6?=
 =?utf-8?B?WTFwaXlHczhJMXVKZUI0ME9vN0lxbzRidmZXUFlVcGo4WDBZOHFXc1lBdEto?=
 =?utf-8?B?OHY3WkNMNVFSWUFVcUxsOTlGZnk4V3E2WUpDNzVWOHpveDlHK1QvR1ZHd0ZJ?=
 =?utf-8?B?YWdNNm9iaVNMeE85Wk9JQlMzeVJMMklnVVQ1YVFhdHJnK3IzZnBqUDVjYU5s?=
 =?utf-8?B?c3g4ZkY4MktuaXdrVkZKVGNTZjk3YXo0SW5yWTh0SlhubmI2bDFPMVZUMG5G?=
 =?utf-8?B?MEpVSXFmODBVZkxTUEJjK3pIb2trTXQ0MHhXb0VnTU56dlBLa2d5S09oRlFU?=
 =?utf-8?B?UDFkK0hMS2c1cEMzZ2tPQTV1WHZ5SWNDek15WjBTelRma3loVTJXOW1jQUhM?=
 =?utf-8?B?ZVhvVk81TVVPejNpOSsrZ1hnZzQvMm1yMjEyY3A5bjFwZGl0MkV1RXBzanMz?=
 =?utf-8?B?TkE3VEdBUXYwcHVBVTUxWGRJZSt5QVJIL3dRUWpkWXc2MkJVTllKMjVCcTJz?=
 =?utf-8?B?VVpKUURjVytHL2pWTW41bDJ5NHFHOG50eXlnWmxDcTNiRmNmVUl5SEQ1bmtk?=
 =?utf-8?B?QitvekxzdFBGWmQ3Rkp4dnZUT1VJa0F2bUt0R1pqZzhPanhDY3I3TVo2RTdC?=
 =?utf-8?B?NGczUG9hd2RlQU91WmI0YTZyc0pLZ3JNb1orVldNbE8xRkFGc3VNWkVhWWhq?=
 =?utf-8?B?NFZMcSticmZNQXF1QTVwdEdteHR0cEZUNU1GR0ZoL2lITTdOTDNRcTlLUThI?=
 =?utf-8?B?dytXRlgyZnJ1MmpLVlBzTTJBcUxwbmVZWHpyRHhCeElrSWp6QlZmRi9oRHJj?=
 =?utf-8?B?dTBtM0JYaTd6SDNZUkxsL0YvbjljVDlrNVcra2Q1Q0QxS3ZiaExuTGJlV0VY?=
 =?utf-8?B?amZKVGNlUURNTTZncVYvR200dG9abDIvalEwQTRWaHZnaTArbHdOMmE2c0Zh?=
 =?utf-8?B?cVRmREdtM05kL2EyaUdzTnZSNGhvejVkYTJZTHJndVhuYU44V25vZHJtd0lH?=
 =?utf-8?B?Zit4cGRoVm5EakZjK2hkaTZZV3RoNENhM0dSMnVwTVU5cGR6UWZUNzd2MFlP?=
 =?utf-8?B?Z280L3ZacWU1MGI0UDF2bGVsY3FEV0VSbFlhSHRSVXZpTUR6RHBkSktZbzhn?=
 =?utf-8?Q?LDJbRFc0JQM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RjFxZlIvUTJDZ1JHdml3eWRuNXFPNHkvRUR2K0xsenJ3SG9YM2NhbUVZcldU?=
 =?utf-8?B?d3ArSWwrejVWSWxIQUMwVnRraU01V0QrTUhHWUV5RHdKMWVXb0N4Rndqd29Q?=
 =?utf-8?B?cE5CQ3R2eUNmVEpwRkpza3FsbVpCVGlYSzdTL2ZXYzhhekVuWU1UUEh4RUZi?=
 =?utf-8?B?ME9MeC8zTDZDTHZNWEtIWXFwakFyZFRCdGNsbUVqUkZHWHRZSG5SQW4yU3hs?=
 =?utf-8?B?MllzdzBlSFZ4SW05Y1BFQzEzQ2d6dFQ1U2krazFaS0lzT3grMXRsd1NGbGov?=
 =?utf-8?B?cnI2YlN1dWRQeFNoU2ZPMVc3eU92WHZBbWlCaHlxbmp6MFJ0RGJxRHR5N1p3?=
 =?utf-8?B?dVlJYWZMSUVFUnhzNGorOGV2Q25DS0ZtUHhkY2J3dEUxbTdLMWN4cnUwK1NX?=
 =?utf-8?B?Mk9WTnZKMExQWVNZQ2g4cmwyNHZYV05BUmxMWkNmeTI1Zm5Za21jdHdwTEhT?=
 =?utf-8?B?QXYwenkrU0p6UUxKdlRYNERYR2Z6T2dOMHhVa1NRSEZwb2lYdUZCR0RBdGEv?=
 =?utf-8?B?cFFKSDFMU0puQ29tSkFPRWhlQ0tkajhQWnd6OFo0SUh2UEFXbUdaYW41NVUw?=
 =?utf-8?B?Tmw1enA3aS94bncwU0gwMmQ4WHVyM283bFBYNlVwbHpyMzZ4RXRqcUlranFT?=
 =?utf-8?B?WWNBbTZuaUFPS1FOOHpjV0hBcXJNT09qczdKN1dpRVpvcWhYcVFUTzZ0Qlpj?=
 =?utf-8?B?anpwcnVqWmU0SGg3MTZpU3hLcmJXTFVDcFh1QnIvb0U0QmxNaVFtOURtOC9v?=
 =?utf-8?B?ZXdvMHZVSm5PZUlCYWdmTktXSGFDUG80bGEwUTdKWituYm0zWCtqckdUam8z?=
 =?utf-8?B?OTUzd2l0bnlsem9LaU5iaHdXK09kYU1abWJSc2RyM04xRnQ3TUJTVnRtNEtK?=
 =?utf-8?B?RktieEpYSTVzYXhYSSthZ0hmdndHSmNXakpYWWp6djdsTUZXcE1vYThUaDRu?=
 =?utf-8?B?VUFnd044ZkxySnByNmRBVzBVaUdnYk9Xb01NT01FUnZUa2EzZG5Kc0VHQlcr?=
 =?utf-8?B?T1I0V1BFYjNpbFpCUElycldob3I3QVFFZXFEUkpjTERmTkJXNk1BQjE3TFZU?=
 =?utf-8?B?RjhDWHF1NGZsTGt0SGtoSnR2RS9ES1Z5L09CQ2dHSmM0c3RhU2JReEhXajZ2?=
 =?utf-8?B?SFIxZ2liR1dYbUpOUDZZMVdQejdMZ1FmQXdnZ2pNVWZwMTVPdDNWc3l3TFBK?=
 =?utf-8?B?dm1mM3VwakJOakZXcXFOTVZvaEQ0ZzRiRGJ2LzFzeDAray9HTHdiTVJsVWI1?=
 =?utf-8?B?enF4ODN5S0NaK2xYSU5WMzN3aFVFU3ExYkZpMUhZNE5NbkpyTHlYZVEyZmZO?=
 =?utf-8?B?T1psWG9XU1lxOGFveGprL0tFRThTbjA1Y2pXd3JpZERLTE54MnREK20zdDFC?=
 =?utf-8?B?MFZvMVRuSS9LTEl2UEJ0aExabFlsYmNnR2thQXQwYjRlMFNUT3hhL3poNFA4?=
 =?utf-8?B?aUwxNWhJZUs0dmpRRXQrVUdwU0NIL21CWmVhY1lrTWFXTW54KzA3Y3FoRzBQ?=
 =?utf-8?B?RFhSczlSWi9JK0ZIaEd0czk4bUFQVURHdG1yb0ZqYzFRN1pvZUpGa2tXVGQ5?=
 =?utf-8?B?QmdlbU1waEkwSGFlTXdZbkdSVGFJYWdUK2hoSDkrWDhrUGVacnZNNGROUWNO?=
 =?utf-8?B?aTVrL3N2NjRoekxaS2trR2xyUlN2YlJVUXVQT21JamJLdmYyVy9QOHVOVkJG?=
 =?utf-8?B?NFpybVd5NVVnVTRKcEhmdHpzUWVRL01rcnltODFYTm9uU1lQdkUzRTR3SStt?=
 =?utf-8?B?REp5ZjlFWG55Qy9qYzlRaFNVS1ZyRFFuT2VXQ0RyN0QyYS9uYjRNU0NQVGdv?=
 =?utf-8?B?Nk1jbU1ySldPNWZDMmY5SUtWUjA4UWExM093dTloa0YyS3owMU5MbTU0eklY?=
 =?utf-8?B?ZXprR1UzZGk1akEzb0J5UHdzVFlRRVl0am1zVmRSZGdINHNXQU1xWmYzajBY?=
 =?utf-8?B?c0syUTRTOUdpNFFaQjZ6Rk45czNlaVBSVGtzTU5reWZYU0RSZjVCK2l2bXVD?=
 =?utf-8?B?cWRsYm5BdkFvdnYwVVJZSy9yUDVYRlBnbGxLcE93c0pITStVVkw1a0dCRDhL?=
 =?utf-8?B?MmZGR1VXMERBQ1YxSE85aGNjd1VqMVdNV09DRWhhVFk0YTZvWVNJcG9pVGZx?=
 =?utf-8?Q?vBE14tMSYJHLzNXdpnEkUXnCz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ab6c166-4a80-45db-6826-08ddf9bf86f9
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2025 10:05:16.0241
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eFltc/Yxk9+D3YOIBAwe9rj/ns6/DxOSOwKGK8MvkDMNGXqWpkku0iVwPBjV+Rao938bvwm8IyqY3khyEdlqkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7574

Jason,


On 9/18/2025 7:47 PM, Jason Gunthorpe wrote:
> On Thu, Sep 11, 2025 at 12:14:15PM +0000, Vasant Hegde wrote:
> 
>> The IOMMU IOVA allocator initially starts with 32-bit address and onces its
>> exhuasted it switches to 64-bit address (max address is determined based
>> on IOMMU and device DMA capability). To support larger IOVA, AMD IOMMU
>> driver increases page table level.
> 
> Is this the case? I thought I saw something that the allocator is
> starting from high addresses?

Right. By default we start with 32bit address (from 0xffff_ffff to 0x0) and once
its full it goes to 64bit (assuming device supports 64bit). At that point
increase_address_space() gets called.


>  
>> But in unmap path (iommu_v1_unmap_pages()), fetch_pte() reads
>> pgtable->[root/mode] without lock. So its possible that in exteme corner case,
>> when increase_address_space() is updating pgtable->[root/mode], fetch_pte()
>> reads wrong page table level (pgtable->mode). It does compare the value with
>> level encoded in page table and returns NULL. This will result is
>> iommu_unmap ops to fail and upper layer may retry/log WARN_ON.
> 
> Yep, definately a bug, I spotted it already and fixed it in iommupt,
> you can read about it here:
> 
> https://lore.kernel.org/linux-iommu/13-v5-116c4948af3d+68091-iommu_pt_jgg@nvidia.com/

Nice. Will take a look this week.

> 
>> CPU 0                                         CPU 1
>> ------                                       ------
>> map pages                                    unmap pages
>> alloc_pte() -> increase_address_space()      iommu_v1_unmap_pages() -> fetch_pte()
>>   pgtable->root = pte (new root value)
>>                                              READ pgtable->[mode/root]
>> 					       Reads new root, old mode
>>   Updates mode (pgtable->mode += 1)
> 
> This doesn't solve the whole problem, yes reading the two values
> coherently is important but we must also serialize parallel map such
> that map only returns if the IOMMU is actually programmed with the new
> roots.
> 
> I don't see that in this fix.
> 
> IMHO unless someone is actually hitting this I'd leave it and focus on
> merging iomupt which fully fixes this without adding any locks to the
> fast path.

Unfortunately yes. We had customer reporting this issue.

-Vasant


