Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB70E7730DC
	for <lists+stable@lfdr.de>; Mon,  7 Aug 2023 23:03:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbjHGVD1 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 7 Aug 2023 17:03:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjHGVD0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 7 Aug 2023 17:03:26 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2058.outbound.protection.outlook.com [40.107.220.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94BC410F7
        for <stable@vger.kernel.org>; Mon,  7 Aug 2023 14:03:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SS+YbeLYNeEmLuWDuv0jVm/gP277+T7rH2RuXZ+69iXrtWBYXliUcClcyjSITMFvGeEbFfp1Jt1pHLiJZnL75hairCsp3dfdorM0vVKyRyxsyNNpHS+W1+k83meNE4A4nW9R2vuI6QPh36dC+61dQFKMIKV3vWiDEK40RL9aijQ/uBtrnyUnmJ1way0tbmupJsmkd2QsYEqj2Xz6O6fMyGrf6guvJFbNj+XTWKiBhTwJG9Z9YLqDrd0S1Ox0aJo47cyi8fuo78bJMqT8MUPRX0jmZ1mkH3tDIzybhVp6tfGNiIGNHl5CbQsNEZHDiRCkOugt+i9iQ7JExI5MVvacJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mTVSPanZkuMicvo9QNUA+zBDDeI3KiHorgY7tSgJrds=;
 b=gPJbmqPswq+4Bh2T33I/8oQuDyOq/NC/Cp2RlGWC8SnjqbW6uZ2yu6RSyOYqP0bhLODoxBquSq+0elWT/vu4NwaMyJbuyKIcfA7NE/wauPS7gSfB5hjlFZQ7YyObdNZPGFiWnC60CaENkxubJVCbyq0xJ2jJYBNC7WG1IcRLaDITrokMewXS8J1q/9BEy100Ocw2UffvjW9MxToCr8OpsXPfQ/wsvduSb+MFuilxVDq7c4675lIPfgJFwTqF8/HyZCsYx3tpuCJbNW+O7TZAyNJGh7HtnKrJ+5z2akPT2or4nDf9sX7U/MRKzgJRMK+GKyy1nZGnHyBRvZOgZm+rgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mTVSPanZkuMicvo9QNUA+zBDDeI3KiHorgY7tSgJrds=;
 b=ElsGjNZaMX02St9ecmZ+0SKekA2ZIPRp0os+msPTMIpq1+mLy5RRag1Q32attokk72TXv+qweJwmh6MWpmjHBm1Hye23CMaiIrAfb1dFTEKSoA3c2WxnhAvqe3HSTP0Arfe7yGLLvG7u4dpB1s1S9QxkkdWW/C4cZVbWY7AjsZo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MN0PR12MB5833.namprd12.prod.outlook.com (2603:10b6:208:378::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.25; Mon, 7 Aug
 2023 21:03:22 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146%7]) with mapi id 15.20.6652.026; Mon, 7 Aug 2023
 21:03:19 +0000
