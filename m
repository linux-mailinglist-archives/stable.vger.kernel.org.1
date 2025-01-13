Return-Path: <stable+bounces-108431-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFC9AA0B807
	for <lists+stable@lfdr.de>; Mon, 13 Jan 2025 14:21:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 398211888978
	for <lists+stable@lfdr.de>; Mon, 13 Jan 2025 13:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4312623DE92;
	Mon, 13 Jan 2025 13:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="tyZS4YkY"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00549402.pphosted.com (mx0a-00549402.pphosted.com [205.220.166.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4978623DE8A
	for <stable@vger.kernel.org>; Mon, 13 Jan 2025 13:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736774381; cv=fail; b=U1HdnCDx8G6zdBEJcguzDVjPkZx8Ye1i38aUI8ZuC8TFxlHNT6yb6wZTVJBEpza/1Nwqa3VquW/kgX9KrEzDbQ5HsAqDy+OKEs7qSPM3S7Ra4UUuyrsu/pl0ly27yVlRNOPTCzheQBOtJ/nuGBaSlAuFQeQfIgnv+wegIrU9Yuo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736774381; c=relaxed/simple;
	bh=eUub+0TN9T4yfudrxWZxfHwURUUchziyP0OVoRSpxoU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uUp0Nbnr5pc2ZuhfFYJft1lKBqM84P0nCYsl3oEk11zfEAPwAUcfOVwEZ+T5t1ngfHix02BJ7ujolz3682j4HrLBeYKADoQIkjtDlxlEf7iDRqUX//y6JAwpH0T05lylsOFEGn5FPM696N4HZ9pE46bigg0twFIU6NwjGhuQAyM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b=tyZS4YkY; arc=fail smtp.client-ip=205.220.166.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Received: from pps.filterd (m0233778.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50D0TdRV011879;
	Mon, 13 Jan 2025 13:19:34 GMT
Received: from tyvp286cu001.outbound.protection.outlook.com (mail-japaneastazlp17011026.outbound.protection.outlook.com [40.93.73.26])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 443hq4h9et-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jan 2025 13:19:34 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wTd4YY7gkCpqFznPD0vnsZ47e1ihWRf920do3WuL86V5hak9qLviz6JtUwLRuuCWKy531Xd+326DXtnQ4Y7Bkid1U5O5bR07nhB4tmm0ZXIbD5qRzPdYDErpJxmmUn+uWlXt32tm0th2sTEUXirvMbA3AEMOg0HgTx/IbVXGsdHLSDREmbtneeZSyAsyjtDn25jpOcyON43Wl5IXNC3o68g3TXLiirnVSAvrh/yJU2kw7pippEn/9UY9+G2ttBIE4Q/ocoE1gwEzf+33JfImb3H3rWekaTTw6Y5I4c5N1ThC0qQdbKcm55WNJ9qiQLt3uyweKv6qr41EeHr5Ey4nMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pZSzCDBP1lEU+hEIwGpAEu61BPRr7evnsx7G6n4F1pM=;
 b=Fb37+4GNdGLcJ3MYwumU4RsEiQNq0EC6PkulmakH0YAcomzeqZg/QVaoMIUwBUw941DJBpdBfOrgfZyzvLUxWl2Pk0QKXgRIhUcwOcbl3dghuPHm4GoPs5BJCgwy+kD0bmhlxtZl3KhPMFB12XQNucDYZfhQxv64q4+51kYC+OLet5g4N2WU1ML2G4Ee+FK5jwWjsZlICqbMXiA0T3S1kJp5xbM3KpZlC6QwAB4QCobaqMYnSd243jH06nYv1rt1hcBCkjuTZt3fINFZ3lKN9O4F3ALKvys24pJuWvN5/l5BHCORLmAAnJBgc3w5oF+uhSTLhJNI9XT2ZLPEM42a5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pZSzCDBP1lEU+hEIwGpAEu61BPRr7evnsx7G6n4F1pM=;
 b=tyZS4YkYq5I7PxveNxX+ce90vP9ooRm3LavNHJVu926bEEqrj5M3oA4d1KDepZ1ecNUEOpoeTUIK5rJobCElHqhMgAMX6jrUPzqUIUoMYdnSDgb53CWE5a/ZZbu5a6D4zemKtbh0RSrU8kAvy4tvajT7YDMDGKUSjQ2LKYOwVKbG7BWecVz1rrzNAfmKA37zjd8ZyPyxmCwoAS0IA1ChIkEIQ/nGIzVxtdXZlFdstzIMlrkDxda9q4GCb5zLKSQS5PDrn+YU5awJWDA7lKI+Uhwy0zefI+41bunDK0PjpdbdvfUi1Y1pbWxRDOoh1Ru9GV9WbBjjLv6HM25fdTT6jQ==
Received: from OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1a7::13)
 by TYCP286MB1777.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:186::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Mon, 13 Jan
 2025 13:19:30 +0000
Received: from OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 ([fe80::ff9:b41:1fa8:f60b]) by OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 ([fe80::ff9:b41:1fa8:f60b%4]) with mapi id 15.20.8335.017; Mon, 13 Jan 2025
 13:19:30 +0000
From: inv.git-commit@tdk.com
To: stable@vger.kernel.org
Cc: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 5.15.y] iio: imu: inv_icm42600: fix spi burst write not supported
Date: Mon, 13 Jan 2025 13:19:18 +0000
Message-Id: <20250113131918.128606-1-inv.git-commit@tdk.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <2025011348-amaretto-wasabi-3e96@gregkh>
References: <2025011348-amaretto-wasabi-3e96@gregkh>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0062.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:21::13) To OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:1a7::13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSZP286MB1942:EE_|TYCP286MB1777:EE_
X-MS-Office365-Filtering-Correlation-Id: 55af93b0-f2e4-47a5-699b-08dd33d4e991
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|7053199007|38350700014|3613699012;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dYCnUFO5ZN+K+f5P0hzlgeZpr8lHGmYrrpwg+ear/jqeAD8A28dhIAmyQCyS?=
 =?us-ascii?Q?KO500aeM1gtG/MOqL7//yCqbQIdnZdtjdIg9WIHeaE3X5mGMQO3aNAFITr0A?=
 =?us-ascii?Q?p+zm2mWe8x2LMT2OIfV7Uh/2CssY05qw586Jlgo+HKWJjGbE+MKIzvqL0Wqz?=
 =?us-ascii?Q?v4mbRh7WrnK3dOzb+Ztfa47cQvaDWyayvGSAnqWsxewYnFp4BCWVPBtEUYsH?=
 =?us-ascii?Q?ZqO+3usQq/MRShbOX+xSCPYqHvLvOOYtEXnqJgeC/haw+Zj0fprt+3uOZOZD?=
 =?us-ascii?Q?1LgCnqTIeKkR+W6XrBf+jv8WM8A9Sl7WePC0wnWlaJPy0UJbZn3idoqY5Yc7?=
 =?us-ascii?Q?p+UAobuGHUTqVAPoIlKIKWYjvPwiiZg5znIlnzGyWpq7zQ15LXCnk7A1wWzx?=
 =?us-ascii?Q?G05h+Pgn2jRI3qYNWUNB6aCBzasDsUSJXtCAWt32KPeXgQQBMabvyyZkDKNN?=
 =?us-ascii?Q?u3neuZl4/FsTgP/qQFsdZVLMzA8z7FxpP+i6ZIGrC2/55xKdgNnUkqP7UD8a?=
 =?us-ascii?Q?NVBg2ADMAqBJdUooT64jvQuLSPYByb07GoS6p0mCob9AniwWEEGn9vI5Fb+x?=
 =?us-ascii?Q?MSdEaaLpwJrFLRwXcG2xWZthA6kjKZGCvk1eA7MhDw6Zu5tcn5t7voE44CSy?=
 =?us-ascii?Q?XHDmAc/HQ9zFMIT6lYS6un8VirHyaSmrT+WLsUd2+ar1WVpI+k1mX6wHLQjI?=
 =?us-ascii?Q?HWY0Z35kweUG+PPnVscoO+5jE95b84h878/opBmgaaLH/Ujw49LrA57c+q9q?=
 =?us-ascii?Q?7TncDW9evJT7/2BnGU9nLAs9ng5eNxjLP5bLka9ifiCa11Zkb/Jzr3wxK2nY?=
 =?us-ascii?Q?UtU37zpsM2DO77GUQZNXtStcHFySBXPIGeVvPSJv0o91PaIgcqU0ZdZ4eZDP?=
 =?us-ascii?Q?DM/Ez37dJSUbT2eMVmmPpQFzuJNf1qBkgHTueHvoP8fUsSWUxNjukBPnviLx?=
 =?us-ascii?Q?do1DrGD7+dF3p+bW9bBHUBz/h2ICpM4evlkTPFds/uLFOcwV4ePxjXcBweEL?=
 =?us-ascii?Q?MCsdQqqFYtoUyMBpPt3HIOgKTFD/cfV4n20J8DKsZlg4oP/l7ECoDDuwpXJk?=
 =?us-ascii?Q?no7aIthY9qpGel9KmbCxmssz4C2jKeD7PuYAJgPHxSzGsDjfNGOrWgenFMZa?=
 =?us-ascii?Q?hc4zWsVd+p0VfS+8W5DyijrXxL9yBQ1wKk5t9dgSSxRQuz5HgcpBmJ0j8LDY?=
 =?us-ascii?Q?ATy8QWwjPE7Uy8zJlcLXujVGU84Bb/Av0faG8mot6g/I8+fJHSXSPQ85VPh5?=
 =?us-ascii?Q?J7bTm0NL98oiz/UZKZy6IflYbwQAL2xGiaDEdB4EZSwD0guIFVIwR415dfgv?=
 =?us-ascii?Q?JtcG1XXgplmeFm1xIJzPayxVCxPhli70ovWdTa8h75ywHhtvzzAQpHfVnY6f?=
 =?us-ascii?Q?3F32VrFuQxmbAYFsw3oskgVD6Gi8zXIMyPe/YTCHa7+DdHM2JaiSgV+FGnFd?=
 =?us-ascii?Q?1pAzQsTvd3c=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(7053199007)(38350700014)(3613699012);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JjnXi0iKUCzOFl/VrWk2J0RmqHGLJ2hnGOr7HpWt1kCeIi92+hQKjGDu5oRv?=
 =?us-ascii?Q?WfTzOhT6t50TGzZqzVXXilBSETTtIjFhBqfALhUr7EEXfBKCQKLmvuG6tJWD?=
 =?us-ascii?Q?lxklM1HBXMH9OJG117cQXq3md5nh632myVZouTmlf0TWHtDdzvDhU+441jwz?=
 =?us-ascii?Q?zyOpXmdijTqmbOzg5tc+TvU0Xjfk+ZNEhPn2qm2dY54smTtqxOPSE6cHUO6H?=
 =?us-ascii?Q?giFNSGSq34rkh/ykiTQrBjG0shwSTiHm88tZ41xHbgHERAsKoixWTo7VRWlp?=
 =?us-ascii?Q?x5idn8S1zf8TJxZOtRvSEEm9nL785qLjzdqTd6az952F6oEs/kDtg0Esl4OL?=
 =?us-ascii?Q?EvhG06kkNZJg6ghNfLTpGi8ZN1UlHb3LQ+k5fsIfNJ1X9TMdr2hwrvLs1+OJ?=
 =?us-ascii?Q?dvW+q1gRNaD/3WDqBRetbfuPjdjHYwsY/Ty8uEbwO53UnjqlT2DaBBPtmgec?=
 =?us-ascii?Q?uNdd4X0b2P7oEOf9r/dYkT5gpr/BQDB0p+EffPt6vZhbJQiZ54iCNEi28Fkk?=
 =?us-ascii?Q?ufwz9gV74Yy9aL0MomgFvW+cC2yfAkKwRXI9gIQ48fVfF3u0wQ3IdNbLxSX7?=
 =?us-ascii?Q?2wEBu0uTngFq+GuxwJxD69GwSBpZsjwKQ7P+3sO7OvN28Z2Ybw/Rx/tvUcVX?=
 =?us-ascii?Q?ZGzs1Q06p2DFrd+1JalpDSS3y8bC6BNT4ddP4LEbDz2GncWcARUQNCHibLPS?=
 =?us-ascii?Q?6LOjDmlwpeQDJpKlKP7b6LSIvBBbtYEtrmJiLoyjjqbDxmhnjI/K7LmKS6cY?=
 =?us-ascii?Q?Ag2+WAUpmVtk8KnCS+g+lg5Ry7S4WKkgsrkmqmyRCHCZfAQMsvcGJFLZnIii?=
 =?us-ascii?Q?N9vjDQM9rKOo7HPtfFRvG0Vb8di+Dy0eXj/sOpqKXWNAIFTpF1FWNi+E33rB?=
 =?us-ascii?Q?a68hK+3X9Zq+iY28LpT/khfeGz7wE0eKeFKRI7dvfDQzf1tSrZAsnewfVWZk?=
 =?us-ascii?Q?nAKhT/fEC9EsSOTuUi4RJASjwOT5e9EnJ9/1eurj0bQHUON9/IbjEQNmayy4?=
 =?us-ascii?Q?BaIPaIZVnT4A58zE03dgZ9tvzZSX8lPXUmiQeqJshwbRhVXvqZTiVAyu9wNr?=
 =?us-ascii?Q?U2WnvA4qD33nI2wej9L+Q6sI8XOEVLRGOpLUd/tn6auTy6FPiK2Kv9gS1g39?=
 =?us-ascii?Q?jDPS8V3ti5Qmg5iYHKsSWfoySMJAcisDLQluqkNs6x+dIRWZfreRKuCMEOWy?=
 =?us-ascii?Q?NtZ6setW5I9rt6upGGyVe5Z+3wS4psOmLPZpMyYE0NVpj/pJ24rcd9yWcPEf?=
 =?us-ascii?Q?T6+3p15F4gI9ns0l57O1PVBipcnxb8C2Uf1PFhgqjl+yl7sqa7UPnUj7xm6G?=
 =?us-ascii?Q?8qM3EdIwmUgDOdqjq7tozRfH2TFb33pIF41t7rArWobJw3qA0OaqSBHbHh8r?=
 =?us-ascii?Q?lKm5fnNG3es1xPjA4FCIIBMcsXE7/HhaSoqdgWkPJk+tZqDbwITg+2q5T0ba?=
 =?us-ascii?Q?qBDjXnLc1mAbs2kvX+LGlF25PUL2u/BOzYZPjEDssLYIruILtg8hC26gBHDp?=
 =?us-ascii?Q?blAHEK9wSWyfWuaZcwNmNTYniG66KQF3TtINMxK35YSxFeLEeg687XHXReac?=
 =?us-ascii?Q?NN+3zWoBryu0/zFZ07VClLrrKZ/Qmdd7Vb/9p3R3jEeUtzxDsYo2chxVw4d2?=
 =?us-ascii?Q?Vw=3D=3D?=
