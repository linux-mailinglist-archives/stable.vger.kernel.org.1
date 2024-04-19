Return-Path: <stable+bounces-40314-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B13EE8AB4B4
	for <lists+stable@lfdr.de>; Fri, 19 Apr 2024 20:04:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D50E11C21DE2
	for <lists+stable@lfdr.de>; Fri, 19 Apr 2024 18:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D269413B297;
	Fri, 19 Apr 2024 18:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rNbjP+XE"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2053.outbound.protection.outlook.com [40.107.236.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F59E13AD28;
	Fri, 19 Apr 2024 18:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713549836; cv=fail; b=JfgpoYOU9rkWq8cK9Ti6UkZgXMjT1A+VyHOL4gLF3lUYQ09kXHL1xan++xzBbMDT0DzNh9LHAOk7BGuFDrs/plc+AOwz8mj4YsrXRtEvPWEPPGlE+d24oe1KXRd1sJ9AYrl22QTzAeitrXcPcqfxoDmEKDM8bcGiJeRvY8p6K4s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713549836; c=relaxed/simple;
	bh=j+i7GjWwjfw0XJyRi5Q2GlEaOvK9JlzdvmBaCHeMsEk=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 Content-Type:MIME-Version; b=O94KHr60SbUwcPPIXyMa1Uv4IzlT9df4jfC2FrqFWJUzlEcf0aveEuyQsZWMozNGO52EvHPTfeAJMHPUNtrHjXrXygWmvb9g0pZlp0EeCqqkpnvxEMy6Yru0BbQIVY5Rt6sv7N1yP+KEZ0I3wEB+byRTGgOFjdBMk+dmdIAG9KY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rNbjP+XE; arc=fail smtp.client-ip=40.107.236.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RcQhIXa8V194tGCFim+hNGnSheLwuBvPrxNh3qccxK4CdwLcGg3kfxvdwsf1najikcwvo1EaMiwzKyBw6l9EDzN+GjrcO89SLtE50ytxveKSMWyNOPn9YsU2oHB/NmPPdL8GHWjC2Ml7DRkzcq1dwLlJQvrcbtVXnu/EgBX05y8B3uimTGvuw+SUF+iDg/CAvlPi4X27A0JcDXxahx/yvMxBMhJfCeiNTA/Kevmuyp6B8jz/4qx5gJ2k5voAbkZt1AdEMD2AZiQ9BspKZcjy2P7qTmHd0rD+TBKh1UdFnIgUNewNxZyxdwuP6lQDL0WNZqhZ++yMC8APICfI3xWxtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DiWB7gzd1yi18Ib5jDj/p/4qp92KHmvD0IfOYxC6XA8=;
 b=oaNgiFfwZtZBn7+LAg3Zp9iwYeJZZGZq9Wijsu4G+vRL98rEKR/rR/b1jgtbbXwlJ+ki6oRQIa2OsrfQSxsuRmohdNraWR0ghICV7x9QU3hJRKm/NIBiETh8cxpcqr3IUgVaml2eI2Au/ZmXGI43UiCmOBM8K8pId7Hu5HtIkFo/kR55666Yij39qQdI0OGVnr/JnsCttnO9PQUCcJTIWFpRkkp3DCijc/NduDo5trgqtzDXIokaz9Lj1SxQ7ZWHx4HH+8PQyf9DLFCeJL8sOdoZ2MomR4dBIklV955Rr7CaluRFU1TiPo8tiEE//iz1aROfuTDtW59nQMBP0KTi9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DiWB7gzd1yi18Ib5jDj/p/4qp92KHmvD0IfOYxC6XA8=;
 b=rNbjP+XE8uepBv9p8W6fJCgPQm+qmV5rMo9oLwpC7R4brb/2bU3IfA5ZSaZOmD2Zgv3lwqUEgVkz6w0JXZBuEUv7HhNAWdN/ngSxwlB0uQboJcNLy8CSeaoAvmSR2VaYzsb6Rlr/Z1/QJwSK0pmT1OB6BpAkyUAKWJbI4EWZdh+8LFehCsFXFwxcBDSldZJaK9du0OwJBFSwRCFebZ90+uFowPdltBcQRCiA97+xcsTn6Qw/mJf3EISS4zqBqZHmbNCr2fVCmE8ztrG+j7ktz4zRlcJGrU6hR4dNE0+IXiaAcoTCxC1tcSvJv8Vr6jlj2ZrJ/eDLJ0WDHYZ6cmaO6Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by DS0PR12MB6656.namprd12.prod.outlook.com (2603:10b6:8:d2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.41; Fri, 19 Apr
 2024 18:03:50 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::3ec0:1215:f4ed:9535]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::3ec0:1215:f4ed:9535%4]) with mapi id 15.20.7472.044; Fri, 19 Apr 2024
 18:03:50 +0000
