Return-Path: <stable+bounces-71513-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D15919649B7
	for <lists+stable@lfdr.de>; Thu, 29 Aug 2024 17:18:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0211E1C222FE
	for <lists+stable@lfdr.de>; Thu, 29 Aug 2024 15:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08E8D1B1516;
	Thu, 29 Aug 2024 15:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=witekio.com header.i=@witekio.com header.b="ka1lO2oH"
X-Original-To: stable@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2135.outbound.protection.outlook.com [40.107.20.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A0D1487F1
	for <stable@vger.kernel.org>; Thu, 29 Aug 2024 15:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.135
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724944680; cv=fail; b=snyHB41yMr4z86FXBUIWIwJzPzum0TCIxSCCcvBJ081JfqC0OME60syEXLZWuQmBYGr9e5lOR74tmVCFkq/udUjjvodjddofvrENar8orheqnttS+Ey6H8AKXDSmzrEVmn4hHYCtjevPwA6eIivtLz2Ptln4bapRFXm+WDB3b+4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724944680; c=relaxed/simple;
	bh=VbArvVxCvnWuJPriOSiQJ60lVhHnIRqwXDFHPY1EA9o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=reM+UZdMeFOdVqcx+vTy+hF9oahqnFg97fxj1fPTgNdgs7u4WD5o2Ls6IEcPAoWJBY1FTuy74r0iTpOWFr92ZeTHqU37FYVDMn+cvBGhemFYp+ITrZoDVN2w2KpQ4saL1z1LviMNdf7wugrulbPR5iGbEyJrL1o7oIR4CM88n60=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=witekio.com; spf=pass smtp.mailfrom=witekio.com; dkim=pass (2048-bit key) header.d=witekio.com header.i=@witekio.com header.b=ka1lO2oH; arc=fail smtp.client-ip=40.107.20.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=witekio.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=witekio.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wXKAZtepYO2tc5ezojgviKWCm4fTSMN1G98BPejBDPgWCxamXjwA7EfcwGHYb413y8rUqzjss/H1JCL30xjDFjGxvT0gcVv5dP6ZB8aYwtcqNA76/ujg/eigqVtCWTvB1w8em+z+5wFO6nk2gIyw7iGFTr9P3nGz0eS6H9OQljqMno3k0TJnGvIUM6lFp9iGCvhG05r6WSVvJT6I15vEOWjIZLuVfVcqfZLNx4aeejR/s4kRRkQ3UuK/zD7oEMLQ/vClszmctjYX85Y+l/Jnz5zmYqMSnpsHo0siIlmKRTRRwmEpbzH/dkfoRhGzIVO4VT6b051Z3gV+JsFARH+FOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lRNc3OpjA6NaMquYCSeWW8lT2WWSHx9xtAq24It2eKs=;
 b=v9iFGexp/V7JXMRGxQr3QNGTU8RTwVwxBIiFwvXL5MuGCYfBCjhyOsOhH6nr6DoMK04HGERCnUmAHgbRBQe5lOlRPQa7MVpToAqZk6NNnfe+qLuRigTNEPz7bPCRBidrWOHrCHkPKWIOx5TZ8IaaqF6Dv1zruZAE8t5S/fB9QehbExH5qFHl7aBTtMrmXHL4KIreX/oQaU27t5wDLf90kxQAJiNC4HRI0rSujjlheBOpxtj0rWCa31Xj4jeHm9NePCwFzBL37G8l9FbZLbHS9IcufADeFu7fCzrdoeOfAUrVSxNn4rutMmEZhLazlYcynLJ3Bgg+n5E1wyPGsHixpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=witekio.com; dmarc=pass action=none header.from=witekio.com;
 dkim=pass header.d=witekio.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=witekio.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lRNc3OpjA6NaMquYCSeWW8lT2WWSHx9xtAq24It2eKs=;
 b=ka1lO2oHI97tOOYlNWzToPrRDtATSYjX6eeTT4VCrLcmRW+42egeJ8RkLVI5HXzLMN4wyjZdlbFCXCOBUOlEBmD7+8FCCeyCTgDuxuoSN+CiyOOWHNPNgh1S2z169i23syWjAAwnwtM2540jokkAzuEU3yzFP/1cNo9CMdbXU34rZRymT/pxFleLpRbdOUr+SkiSLRk2R1cBKcXfYGT29hiZw1FnuMEq53Qre7M2qokfg5t98WP/dqpB3yISySOhfygY61yONTNJNyKd/zsdkbcI3V+K0FrE0nfCAe4zLR52ebKEVggNVvQDvAsKpNwgEjHSITLTbcuNnHXg4hrUcw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=witekio.com;
Received: from PR3P192MB0714.EURP192.PROD.OUTLOOK.COM (2603:10a6:102:48::10)
 by AS2P192MB2266.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:64c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.28; Thu, 29 Aug
 2024 15:17:51 +0000
Received: from PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
 ([fe80::345f:a9e9:d884:3091]) by PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
 ([fe80::345f:a9e9:d884:3091%5]) with mapi id 15.20.7918.019; Thu, 29 Aug 2024
 15:17:51 +0000
From: hsimeliere.opensource@witekio.com
To: stable@vger.kernel.org
Cc: Miklos Szeredi <mszeredi@redhat.com>,
	Hugo SIMELIERE <hsimeliere.opensource@witekio.com>
Subject: [PATCH 4.19 3/6] ovl: switch to mounter creds in readdir
Date: Thu, 29 Aug 2024 17:17:02 +0200
Message-ID: <20240829151732.14930-3-hsimeliere.opensource@witekio.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240829151732.14930-1-hsimeliere.opensource@witekio.com>
References: <20240829151732.14930-1-hsimeliere.opensource@witekio.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PA7P264CA0076.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:349::15) To PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:102:48::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PR3P192MB0714:EE_|AS2P192MB2266:EE_
X-MS-Office365-Filtering-Correlation-Id: e840d8c6-f75d-430a-7371-08dcc83dbfbc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?azXdr+faNQI1zxC+jaSSLMqThgEQ705tm/+l2dVowlPOoxDo+hpOp35qt5jz?=
 =?us-ascii?Q?VHM+6L3TyTUIrIqkdEVSSvaTmlR3dwYD5DWxVaMkac/LEZ16B1arsCOFKr2I?=
 =?us-ascii?Q?FE4zXkS9bwTKq1GifVwVuWodWYvPUSGJ21FJfa0+8Vu4uYcu5eLG1vGmjr9j?=
 =?us-ascii?Q?rE+WlGuiPeL4OTU2t2y0z0ahrn85ZrHYkZuOmnMXtQdVkjYpoCsMMbmzvXB8?=
 =?us-ascii?Q?3dS1CfslGKbCT59UOOypBfB2kQ9b262YBcCghmLu7Ql+Lb2pa0Avmd1cEHzN?=
 =?us-ascii?Q?jlDcfj54HqYfQSTgXgb0BvsRSPacM9stX1aJTUoEfI2jpISrUkPGw6cLUXmE?=
 =?us-ascii?Q?3q15eYMKokUXJ2HWTWHhJZlbbcoqIf0Oab+tAnR3BTAbUorsTeckNfNiWEfe?=
 =?us-ascii?Q?CKntCyhT0cfNX3GTfvkMxQsB+Ht/dBeQzVfYD9+GsIvDG1ifjdFW0owLVoOl?=
 =?us-ascii?Q?jnVCLH0JXNFAnglLjl4qphGAei+VdhGm5rKhEbEfTroHuUIx0+ywnJp0d36H?=
 =?us-ascii?Q?08aRxNkpvsIAoCTUa/1EGGbip6TS8DiCUI0oKbnPFjd8rhxGo9ZCcbEAUhoq?=
 =?us-ascii?Q?776iMMco9igKBXG//LdPUWnnvDcd1ykF69yI080FF5VXc1F1zpRouTfgWaaP?=
 =?us-ascii?Q?NHnbg/Th14cc7UG9qbjwgRVURMCUPN4CpH9zsg50XX03hdZKwV7TsWucvY4c?=
 =?us-ascii?Q?5HLc6aHAcjk4ixkPjwnW3H8yfSjJwWHEzoV0S9QU4E61OUf/W5OThlQjMeQC?=
 =?us-ascii?Q?4JxBwYDsX+ULzjr0sHIwvEEJKXcDAI1DGiaCHOqItlKg+Pgh372QWo7y4rmd?=
 =?us-ascii?Q?Lu3mEQl49z69Ut5uer8Vzoqeey9mrRAcYbVDujX4XB9Bxm64z3gc5FfdvjJ/?=
 =?us-ascii?Q?npyXYMr0EFPZRBlE3b8BurUeGMlDSWQlcjCYjyZ8rgh6yVTv9dIlYjEPA3Od?=
 =?us-ascii?Q?j1SVg3S6vL71FKCAFU+4MxHRF5tuxEtCPHXH0vrqh0v7Yne/KRi7VTGAZJSc?=
 =?us-ascii?Q?69NuMV+y2UW7PYRbnPi1EelyzIznShY9gJaMISsIWROpZMAJ0Vq40TUs5H34?=
 =?us-ascii?Q?ySQ9syNhkffUbbK/qPXnEuvTxUCJK4UVtG+jS9FWQa+gno+ythZxofw3Nw/t?=
 =?us-ascii?Q?HKc2EE3fZsNi6/Kdb0MehSvLMcMYXhfzohW1TkwvJtzLCAwvJ6OWXHf4TUsg?=
 =?us-ascii?Q?lM0f8gD02nhKaVRnzkNMNpBrC+TZhkL9C8/fAsGK4gYatIkmLaxo2G19sFO9?=
 =?us-ascii?Q?aEemNAowFSX7uyn3Fl5B/7/2zPjDDCj+izk9ZoMtv1EARTfqxO/T+9y0W8BF?=
 =?us-ascii?Q?otiP81nd9Kqw9EG6HFQD0kKQXKvMn2Rk19erpypmAElYoz7dbPoUShTcQgdK?=
 =?us-ascii?Q?pjRkv1QawLwK7oWUBsqRxyUaX5L/N+eiTyivtT5P2qFGBQoNTw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR3P192MB0714.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?l79JmdCSLefYHq/8lMIyx+oB/2QfE/qHDKvxtL1F0x4R4FRlKSj9vzWhmw6L?=
 =?us-ascii?Q?N1bLBSB3YGCcd0J09FGKTOASG7lJ5AgmjP6+HqGW87vkeCWXznM1Q8arJ9K7?=
 =?us-ascii?Q?y6R1LaJ71IpFKbbLW3VvAwNiU7WMBuNGXnR9AG6R9CSryTbcpbrFCY+p2TuY?=
 =?us-ascii?Q?WRCa/UKqQtUAywEfZyCug9K5xBzjj7N0SLiToISwDoT1VhPAmqqhvXoNY7A2?=
 =?us-ascii?Q?fbUNCZPqhcevvJOIbmEinF60Bn+QLQqZ295nsa/32bYvqopPf6TjuzhtZYap?=
 =?us-ascii?Q?XggbTcuFpki4DWyLYVevJHGYwNgTHTgqBto4SrMMab/kUtqTaZ33JLRO/9cz?=
 =?us-ascii?Q?rpt+DGxrbMs0iPUs49puoowXcb+/gbhCMbVT1JD2P0Gaxc59t+fEwVBVYr1I?=
 =?us-ascii?Q?XQAO7aVnhUzYiinfIRYUPMajk2yBsXIto50cb3jkhbULd8jAtDpusBXujiT+?=
 =?us-ascii?Q?UzJtx9HwAOdSydj+9pgHqt4DMIr2LlipvZB1vRPwTNiAiReyKTQMK2DpCnQ1?=
 =?us-ascii?Q?CZzP1+lf+5dFOuMYrbWDabyDXBcdUv//ujYZ7aLT70yPV5rttrktYQyJ5MQJ?=
 =?us-ascii?Q?x6+nqVDY3T8XfJZM9eJqaahdCJYvZ4pIPlzL3A1vR1sKSHWk6spMGVyfnZOP?=
 =?us-ascii?Q?I+g8PcbnnywRu8Xyw4xTcUoGVH6iu0g2y4HPvGvVlFw4w2M3nhCxoNol60kG?=
 =?us-ascii?Q?G7bGP2V1tQ+vdZuTrk3+HoC8Vp+UwWDAD4E//498QbozzYbDkmjB4bWQcr1y?=
 =?us-ascii?Q?htbIfHU/+QWC546air+8rEnft7bs5HkJKYWc9TwC3oXEy5DBqULrK/I4gyd7?=
 =?us-ascii?Q?V91R3ZSrH9Pri+dtpnwY7kqebgDL4TJ6EYJgZ5LMnuwOWTBsATpMnMYZTwJ/?=
 =?us-ascii?Q?7GbcxcJYWbnnuVk5MSkpMQYc8NGcoa4KClCd3x1yKYCKi24esw2Z2LgWLnFi?=
 =?us-ascii?Q?KPgPQGwVaJjwgJN9rGuVwzY+Az79dZyCAVcpTewW9jk3VJmE5bqhrPB5MIek?=
 =?us-ascii?Q?44LH2uflPjJ90wNK1KJp7qaF+dLEsnVn7rKWnj6rrXFIl4w0oGoQMSaQQxpz?=
 =?us-ascii?Q?rEn0zWzt2U7aPH+EJNwUZDmqGJuwXr1iSwwoY+oqr/18uD113rKl9/viH7oT?=
 =?us-ascii?Q?T0b7GNngSc65g1NGZHiKsu12YNFyoFgAzBz5HBmw/khM1v3njwnkCOJitymJ?=
 =?us-ascii?Q?J/QoyJw38M7bIostp6y65/m2Gs0uL4IJ+3JHRbJC1iQeGmJWuLbrlSI8yARe?=
 =?us-ascii?Q?w/87exlIwvGO8/QoIez72a22XAAN0gneARz7QetT128gi1f31hodaE9Khzy2?=
 =?us-ascii?Q?YOlMs1MYk4LdaocsiQLn7xNh71o1r/VmOkL44OGbQgiTD/i0ifzi2/ft8TCs?=
 =?us-ascii?Q?TOr/AkOaD91xo9VKrGHB9hZEqzi8qgH1iyTTv3PZx+dc9VUexTm/H0QGkVq2?=
 =?us-ascii?Q?w8XC6GM5J5JZhraYqzkmlJeLupMFyDAU/UfjltpJ6wTa0uF8o+5EhTFOSgiW?=
 =?us-ascii?Q?n+AaLcg70NsWzPzPYbD2GiV5fDSRDk9h+vgktQgHyeoBIT8f9BFLvRJlyyIt?=
 =?us-ascii?Q?wK91OOxz7VBbvSX8PRkN0HGXhtcEi3+8npM4atBPRAKBxQZVapGXOC7o+aFA?=
 =?us-ascii?Q?Rg=3D=3D?=
