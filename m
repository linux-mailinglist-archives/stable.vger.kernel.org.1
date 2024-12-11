Return-Path: <stable+bounces-100627-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 592699ECEF8
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 15:49:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 560901886CA8
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 14:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F335199E8D;
	Wed, 11 Dec 2024 14:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=digi.com header.i=@digi.com header.b="dKndCu5P"
X-Original-To: stable@vger.kernel.org
Received: from outbound-ip24b.ess.barracuda.com (outbound-ip24b.ess.barracuda.com [209.222.82.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C573195811
	for <stable@vger.kernel.org>; Wed, 11 Dec 2024 14:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.221
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733928547; cv=fail; b=bPuElC/mU1A+sZCs/kMAZzxevjeD09JHWSxkSlnNEiDgXg2VcnOg6gCwubh6t3qpoqhRvkEb4E91njTlhKeo6JHE+dJNxQKepWyuvx2pEHwAomGQUiVPVLWY7yzUwaJxjd+ITYM9QmhqsO+5YnkDGQW9n9T6zJ97Ae9h69fQqL0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733928547; c=relaxed/simple;
	bh=kOWQIYJKHf01kIWdB1KE07+7p/UHyCTLGXfqWBJXkl0=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=DHlN3AR0Z0rKhpFkgKNnOOsCr++yrO/Sj96d3/RB1QnrwsqufxOPoa+BB+YCetKPySX7VwRpu0JBHi2KRcQmTTZ+o2P9aARGkz908EhSyMh7SSp8SSEG2V8ie1xE6VzaO0bPR8pBpc6HoxfWUbQ+yF/8VhhG5l7LNE5gIHAUVuY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=digi.com; spf=pass smtp.mailfrom=digi.com; dkim=pass (2048-bit key) header.d=digi.com header.i=@digi.com header.b=dKndCu5P; arc=fail smtp.client-ip=209.222.82.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=digi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digi.com
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2047.outbound.protection.outlook.com [104.47.58.47]) by mx-outbound22-27.us-east-2b.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Wed, 11 Dec 2024 14:48:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u3dYJ7ZKqwlhHer2dcOZHMwkZfhPT4ELHWHatgFOke8F/APo+RopScdrexQcUZyFLOA5pFYyoswWygONQ1QFEOQMCN/Mbs2LzSqiq+W6JBdj83Zd8WmIHl/pkCjcx5zugO5zyeHPsTSF7fb+0O3/ETZiTbEARyaXfGPU6KQKAq6fkvVpgmveZPIixviMTaJ7lej6429VG5z0HsbnpwgKB0GbPd4BvRKUO/7VzCGZ32f5CYJ59zmjNNMe6fmdfZza1MRQ41KrX+54TaP/rIlUUa5IuntwjUXxHEZ4bid4a6uGl0KYZ1lloiR3CgOxi59vlNX6urC3KRJqhoBWA9+6Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/dS3WOnmLOszx5DbYaxjrsIwX9m9SbHOM1RE9ftZ2wA=;
 b=I6qpdLQjFlN0T93EOI7beWpBUkkcKQ7ZmJMmSXyhcBnXOWT0duDyn+mAaBTKPBByOAIEG8U4xYJHcNrKwcFNVmCibWnwQxU5eslytwalaew7xSUY8dFxerVKfWOKy7IT301544wDGWNbW5EkDNBS4I9SK+qOwtOWBEl8DfzpZfsR9XUYhaTBSzcXvBlzPGsnyCBWHNKYske1b9d5JfQ2I20DinDJzCIVdFpVaHpFforJXF3uP5fcwSxaWYz8hzw8cporISFyzoskjmrxcZF3LNTzPv/Ljt70k8NbmI/G7jRiL9FLs4M2fqluw753JO/sxjIkjwNm2rkqVQ7Vc5O6Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=digi.com; dmarc=pass action=none header.from=digi.com;
 dkim=pass header.d=digi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digi.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/dS3WOnmLOszx5DbYaxjrsIwX9m9SbHOM1RE9ftZ2wA=;
 b=dKndCu5PQ97a0DOFaA6hZVTCaTyZ3YvV9iyTsE4cZLzkeajnKtHeuHlq3OcYUqix/dufmPtD+5fMlwXwLNUBAPlyPNXpBekSDljYWGulrjBCLkU3aF/oGeh2gfQqsPez7l2vGglq82LkCknz/psBDz1sm+aCalNOnqx8UPtq7dVjcKh7P3UhyHffrwlijEvH6rasPDwEVBR9LTEjDYeHm1Ol4tAo43TFm3enKkjW7PK7+/UJOsYesHkhrKEqUMXchvZgznINT7tl6GZzmDcffdsyK3P5+keCDR4P3GfRG3efox8Oa00RsN1MvURz5bAodetrj4GLT3sNdlEpx4c6ww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=digi.com;
Received: from CO1PR10MB4561.namprd10.prod.outlook.com (2603:10b6:303:9d::15)
 by CH3PR10MB6835.namprd10.prod.outlook.com (2603:10b6:610:152::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Wed, 11 Dec
 2024 14:48:09 +0000
Received: from CO1PR10MB4561.namprd10.prod.outlook.com
 ([fe80::ecc0:e020:de02:c448]) by CO1PR10MB4561.namprd10.prod.outlook.com
 ([fe80::ecc0:e020:de02:c448%4]) with mapi id 15.20.8251.008; Wed, 11 Dec 2024
 14:48:09 +0000
From: Robert Hodaszi <robert.hodaszi@digi.com>
To: netdev@vger.kernel.org,
	vladimir.oltean@nxp.com,
	claudiu.manoil@nxp.com,
	alexandre.belloni@bootlin.com,
	UNGLinuxDriver@microchip.com,
	andrew@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-kernel@vger.kernel.org
Cc: Robert Hodaszi <robert.hodaszi@digi.com>,
	stable@vger.kernel.org
Subject: [PATCH net v2] net: dsa: tag_ocelot_8021q: fix broken reception
Date: Wed, 11 Dec 2024 15:47:41 +0100
Message-ID: <20241211144741.1415758-1-robert.hodaszi@digi.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-ClientProxiedBy: MI1P293CA0021.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:3::14) To CO1PR10MB4561.namprd10.prod.outlook.com
 (2603:10b6:303:9d::15)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4561:EE_|CH3PR10MB6835:EE_
X-MS-Office365-Filtering-Correlation-Id: 03c3c6ea-93cc-498e-b181-08dd19f2d46f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|52116014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KGCZh7j+KIHF9om6IkHPjQ8NyO5x8XbDr3CumgE4sh6FsHTL40c2PH8I8Zdt?=
 =?us-ascii?Q?qezWWsMkLteMNNbetWfi5XlMmaJxPKtIgKCgqsGdJiaUo+l8IsAru8cidMbT?=
 =?us-ascii?Q?bjIpa8eCJSw6f01CHE5ElJQDKn+LJm/c2LVT1Z/SxXTFg5e5oQkLaT6X1SxT?=
 =?us-ascii?Q?eARuB5a7ou+aFkFODJDBcify5hEmtvep/fmGjB+yW+YxbXK91+MSZrr/p3HJ?=
 =?us-ascii?Q?G2tnA36chD+4YBHvrOHMSd4RGqWzIgH663mCGIipH5k73+j1SAwuIPq39/BW?=
 =?us-ascii?Q?psEVS/9ajqnke1qsDQINazxrt0wV4lHXJvtXL1NYXx0p2ECt+uRwXH8KnnMU?=
 =?us-ascii?Q?7MNQ3USVOsJCOI8dKQQ/W2UWMBBdmAwjJIArbHIPn14eDW2oEAz7DFQZM5aN?=
 =?us-ascii?Q?SR0kRprUxdBdJmYyrlUlUul/dhsd1Gc7dvjcN81SDeH+AvFOYOaZWWdCKW7H?=
 =?us-ascii?Q?gavRiLxEuEwocEgah0Q1MWpTJxZcRDq3dt3ZBsXwCTRuGLxWC5+N/xD0wE/U?=
 =?us-ascii?Q?XthJg9XIYXLtwOH9rxUDJGnAN4czCsqe7fU9fDpLwPChvRmYUODnWAuIsfcn?=
 =?us-ascii?Q?dHzOat2Zlu8J9OcoPZu1W2vBMenw5M6Emx2iL9p0X3b1O3GufBxXYvQArO9h?=
 =?us-ascii?Q?ojoG8IQX/tpD13AINqIuHVXGlLb0BkML2VM1BoycDLjAEdSRX3xYbDzlhIgd?=
 =?us-ascii?Q?jX6BN+xb6osHOQnHATUkAE0fdVu7b/QS/TJCH4vCACDdEEI1WWOShCTsQ3kS?=
 =?us-ascii?Q?T8thfBp0OApfFAZxM2TQJLcwqXrGSJhR92dcWbmete6ZfiH3BUjymTANM/Qc?=
 =?us-ascii?Q?/CbOfbPcQZhHnomrQBmrsAHSj3k1QvslOxcLWPHkHkQgevYAH28cnsAlYuat?=
 =?us-ascii?Q?KAiHJsuzP06APwW+PbWDnPZ8/oB+54f843ttCDO/W5KWd+lLSJZ82PgqJ4U2?=
 =?us-ascii?Q?ZjvNDIyZbADIu2gHlK5x3VtVxGoKJObd2qQGMb2/SqGtBsvXeOSY7SJtEStl?=
 =?us-ascii?Q?qLAA7ESpYSYA7XlBi+WnE+MmuZ8/nZZZFR51UrXF3dEUUKJYz1yUJPMvcEwM?=
 =?us-ascii?Q?HdG1dBNZzYEfPzMojy2Cky+Ust3Y+wcdAnu1cNiI4zh9rDVdaRSh6hihiMvG?=
 =?us-ascii?Q?ptIjO9vq6oA5JEtfsy1jViZE0DAriRTA4MOOaReFglJXAQ6xfEOFtrqSpEsp?=
 =?us-ascii?Q?gYUK6aW7XJ6K/WuVDIVo+4ykHcI4h2/0MBJbD1TnfNdHfN88zoUe6zUJWimL?=
 =?us-ascii?Q?+wfY3TRFtHKLWRTlc49MWX+RrcxltmcM41uxwuSlrZu+eBXyNnFfET6A7TbX?=
 =?us-ascii?Q?vipBDpgwrmDmygHwyzOahQSzV3+xk5gN+u0pABtGueKUshCnY2g2pJXPfyU9?=
 =?us-ascii?Q?GCGTZnhJy+maR/JZAQlw8DGKLZWhH6PhyXOm9z6znGbMuto7GkbbB4sZ9D+Z?=
 =?us-ascii?Q?ho+Undv5ACY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4561.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(52116014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sUmR3SePA5rgq+JS4gXh5xT6iRri4RhWjkmtVa+npfclaxZ7OCI4IIbVJ7Qv?=
 =?us-ascii?Q?kBV0RxpJsePKyEI1rn2tQhiHs34UFKtusfooRII/ZL6OPOUcvr7bPvePkyDh?=
 =?us-ascii?Q?b7N+jXDM+Cr9X4uc2Qx3R7NAlq74s6pBAIrvJ4E1YKXcJx91qHGj0E0Q6NCJ?=
 =?us-ascii?Q?6DaPaww2Mzt3nzZgang02qjD6rC5b/lS/cJD9noYzFFdnAMTfGSa4vEvBhEL?=
 =?us-ascii?Q?8bNxUQgmgVKYuzFtzMdyXT88JETyQRnu0OIchSrsSRYdHTf6rMC3J1QO5s3Z?=
 =?us-ascii?Q?3vh7vM72M0RcnDZQ5Dm8JYtcbQ3N8cq2r73pNvqhIMw0/NbBXBbtM90qK9Ki?=
 =?us-ascii?Q?hU/w7pc8esnUO16ugl5XaDNO1+/xhOm2Tz/3qD1IukCsqzmuVyN/MyKSygcU?=
 =?us-ascii?Q?AbBXK+TNG7W9y35HBawZ4n8xotRvgBWi8BLCSs9pkaFVlX8vRVOrf5aRucSR?=
 =?us-ascii?Q?L/u9KfxLCa4lS1IZ8aHC98jgw1x74ge0+15Upk8n9zHTPdOWA+C5sHIiT95y?=
 =?us-ascii?Q?cMh1RTez8n/8kkZWd/SDrmhi43+D7wpn9C/hH6gzqDj+YMXyZIlX+HVbq8+3?=
 =?us-ascii?Q?RoaNjSJjUBgv2HBZGGqfY9LNXjEfgeEzTlu5uiHpu72/ONJF3EluEvF7cN30?=
 =?us-ascii?Q?+xiN2SEUgqf6VyyYGctcQix/3S4q6ddmvvLl0TTfIadE5kjuHSuVwyuMS1FM?=
 =?us-ascii?Q?OPQYx4Oq8WbmmWA/bsLwQfDq2AKohcxfNscSyGfOBcEASMwxBytPK43JqGiN?=
 =?us-ascii?Q?9MA+YLNAokfIuBEvhfvGlX1iP9mQmYf62EfSJbXV72th61tjuBMRztO1VrWJ?=
 =?us-ascii?Q?AkL1sVHrN34oebRHkACSMEz3XxkAh5mMCGHmBuLtC5maGJS80jYZC/tXGXNi?=
 =?us-ascii?Q?wlAXjICYwRxUcqASw8uLHoq0XO5RzOiEl4edRvN2z4qMpuorgmzCX2xTNHLm?=
 =?us-ascii?Q?fxPFY0zF1kSsSdrKrZm0t/6eWsYDwo+QMeHV0IDgZPelDnbdZ6SMiK82UKtB?=
 =?us-ascii?Q?SVvaux8t8wPf/cLx1spTuxiOA3pCB0ExQi0OxGNTqjfLSIqMYMi75BS5UB9Q?=
 =?us-ascii?Q?5X1a7TjyJoSQpH/hLdWslR7yHbpAhaNeOtZCXgj0ZYbbIAiqNrHyvBiKXZQ2?=
 =?us-ascii?Q?bw1seR4nuwhvbjcbnwMVrDirZZZgX0dIgwkyTEK5YtFdHIyx17sPE+2e9ShR?=
 =?us-ascii?Q?S7ChbHBUWnHyA6xlVtbQ30oS2WRUvYN0LiSKh5Qo+N2UgKCgClEA2hc+Qxlz?=
 =?us-ascii?Q?Dt2ITl0rGZjweJcF2W2DvvUbjyyJINUteyI2pJg9nN7JbLM2uNnawX7jjY4X?=
 =?us-ascii?Q?0S7MRkVxZR0f9zh7QigwDjoGzW7sHM2J2N5VKltiaVVzVmybkSQ1t6jqv/xD?=
 =?us-ascii?Q?2rUvRKUNlCSFPSBm+Nc0BNKCDKXtXTugEiwITwxvur3TICFN4YgByLJguwGA?=
 =?us-ascii?Q?7297yuKleBqTrRUpwrpnPYezGT1/0oyrWX9oW780/SykMB1xnSPhPCjO3kCQ?=
 =?us-ascii?Q?2iy2e4yoeGdW166k85z8hq8dKdo6sWpBAnQ+fg3UTOfhOU1wS8Ty75eBZtJE?=
 =?us-ascii?Q?gzb/vYx2lYZP1YkchB373LyxZvrQsLw5di49pZvf?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 03c3c6ea-93cc-498e-b181-08dd19f2d46f
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4561.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 14:48:09.6315
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: abb4cdb7-1b7e-483e-a143-7ebfd1184b9e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BikEa1w2DCpCo87KVqYfUcBfzdgwHiy0mebQwmnG7DSLl4FH1x/BHuCmKfLhP0GlJO5hUa7MKH3ZedAW9ro2EQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6835
X-OriginatorOrg: digi.com
X-BESS-ID: 1733928535-105659-13563-13636-1
X-BESS-VER: 2019.1_20241205.2350
X-BESS-Apparent-Source-IP: 104.47.58.47
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoZGpkZAVgZQ0CI10djI1NzUJN
	UwLckk0TjRwMgkKdXQPNXC2MTAzMxcqTYWABllJuBBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.261038 [from 
	cloudscan18-112.us-east-2b.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
	0.00 BSF_SC0_MISMATCH_TO    META: Envelope rcpt doesn't match header 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS112744 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND, BSF_SC0_MISMATCH_TO
X-BESS-BRTS-Status:1

The blamed commit changed the dsa_8021q_rcv() calling convention to
accept pre-populated source_port and switch_id arguments. If those are
not available, as in the case of tag_ocelot_8021q, the arguments must be
pre-initialized with -1.

Due to the bug of passing uninitialized arguments in tag_ocelot_8021q,
dsa_8021q_rcv() does not detect that it needs to populate the
source_port and switch_id, and this makes dsa_conduit_find_user() fail,
which leads to packet loss on reception.

Fixes: dcfe7673787b ("net: dsa: tag_sja1105: absorb logic for not overwriting precise info into dsa_8021q_rcv()")
Signed-off-by: Robert Hodaszi <robert.hodaszi@digi.com>
---
Cc: stable@vger.kernel.org
---
 net/dsa/tag_ocelot_8021q.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/dsa/tag_ocelot_8021q.c b/net/dsa/tag_ocelot_8021q.c
index 8e8b1bef6af6..11ea8cfd6266 100644
--- a/net/dsa/tag_ocelot_8021q.c
+++ b/net/dsa/tag_ocelot_8021q.c
@@ -79,7 +79,7 @@ static struct sk_buff *ocelot_xmit(struct sk_buff *skb,
 static struct sk_buff *ocelot_rcv(struct sk_buff *skb,
 				  struct net_device *netdev)
 {
-	int src_port, switch_id;
+	int src_port = -1, switch_id = -1;
 
 	dsa_8021q_rcv(skb, &src_port, &switch_id, NULL, NULL);
 
-- 
2.43.0


