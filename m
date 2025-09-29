Return-Path: <stable+bounces-181923-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C4DFBA9863
	for <lists+stable@lfdr.de>; Mon, 29 Sep 2025 16:20:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5531F176382
	for <lists+stable@lfdr.de>; Mon, 29 Sep 2025 14:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AB4225B1FF;
	Mon, 29 Sep 2025 14:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="t0cAHdzg"
X-Original-To: stable@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010003.outbound.protection.outlook.com [52.101.56.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A069E304BAF
	for <stable@vger.kernel.org>; Mon, 29 Sep 2025 14:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759155640; cv=fail; b=jsLUoHucfnBc/YnkwTqqJChgq+wZWwlt+VIqISYxwsCWSpSuPEoSZELX9uqQKyV0MJ88EbfE/DcgyArYFO9lI/kPUpofCWOxUYxvrkqQA1pLFxEzUW8l7f4tL7EGXD5CwbIXAeEOFCghyYLALuF/y/eK9RE7ygujG0CPh5q2EOk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759155640; c=relaxed/simple;
	bh=jq0VwCQ9nx27OvWlo5+5D7jdu86BnotfRnvN0l74Kvg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ut6qq4mM5eAqcssfA8F+5uAiArAJCr7kVq/jTwdcV2CIOj49X2xG6zBafJqR1HgFqs9s8E0rNb2eVN8NZivg9sQ4MW5RK6DgprVJn9iK+bIZQ/Vo6KuMKfwZxmoy9TgFMaTMUnd48NXU8JQKg0is09m5jr/VuI0a490AcT1FD5w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=t0cAHdzg; arc=fail smtp.client-ip=52.101.56.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vpJA8TS0NzVV6s0T1UL5Na4mq+QuKl53Xxza/zpS8dZSxKWeBFJCiaZb55/RSKhP3zNbOm+zuOqkoi89efMpFeym0SzZgQQ9Piu6v/TErBA9oDCxqv/9r9GmRKW6GDudtqrXUsBkZWVTisNRmFtZSxSEpJjcZVYVxXidlFLE+FMegOThd0QZ0tMZaHxKPZrFwYZtuMHAiL30MKPI0NikzNA+P/NeLDhb7OzBKuxapERt6iR72No30ADPiLHAX4zTgpwRcRzCq8kQXVhP61ZLuYz8Djbg3IeVq/MC3Jq6QYeNx4NVZlTWtVw1mO5uK9cGi18ztPJBr531LbWpBSeCSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x5g/6kzw7EEvnkDT6yCk8DWZEsv5jCtWjyKzVvPm10s=;
 b=OvLxrHSSZJe2uCwrapLZWN25KegklfmIfIE5JC/THNdMqwnhCUwd0cAQte34ghaDutg22dvrcwZHKp3yFfbh6C/aKsEPuZZXdAdPCVdYxaBRglreR6byUzXCjFq2utIcSEwXbpHNUaFscs9mTkZVbwarUurFG7amCoskINacSc2x8/VZ/ZXUZMgGKkb01f904yjPJPs0UnHIo5lhexFeSdFvA2rDG3aDi405PE+n6kdfuNY3qpN9Yv75gQaz67q+M/3TTqvhOhfo4dRginmS/BawBK+xrHnZly9y8nXhFwhXF+BJOQZWpi4HvDAjvNU5ujLjWN5VYhtY0qKazKaVnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x5g/6kzw7EEvnkDT6yCk8DWZEsv5jCtWjyKzVvPm10s=;
 b=t0cAHdzgvTV7vIk8TeSaEZ8LQptVHw8GKz6YkLG/MRHqRbJmVQqn/UbwCDT8TcULOdDHtX2CvZHfnI6BrH0vslBu5t0SRZOnWopVYK3EBn4pgefSiSlnmUJ04/RDhPv77c4/HuY3iAKDXwv8HF1Mrf8O2iLz65/eyXSeG4R1bXeL+s2Y/XQ4PU9OsS2enOW6oSobkqtA9GMQ82Cvp2vLrVktaIll9UKiciTRJXtufVZWBcXfufIzNomoFBLJncZCcW3j89bMWtrO5YKW+cCEDloq/l3gjpzCLTp8goQ1+GAEkFPt/93w40gdnCahP+Wv6uHXDpPEe9UXTqzgqPLdWw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DM4PR12MB6374.namprd12.prod.outlook.com (2603:10b6:8:a3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Mon, 29 Sep
 2025 14:20:28 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9160.015; Mon, 29 Sep 2025
 14:20:28 +0000
Date: Mon, 29 Sep 2025 16:20:17 +0200
From: Andrea Righi <arighi@nvidia.com>
To: gregkh@linuxfoundation.org
Cc: changwoo@igalia.com, tj@kernel.org, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] sched_ext: idle: Handle
 migration-disabled tasks in BPF code" failed to apply to 6.16-stable tree
Message-ID: <aNqVoQaJzYWReVvn@gpd4>
References: <2025092952-wooing-result-72e9@gregkh>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025092952-wooing-result-72e9@gregkh>
X-ClientProxiedBy: MI2P293CA0010.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::20) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DM4PR12MB6374:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bcbc0c1-86ef-4403-c252-08ddff635690
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Lg9pC8bbXFy/m/yA5HyLZG/Roq+ZbWY71fnpOz+i2/5KvbqfvoHxlUATxZH5?=
 =?us-ascii?Q?UEwloRMP8iEonpb36bwJD5usFoH0Bltd+pZGwvTjb4sh7QPBTVFxc3PXi1q5?=
 =?us-ascii?Q?w0+CTu51KyNmZhRCpNQVJKKkGHFRYKOPCsgD2fP9PqDWul3rFh8vY2rpDoaN?=
 =?us-ascii?Q?cvPN2yekWAr1HSENaGbLxHkIOeuh/6J7icnnIiVpIubxe19ETtDUUPc3FaZL?=
 =?us-ascii?Q?Pa074dIu/96gKh7GPmtydN2O4wm1VUey8nwXC0fjIncI3akT5WiqegHkO1nm?=
 =?us-ascii?Q?aXvhzJJfc8xsw3asEdtbO4AbHRYbl4/xgH3ww3ta56jx8i318Mb3ZOAymQqz?=
 =?us-ascii?Q?sUg/c291alZ6NF/c4GyGH53SdxhtqgUUQizib/PWxYDqLzcv7DiUONzTt0L1?=
 =?us-ascii?Q?zh5hDgyOl8MAZA61/OZh22EPAEA/TYE9kcDsoCsqtETmI3SDoNoj2jab234u?=
 =?us-ascii?Q?eJt+rhyXFzwqSgfGxrrmXU5d4OZt/woF2E1VSGzOX5sbSfiD/4v3txcpZ0EO?=
 =?us-ascii?Q?WAfojwLe7PcZG5ZlLfkG4kRDrOycJtFWYB05S5D7wR/5fHA9mJRA9BviPTTa?=
 =?us-ascii?Q?JuGGE5r/QNS670Cp6K5CBF2kfcf2SI/KiUYb8eGQCc7WjBv//Nr5WGsnMLop?=
 =?us-ascii?Q?hm0f/L7Afbq3Hv92ye8QsdPTOV4nNsH8EEhW9nIrLL7pOiMrDt3HOqd3h9fu?=
 =?us-ascii?Q?ytvfg7geDxu6lfyAZjJQ6BFh9EPqRgXLXVRF1w2Pszg+VsQDw+/CUB+/AA1m?=
 =?us-ascii?Q?mFpbXVKDqqt41mVgVQZ9FT3kTCDFhbYm08kZMpHkKKktBkygH4Y3mo2kK4eI?=
 =?us-ascii?Q?fV7HYztBtMi8lwcbOh340hMSLqtpzREDbAuOsYiRIVWoLb8yE1Xt6cWUd3eD?=
 =?us-ascii?Q?xZyTMglX8BrYGIDOkSz4PHJq/4em40TOfqGxA9MsfvhsdfGZCRaJy31Pr+Dg?=
 =?us-ascii?Q?2xfC2iyE2hthKVt8a7mqXwIjMblVgBD0u08510txi3gQaSfWXhwAWbcSFs+f?=
 =?us-ascii?Q?QTH+gewHMW6X1jyHgE3koCa22q0e7zbUpWgPatwtgT9JuVzopPsNZGbEWvNv?=
 =?us-ascii?Q?o/2vjYueuzW010DsMDAAvKp3kBZK7BlRMzH5XHkA7zlx4U7fQIdtokMLbsR+?=
 =?us-ascii?Q?6lrbBpfYmCaWiRWFxpPma82fdsMeFluGqELXBitTajNmLaeAfHmMikDMB+A5?=
 =?us-ascii?Q?eGOGfUC6B/PeoFjW81Cf2nopOzH8h0eWjs7SXLtirE5j/VRZ/ChG/dKn39Ln?=
 =?us-ascii?Q?GI//LEn+FjUJI3Yjlm/iQz/rwWeTspZjCptM1XRX5nltAV6ANsWsPusjFuYg?=
 =?us-ascii?Q?9QBhlkGURB6TOq0n7SCgspUHiKv8UbO7qOUYH32GymwOdjJEh31P193Xr7II?=
 =?us-ascii?Q?uFF+xlFqwgEOoXZWGFnAu2/xFq5kWUz6iAmlBataunJd7oB4KeggPe30F/h7?=
 =?us-ascii?Q?4hPrCc9o86dDzYGv1upN1XPACWMzcHYAdatpWaV6CQPeeKn9QN79EA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2evaiCa7ltcWkletY298K4mItxPgt2uX3iKzNFyqW2Rum31NFTJhyJexrz9A?=
 =?us-ascii?Q?0ej/oZzu+ZKZLETZviHtCGVweIlR4MuzC1yot1pZAMsm07uqzJK2AEFjCBWN?=
 =?us-ascii?Q?BJJok32ek67F57slLXOOv37QBrh6A4mlytdroki07RPSiHh+AeqjHA/YstgK?=
 =?us-ascii?Q?RSeIv/wEbr9iZl3zV+DHpgftAHMomz6zOMTB1M14GCh4EF7V4TgPKRX1AWtT?=
 =?us-ascii?Q?Ew6coLWi6H77UffTpwaW90SN/pn/AaOolVTZimBNRwqeJmgyz7y4h/nYKhgV?=
 =?us-ascii?Q?/18yZDzFokLIApWgCpDLZNRHEayBQV58qs8U1Z+yukiCfdS4OhZM3tWKFlJn?=
 =?us-ascii?Q?nm9asy7fka7s+DwdxIGmsCksSd5sdoYOQYRSNuEWTdp4F4AzJEVZlyQhzQUg?=
 =?us-ascii?Q?tRF5Tj45hkdnfOSUsJZjURZyBrvMbZgO3lf0JoF1/LoHh3bNX/viU2Aq5Mck?=
 =?us-ascii?Q?DbDgny2R6/ZzTpwqlPRnPnpKtYTkX7sRc9a53vDYaNkYI60onO/K28tCh0F1?=
 =?us-ascii?Q?8fF5H0Lsjs4M3RJfkOFkEa9nyWNgpGxF5TpJXGZE3BIplhaAVzOTiADTjVvS?=
 =?us-ascii?Q?3Q9AaHljJKMDDRIDcpyBTO9KJD0UrI58iiHs0soZNpx/d2qN2AZeg+h3zdEO?=
 =?us-ascii?Q?WHXQWs6XGC/7KXPi7kDrMm3P2qAziGlDeh1HAoshQA9C07TptH5eZDhARF1z?=
 =?us-ascii?Q?GZ44CP1lHV4J/y4DbNTm1oGpag9XwlK2AQHLP9OHX+SZSr0fiyoBs+/z526i?=
 =?us-ascii?Q?G8ngX2Qp6ZMfKNLInY1TWiQLLrRlwGaGU8QDx1+/fubDzSlfS17DjK468xOP?=
 =?us-ascii?Q?F4rndq4Vcg08AiQB7KYW39OFmaoHeJ0gJE6Ad0WYmH+ks9dC9augZGsBSsV8?=
 =?us-ascii?Q?td3R3F+mbdscdJE7X1cw4k6eXjFfVka8Vuu5MfKe0PPhAyxRhJUkTVM0h/+u?=
 =?us-ascii?Q?i5Ctsim7/3mLdkFplrJg8+NLKUJuLMPchrcDGjwwEbi/eg4LgyjdA8wMORyn?=
 =?us-ascii?Q?7Ui/qpplwVjV4N796M1647E8B3CHqBRog3IAp+L4WmkQ1V0j0uxo9kSE5RqW?=
 =?us-ascii?Q?aR6rRfaJ5EeUxaJpPMIVatTceQ2PTrj0Qlaz1VmApFvq0D1if5Cc73Mv/KjD?=
 =?us-ascii?Q?aPk5NgPPwKpWc4Mx0N9ISK9UMNt/U0xHAn2r0rZSSoK3olwuDtlR/LBTS/n8?=
 =?us-ascii?Q?huCPt6M6ZqOi1o9drQxJl8Xm7A3lHALWYNTtUbqgzPA4NaSJgpUevVulaevH?=
 =?us-ascii?Q?MvdGXztAhXBBH/UDj/28CfmGFwHszP8TXZ6y1/te6R+o98nvLIzMbfTuvATU?=
 =?us-ascii?Q?liqzqDnxZzt9ePoEfX9n8+CsjRvwb8neWlNdUuuXH5y/VhNa2VmJ1c5G8avZ?=
 =?us-ascii?Q?lOtQRQY4QsVO631lyJm0Bu3YCgloO5pZU6C7WWiGCJ+rwNV2bhgHeYlX9pXy?=
 =?us-ascii?Q?1HfBvTH1SyyQrX28JMbu7PZjnvMCP31iL7G4UWOinyrfwpKpbCP0c9pwZcTj?=
 =?us-ascii?Q?MNSn1WfQ3TuqQu5hN/79PWG+gCBmUQMZ4zTeETDfAFlu6tOSdRSzMElOdsXS?=
 =?us-ascii?Q?rBewiV1UfL69Irj057ad0viqbDokeorD8J8nBPay?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bcbc0c1-86ef-4403-c252-08ddff635690
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2025 14:20:27.7366
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pjh/XGr6GCwU1sukLhPL1mUkS8hIJguhXv1rkFjx0vuBLSyl+TZefIn3/DKE15IStqklUYEckzswuW7/Uuu85w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6374

