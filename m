Return-Path: <stable+bounces-93918-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2354E9D1F6D
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 05:49:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4EDE1F228E2
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 04:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D98FC13C836;
	Tue, 19 Nov 2024 04:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Z89SGdK7"
X-Original-To: stable@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2089.outbound.protection.outlook.com [40.107.212.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B2E29CA;
	Tue, 19 Nov 2024 04:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731991772; cv=fail; b=eTmZcF4J/mX7DBU6Onjm+FyLRW5Hq7ItOF7iEFHpmt9ugMQIuO5siusNOhfeTs98l+1JUgTKWINbSIcOFhSDfiNLwfvecJy10FOjz/8c0J/asxWE04lc9UJkXTC/7WgkE9YPdjt/J4S51bd0qGtAIfD/1bp+ZgAW+/OOZhzi/eU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731991772; c=relaxed/simple;
	bh=qxZ+06sksvqRKUZZOirD0HArWPrU5+ac1naeViNW0MU=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=P1C71f831VxWx8tzv0vjiMEfEWpXu+0LKjqlNjjJ5DP5uSf/G3x5PrS4Tr+s6X5ZeOdvaXVhy+LHe1mtFBykSSZuZKdC0mSQ2g3yBXVySFV3P4Sc6g9tQe7VEtaAj/ZeqnhIsS2IhfSMbsKFWqqSSrNSrqEvfF9Rb/NqezZ+W/Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Z89SGdK7; arc=fail smtp.client-ip=40.107.212.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NSQmq8Z9bKHZayM6Uzv+ZFTgyJp1hlov3Pm6zRTnVu3vMKC7bnFVfx5STdAUO8SjlpR2Snqt9Im/covPWzM+sEwGAbC+arfJiqxv0+agKPh9iNa8shnIIZPNn7IKZq1EMk0k2W3YxfZSgQSvakCjEpRvtrfgHAVggWtOTXD5FRuZivTULHjlbMmikbgQrFLP7StpuAYKrQlAXGe/TVtctQAO1PHoVcaIXbspQiV3eUxnMEPlnsA3hYJOUYU7ZRq6XJ+NLox3SAKD1qqMmwjhCdsk9cKr3SP3qyrKWN3qMSRZQwFRj5ORyn6TrUg3Tg5PJ09UCp7z4q/bHInw2Xd5/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nmmghdc1Y+iTgl9QToz9Bq6ODyB6Zd8YesIsyDsTpm8=;
 b=iqsDLuLSQBZTD9Ku/o9WNTVBesAXBehw70YHk5bAKwpK2mp8lR8EJSsQez/tjgRJif6jp4MNQ8Yyr21LHE6boYsEfRos37CDjaSV/H7XBUz+5+Qv/4Fb+fnVFQ0aVOTjbSHk4xmt1lTdajFciHHBLWgvIWz3baYSazgRNgpwdbQYHhaUsTQOnEZumtw3pouRLUdalYywzEm77BqOON3hJJrPzfgEl7sgt2VwEPKTVYsXCRZlO6o2Pbh3KAC5Hv424yVOJM7ctinsePS82PtJyCyZST7eQgbdVALkI17cLAboU3I5kUrx6j2dbYBBw+clPxUpiO/K0qyxwkAKpb1XqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nmmghdc1Y+iTgl9QToz9Bq6ODyB6Zd8YesIsyDsTpm8=;
 b=Z89SGdK77Oob6ehVa/XJu6/j05Du3Pk8FL7zJa7T+xFFKoItvBz93Jy+8/DqRxOl1mj3KQsydreWVVDLhRIECcFg51yOk4vW62XcGxMRiFEyhXbwOTZaxKUZVx/b9/j3GnwB3XZjTfF3HldZahDNmNBjpD0pcOIGDEJIbz6lkFdWskI17cp+H5cnCiQ+g1BKYlszmc3D9Rd3q6RGtOv3msJ9yBv7KUru7hKZf1+NRbDgVMIOKkGmTtbN8l634UCPxk8ABNgKtyJVOEqsBBifn1nv9Ge19L9F7vbo+b+LDkeS3oFqsq97QiaFFW15nWqiLEk040re630TeYBpyTttyQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ0PR12MB5469.namprd12.prod.outlook.com (2603:10b6:a03:37f::16)
 by DS0PR12MB6559.namprd12.prod.outlook.com (2603:10b6:8:d1::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8158.24; Tue, 19 Nov 2024 04:49:25 +0000
Received: from SJ0PR12MB5469.namprd12.prod.outlook.com
 ([fe80::ff21:d180:55f2:d0c0]) by SJ0PR12MB5469.namprd12.prod.outlook.com
 ([fe80::ff21:d180:55f2:d0c0%4]) with mapi id 15.20.8158.023; Tue, 19 Nov 2024
 04:49:25 +0000
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
Subject: [PATCH] mm/gup: handle NULL pages in unpin_user_pages()
Date: Mon, 18 Nov 2024 20:49:23 -0800
Message-ID: <20241119044923.194853-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.47.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR16CA0013.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::26) To SJ0PR12MB5469.namprd12.prod.outlook.com
 (2603:10b6:a03:37f::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5469:EE_|DS0PR12MB6559:EE_
X-MS-Office365-Filtering-Correlation-Id: 0280a419-bb6d-450f-4568-08dd08558b0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?buKCB8bGOa/UzC57dOV7eyMukpvIk+AcisHxS6Z54BmYGcGAh9e+3b1ThVQj?=
 =?us-ascii?Q?yPiiwzFjOxEldEhPgBKa1kKK1ycg8d+IF2vmXUppkuTcXi8zdOJ2WwA+v2+H?=
 =?us-ascii?Q?aADmAw4wot+kl0iaSM53H/v3V4wfejA5Y5iEoU1jfIF9sARrGbHScZN7+Rz1?=
 =?us-ascii?Q?X1OdIlF5Sks+cznrQN1TNqjHg+KNBDQBD0Bd4LFHnU5AS0vGIijApDS4SxIb?=
 =?us-ascii?Q?6gbic0b9f6vUkrUmsJcj2lKp6jwfLJ4d4EOi865EjMbFT1Jk5PA0rIg7HCTe?=
 =?us-ascii?Q?uNGz6d5wAx0DmoHf2ulaS/OUHN9bQzBf6Q/9m9DZVSixtYYNWcwIi+tWX/ZX?=
 =?us-ascii?Q?P408uUUwpLq0qqD1nBHy7lWhxhl1rTPlT6NWwz1EVydWynTGM/wjtoefcRSa?=
 =?us-ascii?Q?53Tdh2rN6xUw86NPh1lsr0p3fifOpsPZXidGogUAZ9cOtB6TSQ/wxfK6KWML?=
 =?us-ascii?Q?yubzp19BjiMpYUjQj4EG3v29JwDIl0QrWvbqYF5p3EatB6U6EOLmPrMADQjC?=
 =?us-ascii?Q?gbWlq+uoJVxegUY1fBWDq0snscStVl3anzbuUOkzjXF+GIBA5Z+FZ+ia0yfl?=
 =?us-ascii?Q?hb7j/vGrV5a9jNyBtQjFH+6nmiaQq0rWpSBpCXMAi0QyNMSEyt30CPcAmQGq?=
 =?us-ascii?Q?ejR8RTl3Z18HYE4Fz/UdMM4BvObn85Gy8xwC1sr1JsjkHxbCgCBxalM76URI?=
 =?us-ascii?Q?m1j/Qe/I5sgGoPYch23VDY5eZjp94a1IV6P+ymbxTQQasZDfWPEMV/vcQlz9?=
 =?us-ascii?Q?mMFoc+z6PXih3geG30XeEBIsgAWqSz0ZCBQsVQVTjlnxOtzpr6iMIBZ8WOXJ?=
 =?us-ascii?Q?vxxud85TqTAOo7a5LcZBHEcbmSnyMunFfcfo1A3uiVVKTxtSwQtytpncYmwT?=
 =?us-ascii?Q?+t4bEmBmfDBMwckw5YgU692ocA4CdqWvktv2Wo8d4ILnHp0WdudRALm4SFyb?=
 =?us-ascii?Q?VL5lxRwsfjnTpWl8UP7+DwDDhDvxpuDJrc3GgF2ordot2ZvTOlANHVm+im55?=
 =?us-ascii?Q?CpZG9O6WtA8UmkiJZt11eMr0aJOzdI+9zj9S6I1TRQRCVx8qIZmYWN8kWT/t?=
 =?us-ascii?Q?V3nlDKee3cxcBD1zVg26I1NmpA+ZYsmbv0tJwSq0ojAPWFGrNdFc6Aqeal1r?=
 =?us-ascii?Q?xjGNtVY9qZNGQAWrLlmqX1kPmHh3Xy7aDnEQcOxefaxFjnrssHl0rY1a5C27?=
 =?us-ascii?Q?iaxrey3sgEJt3AttEyilSeLy/PLWDPKcKFXtyHiYs+LGemmUPcYftbRrhGZe?=
 =?us-ascii?Q?rbM2qFpvusGqCKtWIh7/Gcn2GCQYskv6RyqDrMhABMRSBAlvR3SRnBO2poXr?=
 =?us-ascii?Q?2qujJQ4ejuGEpUZ2soxYemvg?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR12MB5469.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ER1hmtQSDCEA1Dtu5bUOWc8HeuxudAeTwbvqq2o5fXkTGDMRMi9Q8kkgS8WQ?=
 =?us-ascii?Q?x+Ctlqf2vEeRuPp5gycnLe5LFhNOrSiC5jMiIDErEJRDzjojewjr3lel7bLh?=
 =?us-ascii?Q?hKhZjg4LmeSDXA8em+92A+Srl/IkLgPEbjUkBNDTgo4hDMN01FqrAkwByLVk?=
 =?us-ascii?Q?8Qab+ejykx2sA99/1W/SxOwMNZubFTaNOiEFPtYYnSs3HQyJUkBQii+NH3Nj?=
 =?us-ascii?Q?VWa1xDhTRJu/AjNOmunJZ42xamFR8zlYmEIVYgsQ3R+lkSdEzvDkdtadQ0cF?=
 =?us-ascii?Q?WBcu6JsoSG78AiBWV5DM1ABHE9lIWCXnRG5jiSSoADg0/otO9FW5Br5jhKk0?=
 =?us-ascii?Q?lRuChXCl1ahof63A6EpBPq5X2QzLu8f7jFdlsLBlrCkbomzRNNxdvnl+BPMd?=
 =?us-ascii?Q?lDTGaxhxR/TklxjdH3qVid2NlhcgqCJjX/aWXcsOn5hs79z5BKwNj+XCzxP6?=
 =?us-ascii?Q?qBPB0x9WVOy0aYpprM1zJAg7+T/EXtWVa75agoQvvTSa9ZsbH1cFZw/N3cwD?=
 =?us-ascii?Q?NPBCZkYLuHWY9ewvHY0pQwE8vk+i5aDwH7QrOlKnNnsoV3aI6NM2fLHeJBUW?=
 =?us-ascii?Q?GMPsbJpf0YNq/c0QmEHh7d9qQdQBVYVDtt6HnjeZrQ7Leq2EfadM6UVQ7V9u?=
 =?us-ascii?Q?f+dABiR1jOPUZoel2nGGKSX5imnGQejEcQO78Rj/I691n4KaXfnhZ+l1zOuY?=
 =?us-ascii?Q?2CrC9GWPYXzjm6skvG7V0nE0Jkz/GIJL8dmqZpyEOUWBY9ZjK/9TIcIQQm3l?=
 =?us-ascii?Q?j9K6HaBU/LjbNcAEdpGrQv6D8HZhDF8nDZ5mx11pIIy0m5oshcnRd8Jfl82A?=
 =?us-ascii?Q?DkRMGAd2RMqYYS3cjGmozACw66p0azA7JK3pGwWZ/hJUFgdBPY+apujuIpqz?=
 =?us-ascii?Q?fcrnfkisARSisfetmiYfg9y1LF3ZGBAWEuEJSQC1QXhsIgQ9uNwFOcm9wUsw?=
 =?us-ascii?Q?zJ/BBR5GMY5HyMTCJUd7kzvIX2MxwEvCoknmtV74k5qorVgk07gtMI6ea3K/?=
 =?us-ascii?Q?ja/bw0rXjsouOaLAkcNJK04RGTbDeJW6bwez+b4EuqeHPuuN42ZJVoEhmNqP?=
 =?us-ascii?Q?n+ydtduwlttwZ+ee6VfOm8xmuaL9v42hK6b4oZmfRV2QFWYzGf5ENG97Z5qS?=
 =?us-ascii?Q?69UUOnB9rhk8789QJsodEJyzdRrbFYcqVWrQmIFlfoNDAnDZ9uhwKxnPg23J?=
 =?us-ascii?Q?m5HG4FVxYRUX1+M2QUG+cvL8A0UAByOXuZRjoaE3TpNmTnYa9lPPupxyWiVu?=
 =?us-ascii?Q?/26RwGqiby2mb0mfJCwy3sHzzyEuWE/jDun/Z2yxatz2dS4NyTzAHbmMg7Uo?=
 =?us-ascii?Q?cKIzmkNlJqGWPyym1iRifL4N+K/vm9cQGIWlwOSnLIZyIw0Ob4/LTpsAQBFj?=
 =?us-ascii?Q?hSoTSujBquyeB//yjlol7c95AY9UPcdm/YbkRrNnQ4OM/13gNzavN4JeFemu?=
 =?us-ascii?Q?bNLq6WlNCX0OscutzgMn36mG3t0vYIFFYFY7QZLsb7aNgofRsNjqXIXHqYF7?=
 =?us-ascii?Q?FceVNGZAcnYthZPjkWlkILenbb4z0UAaJIIB7g9x5rD4ja+jnJYj+1aNbhf0?=
 =?us-ascii?Q?9L9fCNAn7fnYi5neuVtsUrUur6dLjnQlwpAR9Cb3?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0280a419-bb6d-450f-4568-08dd08558b0d
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB5469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 04:49:25.5934
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EGHIHq8qLVV9CKQFJDdgkMUUR0CIMlPHGR43FWCb1FilXl/kYBjIPH2Jc8gI9mf7HQ3Y/zcjjsa1OELlv0DJXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6559

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

I got a nasty shock when I tried out a new test machine setup last
night--I wish I'd noticed the problem earlier! But anyway, this should
make it all better...

I've asked Greg K-H to hold off on including commit 94efde1d1539
("mm/gup: avoid an unnecessary allocation call for FOLL_LONGTERM cases")
in linux-stable (6.11.y), but if this fix-to-the-fix looks good, then
maybe both fixes can ultimately end up in stable.

thanks,
John Hubbard

 mm/gup.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index ad0c8922dac3..6e417502728a 100644
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
@@ -248,9 +253,14 @@ static inline struct folio *gup_folio_range_next(struct page *start,
 static inline struct folio *gup_folio_next(struct page **list,
 		unsigned long npages, unsigned long i, unsigned int *ntails)
 {
-	struct folio *folio = page_folio(list[i]);
+	struct folio *folio;
 	unsigned int nr;
 
+	if (!list[i])
+		return NULL;
+
+	folio = page_folio(list[i]);
+
 	for (nr = i + 1; nr < npages; nr++) {
 		if (page_folio(list[nr]) != folio)
 			break;
@@ -410,6 +420,9 @@ void unpin_user_pages(struct page **pages, unsigned long npages)
 	sanity_check_pinned_pages(pages, npages);
 	for (i = 0; i < npages; i += nr) {
 		folio = gup_folio_next(pages, npages, i, &nr);
+		if (!folio)
+			continue;
+
 		gup_put_folio(folio, nr, FOLL_PIN);
 	}
 }
-- 
2.47.0


