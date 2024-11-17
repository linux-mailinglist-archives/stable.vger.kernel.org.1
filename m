Return-Path: <stable+bounces-93744-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B2FA89D0654
	for <lists+stable@lfdr.de>; Sun, 17 Nov 2024 22:32:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24447B22480
	for <lists+stable@lfdr.de>; Sun, 17 Nov 2024 21:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6766312EBE7;
	Sun, 17 Nov 2024 21:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gYwprHY7"
X-Original-To: stable@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2070.outbound.protection.outlook.com [40.107.93.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E7D1DD9D3;
	Sun, 17 Nov 2024 21:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731879158; cv=fail; b=Eodl52yPfGnWbQ7euubxV+vKrUVdrZG4DV42Jc/Hluilze5eKeU7lJZ69Ieqs5Cm5kUl5RyAUjRMKTEZQhBhjFjuOw3hsnA/XshQeJJWJZqn77Fv4Z4w3LOFWoOQX4IwKB0Gw0od+hWzb3Vpm8i3LHJU+ldOphBIF6aH9PLOpHs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731879158; c=relaxed/simple;
	bh=RvLJFztPTn65+a8Zh15E2t8NStMGkMQRMK5+4Ufp1Dc=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=QEmA3TLfUVII8YcAH0i+1JkFedGv1XpVY7CKUxmZ7ttVXoFNWX/R053Tcy+FbuMtIiX5sQxtRKrP2oWk7h/ONAiYOcISD8/h9XLzYvC0tpnKhQkwBHHUUcafVVhnImG+p+b03IR9KiiuczG8a6Nq9Aav8kbpQdCj2r9W/5JGXuI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gYwprHY7; arc=fail smtp.client-ip=40.107.93.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S2V5pLN8UgyjqAYtaYbxntWgJp50J/1NK8ZhXH6rYjaHKrH73yymSauery+0LZ5MwmJ1sS62hTwFMF9FoYoy0NuXqE3qgmGVWLESlGdOx4U/aFAM3RkifuNeRDL+j3fIZn6jgF6/W3fNtu5BhCCG7JZX2xogzgisZbIIloWFFpD7m5CQDx6vatF3kNo2z668zTLioWn2P0vF25CjKfApbV8WP9CCTBf0IjevNK4nVsUPOl2kLB7OFF1GSHjSYgzxUHsSFp/2vLeiDu/hEtxecGG7jLG2a/ltX1JoVdTrPRcCQZ7tFKLKlDeoPqWKAESetx06OD4H1DhwxR5UtMAVmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CWdUJT0WiuhWTTud9lMy6iPo0dWeyK72JK6HMwRrsXY=;
 b=YQ8J0RTfYPWAq+PWbQhF3jopNJ2v1xfGVj5+ZNmY4SQ30bi2q2vuadpadVm8nfBGAgFKhF1W7pGMhqO/pQkDHegWzeyFYNtpoNS1yY5NWu9dAY9i/TVArl2RKyQjHdE1VsMvaJ2FZau6oFl7w1zqMr2bbsjGCXqD636Be109hx0lBC3anCpPOffthj/T0M1DGQsv+WzwJDrPLiNkYJHJi5TclFLUihIxhWH4hOL5b+MGJQ9V8qetESnv0t1xjA9sReG5mMDkje1ytdMrmVzhZx5nz9fcytdG3cgEp6s0wWZzfCbhXfo8JTNFQYlkQoeC0iLCuHQ+H9YupXh134LZAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CWdUJT0WiuhWTTud9lMy6iPo0dWeyK72JK6HMwRrsXY=;
 b=gYwprHY7xbegZShfwciSI2u9YsORQfXs0kOenCAPEaKKWFZzppr/nBj4AEtl82T1kK4UkIq5aec1cx/3qFLqHNbxYtQgkbrYbiM5QA1DLxToqnmNCqWXwRUY7h/oIw9EoqTMyvwACV2TIYhMbFy8Bl++HnsS/PjcWB6JCULVwiqTb0kLOXF20Xmk9A/3XbjrK7S2j3CpPn/9jb777FJamzq3MQwyIiWEV4PYNQWUkpS5EL8VS3N19nW4lOBT6emKtKywwXKkSl/dT4qp11Iok60ZUUbfZPHDvrAwf2Syxs2KdUBPsgkzZ0cyKkaV9XzO3uD65oNNc1QUklRLTT40fA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ0PR12MB5469.namprd12.prod.outlook.com (2603:10b6:a03:37f::16)
 by MW4PR12MB6755.namprd12.prod.outlook.com (2603:10b6:303:1ea::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.18; Sun, 17 Nov
 2024 21:32:32 +0000
Received: from SJ0PR12MB5469.namprd12.prod.outlook.com
 ([fe80::ff21:d180:55f2:d0c0]) by SJ0PR12MB5469.namprd12.prod.outlook.com
 ([fe80::ff21:d180:55f2:d0c0%4]) with mapi id 15.20.8158.023; Sun, 17 Nov 2024
 21:32:32 +0000
From: John Hubbard <jhubbard@nvidia.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
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
	stable@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] mm/gup: avoid an unnecessary allocation call for FOLL_LONGTERM cases
Date: Sun, 17 Nov 2024 13:32:29 -0800
Message-ID: <20241117213229.104346-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.47.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR04CA0015.namprd04.prod.outlook.com
 (2603:10b6:a03:217::20) To SJ0PR12MB5469.namprd12.prod.outlook.com
 (2603:10b6:a03:37f::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5469:EE_|MW4PR12MB6755:EE_
X-MS-Office365-Filtering-Correlation-Id: 98ef6ac0-fbc9-4909-b6f9-08dd074f585e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?M8hMBTSeOvNNmRKLWUYQq0PNv/HMGMcH0eGgjS46IuH5FO4K7pueJHCW4W3R?=
 =?us-ascii?Q?doFxiLYgcuBymHhnORDb6PsHtrrCSRnwMlHDsezZtAtsxjDNaGgsbUy93/dB?=
 =?us-ascii?Q?Mfi6mPs8J7e81rHdqSCqixTeakjisShn+Mz4pjlvZ71fx1fwXKq/DfEQJip9?=
 =?us-ascii?Q?v2r3LHltnbT9Vt+Eos2reJUmKZEKDUsw1U84jCDIClToYPC5hvK1E1uVCWgg?=
 =?us-ascii?Q?vxTuocud3S0/GrRN/Vwk0MDDEkeHqJSB5pL1CCHkmLp1qnrL0tGtFDtKQrKg?=
 =?us-ascii?Q?z7opefMzjsBTYK1lBPHgSa7Nue89ea2dLSqdapoDxpDddPLNiKwGJrf8cEJM?=
 =?us-ascii?Q?TUyuTWOwjB6faYeqRb9SE9HyuEPX+Gt38IsX7SFaVKTVRueD64zvccO/lp9y?=
 =?us-ascii?Q?+o5WgDMP43uzMcs/dngO0kDYPqmWoDgLm2N2zQjnEvIWBlL+gCf14JjFgQ6n?=
 =?us-ascii?Q?DdMNrEJpwlDJhb6NI14jSKcXy+wd+IhHK+1GJMJNnXekJ7xiM6xN01WNhyYU?=
 =?us-ascii?Q?YJBMSUEMqSqa43hszAXpX9HXdYux6mUdhdqquw+rFMenJ4QOCCZj6sr4f9/T?=
 =?us-ascii?Q?2HS4UZ8elOsNjstvwofNBmaWX6OkJ3uC/N6waOgb0nM0X1TGgH1OeY8V3124?=
 =?us-ascii?Q?OMHfpNOydPPppleeo4Ph3B28FOjgeZ0NnvAav1WcXdorBg9bKryqumrgmjWc?=
 =?us-ascii?Q?gtYRTppasdbQ+41oZTWu7Y+UrY+KxNEbJPiRnSb5wFAqh5FH/u+HBGBnvgHi?=
 =?us-ascii?Q?x3+f/tSS8TnPNWoDaxYaOT9xdg12xaQZEbEF5MckbjhisqkZgRxcu38bRBZt?=
 =?us-ascii?Q?zSzF5iIT9f7THhQGGnUNsrQ/Su7di4Dx3o339ZgqOaUabq3vOoMxCXCC26St?=
 =?us-ascii?Q?P1SDfA7yfJnk06L++cZNXyTqiOYsMNiOf8GcsrctzQxX1FWZh4gLuc0V6i49?=
 =?us-ascii?Q?w18QgqTSwSmOnV1hSAV/L7H9+Bq6B6Zo7cZlAlXsNaIdPRn3uYVDEuJXEZ+3?=
 =?us-ascii?Q?0MTglkq2cRJtozQFHPNxp+qYpCpK21mchaIryI5H9AsTeWnMqPZKAATpXRbO?=
 =?us-ascii?Q?FNhpFEiULpOjjvfEDTIqRt3UlcoewO++a2IHXjPvT3KWDGE28yRvdklfya1F?=
 =?us-ascii?Q?1XEV57iVxVD00uhvk2MCYQLAkLxT0om89Zrbr5psaiZKCEtrfuyi0dRH5sqL?=
 =?us-ascii?Q?QyLfRDfzVirBBvW7ugnRXiaDZEWiKC5Qr2iZamGO6TrxXooGpg98Ar5TSpkc?=
 =?us-ascii?Q?7m1smkriC/LRjPNKL2fwbT1ltWsCaDHM52eywPaSmMwo5TzX9xl/3shoMPfF?=
 =?us-ascii?Q?xVjyJKSl1HcAZfsVDIFLdSdW?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR12MB5469.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yugrw3ZcpxwUlp37bqvdaaGQsEi8U2V+1sGRr0ZMBeGvOZ226Vqfl9J/4vaY?=
 =?us-ascii?Q?Z7CgGIJtw/xN7pieufxD1pTOgm0U3p1KJqVEKLfYU8Wwxy4Nxd3Q+9bckJ4u?=
 =?us-ascii?Q?3+qRZFCiyDh9P4T749Yi61LvAhH/oOIdhn/w24MKWUcRzcXK93VNZnaI4laC?=
 =?us-ascii?Q?h6g7vqOcfkh48aFQ+7muwJVGy55Hh25rmxiVkDgCkyRsCeLv3f5UBH90zStu?=
 =?us-ascii?Q?aVF7Nxh6zHhJegxT+EL1SW6EPoyZ/Mpn1lH/4MZ6zcL7NB6VGyavq59VDczk?=
 =?us-ascii?Q?IvFhCPektvNHFF3OUpCT+RTiMgBeyR6Knwmgnuw35P/X3C1cHGTq4RWpScgz?=
 =?us-ascii?Q?vqZm3cOF2X6XLmiqEE6F411A45z52g+kDNG2hhVEmPJsQ1LJdUHZ1907Gj5N?=
 =?us-ascii?Q?17cP4vui4qEN+TwtnmATjje+OTcdK6Is0gVHdnOQvp8REDb7eRBkaugIzUhF?=
 =?us-ascii?Q?hs55n7G096yxxy/xzssBVr9Qp/F7v3FpFqgWovfPF0tOK7kEzIgpPx5ln2uT?=
 =?us-ascii?Q?vyzFNmirORo0+Oa+rBJv3X9bE1YVLGwCmakfJVHIspmVunFNaXlcxCUpdIoy?=
 =?us-ascii?Q?BwTCEWTbJny7GeMhwLtOE3X3zcFcNzMFL7G22semqK+XvHbtYAUGct18GB0Z?=
 =?us-ascii?Q?2oxWT3V4GHAym1POhtOEm6DDRLPmXEahA3PyeHTeBeb/gIcIU8p7/Jbnb1PW?=
 =?us-ascii?Q?+mAlgFnvs6Ihk2les0mkU3U8jcx99MQpq3Lkjmf3ZQtMnmtzZP+j/z6ZDedy?=
 =?us-ascii?Q?/xAXKInJknMwGEkjB4AbNG520j0tCWYSxrgxxT2hECiOpBGSbHE1eO54FUJf?=
 =?us-ascii?Q?z/IZ9O6vHHn8xfsv02ImW/MuG/c1Ydv7I1iRN2yRXeHslwDVUDBr+VkTtene?=
 =?us-ascii?Q?ZSL8yEpErbO0HvnPY9fBslk7X1tzQrtBikvgDA6pLQjkCRy+qOuOyVNT9r4p?=
 =?us-ascii?Q?w0uHbfFDG6amUdAZPSAFSChVchkbh8Z/E6dNtevjia+BIengXqA4WXRNCMGO?=
 =?us-ascii?Q?nq166h+U4+MBQOQz54pJCOaSiTc0O43vZqKpihoCCauW2fnBRMm9mxcmJRY2?=
 =?us-ascii?Q?klOs7iZ5I3K1r1zAjB6vvI2AqXwr90OPpK7wWXss1ivDFbkcpHWZyzPE8UN8?=
 =?us-ascii?Q?NfzaCfgfK7vcC/xHQwtrZrl7JloFzWq6K4/7GlEBRFhF0PCeEaLeUS7BeFWs?=
 =?us-ascii?Q?0/6XJWiHIoNNIIVTSNUQ9PKPLQpDBXv9SNJT24QPtjc4+/9IZ88MFinvj3YS?=
 =?us-ascii?Q?BY5QShaNRAQRCcIdijAa/l4K5DoClOGFQ+aGaERttT6/8Rza1IRDR9LHA/Il?=
 =?us-ascii?Q?UB0e+zhSJ1X1tD4NqEuz65wXwVZvgJz76Ggy0qUbYhvYUk1L0GfCW9sTDwNN?=
 =?us-ascii?Q?oWXvfWH5XZFuJKzc1eEaQ86DwF5ai4qpxB83svYDxylcvODRyh+X7BmGBOZp?=
 =?us-ascii?Q?HxiDO12TMwt8nd4gZL42mftlPUIvZF6jsKubE+9oysSxvORoGoHPW3mD+FaE?=
 =?us-ascii?Q?ZmdEGBPz9SsOD57rLO2GyL21zUNplFRDkvEX/GbKcvQ79VOKOhzafk6KMk0+?=
 =?us-ascii?Q?rgU+P0lEInZbCJvrdBt5XhP8Pzw2VcN72P5GsevMTK3QRzntRXjMiSTCiT7h?=
 =?us-ascii?Q?+g=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98ef6ac0-fbc9-4909-b6f9-08dd074f585e
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB5469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2024 21:32:32.3739
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FBHSQaATDxTdA2vhGoYWH2uTOpGWc9LeiQZhWydHc/5tZyN9jLc/o67Hto6zUT/sxeJssseGHqpUBMa0qydqYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6755

commit 53ba78de064b ("mm/gup: introduce
check_and_migrate_movable_folios()") created a new constraint on the
pin_user_pages*() API family: a potentially large internal allocation must
now occur, for FOLL_LONGTERM cases.

A user-visible consequence has now appeared: user space can no longer pin
more than 2GB of memory anymore on x86_64.  That's because, on a 4KB
PAGE_SIZE system, when user space tries to (indirectly, via a device
driver that calls pin_user_pages()) pin 2GB, this requires an allocation
of a folio pointers array of MAX_PAGE_ORDER size, which is the limit for
kmalloc().

In addition to the directly visible effect described above, there is also
the problem of adding an unnecessary allocation.  The **pages array
argument has already been allocated, and there is no need for a redundant
**folios array allocation in this case.

Fix this by avoiding the new allocation entirely.  This is done by
referring to either the original page[i] within **pages, or to the
associated folio.  Thanks to David Hildenbrand for suggesting this
approach and for providing the initial implementation (which I've tested
and adjusted slightly) as well.

[jhubbard@nvidia.com]: tweaked the patch to apply to linux-stable/6.11.y
[jhubbard@nvidia.com: whitespace tweak, per David]
  Link: https://lkml.kernel.org/r/131cf9c8-ebc0-4cbb-b722-22fa8527bf3c@nvidia.com
[jhubbard@nvidia.com: bypass pofs_get_folio(), per Oscar]
  Link: https://lkml.kernel.org/r/c1587c7f-9155-45be-bd62-1e36c0dd6923@nvidia.com
Link: https://lkml.kernel.org/r/20241105032944.141488-2-jhubbard@nvidia.com
Fixes: 53ba78de064b ("mm/gup: introduce check_and_migrate_movable_folios()")
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
Suggested-by: David Hildenbrand <david@redhat.com>
Acked-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Oscar Salvador <osalvador@suse.de>
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
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 mm/gup.c | 114 +++++++++++++++++++++++++++++++++++++------------------
 1 file changed, 77 insertions(+), 37 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index 947881ff5e8f..fd3d7900c24b 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -2282,20 +2282,57 @@ struct page *get_dump_page(unsigned long addr)
 #endif /* CONFIG_ELF_CORE */
 
 #ifdef CONFIG_MIGRATION
+
+/*
+ * An array of either pages or folios ("pofs"). Although it may seem tempting to
+ * avoid this complication, by simply interpreting a list of folios as a list of
+ * pages, that approach won't work in the longer term, because eventually the
+ * layouts of struct page and struct folio will become completely different.
+ * Furthermore, this pof approach avoids excessive page_folio() calls.
+ */
+struct pages_or_folios {
+	union {
+		struct page **pages;
+		struct folio **folios;
+		void **entries;
+	};
+	bool has_folios;
+	long nr_entries;
+};
+
+static struct folio *pofs_get_folio(struct pages_or_folios *pofs, long i)
+{
+	if (pofs->has_folios)
+		return pofs->folios[i];
+	return page_folio(pofs->pages[i]);
+}
+
+static void pofs_clear_entry(struct pages_or_folios *pofs, long i)
+{
+	pofs->entries[i] = NULL;
+}
+
+static void pofs_unpin(struct pages_or_folios *pofs)
+{
+	if (pofs->has_folios)
+		unpin_folios(pofs->folios, pofs->nr_entries);
+	else
+		unpin_user_pages(pofs->pages, pofs->nr_entries);
+}
+
 /*
  * Returns the number of collected folios. Return value is always >= 0.
  */
 static unsigned long collect_longterm_unpinnable_folios(
-					struct list_head *movable_folio_list,
-					unsigned long nr_folios,
-					struct folio **folios)
+		struct list_head *movable_folio_list,
+		struct pages_or_folios *pofs)
 {
 	unsigned long i, collected = 0;
 	struct folio *prev_folio = NULL;
 	bool drain_allow = true;
 
-	for (i = 0; i < nr_folios; i++) {
-		struct folio *folio = folios[i];
+	for (i = 0; i < pofs->nr_entries; i++) {
+		struct folio *folio = pofs_get_folio(pofs, i);
 
 		if (folio == prev_folio)
 			continue;
@@ -2336,16 +2373,15 @@ static unsigned long collect_longterm_unpinnable_folios(
  * Returns -EAGAIN if all folios were successfully migrated or -errno for
  * failure (or partial success).
  */
-static int migrate_longterm_unpinnable_folios(
-					struct list_head *movable_folio_list,
-					unsigned long nr_folios,
-					struct folio **folios)
+static int
+migrate_longterm_unpinnable_folios(struct list_head *movable_folio_list,
+				   struct pages_or_folios *pofs)
 {
 	int ret;
 	unsigned long i;
 
-	for (i = 0; i < nr_folios; i++) {
-		struct folio *folio = folios[i];
+	for (i = 0; i < pofs->nr_entries; i++) {
+		struct folio *folio = pofs_get_folio(pofs, i);
 
 		if (folio_is_device_coherent(folio)) {
 			/*
@@ -2353,7 +2389,7 @@ static int migrate_longterm_unpinnable_folios(
 			 * convert the pin on the source folio to a normal
 			 * reference.
 			 */
-			folios[i] = NULL;
+			pofs_clear_entry(pofs, i);
 			folio_get(folio);
 			gup_put_folio(folio, 1, FOLL_PIN);
 
@@ -2372,8 +2408,8 @@ static int migrate_longterm_unpinnable_folios(
 		 * calling folio_isolate_lru() which takes a reference so the
 		 * folio won't be freed if it's migrating.
 		 */
-		unpin_folio(folios[i]);
-		folios[i] = NULL;
+		unpin_folio(folio);
+		pofs_clear_entry(pofs, i);
 	}
 
 	if (!list_empty(movable_folio_list)) {
@@ -2396,12 +2432,26 @@ static int migrate_longterm_unpinnable_folios(
 	return -EAGAIN;
 
 err:
-	unpin_folios(folios, nr_folios);
+	pofs_unpin(pofs);
 	putback_movable_pages(movable_folio_list);
 
 	return ret;
 }
 
+static long
+check_and_migrate_movable_pages_or_folios(struct pages_or_folios *pofs)
+{
+	LIST_HEAD(movable_folio_list);
+	unsigned long collected;
+
+	collected = collect_longterm_unpinnable_folios(&movable_folio_list,
+						       pofs);
+	if (!collected)
+		return 0;
+
+	return migrate_longterm_unpinnable_folios(&movable_folio_list, pofs);
+}
+
 /*
  * Check whether all folios are *allowed* to be pinned indefinitely (longterm).
  * Rather confusingly, all folios in the range are required to be pinned via
@@ -2421,16 +2471,13 @@ static int migrate_longterm_unpinnable_folios(
 static long check_and_migrate_movable_folios(unsigned long nr_folios,
 					     struct folio **folios)
 {
-	unsigned long collected;
-	LIST_HEAD(movable_folio_list);
+	struct pages_or_folios pofs = {
+		.folios = folios,
+		.has_folios = true,
+		.nr_entries = nr_folios,
+	};
 
-	collected = collect_longterm_unpinnable_folios(&movable_folio_list,
-						       nr_folios, folios);
-	if (!collected)
-		return 0;
-
-	return migrate_longterm_unpinnable_folios(&movable_folio_list,
-						  nr_folios, folios);
+	return check_and_migrate_movable_pages_or_folios(&pofs);
 }
 
 /*
@@ -2442,20 +2489,13 @@ static long check_and_migrate_movable_folios(unsigned long nr_folios,
 static long check_and_migrate_movable_pages(unsigned long nr_pages,
 					    struct page **pages)
 {
-	struct folio **folios;
-	long i, ret;
+	struct pages_or_folios pofs = {
+		.pages = pages,
+		.has_folios = false,
+		.nr_entries = nr_pages,
+	};
 
-	folios = kmalloc_array(nr_pages, sizeof(*folios), GFP_KERNEL);
-	if (!folios)
-		return -ENOMEM;
-
-	for (i = 0; i < nr_pages; i++)
-		folios[i] = page_folio(pages[i]);
-
-	ret = check_and_migrate_movable_folios(nr_pages, folios);
-
-	kfree(folios);
-	return ret;
+	return check_and_migrate_movable_pages_or_folios(&pofs);
 }
 #else
 static long check_and_migrate_movable_pages(unsigned long nr_pages,
-- 
2.47.0