References: <20240419011740.333714-1-rrameshbabu@nvidia.com>
 <20240419011740.333714-3-rrameshbabu@nvidia.com> <ZiKIUC6bTCDhlnRw@hog>
User-agent: mu4e 1.10.8; emacs 28.2
From: Rahul Rameshbabu <rrameshbabu@nvidia.com>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org, Jakub Kicinski
 <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, "David S. Miller"
 <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, Gal Pressman
 <gal@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, Yossi Kuperman
 <yossiku@nvidia.com>, Benjamin Poirier <bpoirier@nvidia.com>, Cosmin Ratiu
 <cratiu@nvidia.com>
Subject: Re: [PATCH net-next 2/3] macsec: Detect if Rx skb is macsec-related
 for offloading devices that update md_dst
Date: Fri, 19 Apr 2024 11:01:20 -0700
In-reply-to: <ZiKIUC6bTCDhlnRw@hog>
Message-ID: <87mspp6xh7.fsf@nvidia.com>
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0181.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::6) To BYAPR12MB2743.namprd12.prod.outlook.com
 (2603:10b6:a03:61::28)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|DS0PR12MB6656:EE_
X-MS-Office365-Filtering-Correlation-Id: a5c0c49c-445a-424d-b46b-08dc609b10e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HlW49ZGZ8tyR5Wzj0EP3sK5v7Es/3NxuqebiwDSCMa8f46+SWjM0aIM3qLZ1?=
 =?us-ascii?Q?9IqWfKAcDPmglfCwfXmsTjGmdGh0dbxFfN8jiu4LcOoZb9btqFhJu0BPuO+U?=
 =?us-ascii?Q?M/P/VlJ1n+wavuqwKQrr7hLgRgyMIgps6HUH4CwcM5kMrIAvzo/R7866efSo?=
 =?us-ascii?Q?6WKTBne/G0zE+g93OZfOy79Y4zza/lEWvzEPqQruqDETsgTp4t5AwZ761+h+?=
 =?us-ascii?Q?tgmNphfwZlfmh/0SNXePILJyBSiosjNlfaeLDlc0zzjmn2lM/mecU0mi/OBV?=
 =?us-ascii?Q?K5i7n7CLOkuuA1VDqWFgC0VrzqjO/Kl4gkX55FWhir6axFp7qEYDd3Z4csQZ?=
 =?us-ascii?Q?4r9sTsjudCO2BUn9ASZrK1rNZe+4WHqnQZQG6pLDSuTBnUXem4JxFozyPl+J?=
 =?us-ascii?Q?7thzVJlgL7qeco3jDLGW9z5u8MkC+fk+A8cpEZyD1DOvSWFY3e3+4as+LeyN?=
 =?us-ascii?Q?t+XUUxloEN0suqwKUXMputgS/zDqXv6LKku5RceIcWZP7g4+dwdkxwUgJmaH?=
 =?us-ascii?Q?ani7Fta/vzFt/IeVMAfZ4OdFbREh8rYmfTUNskGI7gs1oMfRLdpLdDzZKkv9?=
 =?us-ascii?Q?bS9aATIuArmPkLxDo6Yo+gyauclDkWKboKDU8y9+kzVT2n+9rVEVoRdK2aUi?=
 =?us-ascii?Q?y/CYm1pUFoiWEASKjwnN47IiBuKRwN+U5icAwRq8fuDH2FknurA6TKfxXWPk?=
 =?us-ascii?Q?cG9P2Y8+fU0jshN00zd9iORrfOLazP7XFD37eZdzvYjGt59KT8aUYAj8Y8CK?=
 =?us-ascii?Q?6Ffh7BC04wm37WWltkY9JOi4JIJTSDV1ZtPXWj1e8csm7kQnHS2JUCq46ma6?=
 =?us-ascii?Q?cxiWHvU7oM+/ahfM3hMnNaguPhypMqZD8LpoUT3Jo5UA/xMjW37NbbUYS19B?=
 =?us-ascii?Q?G36Q2rSzrOY+TN5LuGmIwsGsOEUBmbNXsreipEnEjpHHkG86Xj7yqBvPLEYe?=
 =?us-ascii?Q?n7L7s+5IPoyP0GgUdaoxycqhUzlyUfAPhaC2EUsmHmP+NHW6Cg6/u5pk/TeF?=
 =?us-ascii?Q?ETCWPjBkEuqDZ+K3BQfXYRD5ymcNScVFBipTLAuHS1X/A07K47u/kXKVJk+z?=
 =?us-ascii?Q?h1SEuNgpcb8Kg118NCdn1FfC5R5LzZcYkTdCOaVNNKbVsKKRhEJRAsfT5pyU?=
 =?us-ascii?Q?JHfkl+uP2mJHOPXEqrO+qSwTNrasZJlWGRYSCB+29xHqjqJMr8FrpXKnDD/O?=
 =?us-ascii?Q?WrcdgsceO07ZVIMn8fjsaBW6thV3dMwXR8s8xySTejKzII1sqaW52dQEwcLR?=
 =?us-ascii?Q?W4llWtJas1vRGdCo+IwJcDgNr8DNQuo2uPOzf1f4EA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QdYZmGYM1o+q+4DGnpRYVzIxKyAhkb627tac3Bsi7twWxxutYQPN9cPq2TiT?=
 =?us-ascii?Q?LS2Gl/7wgduvA5PhjsqZZitrO/ubmYemU+VPQoXx+kO/n3sMCWQFomXzJcmQ?=
 =?us-ascii?Q?mCiHvX1W2VqNbx0WYEZozL70KAcwYl23m1acChqLbcjcfNaCoDLCdTCthHiq?=
 =?us-ascii?Q?MsaktWLABwrwafL2ZeZ2UHuKNTXPLgWw9JowVgLDCSdfENMsuA2oS0FaQUNU?=
 =?us-ascii?Q?uqGLxMGpOMlQJPg/dcCc/RtvzIRe+xIc/feMOgSMqjV8sBAKC8L3UtrJZsSN?=
 =?us-ascii?Q?aMNOxDgiBWKJwGoLi2W9fmCDz/jgornLNkGgo2xlMIfs72+PshLBuOxlK684?=
 =?us-ascii?Q?qVjfNuc8X4vPOZdZQRdJgaVXIDIxsVEv8n+ARHTE2Z5/F70x0z/jooB0l1hy?=
 =?us-ascii?Q?oJO2kIUpAMjukUM2FvhUUpPPoj8tINXinMn10TSIrXPwFqzQRDJM3ZUJMLE9?=
 =?us-ascii?Q?ZJX6170pg7toqcqRsj1rg54zp9QlqBkS5UpoLB71KPmRt5FZR2X7aZoOMVnI?=
 =?us-ascii?Q?y/Zq9WVg8TtfAE+GP43wQtdWlxVFt71irjHeKW9u2oHJghB3JhMvxmNObvYU?=
 =?us-ascii?Q?ElWDl5NcqOkVTH+AdYKAbJBjgZz3PP7BcbeEo7ZfK7a/NEMfdn9zb060t0Of?=
 =?us-ascii?Q?6U7+gwC5zk3aBOy/VZanXUhTkMogIvwSFqNl4/JN7Gn7xq5MoRUSQsweQBX1?=
 =?us-ascii?Q?dDRznqcZUJHv5yxq6UwzmSiIHMasIpFJqHjf7ApVlgMgCr6QKBFoJwb+lPEo?=
 =?us-ascii?Q?TIVYeRC8B/SGwHNXv04Gl9te5WhZA65nEwsv3R/uTWQ7n1WoEbO3DBp5UOYv?=
 =?us-ascii?Q?0bWLXkCqsGG3nXngIizQ0obuHGODcUZjc4k1E7ydQq9KxXog2jeSslFEPWQW?=
 =?us-ascii?Q?rtQMg2VpjKzK+VATZfzpC/ehx4vx07XGv6J/V+587xJJ/oR681fTsCxoakqm?=
 =?us-ascii?Q?4bzSClgBZixTb9Sb/t5EZdfiWNJ4kgA2upmJDtVJv/QcBq4ZRQ05gVWi5v18?=
 =?us-ascii?Q?tHMbSoDy8q/yY9vfj2wxCCezbQF7CFE1eaKd7fDnnRJehT3XS17FKwWik3si?=
 =?us-ascii?Q?Tr1jCRw8fex1Y5zRL8fgFoGTPcupk8jdT8yMH5eDU12wuBLPuT7vp7ksczYU?=
 =?us-ascii?Q?NkNsgARNqtGAcOEj7vhXfxwGAyRnwfI0V7oNKGybpNGQUfMIi72k+AVvZd1Q?=
 =?us-ascii?Q?d4gCqXrKNM7enoxPS97XT8kg1qpJCvi8SqAAbrzeAYJilmdmDgVdO5mQa/Qi?=
 =?us-ascii?Q?QOqvrH5GUVUSZH9IpevIzv43NspIIEa/Ul0HSGJ+8m+MVh/Go4v1sIfYeuai?=
 =?us-ascii?Q?VpWJ9JEvusvKK8WwK6M0TXBKBz3slDwcgJaaJPTrkyc7FDV2wjQMjJxk5ElP?=
 =?us-ascii?Q?AzbRQacd5xtfiv93ya0tKF/yjcE4+3DSxfoRF83UIwOLRwDNNLGc6mgVQCZ1?=
 =?us-ascii?Q?QXuWrRb2+47n7k5VQO41yVb9I3m7OOqnaJ5vnyFGyz1VIoeGGoyzKJN1E/fO?=
 =?us-ascii?Q?Np8wNuFzRHQwCqwCZ5lKVOfmLjrgAl8nn9Qu4EDmYWJd07q4EliSl38LOymL?=
 =?us-ascii?Q?OwyAsl5An9dYo3sXljYRA3OQCwTo/wkwCdz1CXOeXdNU1u0MItB27zfUs0Gy?=
 =?us-ascii?Q?wQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5c0c49c-445a-424d-b46b-08dc609b10e3
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2024 18:03:50.0749
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f55yDGu9qML+DPR7Oh040vfRvfk/jji0dIQt6M90onmkyzdSVpm19zOZdZQSaQPsQgGJ3Id7Q4FN9d0E5yyvlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6656

