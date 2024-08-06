Return-Path: <stable+bounces-65504-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12B8194984C
	for <lists+stable@lfdr.de>; Tue,  6 Aug 2024 21:31:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95B9E1F21919
	for <lists+stable@lfdr.de>; Tue,  6 Aug 2024 19:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4D50146A6D;
	Tue,  6 Aug 2024 19:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="e3E/rYpt"
X-Original-To: stable@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11020082.outbound.protection.outlook.com [52.101.193.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD3B143C46;
	Tue,  6 Aug 2024 19:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722972688; cv=fail; b=rNNHo1sVrmVMyDIO57ZHRsMGZCN+ppyXAyVcfoAPxdZLNwCQ1XQ/Njlj3aQHde6rWJUZqiOq1fzP5gT1dnpBMoEHZRaPShVjnDKTbqd1nDexU0ZtdGRIgUkIai1pCmVBlO7PwlH1Gb4s45w3Yayybv71ZABC/ZgKXGqzAaT0Vdo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722972688; c=relaxed/simple;
	bh=NMa8ye7eS10Ll6Kt6yd/xdqwq5a/W1NSvQ7RC9qS7+I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qvOw3LxVGQ8UWP49ntAG8XmVvJofvKkxF0RVpMGhQaqNAMsrdQN1l03K7yJTY0dfRi0s0Z05m+mCNBACN8kv9VfkvYovzc/5DN3jzY36X9A7/FUkZTOF5OKz7Vc932ffyyZCRmG18w/98BLqoc+Hz89XIZPwcPDs0GqNB/Y+ZFY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=e3E/rYpt; arc=fail smtp.client-ip=52.101.193.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P3dXEk766tSozPTZo9gs34rWV9ZkNG5FkFgD+6F3/rsf14UYGX4OWG71FVDvgIMDJSzAbNszVCze6xauUsbCnnhi9z/g99uFuGe+MCSDu0IE4lmvQ7eVOGvXF4DxkXdz4CfcEvG2+OVqa/4CFWOtSGJAA33nlsDda+CtYj/ctPJ94Vn8wUBWPUmDPDpsbH3uYGkmjNA21uZOIqPfx7oBDBPA5B4L1jpitDsnMIO+K2wMI683nFLPCgUnBzpCw4x1+YTxNCtzk+Z7mOGkaWGGlfkpjC2nyuXhVdQ3bcM20F3ytJ0GXbUUFYURYyIDDO0uE/CMlyu8STVMYfS3iiYA+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6xRNtRZdQ72dtmuaRy0IIMOhH7ips4oN1qFLKCFUBWg=;
 b=trKrWJkw+P4Taf3rJh7Xh7RwLebZ9asMTomIqZ5c3n9YECsm/kMXpAhgBdk0l3NAazdgKEvj1Kv0t0bZmyAA1n+nBxjHJBShXNxm62e8og5SS6rTCa1MHV3tCjvvWvjWbGO/cgTQQnXCdOu5AOXbIwFrUVUcJof95FOrKWqW9INQFl76ZF7r0plCtDmuYQBnxuU6KQyqYrNmoxMMjQBcA4VJ5m8MoK4wteOW8S1gJirT4p3X7owtBD4ypxz6de0u3uAHLYZFU43Kfg9IZKhhhAoz/wDxiZZClaNeuksSFvxAeWQdElJwSHEeiuDbt0vs2wMXZXJgH/QzPiftt1Zbpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6xRNtRZdQ72dtmuaRy0IIMOhH7ips4oN1qFLKCFUBWg=;
 b=e3E/rYptccZ4HYcXWtXmvZ/gFZHuUTcSPWdpBTweesU1gaU0nFT90AXMOEmqxSSdQtEOAcg6aTtUoIeGNxWdkHMRN7+5gkXOBrbCiyimUGAP3If1y7pqroMFAj33e3wzoE6GDcoktdeiJg1i0kpIxvDmG/9HIeChqyIn+d0sIpE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB6873.prod.exchangelabs.com (2603:10b6:610:112::22) by
 PH0PR01MB6295.prod.exchangelabs.com (2603:10b6:510:17::9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7828.22; Tue, 6 Aug 2024 19:31:18 +0000
Received: from CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460]) by CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460%4]) with mapi id 15.20.7849.008; Tue, 6 Aug 2024
 19:31:18 +0000
From: Yang Shi <yang@os.amperecomputing.com>
To: gregkh@linuxfoundation.org,
	yangge1116@126.com,
	hch@infradead.org,
	david@redhat.com,
	peterx@redhat.com,
	akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [v6.9-stable PATCH] mm: gup: stop abusing try_grab_folio
