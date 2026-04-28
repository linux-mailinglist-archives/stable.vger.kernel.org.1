Return-Path: <stable+bounces-241460-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CLDjHSQY8GmNOQEAu9opvQ
	(envelope-from <stable+bounces-241460-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 04:15:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F0E3F47CA8B
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 04:14:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5CB0A3046055
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 02:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E5B6379EC8;
	Tue, 28 Apr 2026 02:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jGiTl0z6"
X-Original-To: stable@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011044.outbound.protection.outlook.com [52.101.57.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C02D630ACFB;
	Tue, 28 Apr 2026 02:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777342393; cv=fail; b=PvoxdJAdFtp24F/rQcfJEk66QV/CSdikQ4gU57WPmQ2+XD407ZtoVrt9cAxiE4IiJ7c9OTWjuT5VXv1DwbEQLSe5N3DLVY5lyXUgf59h5dTa0c78+zC5ZfE1PCkEgTGEm+Lb3WFNxgScRK4a14dxb9HuGxkIJjsKCe68Hegt7zE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777342393; c=relaxed/simple;
	bh=3KHWHnGxq8jEEwbgp0cfnmWSPrnmc+CZsBOf/B47M+4=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=AuYrkpx9Pfp38XLU9VBPkWaGTFAZSy6VKeHz7noJEraaeWGDxQKecaA4hQn0KgdgYiF529MebNrCi8Sj1g6LJLF2Fh8Ii7HhWk0Wqb+jMagFBwEmIFZwRL66djrQms62rqabGbfQQI7vixCGe5nR+j1pBm0LCgF9YGcyYufwXJo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jGiTl0z6; arc=fail smtp.client-ip=52.101.57.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FmSXS07SKONuXwdVYN1dc7bt/zssBEVsr6qqvxi0Seh++ERa9MOFa6gfVFpyceUj+pn83DbtTVAtu21Mb/sgNVNHxjAQ/H0h5SVM9kxS+i22gO7pUwAdbCaVI2gaRPn1+QNwJPoWNNfK3nVyuQeC0DZm5uT7uQSZ9wEJJWFz09+grbQ2vcwODF4V4O8ZnNykHGmABP8cYuFz++V5fBCTUV01ZmVWG+YKL6QihAEfbG9PXIPnLp/VfZoO13SRe5V5Y4CjEQVfA8irNVWrkcNQyaOhBiE9dj3Se3FhIuGSK4ohAo9bGMAaVfmMbjPzPBSkJ6BXNpeKGTUjgpZ84f+yCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gq/hJ1IknqZB1ji3bbbh+Sz/T+f5iJ3Y2MzKpgbwC6M=;
 b=hK+j9b9/8MPYTlyyL++/WBERo86kvIJNwmX8mX0b+tzSfuNnfbQVWvWbhDcg7QEDPY6/6J4GoibuH5jvhrxmKnJfbX7dezI3xmlJmDbNzpkqHsbI7SbhBTR0XROqOYgc0zXtpJ0cEv/BXvpteIqu0iW69rZjCT9RpcA7mqfV0xegy0lzeEo0nZNMZRIe+kveGE3me8gTBX1CyE8dNP5gxpuckJUNDrhVzCTQIZdo3EjufShU/KD6QQzlYunRybJs6sRH2ikD6s+4x9zBO1LJt5g8BzEFZxhB5q9RQ14UQqq3rnWDu5YM+RCC8PbH7MM+EeuuCSy0gUcUsERFEbj3fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gq/hJ1IknqZB1ji3bbbh+Sz/T+f5iJ3Y2MzKpgbwC6M=;
 b=jGiTl0z67NuoCb6KuFu680N1RpbLqsupGntRA7cjgMK1FrSB6n900oXExpia0+m7fT2JUhn28TxUsrE7/bz4ekZihzX8GeAIetrCRdAqRuP6Xgzs1609X0Vf4mPsF4ktGSRgCq6oXKBnt6D3nKqGnvM6sm+XFmAa63A+ubBGUambyW4k8m2LiaWMtR8pKXIlGSwv/jauWjziyaX+NRsZEgZXxZ8rDz9iQ/y0NofPomCaThmWovflVlN0iNMx4VFDkR6zkczTq7Qc3RbMFYXZMAmr+h4xY8KOK+N7wM+e3e/zKHOIiyBWiNE4aAlwroNr81NcGlgeyu3S8//zuXTPsA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB8442.namprd12.prod.outlook.com (2603:10b6:8:125::12)
 by SJ0PR12MB6757.namprd12.prod.outlook.com (2603:10b6:a03:449::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.17; Tue, 28 Apr
 2026 02:13:06 +0000
Received: from DS0PR12MB8442.namprd12.prod.outlook.com
 ([fe80::c4df:b439:571:4591]) by DS0PR12MB8442.namprd12.prod.outlook.com
 ([fe80::c4df:b439:571:4591%6]) with mapi id 15.20.9870.013; Tue, 28 Apr 2026
 02:13:05 +0000
From: "Matthew R. Ochs" <mochs@nvidia.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Bernd Schubert <bschubert@ddn.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] fuse: do not treat unlimited readdir count as a buffer size
Date: Mon, 27 Apr 2026 19:13:04 -0700
Message-ID: <20260428021304.2338592-1-mochs@nvidia.com>
X-Mailer: git-send-email 2.50.1
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0127.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::12) To DS0PR12MB8442.namprd12.prod.outlook.com
 (2603:10b6:8:125::12)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB8442:EE_|SJ0PR12MB6757:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a293184-016b-4a6d-0264-08dea4cbaf08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	saVH0mjN9GWKzMAb/IehWu5eN+4PmxuNo4uLX6VETUgERyO7xChsR8LFTkBSFtfUAo3K4uZ793eIK6pulhqtasYL4GU4f1MxXQFBvD3Yohd97dEgGWR5afksLtU50t2Ewl7rtRyuUYknPW4TXGJ/wQHNHC3OBzS/8X6I6sOtLxJIKV1XKFdrLRxfRX/Kbwis7NTjAOC1KpO0S9sT0ydIIDy637lWLrZLNGvesezqZEQn3PWIFLDvZedgsTnK5r3kfimVB1OJC1gEI/coRwV6sOkeyy50riW/buEogxH/3ld8wubDrleMSDLl+tuBLlVrKt23J4kTFL5ad/zAggfyshu+BI2XPt2R7v+K2FKXidw0HPF1HxojwC0+yyXCFvleORQ4nulP0/LQ74hc54lyJ9J7Czu8mOQHPmGG0o2pBA7qujyh2TEsp8jP6/ievbp7xfynq8r5a8ufpO1VeGIoHOuI38WUiMuQv9hvrzFrE6B+huErwKI9bLbNjZ0JCLWB5EAvXvz++2ny9nH+2Ge7ZNPw5lWpM4Zay/pNRj3/A0B0LIO5JvCswaaJRZ5TxX02b8Y40zvOZDoPe0GjRHfPgRnrXbbYQAlits7ApeH7t4ENTy90mOkoofW304Ax5A/z38pmypgO7xVyj0hlW3QkI2WZ5r1MIwq8wRXNbVziOHQmKGakxUTg4V8DfrglHDjM28SzQicFQ16ebObdqEilMKQ9BX+T1GeG2INCr4jEMck=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB8442.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RBF6XgrgN3f62eSv56EOsh7RbviL70yNSu1lMKaa15QYbuT/ZMmV3tywN7nY?=
 =?us-ascii?Q?SG0TarXN7njCLPnnM/RGIucNxiU7cQt9b+RHtWqeHZ0DvDPYtsdeNHmdfJiY?=
 =?us-ascii?Q?FwCnD4govq9tfLPM5naU/fpI5p7O54pNyVuKk+2My/iSbuKYKKGIeV+Ideoe?=
 =?us-ascii?Q?56vrDEorwCOzGliSmMw9zqpvvG+GetgUHzqijtP9OdTEEIBn668zkwQWSlNL?=
 =?us-ascii?Q?NVqhnfr3g4mElWxNJvMjebo0dwTUpBoCCTmxVRqDkO/IHSJGeqGRc9QHYeZw?=
 =?us-ascii?Q?EEgxzaS38GpdWUMaU8LzsblqwHrEnmEE6YhnLpno8S4CdGGeURre5gklJ5kf?=
 =?us-ascii?Q?00ugz7PD+EBuqoBjg9UyCA2IBC5oH9f1oDbiFRJKjaUwHk+LJU6U/Fo/5Y1R?=
 =?us-ascii?Q?ffu9NCVlFB+DOhkqY0Q8WuOYI+Woo9obqmQbnQrPmG+f8yWNI04gs6phEvHJ?=
 =?us-ascii?Q?+5ForNKaGRG2PPmRQSkY77s2BLXMgttwNvtsIHE96x77Nvy5FXUEqqwY4fTJ?=
 =?us-ascii?Q?jD5BROf2IExoEyXd/rxAsgzJDKg7fNUoDYoX4X0z1MV/mA2iO3kXdUVIy+MC?=
 =?us-ascii?Q?LCUXUpqn397+R56BPuCAIKihe+5ycAKRtgL6MtPKQ+MOF8K+qVyx5cRExFi3?=
 =?us-ascii?Q?U3ofK3RDukIcOEd/3fwSHNh/1Eg5SFylXJQS9i5ulu2v79oR4AVeJ42oUJu+?=
 =?us-ascii?Q?bGct5znRsb3ODaEvqZK8vWz+gQSZ7S7cegd09wKqqjxpZmS9cnbZMA+8U8ZS?=
 =?us-ascii?Q?GKXJDQxE+plO5b18m2Lc/tqctrFx5K40/REQ2bPhad5qAdaxNNwIp4oBga2V?=
 =?us-ascii?Q?IxSHmXgEkYrXIoh2wTiSl2QV/+2knrrxeFNdPc2whSO2HJaGEmlK4WgA6XR8?=
 =?us-ascii?Q?MrXoY9FgAKgc/9yLPjFXF4unh4nWAeoigqZiEnv0MAPmSVzppvsy1YMb+0ka?=
 =?us-ascii?Q?0nkB/BhCV8L/NpvvdPgdxyoxPq3B5/BgprFDxrS8hXa7mxUuZ5ULlkZkjMyn?=
 =?us-ascii?Q?UXZpV5HtCBkgAyAqGHqJ70jKOxwlGlb/j91TksAzJ105y6p7OMYRbJM/xu31?=
 =?us-ascii?Q?/+N+1ezSHOFTt8L9xb0gwSfBTfWLg7cXr/Ji0am8964J7hg2DxtOD3FeW3pG?=
 =?us-ascii?Q?nMqbBWGKAA19ctONg4h+uiaCjBwhaY8Hibrs8zY5GIRbhZYNykhIk02Ixl22?=
 =?us-ascii?Q?pyqNtDf8Oa3821FLwm4VuFs7cFQfQmSP5RZQhFmEwLIYSN82a10ZxggT01nj?=
 =?us-ascii?Q?todA+cSPediVxhJdwfJaSYkdbpJtDRDk5h2cUq6+wCnnxo4gSBOBpTgzzaVF?=
 =?us-ascii?Q?tc9Bi4refPJznOV89XrhVg8/61ni+slSeUUn6rf0Xpe5ibebb7AiBmBdTfb7?=
 =?us-ascii?Q?k/S4N0ipQBNCYJWMrV4hQvrnZt31Sg6IICXaZNPK40IgY7QfQQQln03btS8J?=
 =?us-ascii?Q?QtdeBxrZEkeBUsqFxWmwFZsuGmk+9kPT5w3GX+fJZ3g/EGF3svPNwBIqEWWU?=
 =?us-ascii?Q?EjvTX1/nTk5i1kHrrBhpqAuaKd66Y9fq5kMljrQMfhuzqSq/v7iRZmnHAqE/?=
 =?us-ascii?Q?LpIobLAKCsKxyYcDdA/Xtn2imNawm3Sq7tBQ7x16PB+6PR2xC4lg79nCjYxM?=
 =?us-ascii?Q?TMkXvfGPG0HRnYzhjgke7zf4hRdHRflRADuJGYGg29PGgE1/mKnHvwPFJu7K?=
 =?us-ascii?Q?lYI9GYwQ2m9i42iTPYmJVp9DTjR945vbHtKZAxXie7wNPJqmaCggRgwf1EqV?=
 =?us-ascii?Q?mlgKUMQOqA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a293184-016b-4a6d-0264-08dea4cbaf08
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB8442.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 02:13:05.6465
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xXq8SafYV92gmoSSYAac4KosuT1VzPmDITme64OM+EDrFtm5JyXW47gZMYhaLfBDYRie3xmG8wDxgGxLaOhNZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6757
X-Rspamd-Queue-Id: F0E3F47CA8B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241460-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mochs@nvidia.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,Nvidia.com:dkim]

