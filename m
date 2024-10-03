Return-Path: <stable+bounces-80677-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AA2F98F599
	for <lists+stable@lfdr.de>; Thu,  3 Oct 2024 19:54:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99E081C21B62
	for <lists+stable@lfdr.de>; Thu,  3 Oct 2024 17:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E24C81A7250;
	Thu,  3 Oct 2024 17:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UB68xgYw"
X-Original-To: stable@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2040.outbound.protection.outlook.com [40.107.212.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D194D19F418
	for <stable@vger.kernel.org>; Thu,  3 Oct 2024 17:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727978044; cv=fail; b=EIDwD574TVoutVESoUYIX7wDAnS388proXG5Xun1/BSQPFCUF9Q6nucL+kQ7XOOGZbFUHk7jtdsGKXSL23UMWB2vSaANO62L8qHAjRKkap66TNBIOMawJz3xGrNNLgKjQW6wXMnbrwulPKhVt4RawUIVugYRIjZSKLJkbku3Rck=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727978044; c=relaxed/simple;
	bh=g6jhybVTCcb+XyJ62Snhbabj6C3ySwaWMiDIDnt9WBk=;
	h=Message-ID:Date:To:From:Subject:Cc:Content-Type:MIME-Version; b=O/oDalqCD35hZV2pdU3asECuewUnJm3KEfD480KJp7Cnr5N7QHPD9kZTNq+wSUoAQJK7lMSluXru5BRWp19adlx3OhhwdTlSf7Kp4uM1AF64HSN4RCADZ5RiTzGYzaP3QyV8zX6sC2ENZKxhIJPgZO6cOHkwqmzkSTZ1o8C+Hgc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UB68xgYw; arc=fail smtp.client-ip=40.107.212.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DOWyTHoUC7hywt667CrLinpuS5KPA4TH3xgq/w9b05tOce/17uL8v0CHzxz7eLuqrvRBS4REX/USrH58w03K1T9mPMeJRy/OOxsoRxoyv5grkgoGFtE7mx8E/g0GutLANqmxlJXA8SLWJlo0rO68Gp/JwFkFWBO59yFByCXvmsOTg76BTt8hEGtUVaYq2wuJTv6h//lHsXV8IfnUeyhgUJqRPA5wVlxq4mE6unqy9LoVVQLwizC8OmtwMPbWtPR8gKNHmwr9J6+GxG4RRZKMn6edFQDwLtUNysdA6DNMlKuAVTMk40yiQcKRejY0v8qF8V2++J19t5aFX9iKV8f6dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fwtV15UmYqtTpRiFKx08JHUe8sjebuiTwxXAteGvoXk=;
 b=t+Gs1NmE6q8tXRbWXQdzwirOR9hKJ9hXPtovP4xhQ1j1fwZTu32wQyffHDU2QVIVDP+k/vWp6Ba3lysz/I56BiRSVMfwBl+UWt0FfSQ7WIRFwsME9+pVj1GA5FQUAZyvwGBLfjmaahsjrkNiClxq6dxHS+yt/SheHl9S/EQlrBkvXfYXcjjtAQ46OdUufQnBpE69lFkbfK74EoGGAXGqg9QR9bS3kwBSZV+eChDMCZpTuEwfQNVCeU1tWBOFhcQpQ0gLBgkDcU7zzM+m+KrRdgxYO/0UBWNRM0pAzVk6YF5lclCB4oGBxmMVe1UxxTOLn1ETsFfa1XvWHEMobCt7kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fwtV15UmYqtTpRiFKx08JHUe8sjebuiTwxXAteGvoXk=;
 b=UB68xgYwPvmGDPSD0lbezab5LjqBcbpL9hVYkmwrxylhFvsKGDRSO+GZgkpLYAhio7VPwtlKlgAjGo0aBOupR8VCBwZ4N41t2k/jz+0r7J58/WduFNwEeYBAXxbR1e9Ql2Y6Apwn3DQtXV3SsdDoL4Gb804fQ26fttbxakpKsMI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by IA1PR12MB7686.namprd12.prod.outlook.com (2603:10b6:208:422::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Thu, 3 Oct
 2024 17:53:54 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%6]) with mapi id 15.20.8026.017; Thu, 3 Oct 2024
 17:53:54 +0000
