Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9876F728A4B
	for <lists+stable@lfdr.de>; Thu,  8 Jun 2023 23:35:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232119AbjFHVf3 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 8 Jun 2023 17:35:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235550AbjFHVf1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 8 Jun 2023 17:35:27 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2075.outbound.protection.outlook.com [40.107.215.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BD0A2D7B;
        Thu,  8 Jun 2023 14:35:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=avrL90Im+5wJNRNHp6JWt2Pspoh/QAVnD35rLu1xZQoLBRUvluFEWMqBr40/OSWZ81a9/k3+A3kqlF2L7PLzulIkYP0R8XNWWs1hde3NfAforZKAPPb3UKoKB5yPbEN+ktgSV77UIGL9XrtEfHqxiZlBYWS/6r3/tYZufDf2spxxUI/f+bMRDSAL86GfVmK9ujL9k3mZtTLSMdzz6GYHiCDZFKlQsAbGpVd3QvG9/d7Dp5sth6J0STmukBHL5YZIc64HTYnliYxKWcLsF0K5KsDRrSVL44fTiGCVhkZWVnFXl0yznIZsVQBjKsUo1Vr1qytnkPjYlkwpT/6fcSMvsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y3hXpje3YoucipAT7F6oome1aTX7JDJfaDC+fpQzGS0=;
 b=ifFjtm2kiqbCLD+XRbKWe1LZOgWH1sB5V7GQNHDeh35Bw+VPz0XTtoj8ZPvzvrt+oe7GfivXmNdx/JErebnFxYso6XPzWCc8ciMXAcjSSzxyhyCdFTzSPzOPybHaoZehwYG9S4MGidnGNmNNacelbsx4d/DGllrLu3pvtMLfQVMCVkAX6l6br9cSVsMpLDjAFJwwALvG9iaE7Kbl3CtRkrCL488SV8PzmoaFbg+BqDVH+SiC+I3MX4I22zXmWhz5YXwlsWxa7a1jzoCwBkA9ymH5LMfqO0YqfWrvIuWiNb0Esup3v8BMPe7HC4gPNc4eTPPA1j+pD1O6Gd6eYD7WKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sancloud.com; dmarc=pass action=none header.from=sancloud.com;
 dkim=pass header.d=sancloud.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sancloud.com;
Received: from SEYPR06MB5064.apcprd06.prod.outlook.com (2603:1096:101:55::13)
 by TYSPR06MB6750.apcprd06.prod.outlook.com (2603:1096:400:479::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.31; Thu, 8 Jun
 2023 21:35:22 +0000
Received: from SEYPR06MB5064.apcprd06.prod.outlook.com
 ([fe80::de44:cc0c:5757:6626]) by SEYPR06MB5064.apcprd06.prod.outlook.com
 ([fe80::de44:cc0c:5757:6626%5]) with mapi id 15.20.6455.030; Thu, 8 Jun 2023
 21:35:22 +0000
From:   Paul Barker <paul.barker@sancloud.com>
To:     stable@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        linux-hardening@vger.kernel.org,
        Paul Barker <paul.barker@sancloud.com>
Subject: [PATCH 5.15.y 2/2] gcc-plugins: Reorganize gimple includes for GCC 13
Date:   Thu,  8 Jun 2023 22:34:58 +0100
Message-Id: <20230608213458.123923-3-paul.barker@sancloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230608213458.123923-1-paul.barker@sancloud.com>
References: <20230608213458.123923-1-paul.barker@sancloud.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1458; i=paul.barker@sancloud.com; h=from:subject; bh=x1UQXG8uYMFX6iY034dqofvH63V8NJ0yxkPcrdslsOU=; b=owGbwMvMwCF2w7xIXuiX9CvG02pJDClNnvUvi7fMcIgIPsP97UeEXfbZM47iCQ4T13eYG/ovN Xp2WeNoRykLgxgHg6yYIsvu2bsuX3+wZGvvDelgmDmsTCBDGLg4BWAiCd2MDNsO36icGJXqfkJy x2HzI5ziZjrP5p3ay1sluN8s5Mj+FxWMDBvenD7DLBRYLdL9g03hj/NxPe8yoybdk2//+0l++Bn swQ4A
X-Developer-Key: i=paul.barker@sancloud.com; a=openpgp; fpr=D2DDFDAE30017AF4CB62AA96A67255DFCCE62ECD
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: LO4P265CA0262.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:37c::10) To SEYPR06MB5064.apcprd06.prod.outlook.com
 (2603:1096:101:55::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEYPR06MB5064:EE_|TYSPR06MB6750:EE_
X-MS-Office365-Filtering-Correlation-Id: 7655c303-919a-4063-8a3b-08db686843a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1yoi117aAtdBct+m9drMfXOIU0fc76x5Dv5SLlT/iEq2u3sXCmABlJ5pPLeyjORoANDZ9ZY5FnLZVnfE0x9mUJE4a6UMeZnHmJ6eSiIxMIq/RZytNXalft1Vy73ogJ/qUs3hkCRQCp3cEiL9LSJc/9zATIu9F4VMcEL+CeDIfL/oZqU2KGyqR7axc19kkdwEskrvKDfJgqF74LhYvX7sKdy0bGafaYE6LxcEl4dD10q5EArZ3UwVU41bWMURvR5K8RlEOdvhrW3XFFx9uYV3bGQ4IFIi3Ysy3TtdoySF+gXRXc9Nep640qphlXUzer3QDgB4F4WFW4XKkRtLzScQSOCcBzyt0cWyn2si9kuL3LWjJpU9qv3K1EBYvaiOJ17Q92cNYpZE1DdNgZ9Z5H5CRh8DijLuQF5GUYnqzbSvLNMvBMCBftwdxgQkZPK0Peog5iiAPwSngWvo/zfgiw2m6hUii2o7xG5iEv20CLzFeXM9KsgKlRISWsfLmjwo5kcuLU94NlCd8ddbbPwNpARMWozuk1jUY4N8XAvNhQB35jWg2gB4/1Mj5Whh1Qx7gogrDp85jSJw603IZBbnjCuRAHGQhThfzshy12XL9T9SGOg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR06MB5064.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39830400003)(366004)(376002)(136003)(346002)(396003)(451199021)(786003)(316002)(36756003)(86362001)(38350700002)(41300700001)(38100700002)(83380400001)(66946007)(26005)(6506007)(1076003)(6512007)(66476007)(66556008)(186003)(2616005)(4326008)(6916009)(6666004)(478600001)(41320700001)(107886003)(54906003)(2906002)(52116002)(6486002)(44832011)(966005)(5660300002)(8936002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6dC622JTNwq4Vbwst39ROvYw+vHNEIhBSEOmmuVuIE5ZJB92TE2S1w3mqcBN?=
 =?us-ascii?Q?EpaylCPZKdRcYNipyKWqTpxR8fGO4SNLt7WgVX2JvORdQdJa3jyZaneuJ1Cc?=
 =?us-ascii?Q?YK9MXx28IOjZtk/fjTfDVQwtt7sQUInMf/APXgyS10PJf1ZUBfah3w1WvtfV?=
 =?us-ascii?Q?/YuRFVC+KVTkdpQyC7eE7y0NzUU0KOCn366ZPsS/yPC8ycYJJzxLS38Jlag6?=
 =?us-ascii?Q?+DUYcyKfmkVhRCJfc06UmKPJ+a7sfzx6apePHBdhGfKe781FCp66Mf5Si2fT?=
 =?us-ascii?Q?SgO7T7r9gyBF8RZywcBVAEYow4+i2alhTo6by7UKJJv2yfCcRJsRRn9xRhLw?=
 =?us-ascii?Q?7c8B6eZiEvP+6kAKUJ/lML2xQEcQwjWvR4LD2MPqay26oOLKj2EgIFxHM0hP?=
 =?us-ascii?Q?XB3je8BY+z+KrCu7ylFVCrgTz7QjJWcwNbw9T4iwhuIp3SIRE+q4nHLOp+ZC?=
 =?us-ascii?Q?CidY4+vo1L6uaMfHcGD4u29HXPl7/clRpkabnwhqH/pvbN2cnTl5vQDZnIBN?=
 =?us-ascii?Q?5hKY9tXgkw+Ci8DdFIWQQb52h2nDEvzv1wemT54lhcd53tQha/JZmInF4fhI?=
 =?us-ascii?Q?HL0v3bQdFZ2G10KDEGQ2j52FHR/cvOO29DHlB0GR0oI1I7G/9tdsq2RIM5KZ?=
 =?us-ascii?Q?SysOMvcqIBU6a0wxSKnnvaLc4J/7qFOCh3+Zl3oEAWN7RkRwi3XGb0szxJUH?=
 =?us-ascii?Q?pNDhFDHx/jIDt+AM8ADWNOYpZDlr5lHSO7sFSQeSmkIYyCT9V+TApxpYOfm5?=
 =?us-ascii?Q?XzAna3uJI2A3Q0aEdOQXcTzI1OXMkjx/+zpnNPQO3aWVRkNYulC8IgTUE5ST?=
 =?us-ascii?Q?5D14YbzmSofw5qajKdCAB2eG5ailKAY7B1RWcdFlVlL5JytsGHQCvajfzh4/?=
 =?us-ascii?Q?iO3Qc40JNcy+RE4TzAwJkyEEx+qcloBfxs0EPLMVjZEodUbEddVrp+QS2GFl?=
 =?us-ascii?Q?SQW3iO4ivZgr6+8h2qd2uFwzXcE+Cv7rPzTlTo020sae88CnAvmOqte6C3Se?=
 =?us-ascii?Q?JJc9JnHIPQer+L3N+BBSXz+Kdu7NCHzkSk2iGE1Fbxh4naZlSIC4J1iHSnMd?=
 =?us-ascii?Q?Ts3HS27pl9+fJj8ll7yGCiDsYfzkrK8SswCq/elHuGybhy1fQJHUz/stnvL9?=
 =?us-ascii?Q?+OMnrYJY5wzZLAPZOcuOep5QurPRqJpYoGoZdllcFftuMQnhfHpblukvpcWx?=
 =?us-ascii?Q?UN4m6qKsD2ZT0r8JxJYdvS1/kLsObjRItCN7AQ8GjOXCvGnqy5pW4fj0qzi7?=
 =?us-ascii?Q?wpmQub/ZQQe489ENHd07peJokg59Abvr72sFeYyPH5QLseWce8yqi1YQ9XiQ?=
 =?us-ascii?Q?n2h/PDS0i67yLKp/VodY2OOsbQ5qzIvejgbC5m+l2xn6Hlz1ZTDKxXItU1iw?=
 =?us-ascii?Q?qqo6H7u6k0/TjC+4vPGVQkwpOuMOoZtkoiRTQ3TcQHDfAWYZPVwaBggBSl7n?=
 =?us-ascii?Q?gC0F4k443TO2hntwCpKUCE2jZW61k0eq23eeRjDufh/2PUV/xm3Iw9ltXGrH?=
 =?us-ascii?Q?lV7lgl+B8IQZBcI1YLwUnhIqiCTBxmYDV8JeK6xO+Ve5QUxHTsSznzNfVI6j?=
 =?us-ascii?Q?QNhaJyV+lcpumay6U1Cmn3eaSbUNKl3COwVjSQIAEBAzRXuwQTZN3jidQmmZ?=
 =?us-ascii?Q?ZQ=3D=3D?=
X-OriginatorOrg: sancloud.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7655c303-919a-4063-8a3b-08db686843a2
X-MS-Exchange-CrossTenant-AuthSource: SEYPR06MB5064.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2023 21:35:22.5259
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3e0f949f-6a74-4378-baf2-0abfca8d5e06
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 03YbHBeXM+HcQclLw2lm8b4r+TL8GVIivK6wXIrGKYVzneHCWXOo4CiYfQuvFAumoWiI2m8HOQzRXFZfagyIqqJfvD7lPV6S8wV7vPamuGk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB6750
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Kees Cook <keescook@chromium.org>

mainline commit: e6a71160cc145e18ab45195abf89884112e02dfb

The gimple-iterator.h header must be included before gimple-fold.h
starting with GCC 13. Reorganize gimple headers to work for all GCC
versions.

Reported-by: Palmer Dabbelt <palmer@rivosinc.com>
Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
Link: https://lore.kernel.org/all/20230113173033.4380-1-palmer@rivosinc.com/
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>

Modified to handle differences in other includes in the 5.15.y tree.
Signed-off-by: Paul Barker <paul.barker@sancloud.com>
---
 scripts/gcc-plugins/gcc-common.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/gcc-plugins/gcc-common.h b/scripts/gcc-plugins/gcc-common.h
index 0c087614fc3e..3f3c37bc14e8 100644
--- a/scripts/gcc-plugins/gcc-common.h
+++ b/scripts/gcc-plugins/gcc-common.h
@@ -77,7 +77,9 @@
 #include "varasm.h"
 #include "stor-layout.h"
 #include "internal-fn.h"
+#include "gimple.h"
 #include "gimple-expr.h"
+#include "gimple-iterator.h"
 #include "gimple-fold.h"
 #include "context.h"
 #include "tree-ssa-alias.h"
@@ -91,11 +93,9 @@
 #include "tree-eh.h"
 #include "stmt.h"
 #include "gimplify.h"
-#include "gimple.h"
 #include "tree-ssa-operands.h"
 #include "tree-phinodes.h"
 #include "tree-cfg.h"
-#include "gimple-iterator.h"
 #include "gimple-ssa.h"
 #include "ssa-iterators.h"
 
-- 
2.34.1

