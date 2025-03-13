Return-Path: <stable+bounces-124307-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 99099A5F49C
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 13:34:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85FCA7AAD34
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 12:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5F221FBC9A;
	Thu, 13 Mar 2025 12:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rQiXWNRZ"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2073.outbound.protection.outlook.com [40.107.243.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D6A262D38
	for <stable@vger.kernel.org>; Thu, 13 Mar 2025 12:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741869181; cv=fail; b=AH/W3OcvmHPAi5p+RFmXdujkmYAO/nNraOlkWRggLBEBdux7SDsv0c6CNiFvsFPZm+lnQxTvlBn55OlgDCFVHiL50dF5xfWM33MmmOOfuzgCTQhawNCwzZmv9if1XcPXRHbAQdb7pTd9yJGOm+nbCJjw9ioT7qc6c5UBMu3NCC0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741869181; c=relaxed/simple;
	bh=hrbrthVl0o4XXiYdIbppf9DRhmy5+BBVF5d4S1qOuAA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=u94WD2rtQlA6j9jQc0kmQkdGQd+ajtr0SCPlBQdfCpZdvgX4rrW+3VHWG7Qn362vqiKPH23ZiJr01AZ+LUA0ZCHaxvB6oY1ta3sQwrryOct6CigzC3/CcL8Rw5FTnhaz6mvzz5It1m/ioelRKOwKPijzBwQQtvfLcDKAzIuPL5M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rQiXWNRZ; arc=fail smtp.client-ip=40.107.243.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WmKokP/U8YXvYsjCvYGgQv4Kn6eW6udme5Zv5u5nTeVzU3D86z2rrpXk3tzuOzbmsvWiO7KaULohTSuUIbTPXCYPTi21qJTa7ubwthnXmGpKfX/BHcFYM/o4CaTyrWORV3RgAjnfujFoH79OmaiQMUyEB6Nds/elAnEqHMoi8NFsWvxL54cENwGCxdeg9Ht42TV6viTgFQL2rPUAZYU/xFB+yS8YpDsF6savQWvPTDF0YwcU7vDJqJq3rjtlFyjqIBRSvKrpaGD4H38twzmV5QRCGNtxPiHSRy1QbFphHxulE1jZEyjBVTtgYObXvFsx6Ki7gK4Z5Rg6BGHgzpSCgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Gur4uMlu/PHhOzKXw08zg8t8Mai5U+ZmlfOMmDnG88=;
 b=l2JPWhxO9X4VjOEdMwov/FowlBeYJ1xyEpra6s47DovOSI8Zi5sGN2r6oeLo8QwhoCGgllarJVGkh4jc/wakBPBH8Qh4Xkzo1JpJncHKDXBgvoExfW3Y74Pi9eCgF5hi/mazyR2ffz7REiOnWymtus9tZQQEPUH0a6RLNXXc3+E22qOXJW2UyYkXk8QiNepmNUX5PZTDmZF4pg3b3injVSkdXg2bhwuPjG59nVIfUXjw6HucY2ND2OMVHCsv0iO2VpuHMEJy9AGccIKbg5PC01d17LJVC3iG1t90bpZL07mD2DuBCQfzK6ECoA7h6RzfNvWIWimzwH+mElJVDcjZFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Gur4uMlu/PHhOzKXw08zg8t8Mai5U+ZmlfOMmDnG88=;
 b=rQiXWNRZ+5J3db7hU4lPJFG98lpn872Fkk3EwcfVEiNnW/bbBdQ9XIOZBoTZu1T34zU2qg8baJIsb/5JkAnq9SJzp7DiBThGfAcI+JKt2oxPTt6qD9XffirxFFnI67+O2MjGk36VNdOQi4a904G/2x3Et1P4S28HV0pXjs2b7Co=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV3PR12MB9213.namprd12.prod.outlook.com (2603:10b6:408:1a6::20)
 by CH2PR12MB4309.namprd12.prod.outlook.com (2603:10b6:610:a4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.28; Thu, 13 Mar
 2025 12:32:55 +0000
Received: from LV3PR12MB9213.namprd12.prod.outlook.com
 ([fe80::dcd3:4b39:8a3a:869a]) by LV3PR12MB9213.namprd12.prod.outlook.com
 ([fe80::dcd3:4b39:8a3a:869a%4]) with mapi id 15.20.8511.026; Thu, 13 Mar 2025
 12:32:55 +0000
Message-ID: <1752a7c9-66b9-441e-acb3-3c5c867fbe8a@amd.com>
Date: Thu, 13 Mar 2025 23:32:48 +1100
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH 6.13.y] virt: sev-guest: Move SNP Guest Request data pages
 handling under snp_cmd_mutex
