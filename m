Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0075371305A
	for <lists+stable@lfdr.de>; Sat, 27 May 2023 01:25:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbjEZXZj (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 26 May 2023 19:25:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbjEZXZh (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 26 May 2023 19:25:37 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01olkn2058.outbound.protection.outlook.com [40.92.53.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 929FAB6
        for <stable@vger.kernel.org>; Fri, 26 May 2023 16:25:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NhKSb+QcaJqz9HTJUtlmtw2+lHIRa5JhvCChO9eQNKev+Qu75Pf22jgi+PE0X23+hXYyyHLMad/FhKPZINTalFBMIJqAO3WPUTMORraBEWrX6bZr9vVACduPdXkO9hFHbMP0ZRXtzYX/6nNr4pNM2SycxqSGxMps/CFeMzNDwD43ai6pSYEB6TO5lK1uxM+MKCcPvnYoh0t1sCqChk40fGbFrqTjZxECQIdKLnFwTBuzpcExceD7GHper3Fxd7EHXczAYLMQvo3cR/0nlOPU2kCIvgWhvMID2AF9GP0xpf73Pj3qwZahnu2HKc0QtnzboU3Wij9NkGhnTPeEJ5m83w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
 b=HaSvmgjZzw0XqFe1ECChoj6AKYvhPF2tfqQ8kBkwy3vvBPLZSPVNKel1twLdR3eL9TtlS+7VUZ/HTjxxsfxKAOLTIz5z3NL+Lm+NyVxBBuPCtpC/zpcoe9q/Qy2bC5TvvAredgUH1/Sq4Z6fJHRuVh8+pj+tILNWvrN7e9CVJHW8O3SKFyHh5ehqCAWvR+dslcNyodndoeziLpVnr9UPgfwgThofvZgAUga0X0YyEFLHalYUxIc3SnkeZmZBDHmzpgD54Ya/0tjjczooCF8b2tocWAxECijV/eHoCmhSQUYJH2pQ3VjUK6TAgpsb6lktES21AuWvG8WtWTLj0i/HKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
 b=sTdZo2tMdjQ5bj3ArxVswLRFujTJYsLcIOqeYQFWtMqQL2aZ16rG6nAZHc6rbmoBVhGhoT2KWyuvqBJMxATv7q1rTGyRfj/tfoXKsgmlAn1wDvjiI08lm9VPUHu+LafUPCotfN1KDWT7yKsTznr/M3JhbqQp+b05+FaL3w0dEaRq10jMGfvFQRE2kFx0wzdyvJt2DviKqivOsL8DG++NQrjH9ZVfLo+Mp7lfF0HD0fidgCirt5YJlRYzEGHef5qcMZRQcyGMlCZTpdeByjclzQIuUVgDUOMVkVaf0oXRO14QkJxf+SEi8pftKRbUwmlbT6+TRw6WQsiP7gMhVEhnGA==
Received: from PUZPR01MB5119.apcprd01.prod.exchangelabs.com
 (2603:1096:301:117::16) by JH0PR01MB5584.apcprd01.prod.exchangelabs.com
 (2603:1096:990:c::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.27; Fri, 26 May
 2023 23:25:33 +0000
Received: from PUZPR01MB5119.apcprd01.prod.exchangelabs.com
 ([fe80::34cb:d7cc:71f:8f2b]) by PUZPR01MB5119.apcprd01.prod.exchangelabs.com
 ([fe80::34cb:d7cc:71f:8f2b%3]) with mapi id 15.20.6433.018; Fri, 26 May 2023
 23:25:33 +0000
Content-Type: text/plain
From:   <khksdvekbxm@hotmail.com>
To:     Undisclosed recipients:;
Date:   Fri, 26 May 2023 23:25:32 +0000
X-TMN:  [nEXKXGU2XWwG3MzQWA31NFcB/47q0Qf0]
X-ClientProxiedBy: SG2P153CA0043.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::12)
 To PUZPR01MB5119.apcprd01.prod.exchangelabs.com (2603:1096:301:117::16)
Message-ID: <PUZPR01MB51190D35C066005586989D62BF479@PUZPR01MB5119.apcprd01.prod.exchangelabs.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR01MB5119:EE_|JH0PR01MB5584:EE_
X-MS-Office365-Filtering-Correlation-Id: b35c30d0-cca9-4dc3-5754-08db5e408090
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4lT64YxhVysROqDFIKfvh1w4pF5SNhD8boD8anZoL6T1oOctINX0dC9hWWpZRFaZIyJPAzObv4n65SzgMY/1ytzN3ViYs+EE2egsDAPOPBBv9Nk5TZ5Z3h2VyIrim4YHehhccK5KrcA02ROkV/vZr800T4TvS9GBjQhkkfk7YoEbSHgPgkAkMCPqKZskb6eA724JQqFk4yWnWEj+lZW2qsPXBZCwoW7IwXuiIM/u+Ly/rxKIGT9ut+KERTAs0AvwHkQzXgn2iS85YcVFOAY9Zi8E9So7UTzhpRnOwbXUGRE=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?el/9NqmSDRxzk8Dx9rC0cJVllIOzLj1vfTGoiD4l3zZMRTIUZMPS7msHLK52?=
 =?us-ascii?Q?IgWI4dRvQVq7LfvGh6r7ANMiz55J8cxveNFPSmn7MtgbQ2CybgSUF9qLNXfA?=
 =?us-ascii?Q?dug52ELIRjBkuyXsLYXLx9JlE3W12JY4D6v2Vz9mTErN6c8e/4tEHhQBmATR?=
 =?us-ascii?Q?S644ev6vrwXddX+QgeCdb3Sn9BJORGB52iRsjWmrxP3nCqeZXmJfgOLNxKrf?=
 =?us-ascii?Q?v9njqm75lrjGknWmbTb/N/KE/75acXHNLj2jzLYn1UfYoUNwTNsguTIcZumf?=
 =?us-ascii?Q?O7AVT2eYdjFXYuSkyiab/T/KGWpXjZsg2lJf+CpY5pTCcdn+FB+uwVjdClQB?=
 =?us-ascii?Q?BvmhSJ+Hr9g94ZxQXW7/ixTt9LmM21+7mhezF6/xQHZDJhkm5DJ/xOBMegsQ?=
 =?us-ascii?Q?1rrbwzc4neK50DS2IhZ6tKJgiBYKmUci2iEIgE9U2SJt9zlnKDWZpUcEwp/h?=
 =?us-ascii?Q?slpkWmPodA3Fgd3zWLnvS39hiWA75DS+xF7TmYcqHVuz7aEamsw+8fCyJzCB?=
 =?us-ascii?Q?Xgl3dHI+SN7pRXPeViYCfMGbSpeC+a0bCc0rkgGHMc40HGfjVGwwq2YQZ5rq?=
 =?us-ascii?Q?npAbcm/62j9/IKxTkfUwx08H/fMoPNMv7uFZqLF2te7iSIBBLIWinwonYD63?=
 =?us-ascii?Q?uVvnMlxOGL6RifxZEWn0SKddawBifmVm2suUICLrh1sQ0GaudYau+r6+Ar1/?=
 =?us-ascii?Q?TWSSEqqlaG6d6d88y7jdPImVAXN371hCizFhKoCBgJj83AO+Xv/01dQfcUuQ?=
 =?us-ascii?Q?eiEIsipNUxWSt2eLKawIcUGjPP6GgcCG4Vk5RhgnHyE5ADZFJLJ9gvNkfAfq?=
 =?us-ascii?Q?dvz89k/rlP+a2/j2wFCyPhVQIb9RuqRjXKFKJ4cfxtld73UVwv9aX6oK7Gvn?=
 =?us-ascii?Q?MEi9JKy9XarpmxEQNnZQOxdTdMsec4onKJXDjw0ehwIrgozewJwDKGCBplGW?=
 =?us-ascii?Q?y0fgrW/qfBzezvynX1Xp+2YYNCDs1uwqX8b9aFWAFHKpeKJfqyctA1HFeIuR?=
 =?us-ascii?Q?6DDMUcH/Xl9hcSQc+bW9K0zkIplJ4A4IaxkmkU3vHw2/VWVjFtjKT0pL0vIs?=
 =?us-ascii?Q?SaHHdqDAMGEpIecLSrTIr3L7imfLeVcqw8cE/dreMZ57NO/Ckir3BbXCGKzb?=
 =?us-ascii?Q?Rhc/2qm6ZBqw22gPdEgqp9C+2dQdkEfehbvrpyqQKrhT0aECuFd11agvzV0O?=
 =?us-ascii?Q?PtMs99fWBStd8yqlY8fyzMPnJdr1ZHlWo07j4mr3G+HmJpO7n9HqbOU7MiM?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-d8e84.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: b35c30d0-cca9-4dc3-5754-08db5e408090
X-MS-Exchange-CrossTenant-AuthSource: PUZPR01MB5119.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2023 23:25:33.3677
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR01MB5584
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

