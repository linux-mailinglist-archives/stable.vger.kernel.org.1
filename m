Return-Path: <stable+bounces-182000-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2972FBAAC46
	for <lists+stable@lfdr.de>; Tue, 30 Sep 2025 01:55:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9DD217E6C1
	for <lists+stable@lfdr.de>; Mon, 29 Sep 2025 23:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEC1523C506;
	Mon, 29 Sep 2025 23:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="F6m0vRLg"
X-Original-To: stable@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012021.outbound.protection.outlook.com [52.101.48.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B60023A562
	for <stable@vger.kernel.org>; Mon, 29 Sep 2025 23:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759190112; cv=fail; b=N6L2sJAaTjFk0r0tkb7Lldi2f/ZuDK1DdI5+NP6UXJWZw/J3GNB7hqetUrrSBUxX9XFj/Ru/TPf8DqkNYWSBBPP/k19JRsG231QzdIEGFNn66Lfr4zUhiA4cp8WdZRmEsCuPVgDNHJJ50k2T2ypXsJ6fw4UahLTz7OHp8jdwnik=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759190112; c=relaxed/simple;
	bh=d9ozbbPNGkrGZgtkbQU2E6EmzNFwcTIvxuNCvTDZvu0=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HyPJLC28H55AeoOtbXzcTBw+d4QuG3g1kJJNOLBFmWDMkb4QxytsVJ4CQ+BxxP7HYjFYfKoVAflPUpg8JNx9AjovKgDYgKLHkV6PhYC/HEpvKF4XKHgjPsCQkCX2B4DLmwBauB/DW8BfQCs8VXBK5xF7SXTNDX3jd2BT5Nq63Kw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=F6m0vRLg; arc=fail smtp.client-ip=52.101.48.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YR6gKkC70rs9gZdn5VQ7yX1zcjxTujyZR6BoHaqum3cMWh3mfr+5hzDX/pJCMpLFYHXkDF2EtCQLszCunv+KUYfBItPP/uy4IixU32pUinvhOlSS7vrAYaXmKDe+Q9oIsPXrt1YfiC4dKfxOp0rmB2kKTC0KViDx0VNq8Dk7ilTVshu/82K3BOA3zq/WTLzIOe2F5zFcLX1aCSk/LVXiLBtfYM7/p1xjxfAt3OGie0ub1GZGLE1RBMxYS+WBj8iSUS7CW9aw+e03k+2urJantEnR02Gdtf86VrcfHZT2I+20Ad93NlEyGzC7JnxRXbbS3Ab0MWsDLnsHiI4fhWt6+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0X3fSky/R9J4HTlQQ8McjvT6jbf8ZqI60AzBf9koizo=;
 b=vwFxoWsH4x0D5vS4BEK2G/AUuKA1FwR4KWtObh6GM8R80mW/WtfqwW4G87k7khcEiahUDqEu0Htg5F9ivlI6GFc5JwxUsp4G5zwu2ptjYt48K1CsbhceWoqKkFGOYMnz5zqpg2y41cvTNgfieHacVIsTKiMS40DEzi0wgsv15r47SP0tb/y0guBXvMFS11G7qwb3qLnPUlAEU5JikgAogO4MXcc+EZ2/rksEG8dB8OTPLCqgVtHG7Xj/nheO+8PeZSn+aMzJkvcRooBdlOCwF4DwK2lxD9Zs/MD7uwSyCxIoRom82gyIWmNEF2d50Q/j2d8kzcPYgPtFJWKbEnh3UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0X3fSky/R9J4HTlQQ8McjvT6jbf8ZqI60AzBf9koizo=;
 b=F6m0vRLgRqh3COnJNLbxvjBtSIuJzfTrDwhVOFW8XY1FzjqZznbpmScqM3hQ67F/dgKa3pOcaW3qOTjL/BUuhz8De9k2yNi0Urhak8V5VyTDGP5L5CqcZxAlPrh/WXjrl/47XTFjZx+razUpBT1qXT+Nb1JSe7PQwyuG90UNmNU9xdktNgBFm85DcauyHIR5Bn/UcIOd2FcF1jFqRO9dXpY/Uaf0vnRID89tqaFpOtbeAZ4O4bfUl28CGiWhOtW9WDodzOQUbKt7Hw5aeIWoHQlflobk4iM8JOghA+OYWNz1dPTs3v/xREza1Em0J6mEJ44/mWtHvkm1ZYf7eyWEJA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from MN2PR03MB4927.namprd03.prod.outlook.com (2603:10b6:208:1a8::8)
 by PH7PR03MB6917.namprd03.prod.outlook.com (2603:10b6:510:12c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.15; Mon, 29 Sep
 2025 23:55:06 +0000
Received: from MN2PR03MB4927.namprd03.prod.outlook.com
 ([fe80::bfcb:80f5:254c:c419]) by MN2PR03MB4927.namprd03.prod.outlook.com
 ([fe80::bfcb:80f5:254c:c419%5]) with mapi id 15.20.9160.015; Mon, 29 Sep 2025
 23:55:06 +0000
From: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
To: stable@vger.kernel.org
Subject: [PATCH 6.12.y] spi: cadence-qspi: defer runtime support on socfpga if reset bit is enabled
Date: Tue, 30 Sep 2025 07:53:31 +0800
Message-Id: <20250929235331.26302-1-khairul.anuar.romli@altera.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <2025092913-unissued-panoramic-e22c@gregkh>
References: <2025092913-unissued-panoramic-e22c@gregkh>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR17CA0013.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::26) To MN2PR03MB4927.namprd03.prod.outlook.com
 (2603:10b6:208:1a8::8)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR03MB4927:EE_|PH7PR03MB6917:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f26deb5-f534-402a-a494-08ddffb39cda
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BWaWvCOnY1YnTz2vf8A6hFpPlzPyJ95PrxR/lHK2Z+XccWMdqoM3War8Zz8k?=
 =?us-ascii?Q?TlfKs/Rj6eBckvttjaU8GjSDqPX21fxx7zd0BfbG810cTue6LWRf6EizHdlm?=
 =?us-ascii?Q?LMUgjbefOaDyzxQPVe9M6jIjhpTOJXjg/Pa741/K0+G36ruQlYy4SB+qCrE/?=
 =?us-ascii?Q?iHloNG3coBoZhNOi2IgK/Pau44UPwnMEpLSv/xx6BX60ovt0GGUixma65LDK?=
 =?us-ascii?Q?YQYmio3c3FeU831gcBco2vf+pY7betICm9WH1Yflp3If0q2iZKRPl3f+EorJ?=
 =?us-ascii?Q?c0EWZbOU0HSHRtWUlHxG3S3Q+Xg4lu2oDQ1PocRrXAxGDTfbRVQT2NFdwYe8?=
 =?us-ascii?Q?9mY/Ma9KubmvTw0LKFJChD0bXI85Hog8QRlkMB+7AymrgDEB57IuTktFCYSo?=
 =?us-ascii?Q?VXh0SOfEO+gild7g//VtlE1UdUz1RyGMOoTrqtKXSc51AKqUiEVpgxhuzt+w?=
 =?us-ascii?Q?Gx8oXSaMWlYj0UBdgjldK047fIhUJhbd3m+mPHzIhZ8WRldRT7LvAQCm3lhO?=
 =?us-ascii?Q?c4EqxWkbWPmdEjDCWY+6NKaHegPvZwgoyjXLckfZ1gFFDH0vA0iQgGYuvN7e?=
 =?us-ascii?Q?AoIeuAP5tiOnBs1isZS2xZMLnlo6ifp+YZ/UpSt4pJL8Iu/u3eWwIftKInlS?=
 =?us-ascii?Q?6e28L+kgElEmwDtwraY/p57A1ZBLXvAQmI8laAlYvJcDb4cAB8BGmOyCmyCY?=
 =?us-ascii?Q?YckOO1iiB4J04v22LAWqCykLWWjGRr+jVdUbj89mNVr4GdaaBOf7ZmBLdlv+?=
 =?us-ascii?Q?h60/3HhlDERGODCz7HCA9+QnJTuElJBfbmkTFbwy0ZjJAhvjrv6ysKabPGxg?=
 =?us-ascii?Q?yxXlOMZRAg57nHvM+BcxQ0w9ck1paOtjSyaRfHW8BD3zptAvW/yiN4avXKNa?=
 =?us-ascii?Q?XlKcyg+7S0LRufwxuWrUS72UXEQJp6eSqrp+P8laj+EJG9q286UFkxW1dvcH?=
 =?us-ascii?Q?RIyBalhBoMuM2CIP91xi2b1yagWLPrddvGLFsCHZOKH9C+au+GiwsLH06gXN?=
 =?us-ascii?Q?OfL3XE3LGdpItvVI7/DE/Eno8FEAMaK+A/KIRzxTc1bsiBHRIFJ8fqw86VHr?=
 =?us-ascii?Q?QhHoFp7+I+5wjaJA5vP8+Phu/EuMHoOeFGndkUWNI8F7OTf3PmMB28kW1diq?=
 =?us-ascii?Q?cleZLJ8V6s2pq0I2HPB1PwSnvz2P3hoIm1WvHcpCQW6mBLiYP/fONJcZzQfX?=
 =?us-ascii?Q?4/FS6zRSEi+5DUZ7XNqxYfJfgJnfn8B5aAcgH/2h0ZZkD8HoAacuDf+Vly4M?=
 =?us-ascii?Q?ykJMZ3+LZeJdxsjAk/Ww99H1VEusSs63cjPM9VKxxfmJGmjuBZjad2fe7pGL?=
 =?us-ascii?Q?W3FsTNwyE9DVSGgYskS7wUMvIALfSBetPbUtomJyiyaCQ3wo+ya/hkFGccHO?=
 =?us-ascii?Q?qY5V2tPWoJIJv5N4hjnpaPkdRu7owu4wBLT4tzHQOzdV5JoCyw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR03MB4927.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?C5QPfbSO2qtIyc4NXCk3XMmH7CNhb6VCzZU4mZBW8wpC8K5AsgHBKNsDobyd?=
 =?us-ascii?Q?EbMZJ+O1e/jGU433qfrQx3Ouwu18ZzVkSW/1jjdjyh6wunJF6tIbPw7MuYr9?=
 =?us-ascii?Q?LmHfhA4CZ+Qv9OH0UtQh92AsTwv6zm4M2FjSBtE0+QKW43OSuBCB4vnMlEUp?=
 =?us-ascii?Q?rumoXQZ/wuV0SUKeKOqjSVActeoSks5CuhK3xwYt/W+qol4yAAKrClfqOehn?=
 =?us-ascii?Q?Roj8xDqXGfxsJFYVjqsxPp/W/Pr/Qutqgjo8yL60p6sQAoi+11Dqg0peXccy?=
 =?us-ascii?Q?WDvTKI1SDZb0GAVpeRPz6v5UNOe4vi6vryhVFwJZ7eIy+qIdRGJkWgstBpsY?=
 =?us-ascii?Q?tUfyNcJAONStKBo2jGMldS3/pE+xwLur+V/JWLVrg2omy2gW9XO8F3YLPChW?=
 =?us-ascii?Q?h8YO7Ut05sqQpyI/Q+iyvLW+RtWRxlO5Kyvfz+s/zdaMgT5sjdrv/IFbwukd?=
 =?us-ascii?Q?+e2VOUwZl9GHmMqgJWb1Ftsc1pildCbQ68sP6ih6OLCsuRV2AN7dcKSH7zy6?=
 =?us-ascii?Q?v7YcMjxmSORIEeVmnFM4pY1IpIhPOzWeoZ5ex/Z92yW0qzlcTqDiM0Svt20T?=
 =?us-ascii?Q?yj1WmI68QzzxXgzyileyPGEnlinebAqBqcpSeFKYztCvPQEcy+qzJBpch5+f?=
 =?us-ascii?Q?pKbC5lSGiyec9AJV4c4x7y6B0uyqhqEpP70x1/hRavukhCl87jaodtxaNN4k?=
 =?us-ascii?Q?naIHXv35BnPmsHp5RVWuwFhO8Mkn1r1keR82wgm/4ty8F2nW/sB/y38CTphC?=
 =?us-ascii?Q?UTOrBK2JyCp1G/65sSKBvs0Wz8Bv0SPT+DIe9hQioei8sbOJhYcd5/ZM4x5Y?=
 =?us-ascii?Q?6MTGNxIALWj2L7PP+bX1nhVEMpyNQJnPrGzVMbhRGVofO+4Wn+oFDjjmwut/?=
 =?us-ascii?Q?cpu9rUkBb0a3uGdll0fF+q/rbcrTrvhuVHKnpDCS3OE+olasM4i5UiirxH/d?=
 =?us-ascii?Q?JKQISTaCKdD5WKyEs0ovEDYi3VuwR6wvPd6v6ZlymyfmleN+ay3gP8sz3bpk?=
 =?us-ascii?Q?IIL4tYknE/37Iqrv+VtJDRYofbRh+toSoZpHDDySoP51gp9tLuYNVBSBoHE8?=
 =?us-ascii?Q?7rwuXxACfa2NPxQSJ1VfRr5XOquBM/cSoxLEOHXw4/IZ+5/75zw8d4Tt0yI9?=
 =?us-ascii?Q?HipAa8Jl99tY2d16fgZuB0ivhsuHo3dcUAQIIAzYswREjEO8Ji3XuUi7K3Zg?=
 =?us-ascii?Q?Yo5xf56oxMEvU8ajbzzfg3upbQY9vVlBKNQPdaFN7W9IyT3smuD0Ki2bfBpj?=
 =?us-ascii?Q?Us1fUX+HGDc8he01+iveGwHUZv/Vc95OXRCSJwmYqdh6hJYEyfAksJfvkF6s?=
 =?us-ascii?Q?dDg7PxBbgM5IPo8bc988pdnjH7VPhDDjKTaiUG25t9KBxRNo9EPJmeIr56IU?=
 =?us-ascii?Q?9LmZMwAfMIdYwg/2CfCByQljikfrRPezZpPkmzmmJcRbEl/qc1I/2WooCrIY?=
 =?us-ascii?Q?zKD20jowtm7Ml9fPOIMVJY08IYUnNdQm6idSejG/I3aSBfAlIRhTuFWOya+/?=
 =?us-ascii?Q?n4KTOvZtMDNjvisC27t0eFJeTA6wZDqQYXd4QmgzQVjyUSKCCSWWReYT0YJ6?=
 =?us-ascii?Q?sm8mT66JmuMpZCgH8S9/n5CIJ9kMJ7TBRfz3ojrvOlt81HjIsM/dV0LSRB8V?=
 =?us-ascii?Q?Jg=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f26deb5-f534-402a-a494-08ddffb39cda
X-MS-Exchange-CrossTenant-AuthSource: MN2PR03MB4927.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2025 23:55:06.5773
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SA3sol0PrH8M2cmj4XJlSaXC/5wd+XBZ8qfsuBGAfGNyUo7v1By8/+rgUuHLXeW2gDfJ2M1ifD74EVW5soYVK+O1rpguiPvkAxckFDQHV8w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR03MB6917

Enabling runtime PM allows the kernel to gate clocks and power to idle
devices. On SoCFPGA, a warm reset does not fully reinitialize these
domains.This leaves devices suspended and powered down, preventing U-Boot
or the kernel from reusing them after a warm reset, which breaks the boot
process.

Fixes: 4892b374c9b7 ("mtd: spi-nor: cadence-quadspi: Add runtime PM support")
CC: stable@vger.kernel.org # 6.12+
Signed-off-by: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
Signed-off-by: Adrian Ng Ho Yin <adrianhoyin.ng@altera.com>
Reviewed-by: Niravkumar L Rabara <nirav.rabara@altera.com>
Reviewed-by: Matthew Gerlach <matthew.gerlach@altera.com>
Link: https://patch.msgid.link/910aad68ba5d948919a7b90fa85a2fadb687229b.1757491372.git.khairul.anuar.romli@altera.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-cadence-quadspi.c | 56 ++++++++++++++++++++-----------
 1 file changed, 37 insertions(+), 19 deletions(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 56be0b6901a8..cb43ed5f4e48 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -44,6 +44,7 @@ static_assert(CQSPI_MAX_CHIPSELECT <= SPI_CS_CNT_MAX);
 #define CQSPI_NEEDS_APB_AHB_HAZARD_WAR	BIT(5)
 #define CQSPI_RD_NO_IRQ			BIT(6)
 #define CQSPI_DISABLE_STIG_MODE		BIT(7)
+#define CQSPI_DISABLE_RUNTIME_PM	BIT(8)
 
 /* Capabilities */
 #define CQSPI_SUPPORTS_OCTAL		BIT(0)
@@ -1436,17 +1437,22 @@ static int cqspi_exec_mem_op(struct spi_mem *mem, const struct spi_mem_op *op)
 	int ret;
 	struct cqspi_st *cqspi = spi_controller_get_devdata(mem->spi->controller);
 	struct device *dev = &cqspi->pdev->dev;
+	const struct cqspi_driver_platdata *ddata = of_device_get_match_data(dev);
 
-	ret = pm_runtime_resume_and_get(dev);
-	if (ret) {
-		dev_err(&mem->spi->dev, "resume failed with %d\n", ret);
-		return ret;
+	if (!(ddata && (ddata->quirks & CQSPI_DISABLE_RUNTIME_PM))) {
+		ret = pm_runtime_resume_and_get(dev);
+		if (ret) {
+			dev_err(&mem->spi->dev, "resume failed with %d\n", ret);
+			return ret;
+		}
 	}
 
 	ret = cqspi_mem_process(mem, op);
 
-	pm_runtime_mark_last_busy(dev);
-	pm_runtime_put_autosuspend(dev);
+	if (!(ddata && (ddata->quirks & CQSPI_DISABLE_RUNTIME_PM))) {
+		pm_runtime_mark_last_busy(dev);
+		pm_runtime_put_autosuspend(dev);
+	}
 
 	if (ret)
 		dev_err(&mem->spi->dev, "operation failed with %d\n", ret);
@@ -1929,11 +1935,12 @@ static int cqspi_probe(struct platform_device *pdev)
 			goto probe_setup_failed;
 	}
 
-	pm_runtime_enable(dev);
-
-	pm_runtime_set_autosuspend_delay(dev, CQSPI_AUTOSUSPEND_TIMEOUT);
-	pm_runtime_use_autosuspend(dev);
-	pm_runtime_get_noresume(dev);
+	if (!(ddata && (ddata->quirks & CQSPI_DISABLE_RUNTIME_PM))) {
+		pm_runtime_enable(dev);
+		pm_runtime_set_autosuspend_delay(dev, CQSPI_AUTOSUSPEND_TIMEOUT);
+		pm_runtime_use_autosuspend(dev);
+		pm_runtime_get_noresume(dev);
+	}
 
 	ret = spi_register_controller(host);
 	if (ret) {
@@ -1941,13 +1948,16 @@ static int cqspi_probe(struct platform_device *pdev)
 		goto probe_setup_failed;
 	}
 
-	pm_runtime_mark_last_busy(dev);
-	pm_runtime_put_autosuspend(dev);
+	if (!(ddata && (ddata->quirks & CQSPI_DISABLE_RUNTIME_PM))) {
+		pm_runtime_mark_last_busy(dev);
+		pm_runtime_put_autosuspend(dev);
+	}
 
 	return 0;
 probe_setup_failed:
 	cqspi_controller_enable(cqspi, 0);
-	pm_runtime_disable(dev);
+	if (!(ddata && (ddata->quirks & CQSPI_DISABLE_RUNTIME_PM)))
+		pm_runtime_disable(dev);
 probe_reset_failed:
 	if (cqspi->is_jh7110)
 		cqspi_jh7110_disable_clk(pdev, cqspi);
@@ -1958,7 +1968,11 @@ static int cqspi_probe(struct platform_device *pdev)
 
 static void cqspi_remove(struct platform_device *pdev)
 {
+	const struct cqspi_driver_platdata *ddata;
 	struct cqspi_st *cqspi = platform_get_drvdata(pdev);
+	struct device *dev = &pdev->dev;
+
+	ddata = of_device_get_match_data(dev);
 
 	spi_unregister_controller(cqspi->host);
 	cqspi_controller_enable(cqspi, 0);
@@ -1966,14 +1980,17 @@ static void cqspi_remove(struct platform_device *pdev)
 	if (cqspi->rx_chan)
 		dma_release_channel(cqspi->rx_chan);
 
-	if (pm_runtime_get_sync(&pdev->dev) >= 0)
-		clk_disable(cqspi->clk);
+	if (!(ddata && (ddata->quirks & CQSPI_DISABLE_RUNTIME_PM)))
+		if (pm_runtime_get_sync(&pdev->dev) >= 0)
+			clk_disable(cqspi->clk);
 
 	if (cqspi->is_jh7110)
 		cqspi_jh7110_disable_clk(pdev, cqspi);
 
-	pm_runtime_put_sync(&pdev->dev);
-	pm_runtime_disable(&pdev->dev);
+	if (!(ddata && (ddata->quirks & CQSPI_DISABLE_RUNTIME_PM))) {
+		pm_runtime_put_sync(&pdev->dev);
+		pm_runtime_disable(&pdev->dev);
+	}
 }
 
 static int cqspi_runtime_suspend(struct device *dev)
@@ -2052,7 +2069,8 @@ static const struct cqspi_driver_platdata socfpga_qspi = {
 	.quirks = CQSPI_DISABLE_DAC_MODE
 			| CQSPI_NO_SUPPORT_WR_COMPLETION
 			| CQSPI_SLOW_SRAM
-			| CQSPI_DISABLE_STIG_MODE,
+			| CQSPI_DISABLE_STIG_MODE
+			| CQSPI_DISABLE_RUNTIME_PM,
 };
 
 static const struct cqspi_driver_platdata versal_ospi = {
-- 
2.35.3


