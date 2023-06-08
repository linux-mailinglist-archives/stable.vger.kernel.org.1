Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 321AD728A48
	for <lists+stable@lfdr.de>; Thu,  8 Jun 2023 23:35:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234505AbjFHVfY (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 8 Jun 2023 17:35:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232119AbjFHVfW (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 8 Jun 2023 17:35:22 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2075.outbound.protection.outlook.com [40.107.215.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8D232D63
        for <stable@vger.kernel.org>; Thu,  8 Jun 2023 14:35:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VWccaV0Cr78bEOGJWQD5Pm3ElMiBTSVHf3Je3t5OdZUPrVj9/IJYP1wfFDAhqGpImLMl9Cglz9yq/65C58P+34QUKeqvgTef+/358GDzvZ8obFvrSi1RxL52LzAZxy/LLbCRKoX2cX1kJLy9cylQov7CyxVYYFI8eyUVSet8YFM3VscY4YFkfOGTKa8aBrBbm2SSCPzUG5KjiTw9itS6gJq0RNQYpdT6aNM0WXrf5N3nAz9N62hDCvAz2uBtXSyObFPeEGT4mFi8e0Y1tjWV0QSf1+vIaLSQfM2wimiI0G0JDu0gVbAd3s8AtYVzJ/abvETvXThg6PMkHaFsyzJAeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+i9ZlqSvRIWBS/oyLu9xmTKRh2svF2ckUBhDCdl91Ac=;
 b=Zx+9w17BWZH9ZSQbL/prhW+pH1RxSiibiUcaKholj7EyYyWaAxaoyYLuoqOZB9pWs7lIfVRAaYomMfn54jCdskoawlgsuyPiXisSQgeopgK8dUhb51FoAXVrS9Gn5OX6M2Qz4/mmkv70xF5RU2miYSk6EpZ5X9Vzk/bcK8Wmxo+5RBuUsA0hYrIKFvauy/dqMBSTY2DxU5l216fg5KMyuQz+NiFABMyFFCP/tn8L5jF8pwIw1InWpwXBEBLsADr3dOxGyv6ev18vMP2flgzm7gnNLiHqW/jfYpsX9oMMwpAfjb1GeAY0BRy1ujp2fVvCr8rym6MDS7a8t4SgahjO6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sancloud.com; dmarc=pass action=none header.from=sancloud.com;
 dkim=pass header.d=sancloud.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sancloud.com;
Received: from SEYPR06MB5064.apcprd06.prod.outlook.com (2603:1096:101:55::13)
 by TYSPR06MB6750.apcprd06.prod.outlook.com (2603:1096:400:479::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.31; Thu, 8 Jun
 2023 21:35:18 +0000
Received: from SEYPR06MB5064.apcprd06.prod.outlook.com
 ([fe80::de44:cc0c:5757:6626]) by SEYPR06MB5064.apcprd06.prod.outlook.com
 ([fe80::de44:cc0c:5757:6626%5]) with mapi id 15.20.6455.030; Thu, 8 Jun 2023
 21:35:17 +0000
From:   Paul Barker <paul.barker@sancloud.com>
To:     stable@vger.kernel.org
Cc:     Paul Barker <paul.barker@sancloud.com>
Subject: [PATCH 5.15.y 0/2] Backport GCC 13 fixes
Date:   Thu,  8 Jun 2023 22:34:56 +0100
Message-Id: <20230608213458.123923-1-paul.barker@sancloud.com>
X-Mailer: git-send-email 2.34.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=877; i=paul.barker@sancloud.com; h=from:subject; bh=TvF2GWCnlP/7Lsv/7ZjAQ9JlLIR/2Z3TGRrVCl55Nlw=; b=owGbwMvMwCF2w7xIXuiX9CvG02pJDClNnnXdOwNt3fTKgvtMBVt5/2anFV5+L2rJfG/Kly271 GcuMiztKGVhEONgkBVTZNk9e9fl6w+WbO29IR0MM4eVCWQIAxenAEwkvI6R4S3TyxWLj5h/u3LC gVXndHZoTPuODTOuJr6+XHRrX9C2nreMDM9+K06ccaXs3O62pFkZ//wmdZwN27BCsHxxwLk01ZA SNW4A
X-Developer-Key: i=paul.barker@sancloud.com; a=openpgp; fpr=D2DDFDAE30017AF4CB62AA96A67255DFCCE62ECD
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: LO4P265CA0262.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:37c::10) To SEYPR06MB5064.apcprd06.prod.outlook.com
 (2603:1096:101:55::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEYPR06MB5064:EE_|TYSPR06MB6750:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fcc5fa3-0134-4fb8-8564-08db6868408d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UcJHSgSCZbfsja/Rl2VyXyZgQ4Frq7UGeNOjMbLkCkR8rDtlRS10hcyLxjwidpFwoEwBiy7U0qmUnNI5NBDKgfdlICsDEHfxzzBflcAB9WG/JicQAykgbm2NqlZ5LSiVQ4QMsGF86cFl3pWf1GX0cdW1uDmVY7L7CZeOG/bAdinmHidX/Y1gf6bNmypY5SgKVCfJlvUDqP0ag5vP7GYIR/Lt5BLjzNrUctBneJXAQavbUuIw5ST3vnHb/U965IBwEPcO0et+3hTQCDa5kixYpc8P8ykki8IQ6h5y/M7kw3MCCPhImZdfiANZqa3rJSV7Sh5J0w7QORFTgUfKCDXl9gG+d1wXZVdIvRu1yWKC1IRE/Qky7zxaU9DwoZwSpmmA0RKQp/OMTw/iBX58cvmIXurZViCQI2DPWVOBGl4aaA+ivWtYMLDm5kPWWO31MdM/mrpu9zNOV77pAA0q2Vz1nJvNtsP2BgkkJCCJGTBtdTsj/FjH/1c8D/QZ0BixEzSbSCpIacFjFDqEsoHsyCfMbvmNfmfWH0ZeGscjry7pPva6Y7PMEmNxZ7E6jFV6jRjHMMUaLpr+42Tfq74MrcPfSJBvmvPid5n1xiAQg3S3PoM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR06MB5064.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39830400003)(366004)(376002)(136003)(346002)(396003)(451199021)(786003)(316002)(36756003)(86362001)(38350700002)(41300700001)(38100700002)(83380400001)(66946007)(26005)(6506007)(1076003)(6512007)(66476007)(66556008)(186003)(2616005)(4326008)(6916009)(6666004)(478600001)(41320700001)(107886003)(4744005)(2906002)(52116002)(6486002)(44832011)(5660300002)(8936002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RqxFHUidPFsvVbNtvIiMOFuDjQCmdKdiBu7bT6PtuPq6YXWAp9Zc/IcDJUfs?=
 =?us-ascii?Q?kp+eQ+o6nfH2YP//lC6hTsw0m2gfgESXr96Jx1Y2MaFKi7cNIni6c3BrPyjX?=
 =?us-ascii?Q?xh/i+4eqE4hVQpSR5H2cskGGforBx8ZgAu7rpFmB4kcqDPw5uPtvjS1BwCrB?=
 =?us-ascii?Q?c2MtUe3BubdmGEjHpy+KjL3ZbUreV6t93Par/Vybfg1O7yVD5KVsCLFmhw5t?=
 =?us-ascii?Q?cEeAmRSppwL3hyHu4jCqYUzKVDIojC9GN3m2ak+PY85f6U9aYIlyObbwAqDz?=
 =?us-ascii?Q?St6awlfE7zG+Yx0hmYbttIzCgOhHI6DydiadQC4/yS1iyy53FkNu1ayeEHoH?=
 =?us-ascii?Q?XrTsTuCKqRmgIAnulqZ7mMrrTzh5SpVqDDZW4Qp4BcVBfWwQphJ1VX6DCXJY?=
 =?us-ascii?Q?riRnHVJbC4zzudugeiaFoqWbEBv/rgO5NTux3BH7WPmM+8YhN2C6V4jBspHS?=
 =?us-ascii?Q?6ZlUM+ITNqCQ4WiPvG0ZqxVnftclQlChKrle4b3IC6BuWdmKCktRwpJOp25l?=
 =?us-ascii?Q?1WIOjVDefO/sgQ+MPq+EfCdvO0IvQ+if39jyLR042DQXgZUYE3dAhRZbGZAE?=
 =?us-ascii?Q?qDkAhGcHorH2y6tDMSUOi+gvVqLX3YecJp3H4/9/fwObsC+PSBdfwz7ceRvM?=
 =?us-ascii?Q?iYj6Ax+bpR1FjUooE/eg1eTdHWK4J5kZFP1OHnDr6skiHewSEQk4GhiUeEsd?=
 =?us-ascii?Q?FAXnbrdVhg9yFbGr0IQqnmgkV8qHfFJlrSqyEdE13UH4VtIH/9mpdjMbaCwO?=
 =?us-ascii?Q?bWNV97bFPlOA+/Pke7eCSik5gguXJFwZl1R8/fSWDSAD4BivMoywRlkAH8M3?=
 =?us-ascii?Q?fkeD+9+9JXlYxjgEit045qMzjIuRKqbItpQsYtR9b/PsVmS5/VPdnkQ9UoR5?=
 =?us-ascii?Q?eRS0k3XF3iK+MB/9H0ZMuOpGm+C1hwBQajEzzWi9QLlHXzDC86AG/XQ+GbTx?=
 =?us-ascii?Q?gm1kiv0oiWNZ4FEXyl06dtPYUNxb6d65HInkZnQCTE3+FWkF/3+Gtu/mpzv9?=
 =?us-ascii?Q?eHTSCJf4xb7UG+oCRkJialso7/hAjFyVkCzhnoZvuOkWKLo/e8RkiVXkVFd3?=
 =?us-ascii?Q?L91Crqg3C4E6pX6PyCAqMuYjuQEFQRTsm6Njn28H/fL4sC2fmvdnO3UXpUhO?=
 =?us-ascii?Q?49arKPvtbZzmFd6natTe4JKsJgBeGZlbIKXyFfkNWMrwAeGWURj5kL/Fo6H3?=
 =?us-ascii?Q?I/DqpW7fXjbu46g8++noFK/BYdaZg+T6BQsaA5W7Lp0fmmXVCrOAfSjsSxBk?=
 =?us-ascii?Q?ROSC5bdGecYG37zFeZKsQnscNu4TtmEHcQITiZKrhMvG2hP7VjNnq1NkUtDU?=
 =?us-ascii?Q?CQBfGdV888ZOM61vT4euxIZDlAX6R3QvFL3BdSb0nz1YiXttDNS9xhV4YLmD?=
 =?us-ascii?Q?GTSN0/F9tOiOnxy8I46IEDozBzZFLdU9xs5eHR6oD4Fz73WjkJAvVZ7HIHoi?=
 =?us-ascii?Q?FaLAN5JfOb0icsETX4Fv+Tjsw0d4rOqL2qqpEhGkEd93649MmcyUQSNUK2G2?=
 =?us-ascii?Q?fPsGwQL4RRlqdufqOtIvLZj+dG1VNwZ7LZio3TWP844W5ufKp1URoEhUd525?=
 =?us-ascii?Q?jUxuXWHYtkz+kBkRRuYbHKkp/o78U0J/wq8vkXUl5vlDpyHkjfbRXccCAIns?=
 =?us-ascii?Q?9Q=3D=3D?=
X-OriginatorOrg: sancloud.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fcc5fa3-0134-4fb8-8564-08db6868408d
X-MS-Exchange-CrossTenant-AuthSource: SEYPR06MB5064.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2023 21:35:17.6813
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3e0f949f-6a74-4378-baf2-0abfca8d5e06
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xVDpIy2Fm9C/TsccVb937IRsBFgyJ5uYpcufJNfFFPLogIiKYF0Ac4LkpYqbSf/VZhL6logdCo8V+uo5NsKFyoBH/++Uxt2ylnM9PpGE2E0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB6750
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

These two commits are required to build the linux-5.15.y branch
successfully with GCC 13 in my testing. Both are backports from
mainline, with a couple of tweaks to make them apply cleanly.

The result has been build tested against a few different gcc versions
(9.5, 11.3 & 13.1) and defconfigs (x86_64_defconfig, i386_defconfig,
ARM multi_v7_defconfig, ARM64 defconfig, RISCV defconfig,
RISCV rv32_defconfig) via Yocto Project builds.

Patches for linux-5.10.y are also on the way.

Arnd Bergmann (1):
  ata: ahci: fix enum constants for gcc-13

Kees Cook (1):
  gcc-plugins: Reorganize gimple includes for GCC 13

 drivers/ata/ahci.h               | 245 ++++++++++++++++---------------
 scripts/gcc-plugins/gcc-common.h |   4 +-
 2 files changed, 125 insertions(+), 124 deletions(-)


base-commit: d7af3e5ba454d007b4939f858739cf1cecdeab46
-- 
2.34.1
