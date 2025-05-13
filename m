Return-Path: <stable+bounces-144160-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F14E4AB5440
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 14:03:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7516F17389E
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 12:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18B1228D85C;
	Tue, 13 May 2025 12:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cji8Auo8"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2040.outbound.protection.outlook.com [40.107.220.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF0880B;
	Tue, 13 May 2025 12:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747137787; cv=fail; b=JzmM2wwj5UWf+kicDYe6n+hbUJeoqxT/WlaGKvDShFjlKwtiOn1t3BnngZPjSDLXcOeCfiYPPvBeRO3HHeIMPb+1fkjGbc9v1gBlKkVOscD5qtMgbxwAx6K9PkhxFuT+tE5cLaHPaxWapOGtKllSIDOySBzBrh+Ip8vXQb1J6sw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747137787; c=relaxed/simple;
	bh=Ag3Kwsk/HsmvGYPZbmyBjONtWK67GJAIEa5fljMGWlc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oMuOIb8AjwXMopSR6b8LAm3tnoIDw5TQidIiYiM21huFHF169YRhQ7x5+ufTolJSwlDpFFqG3XlErM5Anf529RKtByJFy5NSctZJi5eyLB48IQ2d51VGrQq4dIccrwFdXpxYwiCQaAY1tMUOm60mBFxaajoD2DD/S2inLxN1aOo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=cji8Auo8; arc=fail smtp.client-ip=40.107.220.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EWcp7BkrAVEhHFK3m1L3dZ8QSOiwafGsGgFOtIw4wlMD8VmfOsvqYn0sXNyNfSxuWsLwnQau7vBC1Av7y30yoao3D6vLhA7moXwGstnXvwxxTt/d2TY1otbvNhmN9nBSCjJe3UuXu1xp+YlBir54/COlY5mSRmV9N/5XQXC2EML/dzn55/1B53bhJRXx/Nh8MZBxOlRygFgxhwC9IlA15oIbFECRLhTq/vRf8aR1SdCXaP6LKRkDIpjEGgjuXerI1rSBlDAjpt3TaO6kkQCmpv9pdb3bahnlSJu6T1LlgPPs9N//ibWT2Wh3nMlGWfD92Pu2yrewAz24/a/aGhBxLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EbkJZAB0byLtOMa7Xms7zTwzw5PlcbFiD5hplMU09CE=;
 b=RRmLbC8TRbanqmyGEeCjwE/pzVBxkXFIQnrtt8aZmrPJJ3RfjOtFTMkVuY0MD0y0ma02BSs2mjr6UTVlatBgpeTJlAkykSABpz61YjxjhXAfLdtwi4OucZGGXF9yXka/m8glUM9cO9MJztoYJbqLxlE/lZ6PuPi91qeNQ3AROsa9EHrPBJOKP1w4IXPwob1Xfnr2s1TBTbLThaYZ1gtCZskD4hGR2KgJVZqGM6v7a5DIvxxZCbXM6yXN679pxDJ2Z8JGmEFKwb3RGJSg/rmnMRoL/BsvcvIHKpdhTQfNeRDMUaO7tbCJLY+NIIL7iSQ8+78kHgWPDEmF74wTw5CKzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EbkJZAB0byLtOMa7Xms7zTwzw5PlcbFiD5hplMU09CE=;
 b=cji8Auo8xKuLy5gxez3JICB0why/GMxw6pmD4qj3czMVn/J1Zytxi2ZfbBTBdG7R8slxE6G5CUXrNh+BWevu+bkOjL7eH5009dpAN72KZjZlpyG4QCgzSZcvStLBx5gH7a75e0/zsWQk+XQC8Birrv5P3MQT6NU6FM0g72JoGFw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6460.namprd12.prod.outlook.com (2603:10b6:208:3a8::13)
 by SN7PR12MB7882.namprd12.prod.outlook.com (2603:10b6:806:348::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.28; Tue, 13 May
 2025 12:03:03 +0000
Received: from IA1PR12MB6460.namprd12.prod.outlook.com
 ([fe80::c819:8fc0:6563:aadf]) by IA1PR12MB6460.namprd12.prod.outlook.com
 ([fe80::c819:8fc0:6563:aadf%3]) with mapi id 15.20.8722.027; Tue, 13 May 2025
 12:03:03 +0000
Message-ID: <c0af2efa-aea4-43aa-b1da-46ac4c50314b@amd.com>
Date: Tue, 13 May 2025 17:32:55 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] x86/sev: Fix making shared pages private during kdump
To: Borislav Petkov <bp@alien8.de>, Ashish Kalra <Ashish.Kalra@amd.com>
Cc: tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
 x86@kernel.org, thomas.lendacky@amd.com, hpa@zytor.com,
 michael.roth@amd.com, nikunj@amd.com, seanjc@google.com, ardb@kernel.org,
 stable@vger.kernel.org, linux-kernel@vger.kernel.org,
 kexec@lists.infradead.org, linux-coco@lists.linux.dev
