Return-Path: <stable+bounces-141939-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50D4DAAD0BF
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 00:04:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 006574C7856
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 22:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D561217642;
	Tue,  6 May 2025 22:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Hvtvu8qw"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2041.outbound.protection.outlook.com [40.107.223.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 413A3273F9
	for <stable@vger.kernel.org>; Tue,  6 May 2025 22:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746569063; cv=fail; b=qVlz4yQfJRuzMjiIi+xA+BlSnawAwbPuK6yAyJDq5W8DRbWVOiVBtxIjX2MvVHHD3ZQk1N+6DX6eiOKtF9kL+Ul8sxNZRHPQSwAzj2o2EfNc/sF5rDyQccxyLsv608eHt0skNYXd7t0hTxP2OB5/ypf4rmaC/Jgw49JVk24vD/4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746569063; c=relaxed/simple;
	bh=8GOuv94O7Z1rQVlEbnsKkaxis/9xD9nrzOcEb/iaDr4=;
	h=Message-ID:Date:From:Subject:References:To:Cc:In-Reply-To:
	 Content-Type:MIME-Version; b=k/KV/RGSSpOumZL9XYXJuswPdDhII8Q2RJWvOzZYRQb3eV4VgBV2sAwuSSKIncbN6GR4nbMG0GSGmp9+aYyHO5dNfurM24Ts+QcDJni956nV4bnbIqPKjL773sMGRGjGghPNcAqRycdxoWuTu1PE3tL1JVob8AWxBEFjTuREAzg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Hvtvu8qw; arc=fail smtp.client-ip=40.107.223.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sqQNdgCgd4uxeCzgaKZeUSQ1kTWtRQKtE7hRg388T1pNjFaZn0vDieQD1FbZIhQJNwJcyLWWJ0480FuHHUVVoRNLXtOWiw0PwV0Wi+ik2WyQ0nf2gE/0DAOsJlRyxJCByUmv54DgEQVSnVoQrFXbolKbJdbwOR8mm2bSLTtm5A/jOdOYOAlpbh7kXLit3/C5GvJ1/pR7ZF7nuUIQma1ucBUqkCK9+g/jT4Uq65RZlZisfvM+hTVoDx0SXSL68+c7atfpqhWjdYo/44qRucCMTf2uxHjPtifS70nQqI6vRkfWv5Z5ebhFeTft5YWHbA0OEFKaZgAPKlD1OOIz+U6lWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PhSgHkrAQiVfxLvkDzUPmBBzi0/VY3ydq5M7On8cksg=;
 b=ANiz7l3hftHwRSer/QSQTosGzdWbt6xi5SXt9BvG7cgNc+vR5MGcVWvtpeiU0cahRDkx88tcP/IBsFJ+219HnzcHoo7npcFvvh8k3lvRHNeMj7vIa3o98YnLwhY2//Jnz0v4Ni++p0u35vhtOW11l3Pj3qbnj9KoEqeM/5pfXBXPtHW8KK8t+FDxlQZxbZ+kY7IineKW5W6BsP7kETtQ/IOYtJcNL0YeAhxMAvBufZ6tSImQTo6pLEys9/YR/LoArewsA8+j6/aJyAbLHZvy8xaka4lDcKNJJK7TEAzPuldxCQNvEwtMJlABtY7euaLabJOpuW+j1l23oxPuPP3YZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PhSgHkrAQiVfxLvkDzUPmBBzi0/VY3ydq5M7On8cksg=;
 b=Hvtvu8qwFf1yQOS6O3nkUGVlnSmQj8jSYWbVVotFiHajlLEO7y+9YvF11FpO8EruDnv2zsgTaLC9W0uV0AzlmAFflE0UIgGRAQyJ+HRdzQNMkNzTKfeirZ05B+OJDs0b8LrQd60wobVkDlq24OizjzWkpDmppNZcNivOWo8dgg2XlBEX4lNKbjVNPvl65pLMRWrEbQ66DYcj9/0+lJNlrCvuUST/fzQUeYuivKN2hbJijTmPKdAttl/UZLVdZn+g2CdqXX6tupqgVq0S+Ec+UgKLUE+l6MeLzap4PQ73M6QLC2Vb+gncDeBy+1lC9MYOttESHBdBZY6ZLgFoy9t39w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6363.namprd12.prod.outlook.com (2603:10b6:a03:453::9)
 by PH0PR12MB7079.namprd12.prod.outlook.com (2603:10b6:510:21d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.20; Tue, 6 May
 2025 22:04:16 +0000
Received: from SJ1PR12MB6363.namprd12.prod.outlook.com
 ([fe80::bec3:4521:c231:d03b]) by SJ1PR12MB6363.namprd12.prod.outlook.com
 ([fe80::bec3:4521:c231:d03b%5]) with mapi id 15.20.8699.026; Tue, 6 May 2025
 22:04:16 +0000
Message-ID: <288a6b85-3bd5-4dbe-bb3c-370f33687c02@nvidia.com>
Date: Wed, 7 May 2025 01:04:10 +0300
User-Agent: Mozilla Thunderbird
From: Jared Holzman <jholzman@nvidia.com>
Subject: [PATCH v1 6/7] ublk: simplify aborting ublk request
References: <20250506215511.4126251-7-jholzman@nvidia.com>
Reply-To: Jared Holzman <jholzman@nvidia.com>
Content-Language: en-US
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
 Uday Shankar <ushankar@purestorage.com>
Organization: NVIDIA
In-Reply-To: <20250506215511.4126251-7-jholzman@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TLZP290CA0011.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::19) To SJ1PR12MB6363.namprd12.prod.outlook.com
 (2603:10b6:a03:453::9)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6363:EE_|PH0PR12MB7079:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c00b194-34bf-4920-059a-08dd8ce9f144
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|10070799003|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dmxZVkRHTVBMWkdCeWxwVE5LbGdoYnluR2RiR1l5QnlkNS81TlFRcUh3NUVK?=
 =?utf-8?B?cGVnV3J3SWdyVlZLdTAzNUZ1bDl6TmRVOEZCNWlxVHI0SEdnS2JyTitPSzQ3?=
 =?utf-8?B?dW5lck5BTlBadDQzME5ZUmlBeDB1eXI3QjljVmxENnl0dVdHeDVUYVJIcFBH?=
 =?utf-8?B?dVRtTkZHVEdJY1ZKNnR2OCtiSW4yb2NzeTl1RThSZU0zMEFxVEdMNXhPbzU2?=
 =?utf-8?B?Sk9ORlpSNldxeHQydzR6UkppVWVrYmUwL0FxeFlBVTlWdUhiYnlSNzFrT3pi?=
 =?utf-8?B?Ukl6eTRlNzhwUTlSb21NMDE1SXJBcDZNclk2bTY0TGxhK2VKZUE2bjRUZFho?=
 =?utf-8?B?T3RyTkJtb2NQWkJUVTByNGRxV0x6WW9LMVFxbVNqOHBITE1Gb1VmRWhsZW5H?=
 =?utf-8?B?dXo5YnpHRnpEc0JJaHYwVURmZlUrTlNrWnlvUWR1RzlMdXVFNnpYa0pJZTRN?=
 =?utf-8?B?TXJzVHhOUmVQTE9uRDdVcTdxMHNhdi9Ta1JmTXRIdHYwOFhPclg2MnJndVpq?=
 =?utf-8?B?UmJwOWx6OHZVWVhvbzVIR1prd0cyeGtrWGVtemJTVWJ0NUk5N282SGo2TS90?=
 =?utf-8?B?aDZlRU1BVTQ1cnZwcDM3SGVPdm1La3I1RDl2djdjN1lSRis2T1hzSXpGekRh?=
 =?utf-8?B?ZmZpd0NrdEpHSkdJdmNiV05aTVlqSjluUGNuWEdIRlo5MUU0OVBMejFJUTVr?=
 =?utf-8?B?cG9CTjhWYXhWb21GaWszUGkxWWErdVVWclRtWVJRWEExbnZIaFlyb2NQbVBi?=
 =?utf-8?B?VHp4UTRFOVZ6YWhQSGNuc1VndjZlclBaZXY2Tk9yUVJ0LzlxSkFTaUtraDJw?=
 =?utf-8?B?Z0dFaEN4a0g3enpTQUxTcCs3K21Hc3NRVjhLdG13WG9CV0tIQ01FdGpXNGVX?=
 =?utf-8?B?S3lvZWRvaEFOQk81bEY3UGFWdWxLY3VIL1pBSmJKcit5VmpObEZyS21YQjh2?=
 =?utf-8?B?TG5qV2prTkpRb1hmNXVmc2x1ZWxTYytqRDBwOFlaemczb3pMc1A5bTlqeGgy?=
 =?utf-8?B?N0s5WVhjeXhVMDM4Z2dNZzhlb1NVVU50alQxdG4zbXdCNCtiWWdsTWJkOFlr?=
 =?utf-8?B?Nzh0cHRDTGVhVVBLZ21tejN3K2FqbnZCVzA1UHM1Nmd2d044cVlYSmpDR1BR?=
 =?utf-8?B?TGIrMXdHdUkvcW5xaUZEd1ZjYW9vN3k4TmpKRmhXTk1icUJsZXljeFFmUjVP?=
 =?utf-8?B?dmJLOVpIdXNxam81UGNIYkhUdThkTnFZQVlsektFanhkWlhwNFc5dnVLUlRL?=
 =?utf-8?B?eWNxS0FaMUhDWHJNR0JLVGJQODNZbHdxUVBMSExoWnFlLzVOWEpMQUp3N1M3?=
 =?utf-8?B?b0NMUVpaZHBjZFNCYjZlbzFCVkJtVkYzYWthMWRCSHpGd2xkS0xRQ2p6WE9R?=
 =?utf-8?B?b2VpZUNaODlFYzN6aDU3Nzk4cVdrY1ZLUURtTFo1Q1FtWi9Pa0pVUHFYc2o2?=
 =?utf-8?B?RHprSUExU2tzYjl5OW9KSTJRc1dXKzlkK0RlK0VsMXpvZ3Y5RTlMTE9UczNi?=
 =?utf-8?B?b2QrM2YzaURXNEpuQ2NWaS9KV0V3YUxaY21CYWJvdEhrTWJDaHpoVHhabmRn?=
 =?utf-8?B?UXdSMTJhbnhuR0dubGhRenV5VWs5RlRQU2xBSWNsZGc4Z0VkZGhXZGNoK1Zs?=
 =?utf-8?B?SkFuSTRHTTNObE1GQnNVamxjallKbXFML3Nqak04SDdLc0tGcS9uK1lpRUQ5?=
 =?utf-8?B?cy9vc2p3NkhSRUVDQmNVT2NvQlhacndqdVh4Q3hEakc4QXV0TXJFemdjY1c0?=
 =?utf-8?B?SnFLY2dQQ2JNb2N3M3REcU05NDRFaGQ1ZHlNT0UvS25yL1NyN3lVWkZ2SWp4?=
 =?utf-8?B?TXBZOEd1Tit5Umg2dVBIbnROdWxZd3daZ1h3cGo5WWphaDZaYkorTzNnYm9U?=
 =?utf-8?B?S3ZKMko4c0gzUUc3bGU0NW5Bb1ZCeU1WNUszWHFISnZKR0hwWlpXVlovbE1X?=
 =?utf-8?Q?A3oKZXFNpas=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6363.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NlJuUG5tVVA4MVJlR3ZXcmx0M01xY0FLUE1hMW1nV2Q4YUVCT2x5REphbGpX?=
 =?utf-8?B?ODlMMUpNVEhYbU9uVWZ5M1lQWVJqYlgwQnUvVmdHS3h1Q0NJbk5MRDI0Y0dh?=
 =?utf-8?B?WUw4R0FKbmFrb2I3V3QrbmxQQXhoeDlwdHhyWHlZT3NpRlJsQXNLWUU2SjRV?=
 =?utf-8?B?NGtGZXRROWtYbWFKNDRCa29scGdsMlhZK2RrQlIvS2JLelBib3ZZTWZzTXAx?=
 =?utf-8?B?aG43Y205TXUrQ3RsTzVSSkNNbDBENTVSNFJFbWQ0bW9DYkFnWWN1THUzbmtN?=
 =?utf-8?B?M1NNOGlUdUVmS3Q5UjNhQ2UwVkZKUVVJbzBqWCtqbWJTKysxYzZzSmlKRCtQ?=
 =?utf-8?B?TElSd25JUDJCTGFFY1g0R2RHZFRHTHlhN3RJNVVzNG00cDd6eXVlaHNzb2Zn?=
 =?utf-8?B?R1l0TlJ3ZWxLeENKUEVBb3lhMHFlQXZKZGZWenl5N1MxWGFxSENjck94eDBY?=
 =?utf-8?B?Q0UxaWM2NVlwSnAzTUY2R1FtRGs1WTBWUlBKMUlKZ3lwTGh4MHVuRE9CMEsz?=
 =?utf-8?B?R0NJbm5aNmlJaWV5eXdnSkhXYXlGNUxMT0RHbjhGc1JkTGV3WUpTbTB3WDYr?=
 =?utf-8?B?V2NsNXFyS0w0UHF1K1NwUWRMZWxOa2drVWlnNlNRY2NIQlhDNU5Ma3hmM3Ro?=
 =?utf-8?B?Zm1iTExiMnBYcitOeWdCdWhSRENRUHphc1A3VlVvU3VhaVFmTlM1Mm9tTlFv?=
 =?utf-8?B?NVNNcldFak5QUTRnalNDdzdrbFdNeTEyMmtNdDJDNFZNY2kxeHY3Y2V6YkZN?=
 =?utf-8?B?azdZaGl1ZFM3RVVhbjhSNGl6YUJvd3ByQjVFK2xES0doNGVGc2xLa2RmRkp2?=
 =?utf-8?B?TWJPd2R0TG93elBoSmoxR2c1NXF6VDducElQTndtbnNja25WcXFTVEN1ZXRP?=
 =?utf-8?B?cTI2NERYZ1JLVmJ5ZXhjdkF4K01ZWWsyRVo2UHJIZVBoMzN1Zi9DeHluak1a?=
 =?utf-8?B?bi9pcHNxWVpqbGZuMWNPclVDOHdwSFVaWEFmRzV4cHVyYnduSE9OdTBkblll?=
 =?utf-8?B?NU5KUTJCZGM1Q1pDOE40djUwSmdJZ0R4N3N3OThlTHVxMlZUYjFJc0xCWDcv?=
 =?utf-8?B?b2p4T1QzQUwybVpUQW9kTTlyZitwU1NhekRaczJJc2FPd3czaXU2eVpKUm1p?=
 =?utf-8?B?bHhPSXczWVk1OXBSN2dWd1l1THpUcjIvbnRUMVgvRk9YMm9jcnh0MTJDTnJj?=
 =?utf-8?B?eEJuV1JMRkRSd0Q3YndwRDdWN1BnVVlMWEFUYVl5eDBEcXhqWGpSY2h2ODU2?=
 =?utf-8?B?TGhNbmVmSnoxdHU1ZXJGU1h4dUdKTlRNd1lTKzRIdjAxbUJ2cXhpeGx3ejNx?=
 =?utf-8?B?VGNCNVYyb2hkc2lqRWVXZi8xUXdoOVhGMVZReWs0QktQN0ZzbUZsRTJvSktT?=
 =?utf-8?B?RUxDSWtWQWo0dlRCK1QzMGpEVU85M1pMczR3YzRuOXpyYmJOeURQdnNvOEU3?=
 =?utf-8?B?UnFXbzB4dTNIV3hXMTk0ZTNpc1FZOVF4VkswcDJrZXF2VkJ4WEFBNGhJd0hv?=
 =?utf-8?B?c0hpY1BZclpPaXZXcng5Zm1Wa1ZsaDNSVVJTUkZSaC96a1RFUGVpZEowY1JQ?=
 =?utf-8?B?eVZPdENiN3gxZ3ZBZzdBOXIxMVNlWDFCQTBFZkZJQ010Um03b05vY0hFQllR?=
 =?utf-8?B?MHFNV011YjBVNXM5Q053Z2FndEhkRnVlVVlKUGhlN01JRXhucVpxUXdxakZB?=
 =?utf-8?B?NjI2R09KVEV3MVRiYjdqOEJlaGxBME1zYnV4ZStjWUpFY1Vza0NVZUpGNHFC?=
 =?utf-8?B?c3NTUVVmRUFGRkQvRTZPcWNqN3MyYVpNQ2JnWTFoQ0VuQUNSWjgyeE1WdkdJ?=
 =?utf-8?B?QmVORTNBQjhlL2NvTFJWOHNMZGJheGZ1UGdBdVRkRHRrSW95NjJwZkZ3RThN?=
 =?utf-8?B?ZGlTL3RpalpCSTdZd211ME1PUjF6dVhYNkpJQThRbkxBKzROaWNMUzhZQzZv?=
 =?utf-8?B?bDh3TVRJRWlPd3BrQlNpSVUwVjNFNit3ZzZaTFVFaTVGQWdUeFM4MkRJaWJI?=
 =?utf-8?B?U2tUQ2owNXh6RWRYZGlKS1Rrd3c0bGMwV0RmU3Uvak8wdFNnZjBmbyt1c3JJ?=
 =?utf-8?B?Z3pCY0piUCthYlltWXBxSEJaWm1DTSsrSm9DTXkrL210cFNHMFdJRzNnd1Fu?=
 =?utf-8?B?SkRiZFcyaEVpYWEwRGN6dWRKVkZLQTJleWFYQUhzaHNCeUlyRmpEekI2UUc5?=
 =?utf-8?Q?rt9MdrkvDY/eIPNwW3UuOSK+6dbROvfA3EoHpj/62zw3?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c00b194-34bf-4920-059a-08dd8ce9f144
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6363.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 22:04:16.2980
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PRBpS8iSn3991yLDXtbt9OLX6CCN1q/Z3meBSp+5B7WJ+53Ni6A5/G9oZzwJ7xdhF+ie/8mkT5KNiHxMiQRPPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7079


