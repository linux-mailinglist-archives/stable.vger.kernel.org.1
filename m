Return-Path: <stable+bounces-124542-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 637AFA6361D
	for <lists+stable@lfdr.de>; Sun, 16 Mar 2025 15:40:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A25F816F589
	for <lists+stable@lfdr.de>; Sun, 16 Mar 2025 14:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B4CB1A9B28;
	Sun, 16 Mar 2025 14:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DeIvi/qF"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2087.outbound.protection.outlook.com [40.107.244.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81086634EC;
	Sun, 16 Mar 2025 14:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742136002; cv=fail; b=Ia4McFK1Cg1XiqjFP6Ma3nwjah0lMCMKs1ZuYf6erW8jHMAyORhRRgwmnseUKXw6iq64YsnoyyTVEJm+B/tA5iiQb7EwkgtIv6VQ6y1xWHz33gHmh0aO3fB3bp1+WjrUemftr5tn5rBsKZIG+M+XWvtEh2RstXYnUllGKwnT20s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742136002; c=relaxed/simple;
	bh=/uiOPbmJN7Wt3LWkSS58zkGWrgc8k4LL6MQNtdJWELk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Xt90p1IUUjwDgg6pnJPBnVirj2k4jxKMMkHaZXghadXJSIAwjrtUFyPAzJiHCkZvWew8/3FBA8UTJJRmHT8HxsoEsu0GRCdchkB/HH2aCNJLsFBzgjILhLkXnZRVx2My+mMiG/c2wRpDzLnZHbjigK3Ap/2cOsB52FCu8PYRh6Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DeIvi/qF; arc=fail smtp.client-ip=40.107.244.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Exd092VBXPqVX/fdIPG0daZCrgAXTzr78UhynRB1wHs0PJthykt0Q6LS5hIN2Lfspv6O1trXordYhOYbKdjnk4NRa0uOcqyb9bxANq1pCwOtBEPyFRox1O4wWkzwQAVae51jUwvi+SZdOSBcWCdq7k7S+9BIGiE6dZhbn3X5HkP74SE0hU6AQnewpSLj72VGCimck0xvbGS3XanYbApOhWWS6Pye8273V1IfnAoLs89iezBDMNFBBiZv5ZvRbdeFFpL9j9jdfEx/q4hG2wAbfLUQ9UAQoAZG+iL64PpCvRFtbLI95/dkN7/e6mYv7j7V1yhy7CTsSfAjgvDSwLO/8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ecwIji//Vb8mR/25sQpl3jTUwtA0Jt6Jgv+SHxigOU4=;
 b=yQrh8cUZoAGl64ok6RYxiFTtnAWInk65tDeEsJ8cBsCxN6XeR3NsoTVoBIR+MCx0NJ9cvFwMv4XHmBnhGoNC8z7uOwB0jR/SDwwWGJ7C00BoOXvIPc9thSjh3iAI7mXs3VUNBxQ1QLMqjPwFLwEjvjeMRfC588Rzzovi5ebGC35KZURrN0rgejj8LJEZT+s00kXNF/8W3mNrGKZyTRsKRlQRXzTzW3uH/Td1cUY7QYUaaBgHr9s0l8pV3MZY0nYholmvg0LuqUj/Hup9tFkFr04zBsZmv7GuYbtB3qN8Vglnja/0t1dome5ur8ed2DCIHwJIkaoBcLSBOmjhVAtvNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ecwIji//Vb8mR/25sQpl3jTUwtA0Jt6Jgv+SHxigOU4=;
 b=DeIvi/qF2myinjNiWc9j2F0pUxgGegh/MgtrLB/069jnKxT7Kvju+eUsf9LN8B13SasrCMdat/dHteCyGVHbR+91S4e4BjXEMlpliR6y1GTPE3T2bvR1MY/K70ugs0I4iAbJ+8AH4GejDRboayYGNyDykU+Jfi/hFfHgrd28VlpTV/iqMAlntbMqvc9r1QMBjsQcUBvH33Vf8Dq9T/+0z0LCa4hCj/3v0OnAVWRfrt1TR6+u9IMg1f/kHl0NzL+v7n297N/8Qy5ugETmVLkCKQWz5y4dm9VdDkyn5f9/4DINIqdd/+BNdKY1VeCAlYzNpPESXGoyfVyGtZ5iqmLcrw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by SA1PR12MB6869.namprd12.prod.outlook.com (2603:10b6:806:25d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Sun, 16 Mar
 2025 14:39:57 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%4]) with mapi id 15.20.8534.031; Sun, 16 Mar 2025
 14:39:57 +0000
