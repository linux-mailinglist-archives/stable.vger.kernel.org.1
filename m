Return-Path: <stable+bounces-71535-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 519F5964BAD
	for <lists+stable@lfdr.de>; Thu, 29 Aug 2024 18:27:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C703E1F22066
	for <lists+stable@lfdr.de>; Thu, 29 Aug 2024 16:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFDD21B5308;
	Thu, 29 Aug 2024 16:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=witekio.com header.i=@witekio.com header.b="smHBOXbO"
X-Original-To: stable@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2102.outbound.protection.outlook.com [40.107.105.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209541B5310
	for <stable@vger.kernel.org>; Thu, 29 Aug 2024 16:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724948806; cv=fail; b=lesA/nDVv0RjFlAnAiyq8qVX080RPZcwBtEvabFRMpyU+kx7/gvlGrAlA/3m1FUC7HdODAWAaJlO9gaOnpqkXfGwj14Ygp5Lf/WBhciSNtDaE8CSVbf0EQ9DiGkqrFeXnQWu6OAK8J1j+D8W+u4LXdFEchmwRMqmRHIeOJ7t/JI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724948806; c=relaxed/simple;
	bh=ciuwxxM+evgt0qgBpi9sRr8LFq4B8gpOeJ54xvNkSnQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tUl70B91y660t23KxdA2QZ5ZrU+yDCf4yNiy7PsZ7GZiWpRh2MWkbiwdb7shNgaGejTmt2A3vsmESLl3rC3tvmRp3+I3HeRyAMIceSCLee1Uw1avBXbOVpdjCcL22eytGAiHrquLgLSA6BsS/EsTETiIwykfZcpzUgQtgMsF2D0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=witekio.com; spf=pass smtp.mailfrom=witekio.com; dkim=pass (2048-bit key) header.d=witekio.com header.i=@witekio.com header.b=smHBOXbO; arc=fail smtp.client-ip=40.107.105.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=witekio.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=witekio.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wLbjp3KejDqmudpn2Y+MhuuVzIjJBwct8IZrc1s2rV2r/HAtyFj38+EZ/qHGf6Bid/8kfFEGM/nQ5kQaDrK/0e40oCzm7y3BMWuOcHjJJ80C4wRKsjb+9KJujG+6iDCHmy2aRLhy1XpFdzM95kwqmDo6u1jBT7EOlddjPbKf1LUIJx28OmaRJimKSPLj8bAeL2zg/e9xWUHTQdO7nWOCBwa3bggNAbM5ssMN/Jn2+0nnBhwDxtjxg/HbVVUT/RcUyrrcNGR3hHtVpAtMOgAgw4dNxhIFiSRwHuT7o9opYcnTydn6Iue7PUZBSMniuV2lOSGCt6hW7UANOcFgamrmXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C5cqMBGsSHBXj8gv9KWGYlnUCrT2nPVlihsaDa3HgyE=;
 b=jM5fgu4llUay0/8mFMyocRGveE5VpmLez7fEBpbC3/7X7ARImv4/q4mCIp8NsiTSjKQQzbMs/18chlKlQ9A5UtHuEoH/cCa4SulczY3Zgl/rAlp5GVaeactCsZw/io3YZoLT+IBQ5VMh/yJA511UERPFRanC0v7VJ3VXenLzzfTskiJJNwcg+1gom7R0+f8OlfJ1Vg8m8++Fa39U7hns89jGzHzr5CZgGc8wPb6VqlhLgUayZ8JrltEIFAsSUTZrnwnWLqGTUlvkTnR70ectj9S/wsq/LtBlvwkQ3E0Db6N6eycNgmJyr7vJXcZxRIjE5So4wMpNNyZqnX38ffR4mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=witekio.com; dmarc=pass action=none header.from=witekio.com;
 dkim=pass header.d=witekio.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=witekio.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C5cqMBGsSHBXj8gv9KWGYlnUCrT2nPVlihsaDa3HgyE=;
 b=smHBOXbOd0apVNsJ1po78D9GxnIKp2e3guiQKRwme5+FoLjXPwCOxSV6EWZibuVy9hTmsscVcHjLK63LxXc3zz5nCioJqoKqLJgIEoM1liXx1nAJi9jU9eLSHgagQxrZ9TZ26Xg93NmV2VSZrz2TacHw9MkkPLwlY102d/wFcaJueGr9mZjpyFqEnJvhbtHV1gzAz05qBsDzFbPHHRAYzNYpfciheWrqme8pAOiQTBXQ8qMpqMxoA4PA95qoqBF0RnHSPo4CPTKpTj2XNIvRa0y6dVLNV10waJOAR4HB/q3fThT1VujZA43XtEyB5c2Hx1yGiPgWnAou7JMhmgzktQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=witekio.com;
Received: from PR3P192MB0714.EURP192.PROD.OUTLOOK.COM (2603:10a6:102:48::10)
 by DU2P192MB2159.EURP192.PROD.OUTLOOK.COM (2603:10a6:10:495::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.27; Thu, 29 Aug
 2024 16:26:39 +0000
Received: from PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
 ([fe80::345f:a9e9:d884:3091]) by PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
 ([fe80::345f:a9e9:d884:3091%5]) with mapi id 15.20.7918.019; Thu, 29 Aug 2024
 16:26:39 +0000
From: hsimeliere.opensource@witekio.com
To: stable@vger.kernel.org
Cc: Miklos Szeredi <mszeredi@redhat.com>,
	James Morris <jamorris@linux.microsoft.com>,
	Hugo SIMELIERE <hsimeliere.opensource@witekio.com>
Subject: [PATCH 4.19 1/1] vfs: move cap_convert_nscap() call into vfs_setxattr()
Date: Thu, 29 Aug 2024 18:26:21 +0200
Message-ID: <20240829162631.19391-2-hsimeliere.opensource@witekio.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240829162631.19391-1-hsimeliere.opensource@witekio.com>
References: <20240829162631.19391-1-hsimeliere.opensource@witekio.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PA7P264CA0091.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:348::10) To PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:102:48::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PR3P192MB0714:EE_|DU2P192MB2159:EE_
X-MS-Office365-Filtering-Correlation-Id: cb8958b1-a3da-486a-6a0d-08dcc8475c2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hYZFj0VnQbcDK6kSciw6yckmAUzid+PJV6nTQ9zOpeTVzQapCYyxE7zjrz3s?=
 =?us-ascii?Q?VWRIrYIBLb0VKKG/rp4QlrcbrOM70x1hn/NDCVl1qOGDtAruB+Hl3RiEF249?=
 =?us-ascii?Q?ILmneRVanm+ggMt/WQOGJzTFz8u09tzQijO1d4KB9vtG6k6sWx0rTouHXCWa?=
 =?us-ascii?Q?2cJCooOW0sokifFjs1wdwHzLqeCdx2FUUn1+XG/NCYwQFSZ9ArSwX+H1xJb/?=
 =?us-ascii?Q?96RwfBxODvzhVKfHEmYD6pgjnonvjdB20KTuoT8vkOGHtkOw+g7edPd9pAj/?=
 =?us-ascii?Q?LA8VYJJgX4dC/xllbZp7cn5fQOpTroC88oUApMrMa+9sNFP74D5DPIt7Legu?=
 =?us-ascii?Q?P2NQHqmTFWovn0lh2/5K2RdxR1IE8sdpruQgKA2/F7ssixb2B5hnXPosnxel?=
 =?us-ascii?Q?96ahIRhp7cvw0kPkHhxmXHtzEZJ37Kokco8LU/ToHGUweRLSMX3EHu+cuxMS?=
 =?us-ascii?Q?ZwmwwqtMLmzKeaTBc+pWjmXm4eBUdWqRhUIuq4YT7tDQQGyCnD7XWdkbVHh8?=
 =?us-ascii?Q?MJv+ymopoXebIzgQJzmgyVWKUtHT/gYHoxWx4/G525W85oulvLZh+2ELD9Ow?=
 =?us-ascii?Q?XU+izvuBSoTnrPoKY2J2exgXUfk9+G89W42Yvo+ghAXGoMY/ySh16IZl8RD1?=
 =?us-ascii?Q?36CGfunMQ+9S38l3UwPjpJNtdAdFfVbL39/BVsIeO4JjyOrZVq6Kivl0IMAC?=
 =?us-ascii?Q?+0CPhdQrKeZeNSHKCxLcvA+Ws0zAANwL/pAZf4rLil7K4pvHVLQgiTIGnI4z?=
 =?us-ascii?Q?jhiFK+K7hbKHkw5EzYrrAGMCq+/YpaOD9brEJV5onqY0NMuULxSnlDP73ekw?=
 =?us-ascii?Q?6DUoBJG6dmNGx22ZuQOgkAorEeBqv2TcTZZMAbKdEJtHSsb6SwoTvqfdYYBu?=
 =?us-ascii?Q?oKgm3T86V0V/7M2Um3TRe+f7VsesIZDm2baXrDXbzccJ2UQj4SLnGdqK5XhB?=
 =?us-ascii?Q?/i2DCEplcgvCUPplqPY7frFTful52lawHnlZYOhrkGGRuzLvZ+YLzB7BgPHT?=
 =?us-ascii?Q?LOdI0+33ZgQYBIq31HoSavUu4+mbVxcb0aJGo0aMzfW3pyL3up5At67syUKD?=
 =?us-ascii?Q?ENXifQOhhco6sGB7JsoKcKzbvNtfcQBtc8na/SzMVEtkkLjO/WVUtnWl3FVf?=
 =?us-ascii?Q?L2w6pVWEVinYepuE6uaX2tX3vIIXftSXhSqLUaXd1vurx47cMEfz9AYVT+t+?=
 =?us-ascii?Q?DLYt5rkfo3o6ZlZ/TjvpWyssZ5DraHKmT+bnnclGH3ehud4bN8JI1nxu5xTn?=
 =?us-ascii?Q?wYIqNm1pwVKhXEc5rog0mxOz8l4Tjbw5ljxiFuJQKogPS/JoySp0KQUAco1U?=
 =?us-ascii?Q?PQ6+u77iHFwiMwTTw0N4c44AYAB0loTe2wg4u0KeQgfA7j3uIDVGCSzn26vB?=
 =?us-ascii?Q?hqpu2cHHzvOU9ujCsmnBCmShVNYIeBbPmknxfRQxWHS250Qe6A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR3P192MB0714.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AGkncHn+icVzHn7mK13VThv5mtjeQUW4WMAwVuzz5qHhe381yYuSEFrONSSV?=
 =?us-ascii?Q?q5qolO6Cr/hUtcfHYol/YimWH0Un92ptfWZMjab+wCtfmmtekscB/ayyg17C?=
 =?us-ascii?Q?ffQ7gGGaeS3DFlZE4nOyrIINsiE7BQya+zOqQoXFUU50/R1Lyt/3bWCKejaX?=
 =?us-ascii?Q?NXvaph1+fNZjpfeXcC3+Vor9zi5dHdJxaxXYRmMOhXDLGtbL4pJL4Y62C99Y?=
 =?us-ascii?Q?slUXdbwlEaJ8W9LLpvByPEgteXMXzz2NBC56ukFIBGIrRQt66b8DthBsKi0k?=
 =?us-ascii?Q?MKIJBlVF7o2gZtqE52T4vXxNpJOASb42qLaQiJ1SMAqG1tDLOo4WOf2IfLsH?=
 =?us-ascii?Q?tDaoo1nE6cUN9NoSwiLADU1sz/l44N9W8Kx3NYTSOmxR0diieyZtmRUy/yO7?=
 =?us-ascii?Q?oIzjeutZsSeizIA9YZkS+6x9/9+6fGf1mNycVndfPGg2vmfJl2FySQ8puLt/?=
 =?us-ascii?Q?EdL5prUJNEDHwNWH1XyyMsK+dXU1RZBoHcBnic+SfboJ9RsqGPrqZN0hrNLc?=
 =?us-ascii?Q?X+g9EpbAZ39GasnyMU/32SW+tQgOYjJ9clgP9Pg1VtLid2TBR5asOpORmRMT?=
 =?us-ascii?Q?2cWygN2bMKjyY7tvtOUZCTWwUG3vKY4I8du0QF2psvZBymUuBPjXsDn44ly6?=
 =?us-ascii?Q?tnulVt7f8K79LjotlOK6o4txfUVjmoDl2y2Y6/ABni0x8fg23qK97PKfndCq?=
 =?us-ascii?Q?y707dw3BjiFVV6T0A97uMKwnkwxcqdLPQNNo2ncwplyLrAnAsgeLeYlxXpVV?=
 =?us-ascii?Q?zQBgn6TqnbgjP6WY1DRRX4QBL6H71ODg8DHTXVEtUXoThumARqICxbL88hKh?=
 =?us-ascii?Q?wxA8ZRIzztuy4bDy8lLJrme+1FZvVgz4A7RVXdGqovodwCmmJ3q8th4n4rps?=
 =?us-ascii?Q?eivGjo7LBqDaU50oGcwMc8GZmkYy593ps2c4nOMAuxSSlKho2ISGYBDC2doK?=
 =?us-ascii?Q?smUhAaIlxwr6fjCbgoPnnk8pxby0J0NgQGCqGJurQgupvBaghKs45g2bNTHu?=
 =?us-ascii?Q?8ifYdL60gpeuu11rr/br5uSDoyIy9Jz4eapHQVfvtlrt6peve/+W+8omdWiV?=
 =?us-ascii?Q?vjXwnAlHONxWJXMqc+9RDU5CJgn0BwOboYWgjVksmxZLNZ9J0pwLpBFm2thJ?=
 =?us-ascii?Q?3NldTr8shBcSOa9tnn5bNiPoUhkDDXqr7C7tPE/6zDCsrKPRqbTB0ZqJDB18?=
 =?us-ascii?Q?rNEjic6Yi9fVjGUOfZa8XLvXPI3iPt4U89BHxTzwhGHPS2P3rxsgY+7ar3bP?=
 =?us-ascii?Q?Ek7/VbQcT6R1Z6pluK8maztEhdoPprudCOgJ3i5dv1E3dZYWNLYMFl7KWzME?=
 =?us-ascii?Q?8sObKCuu1OfSaQ3Jaw2Yk4UEirNlQt3vGtW17VGjQlpSGWNLcYwXjHuXFb1E?=
 =?us-ascii?Q?QGz4ZeUoXspnFp6N/g80lExJ2X18mBz0kCL3ohaOPm2DMfGS5rI0zLKS0wWX?=
 =?us-ascii?Q?cubqKQlLpmO17o8HBTOqNb01ThTeDjQzoWYRSxMKvm9VDtSb4gEOjK8HSgk4?=
 =?us-ascii?Q?j1zibUilMDzW8bqbMfw2EZttphaTVQW/VgmXIEfYZnBeyy8Y5uwI/Z8i3Wnr?=
 =?us-ascii?Q?bGBa0sCNhTD8G5foE+LmzEYOANj/b17/a8v3vJH8Wc6Kfcb9qCrQQ4L7DR1L?=
 =?us-ascii?Q?Dg=3D=3D?=
X-OriginatorOrg: witekio.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb8958b1-a3da-486a-6a0d-08dcc8475c2b
X-MS-Exchange-CrossTenant-AuthSource: PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 16:26:39.5379
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 317e086a-301a-49af-9ea4-48a1c458b903
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JrPTEAmJ3ZPr0D2x2cVvlsstbMaOlNBfuB8q4IG8NqpddEgm3AoSqFtewDQlpdlokbmrvsQJjgTozPPylJlZDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2P192MB2159

From: Miklos Szeredi <mszeredi@redhat.com>

commit 7c03e2cda4a584cadc398e8f6641ca9988a39d52 upstream.

cap_convert_nscap() does permission checking as well as conversion of the
xattr value conditionally based on fs's user-ns.

This is needed by overlayfs and probably other layered fs (ecryptfs) and is
what vfs_foo() is supposed to do anyway.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Acked-by: James Morris <jamorris@linux.microsoft.com>
Signed-off-by: Hugo SIMELIERE <hsimeliere.opensource@witekio.com>
---
 fs/xattr.c                 | 17 +++++++++++------
 include/linux/capability.h |  2 +-
 security/commoncap.c       |  3 +--
 3 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/fs/xattr.c b/fs/xattr.c
index 5c3407e18e15..aa66b4efef6b 100644
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -248,8 +248,16 @@ vfs_setxattr(struct dentry *dentry, const char *name, const void *value,
 {
 	struct inode *inode = dentry->d_inode;
 	struct inode *delegated_inode = NULL;
+	const void  *orig_value = value;
 	int error;
 
+	if (size && strcmp(name, XATTR_NAME_CAPS) == 0) {
+		error = cap_convert_nscap(dentry, &value, size);
+		if (error < 0)
+			return error;
+		size = error;
+	}
+
 retry_deleg:
 	inode_lock(inode);
 	error = __vfs_setxattr_locked(dentry, name, value, size, flags,
@@ -261,6 +269,9 @@ vfs_setxattr(struct dentry *dentry, const char *name, const void *value,
 		if (!error)
 			goto retry_deleg;
 	}
+	if (value != orig_value)
+		kfree(value);
+
 	return error;
 }
 EXPORT_SYMBOL_GPL(vfs_setxattr);
@@ -509,12 +520,6 @@ setxattr(struct dentry *d, const char __user *name, const void __user *value,
 		if ((strcmp(kname, XATTR_NAME_POSIX_ACL_ACCESS) == 0) ||
 		    (strcmp(kname, XATTR_NAME_POSIX_ACL_DEFAULT) == 0))
 			posix_acl_fix_xattr_from_user(kvalue, size);
-		else if (strcmp(kname, XATTR_NAME_CAPS) == 0) {
-			error = cap_convert_nscap(d, &kvalue, size);
-			if (error < 0)
-				goto out;
-			size = error;
-		}
 	}
 
 	error = vfs_setxattr(d, kname, kvalue, size, flags);
diff --git a/include/linux/capability.h b/include/linux/capability.h
index f640dcbc880c..9fee9a86505c 100644
--- a/include/linux/capability.h
+++ b/include/linux/capability.h
@@ -249,6 +249,6 @@ extern bool ptracer_capable(struct task_struct *tsk, struct user_namespace *ns);
 /* audit system wants to get cap info from files as well */
 extern int get_vfs_caps_from_disk(const struct dentry *dentry, struct cpu_vfs_cap_data *cpu_caps);
 
-extern int cap_convert_nscap(struct dentry *dentry, void **ivalue, size_t size);
+extern int cap_convert_nscap(struct dentry *dentry, const void **ivalue, size_t size);
 
 #endif /* !_LINUX_CAPABILITY_H */
diff --git a/security/commoncap.c b/security/commoncap.c
index 28b204eacc7a..0e9f543d05f5 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -500,7 +500,7 @@ static bool validheader(size_t size, const struct vfs_cap_data *cap)
  *
  * If all is ok, we return the new size, on error return < 0.
  */
-int cap_convert_nscap(struct dentry *dentry, void **ivalue, size_t size)
+int cap_convert_nscap(struct dentry *dentry, const void **ivalue, size_t size)
 {
 	struct vfs_ns_cap_data *nscap;
 	uid_t nsrootid;
@@ -543,7 +543,6 @@ int cap_convert_nscap(struct dentry *dentry, void **ivalue, size_t size)
 	nscap->magic_etc = cpu_to_le32(nsmagic);
 	memcpy(&nscap->data, &cap->data, sizeof(__le32) * 2 * VFS_CAP_U32);
 
-	kvfree(*ivalue);
 	*ivalue = nscap;
 	return newsize;
 }
-- 
2.43.0


