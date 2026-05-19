Return-Path: <stable+bounces-249654-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +IkDKjOjDGq8jwUAu9opvQ
	(envelope-from <stable+bounces-249654-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 19:51:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2807158353C
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 19:51:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4CDE4300DA76
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 17:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66200369D65;
	Tue, 19 May 2026 17:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HOEA5lBV"
X-Original-To: stable@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010042.outbound.protection.outlook.com [40.93.198.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF4DA3438AA
	for <stable@vger.kernel.org>; Tue, 19 May 2026 17:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779212768; cv=fail; b=PZpFWsVFY0GNNKHT3diXj39YtjQhyt13GFaAzTCeCtU5snjFrM0QrWen0p2s6SelizhwVpUvIlbhYQTc6bOh4AgXRU0u4iIM9J2y5QyE8j7KyJ3RqB9EpxdL0/iQqX4L9I4kRcaytUOeOgpXTb8zIYAUBEf45aI4C9GE5BI8VfU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779212768; c=relaxed/simple;
	bh=oMI2XNSu4SiY8PglFmAc+pxp6/eJ1p2rDp38m6T9sMY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YV+0z81mzuvooXOiNSeAVAfPGyzn98E8V1nrh4jk8J8wPGcIvSfy41Gbw9Yah7oL7VCQFyqUM8hMdFBcoi8pORn2oLj8jek0jCi08UkT9UKcnI1oPpuMX59H5/Ut2+y17SxpYzGeRVH43QfPKjdRlqkd1Xj6wn2eEqwroalQ+K0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HOEA5lBV; arc=fail smtp.client-ip=40.93.198.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IqhuoVPhShMMnLEG1R3Gw6ccJJm2LaIEVK5S4CdnnJF319yYgV8s0GbcXMoGhSQzn2ykya1eJubeSkkBevesFQciSvVIqeqGg0K8IDUpy3QLhCbw5x6gjicB8czFaBpfcOeBWfMachgYFzThLT6xg8XpAxcdIGvDIbQQKzWL9cJzthauMz79iUcwHsRFF/TTZKU81CFaipCLJFHxObsqdkA92a6+bleQbVhNf+6+T6GIn66i8MkC14eHrneBdSx1ZzrioJAGaT5nYp+hGfBZ1jt+sFvJUQGQ3a3rcF84gEnMj/mscveurs4MRwfaP2dk8kwt5/yhoX0szIAxvrb18w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/ZdLWT4ZuNOZ8mhVDAfvF34w326j7CFVPumen/4Cjvo=;
 b=vv+sKNzMP885lR0SLk1xHW+Y7Qw0EOjxWJlHOiA869onKl/woLemdhAe2LUkM+m6MMB0AdgzzMwha22DMH6e0+A/CZj8Ute4qEkvkiodPPcqBZqVeOu5DvAK11idjSw2f5HSeMeJFIZqgg6CzrecvWkLSSJYq849EBFo8XYScLhKWFgEUOZYcOz0tGb51KlVOIMP8NtvGeibM554yuq/JE+KsU9NdMApZdvwza+TsOOn0Qowax1gCe4JTN94HStPNr9Wp5u1aBKsOW8yUqcZim9WhVh/HNUb+J4hsnjXQQUfQkdwOuHGcHEkIYtwcHkjz+QKA14enxDrpGKx0HDaHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/ZdLWT4ZuNOZ8mhVDAfvF34w326j7CFVPumen/4Cjvo=;
 b=HOEA5lBVr7iL02uaG2tOCOHkS4i/yx2/Tq8DSdGXFTq42LbTnozYw+V6uOT5YKiX0Cq7Y9ODYl/yW68dfHkr4BuAyzjpD+rwqNE2bnKvlp5CJJ93umg9vslur+bQiQbtnqB0uBpwdXHjD10hrdyZA54ifRuJegyKD2KOOdsTC4P9KdA4v5FFufwEHSXKi8mLEyPMp9gOqvlOTIjDFGknLWy8ePCMnWqwm5r+VAKRIFia2mAO4qjukGoC5cXID5OS4bPfE8DPaajaSKyddub/stTfH18uydA4b7OypuH8bP4oZA0xYYpSTMgOKh4ryxCPyM9xYA6iCG64oeiduwaQuA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by IA0PPFD7DCFAC03.namprd12.prod.outlook.com (2603:10b6:20f:fc04::be7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.34; Tue, 19 May
 2026 17:46:03 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.21.0048.013; Tue, 19 May 2026
 17:46:01 +0000
Date: Tue, 19 May 2026 14:45:59 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, robin.murphy@arm.com, kevin.tian@intel.com,
	joro@8bytes.org, praan@google.com, kees@kernel.org,
	baolu.lu@linux.intel.com, miko.lenczewski@arm.com,
	smostafa@google.com, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, jamien@nvidia.com
Subject: Re: [PATCH v5 4/6] iommu/arm-smmu-v3: Skip EVTQ/PRIQ setup in kdump
 kernel
Message-ID: <20260519174559.GG3602937@nvidia.com>
References: <cover.1778416609.git.nicolinc@nvidia.com>
 <8de5639630e5723d6f371093cef93733f0ca534d.1778416609.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8de5639630e5723d6f371093cef93733f0ca534d.1778416609.git.nicolinc@nvidia.com>
X-ClientProxiedBy: MN0PR02CA0015.namprd02.prod.outlook.com
 (2603:10b6:208:530::16) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|IA0PPFD7DCFAC03:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b5ea1ff-2ee4-441c-67b0-08deb5ce7d14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|11063799006|18002099003|4143699003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	rZAK5QIxMoK6wM0gbJz9gPHHWyS4m+CRqwYnxzdX82SPlD56KuFgAn2hiM38JqHHhmJxPdCP7q2KDilbt2sotbQdd3DYiJFmtr4G9tNZn1idrZrITLH6YGznBHmoV2kLaP/W50tRdaluiEg1pFem2R++oXRGWwLgsnAWZz11/zEzFZePoNcz0P9TVfdUAbUv2RMa21GJMzmaA24Ilin/G6JF6lknGhu5aIsWMEjnym3SkN+zdsBLrtquIMg2e5A8thVXXfcfBbGqrwvmfPRtjLhoQPw36Vh2DzyYFAkWBIBJeNUU6XExximpKms1VVo8pgITSJawjaP4lPSCAXtuolQUMjE0srA5SEpU9yCwZJ6+W2qt/lR1bBKloSFX5A7Ng+3YgYI7J9VYIPk0t48jpjwYkcOh4MyTqmx1BMXt2rmNCMo2k8JpqVPJ+dUNNk1YFEHQtGV3+e7CwJvW9BuKxtZEPj5skfZ0bUq1XAv/a7k3rohfZqvv8dtNCZamyvWbJgv2antX/c9n3qvBXvUYSK549ak2KSpoeB9eeD9+rGlWynnlGJD1KJfzjDw8jfuzh695cZdfkPKQeaLX1bfqUxLKqzB5I/Kl2dIC8FN+PZE3yTbp7/nkmxVBWbRAcMM09163yl+ezKfegVI7tmDBS8IPZ8g87FAPvablKLUvLma1+ish2YxBAiUoFFgaATvZ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(11063799006)(18002099003)(4143699003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?O5huybD5PyL9kcJSoOrqGsInP0lM/cLh92wElr6rWM5o556JQR9VWsUjMEkH?=
 =?us-ascii?Q?aT7iqNGRp2Q8J60qWCQvgN6uTw/N8pkr01vQXlOPpWdrfDAEYd8ZbODsWLYV?=
 =?us-ascii?Q?WT6oOJYVoFGIhJf25GdPMBmLumw2852DT3DVN+enjWlYWBWUfPMwXrKvSc98?=
 =?us-ascii?Q?7d8KTm5BwYRBVOsnPtSqImvzgul0aBsAA7pxGYmqaenJSKNX1wyKZNEQyLlX?=
 =?us-ascii?Q?9AdClCdAtv7dTfIUw6oOFbvYEokD4LDDcMJhfNR921qbx3feA+f7XsTSET7N?=
 =?us-ascii?Q?nzWHX3/SFVgGXVW3inNB5HA6JJOo94tPIPDR3k3R0S59RmleI2C03IUD86B1?=
 =?us-ascii?Q?S8Moksq6jfW3WBqMTNHGVJMff2iaUEMw1qmUmQ6wHAWISQGtcXCy7Y5uFqYj?=
 =?us-ascii?Q?o+ZxG79Mp/y2je7qXjPOcFMez3ecfhMoxd/Lql8aB2UhC/F5LtGDj5moXjm4?=
 =?us-ascii?Q?q4TKLPN/MMr6XMZDyiysp8+a9KPpqrnqRQtwQEc5sGbkN4kUGPi5Uk/uPoio?=
 =?us-ascii?Q?ruFXZJ9HYp7Xuys88yToxTW6F9JzK0H/xzB1QVnqlGp9et0wr6Anaiq2wFut?=
 =?us-ascii?Q?6zVEOQSU9LBwgkfdmMJredrfjK75rOc12XMJkKX/r/ybHiPDnfFJ4s+4lio0?=
 =?us-ascii?Q?mR7R7EKfaUefxxyjVd3NAB9FQaiqGcuHsVXtFG7BjW789jvMlT7tQoUkeO0w?=
 =?us-ascii?Q?fvggo/wD4o3400/RTt9nrHMYI8ipqatN/AXFHvs/cmgotC5gQTLWQ16GXNPv?=
 =?us-ascii?Q?fBEJT7yBjY1CvSwmie3YuJR5IkusnoTGHnPohOeUzjNdwyuJflFi2t0mlOFk?=
 =?us-ascii?Q?fKDM0qRpKSDhgS0bQE2BHFrcUeQHmtxwJazvf2jER34zIAWwdFOk4aYtrkYI?=
 =?us-ascii?Q?8B1ZK+LpivoJ+/qrNB2c16nyF6w6wMZk333rJprlPbvdxv2qeCyhhU9QdYfA?=
 =?us-ascii?Q?b1gPatNuenk+bmWmkfERGkmerwc45JwmjnliVBmjHx4CHAhgPuTBYa3WeVmN?=
 =?us-ascii?Q?6hLSiKceic0UGiymPkkwdv8fFG+ADHW8L2iNMAqWzCJtXdwACS1Yi2oKF8Td?=
 =?us-ascii?Q?c27WcTq2IheN/0BnD6wGGSHv/efu4Z+l5KqCbiz5AWc45h46W2gQBAq4VxVR?=
 =?us-ascii?Q?7giHLQtdvR3PoRlYV1t+37P3pS8ytk1UcYapEaAe6AhydF9c/tmG3GauDKL3?=
 =?us-ascii?Q?MHTPXw08WHtLs1SdA/XijwsXcgachpFPgK5N7Qo/kORvkqpxyWLyW80AgOb3?=
 =?us-ascii?Q?+Zp6Lf+CPEVfvBesteUHSdKypZsyD8b4wCBd0R4jov3+QOoKYFnfdKgv39jd?=
 =?us-ascii?Q?hisGm8UJ2s2OLeUXonSAldCU7bsztI7mMJ85WbVA6Way0x+rmHlo7ozHUXTH?=
 =?us-ascii?Q?8jLZcPnvG3AMni6dwzK5C23otLTpl74SFIe0byC8gUtkeZJvOVWQ4+ahQdSe?=
 =?us-ascii?Q?EPl4/5ehQ8zWb61yQPI5FJT2Tmf/Au/Jhx+6rlF+8KTmjbi1+Pv2PSgnUVw6?=
 =?us-ascii?Q?Ro3FeMS64+jNj3/LeA3khdZjg44T/319o0dCfIDv5LAXNVhRTfIXVz5Um0H2?=
 =?us-ascii?Q?OBH7HWwjiIquF8SrJihYCWcENdM1NxAsVBUUYb6IeqKQExqri0zFIJ4rn5OQ?=
 =?us-ascii?Q?a1j4ZXpNqiJH4VbEtrhcdJyYIEqm0aNnp23zicj2IKjR/R8CVviFU5LJqGLP?=
 =?us-ascii?Q?u64cMGnAk2V5fr2sbdf/vefBc0LFfGONkzSjGbAZo1mCsvDv?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b5ea1ff-2ee4-441c-67b0-08deb5ce7d14
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 17:46:00.7779
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nwlVnSMPhNlgjfnPPV83gtla2zvYSORQ7cOTkT/Nc85AVobhs/sj8kkYWqbForDj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPFD7DCFAC03
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-249654-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email]
X-Rspamd-Queue-Id: 2807158353C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, May 10, 2026 at 02:23:03PM -0700, Nicolin Chen wrote:
> In kdump cases, the crashed kernel's CDs and page tables can be corrupted,
> which could trigger event spamming. Also, we cannot serve page requests.
> 
> Skip the EVTQ/PRIQ setup entirely rather than enabling then disabling them.
> 
> Also add some inline comments explaining that.
> 
> Fixes: b63b3439b856 ("iommu/arm-smmu-v3: Abort all transactions if SMMU is enabled in kdump kernel")
> Cc: stable@vger.kernel.org # v6.12+
> Suggested-by: Kevin Tian <kevin.tian@intel.com>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 43 +++++++++++++--------
>  1 file changed, 27 insertions(+), 16 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

