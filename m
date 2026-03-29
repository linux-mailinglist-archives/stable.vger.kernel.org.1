Return-Path: <stable+bounces-230963-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yL/wHQFTyWnrxQUAu9opvQ
	(envelope-from <stable+bounces-230963-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 18:27:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D0D42352E74
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 18:27:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 73C63300638C
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 16:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14F9C37C922;
	Sun, 29 Mar 2026 16:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mEV1gMhJ"
X-Original-To: stable@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010058.outbound.protection.outlook.com [52.101.61.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE6835DA60;
	Sun, 29 Mar 2026 16:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774801579; cv=fail; b=kG4IMahYXZalWK6mYh3+P4aMSUB6FU5/Ou9y5f82J920lR9JACxSEQVTtvmaNc9bQUCym/qUzANMeKQ3SvewBH2cJyBmGxXMCjmfUaP3jQYUn6+L18WontdLABnW+KmiB0Hta3Who1M8DLpMkqI07chg4gqM57k+VgOl0GoiAoM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774801579; c=relaxed/simple;
	bh=xpagld+NlOKqF4q3IqcICkYlfnXfW0E9Ma0dFOXcML8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EIncQDHjTlC+gbIUgtsq3ogMIiuqeoOIAqITQ2KptgrLZWOwWkdi9k6OBQryZqk64r6kfJMMHksuupqdQ4gWzSDTtLPtsfQQLdQlkiGS93O+cRX0KFwrTBAB8GBKuS0+rWFP36N/qRC6WGSyNVZYHkrtDlZ5RSwG0iexGu57EiI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mEV1gMhJ; arc=fail smtp.client-ip=52.101.61.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WMy8CSGNf5X7dAlnigGqjpRJWECp+SW5OL3wMkdJY2C1qVQxvF2L1kLirH+KtU/Yr6UJppOTrpssT5fmUi3RelQHe+ouVQ+rBE8I5smmGJ6zWVfkUHfd7iqs/KXEI/gqWuWMTG1E2pHOjiMcolIfZI/1ioLTEqQ+GWYYjstpeODytlQZlsr3aAvAhooNWPkHtaygWOlpcLrM8kWzvHucNx036+2J4irGPqguzb5o8HRKtraeD1JGVFtJglcFJaeooCl89EUl2ChU5xEWOPOVxuUHlUVjPgDwbED1e1/qnj+AJg0C1/AK+krVoEYlFzOFt87408W1F5eNc7IjbYRTNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J37tkLt3RWYl9B3lwFjGe9ndOjn9Jo/teoDd7GUS5F0=;
 b=fbRZ2WX4BPuuWgTODdZn7KuPa55tAxsBO3V5bt473pCkZ7OEDEEKNWlS59stkerq/wh8JA0GIdqfBwN+OYX9CPPMa2kc0mtsy+z5Q8tlVgzHJ0BIqn7yHKNwVl2Sys3Xn37GpJbbbYKWMkkkuIVT+0/fHtjGEcx07ppBYa8iD/e0XmLJNzi0GDB8hj4WhJKy4SLnMZzd/kXxIGQ1cYRiWMk8DLRIH2HDSx5HyidlJ+tOIZKLXnDjEQKASD22fLDtD2+Jpk/wxQihlh5mxMvysOhIWoFYrRfOKAz3N1TgBAttdDpeQX1sE5u4kJ5kC1dqk8pCWJNzEjwY+byaO63mbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J37tkLt3RWYl9B3lwFjGe9ndOjn9Jo/teoDd7GUS5F0=;
 b=mEV1gMhJ0bhgxx8WMhguH07jd0rGBHMruZEx6j3010qmasBu8mTXxODSm+uJarfd4PU+y7kuQ2ap+XtLMp7ZuJ3NKTe4cSV/WeB9NzF3MKgiV/tFEKgQTuYraoEUFI7tUjSIxqTvyIT7WWd1QOUfV7Lp7cAsaVagC0QIlywQl6a/tlMmFOjKYJaGi4GVZjN3/qlLgWgxp/eJL36+RhJ0Q1b0Kfxu6ZyRy2limlmP4PIBYNHyZWlVfTahKWLCzEDhsQKw+cE2BclPoGhCuVtfQrMpmOloDqMBWq/ZGo3K5sbZUmODM7Nipk+dbL/yoVnKLQXwhp6xOKWO0LKfj0zNDA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by MW4PR12MB7437.namprd12.prod.outlook.com (2603:10b6:303:21a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Sun, 29 Mar
 2026 16:26:14 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9769.014; Sun, 29 Mar 2026
 16:26:14 +0000
Date: Sun, 29 Mar 2026 18:26:10 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Emil Tsalapatis <emil@etsalapatis.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] sched_ext: Fix SCX_KICK_WAIT deadlock by deferring
 wait to balance callback
Message-ID: <aclSomF-cmT6_UsN@gpd4>
References: <20260329001856.835643-1-tj@kernel.org>
 <20260329001856.835643-2-tj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260329001856.835643-2-tj@kernel.org>
X-ClientProxiedBy: MI2P293CA0005.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::12) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|MW4PR12MB7437:EE_
X-MS-Office365-Filtering-Correlation-Id: d5f0fcf0-5ac3-4cf4-81c8-08de8dafe52d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	hZ25Xi6CxPdZElDApEY4e2SH1s2pJda0xUdrHqu1F6T3cSMM57jVGcGpb8Lq088luZ4t8VK7kQM3KzYq6rOJguUeI7q2ad7aICWtvJ/2JL6YAXmD7snVV3AK7cfKmPa6PA4+SEACoFq0D1UM4UjXIzLPyml+/Z4Yuk0dM2LvkiDNvXjbo0u4NLGaafnW60FJMjnodOHbCAyjbeSL9YGvoTHj8Oqh9A5M/1G4K2F5DrZmD1n7YwrGs6NGW4Iv557AYnYM34bTS7s/A0CZS4EWg/ivZKZS3IS+oJxRs94v2x1nABIuOEsfJ+MSPAauZktw4R5x6S/qlQWpL6nUHHScSg06HFgjbFuud6BZDuVN/pirneOwK9VQrcdMNHUjAk9GqqDL46kMCzYZoBrqkhJiX18FS6NNFqve1Fj/H0sj6ChpC7gt5mI6iNO4GVcHWndS3WlJVdEDQIkZKXX87ckVxm/wXy6AWk//HdVdmUVQIOhYP4xUhrW5geA0Pk1Ht33FT1D8PIcS2PmvZt7En5lbuIzQA2J6SVklOMeF+wts92vXOY/nKOoCJapoEifN82P18mGbREu/trPM/bvVqlLtdKzonYl7RqTwtuogkZx4OD15dgV9Obro8pKvMxxBG3gYUzugu2z4Sfc0BR5j5WmWtgoLOjgnE2UXSxZrdISuOdPXyb4G9/pHkv3r/OSl2r8NKUT+yK9RUChHejFDxu6VnZFXZ+k7jOUDWvjLzGxcFUHTc9Gc0iQWNloin3XI03KG
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OENqR0t0MzdUd1h1NHYxNkc1bWgxSlBoSk54aGgwZzFOelk3aUtOeGNMZnB4?=
 =?utf-8?B?ejN5b2JFZGlFSTc5VHJWVzQ5TElMY1hGeTRnaW4vL0VlWFdFUVZ2VUpodkgy?=
 =?utf-8?B?OXkxS3pPL3RoT2g5aGtKbTlwWDZZTS9hY0pDbUQ4Mm1rNGZ4T1NSRGhMNHFT?=
 =?utf-8?B?TjZlZGZwUWFxeVZvaEU3UXdHaEtiN3VmZDdUVEQ0ZEZKTGwxWGVNZWhhdXp6?=
 =?utf-8?B?OEJNWXFodXlJd3NFOTRXb3J3TTdycm9yVXgzRkRhNnJORDJUcGg1RWtWNG93?=
 =?utf-8?B?b1NuSk9kNU9TOThmSFZKUlZ2bEQrUFJLcVhteVhyRTZXQXRyN01MTklvWlpj?=
 =?utf-8?B?Umk4NTlFYlowb3M3bWF2ZXU5Wi9LaGF4Q2VGQ3J6Y2d5VVp2aTVnN0VNRmtF?=
 =?utf-8?B?dVd0V0pNSTk3RGd0QVZUTjYxcWJTS3FjdGU0TG5jZG4zVk5BYlNrZ24yMUhN?=
 =?utf-8?B?Z1JFUFV0NmNtTG5ZaDB4bzk2SHpqYXhjYnp6eVg4QnA0c1VtdlFnNFNQbEMz?=
 =?utf-8?B?dEsrdkNmOGtnd1dqbmpKQXB6OFZ4SVdTdURvWGd1QkkySGwzYWhoVlJLZ2U1?=
 =?utf-8?B?STNmTVJMc3BvbUt6elFLc0pKU3FiN04vaXQwRmE3RTE1SFUxMEp0aUxFOFJV?=
 =?utf-8?B?WDNXRmFLQ2EwMll5QysrM2Nwb2FhM09GTExXWk1pMGRIVnJkbHpWM3RtVWF1?=
 =?utf-8?B?SWlkWGtuVHNtQ1YwTjY3dytYTDNCN1dsMUtpVjNXSU02RFdqMDVhQnRlSjRH?=
 =?utf-8?B?VW1TeDJFckRmODJlSE92U2pleUJZbU9BRTlyeW9Qc084ajFXdWpFUkZ2d2Mv?=
 =?utf-8?B?eFp3L25VZjlRNzFTbzhPQVpXM0E5d0VuUzV2a3hBMDFTbWFKMzZlSTZwK3FI?=
 =?utf-8?B?dC9kanJyQk5FRXVIZEN4WExOMDJrcllkRFphS1JVeUNkOVI4Rnp1RllkWlV0?=
 =?utf-8?B?Q3dwenIzUXNYMjZnaUJKNmE3VFBDM3hWaERoY0JqZWNMTGNFQU5vdmJxblcx?=
 =?utf-8?B?VzhhTHJNWmM3MHV2RUd2aC9FNFlTZXlxLzlyKzBSSnZSMkFiN1N0dDc4ek1R?=
 =?utf-8?B?V2lwdzZNdTRjTWR0SlZLS21rU0xDclFFaldCbjN3WFNQQmlPUVNhWXBLWERO?=
 =?utf-8?B?YTk5cGdSeWtueHpodGluL3RLOWZQSU81RHUxbWZDUWdVeTVEWWhad0gwNmdL?=
 =?utf-8?B?TEh0blRHc0p4QXpnTEZ4MUlQR2dGSGZvTS9uc2VzWW5UK0Q4WkJobjFSTUNY?=
 =?utf-8?B?c1pGTDVJQi9SQzUxaVJLUGo4ZE4vdWh6bHozWWZKNndaT0xnZ0kxN21TU1lD?=
 =?utf-8?B?ZmNOcmtCZ2IwQTV4a0xOc3ZsWnhIOE9nNVdHd0NGSEpRUFd2bW5adkVWWm9B?=
 =?utf-8?B?Q0hMcmxlOW9mekU5WFlSOTlLaFN1RHV6MmFvTXM1ZGVkS01Za201ZStWeURI?=
 =?utf-8?B?MTFUU1VRVktYWmlmYXFOVWh2QnVDcmZxL3NtRVQxYm0zNWo0YmFDRHJMem5l?=
 =?utf-8?B?RzcvOWFyMm96cGg1SDZYS0NLQzN2NU5yT0JPQUg5RTAzeFFOblJjWDhuK1pH?=
 =?utf-8?B?eVRpclF5RnVoVG9pQWNwMi9vU3ltSFNUS1RtZ0lwWm9ZYkFMclVWY1JnWU9w?=
 =?utf-8?B?R3VOTk5wMVRVOVJxV0w4YldTQVA3TC9CeHZEQysrZFRTU0VlK2dwWUp2bC9C?=
 =?utf-8?B?NTVpYk51bzVXUDRDL2R2SXpvdGNlbTNXYlFESU4xVXhBQVVMTUtxMVBOc0lw?=
 =?utf-8?B?QVNnQlc5eE9welRTQkxHNnc0UjU5SXV0emptcTVGend0ZERkWm9UbkVVYmVt?=
 =?utf-8?B?dlRPekYzR2swVCtLbnJQeXQxS2JINHYwOUF5anByT0xRMEpla3ZHWkxvZDJN?=
 =?utf-8?B?TGI3OGZlUWtMZldmcXlsblRIRnc0dGR2T29tM1V3ejA3N1hTOVNHZmovN01k?=
 =?utf-8?B?SndNV2FkeUN0RTB1U0dzdGk4Sm9lakZyZk5UMkZEMi9MY2w2SG90Z0lZRzVv?=
 =?utf-8?B?aGQ4dDUzY3NqbllBdk9haHpDejhrVnNPUnBrY3pnZHByRnh0c1ppQzRTWVQ3?=
 =?utf-8?B?WlVzQ1FjektiOE80Q1EyK21sWCtvbWphbDRXbjAvS0RhUmxpVERlN2V4N3pN?=
 =?utf-8?B?eU5LUmdCV2RDRERNTnNMZEhaUDBUelBlS01zb1FrQWdySHdibmwra213ay9L?=
 =?utf-8?B?cDB0UXNtbTB6WVZBMXF3ZEZzbGk3K0ozNlFKajUyVGNqRVA2bTAxZWRaMnYr?=
 =?utf-8?B?cDU1aUN2WDNqY21YaGI2R254bURwZDFveWNoZENaTW1MN0pNNXQxZ2xyL01m?=
 =?utf-8?B?WnZnSXZlcis4cHZHaXBYemJaWUVjb3Q0UzBuU2hSbS9WczF0UDZWQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5f0fcf0-5ac3-4cf4-81c8-08de8dafe52d
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2026 16:26:13.9940
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4/WwjecH1Y36maaZpQE6SP8XG2EVwFhVwwm1TfGVgw5dbLz2sB1Fwb9V/u/XZHgwH5Zj+Sl0dsJMQtVzMjEk7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7437
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-230963-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arighi@nvidia.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,arm.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D0D42352E74
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Tejun,

On Sat, Mar 28, 2026 at 02:18:55PM -1000, Tejun Heo wrote:
> SCX_KICK_WAIT busy-waits in kick_cpus_irq_workfn() using
> smp_cond_load_acquire() until the target CPU's kick_sync advances. Because
> the irq_work runs in hardirq context, the waiting CPU cannot reschedule and
> its own kick_sync never advances. If multiple CPUs form a wait cycle, all
> CPUs deadlock.
> 
> Replace the busy-wait in kick_cpus_irq_workfn() with resched_curr() to
> force the CPU through do_pick_task_scx(), which queues a balance callback
> to perform the wait. The balance callback drops the rq lock and enables
> IRQs following the sched_core_balance() pattern, so the CPU can process
> IPIs while waiting. The local CPU's kick_sync is advanced on entry to
> do_pick_task_scx() and continuously during the wait, ensuring any CPU that
> starts waiting for us sees the advancement and cannot form cyclic
> dependencies.
> 
> Fixes: 90e55164dad4 ("sched_ext: Implement SCX_KICK_WAIT")
> Cc: stable@vger.kernel.org # v6.12+
> Reported-by: Christian Loehle <christian.loehle@arm.com>
> Link: https://lore.kernel.org/r/20260316100249.1651641-1-christian.loehle@arm.com
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---
>  kernel/sched/ext.c   | 95 ++++++++++++++++++++++++++++++++------------
>  kernel/sched/sched.h |  3 ++
>  2 files changed, 73 insertions(+), 25 deletions(-)
> 
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index 26a6ac2f8826..d5bdcdb3f700 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -2404,7 +2404,7 @@ static void put_prev_task_scx(struct rq *rq, struct task_struct *p,
>  {
>  	struct scx_sched *sch = scx_root;
>  
> -	/* see kick_cpus_irq_workfn() */
> +	/* see kick_sync_wait_bal_cb() */
>  	smp_store_release(&rq->scx.kick_sync, rq->scx.kick_sync + 1);
>  
>  	update_curr_scx(rq);
> @@ -2447,6 +2447,48 @@ static void put_prev_task_scx(struct rq *rq, struct task_struct *p,
>  		switch_class(rq, next);
>  }
>  
> +static void kick_sync_wait_bal_cb(struct rq *rq)
> +{
> +	struct scx_kick_syncs __rcu *ks = __this_cpu_read(scx_kick_syncs);
> +	unsigned long *ksyncs = rcu_dereference_sched(ks)->syncs;
> +	bool waited;
> +	s32 cpu;
> +
> +	/*
> +	 * Drop rq lock and enable IRQs while waiting. IRQs must be enabled
> +	 * — a target CPU may be waiting for us to process an IPI (e.g. TLB

nit: s/—/-/

> +	 * flush) while we wait for its kick_sync to advance.
> +	 *
> +	 * Also, keep advancing our own kick_sync so that new kick_sync waits
> +	 * targeting us, which can start after we drop the lock, cannot form
> +	 * cyclic dependencies.
> +	 */
> +retry:
> +	waited = false;
> +	for_each_cpu(cpu, rq->scx.cpus_to_sync) {
> +		/*
> +		 * smp_load_acquire() pairs with smp_store_release() on
> +		 * kick_sync updates on the target CPUs.
> +		 */
> +		if (cpu == cpu_of(rq) ||
> +		    smp_load_acquire(&cpu_rq(cpu)->scx.kick_sync) != ksyncs[cpu]) {
> +			cpumask_clear_cpu(cpu, rq->scx.cpus_to_sync);
> +			continue;
> +		}

Should we add something like:

		if (cpu != cpu_of(rq) && !cpu_online(cpu)) {
			cpumask_clear_cpu(cpu, rq->scx.cpus_to_sync);
			continue;
		}

> +
> +		raw_spin_rq_unlock_irq(rq);
> +		while (READ_ONCE(cpu_rq(cpu)->scx.kick_sync) == ksyncs[cpu]) {

And here:
			if (cpu != cpu_of(rq) && !cpu_online(cpu))
				break;

(see below)

> +			smp_store_release(&rq->scx.kick_sync, rq->scx.kick_sync + 1);
> +			cpu_relax();
> +		}
> +		raw_spin_rq_lock_irq(rq);
> +		waited = true;
> +	}
> +
> +	if (waited)
> +		goto retry;
> +}
> +
>  static struct task_struct *first_local_task(struct rq *rq)
>  {
>  	return list_first_entry_or_null(&rq->scx.local_dsq.list,
> @@ -2460,7 +2502,7 @@ do_pick_task_scx(struct rq *rq, struct rq_flags *rf, bool force_scx)
>  	bool keep_prev;
>  	struct task_struct *p;
>  
> -	/* see kick_cpus_irq_workfn() */
> +	/* see kick_sync_wait_bal_cb() */
>  	smp_store_release(&rq->scx.kick_sync, rq->scx.kick_sync + 1);
>  
>  	rq_modified_begin(rq, &ext_sched_class);
> @@ -2470,6 +2512,17 @@ do_pick_task_scx(struct rq *rq, struct rq_flags *rf, bool force_scx)
>  	rq_repin_lock(rq, rf);
>  	maybe_queue_balance_callback(rq);
>  
> +	/*
> +	 * Defer to a balance callback which can drop rq lock and enable
> +	 * IRQs. Waiting directly in the pick path would deadlock against
> +	 * CPUs sending us IPIs (e.g. TLB flushes) while we wait for them.
> +	 */
> +	if (unlikely(rq->scx.kick_sync_pending)) {
> +		rq->scx.kick_sync_pending = false;
> +		queue_balance_callback(rq, &rq->scx.kick_sync_bal_cb,
> +				       kick_sync_wait_bal_cb);

queue_balance_callback() is a no-op if the rq is in balance_push, but I
guess it's ok to just clear the kick_sync_pending if we add the checks
above.

> +	}
> +
>  	/*
>  	 * If any higher-priority sched class enqueued a runnable task on
>  	 * this rq during balance_one(), abort and return RETRY_TASK, so
> @@ -4713,6 +4766,9 @@ static void scx_dump_state(struct scx_exit_info *ei, size_t dump_len)
>  		if (!cpumask_empty(rq->scx.cpus_to_wait))
>  			dump_line(&ns, "  cpus_to_wait   : %*pb",
>  				  cpumask_pr_args(rq->scx.cpus_to_wait));
> +		if (!cpumask_empty(rq->scx.cpus_to_sync))
> +			dump_line(&ns, "  cpus_to_sync   : %*pb",
> +				  cpumask_pr_args(rq->scx.cpus_to_sync));
>  
>  		used = seq_buf_used(&ns);
>  		if (SCX_HAS_OP(sch, dump_cpu)) {
> @@ -5610,11 +5666,11 @@ static bool kick_one_cpu(s32 cpu, struct rq *this_rq, unsigned long *ksyncs)
>  
>  		if (cpumask_test_cpu(cpu, this_scx->cpus_to_wait)) {
>  			if (cur_class == &ext_sched_class) {
> +				cpumask_set_cpu(cpu, this_scx->cpus_to_sync);
>  				ksyncs[cpu] = rq->scx.kick_sync;
>  				should_wait = true;
> -			} else {
> -				cpumask_clear_cpu(cpu, this_scx->cpus_to_wait);
>  			}
> +			cpumask_clear_cpu(cpu, this_scx->cpus_to_wait);
>  		}
>  
>  		resched_curr(rq);
> @@ -5669,27 +5725,15 @@ static void kick_cpus_irq_workfn(struct irq_work *irq_work)
>  		cpumask_clear_cpu(cpu, this_scx->cpus_to_kick_if_idle);
>  	}
>  
> -	if (!should_wait)
> -		return;
> -
> -	for_each_cpu(cpu, this_scx->cpus_to_wait) {
> -		unsigned long *wait_kick_sync = &cpu_rq(cpu)->scx.kick_sync;
> -
> -		/*
> -		 * Busy-wait until the task running at the time of kicking is no
> -		 * longer running. This can be used to implement e.g. core
> -		 * scheduling.
> -		 *
> -		 * smp_cond_load_acquire() pairs with store_releases in
> -		 * pick_task_scx() and put_prev_task_scx(). The former breaks
> -		 * the wait if SCX's scheduling path is entered even if the same
> -		 * task is picked subsequently. The latter is necessary to break
> -		 * the wait when $cpu is taken by a higher sched class.
> -		 */
> -		if (cpu != cpu_of(this_rq))
> -			smp_cond_load_acquire(wait_kick_sync, VAL != ksyncs[cpu]);
> -
> -		cpumask_clear_cpu(cpu, this_scx->cpus_to_wait);
> +	/*
> +	 * Can't wait in hardirq — kick_sync can't advance, deadlocking if
> +	 * CPUs wait for each other. Defer to kick_sync_wait_bal_cb().
> +	 */
> +	if (should_wait) {
> +		raw_spin_rq_lock(this_rq);
> +		this_scx->kick_sync_pending = true;
> +		resched_curr(this_rq);
> +		raw_spin_rq_unlock(this_rq);
>  	}
>  }
>  
> @@ -5794,6 +5838,7 @@ void __init init_sched_ext_class(void)
>  		BUG_ON(!zalloc_cpumask_var_node(&rq->scx.cpus_to_kick_if_idle, GFP_KERNEL, n));
>  		BUG_ON(!zalloc_cpumask_var_node(&rq->scx.cpus_to_preempt, GFP_KERNEL, n));
>  		BUG_ON(!zalloc_cpumask_var_node(&rq->scx.cpus_to_wait, GFP_KERNEL, n));
> +		BUG_ON(!zalloc_cpumask_var_node(&rq->scx.cpus_to_sync, GFP_KERNEL, n));
>  		rq->scx.deferred_irq_work = IRQ_WORK_INIT_HARD(deferred_irq_workfn);
>  		rq->scx.kick_cpus_irq_work = IRQ_WORK_INIT_HARD(kick_cpus_irq_workfn);
>  
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 43bbf0693cca..1ef9ba480f51 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -805,9 +805,12 @@ struct scx_rq {
>  	cpumask_var_t		cpus_to_kick_if_idle;
>  	cpumask_var_t		cpus_to_preempt;
>  	cpumask_var_t		cpus_to_wait;
> +	cpumask_var_t		cpus_to_sync;
> +	bool			kick_sync_pending;
>  	unsigned long		kick_sync;
>  	local_t			reenq_local_deferred;
>  	struct balance_callback	deferred_bal_cb;
> +	struct balance_callback	kick_sync_bal_cb;
>  	struct irq_work		deferred_irq_work;
>  	struct irq_work		kick_cpus_irq_work;
>  	struct scx_dispatch_q	bypass_dsq;
> -- 
> 2.53.0
> 

Thanks,
-Andrea