From: Ming Lei <ming.lei@redhat.com>

Now ublk_abort_queue() is moved to ublk char device release handler,
meantime our request queue is "quiesced" because either ->canceling was
set from uring_cmd cancel function or all IOs are inflight and can't be
completed by ublk server, things becomes easy much:

- all uring_cmd are done, so we needn't to mark io as UBLK_IO_FLAG_ABORTED
for handling completion from uring_cmd

- ublk char device is closed, no one can hold IO request reference any more,
so we can simply complete this request or requeue it for ublk_nosrv_should_reissue_outstanding.

Reviewed-by: Uday Shankar <ushankar@purestorage.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
Link: https://lore.kernel.org/r/20250416035444.99569-8-ming.lei@redhat.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 drivers/block/ublk_drv.c | 82 ++++++++++------------------------------
 1 file changed, 20 insertions(+), 62 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index c3f576a9dbf2..6000147ac2a5 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -115,15 +115,6 @@ struct ublk_uring_cmd_pdu {
  */
 #define UBLK_IO_FLAG_OWNED_BY_SRV 0x02
 
-/*
- * IO command is aborted, so this flag is set in case of
- * !UBLK_IO_FLAG_ACTIVE.
- *
- * After this flag is observed, any pending or new incoming request
- * associated with this io command will be failed immediately
- */
-#define UBLK_IO_FLAG_ABORTED 0x04
-
 /*
  * UBLK_IO_FLAG_NEED_GET_DATA is set because IO command requires
  * get data buffer address from ublksrv.
@@ -1054,12 +1045,6 @@ static inline void __ublk_complete_rq(struct request *req)
 	unsigned int unmapped_bytes;
 	blk_status_t res = BLK_STS_OK;
 
-	/* called from ublk_abort_queue() code path */
-	if (io->flags & UBLK_IO_FLAG_ABORTED) {
-		res = BLK_STS_IOERR;
-		goto exit;
-	}
-
 	/* failed read IO if nothing is read */
 	if (!io->res && req_op(req) == REQ_OP_READ)
 		io->res = -EIO;
@@ -1109,47 +1094,6 @@ static void ublk_complete_rq(struct kref *ref)
 	__ublk_complete_rq(req);
 }
 
