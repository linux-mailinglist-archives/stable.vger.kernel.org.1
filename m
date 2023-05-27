Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC61E7132C0
	for <lists+stable@lfdr.de>; Sat, 27 May 2023 08:04:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbjE0GEg (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 27 May 2023 02:04:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjE0GEg (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 27 May 2023 02:04:36 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10olkn2099.outbound.protection.outlook.com [40.92.40.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F764125
        for <stable@vger.kernel.org>; Fri, 26 May 2023 23:04:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e2as5TgTEvSC1mlL1xUXcSvUPri6NkbIbmUWhFOfUZcslR4KyvEeb+PUy9kO3z/XYvQl24y+v/FwcTXyuOcMIARxMHpfws67zOIc9yloL2RxfjArPWNWXp9NeC5O0P6Xezwe3n+R5M1PVmved/vwiKj2X9g8EA+3rHoI4hMwHn11r/rWvh/WhwZkISg5zLmn3glaROwh9lCN3y3uNO0kHtnAw+D5c74N1V7S7r7g4iofZqyBwwiKW9sCm1oHJcnc64noaFnH6ssuJdIZdHOtYfoqaer0gjCoc/V02XKmIWdG9vT8pkztT1I1ydc7tjmFlypJ70Cd8QsZ3xEWVHevYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
 b=MrDMqXXgDEN60ve3cuWfgI3KydjI/07tpAUC5sYbK28JO48+66NH3pZiuuxiY3H/fVbSLkVTRZF1kb4oBxrAs+Glb2qLkVorYOTeFDLdKbheJXDpyRsJ0JV4Cgdg6RHmQDamNAxC43Xd7B5338d9M+K5ltpiZu6TYfmjGzHjr5ug0X19H31CUtcVLo2xxiXdBN5Co+LPIiLRMEHtwhWSZbKisiyA4uVMrfZJKkymZmsKQA/kaMHU2APUftTvoP5jjR5mJy78HjXoceALgRtDkbzPXtGnWVxHhSpnZoqDBJ7BNS7seGb6L67D6VPeDPjBXviyk92MFtPk0IHYnfYOrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
 b=iE4CAupzRss3qBteDEjoPxIm5HX7VraN5yQmaV1jcX2plT+OXFMXxLuoHM4UlgwHL8z8R5m+0VbUMEcW8WphghDLPS28V9N437AwYXL+6ZSb9nAwKF/3Sstpk+3Zoo2OcszbhY+xqjDan3sV7qnClx0q/bAWMP0+RNoMUYzkYXnA2yky6C+xPPaq+cjl3Cbaqvhx8vl3cve4H7rB+lit4rUPjyoTDAX+RiVV7mwtqraqO3Y2vhDa+bIq65qmu3B3dBWbZGuvXY+Y4tqrpQ4Eq+UiU29fizORJQ581Xxq5nvw45VhYwHEAKnN8DCZJcCT5KEk49B//NVvSv3yej6rCA==
Received: from CO1PR10MB4737.namprd10.prod.outlook.com (2603:10b6:303:91::17)
 by DM6PR10MB4203.namprd10.prod.outlook.com (2603:10b6:5:219::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.16; Sat, 27 May
 2023 06:04:33 +0000
Received: from CO1PR10MB4737.namprd10.prod.outlook.com
 ([fe80::d0da:41a2:f278:8ad4]) by CO1PR10MB4737.namprd10.prod.outlook.com
 ([fe80::d0da:41a2:f278:8ad4%6]) with mapi id 15.20.6433.018; Sat, 27 May 2023
 06:04:33 +0000
Content-Type: text/plain
From:   <swnjjgd@hotmail.com>
To:     Undisclosed recipients:;
Date:   Sat, 27 May 2023 06:04:32 +0000
X-TMN:  [sC/yfk2vXcwFRh8uj2L4K664zbtnPyB5]
X-ClientProxiedBy: SG2PR01CA0172.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::28) To CO1PR10MB4737.namprd10.prod.outlook.com
 (2603:10b6:303:91::17)
Message-ID: <CO1PR10MB4737B289BD9C3924A486169FA6449@CO1PR10MB4737.namprd10.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4737:EE_|DM6PR10MB4203:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d01eca2-bca1-4228-dec4-08db5e783de8
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W8qxuGUz93O63WK5gkLya9TS/HwZyUtryAUkVPh5Df5A8Y3NVE2EZ0rl4if7xVbajy5DF9Dc4669TB5/y96ugyrdzW/XuWLzYv+jIOSsdVMlh67VFStzOUuxa+jvCK9+2FMWtxNPpCfbCIL/gWvCBeAn37oxN3yDEw4CFTkbiqulmtne00ucYtkVyJvEk2tVyeM0ScRZqEkGKC0RpScrYG+4EXA8h9A8ZIzyph8sy6CTVNntdMRFAsHa/+/afb5s3Xznk3ArJ+hhuu1jWBQdcoPeVbMxoWwAASTrhaVVIAI=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HAKYzTGkb5yPmUPojv0VR3L6EIFRlJAxabnRQTHRPobOSEA54o5SRGyjxrEJ?=
 =?us-ascii?Q?0ipMcZn3TByUJAR0jTG6n+iewBD4mn4FsJzLKJ0hQwRnqB79ea9uMNJyWwrY?=
 =?us-ascii?Q?kEdrMT60+up/79mPv/ZJ+JAupe1a4+W+WTz2t/MHVbPJeWq75yMJzMqrziIF?=
 =?us-ascii?Q?5E5EGe5xmOSxmnNvSxVPIsml9hNuSVwPutfspekjrDa5mJG8W+dXph7DDj1R?=
 =?us-ascii?Q?1p7/WdETQKrN64XGKkzhhut8Ji95dh42TKhYrQ58xzK0qy/PQ8WcfIRnsA/E?=
 =?us-ascii?Q?4RLxazQf8BcEYXT8nXXs9hd0ksh7/w8CacT0UyUxQm56ZCXDSDVvyTriPaPd?=
 =?us-ascii?Q?L8S1vo9PnHILSWaLk0Jpkp5MJ2vW3+BtB42DaD+f+ZpNyICoRyVSNBu9a/Ba?=
 =?us-ascii?Q?9xESMx0kBTWPD0DBmU/1kiGQm8BDi2em8lY97zFHeMkvBG8LU46FrYe9rXtL?=
 =?us-ascii?Q?O2Ex5xfoh1/xxOmgWyYNHArYam1xNS4/P5vhASnRQ0KNnUai0ZrGlnDxdo/B?=
 =?us-ascii?Q?rO6pODmwjp9y1iQaa4Q3yBVqknCJcNpVdrhcioJUl9+ImxepvFa9JGSTsbWd?=
 =?us-ascii?Q?rBEhEtyORKWPhVtMyF3BdLNGo6Cd5tPTkO3uZxcEqeC6ZhIm6W8spjdBS4cw?=
 =?us-ascii?Q?tVZ8H/g/lo0/5eCaE+ETtplgIdY160dBLLL4E+4MAEs7UsVnVtpaJAHQzKBk?=
 =?us-ascii?Q?i0Z5pBNuG/PlnFAMsJAybrTy4okBf4ul3+OmLPPedqTN2XJHogNbmc1j/9a3?=
 =?us-ascii?Q?02sEt68vGKZ9DGdtM8m1jr+HdO0L50y+gwXwyu2Z6f9ov9ybuuPlaxVwy1wD?=
 =?us-ascii?Q?j1Uyk3vPcGEM33KTwCzIsg5oQ6l6Mt42nOJcaVGhhKp+c0SMGzl+w7pLoErt?=
 =?us-ascii?Q?n89pRTZAzYxHXX84Ue3UCtZNYhxZkcpCOgjG0RK+lkxHN+2fFiEmj8YxlYFM?=
 =?us-ascii?Q?YjzslX3SooACuQ+6Tr8jwxN96f9cMVNMNxuJymBz4zxB0tz9Z5Iqqk1u8jro?=
 =?us-ascii?Q?BAXqg+HOhzfjScWXuytekdZWZf6UhwEkz0bI/h8HfgP6o01UC1fDs9ULutnY?=
 =?us-ascii?Q?YvzSQCsg8B1rxq6pAAXNluZ34j1abMsbWXb8uYptDih9Mf3lwUwSQr1PYbz8?=
 =?us-ascii?Q?pWunbQMeeErYFtZNpkrP95uQ5UV61WlwbP1FtpvpqLob8lC7SpOIf7Y6NVxY?=
 =?us-ascii?Q?oSYmpNlTP/TumhL4KCg/edPNaumCHiTzblF+fA=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-28291.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d01eca2-bca1-4228-dec4-08db5e783de8
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4737.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2023 06:04:33.3075
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4203
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