Content-Language: en-US
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org
References: <20250312223932-352a4f3bf0ca25bb@stable.kernel.org>
 <4b8da939-7985-43b8-b0c6-12e5871be632@amd.com>
 <2025031300-unstamped-devalue-ceff@gregkh>
From: Alexey Kardashevskiy <aik@amd.com>
In-Reply-To: <2025031300-unstamped-devalue-ceff@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ME3P282CA0003.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:220:80::13) To CH3PR12MB9194.namprd12.prod.outlook.com
 (2603:10b6:610:19f::7)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR12MB9213:EE_|CH2PR12MB4309:EE_
X-MS-Office365-Filtering-Correlation-Id: 3451ccd9-d62e-43b2-88d9-08dd622b2dc4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dFJVMy9kanU2cDhwbC82dXVRcHN1YTRUUzVHZXBNRGpieDFFQW02eVh1YTYr?=
 =?utf-8?B?RDk0QVdCcnNneWVSMklFZUtqYzN4UXQvU29UT1B4aG5OV3lLKzh3ejhXeTBQ?=
 =?utf-8?B?b2N0WkFDRHRNbTIwNGNIa2RBSisyZ1IzQWg3UjlMVmxtbVZYNWNaZmVSd1Np?=
 =?utf-8?B?NzBsTGNtemkwbjQyNWNFT0FVR2FnL1VBck9va0thNkJRNHhzOWcycTZEN3hQ?=
 =?utf-8?B?RktxMlZJa3dRMVlLYTlJVjAwejQ5bnR5SkdSZVhoMDhqdHVrbkNVYk12UmU0?=
 =?utf-8?B?VFBKOU44eW13aFJPZ3hsdlVZM2p1RFZOY0ZSWVRUbFp0RFd6ZzhGUFVBNG0z?=
 =?utf-8?B?MlVQYkhUVTQzRnRmZllHRWlEMXovMjhOdENSSm5oY2FEVHg4R096a25ON1Fr?=
 =?utf-8?B?YXIvN0cvNVo1NzJubE0ycktJc01qOG43NTdqbzlhNEUvbGdTbVJoMWlaSUJm?=
 =?utf-8?B?bW9uOUlSWDUwR0xacjVPZ1hadzgzM3NYRzJkbEdwWmFrdEFOd3ZQSU9yb2VM?=
 =?utf-8?B?Z0VJcXA3QXFnV1J2N2NiRkVrZExNUmhlK2tXUTk1bmJSSkZ1LzFzVGgwTVky?=
 =?utf-8?B?aEhpZHVyTExuQkUvS1lSZmx4Y2hnSzRwSjJxa2lhb1JiaFJndUNWV0ljOXVS?=
 =?utf-8?B?cTZhMWt5dXBVMjM3Nk1QRE1aSEZIdWFiSE1DOFlwdk4ycWdNaDlPeHNZbkJN?=
 =?utf-8?B?Y1hOM0kwNDduVFFOek5adWM1SjR5MWcvYXZ5cHNJRnhDc2pvSVJ6akRKQUxV?=
 =?utf-8?B?Q3FJdUlyVkRLQmJFTHA2T1NEamphMlJrNklxOFVKS2xnNy9NelBsMXFjdCtU?=
 =?utf-8?B?QWtFMzVuKzBRVWVtNm13YzdOREpGcDYvaXhwMjRqKzNsaTFzTFJGcXNyMEdH?=
 =?utf-8?B?elhJcG5yMDNOZjlDWmNkU2xiVWlxcmJlQVFDd0x2OGh0ZmVGMlhqbEYvUno4?=
 =?utf-8?B?NGMrM0NIMEdkMWhWT1R4ZFVNdUR3d2ROVFhlSG9xT0dkUmlwWGIwanEwNmJm?=
 =?utf-8?B?YkFmTVRwdXUyQnhCYTJQMlB0aTFYMHYyNkV1NitMOFJwYTNuUDBEbGtnRTF1?=
 =?utf-8?B?K01IY0daOE5rbmJCMHN6VllVYmFIUmFDUzFMdzdQQ3NMRXpCbFE1NU9LV2dI?=
 =?utf-8?B?Z0dPclcrYmxxV1dab0hCNzlubXdLNTFtY1drMDI1Zy9leHF3ZTRUaVVhTWx5?=
 =?utf-8?B?K21pd3FNRDU1aThGazlXdk9ISmxPM2V4cXpxTEZha2ZVZWw3K1BpbXBwYUFI?=
 =?utf-8?B?dHl6SXFYT0p3WjlpWVgxKzBJVmtmVHd1a1JTbTRGVWR6cm55akpodXFROHNV?=
 =?utf-8?B?TjFRTFpCOFpTQlBLUlAxVjRzb2ZCcnZZd1VyY2lZNThVeldGOTNMMGZwQm92?=
 =?utf-8?B?b0JQYW9JdzIvSjZpVjZaUy8zcnNpN0F0bzhqc21oQUdyN2o3N05VK3Y3b2I0?=
 =?utf-8?B?djNsUjhIYnB4dllqUWxqbGQyOEpYUk5WcGNiNUcyeUJWeW5HUkN6WHl0WXBx?=
 =?utf-8?B?WFpZYjF0QlhWMDNlOHVyR3d2bU0vclRGalpmVDNPN0FldW9VMlhGQVRCYW03?=
 =?utf-8?B?eHBvRXB6dzZpQ3VGTkU4U3ROenJpYzRoY29nYld3Q2YwczFSd2JIQllCaGN2?=
 =?utf-8?B?QnJ0bDR1ZTlaQjBTYytwYTFWNytYSWxwelFJRHQ0UGREcmZWMCtEQTl2Zmll?=
 =?utf-8?B?RlRJNUNLV3I4dlpocXMrQ2hGTS9DRnR6YUQ5SlJiRGVHT0xXUFp5K2Z3WTYr?=
 =?utf-8?B?U1BucWhKMHYwaGRJekxnMzlWR3Z1TjJ6aTAxd2Y0VkZScTZNNnZjNnpwcGZM?=
 =?utf-8?B?SjBMOHV4NWd6dDVERkhMZ3g1OG1UWDJuWTZpT2ptUmxFanU0SUdRUjAwcC9P?=
 =?utf-8?Q?Bx9L9tJ23EVc5?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9213.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aVczNFVJeGdhSU5vUUdhYndtT3pQQk9iWGdRV1FMZm1ZTUJ1UnNwV2p1SWda?=
 =?utf-8?B?THd6MUpFbWxwcXdoWXFqL2MwOTV2YmJjSHBEaU52eU1VOTJwN3J1MUorZWJO?=
 =?utf-8?B?VlBzMGRRY0RYUVoyYUQ1K281T1Zsd3d0ZExSczZLSks5SmgwSnR4S1pCTGNj?=
 =?utf-8?B?QU5Ea3E2UjFBV0RkK2xWM1FsMU4xS2NZK2pCeTdDUzQwNzY0SnR1QW1aWjlC?=
 =?utf-8?B?cHBOVExKVGgvOStjOUtOcnBDeTdtYVpTUGxNQ2l2WlVpenQ4czJzN1dPa2hv?=
 =?utf-8?B?cWxmdVZBRU03Z3l0bG5CcFcrZThkZzNkc0dMRjNCSjB3cXFINmZ0M1l6RlZK?=
 =?utf-8?B?V2h1ZERaUFlYbUhTbFRQelNMb3lNS29qUW5PYy95cHNTT04rSlJvblB5Y3pp?=
 =?utf-8?B?K0xOQlZHRHlSUGVRRXdQcmZZT1hWZmVXUVRtZC9Hb0N2OUZRVFdJQjlWc2hs?=
 =?utf-8?B?UW5iNzBoZmZOU25ZTEpvMlMxclBhelAzeHBlelNXM0NNUkxSU203VytCVmxh?=
 =?utf-8?B?aktINmpoaW9GNE15QS9tMGtiTGl3bjRzVzFlczBRTitRUmZTY2UxYVlNcFJm?=
 =?utf-8?B?UjdjTUU0eW5VLzNwNkZzaWs1T3dGR0tndlk4K0RLWElRSTZLL1BuZDJ1Vmp4?=
 =?utf-8?B?bURMN2xQU3lMRUVKZ3lkUnFDR2tiTTVORjR3ejVZelJ5QTY1a1lVZDlUTU4y?=
 =?utf-8?B?TlZPVTBBdHFGNGpCamRwY29aYTF2NlpJUE82U2NncGZYK2tVbkNhNzMvRjI2?=
 =?utf-8?B?QUdYanFUa294cXdYZnhkNXFiQ1V2dzl6aDJRY3BDMVpoREptTWZ6S3hyQnlK?=
 =?utf-8?B?RnRvSFdYZFBiT3NzQkEvUU9aVTUxdGU1NmRTWDE3Qzk0bFh4ZUIrSzlwSmRD?=
 =?utf-8?B?bW5LditkRVZCY01sVUZLWnYzb0NYZVNvb3FjQW1tKzkyK1JTSVJwZnRQdzVZ?=
 =?utf-8?B?aHk4Z2dEWXdZUEhCV0tYR3Y3OW9OVXJxSm5LTlNpT1dIalg4QlBoRFl6YmpJ?=
 =?utf-8?B?amJsbDIvOTB3eW91YkRmUW5EYlAyWVNCSXh2TWhiVGE3QkVudWxlSlBGTm9D?=
 =?utf-8?B?UXYzQjZRbDlYTk9Fa1dyaThkb2tvRzhycWFKbmxHbHNBNEZlT21HN0pISGp2?=
 =?utf-8?B?dXhTRm04MFhQcWtNajdtbkJaM1NPYzhKbnAxZGd4S3NUMGlIODB6aFlWQ203?=
 =?utf-8?B?bjZ5NVMxMWdhclBkd0lSSXJxdTRUZjcybEZBZDVwTTRoMEIyRU9CZE03S0Mv?=
 =?utf-8?B?UXE2K29zUFpKYVVYZW5XazZiM3RWMGxTeVNocWE0elRwOUxSUVdJUW9iOC9N?=
 =?utf-8?B?MHpPOGxKc0xFWTZ4Y292c0JObUpKNjRDUUExczd0aHpQQ2RTZldyenF0Vzdl?=
 =?utf-8?B?ZHBpdDBVcmxXSzhsVVlZWktxd2p4Ym1aQnE4a0dNUU81S2Zsdk9PODB0akdC?=
 =?utf-8?B?MENrcG94MU5PcjN2dFo1WDJMaWZxRnRha09XamllaGhENFlnWGF2ZVJ0MVlC?=
 =?utf-8?B?VlNXUjV1bDFCc1NTVjR5SFM5MXVyanJ6ZlJLOVB6cjVuejZTaXhxNXc5S0Rm?=
 =?utf-8?B?c3dRSWNBc1NCRDJpNXNKYmRjdUFtd1NxMlQzZCsxZFBFSkhJcVJidlJhUHlV?=
 =?utf-8?B?Y1Q5TzByaEtLL3B5ZGVpcXNxdjA1Wmk1MVpxMkFVVnJQS2U4MTVaRWlaOG1X?=
 =?utf-8?B?L1V5TE9vUWhHZkYvc20vQnAvVE5jbTVBL3ZYNkNEV2g3QWxlZUtCQ3luRElT?=
 =?utf-8?B?L1NkWS81TGFRMWdtZ1FsUmVncjFwcVB4WFdQQ0txcmdlNlZRTkxWVkNJUXFZ?=
 =?utf-8?B?MXo1MmZldWlzR0I4ZjFiMkZwSXVLVDBnNGN4dHEzeHRnZi93VlVLUFpnSksz?=
 =?utf-8?B?V3Z2empOQmUzNVM1Qko0b2V4LzJabG9DWnp5U1JUZTZOWDROOHBkOHNGUDQv?=
 =?utf-8?B?bjZlTDRPWHpNUEVNbHNWTyszRFZmZW5uM3VUVXpHMFNwb0dBVURySmwxUWVS?=
 =?utf-8?B?WUNRbEtVWm1qUGFpeHY5WUpDNzQzYmFPZG5JZDRySnoxaGc0d21MTnE4d3Ri?=
 =?utf-8?B?bFp4RUxvNjBrb3dhT1Y2SlQ5QnZ0NDdsTVN5TzFSOVFNcW9jbzhEYjc3eFNp?=
 =?utf-8?Q?vj9aM/AhTtg30GV9bujJnbpIb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3451ccd9-d62e-43b2-88d9-08dd622b2dc4
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 12:32:55.4989
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zg9RdpWEAbEdw3n7loL9q1vhSozGe5uCin3DA5LqrxJ67YLiM5eBS2qvH8cumQWcQplUb9oYIVv5s7eAm1c1KA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4309



On 13/3/25 22:34, Greg KH wrote:
> On Thu, Mar 13, 2025 at 10:09:25PM +1100, Alexey Kardashevskiy wrote:
>> What does the tool not like in particular? The fact they are different? Or
>> the backported commit log must have started with "commit xxx upstream." and
>> "(cherry picked from commit xxx)" is not good enough? Thanks,
> 
> This is showing that the diff is totally different from what is
> upstream.  Why is it so different?  Why did you not list your changes?

A bunch of code moved from one file (sev-guest.c) to another (core.c) 
after v6.13, but otherwise the two patches are identical, I checked 
chunk by chunk. But yeah, when compared via diff, it is not that 
obvious, I agree.

> Are you sure you got the git commit id correct?

Yes.

> 
> thanks,
> 
> greg k-h

-- 
Alexey


