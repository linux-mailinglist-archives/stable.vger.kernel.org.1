Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7D5271028C
	for <lists+stable@lfdr.de>; Thu, 25 May 2023 03:49:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbjEYBtp (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 24 May 2023 21:49:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjEYBtp (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 24 May 2023 21:49:45 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01olkn2026.outbound.protection.outlook.com [40.92.53.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4485B2
        for <stable@vger.kernel.org>; Wed, 24 May 2023 18:49:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KDWapf99+NOmzXp09ioKt258gnm/ZBuQu4MssnUQth0paUA59n1jT0w02LJFg1riEMwwE4QcwiLNQsmznvkLIhDHNmPyIeA6FkMyWNG8tB+XMPYI9OjOchLhT+WzTOlePryVuF3zWGlSLglz/xLlrbHKbAKG8ilOWOjFzh4fRXwschW13vUCkDtLVl8Kn3FIBLZ+us33zKbVIQSj+N1Z4u8qotVNEGQEgph0HG2kf5u8BLWGVGCTKegB2eTgK8IvARoCQ6ExazldQhu4dvvakoScg+u8BvuUi1urFkOXfb7UnJdH8YACx7cTvdxHyi1zryQvZET36CJ2Odih5ypcWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
 b=A0IhWLyWCF1CermEVDtiQ1vKf5NJeHlJa+/MucwlAITooY/n5c2JZyg9r6fQm5NdA8S7orQACX60nkYMTBhEHJ+jYu0a52oPt1nSQhiX380teJyBqCd5LJ+onbribf0JVlmb7e9qIkK9jYIfvQ1gCilXpl24ypGO1jfyK/jJl+LSQmcdO4Tl+Cns9Jk+Ymj6Ce3qJqisdRIjukeGjIuuFMj8o8c653ax1RgYzDEA2AmjXbzpgYxJHRkXuqN0+rxZgHx/0nE/oLwPF8Pze6JpBGE1Q3Zwn0ltPZWPhaKRXsycETXdiQZBDb42oD+qFTEpw5irjiHuxqiEs3FivEKxzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
 b=QMmJa1MhRRbJrY3mxq/wP1eLPOrHmZIWzoD1yY6W6DvduV9WnjZPiq5gQU4ozp4OyKAZ4qFnrz6iote+JQRxWhKDaEpthYZRgR11pL9NYNYnfmcukFGA2bGs0FWLvPBOLfzWR9WBv11JwXX9ff3GQLbPRuRMbsajtLjLnMkhxQHVMF7OGWo+KLxYkeRF/AXAHyXrUJMlLL7CSt1r1ffF+ivD9MXIm+ceYUlXpmb1Psv0hIwDfic41i1Q+sSpTzm9Iw+KOzSZfkVi1lJY2TBm716v+8JotV8U9y4V2F7ulFg8ZWN9KrJH7lbAwFHOiTylMgPvV713pG0OSDfTmt8TDw==
Received: from SI2PR01MB4201.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1a8::8) by KL1PR01MB4960.apcprd01.prod.exchangelabs.com
 (2603:1096:820:b2::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Thu, 25 May
 2023 01:49:40 +0000
Received: from SI2PR01MB4201.apcprd01.prod.exchangelabs.com
 ([fe80::cd5f:f0d4:87eb:e368]) by SI2PR01MB4201.apcprd01.prod.exchangelabs.com
 ([fe80::cd5f:f0d4:87eb:e368%7]) with mapi id 15.20.6433.015; Thu, 25 May 2023
 01:49:40 +0000
Content-Type: text/plain
From:   <baaknshfwc@hotmail.com>
To:     Undisclosed recipients:;
Date:   Thu, 25 May 2023 01:49:39 +0000
X-TMN:  [lRlgZNBVaueulLOdPkXqU4hKJKkYgD5Tsa36ig0zTrE=]
X-ClientProxiedBy: TYCPR01CA0112.jpnprd01.prod.outlook.com
 (2603:1096:405:4::28) To SI2PR01MB4201.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1a8::8)
Message-ID: <SI2PR01MB420189711970AE9061EEAFE2C1469@SI2PR01MB4201.apcprd01.prod.exchangelabs.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR01MB4201:EE_|KL1PR01MB4960:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d5a9b3e-9543-4c22-c8f0-08db5cc24df9
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ry7w8l/b07f++vZhCjH/ES1ZhIbkveqWfvXuZu2ImKp7JA1yKpf1o1jskC3R91pTyYUCIigoRPtjvKmu61WTyIXlC0YxXfnpVcmyTLVgUH+aMY1xtgPXLMH/WwvTKOip59PBJzVdAAswhVRIAASv8ONNsaRla1FAxkJwGkg77mRzFK6AwozoKTwDelMIqeZFZFEQx1sqsCKan3pX8xrN7slGREeFNuoRINGaK+f5fkztMN8Xll8uYA3LYmS0zBRL2ZXL4bDw4CjaVF4FsbszrJqmtbFsE2pJR8rhATDsjTc=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KQr6gSrd+o4TDAENx7O5yVM48PuhgNkPAXFCedUkQI0gbWfZuP04b+UrSNmr?=
 =?us-ascii?Q?ZLzjjMcRWwyJyceG7GYZSve0Bwhg2DYjm32s9jrHv0iNLoa/VHOIoojpEL7X?=
 =?us-ascii?Q?e7wwBHDBjYcCUpABADkBY1TKKrJTlZMpObci0lvFPDKyVnqPUt68COmPIpZo?=
 =?us-ascii?Q?bd8iXPYvL8IK/L8kabOqTF7wVpZkbqgp7kJt96U4WpG4dz8aipkkMzjrUtGH?=
 =?us-ascii?Q?PZS1i51ROfo6SE5MayQ1/WtCLsBLauEvxIXCbIgvzAP5y6Q4lUlvGq4+QKIJ?=
 =?us-ascii?Q?2v2i86qp0PbpyDIE0IwStLtNMq3WlLj2hHBPE+cohsM5DXKf5JHpRJHzFpbg?=
 =?us-ascii?Q?tjKp6a+wUXyPPnybjr4Lk7DzJxNUsVNjg0XhCNRrPkcZ8KQirpl8/A2xtqqO?=
 =?us-ascii?Q?sFE3KzmqQ13UF1FruFNJSfmcmylUleDwcpbRs7bDWI7+ArDtqGVEt5EaGBwX?=
 =?us-ascii?Q?Qkyk4BETWZlGxLedJn/D6ThuRySuBSxp1jQMw2wOSDXO/BwUYjvsTNGSfD0E?=
 =?us-ascii?Q?eJ3M5KNOzx/02vaU6oWrOp8L4OFxBGFDuy2Ac6w04Mlfa3Ky9crnvvAfSpgf?=
 =?us-ascii?Q?iKjlF9gTDw2ynzK3NAi8bccHuBJi9312XUV9dTDHueYNSsZCo2gRjA6XUFof?=
 =?us-ascii?Q?YQDpmSP49gasvSrqAaDEr9oWfRkHrNjQb6dyEpS0C+9BNn/56JizTa/k1Lh0?=
 =?us-ascii?Q?8zX0q11OpD97dcwMvFB95iMnmzqhFN+7qmVUCjK/PtQ7whvg1MbJszOcr8M5?=
 =?us-ascii?Q?fMqgq+A3l/G17qMtRVT4w7+twG2zBlCYArFHE9cAYiWV645Ul2pKhuKXTWT9?=
 =?us-ascii?Q?ggEA4WWBdZbQcsR+n8i8m4TDkPLm83ah8DFTFBJTwu5QuOKDFoHqBCgQ/Sbi?=
 =?us-ascii?Q?y2Vk9p9NOudYQS/FGl8Eu4t6oH/MEi0bnXTdSCazqEqcx3jxFpHIQ4VsUo71?=
 =?us-ascii?Q?8twbRNL2Xt9M8VLwBvjueLuzZfNGfZ+x5JUU7YfN6feICT/pyb24fs3L6kMM?=
 =?us-ascii?Q?vcerAZmGecHlOCEczKTWMhUUVS+9ydGtktqts+18RnP7s/PlCYDT2Rauz8P9?=
 =?us-ascii?Q?VGujCsohUBYFNIvpCKz7laCkCpKSNVA96Uvaa7UWDBFkrOW3F/1Rzqwu2CFY?=
 =?us-ascii?Q?KUzW0otajLF8axqJ/qwXuCtKiKFVAnKQDy6cGR4nfcGZB+2GLj6XLmZwa0BM?=
 =?us-ascii?Q?u8zEFWpSan4yAA+/0YBJR4+yIQ7YUWhwk4OSEIeTIqRsirIu/Ceu279oeIM?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-d8e84.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d5a9b3e-9543-4c22-c8f0-08db5cc24df9
X-MS-Exchange-CrossTenant-AuthSource: SI2PR01MB4201.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2023 01:49:40.7467
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR01MB4960
X-Spam-Status: No, score=2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,EMPTY_MESSAGE,FREEMAIL_FROM,
        MISSING_SUBJECT,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

