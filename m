Return-Path: <stable+bounces-189159-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B80F1C02CA2
	for <lists+stable@lfdr.de>; Thu, 23 Oct 2025 19:48:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DDD0188B7BE
	for <lists+stable@lfdr.de>; Thu, 23 Oct 2025 17:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C058630148D;
	Thu, 23 Oct 2025 17:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="riN5kN7K"
X-Original-To: stable@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012028.outbound.protection.outlook.com [40.107.209.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD4B296BC3;
	Thu, 23 Oct 2025 17:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761241726; cv=fail; b=Qi0qCI53c95CWFYy2SjlR7av5ZDZUlRQRZCwsEJ4rtpfWue3RhdKE4YbZCLRPOY/V8U2sk+40FZG6sRVn/qg5qi/d7THnz7URzlVoO3CF8ESIwgskRtgM9EvaloY3NjBvBlg4rh+ClE6K7QWL8ubMhVZW9kWdu83aX3mcfTQV6Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761241726; c=relaxed/simple;
	bh=WF6rBV+kcl2ZvBIQglyzVziNSymb5HW1Uat0pNSIZ90=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Nrguq+G6x/si3ox93pjDyMZctYCv86DGJfaM8Zfy5JBB/U44Mn7izWBnVo7Js9vniPmTQz1+aTrn1Ue10Yu7Qe9LDgASvZv4LxnRTdOFBjaoHYLmuxWxyESc0otVPyK4Gt6nRXa38YiDX9LAUxz/e9Rfx4np9QKSmz/MRKgA5bI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=riN5kN7K; arc=fail smtp.client-ip=40.107.209.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YqnycgLTwNbEPvbSGreQVwBLqZ5qaTFzhW3kLw+a9sHqv8z2jjUkFXLqYF2xsnbBVqDa5sHxNFr3kXqzGehFVpuXkL/I1B+m/IMFuGVpbXRW2giAnRIG6xei0y3uNGd3io6LMUiOIgcgvwPPTjGh622zLvNXjpCn/u8nZXJcMkqdWdDR28jlVZ+ymjliMB7kMrKUWX6o2nkGTZQgVYlFQoip98MJaGKxm8UClJRCGzLWaFF3AyhbemHrh8ULZKAklIbQ8FCiSbEaWdar6iQ5HhoFu1XO3MTBwHy5fMI3ol2GzNcsPmEH/FI93VJUZn0teo2EALHKPV5HKESWD5VNKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uB2vWcSw2Kh+/zGViSUn8FTLR0RJLubYIVDGb3rrXyM=;
 b=tT5bYJKuXbnYXCgG7ibh5cFbIqQVkWsUlgSDSuTKZHGHFAAULkCg2BVsDfPnCRGjTNwFyK/WI68iXsyFQbz9zF/9fvJ6sqE4bMCD7JpQh0Ol8HvHt4vLVfvLln8rPKqd9LJBzCbPHWBMT7mIN0ekE3hAfuzlpNuJh42IEA6n4wVxPiclqDFUrl1ks/7Gv4WMOADUsbhQLosOnJSR6JxB1LBm55K6gpsbCLM5jSLbKgR/WXjBoNL6ilQOdvDxKqz8Ir0258uugR/KaHewdD65mAbuPsGmi//aJ+WLTmXXmDiN/MhB+EQ1A+H80Lu4a10Xp/gGn0EMmSBziZvJHZ1Xzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uB2vWcSw2Kh+/zGViSUn8FTLR0RJLubYIVDGb3rrXyM=;
 b=riN5kN7KbWPysVkRo8R3DrKMLWPN2PbYYUPtRGm3j5Mi66NKu5UcmybFgtRHgGIycyFzQJDlK3+iTTdV/0EZ6AOjSpen7D3ewoNIVPQw8pGKmjxOvGckeLoMMBarXU8pu/No3nXH/Xkz5/tzpwgDnrSslTlEruMfHsi1iXp8ZnXEiBHtPcy1xxBHruzfCI/tTMN+j/Zco/8iJoNgVJ3sqeaQdFa/j9+DyDveZc151rcKTezcj1fCATaqUVQOMn/KnB1+6DhGr+GYhoZdroiTlNCqCRwgCsLBrpWvGWfpmlquh6taJV3ZqYB5PnHUECqHVV4dV8b0SIvv43NgWtXrTw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 DS2PR12MB9750.namprd12.prod.outlook.com (2603:10b6:8:2b0::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.13; Thu, 23 Oct 2025 17:48:38 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 17:48:38 +0000
From: Zi Yan <ziy@nvidia.com>
To: Kairui Song <ryncsn@gmail.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Hugh Dickins <hughd@google.com>,
 Dev Jain <dev.jain@arm.com>, David Hildenbrand <david@redhat.com>,
 Barry Song <baohua@kernel.org>, Liam Howlett <liam.howlett@oracle.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Mariano Pache <npache@redhat.com>, Matthew Wilcox <willy@infradead.org>,
 Ryan Roberts <ryan.roberts@arm.com>, linux-kernel@vger.kernel.org,
 Kairui Song <kasong@tencent.com>, stable@vger.kernel.org
Subject: Re: [PATCH v3] mm/shmem: fix THP allocation and fallback loop
Date: Thu, 23 Oct 2025 13:48:36 -0400
X-Mailer: MailMate (2.0r6272)
Message-ID: <22878093-1EAC-42B3-A962-24204628466B@nvidia.com>
In-Reply-To: <20251023065913.36925-1-ryncsn@gmail.com>
References: <20251023065913.36925-1-ryncsn@gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BL1PR13CA0175.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::30) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|DS2PR12MB9750:EE_
X-MS-Office365-Filtering-Correlation-Id: a51e56d4-4140-480d-c6b9-08de125c658c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gWpLhMotM4WH2jR2GW0oTPcYooXSeOoaX4m7P0QljZY78OsijYL2DHShADM2?=
 =?us-ascii?Q?Dz+7kg+RMLZFz846YFpihgHKu4EK4JX2dOpyBpXCVij9nie7bwox1AajI+Sv?=
 =?us-ascii?Q?pZ1Vgj/uFBkf10cjpivc5LESWN6Bzfp/wdJKf5X3ovy5daLSwj3F5ut/60gG?=
 =?us-ascii?Q?OMVW4ISg9LTP50/aHVJfIP33AeieGEPFoZef+wbuPxGsaBptVJGfAKM4V350?=
 =?us-ascii?Q?wS+zU/EY9tA2nMqWeuEeHPZykYm7mxPXJQopA4qldWO2s7Bqa95p4I4apU+W?=
 =?us-ascii?Q?pbP1+YRzeQD7tD7aUBLz8WAzcNBnUxn/ZHM9TnsJP3Zpj9w/Hvl0WVZGJsCs?=
 =?us-ascii?Q?tAUdqDzpcrcvQox+f/JHiPxF4OkWYUo9h4en7TdbZ4Txasx0BgaxsuGJg44+?=
 =?us-ascii?Q?clyVJewFaz9E2tFuQ9aUDITwJ7cyVcdvfkV368opOzxe2bxe3dOD7QzBTj4w?=
 =?us-ascii?Q?NEv3SPgAgE3F+3ZAa1vvcu/jxYk5b5kGMoXu1DVTO7mqi6dY12pWy7zZpmaI?=
 =?us-ascii?Q?mcw3mmehRRCyipGPTJsuGwilAHi+4BQY0wSAL4PTDpQ4v/x5tZ3Jy1V4y6Mw?=
 =?us-ascii?Q?MEQ5o44dSd9Hj4kKuSQikihVisSBbpzzpXGem5VIjtVIRHsolzHmgG3Fp//z?=
 =?us-ascii?Q?J0yz2wRgN1YB8fzHbbDZX2c7MjqjLBMOnhS1ZqRY6UuK4CvSM+NTaQ8ysFIE?=
 =?us-ascii?Q?vf7/AE6Aw1iJ+CHeAXuDD/UdoLPnJ7U90ZiMgu7yGQTkiXAvwtoKzNcgjPah?=
 =?us-ascii?Q?m9s2ArxiW2qz6y+r2l2Nx+bIR3lxD7hRUgKJlOOgNgqJDS9ZZg4811m4ROZ8?=
 =?us-ascii?Q?6CUOPERMROMxlDY6133LhE6KIpCkvg8rS2sMoSd+scHEqZPSbJMBW1e5XIfE?=
 =?us-ascii?Q?CpYg0nLX1xQR3VVDqOUQ5asEAGSRKg7RnWhw4ND7UyUgwP9RcvSdhrvyxywT?=
 =?us-ascii?Q?znUTKC70evw6pReRtwIVuBeG7H+hidkiBV0SvtWKu4D1xYRtlODS2UZfryLG?=
 =?us-ascii?Q?MBMTGNJKXBAXEFdgEK9zGFXIS0W7SWeW9L7eiCRjt6dHaRnvtnF5/cg/8FmR?=
 =?us-ascii?Q?XVnpoBYqg3QKRgIofjJ+390XMgFFaffYBv8HHlReHAx0210uYQbLGAi2rD3W?=
 =?us-ascii?Q?pJ0Z95toQVBJlTuyarhAG7aIhQzqn6INHNcmENhI+eX3kSxZppyUTkJzdtYW?=
 =?us-ascii?Q?pfXz+3fJAG4fRHgFmVXevBHfuO7Ijq4Q8K1bplYRy2TeAQh8IDfJvkingfO+?=
 =?us-ascii?Q?6a/irFC1w/kFG8qWuGbORuzua1CT6HHpWe9id1DM5HZGPRjOaGhaNsD3HPRW?=
 =?us-ascii?Q?h/8j9zKWGKol57mQm0Es1+jV7WWyjl2i6UcyPlnDUsEOgjPJHeJg8gwOr9FQ?=
 =?us-ascii?Q?xpW9U1zZbGpIFiH7yYqJbtcLUD5AjK4s5wovsjfkNeYZQpLI+I9hA2hv70JN?=
 =?us-ascii?Q?n5CwL/mxToBHj5V0GxjD/4jzy4j5Zmw0DbFiOu6tOoZL5vCT5nT+gA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IwnT0HteDfYSOM5WwEgAwzPtI98ywYK3c7jU+JdyflcjToUE5Z0rtK9FdoQH?=
 =?us-ascii?Q?AUUEmr99huQGSnGB6/EDqwQUrHU2yBLPnjLlNNvVhDNY9Le1fQsAmVfjjH0T?=
 =?us-ascii?Q?LDv41Zocxi+8Ptoc89MZCaq8y83unumffAQDza+TejhLlf/XWCgm5GefDGJ+?=
 =?us-ascii?Q?74Dwh4HAXhg2JwqMmadIi9OZVU3YskW6fDhsjJy/oURXQjTHVzyXnkaC3DDn?=
 =?us-ascii?Q?nsJkEvgpkSHaxYQ7paxTtRM2BO2f+vVHL6JbctnLynouEIaoA6hxrFy0ykJE?=
 =?us-ascii?Q?wmMkkflKkZ1emXxmcXYBwccXeZW89fpiBI17QzQ5+0cybMqAFen9rQD0vw5A?=
 =?us-ascii?Q?65ObRzh6Hkd153wFdQUjaCqLksaHlpYJgUpYbP9Ov4oVsBg9dflg7v/ZXPbG?=
 =?us-ascii?Q?qt8ZvV/VukcBFQoSzgPBfV8OqPA2Ms3Vt4RntctJPYeb4pmjl8aoTh5YACIZ?=
 =?us-ascii?Q?TOKP/kLqM8jLLUZYq4uLflkQ8Lf5iFsSH4t2Jo9MpUdbn3xOzKdrUW+s7q+m?=
 =?us-ascii?Q?GzqKDZrucDBJrzMixQ1BUIZXj7/Xh8tHTA5w1Nzp+YkTMnmz7oWsKH68UdyV?=
 =?us-ascii?Q?S6H19b8aRx99VKmhm/5ehLbhe/RuYX+xmhBKod+wwYY/Heq+Z1vsM/ISigpV?=
 =?us-ascii?Q?WfTxePqeU97bxLXL50RErRz2Eh33h7tvbS8hyq2h/XZ/ElZRYhdf7DujT3BE?=
 =?us-ascii?Q?jCMvD0Mk2QH2RBv2upQCrulWYIc8N4qZq5USBVD19hXjVRRj6USmAFnip9gO?=
 =?us-ascii?Q?xj5tNgVUKwU4gmPNMvtjZyS+I4RhJMhQufAnBKbbGmvXZ4sxQ6iBAkWhPEyH?=
 =?us-ascii?Q?ImN8D2LjrhI2nS54NlTCXXi3/uwRIOFf5SDS9eoQzzK5vxfdMwAhqlQK2XZi?=
 =?us-ascii?Q?cXUKml0iKyrc7hMzwz44sTONyw7rFLu4mLSzp0KNWsBTkW9AjOgjxoIeDJ0T?=
 =?us-ascii?Q?w8a2am+0AVOenpmgT/As1toQk9bBAYm+0k82wyX+gOlPqe9iD+4BPEVPfOkI?=
 =?us-ascii?Q?76oC+15U6rA7A88omiUD44D6EV0o81SpM/FwPYhMy/Mof4r4jx3Na83XhS5d?=
 =?us-ascii?Q?G7gYf0+n4cdBQ96NkxjFnaA4ve/fOVnUwsEx1QLVmIJWIgdOCRvVU73h4joG?=
 =?us-ascii?Q?rZ373Dqz18K+8RHRT8s9Z96ROwBud0JEHpQRiUeoCGziVqTTqamhZ5iiEJ4r?=
 =?us-ascii?Q?5k03ULX+HhPKqBAkuuFofoW2/N3Mzwsb6MAol3Ipn5l9kI2INP7vPBGglKFP?=
 =?us-ascii?Q?CdUGkHMSPhBXjBsotoKDeR2dGovqR8U8v0B291X9ByWUQhv+k1XJTuQw4aZr?=
 =?us-ascii?Q?+G17Z+7sljpU9yYftYBU1+aTWA7XTqCkniOQJVYjEdxw8lCcfIj5smXpPkn4?=
 =?us-ascii?Q?mR0cFvpZewJrZdpoZd/wYWaMCB3hfm9103DHa0ujbbKxZ+ehuBruryKDZ5hS?=
 =?us-ascii?Q?c4yxcIhvKfEar3bZQZq0YQtErqxV9UFN6quaO4CY3JBbplHysjKjhKdYU0UO?=
 =?us-ascii?Q?UGlmc5Z/IA99xhbIhHCcc7WsUNyz5BaCrAaXj/mh0TdHZsmtLAjnMGl8pFnh?=
 =?us-ascii?Q?uuq74Eut4QskOjY/0oy+35qh08ZwA5FHmlQ18ZIc?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a51e56d4-4140-480d-c6b9-08de125c658c
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 17:48:38.4531
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gVSrq/mXsioWdzISCfAgsKGREIIxbWqRWj3PHmJ/+LBfqfpjiXNekqD8jcJ9D658
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9750

On 23 Oct 2025, at 2:59, Kairui Song wrote:

> From: Kairui Song <kasong@tencent.com>
>
> The order check and fallback loop is updating the index value on every
> loop, this will cause the index to be wrongly aligned by a larger value=

> while the loop shrinks the order.
>
> This may result in inserting and returning a folio of the wrong index
> and cause data corruption with some userspace workloads [1].
>
> Cc: stable@vger.kernel.org
> Link: https://lore.kernel.org/linux-mm/CAMgjq7DqgAmj25nDUwwu1U2cSGSn8n4=
-Hqpgottedy0S6YYeUw@mail.gmail.com/ [1]
> Fixes: e7a2ab7b3bb5d ("mm: shmem: add mTHP support for anonymous shmem"=
)
> Signed-off-by: Kairui Song <kasong@tencent.com>
>
> ---
>
> Changes from V2:
> - Introduce a temporary variable to improve code,
>   no behavior change, generated code is identical.
> - Link to V2: https://lore.kernel.org/linux-mm/20251022105719.18321-1-r=
yncsn@gmail.com/
>
> Changes from V1:
> - Remove unnecessary cleanup and simplify the commit message.
> - Link to V1: https://lore.kernel.org/linux-mm/20251021190436.81682-1-r=
yncsn@gmail.com/
>
> ---
>  mm/shmem.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>

Acked-by: Zi Yan <ziy@nvidia.com>


--
Best Regards,
Yan, Zi

