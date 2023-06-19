Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0733C735ED8
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 23:16:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229454AbjFSVQV (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 17:16:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjFSVQU (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 17:16:20 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2059.outbound.protection.outlook.com [40.107.237.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A886DC
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 14:16:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qg5pMgHoQCrTEkT5yeqrqCpTVlEcas9aLO+0Y+rjJO0c9CzRhQXJ+BGrSPSm3nC2EcVzWK4eoklxcTvmIbJwhjzVprvT9Ru+dQJ/8vp5vlmEafH5olmFuAcPrNfXmT70pv1md1dF4SqYm/ra3FdDn+5UZWEIp80AplYEJN26Am+Xf2Zzj5H6665eTCU/dhPdS1p0IFDZofUsqEkQoid9cyA7wO7+q8Q1xmD/rX0F+k92iTniiEDrEKhQ9i5PLvhUuTZoJqpBjorG8/73pIdckru0qHshVp8wrlEhXjEJJjQyRtY1j+JnV7+ZbhiUwoVakP12hET18lpCPY67WUDO0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QhKHeEBIl6yg8TORxSUvlbuw6WQ+xcZiRnSXPQCrWb8=;
 b=Y81cCtL6duSjRoBvB7PSZs14qhqSbQFeeob9T4BiBB4evjVfiWth3/EjMgqyZ3ah1f+WR8FlhfBvMWxrLTBMa3a8gE9uEY7m5XEhz1Q47QSWZlAZsj9eI0lvg1aYUutdBcdrIEbVpEHJF1b4czAF3fzSlU1eDnjS/pZYKEziWGXYEL03WazvbWhMMr+jbw7D1C8NU77Drwc3XIDK2nj5ckBZ0jSICydA5Xq70S0YcVPKPBLHpm+y7eoTDSfbBEiicvbkz4olGzHQrSvV/3HA/q6MZWe0nLpTCp4lRbwGR9Hvz51DWGRbTA+OpsnAMFa4SQxkKTqXcu9CUE/KJwQtdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QhKHeEBIl6yg8TORxSUvlbuw6WQ+xcZiRnSXPQCrWb8=;
 b=N7ANLUBXORXnEMwumUM+eZcxtvw1O9SnidWY6u2lnvrAufu1thMe3pcoBNeFm8yZuEq4r5z11K7OAnf2JOhS2cXvgpBnmTmWL7enhxLLuZnIn3WGwQNurNRZCuS/v22IUZcBEQK9GppN247S29us+W9VhDG/v1VzhKDKhPgz9Lg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SJ2PR12MB8783.namprd12.prod.outlook.com (2603:10b6:a03:4d0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Mon, 19 Jun
 2023 21:16:16 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::dfcf:f53c:c778:6f70]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::dfcf:f53c:c778:6f70%5]) with mapi id 15.20.6500.036; Mon, 19 Jun 2023
 21:16:16 +0000
Message-ID: <e2ae2999-2e39-31ad-198a-26ab3ae53ae7@amd.com>
Date:   Mon, 19 Jun 2023 16:16:14 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Content-Language: en-US
To:     stable@vger.kernel.org
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
Subject: [6.3.y 6.1.y 5.15.y] drm/amd/display: fix the system hang while
 disable PSR
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR02CA0077.namprd02.prod.outlook.com
 (2603:10b6:5:1f4::18) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SJ2PR12MB8783:EE_
X-MS-Office365-Filtering-Correlation-Id: 367417d0-230a-47d4-ab46-08db710a6b42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EtbCtFnNnjGW+RfSexS0T+qloJpaiaIOhL8j1j7fy8pIeBmcQeG1ZBti7/HnQXKxlV75JOrwSyx6NfZXLr3fv35b9q8aCMlmVYUpwVrNJoq6GAD9MDU/zxZfjYbhsDlEg9pj2GDLzSn6Po3x1YH71YwbG2dbIRmi1Lc7btv6dDlGT0OaFlNUFG8EqJLwKP74QmBUSq0C1HVKJ2p603tFj5pOci5loFEUNqdmDH4d9xUUeaIo5s1bHVyvqCU8YVWuNVvEgzP00nsWupDY+WhcJg0rPMnBk9eZg4HAU0A41u5/d/zU4HuHnZDiZapGRWfemF96YkcE27NgOun0F4gpjVCGrfKn4r0iheMFgDs7mKyOhzY+xPw2kfQSa9JBtr4YZS7nynF6U50Ts8qlZGouU8YwRLZvXyd8em/Y30O9jFckDcNKdWxVWqcfQkfVL2bPARVVxEXNxUymcMNKOqYfzxCyFFEL1zmBkBEsAmnJeUhHgnbsR2lsiFkKCku4YWRimNcW0aG2wmjUgjCxuPs7DHqgmfBEKHgveDBZlJyIPeYqlFJi1scCgQqDOkgplSDl45SumN/OJQM8G1UGKy8wMsQK7otMNWYpIBXVey7cUvMiCPqqIvfbp6oEMYvC+eRJJV0ymheFenwsZ5LWVXM6TQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(396003)(366004)(376002)(39860400002)(451199021)(5660300002)(2906002)(478600001)(31686004)(4744005)(31696002)(6486002)(66476007)(6916009)(66946007)(86362001)(66556008)(83380400001)(38100700002)(8936002)(36756003)(6506007)(41300700001)(2616005)(8676002)(186003)(6512007)(26005)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YUF2Q2FhcFgxOUJNSkFsMUVHaHFPcUs4Wm91YTdWWVprQlQ4Zkw4UGF2WHc5?=
 =?utf-8?B?MDkxb1Y2dGlJUTRNT2ZxNDBMUUpJQlVUb3VzSmhWampEM2YwNWR4S2pQZmxn?=
 =?utf-8?B?Zmg0UEJZZHltbXFBUDdmRzFwSFA1LzRuYTk4Sk5vK2d0eHZ0aWpycEwxTCtN?=
 =?utf-8?B?WFdUNCsrRXNPVitNc3JRSzFXOVpWaUNkNWtDSlF2Z3JYQlFWZWl3QzFXU3BD?=
 =?utf-8?B?OThsYm1YL3k3WGtucEpvVGJibzVjZElmdTQ1aCt4N0xMY003T0JiOHpKelp6?=
 =?utf-8?B?ZndNTEU3c0lBTHRVZHRJQ0UvalA0aldYRkd3TEhTT1FwQ3lvZFg3Mzd5dWNz?=
 =?utf-8?B?b2t1WlRBVkhLRytCeTlLZTB6d01PeFRDTnllK1ZXeHJHazRJckdWM0FDT3J6?=
 =?utf-8?B?VVM0aW5odTNqSzN6aGpUMEVxRk5nNUdLYjBYVHRIdTk2aDNtWDJyd2QxdEpS?=
 =?utf-8?B?THRrRzFkamJZek9wT0VVcUthRklIMHdwbWdPTEhGMUtUQnV0cGZZdzAvOWQ4?=
 =?utf-8?B?b2YvQ1BEMFJGekc2QlFFVURHMWNyZGtQTXQ0NEdxTml5MTlUZDNuc2luUmpV?=
 =?utf-8?B?Yll2Rnc3ZHhqT1Z1SmhLQU5JWElha3RvcWpkUkdJajFCMGJ4bUhWYTNwcXBO?=
 =?utf-8?B?TjdtK0ZMcTJyMXBSRTNkVnJaT0dSell0b3NzSjJiRUNkc2ZhVWNMZnoweVlE?=
 =?utf-8?B?czFDTzN5MmhYaDRyeW1zUjBZZlJ1UTJab3h3NUo3cWM3ZUlvN3hOWUFpTHJq?=
 =?utf-8?B?N1BiTmZqZ0ZaK05RMUU4VnFwTDR1WW1zc2llYlJoYkhyUCtzcjY3Q3NCek5i?=
 =?utf-8?B?UDdNZ0xlZzFZcEU3Z1NxK01lQkhRY0dSQmVBMFN1S2NmeTF2amJvSmdYb2xI?=
 =?utf-8?B?RnpsQVU2Qzl5VGpRblBOdzVGcmNxN1pzNkpvNSsxQ1dlMjBrcGVHMjVyUDFr?=
 =?utf-8?B?MkY1Zkpya0NzdlJMajhocEFNTlV5RElnaEpJbWJwQkh4a1lzWTlIZ2o0U1Vy?=
 =?utf-8?B?eHFzRXhuQ2FJcXUveS9SeXUzOWVwdnhYOWh6eTJkdUplVTZsK05VUEYraTNh?=
 =?utf-8?B?RWZpY0V5UFdscyt3cDRjSFgyOG81cUl6Wm9zdDZ1c3FZQjZOWHNTSnZ2UXhy?=
 =?utf-8?B?NGU4OGdrd1dseWg1TWJxQlJsUVh1UzJ6aHFmZFRCd25kY3lxRm9XZmEwRzUx?=
 =?utf-8?B?aEQ1bFJmZG9GdHhnTnoxa0tHcnVJdmxabFc5R0RWb1IzRnAvRkNEMFVOZVFr?=
 =?utf-8?B?SVQ1TktNTWRaWWJqYzQyZEx5RGgvb0VHZVBrNmNsWExRektVNzBMZFNFTVhH?=
 =?utf-8?B?WXdkOTREektYN01IRWpyZW9XelhHcVZDY0FIL0o3U2FOT0ZWVGdtTGwrQUxi?=
 =?utf-8?B?UXV4RDhVajdOcVRzSjlZbEhobUtwcXhSYy9maGx1MytVNGZicEpJelZjUVNG?=
 =?utf-8?B?RmFKdUttakw4Smp0Nlk5YkdDSjJpN3lMVTdoYXNEOWwyY3Jma0lIbHdQT1U3?=
 =?utf-8?B?SDdaUWMrK215NjByM0ZncXRTZGNTQjUwdzhyM081SXl0R2JXMHpLeFJjaEhu?=
 =?utf-8?B?R3dHQlZPc3o4MDFWLzduVXZFMTIzakxaTTFoWEZQZGZYKzBPMmNKZGduTVpt?=
 =?utf-8?B?ak5jaGk2TUg5Z0JNMGZzL2t0bmduTWFvWmdnMFJoZHhuUndWTHpUVml0WW1L?=
 =?utf-8?B?UFVTVXhSNzRxVmJaZXdDWkRLUjNpUUE4V2R4QnJmaDlyTFpBaDQrWUxvWjgr?=
 =?utf-8?B?S3JWcWtIaERvcnl5dWR0cTVEZzlLektNTFJ4NHRUblFMQURSakdLMTNxNDM3?=
 =?utf-8?B?V1dCQjV2NW1GZ0UrcXZHK29BazZvSnNLY0NhTStqZEV0akRCRDBYS0FPcS9E?=
 =?utf-8?B?ZkVON1MxZkJ0Y1NmNFJrOU8vSnhab2dUdjk4UVhKNjltS2pPUjNxUHl3bXNW?=
 =?utf-8?B?bnVqaHhHWm9WRm9zOFpEM0dnNXhzSlo5K01GSlhNL3RaNXAxT3ZjaVVXNGpG?=
 =?utf-8?B?MXBMcjZiTWh2RWFNbUduOUhISS8yYTBpSmdBUVkvWFlmM0VUTFNZellPWnkx?=
 =?utf-8?B?d3hoMExZZUtRRmM3Y0FTTTJnNlR1bnRJNXk1YlFjWDJtYXVydU9aT2pHR3lp?=
 =?utf-8?Q?8OqB0IFORwEBxk9gS5191kz6p?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 367417d0-230a-47d4-ab46-08db710a6b42
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2023 21:16:16.7123
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DOzfNLZSF14Qs+m7Q3sk48wKHjL7N8GAND1KjuLa6D0mHIjAWlxfeY6CH0UEZCPS1nNQ45t1yXa/DD1agaKRpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8783
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi,

ea2062dd1f03 ("drm/amd/display: fix the system hang while disable PSR") 
was tagged for stable, but failed to apply to 6.3.y, 6.1.y and 5.15.y.

I've looked into the missing dependencies, and here are the dependencies 
needed for the stable backport:

5.15.y:
-------
97ca308925a5 ("drm/amd/display: Add minimal pipe split transition state")
f7511289821f ("drm/amd/display: Use dc_update_planes_and_stream")
81f743a08f3b ("drm/amd/display: Add wrapper to call planes and stream 
update")
ea2062dd1f03 ("drm/amd/display: fix the system hang while disable PSR")

6.1.y / 6.3.y
-------------
ea2062dd1f03 ("drm/amd/display: fix the system hang while disable PSR")
f7511289821f ("drm/amd/display: Use dc_update_planes_and_stream")
81f743a08f3b ("drm/amd/display: Add wrapper to call planes and stream 
update")
ea2062dd1f03 ("drm/amd/display: fix the system hang while disable PSR")

Thanks!

