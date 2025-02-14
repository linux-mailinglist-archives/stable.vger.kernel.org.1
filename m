Return-Path: <stable+bounces-116357-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8201EA35561
	for <lists+stable@lfdr.de>; Fri, 14 Feb 2025 04:39:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 613E116D609
	for <lists+stable@lfdr.de>; Fri, 14 Feb 2025 03:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C04DA153836;
	Fri, 14 Feb 2025 03:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YPSDOPwc"
X-Original-To: stable@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2089.outbound.protection.outlook.com [40.107.100.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B3FF4A08;
	Fri, 14 Feb 2025 03:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739504340; cv=fail; b=SPlf51faz1NCJZpe3PsAB9rvQVGXNTsD7OypcG9NYRIcAZ/YC7EVAYmaB+Dxr/If37sBkhCfAEvhRlCIb9Azgs/YkECXxQ1iAPjrcNR6QUJpCbG82YECatRbA72xk+2c+gvW2Js8cvS5npCqsQxapThqF4uyCek8Mt8kdewLFBo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739504340; c=relaxed/simple;
	bh=spO2VSz0jKlxDTQGGcFSw9HHd9vKivV/hk/MNrh+vHU=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=F0GImavcfsMvgsVhwadr/jSmSvmweNdMv61uV3ZUXpoBFfu+ryNZkYfx2QaRrG+VHhkM/+S3y54bUxniiqjfXJD28PAcQWXotB7IHO8PFhOVxCei7MpDaieti9RVBEfaYovzxig0sJCd6cku1jOXw6Ss+lgzoyNO4ZaTdB4kjtA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YPSDOPwc; arc=fail smtp.client-ip=40.107.100.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cE4kg7qapb+39JP7dt+r0GWIhRMEDMmmNjnObJSPVD747UHR60TYjqnDNK0RdNxhq9uYvo5LTXPiZJTVgoq2Qkb+Td+pHg07xid3xuuRfVb2YGWQ9xqRxT62hNxyNau9C/i7tJTPqE0g3OMjwFKl2LOCDdU681fOG5cVOR2UnUPfYeDH4SoIBVIsVnZXfFc8xAjuh8vT/6Cr4f+XByeUbqf2BjUqovI2CnG4H6NeHcpEXJB6lS+tKdKaQI5lSKvla9CaVuTuy47E4l/UhmONNv3R3xbSK7+W5ncKqMiX0aSw08AWov+wQ1X2wbSzshuAwhhtZI6WzDGKlnmIMQ0SfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XNKDTVKzx3H43CZq3NlpON2d6JMcUC6SmJrdULr+B4A=;
 b=rSYPJ8UMWJeyy50uqKzOEmdinHVhbSPxyKfRNgVi+lQEmT61VGoFFFbwLl12L0RAXUFH9uMMVb2wYeM8+qHlFERpBfhb7vf8LfAVUWIHo5QaQxjjc4uMCPn+WfW5aUN2ym6l7ZgZqNpXT2XUe0JXcGExjszF7QSFyogY6ea6BYoIdwrAmhlyRg/PwsamRchVoPKtXJxQp06A3JCIkauKxewsl93JoMij7aeJd399Z5JMjUQMjyMjbHPRwxxttrlUmowS3j8WV7efiiTso/vHioKOJknssiKrkMdDso/2WsadDZIUGbN+im1QoqPHilaJ26xppEwHfWjidmR/S0Tj5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XNKDTVKzx3H43CZq3NlpON2d6JMcUC6SmJrdULr+B4A=;
 b=YPSDOPwc1vVcwpG6XPq9+gb5MnXJ4aE155ODrob5cON9ezWYOZObn/ZbLACXThxrKRSNSmQvIDmpbvrdhse0m+N84c3yjBO8jMvN5uY00Mq9GKO10porR9yK1Ul8Hzhc7Qx7pkH7BsRSt0hNBLPSODz9lL2hGi2KsN8CT5IbkNXgc7ABuc1WDs6ImR5XOmJpcDV0qK0NurUVA5R2fZp2rw/ZwZk12uE/9u5VeRZogJ315VyEyrIXtb1TKlXZ3NMUnwNs2CtFmruAKIRWQemrgoIrYe0xcGBaC6s6Vk3A/9NzmTrFhJ8JkNICs4PC90LF22TFaANCuDj5gX+nG2CXGA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5968.namprd12.prod.outlook.com (2603:10b6:408:14f::7)
 by SJ2PR12MB8111.namprd12.prod.outlook.com (2603:10b6:a03:4fe::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.14; Fri, 14 Feb
 2025 03:38:53 +0000
Received: from LV2PR12MB5968.namprd12.prod.outlook.com
 ([fe80::e6dd:1206:6677:f9c4]) by LV2PR12MB5968.namprd12.prod.outlook.com
 ([fe80::e6dd:1206:6677:f9c4%5]) with mapi id 15.20.8445.015; Fri, 14 Feb 2025
 03:38:53 +0000
From: John Hubbard <jhubbard@nvidia.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-mm@kvack.org,
	John Hubbard <jhubbard@nvidia.com>,
	stable@vger.kernel.org,
	Dave Hansen <dave.hansen@intel.com>,
	Li Wang <liwang@redhat.com>,
	David Hildenbrand <david@redhat.com>,
	Jeff Xu <jeffxu@chromium.org>,
	Andrei Vagin <avagin@google.com>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Christian Brauner <brauner@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>,
	Peter Xu <peterx@redhat.com>,
	Rich Felker <dalias@libc.org>,
	Shuah Khan <shuah@kernel.org>
Subject: [PATCH] Revert "selftests/mm: remove local __NR_* definitions"
Date: Thu, 13 Feb 2025 19:38:50 -0800
Message-ID: <20250214033850.235171-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.48.1
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0381.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::26) To LV2PR12MB5968.namprd12.prod.outlook.com
 (2603:10b6:408:14f::7)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5968:EE_|SJ2PR12MB8111:EE_
X-MS-Office365-Filtering-Correlation-Id: d9baebaf-0f73-4f2a-44ce-08dd4ca91a1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hN/eruXxrCzrHc5rKmdFUJw7Yg8AqkqE4eeS0s0paBgungvWthNBdBjLClc/?=
 =?us-ascii?Q?QvVQIJdJv5KHXjwXoZrsO/NjeiuQ94FXUv7MKSFBPJwGjAZl4cQ5iL2s8BfZ?=
 =?us-ascii?Q?lZ/aezJ95MOu6ATMO++wE3tk4rsR39IuiozdJASxAOXtpxb+nflMMXNTt9NA?=
 =?us-ascii?Q?GRr02U7E0eyTTHixoBPJQZzm0qDyDLcysQ2XqFZH6udo2OQusgGa1NeDBNQ0?=
 =?us-ascii?Q?cRkZNyfjRLtBnUsGlW/pFeXvRacQVjoWG9NnP9o4LFpDeN5qqVuV3VIwB4QO?=
 =?us-ascii?Q?bVwdpUpuvNLhwm3NSivr509QZNqKPMmpJX3QhKTRVxyzL7vDXGAKCGJvJjWZ?=
 =?us-ascii?Q?KPqlbflNZZNY5gjnMdAO597suahoInlZAS89oCWOLWJ/Tpz9SedGK0BT+kTJ?=
 =?us-ascii?Q?cgUZcIPsehD33WzQEY7/+HnX58fXKCGgWzPghBmlqqIedkaiuTRrLs8xcOJl?=
 =?us-ascii?Q?36mLg7/oh/di/XMGp0dLqHIhKxwxf+pPVZi/6bcJG4tgeriqtE3uI/K/pI+O?=
 =?us-ascii?Q?iqjcDEM4mkVXVzx102PHcXkUFKex1OUlKvH4vJLoDFhAd6G8vfNsX+WfHuoH?=
 =?us-ascii?Q?X7eD1NOI/FwKpYMlgR4y0Vd1YEI0tcIo0FPhomMMj+JwbXHIcfYYWYooAAgV?=
 =?us-ascii?Q?B/gGBz/TT3HRgnPv/rDsvAXN9lp3wGz0Ml/3pU1MbxZ157sd3dv8rzi5ig/t?=
 =?us-ascii?Q?2sFStehcfXoL3cqHqumgx6uopD87SHh5ZfpSBNl6UIoCzgbbKd6gV+RHCwnF?=
 =?us-ascii?Q?F5DthyeZHR1sdfZJMSfXLDTY5WZrnQ4obEvkXA/gbTpXj6072xFsVBk+qIpd?=
 =?us-ascii?Q?djVLbBXVwfDyMCP2M3PZsxbmVI1YoP+zJHkNYhzJljZJUrt1sR4G3Wm7GMsb?=
 =?us-ascii?Q?1MvFUQI5HDA0c1+fNleJqJyBJsgdAgETLUjAO0ScywhY6Przr58DwCa5d0gz?=
 =?us-ascii?Q?nQQW/AWQHovdlq36L/iOj+KWQmatQ+mf+HRMeB0PZ0d1qtI+ksq8WUUO+O4S?=
 =?us-ascii?Q?njI2OAa5Mu2tfoHKhLAl7XCsBuQSZcV5cQfUSu+92uxsnK8a2kiV866NQ0UA?=
 =?us-ascii?Q?vBfT7vlAdbMnnyUTabxLvCp1MUQDoapHoAkCq51ozuwf9qLekdYa/14539dB?=
 =?us-ascii?Q?lIcxgt836oovcl78EMDYaMANPlmfHOt8eHRY0f0GmL/XI3U/w9RZ6KrIHGQL?=
 =?us-ascii?Q?vT1DRip2YEPVdiOs3O+hEJr6EhEcsZvMnEwblo/ub8j312QVLHqIR/FbpSix?=
 =?us-ascii?Q?yKT2ZPiHD1l0bRbTCgpv4Bw24wPdCK4iiDPp/2LRqaHVyqzDeMwwEKZ75xC/?=
 =?us-ascii?Q?HgG01CAGLnOvmAUXtpbem9Ecca5FgHI7rS3b4OVc8iDg8joAmdob2zR1oRkJ?=
 =?us-ascii?Q?omvDnYQP+ZZu17Wfib6IlaQOB2Ph?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5968.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?if4PH0naRgziblbUm4kOcd9Dq5OGL2NR6xnG5bP+px5rLwghYQSU+0TVzjvj?=
 =?us-ascii?Q?dNOyU6gVNgY24hKDooa5kZd+9F284D8Ss92dSEUaqjSDb/uHh9aW7JnC+pvu?=
 =?us-ascii?Q?xQyMifTznJeu7zKrF2o+o0w7OGAOYGwU1f1kA28XL7sSAVsTF0CjzXNWLl/u?=
 =?us-ascii?Q?cBJbKuiKJeBIzcxM+u2Jw4+Lmf55VxhD5e4fLe+gvtA0szEldRpPxsd9nrvM?=
 =?us-ascii?Q?8Te/Gydvs6FBAmhyd5chDu7sIL6TXb4R2e3B9cdVnfArlRf9lWhmuxWFOE+C?=
 =?us-ascii?Q?js8e1y5kxt/5FUCQXI8/pSc4b9rDgdIBr0WP0amMGAdEJT5rdoRFklX5SKrd?=
 =?us-ascii?Q?6W3poHeUQaoNh7VIRaxVjfpTMFUyZpuYERofjjFdvvzjpCshVDD62O/Dv1aW?=
 =?us-ascii?Q?/0T9p1ng7IhSrAbT6LYrZSZ5S8x2oPHSwR9YsUurBt2+fydmMq6jjM9It8cI?=
 =?us-ascii?Q?OiqxGHeXhmxWpXTAU+erdb3rwxLPGTdxzRqnQ4FHPf5rwCM2CXO5jWvX+rip?=
 =?us-ascii?Q?g3tl4dze8UvQe3/ekCS8xvIAPtgOuMlqGIKEJmRLdyE8DfoVqZdg3w7Gzhuw?=
 =?us-ascii?Q?lOPgkEfe7pTTZ12Z1nB1MfpzR3bm60u8qns4hOjJyZtNsD1GqGTqkJv7qCHn?=
 =?us-ascii?Q?S+Xhv1/Scfa5JEKcNmWsFzteUhEpabvCeTFzmoAoZdyE9ExPYk6G6oMAJnBu?=
 =?us-ascii?Q?unPu2Vumi9OwE+7um8g96duZoMsb8wvE117kuGLZizkp8ggZtVZVYhJ8ee1W?=
 =?us-ascii?Q?tDo9VjdS4y40Wu/ZktuqdPabII7jljLxQyJVoViSlR/sASoQg2p3Khz/394f?=
 =?us-ascii?Q?HKkbhPmxOVcu9VAPXI2o6DVOsg+4whhZEfUZLkU9Lv+8/9Hkrmfgx01dbilU?=
 =?us-ascii?Q?z9cy+Id09eHUkWyYUOUiz3O1TnZgHUq+19cb9VQ3wK0d+5xnxR+xIMWfHwWt?=
 =?us-ascii?Q?0sNTeYDW4Z+vbAZNyWp21thq8LuPoYdFMK29POl2GEOZsgnTp41Fyn3b4JH/?=
 =?us-ascii?Q?OxkglpPM+povOTc6goGDHcKZXDGQtfuvr7WKr9sPzHBKL2sd8TV9JjMadz+P?=
 =?us-ascii?Q?yCzJP/co/NH0sa9PrGhFHCijtkpfc5uPHmryvql2/dyr4FS90i+R3Iwqnlzp?=
 =?us-ascii?Q?pM3Y/ePNxNEUBgyyZkXfJsMbtrnrYxpnh6ktKH5j7jb3cIXXzBujvnsVQ+iq?=
 =?us-ascii?Q?fjYF7TIe13O/Ec6KdBgRTeJFR5wkr2lVw6FudPDEUgsfs3tWktzsUBDQ5AJc?=
 =?us-ascii?Q?qQwA9uT55xf4zIY/gkkgyH40/407RVGmxVqXUwJ1CgCD8PWtpno2HZvXYemz?=
 =?us-ascii?Q?zx3oW35c0TKsao5hImlw+lQzNKMewoCQ6e7QCx5ox6Dq3bKoiVCszXCN5D0O?=
 =?us-ascii?Q?xaEPIY0osquNsolT+40p9hJwS2mYiQG02cLOQIwHXXa/Y3kesUYOgnF6cb+f?=
 =?us-ascii?Q?EW2V4/uIOn7dWeOzAF29tj7gvaw7AXbE1fTKlkogM5fn97MgDbW2lg4VzwWm?=
 =?us-ascii?Q?OJpgc5wPMsgVca3fFhnONviyFtlBXRNiZha9/2b9+L22EOuO6I+ABKnELqTN?=
 =?us-ascii?Q?+CJ/jhQLz5FROC4YmV9MJ0+6w/oeYck0jNjQ8oAd?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9baebaf-0f73-4f2a-44ce-08dd4ca91a1d
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5968.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 03:38:52.9289
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4Tf9JijXVl0eHyu7gcu7ILtiTgA8CvHGop7Gf5LgotJqerR4hta9HIe+XU4yf3vt9THR2IgXoUFXAIkzLJtsHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8111

This reverts commit a5c6bc590094a1a73cf6fa3f505e1945d2bf2461.

The general approach described in commit e076eaca5906 ("selftests: break
the dependency upon local header files") was taken one step too far
here: it should not have been extended to include the syscall numbers.
This is because doing so would require per-arch support in
tools/include/uapi, and no such support exists.

This revert fixes two separate reports of test failures, from Dave
Hansen[1], and Li Wang[2]. An excerpt of Dave's report:

Before this commit (a5c6bc590094a1a73cf6fa3f505e1945d2bf2461) things
are fine.  But after, I get:

	running PKEY tests for unsupported CPU/OS

An excerpt of Li's report:

    I just found that mlock2_() return a wrong value in mlock2-test

[1] https://lore.kernel.org/dc585017-6740-4cab-a536-b12b37a7582d@intel.com
[2] https://lore.kernel.org/CAEemH2eW=UMu9+turT2jRie7+6ewUazXmA6kL+VBo3cGDGU6RA@mail.gmail.com

Fixes: a5c6bc590094 ("selftests/mm: remove local __NR_* definitions")
Cc: stable@vger.kernel.org
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Li Wang <liwang@redhat.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Jeff Xu <jeffxu@chromium.org>
Cc: Andrei Vagin <avagin@google.com>
Cc: Axel Rasmussen <axelrasmussen@google.com>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Kees Cook <kees@kernel.org>
Cc: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Liam R. Howlett <Liam.Howlett@oracle.com>
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: Rich Felker <dalias@libc.org>
Cc: Shuah Khan <shuah@kernel.org>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 tools/testing/selftests/mm/hugepage-mremap.c      |  2 +-
 tools/testing/selftests/mm/ksm_functional_tests.c |  8 +++++++-
 tools/testing/selftests/mm/memfd_secret.c         | 14 +++++++++++++-
 tools/testing/selftests/mm/mkdirty.c              |  8 +++++++-
 tools/testing/selftests/mm/mlock2.h               |  1 -
 tools/testing/selftests/mm/protection_keys.c      |  2 +-
 tools/testing/selftests/mm/uffd-common.c          |  4 ++++
 tools/testing/selftests/mm/uffd-stress.c          | 15 ++++++++++++++-
 tools/testing/selftests/mm/uffd-unit-tests.c      | 14 +++++++++++++-
 9 files changed, 60 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/mm/hugepage-mremap.c b/tools/testing/selftests/mm/hugepage-mremap.c
index ada9156cc497..c463d1c09c9b 100644
--- a/tools/testing/selftests/mm/hugepage-mremap.c
+++ b/tools/testing/selftests/mm/hugepage-mremap.c
@@ -15,7 +15,7 @@
 #define _GNU_SOURCE
 #include <stdlib.h>
 #include <stdio.h>
-#include <asm-generic/unistd.h>
+#include <unistd.h>
 #include <sys/mman.h>
 #include <errno.h>
 #include <fcntl.h> /* Definition of O_* constants */
diff --git a/tools/testing/selftests/mm/ksm_functional_tests.c b/tools/testing/selftests/mm/ksm_functional_tests.c
index 66b4e111b5a2..b61803e36d1c 100644
--- a/tools/testing/selftests/mm/ksm_functional_tests.c
+++ b/tools/testing/selftests/mm/ksm_functional_tests.c
@@ -11,7 +11,7 @@
 #include <string.h>
 #include <stdbool.h>
 #include <stdint.h>
-#include <asm-generic/unistd.h>
+#include <unistd.h>
 #include <errno.h>
 #include <fcntl.h>
 #include <sys/mman.h>
@@ -369,6 +369,7 @@ static void test_unmerge_discarded(void)
 	munmap(map, size);
 }
 
+#ifdef __NR_userfaultfd
 static void test_unmerge_uffd_wp(void)
 {
 	struct uffdio_writeprotect uffd_writeprotect;
@@ -429,6 +430,7 @@ static void test_unmerge_uffd_wp(void)
 unmap:
 	munmap(map, size);
 }
+#endif
 
 /* Verify that KSM can be enabled / queried with prctl. */
 static void test_prctl(void)
@@ -684,7 +686,9 @@ int main(int argc, char **argv)
 		exit(test_child_ksm());
 	}
 
