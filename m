Return-Path: <stable+bounces-129738-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 438BAA800EE
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 13:36:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8314C18871EB
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 11:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D15DC269AF3;
	Tue,  8 Apr 2025 11:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="omvzKMsP"
X-Original-To: stable@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2041.outbound.protection.outlook.com [40.107.101.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E33BB268FF0;
	Tue,  8 Apr 2025 11:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744111845; cv=fail; b=A1dHtwIXAGSz6XbGgROWOs5PIwfRm4HRM8/7GX0uWD+k81DcNr7CknssC5nXC3i9wlam+U8U5CKV7iBtRVa+IKmLsg58mK6LZ2IyOzmo4TnCDBB7U1XSk2mzziKuSvfJUiC5nKoFm03Ba+K+pMm3bm1EORwiV0W46hj6Aj6t6io=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744111845; c=relaxed/simple;
	bh=d4QiF1bRGJAPwLt2z7XoVynXRWtMtY5sK0PLbGz6xJU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TCgMW53qUiC7gZi811nKtv/jzt25rwVv5uoav+kancBgd+1l7eq8zvGpKkawyvGv4E13SNGR0lTHX7OA1gM9INGZqGZp3/v0CRiicqeXRShw3g0eNbMu5/VUjBf3qwCRJa9upJJ03MgDOS7/nqOBIpRiUsi2MGoCNif56x3Qqi0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=omvzKMsP; arc=fail smtp.client-ip=40.107.101.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LewIMllQVp2PEWIieHxMXxhvFA0sQ/B9RXojw25Mz8bW9GMzk0qby7zainzP13YnA46gDeNXZY5TPN84VhAL4YNr4uZxRzMKznMY9eCaZcKVzMABkcwiEQHVT0k3sq3Yy0mjjFKMbA8cMlY6bVKHnocs5RNhdZ8K6R8Ca8I/0qLUwR5xDXtU37TYYOKn6e4wITy25VDL2qRup8KHggaWe3Ay3Jz1eF+iaZCWGoQuCn7BmISi18Aw+I1j2EgGL3oIsJKc5nrpTlfFk3Po/eMvpDgOo0rLwOrQG954ntmKBbFXwCE0WN1Lq3WmXSE2/UWN40bTTQtrwyU80h9KLx+LwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oyBuikXB5lbLdu0dAPm3vzGUe2jagFkcJggJ73Wv5fI=;
 b=DUwetspAGpuh2RCLPN7yopVdDjZWMFijkC2yWbsV1/YaEgdhbRyGFZmFpxUkGii0plhbHOITxS7ij+0LU3Dbri/wUgGSfCYpVYeKcaCcq4o1UuqdSu/hZVty4Sc49pcq4PK8NfckKZ4pbbwuZw05Ccl1ek2johk1jG8tpEOzPoUsamg04O3DU0rfgCbd4w8NjILQKWclSINTtYb/blE0z04aX+Io/A+QOSGS1HbSQJnVvbEPVdg8XRgQR0dMbbp1YoalfRxMW8lpqZbvNXPl/fsZt8ttX+Y63prTgO7Ca29OhlsGbI8Ekg1GwUoIYv5FLDp76V6uA+Iu9fk5TNp5rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oyBuikXB5lbLdu0dAPm3vzGUe2jagFkcJggJ73Wv5fI=;
 b=omvzKMsPoPlh9B9+NOPClxjDLhLg5fBot1xlyi2e+3JovmZgCLCaB5Mr14IMB0wA/7oSISEurmqQjWqjDzHhEqqXF4T+HPPsMe/fMfgemkiyQmzyUn3n6lDcet79zFyNdalobo8kBFQmk/M7jyrI/ZHJNvjz8avn5L1LIzU14vAJPmJ7SFYiqTYLdHHgi5Ak+XWcwmsEewR11GoT3jlNzyv/uCz3zd6NSNQaJbodcq8SUUFKvFn1XQjmVedZGOe3oK/Ur3yeN6MGMHqcTpphyXbl0/2Ql6L4VvIlFPaf8K/j8rAmNzzSlOVd9b8+fdph1vum+rkFeTlD92VsJLzk1Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by SA1PR12MB6919.namprd12.prod.outlook.com (2603:10b6:806:24e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.27; Tue, 8 Apr
 2025 11:30:40 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%6]) with mapi id 15.20.8632.017; Tue, 8 Apr 2025
 11:30:39 +0000
