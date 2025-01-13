Return-Path: <stable+bounces-108460-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ECB3EA0BC4D
	for <lists+stable@lfdr.de>; Mon, 13 Jan 2025 16:43:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E58FA1885613
	for <lists+stable@lfdr.de>; Mon, 13 Jan 2025 15:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3287C1C5D63;
	Mon, 13 Jan 2025 15:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="CexOvynM"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00549402.pphosted.com (mx0b-00549402.pphosted.com [205.220.178.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E515F240221
	for <stable@vger.kernel.org>; Mon, 13 Jan 2025 15:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736783010; cv=fail; b=JiXZSMALI6G1RiphSFHWRurt5tA1u7f0wh9CZ0sZfuI+XNctWfOAJIC8WD3kCZr/WESGNZadYz4XCVzC27ZlaYXET7YHWkgPfI647t7aWcMMkigXj23NTwPmpuR4ouBk2RmEV/R8hGBXRG2rN3rl20rob+7s/RiFkQCfaTvLFvo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736783010; c=relaxed/simple;
	bh=9EyNB1lHcVMqvZOZdAVpDu47SlbNctQZ4E4oyH5zutE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Zx1vV7m7BGslSENO+1eM384ke5Jo+rhs6s5ozP2GsaykAr7w6TInFRQBjnN04fDO9GIzwXjWU4G8PE17nidWvzuUySVOaypcGJQosVYJzt3r73fz2PgZKsdsvBcI1IxsWMKHU/AFwB8NG32bGzJB1sKxR/nKMy+AIYiaXI6ToQ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b=CexOvynM; arc=fail smtp.client-ip=205.220.178.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Received: from pps.filterd (m0233779.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50DBspO5004537;
	Mon, 13 Jan 2025 15:43:23 GMT
Received: from ty3p286cu002.outbound.protection.outlook.com (mail-japaneastazlp17010005.outbound.protection.outlook.com [40.93.73.5])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 443j0h9bau-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jan 2025 15:43:22 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yixTQpwoPKZt/SDaEkOKvhUQQ8c/mIu7iP60YqY+tgmWcai7neotlRxH04Fqz4jhAPYAobkyG84QK0ONGpgYBItmJ+ebQ0Ey+aV0FX4X7V4DEFla05Q2GTzh/LKuoQ0HPTR14WyvVfrDz4q2rnYTrZ0RYs5e36BvjZnBqLdwVN3/cRO3gCVgGrxEJyX3aBCUN5yBwkq74vCcdKmGWyiRhuu7Bi5BI5s7a2v3S+k73pQ1J4PQchbJFc7AVZ3jUAYCEHB1PHj4W1wngYbfcepmk+vOwp0AABrsTqBh/DwNFcL6WmZaXRt9XjtvVW8pdzbncrKzCWKa0jw6bb0/fZWagA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3BschlfoNoYHXvHplOZOHHN/7BqXnb5cUS4mJNG3QAQ=;
 b=KnjoX22vKzKRbZE3ntf0qQCCIoPA6teLMYoOCRYgI/BABOY9yL+WQDLSOC6yosl4WnbDVA0z3jgBmJfTl+DoWAVv5TjYsjCVS1/YlytXZ+nmuAnS/x3T/UvsBsOgWKqZzolaN53PHHvUq4uNDZhT3IMk6jwFnyI8YyQkBSYKJUdoRuNkpl6iSQ4C+qyYLsbO0dU7ajcag8sIJevuYeXoyNiqXEun1KQHJ8kxoeYx8aAT7CTk74aI+77uYZ2FS7JFGVr+LMKTK9cllWgIEABsfN35jws1yvzCPBkLwOeKtUTvnlsqNGNpQlooHxRNwRMhFk3qgVyj01dbdev9QHht2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3BschlfoNoYHXvHplOZOHHN/7BqXnb5cUS4mJNG3QAQ=;
 b=CexOvynMWuHk4L/s+Xt6LLjvmjql9YUsrv8DgYnbKzRtGllrwjFnZF/GAMPqbijFKdKyBi/S9weXWwi5dDnyJY8s4e2qRQcwivYaaOUD3OFZc41iOWsURB0dYFlMucSiFNskykwaExH3CnYZEGLT8gjkxMWLmw45kiKa0aZvwXCGk8wOYC2SVxcNLnE08p3jcts/aSafixkQd3COGgsdzJUVs20iCbIuxCfy3vdOuKh/6AIJL4aXyTh4CUwKUy+VkLyUioqj3wLRjvta/gKPPTRMisW5tP24HsPpSnAXkI3SdgNo1rfGQBPwlk74v0AzzFAvhnB52GJylpLvIz9dNw==
Received: from OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1a7::13)
 by OSZP286MB2394.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:158::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Mon, 13 Jan
 2025 15:43:15 +0000
Received: from OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 ([fe80::ff9:b41:1fa8:f60b]) by OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 ([fe80::ff9:b41:1fa8:f60b%4]) with mapi id 15.20.8335.017; Mon, 13 Jan 2025
 15:43:15 +0000
From: inv.git-commit@tdk.com
To: stable@vger.kernel.org
Cc: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 5.15.y] iio: imu: inv_icm42600: fix timestamps after suspend if sensor is on
Date: Mon, 13 Jan 2025 15:43:03 +0000
Message-Id: <20250113154303.834996-1-inv.git-commit@tdk.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <2025011306-sedan-synthesis-c459@gregkh>
References: <2025011306-sedan-synthesis-c459@gregkh>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI2P293CA0010.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::20) To OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:1a7::13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSZP286MB1942:EE_|OSZP286MB2394:EE_
X-MS-Office365-Filtering-Correlation-Id: e9dd22a8-265e-4f4e-6add-08dd33e8fe65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|376014|366016|7053199007|38350700014|3613699012;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qkSrfAz8HgunqHn28GpOGCgjiTEqxRRk5mmLkILxQHfDRPEV1HKQge/K2Yto?=
 =?us-ascii?Q?Z3G4R0OxuiW//JZ58WIsvjeThWubdYU+Tzo2IqOXaRhZONt2fBtpea8m7pvJ?=
 =?us-ascii?Q?klgZR2avY1iPt6pMYfi+4h4QrGwmwKo1BJ6uMchFv7QHkHV+FrtNgrfPmKgp?=
 =?us-ascii?Q?u8vL+i2Hwxx358UJBxFlmAZwSG4jFoabIUlbuPG284l3n/cmGdz8KdygaJnr?=
 =?us-ascii?Q?EctQ+QktvdvwcQqOuc6tG7o31Nv8FP5GaSmvAE1KcV6Wn6ZCSSV+JcgoVHxu?=
 =?us-ascii?Q?gyoGW70AzqvZY9b61w3rvzaJ8pXsZNWaROB0EzH9UuawlxQeNDnYm1qT5flm?=
 =?us-ascii?Q?M+Pph9OALQJbg2Mqlv0QPgnkS+4sEJRhgPahAXOGAFJxPXdswf+6Jc+khdQU?=
 =?us-ascii?Q?EZ1CrEcCNqNAtiPNh+2GtbHT9R6EHJmHPAlOfgdPD2mFJqH/PKAyoFGoQ0WX?=
 =?us-ascii?Q?Q32ex2Wd41nEdctWYDRBsjC20Oed2xNgZLYLJ9avDtjdeG/xtXK3JVky8Ole?=
 =?us-ascii?Q?NYKfkjxY7amn/hPji6yDxhxo6zJNI0FGl3DiiSJk79q+dkJOyibuEN+8v9tH?=
 =?us-ascii?Q?Fk1JHkajDlVypaAQv37Aom7VKtd2XChbhZO+RTlOwgmwJBLXyNcJjEvVpyc2?=
 =?us-ascii?Q?rl7odymGnVR4dEcoVK/BSJbkC3bv+tXrVVDenQxo/gNWErJwQnbvV83SgN7c?=
 =?us-ascii?Q?z2tV4iJ+v5N7/dOTo+zPbNbJuIK+3bSEYs0+0/XL3cZimotLAzWzCxTHt5uS?=
 =?us-ascii?Q?9JDKYIxZRKVL0RGQTwnvZn8yRN62A4Y9C81eGHO79agWcO5QyzsLmqoOdtiQ?=
 =?us-ascii?Q?hkiJNygsceb2XuWuvWveZVNekiSeV618iOrHVxpPZfgoYLTNruZHAcOlCl9X?=
 =?us-ascii?Q?Zs42iBWrkc7ZJfQf65VSFI64YvJW4AxiExRZH1wLmeSWOEaj2sSN1IkoGfZW?=
 =?us-ascii?Q?041dDRryQPF4jXQq+TyXBBdh9LvFwJu3pJsO6x2hdc925L4STjKXi68BeLYz?=
 =?us-ascii?Q?WXzNCvh4lJYXS3fjI8n0545p7XFJITaMddn9JCz7ZuW1LRPE4CCKBPbCIBVR?=
 =?us-ascii?Q?d4W6/ToPMm9lwnKuu/GZn2yeRJjCBO94ygPrfp6fPXiITBVbOwXKrz3uyJym?=
 =?us-ascii?Q?qs4Mwe0BCdc/GwjGdLjA0hZ1BY1MOS9jxw1SFDY3BSM+VfuzMdCGjLLMS7cN?=
 =?us-ascii?Q?sfG8gPt9Is4l5gnvcLER9NZSrD/ISOHxY+l87Ufhw/JCiQyMo+/0NczdrmRV?=
 =?us-ascii?Q?4T4NqUk8Phh+q3NSet0UHNG+UbY2kNOT0WBas2SUjwTnzChpffYEXFqzs3GT?=
 =?us-ascii?Q?rNFf3s+prKOfhR5yzioFAXVL5rUUAzwstaijJzWOZhU8Q8ZO7qFUBH+9Jbio?=
 =?us-ascii?Q?3NWlUSEyL9O5aoofjhA6ALi4CWnseKYgAlWnxmdxn2+YRCppaHl6XQ+0UkNf?=
 =?us-ascii?Q?p9tv9MFy/38=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(376014)(366016)(7053199007)(38350700014)(3613699012);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MMu6BIoS6UO/ChgdxGfRrQ9u/UJ52LpDNXxUtae3HFUht9e5a90FqYcc9wjZ?=
 =?us-ascii?Q?BzPFhM1HmIlbT3JwE1HEwBlY0aLXH6aSyLvtEK0pnUecQYx4DUXARSfk1s5T?=
 =?us-ascii?Q?8Ksl0MW04T5pXCMsvisiIQabUliNNoXA5rWTTO9aEynX1wlEh4WvjdDd8hH7?=
 =?us-ascii?Q?AEdZaNJ6jw9EDmtRX66WV5nuVq8RLUJ4MoJvhNfqRns2JzSDRuuwJyjVNYtz?=
 =?us-ascii?Q?dqAeHnMU6JSA9jkmQL2UbOf3B20MS9Ufd6gnY0yfvPHyy7chVFZSA7dcCKHt?=
 =?us-ascii?Q?KbJoLJ4IkaFo1vJBsVXp8NEJvL50xnCYpU3yNWG1En6lpP202O+oxUBKx00R?=
 =?us-ascii?Q?CHc9xYNNy85CzJrSlKtP7XXia4M55y2G+jRSMsOZSlupGxMYKpysQQcOrZQw?=
 =?us-ascii?Q?qOFRJaDkvnTF+Njpu2o0+YZok1hwuxHrQBvWDF1aRqi9w3h2HeJ3EGk5lx1C?=
 =?us-ascii?Q?C0J09WuQuGpZ59H9XkQKJ6wSVjsRCqHEItbL9eVGDaZ2qsyOK0+4LQkQQ0ID?=
 =?us-ascii?Q?rg5srS+I1jFMIusK+LDXYtcZFqncGgEUjw4HaOo37MaEVC+xswhgceHx4aVt?=
 =?us-ascii?Q?5jtWyvzhqBtEUKJHJI15Gv+94/J+uiiaqC2BQCTN95YcQBmEQNiGTK2d46oN?=
 =?us-ascii?Q?IT9IQgxPzs+qAmU6nLdGqBO8Zay5gKzenzooqsqGHC6kKdCpFlWHttyZrtGS?=
 =?us-ascii?Q?6PxfcwhmZxo+02+7eD2N2P3r3C7AEyC1HItia7fLu7+hNTvHetlgQHcD1z3v?=
 =?us-ascii?Q?ScLHDmaCgm7t122O9UXNNRpe4Mvi77KW8K2YPHjUgmuEJbT6cQg72dh8cVqT?=
 =?us-ascii?Q?5jP/9xEtlvhou2UcyM3jJZtHEp9ArtYeYcY8h//wfLUNXh/8OrTJmu4niELL?=
 =?us-ascii?Q?OJ6CglkoJYYJPXjL0Q8tq/LBQRmCiITLMHPcJSGj826okYktiV/zcHNejZYD?=
 =?us-ascii?Q?uc0JAd7f+9emDb0Ax/6LhNrLtM3m1ApnqskMKw84E2GQsB3W6RgDUnDV0bRT?=
 =?us-ascii?Q?QRiXmVh6SJpDg7Y0FgP5DhmesYnQbeKTeUJ+xXOYTEf33bK8PAMory7sxJ6l?=
 =?us-ascii?Q?k6AnnwJMtPIWKZUT4FU9m3H0NbxigmKFUeDOseLwatJOnZ+5fGd+/Pr1ViwN?=
 =?us-ascii?Q?4VKsdJbY/mNNFhXvsZLRVDBCZQ+3mzSOniGluoscyUz0u3Hv1NIojde+5gDj?=
 =?us-ascii?Q?9odZH61rJsGWMFdlF8pfgWIa62O1rWDjVs0AE5GvqW2YE3OWW9SNqS93u1/s?=
 =?us-ascii?Q?GjmC1Df4Z79IG9EFOanDK7jZHx2LJzu/UhvFAKbRY++Wg3tfnzytq9eTkNzl?=
 =?us-ascii?Q?XOX3YMq/JcQwQyFTIM1nl+P3xl/HnsN6N5dzrmNraEn24W2r3TwwvyNiXoy3?=
 =?us-ascii?Q?DkpCGz+zZoU3oOV3TnzlUx0yejTjOEmntpmUsAYf0l0uGMZdlgJu5AM3iMfL?=
 =?us-ascii?Q?06nAz/acIERl5a+Hzfo7melvd0dYHW9vMgzZLIQJI0wpqzByZ9+JFhXdngj0?=
 =?us-ascii?Q?38YhnuPabjmkck69806Vihf7M/LYbpXLqBe6V/eZqtZMj1GASqXKqIOib44l?=
 =?us-ascii?Q?WQbnca9R0Ed1ncikVLik2yv6gcLuT5hGJ3yM7/y3+TFLAjCDyRZc9mOs2fja?=
 =?us-ascii?Q?Qw=3D=3D?=
X-OriginatorOrg: tdk.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9dd22a8-265e-4f4e-6add-08dd33e8fe65
X-MS-Exchange-CrossTenant-AuthSource: OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2025 15:43:15.3476
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cfaBYqA10kKnHeabfkynQdmC6Wz0loHqL29w9Y0eduWhU6pl3G2Z1VhwWGA7ucAvwcxmPa12JU9/7wMdoHKJqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZP286MB2394
X-Proofpoint-GUID: MTWE7s7lJav_Ds5reAAYr7_jQgSKSP9F
X-Proofpoint-ORIG-GUID: MTWE7s7lJav_Ds5reAAYr7_jQgSKSP9F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 mlxlogscore=935 clxscore=1015 suspectscore=0 phishscore=0
 spamscore=0 impostorscore=0 adultscore=0 bulkscore=0 mlxscore=0
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
index ca85fccc9839..6ffb67f6fb7b 100644
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