+#ifdef __NR_userfaultfd
 	tests++;
+#endif
 
 	ksft_print_header();
 	ksft_set_plan(tests);
@@ -696,7 +700,9 @@ int main(int argc, char **argv)
 	test_unmerge();
 	test_unmerge_zero_pages();
 	test_unmerge_discarded();
+#ifdef __NR_userfaultfd
 	test_unmerge_uffd_wp();
+#endif
 
 	test_prot_none();
 
diff --git a/tools/testing/selftests/mm/memfd_secret.c b/tools/testing/selftests/mm/memfd_secret.c
index 74c911aa3aea..9a0597310a76 100644
--- a/tools/testing/selftests/mm/memfd_secret.c
+++ b/tools/testing/selftests/mm/memfd_secret.c
@@ -17,7 +17,7 @@
 
 #include <stdlib.h>
 #include <string.h>
-#include <asm-generic/unistd.h>
+#include <unistd.h>
 #include <errno.h>
 #include <stdio.h>
 #include <fcntl.h>
@@ -28,6 +28,8 @@
 #define pass(fmt, ...) ksft_test_result_pass(fmt, ##__VA_ARGS__)
 #define skip(fmt, ...) ksft_test_result_skip(fmt, ##__VA_ARGS__)
 
+#ifdef __NR_memfd_secret
+
 #define PATTERN	0x55
 
 static const int prot = PROT_READ | PROT_WRITE;
