Return-Path: <stable+bounces-95870-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 627549DF11E
	for <lists+stable@lfdr.de>; Sat, 30 Nov 2024 15:18:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 231ED2811BB
	for <lists+stable@lfdr.de>; Sat, 30 Nov 2024 14:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2735415A86B;
	Sat, 30 Nov 2024 14:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="IhAHHQms"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2054.outbound.protection.outlook.com [40.107.244.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6037922066
	for <stable@vger.kernel.org>; Sat, 30 Nov 2024 14:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732976333; cv=fail; b=AN9nudIU1sEqdWnFr3yQ0KU1k6eP4vnbpm+jcgH9x7WmK9ss+DzO4zKnoFY/K6s1sDAPwJGRO7jorwxEPMhtlLhUQk7WSPWxAuHby/dT5SWbddT20B90g2Jjvzb7upqDld6OHzXOgHLVMmQJbrhubNoRPAgZnjae7v6mkWSzKHQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732976333; c=relaxed/simple;
	bh=BlV9pgs4aKlvZ1Ob++4PLTXApJeUwV3E/vUHS4kg77A=;
	h=Message-ID:Date:To:Cc:From:Subject:Content-Type:MIME-Version; b=juckCvAax+6iddWU1FmwiRxoq9KnjPk9/jbmmy2Cq9erQNJGS3mx2vNCfqq4djRB4dznvC4hpep34iLWRSUfwqg+T4S2gjsJrV6/cNI8ayqpXZNIoRNb5rtmWazTbl++YoBV4ZLHU6xn3UdSHvZBFqMCvoOm6f/zi18RMWcaWCg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=IhAHHQms; arc=fail smtp.client-ip=40.107.244.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hR/DcipXUSBdP0DUw4QTLodHLrRidkTrwAMVmQ1bejFyK23nZ4ypEiD9Dtyh6qAPA6cxUBKHw0LE15i2tmy9InZ8usHol4Ze2HOVqHyZMF4ZL9Rnn9mIFtqLqJ9pCF9ux/78YeCgHkyLc34jMFcCnM8/jdKotS0lpta5zOzR+aouBJF2PdlLKxKBOQudw/QyPvZRe6pXE8dxayjYdmXtx1ec5ulqxx9f5qEA4yRuDbvwg470dkT2cjSrGz5w1UmWbD1Fnmfx4RnW8U2mfrSJxzGijIIpB1kEGuuG9/GqizI9eV4KCNUZBt/wY8OxSK7Gm1vw8UHqbYYLVvCFMEpPEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=53hMngYq4tAx42+MISBXRguKTfoX87SNqVCSx86eltg=;
 b=HmToP2umC+Ge9j69snZZc8esyN4dXrlM11s59wyTgQ2ce6RmETxuZmgt8jeyBc5S4eBx/x5tNeS7Viwu1sF/ZM4BOB3TGpRyM+svqksGC5fXHYgjOWCnBSzmE4AFfrb5Qclmc5hsQnkAuH7aW4vO5HBqzH5qJBCX9tqwQGY6VD4MORhoateu2VkwygI9WX3t1eK3s3vEA8DW2YUlA08XNPluryKTMPmWiPrtPKqIDVkU3+KnYDmiKU1qv7iZXV3dx+I1djPS3JAZK7FIhruWeMUsSuN7QH3cVTthoZ812wcZbsgIht9NRIYWiHLYdUHmGPqrKHos+eDfH9IhqeHJ2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=53hMngYq4tAx42+MISBXRguKTfoX87SNqVCSx86eltg=;
 b=IhAHHQmspNYBEPnUI+Afqkj2JJBLuqRleEryRf4jvW6cgkLgjMx5rn2ZFUgsV5yVsXrUw5xeLcaAJtCEEMHwF+nBGCEy+wSFFi6+mSB1LxfKvnwvq2VtUwKbW/UIW4rWx64JOY+J2999Ndg8y9Sq550QJzQwGPqpldfaUH8vyg4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SA3PR12MB9198.namprd12.prod.outlook.com (2603:10b6:806:39f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.16; Sat, 30 Nov
 2024 14:18:48 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8207.014; Sat, 30 Nov 2024
 14:18:47 +0000
Message-ID: <123ec883-4bf6-4efa-b1e3-b139d19bd6fd@amd.com>
Date: Sat, 30 Nov 2024 08:18:45 -0600
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "stable@vger.kernel.org" <stable@vger.kernel.org>
Cc: "Zuo, Jerry" <Jerry.Zuo@amd.com>
From: Mario Limonciello <mario.limonciello@amd.com>
Subject: MST/DSC fixes for stable
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0501CA0014.namprd05.prod.outlook.com
 (2603:10b6:803:40::27) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SA3PR12MB9198:EE_
X-MS-Office365-Filtering-Correlation-Id: a2d69a6f-e8b8-4ade-4318-08dd1149e7aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WDJqNGpOUFNUOG53a0hhRXNkdnQ5MDdvRkpBR01SRXY4bkNzRVladnNCTnps?=
 =?utf-8?B?UVdPUVo5NEpkYkhvc1dxMDJBblJLNjZYV0x6ZXk4bUN5VmlrMTZRVTdTc0RK?=
 =?utf-8?B?WS9MRG1GK20vNEpoS0tReWoxeVIvT3JIVzdZZU9Nc0pNMWhaL3E2aXB4Qnpi?=
 =?utf-8?B?TjhvajdobWdmYks0Qnp2Z1hVQVlheW5hd3FMMWxna2dzZWcvTmk1SEs4THpm?=
 =?utf-8?B?bU50OVVCcWhuaGZxQmJtZGJhSFZzVitHcHFjYkhZeTlQV0JFc3hxdnRhcGov?=
 =?utf-8?B?SDFob0NwSVdGaHBDQmZXNEJMenEremVjK1djcTlmbFRXdXhzdUxOdkdWTzFT?=
 =?utf-8?B?OTlXdzRFL2ZNcUIyR1puVE1UZWRhbGJZWE82YTdmVENMUndISitUZXRkTmlK?=
 =?utf-8?B?NmVQMUl4VVpncTlCYWlXby9pOXlreTFPa2cvQ20zRXRTbXRydk91NnhlQ0dn?=
 =?utf-8?B?Sy9LQzZLTXlYVVJaOGdWdm1GK29VVE9BVzBGM3BBUjBtR202Vmk4TndFejNL?=
 =?utf-8?B?OHNBUXpPZlJiSXJuclVXZXNVaCtOS2FhQmxvb3g4eExHUFVVaHczaGpFTlk4?=
 =?utf-8?B?Zmt6RTYydGhNSjRqc2pnamtrS1crQkJPQ2RxOWFXUHo0d3hQbVN5d2R2REhl?=
 =?utf-8?B?bzNVZDg5VGExTThueWNIN05wZDc4WlMveWtudXRicDVjM2YyZnQxenJ6czQ1?=
 =?utf-8?B?a0dNRy9xTjV6TVNCRW8zT3JTNUhncHpwR0ppV2xZUnVJNUpMaVNUQkFkc1lz?=
 =?utf-8?B?VkhUbU56SlpKcm5zTE9SQXdxQzFsUmZ3Zkt6L2dKbWVDdStvR1JHcGtaS3hz?=
 =?utf-8?B?RTFrd3hUemVad2VucVExdDBReUhlSElVTjc2TGFoS1J1T0gyQU42akdHYUY0?=
 =?utf-8?B?aGpNTEgrRmdiK1RJZHppRUZ5cTZ5ZCswT1RHK0NTUFVaTkphWGxGaFZ0RjFm?=
 =?utf-8?B?RHhWU25uZk1jR0lZMkY0M3VIODVzb25NWUVyMSsyRzZNRDMybFYzWU9Wek0z?=
 =?utf-8?B?NmJxZ2Fha1VuckFJSWt2ZHZhRC8xVUVGRmJiaHVMVCtDVjc4bXBWQ3VmZnlp?=
 =?utf-8?B?ZjdYbmVxdk9qREFFdFdmMGdWL1BrVC9HZ0JTa216OEFDbk12QlRVTk1YaEhT?=
 =?utf-8?B?Wm5tMGtLZi83YXExY3VudDhYVFI3bHIzZnhHakQ1SStuV2U2ekFwSWNXOGo0?=
 =?utf-8?B?Z1Z4eVdkckpPTE80cVZXclRtTzZVb3hlcDVJTUlYNStXUkVzVGFrTHRDcmVG?=
 =?utf-8?B?Y0lyd2NFTURLY3lmZk1EOGhRdnRjTW10a0ZJMzk0NDhjbStwRno4cmRuOU45?=
 =?utf-8?B?S2hzUDBkMkVEZkFnbU5PSkkzL3pSZHQxcitkU0FtM2NrSElzN2xFMWtwdUpy?=
 =?utf-8?B?L2s2SWhvM2ZxcnUrOFFZRmhyQXpXbnNNYUFhMWU5RnZKejBteXRoSDlpRmNi?=
 =?utf-8?B?VkZxMFdvYzJ6bm1aek5EVzFvOHJROGVzVHJra3NPdENsaEVhWUozYlBWYVNM?=
 =?utf-8?B?N1J2TlhNeUNoMHVFK25kT2U5dzlhRTlTTW9OWTF5cVk5cEp3SzRFNVN1bTY0?=
 =?utf-8?B?bjZsUVpvVldSS1p2ajhSMWZ5ZHdNQTdidHF4Y1MzdWh2cUhQVDlCQzN5cnVa?=
 =?utf-8?B?b0xFcncvSVdNcjR6cWtFZWhBM3pOOXhaMzZtMkc1dSthTUkrVWJsSU5lSGRR?=
 =?utf-8?B?NDhrK0JIcXBqeDBETGIvZzlxTWJVRXFTbmM4UDJJbGJ2S0dkMUxlb1pvN3lD?=
 =?utf-8?B?cG53Mnlzcm1zYVE0azhwOGwrdU9UcUpuajFNemR1azhlbGo1dURBTld1dGZU?=
 =?utf-8?B?WUQvU0U4YnpNc3RkMC9pUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K0pERzl4V1RPNDJVUzdLcVRNMzIrV0J2YnFJbFdJWXNPTis3YXRHQm00V0NS?=
 =?utf-8?B?c0hjQlUycUt1Sy8vOHB6U2xSS2xvd0VJTTFPeWVGbjdCNHFEQ01MaFJ1Qi9C?=
 =?utf-8?B?cG42Z2VQY01XK0RyNzBRdno2alVQR2ZWb2UraVdWOTJHcXZyUktocUpMZUZh?=
 =?utf-8?B?dHRpNkc5RlRZVnpWVkEvTVErQThiMlhMRDJaMXlpTjlqamxKNVNtemZKMlRz?=
 =?utf-8?B?M2lPeFdQZy9OL3UzTmRTQU9MbEhUK2lacWdHQ3V2N1R3MWxyRGtiTkpTUWhK?=
 =?utf-8?B?UmMzdGVKdkRWL1pPajc0dVFReFFra3pnY2FVTTdkR21QSnZQSWVvMm5tak1x?=
 =?utf-8?B?eDhZVnlLcHhOaFFua2NIb0FDcmVFRDV5YzBocXJ4RnhWb3RYdGgxZDE0SXUw?=
 =?utf-8?B?RlZzVHBuNFJBZ1prRGtRVUhqcFJDb2pkeTFKbkJPU3NLbW9yNkhTVFBWVzFF?=
 =?utf-8?B?U3FwTGFvOWI4SkFoM052eXNtc3pObnhXSFBRdkJ3TEhtNTE1KzJhMDlNeXZm?=
 =?utf-8?B?QStSVno4OURiRjlGUlNrZFdYUlk0ajZLN2lRT3FWNE9IZ0dKTUZFSDVLSVFG?=
 =?utf-8?B?Ky9QeEdKZDBudGtmQVhIdHFLRGNMMytpUHozUHVNTFFpUXV2SEsyKzZmeUFr?=
 =?utf-8?B?Q0RjNnNSbUptQVFRMEFQSDhUZDVtRTUzOFdFbFBuMGF1QUNCSUx1WkM5UDcz?=
 =?utf-8?B?ZXRSbi80enk3N1dHVEs3TkpOWjVvdFRHb1RXRkJVVG56NmxPT1pUTzh6VTlr?=
 =?utf-8?B?Tm1sNnRRNUoyQnB3eW5ZWWdIYlRlbDZJbVlPNERBL3F6Nmp1aDlLU2NkZ2xH?=
 =?utf-8?B?YjVVcTBLdTA1YkFaL3ZNUzJOVnlLQVBsNzZlTjIvNyt2MGFCWE0rdEVHL2c1?=
 =?utf-8?B?L25KVXE3VjNMWmtwZFhxTGRoTS9qWFU1UzBFTEg3K1V2M3BxZHNMUDZha1hx?=
 =?utf-8?B?ajl3Qk9tUFIwMHBBbGtFaGk5RGZqNThvdEtESlhXYWFiMjVVelBucjVxeW9s?=
 =?utf-8?B?WUN6RExWbitHd2l3TWFCWXpZMUJ1MTdKQ01nTGdKOUxOMVE3WTNLZ0VjeEJI?=
 =?utf-8?B?VUtzZTZCZmExWVc3b3M5SWhld3NYdis0Z1VUN2Q2d0FhWkNCWWt2YnYwcEkz?=
 =?utf-8?B?ZEg5OEtJU0NIOWZqUVRCMk9zMjZ3c2RpK1RZQVVURmxhaWRZeHpRc1UrUW10?=
 =?utf-8?B?ak9qbzdQK3JXc05jL21Wd3h5YzVMTUtESmZWVzh3VEZGbnIzWFI3MFI0NmRk?=
 =?utf-8?B?TktPOXEvbnlRZ25kR01ZZW5aWE1PVFJ5RzNES0pGV0lHelJQVjNIamo1U2t6?=
 =?utf-8?B?cVVkSERvQkFSclA2R2ZERGZVdjYxVURXVUJJTW9IZjdPMk9STEtUcE4vOTZG?=
 =?utf-8?B?aGlLaDcxZzJpT3dreE5wQy9uRCtvRzR1ZUZMSnc5Q2dUNG10dFdsMzhlWVdQ?=
 =?utf-8?B?d2dlb1ZZb2hCdmlJR1dtdldnWFdEbEVuTUd3MmxVZzJhN1JKMVg2OWtmR1Zx?=
 =?utf-8?B?L0huRDB4RXUxT3FBV3BXNXUwdTB5Q2VJYXk4Ulc1WGU2cHpnK2dyYU93VDZr?=
 =?utf-8?B?bFVtQTBBVTM2c2s2aStuMmwySlpSR1RIWjZtQm5xbkl3SVZGOCttQ3NVaW85?=
 =?utf-8?B?Y2tRTlVNbTVzUzdsN21Db1Z0SXdjTUtyMXhYQTdaUFlQalBySWhPbU9VclNr?=
 =?utf-8?B?czUrT1ZTS3FSYnJsbU1GT2R1MHIwRkpFSHdMQU41djRHWWJES2RhZWE3MVZD?=
 =?utf-8?B?Q3JLN1ZLdHlXY3JFZzE3QlUzUjM3UVlLWXk0cTIrNEZ5N2RadHhwN0xMb3Ur?=
 =?utf-8?B?a3hQaGdqbzl5TUY2TWVON3E0YkxObGQ4Q2t3TGRNQW43OXRzMnB1K1RVTDRT?=
 =?utf-8?B?U2dSSm93Q081WUZYQ2toblpPZlJkenRkVVRXa3MxTEdDSFZzN1BWSktvZmlG?=
 =?utf-8?B?SDRlVHhqaURJYitlSXpWQ2c0SWM4S2picXNEOUFkZ0xFcHFFV29ERjFsaUhU?=
 =?utf-8?B?eG5Xdy9kSGZRNGVQUExrQ1k5emFPQ2RxMlVBTjZEd1ZrdjZZK0xHbXQ1SWJ3?=
 =?utf-8?B?bmsvSHg4ZTBQY3p6NnJyS2JVV3VXRE5qN28xbGFrWXM2MkRVRURSOG0zb2Fs?=
 =?utf-8?Q?2iW0HzjTT1zwskICs+f+4nxuw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2d69a6f-e8b8-4ade-4318-08dd1149e7aa
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2024 14:18:47.4957
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lR9yFUd4z4MNRe4LfdQQxwWyUCDdFlVU/lqVy/IIYuJ69h5kpIVZdE1S9TtEM9f2UdjwLb1NOuosztRiPsybrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9198

Hi,

Jerry has been working on getting a lot of testing for these two commits:

commit 9afeda049642 ("drm/amd/display: Skip Invalid Streams from DSC 
Policy")
commit 4641169a8c95 ("drm/amd/display: Fix incorrect DSC recompute trigger")

They fix a ton of MST issues reported in the drm/amd tracker over the 
last few kernel releases.

Can you please apply to 6.11.y and 6.12.y?

Thanks,

