Return-Path: <stable+bounces-205070-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ACF0CF8019
	for <lists+stable@lfdr.de>; Tue, 06 Jan 2026 12:19:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 151E73010514
	for <lists+stable@lfdr.de>; Tue,  6 Jan 2026 11:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 275D43254BC;
	Tue,  6 Jan 2026 11:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="aydPtYOV";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="M8SYd72s"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49D830ACEB
	for <stable@vger.kernel.org>; Tue,  6 Jan 2026 11:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767698338; cv=fail; b=Zom7fb7ySKQEH0KMZx+0nPjWRYeZU+ja8k5s2cj0xExXk2Uv/yM3M6RQH/LekzCxRKrA4fseUmOciMqksNnBj3naVZcsQY2kS+GEyrr/f29BhB3Dw26EcGpX3q5q+SnmdDdX7FJyIHkNetbwMaG99unypeBR72HX5/TRSsBbGn0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767698338; c=relaxed/simple;
	bh=/yenBXxZGhrPQ/+NLOoqEIVuRYPH/vem0t7pGaS8a0w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OQFWmnxIl5XyDdm+eyFHgUcTtjSYrh4ZVqNHNl59ibkuH8kV/nB2FrWXw2PmdQp5zkg8I534uEeJDALVWy5EEQqfD/qOyVGI8FDPqyR1OjGyCC0UTNpeqWxX2fLlL00FuXz1r6wdAUwbg0JiW8ySRkRAWuWqNg+vLH2Keljdth4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=aydPtYOV; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=M8SYd72s; arc=fail smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60648tpq220030;
	Tue, 6 Jan 2026 05:18:48 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PODMain02222019; bh=mydB9d2nvjTn5HfS
	vW9laIyzxWLsZPCNb/oDLF7Ijm0=; b=aydPtYOV1kB9jvRW/FmQaeNs5BKJGxvq
	B7S9AsgTcrrgKs6lANHhlw/rlF5R1IczU7rFlXZ/PXeSbArfrQm1hkSfdcM6OaJo
	xIvJgIIHAC00qSBJJxb4gIPG9lYt1wRdZKRaIXGs+yI1k28j5EpbnXRcUBxmCTQb
	Q55EpacUBPlUeqdpjPNAHd4i4TYxlitZNY45F4JeLAESyS96HdylQJqcx1jdcLT0
	WHGSbwxSj6B8XTgLGGd8KyU81U/8wyAOshwD5BFdSFn1H2G1BYXyk5WvmHzYp2j/
	1MRznGIjkEM+8bwRyhMTviD66SivYo7iCRnub9cYST74XJFj329dKw==
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11021100.outbound.protection.outlook.com [52.101.52.100])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 4bf0dntuq4-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 06 Jan 2026 05:18:48 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pmejvx1PvI3Wo0G088ihIBr8hIEm28IZJSI05lcwgbT1Tg4RwJwbZSsVu8Z1mNbQfwAYPjtfTFR9kaEtekVOyHzvTiVPfnl0GLPl6kO3Ya+5Y4PjIyI/DPk5zySbxHx6Dypd5vFi5v01GrsfKzScJZSYBPR0sZS3BQxppbpcOgTo9MBWkNWetoEj7UtR3YuCsFh+/xkJFgYfjl2rP7NKUfFpuJH9ZVeTD2sjFcYQc+/cL/r8/qkK+egV9Vln/TwKuhr0Ge9Jrf00g7rTF6z+HOmGo+z89d9az10nSfpATgChxdnqj6FCgoMGZ2c1kK9wJ1lxz3jIhCVuQ0SmiJXgnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mydB9d2nvjTn5HfSvW9laIyzxWLsZPCNb/oDLF7Ijm0=;
 b=E1Iy1E2WU7jvoyboa6oTaw0iPhzRFQPw5B0VyIRHLyeaCrTqMOGTDkDivzwxMQrNrbvt8i2IZiSmQmo4F1t2g+Tq+dWdNZ0IoxjPdQ5j5t2lh2U3Yw5Li6QBAZgjw+loMFLmUioQyvd2HDNMzLE2ZCliikllYrUxZkuDXAQgjggGzjBmrqQr6j+Y1leN7CCsNQZmls8YbsVXIc6kkbp+Gbo6Pp+CRqx7HfBvk31AMiegJ0QjrzW8ssTfglVkM3ZLPhfVUoff+WuFk3+NZXW4SKSgQQ+h2pKiFM0iZ0ui1LOe04vwZ6AKlT0D19r/voH/gQ3lt9P8IAkO+rH76E+NUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=bgdev.pl smtp.mailfrom=opensource.cirrus.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=opensource.cirrus.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mydB9d2nvjTn5HfSvW9laIyzxWLsZPCNb/oDLF7Ijm0=;
 b=M8SYd72s+4b8ma87mupP5HSAmGYLcUaC7gsapwdcFpLT0jjhAicCAoOm+8E/lt7xhOtygcc8ev2INmd2IiqArRV+ITdlJ3zCsPfJUQbg4urPZ32Puw6wzT11U5FQDwZNOHiPukXT5KQAE2EhW1tjgdRRltmVwlIQtUJGV5xckEI=
