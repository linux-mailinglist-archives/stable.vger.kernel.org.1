Return-Path: <stable+bounces-93745-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42B329D0658
	for <lists+stable@lfdr.de>; Sun, 17 Nov 2024 22:39:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E30421F20FE8
	for <lists+stable@lfdr.de>; Sun, 17 Nov 2024 21:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 712C91DDC2C;
	Sun, 17 Nov 2024 21:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GwMyzSbt"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2068.outbound.protection.outlook.com [40.107.223.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12FF1DA60D
	for <stable@vger.kernel.org>; Sun, 17 Nov 2024 21:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731879530; cv=fail; b=OGn9OmxFx+wLZfV1enmOJX69MVecP1Wp9MJaypesOfL4r+MxI4c+byFkJO5aFIxyk5bicNs6xJeCIUaurH0xDGBC6rf4d1P2yR7TSkHHEtDrAaxZfEB0AehXAZeQTZBmNiFBIW5gOP8L6qENtR6wo83jbKxwE2fhMjGCxxKWqXM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731879530; c=relaxed/simple;
	bh=6sotOj5JD2xfUpVXZgH9FKnLAhp47+4ZyZXC0YSFjd4=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pWJ/O0Hv6TeKCjmzfVxegruJRd9tJOOoDOLayG3SF5C4BLwmq7Y5uCbyA3kJA9lQXsc+TKStXteFlDEr4vtrKaSFfDL/Lg3sJ7+SkafIzf/jZLDoYnb1jUjZzRUBi/iD7lLM1i1VolxgOht2EvpkCKwyKHzv1gQkAG7XxBd2p4k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GwMyzSbt; arc=fail smtp.client-ip=40.107.223.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dPSgXuHizpr1PDQoeZVPWL802OmG/cbKcJPtrRhWSE3jdD1HyDUPgzc6g4aCcfNYz7xO6XbJhoQALHnXgqU5qxzHF/sCiwP5nnE1E0DDjwAwDnXtn4apgwMT3vA1ex4mwq3ffc1cRNy58Yk4BcpTpUC1fVuxpSOHNgZtmKl4g6CDtXHRtSDTkwKcv1fist6APIHoQmDzfqQ44lUvmSgudOLV8qZgJi0Ao7lpLdldmRfYSuEcrCOu9n2QFWQXFEErW3cOpmRlc4wJ+vh2KxpIiJZ8ZF7i2HvOFBOiuFf5S/5iZ9Tfxds7D1Nm49ArT0yDP7EZCVOxcQKoJz2115qJgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FRafA2R9uoDKEHWETN2TKcYaqLMjhl49a1WaJ2yU3Ko=;
 b=jLzJnqqEPqSPQkBl9r7DWzbLhU84G8uHT6flSV1ZCQ/E3nUilxZI1CXV6GfoVTpzDKT/u7T+gRCd05kf6hpxfoxAAFwN2FTFvISjR8aggwHtdxfzYymchjItGeVQOE7odi7ow7Y4aNRwPzYeIHi6Nxb5ZLadhYVOqSkkteh43lZwuJbtJ3LOpR+Fmwu6SEsEhc9djSbQ0XHHNNAAEEiR1YXIiIsniRXXSXNQCPoHTdoWD1cX9LQq+SRI8y2e6iFVSc5qSQfx3IankHvwVs9dufMtgMFTleVrQUyylRz/Ja7DZP3WR3Rv2mv0P0nPIKPZdKeO0eFot0vZBX85cef2NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FRafA2R9uoDKEHWETN2TKcYaqLMjhl49a1WaJ2yU3Ko=;
 b=GwMyzSbtqvzjibieNV/SQ/+zaOoR4QTkholqz9Lb1KIsjjyhPwRuQLwacOqX9qD63MQQgEz6JRHfd/Cir2cEtZ6qzkYBYc3uih131tpKemwL0cvKPwNN4qrMazIJkRe5VhxzSYLf7uN5nIznvmGMdb3rr4HsQlPtXpVnQUVWyb2oiAaCJMHoSyH5NEALb/KEFCa3Zsrw1zu4CZbdYDy4hTY/ZOQ0reZqk558ty2FsmQQ2R5BlLu2KSV7eZc6gX1eUZrDUlBdl0YQnjfmKNbn2aeT+fyPVpglvHqiPedVTc+MrPptKDMiNtPAbq39Dtvvkqps+MWYbJp2fMHln4Awvw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ0PR12MB5469.namprd12.prod.outlook.com (2603:10b6:a03:37f::16)
 by MW4PR12MB6755.namprd12.prod.outlook.com (2603:10b6:303:1ea::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.18; Sun, 17 Nov
 2024 21:38:43 +0000
Received: from SJ0PR12MB5469.namprd12.prod.outlook.com
 ([fe80::ff21:d180:55f2:d0c0]) by SJ0PR12MB5469.namprd12.prod.outlook.com
 ([fe80::ff21:d180:55f2:d0c0%4]) with mapi id 15.20.8158.023; Sun, 17 Nov 2024
 21:38:43 +0000
Message-ID: <0b27eaaa-2ae7-422b-8b22-e92e49ab439c@nvidia.com>
Date: Sun, 17 Nov 2024 13:38:42 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: FAILED: patch "[PATCH] mm/gup: avoid an unnecessary allocation
 call for" failed to apply to 6.11-stable tree
From: John Hubbard <jhubbard@nvidia.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: airlied@redhat.com, akpm@linux-foundation.org, arnd@arndb.de,
 daniel.vetter@ffwll.ch, david@redhat.com, dongwon.kim@intel.com,
 hch@infradead.org, hughd@google.com, jgg@nvidia.com,
 junxiao.chang@intel.com, kraxel@redhat.com, osalvador@suse.de,
 peterx@redhat.com, stable@vger.kernel.org, vivek.kasireddy@intel.com,
 willy@infradead.org
References: <2024111754-stamina-flyer-1e05@gregkh>
 <b79ed291-ad60-4be7-a2c2-19fedfde74c7@nvidia.com>
 <2024111722-humped-untamed-d299@gregkh>
 <406112aa-1909-4075-9e90-ed59cb7b1660@nvidia.com>
Content-Language: en-US
In-Reply-To: <406112aa-1909-4075-9e90-ed59cb7b1660@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0164.namprd03.prod.outlook.com
 (2603:10b6:a03:338::19) To SJ0PR12MB5469.namprd12.prod.outlook.com
 (2603:10b6:a03:37f::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5469:EE_|MW4PR12MB6755:EE_
X-MS-Office365-Filtering-Correlation-Id: 81ee6d87-33eb-4836-3651-08dd075035a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NjRyZ2k2ZzFDTnRQelI4MXJKdGpqRnFvSkZkcm1TSm5qaXNXTkdWVTFYdkFN?=
 =?utf-8?B?QVVTOTdzSFlQS3d4RVFZOHl4UGE1Y2lVT09WOE1ZZ0RzNVlYZjdsMjd5UG84?=
 =?utf-8?B?Z0U2RXVLWUN3dXdwQjhScnB3WENTM1NNTWdjQkN4cUtYdHVZMnd2TjJuWHYw?=
 =?utf-8?B?ejFJVTdOclhrbDJMc1ZMNDRSK0JOcldIeUg0RTcwWk5UNzdVZGZNK00zakl2?=
 =?utf-8?B?cTZqb0U4QUVKSzlhT1puRzFFVlUvdmZkaTZlRTJMMEEwRE1QRmJndTRnSzN2?=
 =?utf-8?B?WDg3Y1M4aS9ySHhnVHN3cXhVcmZZdWFjcTNxQkpDa2pzZzZzRS9rS0hJeGFn?=
 =?utf-8?B?d25jdEZDeHdaS0pCZ210bk43d2EwOHlZTlNWSTQ3dUd0TGpzMWtCRDllbzRL?=
 =?utf-8?B?MHRvaDZ6UkdsTFh2U0JTUjRrOGlCcUZFVW04UjNFaGZTbTFxb2U1T3gyWDNk?=
 =?utf-8?B?VTlJLzgyUVg1WE5USDVBbGFQQUVZMDVlaW01NDgwR3ZheFFUT21vRGJkRW9G?=
 =?utf-8?B?RWR1WnZvNStZTU1qYlFCVUVEUjVRR1oxV05YVWc3ZlA3ZjF6UGxsTzdjejhL?=
 =?utf-8?B?VVRNcnBWVGc2UE9UaWhYYzMxTnBNRVlaSXN5TW5oNUQ0M3RzUXVYdDVxU0I3?=
 =?utf-8?B?TWtERUlvN3QvRVBicmN6S2lsYlpaVzhCV2FMa1IvQngrWEtsd3dobnVvSGxr?=
 =?utf-8?B?T2FSWUN1TUM0L0twRWphMVV2YkdFTUlGdEZHNVhITllYUG80VnA2RHFuTVM5?=
 =?utf-8?B?YjhrYVV1RXFnNnZaVjIxbkhqYklSV2tway9Ld2xtL0RMS0JaQ0pOcEdZa0Ur?=
 =?utf-8?B?dTlGaGRQWG5FUDZsMG5iaGdQRE5VWTVzL3F6TXVZbVhybm8rS1dEVjlGT0Zn?=
 =?utf-8?B?Yk81Sy9WeSttZE9CQm01SGtwdldLMTlNOHA1RkVqcFhxbDFYTmtJZnR0Wk9v?=
 =?utf-8?B?TW1pTlRDeUxtMzNmeTFFVy9OR01OS0lhdHJKalpESXlDdFhObmcyYjJ3N2tI?=
 =?utf-8?B?elk3OHZ1QW1lN3RKb0xiT2p3VUZ5NGxRWFpSMGNBNlFqdTRaZFVhTTlkaXYz?=
 =?utf-8?B?djhkUVN2WURsTFlIMitCZ2Qyb3doakNHSXhDSGdHWVhsNHc0TnBEbEt4cWVw?=
 =?utf-8?B?cGgyWXg5aVRCbnhRcnF4Q3BQMHczenBhZ0hOUExTRzErcHRaUWk4amVxYTdw?=
 =?utf-8?B?VkNnalp3cFZoN1J1VWRSMUpjOU9MYjBzTjAvb0ZyMEpuWE0rSVNNd0JiU1Zv?=
 =?utf-8?B?c2RJcUhReHB2cUZEOG9OOUVZcUprNzJLd1o2MXFzNmpENmNEQ0FuK2swYzZY?=
 =?utf-8?B?K3Jhb1VOY25IWWM5QmtkeXJjWHlIUm5UZTQ4R1B0eVBvWkVVNTYwRERraXJH?=
 =?utf-8?B?bzdwQ3NQZFBoeHo1bnc1V0ZqdW5GLy9XMFlXMUc0bE91VENMejJOR2JuUVAz?=
 =?utf-8?B?MVVPYmdNZ0dTZDBMZms2Mnhmek10eDQvOTlVSU9SQlBmQ2xUNEVwQk9CYURT?=
 =?utf-8?B?dUtEeEdoaG53Q1lkSXJCTmxueU9YTFJhOUVWYkdEM0NoT0xRc0F5a2RsU0xy?=
 =?utf-8?B?L0IrQ29sTWFNekk2N3dPYk1kVytCcjQ5TU5ySXhCVHBmSW1NQmFGV0VZVTR0?=
 =?utf-8?B?ZFVndGNSM3BROHl3N0pwK0lyVzVlRjdIVXJRMDFWNVZiZ3lGS1Vua1B6Z0oz?=
 =?utf-8?B?MmtTUG1MMEQvUVdLV2ZpWDNhWHVWNVcxUW1EeWJsd3hPSWVQelVKS1RNS0xy?=
 =?utf-8?Q?dw+viqG060de4nouq0ge+ny/YYL7DrPylsNs4g9?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR12MB5469.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VEZXQkdTT3lJdFk1YVNhRFNaYW1COHZadXVkc01UN2RMaktjQTVrK1RPQ1Zl?=
 =?utf-8?B?d2RXUS9SYzZXL28va2EwZE9IektybUY3UDVoUFp6aWw2MkNGZCtLYVB2Q1Ny?=
 =?utf-8?B?S3NySUZEZ0NvY21ncDZwMVJqRUNGc0szdnB6aFJoOHVKMllWamJIbjdUSE1U?=
 =?utf-8?B?V0RNNndPMmVoeks3cVBZR3NMd01HWTNjZDVmMkJpbkFkUUNCOFY0ZWRId3VE?=
 =?utf-8?B?azNUU3hZdEZnL3c2TU4zRVljaXlITll0Wmh6cFNWN2NDdTg3UjFDODZxSWRS?=
 =?utf-8?B?MWVaV3lmNVE1TDdvK085SFZyWWdZeHdXSzBNNVZSNm9qSG9jd1lZRkMxOHE2?=
 =?utf-8?B?SnhVaW9QeTlaVVpUOGZ6RGRnNjltNWJBdG00V0lvTEExN0p3c3F1ZGRwcUJp?=
 =?utf-8?B?WHJHdDE4UVZkbTBwOU14VWdMbktFNWs5YktIWWNpUDkrVUZUczNnTzJtY29L?=
 =?utf-8?B?ZjhMVE9SY1lnT3JXazR5b3I0TzlpNDJxTG1YNlBjNkQzZjcvbkJ4YnQ2NE9i?=
 =?utf-8?B?Ri81OWh3Z1lzQThtdG1CZ2xMNFovdXJzYlNRMUNtc2lHTHhHN3ZSMk5ROTZV?=
 =?utf-8?B?elpRTzE4bVI3emZFeXRmMkk4Y0dyVEp2Q1BwZVI0ajdueFpQc3NaY1BPVGRV?=
 =?utf-8?B?SkZHOVBISVNyQlQrZlN1UStPZW9HSkFjdlJVVEFkeTMyaG90bHl4dlVpaFZS?=
 =?utf-8?B?SisyWDFCN2JZRm4rWlpzbE55OG1MSmhIMnd5d1UrTVZ3cW1Bay8rUi9nQzJ3?=
 =?utf-8?B?eXBZZUNVbDg4RU1YankxWWM2b0FRNG9PMWFmVjg4Si9rTVJNWUxrZlFEL2FQ?=
 =?utf-8?B?amNmUkJNWVBxZDJEZGtrbzMxTWE5Y2hHUGowaS9tNWd0L2tWbE1HemhrTU4w?=
 =?utf-8?B?bG9aS0ZUVVkrSDFQTmtNWEhiRTdlVUJPdGFaL1RmTVliOGZGdFRRRE9QZ3NK?=
 =?utf-8?B?THpFb1FxQng3TEk0NTFWY0w1elkzS0tCTmFoYlJkbjR5aGhhMXl3bWhkNHhY?=
 =?utf-8?B?MU5mZ29PQkhqRE5ET2JPcUFqZDJqN3hjTURxZXVreVRxK3FPN2dKUllBNjk0?=
 =?utf-8?B?Q1B4Z3RqY0I0VmVmWjY3VlRFcFpNQU5RSWJRcytFSUk0a1NqMXNZcEdaZWdq?=
 =?utf-8?B?dGZLTWRpdTNnSUpLTC9PWVhFM3pVWGNvSlNhaVVhYU43Sk54QlhybGl3b3FW?=
 =?utf-8?B?NStxbCtlMHhNVlFEUFR6M0lkR09JcXVGNEs1Z0M5bEdEK3B4QWRQa0RUTUd0?=
 =?utf-8?B?M1NUVUEvNjY3ZVJYWGZ3SjBXdzNCQzBOMHRqa1lzZy80a2NBUW9BTjR2dnR4?=
 =?utf-8?B?RSttYkswZmdzR0JUQSsxS090eGt1Skt3K29aZ1VqU0ZoRHcyU1ZyZkRjdDZm?=
 =?utf-8?B?a0tKRldMaW1IYnFyN1hwdExhdHBHclFMaGZ0aUNRblZ5ZUk5dEl5bjNHM0p3?=
 =?utf-8?B?Z3FwQkl2azFGdDN2S3BjMEYzK291OWVOSWlOcWN3VmNtNDNkTVBzaUxxTWsr?=
 =?utf-8?B?V2duWEtwLzNWOHQ5R1ZOajFQQjBvLzJ2RnIxNzRUckkva1VsL3JXM3VWcm1a?=
 =?utf-8?B?WmxXeklSd0FGWDh0ZnRaN2NQdDNrVHlVK0pHdG1DczhuVDYxU09nUGhMT0tr?=
 =?utf-8?B?bDVkWGs3TkJBdU9JY2xHS1A0NXBJT25oUk9seDdldXlHK1F5em5ObTlnNTRm?=
 =?utf-8?B?Z0VqcHlMeXJSK1pzdTVaa084SVZlSURIcTFWUUYvMUxyQkdqN2I1eHNxR3lU?=
 =?utf-8?B?NFNaVUZnb1R4dzZ4ZWJtalZRdkRmSGNuZU1ZTDc2L21UY3pxMEsxS2FJNS9O?=
 =?utf-8?B?U0kyc3FFZjRGL2k4aFFtWmRObUJCakV6WnlydGpXRWJyekgwdmtKb3hKMnpU?=
 =?utf-8?B?czdrZjRzS0RiZmtNVzZVdlpIaUF2QktaRkIyWWNBeWRrZjBMaHY2NWJPb0V1?=
 =?utf-8?B?MWtuVzFPNkMzUnAvUGhZbjFVLzVMcyt1MmZnOG1vcmpIQ3AwK1E2RmJYQk9x?=
 =?utf-8?B?dWhEdmNtQWpNZ1VTVnlUc1RNT3FORlJ0R1UwUElqTVB1bFc1T0krNTdCRHRV?=
 =?utf-8?B?dGJkcTJZNFZYWVBlR0pvMC95RG9RbmFIUDdCWk1zMDFDdTdaeGN2emVLcWFN?=
 =?utf-8?B?SlEyRXYrWUJlbGZ2U0tGYURNR05WREUxckFqdE5oUnNnc3F6NUZ6dEtrTXZi?=
 =?utf-8?B?RWc9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81ee6d87-33eb-4836-3651-08dd075035a1
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB5469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2024 21:38:43.5859
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lt5mOuASASVfBdI8TeUEpNGL2pPRHMznYC3HCbd7s6o4IH2zHnyJCzekrytcUaMFOK6n54vZ4t/+6saCs0HLdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6755

On 11/17/24 1:27 PM, John Hubbard wrote:
> On 11/17/24 1:25 PM, Greg KH wrote:
>> On Sun, Nov 17, 2024 at 01:19:09PM -0800, John Hubbard wrote:
>>> On 11/17/24 12:33 PM, gregkh@linuxfoundation.org wrote:
> ...
>> Patch is line-wrapped :(
>>
>> Can you resend it in a format I can apply it in?
>>
>> thanks,
>>
>> greg k-h
> 
> OK, I'm going to use git-send-email after all. Thunderbird is clearly
> not The Way here.  Just a sec. :)
> 

OK, I've sent the fixed up version, here:

https://lore.kernel.org/20241117213229.104346-1-jhubbard@nvidia.com


thanks,
-- 
John Hubbard


