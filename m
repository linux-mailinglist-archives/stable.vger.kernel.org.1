Return-Path: <stable+bounces-244598-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aKmENwK3/Gn9SwAAu9opvQ
	(envelope-from <stable+bounces-244598-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 18:00:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 840CE4EBB78
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 18:00:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E436E300D1EB
	for <lists+stable@lfdr.de>; Thu,  7 May 2026 16:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6DFA44B697;
	Thu,  7 May 2026 15:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="dVaxD4ED"
X-Original-To: stable@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012032.outbound.protection.outlook.com [52.101.48.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1889B3F7898;
	Thu,  7 May 2026 15:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778169598; cv=fail; b=fVlDQAyAL2qVpu+xMVB8AIfZlTRA2m3JreAd5p7US0nce/KBNOYywdBVab5/JGqzxi1pfSZTWjiY9c//7fYG4GDiO2zU0AGbRbkUu6g4b3bmCyX62kDEKa6Y+chID7D8c/9SfKv7jXhB+3grE++mvN9fQ9h5f4DQ3b4EyOeIKHY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778169598; c=relaxed/simple;
	bh=gcCnhKT5hQQhdwf0PKXxOBoBC18SZKdjV7Pay4qEyms=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u7n/ELesqW2Oay9xP68oJni07CKPW7v1hFNyYmxVv1tWhx3qBN42gTpTQ0/jPn4iZ4YgcpzFa6BGfm8lTqtYEzmnuyW2UGCCT1hFdPlxXyAnVUd9TsnhHXmw0XPCjx6WC0pLaZtxhQLYUm2EyaivmY+wv35h6hXR4vv7XJoxWmU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=dVaxD4ED; arc=fail smtp.client-ip=52.101.48.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SOsKGTesoqqYEIO5/FZ+T6X6w5prXsNUS8pXFXQCGyVuMlgaU5niE0xfDOnv5KojDuIEJVuRWwhbd/qHiqCnt+Ni9/gEnlLArJAnBqrCCasZHkfU2TRVsZoCX0KBIaYdBoA0uKh9BkvZz10+qUgTsqp5rouNGLleD85ulESwycr9gjgQSqbbpsAOf/5aoH6jIaGUhKyeyCLJdoHX68Wcp/0aXmhGwuMAGT1diiNKUjFbcO9QwJvpA8VXZC16fv67Eob6y9nwzbw9F5JIQKLts3HfQxX8dy40gfN10N5PgepRT85TBF76Tp0QdhIPsG6yA/bAtm5DNiqIuGURIjLCEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h5qlMXbFpRlE4X3MIQCAxqaW35emWVZDHc8//Mm+AHg=;
 b=aco06SjNplQfMySR2veUmKR0erBoidZS/faQSwbyqNFTLTE5K2BsejNOlRIjK99XCLWaxTVnl3Du+aLsT0l1qVQBvOTjetL7cuvRchdZ6t7vzyBFn2zza/+k3ngmSFHEqcYojOuAJIOsY40C6lKdh+jnXoI9veChXtgxwUBHGzsMyl9hjSDOtNDLYZvD4xjj8uHg4rZCrFgGSigh7MhiUOPavxWiF2JviVaHJ/GixflxVYZn0b53q5DGBNpz+sZwXBR56aysvzbEFh+ezzcRZ/9U4ZUemnJR70vEysqSnT2sJLAfUm24UXLJ+dYBLncCky4qsbR7GTjmIShDCs7m/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h5qlMXbFpRlE4X3MIQCAxqaW35emWVZDHc8//Mm+AHg=;
 b=dVaxD4EDUn01lJPm8NMrD69FsxVf6kXLx1MndwR+XIFnZqj3MqvroeY9c8UEd7aHPTsNIH38rpEpn63kBuNnhvkIWuXo4px0fdYtmlTYlTwf4ueNWtJhFW+w/smNsOPx1iKObppVxavgXK/HDVpEReF538L/EES6OLjeOuG6mHs=
Received: from PH1PEPF0001330A.namprd07.prod.outlook.com (2603:10b6:518:1::19)
 by PH7PR10MB7768.namprd10.prod.outlook.com (2603:10b6:510:30d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Thu, 7 May
 2026 15:59:47 +0000
Received: from CY4PEPF0000E9D4.namprd03.prod.outlook.com
 (2a01:111:f403:f912::4) by PH1PEPF0001330A.outlook.office365.com
 (2603:1036:903:47::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.16 via Frontend Transport; Thu,
 7 May 2026 15:59:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 CY4PEPF0000E9D4.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Thu, 7 May 2026 15:59:46 +0000
Received: from DLEE214.ent.ti.com (157.170.170.117) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 7 May
 2026 10:59:46 -0500
Received: from DLEE214.ent.ti.com (157.170.170.117) by DLEE214.ent.ti.com
 (157.170.170.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 7 May
 2026 10:59:45 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE214.ent.ti.com
 (157.170.170.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Thu, 7 May 2026 10:59:45 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 647Fxjx03965288;
	Thu, 7 May 2026 10:59:45 -0500
Date: Thu, 7 May 2026 10:59:45 -0500
From: Nishanth Menon <nm@ti.com>
To: Siddharth Vadapalli <s-vadapalli@ti.com>
CC: Robert Nelson <robertcnelson@gmail.com>, <vigneshr@ti.com>,
	<kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <josua@solid-run.com>, <w.egorov@phytec.de>,
	<matthias.schiffer@ew.tq-group.com>, <d.haller@phytec.de>,
	<francesco.dolcini@toradex.com>, <joao.goncalves@toradex.com>,
	<emanuele.ghidoli@toradex.com>, <ernest.vanhoecke@toradex.com>,
	<rogerq@kernel.org>, <eballetb@redhat.com>, <afd@ti.com>, <u-kumar1@ti.com>,
	<stable@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<luis.parga@ti.com>, <srk@ti.com>
Subject: Re: [PATCH v2 00/13] TI: K3 DTS: fix USB Clocking for Compliance
Message-ID: <20260507155945.alnz3z543gxnulxq@procurer>
References: <20260506141040.1368918-1-s-vadapalli@ti.com>
 <CAOCHtYjJRmr5LhRePqaOomjVHb=o+B8-3+6BN89Xx9erwRdcng@mail.gmail.com>
 <0e9e5de7-b456-4da3-8165-8ed7d66f2671@ti.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0e9e5de7-b456-4da3-8165-8ed7d66f2671@ti.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D4:EE_|PH7PR10MB7768:EE_
X-MS-Office365-Filtering-Correlation-Id: 0cc0765f-82e8-4a29-a652-08deac51a95c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|7416014|376014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	bmhu4Jd1/cwg71tHJvj8z9SHmvNbXWCzN5dKISExq7bH8bsesTRhw1IuWSu4oZ4OamIGG922XhRzyujdGnUohMkYL7qjasxytxkXEWL8icerkDX6Fq0vRzC2j68eosh+v9bhQ53Tu6ojLpuQx708c13bNwhbwPJIbYX7R/jFrE3OkI2PhuuhBMK1cRC3i8A5dfalyASApADh5eafaf2Rm6vgPREV/jGVncI3/4j1dgo+j1AXjFw8yCKyNpv1+O37nt3l76MXabm14qRuA7Jf+bju/pX50d3VzrcJ46zksAKpoBd7H3Xat28ce4HxbvbDskUjnSiHi23JsROSUDIzeXvTHI2Z0f5RHn8AmIGBLeKmsFukwDsYdTvrUZwZN9u+SL9raQKpsgMkQRjWBCQ7o2zPD7fx2ZT5QRfxiNukWlg6bhhc7Fsx3VmhIJVEgrVsCxCHFFoHfx9fdNjYTLky69pRZOR5XSaay+jFX5rQ0onwEu5GCT6vfVAN8tUbrudkrkk3WeS/p7YZHMnMjWA1ax5GPrEVeSy5UFEvw6xygvQEi0uwvpf0RQO5XkCl1S/Qt0iHOidX8p5JQOug+Y87NvhNFgpPhS0pNw/QfxpT6I/hh2rl+eqp+7bmkso2PwBAjj020RvhqVKHrtMqrFqbC9iWo2PHeD3J9pJGUNkM5tOHPLlsCCV7ddNsNhPFPZ31T02mL5ls/3bA+3Ujog38OArk6sZbII/VEoCvvFNhjYc=
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(7416014)(376014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	DJTxeq81vG8AaEix7tn8UvMiIIXYQy1M+sLJm0J/z2MiBQ+H3TEJXZyiglcQwFyOJMeuOM2d0sFDe3bP+MUlfQv25B66lvm5p2sp4rC+P2JxU50D4OQ59pwczWytQU/SgtSFkJ/Xd2yLJxq6MgALsGscP5eNAhnLxoOxEajA/d21ZjA8AXS9KHVetd2qMh6XFYYolhjV4c1knUtiQ/2Ssrcc3F41m2hxGKgQZt7FTT9YPGkRBkecnsMz4OSvSYNHAs2cIhnNGWr8iSQlHGyeVxE2Dz7FOtZFlaIVF3SenEZkeIkD76ovnsyHI68lkuqyp7LKgy3/dUsagNP/7U6xZl2PfaI6YGrWtDVJFWVAJG2im1veZIFn4whZ/ff9G4l33sUSTnmQ5/dFqHY3DFADVA5w+hiy9knHgQfZKqVPMtIKncbdQw/oo0Y7UJHzytKx
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 15:59:46.6108
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cc0765f-82e8-4a29-a652-08deac51a95c
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7768
X-Rspamd-Queue-Id: 840CE4EBB78
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[ti.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[ti.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244598-lists,stable=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	DKIM_TRACE(0.00)[ti.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nm@ti.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,ti.com,kernel.org,solid-run.com,phytec.de,ew.tq-group.com,toradex.com,redhat.com,vger.kernel.org,lists.infradead.org];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable,dt];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action

On 12:14-20260507, Siddharth Vadapalli wrote:
> On 06/05/26 22:37, Robert Nelson wrote:
> > On Wed, May 6, 2026 at 9:08 AM Siddharth Vadapalli <s-vadapalli@ti.com> wrote:
> > > 
> > > Hello,
> > > 
> > > This series enables Internal Spread Spectrum Clocking (SSC) for USB
> > > SuperSpeed configuration. This is mandated by the USB Specification
> > > section 6.5.3 Normative Spread Spectrum Clocking (SSC).
> > > 
> > > Series has been posted as individual patches for respective boards since
> > > the Fixes tag is different for each board and needs to be backported via
> > > stable.
> > 
> > While yes, that's true for stable branches.  Since these are so
> > similar, wouldn't it be best to push them to the board soc family
> > headers?
> 
> I see individual patches per board+SoC combination for new features as well.
> So having individual patches for Fixes seems to be preferred given that
> squashing all Fixes tags into a single patch doesn't make it easy for
> backporting and reverting in case of issues is also easier for individual
> patches.

It is not clear to me the path to stable here.
1. Driver fixes
2. binding updates
3. dts fixes

How are we lining these up for stable?

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
https://ti.com/opensource