Commit dabb90391028 ("fuse: increase readdir buffer size") changed
fuse_readdir_uncached() to size its temporary buffer from ctx->count,
clamped to the negotiated FUSE maximum request size.

That is correct for normal userspace getdents callers, where ctx->count is
the userspace dirent buffer size. It is not correct for in-kernel callers
that use the VFS sentinel values documented for struct dir_context.count:
0 means unknown and INT_MAX means unlimited.

Overlayfs uses INT_MAX when reading merged directories. After
dabb90391028, FUSE interprets that sentinel as a real size request and
expands the readdir buffer to fc->max_pages << PAGE_SHIFT.

For virtiofs, the output kvec is included in the request bounce buffer
allocated by copy_args_to_argbuf():

  req->argbuf = kmalloc(len, GFP_ATOMIC);

On a 64K-page guest, this can require a multi-megabyte contiguous
GFP_ATOMIC allocation. In the failing setup, a 64K-page guest on a 4K-page
host negotiated max_pages=124, so the computed buffer was about 8MB. The
same guest on a 64K-page host negotiated max_pages=16, limiting the
computed buffer to 1MB and masking the bug.

One way to reproduce this is a 64K-page guest on a 4K-page host with an
overlayfs mount whose lower directory is on virtiofs. Reading a merged
directory through overlayfs can then fail with:

  ls: reading directory '<path>': Cannot allocate memory

