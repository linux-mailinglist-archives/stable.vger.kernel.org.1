Return-Path: <stable+bounces-137023-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF4A6AA07FD
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 12:05:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCAE31B61CBC
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 10:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03FEA2BEC47;
	Tue, 29 Apr 2025 10:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="N6FD9xJt"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2058.outbound.protection.outlook.com [40.107.243.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC742BEC31;
	Tue, 29 Apr 2025 10:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745921096; cv=fail; b=ZB2b9pkkHMPimhG1zhNjC+yBZoeRH3FXs7CVBsy2MAc+6zBCJFbhJKswc5L92w0loGuXEZmyL8QleWzWx9CmL1US+RaaSDHyhCULqtwU24AAOnSVNqdFPN0cRKUI/VzVRFi4gayS/WIKWnn2cLEa7pB3vHK3BNvN/UwpaFtNZ7g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745921096; c=relaxed/simple;
	bh=MPvccsTW0SFoD3yKGn+3vmAJmGC+f5xjoV1Haf/RwH4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GPov7xL1cL9puSROPzwMqvoerKA44USOLqRu2UjidX0fIiyA1Z8sSDisKytFspOUoonZs60QL+S8GS+2lp5Pn5YPHUtVVEdO+m5p0wsEAiwxeOtzM15nRyNENOaBH+f0AQaI43JtBhvID7k2Sf54nQbH9lupDPjDjMsSqKr8R30=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=N6FD9xJt; arc=fail smtp.client-ip=40.107.243.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pZtXaWuq6L4kkLccc444+T5XSawkXS2O1J0RERbuEwq8t2r8kuub99E3NDcNvmOdWcg1rEWQdTWYrDQB3+nW1BYAulUR3FecBgqraZvcbMzAqbflKkyD3jbf5Zyh3mcRLJGDDMVn2zfUlM15OdRJsfP/icF1AfBqE/pVGlVs2Dbf9o4dtIpzj++TS4TVQFdXQPKaezwAFoQjD77VUJhp2nf6Al/dGDuo2yD9cWbrvZUak/j/4LTY88czJVPyviYwCA1CifIvUm1VAvJUyvRY95zPYhkjN9O4YSVjYDhNd2BOOy+vgyOVofaWAgUj1pigvFZmNeouigz8qlrUD9laFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zJ9VhtCiUG5nUFZbZRoqY8om32R39Ne0XOmBTBU962M=;
 b=agsNo6jqDrpPZqv2GX+hmlPLBfXT3u+ApE53SURloif1agyzGvTVt/xdH4RJH2GW/CxQmJRMLT4YEApJ6oRvRW7r9Ef0bOStjJ8A0ikp/ItL8/r2wIFhRewpyff9bbSlvs6p5VQp6D/rIo9Nmyh32C3gGy0XzKVHkfDPZ3dJMDd3A5Lt1U+m9gR8VQKKyyhVA56ngFDushy2a4ph42IMq5OWkJzP8ztrYtIEGSDuNVWaIcv3UYPqD06uDkiydVBvH1mIhgrh6XUtuRE/H5R1tZal4zJWP31mIivoIIhICf+oTq5jLtbIH4PQKYlYrnM/DxKiUiYLz3Odr8wrJBNr6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zJ9VhtCiUG5nUFZbZRoqY8om32R39Ne0XOmBTBU962M=;
 b=N6FD9xJttLRUHK5FonZwwkZ7unOU+W1joExsqOnxgtvaIsZwnWHl/ps9UcMQT26Y1eku1PafTDfDt0bCeboqDO30735ilmVd/L0Qmwsv9UgBjdZ8b1aeR7r/QC0EoA4dbDBENlNs78O5Vhr6QPlpWhyBcG1br5rfnDPD/10x3V0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by PH8PR12MB6698.namprd12.prod.outlook.com (2603:10b6:510:1cd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.31; Tue, 29 Apr
 2025 10:04:51 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%3]) with mapi id 15.20.8678.033; Tue, 29 Apr 2025
 10:04:51 +0000
Message-ID: <99d29701-6257-42bf-a1c4-1707c3eb54c1@amd.com>
Date: Tue, 29 Apr 2025 12:04:40 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] nvmem: zynqmp_nvmem: unbreak driver after cleanup
To: Peter Korsgaard <peter@korsgaard.com>,
 Praveen Teja Kundanala <praveen.teja.kundanala@amd.com>,
 Kalyani Akula <kalyani.akula@amd.com>, Srinivas Kandagatla
 <srini@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250422142112.2364822-1-peter@korsgaard.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20250422142112.2364822-1-peter@korsgaard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P194CA0032.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:803:3c::21) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|PH8PR12MB6698:EE_