Hi Greg,

On Mon, Sep 29, 2025 at 01:40:52PM +0200, gregkh@linuxfoundation.org wrote:
> 
> The patch below does not apply to the 6.16-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
> 
> To reproduce the conflict and resubmit, you may use the following commands:
> 
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.16.y
> git checkout FETCH_HEAD
> git cherry-pick -x 55ed11b181c43d81ce03b50209e4e7c4a14ba099
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025092952-wooing-result-72e9@gregkh' --subject-prefix 'PATCH 6.16.y' HEAD^..
> 
> Possible dependencies:

This patch depends on upstream commit 353656eb84fe ("sched_ext: Make
scx_idle_cpu() and related helpers static").

To resolve the conflict I think the best would be to apply commit
353656eb84fef ("sched_ext: idle: Make local functions static in
ext_idle.c") to 6.16-stable as well.

This commit only makes some functions static (no functional changes), so it
should be safe for stable and it'd keep the code more aligned with
upstream.

Thanks,
-Andrea

> 
> 
> 
> thanks,
> 
> greg k-h
> 
> ------------------ original commit in Linus's tree ------------------
> 
> From 55ed11b181c43d81ce03b50209e4e7c4a14ba099 Mon Sep 17 00:00:00 2001
> From: Andrea Righi <arighi@nvidia.com>
> Date: Sat, 20 Sep 2025 15:26:21 +0200
> Subject: [PATCH] sched_ext: idle: Handle migration-disabled tasks in BPF code
> 
> When scx_bpf_select_cpu_dfl()/and() kfuncs are invoked outside of
> ops.select_cpu() we can't rely on @p->migration_disabled to determine if
> migration is disabled for the task @p.
> 
> In fact, migration is always disabled for the current task while running
> BPF code: __bpf_prog_enter() disables migration and __bpf_prog_exit()
> re-enables it.
> 
> To handle this, when @p->migration_disabled == 1, check whether @p is
> the current task. If so, migration was not disabled before entering the
> callback, otherwise migration was disabled.
> 
> This ensures correct idle CPU selection in all cases. The behavior of
> ops.select_cpu() remains unchanged, because this callback is never
> invoked for the current task and migration-disabled tasks are always
> excluded.
> 
> Example: without this change scx_bpf_select_cpu_and() called from
> ops.enqueue() always returns -EBUSY; with this change applied, it
> correctly returns idle CPUs.
> 
> Fixes: 06efc9fe0b8de ("sched_ext: idle: Handle migration-disabled tasks in idle selection")
> Cc: stable@vger.kernel.org # v6.16+
> Signed-off-by: Andrea Righi <arighi@nvidia.com>
> Acked-by: Changwoo Min <changwoo@igalia.com>
> Signed-off-by: Tejun Heo <tj@kernel.org>
> 
> diff --git a/kernel/sched/ext_idle.c b/kernel/sched/ext_idle.c
> index 7174e1c1a392..537c6992bb63 100644
> --- a/kernel/sched/ext_idle.c
> +++ b/kernel/sched/ext_idle.c
> @@ -856,6 +856,32 @@ static bool check_builtin_idle_enabled(void)
>  	return false;
>  }
>  
> +/*
> + * Determine whether @p is a migration-disabled task in the context of BPF
> + * code.
> + *
> + * We can't simply check whether @p->migration_disabled is set in a
> + * sched_ext callback, because migration is always disabled for the current
> + * task while running BPF code.
> + *
> + * The prolog (__bpf_prog_enter) and epilog (__bpf_prog_exit) respectively
> + * disable and re-enable migration. For this reason, the current task
> + * inside a sched_ext callback is always a migration-disabled task.
> + *
> + * Therefore, when @p->migration_disabled == 1, check whether @p is the
> + * current task or not: if it is, then migration was not disabled before
> + * entering the callback, otherwise migration was disabled.
> + *
> + * Returns true if @p is migration-disabled, false otherwise.
> + */
> +static bool is_bpf_migration_disabled(const struct task_struct *p)
> +{
> +	if (p->migration_disabled == 1)
> +		return p != current;
> +	else
> +		return p->migration_disabled;
> +}
> +
>  static s32 select_cpu_from_kfunc(struct task_struct *p, s32 prev_cpu, u64 wake_flags,
>  				 const struct cpumask *allowed, u64 flags)
>  {
> @@ -898,7 +924,7 @@ static s32 select_cpu_from_kfunc(struct task_struct *p, s32 prev_cpu, u64 wake_f
>  	 * selection optimizations and simply check whether the previously
>  	 * used CPU is idle and within the allowed cpumask.
>  	 */
> -	if (p->nr_cpus_allowed == 1 || is_migration_disabled(p)) {
> +	if (p->nr_cpus_allowed == 1 || is_bpf_migration_disabled(p)) {
>  		if (cpumask_test_cpu(prev_cpu, allowed ?: p->cpus_ptr) &&
>  		    scx_idle_test_and_clear_cpu(prev_cpu))
>  			cpu = prev_cpu;
> 