References: <20250506183529.289549-1-Ashish.Kalra@amd.com>
 <20250507094211.GAaBsq8zEJMAuffwmh@fat_crate.local>
Content-Language: en-US
From: "Aithal, Srikanth" <sraithal@amd.com>
In-Reply-To: <20250507094211.GAaBsq8zEJMAuffwmh@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0124.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:96::12) To IA1PR12MB6460.namprd12.prod.outlook.com
 (2603:10b6:208:3a8::13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6460:EE_|SN7PR12MB7882:EE_
X-MS-Office365-Filtering-Correlation-Id: e705930e-6f7a-453a-594e-08dd92161cd9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aDROcmYyNldRTm5jTHMxcHV2SGF2S0FOdmtsemIvNElsM2U2ckFrdnRHOUJm?=
 =?utf-8?B?MXQ1WFJaMHJMWUJYZVlZZ2hTWUluWXYzcGZDT21KTlRveTNNNkdBdm1XaHFR?=
 =?utf-8?B?cEVLYnhOVjE1Z3loOXUrRHF5ZHpkcDdzL1NFZzk4bTBuclJidGdyNnpHQ1lh?=
 =?utf-8?B?RlA4NGtvMTg4VUk2cllEYjF3ZkIwZWR1U2tTU2U2ZExpZTNxRmVpdmxGRnNG?=
 =?utf-8?B?MCtoSFRMWFlCN0o5SFFRak5QU2V4YitWVit4WUNZcnFUUVBmY3ZTN1U0Rklz?=
 =?utf-8?B?SGZKMUdNZ28ybDgvTGFVQzBhVWpwTDJrTHJHTW9yK2VRU21WVUlIekJYc3Jh?=
 =?utf-8?B?dlgwbGdoTE5UZ2hoWmxuU0Z1SS9hampJNUhJSUQzNHJuUUE2SGRlK2JyNUha?=
 =?utf-8?B?eFRFQlFmNnNnSzZzWWlPVCtPdHU2Y3U2dkN6ZkpMN2dDWVVKNEV2ajlHdDly?=
 =?utf-8?B?aHBqWnIrQTdZZUJLeDk1RzJ2dEU4WksyenNzZkp2UWM0dVBEUWZaTC9XMWVH?=
 =?utf-8?B?M1ZPcFpEYWNZSmlGV3AzT0Y4Y1QxaFhBZ0VFcDhnNXRnY2lxbW5XWnF4TEN3?=
 =?utf-8?B?d1pIdldIL3ZmVHNWK1NxaVhyTkxwRElpNi96RE9pYmlkVHVzWWsycUVjancz?=
 =?utf-8?B?dzZ2TEpmS2VZNTR6Q2xDMnd3TWp3WDBRZXhQR3FtWFJPZFVQRHpYTVZwN0FO?=
 =?utf-8?B?M2ZxQkRMS1lGaE05ekpHWnk3aURxVjJObE1sYS9YZ25PYTNOb0s1SWYzd09u?=
 =?utf-8?B?TU94aUNBTXhFUnJ5MGZrTFNyMlNTbDJWclVDNlBzSUJpcjZvcEI5bzVNeXlM?=
 =?utf-8?B?SzRpeDRtaTBlRm50OE85S0ViWlNaYmZ0S1cwWnoxdnA5cGtydnpONlhFVHlT?=
 =?utf-8?B?aWRiQ1hOMkpDUGQ2UkIvQUdGQWNwSlZmZmh3TnhTMkpyMWhRV3RmOVRpN01V?=
 =?utf-8?B?ZzBJcy9MelY0ZGcyUis4cVU5RjBkb3lUTTdBSmMvbEoxWTg2R2FFVW8rUnFC?=
 =?utf-8?B?TTVGNjR4clZpemxRdkR4OTlwRCt5dFVkL0c2YnFwSjc5SXM2U0pMUEREbWNt?=
 =?utf-8?B?cGZEdHQ4ZHdIS05idEt2SVBmK0RuMzdneWlJQ1hYbUFWQS9WVTZKZEkvVjJM?=
 =?utf-8?B?NDd2WC82UWxQelJsVGx1ZGg0by9KUFN4cE5US0dqTDJQd1FUVjc5ZXp4alZY?=
 =?utf-8?B?K0NTdi9LK0JPUHVlMXZSMlZkSC90eHB6dWc4K2s4UkZXV083NU1LSU1qN3lv?=
 =?utf-8?B?SU8xaGJEWnJEV1ErLzlvMHA1dFZPYzJXWGhIY2dkcDBsSnVUSlRBWklrSVJt?=
 =?utf-8?B?SkVFUkNMeWlmb0V2UlZUVzlITjAxQVhJSStzYmo2Sy9zc2puQUczNEZvYzBI?=
 =?utf-8?B?VmRhUGJaMkoyWHplT0NGQ1NzdU01OXhZc0JwYkhoVHhqZkwyblpmSy8vOWRM?=
 =?utf-8?B?S04rSUdLSjlyUnhPY0NZcVFUZHEzbml0Q2RRNjVOZTltekY5QnJ0ZFR2TkJW?=
 =?utf-8?B?alV0amIxRVF5elRKajRvbGZrN2Fpb3BGMVJURmo2aUhJUzU0Z2VnZjNxajgz?=
 =?utf-8?B?WGtlbC9LTEFDajd1YTBsblhrZ3VaUHdaMFRRRWxHU1drM2dnZmtVMkNJbnhS?=
 =?utf-8?B?dmdiY3VpL1NUcEtoNDl6RDJaU1hwclhDOWdrV05JRElXZTQyV0hISjF5ZFpj?=
 =?utf-8?B?SnRYR0RnMG0yeTRFL21uMUF4cXBnbC9EbDJEQlVROXk4L2gyd0c2TUJxQTlD?=
 =?utf-8?B?anJlc0lYZlBnTnBOS0dWbFpvUFlqSEs1RFUvOTc1K1JYelV3aDAwRERNMTRm?=
 =?utf-8?B?WVplYmdGczlRc0djL2RLcGJOSTE1aS91a3hITkRVTU5KSFN2dklTYXY2UUZy?=
 =?utf-8?B?M0Q5QmRCNS9FdWllUlZhMHh3bEJYUFBoenI0TVlwcmFxUTE4U3BiYS9KTkNF?=
 =?utf-8?Q?ROMmNK0IzLg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6460.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aDkyY2NKZk9pa0lWOEsvZW82dEdVM3VVWEh2ek5hVjVBMUFqaG5rczRIVVlP?=
 =?utf-8?B?Rmo3aEFiU0RrdC9xTGFYSW5DY3AzUGRNWGVTa3Z6MlZldHU3WWQ0NW5CREQ3?=
 =?utf-8?B?Mm5heStIZUN0LzdQb3hIdEhqWWZlUnEvV1d3MmMzT3pLQmc1SmJPUlRzeUls?=
 =?utf-8?B?T3RzR3c4Qk1sU3hVQm1Rbkd5M1hHWmM3SXRvNWQ5T3VwNWs0cHJwODVYdDNY?=
 =?utf-8?B?ODNGZ0JPU24zcTJxRTJqM0N5R1lzdXVKSzZPZUxkWHhjMlRIaTBWeGhGN3pX?=
 =?utf-8?B?NERwdWVycnFZMDZqU1RDQUVsNmo1YkJBTExDWi9kbGdaWEZOaW1nU29DOGRa?=
 =?utf-8?B?b0N1N3JiWVNyMytNSmZVWHBFRlhLVUUxamhUb29SRXNqbCtrWFRnNlJSNFVa?=
 =?utf-8?B?VHZWdmh4cWFjVitBYjlCM3VKYVBnZDZrVWVyU25rWGlLNndRRFFsVkFDZHRi?=
 =?utf-8?B?OWd6T2FpNS9PTVdDSjNOV3BxNHg4aTJjT3FVb2FBS1l3ZE1nT0hhZjYyUnh3?=
 =?utf-8?B?RVBLZEw4Q1c1NUlEb1JsNTFsNFlyY1ZHLzExcXduUUx5YklpUkdnRDBxOFZV?=
 =?utf-8?B?QlRzbkVickRjOWxyR3Q0WWRWTDB2NnM0aUpkaityM1BkejBRS0ZYb0YrNklp?=
 =?utf-8?B?d29VMHJHMHQvWDlGZUlNalI2YXg0SXRhUDlHOVk5Yi9Od0t6Yk5qOW5wY2hB?=
 =?utf-8?B?RGxDWU9CdVhFT1hHZUVwRmFpNlR4bWdiVUNMVVVnS0ZwcVZia0krMUUzZGM5?=
 =?utf-8?B?MkMxVkVhdTNNK0ZadzFlNll6ajhMMTFhcmNOTFh0YVJVdHJqRkYvUzVMdmZR?=
 =?utf-8?B?M0oyc0xvNWtVWGFUTTRUQ2Fla05LcUNiRytJb3AzTGZya1prNnlZR1BjVmFz?=
 =?utf-8?B?dWowMXVwRnZ0Vk9sclZqWndTMG52NXV5Q1laWHBveTNmMXdWOTFGcFRnUTNF?=
 =?utf-8?B?MlVmYzE5cDJQR2wrTFNTby9ZanNvcVpLM0U5c1U1eGxpdm5teDhNZGdnbnkx?=
 =?utf-8?B?bzhXVlgxRDZSeWN4aU5Pdkd1S3JTVnFKS29EM1NPMjg4WTZkT0oxMVhWdndl?=
 =?utf-8?B?YzlWVkY4MHN4SDNqRHZsR3VrTGdrcm12eUlRVXBkZUJPSnRLc2dmUElHTnlE?=
 =?utf-8?B?Y3VCdVVTSjVFcXorVWkxdzlWTnczZ2o5UVpzNXc3by9mUkxvVlQxV2xqcVlJ?=
 =?utf-8?B?QU9tZ1Q0SW5DOGNyRVRkaEhRaWwyNE51NE5lWlpZSkFKUlNKRzYyVm9RaE1m?=
 =?utf-8?B?YXJPVWZaYkRJdW93aFdWQTN5OFFzSUJRTXVOdlRjSHdPdklSQXVJd3pMcmo1?=
 =?utf-8?B?eEZqZ2JuRi9UUmhaOEMxNm42NU1HVDB2T0E0SVZRSjRISkR5UmY4ZTZISWtK?=
 =?utf-8?B?NXo3Yk55OHN1ZHdzVVFSZXF4Mk9vWHUvVy9Ga0lIZEg1clRtT1J0QWtSZ3Fv?=
 =?utf-8?B?VmRreUxvVGFNckhoT0dzcnhmZjJudFBEL3h0aUt4NjlaMzhYZnk4NEtSWk1s?=
 =?utf-8?B?U0owRk9NRStONk0zYU40RGdjdW0rY2NVMU1mVXBlTzF5SGhSNzBLanZ1Y3RJ?=
 =?utf-8?B?L3c3Y2wrMVJZb3p5UlJ5a3pkVzRiVmxPM3BzMENEYTFTTnNLZWJtaThyWWRi?=
 =?utf-8?B?TTlKVGxlR2kxTHlGcTZvcXFuK2ZINmJSWUY2RkN4TDNBdEdPM3N3QVVqYzgw?=
 =?utf-8?B?OTh0cGdwL2Z2VVNqK1lPMnlQNkxDT3BSeXg0a05INFo4b3oxU3FZM3hMREd1?=
 =?utf-8?B?WFgyekFERXNlYnhRUFoyZDA5Q1BBeE45bTdjTHhtT0x5cGJ0WkEvVHlUMjJx?=
 =?utf-8?B?R3QvOVE3d05RNUNONDFkRUplVDBqU0RSN0g2YnlmdUVac2VLWVhKeGlxUTB5?=
 =?utf-8?B?dkJqWWRva2lYMjBuR0hJK1lMRm5PUCs1a3NoSVJWS2hucHQ1TytiYy8vRkoz?=
 =?utf-8?B?SjNpaTZvMVF0OXNpTWhlYXdERGxoUkx6MmorL1UzOVdiOFR6REZ3K0x2ZEI2?=
 =?utf-8?B?OXVPYUlZYzluTHNDbllMbDBDZGcwRmk2dk4wcXppU2ZsSHR2MUVJNlg1NDFY?=
 =?utf-8?B?WUhGSWN6blZqRmtxQ3NzTVgrUU9hUzEvVWNJNjc4WjlhaXJ0cmM3Snk0cU0v?=
 =?utf-8?Q?Yi61FR7Jxi3pQWHlOOvZWQCg+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e705930e-6f7a-453a-594e-08dd92161cd9
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6460.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2025 12:03:03.2191
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OPgHQx9jJgjxfIi+jdj3tnHqcIWEPBS0tMkFDU0kUYT3JpCO/Epl/HKONOwZw6C+U41mfx76mNfNCDw6xMeRBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7882

On 5/7/2025 3:12 PM, Borislav Petkov wrote:
> On Tue, May 06, 2025 at 06:35:29PM +0000, Ashish Kalra wrote:
>> From: Ashish Kalra <ashish.kalra@amd.com>
>>
>> When the shared pages are being made private during kdump preparation
>> there are additional checks to handle shared GHCB pages.
>>
>> These additional checks include handling the case of GHCB page being
>> contained within a huge page.
>>
>> The check for handling the case of GHCB contained within a huge
>> page incorrectly skips a page just below the GHCB page from being
>> transitioned back to private during kdump preparation.
>>
>> This skipped page causes a 0x404 #VC exception when it is accessed
>> later while dumping guest memory during vmcore generation via kdump.
>>
>> Correct the range to be checked for GHCB contained in a huge page.
>> Also ensure that the skipped huge page containing the GHCB page is
>> transitioned back to private by applying the correct address mask
>> later when changing GHCBs to private at end of kdump preparation.
>>
>> Fixes: 3074152e56c9 ("x86/sev: Convert shared memory back to private on kexec")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
>> ---
>>   arch/x86/coco/sev/core.c | 11 +++++++----
>>   1 file changed, 7 insertions(+), 4 deletions(-)
> 
> Ok, I've pushed both patches here:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/bp/bp.git/log/?h=tip-x86-urgent-sev
> 
> Please have those who are affected by the issues test and report back.
> 
> Thx.
> 

I tested the failure scenario with the patch hosted in the referenced 
Git tree [1]. The patch resolves the issue.

Tested-by: Srikanth Aithal <sraithal@amd.com>

[1]: 
https://git.kernel.org/pub/scm/linux/kernel/git/bp/bp.git/log/?h=tip-x86-urgent-sev

