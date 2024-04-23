Return-Path: <stable+bounces-40754-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DC8E8AF6E8
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 20:54:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B50EB284A29
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 18:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4E8413DDC4;
	Tue, 23 Apr 2024 18:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="etheaJjs"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2075.outbound.protection.outlook.com [40.107.243.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A26413D516
	for <stable@vger.kernel.org>; Tue, 23 Apr 2024 18:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713898473; cv=fail; b=MpoJkwWxzd+P5aScY/AJ2+JSbA4DBSdpYPYb8eXJhswOLrIiS+7XTtDK3PdxXjl09/NKLjk5cnSLVbsEmsXVQiRZG6B9oRc6eb5hrTLD4UCsNnFH3m5/LhvvpKFKkBfVp5w8WcyYHqEsVhkQ0Mn00oeO0qa6hAgNScn7NNIgxQQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713898473; c=relaxed/simple;
	bh=laxKJ5GIxAw3N9hgYqcrYg9QNd85XDDj5fflbJf2VQ8=;
	h=Message-ID:Date:To:From:Subject:Content-Type:MIME-Version; b=rFSjE7G49jM1th0LeHnW0RDlSC3aekMRsUfbqzncTOLqL8YYXLX66TmKNpqDXehvWSdsykxWYIOwKGzKaIkbTuOVkLh4wGTmp1IMk0btAYZ6bPClcotNM1wUqEdYo0bA9zZfhO8WnlE7zgd/w5M5dzASTpgQJtYJx3ZkTAgwvOI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=etheaJjs; arc=fail smtp.client-ip=40.107.243.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jx9az9lgQYmNWpn4rw+klFA8CgF6brNWKUs3wlqKWNA/P27KWWOGkaVFX9ERptazxrpNAYIexTnvRqECG0Sv5OXqOVtJoxRkNI1UiTaZDnSiq97Mz3qRdj8GklEPhmTkF6x0RkR7YZuMWZ6ydhv+xzjsUMvmt8aN/uyzhfU14o84Ue8I29EC8+d6DVxDNqOBhGeelTipOLF0kPR52tIpP7dvdGXRz2EpmhmIsMrj6xglphEvbULtNCCj66OKQd7ExBqMIgclxEqQvgJdAcX+HELzUOlwFiNESYFOwlBXcKohg8/VwSezqG+rnigFwahnBSCsoAssHL3bVkq5Zjbluw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wEjDzKJEsHemLKqw1ijahof4+Q1/WiCB2iatDsO1BuI=;
 b=X1nk5GC0ma+NxhJLKtLvzOOT6uf/kczEOQuuzQiGhYhTd5FJ6IoQy8uTJ+yRHJwVeRoposAyAdSFLtVRdP9jNRFp6Ji9zsTrCMU2JEg5sWg1FZNyiKR126ynyx7gtsawm9KC1ZW5clyk0Xf5K61wbRvsWgVBd8PxIM+GBaUMN2Omr+2JMrI/NuVIFD+56S64jD4n7fVSTDDhAU2psfKLKGlLjcK4Djqr6Imcs/IOSHmXuSlOeQBK6iMLiOs8L81YpTepRGpxBAOV7t26uqkZbqLcnA3LaujCHQApT7P+H8MXzJpFeFmIucRDLjFllKWdHWmnd6Anvtn6IHquF7sltQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wEjDzKJEsHemLKqw1ijahof4+Q1/WiCB2iatDsO1BuI=;
 b=etheaJjsRaKJnnIyplb8nnCWEZdtHYXbfPeJiyCAXinPbC9Fr4mwNa6k5tZQJzE7A+ecmWxiG6MU2CO7zvSIl161fW1e5gdJbuXZHZB7BpqqdtLNKrIpUPudOa0QZElsK3cDyKsbAMquwJnWDyfwhuOrFceaMBPVfD561XOfEhk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DS0PR12MB9273.namprd12.prod.outlook.com (2603:10b6:8:193::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Tue, 23 Apr
 2024 18:54:29 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::d9b0:364f:335d:bb5b]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::d9b0:364f:335d:bb5b%4]) with mapi id 15.20.7472.044; Tue, 23 Apr 2024
 18:54:29 +0000
