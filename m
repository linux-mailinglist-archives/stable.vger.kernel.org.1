Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6840771035E
	for <lists+stable@lfdr.de>; Thu, 25 May 2023 05:38:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbjEYDiM (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 24 May 2023 23:38:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbjEYDiK (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 24 May 2023 23:38:10 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01olkn2032.outbound.protection.outlook.com [40.92.53.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1A3DE2
        for <stable@vger.kernel.org>; Wed, 24 May 2023 20:38:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WarhyCysoZ3yu0uTcoKI8AVTdr/ti1vb+BQa1i9UIkmh2X+SVXjx+x181EgWGHy5JpOppTEwGBkkbq9viVRrUnM0VfGC4daAcHsfNp51/RDYdeDF2yrqLvLVFAqealgnCPIflvzia8Cm2hH2NzExkFCMlIzh+sXu7BTwqJt2Lb5G1paXd4RHQf910C/88iJcby5eySuIZexg43Ek3CYqDeKnbTBEzhlcSEMqBGmd0OVe8GaBzfi8i9J4OSv4/MMFz3U9kFuTPUxR5jme9AHn682GndUHARH4k1LbExks39LO6p2OW0KouQ8rZX5KPIGoXzthknF7LOzM3Wn1nuZNig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
 b=Fm2Sv6pVJID9elhz0KKZej245ac/jcUrVTMxEMmkPunY2rKXMxwVQEyrGHA5vw8inLes6C8n48YC5c5NSGkQ5SEEpGChDEhxYYGN7uYrDbP6ts8SVCI/d7vy/iy1fC41H33TWkAvq45yFZkAi0OZswA5B8FDbgvaF53RfcDybo6GnJu38dsk0GD1ejDqnShkXYvD9T3eBEQQ7K1LFPi18IfMQPUdtXzdNlXNlopBqp1q/WsuLWAbrzlSHyKafiDUJUj0gv5tYFOHCs5tp4FD+h+67di6wbVnUOSnS3HzUwg+EYZCEGOAIJ9P2MOAbPPV/jusbNdJd3PFeTZ1eXEuFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
 b=gewMbVhBa2yj2v+lIfHjnZU3bUC5Lzf06plFFnWcnnSKNB2XQLzGanCiAr5NDr7RjYBi/OSqWH+jjx1pgaiW+9njyETXI2fyIrSaceAvN57vVIzIfDFBSEtT4lUh/iqyQw91IRl0q6u1KOZwsqF1xa0J76ELmhX7//hJrxubnP/eAaWAz/1n1nak4Xw5mgji9slWXQQdTV/HC63W0QxYDxqxh/0ycTnoiOgWwdHHGLGFUHafeVnI36xV7X4yf/+ctJp1o9ZNs5v0xsDztPVS9XiYgvdymb6SPmGJ5PCG9b+vfXU7uu0xRqvkJ3X85nTzSXkHDgc7hCixvp+oLRUyXg==
Received: from TYUPR01MB5234.apcprd01.prod.exchangelabs.com
 (2603:1096:400:359::6) by TYZPR01MB5158.apcprd01.prod.exchangelabs.com
 (2603:1096:400:33e::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Thu, 25 May
 2023 03:38:06 +0000
Received: from TYUPR01MB5234.apcprd01.prod.exchangelabs.com
 ([fe80::6ccd:4add:f16b:3b48]) by TYUPR01MB5234.apcprd01.prod.exchangelabs.com
 ([fe80::6ccd:4add:f16b:3b48%7]) with mapi id 15.20.6433.016; Thu, 25 May 2023
 03:38:05 +0000
Content-Type: text/plain
From:   <cnbvnepth@hotmail.com>
To:     Undisclosed recipients:;
Date:   Thu, 25 May 2023 03:38:04 +0000
X-TMN:  [72Sle+jTUHsH54sFcpU+oPcKrfZn8eG9BhnO1qr1g/0=]
X-ClientProxiedBy: SG2PR02CA0104.apcprd02.prod.outlook.com
 (2603:1096:4:92::20) To TYUPR01MB5234.apcprd01.prod.exchangelabs.com
 (2603:1096:400:359::6)
Message-ID: <TYUPR01MB5234ECDA81E7F4B72DE1EE81B1469@TYUPR01MB5234.apcprd01.prod.exchangelabs.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYUPR01MB5234:EE_|TYZPR01MB5158:EE_
X-MS-Office365-Filtering-Correlation-Id: 08499e31-4766-4a8f-1e64-08db5cd17320
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vzBI+AtNBcvy6+f+58FeBWr1xKlsyhh0qG+BDYu7/qpyBGHVbTrg50ONqyyv6m9zJP4CnXuyrfM7ngt5i0YwsJdY/GE/Umv63jpJtD4gfoUF7KXvrLGBUGQuUzgg2YJyEuulWhlSe7N7wKYJDKL9IsjZZmtMzWRLyOPtuE0kl142Li7Fl1qcFzZu9wqtZA9kw4YteVrMIZZMmU9vNglh81zkvbaS5Kqu7doHua0v/Obp14wpwJzDMgiZ21WDjInpI8kvdlmlqusMbHihRO1BXlPt17LT9or6PDv3+slSw1g=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Me5bcCgAg2NWpn8rClJQZcTk+BBhwv8BrzkmPcVuvB33dJhIjacyM0A+xNbB?=
 =?us-ascii?Q?fgM+ynjpimEveiwkDG8xIbo6IZRSA9a5xVUI8WmPIsXtnV+xxp5Sty68rgAi?=
 =?us-ascii?Q?INgzPb0g9183iiFCmXGtRVMhWB0zMjEH/R7AVnglHXIeb3GoTJ4E2qLeIkYB?=
 =?us-ascii?Q?2HA4T+3ekZHXak0UguAqneNSVP2cCEyg1lyBF7JKRXe9picbvg1d3QENzIm4?=
 =?us-ascii?Q?jgfsGoB0ShuaZKj87hRJqm7pAIl4bi2GrtrVlWuVoShaZ8xgaEWPiPzPDRNw?=
 =?us-ascii?Q?AZc+mbx2kNyJWMF+3KEEP8CiEy8pCsTmyTU2opCoS1X7uA/7CSRdTHO3Qed5?=
 =?us-ascii?Q?JPkl8mYJZoJNjU95H/g+Xj6B0UQDzZgrl+Qj2UdyIJ0jKzbYfXGrjN3L2y6P?=
 =?us-ascii?Q?ivaQdgrJZfRtIiTTu0kUNgj/jV1tKTD1JZ+M9VNQY32TaMP6eTMySxfjRSc2?=
 =?us-ascii?Q?WhmBYgics26dC+B3SiQ/32d0/GgvTfLqcTF+1yM597dJjBoMvZs6AvYKJNKa?=
 =?us-ascii?Q?eaxC/Y/Nt2/nd45baUggdNm6LfYBllyQuALNvFDQkjx/eNdUCk6cU8bYR0Jw?=
 =?us-ascii?Q?Atxuq6mwOm9w6jx+C+38X3oc+JHBDrxbmWaZPIJCrD2CEGUyBzSsqanBhTKI?=
 =?us-ascii?Q?jJP/wTd7ziaSTh5LUS2uMcQ4PebMee4hPx5KzzCus0Mhf5hG3dGakcce7Zym?=
 =?us-ascii?Q?3EFk/vLOjaH7erePa8ZWOM9MX2JtYlRi5NbqBamKF/J2Ys6nkYxXatBtl6ai?=
 =?us-ascii?Q?IRorRjxeQzjyA/mmGGMSutDx2dVLmLz9ynSU8mj8XtqgABOWNFfoKL0PC8Ja?=
 =?us-ascii?Q?AP4WmrhX0mcBiSoCHjygq0iMlkIMLMDA0An/EhERvicIjk2STUdbCx0Npq1v?=
 =?us-ascii?Q?hAk3UElJCXyZA+dWtfhGfXC7uQjWd0vHUEqhCKjK7ZGMrJDQ7SGIUgkTaY3R?=
 =?us-ascii?Q?yGg69fem9T6uUyLZ+QLaotNlUeI4Dn2BHz6ea8yVZa90LS6OAuNitgwxTLNU?=
 =?us-ascii?Q?Je14EXzOPhDneeZFcK8Cc3rExX2Gxl+VZ5wIrctUiTzdvbPWnqv9Lp9E9rrQ?=
 =?us-ascii?Q?r05padpr6OEgQU4GDFAVANhEuT6Mav+6PYATBjeMf5+HV1wihW2KZEu/Rju5?=
 =?us-ascii?Q?XSEDlmalRsvY9+Q+gf8rWXTPeERS82AxkGJTMcEH/HWidRhO1v3ubXyFlyZq?=
 =?us-ascii?Q?FntGX6TsRvZIugEA4q6unnlhpPwZTfrs9fqbI2l07HcBfL2wUE09xKNx4Zo?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-d8e84.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 08499e31-4766-4a8f-1e64-08db5cd17320
X-MS-Exchange-CrossTenant-AuthSource: TYUPR01MB5234.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2023 03:38:05.8286
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR01MB5158
X-Spam-Status: No, score=2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,EMPTY_MESSAGE,FREEMAIL_FROM,
        HK_RANDOM_ENVFROM,HK_RANDOM_FROM,MISSING_SUBJECT,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

