Return-Path: <stable+bounces-108466-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A53BA0BC9F
	for <lists+stable@lfdr.de>; Mon, 13 Jan 2025 16:51:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8061F1885B9C
	for <lists+stable@lfdr.de>; Mon, 13 Jan 2025 15:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D29EF1C5D5A;
	Mon, 13 Jan 2025 15:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="A0cvcCuN"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00549402.pphosted.com (mx0a-00549402.pphosted.com [205.220.166.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3B725760
	for <stable@vger.kernel.org>; Mon, 13 Jan 2025 15:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736783501; cv=fail; b=EjLwXFxhZb8wwoIFpBMh3ow5cJX1Ih/Sbr9PYktotrD7CWdouUYwvaPQ9twyaKORglidHoBqGp0ezUYVDO8iG08IHuw/sQvxLU7eubKG+hrPoOI6iQwTuOGLHDquq+SlWGBS14fYqLqT6iQuusDD6AxX6F0Fb4oZRYow9P0Oo3k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736783501; c=relaxed/simple;
	bh=hazCZ0tHIsyHuIpueHPi5fBOLi/nxJC1vS5AMNCqCOE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mTny1cs0uY0Od0B/56YszOYQ/h9yJJsMPtQBqeymlKnJZVso88LCvrY86Sm5iczjZm+eghVsVyjMSKCMWe/85PdfZQNeqfpIbHOKd8O0ChuoSXgpzk51JK/HnJD/cf9Byv63LUJSYoO4I3OzJZP/VbYePPJWfQUbDsNbnFE+gVg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b=A0cvcCuN; arc=fail smtp.client-ip=205.220.166.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Received: from pps.filterd (m0233778.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50DFbIQL019256;
	Mon, 13 Jan 2025 15:51:33 GMT
Received: from tyvp286cu001.outbound.protection.outlook.com (mail-japaneastazlp17011026.outbound.protection.outlook.com [40.93.73.26])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 443hq4hc3q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jan 2025 15:51:33 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FYctLO7j8iknFnvhFal5t2LOv6xE+KcQimNiLwMwofOzZaGG/jrJ8Odco+tSVG1zt0v59f/t4GYbOZgV1fWSRH30uwd7aTb4Tq9SYnmOKnsw6mEuBBaNiE3LdDTDf5O6w1De06FV2uDhssdZbblmXD7PIxv1e48XDjL3f6dI6/rqaFps8UbUlTrrS/UMpHpxw1sZT72/lunlJSVYMS8SnvhClS5g5PFii6OAd7VaZi3z+LvIOX2ShgmGrrrsqFy2BfUwPYQAl01j0f87ngtlqyT1V5waOLZsFBpyYzrIED0H/wZiLb8RLxq/tZYNiW+EIEaVrxjgW7W7tcIVwTlegw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AkEMgvPqbH+9j7IG1G086HHFKCJGM2FW3bxHc3HBSEw=;
 b=JtCuYRM9DoGQZZdicQiz4VzZmIWzZMaOQKc24YL4kjf3rOnsvOc2fD9TAC22eESPz5vxEd0cEdVAiJgGRk/e1Q9WjdJnW8e+cccEMsyuk7FJx7ckLRkXthXInWgPKayQJXShvQy1f3rzdsREVYaQZn/19EnyReEH4r/z05xwY40w/GCFCPy04Paf0cVQB538sbuNZYQXNWIYgVqBbXvr36DFIA0ZxfsKZHSPjYILeZVKHT+1GE5DmdzC65I+oJ+Aekv9dLC6heIgGVxgFHH1iUlVr/p2Z2Si7aAUmIh4n2VnMKLAn5ocBi/MNe6zIJwDjbO9W0mjW6msgwlN7vG+Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AkEMgvPqbH+9j7IG1G086HHFKCJGM2FW3bxHc3HBSEw=;
 b=A0cvcCuNIFL23jvt3rtsrTq8owoV/naURl3WBZnCl5PKN5IHbdypH37dli9FXxdpMxxCpaNYb/iOWCcvsOXD5gCajqIbYV4JAiPqyFcyPgfTEqyYPeXu4wvi5RUj9enxMFqIkDcia0Y8M/7ValhRkRN4RjzBIT+FqBjB3AUYr3LXG/TX0PhUmNDns13zxLwOQQcnS9U6tOkP7TYdhPizt5yl4M9E+wvjoIj1NjObIDrc3SiQTkRKIQSvxHxiUalr1PnevGiwNGneY9Qb+u0D+MQy2x5Bn6veFNKfOxg/5g9Sn9H5oey1NCVNrsCKffFrV+iIzWLc9csK3+DcDbS6rQ==
Received: from OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1a7::13)
 by TYVP286MB3652.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:36d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Mon, 13 Jan
 2025 15:51:29 +0000
Received: from OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 ([fe80::ff9:b41:1fa8:f60b]) by OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 ([fe80::ff9:b41:1fa8:f60b%4]) with mapi id 15.20.8335.017; Mon, 13 Jan 2025
 15:51:29 +0000
From: inv.git-commit@tdk.com
To: stable@vger.kernel.org
Cc: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 5.10.y] iio: imu: inv_icm42600: fix timestamps after suspend if sensor is on
Date: Mon, 13 Jan 2025 15:51:18 +0000
Message-Id: <20250113155118.936319-1-inv.git-commit@tdk.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <2025011306-wake-happiness-3601@gregkh>
References: <2025011306-wake-happiness-3601@gregkh>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0179.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:45::19) To OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:1a7::13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSZP286MB1942:EE_|TYVP286MB3652:EE_
X-MS-Office365-Filtering-Correlation-Id: c8a0e2cc-c730-43c7-e53d-08dd33ea24f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|376014|366016|7053199007|38350700014|3613699012;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IjHxRpA+zMt6nilhhowwxo9VgT5tlQWk+8N9T9XL5xmbCqNsRdFe/V/qMANg?=
 =?us-ascii?Q?QDjibuJpL7yjTAvhUJJViM3+PXaSuh5/LTlDK0iuOwl6VSZdxNN4GL7lQYFh?=
 =?us-ascii?Q?C+EgSr7JE6WsVAwTfQlOpunfFpz1otCM6pwKyYahhlUw8UGUJas5p4JTEg/I?=
 =?us-ascii?Q?3TcymypLeoC1+mxvYeABUhbqNuhwCCwkMxWnQdJzfLw6jgf/1Ke0Na6pSg/k?=
 =?us-ascii?Q?L+RIdvsux/8yxpdBXSOBx7JaBMzy29w99UbtLKpBWX3mIm4JiieFsvEowsKS?=
 =?us-ascii?Q?gkG9c5q6ebXmeyqL1+OiXu9jTakEQlaGnJao08/uSAmgaQN1RqfS0ZDE3bQH?=
 =?us-ascii?Q?RnB8frq50CQ0xLBozykw70fb9juJYlWvzXqaWMOBrHYMQYMPmhgiBv9lhZd0?=
 =?us-ascii?Q?cX4TUqH2sdiMuGCKnwFSZLgj0KTbCqkcEuhL3BUV2Sn6KekyaBFO/d58SLBq?=
 =?us-ascii?Q?UbqnJwyte6yQekf+xiq96W+B1KlDNrYH09AcwNay/6YxGFm8ojbhR1JzYb0Z?=
 =?us-ascii?Q?F8T6RZsWixGD2sIG1R9rNvmJNFK/lU4xkoxYH2PKQnnu8toa/lJYNDXPnTAr?=
 =?us-ascii?Q?8BOvxj8F9Jadzf2aOLYaTojeRSur8lWl8VzkyBZh8S21C2zATF1Vg3VpCTb8?=
 =?us-ascii?Q?alQ0H3ezZ6xxx1uP6JYU90pJo1mYNPXKTFb5kyN93uh8BP37LihQpW1o6TqP?=
 =?us-ascii?Q?0TyhnIPaFfDRetao9ZPC2hLcTrLh1upDPMsY5X2EZSQKbIKw3SUV+LLSzWRB?=
 =?us-ascii?Q?06bgXLwOSSe5uaiyp8EI+Ur4vvQUXDE3/3R+yovVm+qQYh81kGJOSuLT/5oy?=
 =?us-ascii?Q?ECvkP3TAxUXdk6Z3HhJimjnxZHL87fEFSwnPpCv1FJOLck2sQVVgDospSqlv?=
 =?us-ascii?Q?knP/X74MAFukZEaE6JGjvydHQLvP9AvwsXmRqRnX5J3GaRDnVa52j7wwYYdN?=
 =?us-ascii?Q?wU+MmaVg0LY5NNq5XxWVdiefQb5/ui5uSa5xOV9JLeyP7MayVae90oF4ERMi?=
 =?us-ascii?Q?nHPf084kAcDlUQ8IrndNTm89MEWD4YmEzJ6f8yQ5uCvXEW5nGR/i1pzFAQ2n?=
 =?us-ascii?Q?vkPe1Asm2dsxl6c6jEtPuPgFnLsvchKzLFMsApicax/UBI2spE0/i/yPrOz+?=
 =?us-ascii?Q?uFfREBxZmELadWGPvq0ck7FQCuHgw3Q1lCEf+pRHBSlEz18VD4spu4F1zSph?=
 =?us-ascii?Q?igMbVBpeXt2bXFFVfsjiYyRMQ6Sgl46amPeueHqhk3i3BYZHGB4puxpWew+O?=
 =?us-ascii?Q?4FYN/i99AEdyDLof5adV5yzMc2qHWso8/ymCqrb2dfZ3sYKht/d0naBKDbFm?=
 =?us-ascii?Q?cZVcaTvI012Zw3CT5SaQ+agp/LGeR30FCV57gH+xaFIxp4iaK3VWSeluzzUp?=
 =?us-ascii?Q?ey+xwGKYTeZy/qQSAsT5AKzhsVqcQxkdi28TS0M41ZRrVNLjrK8vATv/MipN?=
 =?us-ascii?Q?sF61iIfGZO0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(376014)(366016)(7053199007)(38350700014)(3613699012);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EDWz/0YRdDtvuKq9UQIoTc0VvG7VWxWA3DIekXI/Jis/9QqjHDIufBqLztUN?=
 =?us-ascii?Q?Z6KOTWOAAwZXhybJ8yFUuzUix3a47SiWeG72Er+G3OMFBWo/kjNsiagbappo?=
 =?us-ascii?Q?mZqjSIv6M/d4xJWJwhX8OSlEguZlI37JhiWhYWL/sJrBWIo/8HjnMVtOamxe?=
 =?us-ascii?Q?8mK8NhFoA3IXxv3whrk1dq856js7YRhr6sTlVY8bLqHRlDJ1ZuYp8b2gBMnY?=
 =?us-ascii?Q?hGKYSUF/xqMmcLZ6XJUD6l7Qr0Amweaa2KKW42aVOJA89C7ZinQLHg1wru4W?=
 =?us-ascii?Q?XMUeYaolCGBeuuomHFVmvo+qR/Y+2ppzeou4XCZiXFv81sWNbHs93VYRw/t8?=
 =?us-ascii?Q?rC/heMw342iyk799nIICWE0a/9nPpaQcV3nVJtegf667ssAgwcx9FM6iYxA4?=
 =?us-ascii?Q?BABNAv6Uu0r9xa8oWez1rFkbm2w7m3TrmBjzL+Lpww0ug8jaNZHxifa34w6n?=
 =?us-ascii?Q?hDS9ctOGbMGCaP4JZDtMLhtr0qgsklffnbRJ1hTrNnDshiCHsdj56JOQSWJS?=
 =?us-ascii?Q?hOhPvq4aekqPgzbpv4zF+7IYVC/HJteC8moMTcB3+E3rr+BpMHo4Zda8rPdh?=
 =?us-ascii?Q?H0CfwAwJNAfm8KRow3pPeM98HCQ1GOyELOQEu/5nj6boXUWoL8og3dl1XVS2?=
 =?us-ascii?Q?SxGeDwm/MlE7nZrJOLBYRAlgYtS9PoZ/EzqMmdk8Neziv2e8s6sNxy0Yge+D?=
 =?us-ascii?Q?PmdpI2qA8EGDJqE+/P8FPJboKIMmV45/Sw7L9OV5busG/GMFAhU6+DgTp9+7?=
 =?us-ascii?Q?FxuOyGHHBR+NZFgEQsiquteROGQaETLiCIFvXD1LrIk4lkcMEhY+UFLIq4mT?=
 =?us-ascii?Q?YUmUfq5n0zbBHTgNVgA0eNJSZsALLaZptB22rTJjx9VA4DLN+JkNl6bJ2WAL?=
 =?us-ascii?Q?Fv8PLs/7XM2BCTJgxBozM3pLjk2z4cV6xXCn66wY+uafh8v3bDbSP5prfEYb?=
 =?us-ascii?Q?W2us53Cg04ucyxycisIx7hIlOKyOMBNutYv/bYpMB0QrQy2BCjwG7jheTwUb?=
 =?us-ascii?Q?PP1VVdbysq+doWHcTXUyX10hdlvYbkK0tNbmxQbG7syzWnPec4NbdKfcH4Ai?=
 =?us-ascii?Q?E2dPBebRDVZLsp2F0QZwGQwXsV0AgjLWToUWREZiBE5P0vx6jqhEPjVuYZPL?=
 =?us-ascii?Q?osUKtxa2kiQ9hA+Wi7Hb0oJ8jvdPFd4Mw43bi9UhjHw/zajJAJQ2uxIZ0hda?=
 =?us-ascii?Q?ZfTV+LcuX8JOGT8IYL/9jIZ/G+/g6EIKs1nYl+OEyYr6u24AetLa+LpsRA9X?=
 =?us-ascii?Q?frlB3QpRZ1qSADGQxYQG2xCdj5RBC4jQkf5jDc7e35qLE9WgDtkptj9hgo8K?=
 =?us-ascii?Q?XrJiZo+4gE6PR9bCillAuISV2nLGnBadS0ikqqCA2o7Uu+243EFNAifuF9Q2?=
 =?us-ascii?Q?f/dxaQOHd/QmY3rPJLX8nhs7pe+hyxImXyEPwyRgPr9LoguzH3BS63t/8hau?=
 =?us-ascii?Q?pRoQtS7We7HFAvNgcX9Jqo7ZMQNaOScz5RW6VpVZaYRK0lpNKJ64i10HqOMW?=
 =?us-ascii?Q?+17O2KEo3g8OqQNfrxyVtm3f8Pzlz1sTyNAfa8VWfnGQnc0NJ+5fz+Vr8WUT?=
 =?us-ascii?Q?MtkCtzbQXhND4Z04A/u70Uy8AH2FPmYSiCdEdRZJNQ1+SlvxTv9CKtlJe7NS?=
 =?us-ascii?Q?bw=3D=3D?=