X-MS-Office365-Filtering-Correlation-Id: 425086d2-0087-4541-1279-08dd870547e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WTlsL3BybnQ2R0FwQTlvRnVQZnNCSzJDcVRaT2xabTBIbzJOMzUwT0hDVzZo?=
 =?utf-8?B?N0ZSeStjOVhqRE9EK1REd0Z4UkpXOGdkME43WTduQXNzZi9aeE55WlJIRXZp?=
 =?utf-8?B?MWlsbFpyYjdZTGMxV2VmeStwdklXaG5wYTVvNld1Vmk4eno1U3pUUzFobWV2?=
 =?utf-8?B?aURJeFlpdUw1d2ZnR0JoWlI2dnBYWmFFck13bFU0MjNHOFNySnZBMHUvZ3Jt?=
 =?utf-8?B?ZUlMSk55d1M5c2NOMGJzbEJQTHBJL29BMXk0Z2haY1k1UThkaC9oRmllRXF2?=
 =?utf-8?B?UmtQSCtJMGdZaVEvbWlseVZPR3F6ZjBnNlV6UUlZMGhUbmhiWWl0OEpRR25s?=
 =?utf-8?B?NDByT3hpSlI4VmNIZTlKRkxYWGN1UXpCQndZbGx2WnJKdUVQcUpkZ2NTVEpM?=
 =?utf-8?B?c2RvTmlYMHBwenhSNENad09qbmM2bTg0UWlOeTdHU3VkYkVlZkhpOHRVb0Vi?=
 =?utf-8?B?SVgyNU1wZS9yYURTMWVDeWd2b3g0dGpPTWxyL3JOMHpqblVuSmQ4ei9tWTJm?=
 =?utf-8?B?S2s3WUxsY1FNV3FUQ2pTSmVJbytjblBwOG85Q205d3B2TXptUnhzM3ZZWmpP?=
 =?utf-8?B?WXhhcG5BaHFhVWRMNS8waUtBOWowdHpBbTBEcFVkZGplNjQ5YVdrbUQvOHNS?=
 =?utf-8?B?cEdLSXN3UDhjV0VMNUx5R20vTndkUGxTaHpaSGl6V083aEdQVzRhdFJ4eU4y?=
 =?utf-8?B?bUlZenFPLzI5aE1ObHRwN2tPVzFwS2RtVWs0aStHZWxLSGR0Q2V6Z3pSdkps?=
 =?utf-8?B?VFgwMTVMeXp2RWJKNmI0R2ZBdEh5Zjc4VkdnN0p4RTM2Smkxc0x0YU84UHd2?=
 =?utf-8?B?QjJyNnVRcEltK1FzTi9Iby9KQ3piMnJFQVpITGFoWXk3YTRleFFDeS8rSXhP?=
 =?utf-8?B?ekt2b3poREtweWJJRzZRMm4rbVBKZUhIbCtObXM2enZydVdybkI0MVFtT0FD?=
 =?utf-8?B?UEF2ZEZhZ3d3a04xczhoVU0zRGtxN21yWHVvSm9ZcTFmYk5wcGhVZjhORHVm?=
 =?utf-8?B?b1BMWjhoYWdkUGRnOEh3dTloY2VyQm02TXBOcldOS2lWcWNlRndYVFd3bHlN?=
 =?utf-8?B?SE80d2xma0cyLzdiNWVhckRza1dWWEpBMjBVSWkrdzc1Qld3VmRYeFZyWjk2?=
 =?utf-8?B?Y3pyNTRyWi96VGdPYStIQ0xwY0ZPQ2xDamwvaHJNMW1NZ09zVW94L3kvWDIz?=
 =?utf-8?B?cGJCZUQvU1Z3dmR4cWFudFdSbXZmRVZPeWIxM2N5QXcwZW8yeG9acG5SaFRH?=
 =?utf-8?B?enNNVkIwcXFMcmlaaDJYK21sdkkzcVJYVERpdzNtNnJQK3YxSWlNTSt1SEox?=
 =?utf-8?B?ZmxBY0dZaGRxUUlNeDhQSFI0bWx0UnAwZnFxWXFCRitGaGlWaHZWZ2tHVlY3?=
 =?utf-8?B?bUFDcExEZDl4cVp1MW5oWmFlMnRDUjJKYko0QUZNVFBnTUVGOU84MU1FUUZm?=
 =?utf-8?B?Qit2K0ZrVEZJc1FxT0ZVcStYSGdnSU1CUFVicFJnSEl3eTJManJ2T0JTV3JM?=
 =?utf-8?B?MUxwWEc5ejg2UDRXemN1Z3ozbm9UVFpkQkxnOFVXSXp1QklKSzliR0Y1bHBS?=
 =?utf-8?B?aWpCb0FGVlp0cEx4Mm12aGdsK2xoMVFhN0xnTEJRUU43YVl0Q0Z2SDdTVFFv?=
 =?utf-8?B?eFd2Sm82QkhCOHdpeTF6Wmw4RFI1MkpCUVZ5Q0ZId3BtT2hwRkI1aTgxK0tX?=
 =?utf-8?B?eWxhVDZuZEszR1ZBR3BLSVlWV2hMdWdQbmI0MHBYWVVFZ3JRenBMQkpQcUIr?=
 =?utf-8?B?Z2pBR2tsZ3ExYnlMNUVqSXJtbXRmWDJGY2Mxb3VTejU0TXhHWWRRQmdFTjI1?=
 =?utf-8?B?SkxHM2pqUDAxeHU1bmdtc1dhMFhMeVJtdExNcWZHYkt4Zm96Wm9nRS9ReEVn?=
 =?utf-8?B?RE1QTGxhWm0xM1hoWGZKN2NQaGRZM0RoditLQnZDRHFmYlpldnJEYWhKNlBV?=
 =?utf-8?Q?ATo4XmzJkiU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8109.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bWlBVWZPckRTOWEyVXBSU1BBK0ZCckRiMjdKZnMwc05TQWNoalViN2h5RURv?=
 =?utf-8?B?TEVadzhHazhaYUErM2Y3WWVJK3lpS1I2bDdsVkJ5YktRd01kUkFRUUZETCtE?=
 =?utf-8?B?Q21BSnBNK0N5QkN3dmllUjVBaFpGV1dkcVMxUnlLNWlUTnBpQjhteC8wMWh6?=
 =?utf-8?B?c3dLenhkVlNtbUQxcGdPS0RkZG4zRGpobDBWcjNoVkNMMXI5bS95Q1ZQQlBk?=
 =?utf-8?B?clFjUW9GZ3ZwaXpDTE01UEpPNlkrSzJUcCs0U3BzcG90Z3pVSkJUeVE4ZjVw?=
 =?utf-8?B?NmNUUC9KRFNLeHdWSExIQ1VMbkJaeUlLcnY0dW8zYmlGYlJPZWVDRFJqR041?=
 =?utf-8?B?eUwvSG50R3NwM0xVU3hzdHo2WDFQc1lrTzRNQUJLY3drRXBpb1I2WVJOK1Ir?=
 =?utf-8?B?ZitmZjIwNFRYTUlGc3hCU05YZGJ5ZVdjcXdKVm9LRm5KZUVQVjh4UGRiNTF4?=
 =?utf-8?B?SzZqUGdoZ3J0dEpFNWFzZ0tLWStSOVIxU01LZ3Z2ZFpCdHNncVBlcUFUckRz?=
 =?utf-8?B?eHRNb2VwYWxJUDdlWFhYK1ZXTG9lSlJpdlBta202ZE5aVTA1c1JtSnRnaE1M?=
 =?utf-8?B?RmI4TlBIZVNLZWFsNkYwT1pKTGN3MkhjNUxDWmg1WWozZmJVcDJJcU9nQm9h?=
 =?utf-8?B?ajRRSXhpNXlIRnlEaEpVeWNhTTFHSk5FMDk3ZGcva000eUUrQmxyOU5XNGJZ?=
 =?utf-8?B?TXdkSWt2TitmTUlkUFVkNng0SzFTaHArZkljMWdqWTJtY2xUL1hScDZ4UE9p?=
 =?utf-8?B?bEE3VDU2eERzaEg2VEp0WEY4dU4va3FxY0dLak9IQkRSRkpVU1QzTjJ2eW55?=
 =?utf-8?B?VVQ1d1A1U3J6amNUUG9mYVBkQVZCU0R1SFBjQlpVNVdXMjRkdDJ1SWE3VHpy?=
 =?utf-8?B?YmtnaDM5QW9FbjYrcTFHTmZ2NnYvQUlwTFJWYUZCT2FyaHZTNGEyWWZaV0VN?=
 =?utf-8?B?VVlQY3ZqMzJSZXlVVWVDSjY0Y1FCbVRrbGppMktzYVZEelFjeFRaMDgzVnlN?=
 =?utf-8?B?MWxIM2ZINy8zczR2d0RIUzcxcU5TcUdLRFNNLys1SUp5OFVlSytmaXJmOVEr?=
 =?utf-8?B?NHczNUlQZUFnU2VuRUpmU3p4aFBjZ2JBQWU0VTBteU83ZGswS1B0NUhpblJ6?=
 =?utf-8?B?NHN6SFNZVjZHL0xEOG9MdGo4MUVWckZELzBPMS9wdVZaVi9zNmdjSjViMzJI?=
 =?utf-8?B?Rk9ya3l6TUUwaHlCM2djNnZkWFhvTkpkVjc0ZDh2LzdDVTVPZzFMTHZTYksy?=
 =?utf-8?B?RmNsazdWY3NZVUVRRWd6cUd2T3FGK1FCL3JVSDRPNXl1d0p6MzRENlpyRnFs?=
 =?utf-8?B?cit4VXZUaDBwVm4xc3B2Z3ZlS3M4VkNLTDg0eDVJL0IyVHhxQWxKcFZ0bkR2?=
 =?utf-8?B?SEM4R1RXTWUwTzRhQkZkRVlFR21YcmNOV2ZoU3VOalBVZHFwYUwzaU5JRGQ5?=
 =?utf-8?B?em4rZE8wcjJoR3ZRdER5VUpqZGtRYXcyVi9Wc1VZNGxnWHBWQTNyWkFtUzB4?=
 =?utf-8?B?bGp5UUhzYkpJMEFNWXJDT2N1RWNjdWpicFF4NVFWZEhVeFNsNmhEQkRjdEFW?=
 =?utf-8?B?UEpHV2pzSjlSbW5UK3VRMzh0MDkxNXFCMmozUjFIazhhbnB4cXVobmF1aWsv?=
 =?utf-8?B?TVp1YzdjOHh2MExIQ1FOM3V2MWtDN1RuV2t0T05BeXQyR1RRT3JERndwR3hq?=
 =?utf-8?B?RDMyOFF0WEVjV0ZBTjRIYUJ4emtGZE1KNFRMUmZROXNqSlpENyt2bk5weWtG?=
 =?utf-8?B?N0J1cW96NERDMHZRU0dSTlVRZHhCRWUrTm5hNnR6czJTUExibEFyVXNodFBq?=
 =?utf-8?B?QTZ0SmxpeVV4cjdBSUZXbytSOHorOU9sZDBrL1lMVzJzYmJnRDdsb2JxVlIv?=
 =?utf-8?B?ZTZzQTl4cHJncUNtYW9jZnEzZ3N5enl6T3dFYzczQkNyZVdYOVA0ZUl6b1Iv?=
 =?utf-8?B?bmFROXJJYzRkZEcyYTNUNzcrMFMrTjFwUjdMeWROMzczMjhlR3AyMGhTSVJl?=
 =?utf-8?B?Y0VPMzZyVk1iWExKbkxuRjJOY3lzRmsza3orUlVmeGZrVXF1emx6UlZZY2Js?=
 =?utf-8?B?NGFZK3pMY1B6K0kyT3B0Vm5KazNOUFhLMlYyWHVia0Rnek0xd0FhRjdhU3Fq?=
 =?utf-8?Q?JCNTXnGmbOz1n/2Xl3pydn4WW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 425086d2-0087-4541-1279-08dd870547e2
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2025 10:04:50.9930
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dTDcnuxmT6lLSDzwYaZYnfg+d4HE1cs/NjF+HKBiSjRM8EEyIxDqtaQPbNmaGMld
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6698



