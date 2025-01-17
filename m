Return-Path: <stable+bounces-109397-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84E56A152E3
	for <lists+stable@lfdr.de>; Fri, 17 Jan 2025 16:30:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A53C4169A4F
	for <lists+stable@lfdr.de>; Fri, 17 Jan 2025 15:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DEB986AE3;
	Fri, 17 Jan 2025 15:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=witekio.com header.i=@witekio.com header.b="gB+A6q/t"
X-Original-To: stable@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2105.outbound.protection.outlook.com [40.107.20.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DFCC33062
	for <stable@vger.kernel.org>; Fri, 17 Jan 2025 15:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.105
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737127842; cv=fail; b=ki9jTSfJlihh1K3LSQNDynK4KpSJxi3CBFsq9FPGPUgdSYz21ngSl8bNlKYBkv36QFJqCrs8p/e5SumCRLsDN8DevspWbPSXCiM3UF/qqG4ZjccalK66vPk/hW5w5texeeye0wRRFiPIjya4iC+0cg3i/XlkG/+Rkde0wjD/DHM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737127842; c=relaxed/simple;
	bh=i11h+1lGIYHvxJi80PVhczVMEBPmAlnp2TDlQbYJYRw=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=SEOBpYitsjGQHkjSPaVOxl76pmaZTbY9hG5b0S1yjSlvnVxIdhmkSMR8Z3a5tAVU+zOpLLVOJu+EGGIqpyqK4nxUSBEarfgtyq/+lmTU+F15FkzbfsMobn8zmLDJWhrBiCQTyj0BMIPGHJJag7ScNXwYThYRwfZ6bBhv4rTSLhw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=witekio.com; spf=pass smtp.mailfrom=witekio.com; dkim=pass (2048-bit key) header.d=witekio.com header.i=@witekio.com header.b=gB+A6q/t; arc=fail smtp.client-ip=40.107.20.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=witekio.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=witekio.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YeaGQFS+KJfVLyzh5+Tkoa1IKg9sOb/CiQfckqoV30hHOGTL84/jyRmGKSgEUUXxt+2+HaQBpc3xYkUDJRssCGpzgu8/ItGKgawdXHxzM6eyk+00m/5UCzVUhWGs/gV7iQwf9lB/L3bH5gfwKP3FRnpWi+5JQWiWu2apZz9mNEbhK8/n9fA4uvynEjJoBZtsvF03A/gjlSjrHIaGjow+DBlUpkdOwvZJC0n2ZsxX3jvNpSLet9uvjTyjdaekPj/1X40YQ/RacaIcAYyRuL1RcOgzpeQ9KIeyEnqaHzLD9t6F7msQeTZaSf7CijqI0oQ4etAjOvnXkX4LKOMcpu2bcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qUZBxA7ck1ihatXDb+C8y6IKIENqyH2psClPdNBBXyc=;
 b=rjqdEo1lxOQnJVM1NXj77XCGkVhE8dobM7YoJROQ1eUSV1Ve0dMonbPinUcSHv0LYjlntrkSzdgklrreV5XP7l+XfbqT8oPf3rBch4lKnGX8qoE1pkuly1GG3Sa0RBwlGZ4QwaIfWvraQ4wMdW3ovbW+5HWkC0WSUuHyK19G1e5bwNHNZ9czvPtO8ygl5XnsqK91Jxvl4+p1FTsl6SVUEkD6UXYxUOs55bSVqJtjoNokUjPkEtyuJQtwDTi3zYuUffjk8HgYXuwmj/Dik3KigOLaZoFGnDG+vUa53Wt2wupauVpTyQCdB8Eiq821DV8S5UoEfLBp3w0yvaILdQ6M0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=witekio.com; dmarc=pass action=none header.from=witekio.com;
 dkim=pass header.d=witekio.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=witekio.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qUZBxA7ck1ihatXDb+C8y6IKIENqyH2psClPdNBBXyc=;
 b=gB+A6q/thxcrJ8FmBNH8B/DyeVd3l0ATivA0yB0Mcx3sZWMCHy2BAhfPFsG+VB/Q+qj3SrrHG8YP6QOnIyZlkA/tuONR4BPC3TBqEPAYR7G80f98sGi45o0LRCoqlnHNLOEEJFkXEsRlkqtB+83zxH2KjTAddGCLyOOWygK8M3GAXUft/IgONLKyM8MbAYoKUj1qW7ZefSdpIHhda0+51mTxkLEAWlqPW978y6gmvdxr2A8SREBeTQVgKwQQ+Z5Okh3CmpjOfcAIXg874bjEWIjVwp8EhwgrT/ETWomg3liWYudtnClqw8jzjQ10eCYuWRl462RGzoy5f6FDfIa1fQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=witekio.com;
Received: from PR3P192MB0714.EURP192.PROD.OUTLOOK.COM (2603:10a6:102:48::10)
 by DBAP192MB0906.EURP192.PROD.OUTLOOK.COM (2603:10a6:10:1c9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.16; Fri, 17 Jan
 2025 15:30:35 +0000
Received: from PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
 ([fe80::345f:a9e9:d884:3091]) by PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
 ([fe80::345f:a9e9:d884:3091%7]) with mapi id 15.20.8356.014; Fri, 17 Jan 2025
 15:30:35 +0000
From: hsimeliere.opensource@witekio.com
To: stable@vger.kernel.org
Cc: Zhongqiu Han <quic_zhonhan@quicinc.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Bruno VERNAY <bruno.vernay@se.com>,
	Hugo SIMELIERE <hsimeliere.opensource@witekio.com>
Subject: [PATCH v6.1-v5.10] gpiolib: cdev: Fix use after free in lineinfo_changed_notify
Date: Fri, 17 Jan 2025 16:30:17 +0100
Message-ID: <20250117153017.7607-1-hsimeliere.opensource@witekio.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PR1P264CA0069.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:2cc::7) To PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:102:48::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PR3P192MB0714:EE_|DBAP192MB0906:EE_
X-MS-Office365-Filtering-Correlation-Id: 730dcd44-7e53-4387-1ab7-08dd370be2d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uFA+HXnTPNU6dKcqZevGYXVJYHXfHBKeBkN4cjDcD3EthvKlW/0lu5scB0bE?=
 =?us-ascii?Q?4zZIDtC8XiYtYbn+u5wnnmdv3qGqksEzz5DvCx3JMHUIx8UmyKBFmLmosEEu?=
 =?us-ascii?Q?nrpnwiePVXtYwmWKJ0wGnMsYEHTdUMiziP5WXY0uXhO9rGapvDPiHm/vO7WD?=
 =?us-ascii?Q?zSCVv5mxtubNh+eROdaawe2acyw8FPDWf3yaIhCYSz9HiR8tM6fYE27WqHL7?=
 =?us-ascii?Q?vOc2gszOIh/b0YzXjExsXWfEan9+Yb++pjOwCTR74Twf/1m9yh6pC+l2cGRB?=
 =?us-ascii?Q?fAEy4bWQQpaCcR1kfR9uORWbTYo6/ZK3RUyU/ctfLwzUNC8EcH5J+a9NWY1x?=
 =?us-ascii?Q?W/zqLN3i+H1xAcGZ7lh+DFP3Oo5lMrAwBjSONb5/QcbNSIyjOjxZ9wpv8K3H?=
 =?us-ascii?Q?hWg2xsLANZJb6ZXbbGTVWvzMl0edQjNAknidsl5O3gZMX43+E/0IgLGhjgZf?=
 =?us-ascii?Q?zIO1/UO/MzmMHiNI18fUPS6fvnuWDoO68znywhJRIGIPI7qK/Qx581LTZPPi?=
 =?us-ascii?Q?Y4kprOnX7ovXdYYnEswQ5N6P6TAiG826YopRytHJ9ci94PW7+mQvNZnGSQky?=
 =?us-ascii?Q?TPZ4GvWrRlpbLtf4jN2PYJpXTu+XgFZ6/JTAj+HLUOjQ3YWOF3ZuKohreQLT?=
 =?us-ascii?Q?QC8Vtav4/mkFvSAKdzv2sCniN5H6mj15ChRYAkhray+xMy6/BhirIFUu4IrB?=
 =?us-ascii?Q?zqDhF9wdB9S9tJ3sl82ju/vyQCVqoY1RvYH6Xfnk+64CLwzJyFWJVSInNFlo?=
 =?us-ascii?Q?eaR+qv91d3q+uC5IE//m9L1qbwSDqAFBnqb2xlbAw2O3FROw5VMpCSJVEyaF?=
 =?us-ascii?Q?STV2gFpLTHHBVa4yigjkSkZVjBRfg2JWpQZtk/MrZJIf4AhQwOhfwLm7c/RQ?=
 =?us-ascii?Q?SAqSFU1DqdcO/XOIDJL0FiuUI2KDgiQsQGtaIZ2gluh8gQvEtCCdQ1AamOi4?=
 =?us-ascii?Q?2cgWxef5B9fFNh8P8/f07lnaKmxdCGdZoiC2ZOzi7UWbgnORUP2qK6GleCfF?=
 =?us-ascii?Q?RC2rMyUDbaOuuMvCvugdYKx4Fmu9TMwkjGqKYnlfW1g5jBXI1gdAtp5z9ElC?=
 =?us-ascii?Q?WP0bYR+ehgnKcJ5ur/Zdbn/iF0BdHXUHqIzjl4AA8XsJP4TKhjRkMcsFP4DS?=
 =?us-ascii?Q?xEvqLUPVvJdJcQxcbxO2JUCHVsgrouripyuJZSb1vNPDyrNOBn/ndDNAUju/?=
 =?us-ascii?Q?HZqaL9Zm0R/VDOWiKisI2rqLniQ3k2uv/tv9FBScVhLTxp258XkZ6gRKjpBb?=
 =?us-ascii?Q?NuYyxZqdl46ZXU9VTZHq7vLYjSI70iH655YJdHupKoT1gv5egfx52dtayGw5?=
 =?us-ascii?Q?Zwp1qSj/F4IHwccIXTReQ5Ya4simLtg+vinJhb2BTAa+u56pcBUb/gVHbmWt?=
 =?us-ascii?Q?mGH2n/zfwLuJMHJWRQysynMJPq7/RuIxCTihWj9Rfe7aOk/MHA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR3P192MB0714.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Y3keVFwHEDSuyJjFfeSjyv3Z4PxsawCwhS/g86+NYNPh7gdllAry/Nsag8Bx?=
 =?us-ascii?Q?3nPmvg1/bne9nFu8IjZ/X9X9nhZvNakp5JkQf1u+sLNWJgS/a9GFeFWFoML5?=
 =?us-ascii?Q?GUoymXLGNL4tUF+RSNZOrvYva9iRviiTjMx/4DvziIvnAuJACRUc8aA0xPnb?=
 =?us-ascii?Q?YNtY5K3GGsK7IYc0Eg4rVOI2GZGjUq0CWb7Hl4rIg0iRUIEGrvoA7rc4OqZD?=
 =?us-ascii?Q?yAw8nf+VOAVFHI7WzhziNnPhqSzPNii3/5340O55CvW/NVvo4VZ3EaFHCbH5?=
 =?us-ascii?Q?AXQnnHMYleGml3RsF7nQ/ZJigrRTmK4I3ISn3HW0CzYrZW/kVMlkpf3ngnmx?=
 =?us-ascii?Q?KKnMfpcgLDQT96iPwON4XUeaRNJ+Nzph1x7MNvo7JAXPPLRL3g4WxEIxCshw?=
 =?us-ascii?Q?v02EwmuJUyFKlPIfKhKk+nyyhYF+VrskOwyQshT/rpNMtlpJBhj+5thj7eHu?=
 =?us-ascii?Q?1nrnXJtIrRUFTB8qWFXpywlmhfpnqRX4GJ86iPJQyX75P6dyp+uUPCOdmLaJ?=
 =?us-ascii?Q?yth35wXZQuKfHb26rSAmjyW66eCdDLspW51MldflZPE97NulMHzSf6cLAfIB?=
 =?us-ascii?Q?cFlQZNuTbpcE8oJh4Jj5amqGzU3w/PVwLKw9xY9tzGfgow3WttjAHJVhEiGE?=
 =?us-ascii?Q?3/WlNlho5/QfP5t01QQixhaZHUEr4rl/qtAntjZgDegTmn7ZfzcEDJECc3GE?=
 =?us-ascii?Q?BrC2pj0LROImzbind76pKfyKP7rmKNP192eDMvI2sAopj5+KdYIy4t+Q+Ton?=
 =?us-ascii?Q?JCqGY/xW9wJyG0K/F7gWaCQ6hC9uxqJaNpeA2K+8Yosrf71VhNG0sgMt3Z30?=
 =?us-ascii?Q?9jwpp3ZtSlZE2guiuH0b8nbv0xCxqSGaM5Yd0QHlTKdBvFySoaYRkIklD+ZR?=
 =?us-ascii?Q?s/Jrh5zrw2EPzg/Fi6s0Oo2B75bdNt/PIcq3Om3wpInWrEbGRm1flS04uffj?=
 =?us-ascii?Q?uFtD7zk7JOywUqMHsoBiEJwuA16EzLvhInUBj2CP89frW1l3H1V3U4ISTdJl?=
 =?us-ascii?Q?H/xrIg2fBPrBPJ/DPNvpS/pWh8P2tcsCzxuYShM5JeZny8Qw8kZbj2AgOwG4?=
 =?us-ascii?Q?ZekQbsQU2wpr2pdxSiRVYDXszM7waYATMK0nRXsh4G30B3W39rQ6WpTtQBQO?=
 =?us-ascii?Q?bG88eWJZLDRWK6iF9xp6X5lrWB4hIteuDx5kI55WrKiYDn60RVce5vlab7lZ?=
 =?us-ascii?Q?2IphoduE7gAHT3z2tTX/xUMXMWMbiqkECNQM/9xG3IXJv/XiHvzJKAc0sXfp?=
 =?us-ascii?Q?ajrW6OwUyswSh5BprrbqbNAF64BLmo9/q5HFkk57w5HLvSkPejnpc9khsuh4?=
 =?us-ascii?Q?FhoFqkbV/YlYSLJ1e5Tn1EXTVPV7l/810l6ZMC5mPy/diGVtLhWzCt7o668p?=
 =?us-ascii?Q?jxCQScvoDv0mZb7oY0TBpRmp5SP+7G47rTmQrfQ8UQpdFIzx+JBhPSHU+89z?=
 =?us-ascii?Q?Mkumdhl3+eX7lnj2cEh6eMhD9r8MWO66tvOWlYTnwn1eOH5sfZGkQ45IEjTg?=
 =?us-ascii?Q?JrU+u4hYk+3AhbKQj9DPk1Ty1zs8vXB6IhA/NGslkfBED4dIbBTFEA9ZOxob?=
 =?us-ascii?Q?h6ZypvS/0pH30ljpwxePN54FCF9F+1WMWRgXvzEN?=
X-OriginatorOrg: witekio.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 730dcd44-7e53-4387-1ab7-08dd370be2d2
X-MS-Exchange-CrossTenant-AuthSource: PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2025 15:30:35.2148
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 317e086a-301a-49af-9ea4-48a1c458b903
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ljGRRVzBXJqO8DNenexm3GuN84ETeM5BTMRrYwytaPdpuuPXWsF3r3lcXOPiLrwepDwIFgrx0DlWn/dalQGudA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAP192MB0906

From: Zhongqiu Han <quic_zhonhan@quicinc.com>

[ Upstream commit 02f6b0e1ec7e0e7d059dddc893645816552039da ]

The use-after-free issue occurs as follows: when the GPIO chip device file
is being closed by invoking gpio_chrdev_release(), watched_lines is freed
by bitmap_free(), but the unregistration of lineinfo_changed_nb notifier
chain failed due to waiting write rwsem. Additionally, one of the GPIO
chip's lines is also in the release process and holds the notifier chain's
read rwsem. Consequently, a race condition leads to the use-after-free of
watched_lines.

Here is the typical stack when issue happened:

[free]
gpio_chrdev_release()
  --> bitmap_free(cdev->watched_lines)                  <-- freed
  --> blocking_notifier_chain_unregister()
    --> down_write(&nh->rwsem)                          <-- waiting rwsem
          --> __down_write_common()
            --> rwsem_down_write_slowpath()
                  --> schedule_preempt_disabled()
                    --> schedule()

[use]
st54spi_gpio_dev_release()
  --> gpio_free()
    --> gpiod_free()
      --> gpiod_free_commit()
        --> gpiod_line_state_notify()
          --> blocking_notifier_call_chain()
            --> down_read(&nh->rwsem);                  <-- held rwsem
            --> notifier_call_chain()
              --> lineinfo_changed_notify()
                --> test_bit(xxxx, cdev->watched_lines) <-- use after free

The side effect of the use-after-free issue is that a GPIO line event is
being generated for userspace where it shouldn't. However, since the chrdev
is being closed, userspace won't have the chance to read that event anyway.

To fix the issue, call the bitmap_free() function after the unregistration
of lineinfo_changed_nb notifier chain.

Fixes: 51c1064e82e7 ("gpiolib: add new ioctl() for monitoring changes in line info")
Signed-off-by: Zhongqiu Han <quic_zhonhan@quicinc.com>
Link: https://lore.kernel.org/r/20240505141156.2944912-1-quic_zhonhan@quicinc.com
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Signed-off-by: Bruno VERNAY <bruno.vernay@se.com>
Signed-off-by: Hugo SIMELIERE <hsimeliere.opensource@witekio.com>
---
 drivers/gpio/gpiolib-cdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
index 55f640ef3fee..897d20996a8c 100644
--- a/drivers/gpio/gpiolib-cdev.c
+++ b/drivers/gpio/gpiolib-cdev.c
@@ -2860,9 +2860,9 @@ static int gpio_chrdev_release(struct inode *inode, struct file *file)
 	struct gpio_chardev_data *cdev = file->private_data;
 	struct gpio_device *gdev = cdev->gdev;
 
-	bitmap_free(cdev->watched_lines);
 	blocking_notifier_chain_unregister(&gdev->notifier,
 					   &cdev->lineinfo_changed_nb);
+	bitmap_free(cdev->watched_lines);
 	put_device(&gdev->dev);
 	kfree(cdev);
 
-- 
2.43.0


