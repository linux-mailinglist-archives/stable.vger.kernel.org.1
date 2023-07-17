Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F353C755904
	for <lists+stable@lfdr.de>; Mon, 17 Jul 2023 03:20:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbjGQBUX (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 21:20:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbjGQBUX (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 21:20:23 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2080.outbound.protection.outlook.com [40.107.93.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 622D7D8
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 18:20:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=URStmoKBuUckw3oRbY9SqHwIJj6CvoLU5MLmZKnbQCTo96QDKDd0WdGeYfoJq2Ohhvh07bSlfTJBaaDhYvDRcjHq4suGSDMQd6jCC3k2hyysJunp8zHBcwep5W4fLZvmbIw3obPMCLc4OdDzcN4I/kQJmDtevuAt7VAa1uuK+VrBhV2UYt2fjT7Rx6exY/xRW/Yzxv5S36JPT//vBz6bmYauJPRvbOcqUnhmf+6UT+M3AGgncIiiiKt8jDb6N0KZtuA6W7Czt88Qz/eLEJnF5WRrCkB7+FnoTG/6jwPxk4vfAFOKqX9uicmfvz+vBcZhQdSRVrkEliJZvsQtsKWT3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FBwJ898b/lIcUuS3dFdkARMDv5qe6nrniVy2rWr3eEs=;
 b=NQ05GqipBbYNG9RddCKu4lHxXlnq/k9gsbfnu0c17yh0NOFS6LyeTIdEdX409mNCTN0G8P2fa/tDE8m2fFfZ77d355GwaEzK2mwUtnyHMfjTseLzd2jt7P+QFM6vDlx8qtvFDln1rQQcOBkIt+SEadfE2eGka6Jv2d+3OpxCXuu3YWp0z2briSinlbhuOO0XRYCKwgf31vmebbI4rLrTutnokoi4CZnUj692j8hCeZe/SMFE6TcGHnFOg4+PxWNVuK45QTA7ufYq+zu0RfqzMwhA1M25lQO7v+Cb0y0jej01XUFyRrDr76Yg64seuUTTM9PEY+Y3M73xkkgt8DDdYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FBwJ898b/lIcUuS3dFdkARMDv5qe6nrniVy2rWr3eEs=;
 b=gpZ8XxsrsPZcesXf5mN7FjCniGsCVjSES4z95mjAaBaiBfm1Tko4Cip1yf3eUHYBly34/otzGOiJBdylWMSaX9LpAx6Xy3SI45mPxQSi5iBhSiRTKGs4sAfmg10YJQxKlqoNdXSrzSBu+6spvfg8uFIebLPXFaSwcJj+LNDQlxc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by PH0PR12MB8773.namprd12.prod.outlook.com (2603:10b6:510:28d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Mon, 17 Jul
 2023 01:20:13 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146%7]) with mapi id 15.20.6588.031; Mon, 17 Jul 2023
 01:20:13 +0000
Message-ID: <e593a25b-175c-89f8-d178-095bcddddaea@amd.com>
Date:   Sun, 16 Jul 2023 20:20:11 -0500
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>
Cc:     Alex Deucher <alexander.deucher@amd.com>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
Subject: 6.1 amdgpu backports
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN6PR17CA0045.namprd17.prod.outlook.com
 (2603:10b6:405:75::34) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|PH0PR12MB8773:EE_
X-MS-Office365-Filtering-Correlation-Id: fc7abf26-ad34-4b88-4ec9-08db8663f8ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oD58PK+Sz3S/c4HZQzbtBN3p5mrmJR/Iv51sufkRxOodn1vl9grds4P5Qx1ueqHPsOdwLL4wPoFbB5yGB4jTwIDn3qjDxXDNAT0XrpB1btFReiKfnwZa7U0j+x4A3gRGFqBL40AmcSyazSPvOMjjkd3nYUg5I2GK4MNpjU5MOLwEMKiOXqiMRZf3aSRN3xX/XqZV0B9qC96qYdd5m8u+58LyI45Dar1R5s9J3Xre1WfF0hD7X6QAZ9I6pEmCE4gO1204+nbI4AA3j+od9lEhjtvf7SZs7Ism2H6Otl5ewcoH+e08y1czdVn9pHq9K66pAg4rwxPELMMnhDdtH74ke04D0TVFrjG4EsMSXLTF1UU/pl/6vHgjKUjwQ2hOO3uW0cjwJ03Jk9k7ACwWYtNd221Sf3Sa142vjP8a0uT8QVyJun/Eml1iNQFLPrVooJOPdT3FlD8ha+KIdB/LwV4ZBNtQmcN3T8T0+ZW4HwMtJImVyUlkkY2k8NrqfGx+4kWOoef+nrIt5h1XVPOm0Bq2s9X0MQwR9Rbmv1ssGYyenVdEmcnH+qhTsbd4b9aRcgHt6ZKLxTJGC9KpR3vaNZ32blIa+Zyxy2K/NzBJyUloA0v6IvYTNCA9cjRLF8jstDFKuO4az16FBXay0myMuTU3Qg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(136003)(366004)(376002)(39860400002)(451199021)(38100700002)(6486002)(478600001)(41300700001)(8676002)(5660300002)(8936002)(66556008)(316002)(66946007)(66476007)(6916009)(4326008)(2616005)(186003)(83380400001)(6512007)(966005)(26005)(6506007)(7116003)(86362001)(31696002)(36756003)(4744005)(2906002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VndHTjVKSmdPN3REYzJzeG9sVG9BeDBtMU5GN3dZVjYyU1B6ZFlGUng2Y042?=
 =?utf-8?B?ZlBPb0dwSldPSnBVN29hQmpMck9BZVV0cWN6T3VJYmxxeDYxeU5LeGthTis0?=
 =?utf-8?B?RkJ4Ym1iOHdoL1M2bVhsQWl1aVdsWU9hNlBmakI1VDFPdERTdVh5azAyeUIw?=
 =?utf-8?B?RzlYdzhocG1RM0tKcXk5TkxJTEVKV0VXZEw4L1QvSkJwWWxMdmdJMGI3a3Er?=
 =?utf-8?B?SDVOK3Y5NTRDSGt1RkRuNGhCQ0E1NWVaMWVOODQzbkp0Y3RTR3ppSXl1N0xM?=
 =?utf-8?B?K3Q5Sk84NGMxTnBYUzQ1NmNEbHFaSUdjTVlHcVhtRmJGbGl1MHUyb2NydWpt?=
 =?utf-8?B?bUZzb0hLU0NWWUxBZG1VeFBrUUsrQWJzNVZiNThic3FicWI4c2dwZjJ1QkpS?=
 =?utf-8?B?UTMyM1NpUzVKUWg2U3l1RzdocFpiMlE1d3NnUmZpRTNGQWhyODZ3TzErazBu?=
 =?utf-8?B?Rm5qS3Z6MWMyL0o2V04vT2FNdW9kS3huWitSOGVPZXBPeVlrK0crTHhEaWdt?=
 =?utf-8?B?bG1nZGN1VTRaNUdZTFJzUjM3Z1NTbVVGQkx6TFBzTTdYVmoyYUdXZGhJUGhu?=
 =?utf-8?B?eHhrMWtLRmh1TGhZMzRSUG1yUWJJL25YTmNkS250R09IOHZnckR3a2FmMmJJ?=
 =?utf-8?B?anFIS1RpNnc0MTI2cWh2TnFyM3drQ0ZMb3BJUkpjN3BxblFvbnpwMTNraTJV?=
 =?utf-8?B?cEFKOGtRaFNONFpxb3hKTDN1ck1ORkp0cHZPMjJpZ3I2TnRsNEtFWGx5aU5j?=
 =?utf-8?B?elN1Y2ZBZW4vcXYxd2FZZFlZeDRaZmZGMEZMbWt0aDFtWkpHOHJYTTMwQ3J0?=
 =?utf-8?B?WHEzSlhaQ3ZNMmdCbVVCU0EvdGRQZjhuYmt1aXlHQ2tpMDJxaWw4eU9SeGVh?=
 =?utf-8?B?cGh0TFU5WmZNMVJsRzJHZm5jbVRaa25nZTVSMUUzZXFoYThoOWhBNVUybVZK?=
 =?utf-8?B?dzFUTzNYcXFtblBqaW5NZ0FlSTdQNzMwWS9IOHRja2JJT2x1N0JVUWdtVm1T?=
 =?utf-8?B?U0RxdFMyVmpqVy9tS2pZWmlLUVRFQ3ZYVDc4Zk1ORzByQUNIS2JkL3kwUTRL?=
 =?utf-8?B?ejN2ZEYrYk9NZEtQeUY0Wm0zZ1NYRDk0WE40SDdyVjIwT3hsR3dRVE0rc1B2?=
 =?utf-8?B?NlFoVUhkZVFwZkx4aVZ0a0JmWTIrcm1id05KcFErZlh5YkU0a1RiOG5ScjY3?=
 =?utf-8?B?dzZiWllGZUxuc21URVk0NldQeGtTRGh3OFNya3VTQUswbXNMcndwM2dZR1pC?=
 =?utf-8?B?NFVoQ29JY2xNMWg5aW9WZ0dKZ1ZtWXI4OE9TZXNMOXlqQmptWmZlbExjK0pw?=
 =?utf-8?B?c3ZzMjFEZkU2bU8zUzNvQ2wzWlpWTWRDdW5vQkpNT3FHbk1kcHNaK2dPMkNh?=
 =?utf-8?B?OGx5MnM2bzVoVDJLNHljQzlRdG1RN29oTXFHTXpqUkpVQjA4NnZZT2hxbFFW?=
 =?utf-8?B?b2d2RHdYaWNhMHVrZ2JLMmRXajBleXFYMFZrdlppMnBmSE5hQ3lLODkwd1Ay?=
 =?utf-8?B?R0V2bWdmdWV1VHdhejhrMUhuaUdLK0hLT2ZOZXBzL0tJZW9Va0hsbE9iMkVu?=
 =?utf-8?B?VUpjc0VtcnFhOUtqUnlXMEFjWVpKTDNaS2VPaW9SbG83Q25OSG4xQm9JeE9n?=
 =?utf-8?B?UTlOMDdkUG9OMlliWUdIVVhkMmlhL0NxU0dRajZPdWpyelhyREVhdWlxKzNu?=
 =?utf-8?B?Y3BDNzZiUmVZLzVkOEpMWlJSVVhWT1JGUkZUYkZtNW1VZ05tMjBJY2F0TEFQ?=
 =?utf-8?B?cWpHQlhVbXdKRGN4R1JEazdob1RxSkpqL0ZQVWFkbS9yc0o4ZlhaT1NkajdX?=
 =?utf-8?B?WFpJZWk1OG1wNjF3a2dCOWFES1NrdEVwVTNSclVDZHlBaDhQTEU0YXd1bkFv?=
 =?utf-8?B?TERLbmdXdVJ6d2xoeHZXSDNxMkV4VlZHUEdmTDU0YStZK1RjdG1tTDZHc1pT?=
 =?utf-8?B?dFVmRlpSc0MwTkxLTG94VGxJT3VRSE1aWWk3K056Y2FrVDBLaHI5YXhFZi9q?=
 =?utf-8?B?WU9XRkxNeHgyQnFEdTdNaGVrTklNdTdjV285alo5S2xqZERnbkRpWkZqb2dC?=
 =?utf-8?B?YjhtU3VDZEc2bm9PQWdzMGdta3Z3MTJQRUVicUZhazRoOWRoN0pjM1lNdmVU?=
 =?utf-8?Q?CcCjQSnnC38jEGr89VTZaA6pj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc7abf26-ad34-4b88-4ec9-08db8663f8ac
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 01:20:13.6888
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: skXZ05LCcpiqSQmY95f0ixGrbHF3Q/5WaVbC/aVY1FMEaZ/WET8YeVJN9ZTztNYweBmAvYfh6K24YED4TStTPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8773
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi,

As a follow up to 
https://lore.kernel.org/stable/2023071654-flattery-fidgety-0e31@gregkh/ 
I've sorted out the parts of this series that make sense for 6.1.y.
Here are the ones that come back as clean patches you can directly queue 
up to 6.1.y

fd2198727446 ("drm/amd/pm: revise the ASPM settings for thunderbolt 
attached scenario")
ef5fca9f7294 ("drm/amdgpu: add the fan abnormal detection feature")
abd51738fe75 ("drm/amdgpu: Fix minmax warning")
2da0036ea99b ("drm/amd/pm: add abnormal fan detection for smu 13.0.0")
570b295248b0 ("drm/amdgpu: fix number of fence calculations")

Any others that need manual fix up will be sent separately.

Thanks,

