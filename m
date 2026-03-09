Return-Path: <stable+bounces-223673-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ONuXCYDbrmm/JQIAu9opvQ
	(envelope-from <stable+bounces-223673-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 15:38:56 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B0EF323AA9A
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 15:38:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7D52A300F5BA
	for <lists+stable@lfdr.de>; Mon,  9 Mar 2026 14:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF7403C3C00;
	Mon,  9 Mar 2026 14:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="fbnxyjGD"
X-Original-To: stable@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012007.outbound.protection.outlook.com [52.101.48.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7ADF38B7C4;
	Mon,  9 Mar 2026 14:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773067132; cv=fail; b=RXpRI9ek1DAPO0DRpdKsSAEaMN1Ppq0/c43n0I7s1+eRJbgvbwuWKFcwOzTvaQ0yPAHqGdvkrUXNz+emR4ArD9kEUsEybQrTlt3yMY2YYHhQz7dPjerXpL3rSP1uL3FAcb08oYAPm++sDPnAnmKgJ5ZCevnHqTr3mKntaOWIKdg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773067132; c=relaxed/simple;
	bh=NjtkKwJoYmKHWlOXAQTc7YfdynRo28TU5W2f7RJp7HA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GEEPyLwo9quOvESzBvI1zmhOkYo6r7kSrexJL2NHIADt99dy9GJZp7q4CbcKjkqJlGPRIxr9Ea1cq+HWNRE7sC38syuiTaEgoO47mPGeq+ngGYc07r5kUXag5H/WnPyUAZnuZVa9iU4YQPqS73AbHyCgue+g+/CoPTg5POh8HXc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=fbnxyjGD; arc=fail smtp.client-ip=52.101.48.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d2RiNV8eYvQpcERjL57AE7yuMgHZ3rgIhc2XN/khLQyd1Nbncq//uv2dgxf5st2q9xeTswWI3xlkanvKPxGSnUjfKEXFnA2PQgkRRs7yjQdGZ5N0dv37J5PCn0IyGDDIC/GKpsc9Xj9SB4DXjyCM0W1/5GZhg/d5NqWy84i/k7//Ouw1p4SG8yDHXirSAYeG1mKoKZ2qRULzpZSuQAi+muSA9MaRJXEduA+eTZN01XZ+ouCicZVEP7Fq8ImWzB+A0boCKHjEDwuYXnTG9YvC25xtXBdpA+pnnt2cMsLeyPcCcbu1MpJKHvgVI3jg6mFYF4nTlTB62ie5NFF5cS++JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qXRb6qnnbK2YAws8SbzPGnxRQqqbu4D3zdPBAsYT5YQ=;
 b=KImcgrquOpb8n0VmP/FqFmC5pkTBcApwMPapYTsjegL0X3PHhErf8utJWzrS1WOE+CKqxQftpZrUlb//h1Sm/LrQh32c96OymB5UtiwujatS33/i+ZD3qNcQxLDXXxgqnJaft4E/j6zSyw9sq5jJ+bJzMoOixcvnFcN3nQUEYeiFG1xnGjaqoCJzAFT7Qu3QYweLsoIEixbYNrjzFw46E23dhcNSvLRptGP7/+2uBHubdpf3bMkTYaQBZQKXQ8Mw1nl2Sgt5Fmfl95Z17t6clxSczSzEUWFnXhXYYc4huP3RPC18ACaO/IT1AYniXQfzGEIkL8ZinVygShOUHIXhKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qXRb6qnnbK2YAws8SbzPGnxRQqqbu4D3zdPBAsYT5YQ=;
 b=fbnxyjGDEFCWuJ9pzgPp6JQPtXAPHeqnLpVP882jO2PFXj+14lOIEDda3x7UpdAXr08YtoQVKT71JRT8k1hPtmuaxdqjlRZLHt6gQEstZSxH4J/S6LOtkvTejJUABskvaLyhdhxB2ru7eHkgMbWGjiw/z4lK+ZkyEYspDeGgacE=
Received: from CH2PR18CA0054.namprd18.prod.outlook.com (2603:10b6:610:55::34)
 by MN0PR10MB5912.namprd10.prod.outlook.com (2603:10b6:208:3cc::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.25; Mon, 9 Mar
 2026 14:38:48 +0000
Received: from CH1PEPF0000A34C.namprd04.prod.outlook.com
 (2603:10b6:610:55:cafe::16) by CH2PR18CA0054.outlook.office365.com
 (2603:10b6:610:55::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.25 via Frontend Transport; Mon,
 9 Mar 2026 14:38:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 CH1PEPF0000A34C.mail.protection.outlook.com (10.167.244.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Mon, 9 Mar 2026 14:38:47 +0000
Received: from DLEE211.ent.ti.com (157.170.170.113) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 9 Mar
 2026 09:38:47 -0500
Received: from DLEE201.ent.ti.com (157.170.170.76) by DLEE211.ent.ti.com
 (157.170.170.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 9 Mar
 2026 09:38:46 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 9 Mar 2026 09:38:46 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 629EckdG1279381;
	Mon, 9 Mar 2026 09:38:46 -0500
Date: Mon, 9 Mar 2026 09:38:46 -0500
From: Bryan Brattlof <bb@ti.com>
To: Siddharth Vadapalli <s-vadapalli@ti.com>
CC: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <jm@ti.com>, <afd@ti.com>,
	<stable@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<srk@ti.com>
Subject: Re: [PATCH v2] arm64: dts: ti: k3-am62a7-sk: Fix pin name in comment
 from M19 to N22
Message-ID: <20260309143846.qfnwbonqrnimk6gy@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <20260309045539.2070793-1-s-vadapalli@ti.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20260309045539.2070793-1-s-vadapalli@ti.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34C:EE_|MN0PR10MB5912:EE_
X-MS-Office365-Filtering-Correlation-Id: 11a21cc9-7949-4c1e-d847-08de7de992be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700016;
X-Microsoft-Antispam-Message-Info:
	3PtlTPkr9MSImYQQS8QUTvroMfgAaowWMkCEO7UVKrJWYpGMw0shTgAO4rV1DaWhvf7M7Kgi5J/6FkfGq7hyus7341M9cenQcjMSQeEOEl3AnvmWGcHcnlo7GZYqFN3x+3EBh89auNaufBE4bWr3p6ME7DyJGLyucD310IIMYdSoBkalwGuJkkxUZlxaBfUl73IhJdRbPg/JatBRHCsxxhpW0f8tybtG9gUzwtTVLzSEXVp+frZoW8USRZf9YN717Ad50qSrlqPCBltfokmSRswKs1Rvw5evNrIQ57PmlfVnHDbadea4iapjiP5Y8hmwb6Tfii8V7Y7UI+Oif08ooCYCon0eSrzQp9+06oLvRE5YB0mkl9lxd/2sSixeTdXnGFQWs5qejJvOYS2jZs02d3QdCCDiIj0p1Utxny940q90nBfnkDMeC/RmoMqs7BznhNGpIIlFdvfwoITprwABxS+Fl0DFMmyK8brylpdbhOokxwyDPPRexmb54Y8JR19BoMDNL4TlF/Wu67d0hE6vmROlhT+zm8C669X0AVE2ih2SY+QaWqSQbYNU1y0lbjAl/1WidhjZ9gsBxCKGTGaluacRv2SEz8pOZqRVeifNCObAmOwosDRtHxIwNK/CIRskqzULEa/s+XM9bYO6KEignS+Kv94jXYIFSOM2362VhbNSmcPFW4RMHPc4h1qvk/ZgHDaUBr3xdwTnJZ2HcnEwyoQxBuYLxchLfwz0UdIXlOh+GLflrewYkscGIuuQuELpYjQBUbrt9jNkPlxIif5EXg==
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	VGizo+lDWebipdSF7lPBrcT4Eaqn/XcvkxK6FbmY/dcges7mCZPzJ+upF7fgP21fYk4gFSZxRJZkkersZc6oDgI8054I19cTgvEDUGBuU38LzUQ84UIOG+hVHurPoYEGS2e8oBjmxbGtp1bwpaKz0abVwxBK+hyKU6tUCWAzID+D3ORpyjgD0JZO/4vQv2C2D9CExCX2R7vOpVfQ7qP4n5aEPqJUzU23N9SZdL/MdJp4Fj1y3iodtAORxvKYCSPfsUsczBKt2MvSEjDmZ6GEkUjRff/zJIuwgNDt4XPSX0j0ZQtaB3tiznlPjsqieyuPGkHTzOsdmrYN5dEw1QJ9ne879va3f+blX7iuCi1KQ01u1O0cGzFZRGjceLqLs3I3wQwrsgQIeOILitnlGAkBNzlnGYnaKGN4ajXGFNZDniXHbqo96lmC0SH6q7xThQU1
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 14:38:47.5150
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 11a21cc9-7949-4c1e-d847-08de7de992be
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A34C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR10MB5912
X-Rspamd-Queue-Id: B0EF323AA9A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[ti.com,quarantine];
	R_DKIM_ALLOW(-0.20)[ti.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-223673-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,ti.com:dkim,ti.com:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bb@ti.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ti.com:+];
	NEURAL_HAM(-0.00)[-0.995];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[stable,dt];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action

On March  9, 2026 thus sayeth Siddharth Vadapalli:
> The pin for GPMC0_CLK.GPIO0_31 at address 0x000F407C is N22 and not M19.
> Hence, fix the pin name in the comment to avoid confusion.
> 
> Fixes: 8f023012eb4a ("arm64: dts: ti: k3-am62a: Enable UHS mode support for SD cards")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> ---

Nice

Reviewed-by: Bryan Brattlof <bb@ti.com>

~Bryan

