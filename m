Return-Path: <stable+bounces-71577-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 36FF5965CD6
	for <lists+stable@lfdr.de>; Fri, 30 Aug 2024 11:28:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BFA11C231E4
	for <lists+stable@lfdr.de>; Fri, 30 Aug 2024 09:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DCCB16F267;
	Fri, 30 Aug 2024 09:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=witekio.com header.i=@witekio.com header.b="F1loUUjG"
X-Original-To: stable@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2122.outbound.protection.outlook.com [40.107.105.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F23170849
	for <stable@vger.kernel.org>; Fri, 30 Aug 2024 09:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.122
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725010109; cv=fail; b=JKvHLxzDle4bZj28dEuYJ2M/hFzRlOCcHTiqMk+PoGqnnHUMGRVEivdNSHC6JFHt90Cz0ZXAvqRoIjN3CGGjRCPFWiZxyKyEBfDnmFf+6Ydqu3Ckj+pVrfO+Y2OGH7cRLSde0lXUfShOp4iXXuPxoXzJ9Q8hV9B9hZU9spconYM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725010109; c=relaxed/simple;
	bh=OUzyoWlfGp1f4BFS5+LjDNL0r4jvVf5prfdqjLehHwk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GX61HfYB9oPLXF6XHBok105ehShED073szwrS1aMgooXClML3PYJ8ylW9qBZwNxJgt7RDp7ObEqZ8Xtkn6gDzHve0QfWiiObFlRpNEJ2FrJDw56lVnuavEye0p6UjX31XmTKkxlO6wEOA2f9h532Uii/wTGBSHd6dIGm2d3AGMk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=witekio.com; spf=pass smtp.mailfrom=witekio.com; dkim=pass (2048-bit key) header.d=witekio.com header.i=@witekio.com header.b=F1loUUjG; arc=fail smtp.client-ip=40.107.105.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=witekio.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=witekio.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GnwOAk2TViDxhhs/OqJCmSWS3ecjRUX/k/q6LeIhM3aMOb/lWT1bpTzxrq5vtqi862LgrEvo+E9yWAe7jW2tXHy8MgdIat0H/moRDn1VpJ0YuQ9CuYL2XViN6ewbZn5i1EHT9b7678GmC02OQ3J0OQkS/BO4+i2Chiu7C93B74+PywEzd6dbnm2BSKTiN6uUlj4r4qAIVs2hZfpCfKoj4PsuS1OfecO3fYP0SCtqWRVR2jvqsDAWAQOGm17Nhqu8H1LKzzjYajbgdF8jmSCfkYerBv9g25VfT8sBzHne+knIuxyU48UUU9LdJAMmdQnEdrpi0c1s0FmMaLb4iklZPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VfJk3PAswYQKjCIKDiykdOXiBZ3h8w332bvRfjcI/vk=;
 b=TsCgwT2LgCJco1mvp/x5psaXqh+GXEf/YyTR30+jliJq7y1PUivETrfljo7vOPzTBZDcPsC7aFFrAWIuI2kyGSxUjGuavITbPBzOBnF4CkBQ95dPwOpoCoozhFmJI7BxztL8VS3WcpC3M6gdO/d35IDmbxiVN3KEO96/xYp/FS+oV/+VKSVmKXSYRGUwvN9ZaA6mebD+dr+UDh5rUx9o7U8uTvAZMyBNVt3BmNIidFXaNMpu4n2sxvPAdeTb+oSqAd91xf+db30wmZXkCa6vERsXuVW3Jsd6ClZB6/hQzHV/OIBhOzscKbIzCbbvWPKWq/Ob6KGam1YjOOoC3Vgi9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=witekio.com; dmarc=pass action=none header.from=witekio.com;
 dkim=pass header.d=witekio.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=witekio.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VfJk3PAswYQKjCIKDiykdOXiBZ3h8w332bvRfjcI/vk=;
 b=F1loUUjGDS2/6duBaxHneE1MCtLC22GtwQnzwhnxdlYMryJHMoP3ie2Uf7N5hjVbl8OVVOWbv8WM0FxdMh/s6y6A7Mlum5OHLRSiiPHkOm4j6JcNR2QIEt1zJIrJ8dfFt0cJBYXQ71EMldJQhZlyGu+/xhitcTkslp/wz3HQwwpf6YSuf/eWdd3sJHfo6O1QfVKfPvFkOLeUNGCBlsoiQzFcv0Dxmui8MQ/bmB++zWRSiv2Qh9DRp8ywFX7jZaxSEO8em7P1p0uCehF+SH5WQ7KIaLDyXaHwWpHzly7ZxlNBdECq+INukWgCIO4PzEd5+Jrpkn4/VeFd/3G50jMMLw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=witekio.com;
Received: from PR3P192MB0714.EURP192.PROD.OUTLOOK.COM (2603:10a6:102:48::10)
 by DB9P192MB1539.EURP192.PROD.OUTLOOK.COM (2603:10a6:10:33b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Fri, 30 Aug
 2024 09:28:22 +0000
Received: from PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
 ([fe80::345f:a9e9:d884:3091]) by PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
 ([fe80::345f:a9e9:d884:3091%5]) with mapi id 15.20.7918.019; Fri, 30 Aug 2024
 09:28:22 +0000
From: hsimeliere.opensource@witekio.com
To: stable@vger.kernel.org
Cc: Miklos Szeredi <mszeredi@redhat.com>,
	Hugo SIMELIERE <hsimeliere.opensource@witekio.com>
Subject: [PATCH 5.10 1/1] ovl: do not fail because of O_NOATIME
Date: Fri, 30 Aug 2024 11:27:45 +0200
Message-ID: <20240830092806.28880-2-hsimeliere.opensource@witekio.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240830092806.28880-1-hsimeliere.opensource@witekio.com>
References: <20240830092806.28880-1-hsimeliere.opensource@witekio.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PR3P192CA0015.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:102:56::20) To PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:102:48::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PR3P192MB0714:EE_|DB9P192MB1539:EE_
X-MS-Office365-Filtering-Correlation-Id: bf96d68e-1689-42d9-473d-08dcc8d6175c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Kzvc4lCr+sAen79/jiv6PHax+2TJQ+5CbC66nI4t7nNWnB60PDmiqNAlSsJG?=
 =?us-ascii?Q?Jz1XtSqQAAlZwk6cokMBYsfK+pib6g/AwUuEEX5/HEUf3W0CprHANsSSfqsi?=
 =?us-ascii?Q?i2LkW6QnuVOegjRWt8D2Os4Tnb7UH96wgNMYCF254+fb7IMsFXppIeCz9Wfp?=
 =?us-ascii?Q?zRAZmsFwZSrbn7y9feI4M5bw97vVM207Ks4S+EHPIS0Jbx4l3ljDCKOWFubG?=
 =?us-ascii?Q?uRA7835sw3wxgkVThepTrAaq5Qza61YnXxZhdt2QEHm+o9T8ydUh1un6Kugn?=
 =?us-ascii?Q?K288IWf4P1bAygbs2ZnnRkk/VJQ6tR6bYgBpLyeKW6dMPxDEe9Kyt946zw5c?=
 =?us-ascii?Q?tXjix92nEJUTXUa3LGX+jRV31TZY9DrcnztCE32c1AovFtXjtPLPdH1janbt?=
 =?us-ascii?Q?icFsaWf1uW5+674/PLwlWtdPPyg9V0rR4cqYqfLVP/LuNzvh4aLoYEzyQ1LG?=
 =?us-ascii?Q?GRR95EdlPJP1d7Q18PF3cBzs5ITMTrqFSsfZ0VRuuKY8JeR97NtUUqAJDhK/?=
 =?us-ascii?Q?nC1ZcUnvCH0F+GTRlBm831Dk38YqokpxD5Rfy3I7B9dRXGEXia+rap0vxPgr?=
 =?us-ascii?Q?4nHdjDcdg6qk0xYuhSR1K4bi9NaUWrW5ncGTRbOkN6zDLCqC0DaeP6msPuP7?=
 =?us-ascii?Q?w4DUnhgtXEtxY0MRYjsAk0uZl2i5QKfV8VbcWLzpV1Lc2xrytPFuCe6vYP4y?=
 =?us-ascii?Q?VtlVW6tndKGcI9g0EEqhlMXp6vJIDJ/5jyQMkFh3Imzmy9cbGdfSnmSJYoci?=
 =?us-ascii?Q?0KfnY92uc2vMR8IEGndyqOFNlnYB3HHzKhZY1OMZKWEG0PjFrXXpYFrgPDsh?=
 =?us-ascii?Q?miAD5x/EPD9hpLipIX/kVxhPXsbYZveY5jc2+XlUkbkDOMjYvFaFEBKDx57u?=
 =?us-ascii?Q?IOpDtDw2y+9DNjNaWxb0XLE0R2sX+V3q8WFN9BLgDhFMO4xiDIGPqUkOoNwf?=
 =?us-ascii?Q?fkcXYHq4WK+somG0mLd5j3wfhCfmKyf6ja0RoAOXRtPCtVIOPRnl4Hk6rcOI?=
 =?us-ascii?Q?mneHYOU7nKi7s2GRPZRZlDOjj9U9Gpyp5UO2lIgk3c6bhdIklTbV8smjV6Pr?=
 =?us-ascii?Q?cXsnbwO9JHjTuzTZEvmf649+TTiIsE37DxgbExu7fExHRhIyaJ+TvwefG5pM?=
 =?us-ascii?Q?1jkljak0aEcD4YUGeTAc4yavK0jtYIbBtXlk3fmDqqK/ssF+YQcKo+OxqFc6?=
 =?us-ascii?Q?QeCdod4CEmfIl3B2WSUOHxQ+zLFxWPo8TBpiB7LA9TivdIghqbLnWOX2Se8f?=
 =?us-ascii?Q?3KBwwUt/UfFR33UkWkeCnDy5deICQMlzqJs+OfV4ymUZQDW4pk3VpaHrWC54?=
 =?us-ascii?Q?bxOoJFosGh8w9ISdShfym15/wzdo0F36JGSSJyQhx8OHOkKdqUSuO2ADNpvI?=
 =?us-ascii?Q?gY2AnWSzppLxIVWwBxJ5HpL1PGxCAfV1M18C6i/xlMJ340aD9Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR3P192MB0714.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9qEpo3E7P8Mmd6VKyuxSIWjka/JF29ovm7LUEvJXsCQfkrv7CyJIOX674fdX?=
 =?us-ascii?Q?HK3UXR+gtUJw5yUxM7uXyPjibvFfe/tuiYWQgu6ptIW2Cd2MEEzhj078WE7B?=
 =?us-ascii?Q?nrMQDAh9wilx74tYSnNgbFhGM/hxUT4Kavcy1t2Ptbpig/oB3rydVHT1Og8v?=
 =?us-ascii?Q?jtlUQ7ZdhQyFp/Qf6p7VBrbmmAbykYM4OZLnUJgNsejp2JFHykHUW8jeE3vw?=
 =?us-ascii?Q?a3LDuOYmI7Qq1xTUex1lZsWTUABbk7AXsEZFl9odxy+Hgy5IRRMqJ+KHPLjz?=
 =?us-ascii?Q?NFU7IyQ4wUpDGYgJqyPDn0j0ITh6PRbJlIOQWIrDQVt3WX4cCjU2UK8+3W9a?=
 =?us-ascii?Q?GlDqC6dgK3Wx957sH1SgAJWpQgLjWTcsJJRy4/kLydoX29XXSUAmZ7KpHUZ9?=
 =?us-ascii?Q?CojCgyNTu4MVSk1GlQzAzpzYTW6jXpVy9vv6P20ichEfqlNUsFARe43rlJ8+?=
 =?us-ascii?Q?qsI66QBguMeLSrobtrDFTbuwljTPrGuXlwfdxVm1Z9eys056980hVxlON4kw?=
 =?us-ascii?Q?S+TXO3Id3RPCU0NxlMi0MBxfORF50ZxRu8e0ZE4Pozbz3OX+mOPqHQuYHbvR?=
 =?us-ascii?Q?Vff3K7n8PAlAQ6OUpR5DlEySok7fUmGZFJIXZsQT4EsLPFa2HSxVX2e+a3m/?=
 =?us-ascii?Q?9MHGS3LzW0lj1LPicvzxM9dJAospa9VJdfh6hznT/x75fXxdROWYXM1R4xZw?=
 =?us-ascii?Q?y04b7VcDAqVOI8FQLGxRdF9/3TVfJH+rJeskDtadL7bataTTNnqTVnyy7Aoh?=
 =?us-ascii?Q?T/Qmw0xFthHSle/ezXIuaDaIIPiBKR0rqMLY236wrliOVmjynBpFj2W/oMeu?=
 =?us-ascii?Q?xk1FJnnuHfYgQIdVZj6qlvxh2P+FX+O0B4ro562T3PTcbFeOBmFa6pCq/O0j?=
 =?us-ascii?Q?SeaJ6Wy8RTiIIsRkDMoGywJC6Xx3jzFPL/GwY6xdcURR4xaksCaBdoitmwEq?=
 =?us-ascii?Q?Hy4R4j2p1rfcgT/PESnCjSlqKWxZfn83pMtJ3oQEhZIbe5H+k/J9KIQ3eT0s?=
 =?us-ascii?Q?XSZ3i4Kcc6jT8CJAAK8iCwajcHwEDZ/Mx7WqCe8sqKRuMNzBJ5v6qwsVhach?=
 =?us-ascii?Q?XJl+Uy/pTjnvh0nB7Ck2+7zN/VzpmhUZe6P2Zc5uitke+1FHyU16aBkuPSHN?=
 =?us-ascii?Q?JbC+Y43t5ygJC+XGlZjwjSpbBuJzArf0ik9vq3yILE3chELP4ZCQU7lv5PcI?=
 =?us-ascii?Q?zWVtV2pNEgQJ5qCVYWURp4UO21cwQel2MLz+PhT2Qq2fYzejcPuj0xKxJLoz?=
 =?us-ascii?Q?tLXqFcSPBncFF6iC51lZeKKwYxQ/5Va1BaY814Ldqk+TUVpjS2gsKbfLL9ko?=
 =?us-ascii?Q?0zCl+Ep9TXe8Gk9JBIJKTpRuiNPJa8wS73RDKzbGke/CWvAH3MkHuW99Yd4x?=
 =?us-ascii?Q?oO/c1JsVunvN0g5Tl9eL42bwyMj1c3PqqMSTTJv84YAZVfd5obTWgwZdzVAY?=
 =?us-ascii?Q?cO0/HtwsTh+oHdAUcrx22SIaYyIqRUKOYZC0KJ4XV1TV8X2i71i7Z4HHWfYM?=
 =?us-ascii?Q?6IBJ3Qw7SPSHrmxSxbQWmyCej3G4gKcmu1Hjurka0wz9uG5vgVnKQ/e+QC9H?=
 =?us-ascii?Q?HukqRjzeFRtmpJD+BDz/6d5RD1mjNwiKZmL0FyGUGIl+J+fRCcetaTc5Jgog?=
 =?us-ascii?Q?OA=3D=3D?=
X-OriginatorOrg: witekio.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf96d68e-1689-42d9-473d-08dcc8d6175c
X-MS-Exchange-CrossTenant-AuthSource: PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2024 09:28:22.2526
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 317e086a-301a-49af-9ea4-48a1c458b903
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7ZszzYW3xWW6xKRC7vqg9WPIAnUG+KmsXj4KqKCIG+PmLIjMOc5Foeomvm7suEzZSnEHTHv78s6Bz1aJpC1F5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9P192MB1539

From: Miklos Szeredi <mszeredi@redhat.com>

commit b6650dab404c701d7fe08a108b746542a934da84 upstream.

In case the file cannot be opened with O_NOATIME because of lack of
capabilities, then clear O_NOATIME instead of failing.

Remove WARN_ON(), since it would now trigger if O_NOATIME was cleared.
Noticed by Amir Goldstein.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Signed-off-by: Hugo SIMELIERE <hsimeliere.opensource@witekio.com>
---
 fs/overlayfs/file.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
index 244e4258ce16..4440ff43cb66 100644
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -53,9 +53,10 @@ static struct file *ovl_open_realfile(const struct file *file,
 	err = inode_permission(realinode, MAY_OPEN | acc_mode);
 	if (err) {
 		realfile = ERR_PTR(err);
-	} else if (!inode_owner_or_capable(realinode)) {
-		realfile = ERR_PTR(-EPERM);
 	} else {
+		if (!inode_owner_or_capable(realinode))
+			flags &= ~O_NOATIME;
+
 		realfile = open_with_fake_path(&file->f_path, flags, realinode,
 					       current_cred());
 	}
@@ -75,12 +76,6 @@ static int ovl_change_flags(struct file *file, unsigned int flags)
 	struct inode *inode = file_inode(file);
 	int err;
 
-	flags |= OVL_OPEN_FLAGS;
-
-	/* If some flag changed that cannot be changed then something's amiss */
-	if (WARN_ON((file->f_flags ^ flags) & ~OVL_SETFL_MASK))
-		return -EIO;
-
 	flags &= OVL_SETFL_MASK;
 
 	if (((flags ^ file->f_flags) & O_APPEND) && IS_APPEND(inode))
-- 
2.43.0


