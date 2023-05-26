Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2C04711FAE
	for <lists+stable@lfdr.de>; Fri, 26 May 2023 08:15:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242052AbjEZGPI (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 26 May 2023 02:15:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236728AbjEZGPG (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 26 May 2023 02:15:06 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01olkn2051.outbound.protection.outlook.com [40.92.107.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 848B3135
        for <stable@vger.kernel.org>; Thu, 25 May 2023 23:15:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a8iYQ6UQmc+1dA0nhcibZl04f1pncFcAHwjZJBh69XoSZPLNu2iopfISspVljYTVnDIr9IUUFsxY7lrDB1ZCqfUL1PC7DuMBj1Ak6XLH9wXsHb/ru9m8alejAETL2XMoLyisQIn0DeSS/+q7ViOSeebfnfTTpS+xorW6BBLE38LLEZrr6Xhaf+69QlYjoBzwE5p6ExW81oOc/7PmntN12cyF1JdWiirYSlTNa7w2aEgE0+2D+8VUqMjfVlNujtJ4GfGgYqSDpv9tjkOEM7hQUnP2vqE9j4V/SInTxuY56IMZI+eyvGxzIVAyMiR0Txg9c49glbBqMVvlz1wo7Dj3yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
 b=nHYaUuM/pf3U37LOPQMy0AWSoIBiKyGEUL/zuXu2SJgGIj2z0m1mwS7YBDyRbkLtrmBMcQpJocCNQropmnnBBknMaf6eQfhOdjtoZ/x8aTx8fHI93rdYXzScWFIu1P2MvQW8FrJDO68BeVZF5Md2Eq0OQM4uEZr34KI3OVYyiRrdMm1DfpBOqUz3apSXCcPF+LfdexnEcMrxdjYQ9GraXQy57sOtJEQNdA5m5cZ/IY3yTLgsyT+DqEShJtgvrnfN54IflwwlVVzXjsH95bdCA3ykI57mGSNRQanqpfo0Sh7/1/E9SQdvmDMCNh2fKsh7EJrklt2MN42r3lFa3lcvPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
 b=n9VeK25YgUodYoQKKSOaEmTAZHPinsBNF0wjE74GEwMoSePYir1vk5vWwp0rx076yc95WnvnNTDWxAI1EIW+CNTV/diUhxEoWl0YEVMrmeNpBZ19HZofVGQlYA2YNvA26yhQN24JUlKmpUbwwN+yRwLfZfgE7R4dxrECrqTzFZIpHr0R/g8avEqY/IGKBM4j8wDUhWo827nXCQGQ3mFzcv+3zl/qeYaRTAwbvQQMqgwEqHxryBD9KI/n8VTnZayob+BDfhp7psd38ZlkejjlwndVvpKT9YCuAbeF3/qX19vTJIalQzF4Lehsr1VJJj5ij+Mybcni9wi+A4763sNe+w==
Received: from TY2PR0101MB3774.apcprd01.prod.exchangelabs.com
 (2603:1096:404:8010::10) by PSBPR01MB3669.apcprd01.prod.exchangelabs.com
 (2603:1096:301:4::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.18; Fri, 26 May
 2023 06:15:02 +0000
Received: from TY2PR0101MB3774.apcprd01.prod.exchangelabs.com
 ([fe80::652c:55b2:49c5:43ba]) by
 TY2PR0101MB3774.apcprd01.prod.exchangelabs.com
 ([fe80::652c:55b2:49c5:43ba%4]) with mapi id 15.20.6433.018; Fri, 26 May 2023
 06:15:02 +0000
Content-Type: text/plain
From:   <pxkkbkwxymc@hotmail.com>
To:     Undisclosed recipients:;
Date:   Fri, 26 May 2023 06:15:01 +0000
X-TMN:  [WPRdpqfoxUqYESetJAd5mMxR3cmUhAVp]
X-ClientProxiedBy: TY2PR06CA0011.apcprd06.prod.outlook.com
 (2603:1096:404:42::23) To TY2PR0101MB3774.apcprd01.prod.exchangelabs.com
 (2603:1096:404:8010::10)
Message-ID: <TY2PR0101MB37748FEF4ACD9EBA506F1E63B6479@TY2PR0101MB3774.apcprd01.prod.exchangelabs.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY2PR0101MB3774:EE_|PSBPR01MB3669:EE_
X-MS-Office365-Filtering-Correlation-Id: 662831fe-2c23-4c76-c94e-08db5db08a22
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 16czf4QuOf35a2fY2U1p6wA0OZs/hGqmnatgLGvy0sj9Y/tC0T+0ak/t6qzUCdst/ClGWeyN9bJWAmOIvhXAAyp9iCDYNuTo62kquTX7aRBdxzAu99t65YAct+7AZDNOz5TUUXFVBRsJRhcWzreU75upJyYBmEdoaJs4t9ERkBj2MZmU5baHMvlxCLRQ1GG0iOniywPWXIQyWM5g7J9qQG2dwxcG08VcI5e4VL7r2ZCc2APDEcBt7v7TG2Rps3OK5pkyWi3tSBMsnRxyhrhfSzIRwR8hZpuWexbiTzkVtfA=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?D2HpNp/02j0KC1HYpDGGLClkTf6ttbNDQW7zcUXN7jwBRwapjPDri6H38zk4?=
 =?us-ascii?Q?DxFWaHcnKFyFe7UmBUozKqfdcQFjhih7H0nMZIJ3sqQQx+35anQakuGvL9J/?=
 =?us-ascii?Q?fnqwZPZgPb4JwXLNCB2vhq4yagY8LmY8+m/Zr0z1BqOdIZdyDH1ToUGCThXk?=
 =?us-ascii?Q?nAAWrqQHHEb6oAtCHY3szMFNlmgOzJwW3k76u/pxUuTKjlZW0PBTVIw+qHfM?=
 =?us-ascii?Q?8BcFaVEmTvW5iwNsbw4mJmBp9lNiOZAslAhGuHxyDfa9k0SVv5edYv8rh3ZI?=
 =?us-ascii?Q?jUD01aUPQekZt1+7RixKnpbxVAIfOVdBRHtSbU+bqBkNBPYmgSnULl1aOXmj?=
 =?us-ascii?Q?tD9v7PDVEJrZHvfi6qTwNGZ2C5tj1QArtk4qPRiMNobV3hbYSDhfzY+lS5I4?=
 =?us-ascii?Q?7q11YMCL2MNutrF2uy9dTPslqAVu1rqPzRcAZFlzEnXf3L6gD5aWjj5N55vN?=
 =?us-ascii?Q?CMGiY62lAxbyfiZvDFd1OjlGBgSP2pM6oomGyWraWTHvZkl4L4ZWkXOJTK4t?=
 =?us-ascii?Q?9MadrdCdksLw2Pdev55YIrR1U2sh6S1bYgH3+qeEjuqm5PeVyGW04mM3rXAr?=
 =?us-ascii?Q?onGf3ONrdVhWS2zdjh2aI9IAPAdgsKhk92Vnk76DNpTdPq8ZNfT7aOLh9HQj?=
 =?us-ascii?Q?m6/QbMCcgUth4x18QSwkTRffBDt2Wfh9DG0+nX4zrXceRyVEeoq4uttcCbue?=
 =?us-ascii?Q?hgeYQ+ppjlemVLTVZRLeQB427owK2nVHMnyUf7MCpdlBYmYleu28OF8dqoIC?=
 =?us-ascii?Q?A0iUOEuzRN4mIkHAGxRNU0EFsfsVtf2jpkU5huD0MNnaiL6821UeYZEupvR3?=
 =?us-ascii?Q?Yezln0ff/7l7eGjEporwBuc67Cy5YKaByDe8u3dYtX0ol9xvfJK48jhMvvh8?=
 =?us-ascii?Q?ixZ9kqTfkrquaTJXd4Zvzt+X3CcYmatmO92RSseo53Xr442dQCFqOuEFVg16?=
 =?us-ascii?Q?TJjI921eR7I3nEmZXBVMaFw+jULYTX1Cwak+7FdH+s1x883brjX1BxVrfqnL?=
 =?us-ascii?Q?VXNgGw6fQW8xqvdels5KEUYFJo19/6eI/IrnyTCA5YbspWcl+3B+0/ubTVsO?=
 =?us-ascii?Q?UqImC5w78GLhev5VhF+vgTNE/ViMpyn2pDcFBHV5jLnKYuu7Ydn2BfohzSTY?=
 =?us-ascii?Q?pBNnePqbf3AVt4a3re0aqd1AL9xl7hu4TuKAwjeI3Zlk7zoIWTUjFJHR7iAT?=
 =?us-ascii?Q?niwEjspaGErsN6yJy0AP3Gy5Ui9HAucOC4TFVWYX+XL6rjbCj7II8uFn0NU?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-d8e84.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 662831fe-2c23-4c76-c94e-08db5db08a22
X-MS-Exchange-CrossTenant-AuthSource: TY2PR0101MB3774.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2023 06:15:02.0074
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSBPR01MB3669
X-Spam-Status: No, score=2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,EMPTY_MESSAGE,FREEMAIL_FROM,
        FROM_LOCAL_NOVOWEL,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,MISSING_SUBJECT,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