Date: Sun, 16 Mar 2025 10:39:55 -0400
From: Joel Fernandes <joelagnelf@nvidia.com>
To: Juri Lelli <juri.lelli@redhat.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>, stable@vger.kernel.org,
	"Paul E . McKenney" <paulmck@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] sched/fair: Disable DL server on
 rcu_torture_disable_rt_throttle()
Message-ID: <20250316143955.GA2815370@joelnvbox>
References: <20250306011014.2926917-1-joelagnelf@nvidia.com>
 <Z8lsX0GDrx7Pa8vd@jlelli-thinkpadt14gen4.remote.csb>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8lsX0GDrx7Pa8vd@jlelli-thinkpadt14gen4.remote.csb>
X-ClientProxiedBy: IA1P220CA0006.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:461::11) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|SA1PR12MB6869:EE_
X-MS-Office365-Filtering-Correlation-Id: afdda8d5-e131-4c30-5cd5-08dd64986c7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?A458nzDVYbyd3qsCBNdQA7cmsu+Jz2gUk3p9CldduHJQlr+EPO8xRMOBMnpW?=
 =?us-ascii?Q?AbBlq5tioxvDDSufLq9qmUnlKwk1m/ajIV/GU860wlDEouxucyyjdiHhceYU?=
 =?us-ascii?Q?i95Zb9i/1OJuRA17Y3J0ZYoB2BqhyLl1gyty1T4ElTMi4ry7TEm4RTNpkwve?=
 =?us-ascii?Q?pP2NYpK/+RYsS2ai4RsktD2COCCf5aVJDQ9FMaw6f7Hti/jZekbe8Q5ef4l7?=
 =?us-ascii?Q?l28TM/TiD5Fh1B7XqXv30ycV/gjNQ9vHMzqufi/2/x0r7Q8QQSqYzi19fBeO?=
 =?us-ascii?Q?ZB6t2r5iBRdJcdKWnqfZMr9wxWq93oSWtkxVWvk7Qcj5Tz+7i78wo04bNCyF?=
 =?us-ascii?Q?DUbJaGGsKngvA/69siwpyUNtrxhsB+nX1Eh/2xP0bcNn0uFFITfHlxCg8MVe?=
 =?us-ascii?Q?KuJZm6yGFQXNLF08zyHcI+8ppbe4LIUB+zMr7Cq7rvXrJWvFJ3QqkMBvlKok?=
 =?us-ascii?Q?q4qyzyxdPyIx0l4qxEMKrCgCQ9mm6J6ljacJpXroeX7caP3WRUbUdWx+DARK?=
 =?us-ascii?Q?Z4UBVwADQhk5/bith/bl/l4Eb9yIO0Ea14QZWg5Lj2kQdLuXSwY9z6HToRFk?=
 =?us-ascii?Q?1vsM0YPuGNTv7qZ76GC507VUTze9aIOpfwsRjj+OgaD30LbGzujsfweb7R4+?=
 =?us-ascii?Q?avVjK97b+k6yIVeubEtQLdDLVRkP6NaXiVeU1EfW6mbyvaFXol8jGS6s+Tjc?=
 =?us-ascii?Q?YjLEZFhm3vCt4h9WhfFdxGPgYXo1x11fEO5Dx+loJL/8aWo0V5/Zz0vQCgq1?=
 =?us-ascii?Q?Dt14JpR/bswvW6N6Qqj2kUAJKbPwH5OqjLPcMFWoOd4RsziTPnKPLYfH0aO9?=
 =?us-ascii?Q?7uuULSP5avgpk0WP0qY7Irr12UK4er44UczumpnZuLscGtL1cJUxqx5njaeW?=
 =?us-ascii?Q?xaHHc9oouqUcoMd/J+RRygshCnu/DRgp994EOgWe/qCDdVniJRXKvuzhKqPk?=
 =?us-ascii?Q?o/7C0ARWunWio90LPNXLF9VUVRopnwP2/hTZ02jorBgEAwqw5a7XbiDbxtBq?=
 =?us-ascii?Q?eT4+lD7ISjS2hpm+0zQQzyGxAlFFqd0gJOzdSQK+Z3SPiHtb0NoWF6c0T+Vv?=
 =?us-ascii?Q?roYcGLgd6L7UpFKDO7oTa8TGg1d77uMlscFWJCDVMjpvmkaQjlYFbI1kbPuE?=
 =?us-ascii?Q?jQvhBax2I0x8L9aQollJ8pF3gBeR1zUCDZRLjzSgjBRKoRjZMqbKpTCWzfDW?=
 =?us-ascii?Q?cyioo9s7XT1TJo5IngtZ+1yHL+LSlMudtJA+jI7TvgTOJIF2wPfvxXZO1IIv?=
 =?us-ascii?Q?DKzreQtWZ/JJF7Su0lmfK5Y7Ho6oapEINCNllnB9axMWHcj6Gq6btygO+h0u?=
 =?us-ascii?Q?BDzMqHXmeT9osq0DU9Z4nMk5vYbwrMQSQiDaYSxP/6rKwcrEnXp3Usf2ws+6?=
 =?us-ascii?Q?hByUeCA68QOHshHEJ7JnqNMjKImu?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vj8/1sITvy++VarSVLd6saBap3CnAC+rUGkypNWama86Yvug9aJQvQc57ZSe?=
 =?us-ascii?Q?iNJr5B2CVV8jjP+9l6sUkVzMfHU0medw6s1aBCwCV1MXR4RCMpE6gTAIHjzV?=
 =?us-ascii?Q?5KrDunwkUDPZG0Gf959U2zdhTcvuzwXeVSA6lVBodeBvQZaf5dirJ2TP1xEr?=
 =?us-ascii?Q?F5u9GTUlFXIUzCSJhDAiYndFxhkdwumiubpt/dLQ7KaK8ukXDN67sB3jStwh?=
 =?us-ascii?Q?raYNePNTz99YCsKmqw+t9zywP8mYkxF2Ii2VsqkiWanTz3xMBaBbID4weGXF?=
 =?us-ascii?Q?ICKpDbfX/NN9xrl1hbiw7nFt9DsV4/dQVWDSgQ+FmOKYZ/o+Hr2+IcXSgMTn?=
 =?us-ascii?Q?Fef58vmvwgWHRavwRcyuC30Ad0F8yG6Ml3bIoxMrPpScbULWnMhcK8Odo76T?=
 =?us-ascii?Q?DX/lQcFYtfMvcxhZ5r8ZZabf8sLEWNTsB8vVC61O+MBDGAXOe/sqBnZowm5H?=
 =?us-ascii?Q?56mWBNaYqswfcg+HkK3AJTvuihqBWWf7VpRuLwHkGQmIH2KTKlQp9dx2VdjY?=
 =?us-ascii?Q?eift6P3KSgp9r8Xh6eR7XcNA6osy2eDf5x0KYPQoCAVGjJCYHNdtk1+b0RIU?=
 =?us-ascii?Q?z7CyuKos72WMCMAfO7DA9P7nDc9LapvTqGx4gLtQl7y+yzdp7hdDDgyowOTS?=
 =?us-ascii?Q?Erqs5b4cbpMueUdzyzCnztLM9PlruDgD4MS2RpA3QrpZGLZKNsmV4Ze4ahqx?=
 =?us-ascii?Q?0WFzTFWxzqePqYFUIXj907dKjIQ6Stxb7nLMEfIBBE2qyVv2Dvnh8aYYxCXI?=
 =?us-ascii?Q?xugGCDDeDeemFhGE6pnK+mEMlvVs5tgLngr0dpaJTjKOESWTMgnKWftgJqrl?=
 =?us-ascii?Q?BWo+AwKcZK0A1kmwGRkEE/45E7bqj4QeKDIpBNCT5igzqDN729Vbvj+wwubm?=
 =?us-ascii?Q?ODXr+V7UFytv/gBYfpB+ooNhz9HXtot0oWEKlUsYgoB//FR5u3UWbIxNcd9T?=
 =?us-ascii?Q?KWnKGWJlbJ3OEHh4V0CUxqRuxzTmu1bUxIBQdqPxHRobMtzQwmoc9ZPr83F8?=
 =?us-ascii?Q?mtQd0ZA3TpvvlFpNxO3rUzjFnF3sXCkG5DpqEOHElc/HHjTTCoj1MsGqs+In?=
 =?us-ascii?Q?06EFvaZ4f7I1/jtmZ5JjMDkd9ugzcTxO1I1NywLoOJhLlkIdabqagxkwcNQg?=
 =?us-ascii?Q?tZe7Ip/IW5Q0NPihamYSnQ3OOKQjjXoU+43w1QmGwPYZFryXd571qYsE28cD?=
 =?us-ascii?Q?tfTqDMYVL3DO6+redU5Z8ylRVjNrmYAQBeNwY7h0btq7UET6f7dWki7Pujqy?=
 =?us-ascii?Q?ru7iUUSMYtJSmuvmOrqb6jWnbGOeXqf7EkDGhdzR8VrY4shUfmAzoBHjaZQk?=
 =?us-ascii?Q?GJFS7l8U74ArZOSlTomFiuuWD4Pae1Xw4Y2WComa0S6gmZryqHfu6ad/Or8u?=
 =?us-ascii?Q?sjj6yz9lBot4mMeByqoHJsPyliOFw79A/NdcDM/nhPMBPKq93zJNsOrveat7?=
 =?us-ascii?Q?XniOVwxreDTBZGZg/KAXZzvJPPnhsBTUl55iMLH4Lz5/87SPC5yYszr8D2nv?=
 =?us-ascii?Q?pBGFMhEJo8m/GCGY3gOlSweGWa26JTPb1JFzK9FnfLY+/okHGw8gMJSvVjVk?=
 =?us-ascii?Q?v9K6S3qeIRS2CqrOtlF8KdJA+/uwseGkSUOk3zzQ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afdda8d5-e131-4c30-5cd5-08dd64986c7e
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2025 14:39:57.5648
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OZ6gRmKwwjPjFb6R/HH9Ef/TdAzdyfQEuHIF468o48YGRns6EdByqgWcYgPZ61Li/jjlanoEXoM8jCLuSWGXfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6869