X-OriginatorOrg: witekio.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e840d8c6-f75d-430a-7371-08dcc83dbfbc
X-MS-Exchange-CrossTenant-AuthSource: PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 15:17:51.5918
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 317e086a-301a-49af-9ea4-48a1c458b903
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BoJuRS+D0MJta4tXt/RZUB2lNDqtj+Kxl9LbphoEsBbc5MIOPIuwZI2BGDpcxF1miPI9eiKw3381Gr/UtsaTWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2P192MB2266

From: Miklos Szeredi <mszeredi@redhat.com>

commit 48bd024b8a40d73ad6b086de2615738da0c7004f upstream.

In preparation for more permission checking, override credentials for
directory operations on the underlying filesystems.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Signed-off-by: Hugo SIMELIERE <hsimeliere.opensource@witekio.com>
---
 fs/overlayfs/readdir.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
index 11b7941c5dbc..db9132a020de 100644
--- a/fs/overlayfs/readdir.c
+++ b/fs/overlayfs/readdir.c
@@ -735,8 +735,10 @@ static int ovl_iterate(struct file *file, struct dir_context *ctx)
 	struct ovl_dir_file *od = file->private_data;
 	struct dentry *dentry = file->f_path.dentry;
 	struct ovl_cache_entry *p;
+	const struct cred *old_cred;
 	int err;
 
