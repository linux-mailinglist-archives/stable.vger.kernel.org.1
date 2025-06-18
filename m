Return-Path: <stable+bounces-154621-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E050ADE107
	for <lists+stable@lfdr.de>; Wed, 18 Jun 2025 04:16:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 656D13AF906
	for <lists+stable@lfdr.de>; Wed, 18 Jun 2025 02:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF81372606;
	Wed, 18 Jun 2025 02:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="FONAj70v"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2059.outbound.protection.outlook.com [40.107.223.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F322940D;
	Wed, 18 Jun 2025 02:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750212979; cv=fail; b=ap0yZYezP6mXh5niSoG7fXS4VEO+puTnjSh0ufwkpdl8sAR7RS6d6zyOMyVfSTj2Z26r7GP2OIk8BRWC0z/OKCBLs6eOdlO7NYD5tqRchmTzZUiU7xPwLEIyXZBwewyzhSjsg2kMaT/Zu3CL4MbML6j4L2XHRKxVc2xjqDVPxCk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750212979; c=relaxed/simple;
	bh=3/l8BEjgImSPWRbHINx0x1hzgN7j5F50qwhdXFaFJyw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=igLoodbe9HacTpyO7wdmV9mZmMsrVvlsyBRNFs+yuMAjas8yJooGRWt+4A6vinC/h+MS9TV61xVzX+9FxPnuJz5mUtyN1tnG+Twm1q69WDLf5mL/FnM9LW9s7pCIUEQLKE4Rv4pbVgGsc5uvyu9We94e8uXDJB/+80vAUfJRe9U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=FONAj70v; arc=fail smtp.client-ip=40.107.223.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vsJEo1m7cUG8sMY1jwygLKbqyLloarE61s7cdwUeLFayF5Pcqh/zcEvc/kTpO7jYGj8o/1vhMyeWFiDRv/eg5rSYQedhCV6+jXTSTCe/sZV4hwy1fOHVq2DCghGFbC9BjPIh5tx4DKcSsWPTjVPOofhKScFwV/EjYfdbyoc7neUUxaD1twLIPgQglb7ejizwylBmhcEICecp8ZA8lww7EEQnfaP1qz1KuiVM74kuXz+Y9dGoNSSLHlnNpdVRluWCFjOJLm23m6c6tgse1b7SyGa00CxSYPUVZjwQtOdiF8Vb+BhpKqSGurFFauHxGset1708OIEmUJkIuTVU7p0E+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bTpgnVzEdivgeqnxqiQHzgiLM5bPJQ57M9TbUBKQECo=;
 b=IsCG4zbnl0FuctxpLPA2V2RxTr500KlSUtLnnotqGzvmAMAibZOhuGBx3Z8j4XNjj2V+phLqYvV26H3VoIYU7nhlJ2P5AuEPsXA22SmguFrpnhQWUMQ0RIp6pCb17eoAKl1Xh67MvboJIJTTrOyG+w5+RmT05ooC62jSeCPNaFkgZC6VCLjwLM8KlJG1dECSe6xbQq6ggvjqX1//KVgsime+cHJpDtIHqpI3eLxO0f4iuX54VBDs2S8JYZAr+wVLtymlT3zeXMiDuSTDtsC0UAR2JDni7Nqq1wssSZDhjGy0DcVFBHy1eXultG9pM6RzjfxJGGuxWk0GjRd79J7HQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bTpgnVzEdivgeqnxqiQHzgiLM5bPJQ57M9TbUBKQECo=;
 b=FONAj70v0dT9uswXAcZD6XYK5SU5IbywDoDGrqdcShL65/ob0TOl7Ms2TThxrJgEmhfnsz4EDIDnfqEqIslp90fN62QBtzJcbNEnk0N4r260Zm/NCyP9UG/SGrzT/ILV9xnRNjQDWRQzKghmipT9aQCCoWl9KuZECDqOJm8QUYs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by IA1PR12MB6043.namprd12.prod.outlook.com (2603:10b6:208:3d5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Wed, 18 Jun
 2025 02:16:13 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.8835.026; Wed, 18 Jun 2025
 02:16:11 +0000
Message-ID: <3271e5d7-9b2a-4378-9ed2-825507202c16@amd.com>
Date: Tue, 17 Jun 2025 21:16:09 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] drm/amd/display: Radeon 840M/860M: bisected suspend
 crash
To: Alex Hung <alex.hung@amd.com>, ggo@tuxedocomputers.com,
 stable@vger.kernel.org, regressions@lists.linux.dev,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: amd-gfx@lists.freedesktop.org, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Hamza Mahfooz <hamza.mahfooz@amd.com>,
 Werner Sembach <wse@tuxedocomputers.com>,
 Christoffer Sandberg <cs@tuxedocomputers.com>
References: <fd10cda4-cd9b-487e-b7c6-83c98c9db3f8@tuxedocomputers.com>
 <3002633a-5c9e-4baa-b16a-91fdec994e02@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <3002633a-5c9e-4baa-b16a-91fdec994e02@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0078.namprd13.prod.outlook.com
 (2603:10b6:208:2b8::23) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|IA1PR12MB6043:EE_
X-MS-Office365-Filtering-Correlation-Id: 36df62ed-33fc-4bcf-dbb9-08ddae0e1842
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QTZzV0lUaDA1Ymt1WVRlNXhjNEhHRSt0dEkvYWF3cDBmUXd3bWptc05VTG1h?=
 =?utf-8?B?Znh5T3NRNU9USG1nN2g4clNKanl0YStQQnVkdlJyNEo0TktaSDhsMzF5MnNr?=
 =?utf-8?B?RldmYzNKVFJ2amdwdElnbkJOV1gzYThrZTBHa0R3VEIreTFKUUhIMGNjc001?=
 =?utf-8?B?eHVVRXhSeGhtTllEbXZjNDdjRHdsL1VCd0ZNU0xFQUJpODdkMWEvclRvOEFG?=
 =?utf-8?B?R3ZSK2RadEdCem1DaXhvRGx3dUdXWFBicm9yQXg2bFhQYTNQZXVLVWdsZlBM?=
 =?utf-8?B?a01SVkg4Uy8wRWVwelpDdFpCQ0w0Umt5UW10RnN5c3dEWC83M29iYVloT0tm?=
 =?utf-8?B?U1NkSFlXUkcwM083NU9kRnlweHFjSVdZSloxYkRsRU5pQVZBalRlVG40aGZV?=
 =?utf-8?B?VmltRlAwMlNWWUQxYklrYXNVUTljRm9XWDFxNlRpRDRYL0V5b0E1YmJPT3d4?=
 =?utf-8?B?L09LaUgrM1RtMXJ0OUlnTmR2TEo0QVpEVE1pdFlqWnByK0VzalNNeEJuYWpD?=
 =?utf-8?B?S2ZnY3J2dWVnVXp3YlZXamhQaHBEaWE0T3NmQUQyb0dnVXRNQVdZQmhjSGs1?=
 =?utf-8?B?VzVCVUpCa2h4eG0rQi9qVjNHZUluL0tVOUVYRzlPbTArOXJXTXk5YVhhakdL?=
 =?utf-8?B?dTl0bmV0WVhKV3pLdlAxQTBCY3ZrT1ZuMDhtTDExNHk3dkdkdkMzOWtlQlFl?=
 =?utf-8?B?cnI0ZEFWK3JGU3lOVlZXRERSRDY5bmFZT2JySWdLemFhcENBcmREWE9xd1Ax?=
 =?utf-8?B?TUoybGdjZkRMdWJibjE3aTcxM2V1Yk53WDYrMjNwamFmcFoyeEo0RFVMTzN0?=
 =?utf-8?B?Wmh2RGlSakpWYUs3TXpnQjZWK29EQmxOdUpSZVVxbXhpTGJIQkcvbWg2N2pi?=
 =?utf-8?B?aUZvRlB0eGFaaDF4dU5nay8rVzNDeHVKZ0NQd3lLZGF1VVlyc281WThEMkdj?=
 =?utf-8?B?VGc1TjNPaVljTUtHd0FSRThrazNBam9ZYlV4YUtheUU4Q0VpWU5YMVI1MlJS?=
 =?utf-8?B?dnZCdTNHWTl4V2h6dFU0OFpsbFJLamdiSEhVNWZPZkFtYzZuRkJBNGo5T0Ez?=
 =?utf-8?B?M3ZuMTRmWnkrNnh0QlhudVIyc2pLaWtVTkYrR1VQdE56Z0plL3YvUXdCZ2Q0?=
 =?utf-8?B?ZVFnWlV0WG16ek1SM2I3OEErOG1BRFFwMndZS1NzUEZRYTdrQVEyQXBWZ0NE?=
 =?utf-8?B?YVpoN2JISndLYXNsK0h2OEROc0RIbHl3bGxZbUJVTExVS21xeU05SFRCanU2?=
 =?utf-8?B?SVRUaC8zWXh4clFhYVVyMlViclZLQk5YYW1uVHMyNUFyS2ZRM0dnV1JVMEQy?=
 =?utf-8?B?ZVhWNjZMYjlrRWhKVUxVU25aQjVoRjVJMHQraXEyTXU1cmhPRXFVU2ZwV3dC?=
 =?utf-8?B?SDRsOGtlckhwekQxVG4rdnNET1JWSzgxbGhPaWk5VVRNZ0NSK08xeHRiMDJE?=
 =?utf-8?B?VGFQRkxlU0o3TzhLY3ZPSEMvOXBRY285azdwK0hHUUMyVDB1UnhiSS9BeklI?=
 =?utf-8?B?QVBQYjFaSUlGKzRHckhGMkpRMW5ObkpvNVBsT1JvR01nOUc5OERQR1hrdk5u?=
 =?utf-8?B?My9OYzBERmZBY1JYTGN5NHllRmRYdlFzRGVDN01UNWRHVzhnbExsdkE5NzB4?=
 =?utf-8?B?ZWtsTDV2S3l4cGR4MURzY0NMT3ZVL09aM05naVNFV0NXQUh4RTIrYnBlSy9y?=
 =?utf-8?B?K2RYM2tTbXZCNDhqL3JmaSs0eFBLUytoM0hycU5KbGJQN2IzUnN2TDZ5Q3p6?=
 =?utf-8?B?aCt0cEg4alk4bFYyNlkyUy9zTmRrbWwxcEROWGx4T3dZMmxpNld6eEhvVjB4?=
 =?utf-8?Q?G/Z22kUiJGbl9DahNj4/bgPT4bqyLcOu0RSnM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?STdaWWFaWU5uUFZhMTkyYllYckFDOGdMSitLVnNTL3d4dERlZDJoT3VGQWV5?=
 =?utf-8?B?ZXBuYkFWTDBmK3FNUGgrTHRHMmpsb2t2cHpyS2tGbDZGL0N4T2s0STRkU2hr?=
 =?utf-8?B?SjZoeHgyMk9EWVN6Z2lwUng2NTBZVnhWY0d0c3pmbzQvZG1yRVlFczJ2UE1y?=
 =?utf-8?B?RUtneUdvZHp4NW9JdUd0enNlZTFUUGd3TE5mRW9HYTNGRktmdDZIaW9lb285?=
 =?utf-8?B?RFBacnE5WXhGVEhKdGMvS1RicjZFdGpnVURaWWVjc3hQdXpqcnh5Qk5MWVNJ?=
 =?utf-8?B?MjlVSnZUa0V4VDFOQlBoU3p4bnlOWmxFOVJNWXU1MkhuWW9MTVNHNlY4cHUw?=
 =?utf-8?B?ai9CTzZMZFhlazVOQVpTZ2Q4cDgzYk9ML3I3N1krOURqZHYyNnJ1QkpZMStO?=
 =?utf-8?B?RS9XZEZGZHVkYUQ3Vk9KSU9yWXpsRGk4WHA4Njl6V3QrR1F1R0g0bFBjRUR6?=
 =?utf-8?B?TERlbEpOU1ZLRmxVWDJtT1lvMUllZmVkSHJRVkU4MGpCNUptZ0NieUk5cnVo?=
 =?utf-8?B?MUNkMWxITklBZWNBK2diRDcrUWh1cmx0Tm1lYTdQSmVMZmIrYUJ3OHNwM3JX?=
 =?utf-8?B?Vk9jYzRuc2tWOXc1WUJhaHl1dzNVaExwRmJkVVZUZjNCOUhZZFJIZUtuRUFJ?=
 =?utf-8?B?d3M2c2JsT2dYc3RHcTd5eGlwcis2S1RPS3NEZUw1ZnlZK0FzZ2xvY2dielJx?=
 =?utf-8?B?VUVyTy9pK0JzS2NSakU1Y1NIMHA4di92V1pjSThJUi9VL2Ywd2xmOEVrSHNN?=
 =?utf-8?B?T0NFcTR2dFZ5K00xSThWVkp5UjdDRWVtRUJXb2doR1FqV1c0eGZTQ29Gd21z?=
 =?utf-8?B?eXBlOERYR0grTjJpa1NoemZTTW1Bd2FoRGV3QlpwRm5kMkd1YlcrVFJvMWg0?=
 =?utf-8?B?RythUGxsclNPaURuYVVGc3V1TkF2MVZDWGt1ZXJkNzdadkI2U25xekNETk8r?=
 =?utf-8?B?TzI5QzQ3amM2OTEwaWhOQ3lnb3Z4bkNOb25YbmJNSXUzb0owaldzRE9ONzFB?=
 =?utf-8?B?cXUvUDg1Rm41L1hzTnFPOG95bXFsUWdEQ0FyNFdjZndsVElMRkc1aHdZVGFO?=
 =?utf-8?B?MXdLbk4zYTF5U2FaMXR3SFFQdmZLTUs1T0NhMkdqV1I0WEF6TXZxd0tSNzVK?=
 =?utf-8?B?QXVxMHBDZWZ6cStGQzB4MkF1NXJLeGJKd1F0emw0RlpSdmYySjFsRGJ6ZjF0?=
 =?utf-8?B?NGZZTTE1L2FZVVNIUldlMVJ0NjJCdVBFanF4VXgrZU1BcU9VV2dPRkRzWVJF?=
 =?utf-8?B?Y0F5OEN3WFdPU0FmSDJqN2JTZmZTYk9nY1JuM3p6QW9Tdm9IVVVhbDhvdlFl?=
 =?utf-8?B?SHBmYnlIN3dKMWgycmlCYjFNc2ZNWUxoY2FDZ3JMMG5BTVdmZHJOOE9ydUU5?=
 =?utf-8?B?d1BTS2xNNVpZWERzTGZjd2UzTXdsdHo1SXBnUDJjR1M1TWkzT2ZiYW0xSjhq?=
 =?utf-8?B?dkxIcS9ONkxWNm9SRXhsYUhaN004RGFEV3ZtbEpsc0FoUmhVTUJJbkh6NHNq?=
 =?utf-8?B?cWdKWkU2Qk9YSnNJSkxRNitHTW1rU1YrR216S2Z3U2IrYThWbDM1ZFg1RVZq?=
 =?utf-8?B?WDA1UFE4eGhmT0Q3a25LL0tGZEcwMnJUVE5MY0k2SSsyOGQ2U05icTRNZG14?=
 =?utf-8?B?M3JWU05SajcxKzNLMlNyWDJQS25XT0pwUXFCZGUzWFJXTUNNVzVwZmdzY2pD?=
 =?utf-8?B?ekl0T1E3ajRDeDhkaUZLbitrMDVGYmhpSXo4akV0QUV6OWhSZHpRMkNVTVdw?=
 =?utf-8?B?OC9MOXVhWXV0SzFib0lUalp6K0Zualk2aGVTZ05lcjZoNXBCNUo5d0hBb2t0?=
 =?utf-8?B?MStxMmtncXp1cnArNXVSakxDVFg3eVlVSFVkdVFaR3p0dzJTeStaNHFTTXBR?=
 =?utf-8?B?VjZkQkVodEI5TyszWVRhT1p5Z2lZWEFoa0xNbGtqKzJaYXp0anhFVkdTNkRk?=
 =?utf-8?B?RFZaeGhKaHhJUVNmNUNCYVRrTXhYT0c1RDNiZ0dZeE5VZGxuYVhxYnhZQ05z?=
 =?utf-8?B?cGdhWTVqWGY5S2YyMzA1NUJLcW1uQi8wVWhObUlvb1JlQW16TDZacXlxWllk?=
 =?utf-8?B?Z2RqWnJKQVc4K1RjcFVlR3d3WWlrQkpzTTEzOVVwSDVxVTNkVlJKUm9ScFAx?=
 =?utf-8?Q?SBzrqY6LPb1lV05P3ODVwyhFn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36df62ed-33fc-4bcf-dbb9-08ddae0e1842
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2025 02:16:11.8454
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: heHilvDs50vphycPXRTtH2YZXdbAf7qpsdsms6GMN0PXA1u9qMzjMQfmXUi/LnpAvc2XhTWeZvTKVv+KX1mgHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6043

On 6/17/2025 6:42 PM, Alex Hung wrote:
> Hi,
> 
> Thanks for reporting. Can you please create a bug at https:// 
> gitlab.freedesktop.org/drm/amd/-/issues/ for issue tracking and log 
> collection.
> 
> On 6/12/25 08:08, ggo@tuxedocomputers.com wrote:
>> Hi,
>>
>> I have discovered that two small form factor desktops with Ryzen AI 7
>> 350 and Ryzen AI 5 340 crash when woken up from suspend. I can see how
>> the LED on the USB mouse is switched on when I trigger a resume via
>> keyboard button, but the display remains black. The kernel also no
>> longer responds to Magic SysRq keys in this state.
>>
>> The problem affects all kernels after merge b50753547453 (v6.11.0). But
>> this merge only adds PCI_DEVICE_ID_AMD_1AH_M60H_ROOT with commit
>> 59c34008d (necessary to trigger this bug with Ryzen AI CPU).
>> I cherry-picked this commit and continued searching. Which finally led
>> me to commit f6098641d3e - drm/amd/display: fix s2idle entry for DCN3.5+
>>
>> If I remove the code, which has changed somewhat in the meantime, then
>> the suspend works without any problems. See the following patch.
>>
>> Regards,
>> Georg
>>
>>
>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> index d3100f641ac6..76204ae70acc 100644
>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> @@ -3121,9 +3121,6 @@ static int dm_suspend(struct amdgpu_ip_block
>> *ip_block)
>>
>>       dc_set_power_state(dm->dc, DC_ACPI_CM_POWER_STATE_D3);
>>
>> -    if (dm->dc->caps.ips_support && adev->in_s0ix)
>> -        dc_allow_idle_optimizations(dm->dc, true);
>> -
>>       dc_dmub_srv_set_power_state(dm->dc->ctx->dmub_srv,
>> DC_ACPI_CM_POWER_STATE_D3);
>>
>>       return 0;
>>
> 
> 

That patch you did is basically blocking hardware sleep.  I wouldn't 
call it a solution.

If you haven't already; please use 
https://git.kernel.org/pub/scm/linux/kernel/git/superm1/amd-debug-tools.git/about/ 
to triage this issue.  It will flag the most common things that are hard 
to diagnose without knowledge.

If that doesn't flag anything, please reproduce on a mainline kernel 
(6.15.y or 6.16-rcX) and then file a bug as Alex suggested.  Attach the 
report you generated from the tool there.