Treat unknown and unlimited counts the same way fuse_readdir_uncached()
did before dabb90391028: use PAGE_SIZE. Keep the larger readdir buffer
for callers that provide a meaningful positive count.

Fixes: dabb90391028 ("fuse: increase readdir buffer size")
Cc: stable@vger.kernel.org
Signed-off-by: Matthew R. Ochs <mochs@nvidia.com>
---
 fs/fuse/readdir.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/fuse/readdir.c b/fs/fuse/readdir.c
index c2aae2eef086..0e436c563efb 100644
--- a/fs/fuse/readdir.c
+++ b/fs/fuse/readdir.c
@@ -341,7 +341,10 @@ static int fuse_readdir_uncached(struct file *file, struct dir_context *ctx)
 	struct fuse_io_args ia = {};
 	struct fuse_args *args = &ia.ap.args;
 	void *buf;
-	size_t bufsize = clamp((unsigned int) ctx->count, PAGE_SIZE, fc->max_pages << PAGE_SHIFT);
+	unsigned int count = (unsigned int)ctx->count;
+	size_t bufsize = (count && count != (unsigned int)INT_MAX) ?
+		clamp(count, (unsigned int)PAGE_SIZE, fc->max_pages << PAGE_SHIFT) :
+		PAGE_SIZE;
 	u64 attr_version = 0, evict_ctr = 0;
 	bool locked;
 
-- 
2.50.1


