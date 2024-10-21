Return-Path: <stable+bounces-87627-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C7449A7375
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 21:23:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDD171F21650
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 19:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6B581F470E;
	Mon, 21 Oct 2024 19:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JKkl55Lr"
X-Original-To: stable@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2088.outbound.protection.outlook.com [40.107.101.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7FD1CF7A6
	for <stable@vger.kernel.org>; Mon, 21 Oct 2024 19:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729538597; cv=fail; b=lOIhNDZuI4lUOwDyTn4M4+p3oSb2ijGQWWuPBymq8lLVMUo99998QWnByoTOdqDeXsayIIXpYw+ZVvXJAXw7nu7LTWscmRPZxXMrWNzi8grfpy321o6RtSjG7BQAyADVRriJYySdQf+qMO0xy8gDYZJEGm6Eh5r1TqC825IJcFs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729538597; c=relaxed/simple;
	bh=1Qdm2DL8eflaqwm0QBbrGLPejMgvsj/LjGlJffQZm/k=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=t7NuyUxXoVMsFt+xxMIK7bT8+V+DTxqE/lq7VmBV6D1YjKbnswzr96YvR5fZpaJbt/tTwgYLncMkpLOkQADrfDSDH4VCqmO8d7smnsgUdX9zt52BiRB0cr9rXGZ5D/yqHRF0NAGFkKSzcFZbGLcaAuYxoD0MRVtMGtJTtztnRUQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JKkl55Lr; arc=fail smtp.client-ip=40.107.101.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tNAUGrLBTjFUGPmZis5h3AFfTanbC3sjaxjpEWCYyYpYZyTQaXiBt8GcBTbW4wHUdyLOxUsvMC/VguNmnCOk/ebKZNjFYOg/X82orJCWxGkRhxNuADuLHNoiNAXOxrJUEcqNLQQdIXechoWFEjV6yhkhdWCwUCYSUeaClBLIb3IGLNr6WNXgpQztTWeIaiR/5j4Xym/qlEuWszXqfaPGYn3MHAufGw7OdChcesdm/RSU0C/9wM9gcLbCE/nQ+b8Tm1TS/NCJHMUqi8j2voTm6AbMGkJu9Eal7CrejaIY/Q1ayUUo1gPNbrgHUR4Cc5xE7tWtrdXVGUOB1vUzF6b/Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C1mgNr1kzN9Uur8fmD1sl705sfpii72JxRUHtyqki4E=;
 b=L3wLbxsufZDwUNkw/mqFli2btA6Iz8Zv1RcFWC52+5Qqu+eQufqxaqGa3NCifYSIEkUpR/7GnfXJDgH9PKvH2CVmtN95IVKNmdBqy9/N147yfKI+U0jBS75J18wwir9I3oKshNgmSzLPbjaeBEoPxexYNtIx8xMFwCwvKDNz73Wi3LNRSPcgY6sVBAW/YOHuhTZTcQIK3Oge3d6j7GVoYZWh6ByGoOKyMxTSQNu5UUksM/0SgouwLc+22y8ryTtjURWgpHA1ZZ16exUoqAF4imoqx1SRwgIAGNfTDkVIe+HCHaotqrtdowOVluconn6+7nn183DNkIzgFaNkNQTGgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C1mgNr1kzN9Uur8fmD1sl705sfpii72JxRUHtyqki4E=;
 b=JKkl55LrHmKj2wEAdCHeOCoFI1mts/q6qaf4tnt8ZJy3CWv/NwrYGJVYTIHyTkkZierA1Ew1wzGB78Z5MQQ3XsoiVNuMgonmJMLighWTakoijeys+hNQet7PJePi7KU0LnD7ZO5agSGgPQ6XR+VjIE4xzd/oKBqA2IV5H39f5Cw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5311.namprd12.prod.outlook.com (2603:10b6:5:39f::7) by
 LV2PR12MB5776.namprd12.prod.outlook.com (2603:10b6:408:178::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.26; Mon, 21 Oct
 2024 19:23:10 +0000
Received: from DM4PR12MB5311.namprd12.prod.outlook.com
 ([fe80::a846:49eb:e660:1b5b]) by DM4PR12MB5311.namprd12.prod.outlook.com
 ([fe80::a846:49eb:e660:1b5b%4]) with mapi id 15.20.8069.027; Mon, 21 Oct 2024
 19:23:10 +0000
Message-ID: <55d702c0-70ca-4328-b798-29b379742b3d@amd.com>
Date: Mon, 21 Oct 2024 15:23:08 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Disable PSR-SU on Parade 08-01 TCON too
To: Mario Limonciello <mario.limonciello@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: stable@vger.kernel.org, Marc Rossi <Marc.Rossi@amd.com>,
 Hamza Mahfooz <Hamza.Mahfooz@amd.com>
References: <20240205211233.2601-1-mario.limonciello@amd.com>
Content-Language: en-US
From: Leo Li <sunpeng.li@amd.com>
In-Reply-To: <20240205211233.2601-1-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR01CA0117.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:1::17) To DM4PR12MB5311.namprd12.prod.outlook.com
 (2603:10b6:5:39f::7)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5311:EE_|LV2PR12MB5776:EE_
X-MS-Office365-Filtering-Correlation-Id: ce0731a0-b3bf-421a-a1d7-08dcf205cc97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SHpFWklTWnpvQ0xESTRDUk9IUlljeGJCajJWQkRSa3JYdWN4bC9rNWZkTzRZ?=
 =?utf-8?B?aDA5UUppb285RWhlNEY3Q2NTbmNXcDNleHpKbi9UQ1gyTWxmSjZpdm5wNk5T?=
 =?utf-8?B?UmVleWNZSjFtQ3dzVG5kazl0NlU3RlA3Q0F4M2E3c3MweVllazBLZ00vOFBJ?=
 =?utf-8?B?WHprSW9ubEVKdTF0UzN5MEc0U21PelJIVmszMmszTXcxQkZqODY2eEs3aTQv?=
 =?utf-8?B?OE9uejExd3dKOWxLdHliWG9LZlNKUzdIcGQzV3lpajFoWU8za0U1TDNKK0Y2?=
 =?utf-8?B?akJiaW03aktFL1ZLanJ6aUR2L1VhSDRMLzlDKy9JRURhbm9aNXZiemZ3Qksv?=
 =?utf-8?B?RTRnWjBoOUpyRHRLdXBydTBRSi9HNjM1Z1U2S1NpeVFsa3ZmS21jYkptYlAz?=
 =?utf-8?B?STBZdVd2RDVIRTB5MllHNGNRUVR4MVNlOFJTR3k2amh3T3YvbzVhTXE2dmtz?=
 =?utf-8?B?WGxheWlwNFh3Ui9JU2xyY3hjdHlIM3hBWWdkUVFVczd5eGNkOStwMGx3RW0z?=
 =?utf-8?B?WFl2QkhQVXB0bW5lZ0Y2eDBGZElnWjdsOXl6cWNJbE5Sbk44VFRBOGtBb2FS?=
 =?utf-8?B?TXJOaEFrZUFES3BRTzBsQUg2R1VIWmVjOTkwbXpsWndUOHhGcDdBcS8xUkVl?=
 =?utf-8?B?NE5DZ2UwQzBZMmpzVjVOaGpQekI2SkZ0eXkzQ0Z1azR6a1JKWnk0b3RYRE1K?=
 =?utf-8?B?Y0tscWQ4TUl2UGdFbG00WFZVTlg4MjNWS2w4RlZYY0RrSFo3eEFzbDF2d1lO?=
 =?utf-8?B?UXUzSWFZTzFNRkttSit0c2x4blhsNFFJNXhqNFN4RHE1K2xzM1VXRUpVQkU2?=
 =?utf-8?B?VVN2N0c5U203RTRHdjJwdTNhbVZsZ0NTWEhjbnBHcU9BNnFhdml2U3c0Z2xX?=
 =?utf-8?B?UkpTZXlUYWFEVHl4MUlRVWdwTFJVL2JmdFBHYzk1NFdRUjg0MU9GZ1Z4SGVm?=
 =?utf-8?B?R2U3UXdSWWJnZ2lZeTJyTFVtUjJNN0V6NFY2cTlIR0h3RU5qNG1MQlZ0WnRN?=
 =?utf-8?B?NDNYaGRqcTlRcmtNdUVsdFYzNEV3NlZGZW1ITkN1ZjdPdGpmVVkvOVZTUEZm?=
 =?utf-8?B?TVpZbGdPSmxrbFYycWRvM0QzRlRnTStKWHZrN1ZUMzlFcTdqaXh3VVEwdWoz?=
 =?utf-8?B?Z2E3M0lxN2M1bnlhdW9STjlpYjNQZVdIVlJweXFscGZIK0dWTUFKMnkyL0U1?=
 =?utf-8?B?aW1tRXBzbW9uZnVGZ0JNKy92d09wbWVjK3c1YXBKUlZtZEZydC9LTy9wb2ZK?=
 =?utf-8?B?OEZhZXJJazNGTXJxUjIvWXpBZUlWYW9RbXE5b1ZUQTF4NGxsSW4relJJVE9v?=
 =?utf-8?B?Mkh3ZUlWS3IwU3RPUU9qODM0eXl5cnRkMkd2c3hlVzkrNVo0WjB5QzRzMW56?=
 =?utf-8?B?OHYyQUpKR3NxQmRwUytTOXRHb2ppaUdmemlLamk2bjc4NU52b2JmSzByY2dW?=
 =?utf-8?B?VlFvd3ZwK05hQmhHYUJ2MjNzZy9VNVVkZGJseVRyNnVlODNmRDVKRlBuWGZt?=
 =?utf-8?B?Qmx6cUNSa3lNQVp4MSs1TGR4eWxaQzNuby9KbWJNUUUwOG5NaHA2RHo0MVZQ?=
 =?utf-8?B?S25MbUtnNHR4RHFtMUZoY0hkVHZGeWkvYTZJcjVKQWV2VzFvVUJKeTFaMnVX?=
 =?utf-8?B?dk80NWZ4eE1ib2c2Z1lxMzQyZGEwOG9OaEtFQnY5ZGdBREVBR3I2SVJnYm5W?=
 =?utf-8?B?SHVqd2poR0ZlNCs1Ly93aHhLQ3ZEVzRDdUlNZjl2L2MzZ3MvWWJsakJBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5311.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V000T1VxSDVhQnBhYjhSWFlOZE5DZGc3OTMrZWtkRUpqV3V4Tlova2hqUC9R?=
 =?utf-8?B?L2JqZzdmTzc5L3Azb2pTRFdGdDk0NzZ1ZXpRVDUra25SWEc3WnUvV1Y0SFFQ?=
 =?utf-8?B?N2hqYjVIM1grSHBKMVJQTjd6THY5WVEzVlZ4WC9HRkVKNkU5TVRxVGlKa1Rl?=
 =?utf-8?B?MDNaS0ZLcVdTK1B1SnhQMk9WbThmQjIvWjZuanlzeUFRRmJMZjVUZFdRTDVF?=
 =?utf-8?B?NjhLRGdhNGwvZm5zZHlMTXhDTGIvZ1pJRUp1TUxuc2xCbVVhUlMrdDU2NHMz?=
 =?utf-8?B?alduZ0RKejVNc054NmovSHJNOXRvS1k1NkJKSjVkdXdqbm8vSy9Cdzk2eW5H?=
 =?utf-8?B?NnNqTGFZT0RNKzFsOExRSlorWFdWQkpPakN6VnB0bWY5aUhmQUpYWnJnV25C?=
 =?utf-8?B?Z2pYbVZCcjNMZnlPYklNZm1DMGhHTEpMSWR6YXZxY3p0L1NKaHNsK29tRGFE?=
 =?utf-8?B?eW90ZGhncEZkVWU5aVZUQWVYekIwZTB6U0FxWU83NStYU01UQmkwS1FXclIx?=
 =?utf-8?B?dytSeGtLaHdmcjh6N0NDaUF4ejljWDAyL3U0V3MzNFRuNFZmTUhyTVIvRkdX?=
 =?utf-8?B?dlpKZmliRUdQS0hyVExaWkVaTUxMUUlncEtvL0NlUzJ6UUdTMVNqenhQUHRu?=
 =?utf-8?B?c29kUjVwZDNvbTM3V2EwbU9SeHBSVGRNNm5qeXdqUnNhd0ZYQTg5eWM2T3Fn?=
 =?utf-8?B?S0JkWUFyM2ZOQUZpOG5zOEhjZGhZSkNJSnV5WnU3QUluRjBIcktNZk4zVzRF?=
 =?utf-8?B?NTZsNWM5U0E0MGNSNm1SSDlneUNia3JidmdHM1YwTzVnYlB4RUF1aEdadE1O?=
 =?utf-8?B?Yy81OXVxUkpQZ2lrMGxoY0ZnQkhvenJEQWFWb21tYm5BM0RHdnRSY2E4K2lZ?=
 =?utf-8?B?dldBNDZIRC9rdVFFaFZwUkZzQnB6NVpCTXpOcndoNVd5OXpvdVFMc1FZM3lq?=
 =?utf-8?B?UElvWUN0eHlxVkdQY0hzdGU4bkhpdFl6OGZEWGk1MmFpUHZTZVdGalExY2pi?=
 =?utf-8?B?VUtBb0hOQzcvT0hmVkY4bnFpQ3VZWHN5aGRHNXBNY3BaQzFwN01lbnkzVzV5?=
 =?utf-8?B?NUg3UERZMEpoOWhWRklYWkJjNG5tSXVhOFJ6UHhMbTBYSnZrbWhmQ1htVHNQ?=
 =?utf-8?B?MFBNWHVibDhBSkFnQlZxS2FPanRvd2lCY3VGa2prV095MndNZGVFVGtremFD?=
 =?utf-8?B?ZDBwUS9xS3A3d3NlOG5raTlOeGlGV3ljUnZXVkc1STAzZERDN3Z3d05YTkJN?=
 =?utf-8?B?ZnVNUjIrS1pxQXZtMDZ2dmIyQU5ZSEtRajlWQlhOTldQUWFsekgxcXMzMTBS?=
 =?utf-8?B?TU5yVmhvUXl0NGljQkZkcE9UQndsdHJPOVBlSVVjNG9xbkNsd1lBQlJoZkhQ?=
 =?utf-8?B?cWxEemkxb29WTktmMEFXanpKQi8xOVYrTHRLOXVGRW9sVGRmdVE5Y0k4blAw?=
 =?utf-8?B?YTA0eDBuSGtCcVcycjkxTGkycE1LUXdzdi9uRFFVZmJpbkkyRDJpTEFSOGtK?=
 =?utf-8?B?ZUJwRzdsL2pzUlJZVXp3cE9HVVNQd05RTklhVXNvSzFhRTJLNy9COU9DaWdH?=
 =?utf-8?B?RHRjWmRsYjJQc0hHSWVIb2pqNXBnaURXTTAzdjVTanN2eFZkdVV3SGNSdjFj?=
 =?utf-8?B?NzBoa3N2YjdyNDVnaWpoaDhRemp5K25JNjdEL0pOTCtXWkFsNHFManRFdDBO?=
 =?utf-8?B?SzRFQ0t4dWdsSi9qdG93d1hjTDJIK25UYzFhWTRlblM3OFEvSzlJTUZiNTlN?=
 =?utf-8?B?YUxCa242SFE4MHZma3ZGYTNrcFF0Q0dwRkdoM1RZUFhWQ0Q5RzhpcG40c2Q0?=
 =?utf-8?B?bGJTckFuazJkSktpelhaOWx2QW5zZyt3Mmt4bXh1TTZaSVlIOFBFYmg2L2du?=
 =?utf-8?B?UUdwWk9LUGowaTR0TlBPNEk2cWpCQkJYc1BTUGRWc2grM0QwWW9NcWFGZWZE?=
 =?utf-8?B?dTc2YTVoQVRsWUsrZStzSGFWOWUzcWtQSnA2LzQzKzY0c0hiR0c5WGdnbzZ3?=
 =?utf-8?B?ekYvTUhJVXljTDNROU9udDcvdGJLMUxVOXNDektJVW8rSTF3c2tVeHIrZEkw?=
 =?utf-8?B?aGJrMEVIaXExVy91Zk8rOU56L3AxSVJOWEVxRjhjTHMvajg0QkxSckNNNkY2?=
 =?utf-8?Q?Sils=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce0731a0-b3bf-421a-a1d7-08dcf205cc97
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5311.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 19:23:10.5139
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3xeI+4lXkrhmnYtaNe5sgdoVcr4PaAQaDhrwlH/lqvFbkJMJFtuhOPfLQoLgDjfB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5776



On 2024-02-05 16:12, Mario Limonciello wrote:
> Stuart Hayhurst has found that both at bootup and fullscreen VA-API video
> is leading to black screens for around 1 second and kernel WARNING [1] traces
> when calling dmub_psr_enable() with Parade 08-01 TCON.
> 
> These symptoms all go away with PSR-SU disabled for this TCON, so disable
> it for now while DMUB traces [2] from the failure can be analyzed and the failure
> state properly root caused.
> 
> Cc: stable@vger.kernel.org
> Cc: Marc Rossi <Marc.Rossi@amd.com>
> Cc: Hamza Mahfooz <Hamza.Mahfooz@amd.com>
> Link: https://gitlab.freedesktop.org/drm/amd/uploads/a832dd515b571ee171b3e3b566e99a13/dmesg.log [1]
> Link: https://gitlab.freedesktop.org/drm/amd/uploads/8f13ff3b00963c833e23e68aa8116959/output.log [2]
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/2645
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Reviewed-by: Leo Li <sunpeng.li@amd.com>

Thanks
> ---
> ---
>   drivers/gpu/drm/amd/display/modules/power/power_helpers.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/display/modules/power/power_helpers.c b/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
> index e304e8435fb8..477289846a0a 100644
> --- a/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
> +++ b/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
> @@ -841,6 +841,8 @@ bool is_psr_su_specific_panel(struct dc_link *link)
>   				isPSRSUSupported = false;
>   			else if (dpcd_caps->sink_dev_id_str[1] == 0x08 && dpcd_caps->sink_dev_id_str[0] == 0x03)
>   				isPSRSUSupported = false;
> +			else if (dpcd_caps->sink_dev_id_str[1] == 0x08 && dpcd_caps->sink_dev_id_str[0] == 0x01)
> +				isPSRSUSupported = false;
>   			else if (dpcd_caps->psr_info.force_psrsu_cap == 0x1)
>   				isPSRSUSupported = true;
>   		}