@@ -332,3 +334,13 @@ int main(int argc, char *argv[])
 
 	ksft_finished();
 }
+
+#else /* __NR_memfd_secret */
+
+int main(int argc, char *argv[])
+{
+	printf("skip: skipping memfd_secret test (missing __NR_memfd_secret)\n");
+	return KSFT_SKIP;
+}
+
+#endif /* __NR_memfd_secret */
diff --git a/tools/testing/selftests/mm/mkdirty.c b/tools/testing/selftests/mm/mkdirty.c
index af2fce496912..09feeb453646 100644
--- a/tools/testing/selftests/mm/mkdirty.c
+++ b/tools/testing/selftests/mm/mkdirty.c
@@ -9,7 +9,7 @@
  */
 #include <fcntl.h>
 #include <signal.h>
-#include <asm-generic/unistd.h>
+#include <unistd.h>
 #include <string.h>
 #include <errno.h>
 #include <stdlib.h>
@@ -265,6 +265,7 @@ static void test_pte_mapped_thp(void)
 	munmap(mmap_mem, mmap_size);
 }
 
+#ifdef __NR_userfaultfd
 static void test_uffdio_copy(void)
 {
 	struct uffdio_register uffdio_register;
@@ -322,6 +323,7 @@ static void test_uffdio_copy(void)
 	munmap(dst, pagesize);
 	free(src);
 }
