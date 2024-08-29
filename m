Return-Path: <stable+bounces-71515-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15D4F9649B9
	for <lists+stable@lfdr.de>; Thu, 29 Aug 2024 17:18:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B7E71C20FFB
	for <lists+stable@lfdr.de>; Thu, 29 Aug 2024 15:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54C8D1B1429;
	Thu, 29 Aug 2024 15:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=witekio.com header.i=@witekio.com header.b="GjTsUYoB"
X-Original-To: stable@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2135.outbound.protection.outlook.com [40.107.20.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2ADB1B29BA
	for <stable@vger.kernel.org>; Thu, 29 Aug 2024 15:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.135
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724944686; cv=fail; b=J85jmBytk74oHkiP+TYkor3ZU9ut8In3CxELoRVnMxTyEmUXXpPpF7GqINVgEq1y8uFXecPH4v8tU7XUm/O/T8uK893wycUWeXidnBN2Jq4rczIjRNYYSrr+/Xc5npmjfm3IZfVLEoVW7hS/U6iUa0K/52YNqkxY5YnCV9TK9Rw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724944686; c=relaxed/simple;
	bh=efuJVaWoODQQD6g5bstpe/ED9wNMjoLt7ib7klMTTJs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZUdBNjKdfQCAD8nVnZN4e8ozyG0PgIYHyqO92DUErA49Fhv6qMwS6UHD2jue1LUE1aJ9QGt5/PD0ETxmxNGYfMerqQhOfSkfmWTdPVLqk1KMvpb9Z2nuwYUeO4MHJqW+UFaDdNcZavH3/MTGaBncqyDFarZG8StrzwtmQMeEZOE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=witekio.com; spf=pass smtp.mailfrom=witekio.com; dkim=pass (2048-bit key) header.d=witekio.com header.i=@witekio.com header.b=GjTsUYoB; arc=fail smtp.client-ip=40.107.20.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=witekio.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=witekio.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o03i22HJJSZL70oeqZcrjwT4oBWHzwvnSeHcBuGx7S6UdB/s+8/H+DsXdXKCpB2W43j3Wf9dQNDoQ9cOUF5Gchb7Xyilm0HcZhgWgL7kZHBY9CxHcQ7c1ohfGPJ4az7ro9w8KmQUX4Y/NDUaiB+uXdff76bO9agwzRo5kDQOpakBHYv7Qt4o+8OQOJUVnV/KH6imIFTQJqNxUlHIXg1GqRPmSLFeBkqaCjz2fAxsdE+cvT5jQLHBW1deWsmOAW+OErOmXZdHmIdFrrr2q+Z7lGgHWQTW9gWo//UykgWc6ed8ZUCrMTfRwCNoOqcyMn3jkDQmagzhIJ4Ec/z7ohbmLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x7FMt+PB/WP6cRYKN1AxREt3ILe37QH2CZri5sOTvxo=;
 b=yy6Xovp4TCznvjj7V9zuXAZQoTFkdWt8KvUCVgqlyPEsH9HZ0uUCh8MgxOYg0fBW7dmRVuaYDpvF0HAqNB/DoHIp9MRwNmDp0n0LTXmd0ASuZU227mhcqNghOyH6oSY88htBnWyxuaD+3xuezdxb8R5/wrlMXrBHDQDh/uMsT8rzS1J1m5fTMuXb7JzQzbTy/3zaQrdY0ZVDbvEwzNj2Wk0uOIpmnFs1h5pOVMHfP8GycZoNlEls4gBoZPcWGNjI7/NO2rRdyW/SSaAjqX/1dB1rZTuA1FBBNZdkiPqjQpgoVi/2F2QChPHfwSaCqs7HS4DybL4bFwnqXt2jlBD2tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=witekio.com; dmarc=pass action=none header.from=witekio.com;
 dkim=pass header.d=witekio.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=witekio.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x7FMt+PB/WP6cRYKN1AxREt3ILe37QH2CZri5sOTvxo=;
 b=GjTsUYoB0DBh8jubzRWg58dYqExpl2ZeCGzvfJbmIHhb8Lpvkvt9L/3GXYiqs9jx4WkCOuvWk2BrjymyoBK5imxEcvHe0yt+2u7d1cywz5bBcZJhi/PVpuo6m8TZAAbNKnYCGdB65jveT07MB4KODCmurQahTanzFFfFFyu6xJuozJ1eYXgxGCuCLL/xoyhOlF4358jKSejBErWytOTmK+gBAkoY8DWf26ZoDfisecjM0pHd18/y6XCfsQ/w9y2jjXLbeMpVLrEfV8/2qBftX2FPBrFcifkyzBUTxKOegujtSzn5yoUVdwypv97DL3+i3ZTc1Tx4M5m9kR5HtAQziA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=witekio.com;
Received: from PR3P192MB0714.EURP192.PROD.OUTLOOK.COM (2603:10a6:102:48::10)
 by AS2P192MB2266.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:64c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.28; Thu, 29 Aug
 2024 15:17:54 +0000
Received: from PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
 ([fe80::345f:a9e9:d884:3091]) by PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
 ([fe80::345f:a9e9:d884:3091%5]) with mapi id 15.20.7918.019; Thu, 29 Aug 2024
 15:17:54 +0000
From: hsimeliere.opensource@witekio.com
To: stable@vger.kernel.org
Cc: Miklos Szeredi <mszeredi@redhat.com>,
	Hugo SIMELIERE <hsimeliere.opensource@witekio.com>
Subject: [PATCH 4.19 5/6] ovl: pass correct flags for opening real directory
Date: Thu, 29 Aug 2024 17:17:04 +0200
Message-ID: <20240829151732.14930-5-hsimeliere.opensource@witekio.com>
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
X-MS-Office365-Filtering-Correlation-Id: b4b0f302-8079-4d82-93dc-08dcc83dc144
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6OnysCMapJT/53BtZNt2hWFOnbzIDNlE72+tNFZHPtMTNnnQsWn5OYp9TDQi?=
 =?us-ascii?Q?KUqvgsTRny9WZqbOAFSIkzlCXuK+rYKmnbOyOV6wqtZO+1gjBVSu6oMEzW4O?=
 =?us-ascii?Q?vfPr6HwPTyZtH40VMSjBT5sgywmAlZdRqcmYCz6PGAncPS5ltYKu2A1rYi4L?=
 =?us-ascii?Q?zdQIKmdI2C65z1OVNovux6RRp3nd/Q3ig1EKddi56yvpGyVTOKSeSbHlaf41?=
 =?us-ascii?Q?XfkVfNrZEcdj3mmnAsk6PhwGFZICsoaTAD3VlY7s3chN6kXYpeQLm0ilAJbZ?=
 =?us-ascii?Q?8nYUtLTffXEnhxHb4imT8KZr9rd4BKxbEZdiBtIjzHEa+ne6oP5fEqW2JVkB?=
 =?us-ascii?Q?kwpwi2o11rXgeAyrsLiJGUu+kuZqLnrjQl8wDF4a0IjjfBJ1oyxVGGkhhjY0?=
 =?us-ascii?Q?Hv6k9S1oWi1opv+945IzGgdAjmGro5fZBdR1o44iEYxMqS/nAoK+tA1vn7RS?=
 =?us-ascii?Q?YZKf9pSlgvMxTogugf5JEgMbulpEeK4sz80iyh0iiPRi0WdJQqWwRyVmMRo8?=
 =?us-ascii?Q?iOEboxhmVjRu/P1HaYPt50wVW+eE6TluhDP4EfjHr93vQ39354pFLPwyG2rK?=
 =?us-ascii?Q?LGoPezyikqdtcOzbjf8rMpXwFPIThYGVO0FFeZKh090tv76Qbik1gMtfo26B?=
 =?us-ascii?Q?3mvJkwCtnKyyBkSthHqN8xK75jP2l/djUc3+53XZt/WI8lG1mNEvp9o5iKEo?=
 =?us-ascii?Q?R3VEHLXc6Y3tJ9TkfwFCMb1YJg5d+g4qHFcUnuzY/Sq0Y6DGf1oTCfULUXM/?=
 =?us-ascii?Q?2svcySlHJwH1vnYbDjylG8yaMD7b/ETYbkttxH6PkSoCbgll+V82ePW4wv9J?=
 =?us-ascii?Q?onB0f+5xbMwa8bdEh6KX7Y4LC93uWNqE77sybFAYU/FAHSp/BzLnHOY8Pqxv?=
 =?us-ascii?Q?d7n1jsw3ylZjDlenFj5mwHWpXFtwUaa/0LpJFw4cErBnVI2Y4MkZJqZDusD3?=
 =?us-ascii?Q?H77WUd/qogMzpLTBu/7w0ttqjkvDjVrfT984bqm/et6n72u2VIewC6aORFMy?=
 =?us-ascii?Q?fi8gFLR3/BD7fqJDTcx8krxENIleGdcHJIuhlkffYqCFumgTizf2BIkcqZdo?=
 =?us-ascii?Q?6WCCjJ6vjjagEzprLAYDE2xS6PrtnEb5Vwy1umbxHMGNm21BXOV99lDuoaDf?=
 =?us-ascii?Q?R1KZTYUcDBNMuLEWjklveaG5f7S32Nm/OhWY8lwjj5NZ/6U5SRgQ3ZBkegAc?=
 =?us-ascii?Q?KUayRHmghItXi5Zv36crfUM6HplHDfvlTGshMBXLeOCRfmJJdBTE60Ms55kN?=
 =?us-ascii?Q?n02mEy/NuhNDJZLDxnK7pIj29+mBJTDXG0hg1ChihFaO9yTczYTlRAB+Z6NS?=
 =?us-ascii?Q?86CyqJyLQJuDEYE1nLwsGGhEw7I+LHoIlblG1ni6XxJiQzax0vq0hCUG6cG1?=
 =?us-ascii?Q?VIIA/TWPSSx/+HDywWTiOcGhmfDAE+OeJEHSfjFgfvMK1QAobA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR3P192MB0714.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uy5gyVcUl+8Ry/cYhvquTpX+0xxjtCuFWA1sIneM0XcEia1bgUkUcAIR5Vw2?=
 =?us-ascii?Q?M9gyGaQQmsxUX3Uif8ecDQTPTafIyWzfbb7goAiSrQ/k4+dw58olx2hlqTFB?=
 =?us-ascii?Q?YzzGm57wPR5217Fy3Y9qX11H2BtvjRsfqtooWIsLMeEUFGhjVHeUr5TGYJVG?=
 =?us-ascii?Q?hgJA4X1By1qyL37z1vSb7JvcOK40w73LZx7zp6LzspmjNhyfEWEPFfQULCDu?=
 =?us-ascii?Q?2+aoFvvgyW0IfbX4NwG6IL0cSIgbrhzShFtEQ0+7KUu5/FwVqoFizAjm2USB?=
 =?us-ascii?Q?pkzNvBi8u3ybcGlj1PZFN//LZmREMksMNpxX9+/VQoODgwzXF6WjdbxHGjBs?=
 =?us-ascii?Q?IVtec4vjWCwLagEBVDC0BDxSOPek0oyRidIClaBsM8see34l1Vd+alY00+vt?=
 =?us-ascii?Q?fOaTRhwZJT7z5tc2M5EjJJ7LpLciaHCHwsIUypbHpkdfBSQp6vH5OEXwkmmA?=
 =?us-ascii?Q?9OhUGgTwx3T9QS+FLqYef/pbrK6zHagrOtwipCBonxav/sx0DPvfu25ygTy5?=
 =?us-ascii?Q?snm71Ug//RNgmQq4LeGsD9goU1IBvgkht3eK67l67/CF67N7tSBQzxX2qv9a?=
 =?us-ascii?Q?iLdkrFPMYLeD+AmfqrmoiUhZ9pEylGMxjHqN4Q9ecDGYcephfZ0YnVLdBIKO?=
 =?us-ascii?Q?FqsBxcvPik/Xy2fW2SD1jyooU0hqrSXgSTH+d7bbM547BKLge1Bo8RVKSeoX?=
 =?us-ascii?Q?WLKEMuN8tjPHkzkgg5kqtjnw+VCfinjm1ozmZepCnCiLSfyKgsagcz6VEd7z?=
 =?us-ascii?Q?rxIUaF8/jU95LnyaAKOVyRrABvvv/pv50X5X3DELUHI8RsrePAcIdiC8sXk/?=
 =?us-ascii?Q?Sv/wOEe2WOKiDunslxX1qwtScyji+VZVjUZJ+UajhNsaHh22WjzUqyCyost6?=
 =?us-ascii?Q?6JWmPGNDKJ/UGCQs1DDxaU88eCQgsj9nDplpaSsZ+z5aPQe/+AFqbb6Hca2n?=
 =?us-ascii?Q?KfXgnX3P8VIBqQZz2SulEfCbIeRAVtx7Qbr2bCph9rgUBmAwhA+6DrvX07Tv?=
 =?us-ascii?Q?rPqBX1Ddnt91PhhnNW/frZ3YhhG983F+xlAlz+MXhXgNXp+2lIVtB96BOOYP?=
 =?us-ascii?Q?vsHpc+W0Ckta0rBejWWswX9a5vymDSFoIHNUPI8vLnaMN0kKXslBmNloDdcW?=
 =?us-ascii?Q?+6GScE3TnmsaBTwE/n1Ep4wxJysr3+Q8xV/nmXSwDM4LwozYwRAlkb8QR9nd?=
 =?us-ascii?Q?Hzuwhf5C05qEit+ZBLd0P1fE7fTfAihdh6g+Rt+1i4hat4mGXBHud4wUrtHE?=
 =?us-ascii?Q?vBRQA/PoLgflzSQyLeDgLMbdVZVY63H2iqqSN9NDanTIO3404V4wgaC8VDJp?=
 =?us-ascii?Q?YHlUFdroQZ/sornohPSwdPUIN+wYaC7xmLa3FJsnqDaUNCl7ANIRBZtpQI3l?=
 =?us-ascii?Q?UaqP7eYQxv6brzNeTX0ceuo8Hek+fjg99+MtjtI6f56kDkJFIluwmEBSYWtZ?=
 =?us-ascii?Q?SSLHdkJnngYwUoB7ftYYfPuOPpYRSZ+qKOjWBOcpw9MIp6tsKtO2I6XmqqEO?=
 =?us-ascii?Q?+5ElBBJFaGPwtSmYHnBwYO4P4UHowRwbwYHNMiAqYBRdgsVC7UHQLBYnKbrR?=
 =?us-ascii?Q?oXrZL3vBdG7tfcmD1iSyZ47UAkWP4w0px2DbeZp+xbojoCaW8i1v9+UxkJ3r?=
 =?us-ascii?Q?lg=3D=3D?=
X-OriginatorOrg: witekio.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4b0f302-8079-4d82-93dc-08dcc83dc144
X-MS-Exchange-CrossTenant-AuthSource: PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 15:17:54.1651
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 317e086a-301a-49af-9ea4-48a1c458b903
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zoGYebmOxlQCDquuTWa5wuuUm3eKaZjXJ8+ExyNkXiJAK45/fHDpDBXNVI2ptSiayb3hqEepSqZMIukRM7Iivw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2P192MB2266

From: Miklos Szeredi <mszeredi@redhat.com>

commit 130fdbc3d1f9966dd4230709c30f3768bccd3065 upstream.

The three instances of ovl_path_open() in overlayfs/readdir.c do three
different things:

 - pass f_flags from overlay file
 - pass O_RDONLY | O_DIRECTORY
 - pass just O_RDONLY

The value of f_flags can be (other than O_RDONLY):

O_WRONLY	- not possible for a directory
O_RDWR		- not possible for a directory
O_CREAT		- masked out by dentry_open()
O_EXCL		- masked out by dentry_open()
O_NOCTTY	- masked out by dentry_open()
O_TRUNC		- masked out by dentry_open()
O_APPEND	- no effect on directory ops
O_NDELAY	- no effect on directory ops
O_NONBLOCK	- no effect on directory ops
__O_SYNC	- no effect on directory ops
O_DSYNC		- no effect on directory ops
FASYNC		- no effect on directory ops
O_DIRECT	- no effect on directory ops
O_LARGEFILE	- ?
O_DIRECTORY	- only affects lookup
O_NOFOLLOW	- only affects lookup
O_NOATIME	- overlay sets this unconditionally in ovl_path_open()
O_CLOEXEC	- only affects fd allocation
O_PATH		- no effect on directory ops
__O_TMPFILE	- not possible for a directory

Fon non-merge directories we use the underlying filesystem's iterate; in
this case honor O_LARGEFILE from the original file to make sure that open
doesn't get rejected.

For merge directories it's safe to pass O_LARGEFILE unconditionally since
userspace will only see the artificial offsets created by overlayfs.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Signed-off-by: Hugo SIMELIERE <hsimeliere.opensource@witekio.com>
---
 fs/overlayfs/readdir.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
index db9132a020de..2e12b756cc82 100644
--- a/fs/overlayfs/readdir.c
+++ b/fs/overlayfs/readdir.c
@@ -300,7 +300,7 @@ static inline int ovl_dir_read(struct path *realpath,
 	struct file *realfile;
 	int err;
 
-	realfile = ovl_path_open(realpath, O_RDONLY | O_DIRECTORY);
+	realfile = ovl_path_open(realpath, O_RDONLY | O_LARGEFILE);
 	if (IS_ERR(realfile))
 		return PTR_ERR(realfile);
 
@@ -831,6 +831,12 @@ static loff_t ovl_dir_llseek(struct file *file, loff_t offset, int origin)
 	return res;
 }
 
+static struct file *ovl_dir_open_realfile(struct file *file,
+					  struct path *realpath)
+{
+	return ovl_path_open(realpath, O_RDONLY | (file->f_flags & O_LARGEFILE));
+}
+
 static int ovl_dir_fsync(struct file *file, loff_t start, loff_t end,
 			 int datasync)
 {
@@ -853,7 +859,7 @@ static int ovl_dir_fsync(struct file *file, loff_t start, loff_t end,
 			struct path upperpath;
 
 			ovl_path_upper(dentry, &upperpath);
-			realfile = ovl_path_open(&upperpath, O_RDONLY);
+			realfile = ovl_dir_open_realfile(file, &upperpath);
 
 			inode_lock(inode);
 			if (!od->upperfile) {
@@ -904,7 +910,7 @@ static int ovl_dir_open(struct inode *inode, struct file *file)
 		return -ENOMEM;
 
 	type = ovl_path_real(file->f_path.dentry, &realpath);
-	realfile = ovl_path_open(&realpath, file->f_flags);
+	realfile = ovl_dir_open_realfile(file, &realpath);
 	if (IS_ERR(realfile)) {
 		kfree(od);
 		return PTR_ERR(realfile);
-- 
2.43.0


