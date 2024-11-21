Return-Path: <stable+bounces-94487-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCEF19D4659
	for <lists+stable@lfdr.de>; Thu, 21 Nov 2024 04:49:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 703EE28236C
	for <lists+stable@lfdr.de>; Thu, 21 Nov 2024 03:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC0704595B;
	Thu, 21 Nov 2024 03:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EV6/X8xf"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2070.outbound.protection.outlook.com [40.107.220.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D95B10A3E;
	Thu, 21 Nov 2024 03:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732160987; cv=fail; b=qkZ2BVAR1CS3Cz6nl7Dl5PunNHvP26wknPvVPT5AslSx8XjMdNuYUqxu6R09guC6cSqM02GO3UiNw67YbWwJUd0YqsJHMz3kTOX+llyRRB69JyUXJO5Ys3ttSvqGjNziZJSS/dYyf/85BCzMPM8CoWiYc7oNpMMHRYP2f4T6jRw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732160987; c=relaxed/simple;
	bh=eF49+9xRHRLY+TmrXCsH+QZk8uJBcppRioj2sP7pQok=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=fJUL6JL5JM+o1UqCrhWVM8AamDC6TujfYbxvQXGYLxW81jsKgswjLYtMCWoviykPOA9LpWhb046fimzOPr3QAYlW0qdshYalgMoUUJhCX7hxvLapRYaZHlmROcEADCPJA8571uWH6jgzT3ik4veNCEOzNGazmvqhZJTJ3DFHr9A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EV6/X8xf; arc=fail smtp.client-ip=40.107.220.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F01rqlKfqXAFLfMSM9f7A9u5ZMxirrwTh+o+azJA0bfwZY8ozwuNkElH+xV0uXTvlii1E0rUwtehxXpucl97uBOKmfT2QizY+AvjKeVlTpZtAxr3U73jQio5V7IOUc6WcK13OIApRjq8uI1dvEgI/I6huUUK1HdTTtWeLv0EzrAKrRg/5yiQRYEsDE1Do4Wx9MP6ymByuYnhA7rkA/2SxcDhZtSIPAb2iNuIv+wwbHRD/+xjLy1nECSO5ylPyu7psBnkpIOPjroztcaCBn/81lFHrZ5rVcarKH4HKHcIBVH8bXRyOSTZ+IqBA5neuKGh/meDEQKwUa9NWPGstYk2sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ev5FmAIzpZYSjnRVgilauia7Iu/E86hqcf2/cWen3/4=;
 b=D8rePkwtbbC1Vfzhr/TdGu54Qq88oItNw/+bUXExH99UfFOd51qbJyPJirSWbmRf+VIc9/GtMkjMh9JPYefDqF0CNW5d2NtDZrIIkLlSY/K/k6uDbrigVnTZEI6ZcdYlvHYi7+kImxU4fo6PFJmarUALVfrCyK68lh00DhhiAvj6S0HBMlYjgnDBUVlq9oeHAqfmoDV5W8/iWAqBX6biJ0s9PZ4Ul2kGamL/rQIl7fX5C1Yc5bt8SFE2EKMKK3hoMlIUf3udBNVhbCHfiisvwcUvIfqbsfPBNJhA2T70Uv5ZBLOnudmHzmhya6raABaxAVwlkYcPWBNXQAuLDr2u7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ev5FmAIzpZYSjnRVgilauia7Iu/E86hqcf2/cWen3/4=;
 b=EV6/X8xfCtwaXUgxp5G8cnnuuvgjoih3eAAGc/jJ9cFJSXhBAYyJSZVbpkJbMXFUg62GoGjwMWWHRppYapVOa4q0djaV8gUL2hl/TviXgzHVC9LZeukEYcty8Kgx99uoiULI/6cnmIcw3xoDjduE25TmEVF+FOSYrxwVKwbdI6K4FLKx3ul0Ali1va3kM5eghyKkTw+aZInHxTvdVB+Fld+EvbrKPnEo66IwJq3eKUCKuVKlO9HZtmn49BPzWJzUHEowtXcwNoEkSzwS1lFSqxlCXeRoCMtCqKThudMTDyLpQoQt2J67VzpNnIMqsdWwaddXHjw9S4lx5/4uGsSOag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ0PR12MB5469.namprd12.prod.outlook.com (2603:10b6:a03:37f::16)
 by SA3PR12MB7857.namprd12.prod.outlook.com (2603:10b6:806:31e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Thu, 21 Nov
 2024 03:49:40 +0000
Received: from SJ0PR12MB5469.namprd12.prod.outlook.com
 ([fe80::ff21:d180:55f2:d0c0]) by SJ0PR12MB5469.namprd12.prod.outlook.com
 ([fe80::ff21:d180:55f2:d0c0%4]) with mapi id 15.20.8182.014; Thu, 21 Nov 2024
 03:49:40 +0000
From: John Hubbard <jhubbard@nvidia.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-mm@kvack.org,
	John Hubbard <jhubbard@nvidia.com>,
	David Hildenbrand <david@redhat.com>,
	Oscar Salvador <osalvador@suse.de>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>,
	Dave Airlie <airlied@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Christoph Hellwig <hch@infradead.org>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Peter Xu <peterx@redhat.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	Dongwon Kim <dongwon.kim@intel.com>,
	Hugh Dickins <hughd@google.com>,
	Junxiao Chang <junxiao.chang@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] mm/gup: handle NULL pages in unpin_user_pages()
