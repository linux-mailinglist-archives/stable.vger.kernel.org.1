Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 540187A276A
	for <lists+stable@lfdr.de>; Fri, 15 Sep 2023 21:51:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232845AbjIOTvE (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 15 Sep 2023 15:51:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232230AbjIOTu4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 15 Sep 2023 15:50:56 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2044.outbound.protection.outlook.com [40.107.92.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A78B2C7
        for <stable@vger.kernel.org>; Fri, 15 Sep 2023 12:50:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qk6mlsT9xvFk1ixA4dLDUChL2bDX+abHsIdhlQa6dAzwj+o3sehh0Ic30sdSUnjqZ7IwFGjeJcdxCImO9evd7Iyuv9n2yvELnwLjPDI594G5iB13eM8/FCbyWav8ipS5HUT/GAgc5FfnW/aHOvQvJk6m2efqz0Qo3D4WRMMc21vUS9TkOyuqrqLKoYurpYV7j/FMtZZt2VG7ehZmKuh12FaXMprJVV9mnbpNE1GK8tuBAcVwcKhhnjNp5kTrlxrR3MQiRJbNAqRxt1+nuO35V+13QNa3DB2zaj68D++AZvCmwbDmXd9FMkAR9tOfgYI/dfPixUnRHT7GKJawgi9qUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rM1HVzrJN5mRgXWIXOuMpcdHpHWo4FdLxixJQMb6QsI=;
 b=dFUwoTGtg4yg/6J+5Q+ENum2iWgs56L6JLCQz9JlGNo1/Y885VYwITZbFTDl3KYn7g6IX1IgGbEdYNtH086wf97ty3qxlFGRykXqSVUeLj55RaEDU0FzR15KIBzKIYofPFBBaUUzlO35ZDBD4Dl3ZuWXA6wvR+lw4vLhZCAAIue+X9ME8ys+H/VRHKra7EIA7q7QeJylZhDfFGKCkuLDgE1IhEvszLK9oZLKterXS6cgS7Eak4IkTtzey9+unIEGl2MWi8Wo6sJKAVyF+rTAp6P4hzsODtRS89lw2gm3Nf2JMNPlEYa/PYQgP1Jde86vocUDEgM6DyKNMXRZsOJgXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rM1HVzrJN5mRgXWIXOuMpcdHpHWo4FdLxixJQMb6QsI=;
 b=T3y419leWngBOliHOXP5eEGjFS4fTGMa9uS7X216WXzbtvDsfNfpQTmaf9fJgCr6+22wltyJ15+lnqWVPi4tB01YP1w7YkEC7nLoKhODc39rC2wDhKhE4I3sJE2I/cIkE7P0tHbhTINXRgexfwC6/plP8ykO8FmZdwWAkSQkCFM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by IA1PR12MB6066.namprd12.prod.outlook.com (2603:10b6:208:3ee::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.40; Fri, 15 Sep
 2023 19:50:45 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146%7]) with mapi id 15.20.6768.029; Fri, 15 Sep 2023
 19:50:45 +0000
Message-ID: <42a47017-633a-4749-8215-2ff35913f578@amd.com>
Date:   Fri, 15 Sep 2023 14:50:43 -0500
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To:     stable@vger.kernel.org
Cc:     "Zuo, Jerry" <Jerry.Zuo@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        "Wentland, Harry" <Harry.Wentland@amd.com>
From:   Mario Limonciello <mario.limonciello@amd.com>
Subject: Fix colorspace warning on MST displays
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0235.namprd04.prod.outlook.com
 (2603:10b6:806:127::30) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|IA1PR12MB6066:EE_
X-MS-Office365-Filtering-Correlation-Id: 7616d8b0-46b4-40de-8396-08dbb6250d1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PFn/3VJo3Ly+7TnC3jq8ge5VAtR3S19M3SBZQmfB819HUmbageojYMb0goKyttBnFRGsGJ/yRCBXqTdAxHi/dJFhgNHQjSUKaoui9vR/swQTPqG4GO9tgVK2SAKlVHm1f84v7ES8THdztuG6r/em9duF9jmZx0BNTWxQyeTVn0IlMMM5B3GdfikY79YGBwso7RojEY+FrshB+zGRqzJHdDLCoabVuOco1uKdsK1OLWFyFych3HdjfkZtHfkYpvZwisRMArOY0vRaCfgw62m/XFRhMu5Ox65WpJis7xAph+xZG6MBkBFcCqmjeIlLx0Zmq7qnXPXTI5OMur6g6EQVqelPmuQAa3mCvK4eHg/1Z32cvrqjf+apdvHOQVnFT3vgCxJE8UFDF9MHAY+n/1uec8UcRsUwLY97eDm/HUJHzr0WVqHe8FuXJfoXab2LeONHXktfLs5R50MSR9hNYSwABDmt9ZElZ9SjI7RQTra7aUPtZV7/4+RtjRMbWAxr+/7njWSeWkapKcEgR4rBc2dgF7YiXvyEdn5OJpwVK7k9StoqHiSHGIQ0WwDQULZyrOqdfHc6IhbfkgqLOl7AWKISFk98mpvMuBaOPPSFbsqFswrqK+LQMZFCgHNqOcmymosVpOiE92Z3541E7tXvokyfWQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(376002)(366004)(136003)(346002)(186009)(1800799009)(451199024)(478600001)(6506007)(6486002)(6512007)(2906002)(4744005)(2616005)(44832011)(8936002)(66556008)(66476007)(54906003)(66946007)(4326008)(6916009)(26005)(83380400001)(8676002)(41300700001)(5660300002)(316002)(36756003)(31696002)(86362001)(38100700002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SlRiL25PeW5XcDVEVnpTZEFmMk5LM0RTcVFQWitFbUt2M1hVV3dsMklxbm9k?=
 =?utf-8?B?aWZlTVdBUi9uZzZ5ZTdZOWpXNmZKdFlyOWs5SzlWRmZYWEpEdFpaVjI1c2Vj?=
 =?utf-8?B?MTVnNngzMHRoZE9meG1lQWExMk1RNXdHQVN2c3gyOXBqejBwbEY5TWxtYy8y?=
 =?utf-8?B?Q0tXZGZKUmhJc2NSVjdsZFh0cGI5SEFNOFFzWXZtRG05TFZMUk5xK3BQUmVw?=
 =?utf-8?B?TUVMTzhMZ0pobXFZNGtUQTZVYXQ2Qmw0d216WkluaSsraThlaXBxS3Zwb3Az?=
 =?utf-8?B?ek53YjR2MkFZMVdrYW1pTjhVK1pjYkxZaUdmRGhiVWZCMDFiSFh3SG82Tmh2?=
 =?utf-8?B?cXB3RTFDdGVxTFNsdmNaMmdtVmFyaTJ2UG5hVWJEWjVLeXM5alFLM09zMWR6?=
 =?utf-8?B?djdzNE1RTW8xamVlK0toQ0hMZkdUZUl5T1pTUVQyNDdmajlxSUZnbi96WHpB?=
 =?utf-8?B?VWlKcW1vZzJGTG5Rbytpc09kOFNwTkIwQ2FPaEYvYU1TVTJweXNrN2d3R1FF?=
 =?utf-8?B?RStXejhaNFJHbzYySEdmQlpzaDRCdzZCcDVvaFQ2NE93eWFrN3VHNWhYQno0?=
 =?utf-8?B?ZGIyUm1lL1lNelM5cTRCSVNTa3RNajlVQnNMTHlmUTQ5T01Oa2FXL3BtL1Er?=
 =?utf-8?B?UnlXLzR5UXUvSmV5aE1Kb0RMTSs2TmxJZXQwQXV3SGpHOTAvNnQvcVVjUklO?=
 =?utf-8?B?aHJDU3BweGM3MjQ0YUV6S01NeWhzZ3ZsV3NBM3NPZWJ3dFZtdCsvbnpNajZ0?=
 =?utf-8?B?NTByemRkWDBpWGM0QURCYkN6ZHdhZGRSUENVQW5mSTI2WEpXSG0yL01JOXhu?=
 =?utf-8?B?czFoZHhGdEJoVzdhUm5sN2IwWGI0OTNPaExFNlFhcGVPWmQ2Y1NXK3JjZVov?=
 =?utf-8?B?b3o2VXVQbHJzRGRFc0FValp1NWIvaUFSbEhZOWJid0lKZkRLcThGVG9QdjE3?=
 =?utf-8?B?RTJuSTU2RnNwQ2I5VVlwZkkyekNiTHg2NWtnSTh4NFF5YzZPd3lHdHNDbzJU?=
 =?utf-8?B?b2ZHTmdBWjBUNDJyVU90cHBCUjVwWWRoZVdlb2gyYndMZ3NPbEd4bjR0aG9W?=
 =?utf-8?B?U1BiRnNWMlJxOERtOFhXL21rbTVBS205UkJmWkdhcnd4TkR3VUsyV1Bld0tJ?=
 =?utf-8?B?M2ZpSjFldkNXY3dib3p6aWZqZmswbXVmOER5OXJTZ3E5WGhFUHZITlRaZElZ?=
 =?utf-8?B?bE1ISlZPVGFQUkF0Y2U0cFRBMHNRbWo0UW42TGFhaEtiM2ZFd1dqOUNZNWVU?=
 =?utf-8?B?Q3ZZOG1idDVNN0RJakxjSEZRZzRYTkl6Tnd5anRtTXY3MHRFNHZVUUJ3R3dK?=
 =?utf-8?B?TDUzM2l0VmUvenZwZXBsZklvR2k3d252QWgzY1FqUzVGc0h4NlY5RERrUEkw?=
 =?utf-8?B?Z2lheWRZTHZsaE9jRXFLdURmbE9BZ3c5OWx4NUNTUkFFLy8zZ3pEaHJ1TVpX?=
 =?utf-8?B?Z3R1QlJjV2lHY2dvN2tJY2hjTDN6WlNYcm1hdUVXa0I4ODNvR1lYWGgra1pY?=
 =?utf-8?B?eUl6aSticHV2NW5jL2l6REdtbnhBRlRmUmNQaStKcjNDZnhuODlacjMzeVhX?=
 =?utf-8?B?cDV3RitGb3BUREQ3c0tDVXcvUmxuY1ZKMEtCSDE3ZDdja1htR2JTRis4OU50?=
 =?utf-8?B?aEdDNHVZaDV2MnhpRUttTWFUaTc4c3pUMUp3bTBVWmxLcWJFQnpHOHBPV0Yr?=
 =?utf-8?B?aGdmSHA3QVlaWkt5Zksrby9sMHhhanR6UGxUUHZ2TE9ybkVhQSsvZkJMdDZw?=
 =?utf-8?B?anVxSXRuZzlham51ZUFXcGx1b0NSSE1IdEVrQXhIbXJqczB3MVFSS1M2dEg3?=
 =?utf-8?B?dGFCdFBGbTRxWWszYlVHNHVadmUva25GY0JJaXBsZENrMmQrZXJ3R2Z2NEwr?=
 =?utf-8?B?ZDhrUmdWREwxWmtCQmFaamdpazQwNnlFcU9aMWdwaXBaWTlrcktmOXl3b3Zo?=
 =?utf-8?B?VkRnbHAwZkhuRnZYOXErOWVTL2hBUU1HbEppaEt6aFhKbXVsOGViTkprUU5z?=
 =?utf-8?B?YU9zMEhUR0UzdjNpQlFsaUg0eCszSUhpcWNQMjdJKytMNFlZUm8zTmkwczc3?=
 =?utf-8?B?NVYvT1o0SUJCT255RGxwcUNwWGE0MUc4YWd1SjFLbTdaT1NyWGh2bVBWdjlH?=
 =?utf-8?Q?l+KWqnTZf2OSucy/D8BcmYoa2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7616d8b0-46b4-40de-8396-08dbb6250d1a
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 19:50:45.4931
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UcEggjAtnpJVeMi5Vqu4CqekZDJ3+nXMir6nTbQQgCqA1a3T0rLchDp6Vzx9PH3GgJBUItzBz2ePmee9g7lEHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6066
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

There are some warning traces being reported in linux-6.5.y related to 
the relatively recent colorspace property.

A workaround is landed in 6.6-rc1 to avoid the traces.

Can you please backport this back to linux-6.5.y?

69a959610229 ("drm/amd/display: Temporary Disable MST DP Colorspace 
Property")

Thanks!