Message-ID: <14faf893-2206-49c5-b32a-3aa19c6270ad@amd.com>
Date: Thu, 3 Oct 2024 12:53:52 -0500
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "stable@vger.kernel.org" <stable@vger.kernel.org>
From: Mario Limonciello <mario.limonciello@amd.com>
Subject: Re-enable panel replay on 6.11 kernel
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0037.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:2d0::18) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|IA1PR12MB7686:EE_
X-MS-Office365-Filtering-Correlation-Id: 535f02cd-b064-48da-11fb-08dce3d458b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MThBUFloWHNRekdwTXhJUjlxY3NQMWZ2bjc1S3BnT3RqalBrME5LZjdLYVBn?=
 =?utf-8?B?Q2tnRTFicitOb1YwWjRNWUFUdEZ6NklNY0lLREdPZHI3R01qWUlxWFg5WlVL?=
 =?utf-8?B?T3RDOCtuS3hkUWswcS9GWS9sODBaSVVLdnZoMk9xSm5sUmZtYWNqMlM0NzND?=
 =?utf-8?B?bFdScjU5d0pQbUtCY2tDc01GNFNFSmllNm0wSm0wRm9ZczdNcXduOW5ZSERx?=
 =?utf-8?B?cjloaExvS0NidTdJN1hFdTZpQlFnUjNXajVrL005bUtiUXdHdGNkb2RZcllT?=
 =?utf-8?B?a2FVSXhycUl3OUNUM1lUTHhRNUhrRjdqTjQ1ZE12L2FYYnQ2S2NISFQvbUFL?=
 =?utf-8?B?emsrdGhUSXRhYTh0TG94clhmeEl1ZlRncFVxdkpOU01aQ2J1MmQva2JjenBC?=
 =?utf-8?B?YitVM1FiTzRSUnM2WVFPZFRETXpMc2FFUVk5OCsyNmZKc0M5U1REWEtsUVk0?=
 =?utf-8?B?SFlRRm1uWGR6SEpzTk1TcDBFY3RZYkp4RGg4UndVbDEzN3ZOU3lXRjZkY1FN?=
 =?utf-8?B?WE9ybERUdUtGRlFseGMvMktwUzBlRzRJd1Bob0RDTHo5bFBIMEtTcElGN3A0?=
 =?utf-8?B?Z1JKNmF5L1NDZWRwZ2hjRW5SUGsxWkZsNXMrUktab2hUYTM3ZkVTb29hYTZK?=
 =?utf-8?B?VksxU0NxVHMxQXlubkduLy9lOExNM3V0U1lNYnVHd1FVTjl0QlQ5NWkyODZQ?=
 =?utf-8?B?c25yN3J3Q3BjQmtOR2FDaW9EckdKTEhDTW5LT2xWTVhyZjNIa3NiSlZpcTZU?=
 =?utf-8?B?WEdGSmFvdU9tZU85ZWRsdTY1RU5zWERyK21TSjMrQmZmZTJNYVIvQ29ZTzF2?=
 =?utf-8?B?S1dIQldXQlpQcWFJajM5WUZlOHk1RDhTa2N4TGxkUXJXL3N5anlHQm9iWUxo?=
 =?utf-8?B?dnQyYk4wU1phTTVMZHpOSXR0OGJPYU9rTGhRb09Gbm53S0sxek5LRjd1czZV?=
 =?utf-8?B?Q2hHRlRMZC9HQVdWWlIzNjVXeXk5VXBqc29UMVpUeWgyV2U1QS9lemRubXpE?=
 =?utf-8?B?RXJTMEMwUkNIWkdhL3Jla1ZLVlhpSzZlWk5hU3dRdnYybjN6aGNKYVpreWhZ?=
 =?utf-8?B?OWJTN3k2OGdVZ0t2TzU3b2t0Tkh0ZGQyV3UvakR5VEs0amdlTC9Pak1BbkU3?=
 =?utf-8?B?RWNueWNOZUhSM2NJb0N4SUZNZjREUm9YN2RzRUNGcFJKRFlnT0xxVm1MQVRQ?=
 =?utf-8?B?WEpUNnZSMzhidW5LQmVpS0JMSE9zOTJ0NEo4cHM1bjF4K2I4MnhJRXZQTWlK?=
 =?utf-8?B?anJiazFVajhDLzhZS1VkeEhWUzFiWHlTd0ttTHAvUHVVajJsamM5eUdSVm56?=
 =?utf-8?B?VGNCOFlmL3BqeWt1S20rak4vNHYrZDc4UGZ0c2NlM3M4aFhzVWptcHZEZ084?=
 =?utf-8?B?RFIwUVBlb0NFODAzYWhodUhrbHpOWGdWbEszam5mUldnSEJCTDh2OXYxWWph?=
 =?utf-8?B?YXFtUkgrR2gvMDQ5Um91VnY1SGZaVXR6MGdRT01JRlM5Q0NHZ0RMb1NtYmJ5?=
 =?utf-8?B?WHc5SndjRjdVMlh3dlZDRjlBSDZiNjlTVk9XVDVUdHp6Ylpwb3ZyeVUxdGFh?=
 =?utf-8?B?NzhXc2pWT2M0ejFpcU1uT1c5NEZWRXhTcGNDc1RPVzU3SVNrdWxlT29SSmtP?=
 =?utf-8?B?RkswVGtsME1LanY3QlVSMFptVDlsM0dnRGs4RGhmVEpmbWEzN1prcVRCVGdD?=
 =?utf-8?B?YzZGenV1ZGMvbm5xSWJNK2tEcERsSWdxdTQwU2dIajNmU3dlTC9SelRRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NnV0M1cxaXZNY2N3KzFsaTVBVHJUMS90aWlLKzVUdEhjQmxRSFZhMDdwaTF3?=
 =?utf-8?B?TWlPMC9HUFhBeTBGN2RXTHRLOFcxSThUaXBDOXVhMnZhcTNBSytLdnZJZ0pJ?=
 =?utf-8?B?bFhBTm9Xb08xSDVteGNHUlJrdkhkQWVJU0MvbzkyZjRURGk2dDlFUDVHaHRs?=
 =?utf-8?B?RldyZlB1bW9XSjd0NU1BUXZPQmNTTi9LQzFSVVMrYzZMVUdZa3BjWVJXa2Ez?=
 =?utf-8?B?VmZVeXpZNVVDYklZdUk5c3hSQXkyNFcybThDUTJleFdaclJXaDVwWVBha2Rq?=
 =?utf-8?B?UFkrQVlYd2s3dllrWktpdldBRzdZbnkyd1V6bXdIcUpSTFFZOS92N1AycVdQ?=
 =?utf-8?B?T2xGb0N6bTFPQjRVNjEzNzczRXdRTjZ3VURGMUVrNHNQbWpTY1g5WFZrbkxn?=
 =?utf-8?B?RUtCS0tEanFqWWxscjI2VDE4YjB3emR0N1lKTkVsTGhNLzlya0wrZmZEeWNV?=
 =?utf-8?B?YXIrWllGTnpzNmdvNG9vYS84NzBFZ21RbHdiWkRtNjYweTRWUkRiNVkxeWF5?=
 =?utf-8?B?K1dlc1RVS0ZtUE5aYjNDaVRqTXBsT0M1MTRKdUFra3hOcENhenZhRStpcEs0?=
 =?utf-8?B?Yko3clpDcStZVVc1N1ltQXEzR3I5STcwa3NSZWEydEUwSUJHMEJBeG1kMEgw?=
 =?utf-8?B?THRIbGdDR1FVcGwvczc4amxLMk1HUWtaMmozbDhtNmdWZjQzbk92WmFSemMv?=
 =?utf-8?B?TE1NMGh1VnhHRElBYi8zbmZPN0NVeG9ZRHhGdkxNaG52YjA3YWlBRlVzKzd0?=
 =?utf-8?B?T2F2VVVkbk1zcmFLUGpreU15c1d1cUdkUTR4QnlsbFR6QjUwbjFGaFdnMHNO?=
 =?utf-8?B?RzdtLzNFSzdNMUxHTHZWOCsrd3hGRDhTWXFRbkZtSGUwdlUxZDBzbkRSSjJw?=
 =?utf-8?B?aU90TmNFRmtaSU5QM2xaN1VuSVBISFJKam53OC9lV1dCY1lWbVhYcHM1bTAx?=
 =?utf-8?B?ZnNmRkk5SmNsZjAvdUtDVjQ0WU4wMmkvejdnVUo1eXZKc0k4bitiMHRiM0l2?=
 =?utf-8?B?bThFdzhuWDkrY3IxTm5VUlFlQkdLbWIrek9GeG1JSXQ0R0xFRWFpTWc2MzA2?=
 =?utf-8?B?U01UTEpHUDVyQi92cTY0QU52ZENlYkxScXNVb283MitpOWJmY1hmcnNFR2Z1?=
 =?utf-8?B?ZnVuWWZrdGpoNG9rKzhaMDRjVlNBTW4vQlorOEdYeWwrT1NGQW5nYkpFaGRh?=
 =?utf-8?B?dWlnM3hOL0ZyNHdWc0cxdWxkUXpld05WbTZMejZqc0E4YVh3Q2RXdmxzMkNO?=
 =?utf-8?B?S25ITmxtTnRvZmp2a24xK0c1NTNnUWtYa2JwNmg2dHlUUCtFaW1OdVhQWDVB?=
 =?utf-8?B?b1cwNlhuN2YxTHYxUnJOeVFMN012YjI0RE1rVnF1UlphU1BZVUFGZGthSGVM?=
 =?utf-8?B?aXN5bVNvYmlhcTdMZmtSenlpV1RPelNaQWtsS3k2clFyYmx2cVYwek4rd1dM?=
 =?utf-8?B?blQyYm96NmJKTm1VVUFDUzZSU0d2MjFaK2tnQXFFOVU2ZWZWbW9vZDdJVTAv?=
 =?utf-8?B?NWZNMXdDL1R0eGU5SEg1WkRTOFdYUUtpN1pWYTJkWkl2eW5MWG9ubkZUUThI?=
 =?utf-8?B?K2l3QkdUU1FZYzZ3NWRWa0dDWUxGdjM5VjhSVEVTK2xWQXFWaWlEUWQwN1JM?=
 =?utf-8?B?MTFnTFh3R205ekw4VkxKeEFGV29nQ3hhUk50M2xabVFBVTBzcVpqOUp3WnRk?=
 =?utf-8?B?WjM2K3JJVXRZZVN1UTZDb2l5aUxJTnFIQjdkalVkNnowOXJOdGlRV0RvWWxO?=
 =?utf-8?B?RmZhWGhtYWhFMld3dUdsMTVNeElsRVRFYnp4amJKd1djT01lbGtDK0psbmJX?=
 =?utf-8?B?aTVrUWNuSFhPeEFOUDRNaFJNRm40dm90Q1NZVUEydWNXRG52Sm1IRUd1ei9y?=
 =?utf-8?B?QTFtTk5kS29qK2xqQmFDRUh4Nno5cGUyZDcyTEFRVWN0YXpOTW9DWTRwR3Bj?=
 =?utf-8?B?a2pjOE5RRld1OXV6TzFtay9MOFZSRjlTTlF4cXpab0pIOWRTQWlYY3BrN0dm?=
 =?utf-8?B?SWtMTVZuUWpuOHBKZENHNzBhcENaNWp6YytOU0lFWE1tZGpXNStTNE40RkZm?=
 =?utf-8?B?bXF4Ny9RdjE2SjNqQnpYd0szcExLUWNXVEF6ck1CU21HeXZLdUxiRFNQejNM?=
 =?utf-8?Q?GBaRMj0i8Bl0Ou8apqvxvwcVD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 535f02cd-b064-48da-11fb-08dce3d458b9
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2024 17:53:54.2356
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dqiYE9IhgqSaB39SVYlTRY6SVa+kZS3dUL4gLf6mGq2nZZ9vUJREYYSQrThOtt4GYVi2hbZvnnPeusll8m4/Og==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7686

Hi,

"Panel replay" is a power saving technology that some display panels 
support.

During 6.11 development we had to turn off panel replay due to reports 
of regressions.  Those regressions have now been fixed, and I've 
confirmed that panel replay works again properly on 6.11 with the 
following series of commits.

Can you please consider taking these back to 6.11.y so that users with 
these panels can get their power savings back?

commit b68417613d41 ("drm/amd/display: Disable replay if VRR capability 
is false")
commit f91a9af09dea ("drm/amd/display: Fix VRR cannot enable")
commit df18a4de9e77 ("drm/amd/display: Reset VRR config during resume")
commit be64336307a6 ("drm/amd/display: Re-enable panel replay feature")

Thanks!


