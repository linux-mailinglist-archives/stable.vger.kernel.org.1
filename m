Return-Path: <stable+bounces-245428-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kIoAOoDtAmryygEAu9opvQ
	(envelope-from <stable+bounces-245428-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 11:06:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8289351D3F5
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 11:06:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C05EA3021644
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 09:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA5ED3B892B;
	Tue, 12 May 2026 09:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qnap.com header.i=@qnap.com header.b="pMXmdZfb"
X-Original-To: stable@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11022074.outbound.protection.outlook.com [40.107.75.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D1625B0A1;
	Tue, 12 May 2026 09:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778576705; cv=fail; b=ZuUlSCvIRQjW8tPoUopTmSCgd1ariSZCkOiTQrJndsIXh/IAmDddygBcVIs9jFRXg14VV7o/bDcK+jXFgq1sXvnvuEDaLOCdDSy3D6cM8PGRy9bbA6kBsazIrTcbB7RsIPHYt7bcnBEEGXBKVhKF3TXIqdR/z1/MCal4ey5cqLQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778576705; c=relaxed/simple;
	bh=t4WprLnglpopj5PK12LzlniZ07Sm5lWhs+1gANPb4Vg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UIfR/1JJNCnVpzM9K7bkxh6l/LCzc5z73s37V1IJ6jLARLybupyb3/SlJPJYN825dsZavLigiXhRQ19AJSAwZOBquv+WJaEy332oN+OYl2BAnI4UD3dn7Kk7aPaLhxfD6PYmkcbUkxjhOs/YcysH0zVIjP7ylK6Rz6dEgC6ur3w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qnap.com; spf=pass smtp.mailfrom=qnap.com; dkim=pass (2048-bit key) header.d=qnap.com header.i=@qnap.com header.b=pMXmdZfb; arc=fail smtp.client-ip=40.107.75.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qnap.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qnap.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PPMCNtKAqJILSYjLtORw4EnmKnWYWpQZNrLFm4Riz2U9WVe5oYODItRrmkelG0/jxaHopCQF/X2eNF3Prl2fbK+Vhyt52x4mqY/z5K0NVaMBWapTzlOEq1z45r69v5Aai76ucTNhrGMPOImj8CUbam7zmBfD4Rpt87BKQbuiJiQIiM9MfcFb1ZK3ku4BdgPo5no76SbQlr0kmu404Lri2ukWJGZ3wJG8IPyRjclfNDeGUd7xN/GTLkpv/MJp55D+ATAFqIHWa5WHytibHDJ8GjSSudUI3WLAYL6+yjH2XasX8MAs6sJvrO90WBYqm/x3vNty8kKaYJNlUiU1CvVaXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jBQ/2xLRnYD0/W7EldmPIRa9vMUGSLHr8MhIdvjwvMc=;
 b=XX6M4Vsnr2LE3lUj1xxZy0iSxP1fPf6txN4e6gkbfrIw05fAuojWmK6pbSmijI908vEAeOkySnC7p0v+7e3ZY0GSEuMmhJmyKEOm/F6EVEeLj0LvxfnKaGVkYLyB2I184EA5h+Y2lUwmYqcbpqd3TEuDOBBCod6TUoQcdCrL0auklzUIu4s6BLJcNbqmMjcfmbEhenGqccGHnfqqSaemxG6pxDDPr4OUQRXMbPdNJEbN1NnYl3Lp45MJXQUwDEOHDS9D9TZdwVFm8n7hU/XPmlxJw1sWDLSpyKOAmVwPcoiweCppYU053ILFVZeloBorL/UtWO2w2rq822yEkCM3Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 122.147.219.42) smtp.rcpttodomain=kernel.org smtp.mailfrom=qnap.com;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=qnap.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qnap.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jBQ/2xLRnYD0/W7EldmPIRa9vMUGSLHr8MhIdvjwvMc=;
 b=pMXmdZfb1wCtD9BQAFBKuqxTqV1Bvvt/izIE8c0KfeVyn4uQXnZPSn2BLrmD+1icKIEvP5Pihe2sbcMxrNRx8Fud9VNa76MAVjF0eWHl3E78oqdwJZ7ZKKbvdAm+LlusAyf2x0y47VDoYv12p88OajyEGcOF1TRIMRTP+XjbZGuoBcGTvg1cnKO3fPkynV8c0IkGuUCA2kTarGB9GCzu/8AiSXxbBXWAwGq9yHWhBJC8buAykkBqOdxvTYsoZnfHmMtDvMscVHomcWCsX1bCfMTYqcbM/zTukmlY+SAKzP7QQqAH43TgKh7DziT/z96MQZmLfTQkh2TYO/gUaQ1kqg==
Received: from JH0PR01CA0008.apcprd01.prod.exchangelabs.com
 (2603:1096:990:56::9) by SI2PPF17766D185.apcprd04.prod.outlook.com
 (2603:1096:f:fff6::7c6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.21; Tue, 12 May
 2026 09:04:57 +0000
Received: from OSA0EPF000000C6.apcprd02.prod.outlook.com
 (2603:1096:990:56:cafe::de) by JH0PR01CA0008.outlook.office365.com
 (2603:1096:990:56::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9913.11 via Frontend Transport; Tue,
 12 May 2026 09:04:56 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 122.147.219.42)
 smtp.mailfrom=qnap.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=qnap.com;
Received-SPF: Fail (protection.outlook.com: domain of qnap.com does not
 designate 122.147.219.42 as permitted sender)
 receiver=protection.outlook.com; client-ip=122.147.219.42;
 helo=mail19.qnap.com;
Received: from mail19.qnap.com (122.147.219.42) by
 OSA0EPF000000C6.mail.protection.outlook.com (10.167.240.52) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.13
 via Frontend Transport; Tue, 12 May 2026 09:04:56 +0000
Received: from localhost (unknown [172.17.22.18])
	by mail19.qnap.com (Postfix) with ESMTP id 8C5DE2AE;
	Tue, 12 May 2026 17:04:55 +0800 (CST)
From: Henry Tseng <henrytseng@qnap.com>
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	rafael@kernel.org,
	viresh.kumar@linaro.org
Cc: Henry Tseng <henrytseng@qnap.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] cpufreq: intel_pstate: Fix Raptor Lake-E cpufreq limits
Date: Tue, 12 May 2026 17:04:02 +0800
Message-ID: <20260512090403.2708970-1-henrytseng@qnap.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260511235328.2018458-1-srinivas.pandruvada@linux.intel.com>
References: <20260511235328.2018458-1-srinivas.pandruvada@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSA0EPF000000C6:EE_|SI2PPF17766D185:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 6491e04a-98e4-45bc-16b3-08deb0058982
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700016|82310400026|55112099003|11063799003|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	ws9j22TFKqRDeXiBsrhLKYFHH4MkfHmoETK5jh5YaqmUEZ5yu0MWYRfgWGjkPKeazTk+MoHRyWiQTv0mZjJY1yWSZPniuvBtVDNYmB8SsWCCGxUZ5kPOPkGUJ5x9uKU5bLhFKQLezU62YTvAHss4BqYwqBrbQyGo9EEcGGr+WsOUZkHJtNltS1rZlX3uTlO0vtrm1B9Pc9XQY1O7DyeuImVOOxIjCaw7A8Q/9DO0+2lsR3oRCG/6O2dWME+0DJtwugMprhLlQuNR0gEBC5SRpTseAEhYABwnXXKDgIeghnUqUQYsZxFLRVlIWSumnGjhjIQ2oxPqiB36vvocvbXpmysN1FD7yHqddBR4OTfuIajsZrVzxeOFhn1fjqGGQTY7gCmmPwBub+3PZNO83otVhdgnefYtF2GsA3GvjLjY/mUo1VG2/cTzjq/sl8OSnqXrgLdYCRZzyyP4iFrZJFJsJX9U479bPcZqaUv5kJjCDeqZWz8DB7A9T66j/cZHs32wkRLdvPFXOZYt3HkIOjmi4tCTq7POboNv/HZGUuw+ULBp54EfAcIE8dnMf1D4wIAYKiE4UamI2yAWArt+OvOWFUHIagaN5lccQ7WHVLwe50QMoQQd5uGNzV4f1HdUfUDBMYPQ95w+E0taFGR59okaits7so/WnuxTvtQI/maleh/6wM5Qy4fqALLHoqr+OBddPR7eWB3zhhGjgd1GzIVdLkdrd7F9Br3t/aBTACMc36o=
X-Forefront-Antispam-Report:
	CIP:122.147.219.42;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail19.qnap.com;PTR:122-147-219-42.static.sparqnet.net;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(55112099003)(11063799003)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	1Q6HKW4E5drs8t4Nba6/IOLYkYJTJ1YXDvlE6hwo77rx6G8wTinkCAs79YFCjFqe3l6qhWMzSUz2JGmI5MjrYpTDX5yk48nwZSn6Eukx3iuNixJUSw4P+6SZ0aIjZSFshjsLXoYRcVpxW1JQDgvt3VwU7Fs+wmv5kY7v6LoxXOXoE1v2m08DRROlALWBKXporR5sO+N8eYFLPJnHEbevd9I6aIbd3Ekd8nLIhlgsYcasrE2X8QNeUHMWvUJg7gK41YrEwEugjBBL2xZI8gpQOlT7MMS9Hwih+ffhztjsV4jvMvFmz99Nt2suiBlmOhFpTlzDXGhbvzCXZwJ7ZH5R7w/J0GFxVF7bvMBszqL68u9Brc+QdBYIwW4+67CGVgMwOGBePIXS8qTf0P0jgyQPUapTkcvvgsJgr1v1mt/aAzKZ52Ff8NPE+eMK1gX05TI7
X-OriginatorOrg: qnap.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 09:04:56.0205
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6491e04a-98e4-45bc-16b3-08deb0058982
X-MS-Exchange-CrossTenant-Id: 6eba8807-6ef0-4e31-890c-a6ecfbb98568
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=6eba8807-6ef0-4e31-890c-a6ecfbb98568;Ip=[122.147.219.42];Helo=[mail19.qnap.com]
X-MS-Exchange-CrossTenant-AuthSource:
	OSA0EPF000000C6.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PPF17766D185
X-Rspamd-Queue-Id: 8289351D3F5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qnap.com,quarantine];
	R_DKIM_ALLOW(-0.20)[qnap.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-245428-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[qnap.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[henrytseng@qnap.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email,qnap.com:email,qnap.com:mid,qnap.com:dkim];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

On Mon, 11 May 2026 16:53:28 -0700, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com> wrote:
> Raptor Lake-E processors are not correctly showing cpufreq frequency
> limits.
> 
> These CPUs don't set X86_FEATURE_HYBRID_CPU and have no E-cores, but
> P-cores still use hybrid scaling factor.
> ...

Tested on Intel Core 9 273PE (Bartlett Lake P-core only):
cpuinfo_max_freq is now correctly reported as 5.5/5.7 GHz, matching
the datasheet, via the dynamic CPPC compute path.

On another Bartlett Lake P-core only SKU (Intel Core 7 253PE), the
CPPC-computed factor (80645) overshoots the datasheet Max Turbo
Frequency (5.5 GHz) by 100 MHz, matching the CPPC rounding error
described in the commit message.

I'll send a standalone patch adding Bartlett Lake to
intel_hybrid_scaling_factor[] with HYBRID_SCALING_FACTOR_ADL to
address the 253PE residual.

Tested-by: Henry Tseng <henrytseng@qnap.com>

Thanks,
Henry