On 4/22/25 16:21, Peter Korsgaard wrote:
> Commit 29be47fcd6a0 ("nvmem: zynqmp_nvmem: zynqmp_nvmem_probe cleanup")
> changed the driver to expect the device pointer to be passed as the
> "context", but in nvmem the context parameter comes from nvmem_config.priv
> which is never set - Leading to null pointer exceptions when the device is
> accessed.
> 
> Fixes: 29be47fcd6a0 ("nvmem: zynqmp_nvmem: zynqmp_nvmem_probe cleanup")
> Cc: stable@vger.kernel.org
> Signed-off-by: Peter Korsgaard <peter@korsgaard.com>
> ---
> Changes since v1:
> - Cc stable
> 
>   drivers/nvmem/zynqmp_nvmem.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/nvmem/zynqmp_nvmem.c b/drivers/nvmem/zynqmp_nvmem.c
> index 8682adaacd692..7da717d6c7faf 100644
> --- a/drivers/nvmem/zynqmp_nvmem.c
> +++ b/drivers/nvmem/zynqmp_nvmem.c
> @@ -213,6 +213,7 @@ static int zynqmp_nvmem_probe(struct platform_device *pdev)
>   	econfig.word_size = 1;
>   	econfig.size = ZYNQMP_NVMEM_SIZE;
>   	econfig.dev = dev;
> +	econfig.priv = dev;
>   	econfig.add_legacy_fixed_of_cells = true;
>   	econfig.reg_read = zynqmp_nvmem_read;
>   	econfig.reg_write = zynqmp_nvmem_write;

Reviewed-by: Michal Simek <michal.simek@amd.com>
Tested-by: Michal Simek <michal.simek@amd.com>

Thanks,
Michal

