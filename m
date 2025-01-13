Return-Path: <stable+bounces-108442-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9F90A0B8C6
	for <lists+stable@lfdr.de>; Mon, 13 Jan 2025 14:53:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7785B3A4B5B
	for <lists+stable@lfdr.de>; Mon, 13 Jan 2025 13:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7ED1231CA4;
	Mon, 13 Jan 2025 13:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="q2cb+Z0+"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00549402.pphosted.com (mx0b-00549402.pphosted.com [205.220.178.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45ED022AE7B
	for <stable@vger.kernel.org>; Mon, 13 Jan 2025 13:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736776412; cv=fail; b=C3bI6fAWgGoOhciU5a4qt8YQkhp9B+qYYmY/VqqLtDxZGoJ1CSFriwyIlRUCVsT/qDD3snZYS1aZTE9dAIotRLus4G6bZBjemMlZgODhl9EPXkz6wWDE0FnBgk+X7ZRyxi5LT+zhVPIiqYrhyAeGdtD0oSv19kUMZ0kgA7ZOHX4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736776412; c=relaxed/simple;
	bh=FSR80aF1gSIWIAug6EfUCG+hf9owgb3QI4FtmYs/4XU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MW3eOTIxvzmNhsfhC744Mzph8Oi8kTakvOeI2HCE8t9xykZh/O+UPyEQlcBjjoY0a3sm7TFOGVwTdGE8a8hVGCRzA/AUBVylGG+KyVYgrH4zfzzImIyIr8x5GiUggPud5tx9QkLXLfIjhR71SyCEi51Y5S9Ttvyy2SGa8PYynM4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b=q2cb+Z0+; arc=fail smtp.client-ip=205.220.178.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Received: from pps.filterd (m0233779.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50DBOZFU024824;
	Mon, 13 Jan 2025 13:53:24 GMT
Received: from os0p286cu010.outbound.protection.outlook.com (mail-japanwestazlp17011027.outbound.protection.outlook.com [40.93.130.27])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 443j0h99e2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jan 2025 13:53:24 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WOqFsCFkD92D/M+4iSH1DJzGtjUPtTUTdOQ6Ue4JPWYiG2uAmzKe8nt5sMGvrWB0y76UkrpE3yk6eRPFTeVIPB+C/cR89fvrP/UaHS4OjbJSwZxjW9IzsXGznmzRJGaj8DU8BMfvH3j2WnNPHbwZmTwN75oeFuGexvYp3a3jqwa18kgqp59hR2ezaS9Bzahz00kft0VwdVj1bKX739WrBzpK+D9HeYVrUpy1pPvKsU9PqOIvuiTgrTA44oTtA1+y7Pxpe2L5FYkoT8c/F8kisMvaanCyQUguVg7DrEi7FiKouVs6uEcFjGnVmzmN5ZW+sl5RgcwqsbTnCPzUjCEpwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J/pB+rsn/cVfQwsMJPTdplOIzwlwheRUxYl+1olAuuA=;
 b=XEHEXj+d4kP2GSq0g8dpD/BKe1GqBENDoNAD9T89ctNSt7Fp3cMkG2FcMuaDrHkwK+U+chRF0vV5w6itFRIBof0qUCEJnFocBGBT4UYJXw70+AR+S4nQIOytPEjzTX7t/8DnQDRKBb5TpJAAV2yCRzySOQjn29J3Wbe91k2QHmFobwOcPe6qZewczHTs20x/IaxbNAV1Pg/hPkml52I8T4SKby/MMI/0zTJFYjoP1FpyyLb0xyrYRa/NT5hlW/gU4VlyOpYKegTV8pd3ZyxcRUAcJTuo36zdqZKlBvthtBZola+qEL9YsNP7rzvemclLQnvQwRNZVFbnv9tY8m9B2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J/pB+rsn/cVfQwsMJPTdplOIzwlwheRUxYl+1olAuuA=;
 b=q2cb+Z0+FBfR41WO/peGqUew+9dMl2AVpOsrlZPJuW9g9i926YfXg2svZbLgolMjU3l0CNOcspMakeEJCv/SWueYhxN5mKIYDS5MgIA/AxvfLlrAuBCXKgWmCTA2itYHCzvphK+bN4SJqJeQ6jFL6lF6EUES5uAsWFyCc08cfd/ynRXpFcLSX90pvPxvm1BOY25KOO5gjrUAbrSajXMjI0uS/S7bpx3fRz0DUXTy2NWZkNZU7QxegOBTMeD5IVrylNmmly6vboiEljStpEsODbdKF4hy1lItRSzwjrL20w9qUc0G95KgwgIyqrkTUROnvx7lFADRopL0+Emc+isDTA==
Received: from OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1a7::13)
 by TYRP286MB4735.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:1ac::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Mon, 13 Jan
 2025 13:53:19 +0000
Received: from OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 ([fe80::ff9:b41:1fa8:f60b]) by OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 ([fe80::ff9:b41:1fa8:f60b%4]) with mapi id 15.20.8335.017; Mon, 13 Jan 2025
 13:53:19 +0000
From: inv.git-commit@tdk.com
To: stable@vger.kernel.org
Cc: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 6.6.y v2] iio: imu: inv_icm42600: fix spi burst write not supported
Date: Mon, 13 Jan 2025 13:53:07 +0000
Message-Id: <20250113135307.442870-1-inv.git-commit@tdk.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <2025011346-empty-yoyo-e301@gregkh>
References: <2025011346-empty-yoyo-e301@gregkh>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0213.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:6a::19) To OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:1a7::13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSZP286MB1942:EE_|TYRP286MB4735:EE_
X-MS-Office365-Filtering-Correlation-Id: e50ab33f-4826-4f92-92c2-08dd33d9a2aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|7053199007|3613699012|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hnbIyxN4AafvIEZtcKcjCYzBSbwTGLVw8YeA1GG8NIcaIUHMFY6PGjqJgIEc?=
 =?us-ascii?Q?lsmmQ3d4OkEUQg875oc5ZvlwJCYkFlfBVqOaK/MCxNJDGkd23+huRc5RFsO+?=
 =?us-ascii?Q?JFGZj3Z4ueB4V0RVgLP4WDj1Sb07nhhEFbJzUeCuAn7s2uO6+Bt7GxpYM17Z?=
 =?us-ascii?Q?PbIypUyN8vbMUFlOjnEMt9GQR/QitjzAiEaBLuXO3SoxrXHxAvplOrykYm5/?=
 =?us-ascii?Q?IkfCuMHHmysTcr3M9lA6oDGWIb51HFRRMBBZTFzwNpeH4stlLD3oOCqJsUYa?=
 =?us-ascii?Q?DbcIGS2WzZDob0NSuH6dC92Now67c4+Edthk+xDG2ZiDD/PM+DBy/NNWYVVe?=
 =?us-ascii?Q?eoeZlm5lpLH2n99/N1yHGd3zDiFscSkPpuRyHNAJam+KGQpugAKrKaNzD+xs?=
 =?us-ascii?Q?751uzYsiWOW/TyIZz8eNujw9k4Cg5PGdlaUbvrTi2rvToOGkrX0ZiM4l0HWS?=
 =?us-ascii?Q?QKSLpqcSTyqUcPZbXxxi9CF9WvwJA3gIY7RYF2AThgXIpuhCLhOW18NpHK0+?=
 =?us-ascii?Q?P8Z+7zcYCpHQn/Y07cWxAhRzM7atIkeL+h56rc1SPriOaJzVg4LVEFoOx3TL?=
 =?us-ascii?Q?z7+qtF9rkpZeGKn2HJXcpTcnf4WDHcH5yuqLnl97JVojFCjR3WElXtu2yRWo?=
 =?us-ascii?Q?2zgiZ6bJbh7eFYvUS7sE+Tg7p1NHJs2UaR8wWstFsi3TNoFW9Gd3gzwiblCZ?=
 =?us-ascii?Q?BQMLsS+Q5suhMNH5sy7uMg1ruQ9vQzasvucQ74TuLdhGoOCXu6hhD40/KYX3?=
 =?us-ascii?Q?2+lyY2YWgsOXabc8utpfCwMqmrtvtvq3RieWiFpE26CCo/4Oz2yRiW/V3oGq?=
 =?us-ascii?Q?VpBXHv+EXbS6Oj20o0wkk05D/I4OVtaHiPqQDafrbt/MuBpuPFQMyh2Ix325?=
 =?us-ascii?Q?g+xEwynd0/TWV+q17KMTpS9ZjZpIYSb9gJJYI0Q575jj8PyKgFkUTMAOBE6O?=
 =?us-ascii?Q?0KIj4naaEyabFSE0ldZR17FtM9JT6BGZAo5RsuALaV1Z3VcH9EbHSUrg1fgn?=
 =?us-ascii?Q?lyO1wMAiDUNAfvT6dbFsEWCtE8Pb8TEEGZ0wd1spKqhcT7NWOrRirGVgfIFz?=
 =?us-ascii?Q?DnISEU86Rtg5DXzODynVva/YNmdOFgLC9P6aYijyG4DgtaEvWaeKaJxVbyPh?=
 =?us-ascii?Q?eCaaz0GB0/z26Ya82p6tNUTDcB9l2zoa2T4JO8a+KO+H9KQa9FE/4Ei96nYd?=
 =?us-ascii?Q?QpWk2rDfMf1YmpjBHOw002KMnX6Hm9qCjApXUt40db4m52TMFyPi+zlIeYPN?=
 =?us-ascii?Q?+AMpNOAzf563THYbqVMkQS/ZQcX6dsOoJ0n1kwMKb7Ml2PUsf7MPWd4mwZ95?=
 =?us-ascii?Q?dnUS4DjTsfhiCfvX+YSXL1D1NpwxOckg7y6ryMmb6T4fASnrLohVcz3qs2HO?=
 =?us-ascii?Q?OvbKQIU8g5DvlA0jSVWpG7eBsT2jugVOcsCBOrjyGAMOR+1vRrdYUFIG6AV2?=
 =?us-ascii?Q?T4JvzL1k6f8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(7053199007)(3613699012)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?M4JAkYVY3eoTy2M7fnbc1mlZxRCTzsSLo3lUZW+aT3bUBEEhjcS3TSXW6/YN?=
 =?us-ascii?Q?nEg9ll+EMY9scv/XE9gqHlQTkRNDAo4N5MoQZVmWyBVqno64cVaVGQTZDnjS?=
 =?us-ascii?Q?6o7XLPBE7FWlydwN1LRjjHgoWpGNVP/9nMD+/lzl4O0VyPzhPtFSFph7uY+k?=
 =?us-ascii?Q?DNo2+kDbgOx6Pxc/3agwqdQkocZFFbbORHtcmpuUrS8V1x5iSg1XQqt3djW4?=
 =?us-ascii?Q?oveCiLrRMTQ9xnk9rkFcRQSDqTN4+wz6t1gYUnj3vNX++0XK8Uf4L7JWrflo?=
 =?us-ascii?Q?2MolyO0287rJYrSiztm8sPt5qJZFX0n+nUO90MFhTIe915yDTXV9rWgf1bLq?=
 =?us-ascii?Q?GqxJxVThgVtTbOfqfLNMwB8WcsfTI/lr/Lmb6iHaWSjg3lyb7htoXZweBKuF?=
 =?us-ascii?Q?vScyJw97Kts/8cGC3qTXQCa1m5kutXL58it3U+a1HF/MfdcJEbhZOuVGCWxP?=
 =?us-ascii?Q?cbzY+0v/OrAZA0QJ7R1atcdDmy5gdGhoYHOvn/rAc1xjAi0O3XBERhVboCDZ?=
 =?us-ascii?Q?n4WOmPix9EjqhFEPM8UZnXWIwf6aYw0qRh2G8aQnNgfEyKmYg07mSz3+srd3?=
 =?us-ascii?Q?AslpxU+uJWc+rGqd/67sXsJcaDiWaV8FxvFKrYXqn4QoKhYlmfzqK4z/ASfI?=
 =?us-ascii?Q?5lUZTTBMKAkrau+HqNYL0LGRxVfJ+NhFJlMy5eR3PtlzdSmlsMMPlBil1uIb?=
 =?us-ascii?Q?a28r6M3ZOn35uNWqttWurKaQiO85cSd1JcXKQlAXNZE1g4Xpa72jEtAnqKfC?=
 =?us-ascii?Q?0fm/Idp3B2If2egbzaRoC/kcVWqvo0UMGL+yiJbrA0KG2+w8B5bw6mKAIJD6?=
 =?us-ascii?Q?0IYz9HyWVZ4+7sUKgZ28CiAjJP0vMVcMJKyCg/qaE6z6xGzSImi+8gDCXXHD?=
 =?us-ascii?Q?9r21fq8Q1YFVXDt4oh0gXFS5Onlrjqd+Sw0Jp95oPAvrKV6Gj67OKoIfbx3J?=
 =?us-ascii?Q?4ZPdOLgCQLTjcz/9PioCEC+epW11C75q9y1EsBr/VJ9GVRvHHfkxyiYEcDvC?=
 =?us-ascii?Q?vN9FbgrywL07AatiFaHET2StNnB2uCbkqUI3tTWoQdhJNIEoRmRjX7kC5NxA?=
 =?us-ascii?Q?EZCwJGsA5P1k6Q7J1klqk66UXp3KCPltgtLjt8kiCzoVdl7Ctt4nLZCxI+tO?=
 =?us-ascii?Q?0lVIO2nAphQMUl2FmrU93P2JdgQKA3xEte1jcW3d/igZmV7I1btgP5/UNfv8?=
 =?us-ascii?Q?bDPrQntbO1/6ATTS4/uuFebc/UkNJz71+C1K21AgD5nMBu1Xwtdtbb+qAEPw?=
 =?us-ascii?Q?lbQphHmrDk9rz+ozAUMUZu7IUJyHZfvFONpbJ7SraQXwq1KbvhAi8LbB+6ek?=
 =?us-ascii?Q?bnNdwFWhrIw2rL3Qa5Z/3i5U1dj56+thKvtXCjoZ92735g2tMrkck2dzK/yr?=
 =?us-ascii?Q?szSSMzF8jNwll5wWcDbn249tp3nr6dQ6VNne8NNh1GPmvT+vpsPSfELUdBDr?=
 =?us-ascii?Q?zjxDuSF6kWQ518TmekmQsi2iXwaA0Bg312PDduRnQOhATGBMJvt89UZckoRw?=
 =?us-ascii?Q?UcecPNSFdA+u6gf0RtPRgdEaKtQyYLEO1LGH3RR/Ja2G4IXEaFywb2fF81D0?=
 =?us-ascii?Q?XJgSC5DWN/KYhC9+ae4Tk6WTfWt864Hlg2F8ae63?=