Message-ID: <a06d9047-114f-4e63-b3b4-efcd83ca6d1e@amd.com>
Date: Tue, 23 Apr 2024 13:54:27 -0500
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "stable@vger.kernel.org" <stable@vger.kernel.org>
From: Mario Limonciello <mario.limonciello@amd.com>
Subject: Reset thunderbolt topologies at bootup
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0088.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:35e::15) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DS0PR12MB9273:EE_
X-MS-Office365-Filtering-Correlation-Id: f10f3079-d835-46c7-0771-08dc63c6cdf1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?emYxbFRrTDZ3SldhVDMwZ3JyOUpEKzBqRlRlR2k1bXlEcEpiKytCOG80VWEv?=
 =?utf-8?B?cGNQTE9PblF1S2FCWDZXVUlMaE5VcEJsNWM3VTZVQXFrblA4T3FiYmN1UzA5?=
 =?utf-8?B?eEtIR0lQR3htQjA1ZDl0bkt0MGRoRkRkcVg2WWIrdGdZaTJkR3c5OExxN01w?=
 =?utf-8?B?dkdKWlRRaWFxWWdLOEw0RVJuaW0rZGZjR1l1SSt3dnpJMC9WZW1TL3NSeFFk?=
 =?utf-8?B?eW5IY3pyYmJUTDB3eWpuL09EQjFFTHBxdVBEdGc5ZzlOQkxZb1hra1lYMVpy?=
 =?utf-8?B?c0pzZW05elJTbEVqVFg3T2IxRlY3eEhiQ2lzbGtJLzhFalJrZmFUaktTeHda?=
 =?utf-8?B?OWZCZzRMcjhoSml6NWtDaFUya0pFZ21Hb3NrSUdJMHVQa3dnU0FNTzlFdFlw?=
 =?utf-8?B?d3pFOVlMOUxNSTlLK0VaZUdrL1kzeWpJTDdYOXdnckltRFpDMGZYZHAvbmF4?=
 =?utf-8?B?N3ZIdFRCSWxsQlJKSTgzald0VEJLaDJJaHk1dTZ6KzJkVVF3Q2lqZ0NSNklK?=
 =?utf-8?B?dlorT2x6QnpyTmtqcHJTNW9XOSt5Mm01VDFVVS83U1ExOEZ3cHMzMGt0MUh3?=
 =?utf-8?B?K25DMVpwVGpQdlk2cW8wZFllNjZkYjdUWUtOZ0NqNkJPcXVNTWx5V05YeHFm?=
 =?utf-8?B?STRCODBqK050TC9ua2JJa01lSjhHaTMvMXdWUDRJRW05R3NaWktPYWFGaHA4?=
 =?utf-8?B?Y0FMaVZ1VGs3YUhMd0JhRFJ5U2Z0ZlU2MDJaR0VrdmdlWWpxd0laWUdQU1li?=
 =?utf-8?B?bVZkb3hvb1RYQTM5Uzh4bTNrUmFFUTB1YnZaYVM5QlRjMUczeko2bU45WkZC?=
 =?utf-8?B?Q21YR2pCTVMvcG1aWWlLRHArWHY1dVhRNkZmdU5sRmM0WVE2VEZ3bDBlZjh0?=
 =?utf-8?B?T2NTcHZyL1dyaUJxaFlwUTNkWnRKWkZKcW5NMHZOemVGNVV3UktyRmhrMUZr?=
 =?utf-8?B?REsrTGZzMkxjNkYxT2k1MVB2bFlFK1VGSnVyNXUwUk9BMHhBWTU0RHBlKzFq?=
 =?utf-8?B?THlIVkZVSjV4WFFwTzExbTFBVVJ4Y0oxdGFXckFkODdUMVN0bFlTN3RNTDJa?=
 =?utf-8?B?eXFvUTViSDB3UXl5V0dzVnVTTkNwbG9pUzA1TXgxakYrQXQwSGszcmZhbldx?=
 =?utf-8?B?RENwQnJDWTFrbzk4WVBoaFAwZ2lQL2VOLytWamNpbG5FMWZXeDBrMjFPOVJC?=
 =?utf-8?B?TFc0K3Uwa0JObXBONWN3UTZZNDVza2paNjhyb3dhMGJvYlg1bDZRU0MwK1ZS?=
 =?utf-8?B?VG9BTU1uc0VZdlZneGlWUHRYU1l1MHNrODV4VDArNEcxTkhocGl5bnJTQWRh?=
 =?utf-8?B?NElvWXBBdmNkK0RQM01qWDd5Q0tzdFp3TzN2QlJpQzBTbFZxY1kxb0xITlg1?=
 =?utf-8?B?cXlHWEhlQ0VHWi80ZmpQeEJCOGFhOXVuenVEOVZoN1ByTUhsUDlFTmVreHhL?=
 =?utf-8?B?UHgrdjZDejc1K1plQTYyZm1qMExVbjhSR2UrSytSRTFpWnQwOURqSnc5T2RP?=
 =?utf-8?B?YS9xMTBwRUN0TjFRKy9VeDRHUXlSNVJaMUlvT3gxeFQ2eEdSTE9yMmxkcVlr?=
 =?utf-8?B?WjdzRWlyeDhNRWFDd21NMzNEdUU5NUtXWVFPMEFmbHhBTGd1OXI3azBSR3FC?=
 =?utf-8?B?RGVrSHIwSGpMdUdpSW1LL3ZMVEc0cXgrbUpsYnNtcWdORzBvcUIrK1BtUFpI?=
 =?utf-8?B?K21HV2JNTjQ3U2JwbDNoazljVnVpNkVkVHBvWGxlZlU1ZTNXczFGOElnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SFBlS0Q4dkwvT2ZxaFJxNjFFc08zWUtwOWo4SmZhb0c2UmhITUNWam9CME81?=
 =?utf-8?B?Ri8yNWpjN0YzbEVNU004aWJRMkc4djVUVkd1WmUxOWttYzhSK0hhT2hoTHdC?=
 =?utf-8?B?S2NxcExOcEN5NVpIeVd5QjI2bjJ1bHBORGROTzF4VnIzZmV5ODZIMzFPZFZE?=
 =?utf-8?B?N3VyZGRCVXFkazZ1aENaMGtpR3YzUzVWdm9OdmhQMVQvWXR0N3lvSFpWbm5T?=
 =?utf-8?B?YXpTdDdRN0VGS0VodU9ZUExheTZzclN6Y2pXK3NybkVqenJUU3UzSTZnU0RD?=
 =?utf-8?B?UUorUGhpaExUdmhxUzNqMkpSYWErUXZNd0dHUWlGMldURnBQQnZRQS9wMlYx?=
 =?utf-8?B?cDRIT2M1WDBMNSt3eUJOSk8wTHd2TVZhUUxzbFRCSkJyY0hmeUliTmFwSFQv?=
 =?utf-8?B?VHE4dklZeTlWNm9JMVRZN2k3OFZGS0s0QnpqZitLMWk0cS8rSjBPbU9aNGxO?=
 =?utf-8?B?WkYwMmp0ejJzZGdjVGg1V3dXVWg3dk91cXl5aGJFZHRYYmtXR0dmdm8zUS96?=
 =?utf-8?B?K3RvdDJ0dUJFTmJyRFlsT2x1SGd2bHhXWFBRYitvL2laUkxySi9DK2FyZWRo?=
 =?utf-8?B?YVQ2MzlENmFMdmhTeWY3L2dxcFUycncyeThEajZaQ2F6MEZMc3NNamp4MmZW?=
 =?utf-8?B?Tm5TNGtoci9FbWtZa0JEUlFYV3VKWXdhU0FJMnNmdlBxRHRUT2xMUDhZZU1B?=
 =?utf-8?B?RzFjSndDUzJIeStUVHdaamxmZnlMKzRUVFFJN3dteVQxR3ZGaXlrdHlTWnpl?=
 =?utf-8?B?QnJiTERXTkV2ZDdETVFqL2U5MXBXLzNSekgvSFhEUDl3YVBSVzJDZWRZSkkr?=
 =?utf-8?B?cjZ4aXZ2S1NOMzdmd3VOSURNaEwxeFVhV1NKQzByREg4aDBCRFBQY3c2NHly?=
 =?utf-8?B?R3ZDbllZeHJZRUswYjBXeXM1MWxhbGI0VXpGY0ZrTWd2UGZTWDZVNnlISlR3?=
 =?utf-8?B?cHhra25IdFFuQk1LVUZqRTdrbGZBYzVrcU1qK3kzUnVrQ2tDSnJrUm1IN3lj?=
 =?utf-8?B?YzhxZlNEL2EraituUnQwYjVBdlF0SFVYc1ppSUp2bDU2bGNESXE4NnNVYzBN?=
 =?utf-8?B?d3IveVF1Y0tQRkh6NDRyWjVlVUNCZEwwRU9lSVpQOEpMdEp3cWhSNUIyRytW?=
 =?utf-8?B?eU1qODJIRkpWcHNKUE42MWFENkVrOVIxUm8vVGVDNmFUZ2VLa3psbGRnNG9C?=
 =?utf-8?B?ME16akIyd3BrbXFyWmpDTDd4Rm0yOHlyN21hMllBWkVpeWJHUGpUTXVFdkFC?=
 =?utf-8?B?T21oUSt2dHZrcjd3b1VIYktXWmo5czhDQ2pUYW1kU1FLRnRjZ28rZXJvcnBx?=
 =?utf-8?B?UnBDQ2RTNk4vK213cFdoMFN6eVZOeHA5RTZLSnJyT00wZG12US80cnJOT0Rj?=
 =?utf-8?B?VXBhTXRZUENtMHo5RWg3TzN2djFFc0g5WVQ1WVo1b050dGtZYnVTM1J1eVFi?=
 =?utf-8?B?QU1qU0R6cFdPMHN4Mk51UGZOOGlERjdXZEFRMHNXckVFNG9EM0tHYzFBYUJE?=
 =?utf-8?B?YzFZUm00RFExSitNSDNOTm1qWGREdzYxbHV6cmJ3SU12dWRxL3ZHMU1Vem5L?=
 =?utf-8?B?N2t0QUw4THExQ1czMWY1ellxV3phNTZWbzZjYlFwalpwcHN5K0hiUGdjNEtL?=
 =?utf-8?B?MjdqMi9HTDJXVzFYenltQjZLMVBYbTdVMTJYaWZVN2wwRlJnNUxmNWt4TTRI?=
 =?utf-8?B?VmhPMmJyRGZVaWhvdVc3R0dNdmxqUjBuL1ZPaVV0ckRVUmM0VHVLRDhJYnhR?=
 =?utf-8?B?eHlvZEJJY3owaDJBam9jaXFsUVBvNmYxL3hpQ2RQcXRCRzcvdmVtZXBEZjNV?=
 =?utf-8?B?ZmtET0Yrb1k2Zm9BdjBNSXd4Zkgza2MrWUk2S0ZFREtSTkhRL1dmTUdZdnlu?=
 =?utf-8?B?cVFmMzVzYVlVTS9iZFpGRWp2SFFGVFY4M2pBUHFNRXExV082S2JhbnBiZEdm?=
 =?utf-8?B?QkhOL3dGN2p5RlI4VDF2amhBeitMcEQ0WkZZaUNwTUl0L3pEQ2pkYk41T3ZV?=
 =?utf-8?B?WTNBaSt4T0lIYndrbHNLM1F2Q1Qza1RDQWJzYXRiNHprMHpVZXo2ZU5JRDQx?=
 =?utf-8?B?WkwyVjExN2NUQ0FPcllML2FmZWVIWXN0VVFTRTkxMkxMTUxlZ21PRGMxQXNH?=
 =?utf-8?Q?xjT0oAHJPNJjuTWxotaO92DPY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f10f3079-d835-46c7-0771-08dc63c6cdf1
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 18:54:29.1738
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cdYJjiEK/FF+8rX5lT7Ms6Q1OMTNdtLo5VPFoi/b+1IEh9FnkvlgCPFG9fwFRowRLBkQwUB0JeB3155ZW58t4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9273

Hi,

We've got a collection of bug reports about how if a Thunderbolt device 
is connected at bootup it doesn't behave the same as if it were 
hotplugged by the user after bootup.  Issues range from non-functional 
devices or display devices working at lower performance.

All of the issues stem from a pre-OS firmware initializing the USB4 
controller and the OS re-using those tunnels.  This has been fixed in 
6.9-rc1 by resetting the controller to a fresh state and discarding 
whatever firmware has done.  I'd like to bring it back to 6.6.y LTS and 
6.8.y stable.

01da6b99d49f6 thunderbolt: Introduce tb_port_reset()
b35c1d7b11da8 thunderbolt: Introduce tb_path_deactivate_hop()
ec8162b3f0683 thunderbolt: Make tb_switch_reset() support Thunderbolt 2, 
3 and USB4 routers
9a54c5f3dbde thunderbolt: Reset topology created by the boot firmware

Thanks!

