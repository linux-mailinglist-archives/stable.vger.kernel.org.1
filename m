Return-Path: <stable+bounces-43536-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C417E8C273C
	for <lists+stable@lfdr.de>; Fri, 10 May 2024 16:57:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E81101C225D2
	for <lists+stable@lfdr.de>; Fri, 10 May 2024 14:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4040171086;
	Fri, 10 May 2024 14:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xvaXM7QU"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2060.outbound.protection.outlook.com [40.107.236.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0338B12C539
	for <stable@vger.kernel.org>; Fri, 10 May 2024 14:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715353027; cv=fail; b=tsKRsv72eIwqNyk78rEIPP6geO05po3hrI4oyHwNo4tC2IjlO3FeysmI87E4WCDqSOb6iwZlQf1TXssL+wXks2Qge+znJ9/5A840+5MPFwSxLNyFZ2xVhv1HRHqVV+A/nH1fFB+r/rI+HxRqpbq218/ugaoKSLFdfjGLAohlpj8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715353027; c=relaxed/simple;
	bh=iGnS1G4dRv15VmJ0a+kMFJPicUEDxAVtDqxi8oaBUcY=;
	h=Message-ID:Date:To:From:Subject:Content-Type:MIME-Version; b=rUfAoKHplLNZEcan1OfoDNmluC1TUzucMmslu+I99dHeMQTzKVuZi+zdOkqdJ8Ib+loM6aqFqG3jPJC6tsKLiov5elhrdF+s0w3sR7ZZ4lW0+clyCmR3cabvV2fGQDyB09PaWBdSPQdeecWPUVHW4tJrOZQeHXlZq/SXJIPnvbo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xvaXM7QU; arc=fail smtp.client-ip=40.107.236.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eye+cYoKIRd/GVVvkfi+BjPskvnJJ7KbukRJtLWzvG8yqjuByxvz35z38W4Bn45kVYxS/P3ng9V7gVegTyid/8n4nOCNZ/f0NXm3x66V7HYanbCHEY2mLctzvyUkhDXaUyJknVE/o45GyEQPLgWabXsBZs5e3m61A6Y86+08EfV9ykDGHn9TeFAzPJfcUE1+PD4117wmbd5jHnC1D2H5DHwsWycVRNbyTTmUxrrrcQLhhknNVLwxbI6Pwhz35a7e43k+LDyWTakuOTTJoPhQZQcyLRE39LdPXPno7i0rrztQobanv3nv2eeci83saoxNJNCro4VoYlj+298bhb6ryg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ITJj3wb7ifK51ueljFnNKe5Ob7a8APX61JyFmzzglcs=;
 b=ITIVvxDkl42V/HGqHiS4bTk7ERrKUYJybzpO6LCc2bC0e4/JA/x1gkAF9k3fR77RVheGib9CcH123JgQVPyPCVu1O5Aepy7NcP7amqH9qxRtOaivikz8UUP2BDQJLgZWR4t3a9ndtgbGUBsZWk7bZtWjq7tpAqAm0POGCK+L/YR/TTMAyvMH9XlLU2P+ZIY5Rdh84dC9ubF5MOXX2m07C0tWkL4T9yUnYID9ZRCNEpVCsWWE+OMErb/m+BU4opEOhuAr1s9VG4g/Zd2nTDviJ02WHkR2rIJDge4FNAx20Ss6+/imfvQrHUY9gXv772lLmQJk5QB75XcrSQMoqc0KCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ITJj3wb7ifK51ueljFnNKe5Ob7a8APX61JyFmzzglcs=;
 b=xvaXM7QUHFLJhF4UgPhoWJoSAFBX+wD5JhLjG0gg7EUJwZP4rClutq+B1rBnALeK2OMgnYIM/5g0he8yjmZwFkYN1wLv5ttzuupwuGrB1yKnXurLVeM5ieO0Ad1xaSaLCjn+5CpcKSUva+2FhlMoB3uznksk8ZSh2yLI0DKD/SY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DS0PR12MB9059.namprd12.prod.outlook.com (2603:10b6:8:c5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.45; Fri, 10 May
 2024 14:57:03 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.7544.046; Fri, 10 May 2024
 14:57:02 +0000
Message-ID: <ca88501c-11ad-4803-8e0b-18fd10950733@amd.com>
Date: Fri, 10 May 2024 09:57:00 -0500
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "stable@vger.kernel.org" <stable@vger.kernel.org>
From: Mario Limonciello <mario.limonciello@amd.com>
Subject: DCN 3.5 hang on boot
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DS7PR03CA0328.namprd03.prod.outlook.com
 (2603:10b6:8:2b::30) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DS0PR12MB9059:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c893d93-a7d8-4f9f-a8ca-08dc71017358
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V1FVNmo4d0s3K0lGM1ZHbmRIVStrMnhrcFRTNzhNaitqWG5id0NJRU9nTHFl?=
 =?utf-8?B?cUIrNHBzOHBhNUlucFQ2NWJ3Y01uVHRuUWJmRk9SbXNyd3hobC9IZ0tWWGkr?=
 =?utf-8?B?YWREMlRabndsWEVSSXBnZkhoZFFPd2VrYzRNcis4dEVVbVQva3YrZ3RTK2cv?=
 =?utf-8?B?blI3cHRVeXFKczh1bW02VnNlNlQ3enlkM3RsWklibjh1V2pWSWZESnZSTEQz?=
 =?utf-8?B?ZTB4aDkyUGZTV2wxWjdNWlhaNWdlRFh4UGFwSjZPYUJsQTdFSy9jOWFHM2o4?=
 =?utf-8?B?Qi9INkIrVjJJS2IrZGZKbjJpMHlOVU9ZNTNNZUV4bFJVbC8rN0cyL1kvcDRX?=
 =?utf-8?B?cnI2YTEzdC82ZEJWOGxPQUMwdlM3V1pYc3BjN3lLSWcxb2l5aUMrdzZ0dWZQ?=
 =?utf-8?B?djRkd0hWTzBWajJUYlFicGd2cHVXTWkwN25rVFdUK2NpdUUwS2sydUNERVlC?=
 =?utf-8?B?VHVHTXVMb3ZDV1AzcFpzcWN4amVrMHRUU1YrczhPTzJsbnNwL003bUdtNUdK?=
 =?utf-8?B?Q09GRGNIbjBPUUh1SkpVdkZxRitkTEdCYUt3STlVZlFNbUh3R3JJNW1sUmZk?=
 =?utf-8?B?dTVqREdvS2trREFxNDZUaTJuaEh1Yy9HQUl6b0k0enB2aGExNkVuaDcvd3BT?=
 =?utf-8?B?VzF2dFhHMEdaSXpDMFdEZTUyUDM4TVZES3NKSU53Q08wb1FRZFZ2MzZrdmYw?=
 =?utf-8?B?anBzYmdRdmJhMldGYy9CblAxZlUvNUV4N0NveFUvREg0VDNLSnFXek9wWExw?=
 =?utf-8?B?cElxbnRncG56ek9sZitUSEhwSkxyaVFiOFhYRi9ZMHlUaC9ndUhRdkM0bE9m?=
 =?utf-8?B?V080VHI0Qll3NUcyWHVmTm1xT2FMNDQvQUl5YlRPTUdGNTFBZ01GUDQydkFQ?=
 =?utf-8?B?MzlQQTRvcHN6cWJTcG5CTEtrZUQybC9jNWkxNWxqeEFiS01lTTJEOVpweWF4?=
 =?utf-8?B?YkZibUk5UzhMYzE1VkticGRxYnpFNFg2ZzdHYUZTdU00dmRaSWVNelVpdFBn?=
 =?utf-8?B?WTZNbHc3OWtKMWQyazhQRmFEM3E1UzNUQlgyOHYyRis4THM1eEJJcW5HM0NP?=
 =?utf-8?B?K2syeTBPb3dTN0FRYmVsZGd2aGFSOHRXa3J2Mzhta0pHR29FSVk0dDhDeEI5?=
 =?utf-8?B?aXhyNTd6cG01Mnp2OVVMdVhVMXh6N1hyVnhzaEEvNFJUNzJnTXNWMy9nNEFM?=
 =?utf-8?B?MlBHcmlJV2FQL0pmbzFaeDZRaE5GTEdzaXhkSHh3WUxtcEYyTHdJL2ZQOWxi?=
 =?utf-8?B?dnoxL1NQZVBlbUFrRGJOOXE2L1JQeHJMRC9ISitmMEY3YnVpTElOWnFHcWpn?=
 =?utf-8?B?N05XWjBuMThyaFFoTk5qdmpINDdqcVNyblFHZURZM2NiK0RCZU1qekV1L0NG?=
 =?utf-8?B?MW43K0MwVzlYcDE4VTZZWE9CYnZnVHpQYm1JZHZHanlCNG8xREFiaUo5Ry8z?=
 =?utf-8?B?VytENWphQS9wQUpHT2IrM0w1ZzRhUDdxWndlQldONkVObjhpWVFGTzhHY1NT?=
 =?utf-8?B?YmJZdW9YQ2tHbXBpK0FGeEFmdk93aFlvMEYyTEs2SHhJYllRdytiUE96WXMz?=
 =?utf-8?B?L3g1bGE5TXh3NjhIRjlYMjlWRW9jdERWd2EyZS81bTJ4WGRKc2ovUHkvUUZa?=
 =?utf-8?B?OUthRTN4Tm1VMldmMXdFS3ZaQ2o4Vm56SnJ0QWowWGkzTzE2dGVZK2JTNll3?=
 =?utf-8?B?ZDJOWGRiKzRsOHQzMGcreG9xTzdEWkkyY2d5bWExRURiL0RQR0w5ckxRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VkV5QjJ1VThZMlluN2UwYXI1NFRud2RVd1RnWlJuMHVObnRURkpYLzR1M0t3?=
 =?utf-8?B?bjc2eFZoeExVbWI4TGtsZmRVdzRmbFJSdDNtaERRNXBLVmorclJXV1RhTFls?=
 =?utf-8?B?WFRhU3FRNEVUd0tSVmgxMkNNS3Y1Zk5rdWVXSjlTVktVSTNVSmxPVno3NWtU?=
 =?utf-8?B?ODVncFByam9IaE5XM3g4T1VmbU5uaFI1T0ZhNHM2a0VwV2VXYlFVT1NWbG9S?=
 =?utf-8?B?U2dyRkk5U2RCYjlTOHVUejNFeWVoWHMrYy9Mb2F0OWFyQXlrME1CYTkyb3Vu?=
 =?utf-8?B?RU9pNXJlSFo3Ry9OK04vbW9DaUp1N0xwVkttNXp1amM4Y3BzcDBQdWY0djVh?=
 =?utf-8?B?czlLajhNcTFFN0Q1R3ZnZjdlSzNMYTNSYkhRdnRQZHpaY2RLNk5SOUJMa1lG?=
 =?utf-8?B?TzFMK1JaVWtGQVE0aWR3MXhsdUdhWXFiVU4zSUlmY0FaLzBZWFVTTFU2VGNv?=
 =?utf-8?B?SGtsU3VNeGFQNTBZeE1qODBwRFRnRUtDZGxqdEhMaW1weVJhc3kxR1EzbWwr?=
 =?utf-8?B?ZXZrMUhwWktiK0ZCaVNnUTZiaVRsUktqSjZqRWdpbEtDOE5CNHord040QWtD?=
 =?utf-8?B?MXRaKzJkM05WSTVMbHFOTG9DMGNPeUd4UFgrTFlrZ0t4b1BVN0haN01nbVVF?=
 =?utf-8?B?cklhQWZJMWNrLzZBQlU3emVSQVJqWjJ6VmduaUUvb2hEQzNOamVpeHlQN2pZ?=
 =?utf-8?B?d1JTMS9pdUUvY1J1U2t6TUh4NEw0bmF3RENTZzRERFlMQ2VqQlBPQmYrRW5Z?=
 =?utf-8?B?dzY3TmI0Yk9JK1Q0T0NHaXBKSjJ2VHhmZjJlWURtcmRUcWQwTVN4cDVzcGJY?=
 =?utf-8?B?RkRWdmxBOGdJZjhUSnhqNXRRVEhqRjRaRVVnVEs4R3pqa3JhWVpHU2NHa3Zi?=
 =?utf-8?B?ajY2MUxkRHM2SlRBT29KKzV0UlVqcjhzWUVLYkh5ZHgyOTNJTStIWGxrR1FD?=
 =?utf-8?B?eEwzRnJGN3JUSEtGVk9lWVUwNnFpd3FKbVFiNncvYzNtTnQ2QU9FWjFoWHRT?=
 =?utf-8?B?K2ViNTd1aTljbldESzNxcjBwR1NCS1ZtQ2djeDdWbWVnTHlDUHA2TWhiY1di?=
 =?utf-8?B?dEI4VUVFUlN2bngrejBTNnFPNU40OWRCOWx2cXI4UVdZc043d0NhK2xDcm1R?=
 =?utf-8?B?MG9BdStuWnMrSFVmb01ocys2UVh1d2lBTDFIZEZ5MW1EbHRDS0VERVhxLzFU?=
 =?utf-8?B?Z2hjSzhZYURRTXhRdXdmVTJLSGdmL0tpZUxTNU42OXFTRlA2akN0cjhMYlQ4?=
 =?utf-8?B?WWR1elpYNFI3TVd3RVFUMGR1MU9BRjZRcGFrbEtPOGVLLzZKOUZnVE1Fc3o3?=
 =?utf-8?B?WU1mdGdvejlHOXl1aTZXUVpVbDdpZEViQ2FkaDU0d0FhYk9peGRTK0NRR21r?=
 =?utf-8?B?Ym9ZdVdmdzBIQUxpeXp4Q2JjK2hzSDg3OXNtczZwekJzTjJZR1dnNHRrY0xk?=
 =?utf-8?B?Q09aTWEvMDhQR0hPQjczRjh6VG5mbUgxSXJGZW9DM1pLWU42Zm1RT0Faektk?=
 =?utf-8?B?WVVVZXpLZWZ5bXZNUlV4c3lrOEwwN2IxbEEyUjdLN21lakxISENaY3prYzFp?=
 =?utf-8?B?YUJ4bk91bDRDSndmUldFcSszMDE1QmdZb0Nnc0ZDc09FMjdZeGRyUGpweW96?=
 =?utf-8?B?S0VSb1hNajR6dkhDZGM5cFUzTlFtWmVTd3FnQyt6aXVZWWZDdjl0aTFVN0Vt?=
 =?utf-8?B?QUpwVDNnOVc1UERCQVphbTA5Q0duQVQreVYrVTROczBQVFlOUVdIUCtyUVYy?=
 =?utf-8?B?NlViSlFqSVNtQXkwOFZxVE1hTFpKSjF0ekR0a24rc21QS2NuVHNuSjVCLzlX?=
 =?utf-8?B?QlVpWFhYSzl6Y2sxeWFncThiUnFscEpBYzhseWhUSXpUY1I3NlU0M3FOZVZ0?=
 =?utf-8?B?VHFYeHhKOXpXV3FCK20zQ3VESVVXQUx4SW5WZXZIdW51ZTdsRkwwY0xOZW55?=
 =?utf-8?B?cnNNV1gyUDk4TmdxOWQ3REd3eVFlaEczTG90T2Y5NkllV3JXMjQwWjdvc0J5?=
 =?utf-8?B?TnczZXFpbDhUNm42bEYvVHE1SjJNTTZ2V21zVXE4cG5qMkh6MGpUV2VadlFG?=
 =?utf-8?B?UUdOMFFrRTRFTUZiWFU1cStBb3dzQmpETGVVRlc2dmVQZ1hRRmVCUXBNd2xt?=
 =?utf-8?Q?ph9TOc26HiWlsAt+80ZcpvyYX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c893d93-a7d8-4f9f-a8ca-08dc71017358
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2024 14:57:02.5957
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6LK3oukyAbVY0qWWIJVGNqgDP9w8TcmbsnJvQ2yZYQKlf8JkYy+WVNEqhylNnxAnHUpg90R9k0rtK9tBfrBlUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9059

Hi,

APUs with DCN 3.5 are nominally supported with kernel 6.8 but are 
hitting a NULL pointer error at bootup.  It’s because of a VBIOS change 
to bump to a newer version (but same structure definition).

Can you please bring this to linux-6.8.y?

9a35d205f466 ("drm/amd/display: Atom Integrated System Info v2_2 for DCN35")

Thanks!


