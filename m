Return-Path: <stable+bounces-144174-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BD04AB5678
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 15:49:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6048467A67
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 13:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14DE528E5E3;
	Tue, 13 May 2025 13:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zZYqRgzV"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2059.outbound.protection.outlook.com [40.107.243.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EEFD28DB78
	for <stable@vger.kernel.org>; Tue, 13 May 2025 13:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747144186; cv=fail; b=FpC8Vu8aVH84mVIeMdmRxdYdGoOFhuUWmZBYWfdL0FWiGB8RBVMTsCqKt+hfx+fgrbzrzPYNPTd7q1+pobkd8yOYCzFfNm+mciJyIS/oKdnvIV/E3Y5WkClS7n8QBBl67UjNPA2h4pQ1HEoNSB1t6aK9yIfR/yM43bNyDgmMHnY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747144186; c=relaxed/simple;
	bh=xfw7WWpG0wJBQbXMWxy/sx24a8YRe5g4P9xtIZc/YA8=;
	h=Subject:To:Cc:References:From:Message-ID:Date:In-Reply-To:
	 Content-Type:MIME-Version; b=tcYME4JWeYbI3fc/bl4jw1g80Cd9q0JsXDNHvDz1oagAPVbd8Qfrte4+JR7HWJFfp5iFBphQeS1iFWe7WhYV1YD5+c0yl27c49g6o/lVLikWLge5ZYk1gsMe7sL9A3cAqOeOaoA2UzpyC8oIc+IaohRvZ6cbRlX7QF171rl3UkE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zZYqRgzV; arc=fail smtp.client-ip=40.107.243.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y+JUiLN9pMhskd28iGj9a3wj+AwaGN89pAcmEyzON6/Fm4bzcxt5IaxaugDf7kpiJLMI1vGa0r68Wjk4/qNFfDrYsxnH6KE2FQydOQreXjmVDqXVYBaQtKi05CUGMeNmH7bt62KqFxFUMovauzfms7xQL3pvfGyOtx/a0YH66UZX6vrcSsyp7/fsXh6XE3RsUArjlhQxyZhvt55+Xy5de/74PeK9eN2rpCEANCPa5AvHTxOU4IxPs4Gby5Obz+uJ5mXNkWPqC4GC5JbOowZTjvDJbX2Tpj7F8+KgFliZdXxSg7bj3DTMTyzHWmPHZo5x5vFWDXcsPiiZgI/hqlST/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QQuAeaYGAfA7/rJYSF/KMG0IxUeJEFZExru+CQ6m9nE=;
 b=Byhurz3++8JDGa/2nMbGT7t2m59E4KuW/2IcXcGuTSTl7EMo5VsAFp4sLWZr+9ZiQnDXPPH07La3ep8E+kPLgKQ8m/yLcPoyY7nZqFacu2vUV4EXKJoOtYijJYJC/UUHvMYepsceYQIJaWb2sE4m9PLqyskZ4ym90d9qJ4JK465RDsgsOuW7XrSyCPCoMZXVnARuHN7MjnVSKboVwyAyrCPw3zW3rNz8MqP7PPEqNOhKM8I0vTnfSB4/RNPiLjwgv+3K6lgNk7jMVakI5bdCkostBgn3vmRYwDkTVog+5zVjvbjEUn9t/xue9osj+Th9jU5lrPd5lHQrWnUsKA9OQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QQuAeaYGAfA7/rJYSF/KMG0IxUeJEFZExru+CQ6m9nE=;
 b=zZYqRgzV1yY04aNXs7+L9xmOZJy+j+zgRxG0Cqs8CeEf7Bu6/5DpXdau48vhI5KRCS3ww22PEFrj02yJnoWPk+ReoO6KEQgMR7YhNvCh9KcJ0ZammtxR2ivUHQA8l86oOCHdZCDlLkbc1Gr/uRgJ/6fFcYTRcgN/TPtKKtyuOwI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5052.namprd12.prod.outlook.com (2603:10b6:408:135::19)
 by DM6PR12MB4388.namprd12.prod.outlook.com (2603:10b6:5:2a9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Tue, 13 May
 2025 13:49:43 +0000
Received: from BN9PR12MB5052.namprd12.prod.outlook.com
 ([fe80::7714:4f80:f3e1:60cf]) by BN9PR12MB5052.namprd12.prod.outlook.com
 ([fe80::7714:4f80:f3e1:60cf%5]) with mapi id 15.20.8722.027; Tue, 13 May 2025
 13:49:42 +0000
Subject: Re: [PATCH] drm/amd/display: Avoid flooding unnecessary info messages
To: Harry Wentland <harry.wentland@amd.com>, Wayne Lin <Wayne.Lin@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: Mario Limonciello <mario.limonciello@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, stable@vger.kernel.org
References: <20250513032026.838036-1-Wayne.Lin@amd.com>
 <4a3d9653-cc3f-4b24-b6a9-a2d676e8af03@amd.com>
From: "Yadav, Arvind" <arvyadav@amd.com>
Message-ID: <ae74a933-de1b-3fb2-297b-afec813ebb9c@amd.com>
Date: Tue, 13 May 2025 19:19:37 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
In-Reply-To: <4a3d9653-cc3f-4b24-b6a9-a2d676e8af03@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: PN4PR01CA0054.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:274::12) To BN9PR12MB5052.namprd12.prod.outlook.com
 (2603:10b6:408:135::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5052:EE_|DM6PR12MB4388:EE_
X-MS-Office365-Filtering-Correlation-Id: e88dffa3-436b-464e-2ca2-08dd92250384
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d1FkN3N2SVRtZklwOGt1eDNJNS9KZE9oL3pOUXI1RTZNUHA2bEZhc1hRQkFE?=
 =?utf-8?B?dG12MnV5dzVUSFdFTDJrU2tmZnp2RmgycHFib0hjQm5URmQvK1MwaWJEbXA5?=
 =?utf-8?B?M3Eyek5tMzIrRlBGV3lieWlrNDZhR0lOV1J5V2VRZlFGeGRSakxnTmdHeU1V?=
 =?utf-8?B?ejBsR09wdERmYTJjVm5hYXRwTGR1cGFlSCtVQ1o1RSsyRzl2Ym0va01HcVQ4?=
 =?utf-8?B?bzVaK1ErM2pXeFRXMG9ROWlmM1RFZllod3JJd2x6RzR6ZldhUDlGN0VXMnZk?=
 =?utf-8?B?S2x1Unp6QVlEemNJMDh6N1ZvdSs1VVhLMzFnY29HRGg2Ly9yM2pKVUtiUEVw?=
 =?utf-8?B?MEREbEEwQ3ZzWC84eGVnTWJZS010V1p5dis1ZzcyUjMvWENSVjRNZ3UxQWdB?=
 =?utf-8?B?WlB6Q1g1MnFpNXFCRzhGK1VWQTNUeVFrZGxSbE9yUGlObWRBcW1MOVZBdUNv?=
 =?utf-8?B?NE1sbktBUU9PYlpIM25tdU9PNjVhZGF5cDh1T0Vmb3lnb0J4K2paTHc2YitS?=
 =?utf-8?B?c2hBTGx2RzgwR3cyREQxS3lQMzdNNGhHTE9uRTlreTZkR2hFeDRrWENLL0pJ?=
 =?utf-8?B?SjNJM0kvb2g0Q25wNm9lWGE5Z20vd2orM3ZhME1BMm1maXVJOFRxTW5rcytW?=
 =?utf-8?B?TGE0SENHMWNiQW4yejFQMmlmaG5aZk5ES04xUHkzbFhxSDFtNkxLbzYrQWMw?=
 =?utf-8?B?djc5bGYwTVNvM3ZTRkx4TnI0N2dMOEVBOVo3aXRTZThKczNkK3RZSGo5MzFv?=
 =?utf-8?B?MnFJR3MxREY5MGJvelY4dVh1bzNNWW9ZUEc3N3Q3bWVjSXZnTDhyM3FTOEZX?=
 =?utf-8?B?WjllYlJ2dTFHeHVjWGs4MVZ6b0w3VzV6OEtqS2Fia1dsN1BxSm5xZk9tMVF2?=
 =?utf-8?B?cTkvMWl3VnJjSlYzOWp4aGxKNk5lWFBhUW13M3oxWkhCZEtLMGxXV2J2aGV2?=
 =?utf-8?B?dTVaVktDdTBmdFhRSDlWc3JWc1BpR3dwbTZjMms1Z1ZkTTRyeU5OWG5MSW1T?=
 =?utf-8?B?dU0xRUFwaWlUd3lzWW02OE9uWDJ2eDVZb1RCQjRwU0ZFbjRVWldIVzVEMFBV?=
 =?utf-8?B?dlFYbzRJbEhvVXdmUDJ4VDd5dW5CdmlnUkZZUGYzUFEwbE9DdzRtUUFUYXhS?=
 =?utf-8?B?UDlVS3RQaVdXSnlTeUcydU8zbVE0WEh5R0xISlJubjl0RXJZb2w0eDJMZUdO?=
 =?utf-8?B?ay9BdHg1WlR0bDc1T3hRK3plNWVrZDdFTEN1SmpYT1ErZGJ4dE5ZMkZUMHZk?=
 =?utf-8?B?TCsvWTl0TGFUbEVBVlMxVzB0eCsra0E1RFVIVjdNcWRzT3RHbWVoOWxkN2Jq?=
 =?utf-8?B?VVM4OUJxQ1pVZ0FSVEZBVnBTd3ZYYW9YSUhyOGNPVUVlMWpCVUM2aU5FWGx3?=
 =?utf-8?B?Qlk1YjFVUWVlUlBxb0llbWhXTFZyWS9QLzR6Vk92V3JLNVJ4VExaMTlRbzFs?=
 =?utf-8?B?U1dSclp2dWdmdjdTaXFXUDRqU1pMcUlLS0FrSUEydHVKRlZYdHJKdVluVk1h?=
 =?utf-8?B?bTB2b0RQOU9kUC9qdERrUFNiTGhaYnJoS1VCVFVPMUtFTitlVG16QTdnK3VB?=
 =?utf-8?B?TkV4YTYzUlozdk5PYWdRTnlOMGk4WE9aYzNWR0ZYekhqRjNzM3JXUTVrYWVz?=
 =?utf-8?B?Wjh3REFvYk80MFJwUE9ZSjl3dmJTL05sbW9OMmFna0tXQnRkbFR3UTJtSnRJ?=
 =?utf-8?B?cmxQNUt2UE5ZcW1OZlcvSmNiYkdNZE1JbWkxOC9xRG9kcFlrYzhYU0FmaEI3?=
 =?utf-8?B?cXVJZ3Jmd1k0UklEWkJjK1hBaERwOUQ2QU03a2d2Nmk3TGMzWTBPUkhiQWpw?=
 =?utf-8?B?bDBBZlBKM203aUV3cGFTL2k4MzhYNFVFVnVOaWZnZnNhM3dOelZkUzM5ZkJx?=
 =?utf-8?B?NmNnNGVsVGJMbG5nODk4bitVOFdUNjJJUVFZZXlWc0ZodEZ0bEo1Sm5RR2tq?=
 =?utf-8?Q?87qGbbaxLWA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5052.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TW85eWdEYzJWT05idFJXMEZYUXViYVBqR0ZPM1NwWXBqRC90ODRTdFpjN3NI?=
 =?utf-8?B?VmtlU0NhU2FwY0RnZ2RiZ0YzQm1jUVBFREFRd2gwSHMxVjZZUWI4eURXYkJW?=
 =?utf-8?B?cFlPaUp4K1FqTUNDaFpHT2ZRR1RjVm4wKzNwMVB3S2k5SDc2OExiYmxTVjU3?=
 =?utf-8?B?TkYxMFJ5UmpPciszQkM3VFlQTHNXc29sL05QbG0xbG9SU2xDUVNEK0NTYm1o?=
 =?utf-8?B?amRycUJ6ZU04eVBQeDJWVC95dkhpOWoxVW0xaHV6U3ZORFJyQmtlVjgrRHpx?=
 =?utf-8?B?M3NPdlNzbEZFQXhvTElJZmNsSGM2Ui9tamF3emVUbldmSEhHTTgvbys2RGli?=
 =?utf-8?B?SVhwWklpWVBWYnoxcTNCUGlvQnNjOGVHS2ptUDdvWDFTYlphQkMzRldjekxZ?=
 =?utf-8?B?cG96b29NZ0FOS3VzWWdqaVZFYTBCVjZ6Y2tidHVPUW1PZDJwSGkxK0ZHQ3R2?=
 =?utf-8?B?VVNXZy83N0NXYmNXL1BITmphSU9BT2NFWVFXL3ZMMkhudGJoM2ZhZXYrMFo1?=
 =?utf-8?B?SHQ3eG1tM0s1dXljanpxOFFCUG8wMWJqTVhuODJlZ2VER0JSbVhySldaN1JT?=
 =?utf-8?B?dXRMNmJjZU1obFd2aXlpdm5Mdk5Sa0dHSkZvMDEyMlU2YjB3dFBxa0QvZng0?=
 =?utf-8?B?ZHJrMXlBV2E2QnhjZFFuS2JsQ2FyUmd0bDNJM0hINWtYUk5hUEQ4emdSYUdS?=
 =?utf-8?B?TjJ3c2c0MjJVNGtHc3ZudXFKbm1pQkFJd29sUGRxSi9lMGZENEwyYUNlQjRY?=
 =?utf-8?B?dmFud1ovWDJoL2RDcldxczRBV3ZUNlk0QVkzaW9DdkE0T3QxZkppTGFSOHRk?=
 =?utf-8?B?UTFmV2hxTjhyaytXRGxQYkN3cnM3dC82MEdETnFNVFJIdkVWdTZiV1R4WFNp?=
 =?utf-8?B?YWxoQWFxdmFDaEptM3ZMUlRZa3JDcmd1NGIydkxjazdnVTZZb2drYnVSbXJE?=
 =?utf-8?B?NTFUcnBJRGN2T3B5TzAvNE9SZnFibEo4OFd6OU1mWjJMWEVOM1c5NkMzT1Z0?=
 =?utf-8?B?WFpYb0Zxd3NiclBNMERKeTVsclBibDRZREpxUkFRWTkyNGQvMVIwVzM3cEdy?=
 =?utf-8?B?d2pPdjBHQXQybzJDOTAzNzhub0NtTE9kVmxqWHppT0MvL3lFbFovYklhNW56?=
 =?utf-8?B?aVhqYzJrbTVEZ0liZnllSFVZNFNsek5VY2VoaDAwRlZGVVBVL3NrYWY1SnVj?=
 =?utf-8?B?LzV4cDhEOC91MmQxeVQvc2N0eWRiUHBoVzdUTEpqaXgvYzRuZzVnTDVFK0Fp?=
 =?utf-8?B?QmthYVhkK05sdFltVldrTnR2TlhRZERSaXh5Y0RCVjNETFdYbXZQQUE0eWRp?=
 =?utf-8?B?MGZ6ODFhSjkzQjBYZnpZTHRrcVdTVXExd1lyS05UWmVINHFWbzNHWXBIeEZr?=
 =?utf-8?B?NkFqRC9udHdJZC92WHlGSTBIaXdBcENxZkJQU2VIMjg1K0dkQUhINlY1N09E?=
 =?utf-8?B?NE1jd2NOMWs0ZmpiNGZJRjc0SnpOTDRwZVdOWGhPeHpqbUFBdnk5RytXSUJy?=
 =?utf-8?B?N29rWEw3Z0FHRDdDYjJiektucXl1V0pSMno3am9tOXVQcXpRQXlscGg2ZFhY?=
 =?utf-8?B?UHJOdUJPYVNrQkRGY3JoK0RlaUorZk1NVGFoQnlwOENDOGFINlhpOUtMQmN0?=
 =?utf-8?B?VmlhZjNhbkxRTUdVS1krYlB3Y3NJdDBSY0p3dW5GMWFtL2NZMFFZeml4MVRs?=
 =?utf-8?B?ZUxYODBRUzZsV2diZVdFUGQ2WmZ2aWhuWWd0OWRJNzF1dmlweUlyV2F3VlZa?=
 =?utf-8?B?ZEw4M0pidHR4ZTk1azFyREpXdWluNFVZY0MwZ2d2RzVETHhoeXZYaXhUd2VK?=
 =?utf-8?B?a0pOTnNmenRZUSsxOFJ1QVpvQ25adVAwcko4QjNvYjJRa3QwckxqMjZPM2p5?=
 =?utf-8?B?TE5jdVBWV0NtYlpZVE1RRkVpRWdMTkxDQ0xITzNrVWZMMi90aTFLb29KQWhO?=
 =?utf-8?B?dXdRL3lndFV3bUZEeVB5emw0Q3dvWkhpU0o2cDg2QVpPaWlMbVJ6ZGpFMnNS?=
 =?utf-8?B?TU0zU2sxUnB1bnJGUWorcHJubE9CSnJUMmhqVkJKbDl3OSt3K1RHdHpwcGJx?=
 =?utf-8?B?c0JYZVN3ZlJNZjZiZFFtL2NveFRwOEg1OW5ZOWEwckxRcDVrUzFKdjFHVjlT?=
 =?utf-8?Q?5yPo0ECDYhvuEiuL37FFZnHs5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e88dffa3-436b-464e-2ca2-08dd92250384
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5052.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2025 13:49:42.8417
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ejAiGhV9uMr8GfS+6YqaCsqHPehT0DG6NpAqnRgO3s+ZfcuMMVA2JXn8EYBlu8IkSL8RFuh+zLKk5mlnx6dT1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4388

These log messages are overwhelming during the boot process.

Acked-by: Arvind Yadav <Arvind.Yadav@amd.com>
~arvind

On 5/13/2025 7:05 PM, Harry Wentland wrote:
>
> On 2025-05-12 23:20, Wayne Lin wrote:
>> It's expected that we'll encounter temporary exceptions
>> during aux transactions. Adjust logging from drm_info to
>> drm_dbg_dp to prevent flooding with unnecessary log messages.
>>
>> Fixes: 6285f12bc54c ("drm/amd/display: Fix wrong handling for AUX_DEFER case")
>> Cc: stable@vger.kernel.org
>> Cc: Mario Limonciello <mario.limonciello@amd.com>
>> Cc: Alex Deucher <alexander.deucher@amd.com>
>> Signed-off-by: Wayne Lin <Wayne.Lin@amd.com>
> Reviewed-by: Harry Wentland <harry.wentland@amd.com>
>
> Harry
>
>> ---
>>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
>> index 0d7b72c75802..25e8befbcc47 100644
>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
>> @@ -107,7 +107,7 @@ static ssize_t dm_dp_aux_transfer(struct drm_dp_aux *aux,
>>   	if (payload.write && result >= 0) {
>>   		if (result) {
>>   			/*one byte indicating partially written bytes*/
>> -			drm_info(adev_to_drm(adev), "amdgpu: AUX partially written\n");
>> +			drm_dbg_dp(adev_to_drm(adev), "amdgpu: AUX partially written\n");
>>   			result = payload.data[0];
>>   		} else if (!payload.reply[0])
>>   			/*I2C_ACK|AUX_ACK*/
>> @@ -133,11 +133,11 @@ static ssize_t dm_dp_aux_transfer(struct drm_dp_aux *aux,
>>   			break;
>>   		}
>>   
>> -		drm_info(adev_to_drm(adev), "amdgpu: DP AUX transfer fail:%d\n", operation_result);
>> +		drm_dbg_dp(adev_to_drm(adev), "amdgpu: DP AUX transfer fail:%d\n", operation_result);
>>   	}
>>   
>>   	if (payload.reply[0])
>> -		drm_info(adev_to_drm(adev), "amdgpu: AUX reply command not ACK: 0x%02x.",
>> +		drm_dbg_dp(adev_to_drm(adev), "amdgpu: AUX reply command not ACK: 0x%02x.",
>>   			payload.reply[0]);
>>   
>>   	return result;