Date: Tue, 8 Apr 2025 13:30:32 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Breno Leitao <leitao@debian.org>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org, christophe.jaillet@wanadoo.fr,
	kernel-team@meta.com, stable@vger.kernel.org,
	Rik van Riel <riel@surriel.com>
Subject: Re: [PATCH v2] sched_ext: Use kvzalloc for large exit_dump allocation
Message-ID: <Z_UI2AHtkIGS4bZR@gpd3>
References: <20250408-scx-v2-1-1979fc040903@debian.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250408-scx-v2-1-1979fc040903@debian.org>
X-ClientProxiedBy: MRXP264CA0003.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:15::15) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|SA1PR12MB6919:EE_
X-MS-Office365-Filtering-Correlation-Id: dee2c4c1-b8ed-4696-17a5-08dd7690ca3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MX4+50kR/xy/0rnS6kc0IqZ4AWxTw0bt/e6wYkCxfxeEA7Dn4mZiUw44lMDn?=
 =?us-ascii?Q?AzOvffXoCLAfqBrL6n2Cx8iRe6ZzX3ya/jweU89ix0kzik96TN9w8F8zETi3?=
 =?us-ascii?Q?sktZAjU4ToLbzvIdnZWNaHx1juQzFhsxC8I9Z7gFp6bUYluvYBUVrC4XSx5z?=
 =?us-ascii?Q?TawZc13kNxyjB0OPykacTnpVpqgPkl9baCeBvXfZMFn8jMc5HIsb4RGwm9cE?=
 =?us-ascii?Q?Qxd/KI0w0bg1PM8IT/sVSw+eTxJOFoFdtoqHPPDu6gfE0inOltnTjc8g/jKI?=
 =?us-ascii?Q?0qulizxHfW82xCRqgRgb5gYjcqP4vGmIri5ELCbp8OaSCMzkbo9lpao2qaIf?=
 =?us-ascii?Q?kvC88DnoNDf2ZNGVRQqZ7PGNzRuJXCpkKQUBd7xy/Ww1/BEjYOszIj5NWF7R?=
 =?us-ascii?Q?YFj0hZpvWBNGA1/PG9CnIqAszEhxGm2drJ/SUuhC2W98gG7mxZvfZzCqCh1P?=
 =?us-ascii?Q?Wa59isNhgFMAaei1xyuQLDrA9kw3qw53z4CPuSoc7hfO0cZ/np/igr2IOHCn?=
 =?us-ascii?Q?07hyG+rxYhPdDwHn4fEeUCKLQCjsfevjpKMpeAndqZ4AKAhmhMxWSGe+1jek?=
 =?us-ascii?Q?W+moQg15pluQK4E1fs8PB9Qzfde4X8pgA64FhfsucAt7dKgK9UZRTr2MKOI8?=
 =?us-ascii?Q?SbPFd7MQIa6VeKtephG6bCFRgyCO0xjzb5wNO46M3SuYe+h1/tlM5RkJEvpe?=
 =?us-ascii?Q?OzH7qmuz5+aSa2UGpctz5U4vAD/2c/sX7nXRwAXHlGeIQARoXvGatJbg5ja8?=
 =?us-ascii?Q?OCZllqG0MjQS0RqH/l2rnjyHu+PPd6XGjLH8SdBEiFiIoYcUSnRjzsKKt0r7?=
 =?us-ascii?Q?JSgRXFA1/KSjcRUDirJksSAuzbEmQ4F1JmHZqgGaUKFbgiXuB+dzyrgtNfXb?=
 =?us-ascii?Q?9newZ6aIhaCzcNk5ZTTYUmy9wl75pJeLx2wI7cwcNDA/V9L7VGNmGywkFUpc?=
 =?us-ascii?Q?+Ly18c52x9qx/mU1dwY+hxULlK697DGn/+2IlnUlvD02EYJsofrjLZqLkdrO?=
 =?us-ascii?Q?Cg1HtDvIXmOXiN+jmpaTFaZuC4QLwdbb+B9u0hj236825sD+XfNXtmrJo6wk?=
 =?us-ascii?Q?5GgItCmTQPH//XgbNWd9FlTB09YDHvqKoRyITT0KxWFRX6R/OkZ3JbQs0ars?=
 =?us-ascii?Q?0JEhXHLD+Ki7jd8UTz1ZRlRGWr6mn6pHJU/7sK+qgDcdmL8yixriJWLt+rOu?=
 =?us-ascii?Q?zgIEecmUV0iov98mvkZlHTY5NORfg8GYaiuRo+Ye0R9vfXo1gn175vNiEykv?=
 =?us-ascii?Q?QTavI2WssasC1Qm1uCanFj8J78f3B1UZR1bwvBVm+bco+PaO7+zsmfLDvMch?=
 =?us-ascii?Q?Mmfk4wDKyAx/XXqjoiaJeDVTASoda6av9lqdD/Szz5X0Qh5Ckdb0SiMHqsRJ?=
 =?us-ascii?Q?zddglkBs93apqeKt9z8ymAtKPU0L?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tO3h3tcCpXhJLw5sOEyf0hKUexMlT8+cp3Ib+mLVPpgCw147eHDDrsc0fOT1?=
 =?us-ascii?Q?VFEppaMBu+B1kNRBzq9JAUbk33PG8BAlFuetHuKB/2v5I9lTDNqexLPkwEIo?=
 =?us-ascii?Q?5oWOIgBk9eu73nIvRxbuvVAdZI/+nqhuY/vzeiiOZ8JSzPb3Tkc63+VXEZZP?=
 =?us-ascii?Q?zz2RfNOesd4PLkjCDQXkN1+hTWhpsPzx5bflih40XTtlziNrfG4Ucc8Zlkzw?=
 =?us-ascii?Q?Gf2sw0OlNoPf5Iwn1UvLHkM7/N95eOd92SUcxL5qtV0cbP+jFUnKA/bfHiUQ?=
 =?us-ascii?Q?QElIgjkaHoTf2tSSKTcxjL9EtORJAJNhG5Uzr21mzXyam8iD4zcdDL2BOPkN?=
 =?us-ascii?Q?FSC1Th43atQoSM4uyYTkZ8FUf0cJaHNjLPoiG4K6sSssgVTm67zX3IEumXJy?=
 =?us-ascii?Q?TLplXxlGmG/I/48h2jII9JGmJNHfI+AFFYEnEj8gfVnxtyHIl6ZC+WIhYPBL?=
 =?us-ascii?Q?6cGxN5Yo919bwfuix5Y/Q5jyu10/Qbo7HWsQrW6YvhLPYsYGTfdlUtDB4Cq0?=
 =?us-ascii?Q?SV185MxaGu0KT1hKsxIFVtMseRcWA0RB8HTb7k/sh1FYECw0MXs7//DUR6Ur?=
 =?us-ascii?Q?aYPFdiDeDzN0zTuQbv1hPlOOuNepK3mDOnjyPUioQCtzaBEYt25OrX2Nhwgh?=
 =?us-ascii?Q?mfiJ54ZeppYwn6+RabXz17QECBAY+U1rXfJU0f8DvszMIJ2clKxNnOJKxsaM?=
 =?us-ascii?Q?sBEothLtgxp4j4q/kDDlru8/87+hngmSlf8LYUX3PI0k3Dab2U8CF6XB30iS?=
 =?us-ascii?Q?VTChLbLOnZUJG7++2e038PRDZve3H/saTKiHvn8Cm5x9VHSYF1KSZ63ab71L?=
 =?us-ascii?Q?BAcP1YU14ln1pabvpc6X8X6b0gCfM8IJLxXxsKy+878cCKJOhxq+ymTIDea2?=
 =?us-ascii?Q?HFhIMVyyo25FZwd6dnTpfNpgRR2wF9wXfPLLR3yaWXmbugl3/dIufHMdS16e?=
 =?us-ascii?Q?wO+IpJbANDO4O+3EJhZsCVVfI0DzVkCdT/YJj8KCpf4pPcFPnlIcPUDt3RPY?=
 =?us-ascii?Q?YDD/HEaR3S3j+7pGYUHULYNZD4Sy8Zhf2Jg4gQQHNS78P5m3yjwFyLFz5tpV?=
 =?us-ascii?Q?CXSzNKTuKbNERYvw5uhXspdEr2VPYQYZnR2Jn+s3bBYP+oKbqPnoVLyMwzcH?=
 =?us-ascii?Q?pD9NoSac4Wxil2NwulrGx1dCJFfhOEATLqAutOdIXNeeKR3rZMZVfHtj4eLS?=
 =?us-ascii?Q?a1JgMuaYPTsT2Cxme9AkdF23keES6hdfHb027kitN+cBMRkrBxO/guHb2ko/?=
 =?us-ascii?Q?/5W90t+QUR84kgcfC8U8BynkVNSXptr5nlqVZXCgI+gbrrGwy0mBgqemg6Zd?=
 =?us-ascii?Q?AcCaQAtEWHEDLGfgFqbsiwfxJk+soede7u0LQoWTiF77icqRDHx7jIWOSkef?=
 =?us-ascii?Q?MrESsEBMKxaQMj7mTWSVsDqoPhT3tYMtkVk7mEQs2utenwIcXB51BnahpUWd?=
 =?us-ascii?Q?av3DA/gOOUIVWxEcCNb5leUbN5yZangjq23ZPRuWubsxoWO7c535fyluKVfW?=
 =?us-ascii?Q?jAAkiQMzoUhG6O1056RKfZ6x1emdNEQKD2+CddgbxZ5cW4MspOAn+r002elL?=
 =?us-ascii?Q?9l63Or1lIdp6FtEh++t+k5DMW3KvY1V/QGODqxo2?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dee2c4c1-b8ed-4696-17a5-08dd7690ca3f
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2025 11:30:39.8437
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iJfID7zNFky9yem+PDi9ys3g7h/zThT8MTyEymKwa9weh9Xi0RFPVP21JyMDLs2tjPc5x3JGeinxd3/pEiHkVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6919