+	old_cred = ovl_override_creds(dentry->d_sb);
 	if (!ctx->pos)
 		ovl_dir_reset(file);
 
@@ -750,17 +752,20 @@ static int ovl_iterate(struct file *file, struct dir_context *ctx)
 		    (ovl_same_sb(dentry->d_sb) &&
 		     (ovl_is_impure_dir(file) ||
 		      OVL_TYPE_MERGE(ovl_path_type(dentry->d_parent))))) {
-			return ovl_iterate_real(file, ctx);
+			err = ovl_iterate_real(file, ctx);
+		} else {
+			err = iterate_dir(od->realfile, ctx);
 		}
-		return iterate_dir(od->realfile, ctx);
+		goto out;
 	}
 
 	if (!od->cache) {
 		struct ovl_dir_cache *cache;
 
 		cache = ovl_cache_get(dentry);
+		err = PTR_ERR(cache);
 		if (IS_ERR(cache))
-			return PTR_ERR(cache);
+			goto out;
 
 		od->cache = cache;
 		ovl_seek_cursor(od, ctx->pos);
@@ -772,7 +777,7 @@ static int ovl_iterate(struct file *file, struct dir_context *ctx)
 			if (!p->ino) {
 				err = ovl_cache_update_ino(&file->f_path, p);
 				if (err)
-					return err;
+					goto out;
 			}
 			if (!dir_emit(ctx, p->name, p->len, p->ino, p->type))
 				break;
@@ -780,7 +785,10 @@ static int ovl_iterate(struct file *file, struct dir_context *ctx)
 		od->cursor = p->l_node.next;
 		ctx->pos++;
 	}
-	return 0;
+	err = 0;
+out:
+	revert_creds(old_cred);
+	return err;
 }
 
 static loff_t ovl_dir_llseek(struct file *file, loff_t offset, int origin)
-- 
2.43.0


