Return-Path: <stable+bounces-100631-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5E609ECF3C
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 16:02:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6828D281036
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 15:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3252B24634E;
	Wed, 11 Dec 2024 15:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=digi.com header.i=@digi.com header.b="SA+7fgYh"
X-Original-To: stable@vger.kernel.org
Received: from outbound-ip8b.ess.barracuda.com (outbound-ip8b.ess.barracuda.com [209.222.82.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18871246343
	for <stable@vger.kernel.org>; Wed, 11 Dec 2024 15:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.190
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733929369; cv=fail; b=Drhb3JGJKfMJCzk4P+047/Fom62QcwPbt/BzaXAxXS8XOkFOAFg1CfoyedvoTCw2/tAzHByrhhvgvC0XbyVH7v7VTT8sDzs+F8YP2oJIaoQfQn965xVidEREOeLs+gj6Ki3eFlq/NOgi3FNrBXwKX6f1dQkQuu8u6fFMMKXVt9w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733929369; c=relaxed/simple;
	bh=hAycvSR0W+4PdAY9mog9WwtUwoBWPszeWSQcU6FdX+s=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=U6s59kBLvaICvU2JeeQUgsb9WfpCkDFkyDFcM+SV6MyuJB31xeJYmXlI3xKa4YNv4knjVlTmiDtBAL+jxJ64JsBDdQr3RPDAf1NeyTONSVI2tuF0EcQsjxg3MZy0b8sDvyWFgZ2YVkqwQcqfDvfmnKzokSFceqX4IGRnd1e0eo0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=digi.com; spf=pass smtp.mailfrom=digi.com; dkim=pass (2048-bit key) header.d=digi.com header.i=@digi.com header.b=SA+7fgYh; arc=fail smtp.client-ip=209.222.82.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=digi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digi.com
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2045.outbound.protection.outlook.com [104.47.70.45]) by mx-outbound16-157.us-east-2b.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Wed, 11 Dec 2024 15:02:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UWR5YBvRlsJUXKExWfnS4iYusmVlsq2krqbitLmF37iJaS/+Vky4fPeEawMhRYD/hO0fX5Eiz/NZVdowxbA3Cn1nfchTEpnZBic/olr+l10sLMJ6K3wODpmc2jtaHz6Ei5lqg9r3thmAdYjGY49lYxR2a/dGvgQQQgii9kiIopJ4u+XBLqPQM7Mmy1wmjzymnU9HtH3a7WUWFfm04feNIiMLgeQXRwUite7A/hVSd/YbFTF4egq/iapb1qJrhsvaxQe/3xyYMPEhyfkWIn5nk9nxfbVx0dCHPu6oqdZFCoqM02y+QM+rHSuJ3x0MGSvBIbF2wpiCJer6UsTXp1ryaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yy6NEAgxSeht72ZATl7vQEEpQJL3sho3skWOSNR2GjE=;
 b=eHaSe5zvgvflGuxvLsf74cldY63sNKLvZLhzcIR6whm0Z1yUGqvkuGhAAOsrGqpkONPwW6N2GVfHHHE3LNC79T2S/l+pM17yxGHHOG6jyvS1uFwyMJfHKRIg56fI7tKxfGlTMjS4TmGv6r7qOyESPAFW2ZMFFlvIdeRh4aW0NP0BG9Wy3WO8GWfL/O9ELJJtbMZDxlaR3IYnWn1FnF+mLjieFWO21KEtHGJ4lirPnyCgskpcd+hyHZYYLBAbHLHy/wEycXiEKC8rEtFq6dWPeAT9ZRDkOkm/lCgHWyq8TQ1Gf3mVKKAe70SQqORkBI81GQsbmUcth7ZhziBz/f9bTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=digi.com; dmarc=pass action=none header.from=digi.com;
 dkim=pass header.d=digi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digi.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yy6NEAgxSeht72ZATl7vQEEpQJL3sho3skWOSNR2GjE=;
 b=SA+7fgYhndREt/kiOQ6Vhakp6Pkr9gi9i2oKfdNZaLXIUtWYXMQOuHM2yDVAuYeaT6WTlJJqx7ND0bSdj585RcUuQzWptOfFiRW0UqTv9NMMDE+fAOoRVtlGfNjum3/Os7uf3dyLUkK0/d0QjWJT9efGGiVt9NKO8psNDDF3AkdZGXkm6wiUJRO3XkgeLKYpCQ0X+CQeIk7m3/rWb5khxvI6d5YSpvmxLc4Jo6K5balzsBMNUUWvVevwr8azn/Vp+HfbALDfT+B/eM+mBYQE3klvahxTw8EdCv1LzQDNuAm6hSa6Da9Pz/xPviVwwPSxrUVMm5fgVUCJawAuVyYqlA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=digi.com;
Received: from CO1PR10MB4561.namprd10.prod.outlook.com (2603:10b6:303:9d::15)
 by CH0PR10MB4905.namprd10.prod.outlook.com (2603:10b6:610:ca::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Wed, 11 Dec
 2024 14:28:15 +0000
Received: from CO1PR10MB4561.namprd10.prod.outlook.com
 ([fe80::ecc0:e020:de02:c448]) by CO1PR10MB4561.namprd10.prod.outlook.com
 ([fe80::ecc0:e020:de02:c448%4]) with mapi id 15.20.8251.008; Wed, 11 Dec 2024
 14:28:15 +0000
From: Robert Hodaszi <robert.hodaszi@digi.com>
To: hodrob84@gmail.com
Cc: Robert Hodaszi <robert.hodaszi@digi.com>,
	stable@vger.kernel.org
Subject: [PATCH net] net: dsa: tag_ocelot_8021q: fix broken reception
Date: Wed, 11 Dec 2024 15:28:01 +0100
Message-ID: <20241211142801.1409014-1-robert.hodaszi@digi.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0033.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1c::20) To CO1PR10MB4561.namprd10.prod.outlook.com
 (2603:10b6:303:9d::15)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4561:EE_|CH0PR10MB4905:EE_
X-MS-Office365-Filtering-Correlation-Id: 14a7d022-9333-492f-dede-08dd19f00c8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gcdTogvOi+yjP4J87nuysRKAB+7SLCrIrv2VNP+uJXSIGdYWjafoJgPqHR5Z?=
 =?us-ascii?Q?KVcBc/QQUygCp3IOEykeWaTIRfEbrgo7vf0BkvfAWJF1XxV7fEsgw+VAWiOh?=
 =?us-ascii?Q?6RDiSrByxvyjVuIjZp8DAQLpY21WARPSbfE5KZb34wVp6aDhU5mmDKSe3yju?=
 =?us-ascii?Q?X4Ffyu1wjAa4UYtH5DQvFWLdcTvJfDDZX6cDIQ0GCePguQJ+FeoDR/O3bgRJ?=
 =?us-ascii?Q?3NVkB2VoLKQQgwKpKWGIQitPd630ZxqQ6X3952vAAk3I2EZjqmKIaKXLvlPh?=
 =?us-ascii?Q?orpiFmBCB3LOwYBkGISLjpLfltnuBCOepPoLm544pj0F5Qozm8NqTqo6Bv0c?=
 =?us-ascii?Q?zC2aHuIBRdRn0m2G76AdBnMKx0X761deOnMPw0ptZyJbqrC7hRvdqb7dBkkY?=
 =?us-ascii?Q?ZTneP+Uw4PrdDZeDymF6ImevR3FkDmFbuBykC8xrDCzLRxkr5TpAq1IoQShS?=
 =?us-ascii?Q?SSKGXgDwz545JTIoEqrJDEDS3t0i0cNbkr23qiIbHfHfVHKgYAxA4kfUb1Ju?=
 =?us-ascii?Q?pVlLWfGBbW5VFfJeYwxRdjLfV5aiEtqbzYi4jeDIqn0/km3xBz3aAm144YDM?=
 =?us-ascii?Q?DhwG3vm026WwBPKmnECsvnZH0uhciB7gvygXlBM3S2GUcjSh0WNojx11ESYg?=
 =?us-ascii?Q?yc16/+hOQpctgSgq0H5HhCsBbjFFdlc3Q0438JAHAsUGJ/PnWSp+VCd4pDL4?=
 =?us-ascii?Q?lptCr0NNwcgnEk2i1WNiCk30AkDa4uT7vcd6kMSAgy8KWA1BtAdrG1o8CgeF?=
 =?us-ascii?Q?5RX7hDkBqerJ3GSUO70UftHGcksBZhjMZRE54+PRm9kBdpSwbIYM5yLNSg4I?=
 =?us-ascii?Q?KrmYBDf/9vWksKXs5g4x2RyWhFVfdGHZns7q3LGAg8q771PJaJ+Q6Bu0/UQz?=
 =?us-ascii?Q?Wmok07cvj9K+TlU2yUnkPddXGu5i1m4LQKIHM3nubE7EFCv+skbLls48iyea?=
 =?us-ascii?Q?fmezCAUgm1Ao611WS2Kwz0/ZwItASEYEcUZocriHkgwjz5zUDV/At4Yyol91?=
 =?us-ascii?Q?CSFDPQZkAP05In4GW/x+HjKPjIxwHqEE0u/RQPPlJn0TrN5gXjRhJH0dLCnu?=
 =?us-ascii?Q?jBf054P/rP++eouVlTQtQxZWgri+vu8oqFRZYQP3ij6eTtV3ntGI54+sidOi?=
 =?us-ascii?Q?Q3Zk4ZzZqfc2uxcSe/DNYwKUHK2LCMwFB/bua6vDNETgfR9+ZSGt80pL+TDf?=
 =?us-ascii?Q?I7H8kH7Y5p3zdATMSDAK5e/3gkV/PE5NrPkMfP25xnAXAhJCWm1N9xI+eW+3?=
 =?us-ascii?Q?o1pOB3LsBunsmcy5dImdphdQ3eY2EVjuDshbOk0ukrSQTArvyUn6gaLXNMT0?=
 =?us-ascii?Q?I5jyivcUzs3HO5vgsJc4WHz14o4+oZicqWlozDV8ywb+VjZV9ovIpSL7MrL9?=
 =?us-ascii?Q?YVdeYBBWIq8cRmZWtpLriXODlZeK9Bcpy52zj6fGgzW6ZW+EPg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4561.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ig0Z7v0UcgIYECy/43HHdnbzF1yT85vtvunzeTHJLlT/Jw0DIVXy4vvTyVbR?=
 =?us-ascii?Q?bDPu9O8eXjPk6HzErTHYpOG5dWb3/L0UrL11RCmGeTQSJhh04lTXEabebw5q?=
 =?us-ascii?Q?sthzwrvKr8WhV0frmfRpDPeUiJT6abO5YAoZ6/EKtwzx8oA5eCKL3Sz6mwfy?=
 =?us-ascii?Q?Hge7hJUobczVM0WnH+eNpgt8t30YdWF9J+lqzeqSUKzGG4ZdztMLm4pBR1t3?=
 =?us-ascii?Q?c0uW3/uJeRU5TdcciRHh2SxSDgvBdtbvejNf6uzEn+ipKmPejaeoCtgUobcE?=
 =?us-ascii?Q?9xmDybmlXwVth6R5tEy1FhFo3gaJa4YjhWA+82qqo+V2NdQ2NPeHDAdSjl8q?=
 =?us-ascii?Q?VYwfoOqmNeeymmF3hQkq7BShO/pcylfIOBKqNovFvJINJvaDujsCzdckfkRG?=
 =?us-ascii?Q?elDWJblYuERELz9lpjuVCBA9tIAppD1VUcZwGpyNakwK55oZ+hKkbHRkFko+?=
 =?us-ascii?Q?0cVSKFCFPebx9Somsf9Jazr09HTOgh3uwkfOwHRKvJhorle56vg93rZ/uPKR?=
 =?us-ascii?Q?/gOA2FhahLfzr6V65goox/LOyX3CWJ7rveuddZhjA9aXuuYOJlwUOIDWkPHP?=
 =?us-ascii?Q?QqyQwWhtfN317kaj1o2YKZ+T1mU3kELmSNwmoO8pkufNKcMKdNKlI5E2MZ7q?=
 =?us-ascii?Q?p17g9KxyF0pxPRL/MmrnamOpMbi4bkEsTihTRRHaxSO9FBtnrYDkH3Br4lJX?=
 =?us-ascii?Q?lFhB6ptm/m8nUCgxVzpDqvmDxfgcJniMh5jxYbIFBsrXoLjEM3pNPhceJ8PL?=
 =?us-ascii?Q?SAuYJ9UD2Pg1zh7YpuEgMODw2qICOfbsWom12z9L82Xpr1JjOUPQgVHyRkjf?=
 =?us-ascii?Q?Tt2kksMq2H4biyUrwawW386wTwldDLWy/k/3PbhWEb8EiQIxw0TrGSMCGYRy?=
 =?us-ascii?Q?9L7lN/bzTy3sMN8UTehA0Ysv0vLS3abtE5+i6wxZvSuF5c7K7lBALPGNVk62?=
 =?us-ascii?Q?Y86XHNOD8tIB6LlPr/KTURqn+999A732tDETxDUFh1sJEZon/2UwzYoY1WQz?=
 =?us-ascii?Q?galQ5+Rz6CRBrud8GsuWAfIlorsb5j9MUUhg9e6BF6JWWhDYE++uGL9wWZAk?=
 =?us-ascii?Q?2gGzvQ7AcYAThuEe7Tef1pVr+AHgRHJkd2dKXdXAoko09wPhtJKl/ce4IEbe?=
 =?us-ascii?Q?kNa0NHMHGvvjRTuo/TIbGKHWwMqb4orae0p8PHWFI4EJD8/RAweGG8/+tees?=
 =?us-ascii?Q?7eiNKIaYY7iLaTm50t8wJJ+vqZhbTvUCB8iX5s+0tUkhcqz+y2P9ioA5K46A?=
 =?us-ascii?Q?HVTRaLpXv+k9d7U5qEDfOppLwEgZv06pBiaQt4y0k3y0/4RzW7OFHmqBnwjc?=
 =?us-ascii?Q?sFhyz+6mIHVXROHdDaIEOlD3k2g56bF8wXe9rulnXbcRWRFPNzc/lqwRlgrY?=
 =?us-ascii?Q?zAAPC/gk6vPk/SvLGc52BZux8bSkkHGOqzFVYN9kg/gtsCIxqmmx2SRwQEHK?=
 =?us-ascii?Q?i/WKgl/3Fyo5i43Wikt+gOrGhMLVJwmVCzs8vR/a+v0SxeNOC8eoQkmts6nO?=
 =?us-ascii?Q?rd7jYY7VRkCD93BwYRI44OSUc+6hmOW02q7RjDRX5LN5PA3ao6JxB5O7GPgE?=
 =?us-ascii?Q?1YSlD7iCqtRHqHw8Lb8ygsytm8M94zq4Ofw0KaAf?=
X-OriginatorOrg: digi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14a7d022-9333-492f-dede-08dd19f00c8b
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4561.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 14:28:15.1072
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: abb4cdb7-1b7e-483e-a143-7ebfd1184b9e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EZ2ZOB0apLuwAaK0GUbkXPFGUYZaG250KFkrWuEQoiUBqx/ZocXD7z35BnYJ6/FtsvK9ejhGJV5HeJg9NoBNUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4905
X-BESS-ID: 1733929366-104253-13345-14764-1
X-BESS-VER: 2019.1_20241205.2350
X-BESS-Apparent-Source-IP: 104.47.70.45
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVobG5kZAVgZQ0MwizdLCLNnY0t
	wo2dw8OcU4NdXC1MLUNNHUPNHQwMxQqTYWAE9kPk9BAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.261039 [from 
	cloudscan14-37.us-east-2a.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_SC0_MISMATCH_TO    META: Envelope rcpt doesn't match header 
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS112744 scores of KILL_LEVEL=7.0 tests=BSF_SC0_MISMATCH_TO, BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

Commit dcfe7673787b4bfea2c213df443d312aa754757b ("net: dsa: tag_sja1105:
absorb logic for not overwriting precise info into dsa_8021q_rcv()")
added support to let the DSA switch driver set source_port and
switch_id. tag_8021q's logic overrides the previously set source_port
and switch_id only if they are marked as "invalid" (-1). sja1105 and
vsc73xx drivers are doing that properly, but ocelot_8021q driver doesn't
initialize those variables. That causes dsa_8021q_rcv() doesn't set
them, and they remain unassigned.

Initialize them as invalid to so dsa_8021q_rcv() can return with the
proper values.

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


