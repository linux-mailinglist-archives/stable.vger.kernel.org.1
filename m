Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE6C5728B00
	for <lists+stable@lfdr.de>; Fri,  9 Jun 2023 00:14:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233477AbjFHWOP (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 8 Jun 2023 18:14:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232715AbjFHWOO (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 8 Jun 2023 18:14:14 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2064.outbound.protection.outlook.com [40.107.255.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD7171BE4;
        Thu,  8 Jun 2023 15:14:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=al6M0Pl2CtATGIhZgcuCV0Rb+tuGSD3TiNWg8x48OohPuZn0DPMDi4Fon9EUoHpx/AoFjN2Kkyiobt6ry3eiA7lsQAZEX/Yr7Fbhz39nCi90yj6i7aEF6Swchfo8s2AHlwRDj1efbG/2IrYad1coQJT4Ju4dF5yrntfFElgfepCZXE3QgKBGAqz/clbZNQZKp9YNaf6l49VKBsyzUTYtu/WorEC0wkQ3Hn81lGijsDS86iZrrsZ8TyqfVaGzTmLpV0sx6QzjHLlavE5dpnV/UcjYMAGRaAtQGJAqtgPRt8eowEZZegzPCayHGSGMdNZIEsqMRn3lUwLdFzKPpf0cIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=08FbxRS/8pvGaDINzibzfgJbV81jYhUpMmPKyn9tmvU=;
 b=l8uESgsNfnzrnwVn/6L8YxSy4x7FVMnUh3A9G37VYbxyBXZmRi2zGP1PlrH4OE1CiggFxFftfyJA1EDq60Lag/n9sNf6W2TOcgAjRQqWB4RfsTmAlqze2pK1JlgkjEK4zQ17KGuC3OOf96qJngA7In6pDc3w6fIKRxmQnW2WwlJ/L4kRLQbMQzaw2TgQcXqmjv5TBiblciOJ89C7QINoQn9THaH23bigtV9KRv5yffpgBdL1wEa27xOdetxto23QnxEtFudqtJrVjYG12zmmExDn1hCNMj3EhrS7uMH9uAyBZ7LH3ot3LflFMzvIYQFUs0AIhpe2Xj+4tsK+NODvoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sancloud.com; dmarc=pass action=none header.from=sancloud.com;
 dkim=pass header.d=sancloud.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sancloud.com;
Received: from SEYPR06MB5064.apcprd06.prod.outlook.com (2603:1096:101:55::13)
 by SI2PR06MB4316.apcprd06.prod.outlook.com (2603:1096:4:155::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.19; Thu, 8 Jun
 2023 22:14:10 +0000
Received: from SEYPR06MB5064.apcprd06.prod.outlook.com
 ([fe80::de44:cc0c:5757:6626]) by SEYPR06MB5064.apcprd06.prod.outlook.com
 ([fe80::de44:cc0c:5757:6626%5]) with mapi id 15.20.6455.030; Thu, 8 Jun 2023
 22:14:09 +0000
From:   Paul Barker <paul.barker@sancloud.com>
To:     stable@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        linux-hardening@vger.kernel.org,
        Paul Barker <paul.barker@sancloud.com>
Subject: [PATCH 5.10.y 2/2] gcc-plugins: Reorganize gimple includes for GCC 13
Date:   Thu,  8 Jun 2023 23:13:35 +0100
Message-Id: <20230608221335.124520-3-paul.barker@sancloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230608221335.124520-1-paul.barker@sancloud.com>
References: <20230608221335.124520-1-paul.barker@sancloud.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1561; i=paul.barker@sancloud.com; h=from:subject; bh=s4JV33sZtMtcDoHuERA6iFQ9es3902ur3fu2GkSK1JA=; b=owGbwMvMwCF2w7xIXuiX9CvG02pJDClNQT13ruZ9WNOyy2PnqiQRmaqlIvfd4hfseX52+t7Ov XtkV7tN7ihlYRDjYJAVU2TZPXvX5esPlmztvSEdDDOHlQlkCAMXpwBMZCIzI8P++Tt3c0S8zN7a pVmaFeEkw2KbHRao8rOAs9LpVuiCZ7YMf+WjIm4Eb3EN8Hz4nP/07ohimcqmFQJ/b6+cwTT3OvO XcxwA
X-Developer-Key: i=paul.barker@sancloud.com; a=openpgp; fpr=D2DDFDAE30017AF4CB62AA96A67255DFCCE62ECD
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: LO4P123CA0374.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18e::19) To SEYPR06MB5064.apcprd06.prod.outlook.com
 (2603:1096:101:55::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEYPR06MB5064:EE_|SI2PR06MB4316:EE_
X-MS-Office365-Filtering-Correlation-Id: 49bcb441-caa3-40f3-b93f-08db686daee3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e46wIPHo+MN1ZDJrkynOt0vgfPPoKoOYegUdwNjLg5ky0Lz8y2YHmcsRoIr/y92WRqVGwUhurOGRocPbusGFCmE2PSSlshkzgCCiGANZ8jGXJrdATLpvoiI03beF0kt07bSH0d/qC08qB8rLCICP4cy9CZFcpewdvFNIDYEXaWXZMT6YAdDgxrTrsICu+KjaldeK/eHB+yGIEnt1EzyIEMoOS90h9V43/IanfKf60E9ydhlxv0d2KvrEajltuMUfmHpVDrurNKbItb0SgZoYgv4mfyN76q6qnSfiicVLZn23iyBPQr9KQ2cQsUChE8fmnqKYxtdrXdvRzBDOCDY8cyS4/4vUv/u+nVpV4mPWTYTW9SI2x2bJDm9NEiKj4d8KPuL/y50UJFHy15HWawboxkPIGJW6duapdzRmvcWYYZxb7cKJb9VZh8DEcmJ3iYN/KxIoAXVpGYHjXTTz98odJjpRU8zTauca7chPdVntMlfFrL63/Vd7VFq6dsukN8tgGrK6dcIJqkq6Q65PRcOG1Pzl7qtq5xg5ET886CYGmPukigIYZ97kgt23iW/XDF3xEPDIlfK+tYMVViIVHKvhcUEYZ1oQbtC1A1nhjrR0PIY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR06MB5064.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(366004)(39830400003)(376002)(346002)(451199021)(41300700001)(6666004)(966005)(5660300002)(8676002)(8936002)(6916009)(44832011)(4326008)(66946007)(66476007)(66556008)(54906003)(36756003)(316002)(786003)(478600001)(2906002)(38100700002)(38350700002)(52116002)(6486002)(41320700001)(26005)(1076003)(6506007)(107886003)(186003)(6512007)(83380400001)(2616005)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4ojDMevUW+U2erHF47E/HoqlF1rsNF0qUx2AIw0IY3ROLf922eZ5f2pzFRP1?=
 =?us-ascii?Q?KoUSAF5waLgK78iAf61Ol7U3dAOZzM3eKlf9lw2KH4AX7ecfoXoJtlrpyZaZ?=
 =?us-ascii?Q?oEmjl13Wk47rkun7tFZzrNMUYD+SWp8sGfxeSHTV/wEL+i+FQheE02KM+Svg?=
 =?us-ascii?Q?FhLy+3hM0z3mXdzLbZPca7d1TgnlHJ8viDoPtgjL0AGhTXn5rEEStVsOdhsF?=
 =?us-ascii?Q?noiNmAOrbZUVQhNnHMw23Mi9TMXAtzrfQx+2SpuyGtz0sF+YQZH5Cg1AOTA7?=
 =?us-ascii?Q?yy8vB78PD/3/KBXzKgXHhmGXKPYke+WXflW6Eh46z8ES4xZZ6RPdFjQ+XDc/?=
 =?us-ascii?Q?Y6ap0V+txG3JE1E3H65vsL5GaZdnAXzO66B+FEUBCbXHQQk78QlR/LV6MjhP?=
 =?us-ascii?Q?WTJT0LzkpI44TN2v46CHYPG2poJEizFy10qf9UmHY7vpXf29D9GaPoHz5ytw?=
 =?us-ascii?Q?vvM7e9SOpaRac44xIc5Z1Xwb6qZtSCvO9UFK8rMTRkGFHSJxts24GVEvWKAV?=
 =?us-ascii?Q?wnUOvTKZ7WBut/gf+Svls7p51hu0LwfRMd7AB+TCIDb8K3OWRrucvleo464h?=
 =?us-ascii?Q?1lfRUHzp+qPiz6A/bRiRn2H3g/r9XVITS6+t/wlFqEknbBCDmSIWCWl017jc?=
 =?us-ascii?Q?k4YGHbHBxmsSD2pnXEp0vTUTtIx+jD0CQYQmoMSmxR8NhgLgnY6LsoKfRJD4?=
 =?us-ascii?Q?hcC1SFUjjwdT8/kR7MtLDohHwqV+h1rFofbx/oxY0XZacWeswitdssxd0sSJ?=
 =?us-ascii?Q?TTmkh6OjTR+obl+IKV3ZF07OKse97b8qxO5Je41IdzWC9ojf8UbZ1sMNmCVw?=
 =?us-ascii?Q?B+o5xrFFvjkYg4IJ2WxuNAxJbjTwMy3kgCqt428K/EZ50MMJBoE3RxsrNx6B?=
 =?us-ascii?Q?vxk2jicU0jSpjckc/wG32+CYmu+ksMTtwTSQxZnF1yyarmWdpd9MIxk/QnrH?=
 =?us-ascii?Q?aF6F1oZagJhxK8U8vjq5Ty1nllJXCqdeTU4iweORnrJEwHFk/n3pIMXJDsI3?=
 =?us-ascii?Q?jeTmn38bbwh68DXdGHTzr+oIEoTmnzWWB1d02IvJbmdU7pyMACkEE4ptbi7b?=
 =?us-ascii?Q?hfACX2RToHxMrTDCFUt3o5ykPldpgnDQXq3ONSE58wQVxKMHpcbl7MdPk2V5?=
 =?us-ascii?Q?ODrL41EVfkcQpw39Ht68t05bk9wnlAbrecf2TAD5Kg4wC7PCYUJgTR808rJU?=
 =?us-ascii?Q?gtCJeQHkb02AAw7qKNFcOKY0GEZqH+930Quvbq73aaaLbI+NpM4Obd+X5JQO?=
 =?us-ascii?Q?3TDnciWJMy9WJkLMRJroh+azPYQmtzG1zdjL65EX70ifljJyJfvO5dsKQ9R0?=
 =?us-ascii?Q?yuayRDvU/U4Y202F3oANnNaDS5XZd4AcbefSylY3gpZKOL7RfOoD1vwToyvs?=
 =?us-ascii?Q?+nN0LsgeSlZHopLMolCkko/QaIs9y2n22yeo3TjhfVDfvalYqBwZmK6tAt5t?=
 =?us-ascii?Q?hoEtb+PWFP1xl4JK0TQIU7nz9LBfHY/I2McNre7feHaIe3iHDzGiylB2nQZM?=
 =?us-ascii?Q?jvygyegpzBbkC/JiOxTqArcYAqqcEUzz6jatLRhn6WsRE+rvh/H5mTs80GOI?=
 =?us-ascii?Q?Trl6LFAfdUd/1y7iynp0F9LCWFAFSsIqKqgJyTRWo6xcgClcNW5zgCFZRoaZ?=
 =?us-ascii?Q?xg=3D=3D?=
X-OriginatorOrg: sancloud.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49bcb441-caa3-40f3-b93f-08db686daee3
X-MS-Exchange-CrossTenant-AuthSource: SEYPR06MB5064.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2023 22:14:09.9130
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3e0f949f-6a74-4378-baf2-0abfca8d5e06
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /YnMLO5VPobL5fZfH3RBB31mpyY1GDBEmtNrxzqXJUI5RNoonjLZPoO8Jgt6kCSxWbJzVrIWDgdw7ufWDiEKgzpyyGkTahM/ugGxi6dwqOQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB4316
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

Modified to handle differences in other includes and conditional
compilation in the 5.10.y tree.
Signed-off-by: Paul Barker <paul.barker@sancloud.com>
---
 scripts/gcc-plugins/gcc-common.h | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/scripts/gcc-plugins/gcc-common.h b/scripts/gcc-plugins/gcc-common.h
index 9ad76b7f3f10..6d4563b8a52c 100644
--- a/scripts/gcc-plugins/gcc-common.h
+++ b/scripts/gcc-plugins/gcc-common.h
@@ -108,7 +108,13 @@
 #include "varasm.h"
 #include "stor-layout.h"
 #include "internal-fn.h"
+#endif
+
+#include "gimple.h"
+
+#if BUILDING_GCC_VERSION >= 4009
 #include "gimple-expr.h"
+#include "gimple-iterator.h"
 #include "gimple-fold.h"
 #include "context.h"
 #include "tree-ssa-alias.h"
@@ -124,13 +130,10 @@
 #include "gimplify.h"
 #endif
 
-#include "gimple.h"
-
 #if BUILDING_GCC_VERSION >= 4009
 #include "tree-ssa-operands.h"
 #include "tree-phinodes.h"
 #include "tree-cfg.h"
-#include "gimple-iterator.h"
 #include "gimple-ssa.h"
 #include "ssa-iterators.h"
 #endif
-- 
2.34.1