+#endif /* __NR_userfaultfd */
 
 int main(void)
 {
@@ -334,7 +336,9 @@ int main(void)
 			       thpsize / 1024);
 		tests += 3;
 	}
+#ifdef __NR_userfaultfd
 	tests += 1;
+#endif /* __NR_userfaultfd */
 
 	ksft_print_header();
 	ksft_set_plan(tests);
@@ -364,7 +368,9 @@ int main(void)
 	if (thpsize)
 		test_pte_mapped_thp();
 	/* Placing a fresh page via userfaultfd may set the PTE dirty. */
+#ifdef __NR_userfaultfd
 	test_uffdio_copy();
+#endif /* __NR_userfaultfd */
 
 	err = ksft_get_fail_cnt();
 	if (err)
diff --git a/tools/testing/selftests/mm/mlock2.h b/tools/testing/selftests/mm/mlock2.h
index 1e5731bab499..4417eaa5cfb7 100644
--- a/tools/testing/selftests/mm/mlock2.h
+++ b/tools/testing/selftests/mm/mlock2.h
@@ -3,7 +3,6 @@
 #include <errno.h>
 #include <stdio.h>
 #include <stdlib.h>
-#include <asm-generic/unistd.h>
 
 static int mlock2_(void *start, size_t len, int flags)
 {
diff --git a/tools/testing/selftests/mm/protection_keys.c b/tools/testing/selftests/mm/protection_keys.c
index a4683f2476f2..35565af308af 100644
--- a/tools/testing/selftests/mm/protection_keys.c
+++ b/tools/testing/selftests/mm/protection_keys.c
@@ -42,7 +42,7 @@
 #include <sys/wait.h>
 #include <sys/stat.h>
 #include <fcntl.h>
-#include <asm-generic/unistd.h>
+#include <unistd.h>
 #include <sys/ptrace.h>
 #include <setjmp.h>
 
diff --git a/tools/testing/selftests/mm/uffd-common.c b/tools/testing/selftests/mm/uffd-common.c
index 717539eddf98..7ad6ba660c7d 100644
--- a/tools/testing/selftests/mm/uffd-common.c
+++ b/tools/testing/selftests/mm/uffd-common.c
@@ -673,7 +673,11 @@ int uffd_open_dev(unsigned int flags)
 
 int uffd_open_sys(unsigned int flags)
 {
+#ifdef __NR_userfaultfd
 	return syscall(__NR_userfaultfd, flags);
+#else
+	return -1;
+#endif
 }
 
 int uffd_open(unsigned int flags)
diff --git a/tools/testing/selftests/mm/uffd-stress.c b/tools/testing/selftests/mm/uffd-stress.c
index a4b83280998a..944d559ade21 100644
--- a/tools/testing/selftests/mm/uffd-stress.c
+++ b/tools/testing/selftests/mm/uffd-stress.c
@@ -33,10 +33,11 @@
  * pthread_mutex_lock will also verify the atomicity of the memory
  * transfer (UFFDIO_COPY).
  */
-#include <asm-generic/unistd.h>
+
 #include "uffd-common.h"
 
 uint64_t features;
+#ifdef __NR_userfaultfd
 
 #define BOUNCE_RANDOM		(1<<0)
 #define BOUNCE_RACINGFAULTS	(1<<1)
@@ -471,3 +472,15 @@ int main(int argc, char **argv)
 	       nr_pages, nr_pages_per_cpu);
 	return userfaultfd_stress();
 }
