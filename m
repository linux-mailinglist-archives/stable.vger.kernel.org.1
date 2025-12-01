Return-Path: <stable+bounces-197916-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 76535C97BC4
	for <lists+stable@lfdr.de>; Mon, 01 Dec 2025 14:55:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 212A53446D9
	for <lists+stable@lfdr.de>; Mon,  1 Dec 2025 13:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3A2930EF85;
	Mon,  1 Dec 2025 13:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="eBwVJ34U"
X-Original-To: stable@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010048.outbound.protection.outlook.com [52.101.56.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5232F6587
	for <stable@vger.kernel.org>; Mon,  1 Dec 2025 13:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764597315; cv=fail; b=RPB33CQs/+WpQK5xIszcfAtZAAso/7x1KRNgpwZJ+JHGPMEAmgOuUfk+Ml0EbO17x/FueVPLX0yMlcwbr2DGmeCUxOzWBn5W8CztHDPQ5tSzi8wuRFj4aeXBAfz6Klutfa9GZ5oVEN1qLDYmYkmDl59Ps4TDspaxG4qpG/gvNTs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764597315; c=relaxed/simple;
	bh=tkgZHeOjuk2Tysp3qnGCzQ9JQRLQrhJkhfJ7jFOaC74=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mxwL2s654pJciQUOkKG1RJEuBJrdHnylNBMyePDnizAuCKvintj7qD401NtyrxDNX+3akz7ZFFnjirUXm7/rqYwt4o0+CMYeNsvjqGhZsdA/exnrx08pPqudh+Dn/x/qX0rvPlHW9/30RYgCoNWXZs/XYytuWN6nu7Y0MI5lLm4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=eBwVJ34U; arc=fail smtp.client-ip=52.101.56.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IFyDAwLlKm7aqsqilPSY345BcxmfCF4zV4lufcZ7FKB6aknGEeGPDKIN1vpKQxkzX2akoE2yYB8ZxuMGrW2HAwyHGtnZTO+wA5I1p8Svna859EzVgigJ3mhvFsvdNAlphlazWCqxwSYmeujWITSxlUWA8X7ijenWeX2vqQtp4N0oMMGLat/Wo4t0CJN7WRh9QsmS5aJm5AUE+J+8crwnvoeJMueiGjy7xRiypnt3JuDq0976KSHpMgUJAGDZxS3Q/MN7EFLHVtDNjoVqFqYkoNcCl6caMi257EbDvzOZHYVx+D/FdwmMLDqh3wnVNYZCzMQoeLnX+3DxW10FvYqEhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BDEUltlgnHx369QxAjBRfoVrEM2Uvbqa+EanI38fz+s=;
 b=iHOhIh+w0LQVztPAVug52i98ZileKtGh+NUvKYPes8Z13jZQSUS0rPH5VPKnPT4j5Hs4Mil/9mcKhsnOrGxvZNXw5HVOGde/XwamR2YzriTzU1qJBcZCU3ieQ0gY+QcpjJk2ZQQTvAoUq9vBMFvzkw9mq8Qey6WI4SxUS3iWBE5Tnx7HK+/CAtzOi6LTl6uNWjICOpG/fxJTcgXeNY8KH/oBFZFXmRpcfB0bRDGev7qxl/AblWtJcUyprK60Ukd1F+InENjLjmBOLMD2Zw9Xretx5V5ouUZChq2wUVXdEvkXuGDJETG/ThhFEsdFcajRn/FkWTV3gDdJejJ9avsZug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BDEUltlgnHx369QxAjBRfoVrEM2Uvbqa+EanI38fz+s=;
 b=eBwVJ34UI/PeXF6NpmJKe3O25dTEc0RKQaGKLedER8GPrhEWAIJHypheDk7h/waIUeiGii/b5S0ekWq0C/Epg/RzpqSZtY/9uP2fFcVq1G2XFj4kRyYrMeatpBjoJwRKtaVhnJXn6SdfWil5mH3kq1KhTR/GmjnhsLFToihOaCM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH3PR12MB8459.namprd12.prod.outlook.com (2603:10b6:610:139::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 1 Dec
 2025 13:55:11 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9366.012; Mon, 1 Dec 2025
 13:55:11 +0000
Message-ID: <2ddf2713-d63b-4911-a079-bd61cd11cc5c@amd.com>
Date: Mon, 1 Dec 2025 14:55:08 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Forward VMID reservation errors
To: Natalie Vock <natalie.vock@gmx.de>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, stable@vger.kernel.org
References: <20251201134147.10026-1-natalie.vock@gmx.de>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20251201134147.10026-1-natalie.vock@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0020.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::7) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH3PR12MB8459:EE_
X-MS-Office365-Filtering-Correlation-Id: 82037180-b116-4f32-564b-08de30e13ed2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bXFDNWZYcXVBMVNSMXpvbWZQSmlhRmNiVStjU2twQ1NEN1FVS0k4eTVQTmtR?=
 =?utf-8?B?Q2lhcnoyUlk2ZUd5R3hlVG8wS0lPdk9sbjE4Qy95WXVuSG5kVUpVV3o1RU1z?=
 =?utf-8?B?TmFOWENScmU3c1NtbHpQWGRSL01hdWpGeGl3eDd6ckp3TEIrY0paMWtScE12?=
 =?utf-8?B?Mnp6NmZvU3BXTTd2N0ZqMXcxbHN6MVNxUWVKUE5XaW45T3MrcEdKUkRoR2Jm?=
 =?utf-8?B?MGpnWVFnNnF2SzY5ZE1tTjNpNnpneXViSXhGeHdGTDZCbERmdXNkNGVyMUs0?=
 =?utf-8?B?NHJvRGMwWnRMb2FONldKZm90QW1EbmFPSUFUeDQ5UmJaakdYYzZqbERPUUFu?=
 =?utf-8?B?Z1hSMjc1dlVBSmVPcVMzU3VpQW9sbFZMYkZFa0p0WnEzL0ZpU2huWVdzM0FC?=
 =?utf-8?B?aVlaTHpQNUFnWUptck5RbkhxOXBzellnSkZvdncvNlZvWmswNmdkNjBqZCth?=
 =?utf-8?B?SXdXWFc5WVh5UUkvZW16OXU4bmpmS0VGMEZUREpZRXJaQit6aSt6a2ZCU3R4?=
 =?utf-8?B?SWE0d29sanlGdHRGTW50SWdzR1VRa05IZDdzRjUzWE1RRzR2NmdLZVplL1cz?=
 =?utf-8?B?RURvYk5nQkxUbTVpNE8waDM5WitLcUo4Ulh6elk2TUJNejd5MmtaaXhCSXU0?=
 =?utf-8?B?Z1Z0WEdibng0MXV5dE9zcFZTVkVhZGRseWc1bXRwRWlzaTlmR2prNkhveERa?=
 =?utf-8?B?MjJkZlUxaUZSVngrYStyVXhUemU4QzhUWnlxT0hvTEwxNEFmVzN6TUxJbHJC?=
 =?utf-8?B?ejhNMVNWTnRhMXVMaks1T1g1NmtyU0tVd01wajhBazlZQVpzV0VSMzNXMnlY?=
 =?utf-8?B?TG4waTByOGxZMzBEa0FMbk8ybXZZRUtaZVRGS2dyNHVKZTB3UERXTHkxakE4?=
 =?utf-8?B?STZjd05JN3Z5QWhkYWV2UDNIcUZnL0hjTUVudDRFa0o1RHd5cGZ5RmNKK29J?=
 =?utf-8?B?Y09XdEQrbkhxb0RpQksxT3hua0hwRFBFemR6aTFQdDdnUzJXVmJBcU9LTllk?=
 =?utf-8?B?aGlZa1RTWiszRkNYeWdXdUNTL2ljOXprZXlpOGNkcHdKTTNKQnNYYWZJUnRR?=
 =?utf-8?B?ZnlzK09wSmNKSjkyblhLeENhcWk0Z0VJeUEzUU80Y3ZWVDhWaW5WUnN6azFv?=
 =?utf-8?B?K1B3ckgrNmljVHdOSTlPU2VvbnRjZVRkRGw1T2JKcnJHeFQxMUJpNzlQVjl0?=
 =?utf-8?B?RG1mWDFCN2ZjYWR6dmtSa1NiMG5uU0hiQzlnc0hOeVlVZ2RIWGVidk5nUmFP?=
 =?utf-8?B?aGJZQlA2UndRTVBYNDh2cVpPN3Z3YXFEQk5HVzRVTmIzVkwrREpJa2dycUJT?=
 =?utf-8?B?RkdsdDlXZVZVSDlxVDlyemhYNFEveEpXczl2NjNzdnNFMmEzbzhWVGQ3eWxj?=
 =?utf-8?B?clJjNFBzOXh4ZTRvWkR0WkJIVk16WnpUV3Y1SFFva1pma0xaQVNnbnBFMnJ6?=
 =?utf-8?B?VHV1VU5YYjlBRlcrYU5xL3lzRENONEJvTDY1UXJBQTRwRnllYzVaanBvSEVY?=
 =?utf-8?B?L2J2akcyVTQyRzFlNEVLTFA1bS90NVpCYU02ZzdPSmFEVkZLRnhQYXcyTU5V?=
 =?utf-8?B?M1c3RVVNWjNQWThHR0x6VFlUcDlWUkhCT3hsUHovS2c2a28rSlh2TTVZL3M3?=
 =?utf-8?B?QVlTZkVYY3RnM2swaEpuTGRvWExBci9GdWdGTzVQMGFOZHA3NG4waGQ4QkdJ?=
 =?utf-8?B?ZVorajZudW5BQ2YrendJTGlxWE9zakZwN1BkczBBcjBTY016WDRscm1mSldF?=
 =?utf-8?B?SkJrOHk0TEs2UUduSjB1UzQzc3pOdGsyditWbDMxeFdrZjlETE9hdUJtR2hi?=
 =?utf-8?B?YWNXNTZDTWgxdEsrNm9pTzZZaGRNY2tvYWVoSXJiMS9GV2VwRWRLTUlzOURY?=
 =?utf-8?B?QkNpSWkvQTB0YWR0NzJLUG1tM0ZBbnRMd0J2RXdIb3c2R1IrcVRpOHFQM0c3?=
 =?utf-8?Q?QwqnMeIWVUqtAftX2FgPBUy+5i11r/Pz?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UUkxQXBqdTFrTlJaV2JOYjFvTDB6UDVvOFQ3dGtVTkFRb0kyY29RN2kvUi9Z?=
 =?utf-8?B?bzZhUlFxU0F5dUdDRzQ1Ui9lS0RHekRqdWNjSDlTdVNhcUt4VWlRcTJGUlRp?=
 =?utf-8?B?VjFQTXZKaGRGVDB0enJyWjZIOS8zV0ZRRkVzWVpHSy9oR3U5NFNUS1NxVjFz?=
 =?utf-8?B?b043MTJ6ckU3dElzbjQ2T0ZuaWErUG41bFB0Zld5VnB6ZS9oWlBYeGVBeGtj?=
 =?utf-8?B?SHVOSDdpa0lKWW9oNUNEZWY2NElqQVVML3ZNc3NvanRvek10Vlp5dGxYNnVT?=
 =?utf-8?B?WnBIcER0b05VYTUySWE0Z1NLdkV0c2I0Y0N3MnhHMURTWVlKc1Y3MEg3c0Np?=
 =?utf-8?B?R3RPNkpUL2hGSEkzVWN5aEJPZXRrcWVTQVh1SmxrL2h2b0JSSEFzT0ZTR2I1?=
 =?utf-8?B?QWt6czFUelRUUFg2cFZGZVVUZEtob1VZQWtMRkRaWUh1dE92MFA5UVlkei9I?=
 =?utf-8?B?aXBIclppR0xiSitVRmYvU3hWdURqVzNtUWl2TCtBMUswc3FIcXRSalduejNo?=
 =?utf-8?B?VUhvaGFndTFQc0VkZ21KVWRMNm91cEErUFpUcUhNSFhLUEhNK1NPN0hGMWFY?=
 =?utf-8?B?RXNIbTIxamx3VkVzQ1ByNzlOMG1Ydjc5VTA5V2ZWZ2xGVS94d0x1QUZySGJa?=
 =?utf-8?B?MkdMN08xejB0bGg0Ujd4S1hua3V6MkFQOHFpdi9NZTRmTXVEN3JKYzF5UXIz?=
 =?utf-8?B?TThrOVcycGdPRXgvbHhTWGlQVEEzQit5cnJxcHdZZlhyMUJCejh2ZW1na3R2?=
 =?utf-8?B?emYyNTZla2F4N3VJNExMU0w0NmxaYmJuUEg5VzJyNFNwU1RLZDROcTlpK05l?=
 =?utf-8?B?cEFpd1ptUjhEdlQwdUtvS2d6MXJ5U0JrektzTUZwQkFaWHh0MDdrcERIcmpk?=
 =?utf-8?B?L1lzd2NtS0dNQlYwNmFyelRMNGp4dWRnaFFqZmphZE0zRTJuVUxpVUlLM0Fi?=
 =?utf-8?B?ZUFxQXB6ZHNxZE9FR2dWR3VudnFrbWNVQ0Jjb21MU20vYTNIalZlRE56WCtN?=
 =?utf-8?B?dHdZN3pHSTRrbUlpeGpOaXN2UDJxRVJKblBUM3FxVis3djRqNTBDUXBDNzNa?=
 =?utf-8?B?QjhRdWtObGkxK09uamsvaHdkL3A2QTBsS0lZcEhJdUlHWW5zK1VZRHdEQSs2?=
 =?utf-8?B?bkdVTjArODZkT2RkYk9PZEZvUFJmbWdDK2pZdGxaRE9vcG94SGdHNDY4bG1n?=
 =?utf-8?B?MDh5NERKSlF3ZFJ6VTBMUXZQZm5SVjN4dFFqNm5pUnFwNnpuNXRPcHVSMjR0?=
 =?utf-8?B?MjdYKzltMlF6ek1CMWJSTVhISDNoNnJSZ1VlSEdBNnpqRGQ2UUxKd0xjcW1t?=
 =?utf-8?B?WjNUQnZWVGd4TzhkNFB6VCs1TDJRWHc0NURGMU5ieUpYYkd5Ry9iWnZkMHBK?=
 =?utf-8?B?UVo3bHlMczBkWU02ektFOWtWL3M5VjBiUXFBMGlWWm5ScitOMXVxL2ZENjV4?=
 =?utf-8?B?TnJLSUl5TEd4QkRnc3gxcmVldWFtM3d4ZXhvMitQWEEzTFpET3QxOTduVnk5?=
 =?utf-8?B?MzVoWVFoSWxUaHdvb1paUGQxbGlnZWZqWWVuQzdhams0dGk4dDBZTm5EM1Y4?=
 =?utf-8?B?MWt0TDkwbjJST2Qvc0xicUxzUGRVZTZIWGNuNUNEbWxJMDkyZmpuM0kwN2lX?=
 =?utf-8?B?WlpDNzBnTDY0TEVueVVBZUUzRzdwNFA5UWVBNmlWQ0R3QzF3ZnRWSTZPVTlB?=
 =?utf-8?B?OHQyczMrb1VNS2pWbEJ6Q25ncG01Y0hCV1RiZmp4eXhLOUpOQWluczYxbzlK?=
 =?utf-8?B?QTJCOUgrUXV0K0NVb3pzSXFRVmZNMmZKV1pVMU1mOEQ3NHZkbE1VMjE5bUVX?=
 =?utf-8?B?bU5CWFVBOUNFUU1qaGI1SlBUbjJPdHZ5RklFOFo5RDZlVlk5bWc2MmVFdUhi?=
 =?utf-8?B?enBxeFdicEZiMUZTeGRXMWYzVjVRTUppcnYzZm1pSkRVYVNmMlNacEZnYVR2?=
 =?utf-8?B?MzYybFdrVmtnejk4UlVneU1xTGxCRjhmMmhjRzY0dFhjbDZ4SkZ6bEJudDNW?=
 =?utf-8?B?MEdWbkhHRVFyMmhEcnBaTnlwMlJLSzBsVHFnN1BIc0tiOUMweFJQN0tOd05u?=
 =?utf-8?B?UFozOHJOM0RXYWc5NjVaQzdIa0U0bUlFTVFjczRuRzA2RGhQTXNteFU2ckZQ?=
 =?utf-8?Q?dstqUCWlGGVioLuj8vy7NRD7m?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82037180-b116-4f32-564b-08de30e13ed2
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2025 13:55:11.4493
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CElpsGUbYrbE0+yvN2pgZZPTR4AmTbtCfOlHeVvgfm8r2IWkr8usBvOwN6lizOcL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8459

On 12/1/25 14:41, Natalie Vock wrote:
> Otherwise userspace may be fooled into believing it has a reserved VMID
> when in reality it doesn't, ultimately leading to GPU hangs when SPM is
> used.

Good catch!

> Fixes: 80e709ee6ecc ("drm/amdgpu: add option params to enforce process isolation between graphics and compute")
> Cc: stable@vger.kernel.org
> Signed-off-by: Natalie Vock <natalie.vock@gmx.de>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 61820166efbf6..52f8038125530 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -2913,6 +2913,7 @@ int amdgpu_vm_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
>  	struct amdgpu_device *adev = drm_to_adev(dev);
>  	struct amdgpu_fpriv *fpriv = filp->driver_priv;
>  	struct amdgpu_vm *vm = &fpriv->vm;
> +	int r = 0;

Initializing local variables used as return code is usually seen as bad coding style, but see below.

>  
>  	/* No valid flags defined yet */
>  	if (args->in.flags)
> @@ -2921,16 +2922,16 @@ int amdgpu_vm_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
>  	switch (args->in.op) {
>  	case AMDGPU_VM_OP_RESERVE_VMID:
>  		/* We only have requirement to reserve vmid from gfxhub */
> -		amdgpu_vmid_alloc_reserved(adev, vm, AMDGPU_GFXHUB(0));
> +		r = amdgpu_vmid_alloc_reserved(adev, vm, AMDGPU_GFXHUB(0));
>  		break;

You can just use return amdgpu_vmid_alloc_reserved((..) here, no need for the local variables.

Apart from that looks good to me.

Regards,
Christian.

>  	case AMDGPU_VM_OP_UNRESERVE_VMID:
>  		amdgpu_vmid_free_reserved(adev, vm, AMDGPU_GFXHUB(0));
>  		break;
>  	default:
> -		return -EINVAL;
> +		r = -EINVAL;
>  	}
>  
> -	return 0;
> +	return r;
>  }
>  
>  /**


