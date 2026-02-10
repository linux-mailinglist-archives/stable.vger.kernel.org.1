Return-Path: <stable+bounces-215599-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id COgcDOmvimklNAAAu9opvQ
	(envelope-from <stable+bounces-215599-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Feb 2026 05:11:21 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 88AAE116DAB
	for <lists+stable@lfdr.de>; Tue, 10 Feb 2026 05:11:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 043203012C57
	for <lists+stable@lfdr.de>; Tue, 10 Feb 2026 04:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AACB31355C;
	Tue, 10 Feb 2026 04:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WwOT0AkO"
X-Original-To: stable@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011028.outbound.protection.outlook.com [52.101.62.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E2F330DED8;
	Tue, 10 Feb 2026 04:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770696675; cv=fail; b=pdsayykKIqXobCzUDO0hTN9iIgPYQcmYG4te6UZXr5giMichZKnfKJ14eyMXR0BDMrKAKc7ye9ojZFMXUYCwjFpAWS22axX9T5B/CgMhOxfvTBzGrzaJ/9el/XaFIT0luftVL0qK5g3UOBbaPftWjM5gFY3y97pfoOR6V2TzNzQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770696675; c=relaxed/simple;
	bh=uUlL6pamdwoEY17HqGeQWYQBzpEeK1XhVz8We2wLzOY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mZNeOUdeYOvely9g5DHv01JYaMwsV4Y4dBgFSBsfMzIN2tJaUHlLMluO56okDAadjScMRfgO3aYLY6cl8S6a3NvP04+wiWtXTZzvyOqOYoZFzimuO6AbNb9nX6Q38EHQ/ofJLxRyrlcpcl2q124Dz228nbmKIqB/haRgqNgT9+Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WwOT0AkO; arc=fail smtp.client-ip=52.101.62.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rViS7Rz5tGeucimKIl4pMNN4pGZDFiYFJPISbxuVq8v1NA0QpAiCjB5a1rtCrbQwY7P0D6/ubMSUNf6PvZHvMyxgpYPUWKDtxKCE5Xwe2ShtsEPzUbEkT87cRuLkud7lrJvyE9o58Dnb0GpRiOQdbxvg7lIEF0qB4lXJhQKWo/MTNvDC9nwD3KnrxUOKKNaV/3e0KNMI8fQvcQLpBy6dupdVEEEKIDpD18FiJYCM8G0TrPQn7RejjYdXfLY43X9PTHmUFT5RU+PXl6rUomXmevmd3O2C4/ozKlj2tJntIAm8wG9e9nCJwO472aBjq6QF29nS5QdKOzPxVPQUV+0O1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uUlL6pamdwoEY17HqGeQWYQBzpEeK1XhVz8We2wLzOY=;
 b=UzGAewpHa1nOkY7Qgd43FGsXCGoBtR4oUvKR/Bl1iDd0SmNYx/8NiMiFIJo16M9YV8l+y2N2caSDpMVsQoRXC9Hkkaukkg1EkdEYWfnaddAlJFalqsUzndIXbKQa966Tdrzgy9YDx8BKtLfm1xEWYBmBRmx4/DoiH3Ph61Cmn/l4dgHpveyqLSI4XRy2C3K4+ReuG+VJREknPz/gUeHX7t8ONtjVJ5TRNjWU04SPJWjAg0aPDVHO2yx0gWr0Ccz7faHq5G67sSR7IKbmH8qahB546N7ZT3bwUkEkCqOwYMWI3FH7z610h3WWr/Lc8kCTkaBYklHH5JATsgTCViQZuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uUlL6pamdwoEY17HqGeQWYQBzpEeK1XhVz8We2wLzOY=;
 b=WwOT0AkONHp3KAGy6h0yDPGCa9r8tluKsMTyAFj7Foj89CqBkTp5lCKQ+xf/MAUBzAIdXD8IJFfg2wwov+BPLXQC8bf5gnH8A8ydgG8a7jojkMNB65kEifbUDJL+AECeg9nRRP+qU7mBx1pqix+5rVhHtmJQmXaYSc89wT/rxhqqGypr/j37stjJFOi0PVjCOEn6BWMg4VvfnDfEBVq87xOoH6YHK7C81KVLUT5KCTTMMxcTteU7MoXlkDxHkgTYY3IxBoz6IwMfJyY4qhNPftPJb/XzzcgFFEoNI5eEPDaOUvv6K2RMTzKTK5vUTjS0UxCC/UH8QkuLl7cEb15pFw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB8245.namprd12.prod.outlook.com (2603:10b6:8:f2::16) by
 LV2PR12MB5894.namprd12.prod.outlook.com (2603:10b6:408:174::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.17; Tue, 10 Feb
 2026 04:11:10 +0000
Received: from DS0PR12MB8245.namprd12.prod.outlook.com
 ([fe80::e7c5:cfca:a597:7fa4]) by DS0PR12MB8245.namprd12.prod.outlook.com
 ([fe80::e7c5:cfca:a597:7fa4%4]) with mapi id 15.20.9587.017; Tue, 10 Feb 2026
 04:11:10 +0000
Message-ID: <94458c39-587b-4bb4-a410-e921e5d99f10@nvidia.com>
Date: Tue, 10 Feb 2026 09:40:44 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] PCI: tegra194: Reset BARs when running in PCIe
 endpoint mode
To: Niklas Cassel <cassel@kernel.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>, Vidya Sagar <vidyas@nvidia.com>,
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>, stable@vger.kernel.org,
 Thierry Reding <treding@nvidia.com>, linux-pci@vger.kernel.org,
 linux-tegra@vger.kernel.org, Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, Rob Herring <robh@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>
References: <20250922140822.519796-5-cassel@kernel.org>
 <20250922140822.519796-7-cassel@kernel.org>
 <2fedf28e-83ea-4e51-b1a1-e45f0e928509@nvidia.com> <aYonDJyd_dbV0GBK@ryzen>
Content-Language: en-US
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
X-Nvconfidentiality: nvpublic
In-Reply-To: <aYonDJyd_dbV0GBK@ryzen>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5P287CA0050.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d3::14) To DS0PR12MB8245.namprd12.prod.outlook.com
 (2603:10b6:8:f2::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB8245:EE_|LV2PR12MB5894:EE_
X-MS-Office365-Filtering-Correlation-Id: 5281f8ab-c21e-4869-1a00-08de685a6bdd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZlN1cjAwc21mMUd3d2JNK2RCUEltZ2YzTXlJeEEyZmRKZTlrMm1sNlJTNHBi?=
 =?utf-8?B?bTlsL1Nzci9SOXZYT2NMZWxCdVFsbHVuTFA4UExLSm9MbHRpSFBCcHVERmhG?=
 =?utf-8?B?M1pVdVpwVzgySkcrSFVjbU9IQ2lkRGRMejZ3NCtOTHE3ek9LNjhTL3hiSEFm?=
 =?utf-8?B?QTEvejFWbGlUam9CL1p3ZkU5T2NXQnI0NVBPdDFNWEpKSFVneTkrb28vdk50?=
 =?utf-8?B?VWdyekN0WU51MC9kRmdQRldOaXZSTTVJenFPRDNyUmNobXg0SG12ZzZPOHNx?=
 =?utf-8?B?b0RlWHluNEpHSVBCT2l6TnYwSVIrRTJoMURJYS94VXM5UWlnYnFUaURyd3ZD?=
 =?utf-8?B?cVpkTzd0THhSU05yTjlxUGx1SVA4L2tNUTFxL04wbWZrVmxvRFZ5bzByNll4?=
 =?utf-8?B?V1YvWjNlQ0RHcncwNHRnbWJSWExUTS8wQ24rME9yUkRZWGV3Uituam5PS3FB?=
 =?utf-8?B?QkIrTFFURW5OZnRwRWhiL093aFVjMnRGblRuelJKOWlheDhKUHZrM2gxYUF2?=
 =?utf-8?B?L3pXaStTSzQrWFd5cW9PaHVhdE9oZFVmVjFRajI3RHZNZU9kYnA4eVNYdUFt?=
 =?utf-8?B?UFZKZm9qTmQ3NDV3UTdTWHFtTmdQam1ZdlhsVTluK3Z0Skh4Mi9Eb3hKdTFh?=
 =?utf-8?B?bTllZTgyK2ZWazR3bzBoSGJ4QXRjVHcwdStmL2crOW1HdG05S3A3M3ZUTlY0?=
 =?utf-8?B?REF4ditxbzFCNXZKdWJPMjk4clRDMDZSc1RqdXhkRGdIaXJnVTh3Zll1MCt3?=
 =?utf-8?B?RzdodkI0Z1lmbHMxbkp6TTZBWVVaSW4yeGE2RkNCLzl4bWpTaHVqMTBCVGVR?=
 =?utf-8?B?eW9aUnp2TkM1ZW1OQ3ArMXA0ZDlnWlpuZVFHSCs3WmZyWlRMWGQzRy9mZkYv?=
 =?utf-8?B?c0NPQ2hsUjJKbnNWWDNtRjhsVWJlQnl3U1VYR2xWZDZURktKQkNudWgzcEJ2?=
 =?utf-8?B?cmVFQVEwL0Fza0RuU0dUb2lSM0srTFU2RERyL0Q4cEJxN05Bam8wQkpKaVBY?=
 =?utf-8?B?aitIMUVDNWZ2SEtoSk9yelY3T1UzQW5PcGJIVWEydEplRC9kZHF2TG94TDI3?=
 =?utf-8?B?QVMrR1JJWlVma3pQNXBTZmNqbll6aVF4L29pcC9nQ2NWT2JpRVk2MW5qY3A0?=
 =?utf-8?B?Nzk1Y21SaGtzcmZLeGZzeXJlN0tLWEx5K1FEMGtqSllZUVV1bXNXZ0VDRFAz?=
 =?utf-8?B?R0xqTG1sT01CMTZHUDFTdW5OdFFRZHNKWHkwdVlwTVM1OGVhZml3ZXdkY3Q1?=
 =?utf-8?B?akJLN21yM2w2NFJmM2EyNnpzbGdiSE5tdkFERWdOSnArMVJiU3BGOWp4U3RU?=
 =?utf-8?B?Q3BYeUpTdzR2OUlkS1lMdmZIUUV0eXllMjRUOWEyQUd3K0xZMEY2dzREQ0Er?=
 =?utf-8?B?TnlJZW5YYTIraG9xZUF3dFV2dWpBc0xXd2d2MlVJWCtZd29QZTV2VGZWeFkw?=
 =?utf-8?B?OU5OL1oxeWRXZlN1YVBWMDl0QURjZS9iRzZnUmhJWEh1UEJWTjJFY2s5Wita?=
 =?utf-8?B?TWREMDlPazF2c3F3TEdRY05FNVlYRlFJb2lzdE5mLy9SQXplWWtvckVwUGZk?=
 =?utf-8?B?b0tmLzkxMzgyaVdRWWJ0ampXcHVUV05ZTGs0bUJhVTFuMDlsbGVkbGJLWmk3?=
 =?utf-8?B?MEw3OW4vS013bnh0S3drN2RxK2FoUGVkOStWS1RVemhIbW5uMnhwNVR2OEZ0?=
 =?utf-8?B?SmdXTXVieUo1SUdSRVlGZU9LYWpOeDIrODhpc1FxU1ZhSUZic1BObUxnV2h5?=
 =?utf-8?B?Uzc1cmdVMTl3U25sYlVrZ2k2MUtlTXFsT1NGOEwzMUVVTzcwUU9wbktXQzBt?=
 =?utf-8?B?b3p6cTl1NUVLbFhLNGdNMG1FOTBjWXg4ZGk1WFFtK3VsYTBhejd1SkpEWWdI?=
 =?utf-8?B?a2lLMW9RRlFIK1p6WVJoNXZWV1A5S3RKYjkzZy8wUEozQzRGbzYxdHNLT3k5?=
 =?utf-8?B?WHVUYWNneWtTV2VSaHBVeE1QbUdNTFhtMk1zV3YweStUcDdCaDZVb2h0RjNm?=
 =?utf-8?B?MXp0bWg1bFQvZ2tibkF1RnBSMmlnOFkvblAycDZRZmFVcnIrTHZFMXpPVkNP?=
 =?utf-8?B?QUhQZVBkL050MFFUOXllN1pWanFrTFBxOGNEMmV5clpLZ0E2RXBOM3QvUUtZ?=
 =?utf-8?Q?mUYg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB8245.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SVFka1hKQTBSOERiRllHSFZKUkFmcUlJOHgyL2g0c3hyc3NleENBUHEzNkxu?=
 =?utf-8?B?N2sxRFBFYmtWTHlvdW1MZzU1R1VuMVdsZUxiajA1UkxnN2VYK0g5WVVZNWJt?=
 =?utf-8?B?YndtSkhGR3JwTDErZzh0NWlSbUF1WTZ6UWthamJocHI4UWxGT0FSeGFORzkw?=
 =?utf-8?B?S1FBd2VHYTdhSTd5T1NGMzl0RVhkUVhORnJ3eXUvK3BUYlhVMTc4ekZqcmdQ?=
 =?utf-8?B?bzc3WmpKUGlYYlhWb1VjL0tjaXZ3QnBEQVBYUnRBdVUwbEwrNUdxc3FEczVI?=
 =?utf-8?B?RWVhdHJDUklFcnRjZlZMTjlsd2N5ekVXenNSSnUycjVuWlJCTVRLZ1JraTJs?=
 =?utf-8?B?VE9uSXcrN2xUcmJCam0zeXhKUndNbGV2YnJmTFdFUkt2S3k0amFkNlBZQS9N?=
 =?utf-8?B?SmdoK0hkOXdkeG9nMTI2eVhacm4xWHVUQ3ZUMWxwOEFJaFpidFFzVEJENDlv?=
 =?utf-8?B?VWsxRHhja0MzQjlDdmJsNGRtQkF6YmdTa21HMk5CeUFhRStWTzhHVGJ6bkV6?=
 =?utf-8?B?c1RGVjFVQ1FxZnl0UEVNSGNOc3V2WWkvOUJIWXM1cURSNTVweGZUWk1kUjU4?=
 =?utf-8?B?UExzbmoxYXBLL2xpQUxBUW83UzR0NVg0ZWlyTTdYa0RwNnFJWGg0bFBiZElJ?=
 =?utf-8?B?bzlvaWpmV3FSSFA1aG5GWUJwZTRFejJVZVpxM3dtRDYvemROREw1MHNoMzA1?=
 =?utf-8?B?L2VKNWpLY2RRU3RLNzVCV1RBaFMxT3RwYzIvYU14TmFmNlo1SEdUUWQ3b1Qy?=
 =?utf-8?B?aW93clVwb0htQ29QQlg3UzJmRlpNeGFPY29rVVA0bjZ4eXIxazlUQlBRTm9h?=
 =?utf-8?B?b2tXUUxXNXRYY2dHSmlCc0dHNHR4bHdZbzlSSUhGU1dUamZiTzdvTFh4ZCtH?=
 =?utf-8?B?Z1JBc2NBRHVLRkxyMmRNTEsySWx1c1IvcHVLcS9LS2FBYWNXTVR3Z0t2dElP?=
 =?utf-8?B?ancrb09VOUlyai9MV0lhMnRiU1R3Vk9mR0M3c3V1WWFrWFVXWDdjSVM3V3dK?=
 =?utf-8?B?RmJJV09zcnR5bXRONHdIVkdsbE9LTHh0ZlgrZ2dLa2ZDWTZWc0V1eW1pOUtr?=
 =?utf-8?B?VEJua1F3Mi9nNlcyNEdRd3hma2dhVHg4YkltcGNWbnJGdnM4NWQwaGsrTXkw?=
 =?utf-8?B?SEkxZ0ViNmxCZmdpN3I3a2RtbGx0cVQzeDZEa1VpT3lIRXFxUGN4QlVrNjhx?=
 =?utf-8?B?dEVUdUt0b3FydmYveDBzSFk4SHJ5R3NjTDQxUGFDNHZRUGVVV0s0R2VkbjUw?=
 =?utf-8?B?OXVxamlUcHBycS93Y0V4S3FiY01JTUJWMzFnRUpVb2ZyUS9CandkUFNONldX?=
 =?utf-8?B?ZjVNT1BDblY0WERyUW1OQUdtTndSK3lIOE90MTBsditzR1UxVk1DUkV1SmF1?=
 =?utf-8?B?RXZsNlNSaHVVUG5CWXQvTW40ZzlkSnA0eExTdjJNLzY4WjVlQ3JuNEFIb05W?=
 =?utf-8?B?K1BEelRScHhOSUlOQVBpMk1sbVl2c2tSNGZ0Z1RQTkhYYjhvRmw0bWNmb1hw?=
 =?utf-8?B?ZHFHMS8rOEpZRVorRDF6NEtKWC82aUVEcnAvSEVmS3h5V01vQ1ZTUzM1Qm9l?=
 =?utf-8?B?Zm5YODlQWkxFcGs0RDVlNGZRYTBZak1ZSmdPNEdyRWMxR3FGOVZ3Tng5TzZZ?=
 =?utf-8?B?dENiMjNYSjZWeUtSWllyMTNuL0EwOW5YU0dXVFYwUThPWnl4eWszQ2svcXY0?=
 =?utf-8?B?aFpuTUZRZzFnaG0vQTJQdHlJVmRzZlYrM1JicW9idlB2ZiszQWJ1U2NiV2Zp?=
 =?utf-8?B?bUgxV0hydXdPTnNoRHpJay91YkNpc1k3Q0NzMTRuekx3TTZvRm9yaHl4WXFT?=
 =?utf-8?B?SG1rVU9QQ013ZzJCTzkxeGlmSGN5RldoU1BBNEdUOTE3YUF0Z1hVaVhMb3VB?=
 =?utf-8?B?YkxWZlNMcW1mOHJibEtldTk3TGhoa215b1dtb0w4eWlBbThQRU9wVTg4UVZv?=
 =?utf-8?B?YkxEUVFIcnNmRm80OHhhZDhSTGhZUGlMTW9ReHdMdUQrVmJGNTF3NENVL1Vl?=
 =?utf-8?B?R0syNHNKU3d1cnlCMVU0SXdrVW1XSzJ1b0hobE9JUGhsL0VmWDViUStZWmcr?=
 =?utf-8?B?cGg2RUMwSTFQTFpUbmRIY0xNaGJuRkwxSnFDYS9DWFczb0QyTGhld3hGZ1Rh?=
 =?utf-8?B?UkFqd0dlbS9PaVJ0TGVVSTcxT20xYjhhSHNKbEQvbGRDaWlXNmZEU1Q0UElZ?=
 =?utf-8?B?N1J4bm1LaXZOYmVxZ3I2RDdIdGxLTEpjVlpMRU9udk5oQXlDSUNCc1VzaUZZ?=
 =?utf-8?B?blZyOFBpSDVLK0xLeWFvbWd6eUVHTExtcXlrdW1reHd6TFRKbFdVclJDWkYv?=
 =?utf-8?B?Y2RJZm44UzExcTRVWCtPblFXZ2FWcDdvVDRCQXpOTFJrUEI2UzBmQ0FHbmJC?=
 =?utf-8?Q?f5I8IhqY6aS3OlBA=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5281f8ab-c21e-4869-1a00-08de685a6bdd
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB8245.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 04:11:10.2878
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GQLnU5SuVjusj53lzrwXCgEGqb/MveOtLZ5oLeWBAfJ1aGNOv3c0UTTau3Oe02aUzePjLOebVR2vmMQGM+6y6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5894
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-215599-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,nvidia.com,wdc.com,vger.kernel.org,google.com,gmail.com];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mmaddireddy@nvidia.com,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 88AAE116DAB
X-Rspamd-Action: no action

On 09/02/26 11:57 pm, Niklas Cassel wrote:

> On Sun, Feb 08, 2026 at 11:41:42PM +0530, Manikanta Maddireddy wrote:
>> Hi Niklas,
>>
>> Tegra PCIe exposes only DMA register over BAR4, not iATU.
>> So, the issue described in this commit message is not applicable.
>> This patch is disabling BAR2 and BAR4, after enumeration I see
>> only BAR0. I think we should revert this patch.
>> Please share your inputs on this.
> If you look at this commit, it only disables all BARs by default,
> which brings the tegra driver in-line with all other DWC based
> endpoint drivers: dra7xx, imx6, layerscape-ep, artpec6, dw-rockchip,
> qcom-ep, rcar-gen4, and uniphier-ep.
>
> A PCI endpoint function (EPF) driver will still be able to enable a
> BAR that was disabled in .init().
> However, an EPF driver will not be able to use/enable a reserved BAR.
>
> Look at e.g. the code in pci-epf-test. It will not allocate backing
> memory for a BAR that is reserved, so having a BAR enabled that we
> have not allocated backing memory for is wrong.
>
> Commit c57247f940e8 ("PCI: tegra: Add support for PCIe endpoint
> mode in Tegra194") is the commit that marked all BARs other than
> BAR0 as reserved, so if you want to test BARs other than BAR0,
> talk to the author of that commit.
>
> If you revert this patch, tools/testing/selftests/pci_endpoint/pci_endpoint_test
> will once again fail the consecutive BAR test, so I think it would
> be wrong to revert this patch.
>
> If it is ATU registers or eDMA registers exposed in BAR4 does not
> really matter. The end result is that you overwrite eDMA registers
> that you should not be overwriting when you run the BAR tests.
> (So BAR4 should absolutely be marked as reserved).
>
> I don't recall, but if you overwrite the eDMA registers, then in
> addition to the consecutive BAR test failing, most likely the DMA
> test cases will also fail.
>
> Have you tried running
> tools/testing/selftests/pci_endpoint/pci_endpoint_test
> ?
>
>
> Kind regards,
> Niklas

Hi Niklas,

In Tegra234 PCIe, BAR1 is MSI-X table and BAR2 is DMA registers backed

by PCIe HW RAM and registers. EPF driver shouldn't allocate memory for

these two BARs. This is the reason for marking them as reserved in

Tegra PCIe driver. DMA registers are exposed over BAR2 to allow

PCI client driver in host to transfer data from host to endpoint

using endpoint remote DMA read functionality. BAR test fails on this

because not all register bits are writable. Consider NVMe example

which has RO capability bits at the start of the BAR, it is not correct

to add BAR test on these bits.


I think following fixes are required to address this issue,

1. BAR test in pci_endpoint_test should skip MSI-X table.

2. BAR test in pci_endpoint_test should provide option to

skip this test on known reserved BARs, maybe we can use

pci_endpoint_test_data for this.

3. EPC driver should provide BAR_DISABLED enum to disable

unused BARs.

4. Tegra PCIe driver should disable only BAR_DISABLED bars and

leave BAR_RESERVED untouched.

5. Return NO_BAR for both BAR_DISABLED and BAR_RESERVED in

pci_epc_get_next_free_bar()


Let me know your opinion on this.


