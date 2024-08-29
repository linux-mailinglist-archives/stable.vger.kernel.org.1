Return-Path: <stable+bounces-71512-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A49FB9649B5
	for <lists+stable@lfdr.de>; Thu, 29 Aug 2024 17:18:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8DCA1C2281E
	for <lists+stable@lfdr.de>; Thu, 29 Aug 2024 15:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BD141B14FA;
	Thu, 29 Aug 2024 15:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=witekio.com header.i=@witekio.com header.b="fL1ekM6l"
X-Original-To: stable@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2135.outbound.protection.outlook.com [40.107.20.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE11B18CC07
	for <stable@vger.kernel.org>; Thu, 29 Aug 2024 15:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.135
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724944677; cv=fail; b=OmQ1wpUWc1+t+oLldmdFBq+75ShR9EgXyhK+iVCvR8cQgWXktwiVhgytiTgpyK5azKspaOtbfGlRqXNR2dxj14rVWsZLris7/p2QnNjQxqkk0TQ0rwM76xSpey4TYhWsacYR/QnnnFS3jRVKRPgA6eXdIT9DMRbsia3lPK+1P+Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724944677; c=relaxed/simple;
	bh=T3TdYsZ9efryYKjbFv4YU5aIFKjhXRxjppRFqObZ84k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XaU7U27BNW2g5Qylxb0qqiDgqaklXaHDIeTcumUKVndpDNNXhgVs4b4EQmRk6hfUD/5+9TH/BjvXdEp0wwb1o4yC247usGd/4qZPTB9XLawYQ5nBGWzrHpVKLnJWaYa1IVgQrQQKXD145nBts22rpUk4aes0FUCDjEUHWYFj6qs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=witekio.com; spf=pass smtp.mailfrom=witekio.com; dkim=pass (2048-bit key) header.d=witekio.com header.i=@witekio.com header.b=fL1ekM6l; arc=fail smtp.client-ip=40.107.20.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=witekio.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=witekio.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GIJDXkn8Bf8Aio/puqZ5f7G2j7VlvWc2JPb3zo9djcJbBzTl8h2kVqqI2HhZ/DH5sUY8fJR4RgSngCbMfqLr8EUeHf25xJZbtIhizLFKBTjmpHrWN8yDThvG0lhU8ZbfdclNyHMEhiXnR7jAJEzFNj3Qllwscin8C/mHk1F0YnsZekovvGp6xiIkNSKdGnBVBrphPLAzX+odSyJ3y6dGgAsb8Fm3eb7+z7WCjmaBOZdtTwvnV6h0zp7WEi1uzxZpzmb+3SyDBIx0iEWgbam+WtN/Ajs4F0rfmPQI4p73iuZtBwHb34pf43WPnD4Tig0MiuLoXFQK03Of3TJurdHVcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nNwhhbc8mwg56+apTG6YPfavbTtdqGiofmG/B8i9Rx0=;
 b=G7S2MMLFuf9txOWh8V8YJdAdgDvazO9uRgMsjZeyoyNOQ1UoQEEAr0ZvqWaxlERDzU6XY/bLJs/KQcFlpxOSkqZuMJb1YggsJbveVHOeEmp+WL4X3j50Fh0K09LHHa2SJdlyoEPOWZ6heKqMPmeMvAckvlPQDymfgcK9IPkMiqBxzsNHl/2MMoqJ9BNwZMvHWD4qqQnuToJDm1MrsS44aXLa6LoiflC0ryQxlehJjitkrqbvixIb4X4YDVzr6ofsgZwkn05yJRwfYx8+4R5WszKJFEHgt/U0OV2LPiLZiSVJXXSYSmG3WUwdTGXyYEmxfihQc/Sypmm9WYTJ4nc92g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=witekio.com; dmarc=pass action=none header.from=witekio.com;
 dkim=pass header.d=witekio.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=witekio.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nNwhhbc8mwg56+apTG6YPfavbTtdqGiofmG/B8i9Rx0=;
 b=fL1ekM6l3lF1P3Zab5DIStJ9OrGfvk5Qnb1UfZYmrsNY0Mm7Oytxe75BbHjJ+g57cpD311fZuI5uclEOfJu6VkwhjRp3GqBrKxN2AFZ2nPqbtw9ZwG8wyCkKeUiVh7IrZWDTafILbHQK6Xdmn2KaPlu6JZYbmlu/cJIDF23wvJvMyFBS/k8JtOMuutuhRp3yFjRoN9/f5Hss6BZjzVYi68mWa8//wIiAqdv9YV3xWels0+eaNzui6m7GiT2l2mFSLaYuThTqyvKiLFsyPNVCOyiCw+l6N/RLr4UjXlqRGHWgvcU3cD6z/rjwUMioY4TgAEea44/qvUS8qtsg2IUgBQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=witekio.com;
Received: from PR3P192MB0714.EURP192.PROD.OUTLOOK.COM (2603:10a6:102:48::10)
 by AS2P192MB2266.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:64c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.28; Thu, 29 Aug
 2024 15:17:50 +0000
Received: from PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
 ([fe80::345f:a9e9:d884:3091]) by PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
 ([fe80::345f:a9e9:d884:3091%5]) with mapi id 15.20.7918.019; Thu, 29 Aug 2024
 15:17:50 +0000
From: hsimeliere.opensource@witekio.com
To: stable@vger.kernel.org
Cc: Miklos Szeredi <mszeredi@redhat.com>,
	Hugo SIMELIERE <hsimeliere.opensource@witekio.com>
Subject: [PATCH 4.19 2/6] ovl: verify permissions in ovl_path_open()
Date: Thu, 29 Aug 2024 17:17:01 +0200
Message-ID: <20240829151732.14930-2-hsimeliere.opensource@witekio.com>
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
X-MS-Office365-Filtering-Correlation-Id: c52f3795-f187-4c59-167f-08dcc83dbec2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YoevfKzbwj71wCeCLVCsBAt9X0DklMLI897fjxGi21A3tpRt+zPmsSDNQ5q/?=
 =?us-ascii?Q?KvqWrwFKnlmaGM3BepPPAnETpTP0WIOWczcomTZmo0mwb6NV79T+hZriRcFT?=
 =?us-ascii?Q?5eNcxXY1ignPTMprqFSpsYBpLFeS4sUE9g8WU5jTzi4I3zy4LygsTgYfOYcG?=
 =?us-ascii?Q?MxotvNos5j+uvSGMJdBp/cpxEY7lDLyUOK3HIlmjCu8jrSONzDbH65AwraXR?=
 =?us-ascii?Q?kjV1WQYBxOYLQ/PvCqt6KiCLapZbZgGXeink9Hb9xv0zLmvy78S/xD16hBgR?=
 =?us-ascii?Q?FmgYkfBSO4ddVtz1CNbkGQdGD8ALCfllxAwUd6+C5ePTWmWKsQYQ95AHDgiZ?=
 =?us-ascii?Q?rO8OunkSFbsNTA1CCUcruIER/zIWcaDEezREGY67Ug5M2LnhL8ILSgD3xbGK?=
 =?us-ascii?Q?dGw3v8EaZZ9e0Eu7i3ws5YetBwADkGWTDyWexdS4qkx/NXha3Jlcg5b7j2fv?=
 =?us-ascii?Q?EFI8veinpYea8i0RHQ41+E83n4iqcgofhpmvTHtwqbzuf5DK5f9mbxvzQ18I?=
 =?us-ascii?Q?PfVHC7ezeZEOz0OJMxKB1jOyqzH6/FA57zxoUQD2Doi/bB61ZUtwJmqR+2sH?=
 =?us-ascii?Q?hvr4/f1MA9/swUnMhAyS2Ug7OXy5+HH4UGRqUGw/qVhWcsGB/b8gKkwqG8eB?=
 =?us-ascii?Q?5Jr/pfK0JM5q+CRJ+Hy4YP9hC1qSHjMv1gv10kjxqPsGpnIEhrrJ3eOLIM2H?=
 =?us-ascii?Q?LqG6Ka+92mgCLqqT/6qsWrVZt7PmZT5wVLTYf8Okd7S5hjBH1lDha/JNdwrP?=
 =?us-ascii?Q?hmrGEh7lPRyZU5NsxjyIITQrN3RxH+EQoS/UGSrL2L2wLpn0SePREQZyDRPE?=
 =?us-ascii?Q?LPPhPKOgViXd0+Yb1+qQ2bjD3+O8bVSJAwuaVyhjPKu+6gPKRNGDlX9prRwb?=
 =?us-ascii?Q?CyAKEt1pXa9oNcso1yYXLQvdf7BJs+54KAT8KlrKc90dGUQ7z5QQD0tP1oxh?=
 =?us-ascii?Q?97Do62WvSRv5UoLvkxHhW66qQDDzVdfgvOaGBXKqGNN9fJZ86Djwo6H4lpcm?=
 =?us-ascii?Q?fq7F5Bd2A+w6wakJTqjeuQXdIjBRkXMSg06vkpD+Si9qL8Brk+yqp9tjS88B?=
 =?us-ascii?Q?9H4aJR/rcoprRngr0oF8udHidWYqUUMrcgE/wRBYTauULy1xcIqlrTmYwOuw?=
 =?us-ascii?Q?fvOxF+duA7rnuImz9NpYg0zt6RAS2bmDUB2dgraEXGWgn6nsVahV5h/Es10z?=
 =?us-ascii?Q?gEWLLQuXTqjpl0TZQwduXyrGfNpRGeI1/BgSSHkg9qcTUiYt4hqbjrhcNtbP?=
 =?us-ascii?Q?hIR04AM2qYN/Y7xC4Y7XaOf6mQPdXtdvya+EN3+PG42P3bIyJRjVJY3i14Bj?=
 =?us-ascii?Q?FHCA23kTOY2uqqENMhOTtAy4r/Mrgejtlw+29pN58cL1bpeH3JPvjQdGryYw?=
 =?us-ascii?Q?JhfZQbwgl5CBZTDtLun5ME+QdyIV5ubdfGjXE06cUlJYZzcKgA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR3P192MB0714.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cHCqRxGGToklunHX2LaauolReYABJRIeTyuMWn+1TIIocKhzOfTReQ2PD0Ej?=
 =?us-ascii?Q?vIamJdV+rwLcDvV8fqb1z2nrmlvpqTkRn/Eyo3XO9Q5GJU+ctdDKDzhC684R?=
 =?us-ascii?Q?D3gPFCG9eznBG3MSMIV0xQIKCY1TXGgNGWJ5dHr09vt421Vp4OC09odaVwPt?=
 =?us-ascii?Q?HzIkFSu4hizownh35iEwGfOBLoKSTDV/21W8T/mHNNlMK+6JBeptszgI3FfL?=
 =?us-ascii?Q?CRoW4zFgC2/FSFOjInvLsTIBjIB9IFkmUnM/N4JeJJbB+JGmAT5TdxGYiDZ6?=
 =?us-ascii?Q?gGraiOfn4zIbp6OGA8N3ijkrziec20rkgAq61eBQ92+kwY8Qx6sOPRO7xfPi?=
 =?us-ascii?Q?2PQcGrMYp2YuFt8Zdl/hdricsT8LrhESdd+RdYAfmTghTcYYecEfh4Vd+LV9?=
 =?us-ascii?Q?bdIbFpG2hwRdU30m8SeGtuYD8kej02KVTisr2jipK5VNnYerxF1/KvsvDW2U?=
 =?us-ascii?Q?xxEtMxj7+sXTfhFOOpENQXVqGIVG8Pb2Sy99gvTCVsqcpPR20LeHR7/q3+TA?=
 =?us-ascii?Q?aFEFNyVlCKZ70VnioE6Y2bc39CDvEn+8ikBJi+2UmrCUgl6Svk93FfXqVRwK?=
 =?us-ascii?Q?UQS5MDiYhVHFdlZXGxsA8il/GMSvbuhWsJef/N53xOeolO1f+3dQY1YSmTbt?=
 =?us-ascii?Q?J88waewS/45vsKHTEqAZCR4rIcqV0IQUNBSxPUt9q7d6XFLUbZlFyRXlsK6o?=
 =?us-ascii?Q?iIYAWkqAR2ME6vaZUTyCTOpjcniwkuwaYceCpQrVi605kiTHTBBNUZdJk+8m?=
 =?us-ascii?Q?JaMJw0d1pI0wJ2IdmVFbZ05nYcaf+ZN6QDEm5CLpvaN1w6kF1ya2gr0E2C/s?=
 =?us-ascii?Q?xpm6D8+ggYkCoZNld5wZ+8xWTCy+Ve32R4TUzNTnITCXPDOKiurpELzAgwqA?=
 =?us-ascii?Q?Os7jCWKPSY1+3ixE+wQKj+y6z0vuYvDQ7dFRoDpBod7Z+MNz/2oHBvcGZl0v?=
 =?us-ascii?Q?V+ZhvJT8jz07qeMsRYXf9s7CrN+b8YoGKuqRELyd1c4DmYqTKBnZNk0hRi5q?=
 =?us-ascii?Q?/mNSM6xJMuOQtGZzd1VDJMRW372pF4KqJbGwFyEqwkkxXrOiEtKpPOaXW9Oj?=
 =?us-ascii?Q?DJHzsX19c6GyMcRqwbqzOSTp3h0pTItUm3Ma/QAS6i3zyzIPOvdVjVKkK4a2?=
 =?us-ascii?Q?zUDWdMj/IGgAlTnN+jZ9tx/fY+ZHT5ba0TlxbcHQ3LFR7hl8lH6/fsrSXase?=
 =?us-ascii?Q?naeOtzHEQSiQ7bJ+87fYkZnEAyxVETgxHvUu4amQqJR/5E0l1RlCnFQ63hOg?=
 =?us-ascii?Q?00I21LGM1epaFS5EfElQeGBnKmuyXHiy4zJlJKYPNVEbjmJzNVn+YjVhVh4v?=
 =?us-ascii?Q?qevicRqPaW28ciCwylHFG+PLGV6Jak+woGiI7rsuvIc+W7jR/slDY34haCQ2?=
 =?us-ascii?Q?fiCAmd5z3EFJx7qzSMAw0+XFsY05+5yOTr4a/rYcliosv+Wk7yyxMZC1xemB?=
 =?us-ascii?Q?4E810dZAN8LfK1qyfmgqX7DylV38sJTU1a+VNV3Nl8xr64sjbn/4Rys7Fjfx?=
 =?us-ascii?Q?hWyPHsQn/jdAqsoobSCE/7vPlTOSZYuKB0I+KtzIet3DjDklDU1FwPcDyp/M?=
 =?us-ascii?Q?eJ/nxZICyLcO7bTVkgRT8YsT0ARfpZL0IlcZbOKhSdrffjkEEfBMnf+6Xnf6?=
 =?us-ascii?Q?uQ=3D=3D?=
X-OriginatorOrg: witekio.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c52f3795-f187-4c59-167f-08dcc83dbec2
X-MS-Exchange-CrossTenant-AuthSource: PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 15:17:49.9573
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 317e086a-301a-49af-9ea4-48a1c458b903
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bM30eHK9YsX0iarC/ojfaKKrzSCyvKx+lJ63SVY22ggWxDhlJ+L8oXKH7Efw1g+rB3D1TS/wiSSZTs/skJCZhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2P192MB2266

From: Miklos Szeredi <mszeredi@redhat.com>

commit 56230d956739b9cb1cbde439d76227d77979a04d upstream.

Check permission before opening a real file.

ovl_path_open() is used by readdir and copy-up routines.

ovl_permission() theoretically already checked copy up permissions, but it
doesn't hurt to re-do these checks during the actual copy-up.

For directory reading ovl_permission() only checks access to topmost
underlying layer.  Readdir on a merged directory accesses layers below the
topmost one as well.  Permission wasn't checked for these layers.

Note: modifying ovl_permission() to perform this check would be far more
complex and hence more bug prone.  The result is less precise permissions
returned in access(2).  If this turns out to be an issue, we can revisit
this bug.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Signed-off-by: Hugo SIMELIERE <hsimeliere.opensource@witekio.com>
---
 fs/overlayfs/util.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
index db8bdb29b320..afbc6a97da2a 100644
--- a/fs/overlayfs/util.c
+++ b/fs/overlayfs/util.c
@@ -479,7 +479,32 @@ bool ovl_is_whiteout(struct dentry *dentry)
 
 struct file *ovl_path_open(struct path *path, int flags)
 {
-	return dentry_open(path, flags | O_NOATIME, current_cred());
+	struct inode *inode = d_inode(path->dentry);
+	int err, acc_mode;
+
+	if (flags & ~(O_ACCMODE | O_LARGEFILE))
+		BUG();
+
+	switch (flags & O_ACCMODE) {
+	case O_RDONLY:
+		acc_mode = MAY_READ;
+		break;
+	case O_WRONLY:
+		acc_mode = MAY_WRITE;
+		break;
+	default:
+		BUG();
+	}
+
+	err = inode_permission(inode, acc_mode | MAY_OPEN);
+	if (err)
+		return ERR_PTR(err);
+
+	/* O_NOATIME is an optimization, don't fail if not permitted */
+	if (inode_owner_or_capable(inode))
+		flags |= O_NOATIME;
+
+	return dentry_open(path, flags, current_cred());
 }
 
 /* Caller should hold ovl_inode->lock */
-- 
2.43.0


