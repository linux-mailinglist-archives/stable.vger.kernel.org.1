Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82D40713165
	for <lists+stable@lfdr.de>; Sat, 27 May 2023 03:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231440AbjE0BPS (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 26 May 2023 21:15:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbjE0BPR (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 26 May 2023 21:15:17 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01olkn2047.outbound.protection.outlook.com [40.92.107.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C19A1B4
        for <stable@vger.kernel.org>; Fri, 26 May 2023 18:15:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KKb9qCPuMIGIGdcZ6p8aKcZgItxzq6JvzgTb3olQ4TJcMyHbX5d2nu2rcVx+n3m5OVGUUmGcZYMuyi87KckeRR7Vo7RB2cvlz2LcguDQTk4+ikglZiZkJM15xsSzoLc79s1g7OWC6lV5UM5cWNu/eCy3Mvpyayf4nZWyBwHXz/NZBYhCe0A69ceWqnsup1ukAGjofnVDxiAG2La4PB3bxNDuOKp6iN9EocxlitRdqHuD9Q2xaftztnOxmWXc0CHh8avhZjlDFhngpewm0cS+TGfOHI0lpHMekvnPDw3SUOsM7oC4q92e+Bvk3jTV9JLOhnofB+jcTQzuzOkzgGUn2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
 b=doXZLMbpddcv5lGmYt8DWuu/Ga2foSGm18HCJgd0wNyx9fn3DUOPaUqJ310h4NoCjrC3ef+QYynAREhWOebpEaHeETxpYjRA8pBrGsRmtCJLoQ2Q+VhlUSBF9iEF2MX21PaqQEr3oTuWh/3GHGh7IKjZd1sd4g6t4AcHjUMhcv5MmgVjn0b6/bqeP1Ct8KttuZEyOPqemrpj25I88rv540tQV+6Ot33at/agTVjy0Im6CO2HFgtZnUYAGm1v0JhbPdJ52MNRnpnhswV1J4BM2M3HKn1aWQ6KF/fRDYlis50svdijA79Uv+vYanGJ//w1HCZzzN4G98luVLcqQwKuUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
 b=SYp6aRCX7fPrWOm56B+iowi8LVHApQEgee7HIgROjpLP8WQ6qBoZDbJeKC2pgDFb4WKIMcTUCkjmtxqDEEIp7NK9QeuV1Tf+BzuxkKidEtbspnlxpiE6WWMYHwVm8Pshh1ohKTVlnI/9oxAqt4lvHuzpn1SN806Sv0OCWeQWVIz1NKnGEoIROkB6a9Xx+06e/8qctJ43MxVjtq5XbEwPFqN+Fs1ZCoTWzpu16piaa6XaGVMsDKvUbxGGNT9NAjvUTyogadHP2DfCtfyrFMWTlCjNnSAhhaX5nZzHKPsUY5tBLd3UJOc2qtQs7uxBXtW0I2L/9hhIwmBc4VL6m7Z1cA==
Received: from SEZPR06MB5504.apcprd06.prod.outlook.com (2603:1096:101:a4::13)
 by SI2PR06MB5361.apcprd06.prod.outlook.com (2603:1096:4:1e9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Sat, 27 May
 2023 01:15:12 +0000
Received: from SEZPR06MB5504.apcprd06.prod.outlook.com
 ([fe80::ccdb:20e5:541e:5a80]) by SEZPR06MB5504.apcprd06.prod.outlook.com
 ([fe80::ccdb:20e5:541e:5a80%2]) with mapi id 15.20.6433.018; Sat, 27 May 2023
 01:15:12 +0000
Content-Type: text/plain
From:   <fvbmhmq@hotmail.com>
To:     Undisclosed recipients:;
Date:   Sat, 27 May 2023 01:15:11 +0000
X-TMN:  [1lRTQJ4Zfu3XkYGGhulwWwieSK5zmssq]
X-ClientProxiedBy: TY2PR01CA0017.jpnprd01.prod.outlook.com
 (2603:1096:404:a::29) To SEZPR06MB5504.apcprd06.prod.outlook.com
 (2603:1096:101:a4::13)
Message-ID: <SEZPR06MB55046988F49BEE8085D73A6BA4449@SEZPR06MB5504.apcprd06.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5504:EE_|SI2PR06MB5361:EE_
X-MS-Office365-Filtering-Correlation-Id: c45af231-1231-47db-614c-08db5e4fd1e1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Dcv7SYC/6v91vK5ywgSweHh85SCq2R3FkDyvFS0bgAJE9Yc2EArUBH5lhfMpbiiDkWkHs3ng4JkU3Ii4jAdU1XPyhTlUBAi/SQQCtkD8mMbWW+LhPHKNvgC4eA2a39o5x0sg43zfzY+ObTy+qzCpTepPFan08Jba2bxAn+YDO5sbRRn31mPufpKBesHYtIO/nuTRHhqmQ/BryHbcnCAjN6hei2E8xzG70Tn90MJaMXxIHui58/RX+BRlRvmMJ9+FNjJQnFF58MT0q3kBJH3gxDf+ssba6G2bgaSp1d9zyEg=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?v1XRTkYgTM5bqcDNwir5v9oobt3LDHlltwqFNdO/pjroaZmpt9LFavahDilh?=
 =?us-ascii?Q?bC+vvM+6G84ITD1z++pHyOoA3Xfo8YQS5zDweWLYOO/Wccaog7kxWI8/LTky?=
 =?us-ascii?Q?dvFg3lkp/D9yufo7dvQ9LubrK54qqVU5Q3KuhA8zMW8++5+6YM6krK96Vycz?=
 =?us-ascii?Q?MiBFiPrcTcoA1mKB9lFsKb1oevFj4ntGdA5RbvTNx8scBiP89V87AheAWDJk?=
 =?us-ascii?Q?6yadC2mbjHqdo6WJR6rt2XBzCDvWQuTlTGXAw8q499yB1L8ebKP83O/T3Rt5?=
 =?us-ascii?Q?N2+l6CUendx9ewbXIIzMcpUP2PnUJZIG5ENMkLfVhIUYgWDVWCknmE5wLLON?=
 =?us-ascii?Q?aBK+G09Qh81Jnofp5piJwSOaqRF5LoVCf1E8OXwO/iIlvlgkL7mPZ0cOR2BY?=
 =?us-ascii?Q?TQTlWWzV/9RS1bCN6hTXK6/1R1X8XE3OLeu7cC6I7zZCLx0+A0xFsVGPiaLH?=
 =?us-ascii?Q?0YfoFRYuYR6VtCezIFfUWT3ZWyU9wfjY6TmhN/uePlRZ5YBjpEa+S+hUKWB7?=
 =?us-ascii?Q?YZMty1msCtDwp2oTRiiadnRWC3TaFg8lK4CeGMR24tjNWpGnGkX8stMXsD2v?=
 =?us-ascii?Q?jZDVe1lHXAqh5H/sWoksxV3qVlifxfet5ND1INxZTPETHuYotYfrI+6i+Fjq?=
 =?us-ascii?Q?VgRTGzK2nmBeBhMyYpqSBvie1pu9txU/Qn8Lpms9L9bd4lzbKME7ir1uzdQW?=
 =?us-ascii?Q?e9JEI4SCqKwDIyzJ811iZGp9jUBfZJEVhIw1U2x8m/7cr8YCd9hbi3lE84M9?=
 =?us-ascii?Q?4dou/2RDY4accJoBM/DeRrLjfdqBlSr3eknuS/e80fCTroDn78t7b0Q5Rb3d?=
 =?us-ascii?Q?PcR0hrMO9al9z8geG5n/eTrGvQJ4WGc4/4CZe6ZXFVx3uYFwjD24iwlAyjV+?=
 =?us-ascii?Q?b9NaJh5fp9gw1SAa2d4zh2J1otC/O0/2chLBxfrKKDg79ZB5DoGAXSt+zL0D?=
 =?us-ascii?Q?UkCMfJFuyJbnQbv0xsKHlYUNKnNww8WDUmpojaUWtCvbcngZtuoNhXaff1i5?=
 =?us-ascii?Q?YZ9s38134GcLwlxJ2zBQbbfdUKmwDNF8Qn5aCyiGveIpg9OvuaAxTQhqIvfL?=
 =?us-ascii?Q?OeX3aa+KH1dOR9EGRJIzL0ndvMaMDoVx8Xt4WavaeMM3Hw1SkicrJ7ISFIkw?=
 =?us-ascii?Q?A26lzXnRS0REtooC9VhrrYde/wZrfymVEC30r6GS7Ygabl4y6e9o0FtCWZ/A?=
 =?us-ascii?Q?RCck8ihrB8nFidAAoVO27+ZFEX0+H7i/gEtaYQ=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-3208f.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: c45af231-1231-47db-614c-08db5e4fd1e1
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5504.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2023 01:15:12.2882
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB5361
X-Spam-Status: No, score=2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,EMPTY_MESSAGE,FREEMAIL_FROM,
        MISSING_SUBJECT,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

