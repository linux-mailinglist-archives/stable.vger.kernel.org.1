Return-Path: <stable+bounces-166708-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 337A1B1C883
	for <lists+stable@lfdr.de>; Wed,  6 Aug 2025 17:17:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D591A18A390D
	for <lists+stable@lfdr.de>; Wed,  6 Aug 2025 15:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CCE828B7F1;
	Wed,  6 Aug 2025 15:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1M7MieGO"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2074.outbound.protection.outlook.com [40.107.220.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7082B21D5BF
	for <stable@vger.kernel.org>; Wed,  6 Aug 2025 15:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754493434; cv=fail; b=mAeulR9jfYVUOrqM7Hi9S3ICEuz0cvNYj0ckmtNPPpGiJUiTGiXRxxE4KWXnZKd/yigSDNeWeFYCAb1Jn3S7RsAQsCCkzuCxWSYwE2tN/zI3ssI2i004NOwr3rWaDUV7RQW/3faZlDacRj3Xvgk9Z8nM4sjy9pDEYeJbZVHxrPY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754493434; c=relaxed/simple;
	bh=PAriNkOD+SqoHDQ0J1YC3XUOvRocSznVg3L6xgSHI0Q=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=W+95PFTgGeg0RxuKS8nh84zWfbykfhonhu7H8/60GH/0gM+jo5QM3WOQ9pkcwlWNT2KMKgwn7BBxhdtDNVaeP8Ou1tBn3XWppdVRedQhAyFEZcIGOUqTSyTlJ+iXPuPrlakboLicgkCg3rjDGfBovOcxZ6+bJ1B6HZ0FpYrcDuw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1M7MieGO; arc=fail smtp.client-ip=40.107.220.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MhU7zPBs1ix1hXt/ubx/lr2Aqa2cNVTZTgdmSlzZY8XHc16M5MmebnO16D6hqpmCawd2LwcD5QplvHQ9j+5YyJi2lcznbWEO1y6eIoqCOLdaMG73878pNi2FuOXwgnmxP3pvJClDg4NHvr4I+ry8jDXj3PCqCZBb/8n902tjzZ+HWMExHYwxtS6FaBsMLjz6twRtkEeu2t921su2L0VBYtVqAw+2FdjZvC0Z7S0sLtrchbyg8zW85AAvxMkpuDWOxqpXmNXtcl0+GWN90+oauJGq+98uKXtUedu7PGcUSQDGitCO36DHfazOqb9ZTSJFEKCYisZcg0YuYhofe2CSHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nb7pozuBI5GCIbfUfXgplQ7rzkWGdfeppRjCqzl7Ong=;
 b=yRlA4NPpO9IbjmVfnO52kjNCHQ5xgLJbYXB2sHp1/Twm3Z2CxwTnpoDSEZ4F1mUotNkIuS/XdzQUpsabjw8XxOK6bR7c8JOdClJSVmRA1Y6KFhXREPShTYm3cC6xM+UpUq+zkHoRqBVgwox0XU7c1WNwNzJnCUv6l0C/V6+PyUt21GCrh7XzRozZf++vOYaOrTmdLEOaTud6Zu5QyT0SRFyoLoy0g14Vg+JLo/SU8P3EJsqdPnVQq+C2TAeOdWGYZ82YUqBdZp5Dx70lCjnQC9MSi6MWJaiOvV6k2ThvuaOKsp1em3kzUL7wQf8TRsHwq1MHHuMXPFDkWD0tCoxenQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nb7pozuBI5GCIbfUfXgplQ7rzkWGdfeppRjCqzl7Ong=;
 b=1M7MieGO7tX2QZeCcKNFeiXzlxkAwBsCXHSfXrQa36PInmMjeSVQFTYRG0h3cFEUvLWPy7eyENTmcB+c7hNpUMWFHljUaxkiwJ6RSnfHlx6ULYQd5thEh1ETc1ARsakOlke/jYJVKh2dxDhTPkOuuSi017HqAC+5F3HFoYLtn1c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB7820.namprd12.prod.outlook.com (2603:10b6:510:268::8)
 by BN5PR12MB9485.namprd12.prod.outlook.com (2603:10b6:408:2a8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.14; Wed, 6 Aug
 2025 15:17:09 +0000
Received: from PH7PR12MB7820.namprd12.prod.outlook.com
 ([fe80::7606:59:8d0d:6d4c]) by PH7PR12MB7820.namprd12.prod.outlook.com
 ([fe80::7606:59:8d0d:6d4c%5]) with mapi id 15.20.8989.017; Wed, 6 Aug 2025
 15:17:09 +0000
Message-ID: <eca66cd1-aaa3-4ec2-aecc-bbed7f44f7ae@amd.com>
Date: Wed, 6 Aug 2025 20:47:03 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu/discovery: fix fw based ip discovery
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Cc: stable@vger.kernel.org
References: <20250730155900.22657-1-alexander.deucher@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20250730155900.22657-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4PR01CA0090.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:2ae::11) To PH7PR12MB7820.namprd12.prod.outlook.com
 (2603:10b6:510:268::8)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7820:EE_|BN5PR12MB9485:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b3bf221-ee08-4fee-68da-08ddd4fc4faf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dWkwclJGb3FXS1ZpRk53WUJyUlVNcE5CcnRtbGFFc2R1OUxyQ3FDcndxZWE3?=
 =?utf-8?B?bldPRjJTUlp4WkRpV2cvcE5sNHp2YmVXdGRyUDFZZ2lIQUtqZDhLZ3ZSTkxR?=
 =?utf-8?B?VVdUQ3BKdG92aWEzVWRNWXBrRXVvNm5uYk5QUkZOSGQwMHRsSU93ejh4d0dU?=
 =?utf-8?B?N3dPTUMvYWx6TmVWckpQSzk5ZW1yaVdMcEdhaERrclJ6MTE5L1dwSmg2Y2xG?=
 =?utf-8?B?NVhKSDV1Z2VDQStSUWRRT0pPOXViaDB3YmV2Q1BLbHZjeWxhYzcvNXZVRmpK?=
 =?utf-8?B?d1JKZXI3TUpQL05EZUFFSnlyekFKUWE1RDVPN2dEVVVVMFdBQk9OYVdXc3Vy?=
 =?utf-8?B?c1ZMaVVVWnBqUXBaelU2cDQvdmRRRVZzTGs4VUp5eTRhRGxBVC9tcDJPM0ZT?=
 =?utf-8?B?SkFzbUdNaUFZNEY5QjdPY3Jkb0wwSGVIVjVPS0Y2MHNOK2IvV2tnZUtwa2p4?=
 =?utf-8?B?SmdxaHZ6OENwYnpTU2EwQk5PMUU3NmZ0YTRVRnBDbWhJTVhJdEFOZEMzVWkw?=
 =?utf-8?B?WUJXMThqK2hQYUJFaFRiZWM4ek41dThUeTF2aTgxY3A0WDV6TUszQ3ZnSGJr?=
 =?utf-8?B?WTdjUmlWekVIN3g0c3FMbFQrS2hwbWs4bmJMRUJ4dkVQNzVRZW9ZdVpXdllv?=
 =?utf-8?B?SVhheW0xK3lvUnMvbEZrTDRxWGdRM005UjNKcENyZzNVOW1vVjJFVjMyUXpK?=
 =?utf-8?B?Q3BER1VVMVhncnpBdCtiNEVkcVRpbzdHWUE2WmtlUWhLR1RWUjJyYTNDSXJ4?=
 =?utf-8?B?QzE0RzFENVgzUUduVkMxNlc2Y1Y5UkhXMW1TZDhMWW4rMlZoWTkvbGdNOU5k?=
 =?utf-8?B?dUFKazNuYXBVRmZOUTdSSnNqdE5OVUdDOUh5amc3UVNYbC9VMWZWMkxSbVU5?=
 =?utf-8?B?YzlicDc3YnZVVm5xV1FZNGkyZ0EzMjR3RFpzWjE2REpKWHBsRFJlN2R0UW5X?=
 =?utf-8?B?eWFFRVI2d0hONTBDOUIxWmdRSFN1Y1UzcnE5N1h3Q2J4MTZCc1pTcEN5SUtO?=
 =?utf-8?B?VnNBZ2xkRGsvT3pOdXBmMUk1a29VZ21sejk1bkpWMjk1cm9GS0tuM2tKc1VL?=
 =?utf-8?B?Qk9qMTJIUEF1b2dSYXVadnJSRU40ZGxKVG02Z3JFaFdjMHNqKzk0czRJVjNY?=
 =?utf-8?B?Vmo1czFqeWJ4Z0hERG9IaGNHSlZydS8rcGlXOGhTcGdodkl4ck1sSDA0Szhq?=
 =?utf-8?B?TUNKN1c5Y0lhcTB3R0ZDcFN5OUpFTHVadkhIbE8yWHZpb2prWGNacVQ1N09k?=
 =?utf-8?B?ZGZzMDBkYzRSQzEvSXBjNUwxU3pjV1VnK0p1NDZjRUZ3dFpYd1NrdlB0RmIr?=
 =?utf-8?B?aGI1MFpxa0ttUHM1QUc0UXhVL29OUlNzaEh0bVdQNHRFY2NFUkZObFRxUHpn?=
 =?utf-8?B?NjlaZjdvOE1RZXBWd0dLODlOOVRiSC9DZXlBNnUwZGF5SGRERXFSemoyT0t6?=
 =?utf-8?B?MlRjTjB6amNnRVYzSWhUNG5ITEFPTkNGODJXSElqMTRpM05vZVBiUHdkWkpU?=
 =?utf-8?B?R2NqdTgwRjJVQlBacVBDRGRtNU9uK1lXQmpBcDVzL3d5dy9jd0VPTlNHNUtm?=
 =?utf-8?B?YmFlclZ4NFdPYTZJazhyM0VpQTZucldua0NDTWVLNUdiUGxwTGlnSGh4QTE3?=
 =?utf-8?B?S0x0T1JzR1RXZnhnb3puOFJaWHhlMWlCS3JDbHJiQTNtZjBGQVNIay9lMStY?=
 =?utf-8?B?Q0c4MTd0bzdJTm1DZVM4Y3k4Q0VEUGJiOGkya2FJSFBnUElDTElad3c5SEtK?=
 =?utf-8?B?ZkwzRjBLcVYzdzF0WDcxUEpEMEZ1c3BTZ1VKalRwSWlOcDNRdU9DRkQ4S09w?=
 =?utf-8?Q?pCViZ9JAiu9HZwvEjVE9evmvV/nNF9jZISfK8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB7820.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?clNmZzVnTWUwdDA3aUtQM3Rmc0JKTWMyc1FmeWdTWE9YVFA0ZDJudEMvWFoy?=
 =?utf-8?B?YzFqM1J5UU5NYUNoTVVNRGRyRlNoM1dKMVZTZlpKa2xNc3JwdHh5RmhLSWQ2?=
 =?utf-8?B?dC9YZG9MOVdtUHRrMGxUbzFFK0wrZE54U3UvQzRyeGtxanE0K2wwdExKVUFL?=
 =?utf-8?B?NlVvemNJMXRzOE5NNzNvcTVVK2l2R0M3TjdWazZpaXVyYlJNSmpGRXlTYk04?=
 =?utf-8?B?YXE4NFNwd0RqWkIxUVNjaTFuWTBIdnppSEYyL2RGWmRESHpueEIrd0lNdEZC?=
 =?utf-8?B?cjhRNVh4ajlZUVBJdFpacDFMUTh1QnB3dWhaZ0t5MFFEdXl4MWtrcnlmWXhm?=
 =?utf-8?B?bVk0Y2ozUnhTWjdpNEhTeHpjcDJMbHpMbkhSUFUxNzJEWjJKL0F1YWtyK0xv?=
 =?utf-8?B?aEc2NExkc3E3UlZQbUtWWG1WQitMSDFlbnVnRVhQVmdvRlFZdGdoUFRWeXNO?=
 =?utf-8?B?MEpERVpRbWRsNm16eVFMclV2NWpXaDNEWHZPRStoWUM4RDlzK0VEemNSWmNt?=
 =?utf-8?B?TWkrMmdkcGZCTGFQbWlzK09YZHFrTVpLckoyVFA5NnF2RDJucmRpT2Y3a1Er?=
 =?utf-8?B?K3dQREFQaHhiYXpZYzk2ejQ0amN5ZmRWRis5bGpRcVF0Yyt5clVCQnJOdlhS?=
 =?utf-8?B?YWVjQ0dVYWJKVVBnL1p3T1psMm5CSU5TdDMyVTgvbFd3cEk5TVcwZzlvMjdz?=
 =?utf-8?B?V3RVcGdHcTVMSmNyNDZ0K0kvYnhVSjdIblVwT2Irc2ZMUFpHbFV1ZkQwbVB6?=
 =?utf-8?B?TVJuQUVKNWp3UmtMeEJuc01CRzFKaVZrQTBFV2VOenpMcURaRks2R204ejM0?=
 =?utf-8?B?VkFZdUFwcHhSRE9abjQ0UFQwS3h0NTE4RmIra2NoYzZDWDIzY3Q4c09nT3hD?=
 =?utf-8?B?QWwyc1Z4N2VMbEw3c3Z2V2VDUUtZTkhEVEJsek5VSVI4UnZsT0tDeE5JYWh2?=
 =?utf-8?B?b2lxaW1zVFREcExoZHdlN3dHTjRxUjNSSFRFb1M4dFJzNWZZSEdPR2tqcS80?=
 =?utf-8?B?S3hFbStraFYzMmR5bFFqTUlCcXN1eXdwVmtBU1V6T1dOQ1RLTjlzZTJQdGlT?=
 =?utf-8?B?VDQ3K0RhaG1sMGMxUTBObGJDaWJjN1hlMkVXRzZadlhZSlBzcGR2M2x2VDZl?=
 =?utf-8?B?ZlJJQklDTVp4SHhMQVlpQ256R0paSHJHM0plemlZdTlLWkx2c0ZJaHFPNVBM?=
 =?utf-8?B?bmJJZWVjRCtMdGk4NHFaY25Fa0hVNkRTNDhJTGVvQnFnbzBzODVONjNJaWRi?=
 =?utf-8?B?OHhKY3k5ajVLMzNQbDdsWUw3ckxDbDhXOTl5aFZ4QlNSZHd3di9lSnNsUEpY?=
 =?utf-8?B?VWZKU2c1UWRvSTZBSXFNbzFMeUFLd2Y1c25WYWR3Q1E0NWVkeEV5eXpzMC9O?=
 =?utf-8?B?R1lYa3IrZHo3WjZIYTIyd00zM3R3SndBdzNtWmtiN01wNTl5cVE2ZnZjcHls?=
 =?utf-8?B?OVNUSlA2UitxQU1aZyt3SzVIaXFjRGkwSHowdnBMNUxibGpNR2I0cmJkNUpV?=
 =?utf-8?B?RzBOQTlmK0ZVTUpHemNkYjg1eHJhbXE5ZlozRnhFUC9pRW5zalJ1SFh5Wmxt?=
 =?utf-8?B?WFpZSWlqYW9FRmkzbDZ4a3E1WktGRXJiOXA2REZUYWhHMnJsZW1rTFJRRita?=
 =?utf-8?B?M2JidEIvTVAwaEQ4R0pXaW00dEZkUGdUaGRiNGVnK2J2YUxjTzlFYnJnTmxh?=
 =?utf-8?B?TDVoallMZlY1RldSOXNweXNTTDJjb2dDUkFEWDdKei9UcFRjQmJyWWtobEhX?=
 =?utf-8?B?Q3RpNkFkRVNoZ2VTZmVJYXpVM05VQnRlNU1VVWcyM0crRDhQY3RGMlhyWDQ2?=
 =?utf-8?B?b0V3VFVhdEp3MXhKcFptMHBuQ2dQcHFrcFI2UkJVL3R0ZUxURUxlZThjNnVE?=
 =?utf-8?B?cG5PaENPeXQxUDhSdlAraXp1TFpvQ0gzWDZWVHIvT0sxbkN4ckNvSVpZK1BR?=
 =?utf-8?B?eVNpQWtSVDRzeWFuRnlYVGNHYmNWd1VJdVRaVjFqU0orL3FGcEk0ajRLbnZX?=
 =?utf-8?B?K2h5KzZ4SkF3UFJDWHZ3WEdWSUVkS2tCbjNyei9FOE8yRUlsVUpxYmNjZG1L?=
 =?utf-8?B?TEYzZE1ldHZ4anlCZEdRQjNMWGZ3R0Y1cXZrQkwzQ3lsS0JibHFnV3RaZGFo?=
 =?utf-8?Q?16Ze8z2VW0Y7R+hHrk9hGN3U+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b3bf221-ee08-4fee-68da-08ddd4fc4faf
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7820.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2025 15:17:09.4054
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 87ZW5Ydn0RaM7H/4B8cbbbFzgcr8r9fM1sA95r2TzdLAdjX57UtjvogbgkNRqwbs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9485



