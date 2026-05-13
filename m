Return-Path: <stable+bounces-246895-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8PiaCMKTBGrYLgIAu9opvQ
	(envelope-from <stable+bounces-246895-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 17:07:46 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B63BE535C36
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 17:07:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AA318302E7FF
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 15:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 515FC466B68;
	Wed, 13 May 2026 15:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cjwbLUVu"
X-Original-To: stable@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012052.outbound.protection.outlook.com [52.101.43.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8C546AF3E
	for <stable@vger.kernel.org>; Wed, 13 May 2026 15:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778684428; cv=fail; b=lI8a+WgXqJcRyBow9+WUCNcqeTeK1d2NEnY8ZQIOhOFb/YUxfAfy1xrH+K8vaIRcpXfxkcYANfj5nuRCf+7groo8rPy9IEHK8x23sRirKeORyGMmSSMhFWNQXdoc9zsuCn1Q878rMW4dpkLRIpbU/xO7gAE0FZBXO+ajCeJGgA4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778684428; c=relaxed/simple;
	bh=4IAblxrmuhnuy7bEw5eqjPYSlmX1gr1kcP7ZPEqkanw=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=mEP2cm5X1tJkM0wyVRBfjWX5Np/1SE0D6pPqvmayfeEBYGuXu+3tVggx0GDt1/brCVUIoz4hJteXtgfQXQyFmi4iAhvZpZsRTSbrOdbD43sS1WxHq83nK6oF+mEYrgHHYhO2120pbgrCWfqH35gmY09ClVNc2hLiooz0EzuWr58=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cjwbLUVu; arc=fail smtp.client-ip=52.101.43.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F6djuzsMc9WStj645T75lGNlwtXF4iIO1SOcAIqoXtqAd2VdTgfvS9dHZs9fXdo+LlWqSisnidQnzFyMakkyLylfNO4BXL+qdc5kpCPKnIo2pndEYB7qYIMwL5JBWADtr6MC21KY/WcctTKnc9rFkSeVSCevogL4su2bENf1gySV/h/J0t8I0sPdEU2lNSrB5SlgA2MFdw7zGJOytH4m6Z9VO6uXMqybjzakv7SRvD4up5mPsSuZdmw/36M1+yjtcRFAIg9Ma1lRKQKYmrXxnd5VBFZrepPy3bKoUuNkQal5Nb0o1Kzspb17S38eBjcR4WOdXEpu4/z0Kdr46QKRxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BwNO+MifZkZBsic55rjQ6b/cHoy/DnRtlejDLIdWFSw=;
 b=DMB+HTDCLsd6lQGKNJagJG5SOUH+CD9mSeoXgS3pL85jWgj9wRQ3mQ1pd6KUSabklcKxHhbqO/K/CSH0gIgpi+c1X27tqSz15CD8PIl6drVFIXTgV36RbF7AsBHmtW1c7AAZJPIpskbgx9gVZHuNOTJzoH6kA+aPTs/IdUzzi8NTqKtc75tWvZNP3gU8tF+xg7HTmBtv/+b1uXLjkhcBQSmE3GQ0QyUkTlsP7d1wb+kYkvNfHGk8193u9OJvRHjsx9AOmA3zKIP3TfcArB7lnK3aVWvWwF5+P+buCX92g115L6ECdxw4bpAMi6Wn53dlkatUpaq3ePsr9PbFhvKQKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BwNO+MifZkZBsic55rjQ6b/cHoy/DnRtlejDLIdWFSw=;
 b=cjwbLUVuZdfiDKDHfS4YBpIRbgOy34QLoy0uOY3Ep/2jSlfdDCnKnOC8+RZXMkZmHb5yFD6pxVRhGvdWxXhGsitkbBjOsXsInnTFcGAzCeNsY9Tz6FuA9WCpGHKdnDSE7MG3FHIzabrIAoQzUAC9EveNfkwqsEGofbjmtkwwAGPDnq9BBcqVLoDCpyZMkt1CtqtzkTB0axv2ICy0QZfNpu2W93n1dPutlGSVHVKujRzFCs+lJ3M/Hq3kmda4SeeFdyX7/dMvtzJ/ty4sFGp/4shgykU/ueLcE0BPu6+YNVXs8dmfxplZPQH41eylWz4mmD5gLIIBeqrbrusQfDlrEQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SJ1PR12MB6291.namprd12.prod.outlook.com (2603:10b6:a03:456::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 15:00:18 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9913.009; Wed, 13 May 2026
 15:00:18 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>,
	linux-rdma@vger.kernel.org
Cc: patches@lists.linux.dev,
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>,
	stable@vger.kernel.org
Subject: [PATCH rc] RDMA/core: Do not read wild stack memory in uverbs_get_handler_fn()
Date: Wed, 13 May 2026 12:00:16 -0300
Message-ID: <0-v1-c4e9da262868+24d-ib_handler_fn_fix_jgg@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT1PR01CA0092.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::31) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SJ1PR12MB6291:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f62e6f6-c9cc-46b7-bc7f-08deb10058c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|56012099003|18002099003|11063799003;
X-Microsoft-Antispam-Message-Info:
	vVbQhspwOrsN5nNFdwkUKoHWufSpZzPcZqRIEe6B6DpwxV94ZOITgPb4Gr/DYTILelSL7U3MqIl9HsFl/9RmFhORe7wzjSC9MY7B1Sdl31S85w6epY7TtZDio+17nfx/PRUg2bxp+Z+d39xFaOixCF6fdcXojCMtr/wwJFY2SjdhFG6saBT0jMFKx3qo+vp/2piOktFt723sHgvD9inoNBF+c8vSas6BeGA14B/uSeEzKCQcQg5EJ+1krVVct1TdcjHyAtxAtCLGiAeUQ7rlZICT6ejVEJs+8hZBTUFblYIa6Lw1q3PTBWTIaGFk8WF+DrOFtiN4t/CEGuufYhEcra4cS+OQvyPAclfndZkwGuPcJnxRw+xgv0lQdoov3EGrzZGyCvTpeARvZcjUsuPv6aLriVA383V93MiK75FAEFKPu8JYebslI8jEZ+KBIdDmPbSSfhc30xqOUKtWZ6wPtBqXctjWoUWq9QpvixiH76iPGUfoqAk7jSneV7Csqkt88sfhiYav9gCy8+4RukzOQ1PNwKPHDS20//UrjCcK9fc0Z9ms4wHaYkNT7Fl113hKAn9f759ly4GDpcLzVgmCiLxaJuLJNnpbD6J+auXE22KmwBSiGcgdcHx3V0r2ECSqi/+SrBJmvFYE3A9LhxUExatWzGvhp7YRHJeH2zpc3C4yvzPbhQlX+ZMaRfEofU1+
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(56012099003)(18002099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/yiyqqVWHavsdvAdZbnoKT7i0K3AHEnHbMNGA4WHYYpD7UVGi1Tg8oNln4gN?=
 =?us-ascii?Q?2SuBVODrdotcYVrk+AXl/ub11/Fp45tcJbzVoFowWP7n3Vnhs4f3BDoByxEU?=
 =?us-ascii?Q?8orePFRUubr8CfQO+WlWSNQeZorasY0p8G3D/jnP8doTiH5QO1wmaaxgubAQ?=
 =?us-ascii?Q?Ac4mUHewaQz0Ju7U7f2INkn7t8nF7XLjxCHYSzFIVE0mO95RHpMCSYTtsw2z?=
 =?us-ascii?Q?jxDoPYmO3k7uV75J/QxjVwR+56RSO8GZPpz01BfOVUjDbyFr5RC7kdVCswcO?=
 =?us-ascii?Q?rNp7hI5JAyG1+nPESxe4GRPISk4UtIT2rk5bzJC3V9s7auYlS9LNBGxxNKw6?=
 =?us-ascii?Q?JcmLBBn0yceRDKggBIArWRrxKYKUxxKFIiAYMV4E2ZQTULx0/GZLZM1e6Yei?=
 =?us-ascii?Q?qYjmLuz41lhaqNpvZn6W1/OeI9UbvYeYO1VRojoWkAF2VEMbczfmgMDfz12g?=
 =?us-ascii?Q?gcdAMavBST8l8k/xlaFivc8joYB8ejZ9WWa2LJDCpi2TtiORjlNBQE6ZFO3h?=
 =?us-ascii?Q?QE4G4TS/9rVkaVyFUkh5yxzAOhPqeAoLbTdGpkPFYz7AdmiD4WMNYkqehx0a?=
 =?us-ascii?Q?sWM4IspxTrIYZSAfkL9RhnGqPX7C9U2aF/jEqztRVAqNZc2SvMDxYRRZWkWQ?=
 =?us-ascii?Q?xhG6ilgNQsAXvZuR+306C8xB9IfuZlENI+GTrlmJOJZbCv4XWR2OICkOXG+l?=
 =?us-ascii?Q?7otW3SG3Y9+GByrirI+df2KJO75+zb4DGUzoizq56YfKVRJfw2n9s8nGBmyV?=
 =?us-ascii?Q?6nExGkkpveJ2WOAzMrj6xOu3c2gOCx4qqYNCGyuwUlniZLEp2abMsJSZhgVS?=
 =?us-ascii?Q?3F161BWnJJew4t96Y6i9LMZrV9yMdfNUKhhfQriz81suBR1rnAbKqqXPeoAV?=
 =?us-ascii?Q?mOvWnUlTh8T2KATyFlpJNcP8EnumiF4xXi+HiS8/BERoOmfDtpaKBSMGc361?=
 =?us-ascii?Q?J6wYM+nQMXjYQ6MGP7jXHjDGVFzL1d/A/p5RUcfJxd2D4qJXvoHph/s5fPlP?=
 =?us-ascii?Q?557R3wufV39719KLfXKYrlBfTFvBbN2nATFhuOpjNsvuhuDlBYaPie8OOm/o?=
 =?us-ascii?Q?pQsUWu0caarAojE8F7QrAHhlthB1IcPwGjWkYs2cG25DsB1/wWcwhiVkk+9d?=
 =?us-ascii?Q?brcq2vK0SGC6kBCha3jlrhLvsxoVZ67OqJipaJEjZobwTltgvgxcWIEhpbYS?=
 =?us-ascii?Q?zunSL7rCfiIgL7Ffh0wTsUJ0DIbvJpSHNtTaI5MsB7BOCBg9mzrIVwxHxLNe?=
 =?us-ascii?Q?e/GYIo23qm/rzGSgmAu0vHdgdtFft0kaOab3Vzl/ysbq4vHrT1gmPqBmWRma?=
 =?us-ascii?Q?7vWSVZrgN9iqFZNU8aR3gbLg9JCQ1HXf+QX2kmlsRaK1wNjYdEpaCuqcdX3v?=
 =?us-ascii?Q?rz0pm4ZlP8IvfY9WplVQeFcEs+B93cCP53IVxF82VlapaU/MLVpSIXc9Qy+I?=
 =?us-ascii?Q?yyUlr+2Vvcfuy8bP2Cq40dLN92CXVkxAQPpykZ9IPuSoGzWZ5UIT6ttHm5qQ?=
 =?us-ascii?Q?PQxN970Le/49bFO30h6AUFUQ7Zi0VSFNOW6meiT5209bNbvfCTWuvwz9wSOr?=
 =?us-ascii?Q?JWqyc5bxCFAS+5UC5H+hcFQrCTU1RmkdjBQ6L37UCNdc2reKXgjayhvCX93z?=
 =?us-ascii?Q?59QnlRYtdcV8v9z2/AxvDnJCiW05DVeHlMAM0QUpFlDFEr+G4LazCZVd0h9S?=
 =?us-ascii?Q?7Cs3Cy+S9Z1g+Xu/xguQuuKqwP8ALkvBjgLBf/QFU7lmCmr9?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f62e6f6-c9cc-46b7-bc7f-08deb10058c4
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 15:00:18.2215
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DV7sYOGoN1V5JMUsVjfZcsEs0YnblyQq9ijJ9NpX5fnkLE4KZq/YxllfwXVErUDk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6291
X-Rspamd-Queue-Id: B63BE535C36
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-246895-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Sashiko points out the legacy write path in ib_uverbs_write() does
allocate a struct uverbs_attr_bundle, but it doesn't wrap it in a
bundle_priv so downcasting here isn't safe.

Instead lift the method_elm out of the bundle_priv and use it for the
debug function. The legacy write path will leave it set as NULL since the
write method_elm uses a different type.

Cc: stable@vger.kernel.org
Fixes: 1de9287ece44 ("RDMA: Add ib_copy_validate_udata_in()")
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/core/uverbs_ioctl.c | 31 +++++++++++++-------------
 include/rdma/uverbs_ioctl.h            |  1 +
 2 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/infiniband/core/uverbs_ioctl.c b/drivers/infiniband/core/uverbs_ioctl.c
index b61af625e679b2..e185af57dc1a93 100644
--- a/drivers/infiniband/core/uverbs_ioctl.c
+++ b/drivers/infiniband/core/uverbs_ioctl.c
@@ -50,7 +50,6 @@ struct bundle_priv {
 	size_t internal_used;
 
 	struct radix_tree_root *radix;
-	const struct uverbs_api_ioctl_method *method_elm;
 	void __rcu **radix_slots;
 	unsigned long radix_slots_len;
 	u32 method_key;
@@ -74,12 +73,10 @@ uverbs_api_ioctl_handler_fn uverbs_get_handler_fn(struct ib_udata *udata)
 {
 	struct uverbs_attr_bundle *bundle =
 		rdma_udata_to_uverbs_attr_bundle(udata);
-	struct bundle_priv *pbundle =
-		container_of(&bundle->hdr, struct bundle_priv, bundle);
 
 	lockdep_assert_held(&bundle->ufile->device->disassociate_srcu);
 
-	return srcu_dereference(pbundle->method_elm->handler,
+	return srcu_dereference(bundle->method_elm->handler,
 				&bundle->ufile->device->disassociate_srcu);
 }
 
@@ -445,13 +442,13 @@ static int ib_uverbs_run_method(struct bundle_priv *pbundle,
 	struct uverbs_attr_bundle *bundle =
 		container_of(&pbundle->bundle, struct uverbs_attr_bundle, hdr);
 	size_t uattrs_size = array_size(sizeof(*pbundle->uattrs), num_attrs);
-	unsigned int destroy_bkey = pbundle->method_elm->destroy_bkey;
+	unsigned int destroy_bkey = bundle->method_elm->destroy_bkey;
 	unsigned int i;
 	int ret;
 
 	/* See uverbs_disassociate_api() */
 	handler = srcu_dereference(
-		pbundle->method_elm->handler,
+		bundle->method_elm->handler,
 		&pbundle->bundle.ufile->device->disassociate_srcu);
 	if (!handler)
 		return -EIO;
@@ -469,12 +466,12 @@ static int ib_uverbs_run_method(struct bundle_priv *pbundle,
 	}
 
 	/* User space did not provide all the mandatory attributes */
-	if (unlikely(!bitmap_subset(pbundle->method_elm->attr_mandatory,
+	if (unlikely(!bitmap_subset(bundle->method_elm->attr_mandatory,
 				    pbundle->bundle.attr_present,
-				    pbundle->method_elm->key_bitmap_len)))
+				    bundle->method_elm->key_bitmap_len)))
 		return -EINVAL;
 
-	if (pbundle->method_elm->has_udata)
+	if (bundle->method_elm->has_udata)
 		uverbs_fill_udata(bundle, &pbundle->bundle.driver_udata,
 				  UVERBS_ATTR_UHW_IN, UVERBS_ATTR_UHW_OUT);
 	else
@@ -499,7 +496,7 @@ static int ib_uverbs_run_method(struct bundle_priv *pbundle,
 	 * assume that the driver wrote to its UHW_OUT and flag userspace
 	 * appropriately.
 	 */
-	if (!ret && pbundle->method_elm->has_udata) {
+	if (!ret && bundle->method_elm->has_udata) {
 		const struct uverbs_attr *attr =
 			uverbs_attr_get(bundle, UVERBS_ATTR_UHW_OUT);
 
@@ -520,7 +517,7 @@ static int ib_uverbs_run_method(struct bundle_priv *pbundle,
 
 static void bundle_destroy(struct bundle_priv *pbundle, bool commit)
 {
-	unsigned int key_bitmap_len = pbundle->method_elm->key_bitmap_len;
+	unsigned int key_bitmap_len = pbundle->bundle.method_elm->key_bitmap_len;
 	struct uverbs_attr_bundle *bundle =
 		container_of(&pbundle->bundle, struct uverbs_attr_bundle, hdr);
 	struct bundle_alloc_head *memblock;
@@ -608,7 +605,7 @@ static int ib_uverbs_cmd_verbs(struct ib_uverbs_file *ufile,
 	}
 
 	/* Space for the pbundle->bundle.attrs flex array */
-	pbundle->method_elm = method_elm;
+	pbundle->bundle.method_elm = method_elm;
 	pbundle->method_key = attrs_iter.index;
 	pbundle->bundle.ufile = ufile;
 	pbundle->bundle.context = NULL; /* only valid if bundle has uobject */
@@ -617,10 +614,12 @@ static int ib_uverbs_cmd_verbs(struct ib_uverbs_file *ufile,
 	pbundle->radix_slots_len = radix_tree_chunk_size(&attrs_iter);
 	pbundle->user_attrs = user_attrs;
 
-	pbundle->internal_used = ALIGN(pbundle->method_elm->key_bitmap_len *
-					       sizeof(*container_of(&pbundle->bundle,
-							struct uverbs_attr_bundle, hdr)->attrs),
-					       sizeof(*pbundle->internal_buffer));
+	pbundle->internal_used = ALIGN(
+		pbundle->bundle.method_elm->key_bitmap_len *
+			sizeof(*container_of(&pbundle->bundle,
+					     struct uverbs_attr_bundle, hdr)
+					->attrs),
+		sizeof(*pbundle->internal_buffer));
 	memset(pbundle->bundle.attr_present, 0,
 	       sizeof(pbundle->bundle.attr_present));
 	memset(pbundle->uobj_finalize, 0, sizeof(pbundle->uobj_finalize));
diff --git a/include/rdma/uverbs_ioctl.h b/include/rdma/uverbs_ioctl.h
index e2af17da3e32ce..c89428030d61ae 100644
--- a/include/rdma/uverbs_ioctl.h
+++ b/include/rdma/uverbs_ioctl.h
@@ -635,6 +635,7 @@ struct uverbs_attr_bundle {
 		struct ib_uverbs_file *ufile;
 		struct ib_ucontext *context;
 		struct ib_uobject *uobject;
+		const struct uverbs_api_ioctl_method *method_elm;
 		DECLARE_BITMAP(attr_present, UVERBS_API_ATTR_BKEY_LEN);
 	);
 	struct uverbs_attr attrs[];

base-commit: a2009b0ca05ea2a937109e3844769209c07f93c3
-- 
2.43.0