On Thu, Mar 06, 2025 at 09:35:27AM +0000, Juri Lelli wrote:
> Hi Joel,
> 
> On 05/03/25 20:10, Joel Fernandes wrote:
> > Currently, RCU boost testing in rcutorture is broken because it relies on
> > having RT throttling disabled. This means the test will always pass (or
> > rarely fail). This occurs because recently, RT throttling was replaced
> > by DL server which boosts CFS tasks even when rcutorture tried to
> > disable throttling (see rcu_torture_disable_rt_throttle()). However, the
> > systctl_sched_rt_runtime variable is not considered thus still allowing
> > RT tasks to be preempted by CFS tasks.
> > 
> > Therefore this patch prevents DL server from starting when RCU torture
> > sets the sysctl_sched_rt_runtime to -1.
> > 
> > With this patch, boosting in TREE09 fails reliably if RCU_BOOST=n.
> > 
> > Steven also mentioned that this could fix RT usecases where users do not
> > want DL server to be interfering.
> > 
> > Cc: stable@vger.kernel.org
> > Cc: Paul E. McKenney <paulmck@kernel.org>
> > Cc: Steven Rostedt <rostedt@goodmis.org>
> > Fixes: cea5a3472ac4 ("sched/fair: Cleanup fair_server")
> > Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
> > ---
> > v1->v2:
> > 	Updated Fixes tag (Steven)
> > 	Moved the stoppage of DL server to fair (Juri)
> 
> I think what I suggested/wondered (sorry if I wasn't clear) is that we
> might need a link between sched_rt_runtime and the fair_server per-cpu
> runtime under sched/debug (i.e., sched_fair_write(), etc), otherwise one
> can end up with DL server disabled and still non zero runtime on the
> debug interface. This is only if we want to make that link, though;
> which I am not entirely sure it is something we want to do, as we will
> be stuck with an old/legacy interface if we do. Peter?


While we are discussing, would it be acceptable to provide a sysctl that
disabled DL server? We could set this via boot parameters in rcutorture. That
would unblock the testing. If feel that is OK to do considering another
sysctl systctl_sched_rt_runtime is already there to disable RT throttling,
so we are just adding a similar one for DL server. What do you think?

thanks,

 - Joel


