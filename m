Return-Path: <stable+bounces-144264-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE8B7AB5CFA
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 21:10:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04CD93A9FC0
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 19:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B77B52BF96C;
	Tue, 13 May 2025 19:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="IzXFL8By"
X-Original-To: stable@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11021108.outbound.protection.outlook.com [40.93.194.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE891E8328;
	Tue, 13 May 2025 19:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.108
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747163438; cv=fail; b=kAogbz8/dJ/MIvrs7MhmkECRIL+HkrpNfDRWVqCyN1d3sTs0m83GVB2zYPs5KG+gZt1bdJ4iOQ2rd5LdMGdCpNJlDYytJA/BdntrM3vGtrIUTE8YvXrQCG3xcktXB2Xc2oQDF+PKGGfBdkUYk+lirdRkcIokyBNrtARFR6W5EFE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747163438; c=relaxed/simple;
	bh=r5gOljndzKMowGL1jyyhEgLAJoK8IfApwLJ/F7VHIDE=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 Content-Type:MIME-Version; b=XIh35N9I6L8/925ToO6AFARxqDDcqFXRHmlVqcc6+y6EyUmUyntiqchsOqwnKqS6f181cyO20q5srqCBpWJXRKzUm/6rUfxUO/nTYoBQssPL+jq2ZmgqwIk6ai3R3GcyJGsOQJhY+ntY+2sL5gSeI8HdRmebcvHjBf4d0//7hyQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=IzXFL8By; arc=fail smtp.client-ip=40.93.194.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jsh4v5l1gUDUzYrFTNWSJ7ex9ZptlOqL6jL4gJFBPADNP5pF/c9leRjCYsV6kKdYzUi/mEP/1g1wPow1EhabUzH4CaUqDp5wkcJn8RH3Eu6On+1P1RsPoyTSE966XR90NQ+8N7FqKjE2xhBw2qTDzsM/FjQqPk6RfJ7288CI6GKuKwt9+UK/bemyIjAmNlIX2qyQA7jdEscUkBFCYqDqTWJVmhi8gUi41ghUMmgtOdRkYhTHL0GoIrzNAA2sU5mhT/4pkuR2nze4Oz1VvJAydJQOcmT15kT39H6hGDDfDG4Tu/Ht4R+JFqY3i/lSkUJlzvAC8gYxmUbdpnxc6jteww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f8VCkCR/IApHyk9BqCXUUXLqrQa1jsH2d7AbUh9eYbY=;
 b=bbW8Yoks0rPofMs1L0DFhlHIQVjtOh66S8vXLeGO4KbIpuz8tjg5tTzMXZAuA0TtcKEQOtne4l+ko+xe4jXxJ2h3Q4wqvjQaTHqB3EHPJlHeyFh+fEAQCOQ/fzrnjTaFCFWtlZ14dytuXRK2erN9l70xyjl5LOsSKG/n3Rn88X7wscT0GbekibYxtOZvvteJL2kOvzfZsWvt1c8kd7EeZmQpRZH85p+3RyNC57B5GWFqDmFufg6qt3REw8qZK4NENx6W87stS40m4Mdwtl1N0omdu5Xpu2xWe747uh4PYWC4ylc2moJrrq7ICo8u1+jJ/2rqcIZurWbO9OKhlx8EyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f8VCkCR/IApHyk9BqCXUUXLqrQa1jsH2d7AbUh9eYbY=;
 b=IzXFL8BykO4b/xZrYhh2QAmLjcx0qi5UmkBKCUZcQG4IkQhtz7SMyfKKSCBERkWkK/AwcxS4o6KUDXhPos8SksFqIfzKSJpmshUCFp0XNG7KFdW/03XM6xJXQelLlVIKwk9h2k75xsyrykF/5vpeo7BKeg9Qd3CBotUKQ+OAHFc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from MW4PR01MB6228.prod.exchangelabs.com (2603:10b6:303:76::7) by
 MW4PR01MB6130.prod.exchangelabs.com (2603:10b6:303:75::8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.30; Tue, 13 May 2025 19:10:33 +0000
Received: from MW4PR01MB6228.prod.exchangelabs.com
 ([fe80::13ba:df5b:8558:8bba]) by MW4PR01MB6228.prod.exchangelabs.com
 ([fe80::13ba:df5b:8558:8bba%4]) with mapi id 15.20.8722.027; Tue, 13 May 2025
 19:10:33 +0000
Date: Tue, 13 May 2025 12:10:29 -0700 (PDT)
From: Ilkka Koskinen <ilkka@os.amperecomputing.com>
To: Robin Murphy <robin.murphy@arm.com>
cc: will@kernel.org, mark.rutland@arm.com, 
    linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
    stable@vger.kernel.org
Subject: Re: [PATCH] perf/arm-cmn: Initialise cmn->cpu earlier
In-Reply-To: <b12fccba6b5b4d2674944f59e4daad91cd63420b.1747069914.git.robin.murphy@arm.com>
Message-ID: <6e3c1f7a-ec87-d135-bee-1470da25a8fd@os.amperecomputing.com>
References: <b12fccba6b5b4d2674944f59e4daad91cd63420b.1747069914.git.robin.murphy@arm.com>
Content-Type: text/plain; format=flowed; charset=US-ASCII
X-ClientProxiedBy: MW4PR03CA0135.namprd03.prod.outlook.com
 (2603:10b6:303:8c::20) To MW4PR01MB6228.prod.exchangelabs.com
 (2603:10b6:303:76::7)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR01MB6228:EE_|MW4PR01MB6130:EE_
X-MS-Office365-Filtering-Correlation-Id: dfe76e0f-215a-45d4-1e96-08dd9251d57c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VMBDimJKkLa7zokLz9az9QnS5nLIVXfOKlMQvnq/UZpc1ReZBqoI6jgrgHO7?=
 =?us-ascii?Q?/YLRRUBOzaEOdmAoodIdREQ2p8ijRsYHGm0ED5KuPd6hHQbWWACA/ixpDBez?=
 =?us-ascii?Q?mO3LRRwL0DQG1w/tLZFNzaPWxCokV76HSLISmvEP4FCez3hmgUl2NKNWXXaK?=
 =?us-ascii?Q?5PhF1VEfuu+1KJfSpgBB7yUIcpLCymYz426x+5DHqcSqybm5wuMyV7Ww0CSb?=
 =?us-ascii?Q?ipBgOa0D7gVI+esMFVI+y7pjVKTxqeeyaDSW2ufq1uOlt8CLWmRdgg46KayE?=
 =?us-ascii?Q?ay2XJMQ+qJpp0hupRJ/nw7YB/y6879qTSDwVou/pv8V9crXfZ9URvglV8J9n?=
 =?us-ascii?Q?XlIXXRkjATGI4xTVLxHG0Ndnq8r9bUrmNqlIxHJzQ5DsQQxyQDMtXq5bt69t?=
 =?us-ascii?Q?WJeGnjrYJ81Z7LvFetLNa8B2OpRcDmBLlDOFk2Sy6CJxbwZrC5hysUuWsq8y?=
 =?us-ascii?Q?jWNPWKB6wT2p7Crxv801y4j7Gjxjc1A/xYJK1b738dR4DjeIHi6/RRA1Ab2L?=
 =?us-ascii?Q?3i+IbkWalDr5+fm65+sv4rYBpMfWh5UTfMdNq94xS/CpYugpgvLbREMRHpfP?=
 =?us-ascii?Q?3Oxs4mdc6zRmlBGmziOcR4XMpwR2TEN7qVX0tltXqAM9jl9lmJa9W/JBrAPw?=
 =?us-ascii?Q?/LiLoH5fuv30MyrAouOrBOBcN6Xek9YCtMZF1ocvli6Qxvl9dvE5PXQUdmSA?=
 =?us-ascii?Q?vVp0nCaEdRUP/KWVzFroVABXCGV5Zk2KXY4IA1kuMbwP91n9JMZC0FjpqoYK?=
 =?us-ascii?Q?bf77UQTbgw5NUscY77RK2XqYjjrEq4qRQncoyC5JKK2yIPvB5ygVZwWiZngv?=
 =?us-ascii?Q?010isN8OJHR4m6XJtcwMvVJVbBq9PvWv+lzq0KBRBjSxGO4S7FPN8bwL/hKr?=
 =?us-ascii?Q?KIhzkfKAoVHBhCGK8I8zvydw8e6SGdIbHpGWYP4RG/fqO/ESVxiprBssgcXb?=
 =?us-ascii?Q?oTBSL6njdv5cDc+6T3Re1ZeJEVTPlO0zUomATpNcjUokPSeZeVYcG9fh9dz3?=
 =?us-ascii?Q?EDCjU96Ty6tNrS0suXnreovI+2l4dOxlzlWv7vXEogaohDacsEals7HenDSx?=
 =?us-ascii?Q?hGRgmWs5YPNig1VXqwgEWNzn1QZ6AqWUkKHeI+c1DujWOUUSjRBpZlTj2Z7u?=
 =?us-ascii?Q?C/EDyMb7oY3CrcyqYPT6ln1qPeL4r04uafLuEvxo5jJfRlDbBu6oYcew3k8l?=
 =?us-ascii?Q?0sXhm/8zYzlbOlMIlc8aAuB4ck+NqhvZMdhcmJJPyacqWUnqlfZYNwRseqtI?=
 =?us-ascii?Q?Fmvmhgs4tcRIDgXdTmDdpPGg5cs8GG6ZuoqWN0ja/F9giX13VOZT8D32tSou?=
 =?us-ascii?Q?EX+lzl9Z2kHMMoX3vD5L+bjA4sv/9maQuYmE2TvrSDFyjjWBU7d0HKp2KVwV?=
 =?us-ascii?Q?9D1K+zts1CuEK/1L5L4k/FycaT85ibhCt0sb/BKvC2FZ4oliEFm3vvQkwJlv?=
 =?us-ascii?Q?4ceVslZAvucq0wmRoVGchN6ly3apfA6EmWXukciXeJyuthjFwo/hVQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR01MB6228.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fwvwS9ubZJ512NE//EVkXSeK7Qs7WdlkF5nbr54vUYVsC3Zpy4RxWOCGNdpV?=
 =?us-ascii?Q?0IIcuf3b1Kn5+gA6GT9RCtSMM/FS9lmOU6986H5QYH8Fj80udKt6Aa0zEEGH?=
 =?us-ascii?Q?YVvH2Cn4Un2fKCcUnKkp3379bSrG/KIWC8JlrPYmGqBqDhsfxezN7GzQmJw5?=
 =?us-ascii?Q?OyJ6bA0GPonJskDh5hG9A+EJWQ+VkZpGCWuknC8AJKAu8K3hkK5VMRvCKDUK?=
 =?us-ascii?Q?AlWzt+npFwjGzuJIYDV/rgXPFvehcBffM4bNMSC3aqPVMS/SnM0ag4FF6STv?=
 =?us-ascii?Q?RiYwhYuH+jhilQoC8qmvZrkwW4USHQ6GDR/JHo3oKCI4fVHJN/sAhukrF2KS?=
 =?us-ascii?Q?CVGtZlBQk1aMqUPya2ttnmfIVgi55/a5vkSVZUdKLvypZ1RPbw1pF8av5H2c?=
 =?us-ascii?Q?F57gP+MNOxGkA3Uintj2A/lAzVytBVaMC/2Ny6MF29iTWd47lYFHcTtXe/2W?=
 =?us-ascii?Q?S75R9N999Jba/bjXNHV7qSbcNmjrt1kX7z7ElAJrSxRY9WFtqwthNbm2b35A?=
 =?us-ascii?Q?2j1VoDRkuB77pMOsXO35CrV3eWiqzxsfuxWzHGrZ1U8rLUSprV3lz2Iswgdn?=
 =?us-ascii?Q?qvFqtFkdyjuT3qOMjfguMYUserwC2PBlAvhXHjdbQdHnAZ+AKs9kocvXUPoJ?=
 =?us-ascii?Q?33BT46uKsulGeLpuHcUj5C2RXtexpJjqWst7H4aielUhCEDmg47TTozc6iDR?=
 =?us-ascii?Q?qYkkSqtAwJwR3hZJg9uD+ELALrH3TrOWki6jsWecumuRBEb8y2h/SezTlDqA?=
 =?us-ascii?Q?Axz5I9By1FYKeAYaUblHu8JwDsXS4YiIolvG5eYPnUD/HG6Sp/wdNFtiftnW?=
 =?us-ascii?Q?pHV6vAIpY1M0/N2W9my/Uoc4g8BdtCEYsK30DBj8JIglYuuhz/4hfxkmuUqT?=
 =?us-ascii?Q?N8ZgcM6mXj9QfOXmzQ/wGbbRA1LIuV0cR4Qf75ENHIjVGDPGkqvLX2ZTHGNy?=
 =?us-ascii?Q?FZLwprkNfXYpzeRfZ8oDkAyxZkJjZwFRxe9vFHLAkYY7OfHlwC4DuJP7v6PQ?=
 =?us-ascii?Q?mbxWrI/9OTuIUmmcz/7UwH85lxxtpzVfSxU3JNyOAN1KrDtEmCFHqvlWS1R3?=
 =?us-ascii?Q?ch7bIQozNCVGjX76eL16JDl2Ti9xlRZ6WVMwjWUNUSAdyaVw2GrekNaDXPGJ?=
 =?us-ascii?Q?hGer1yv8bSkd3D5Xg6ipse5A99OFg01atc4Md9lZVjmLqtxmXf/63IAOvVSV?=
 =?us-ascii?Q?BtTPvs/W6w6yLlRXwQcnBIu83nMOkQ5DLQlaC+dHuLXoAHQgGfU+niYn8o68?=
 =?us-ascii?Q?05OFq9xkTGjdZLysq/LrjXA9y0/k1Hih3LRqEk4rF7zkc7rmZxDkU0OGsBNK?=
 =?us-ascii?Q?tPBYfUs9xBLmHRtTXfVWHP51S3ogSxCACDxGwKd6GlQNc3pcEnxFeNb8ZSyJ?=
 =?us-ascii?Q?3vknn6wNSwaCD/4v7weEZYzbiB6c5ori9DsrOJApzYedUXN7sNbX61IAkR78?=
 =?us-ascii?Q?wd5YnazwQxqDvqy8WRIyNfCo9pcW/AceAKUG7ER37mJWjCv1vr45kd1oZqjp?=
 =?us-ascii?Q?7LwLAdNG56S/tLNvl8FWNp9nbrkF4ojcxy4O2+AreWFtRAHljrB6GYTZOa67?=
 =?us-ascii?Q?0L33eVp/71ssbqtjMVGaJAJ6QoXRW6a4FgjohNNIumFWA1NtAl0wOaHOotQO?=
 =?us-ascii?Q?5oM413J5YxPEI+9NwRyO+3Y=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfe76e0f-215a-45d4-1e96-08dd9251d57c
X-MS-Exchange-CrossTenant-AuthSource: MW4PR01MB6228.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2025 19:10:33.0130
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JGNIhi2wuGcqteGKytOOiMZBl+xf+UKs1iR1jX9DofsawcmsaYuf6oCKMsJJwE5dGGiav5X+NIJqK9py/78RtTSWGmGRIVcNYfUKWmKG4EaFvObdWonAEe6d/XKQNmgG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR01MB6130



On Mon, 12 May 2025, Robin Murphy wrote:
> For all the complexity of handling affinity for CPU hotplug, what we've
> apparently managed to overlook is that arm_cmn_init_irqs() has in fact
> always been setting the *initial* affinity of all IRQs to CPU 0, not the
> CPU we subsequently choose for event scheduling. Oh dear.
>
> Cc: stable@vger.kernel.org
> Fixes: 0ba64770a2f2 ("perf: Add Arm CMN-600 PMU driver")
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

Good catch.

Reviewed-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>

> ---
> drivers/perf/arm-cmn.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
> index aa2908313558..e385f187a084 100644
> --- a/drivers/perf/arm-cmn.c
> +++ b/drivers/perf/arm-cmn.c
> @@ -2558,6 +2558,7 @@ static int arm_cmn_probe(struct platform_device *pdev)
>
> 	cmn->dev = &pdev->dev;
> 	cmn->part = (unsigned long)device_get_match_data(cmn->dev);
> +	cmn->cpu = cpumask_local_spread(0, dev_to_node(cmn->dev));
> 	platform_set_drvdata(pdev, cmn);
>
> 	if (cmn->part == PART_CMN600 && has_acpi_companion(cmn->dev)) {
> @@ -2585,7 +2586,6 @@ static int arm_cmn_probe(struct platform_device *pdev)
> 	if (err)
> 		return err;
>
> -	cmn->cpu = cpumask_local_spread(0, dev_to_node(cmn->dev));
> 	cmn->pmu = (struct pmu) {
> 		.module = THIS_MODULE,
> 		.parent = cmn->dev,
> -- 
> 2.39.2.101.g768bb238c484.dirty
>
>
>