Date: Tue,  6 Aug 2024 12:30:37 -0700
Message-ID: <20240806193037.1826490-2-yang@os.amperecomputing.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240806193037.1826490-1-yang@os.amperecomputing.com>
References: <20240806193037.1826490-1-yang@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH5PR05CA0013.namprd05.prod.outlook.com
 (2603:10b6:610:1f0::26) To CH0PR01MB6873.prod.exchangelabs.com
 (2603:10b6:610:112::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB6873:EE_|PH0PR01MB6295:EE_
X-MS-Office365-Filtering-Correlation-Id: e721358a-7c8b-4703-4673-08dcb64e57fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?X5AS61DXVn1n/QCvMZBitFM5p3t+cCfMcJJmJioNFuvu5sxMx7LRqm+EudU0?=
 =?us-ascii?Q?AZ4EIK5IVcUZx3WO+fd3oxPB3M6PCHaBtpQ8oY4TYD84KNNc+iqglqEzOEiM?=
 =?us-ascii?Q?rzO4x35tWIF04u2WDpMFr1/qZjc/3H/MjxCEDRV70WmxtaSrA7PhAAYUKBJ4?=
 =?us-ascii?Q?fUKRYL0qmKk7B/WOOOKKQbOknjHjxpCGPLtRE8olewYsWMpMzS8KRj8cplGL?=
 =?us-ascii?Q?nptQGFeqznodpXZZrBSv3ysxhdBqXQviQXTjLp3rtq3Ctc7+rkwQ7l06IUdw?=
 =?us-ascii?Q?a+ovwFsYS6j16pjl2n+fgvKMRSoKcGxjel9/wUTyF9YVbkA3FsyAs25A4PhX?=
 =?us-ascii?Q?yqK+IpSgk6G0YLGWWd7JwzuPS64jzJXU3oSPavSkS5/nIDXF89O1o39FLeem?=
 =?us-ascii?Q?3TfrtokfY340zfxNUC6LDpT6+7fr8TuWBHyyIOrB4zTIdHmlcldeseL6n3+k?=
 =?us-ascii?Q?HdOnZokPXgHeC8T4kLxNWFODGjAxSLxEdJvpRBi6O9i4S/94KqFBwPit1TjR?=
 =?us-ascii?Q?PQscExkGzA1exJJ+2xKTc5nMA+kKbxBaLfQsmmfL8CrI0n3oM5JTA0oB01F+?=
 =?us-ascii?Q?8iGmPR1hAe1zcd18pLYli9xLBVZrUeehtvhxIpKQ7buuQJ6PXedSy8lsfH7i?=
 =?us-ascii?Q?/Bt4erug/nq4pkkQvsXwwqdWAZPCzDplk69P2jfOoW7Ll1MJ6odZi2KXJVNU?=
 =?us-ascii?Q?tJoQSIPjrBchrqTG3Jbmwx1VUoAQslRcwMMZ5nVYJgLAn98pERpeOmNDUpxX?=
 =?us-ascii?Q?0b1mEAZBIPr8kLoA3AO3XcSZI0sniNWFyn6cv7t6Y0HtzpARyGVPfBdp5nR0?=
 =?us-ascii?Q?I/o2ph871y4c+VdMobyVrHixP5adnXYoXliv/LdYPYLUAg+ciyZo+1Vb+qB3?=
 =?us-ascii?Q?BieMTKi/Y54uI3W4r79lKSCw6OfnfCD0EZ7rNzqVmDaiaXWHCXSVU/rfY/7U?=
 =?us-ascii?Q?aXJWR4XSX+zrTXXfzbObD+NfjzAOWXiwPipJGkPjRsu8ZFwcniXkn+DVp+7J?=
 =?us-ascii?Q?+3TTI1Joot4gzGXkoJIjAqZrE7CPTtnFmkehEeilL2K3SNbdlIaDeTxq2LJ8?=
 =?us-ascii?Q?NeIoa39+C4HCU54J9e0q+NEYgNod2rumPQYvXwW01mV0QGiEgzxHqDLAKQI/?=
 =?us-ascii?Q?7GZ3Z9IJ7m+JAn9hafYPeiEFuFJ460jEirKbef/5XWc2Xela6ttLotWLzJ4k?=
 =?us-ascii?Q?FxhFXbHJzM26UhfjJkUy7HEg9we1Jwx/atYhRuy/njeXp3gtRh2l+zRud9mD?=
 =?us-ascii?Q?wV56QC2F++gZX/TnxKmoGbp0cMR/YcLAWASnhPDCIN/9jCVpqkPaesdpPMKS?=
 =?us-ascii?Q?bQnHwpbkP9wZPiucP1d58DAn3EoWiUtf/rv2dorUOC+lw+qbxi+MuOmEZuZe?=
 =?us-ascii?Q?XwsAqKc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB6873.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(52116014)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?t4MRwJO9R9OhS+frvp+/1E7QaPQaA8RCOxxrx7ycQvwzrhQF86q2ZUzoJCUb?=
 =?us-ascii?Q?d3OF5CD2Ttcw573M4r2mpNKnIaT/pZK4d3A+EvPNyFabKs9q4O4CCt9t4znC?=
 =?us-ascii?Q?CSQT8eDz5QmT/RmL2qwSKrcMsMdtS/GhXlouFGFSpEzOBqX2w8PZAufG/1yt?=
 =?us-ascii?Q?Zj4wgk1OuqfG6f9S0R8QwwyxMvVBoyBLg3jES0gq3OwjdpOcKuWKJL01f98b?=
 =?us-ascii?Q?HXScYqG3zpMWGG/xZgfzsvQao1RfO7wI+7Lbkv7p4lbiT8rpbD+GBt2djhDP?=
 =?us-ascii?Q?tTREIYKmtSQOGoHby2VLiYOJN3/P+krvgEWRWVKu0kc7h4J+Z2Rld3cCzCPH?=
 =?us-ascii?Q?pHC0+CL63wykHYKKqlJJ9he1rm3vG+297Ilkhh6e7ehapdJhz+FTI0uBkyDp?=
 =?us-ascii?Q?tuCPpKk/9rcFzxDT1wKM2YrhceqsIXuEx4uROCjprUy7aeE2kV3gWdnl56Kb?=
 =?us-ascii?Q?J39+cVWQ0GbeBXmby+BN9OujYCxXQht1OOtzNlzTmskES8/rDoyoF2Sh28mr?=
 =?us-ascii?Q?cz4uSl8U4lmBRcjxcIWdKmcDiIITw87X8HyEjvCefLhrnCB/CJWP7kGkswcC?=
 =?us-ascii?Q?UZbxuS2hepIcH9AFtvBKlJnjJFK25RGxDRLN1KpuF2aUP9pra5A6J2GeIv3J?=
 =?us-ascii?Q?hQMLwW2hApC+Dn9vaHjsoywOKitNR7mF1TdVoYLNfwO6OtRtasmTgHwnE6Tm?=
 =?us-ascii?Q?eb2DTwd5wJvrWZiO8IcKnIVbznNWN4VjhQwrFEyNS0E2HP4fZomIluEIB8VF?=
 =?us-ascii?Q?JJ5uY3TgoiNDwlBOQ1v4yP0T4bU9OeThAFwsJ1+Dh47oCXnLaxZ74gIJJbW7?=
 =?us-ascii?Q?fdpFagRSPTyCr6lxkazqW/EpB5u4NlB1cdkkUX5G4BE0tLfZpPxmxhEgtYUa?=
 =?us-ascii?Q?+aILFGl0qK4H+EAIV4rVO1+f9kkbPXkcgItgxmMl78jhcILG+XHvdab4lY52?=
 =?us-ascii?Q?36UlhkjG+7gNxyJR1WNe4Ok58lZ8KHK3n7XQ4oNu6t8PAfFD+KcnMpI1zzvB?=
 =?us-ascii?Q?ku/D9BW4JSKrt5dD3R2sRGhua6Q04T6jLKGMDPj9H+5jgOVXoKP5uC4mkC/s?=
 =?us-ascii?Q?t5NifnOpDpqUk1uzoWWwDkFFBRcK3WCiwMs3B7X8Nj5eu7gFemn9huhzTXIs?=
 =?us-ascii?Q?TP1HFjOF9v8FidyfODcW0cuRjQ4BNmfjsOALpJEOdJ7+hMnXdzzGkXk++5B0?=
 =?us-ascii?Q?lP2LnmKEWNK6i/dkLe2Dwg3apEj0sy0drBeFP+fYJkhKrzww4PpatYwccpfv?=
 =?us-ascii?Q?AFtYdXneoK4PROmqJqroNWf5qZmHovCuQ0Btgq5hOONsrZaqGs53cujeq3Wq?=
 =?us-ascii?Q?I6sms0GEneBwmIa73zXvuQQKaI7QnHw7yyO3yC484WHoGbOpGjhyteYnBW7v?=
 =?us-ascii?Q?tQsIP4EO+rH5riY9OqamjOiDCyp5zJ45CiUSIoHQROBwN6GkiQtyPdJ0iYF/?=
 =?us-ascii?Q?BgegO8XPqPect0xAIEoGkpGVvkuyJym5pmF3kegujrfOXNK7zwo9D75QkQeg?=
 =?us-ascii?Q?dAAhcovjip84d0XTed5sv8qXYTk8ICQavKORcorKjDIZVQIW1/Dl6zK3lCZW?=
 =?us-ascii?Q?Ds+OCwHNHRBniIlt3F3nd7rlMwwFh2DeGS8IgKcJOOPTauY2Ud1Hxe6jbT9s?=
 =?us-ascii?Q?ibeEf3fPkr2WuujyKGvV0ws=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e721358a-7c8b-4703-4673-08dcb64e57fb
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB6873.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2024 19:31:18.2126
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KDcsVEQzV6tKEQlA8dxJ9b6b3zozSgujskF29uFHfkjLjAmVbCmmmtzO08ssvJJUss3nUVyFf/ppyLvTzW44HaMpoCtv3n//CVk90BPmav4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB6295

commit f442fa6141379a20b48ae3efabee827a3d260787 upstream

A kernel warning was reported when pinning folio in CMA memory when
launching SEV virtual machine.  The splat looks like:

[  464.325306] WARNING: CPU: 13 PID: 6734 at mm/gup.c:1313 __get_user_pages+0x423/0x520
[  464.325464] CPU: 13 PID: 6734 Comm: qemu-kvm Kdump: loaded Not tainted 6.6.33+ #6
[  464.325477] RIP: 0010:__get_user_pages+0x423/0x520
[  464.325515] Call Trace:
[  464.325520]  <TASK>
[  464.325523]  ? __get_user_pages+0x423/0x520
[  464.325528]  ? __warn+0x81/0x130
[  464.325536]  ? __get_user_pages+0x423/0x520
[  464.325541]  ? report_bug+0x171/0x1a0
[  464.325549]  ? handle_bug+0x3c/0x70
[  464.325554]  ? exc_invalid_op+0x17/0x70
[  464.325558]  ? asm_exc_invalid_op+0x1a/0x20
[  464.325567]  ? __get_user_pages+0x423/0x520
[  464.325575]  __gup_longterm_locked+0x212/0x7a0
[  464.325583]  internal_get_user_pages_fast+0xfb/0x190
[  464.325590]  pin_user_pages_fast+0x47/0x60
[  464.325598]  sev_pin_memory+0xca/0x170 [kvm_amd]
[  464.325616]  sev_mem_enc_register_region+0x81/0x130 [kvm_amd]

Per the analysis done by yangge, when starting the SEV virtual machine, it
will call pin_user_pages_fast(..., FOLL_LONGTERM, ...) to pin the memory.
But the page is in CMA area, so fast GUP will fail then fallback to the
slow path due to the longterm pinnalbe check in try_grab_folio().

The slow path will try to pin the pages then migrate them out of CMA area.
But the slow path also uses try_grab_folio() to pin the page, it will
also fail due to the same check then the above warning is triggered.

In addition, the try_grab_folio() is supposed to be used in fast path and
it elevates folio refcount by using add ref unless zero.  We are guaranteed
to have at least one stable reference in slow path, so the simple atomic add
could be used.  The performance difference should be trivial, but the
misuse may be confusing and misleading.

Redefined try_grab_folio() to try_grab_folio_fast(), and try_grab_page()
to try_grab_folio(), and use them in the proper paths.  This solves both
the abuse and the kernel warning.

The proper naming makes their usecase more clear and should prevent from
abusing in the future.

peterx said:

: The user will see the pin fails, for gpu-slow it further triggers the WARN
: right below that failure (as in the original report):
:
:         folio = try_grab_folio(page, page_increm - 1,
:                                 foll_flags);
:         if (WARN_ON_ONCE(!folio)) { <------------------------ here
:                 /*
:                         * Release the 1st page ref if the
:                         * folio is problematic, fail hard.
:                         */
:                 gup_put_folio(page_folio(page), 1,
:                                 foll_flags);
:                 ret = -EFAULT;
:                 goto out;
:         }

[1] https://lore.kernel.org/linux-mm/1719478388-31917-1-git-send-email-yangge1116@126.com/

[shy828301@gmail.com: fix implicit declaration of function try_grab_folio_fast]
  Link: https://lkml.kernel.org/r/CAHbLzkowMSso-4Nufc9hcMehQsK9PNz3OSu-+eniU-2Mm-xjhA@mail.gmail.com
Link: https://lkml.kernel.org/r/20240628191458.2605553-1-yang@os.amperecomputing.com
Fixes: 57edfcfd3419 ("mm/gup: accelerate thp gup even for "pages != NULL"")
Signed-off-by: Yang Shi <yang@os.amperecomputing.com>
Reported-by: yangge <yangge1116@126.com>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: David Hildenbrand <david@redhat.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: <stable@vger.kernel.org>	[6.6+]
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 mm/gup.c         | 251 ++++++++++++++++++++++++-----------------------
 mm/huge_memory.c |   4 +-
 mm/hugetlb.c     |   2 +-
 mm/internal.h    |   4 +-
 4 files changed, 134 insertions(+), 127 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index ec8570d25a6c..f8cab5c4c0fa 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -97,95 +97,6 @@ static inline struct folio *try_get_folio(struct page *page, int refs)
 	return folio;
 }
 