+
+#else /* __NR_userfaultfd */
+
+#warning "missing __NR_userfaultfd definition"
+
+int main(void)
+{
+	printf("skip: Skipping userfaultfd test (missing __NR_userfaultfd)\n");
+	return KSFT_SKIP;
+}
+
+#endif /* __NR_userfaultfd */
diff --git a/tools/testing/selftests/mm/uffd-unit-tests.c b/tools/testing/selftests/mm/uffd-unit-tests.c
index 9ff71fa1f9bf..74c8bc02b506 100644
--- a/tools/testing/selftests/mm/uffd-unit-tests.c
+++ b/tools/testing/selftests/mm/uffd-unit-tests.c
@@ -5,11 +5,12 @@
  *  Copyright (C) 2015-2023  Red Hat, Inc.
  */
 
-#include <asm-generic/unistd.h>
 #include "uffd-common.h"
 
 #include "../../../../mm/gup_test.h"
 
+#ifdef __NR_userfaultfd
+
 /* The unit test doesn't need a large or random size, make it 32MB for now */
 #define  UFFD_TEST_MEM_SIZE               (32UL << 20)
 
@@ -1558,3 +1559,14 @@ int main(int argc, char *argv[])
 	return ksft_get_fail_cnt() ? KSFT_FAIL : KSFT_PASS;
 }
 
+#else /* __NR_userfaultfd */
+
+#warning "missing __NR_userfaultfd definition"
+
+int main(void)
+{
+	printf("Skipping %s (missing __NR_userfaultfd)\n", __file__);
+	return KSFT_SKIP;
+}
+
+#endif /* __NR_userfaultfd */

base-commit: 5c2b80714a515d35d52772c931ca4581f4646bac
-- 
2.48.1