-static void ublk_do_fail_rq(struct request *req)
-{
-	struct ublk_queue *ubq = req->mq_hctx->driver_data;
-
-	if (ublk_nosrv_should_reissue_outstanding(ubq->dev))
-		blk_mq_requeue_request(req, false);
-	else
-		__ublk_complete_rq(req);
-}
-
-static void ublk_fail_rq_fn(struct kref *ref)
-{
-	struct ublk_rq_data *data = container_of(ref, struct ublk_rq_data,
-			ref);
-	struct request *req = blk_mq_rq_from_pdu(data);
-
-	ublk_do_fail_rq(req);
-}
-
-/*
- * Since ublk_rq_task_work_cb always fails requests immediately during
- * exiting, __ublk_fail_req() is only called from abort context during
- * exiting. So lock is unnecessary.
- *
- * Also aborting may not be started yet, keep in mind that one failed
- * request may be issued by block layer again.
- */
-static void __ublk_fail_req(struct ublk_queue *ubq, struct ublk_io *io,
-		struct request *req)
-{
-	WARN_ON_ONCE(io->flags & UBLK_IO_FLAG_ACTIVE);
-
-	if (ublk_need_req_ref(ubq)) {
-		struct ublk_rq_data *data = blk_mq_rq_to_pdu(req);
-
-		kref_put(&data->ref, ublk_fail_rq_fn);
-	} else {
-		ublk_do_fail_rq(req);
-	}
-}
-
 static void ubq_complete_io_cmd(struct ublk_io *io, int res,
 				unsigned issue_flags)
 {
@@ -1639,10 +1583,26 @@ static void ublk_commit_completion(struct ublk_device *ub,
 		ublk_put_req_ref(ubq, req);
 }
 
+static void __ublk_fail_req(struct ublk_queue *ubq, struct ublk_io *io,
+		struct request *req)
+{
+	WARN_ON_ONCE(io->flags & UBLK_IO_FLAG_ACTIVE);
+
+	if (ublk_nosrv_should_reissue_outstanding(ubq->dev))
+		blk_mq_requeue_request(req, false);
+	else {
+		io->res = -EIO;
+		__ublk_complete_rq(req);
+	}
+}
+
 /*
- * Called from ubq_daemon context via cancel fn, meantime quiesce ublk
- * blk-mq queue, so we are called exclusively with blk-mq and ubq_daemon
- * context, so everything is serialized.
+ * Called from ublk char device release handler, when any uring_cmd is
+ * done, meantime request queue is "quiesced" since all inflight requests
+ * can't be completed because ublk server is dead.
+ *
+ * So no one can hold our request IO reference any more, simply ignore the
+ * reference, and complete the request immediately
  */
 static void ublk_abort_queue(struct ublk_device *ub, struct ublk_queue *ubq)
 {
@@ -1659,10 +1619,8 @@ static void ublk_abort_queue(struct ublk_device *ub, struct ublk_queue *ubq)
 			 * will do it
 			 */
 			rq = blk_mq_tag_to_rq(ub->tag_set.tags[ubq->q_id], i);
-			if (rq && blk_mq_request_started(rq)) {
-				io->flags |= UBLK_IO_FLAG_ABORTED;
+			if (rq && blk_mq_request_started(rq))
 				__ublk_fail_req(ubq, io, rq);
-			}
 		}
 	}
 }
-- 
2.43.0


