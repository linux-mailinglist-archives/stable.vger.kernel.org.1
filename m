Return-Path: <stable+bounces-217859-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iDMXHm0ynWk2NQQAu9opvQ
	(envelope-from <stable+bounces-217859-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 06:09:01 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CFF48181CC8
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 06:09:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 68DEB30432E4
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 05:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27A1327CB35;
	Tue, 24 Feb 2026 05:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="UUMRiL4o"
X-Original-To: stable@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011043.outbound.protection.outlook.com [40.93.194.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2F7203710;
	Tue, 24 Feb 2026 05:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771909730; cv=fail; b=b2bCnFF/gqzV7YOkSYUH/0vlnp/nYyvH6STU85YTsQ+9qbqy62OTqgssPxUUMycePOWDWLV7f8xgcH2ZZoHUkprLyV0ce0bvGVgzEDKTi5xRC1+yD5BTGav2NgvaGpqBX3RR/kPcnFt3Femo9MSMTfIcKsKMUFqNhG7h5GbaCIU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771909730; c=relaxed/simple;
	bh=euHULK9larj7hRnSuMht4BHfdEeS/EtIoCprB1tb+R8=;
	h=Message-ID:Subject:From:To:CC:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kdhg2QAK3eSxQ8FVCumK7ALv9G6jNo1vzLS5j5bE7aukDeF/gGLCBhrfzK5xY95oS5jIf+ZrKkbuKTNkY0TEcts66rh10qbgl2OZpz7giOTCJ8+zxWV90QMq0Q2KEXg6un/eVo+gLBqMzwYMISfgyOUfQUfuJAR4RQB/NoggPWQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=UUMRiL4o; arc=fail smtp.client-ip=40.93.194.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B1dbxgU4SbWz6ZA+EnyoqdEeyuiXSYdxifB+uB7frlcvsse6RW03wMu9Fg8B6AELC2/7iNEomr7Gwfxtn952QXs3i0qJnWj6oOslfSh0TMnX0OH1Bwk6bH2U6zruyCti77jj9bia0j5R3/X1Ypw6kL03yNnWJZg93SYftumHpjnxRvyONQR4l6fyT0fODHiPVB3g36YbTTrwGNPgXbLCdkNnSJDW4ANPwVly3oeUYi1ntoL9/wNVy+q9vYENiYwWyH4qa+97AFbQ1tXmJcgzhZLue1fakTaKM3R4NYeL1f6rTMjNOwaXRkOI/KHPJcWc/8RxvhtP8xVLaKXOfm8ARA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DHPAI6LmOhG6pwB4C6sW/Z+omkjLiyjc9iKZFx6DF0s=;
 b=K8xYXCvHa3/oX9JamSRPNPhRGc5YQ+7mK1QeWqyIPzshvuhzKFLhCfcvDpuVy3d2RKd8kvRLmKlJT24KqzRPlzQPPfSrq/KFHL38UvXZhFThND1B1NzamnT+s/+3IjgOxtIafbS/utMeuDVsVrGDwBFL4GJ5jIHrSj87aWWMjvR2LEs8VUwizRspDW3SHdZnzNhW2aRxK5TQyKXDbBoQUWRll6xqLMDl+bigbdpIx72smJvEZgJuX5qkpxOCx9UWc/K9eJ6XfEYkYQHUKxPUCDyEOwUwEy3p8KllnjD2c/Yel6N/Q7iN9G6muxievHpoLPAtm9hXApg8NjczaouXPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DHPAI6LmOhG6pwB4C6sW/Z+omkjLiyjc9iKZFx6DF0s=;
 b=UUMRiL4omR2OEyYFaemFBbnlxAHFjfL5ouNcM2p/Me5nZnx01GDhvfj1KYyQYQIqiWAS+LIrWeRLamuFhoPsMI19di/S1E1hUjGZc1KVsTunus4/+x8kRRM9oNO9n6S6ORgl6gkxK+HP6q+AohkssyaUVx+wgLRyOUeINXsqQl8=
Received: from PH7PR17CA0025.namprd17.prod.outlook.com (2603:10b6:510:323::27)
 by DM4PR10MB7449.namprd10.prod.outlook.com (2603:10b6:8:17e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Tue, 24 Feb
 2026 05:08:46 +0000
Received: from CY4PEPF0000EE3D.namprd03.prod.outlook.com
 (2603:10b6:510:323:cafe::1f) by PH7PR17CA0025.outlook.office365.com
 (2603:10b6:510:323::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.22 via Frontend Transport; Tue,
 24 Feb 2026 05:08:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 CY4PEPF0000EE3D.mail.protection.outlook.com (10.167.242.15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Tue, 24 Feb 2026 05:08:44 +0000
Received: from DFLE205.ent.ti.com (10.64.6.63) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 23 Feb
 2026 23:08:41 -0600
Received: from DFLE211.ent.ti.com (10.64.6.69) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 23 Feb
 2026 23:08:40 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE211.ent.ti.com
 (10.64.6.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 23 Feb 2026 23:08:40 -0600
Received: from [10.24.73.74] (uda0492258.dhcp.ti.com [10.24.73.74])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61O58Y8H2110554;
	Mon, 23 Feb 2026 23:08:35 -0600
Message-ID: <c9b1c5c2c5f9587c31132586fddb1921ff6824a8.camel@ti.com>
Subject: Re: [PATCH net 1/3] net: ethernet: ti: am65-cpsw-nuss: set
 irq_disabled after disabling RX IRQ
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<pabeni@redhat.com>, <danishanwar@ti.com>, <rogerq@kernel.org>,
	<horms@kernel.org>, <mwalle@kernel.org>, <nm@ti.com>, <v-singh1@ti.com>,
	<vadim.fedorenko@linux.dev>, <matthias.schiffer@ew.tq-group.com>,
	<vigneshr@ti.com>, <m-malladi@ti.com>, <jacob.e.keller@intel.com>,
	<stable@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<srk@ti.com>, <s-vadapalli@ti.com>
Date: Tue, 24 Feb 2026 10:40:05 +0530
In-Reply-To: <20260223184803.739c17a7@kernel.org>
References: <20260220041431.372610-1-s-vadapalli@ti.com>
		<20260220041431.372610-2-s-vadapalli@ti.com>
	 <20260223184803.739c17a7@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3D:EE_|DM4PR10MB7449:EE_
X-MS-Office365-Filtering-Correlation-Id: 5dea64b6-024f-42f4-bd96-08de7362c8c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Ymg5QWtOL2xkRTJoY0tmWHFTL1o2QXVNbE5uR2RPMlZsVUxkVXdqcks2KzVK?=
 =?utf-8?B?c29oVUxwZFVFMVNLV3NQZllyZlRrcGtsbFNUWkFlSWxpZnZ4VjhVdzhiWko5?=
 =?utf-8?B?SWR4bk9Rb0hrby8wZm8rNmdaN3hreDBGaTJYSm9YbE1sM29iWEhlUmM0YXJL?=
 =?utf-8?B?MDlVdUYybU5OMS9YZHRIWEJJaG4yNzVtc2kwNGxOVzZBb0FOL3BmaDh2UDRt?=
 =?utf-8?B?T0xSYXlvZlJ6bXJrbTFlR1dCR1BQUnBVbmo1RkVaMjg4ellFVGlUSEFYYkdP?=
 =?utf-8?B?aTFHSmdvQmVYSlA3V1lNbHlrUGMyczBMam0wS2ZlVzNPWlJQb20yMU0yR01m?=
 =?utf-8?B?Wlp2RGVITlNLYVNKQUI2bmZQM3FEc2l0cGRiWUF3WHREaFBaTmppQWVpdlZU?=
 =?utf-8?B?dEgvakYwZld2c3g0WWs0TVhLdC9DZ2R6Y1pRVXpzY2FMaWEzYU5raGorVFpM?=
 =?utf-8?B?WDNBOFdEb2Fad0p4M0I1SUhNK2pSUElxMmNlR2FZOWE1ZTN6VkJKcm1aRWti?=
 =?utf-8?B?YUxTTUpPLzVqZ0VOSHozV2pRQ3Z0ckZiRjRmSUZSeWc1OGZrZ3hOQm5UQm5M?=
 =?utf-8?B?QzJYa2NqcXBDVG51Zkx1TEpLMHZjMEJ5Z0NOTnVJRmhZaElkTmNVdkNDeDRp?=
 =?utf-8?B?NlppcW4vY1FUVWwyWHFMWVYxZ3pURkdobklSQ2pBMlVHdUdiVkI4QkxHVExx?=
 =?utf-8?B?LzNxVDZOWmladUowWFlpSU5HVW4zbEd1NTVKVmg1alBObUNlS3ZCSmRabzN3?=
 =?utf-8?B?U2xGZTJFOWVOKzhPdGozOTY3MkEwUTgxSHZKT0FHaWl3RjBHSmxzeGJVQnpD?=
 =?utf-8?B?VjZPUVVta0lyMDRoeUZkTWI3a2l0UU5POG5VNmxwdFVoUndiaitVU1h6MnUr?=
 =?utf-8?B?Q2FPbnY2UjYzMEQyNXdRQUt2RnVXNG8wTzRtMXl3TWFiNHBnOEcvc042NGpm?=
 =?utf-8?B?NTErcStSR3BxbWkySXM5dzRMZ2JLdGhmR2ZuTFE0dHB6YnRESTFaQ05lV1V5?=
 =?utf-8?B?RW45Tm55S2gvL25Ba2hSL24waDJNQ1dUQ3AzbGN6TXh5dFRoZklRYnl2bUFO?=
 =?utf-8?B?UjY1eExXODBXUW9kc05FYnAzckpyK2k2NWtpRFg4ZmRjSU9wbjUzeit0STRH?=
 =?utf-8?B?UHV2eHpRdDlIdnltU09KRm5XQ1BpK01HaWdpUCtDWjZLL081dHFvL1BURGNk?=
 =?utf-8?B?K1pQc09jaGxYN3J6RzZzeVBZWGEvaVdRYlFUd2FqRlBkeWtQN0haN2xlYVZJ?=
 =?utf-8?B?UnAyUitjcVBQVWlSWkIrRk5la2pick41Q3ZIczNPS0JyMDg2TlhvNVR0OFc3?=
 =?utf-8?B?cEYwS0t2S2FpVXJqK0N3WlBiTVl3cGgyVksrQ2xGT2pyV0hmTVlNcTlacmRK?=
 =?utf-8?B?TE5XR1RUQzJCYngrTk9CYnVFRVA2dU9pTlc2TnRvTGdGSnB5bmk5MUFMZzVU?=
 =?utf-8?B?LzN2N3RqK2U4TDFJSTY3bUczeXRQRUtQNTVpbnFDc2EybUFSUFpQcEhEU2hT?=
 =?utf-8?B?cnlIcEhnbDNkTm5tZFpEYTJ3T2RpaksxamZnRnUxcnVQeW9RRkRzaGRWa042?=
 =?utf-8?B?a0Q1bGdxTmYrYm5lMC9WUkNWeUVxN2RDMFY3clN4d0VsK3VpaENZRHRkNjJO?=
 =?utf-8?B?TGhROGRIbmFkckdneUgwL0RWQ0RKMFVVYzJ5V1JaYXNHRnh2WjhzMHJycURk?=
 =?utf-8?B?OGh3VlNZbUtKelMySzEvN21DYnhKNkZzNnlDMUloU2lmelJPdFZRdE9KSTBP?=
 =?utf-8?B?ajd4bmpTbUZIWmNBTHBpMlRSTzVsNFl2R0JvdXQ5V3NWaklSYjRiRkR4REpH?=
 =?utf-8?B?aFJCSTdzSDczWGVIZXljRnQyM1Y5bzVkMHg5bnIzNTZpN2FGVTFNQlcrU2lZ?=
 =?utf-8?B?ZHJYTU9ZaFA4cGZic2xXK0duUFpWSUZwVlByZEwzTHlucXoyZmpDVUNHNzQ0?=
 =?utf-8?B?Y1Y1d3ZyamQxbW1ZTWtpb2hxV0hxZ3hxY0ZzM2l4RitTME5rT0s0bEFjWnFB?=
 =?utf-8?B?bjI4YmFUOWVubGpKQlQ5ejZqM2RPWnk4dEV6THlKR3NqUWxhd3dUZ25EejRu?=
 =?utf-8?B?N0R1MCtGblVmeHVYbEpRRm9ST2hvYjlsZ3o0Qzh6UVhlRitvNUx5WWZvNnVS?=
 =?utf-8?B?UzRpbEFnL2daOFdZZ2Q0eUVEaDh3YlFxaHl3dWV1V3lLSEFtOXhrdzRkUE9k?=
 =?utf-8?B?ck9ZSVJHMjg5TWJVYjJUVi8xYVhMQ2c1eDZ1QVpEV3ErRTBiREVlNWF2dENJ?=
 =?utf-8?B?bjZRQlFSa05rVkp2MExGYUJJbzFBPT0=?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	bBm1QK6hmhPWmzpve/x3tYNyS91z/NYWK5OE1xvlcNiwIcNT6g6f8WFBMKTvq+bC3/3wIOecKGRFDyI+wQEq6Ie0wcNnFByRcAHTLH1CQlt2C5MA3l9H2OJt6stuAiof9x2LgDhkYzJBrMKns5Ds4YtXZve7Qi8rg89Rx1kz22KgUG+ZaQuESV6WN7m7IsoEraPujrvXnBsyXqUr+m3YcCNk7XObMR9ZBms9oqhsxnuOcqeLNUUOIieRjh0SEJV47b0PAFidxhck+WIcvBBXie8jLOL4VL6/tg56sOpjACNTGXAJkXvcEMuGUXp2IP9ZNbnvrsrpdaE9Gk4LwxfuR1hrrEmdruaQCScGcSQs/AF7VOEjTaJVEURoQAzECDC44QEBHeELn49vdMUZOYF21Z7n/IMhLI4+b6gR4a4oAjPvTJTeZEOhqcu5fZJRYcLc
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 05:08:44.4891
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dea64b6-024f-42f4-bd96-08de7362c8c8
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB7449
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[ti.com,quarantine];
	R_DKIM_ALLOW(-0.20)[ti.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[22];
	TAGGED_FROM(0.00)[bounces-217859-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[s-vadapalli@ti.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ti.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[stable,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: CFF48181CC8
X-Rspamd-Action: no action

On Mon, 2026-02-23 at 18:48 -0800, Jakub Kicinski wrote:
> On Fri, 20 Feb 2026 09:41:57 +0530 Siddharth Vadapalli wrote:
> > The 'irq_disabled' variable indicates the current state of the RX IRQ a=
nd
> > is used by the RX NAPI handler to determine whether the IRQ should be
> > enabled.
> >=20
> > Currently, 'irq_disabled' is set before actually disabling the IRQ by
> > invoking disable_irq_nosync(). In an SMP environment, this leads to a r=
ace
> > condition wherein the processor taking the interrupt sets 'irq_disabled=
'
> > while another processor executing a previous instance of the RX NAPI
> > handler sees 'irq_disabled' set and invokes enable_irq() before the RX =
IRQ
> > is actually disabled by disable_irq_nosync(). This results in the follo=
wing
> > warning:
> > 	Unbalanced enable for IRQ ...
> >=20
> > Fix this by disabling the RX IRQ using disable_irq_nosync() before sett=
ing
> > 'irq_disabled'.
>=20
> I'm not sure this is enough. The IRQ enable/disable serves as barriers
> so the ordering is sane. I think the problem is that there are multiple
> paths for Rx which may schedule NAPI, not just the path from the IRQ
> handler. If the state changes have to be atomic you need a lock.

I assume that state changes will be atomic since 'irq_disabled' is set in
the HARD
IRQ handler. Only the processor taking the interrupt will be able to update
the state.
Other processors can read the variable during their execution of the
previous NAPI
RX handlers. Only when 'irq_disabled' is set they will invoke
'enable_irq()'. So the race
condition that you are referring to, is possible during the 'enable_irq()'
path:

	In am65_cpsw_nuss_rx_poll() =3D> The RX NAPI Handler
		...
		if (flow->irq_disabled) {
			flow->irq_disabled =3D false;
			...
			enable_irq();

CPU1 sees irq_disabled being 'true' and before it updates it to 'false', if
CPU2 also sees irq_disabled
being 'true', both CPU1 and CPU2 will enter the IF-condition and eventually
invoke enable_irq().

Please let me know if this is what you were referring to. I will use atomic
APIs at all places to update
'irq_disabled'.

Regards,
Siddharth.