Message-ID: <50a5705d-dbcb-4db4-a210-c55dabe5d7a0@amd.com>
Date:   Mon, 7 Aug 2023 16:03:20 -0500
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To:     Stable <stable@vger.kernel.org>, william.bonnaventure@gmail.com
From:   Mario Limonciello <mario.limonciello@amd.com>
Subject: [6.1.y] Fix a regression where Kodi stopped working on 6.1.y
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0093.namprd11.prod.outlook.com
 (2603:10b6:806:d1::8) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|MN0PR12MB5833:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b86cc64-470b-487d-e21e-08db9789ba27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xzzBfSJ5T5puHdshXHHncaiGicud1w0s9tLtfotKxQHAPP1DCbMDx7etI8hrk25bD+T8Sa/qJQLZaiEg3iwdkRr353/qMe/rRA/ABMXCmkbGqHgysXz70sAXs9yn91ynXcAJBLCJpecfPGTHUEJ3e4wlqKrdqe586Qb4fqUuI0aIxG13JJ/UmIzv+M7pM5NiepMOm0HNxkSZt9OEOU0wDV5zKSBMDtjg/WBx/Vo88MDe+IlorCMBCboIN0QRbHvAHn196OQZoqVGO7vmarsgWxYGIiMa4ECyBpDBxmHUz+r12CbhI5/96qnR/hxoIRB3G72OcKTe1XZzk5c48IFrcVJMueJ3BIUuwSGtJ0F9QGbZC5euNAApxD+DipfwI4XPFfSEgUAJon9mWBjKDhozDWfiB+TtomocBVYeOoncj2L38RZ1Nz6kyLYuYvLzWh7fabyK7lP/vOAU0SU6BL2bOCnYQ1Mh6y2FN4i/QiSEjM4Qf7B+I0S1Z6KxUOCSo9Au+PUo95jMpXvUo3s6qQkZsdgEu36rdUAGaIEL7pCLSesvTJ/IcImD76VsEa1LPwc/4W1JdrcvUmfW+mDs5cUvCgE85Bk4EU580wVCTGn355XRzaif/3CCGTl+nmW2tD0SwK5vKz96VzxbOiaU/dmGVa/uJrWQdGZs+4xy5IpKxP4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(136003)(346002)(366004)(376002)(451199021)(186006)(1800799003)(2616005)(36756003)(966005)(6512007)(316002)(86362001)(38100700002)(6666004)(66946007)(478600001)(6486002)(66476007)(66556008)(31696002)(6506007)(41300700001)(26005)(8676002)(8936002)(4744005)(2906002)(83380400001)(5660300002)(31686004)(44832011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bFcrTjVzSkdoSzFBeXZKVk9GTWZQM2tLNHYxczhYbzFBRGE5K1l0UG96L2Rh?=
 =?utf-8?B?a0NKTlhLRGRWOXNvKzU0VnJyU0tkdVBsUXFoZmlJUjRqOG5ZYzN6U3RFd0tF?=
 =?utf-8?B?SU0xOTJuL0ZtbjNObkp5TDNHQ3ZxRndrcU1rU2cza1ZWUnpCdjc1ckhOWFN5?=
 =?utf-8?B?blhXajY0bzluRUNCdzBIYkN2a282d0NzQjlFdUhiQ3RPV01PV2kvY2tUbzBB?=
 =?utf-8?B?ZkE0NlZBc2hpak9kRG1IVWJ5b3g5bnJPajB3UzV4d0RIc0FjUHdzQVpNRERK?=
 =?utf-8?B?MTNNc1hDYU5PNzNDb1ZUY3ZRKzlPRmd1WE5BZFFONEVyU0NlbE8rT2FJVmtw?=
 =?utf-8?B?d1lSWWhaRmtHVWFZWU1rWEw1dVBOZkNrWHBXS3dqd24rNm1yT3BjbGUrMm4r?=
 =?utf-8?B?YjVZRHpiVGRiNUhPOHo4NEhJcE5wUHdNdnNZQTRjMms2Q1NDaGdDNkJjQjQ3?=
 =?utf-8?B?YjZNQjZhY09qNWpXSkQ0NG8wdVZKZEZpeEc2NVZlWUZ5bURtOXRkakQ0MFlp?=
 =?utf-8?B?N21UTk8rZXFZYktWemZ1bHQzelFmRlhVZ2xUVHNESUZtNmVoUnJSMVRyMmRa?=
 =?utf-8?B?Vlc5dFF3QmkwZWZaRGxMSnFtN01iQWRRNWhOWVAwK3ZwK1IyTmZwZTNuZ0Rh?=
 =?utf-8?B?QzdRSUYxaVRmUzZRQjhKMW1KdUp0Q21pVWQ4QzZnVVc5SlM5N05LMHJab0o5?=
 =?utf-8?B?ZGlFYjFwN0tubUtnQmx1M1hlOE5MYjlhUzJ3ZUQrRFd3NlpRL0JDeEZtVjh6?=
 =?utf-8?B?NXhjdFlRSHk4cFAvMWtibnloMWtZYm8wTTFveUZWTUczOFJtSlYxZ1VwTElU?=
 =?utf-8?B?eUpsOHY1T25jQ0RaVE12UFhlN1l6MFp3RUpnNFhSbWdhUW5wdVpDQ3J3NzJz?=
 =?utf-8?B?R1pucEx2WmtsRk1lMTRDcFZBczF6NllmTFJ5bTA1M25LOWVQVnN6aGtna3FJ?=
 =?utf-8?B?cmcvWElRMzlEaVo3Q3ZEdVoyWW40VFUvTzN4WG9oNTE2Yk5EZEJtWXdta2lw?=
 =?utf-8?B?NHdqZXdCbklxdW1JWEM0aCs0OVhPN3VCK2swS0IrQlV2WngzN3NaS0RGUW1G?=
 =?utf-8?B?bzVybDhWOU4wR1ZycmhxTTVWdzlnRStUY3JGcHVCU2I1ZHYrSHZoeFVzR3NG?=
 =?utf-8?B?akJGcGVyaWlhbmZXV2JBcmVuT3pUQWpLWU52TGgwQjlQYmJEMk44UFNEdWcx?=
 =?utf-8?B?UTNpSGE4anZ3OXFZUURhejV1VnJ2cHpZdGU4ZnREaUpLS1k0MityNi9hMnhj?=
 =?utf-8?B?WEErRzJxSW1LdWlFZ0JNcHRVcFFVZ3F2WjQ5eUJvWGlxT254ZW1YNkNUTEgy?=
 =?utf-8?B?eXlwam9sQ0x6QktyeVlHKytwRjg3TDZSWFkwOCtIMG5NMFFXL3JLcHEwZWpV?=
 =?utf-8?B?eU9WZTFJejhkYVRROGttOUFZRWY4QStWeTN4cnRmU0QwWUg4dW5xOE5JcU9v?=
 =?utf-8?B?OE1xRXJZZUNnODExaGxVS3k3REtlMWdQY20yMmFJajBvNkRNVEsvVkY0R3Qv?=
 =?utf-8?B?cDVRcmhlcWlSWll3NWVER3hBdDNpN0NXZnI5Zy9EUGY5QVpZVlZTcyt4K0pw?=
 =?utf-8?B?d0FTUWJMc240NTJkYjNGRTllTzU1YmtYczM5NW5lV2tCK1liSWZCc3dOQXkw?=
 =?utf-8?B?UXQ2WWlwNDlqWDVrRFpXZFBPcGMxWjZYK25QZWdHeHYrb3FEZk1DWTBRVVY5?=
 =?utf-8?B?Y1l3dlg4WXhDeWZpaCswSEtFS1o4Ky9Yb1dnS2pNbnZmVXgxbXI5TU5jUThL?=
 =?utf-8?B?bTNRRWx0NlZZRXRqSUVMMTc4ZE8rMFR3REVwSmh0RUs3MzlNSFN1UFAwdWNr?=
 =?utf-8?B?K3BnRmNNaFl0QnhOR2EzOVJYYWlEMG9raE1EaEx0dFVuWjVkSmd3THhTRmtV?=
 =?utf-8?B?QmVuSmU5M1Q3Ti9tVHA4UDMyZkNwMTZIN09IZTAzamNpLzhkWGlzYUVuVzRL?=
 =?utf-8?B?VHNaeFI3NU9sd2wxdlBNcnRoL1hoTWdTNVlvdEgxRXFaTExpMEQ5Z3lqSi9I?=
 =?utf-8?B?ZTNBZENmNzBXaCtDNUFzMENiVW11NDhuZmlTUG12QTQwbndjQXFkbkgrc28r?=
 =?utf-8?B?ZUVDZ0ppUHNrR0QzQnZHNzdhYXNMa25YSkw2eGlDZjhNQ2E5YjVUVkJLL1dT?=
 =?utf-8?Q?/TwbngbXGvgTY2huK/NnggXNK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b86cc64-470b-487d-e21e-08db9789ba27
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2023 21:03:19.4201
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KLW1u5xhj5E49M5eyaCCTe1b8YcEHSlRVXWHXopK0vq+/+JD0B8s2emZqkOPW6ChYYPYLBp0xQjL+Cuez6QhJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5833
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi,

It was reported that when '8d855bc67630 ("drm/amd/display: Use 
dc_update_planes_and_stream")' was backported it caused a regression 
where Kodi could no longer display.

Reported-and-tested-by: william.bonnaventure@gmail.com
Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2766
Link: https://github.com/LibreELEC/LibreELEC.tv/issues/8013

This is fixed by backporting this additional commit to 6.1.y.

bb46a6a9bab1 ("drm/amd/display: Ensure that planes are in the same order")

Can you please queue this up?

Thanks!
