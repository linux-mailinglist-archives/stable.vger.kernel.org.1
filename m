Return-Path: <stable+bounces-217535-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eFlhE3Hgl2ne9gIAu9opvQ
	(envelope-from <stable+bounces-217535-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 20 Feb 2026 05:17:53 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7184F164A87
	for <lists+stable@lfdr.de>; Fri, 20 Feb 2026 05:17:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BA8E030138E7
	for <lists+stable@lfdr.de>; Fri, 20 Feb 2026 04:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65CC32D130C;
	Fri, 20 Feb 2026 04:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="lt3Nlh9o"
X-Original-To: stable@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010000.outbound.protection.outlook.com [52.101.85.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29EF72D838A;
	Fri, 20 Feb 2026 04:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771560797; cv=fail; b=VjWR4CeWVwsjqu9EZAgLaMaUb0WiYYkxah0V0E3xg3Nhp6YrJjya6eltxKl2/dGAWiWcLFwHzqqBYCCEHbYri19a9M9KpJ9w0NHYZKZANNYFB3not+gCBSTpvUPaYEnEDZqXuNS5tFlOXYOCCAuLsUQcvqNfV3GC8q581hFh7Iw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771560797; c=relaxed/simple;
	bh=mfxcCalBqcqA7sW4tbUutKE9H6TK+CTil16hEUtRUV4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Yexasb3kh40t3LO8Oi37fB9bxTIHmZ5QelzJQmNOWV4bIKYzNfIVkhRtmgrngoLNNqywgbYOC3vX2wAcVmKX16DO+AQlvTc9nVO0rfIGDRUUDH5l8n7XSD90PSqhefRL+b0lxtuxL3xLcvxLyaTr7txCsslRJisdENousqms/6U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=lt3Nlh9o; arc=fail smtp.client-ip=52.101.85.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nd/7T/QL5EwEOIuGhDYE/bVGW2kUkom+Uu9+MUOr7CjWxSSlsQpOsDW8SCRnWZR34w/t6AArLuN11NDNFn+6QAg7AP3U6+BU48PHT9vgdCjwM1wOIkJVvYpEKVFr/B9IH3XNW/gljISGLZciLO4NBVKtXykP0ULX86IOIoV47twsJGDESxzEUkm2zXPg9J6zCKJJnzLBEG7RR+xe99jUAew+zadcWeZ6bIRPfjMKRVbM7GJkOfy+BlIEm+g8YtvR9Q5dT3Ys1TCue2+MmzIzH338AByAtYNYPBWUC3777k0s1DHLUGKGBqpteSdqa2a9UGaGTCIFWHl0ElyM7KZDJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jFiDUoJSEDEpiJ7fPzEEnqxwlGjetZigBJkDMufdJR0=;
 b=pXGFwikgHJZwhJIyOyP2jsm4q57LS1U1bdNEWzNeYUT59rq8u3UtkaGLFb3CSShMZoYP9NqtsN7YwX3FYbhnues8PcUm+OTKmOdWREL3BpeQxOmPcJeKpH3PNdU1Rs7yCSa+lJnb2f9U19f/g170EamBdMyTBOSj1ioixNK1O3L2PQKccrF4b5rSHW4akWYTowvqHYFewSa82Qtd8j25VpAcwL+IGuo5H/ybZW6GXmPrIA5snc9n5eGL2qYFDYQhcepoA0JnJcHru/qHiVvxTxq5FAczQfBQ3+IXjZp/vmknr+wDusyn5+jx7Tn2i1Yad3qpjYvvQc4rEe2WPyMyKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jFiDUoJSEDEpiJ7fPzEEnqxwlGjetZigBJkDMufdJR0=;
 b=lt3Nlh9oA5WDm62uq1rQPNiesbRic1FkirtACDGLK76CfCP7xHnKpoKoqaAa7/6YkmZpl9rUOec79cMeOq1F6JTw3NR1FTuri7JyEGuL38u0I+AcfLDTR3jssmhSZVoTZJ1b/FzPIPL9mdIuDlBeCW/mxg36Dzd9lPfmLRC/yWI=
Received: from BYAPR05CA0039.namprd05.prod.outlook.com (2603:10b6:a03:74::16)
 by SJ0PR10MB5695.namprd10.prod.outlook.com (2603:10b6:a03:3ee::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.16; Fri, 20 Feb
 2026 04:13:11 +0000
Received: from CO1PEPF00012E62.namprd05.prod.outlook.com
 (2603:10b6:a03:74:cafe::a7) by BYAPR05CA0039.outlook.office365.com
 (2603:10b6:a03:74::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.15 via Frontend Transport; Fri,
 20 Feb 2026 04:13:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 CO1PEPF00012E62.mail.protection.outlook.com (10.167.249.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Fri, 20 Feb 2026 04:13:10 +0000
Received: from DLEE205.ent.ti.com (157.170.170.85) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 19 Feb
 2026 22:13:08 -0600
Received: from DLEE215.ent.ti.com (157.170.170.118) by DLEE205.ent.ti.com
 (157.170.170.85) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 19 Feb
 2026 22:13:08 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE215.ent.ti.com
 (157.170.170.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 19 Feb 2026 22:13:08 -0600
Received: from toolbox.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.73.74])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61K4D1Sq3237911;
	Thu, 19 Feb 2026 22:13:02 -0600
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <danishanwar@ti.com>,
	<rogerq@kernel.org>, <horms@kernel.org>, <mwalle@kernel.org>, <nm@ti.com>,
	<v-singh1@ti.com>, <vadim.fedorenko@linux.dev>,
	<matthias.schiffer@ew.tq-group.com>, <vigneshr@ti.com>, <m-malladi@ti.com>,
	<jacob.e.keller@intel.com>
CC: <stable@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH net 0/3] Fix Unbalanced IRQ Enable for CPSW and ICSSG
Date: Fri, 20 Feb 2026 09:41:56 +0530
Message-ID: <20260220041431.372610-1-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E62:EE_|SJ0PR10MB5695:EE_
X-MS-Office365-Filtering-Correlation-Id: fbfe6857-195f-4b24-c4e2-08de70365bfc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|7416014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?q7/eFvyUqRh9M0QtUpRUOn1DOlFG6eqdEHywG99cLrVDrqpuMTR2t9TqSWFW?=
 =?us-ascii?Q?UpmdfZhHTqFENaCI43VaLD6WzP5SaqgA/bk4D4LCRzDx/BojPXGy+9z/aFo7?=
 =?us-ascii?Q?To3AQuEhyF7ErI6u3SvwRNKeNUakgozpHs8QIO80YcvUuQQEg+b6klTPzJD0?=
 =?us-ascii?Q?T1/QIvH64atvQL4yRZcut2aPdPkphpZKO2xTMbF+tc1EqZZjlmUrefemC6e9?=
 =?us-ascii?Q?suvFPO5gEG8TDJ3oWBbGtZy3EsP+Yqs5a3mTwr4Pji+wpTKeFhbRirJ80mvV?=
 =?us-ascii?Q?rSTCZgirWy7GVzScEm19i/NBp2alcGdtAfIX4Ot6prFoN2nz8yWwNioqtXKP?=
 =?us-ascii?Q?NwDbohyo37bz4nonpCH2QchhiUZKZE0p41RIFECiZweLRmuaeR3ryrcIl32Y?=
 =?us-ascii?Q?mn2cJCmD+2ksRoMbmj+PMeRCmxLAVvCfc6LhLnYpjvxmmHqjU/ns+tYJuMLJ?=
 =?us-ascii?Q?JW5jHMq+t5tYd9s/8p8AfHnH90yM3cngipLDy3cjZ+9UdP8pgunxjKGkxH7E?=
 =?us-ascii?Q?NP5sAUOYTplM+RSVIgCZnxWIMNoANCAnIEPDRIDKIPEBwKlAtpIxsjD3kEeQ?=
 =?us-ascii?Q?WZHEns+WYhDrioEeJfoR/3kdspUAwH+Ewp/DsH36mqOeyDBM0mziuEhd86DC?=
 =?us-ascii?Q?r1QHf0lGFbgdgh7UJNaIbwKmtd4YXp2lLDFJE6E83WNvq9/sl4IVPP4bgRkE?=
 =?us-ascii?Q?fFAK3ut/edrY6eh9CDUFx/Ak//4LTo4PDZ2Vunc3qNE6NgGFuQUB4JUTumol?=
 =?us-ascii?Q?MDP3lv6zm1YW09q86b0MY/wUXLJb9eXVdsrDzTld5HmbbCV8FsJCr5r3o1XH?=
 =?us-ascii?Q?FSgJeVy2dk0euTZOEzkivJFkquLx35sR+v5D7Hwb8Mpj7ogoygSelbrsh4/K?=
 =?us-ascii?Q?WlPfsj4B+pMv6q+miN2VpUqhfnlqoWb3a/SxSYOgZe6lEJjREnjjP/VHw1rb?=
 =?us-ascii?Q?zOegFmjJdQ6aQnGMAOL0Z+06birJw6HfZEPByLBG8NTy6LVby5QowA/T9SKW?=
 =?us-ascii?Q?5Qlv39zxmEtbY5P8bfEYYZNr4Zc2QopDZ+XYBjdifcqv43cIJrFmiq6E92ox?=
 =?us-ascii?Q?JCJQiXbrR3a4KNeIqS9o29wJBDCIeAjERCKIMMNlp0OjkFGl1JdQyH25GaTn?=
 =?us-ascii?Q?tTQgS/ld9clhTAvrh3JKPDns1iCzM0N0KW9IektQ6HPti0GLaVntlFxPp8Wp?=
 =?us-ascii?Q?3NZ9E/yGcdmwreYG9lC+qC7CMB6ujVhEbsfM9FSI0BVZasIhjwMqCZJqQTxt?=
 =?us-ascii?Q?WsD7VpWoeEbi52RGlynroKzf705LCabIX+EM8vYlzRD/tU7pdKiozw47XPu9?=
 =?us-ascii?Q?9UTfsI1zqirBL/NV2x8irXCB2Qk0SbARCjSkMHWxmBBZnLXM5z0HqA3EPnxg?=
 =?us-ascii?Q?o39FhXPMpT+sDZQSg9ckK/ZQYvKESNS4YoOfQtKOlcWx4FXqSmZzYi4961W/?=
 =?us-ascii?Q?fxXPvNbDHqBETNcYftv3lCiMBFKE+xfz0fSLI7oWYRgatoyq7z9wxnu0vi8m?=
 =?us-ascii?Q?GuJ2EjeDmp3oGaH4QIBGOVssjLPXrG4aWw1umdarzZXKMq4hQWZ4MbMQBTRJ?=
 =?us-ascii?Q?tjFHYEElCpaluhoj2uCvK6rnwSnyqluIU6cNPFZ5ToJ1z8BlO6Th4pFKzL0l?=
 =?us-ascii?Q?yOgVjRPqEznLYh6MeYE8zdtjJn16Ryn+K6ZJy4JGSPc/abrUqdlil1xLxUDI?=
 =?us-ascii?Q?0Wltcv8pyqCU50/3QKwrQqbHIK4=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(7416014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	8TX9BFjKgwrtbiyoNrshRdVuMj+L0354FVoNaCpG7e5279AqIoLGP4uoWKfn/pGTd/TCcvYUj8A/YP0mnuXrpUghf3N4TTq50pCSwIiuQ9e/bgGQdb5623Z/6GMUTtcV1Nsz8CWtqAxNjQNfFIokH4gtURtu6/zxJi8T8cFV5Srz/tz5jYlqpGZEoUotN3ONH7EB/hzKhcrFRFujRZhOuZo+NVkEdG9PcK1mT4WRvW+1AjXx9VQiRoqFl1/5n7y5jGyZqjQZNDKML/lKROEAYViJSjtU9Uhg3ZeEiw6IKXjF956+QZnFaXYV0xTXUDSaCB3tFpVttgnsqsK+w6aZ+dGkGrGC9IIOo3WzF8pqKlnJET0JYRBd287kTm8QENMsAbEK40+zD+p2lSdreez8ZKLMWun7biqa1EDxU3a6KX9X6Jt1zDH838P106zPedYt
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2026 04:13:10.5715
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fbfe6857-195f-4b24-c4e2-08de70365bfc
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF00012E62.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5695
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ti.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[ti.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-217535-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[ti.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[22];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[s-vadapalli@ti.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ti.com:mid,ti.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[stable,netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 7184F164A87
X-Rspamd-Action: no action

Hello,

This series fixes the warning:
    Unbalanced enable for IRQ ...
for the CPSW and ICSSG drivers.

Under heavy traffic and in an SMP environment the warning shows up after
a relatively long time. The issue occurs due to the order in which the
variable 'irq_disabled' is set and the function disable_irq_nosync() is
invoked.

I have examined other drivers and they follow the right order which is
to invoke disable_irq_nosync() before setting 'irq_disabled' (or its
equivalent variable).

The first patch is for the CPSW driver and it has two Fixes tags since
the code change associated with the fix is for a recent commit while
the incorrect order was first introduced by a much older commit.

The second and third patches are for the ICSSG driver. Although they
are both for the same driver and could be squashed, I chose to split
them since they fix different commits and need to be backported as
Fixes for the respective commits.

Regards,
Siddharth.

Siddharth Vadapalli (3):
  net: ethernet: ti: am65-cpsw-nuss: set irq_disabled after disabling RX
    IRQ
  net: ethernet: ti: icssg_common: set irq_disabled after disabling TX
    IRQ
  net: ethernet: ti: icssg_common: set irq_disabled after disabling RX
    IRQ

 drivers/net/ethernet/ti/am65-cpsw-nuss.c     | 2 +-
 drivers/net/ethernet/ti/icssg/icssg_common.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

-- 
2.51.1