X-OriginatorOrg: tdk.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8a0e2cc-c730-43c7-e53d-08dd33ea24f0
X-MS-Exchange-CrossTenant-AuthSource: OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2025 15:51:29.5309
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g0F0t2vYy2Qd8nYww6xtdEqRGHpEjOVDD2rJDkDskEIV3LggKw3Kzh5wSySFS6FJqsEUMduHz2QHS9S5iDJ7pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYVP286MB3652
X-Proofpoint-GUID: SQ5Z08cq0kZ7Yx6F0L1XwTby-WsDVv3l
X-Proofpoint-ORIG-GUID: SQ5Z08cq0kZ7Yx6F0L1XwTby-WsDVv3l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0
 lowpriorityscore=0 spamscore=0 mlxlogscore=935 adultscore=0 malwarescore=0
 suspectscore=0 impostorscore=0 priorityscore=1501 clxscore=1015 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501130131

From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>

Currently suspending while sensors are one will result in timestamping
continuing without gap at resume. It can work with monotonic clock but
not with other clocks. Fix that by resetting timestamping.

Fixes: ec74ae9fd37c ("iio: imu: inv_icm42600: add accurate timestamping")
Cc: stable@vger.kernel.org
Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Link: https://patch.msgid.link/20241113-inv_icm42600-fix-timestamps-after-suspend-v1-1-dfc77c394173@tdk.com
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
(cherry picked from commit 65a60a590142c54a3f3be11ff162db2d5b0e1e06)
---
 drivers/iio/imu/inv_icm42600/inv_icm42600_core.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
index dcbd4e928851..351fce3c189e 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
@@ -709,6 +709,8 @@ static int __maybe_unused inv_icm42600_suspend(struct device *dev)
 static int __maybe_unused inv_icm42600_resume(struct device *dev)
 {
 	struct inv_icm42600_state *st = dev_get_drvdata(dev);
+	struct inv_icm42600_timestamp *gyro_ts = iio_priv(st->indio_gyro);
+	struct inv_icm42600_timestamp *accel_ts = iio_priv(st->indio_accel);
 	int ret;
 
 	mutex_lock(&st->lock);
@@ -729,9 +731,12 @@ static int __maybe_unused inv_icm42600_resume(struct device *dev)
 		goto out_unlock;
 
 	/* restore FIFO data streaming */
-	if (st->fifo.on)
+	if (st->fifo.on) {
+		inv_icm42600_timestamp_reset(gyro_ts);
+		inv_icm42600_timestamp_reset(accel_ts);
 		ret = regmap_write(st->map, INV_ICM42600_REG_FIFO_CONFIG,
 				   INV_ICM42600_FIFO_CONFIG_STREAM);
+	}
 
 out_unlock:
 	mutex_unlock(&st->lock);
-- 
2.25.1