X-OriginatorOrg: tdk.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55af93b0-f2e4-47a5-699b-08dd33d4e991
X-MS-Exchange-CrossTenant-AuthSource: OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2025 13:19:30.5377
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h6QkfVTopz740m2w0XdTOBfZ1iGaYkG0Pr/ixKgFfD8LRAoyc/ohUH65FRWK7uRr3WDRRKZjDrsDx+IqFiErUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB1777
X-Proofpoint-GUID: GUmvhy9NIV8AFBaWkVwXYGFxF8-h6naY
X-Proofpoint-ORIG-GUID: GUmvhy9NIV8AFBaWkVwXYGFxF8-h6naY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0
 lowpriorityscore=0 spamscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 suspectscore=0 impostorscore=0 priorityscore=1501 clxscore=1015 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501130112

From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>

Burst write with SPI is not working for all icm42600 chips. It was
only used for setting user offsets with regmap_bulk_write.

Add specific SPI regmap config for using only single write with SPI.

Fixes: 9f9ff91b775b ("iio: imu: inv_icm42600: add SPI driver for inv_icm42600 driver")
Cc: stable@vger.kernel.org
Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Link: https://patch.msgid.link/20241112-inv-icm42600-fix-spi-burst-write-not-supported-v2-1-97690dc03607@tdk.com
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
(cherry picked from commit c0f866de4ce447bca3191b9cefac60c4b36a7922)
---
 drivers/iio/imu/inv_icm42600/inv_icm42600.h      |  1 +
 drivers/iio/imu/inv_icm42600/inv_icm42600_core.c | 12 ++++++++++++
 drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c  |  3 ++-
 3 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600.h b/drivers/iio/imu/inv_icm42600/inv_icm42600.h
