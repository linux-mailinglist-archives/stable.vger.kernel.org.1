Return-Path: <stable+bounces-200928-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B215CB972B
	for <lists+stable@lfdr.de>; Fri, 12 Dec 2025 18:25:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 250D730C6A7D
	for <lists+stable@lfdr.de>; Fri, 12 Dec 2025 17:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D42E2D7DF4;
	Fri, 12 Dec 2025 17:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WgeBcuez"
X-Original-To: stable@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011067.outbound.protection.outlook.com [52.101.62.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B91F2D77F7;
	Fri, 12 Dec 2025 17:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765560197; cv=fail; b=Kh6v1ueUdokSbr2Z0MLuL3RDL7PenJKvl+Vc5Txyvc/9GHMoDDxLUFJnGkNrejlEHHl7KclrIHQ5am+t0wvohYIlT2Elnq7gx4Cke0mUuyq1TZYooi7SALLrp/OsJtg1bw9fNowjQKBCiKbNh1XEd4dCVq6z6XCJ7/jgib9Ex1s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765560197; c=relaxed/simple;
	bh=GLHGj00wU0oBumiaafZ5BNXdMBYWCToW5mQNKRWRf68=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=D6uBU56asLPcakE3hcMdo0Wz+0nTQ/KtidnsAc5aEqcY0WkiIQqohR94wtqv7FpGetZRBxAnac13N2okgXv9lTunFzS3Zagio6zol/PjdFSPyPzywz25XhV7GZanb/+fL8ePtkI9/8lVwf0jEA5IHZHf74sZHHVfgtZt1alZCwA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WgeBcuez; arc=fail smtp.client-ip=52.101.62.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SUPKFnKmHRtvvQHMbhXOhF/e+Tm/M7gI38br4YHN4938WjGfaGwrS+IwN626PHztAQbJjS9DwIC3x1aX6MNBivlTI9sGLa/tsT4jXhbBoZueXPa0Zu6aQ7dJbiQzEDg3iiFPalRKcDu15AuIBz/hsiKNooeItVG3rLOTek9uNnxBqxZLO7wg9JqqTCnMoxY/m2uio6ajmzfEYwRw6dmm8T8DhoymFYZ+9fm+uiE85peEA17ddRiK+E00mD4wuwFBFICYxROnjqq/6oyW4BVAreejqTUGzyAOzCx1t29AsZeZpPWftgTYTN9Fmi83NAlN2ivb5Xf37VjzPV6ufTvmng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PvIhyUH0OQz78VtY7mWlB4L037BkHh+HrpH1dJcFpkI=;
 b=xhRhVx0tyTVeMhZ7Pzqv57I2iPtLcA4/rPSwD3wH5wKFt9+5obnmLd+Pz1hbPaZg8UDoGG5ufjeU58f+Lg0bLwV6LvjNkiw+2wvCWreBKPS0iYo7uZE9XeV4M6IAozkV39afpsrjGXH7p6HexaYB97JY2oXGc4ZSReUci0NVK5dTMZyRywtLX+eNpXHYA8KOXJakCxuq2/AypHt3/as7JEtR88iBga3hgxYIpI9UK6AVTSBxeg92JyCSmewv58x5zI8Dufkpg8OI5lTXkhSHILUpTPoy6+P5QlmHCXcbVSNJ47fkZvn9voBQKVwcBWWpLPL+rVgkLbPXahMvxEGHMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PvIhyUH0OQz78VtY7mWlB4L037BkHh+HrpH1dJcFpkI=;
 b=WgeBcuezKavxbGMDDZzaOkjkbIBlJQTBXw2wSN4tZtGjeYK7P/fTT4slDn0XQ33TQev2L+FdNfmCWtNOb0N5NQI9DC8SnKOfPXkGPysa2Z29kmtxAAEKbb2gHuvXU2WrFD1zoCjjzPpw1rnKGlOYf1IlSJnS9g8doUndAkEVPmY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH0PR12MB7982.namprd12.prod.outlook.com (2603:10b6:510:28d::5)
 by BY5PR12MB4131.namprd12.prod.outlook.com (2603:10b6:a03:212::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.11; Fri, 12 Dec
 2025 17:23:11 +0000
Received: from PH0PR12MB7982.namprd12.prod.outlook.com
 ([fe80::bfd5:ffcf:f153:636a]) by PH0PR12MB7982.namprd12.prod.outlook.com
 ([fe80::bfd5:ffcf:f153:636a%5]) with mapi id 15.20.9412.005; Fri, 12 Dec 2025
 17:23:11 +0000
Message-ID: <1735c1c0-e731-4fec-83b1-818012194fc8@amd.com>
Date: Fri, 12 Dec 2025 09:23:06 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erspan: Initialize options_len before referencing
 options.
To: Frode Nordahl <fnordahl@ubuntu.com>, netdev@vger.kernel.org
Cc: stable@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 David Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Gal Pressman <gal@nvidia.com>,
 Kees Cook <kees@kernel.org>, Cosmin Ratiu <cratiu@nvidia.com>,
 Tariq Toukan <tariqt@nvidia.com>, linux-kernel@vger.kernel.org
References: <20251212073202.13153-1-fnordahl@ubuntu.com>
Content-Language: en-US
From: "Creeley, Brett" <bcreeley@amd.com>
In-Reply-To: <20251212073202.13153-1-fnordahl@ubuntu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0003.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::8) To PH0PR12MB7982.namprd12.prod.outlook.com
 (2603:10b6:510:28d::5)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7982:EE_|BY5PR12MB4131:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c08e7f0-dba0-46a7-f2e9-08de39a31fc5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L3VnSFlBekc5VHp5OWhEQ2ZQTmdvY3FmQnNNWEpwdStNQXhhTmVJNlArSSty?=
 =?utf-8?B?amdpdnl1a2t6S2lNUHNLNjBjMDErSGluck4rREs5T1RSRWdmQkJkK1orRnhm?=
 =?utf-8?B?VHdPMHVMaEJpNGZwcEV4SlNLdlZIU2U2NkVoZUl6azR6dTlFSVBIOGwydUhW?=
 =?utf-8?B?U3ZGdGNCNFM1VE1CTVFEek81OEgydTNVTGpPeVBuVWdyQlRZTlNWUmM2enpj?=
 =?utf-8?B?aUJrbkd5VWNDdDFFaHg0S1hiVjJkT05zOE5oaUNMZEtjdXNUSlF5Vmt3TjAr?=
 =?utf-8?B?Y1J4Q3g5UlppQXo1ZGRiRVdqUGUzVElKZEFvTG8rQkV5Z0orZjNReG56ZXJS?=
 =?utf-8?B?MGR1eFZqM0xXZ2kzSmpDQWNoZTBBMEZkYzkxaWc0MXp1UHlqQlNtWHA1YTJv?=
 =?utf-8?B?eGlBb3VCa2hza2N3S01JaTJxUWNJU3UzZk5tbWYyb0h5cGRjaEVKY09USUFs?=
 =?utf-8?B?NnVTc1RRZExIS1FjSE5CdmtQNWh0a3ZmQk5NemxDSlFxd0FhU1QwQmNuVzB0?=
 =?utf-8?B?UEJTUXdsVUFrczI2Tlg3MEQwU1BKNE15RXRwbVUrakVqQ0dTeC9RRFFTR09H?=
 =?utf-8?B?cFphU2JTdFFHb1c2WlJDUXBKbEFvZ2ZhSC94d3JKOHFVY1hFQmxBejZVVlVz?=
 =?utf-8?B?NldSQitwNkowdW5uVlQvWXdNS3p6N1ByQnNIbVRpYmZJclhBWitIOWh1OGFD?=
 =?utf-8?B?Z1BrMFdaVVF3ODlBYlNVNlNJSGxGdGZXVU9sZUJTTlZPclVGOU5wc25tUHZM?=
 =?utf-8?B?WkQvWjFNaTBIcEY4aUo3dTdHTGp1Q0MrbG82RFY1RUUyVThqa0tUeTlxTG84?=
 =?utf-8?B?ZzlmcjdqNWJ1U1VkNzkwL0l0NTRlWmk0Q2pEbUJVSCtFTThpUjlOeW0rQ3cz?=
 =?utf-8?B?WGxWTnRmT2ZlR0YrRDJGQS9uVG1RaUdGQlVnM1piR045azl1ckhRZ3ZHSGkr?=
 =?utf-8?B?c20xL3NRcExEVDRWTGtaalVkeUpXT1BHS2c3QldjMnlILzhabmtEUlAwUVV3?=
 =?utf-8?B?dlloc0tTVzVGM1I3T1ZUanZLK2FTTUxNM2w1SmlQNEJ3WkNEYTA3dG5CaXFS?=
 =?utf-8?B?T1VNNDlPMjVsVWxTalhieHByT3VGRE5xcVVpM0V6b3JEc0hqYmtqZE0wUTZr?=
 =?utf-8?B?YzU5RE5nM3JkaXJ3dlRmNENPNzRrMFg2WDd4MkdmR2tHNTlTWFVCWlBESVFB?=
 =?utf-8?B?blVhZEdyS0oyblJQc21ZQ0pxOFA3VmFPZ2p6c0p2RXZzN0NmZFhlK3NVc1pY?=
 =?utf-8?B?L1BXZ3RxNVU3UG9xdzBzR3hBYW1VMWpFQ2pQWFVUbW85WFREUm95ZnowYlAv?=
 =?utf-8?B?QVhOVkQ3WWRwaERTbFFDTjJDZUFjcU9VL3VtWEJadEpWN3dSbWR2T0FrTFhR?=
 =?utf-8?B?eGpaN0hKMFUwZHQyYWtUVWNQYXdsWnY1TVBtSDVHb0UvNTdRSHRhK3M3RlJM?=
 =?utf-8?B?Z0FFakZBSEozK2FSNC8wNHIwdmV6bG54VVF3UWFxZmxYZlhyc0cxdDg1a1Ir?=
 =?utf-8?B?OTgzNXFZNmdYc2xWYVd3NHN6dWJNU2lMdEJtRjZDa2lmalpOd2lXK2lUR0tq?=
 =?utf-8?B?OEYwOENwQUxJN1ROa2ZiU0V4U09MNUJZQnFSbGoyUkZWazVSR1prZkhKQU10?=
 =?utf-8?B?SVhQL0N6dkMrNk5ZL3lsbnpNZ3BEdnZWZktLMTk4L2FTVFQxRVJobitlQ0hy?=
 =?utf-8?B?SW03UXh2RVRyTVNvNDFTbFg1SEdKKy8raGJPSy9qUTBYQzBIc1hGWUo0Vnpt?=
 =?utf-8?B?dzJPTW5IMWhVQUd1dzdLbVF6ZEpFdXNIYzlmMlVzNWJMY3JEZjI0TytXREV3?=
 =?utf-8?B?S0dqMVRyTGJjbDB0UURxU2NDVkszLy9peGNLNTNzZGRDUTBpaithb3hwSFNs?=
 =?utf-8?B?TmVkZ0lSYmU0QXFVZno4NFZMcGdLQWJ1VlJZRGQ0U2JDN0MxZFNnZ09Nc1NB?=
 =?utf-8?B?YW9McHJ0ek5xTjhnZGtvV1Z4ME9tNVFqc1QyQWx0QzFrVkhJVG1TVEJhbGhj?=
 =?utf-8?B?OExVelRvUkpRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7982.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Ry9WKzgraklIYnRHaUxXa0hpWWlldzQ3c1BqM2hhWnN6SGd3bWxSUnhBY2lG?=
 =?utf-8?B?OUZCeStXRHduenhXZ3hxLzBnMVZHZkF0Y0JHTzJLME45a1M5elRkZUc3eVJm?=
 =?utf-8?B?cmFnNUF3VGZVVHFKdk1UYWRRbXNwY1dhTEFmejMvT2FiTkthelVlbktqN0FU?=
 =?utf-8?B?SG1sY0I5N28wT2lXam5FQ09PdUpkMFBiamhkUnNJcjYydFRjdUt3ZUZ2T0JH?=
 =?utf-8?B?bnQySk4rYWJWT2Z2WFNFTld6QnU4UzB4UGk4c1lKaVR2cjREcG50eHoreTNY?=
 =?utf-8?B?S3F3MUp3LzMxS1FNOGRnM2xvRnRMN1Q4QU5mT3FqczN5bzF5U21SZ0F6S2FC?=
 =?utf-8?B?Uk53N3gvUHVLQlZpcHJ2T25XbDVNNllKRWJVdmxYK3hkTGtjZnJmOGhxTVNQ?=
 =?utf-8?B?M09sblorWU9DamlmRTU5NE5FSlpOL0NCcWlHc0x5TkdGOHFpeWpIZ2pOYTh2?=
 =?utf-8?B?bktPbnk1dFUzcm1ibWowOHhncjJTVGNFaWhic3pDM1NZWVhjeXlvQnovRDFu?=
 =?utf-8?B?Y0pvYnc4V0JVQjRFMzV5ZElvbG5ubGM5Rjl0TGhRL1p0K3dPTWlicDU2d01E?=
 =?utf-8?B?SXlXMXdWbWhRb0V1WWtvQ0N3bExXWkVQb2tmTnpibHZNbnpMTnU3cTlYczhO?=
 =?utf-8?B?VW5QMjNrUWI0M0NEdmt6UDlPdlZaZUZSbGpSUVh3Qno3Z3llMGtlUksxYVdl?=
 =?utf-8?B?bFA3a2JLblZXdmVNL0hXZU40MXFYWW83YVhoR0VWNHNXOHZjOFBoeDA5bnl5?=
 =?utf-8?B?V3pNNVlhNC9jUXIxUUFFcGlBOUpPTDVmQWpQNkZtMHNtaVkrQ2w2SWNzRnMr?=
 =?utf-8?B?aEJKVHNHMXUvUDM3OForVFVHSnBMMGZXdFlRRGpTZS9XbjdDQi9UVjJuUnQ1?=
 =?utf-8?B?ellFTlZCSFY5RVQwWDdob3NhNnpJQUorR25vVEY0ZGxteGNxckwvWk4wV0VK?=
 =?utf-8?B?Zmd0UGRLUm5sckxOcmhqbnJvVUhBc255NzRrNkErc09DVFB4TkU4dTJhMGty?=
 =?utf-8?B?MXNlMzdVTWtKMHdHbWhOTkdHSjBJbk9MUWtDVGxSMVp5cmFkV05WM0JhTnl6?=
 =?utf-8?B?VEgyMnBxVnRyTnB3SDVMaFp4NnluaUgyb3Y5YTIvU2d3Yk1DUFkvVU5yTnNJ?=
 =?utf-8?B?elZKeGpwVFQ2U3UvTTgrUzVpYjkwemdEVjZsdkwzcEJEVlBOeU85N1lwVzRq?=
 =?utf-8?B?SE9RbExLMDJsKzBpdkp1dEZGOW5SaUFyWFZXdURrdjQ3amFKUE1aNjhIQmJj?=
 =?utf-8?B?MUJXaks3UFRsVVZOQ0szZkNHaE90NGVRUllJWUp2WVgxcWNBQ2FqVy9LZ3di?=
 =?utf-8?B?Uk9ES0VSM2NjM0NTTEE4cXBSL0kzbm9VNytSbHlNUkczdEVtcTRvR0lxM3ZF?=
 =?utf-8?B?RjVQUGVvRktnYWtWWXdoeTlhWjR6RFgvK2FyenJaM3Y2QkJKMVM0RFhEV2kr?=
 =?utf-8?B?SzdkRmZnZE5HaXd6cWZySFQwdkNBbEdmSFZFVXlzUE0wWG9KbmE4ZlFldWdh?=
 =?utf-8?B?VkNwZ0l5N1dYVXVaalppbzBJZmdUSHZKNkZDK2pCSVRUZ3JFblB2cm1CMnpI?=
 =?utf-8?B?ZVBJSUVvV2xYaTNBRTBIUUoxUTNoeDdpR2lkdGtyYTBvM0hGeExrcm1HS05m?=
 =?utf-8?B?YXIyTHRkUUIwWW9HUEN1NkpqUnJjMWNIM3UrSkhsa2ZjK1IwM0FWUUtJWFdL?=
 =?utf-8?B?blFGUkVqNHFMVWsxR3gzTnMxc3dLcmx0bzZBTW9CeFVKSUZhZGZiNmFxSVZP?=
 =?utf-8?B?ZitZMEY3TWo3YndBajEwZkp1M3IwbFdBS3FDUDZ4Qmk3clRjdDhna09ic1RV?=
 =?utf-8?B?bTJ2SHVFakt0NkVFUDBuUklQdmdWL01aVkdoUkJSbmJrQVJJRklNNzBXRUpx?=
 =?utf-8?B?OTVFZ3lhUXF0U3EwamdYM216bkVqYytNUCtscG15N2hXK1dnbEIzWkpZZnZo?=
 =?utf-8?B?bExkeEZGTjd6a3hSQUpseXIyN0lwTmZrRUQ0VVJ5dE5rTTJKb3lqd1FpK1h0?=
 =?utf-8?B?K2kzSE9ibDRXOXAzc0dnU1FVeWFsbi9HSkVFTzN2aWkrNHp1ZDZraW9md1Zv?=
 =?utf-8?B?U05XNnJYeHBjbXNpbEtXLzVlZVF3MFF5MlpNRVI4VTBKd1ZKYXRBd1c0ZkxV?=
 =?utf-8?Q?JoPe/GOb1PYsrsm+1yXNmadDJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c08e7f0-dba0-46a7-f2e9-08de39a31fc5
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7982.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2025 17:23:11.0393
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4gBF0eTKaPha+Pxw4BuFHsOsb8JgRYIWbhVwpQYVKbJCyYXtiBjPK3fCMFe7d64J3mgIs4LJgHo8+j4GIkwgoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4131


On 12/11/2025 11:32 PM, Frode Nordahl wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
>
>
> The struct ip_tunnel_info has a flexible array member named
> options that is protected by a counted_by(options_len)
> attribute.
>
> The compiler will use this information to enforce runtime bounds
> checking deployed by FORTIFY_SOURCE string helpers.
>
> As laid out in the GCC documentation, the counter must be
> initialized before the first reference to the flexible array
> member.
>
> In the normal case the ip_tunnel_info_opts_set() helper is used
> which would initialize options_len properly, however in the GRE
> ERSPAN code a partial update is done, preventing the use of the
> helper function.
>
> Before this change the handling of ERSPAN traffic in GRE tunnels
> would cause a kernel panic when the kernel is compiled with
> GCC 15+ and having FORTIFY_SOURCE configured:
>
> memcpy: detected buffer overflow: 4 byte write of buffer size 0
>
> Call Trace:
>   <IRQ>
>   __fortify_panic+0xd/0xf
>   erspan_rcv.cold+0x68/0x83
>   ? ip_route_input_slow+0x816/0x9d0
>   gre_rcv+0x1b2/0x1c0
>   gre_rcv+0x8e/0x100
>   ? raw_v4_input+0x2a0/0x2b0
>   ip_protocol_deliver_rcu+0x1ea/0x210
>   ip_local_deliver_finish+0x86/0x110
>   ip_local_deliver+0x65/0x110
>   ? ip_rcv_finish_core+0xd6/0x360
>   ip_rcv+0x186/0x1a0
>
> Link: https://gcc.gnu.org/onlinedocs/gcc/Common-Variable-Attributes.html#index-counted_005fby-variable-attribute
> Reported-at: https://launchpad.net/bugs/2129580
> Fixes: bb5e62f2d547 ("net: Add options as a flexible array to struct ip_tunnel_info")

Should this be [PATCH net]?

It seems like this should be intended for the net tree.

> Signed-off-by: Frode Nordahl <fnordahl@ubuntu.com>
> ---
>   net/ipv4/ip_gre.c  | 18 ++++++++++++++++--
>   net/ipv6/ip6_gre.c | 18 ++++++++++++++++--
>   2 files changed, 32 insertions(+), 4 deletions(-)
>
> diff --git a/net/ipv4/ip_gre.c b/net/ipv4/ip_gre.c
> index 761a53c6a89a..285a656c9e41 100644
> --- a/net/ipv4/ip_gre.c
> +++ b/net/ipv4/ip_gre.c
> @@ -330,6 +330,22 @@ static int erspan_rcv(struct sk_buff *skb, struct tnl_ptk_info *tpi,
>                          if (!tun_dst)
>                                  return PACKET_REJECT;
>
> +                       /* The struct ip_tunnel_info has a flexible array member named
> +                        * options that is protected by a counted_by(options_len)
> +                        * attribute.
> +                        *
> +                        * The compiler will use this information to enforce runtime bounds
> +                        * checking deployed by FORTIFY_SOURCE string helpers.
> +                        *
> +                        * As laid out in the GCC documentation, the counter must be
> +                        * initialized before the first reference to the flexible array
> +                        * member.
> +                        *
> +                        * Link: https://gcc.gnu.org/onlinedocs/gcc/Common-Variable-Attributes.html#index-counted_005fby-variable-attribute

Nit, but I wonder if the Link in the commit message is good enough? Same 
comment below.

Thanks,

Brett

> +                        */
> +                       info = &tun_dst->u.tun_info;
> +                       info->options_len = sizeof(*md);
> +
>                          /* skb can be uncloned in __iptunnel_pull_header, so
>                           * old pkt_md is no longer valid and we need to reset
>                           * it
> @@ -344,10 +360,8 @@ static int erspan_rcv(struct sk_buff *skb, struct tnl_ptk_info *tpi,
>                          memcpy(md2, pkt_md, ver == 1 ? ERSPAN_V1_MDSIZE :
>                                                         ERSPAN_V2_MDSIZE);
>
> -                       info = &tun_dst->u.tun_info;
>                          __set_bit(IP_TUNNEL_ERSPAN_OPT_BIT,
>                                    info->key.tun_flags);
> -                       info->options_len = sizeof(*md);
>                  }
>
>                  skb_reset_mac_header(skb);
> diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
> index c82a75510c0e..eb840a11b93b 100644
> --- a/net/ipv6/ip6_gre.c
> +++ b/net/ipv6/ip6_gre.c
> @@ -535,6 +535,22 @@ static int ip6erspan_rcv(struct sk_buff *skb,
>                          if (!tun_dst)
>                                  return PACKET_REJECT;
>
> +                       /* The struct ip_tunnel_info has a flexible array member named
> +                        * options that is protected by a counted_by(options_len)
> +                        * attribute.
> +                        *
> +                        * The compiler will use this information to enforce runtime bounds
> +                        * checking deployed by FORTIFY_SOURCE string helpers.
> +                        *
> +                        * As laid out in the GCC documentation, the counter must be
> +                        * initialized before the first reference to the flexible array
> +                        * member.
> +                        *
> +                        * Link: https://gcc.gnu.org/onlinedocs/gcc/Common-Variable-Attributes.html#index-counted_005fby-variable-attribute
> +                        */
> +                       info = &tun_dst->u.tun_info;
> +                       info->options_len = sizeof(*md);
> +
>                          /* skb can be uncloned in __iptunnel_pull_header, so
>                           * old pkt_md is no longer valid and we need to reset
>                           * it
> @@ -543,7 +559,6 @@ static int ip6erspan_rcv(struct sk_buff *skb,
>                               skb_network_header_len(skb);
>                          pkt_md = (struct erspan_metadata *)(gh + gre_hdr_len +
>                                                              sizeof(*ershdr));
> -                       info = &tun_dst->u.tun_info;
>                          md = ip_tunnel_info_opts(info);
>                          md->version = ver;
>                          md2 = &md->u.md2;
> @@ -551,7 +566,6 @@ static int ip6erspan_rcv(struct sk_buff *skb,
>                                                         ERSPAN_V2_MDSIZE);
>                          __set_bit(IP_TUNNEL_ERSPAN_OPT_BIT,
>                                    info->key.tun_flags);
> -                       info->options_len = sizeof(*md);
>
>                          ip6_tnl_rcv(tunnel, skb, tpi, tun_dst, log_ecn_error);
>
> --
> 2.43.0
>
>