Date: Wed, 20 Nov 2024 19:49:33 -0800
Message-ID: <20241121034933.77502-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.47.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0027.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::32) To SJ0PR12MB5469.namprd12.prod.outlook.com
 (2603:10b6:a03:37f::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5469:EE_|SA3PR12MB7857:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c7a9bd2-f941-4dc1-8998-08dd09df86ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ncxr+BfFbQe1hW4eyvxDPHvHHeG4pZmjhDzOT62Wq3xPV6fP0M+PExwfvuY9?=
 =?us-ascii?Q?AT2maK9vJRhthfx5EmA7AAciMtQe+8GBFYpjfU7907vADGhXsZOs+kW2+CZn?=
 =?us-ascii?Q?5DXsybjRQ1yCM0v3LrXGvRFvLXbxb/buMTGdBfOyTlV/4fUfJAUZeQEp9Od/?=
 =?us-ascii?Q?tJOCaWJr9nk3ZYjPTNkEMJ1NfjWVuOrjsh2E2RQ1t/4m6IMVlo1IAiTsC26n?=
 =?us-ascii?Q?fGgLXHu/k63xQ/94R5AUFyV94vneym1LvA7JsbhARDRr9PlvRygc98U/YPjx?=
 =?us-ascii?Q?+DDvm0rtUSu5R9lv88lDlii4vt7EWD1QgZfyvxcI5rECpw8vzDTtGvF65apA?=
 =?us-ascii?Q?/+h/CWGthrpzV4lOf+HbleCuRYmG3tMIytlu6ImqFdrAgPwhggpIH+4jSYJc?=
 =?us-ascii?Q?hgFvT5cMuuiax9ESB1X2kBC72KUJlf64+Ku342TzZOraMxp/PczKTNskzIb7?=
 =?us-ascii?Q?emAcDWUuCzhBOpAn7OFZG0J4LjhCFjHUjDBTfjvg1GaU7Sv945LkiGzU7qi1?=
 =?us-ascii?Q?b60zF8bWTnwXqLeibA3nv2U1YwYuQkqIooERUxv9AWQ2eoXWx/tUlRZxWZ8j?=
 =?us-ascii?Q?D9Bhv+sGvozY/XveJQpwvS9N0WrEM/m7vjQbEgBUNaQcFGd8o6ElofimdIWo?=
 =?us-ascii?Q?4ypR5UfHc4N6ZSNPJ2I1kfjwd4CvpRz5Dsj670l/aOuuWG/+lHrK4lb5+T7f?=
 =?us-ascii?Q?3lUDEO0eU+kPg89jsY8wZ5yw2N1NdJvpaIclbBWeiLaeaOLc5tpUC8NDN3/e?=
 =?us-ascii?Q?mlv1bBARI+HmtsHNGop9LJq0v7XGyF7U9FQLyv5IPied42gc+bkic9RMlPrn?=
 =?us-ascii?Q?o+zP9rzwxz57fCChpy23316k/Qu/rRbj2ubqeW++NKUqKRSkvZ912tajBfAw?=
 =?us-ascii?Q?zX3ekutdjo9Ns70tFSTGk01tUSNuHiWiBMueGDouZSw4wGiUVvqDrkgU81hu?=
 =?us-ascii?Q?si+vzjamrW7nggLmLukckQF1QKguBAj++OGdAlCiC6frT02Lx5ax2xLuxUnM?=
 =?us-ascii?Q?XV2ZJsLHYwLQhjHJr2DHcP1kyRjeow1OxFmGDlSuUpWz/V0FDK01avYOnKVA?=
 =?us-ascii?Q?/OuldozeGsFlLr8kv+FthWyiwZUiZhBdazhnsl/XPPhrAkqHbZGOM+yQiLco?=
 =?us-ascii?Q?Jz0k3iix5raWZ6cD/qsMKJrwoUAAjES46zRGUvcXJq6r6056628Mgtio2ek2?=
 =?us-ascii?Q?nXdrPbUKjKKylBF31gKDpJYvprUiTY2NyRGmMvn3fTxs3rk8jmJ3knppXBl/?=
 =?us-ascii?Q?KxDbXzHtOnryfQ5NAuUJo5nTH+mygNze2fvWIgSp2fmuLw5g1tr2tumQIBg2?=
 =?us-ascii?Q?PxuDcyNZOz6pK3xhLWBf89Rr?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR12MB5469.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tAxVvJ6DnJ2vAB0ApyLgSuqunq1nWBI5XiCd5TrhlDcWC0WywmuBn8llNvQi?=
 =?us-ascii?Q?0azEdDdsM8G3T08aNIc2G9Mi3aCw6rm/x6vYkO96OPvEAHPdoMrIOD4J4IZp?=
 =?us-ascii?Q?d6Q5j0nCyZmzJDBJJLxRKccRSVG3XusSZ8izgpKtc/Q0DavPgTq7GpVl+O8G?=
 =?us-ascii?Q?cTI2h2cOi4GEewrmiky77TNev+zjQ0Aophn0/U+qpdSmL0HCoPDSA2slyvVQ?=
 =?us-ascii?Q?bqpZ43uGprPAj6oDaUcx0hO6wQJpZqDmas0sgTrvXEVg6MKboaTmGQ7O1YlQ?=
 =?us-ascii?Q?CNvzkbof77X0b91NcNWAy3aqzTK7WFRVuVlM2Ao0xs7hO/1Yrw7ucHF3DMMq?=
 =?us-ascii?Q?mVYP/TtYiT60auZnJcSAxvvLtisLQLSq+xiQU3cWEIbJf1GoZpnAv6zUV7yi?=
 =?us-ascii?Q?snCdrNR2lnreCzLIz74JevllxrCGzV5heG7K29g/j4kHAGr9oKuxskwBZaQr?=
 =?us-ascii?Q?uagce3cADkKbhcAP585kovgSBRbsi6VFwSPB76NGVXhSlf/vPhh6aVwV4k8v?=
 =?us-ascii?Q?UsuzIDok3PiN08JHxVGfr8GJAWD6qU0kItHRpmC9xuB7DiBaBptnFxN6/qe2?=
 =?us-ascii?Q?pbNt2ZjZkE0b0zrrY24Nd60Kc+y9IVEFFxOljdl1MSMrKKEP2F7EL9g0gu9b?=
 =?us-ascii?Q?hxNz/MAU32meCKVeh2IwaoVYjU7PxQilA7GCgVKZpTITo+T5fa5O5hAqeV2x?=
 =?us-ascii?Q?hZc/axNZIQTT5FgClmYPBWFj9Yw1nHEb9J3cuuSrbNYC6FdYGwQyicQH33Pa?=
 =?us-ascii?Q?8yqHch5MCFTRAQ/BhPQP+dvR/wtIzr5Xm3lucHPZKRMkaNlQFDapD8F6LVip?=
 =?us-ascii?Q?8BRDvkPdJm+MvXE/xn5EpjBxykkGvYlx32JK8DWek7Xx4hXUHHGGiRbpLGcH?=
 =?us-ascii?Q?bS9F+5lEoOmhykWPi7Bh23jzc98Bm6AGvWuDmdV9yfWbbeqgopehMRuYS6DH?=
 =?us-ascii?Q?iKY6YA1ar/H9IBzAUIQen7aIXh2NtU/I1Ws6dkXffoGICnOE/F+Q4Y2roX+l?=
 =?us-ascii?Q?mYkJPjawP7HE1uyKN5Z/kQDOXS6GlvMDJXSPN9aBHcQBBAvWezBMSxZYa9vU?=
 =?us-ascii?Q?bcTw3/IzzJKhA/NDV3/CaNnsqrc0/lbfUJEIBJO+nDU/hUspIGf0Avh8pqqu?=
 =?us-ascii?Q?FZ2PThD9xy93KtLr98ARNVKCarXDXBmlFIhKlGTEHGp6sMboS5MSm+yXe5Ej?=
 =?us-ascii?Q?Vd2nEAwrnzKqKN5+BmHBLSITueV7f9STpyD3u4gYbzqAcvjLGrM5T/v8Yfl2?=
 =?us-ascii?Q?vk7wlSaieKTIlMVhG7lqBYN52GGjH9ExA/7xbAGYtP0eXtkCHPi+MUVp4KOO?=
 =?us-ascii?Q?SQiZ4BsIHjMrZs6+msHiGwNw5j4cEo/trWnP8tXajutY3MB/9anU5sBNdFXl?=
 =?us-ascii?Q?zjRw9n+E5dVjqXNGnz6H8N1mFE8bkKwFnZ/wwmBOPV4OfUWTTrQxQRIgywia?=
 =?us-ascii?Q?QCm/NhZpSDmgaNic7waq8AQEezSoVgSYU92QfFYflRVsfL1JWDNFHoMw5uNr?=
 =?us-ascii?Q?6FlmL1d7Geqlxr0MyHfAM5YBFzoHq1M56/hl7YilidNKXrIYHHZpDCUcAtwn?=
 =?us-ascii?Q?zqqdYc8aif5SySoXgkJJYP8yUPLdziBbXE3ZnGAb?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c7a9bd2-f941-4dc1-8998-08dd09df86ce
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB5469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2024 03:49:40.1662
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GQcCqGYePDe69O/Z4zl5GUpTwNJsXU8O9zhlwPDMMNFdjs6xR7qWZGVX2frGUounntkoWQpqN+7j0RpWCVYlvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7857

The recent addition of "pofs" (pages or folios) handling to gup has a
flaw: it assumes that unpin_user_pages() handles NULL pages in the
pages** array. That's not the case, as I discovered when I ran on a new
configuration on my test machine.

Fix this by skipping NULL pages in unpin_user_pages(), just like
unpin_folios() already does.

Details: when booting on x86 with "numa=fake=2 movablecore=4G" on Linux
6.12, and running this:

    tools/testing/selftests/mm/gup_longterm

...I get the following crash:

BUG: kernel NULL pointer dereference, address: 0000000000000008
RIP: 0010:sanity_check_pinned_pages+0x3a/0x2d0
...
Call Trace:
 <TASK>
 ? __die_body+0x66/0xb0
 ? page_fault_oops+0x30c/0x3b0
 ? do_user_addr_fault+0x6c3/0x720
 ? irqentry_enter+0x34/0x60
 ? exc_page_fault+0x68/0x100
 ? asm_exc_page_fault+0x22/0x30
 ? sanity_check_pinned_pages+0x3a/0x2d0
 unpin_user_pages+0x24/0xe0
 check_and_migrate_movable_pages_or_folios+0x455/0x4b0
 __gup_longterm_locked+0x3bf/0x820
 ? mmap_read_lock_killable+0x12/0x50
 ? __pfx_mmap_read_lock_killable+0x10/0x10
 pin_user_pages+0x66/0xa0
 gup_test_ioctl+0x358/0xb20
 __se_sys_ioctl+0x6b/0xc0
 do_syscall_64+0x7b/0x150
 entry_SYSCALL_64_after_hwframe+0x76/0x7e

Fixes: 94efde1d1539 ("mm/gup: avoid an unnecessary allocation call for FOLL_LONGTERM cases")
Cc: David Hildenbrand <david@redhat.com>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>
Cc: Dave Airlie <airlied@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Dongwon Kim <dongwon.kim@intel.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Junxiao Chang <junxiao.chang@intel.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---

Hi,

This is based on v6.12.

Changes since v1:

Simplified by limiting the change to unpin_user_pages() and the
associated sanity_check_pinned_pages(), thanks to David Hildenbrand
for pointing out that issue in v1 [1].

[1] https://lore.kernel.org/20241119044923.194853-1-jhubbard@nvidia.com

thanks,
John Hubbard




 mm/gup.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/mm/gup.c b/mm/gup.c
index ad0c8922dac3..7053f8114e01 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -52,7 +52,12 @@ static inline void sanity_check_pinned_pages(struct page **pages,
 	 */
 	for (; npages; npages--, pages++) {
 		struct page *page = *pages;
-		struct folio *folio = page_folio(page);
+		struct folio *folio;
+
+		if (!page)
+			continue;
+
+		folio = page_folio(page);
 
 		if (is_zero_page(page) ||
 		    !folio_test_anon(folio))
@@ -409,6 +414,10 @@ void unpin_user_pages(struct page **pages, unsigned long npages)
 
 	sanity_check_pinned_pages(pages, npages);
 	for (i = 0; i < npages; i += nr) {
+		if (!pages[i]) {
+			nr = 1;
+			continue;
+		}
 		folio = gup_folio_next(pages, npages, i, &nr);
 		gup_put_folio(folio, nr, FOLL_PIN);
 	}

base-commit: adc218676eef25575469234709c2d87185ca223a
-- 
2.47.0