Received: from PH7PR13CA0003.namprd13.prod.outlook.com (2603:10b6:510:174::14)
 by LV8PR19MB8269.namprd19.prod.outlook.com (2603:10b6:408:191::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Tue, 6 Jan
 2026 11:18:44 +0000
Received: from CY4PEPF0000E9D7.namprd05.prod.outlook.com
 (2603:10b6:510:174:cafe::d8) by PH7PR13CA0003.outlook.office365.com
 (2603:10b6:510:174::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.2 via Frontend Transport; Tue, 6
 Jan 2026 11:18:42 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 CY4PEPF0000E9D7.mail.protection.outlook.com (10.167.241.70) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.1
 via Frontend Transport; Tue, 6 Jan 2026 11:18:42 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 8EFD1406541;
	Tue,  6 Jan 2026 11:18:41 +0000 (UTC)
Received: from ediswws07.ad.cirrus.com (ediswws07.ad.cirrus.com [198.90.208.14])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 6D3EC820247;
	Tue,  6 Jan 2026 11:18:41 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: stable@vger.kernel.org
Cc: linus.walleij@linaro.org, brgl@bgdev.pl, patches@opensource.cirrus.com
Subject: [PATCH RESEND] Revert "gpio: swnode: don't use the swnode's name as the key for GPIO lookup"
Date: Tue,  6 Jan 2026 11:18:38 +0000
Message-ID: <20260106111838.1360888-1-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D7:EE_|LV8PR19MB8269:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: a3e02c76-3735-4b48-599c-08de4d1559e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|61400799027|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3ifF+DkVqpG0g97oy06eTD6m7ZsYKvJiKvE6ZABUcFzgG/H8pNxxF0pzOHmJ?=
 =?us-ascii?Q?1rmyeR5iOadjRULuvjhsdGFGSaIuDzCMrO417a++T9vdGU9ihwx0xH742bvV?=
 =?us-ascii?Q?vNSJArbNf28SEhlATABZM1eZ5p2kWyy2er4egogCypSFRdirvWkKJLglElO5?=
 =?us-ascii?Q?OIG9pAZZman69aNu8/QwqeVL370izqProP5v+ofWibZrBL/DCPUccCGgkxqP?=
 =?us-ascii?Q?+eTcj9w0jDI22bk4Divs+Dz5KlDgxYT4fWQj5wHaUgVou9YrYGtQqOJAL4X2?=
 =?us-ascii?Q?z5ARuwcECps777fTldJJMgwAfH1LfPJEiuYYzSQKEgde+u33Hn4cgws7XE8F?=
 =?us-ascii?Q?CV3yzNktxgJdp2dw6wmPAhUVVU1pFn39T9sICfDEm0JtmnPORUJoBx0dAPQc?=
 =?us-ascii?Q?/wbhT8eFniP5Bk/Yg5Q7TJc0Bpw+4JYVXEG9h3Ei1O68c8sM7bajKzBwKQ1a?=
 =?us-ascii?Q?0oqbEtKTxOTyftzhD8Er2eDqhjQChA2QjPz3R4XPPyko7SaiizzyFb1dcqp6?=
 =?us-ascii?Q?Fj185v1WbwKjU57G8jVcD6FQ4qitdwbmHRbnLNH4PKDClR+LybLR+bBdn1Ux?=
 =?us-ascii?Q?IL/2BWJJpP41s2mULs3ZGHIr1o0kwWcQ2YRXzwUEgZoZmvoC+P06XqlyaKs5?=
 =?us-ascii?Q?7NFbgxxnDDmQCW7+qMTP1ex68ewwXMjFiMtvKlkw6b0nFbAx74v9KPZqeE58?=
 =?us-ascii?Q?lvEzm8l/yvi4GzutP2PKZlT0jQNNrfLtqea9XKUY1CHHLYJ+Ab3O5n1TrQn/?=
 =?us-ascii?Q?3ptfx2geykcEb3nOlgefTZROEJa+KlVppj3LPXgF0VPb3tkKoV6o24S1Bwqw?=
 =?us-ascii?Q?/67ODwo/p/T/C35KAsIYBYSXFZeCIbdkUTVGjZkcQ6dk1yJpFB4OCXKKlhh7?=
 =?us-ascii?Q?q0VWgp+gjO8HSOod+SsvSLAH4yEBuyGhmn3lQdpz5JjCafT7FLkO3SfiA0nA?=
 =?us-ascii?Q?GJaAtaG2j17Uqlig2XAmMX/6ql7kLr6AdpZJYDq2ITgvCnJVPR6uq5i7wa9v?=
 =?us-ascii?Q?rDAeeAfKfeJhW1jRlsTaUSbqfkm+DGEdbZRiRWL1IOzQ3p1viSwOmzGqw4DX?=
 =?us-ascii?Q?HTzdxJ9IZgj7f7xRFOL8Wa23k5zCCs07VIAv7nHfvdTkl8ri2j9gBaea5+Sh?=
 =?us-ascii?Q?qPtyssih1j6tUowlqojAUh6KV68x7gXcI2w0zkfV5w8Bjpp1Q4bt419K/8g8?=
 =?us-ascii?Q?GaruQ6y2qHn0VrQV74Nf5H6OgFRvf3aPgwOqdBwnYP4wFsQ9IsOEOgTX9j+S?=
 =?us-ascii?Q?QP9LFDS3pekAfzqFwgXsARmyd1lttjzxfmXof15oo5rTl//wdTeubrJVtExH?=
 =?us-ascii?Q?vy+jZd2nbdWpGt2GWhShgbxW5LeQvJUxddjsW2sxk10E1ipdmrEJ0H/Oc9Yh?=
 =?us-ascii?Q?aUl5z5IZ6ZAm/CuYnMNTtG5I1g5iACIb/gqPmHGFkjMNRL3QvVFjywxU734o?=
 =?us-ascii?Q?kKTxOWzaaWrxLk58S0dpgLSrFIoNLZbrH+YTm2Z1+VtkFwtI/4Ux7BM3WIOi?=
 =?us-ascii?Q?dUjIi8k3pXqo2JketUwrS9Gvz/M8xQbWbmnVi8mERnqW7m/UE+OX4Sk4UB8Y?=
 =?us-ascii?Q?Tu2Ru5u+gzy/n2utC6U=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(61400799027)(13003099007);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2026 11:18:42.8014
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a3e02c76-3735-4b48-599c-08de4d1559e4
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-CY4PEPF0000E9D7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR19MB8269
X-Proofpoint-GUID: YBE7_YESubysJjZ4OCFCdQ0EdySKNdXh
X-Proofpoint-ORIG-GUID: YBE7_YESubysJjZ4OCFCdQ0EdySKNdXh
X-Authority-Analysis: v=2.4 cv=FscIPmrq c=1 sm=1 tr=0 ts=695cef98 cx=c_pps
 a=oHVU4+OBm0glsEb2BXLEfQ==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=O_mYIUxG9PxvoMOS:21 a=vUbySO9Y5rIA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=NEAV23lmAAAA:8
 a=w1d2syhTAAAA:8 a=1LwIm-yovOpG0Fd6MUkA:9 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA2MDA5NyBTYWx0ZWRfX7t1KLwUNq82N
 dAnGYrrvTbzLjJ+rOMtIgwk4Z5B763qHxc0IY/YDvzNt3w1dLh9sFg3K6FHA2tSPqlzknyB1E4M
 fluHbnO0bgi6hVzTCbPrXuDMQh3TjvUnuDt4LE7Nq58qszytydJ0gL9cjDo8c9bvIVFhSUHWVXw
 3DGStnFe4cMlDayLq8jKJ9p1TAVBzsnxhCaBbFjGpMfX0AkJfOB7Tf9m/+re9GySx3PcmSMEz77
 wdLyVtu4W8f4MU/aI7FGJ69cFdGjXZQ/n4gSs3eUNL8v7QXUIezTb/WA5OnGLWGc9jBQiyk2kE1
 VhJnyJxuu+rgm3wAl6KhgYWAyndQ1Bs4zDvJNDFSJSzXhDcJCeiayIa44Kx+xTNQ1bClIDaMInK
 LdxAesGccZJ0/Heli2GKFePXCD3PtWc/I+cIBQCtWjmQSDBG7lZ2E48Yj2k/kWB/50UjdlQXIks
 aTMjnWWFoGMuGGQqmrg==
X-Proofpoint-Spam-Reason: safe

This reverts commit 25decf0469d4c91d90aa2e28d996aed276bfc622.

This software node change doesn't actually fix any current issues
with the kernel, it is an improvement to the lookup process rather
than fixing a live bug. It also causes a couple of regressions with
shipping laptops, which relied on the label based lookup.

There is a fix for the regressions in mainline, the first 5 patches
of [1]. However, those patches are fairly substantial changes and
given the patch causing the regression doesn't actually fix a bug
it seems better to just revert it in stable.

CC: stable@vger.kernel.org # 6.18
Link: https://lore.kernel.org/linux-sound/20251120-reset-gpios-swnodes-v7-0-a100493a0f4b@linaro.org/ [1]
Closes: https://github.com/thesofproject/linux/issues/5599
Closes: https://github.com/thesofproject/linux/issues/5603
Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---

This fix for the software node lookups is also required on 6.18 stable,
see the discussion for 6.12/6.17 in [2] for why we are doing a revert
rather than backporting the other fixes. The "full" fixes are merged in
6.19 so this should be the last kernel we need to push this revert onto.

Thanks,
Charles


 drivers/gpio/gpiolib-swnode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpiolib-swnode.c b/drivers/gpio/gpiolib-swnode.c
index e3806db1c0e07..f21dbc28cf2c8 100644
--- a/drivers/gpio/gpiolib-swnode.c
+++ b/drivers/gpio/gpiolib-swnode.c
@@ -41,7 +41,7 @@ static struct gpio_device *swnode_get_gpio_device(struct fwnode_handle *fwnode)
 	    !strcmp(gdev_node->name, GPIOLIB_SWNODE_UNDEFINED_NAME))
 		return ERR_PTR(-ENOENT);
 
-	gdev = gpio_device_find_by_fwnode(fwnode);
+	gdev = gpio_device_find_by_label(gdev_node->name);
 	return gdev ?: ERR_PTR(-EPROBE_DEFER);
 }
 
-- 
2.47.3