On 7/30/2025 9:29 PM, Alex Deucher wrote:
> We only need the fw based discovery table for sysfs.  No
> need to parse it.  Additionally parsing some of the board
> specific tables may result in incorrect data on some boards.
> just load the binary and don't parse it on those boards.
> 
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4441
> Fixes: 80a0e8282933 ("drm/amdgpu/discovery: optionally use fw based ip discovery")
> Cc: stable@vger.kernel.org
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

One generic question - if discovery content is completely ignored by
driver, how external tool using sysfs could consume the data? Wouldn't
there be a mismatch in the config?

Thanks,
Lijo

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  5 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 72 ++++++++++---------
>  2 files changed, 41 insertions(+), 36 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index efe98ffb679a4..b2538cff222ce 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -2570,9 +2570,6 @@ static int amdgpu_device_parse_gpu_info_fw(struct amdgpu_device *adev)
>  
>  	adev->firmware.gpu_info_fw = NULL;
>  
> -	if (adev->mman.discovery_bin)
> -		return 0;
> -
>  	switch (adev->asic_type) {
>  	default:
>  		return 0;
> @@ -2594,6 +2591,8 @@ static int amdgpu_device_parse_gpu_info_fw(struct amdgpu_device *adev)
>  		chip_name = "arcturus";
>  		break;
>  	case CHIP_NAVI12:
> +		if (adev->mman.discovery_bin)
> +			return 0;
>  		chip_name = "navi12";
>  		break;
>  	}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> index 81b3443c8d7f4..27bd7659961e8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -2555,40 +2555,11 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
>  
>  	switch (adev->asic_type) {
>  	case CHIP_VEGA10:
> -	case CHIP_VEGA12:
> -	case CHIP_RAVEN:
> -	case CHIP_VEGA20:
> -	case CHIP_ARCTURUS:
> -	case CHIP_ALDEBARAN:
> -		/* this is not fatal.  We have a fallback below
> -		 * if the new firmwares are not present. some of
> -		 * this will be overridden below to keep things
> -		 * consistent with the current behavior.
> +		/* This is not fatal.  We only need the discovery
> +		 * binary for sysfs.  We don't need it for a
> +		 * functional system.
>  		 */
> -		r = amdgpu_discovery_reg_base_init(adev);
> -		if (!r) {
> -			amdgpu_discovery_harvest_ip(adev);
> -			amdgpu_discovery_get_gfx_info(adev);
> -			amdgpu_discovery_get_mall_info(adev);
> -			amdgpu_discovery_get_vcn_info(adev);
> -		}
> -		break;
> -	default:
> -		r = amdgpu_discovery_reg_base_init(adev);
> -		if (r) {
> -			drm_err(&adev->ddev, "discovery failed: %d\n", r);
> -			return r;
> -		}
> -
> -		amdgpu_discovery_harvest_ip(adev);
> -		amdgpu_discovery_get_gfx_info(adev);
> -		amdgpu_discovery_get_mall_info(adev);
> -		amdgpu_discovery_get_vcn_info(adev);
> -		break;
> -	}
> -
> -	switch (adev->asic_type) {
> -	case CHIP_VEGA10:
> +		amdgpu_discovery_init(adev);
>  		vega10_reg_base_init(adev);
>  		adev->sdma.num_instances = 2;
>  		adev->gmc.num_umc = 4;
> @@ -2611,6 +2582,11 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
>  		adev->ip_versions[DCI_HWIP][0] = IP_VERSION(12, 0, 0);
>  		break;
>  	case CHIP_VEGA12:
> +		/* This is not fatal.  We only need the discovery
> +		 * binary for sysfs.  We don't need it for a
> +		 * functional system.
> +		 */
> +		amdgpu_discovery_init(adev);
>  		vega10_reg_base_init(adev);
>  		adev->sdma.num_instances = 2;
>  		adev->gmc.num_umc = 4;
> @@ -2633,6 +2609,11 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
>  		adev->ip_versions[DCI_HWIP][0] = IP_VERSION(12, 0, 1);
>  		break;
>  	case CHIP_RAVEN:
> +		/* This is not fatal.  We only need the discovery
> +		 * binary for sysfs.  We don't need it for a
> +		 * functional system.
> +		 */
> +		amdgpu_discovery_init(adev);
>  		vega10_reg_base_init(adev);
>  		adev->sdma.num_instances = 1;
>  		adev->vcn.num_vcn_inst = 1;
> @@ -2674,6 +2655,11 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
>  		}
>  		break;
>  	case CHIP_VEGA20:
> +		/* This is not fatal.  We only need the discovery
> +		 * binary for sysfs.  We don't need it for a
> +		 * functional system.
> +		 */
> +		amdgpu_discovery_init(adev);
>  		vega20_reg_base_init(adev);
>  		adev->sdma.num_instances = 2;
>  		adev->gmc.num_umc = 8;
> @@ -2697,6 +2683,11 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
>  		adev->ip_versions[DCI_HWIP][0] = IP_VERSION(12, 1, 0);
>  		break;
>  	case CHIP_ARCTURUS:
> +		/* This is not fatal.  We only need the discovery
> +		 * binary for sysfs.  We don't need it for a
> +		 * functional system.
> +		 */
> +		amdgpu_discovery_init(adev);
>  		arct_reg_base_init(adev);
>  		adev->sdma.num_instances = 8;
>  		adev->vcn.num_vcn_inst = 2;
> @@ -2725,6 +2716,11 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
>  		adev->ip_versions[UVD_HWIP][1] = IP_VERSION(2, 5, 0);
>  		break;
>  	case CHIP_ALDEBARAN:
> +		/* This is not fatal.  We only need the discovery
> +		 * binary for sysfs.  We don't need it for a
> +		 * functional system.
> +		 */
> +		amdgpu_discovery_init(adev);
>  		aldebaran_reg_base_init(adev);
>  		adev->sdma.num_instances = 5;
>  		adev->vcn.num_vcn_inst = 2;
> @@ -2751,6 +2747,16 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
>  		adev->ip_versions[XGMI_HWIP][0] = IP_VERSION(6, 1, 0);
>  		break;
>  	default:
> +		r = amdgpu_discovery_reg_base_init(adev);
> +		if (r) {
> +			drm_err(&adev->ddev, "discovery failed: %d\n", r);
> +			return r;
> +		}
> +
> +		amdgpu_discovery_harvest_ip(adev);
> +		amdgpu_discovery_get_gfx_info(adev);
> +		amdgpu_discovery_get_mall_info(adev);
> +		amdgpu_discovery_get_vcn_info(adev);
>  		break;
>  	}
>  