On Fri, 19 Apr, 2024 17:05:52 +0200 Sabrina Dubroca <sd@queasysnail.net> wrote:
> 2024-04-18, 18:17:16 -0700, Rahul Rameshbabu wrote:
<snip>
>> +			/* This datapath is insecure because it is unable to
>> +			 * enforce isolation of broadcast/multicast traffic and
>> +			 * unicast traffic with promiscuous mode on the macsec
>> +			 * netdev. Since the core stack has no mechanism to
>> +			 * check that the hardware did indeed receive MACsec
>> +			 * traffic, it is possible that the response handling
>> +			 * done by the MACsec port was to a plaintext packet.
>> +			 * This violates the MACsec protocol standard.
>> +			 */
>> +			DEBUG_NET_WARN_ON_ONCE(true);
>
> If you insist on this warning (and I'm not convinced it's useful,
> since if the HW is already built and cannot inform the driver, there's
> nothing the driver implementer can do), I would move it somewhere into
> the config path. macsec_update_offload would be a better location for
> this kind of warning (maybe with a pr_warn (not limited to debug
> configs) saying something like "MACsec offload on devices that don't
> support md_dst are insecure: they do not provide proper isolation of
> traffic"). The comment can stay here.
>

I do not like the warning either. I left it mainly if it needed further
discussion on the mailing list. Will remove it in my next revision. That
said, it may make sense to advertise rx_uses_md_dst over netlink to
annotate what macsec offload path a device uses? Just throwing out an
idea here.

>>  			if (ether_addr_equal_64bits(hdr->h_dest,
>>  						    ndev->dev_addr)) {
>>  				/* exact match, divert skb to this port */

--
Thanks,

Rahul Rameshbabu