X-OriginatorOrg: tdk.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e50ab33f-4826-4f92-92c2-08dd33d9a2aa
X-MS-Exchange-CrossTenant-AuthSource: OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2025 13:53:19.0999
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LvwbJVZMbHp48eD/WYYSfTTQ9jEoVPdNFvF3heSeczuoFKcgUhE7pxltO61NP6sLpIw78UwAHsDF83ZebT0lFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRP286MB4735
X-Proofpoint-GUID: Sh_5HtTS97V9LSLfeyw4hC7FXXd9x4t7
X-Proofpoint-ORIG-GUID: Sh_5HtTS97V9LSLfeyw4hC7FXXd9x4t7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 mlxlogscore=999 clxscore=1015 suspectscore=0 phishscore=0
 spamscore=0 impostorscore=0 adultscore=0 bulkscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501130116

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
 drivers/iio/imu/inv_icm42600/inv_icm42600_core.c | 11 +++++++++++
 drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c  |  3 ++-
 3 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600.h b/drivers/iio/imu/inv_icm42600/inv_icm42600.h
index 0e290c807b0f..94c0eb0bf874 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600.h
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600.h
@@ -362,6 +362,7 @@ struct inv_icm42600_state {
 typedef int (*inv_icm42600_bus_setup)(struct inv_icm42600_state *);
 
 extern const struct regmap_config inv_icm42600_regmap_config;
+extern const struct regmap_config inv_icm42600_spi_regmap_config;
 extern const struct dev_pm_ops inv_icm42600_pm_ops;
 
 const struct iio_mount_matrix *
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
index a5e81906e37e..058f13447cd3 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
@@ -43,6 +43,17 @@ const struct regmap_config inv_icm42600_regmap_config = {
 };
 EXPORT_SYMBOL_NS_GPL(inv_icm42600_regmap_config, IIO_ICM42600);
 
+/* define specific regmap for SPI not supporting burst write */
+const struct regmap_config inv_icm42600_spi_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = 0x4FFF,
+	.ranges = inv_icm42600_regmap_ranges,
+	.num_ranges = ARRAY_SIZE(inv_icm42600_regmap_ranges),
+	.use_single_write = true,
+};
+EXPORT_SYMBOL_NS_GPL(inv_icm42600_spi_regmap_config, IIO_ICM42600);
+
 struct inv_icm42600_hw {
 	uint8_t whoami;
 	const char *name;
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c
index 6be4ac794937..abfa1b73cf4d 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c
@@ -59,7 +59,8 @@ static int inv_icm42600_probe(struct spi_device *spi)
 		return -EINVAL;
 	chip = (uintptr_t)match;
 
-	regmap = devm_regmap_init_spi(spi, &inv_icm42600_regmap_config);
+	/* use SPI specific regmap */
+	regmap = devm_regmap_init_spi(spi, &inv_icm42600_spi_regmap_config);
 	if (IS_ERR(regmap))
 		return PTR_ERR(regmap);
 
-- 
2.25.1