index 995a9dc06521..f5df2e13b063 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600.h
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600.h
@@ -360,6 +360,7 @@ struct inv_icm42600_state {
 typedef int (*inv_icm42600_bus_setup)(struct inv_icm42600_state *);
 
 extern const struct regmap_config inv_icm42600_regmap_config;
+extern const struct regmap_config inv_icm42600_spi_regmap_config;
 extern const struct dev_pm_ops inv_icm42600_pm_ops;
 
 const struct iio_mount_matrix *
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
index ca85fccc9839..a562d7476955 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
@@ -43,6 +43,18 @@ const struct regmap_config inv_icm42600_regmap_config = {
 };
 EXPORT_SYMBOL_GPL(inv_icm42600_regmap_config);
 
+/* define specific regmap for SPI not supporting burst write */
+const struct regmap_config inv_icm42600_spi_regmap_config = {
+	.name = "inv_icm42600",
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = 0x4FFF,
+	.ranges = inv_icm42600_regmap_ranges,
+	.num_ranges = ARRAY_SIZE(inv_icm42600_regmap_ranges),
+	.use_single_write = true,
+};
+EXPORT_SYMBOL_GPL(inv_icm42600_spi_regmap_config);
+
 struct inv_icm42600_hw {
 	uint8_t whoami;
 	const char *name;
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c
index 323789697a08..193afb46725d 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c
@@ -59,7 +59,8 @@ static int inv_icm42600_probe(struct spi_device *spi)
 		return -EINVAL;
 	chip = (enum inv_icm42600_chip)match;
 
-	regmap = devm_regmap_init_spi(spi, &inv_icm42600_regmap_config);
+	/* use SPI specific regmap */
+	regmap = devm_regmap_init_spi(spi, &inv_icm42600_spi_regmap_config);
 	if (IS_ERR(regmap))
 		return PTR_ERR(regmap);
 
-- 
2.25.1


