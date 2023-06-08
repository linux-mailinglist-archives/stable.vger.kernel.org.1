Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DF68728AFD
	for <lists+stable@lfdr.de>; Fri,  9 Jun 2023 00:14:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbjFHWOK (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 8 Jun 2023 18:14:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbjFHWOK (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 8 Jun 2023 18:14:10 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2064.outbound.protection.outlook.com [40.107.255.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 116581BE4
        for <stable@vger.kernel.org>; Thu,  8 Jun 2023 15:14:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A1NNI+MPmlVR0AxIxtvkrHXrl8LpIRS+1IpqTXMge7UPUBJemg2whQ/8Cfu7msZ6FJ+pxc6DCIlkaQKXH+rrE09X8rGbjOdV0YpQIAsnJgekM+uuCy+i6Ugw/05Bvi0Xl5BpOMe3acQHykjxlwjfnpBBtNuSLRXPfSDLaTqyxYJHKsK338PG2icYLDVR1XUxl1wPQ8/uKAJDM+BAUFHt9W52e5Bg0IgdvY+C9IqDCgRt5KHkFKQWQ6RYseLVd07AWusnkFNE3I9dPRfKXXcHCGVLLmIzxM6xSazLsTvL1SpDjtmzLAFHD80BYNBvXCM1G1MNvL8PkH1DZ3541P7qEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SSa7CpyPUn7GAHzmbgXGUjcKdbifk3xSUAT+9q7n6Ek=;
 b=HSPYahpoS1WyMTqSS4YKx3baNTXZaCqwZywXaOEN9+pZhU5+ZrtouVU0XwcoOLlj12d1JQ9MeWpn7TTY3cgbHgzvrtKe9/YcB36AmQsgHmlVJWXn8+cjhZsAEHLF4yDvBZ68uEn0+ASbl9fSAQdhc2cTfnF9UFK/xH8N/HfISGqYXji5dCV3aUZD34Wc6eS0sTZVSAnN9SyWEG4wT0tlKzcoyPE7LJDenpWUY5NblU/9Sd+/o7lyA7XiVX5ZJgXsnjn+rqMtZ4o7cSqHgbfKwr7OVl8JpT5WCzP3hU8M6Cznyp4//Ust3rCTI4Vyqncny2g5Vxk3q9MRN4Dh7/sudA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sancloud.com; dmarc=pass action=none header.from=sancloud.com;
 dkim=pass header.d=sancloud.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sancloud.com;
Received: from SEYPR06MB5064.apcprd06.prod.outlook.com (2603:1096:101:55::13)
 by SI2PR06MB4316.apcprd06.prod.outlook.com (2603:1096:4:155::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.19; Thu, 8 Jun
 2023 22:14:05 +0000
Received: from SEYPR06MB5064.apcprd06.prod.outlook.com
 ([fe80::de44:cc0c:5757:6626]) by SEYPR06MB5064.apcprd06.prod.outlook.com
 ([fe80::de44:cc0c:5757:6626%5]) with mapi id 15.20.6455.030; Thu, 8 Jun 2023
 22:14:05 +0000
From:   Paul Barker <paul.barker@sancloud.com>
To:     stable@vger.kernel.org
Cc:     Paul Barker <paul.barker@sancloud.com>
Subject: [PATCH 5.10.y 0/2] Backport GCC 13 fixes
Date:   Thu,  8 Jun 2023 23:13:33 +0100
Message-Id: <20230608221335.124520-1-paul.barker@sancloud.com>
X-Mailer: git-send-email 2.34.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=965; i=paul.barker@sancloud.com; h=from:subject; bh=vfgQJuc/RCjNcGmQyUlBPMjphEmeOoNCcHhfc9usFpc=; b=owGbwMvMwCF2w7xIXuiX9CvG02pJDClNQfV3t7n6cSl9FhP+dWzZH+slR0vq9m/1V91/84P2F iffj/7vOkpZGMQ4GGTFFFl2z951+fqDJVt7b0gHw8xhZQIZwsDFKQATaX7JyHD2/G07E5P2c9eu Fx4QeL7W/Ehuh+PX0gflim5vSyWO23kz/M9cITPhiVGV0Jd9qgd+NidNvml4VzFwLV+DZaqZ+gI LJnYA
X-Developer-Key: i=paul.barker@sancloud.com; a=openpgp; fpr=D2DDFDAE30017AF4CB62AA96A67255DFCCE62ECD
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: LO4P123CA0374.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18e::19) To SEYPR06MB5064.apcprd06.prod.outlook.com
 (2603:1096:101:55::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEYPR06MB5064:EE_|SI2PR06MB4316:EE_
X-MS-Office365-Filtering-Correlation-Id: 34abb958-f3bc-4b68-3f2c-08db686dabd8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /fVIRTOd2MpTIHzhRPIZ25ZmePSkg7dKrynR3QZlbh8NK9UpreJHynhRlinXfODpEmFid47bEGbzWgzsxjyQ7snyYtTj3JTS2711pVAAsxoGfSqBn5z367Zob3Cf21Dbee6StdclLOThiaZFExwGHU9rHCkPQXt73bEiWyxEyKc8hNiYDZejCrUF3gEsLB6O3Up07ZPlcJ+PfnsDsUclmqDVViA0bo/usJEObZnNCYVeaOTFkE+T9lOBEV93OdxT5aIehTjH7MwXiK4fRS7xUNA6FAaDYVzFNOLsmKXwP/GdDFkvUnWyErhmuigaDxhwh8KAb+9/KkqhflqqcHKgv9AF07Qn3d4fI0ybf3WnM/WAzoJ1H9Hfva2JthPLwFcemlwBjB0cXjyd94uES7s0HiLUUfPWTfzdG5VNnlKiy8Kn/zVlADRdLZw1B93mHg4apdtBhSaeCBEbKCXPUDNu2Wlro7s+AG2KQ2+ri2+aEVIKXJd4DwM71WIe8UCxi1ikSi7aCD4ddKqsiZzToj8UmbL2gcNKYnmzQtOsztc5TCK/YY0J4Dp1yt2IpO05L2kRn59zFlmLOzbh5wt2bJTU38db1rVplyVOMEEEeUH76jM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR06MB5064.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(366004)(39830400003)(376002)(346002)(451199021)(41300700001)(6666004)(966005)(5660300002)(8676002)(8936002)(6916009)(44832011)(4326008)(66946007)(66476007)(66556008)(36756003)(316002)(786003)(478600001)(2906002)(4744005)(38100700002)(38350700002)(52116002)(6486002)(41320700001)(26005)(1076003)(6506007)(107886003)(186003)(6512007)(83380400001)(2616005)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?B9nuEBhBmKS+tbs70Zeu4MocGdyhjPTz50JPsFwa9EQY63xqiHUBh60/dhO9?=
 =?us-ascii?Q?yAm8ay+Pnt/h7BMyPX87UlsYSXhNYEYlPQtICIvdCSzV8Z0VOtm42WZpRcx8?=
 =?us-ascii?Q?tgfF5erD+600ePrXNP+hLqUNBe2mP3S4FufhvNeSyf7+qllY54KUbbFpxWUA?=
 =?us-ascii?Q?18sjHotvtFaghk3/nXHf2y5nS8w3eZyaXLx0w4ekMVG+J/lAro7L/4fbei11?=
 =?us-ascii?Q?d+qR/Vw1nfK9vqr8S6UqzDY8ZYkPgmpYbw/fzkHNpwl3NKjMQsOH2jrIEkHd?=
 =?us-ascii?Q?QI6phSZsHf1oM3MJ0/6pALG8g8HqQYzeCneGwWXhXsRaOV+cnItHqd7eWrTi?=
 =?us-ascii?Q?FnOp1ZwVOUucvDf7uQ7IYzbd/QScjJ3hEESWLp5wlmHFwg17cNHc8HqEgBxE?=
 =?us-ascii?Q?C5WW/CXFGK+ULpgk5aBiZpT+aO8kxozh+ex+0zII0R7H3j+A8fzGsL/KLxTT?=
 =?us-ascii?Q?HZ9ZFAbq2W4AqhXXWf+eBy7HRkFlb64CqcE3zLsJWwL/YFZcuS115uB8XvFN?=
 =?us-ascii?Q?cgTdrUQZUMNcMlwLw7Qq61Wzq7ocgyIzxxb9kPd84iXl6jBXa/VL0RMKcIqk?=
 =?us-ascii?Q?vjfxyrh3Vsx3gv9gr6PtwjyDM6p/j+C9RRiKo9VeivMgDG46CqDinwc0u4k6?=
 =?us-ascii?Q?FIC1zMEgAALg4Z6GQPZrtxAZFQklGGJiq4APh2zMaWp+7b3pjuLm6BIT4tKb?=
 =?us-ascii?Q?VWXj2Rcde1/QZbGz1Ry1tTR1oCgeSyx1JQn3JqCIhcJfhmGygVl+fSaFJ+Oi?=
 =?us-ascii?Q?HzZ2h7wOG/m9fppNJvrZen1+58BGnE1E4ewqNIqx7TtgwI1jiVtWiShOiPQ1?=
 =?us-ascii?Q?hsV0YrZdgtPTLg54XoGStuZiJpXGadTlzkdl+hhhvGfCVa28Ln+y4nP/2yW6?=
 =?us-ascii?Q?qwpaTQHmlp0EKP1+OgnwfnCNFtv7eMqYoQpWO9EDyQ4fIbNP2s6GOBtzHeIY?=
 =?us-ascii?Q?5aMqx+TXkCpQVuH32H21kHu6gf1xiB7OBr9E4th3gsowywllKq9utWupD2KU?=
 =?us-ascii?Q?5Gj5BTnD1yyNABjmjvXXgTUG1HlSM+6MEgysCRQT52ZQqqmrq24LWT/wPesd?=
 =?us-ascii?Q?ImPTi5hFgbOcSEK5LxdtoAzygZbtPmhQg+VsMLTxayS8QtZxiNuLPzV+yFeK?=
 =?us-ascii?Q?lTgVPAk6VA7DrF+iLSvC8/ZniUoD9AGkgeLlMRkozbP5CfDNZptvIz0ThDOn?=
 =?us-ascii?Q?iB8OIf4FZMGMYaV3Q3qE5VfAkEeWSlz6xNkWtrx9gaKokw+/wsb3sqkzXf7N?=
 =?us-ascii?Q?GGrHkajJAlEpAGNoCC5H/LeRvCsMUMwcKXlfIChwhR7aTequQo0545hCZdIA?=
 =?us-ascii?Q?BWyBDGgAh697bKddYtUl4PVQe1gtAk5r5C0KQafxwzOiClEStzoIyX+GV3KK?=
 =?us-ascii?Q?HolcSTlOsoxodxlvp5HLVEk6uVDpmE4JFFB4F5UvAX1c9E0QHMceSbuwIuIx?=
 =?us-ascii?Q?jxpGbah4KhBpJ2brRZR+s3R+I635UEVsWkRaUBSUn2hC7N4Oqf0J9ivy/Tp5?=
 =?us-ascii?Q?zGpyWsOSLbIjutmz1PRU/dieulRM8NvFRXXrEY8xnbFjyAKz+TE0NWUhFJTz?=
 =?us-ascii?Q?HsWSxgtJVz96i6H5NYVXvcLN7+56M39Kgnc/S7qOogZpnE+XqEopB0u04s5+?=
 =?us-ascii?Q?1Q=3D=3D?=
X-OriginatorOrg: sancloud.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34abb958-f3bc-4b68-3f2c-08db686dabd8
X-MS-Exchange-CrossTenant-AuthSource: SEYPR06MB5064.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2023 22:14:05.1303
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3e0f949f-6a74-4378-baf2-0abfca8d5e06
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FLAx19dg+gkJlJbbxVJkneGQ0+gmVo9WIr+f9M7cY/QL0XYlLQFiuRvUhx5MlwRbQVFtj86/O4B2E0a1teJUbWvh+ReTfaYqrNfLlAf9dak=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB4316
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

These two commits are required to build the linux-5.10.y branch
successfully with GCC 13 in my testing. Both are backports from
mainline, with a couple of tweaks to make them apply cleanly.

The result has been build tested against a few different gcc versions
(9.5, 11.3 & 13.1) and defconfigs (x86_64_defconfig, i386_defconfig,
ARM multi_v7_defconfig, ARM64 defconfig, RISCV defconfig,
RISCV rv32_defconfig) via Yocto Project builds.

Patches for linux-5.15.y have also been sent:
    https://lore.kernel.org/stable/20230608213458.123923-1-paul.barker@sancloud.com/T/

Arnd Bergmann (1):
  ata: ahci: fix enum constants for gcc-13

Kees Cook (1):
  gcc-plugins: Reorganize gimple includes for GCC 13

 drivers/ata/ahci.h               | 245 ++++++++++++++++---------------
 scripts/gcc-plugins/gcc-common.h |   9 +-
 2 files changed, 129 insertions(+), 125 deletions(-)


base-commit: c7992b6c7f0e2b0a87dd8e3f488250557b077c20
-- 
2.34.1

