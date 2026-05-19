Return-Path: <stable+bounces-249417-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4NHxOIyzC2q2LAUAu9opvQ
	(envelope-from <stable+bounces-249417-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 02:49:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EB50575BB2
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 02:49:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BF76F30594C5
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 00:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D87FA26982C;
	Tue, 19 May 2026 00:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="j0Y/raR+"
X-Original-To: stable@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011046.outbound.protection.outlook.com [52.101.57.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCFFE3AC00;
	Tue, 19 May 2026 00:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779151672; cv=fail; b=D+14KK1g042fpin3itjecadB+/wNdQqngDg5C+JpdO8YjZtUqbsqhkzFyZwaJ4O3XRO44lwFltcarEyHksNrZP2u1Xc83zib1cs1ua+JPIywgnpvtSVr31ouicWr8TbxbngP00QvemXswthCd9UNiUeAB8wXsvoBQ9rHlxV3wpQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779151672; c=relaxed/simple;
	bh=ZFdnTScC58r1h90sbPJytwSiLb4CDgSRAKHCyfAvWB0=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=NnlBKiwyrr5oQRQ0Cn8tIxw7sPX834+OjkTHKVwO5cON+90ruGPKd9a4Mxgk743PjHveuU6FC/Zu4CXEkCdl+q/LlriYp8XJNYNIRTIHMlzJkjJF4/HbNt1uIWZtU2EjgCS7u7yK6zYY4F0hINkwg3JRxr12Ro9AW/tFeMYdm/o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=j0Y/raR+; arc=fail smtp.client-ip=52.101.57.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mfurDl0oMxBcusy4G5aIBUxfeTOCdamh5MwlOkNBfcndFjvP0zCDN9m7DEh4SUgv5GdfzBBs+rFD5yYfH0JU+jjOzwnJaEd9N6y28atVinn0QvKP+UYqqHvnIZqE5Gdplc8pXSJ41tqktd+CjAdYtLKB1oCpDapKnXFnox+CdmNIXxZf0O2YM6bJZn6/vQj+yZAILxYMq6jqADGdWu9T3KFACskkBuESU9N4wZEp9QAwdqaoC85DjyJ9lQTaA3VQYGEOCYMWeTJZwshHJANkVUdjY765+VRlyRUPRiqi9dJaB5nVTL8fdIlFQGQ8Epv1jNyrxVKublP8VG/owp3WJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xx0h/jpvhKKzgiEX6SrUcw/0ZG16R2G1CFwJhBVG4BE=;
 b=BMs2fmAjKpUJknw6Q4usTDKpSV23B/po3QVZ5W1Dm7H0uqa70SI+uKqR7qXA7YGzOOJ7F4TmBaDvOBDlFum9cWYVcyfZRzS/hTWrBywh0QV4JBykpjNFhBHLFeH5jXjoi5nN36Sb7lekq+vA/qtEn2crApkjBArwtcJ868cmFBUULULRwVi7jT/tW6jwMY/aDd37zPY5h5b6DQFMRO8c+H7hyEYcIH6wlrn+pB1jeRHgGY+dwJweOvcAUlbKWR5rqyGe+anwCyeIfNiUbtx2OM9yI8Ft2vS2DdCXy6tR0wv3JDYYwgMuFaOROGSRIrK3JW+a/uFEEz4RLQpCl7hyWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xx0h/jpvhKKzgiEX6SrUcw/0ZG16R2G1CFwJhBVG4BE=;
 b=j0Y/raR+Fu7c14wEN4TngSO5TkjHPyCPPsHMe+TM9zOwdKyuqUMd9E1zEq9RvPDMy/QH+ZI/W05PAs9ZqFFeO6yLPVJn7hTVrxWMpL3hHb0G5exW3nVW5IcmKTAXBi20pOGqujetwMOyrh/aB8ROJf4sWJiGd6v077Q58vKLkrGKdmn4mYyJbeWz2s7Ss+vgblOzivs8RkHr2nxzMFep6CkNjwHY3siqvVuloblXwlXXF5MdDqjYmvrssIHzhnxBingbvsQyQudaLE9AyAaKnRFKr5hvirvCmQQ/krmpwNZOP1Stu4meTXR8EZwsDDNJXlbqP2nA1X/6e3NXoGE7Mg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB8442.namprd12.prod.outlook.com (2603:10b6:8:125::12)
 by SJ2PR12MB8874.namprd12.prod.outlook.com (2603:10b6:a03:540::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.21; Tue, 19 May
 2026 00:47:47 +0000
Received: from DS0PR12MB8442.namprd12.prod.outlook.com
 ([fe80::c4df:b439:571:4591]) by DS0PR12MB8442.namprd12.prod.outlook.com
 ([fe80::c4df:b439:571:4591%6]) with mapi id 15.20.9913.009; Tue, 19 May 2026
 00:47:47 +0000
From: "Matthew R. Ochs" <mochs@nvidia.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Bernd Schubert <bschubert@ddn.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v3] fuse: back uncached readdir buffers with pages
Date: Mon, 18 May 2026 17:47:46 -0700
Message-ID: <20260519004746.3203156-1-mochs@nvidia.com>
X-Mailer: git-send-email 2.50.1
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR06CA0016.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::29) To DS0PR12MB8442.namprd12.prod.outlook.com
 (2603:10b6:8:125::12)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB8442:EE_|SJ2PR12MB8874:EE_
X-MS-Office365-Filtering-Correlation-Id: 60dc490e-571d-4d56-cf01-08deb5403ef7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|11063799003|3023799003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	72cm2JdHIOppmU4mbWn9+0lo81n6TykJ/Vb8nwONXqKD2pYP4jyJt7A75iV76kPiDLUvss2kPEgCwNge4wF8B19IrJQwvl220G1tTnRTMYzt8oP+qxtOV9UeTPU/696E+D8Y3joSnexaVZdRmHlgpNOMCpQiqnl+qJpgN+yr+syEBhAsS+JxnARjkzp/mZakhZIBkKW5wo2LgZaKQKSUZwgGpibP4ylTe6HOk/jJnQN6G+9lawSup5RxnrixAMjPQ8/GFHAjNUD9iWcqbrETookoFOSTlPYJsT1hKU/8BSvFgFwVjeB85w6gv8GGJCMP5QrEJ0/UT9tHwHTlKwf2CsGpCGY02Zj61H5SXg2+iZf3dhzQ+/72soEKt6I79XRNVR6M5NgIblEWj/dAOwlocHiAwluP3wEdhIrIqd1KKQNXYeMsJw2WKKamhrZMglp8o+7eXyJUma6wotiJpgzn/HTq5Y1OvgOf3s0qJ5rpEbIVVE/ZR9ylJClYvuFGCr5VR6Cs+WDaP8n2JTmjPoEVdKUTC+Am/99r4RgNTQ0dDWf3t4Wur+4+uIwSUWYpp3hj4fw3M5EVLRi2p/BD6vRS0WRJNFdUfo6A/La+3WbjWrAiIE2LiekccRsS6Yg8DyWkwc2JAzH6i3OVN1eJ3VFR5fBuqeaIZeK7jQ/WuR71JOgGLZW0DUKxY93V5LeRbu0ItE7sFNLt+2LSlE7osxNa1w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB8442.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(11063799003)(3023799003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gIuR05WROfQInS+hJfnabEwalTeX+CymPpqrQP1JjBgbGbr/qk72m58gPJa7?=
 =?us-ascii?Q?2lNDWzV1btdthcF4+0S+VPJXP6BldThQTf3h+H9EmskqYFb1qxd1PBAlVueo?=
 =?us-ascii?Q?LORLpEuHq/JXebUHZiH6v1SAKQ/FU85lKqITdHOlKLeM+o55uf4Q087Mk14q?=
 =?us-ascii?Q?04Q1prezfwZGO3sxu3bXwmNed/8rwamrpBuGZIMyghsPOyaiyx2Gu5Wq12+d?=
 =?us-ascii?Q?EQmnjfn/gtezjzpkV6P0lnOagS253Y/2HJSY4mWLIdu6pa511E/eqeEeX/LI?=
 =?us-ascii?Q?JvS23mmnUfB5SH9wlxCdfdzfPcHo5lxv2pwldBXLOihSO6MuArq+smrW85pQ?=
 =?us-ascii?Q?Fj4BigpHdlAfM4MtKVg3PwazbVPyctJhiJDoRWZlXpbCiQk0fOtGXxbxRawf?=
 =?us-ascii?Q?P2X6jQi538QMDCPgL6d78F/tb9NJPfcwXfBjDc8aRRixyNYsN319R1ok9a7v?=
 =?us-ascii?Q?9EdBvd2qV2iViXGxLAgMVWEVuLxy8XtltfFmtms78XHlJiUVRqB6c2uyfNJF?=
 =?us-ascii?Q?NlPwrL+OPH04+M2QAW38pn+njjzFO6FGDcjbzUqdfqGJPBt8wUXYgucU40V3?=
 =?us-ascii?Q?UqprcwzXe4+vmtlMbnRywEiyzBjO8iousiDadcGPQxu8NtBgaoV8EzPm2xSq?=
 =?us-ascii?Q?mnfCxjjW0uOwzwDCoQw777w4I9KEfBjF7xYlpnK0/2ndgZPRP6s4yacMdd8L?=
 =?us-ascii?Q?PXoCUXJJTO0O1JtyZTMHXW14/6J2dcmU1Ho9LPzb+BwaHlQK3XBd0uc2zf5U?=
 =?us-ascii?Q?jUX+iOwhPcKjsvgX7HVU583lg+XsTdvzC+iaYQe+Ks1yGcCmQ8LRufr93aqZ?=
 =?us-ascii?Q?BXaERcrpacxXnq6gGllXvNVsNMXr5OBeDOXtlxiZaqIfh75ilxDUqaDtbLMX?=
 =?us-ascii?Q?MhQAuTLqRGuHyZiHveAUrY9y5T6gwbjNg5N5PW+3Y1ZLjXl5BzzKtc9SAeFa?=
 =?us-ascii?Q?h4DzQqhrTXIECmZpL7W+ij/oL1YEAMwfijjEtanREZHtmWW4tUisiiiLEe7L?=
 =?us-ascii?Q?WXLGpCgTzEGJOpEs0jEVlLlhmv5Fq+LRJgSLU19Jq4v0VhttnRAt9CfS2JAy?=
 =?us-ascii?Q?tF+1gk4t0CrYVE62IpZbVbtNNZrSTKmt2xEG6RVtvcGLm9xnbcQJby2R6fVH?=
 =?us-ascii?Q?pGDDploVTdkh9JJUMQyKNw3yfHyzff9OEDSBkkW8A1Ji5+gDLjnoWnhmRT1v?=
 =?us-ascii?Q?tUI8KXON58nN6I0GBx2IFi3AFTteo3jrTTPB9jl+8tn/1lze/Cf37MaweANm?=
 =?us-ascii?Q?TQVZvHKyDki0RZeU+BYyOlx6NS2rI6LlXg9IbclB3MM0EwbHgimPW8ZbL0NY?=
 =?us-ascii?Q?BV1suINvg1miKWTmTdfo2dlA7svLh+jDhOJH/1l0UtgdjLGAuGcTYbNHvTqc?=
 =?us-ascii?Q?Oa861M+HGhWGKn9A7BKTJDrMtmxa5KxBpUEjnbuIHbSlYeye12PbCobJTlNt?=
 =?us-ascii?Q?vOe6I/ock52hSp9VPBraYwc4O/CkkUS194sTwzn0EtVo7uI8qvu4x06CzzvS?=
 =?us-ascii?Q?9twsaIymp9brR+5TaX+7MSt/FTWUhJdJhO0OYzyxLSsOQfxus9hWfRVhh2uy?=
 =?us-ascii?Q?Xs8UKT8GJ+OE/gQ7A9pvX9shaL9Ih6AxM5+vQrW0v3Yb9szmYY7uJ9BYHD1T?=
 =?us-ascii?Q?LvR6rH83Ay8gsI7Kb+o2mvYIGw23WEg4CEoJaa/zuo8JFd69sFQZF6Tn+6Pj?=
 =?us-ascii?Q?QEHdp0FRKypffpF41MciWi6ka6oDFlC9wHQM+R1tCCbfyubhOy60wVwhSU7q?=
 =?us-ascii?Q?rLJoiJ4uOg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60dc490e-571d-4d56-cf01-08deb5403ef7
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB8442.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 00:47:47.3592
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XELAE3YDaeKPRAKdtmDJMOACbt++/M9VpK2YOJ8dYw1AVH7PzwQXjflaQhTWVQfrOk8LcTzoOh63eYl1AcRtvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8874
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-249417-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[mochs@nvidia.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,nvidia.com:mid,nvidia.com:email]
X-Rspamd-Queue-Id: 5EB50575BB2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Commit dabb90391028 ("fuse: increase readdir buffer size") changed
fuse_readdir_uncached() to size its temporary buffer from ctx->count.
This is useful for overlayfs and other in-kernel callers that use
INT_MAX to indicate an unlimited directory read.

The buffer is capped by fc->max_pages converted to bytes with PAGE_SIZE.
However, fc->max_pages is a page-count limit, not a byte-sized payload
limit. READDIR is a read-side operation, so include fc->max_read in the
cap. Also keep fc->max_write in the cap: it is the daemon-advertised
byte-sized payload limit relevant to virtiofs in the failing
configuration, while fc->max_read can remain effectively unlimited there.

The larger buffer is also currently supplied as a kvec output argument.
For virtiofs, kvec arguments are copied through req->argbuf, which is
allocated with kmalloc(..., GFP_ATOMIC). A large readdir buffer can
therefore require a multi-megabyte contiguous atomic allocation and fail
with -ENOMEM.

This was observed with a 64K-page guest on a 4K-page host, using an
overlayfs mount whose lower directory is on virtiofs. Reading a merged
directory through overlayfs failed with:

  ls: reading directory '<path>': Cannot allocate memory

Avoid the oversized request and the large bounce-buffer allocation by
capping the requested byte size by fc->max_pages, fc->max_read, and
fc->max_write, then backing the uncached readdir output with pages and
setting out_pages. The virtiofs transport can then pass the pages as
scatter-gather entries instead of copying the output through argbuf.

Map the pages with vm_map_ram() only while parsing the returned dirents,
so the existing parser can continue to operate on a linear kernel mapping.

Fixes: dabb90391028 ("fuse: increase readdir buffer size")
Cc: stable@vger.kernel.org
Signed-off-by: Matthew R. Ochs <mochs@nvidia.com>
---
v3:
- Cap the requested byte size by fc->max_read in addition to fc->max_pages
  and fc->max_write.
- Use clamp_t(size_t, ...) for the readdir buffer size calculation.
- Use __free(kvfree) for the temporary page pointer array.
- Use release_pages() for pages allocated by alloc_pages_bulk().
- Handle partial alloc_pages_bulk() success by shrinking the request size.
- Verified with --overlay-rwdir across 4K/64K host and guest page sizes.
- Link to v2: https://lore.kernel.org/all/20260428233028.2747981-1-mochs@nvidia.com/

v2:
- Reworked uncached readdir to use output pages and out_pages, per Miklos.
- Cap the requested byte size by both fc->max_pages and fc->max_write.
- Map pages with vm_map_ram() only while parsing returned dirents.
- Verified with --overlay-rwdir across 4K/64K host and guest page sizes.
- Link to v1: https://lore.kernel.org/all/20260428021304.2338592-1-mochs@nvidia.com/

 fs/fuse/readdir.c | 64 +++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 54 insertions(+), 10 deletions(-)

diff --git a/fs/fuse/readdir.c b/fs/fuse/readdir.c
index db5ae8ec1030..8116688fe5b2 100644
--- a/fs/fuse/readdir.c
+++ b/fs/fuse/readdir.c
@@ -12,6 +12,7 @@
 #include <linux/posix_acl.h>
 #include <linux/pagemap.h>
 #include <linux/highmem.h>
+#include <linux/vmalloc.h>
 
 static bool fuse_use_readdirplus(struct inode *dir, struct dir_context *ctx)
 {
@@ -343,17 +344,48 @@ static int fuse_readdir_uncached(struct file *file, struct dir_context *ctx)
 	struct fuse_mount *fm = get_fuse_mount(inode);
 	struct fuse_conn *fc = fm->fc;
 	struct fuse_io_args ia = {};
-	struct fuse_args *args = &ia.ap.args;
+	struct fuse_args_pages *ap = &ia.ap;
+	struct fuse_args *args = &ap->args;
+	struct page **pages __free(kvfree) = NULL;
 	void *buf;
-	size_t bufsize = clamp((unsigned int) ctx->count, PAGE_SIZE, fc->max_pages << PAGE_SHIFT);
+	size_t max_bufsize = min3((size_t)fc->max_pages << PAGE_SHIFT,
+				  (size_t)fc->max_read,
+				  (size_t)fc->max_write);
+	size_t bufsize = clamp_t(size_t, ctx->count, PAGE_SIZE, max_bufsize);
+	unsigned int nr_pages = DIV_ROUND_UP(bufsize, PAGE_SIZE);
 	u64 attr_version = 0, evict_ctr = 0;
 	bool locked;
+	unsigned int nr_alloc;
+	unsigned int i;
 
-	buf = kvmalloc(bufsize, GFP_KERNEL);
-	if (!buf)
+	pages = kvcalloc(nr_pages, sizeof(*pages), GFP_KERNEL);
+	if (!pages)
 		return -ENOMEM;
 
-	args->out_args[0].value = buf;
+	nr_alloc = alloc_pages_bulk(GFP_KERNEL, nr_pages, pages);
+	if (!nr_alloc) {
+		res = -ENOMEM;
+		goto out;
+	}
+	if (nr_alloc < nr_pages) {
+		nr_pages = nr_alloc;
+		bufsize = (size_t)nr_pages << PAGE_SHIFT;
+	}
+
+	ap->folios = fuse_folios_alloc(nr_pages, GFP_KERNEL, &ap->descs);
+	if (!ap->folios) {
+		res = -ENOMEM;
+		goto out;
+	}
+
+	for (i = 0; i < nr_pages; i++) {
+		ap->folios[i] = page_folio(pages[i]);
+		ap->descs[i].length = min_t(size_t,
+					    bufsize - (size_t)i * PAGE_SIZE,
+					    PAGE_SIZE);
+	}
+	ap->num_folios = nr_pages;
+	args->out_pages = true;
 
 	plus = fuse_use_readdirplus(inode, ctx);
 	if (plus) {
@@ -372,16 +404,28 @@ static int fuse_readdir_uncached(struct file *file, struct dir_context *ctx)
 
 			if (ff->open_flags & FOPEN_CACHE_DIR)
 				fuse_readdir_cache_end(file, ctx->pos);
-		} else if (plus) {
-			res = parse_dirplusfile(buf, res, file, ctx, attr_version,
-						evict_ctr);
 		} else {
-			res = parse_dirfile(buf, res, file, ctx);
+			buf = vm_map_ram(pages, nr_pages, -1);
+			if (!buf) {
+				res = -ENOMEM;
+			} else {
+				if (plus)
+					res = parse_dirplusfile(buf, res, file, ctx,
+								attr_version,
+								evict_ctr);
+				else
+					res = parse_dirfile(buf, res, file, ctx);
+
+				vm_unmap_ram(buf, nr_pages);
+			}
 		}
 	}
 
-	kvfree(buf);
 	fuse_invalidate_atime(inode);
+
+out:
+	kfree(ap->folios);
+	release_pages(pages, nr_alloc);
 	return res;
 }
 
-- 
2.50.1


