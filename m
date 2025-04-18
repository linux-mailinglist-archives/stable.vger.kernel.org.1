Return-Path: <stable+bounces-134565-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F9F8A936B6
	for <lists+stable@lfdr.de>; Fri, 18 Apr 2025 13:50:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB7361B64077
	for <lists+stable@lfdr.de>; Fri, 18 Apr 2025 11:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CF3A26FDA0;
	Fri, 18 Apr 2025 11:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="P+Wk3xk0"
X-Original-To: stable@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2065.outbound.protection.outlook.com [40.107.94.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE4952686AE;
	Fri, 18 Apr 2025 11:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744977049; cv=fail; b=ELQt2VoDD4z936EIvfD6dHlsLGXaqjnWgSU3s6/nivDyXh53pXZ0MNCvnCVV96kV22o7VyRA+i0vtOlQIwTC7XMqFaYBNmEMvidqBvEBXDVjW3ffV+r/NqFN6H4lH1PPMh26F1Qy5oDo9/x3TMBc0XS/uEuEvDKyW5DcaKZR4WI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744977049; c=relaxed/simple;
	bh=UKmZfJqjXfa/n2W6Zhod9PjD7dfyHW2huZNXMqW+h58=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QJeCzrNrdGOBZ2+8sMQuUdGF5WA1aI8afj4Rdytq/+/RNRyoTDZyZVacn78cTCmwQXR7GbyvIl0s0V78NAsdzN+7u1gzNPA6Xp6TY6R/chp02Ei5bXtMaNT0BFzUMQmfT4TPpMNGfxbT8skeQ4SaBbEFdR3aLYGa0R31WmzeSaQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=P+Wk3xk0; arc=fail smtp.client-ip=40.107.94.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XvOfRvc8a57VWoaHm3Lq4tZkq3lwoK1YBc0PbvRVApu1flkI3C5LiYfPxuu9ArnXRb/Qdk6I51vL42WEF42erZhatqNjtQFxw+Waqv+8HbjoZmeTjSP2o214YlfCrdUYPgEmzPGBtt4SkC6aS4x1TXlfkkkHzLB6FawC8B7rDnvm2iUGrEsemzcCFANgTBlnTl0gU6nwsYpXurR7v9vBgCz9ClOIjC3puJl8ytaywUVK3O6JwR5tdROQE3PTppL3AeygG2ds/EMIHMS592vOHgIRE9we6mb3U1zxeZfVm05IZzKbDRv6ZdR8XntILlFygh+1tN9EJiH+39GXrKvytg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UKmZfJqjXfa/n2W6Zhod9PjD7dfyHW2huZNXMqW+h58=;
 b=oz09AG3NuX0vyvfOvCYhHqZKSZZhjkTTZ/chN0HX40xeSQCu0A8Doe21Piofe4+OiMAbtak//WvsNKY01fAmnq4HDq1Ezjon0+A14pJRcsxgckCbQ6g2vf5MxxGLLi4tYT4tbyvbTdg3bhO5JsypBIM8QvpyOAvxMGQWie5Pc3BsbpINy6YiwrI2fDbbcnwjc9zsuZ/yXGzrp/9psff8dlvmwFoIWk9dxOKdbxCMt8cet0UOWEyZPjAcB1zs/K2wMhVJLwr75qlLk9DJKsYJejd/Obh8E2q+Th5jVkN/8/iGrIBQ+ZVfWy7WCdk429PmISEHLlQDDPerqvV81Cci7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UKmZfJqjXfa/n2W6Zhod9PjD7dfyHW2huZNXMqW+h58=;
 b=P+Wk3xk0hxMjRvtMdzl0sJ5vjDfKW5th4Tjpe8B1ArKDDXdfFWYzuz8JBBzlXQ1Wt+WnspjZsYk6sLYL0iDsdwli+O34UYG9nyqeniYDQuK8I3UARICl3H5PwuRWd43H3WoVqB5hsmPOQsOIdmJ4CA2EetxXPDBjolncGeijvtExM/WMSdlv9r7fmFjtkl1D7/UC4TIUwJRijvXBH8cfT4OnptJiPFfdxx40z+JEsBkJKxQaOzIkVtjCpu1UWxJpWaMKFcN0rjXhZtChkeCI4QE4UHjpIz9VkqREIdNhZoogew3hzBVww+RSopHheVmS0krAmhU30qWJFFUdsK/JGw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 DS0PR12MB7851.namprd12.prod.outlook.com (2603:10b6:8:14a::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.25; Fri, 18 Apr 2025 11:50:44 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8632.040; Fri, 18 Apr 2025
 11:50:38 +0000
From: Zi Yan <ziy@nvidia.com>
To: Gavin Guo <gavinguo@igalia.com>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, david@redhat.com,
 willy@infradead.org, linmiaohe@huawei.com, hughd@google.com,
 revest@google.com, kernel-dev@igalia.com, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH v2] mm/huge_memory: fix dereferencing invalid pmd
 migration entry
Date: Fri, 18 Apr 2025 07:50:35 -0400
X-Mailer: MailMate (2.0r6245)
Message-ID: <321CF34D-79CF-4B14-AE3D-5815B8D74E8A@nvidia.com>
In-Reply-To: <20250418085802.2973519-1-gavinguo@igalia.com>
References: <20250418085802.2973519-1-gavinguo@igalia.com>
Content-Type: text/plain
X-ClientProxiedBy: BN0PR03CA0027.namprd03.prod.outlook.com
 (2603:10b6:408:e6::32) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|DS0PR12MB7851:EE_
X-MS-Office365-Filtering-Correlation-Id: f0b85d06-e76d-483a-f676-08dd7e6f3ca5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KvoFXhyEm4sCVHRzoyW3OhYjuZ4zmeKvWTfFc4LY+VlCcQR2BiSVPW9vHCei?=
 =?us-ascii?Q?XNbwh2z+sMukYUF342sSB9WcvbCSeEdDCc9aJUCJ1pFHomtc6LyITMuw9pRo?=
 =?us-ascii?Q?LSUzHdKTlYMR/OJLJar/NzHDdtoZg/ez8gPqgK04r7snFrZj6TcUybwLD6nh?=
 =?us-ascii?Q?usl/etOYetaZRdIIUpT4G3S1qCJ6pK8cqEEEf7R609ksozT9Beq6mxl0Bq6w?=
 =?us-ascii?Q?jtw3qrzNGqG9d8uw9HCejCVypkOPnZwSrh+xcOth51sMVwEV1eGByRAxTV8w?=
 =?us-ascii?Q?KquH4BIXxAQSVGji+mQhePX75bHEmVMRecEJ3xbcJ3wG8Hw3qW0Gg5HEqFMy?=
 =?us-ascii?Q?iPWwJR7uiHgGcpzFntHMePRVDHvHqsLJHRZ6sDdSpF5BeYrjre/spgpvCfJv?=
 =?us-ascii?Q?PuWDDqvgUaKNmJuj9+EikANOLAdjXJISrdqCAQ/IhxAZ6q+W2pnO8OEXndqE?=
 =?us-ascii?Q?9P2kFWIlf/To18WJIMckn1OmfvbnLkVfQWV9NYay129RrGIXlSeflpkrrDEV?=
 =?us-ascii?Q?/J3ADjy9PT6Y/nlBhV5Idk/ypFo3P9/ToBrYUkzJfDeWfQ/63sEJv5NWjWR8?=
 =?us-ascii?Q?Pk+lGZxJ7Gdgo2jpmXLr1ExUOwbAk8RbhAlA8k0W854PlJ3UMQAkm89joqvw?=
 =?us-ascii?Q?vZP/0V4LnjOE7e6jHdApMHs6y8nKLuSFQ7DxLTDEyjr0XDKeksrNeix5crBg?=
 =?us-ascii?Q?FZVtz0MhvKSdVJOK6larPb9iYY1xjB0Wv/WOFIlYgQZbvZEg19L9EMISrZVs?=
 =?us-ascii?Q?27/vJKkQEszBd/NgXX70tErWJhSxo8Ct79f9+AsNkI+pNFBYUoVEEIibkLrR?=
 =?us-ascii?Q?WMit2OTkh2meMNoSHWaCM/7gwZn4e3qUzry+HW4y4WNdUogrbog/YN/r0CXU?=
 =?us-ascii?Q?BQCs7sqWHu92QovEDATTdOOOa+rk1TU2ZuJ62LgNzQ0tQXTzbOWbUbNBYc7q?=
 =?us-ascii?Q?LA22Io+qWBubGxK67bauBbUGLwynhM7SPjf4vcVlTAwz42RKe5UARbZ7nyYF?=
 =?us-ascii?Q?IghSrcy5PevQleFVr+bgx3y5arUgyV63Wyuflia9pT/EUqqwdtRYJrVrV9l0?=
 =?us-ascii?Q?Zp61vq6/2n2REb8ny/IPdPgQOkNy8cNm6uPPdiBL056xHpnH8v1BeZgUi5YA?=
 =?us-ascii?Q?414RpSQm2qwjH7F92qyunCEc22xVhbDHutawu/U7E5/OGXhK1x13XxS/3tDc?=
 =?us-ascii?Q?ALvYYw0Rb8MxaqgSt0b+rVyFdrU1TFv8Fjg4+qbilAFlUYcR+XglCw8EH5Kr?=
 =?us-ascii?Q?5jbeLnQEzGz7xfN8KV7E6MynoiSW0K3Xi0ePQwOJJj6DHrLjegzv+xmqBQp2?=
 =?us-ascii?Q?GPHofi9bSGRDjctNaTX1sKr+CD0enZa3DihYuO1WGnZg18EryB4c/pgrpnfb?=
 =?us-ascii?Q?QgvcrwND2QU53uLlu6kEUV28GlLqVAQlbBJSjpb1vxRvDpgGgRpLH0zwTyW9?=
 =?us-ascii?Q?GD/K3aB2zdY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?asnCRyit1jt4/hpNCu6AAx22ypPDeqr6UxXu1gCo8hWnNrsiNlZBZwk6yLyP?=
 =?us-ascii?Q?QnZJRujC/1q75rbQjG3nzKrlNoqTlGdEM048rpU4EWas/7UWyLJCyTVXid4z?=
 =?us-ascii?Q?hClzdcsOGoaDn8722isQMCzqzeOfP/vA52CSi3LrXVt/RvwTogLua0mW2YoE?=
 =?us-ascii?Q?7PuSnbPF0+lAm9jKhrQdqXXQcRAOCtbTvPbB87RAylOIcxUjT5O10B7UDhl8?=
 =?us-ascii?Q?92iY68ut9iDgxVnRVwdJAZJatlp8HEHnsP4cnVlzm5s5SOrdbMwC+XBXkoiD?=
 =?us-ascii?Q?7c7YHEbjdlyZe+AdUnYf8uNAhCeWahFtF/eH53fABI7zhXOLxkGhPWWQ+MFl?=
 =?us-ascii?Q?D4yZzM6TyN66BHzlLictYXuAQYcvwEeHzeZvClbuC36ujSsSnZbT/sk82k0P?=
 =?us-ascii?Q?TQgBQoKceRYe5Gdqsg764aFJcdbJIS52rq0IXTiTMxmqqj+dPngBjBJH4+CM?=
 =?us-ascii?Q?2X+8HJtrRcd2bkn24ztcI0rJg5pMKLE07iZPs6lDrexTGuJlbwWrYL9rFaum?=
 =?us-ascii?Q?fA0QgMGg/jwcGVS6SBjBVo6BLO8U2ROPND3uo+6x6vO7z3WSrbkhscg5pKLZ?=
 =?us-ascii?Q?+YEtlimPE4UXene29p21cZv2KTfMUm6qoTtlPbk7w3s4iEBtFLZFugEAZYCw?=
 =?us-ascii?Q?3a7F+kaLyXfDm2GnviUscxc1EuUSCBLbuEGpOhyjTW3I4baIYypUp3ztwxL3?=
 =?us-ascii?Q?8O4lq127S2GrNWg6tgQNSHLOAyJh2C/pxn+GEPtGEIjyjP5JYe3KigclP0Aa?=
 =?us-ascii?Q?Tngftz9UJ/c7DP0tnduz1umCU8bcs/hyZ1Sep4lRkojSrhMSZCS2holkiJVK?=
 =?us-ascii?Q?E4Cs1ljpkVntz3ZCCcl5a9DEDi0936899Ps1X91PkFx61ewYvPnZS5ZIhKsL?=
 =?us-ascii?Q?pm2i8NaeEozmJFue8kaC6DMog33qvUw0UIoU2Tew4Wh/qD8xcZlg9T677EOx?=
 =?us-ascii?Q?jat3T6uzgD5tOFzMyx+xEsf2vQHKB7P5g4lXki03Aw/vPOOi9Hq1cNAdpGce?=
 =?us-ascii?Q?1da4ELQ+8yj4pkqseqmcRgtSrI3ddMOQUZklgVZVyc3Mi1+Kw5jqebRETCdN?=
 =?us-ascii?Q?Yv+tglA6pYlgpH9WUdQDhXTTMo1T1AvbxwoAhkfUvo+lSC9uKOT7f3odKycn?=
 =?us-ascii?Q?Nn4M5Up82OJmHmfKMY9+XOQ3ehL/+hd8EVFvDOa3n+yRn2jgoRxEAqfl88Oj?=
 =?us-ascii?Q?yW1Ud6S0PP/TVV7fGlSuhFS+zuQQnnsgjJE49oeAY9vP8WqIUSLCSjZKhFrG?=
 =?us-ascii?Q?YNt+kBQ/SN4K4kyz5cx3bL2cszu4xI9CoFXWSDamt/kMbLKaVx1v47H7WzwQ?=
 =?us-ascii?Q?yBMS5hZTeIhETjoBoCOCIU5N6n4oBj/8k/X/wioHi9YykkNYT4WAc4jw0L4k?=
 =?us-ascii?Q?mSfhFDOo7KVAmDZ9CuHHil5X6omGkEyflcFVMAuh+GDaKbD53SNOTVKcBDmt?=
 =?us-ascii?Q?09DMbfSfh9qTBdPXenPWaq8PiOVOOVEnIhy+XYiKHVf0oN6cJE3f7KvH575w?=
 =?us-ascii?Q?+GRy8YDE7Fah179dXJYawPdyUbsqfk1SCyrva5IRFvlrYJZm6g4wka+DPcEC?=
 =?us-ascii?Q?GjJw2qrzXRKftVnpvPM289Ik+esUq9o8jmPIJqtM?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0b85d06-e76d-483a-f676-08dd7e6f3ca5
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2025 11:50:38.1603
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3gMPyEW2Q31ebAm8+MT2nZQ8MNGa6Aw08ij5Qw2PLWibJl0YBQX0IHxdJBBiWvc4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7851

On 18 Apr 2025, at 4:58, Gavin Guo wrote:

> When migrating a THP, concurrent access to the PMD migration entry
> during a deferred split scan can lead to a invalid address access, as

s/a/an/

> illustrated below. To prevent this page fault, it is necessary to check

s/this page fault/this invalid access/

The rest looks good to me.


Best Regards,
Yan, Zi