-/**
- * try_grab_folio() - Attempt to get or pin a folio.
- * @page:  pointer to page to be grabbed
- * @refs:  the value to (effectively) add to the folio's refcount
- * @flags: gup flags: these are the FOLL_* flag values.
- *
- * "grab" names in this file mean, "look at flags to decide whether to use
- * FOLL_PIN or FOLL_GET behavior, when incrementing the folio's refcount.
- *
- * Either FOLL_PIN or FOLL_GET (or neither) must be set, but not both at the
- * same time. (That's true throughout the get_user_pages*() and
- * pin_user_pages*() APIs.) Cases:
- *
- *    FOLL_GET: folio's refcount will be incremented by @refs.
- *
- *    FOLL_PIN on large folios: folio's refcount will be incremented by
- *    @refs, and its pincount will be incremented by @refs.
- *
- *    FOLL_PIN on single-page folios: folio's refcount will be incremented by
- *    @refs * GUP_PIN_COUNTING_BIAS.
- *
- * Return: The folio containing @page (with refcount appropriately
- * incremented) for success, or NULL upon failure. If neither FOLL_GET
- * nor FOLL_PIN was set, that's considered failure, and furthermore,
- * a likely bug in the caller, so a warning is also emitted.
- */
-struct folio *try_grab_folio(struct page *page, int refs, unsigned int flags)
-{
-	struct folio *folio;
-
-	if (WARN_ON_ONCE((flags & (FOLL_GET | FOLL_PIN)) == 0))
-		return NULL;
-
-	if (unlikely(!(flags & FOLL_PCI_P2PDMA) && is_pci_p2pdma_page(page)))
-		return NULL;
-
-	if (flags & FOLL_GET)
-		return try_get_folio(page, refs);
-
-	/* FOLL_PIN is set */
-
-	/*
-	 * Don't take a pin on the zero page - it's not going anywhere
-	 * and it is used in a *lot* of places.
-	 */
-	if (is_zero_page(page))
-		return page_folio(page);
-
-	folio = try_get_folio(page, refs);
-	if (!folio)
-		return NULL;
-
-	/*
-	 * Can't do FOLL_LONGTERM + FOLL_PIN gup fast path if not in a
-	 * right zone, so fail and let the caller fall back to the slow
-	 * path.
-	 */
-	if (unlikely((flags & FOLL_LONGTERM) &&
-		     !folio_is_longterm_pinnable(folio))) {
-		if (!put_devmap_managed_page_refs(&folio->page, refs))
-			folio_put_refs(folio, refs);
-		return NULL;
-	}
-
-	/*
-	 * When pinning a large folio, use an exact count to track it.
-	 *
-	 * However, be sure to *also* increment the normal folio
-	 * refcount field at least once, so that the folio really
-	 * is pinned.  That's why the refcount from the earlier
-	 * try_get_folio() is left intact.
-	 */
-	if (folio_test_large(folio))
-		atomic_add(refs, &folio->_pincount);
-	else
-		folio_ref_add(folio,
-				refs * (GUP_PIN_COUNTING_BIAS - 1));
-	/*
-	 * Adjust the pincount before re-checking the PTE for changes.
-	 * This is essentially a smp_mb() and is paired with a memory
-	 * barrier in folio_try_share_anon_rmap_*().
-	 */
-	smp_mb__after_atomic();
-
-	node_stat_mod_folio(folio, NR_FOLL_PIN_ACQUIRED, refs);
-
-	return folio;
-}
-
 static void gup_put_folio(struct folio *folio, int refs, unsigned int flags)
 {
 	if (flags & FOLL_PIN) {
@@ -203,58 +114,59 @@ static void gup_put_folio(struct folio *folio, int refs, unsigned int flags)
 }
 
 /**
- * try_grab_page() - elevate a page's refcount by a flag-dependent amount
- * @page:    pointer to page to be grabbed
- * @flags:   gup flags: these are the FOLL_* flag values.
+ * try_grab_folio() - add a folio's refcount by a flag-dependent amount
+ * @folio:    pointer to folio to be grabbed
+ * @refs:     the value to (effectively) add to the folio's refcount
+ * @flags:    gup flags: these are the FOLL_* flag values
  *
  * This might not do anything at all, depending on the flags argument.
  *
  * "grab" names in this file mean, "look at flags to decide whether to use
- * FOLL_PIN or FOLL_GET behavior, when incrementing the page's refcount.
+ * FOLL_PIN or FOLL_GET behavior, when incrementing the folio's refcount.
  *
  * Either FOLL_PIN or FOLL_GET (or neither) may be set, but not both at the same
- * time. Cases: please see the try_grab_folio() documentation, with
- * "refs=1".
+ * time.
  *
  * Return: 0 for success, or if no action was required (if neither FOLL_PIN
  * nor FOLL_GET was set, nothing is done). A negative error code for failure:
  *
- *   -ENOMEM		FOLL_GET or FOLL_PIN was set, but the page could not
+ *   -ENOMEM		FOLL_GET or FOLL_PIN was set, but the folio could not
  *			be grabbed.
+ *
+ * It is called when we have a stable reference for the folio, typically in
+ * GUP slow path.
  */
-int __must_check try_grab_page(struct page *page, unsigned int flags)
+int __must_check try_grab_folio(struct folio *folio, int refs,
+				unsigned int flags)
 {
-	struct folio *folio = page_folio(page);
-
 	if (WARN_ON_ONCE(folio_ref_count(folio) <= 0))
 		return -ENOMEM;
 
-	if (unlikely(!(flags & FOLL_PCI_P2PDMA) && is_pci_p2pdma_page(page)))
+	if (unlikely(!(flags & FOLL_PCI_P2PDMA) && is_pci_p2pdma_page(&folio->page)))
 		return -EREMOTEIO;
 
 	if (flags & FOLL_GET)
-		folio_ref_inc(folio);
+		folio_ref_add(folio, refs);
 	else if (flags & FOLL_PIN) {
 		/*
 		 * Don't take a pin on the zero page - it's not going anywhere
 		 * and it is used in a *lot* of places.
 		 */
-		if (is_zero_page(page))
+		if (is_zero_folio(folio))
 			return 0;
 
 		/*
-		 * Similar to try_grab_folio(): be sure to *also*
-		 * increment the normal page refcount field at least once,
+		 * Increment the normal page refcount field at least once,
 		 * so that the page really is pinned.
 		 */
 		if (folio_test_large(folio)) {
-			folio_ref_add(folio, 1);
-			atomic_add(1, &folio->_pincount);
+			folio_ref_add(folio, refs);
+			atomic_add(refs, &folio->_pincount);
 		} else {
-			folio_ref_add(folio, GUP_PIN_COUNTING_BIAS);
+			folio_ref_add(folio, refs * GUP_PIN_COUNTING_BIAS);
 		}
 
-		node_stat_mod_folio(folio, NR_FOLL_PIN_ACQUIRED, 1);
+		node_stat_mod_folio(folio, NR_FOLL_PIN_ACQUIRED, refs);
 	}
 
 	return 0;
@@ -647,8 +559,8 @@ static struct page *follow_page_pte(struct vm_area_struct *vma,
 	VM_BUG_ON_PAGE((flags & FOLL_PIN) && PageAnon(page) &&
 		       !PageAnonExclusive(page), page);
 
-	/* try_grab_page() does nothing unless FOLL_GET or FOLL_PIN is set. */
-	ret = try_grab_page(page, flags);
+	/* try_grab_folio() does nothing unless FOLL_GET or FOLL_PIN is set. */
+	ret = try_grab_folio(page_folio(page), 1, flags);
 	if (unlikely(ret)) {
 		page = ERR_PTR(ret);
 		goto out;
@@ -901,7 +813,7 @@ static int get_gate_page(struct mm_struct *mm, unsigned long address,
 			goto unmap;
 		*page = pte_page(entry);
 	}
-	ret = try_grab_page(*page, gup_flags);
+	ret = try_grab_folio(page_folio(*page), 1, gup_flags);
 	if (unlikely(ret))
 		goto unmap;
 out:
@@ -1304,20 +1216,19 @@ static long __get_user_pages(struct mm_struct *mm,
 			 * pages.
 			 */
 			if (page_increm > 1) {
-				struct folio *folio;
+				struct folio *folio = page_folio(page);
 
 				/*
 				 * Since we already hold refcount on the
 				 * large folio, this should never fail.
 				 */
-				folio = try_grab_folio(page, page_increm - 1,
-						       foll_flags);
-				if (WARN_ON_ONCE(!folio)) {
+				if (try_grab_folio(folio, page_increm - 1,
+						       foll_flags)) {
 					/*
 					 * Release the 1st page ref if the
 					 * folio is problematic, fail hard.
 					 */
-					gup_put_folio(page_folio(page), 1,
+					gup_put_folio(folio, 1,
 						      foll_flags);
 					ret = -EFAULT;
 					goto out;
@@ -2556,6 +2467,102 @@ static void __maybe_unused undo_dev_pagemap(int *nr, int nr_start,
 	}
 }
 
+/**
+ * try_grab_folio_fast() - Attempt to get or pin a folio in fast path.
+ * @page:  pointer to page to be grabbed
+ * @refs:  the value to (effectively) add to the folio's refcount
+ * @flags: gup flags: these are the FOLL_* flag values.
+ *
+ * "grab" names in this file mean, "look at flags to decide whether to use
+ * FOLL_PIN or FOLL_GET behavior, when incrementing the folio's refcount.
+ *
+ * Either FOLL_PIN or FOLL_GET (or neither) must be set, but not both at the
+ * same time. (That's true throughout the get_user_pages*() and
+ * pin_user_pages*() APIs.) Cases:
+ *
+ *    FOLL_GET: folio's refcount will be incremented by @refs.
+ *
+ *    FOLL_PIN on large folios: folio's refcount will be incremented by
+ *    @refs, and its pincount will be incremented by @refs.
+ *
+ *    FOLL_PIN on single-page folios: folio's refcount will be incremented by
+ *    @refs * GUP_PIN_COUNTING_BIAS.
+ *
+ * Return: The folio containing @page (with refcount appropriately
+ * incremented) for success, or NULL upon failure. If neither FOLL_GET
+ * nor FOLL_PIN was set, that's considered failure, and furthermore,
+ * a likely bug in the caller, so a warning is also emitted.
+ *
+ * It uses add ref unless zero to elevate the folio refcount and must be called
+ * in fast path only.
+ */
+static struct folio *try_grab_folio_fast(struct page *page, int refs,
+					 unsigned int flags)
+{
+	struct folio *folio;
+
+	/* Raise warn if it is not called in fast GUP */
+	VM_WARN_ON_ONCE(!irqs_disabled());
+
+	if (WARN_ON_ONCE((flags & (FOLL_GET | FOLL_PIN)) == 0))
+		return NULL;
+
+	if (unlikely(!(flags & FOLL_PCI_P2PDMA) && is_pci_p2pdma_page(page)))
+		return NULL;
+
+	if (flags & FOLL_GET)
+		return try_get_folio(page, refs);
+
+	/* FOLL_PIN is set */
+
+	/*
+	 * Don't take a pin on the zero page - it's not going anywhere
+	 * and it is used in a *lot* of places.
+	 */
+	if (is_zero_page(page))
+		return page_folio(page);
+
+	folio = try_get_folio(page, refs);
+	if (!folio)
+		return NULL;
+
+	/*
+	 * Can't do FOLL_LONGTERM + FOLL_PIN gup fast path if not in a
+	 * right zone, so fail and let the caller fall back to the slow
+	 * path.
+	 */
+	if (unlikely((flags & FOLL_LONGTERM) &&
+		     !folio_is_longterm_pinnable(folio))) {
+		if (!put_devmap_managed_page_refs(&folio->page, refs))
+			folio_put_refs(folio, refs);
+		return NULL;
+	}
+
+	/*
+	 * When pinning a large folio, use an exact count to track it.
+	 *
+	 * However, be sure to *also* increment the normal folio
+	 * refcount field at least once, so that the folio really
+	 * is pinned.  That's why the refcount from the earlier
+	 * try_get_folio() is left intact.
+	 */
+	if (folio_test_large(folio))
+		atomic_add(refs, &folio->_pincount);
+	else
+		folio_ref_add(folio,
+				refs * (GUP_PIN_COUNTING_BIAS - 1));
+	/*
+	 * Adjust the pincount before re-checking the PTE for changes.
+	 * This is essentially a smp_mb() and is paired with a memory
+	 * barrier in folio_try_share_anon_rmap_*().
+	 */
+	smp_mb__after_atomic();
+
+	node_stat_mod_folio(folio, NR_FOLL_PIN_ACQUIRED, refs);
+
+	return folio;
+}
+
 #ifdef CONFIG_ARCH_HAS_PTE_SPECIAL
 /*
  * Fast-gup relies on pte change detection to avoid concurrent pgtable
@@ -2620,7 +2627,7 @@ static int gup_pte_range(pmd_t pmd, pmd_t *pmdp, unsigned long addr,
 		VM_BUG_ON(!pfn_valid(pte_pfn(pte)));
 		page = pte_page(pte);
 
-		folio = try_grab_folio(page, 1, flags);
+		folio = try_grab_folio_fast(page, 1, flags);
 		if (!folio)
 			goto pte_unmap;
 
@@ -2714,7 +2721,7 @@ static int __gup_device_huge(unsigned long pfn, unsigned long addr,
 
 		SetPageReferenced(page);
 		pages[*nr] = page;
-		if (unlikely(try_grab_page(page, flags))) {
+		if (unlikely(try_grab_folio(page_folio(page), 1, flags))) {
 			undo_dev_pagemap(nr, nr_start, flags, pages);
 			break;
 		}
@@ -2823,7 +2830,7 @@ static int gup_hugepte(pte_t *ptep, unsigned long sz, unsigned long addr,
 	page = nth_page(pte_page(pte), (addr & (sz - 1)) >> PAGE_SHIFT);
 	refs = record_subpages(page, addr, end, pages + *nr);
 
-	folio = try_grab_folio(page, refs, flags);
+	folio = try_grab_folio_fast(page, refs, flags);
 	if (!folio)
 		return 0;
 
@@ -2894,7 +2901,7 @@ static int gup_huge_pmd(pmd_t orig, pmd_t *pmdp, unsigned long addr,
 	page = nth_page(pmd_page(orig), (addr & ~PMD_MASK) >> PAGE_SHIFT);
 	refs = record_subpages(page, addr, end, pages + *nr);
 
-	folio = try_grab_folio(page, refs, flags);
+	folio = try_grab_folio_fast(page, refs, flags);
 	if (!folio)
 		return 0;
 
@@ -2938,7 +2945,7 @@ static int gup_huge_pud(pud_t orig, pud_t *pudp, unsigned long addr,
 	page = nth_page(pud_page(orig), (addr & ~PUD_MASK) >> PAGE_SHIFT);
 	refs = record_subpages(page, addr, end, pages + *nr);
 
-	folio = try_grab_folio(page, refs, flags);
+	folio = try_grab_folio_fast(page, refs, flags);
 	if (!folio)
 		return 0;
 
@@ -2978,7 +2985,7 @@ static int gup_huge_pgd(pgd_t orig, pgd_t *pgdp, unsigned long addr,
 	page = nth_page(pgd_page(orig), (addr & ~PGDIR_MASK) >> PAGE_SHIFT);
 	refs = record_subpages(page, addr, end, pages + *nr);
 
-	folio = try_grab_folio(page, refs, flags);
+	folio = try_grab_folio_fast(page, refs, flags);
 	if (!folio)
 		return 0;
 
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 769e8a125f0c..5040662de850 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1274,7 +1274,7 @@ struct page *follow_devmap_pmd(struct vm_area_struct *vma, unsigned long addr,
 	if (!*pgmap)
 		return ERR_PTR(-EFAULT);
 	page = pfn_to_page(pfn);
-	ret = try_grab_page(page, flags);
+	ret = try_grab_folio(page_folio(page), 1, flags);
 	if (ret)
 		page = ERR_PTR(ret);
 
@@ -1696,7 +1696,7 @@ struct page *follow_trans_huge_pmd(struct vm_area_struct *vma,
 	VM_BUG_ON_PAGE((flags & FOLL_PIN) && PageAnon(page) &&
 			!PageAnonExclusive(page), page);
 
-	ret = try_grab_page(page, flags);
+	ret = try_grab_folio(page_folio(page), 1, flags);
 	if (ret)
 		return ERR_PTR(ret);
 
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index c445e6fd8579..d3848f56038d 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6931,7 +6931,7 @@ struct page *hugetlb_follow_page_mask(struct vm_area_struct *vma,
 		 * try_grab_page() should always be able to get the page here,
 		 * because we hold the ptl lock and have verified pte_present().
 		 */
-		ret = try_grab_page(page, flags);
+		ret = try_grab_folio(page_folio(page), 1, flags);
 
 		if (WARN_ON_ONCE(ret)) {
 			page = ERR_PTR(ret);
diff --git a/mm/internal.h b/mm/internal.h
index 07ad2675a88b..cf9a54ef2641 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1096,8 +1096,8 @@ int migrate_device_coherent_page(struct page *page);
 /*
  * mm/gup.c
  */
-struct folio *try_grab_folio(struct page *page, int refs, unsigned int flags);
-int __must_check try_grab_page(struct page *page, unsigned int flags);
+int __must_check try_grab_folio(struct folio *folio, int refs,
+				unsigned int flags);
 
 /*
  * mm/huge_memory.c
-- 
2.41.0