Hi Breno,

I already acked even the buggy version, so this one looks good. :)

On Tue, Apr 08, 2025 at 04:09:02AM -0700, Breno Leitao wrote:
> Replace kzalloc with kvzalloc for the exit_dump buffer allocation, which
> can require large contiguous memory (up to order=9) depending on the

BTW, from where this order=9 is coming from? exit_dump_len is 32K by
default, but a BPF scheduler can arbitrarily set it to any value via
ops->exit_dump_len, so it could be even bigger than an order 9 allocation.

Thanks,
-Andrea

> implementation. This change prevents allocation failures by allowing the
> system to fall back to vmalloc when contiguous memory allocation fails.
> 
> Since this buffer is only used for debugging purposes, physical memory
> contiguity is not required, making vmalloc a suitable alternative.
> 
> Cc: stable@vger.kernel.org
> Fixes: 07814a9439a3b0 ("sched_ext: Print debug dump after an error exit")
> Suggested-by: Rik van Riel <riel@surriel.com>
> Signed-off-by: Breno Leitao <leitao@debian.org>
> Acked-by: Andrea Righi <arighi@nvidia.com>
> ---
> Changes in v2:
> - Use kvfree() on the free path as well.
> - Link to v1: https://lore.kernel.org/r/20250407-scx-v1-1-774ba74a2c17@debian.org
> ---
>  kernel/sched/ext.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index 66bcd40a28ca1..db9af6a3c04fd 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -4623,7 +4623,7 @@ static void scx_ops_bypass(bool bypass)
>  
>  static void free_exit_info(struct scx_exit_info *ei)
>  {
> -	kfree(ei->dump);
> +	kvfree(ei->dump);
>  	kfree(ei->msg);
>  	kfree(ei->bt);
>  	kfree(ei);
> @@ -4639,7 +4639,7 @@ static struct scx_exit_info *alloc_exit_info(size_t exit_dump_len)
>  
>  	ei->bt = kcalloc(SCX_EXIT_BT_LEN, sizeof(ei->bt[0]), GFP_KERNEL);
>  	ei->msg = kzalloc(SCX_EXIT_MSG_LEN, GFP_KERNEL);
> -	ei->dump = kzalloc(exit_dump_len, GFP_KERNEL);
> +	ei->dump = kvzalloc(exit_dump_len, GFP_KERNEL);
>  
>  	if (!ei->bt || !ei->msg || !ei->dump) {
>  		free_exit_info(ei);
> 
> ---
> base-commit: 0af2f6be1b4281385b618cb86ad946eded089ac8
> change-id: 20250407-scx-11dbf94803c3
> 
> Best regards,
> -- 
> Breno Leitao <leitao@debian.org>
> 

