Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65ECD6F225F
	for <lists+stable@lfdr.de>; Sat, 29 Apr 2023 04:19:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347032AbjD2CTb (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 28 Apr 2023 22:19:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230249AbjD2CTa (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 28 Apr 2023 22:19:30 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2056.outbound.protection.outlook.com [40.107.237.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6382D1FDB
        for <stable@vger.kernel.org>; Fri, 28 Apr 2023 19:19:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hC38B+H37ah/kRWQm1qRt6PyECvZgVxaScU+0n9F6mizMgielFt5BJQylMtmceCLIF4t4jHImI+CaVQmEHR8IUfBOA8qw+yD2nixXsczXa9mzLTHRQ5d/QkUG30CSSJEM6zJlZqp9H0gqw3lFoz2ZAwMEd71qw+9oRThRwdJrkCPAMBn2p79ARmh4g0vZoQr/TyuhdKbcxWtSzPKpBfWUa0LC0WsnTPi8IpNPe0EthQx3wibcvLGTZqCdwt1hulSiAuZv4SAw8KyDEdUk1aE7SEDCfahC7tfWG07d0kjMAjWyYm4Ur/K32D/ay+lrBM5fLuumRFGtmZLUYr+PoywzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TPzC2TOueAAxKlF+lhSJR2u1/UspwD9iTH7b7ir/G4E=;
 b=LKxQtj2jeAeYdRgNElf9kyQS47jKsBOjkGzjodCMDY+YEbTgqfRz33m3bwWzGyhh2PxoO3t5FJVSTkJS6hxFpyoGhYrSPaiPRcMriFzzWexTHp6mkzektjKXS4ISvTatnLjT9hLblclmH4Ln4OoaSbwCZ/49AHpWC+p3G5lgYPgiQu+jfpoHuD9qquno15Q/LsiULbsqjFBxWsh67kIW4Nja7eNcHz/ZVGaUB/hjupW/sv0trXwVTbEl4Qzq1M9EAiBZ5i0KSdE5elKWZgzKIl0V8CQwCvdhtXLqGw7h63Ww6xIwFFtNnXDHDIN7NegOeIjxOfUnTfNBUK0WCgiKyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TPzC2TOueAAxKlF+lhSJR2u1/UspwD9iTH7b7ir/G4E=;
 b=Ij+jLm1hSONQzeXPZwJjHKKuzc/8uZn5YQyYXu5nblsvUO2eAwb69uuEg2TdDHW4qbI+bukcAQ2x7BoGTzWPTe8H+oHjiRceFYMMFP8YYnMseVsb0/I//9qvHT/weZ+E9dMjbLk1f7NIjwrCE1eLE3WUX9Vy3DwBbSHiIqPTHII=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6340.23; Sat, 29 Apr 2023 02:19:25 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3f45:358e:abba:24f5]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3f45:358e:abba:24f5%3]) with mapi id 15.20.6340.024; Sat, 29 Apr 2023
 02:19:25 +0000
Message-ID: <db463655-1baf-b882-b940-23f9b0593159@amd.com>
Date:   Fri, 28 Apr 2023 21:19:22 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: Pink sardine ACP stability issue
Content-Language: en-US
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>
Cc:     "Gong, Richard" <Richard.Gong@amd.com>
References: <093b3c24-2df0-5a8f-4e41-057f39fcd87f@amd.com>
In-Reply-To: <093b3c24-2df0-5a8f-4e41-057f39fcd87f@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR17CA0035.namprd17.prod.outlook.com
 (2603:10b6:5:1b3::48) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DS7PR12MB6048:EE_
X-MS-Office365-Filtering-Correlation-Id: ba04aa99-eb56-43ea-f4ac-08db485826ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MItUMx4JyJxspjcUKnWV44KMEwOvePub64GbWpk2kKusiqyknH83WsNBlog0e3G+LcZxGP25PQrhVL76F54EFseWOLOQweS8xdGa6fgtm+ovC4Hbp4vDBqKjQb6U+KReZg2Hx4WINMukhIimH+lhfy36jiKLDnV+IEKMnsD+diZ9YeAv98/sLDf5/wbNdUYU+d7mqMm7d0wWL1BlVTiJUG6Fu0GQeM/QuXsJxUC89OmFeUm0Xon25IPCoBuxVCE+YEUK9lG2A95mOOksuny3MqJTuqNQO+pveRfWLG/ZVliguyJptRbtEQ5M4+q3kxYvkGYd8bqrecLPyhyVEp5cdhCiqywcosSSDWNmBpV+QSdRY8DA16FWue0JEdion2aHsrcuy3ubPiyerAzyr+wmJID8LNkYgdmq7Rw/eaRMImnGpopFSz9oz83RHinb6FKvJMY9UpW4T1xBtTAOYTqV74l75mGgls2g519KgKK434ZMb4MvcuY5CcDztA1XC6nlGnqxsc12fR2p9hZROoNTfQ3wpTlLYu2i739Baik2GG426Y47u8TPJbvXxnhl45crP0aBoUXXQzqoUz03wPHYfummMT9iijLw9+Yao9ecQJfwRxuO8DWa9mqmZDAx+XhSZOm7sTXWc3RQLjYCoD9UjQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(39860400002)(136003)(396003)(346002)(451199021)(2616005)(186003)(31696002)(8936002)(8676002)(5660300002)(86362001)(83380400001)(44832011)(31686004)(6666004)(41300700001)(6486002)(316002)(53546011)(478600001)(6512007)(6506007)(66946007)(66556008)(6916009)(38100700002)(66476007)(4744005)(2906002)(4326008)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N1JZSWU4aVBqQ1RVUncvdDJpTnZxNTFndmJYWStZaXZwVHluNDZkQ1Q5b1M2?=
 =?utf-8?B?c3RoNTlzTUlMUjZMdE1QMkEydDV0S0JYQzhSMm51NzQxTndia2kyd0lsT2VX?=
 =?utf-8?B?QmdrSE5IRmgwRzFCUTVWMGZSUy9RQVdzK0NXZ3kwNWpNYVNrL29FQzRDdjB1?=
 =?utf-8?B?dkczMGJWS2JOd3hKMldhYlhzVHpxb090ZkFWRE5tTzdhRkV1SCsydk1mL1VU?=
 =?utf-8?B?MVR0QjQ3ZFhFUDVwaEhFT1lkalpaV2MyTHpxN2lIRTkyNS9hUnhQejExemFO?=
 =?utf-8?B?MmhRNms3MnVPcTV3REYyc1FaVHZYamhkODBKRlJmY1hGcHdScWZSM0lrV3By?=
 =?utf-8?B?NzRIdTFNZ2NveGw3eGQzcUIwUi8rNVJSdVY4eDBxcENRK3JwQ3c1Wm1iQ0pV?=
 =?utf-8?B?bmE0eFAyVCtsRzd5dk9ieTJYSWtvY3E3V25DWThIR1lydUVrWTBaQmpZc1JM?=
 =?utf-8?B?NFRDTGlhRjV2MWI4R1V6Mi9ia0dRQ0JGeU1GTVFiUkVsZEpSQ3NmM1VHTFVh?=
 =?utf-8?B?STU4ZkVzbkdPY3BVS1JvcldISE5QdXZzR0FnK0hWSm5ZMC91Uzg3RHdCMzIw?=
 =?utf-8?B?TWpwZlZXNzh3MkxhNkVMY3d1c1RORG9LN1dXTWh4bGZpZ1ZJU2RLaklXeWVz?=
 =?utf-8?B?c0p2aXhuaXhieEhZeG80dVRvdzY2VFd2dTE2Y2Zxb3RaaktVdW5IUVd1cUEy?=
 =?utf-8?B?U1psQzlnb1NGT05GM0hUZVdlamgvY0gxUk5BWG5Sd1RHbjNKMDF5VXBQamhu?=
 =?utf-8?B?aFpzdFE4eUdzRGtIWHhlVFlGenM0UjlKYmhGYkJLcW5lZFByY0dua1orTThE?=
 =?utf-8?B?THRwZ1JBVGxEOVA3anRVZFU2d0RiTTJ2bjFCbzFYUlJCamdoU2x5aGFYYXBn?=
 =?utf-8?B?WXBRRkl5bmhUaGtvaHcwRzFhcEQ3RGhLYXRFMFBmSWhWVXdIY1kzWGY3bWhI?=
 =?utf-8?B?OUNyd3dSbkNrZWhRb2tKL3dBMEhxdE5QUURrOVZJczdoNWpZWktSVnRkaUJQ?=
 =?utf-8?B?K2VCL0M2U2RtZitRbFZRa3AraFB0YmViQjQ4VnNRRURpMU5iM05sUHVTRUZr?=
 =?utf-8?B?SXhybTU0UjhoUTJKUkVZRjBIdWJza1NFSjM2RFEvZE9xK1RvQjlRTzhVN2pU?=
 =?utf-8?B?cU1MTjV3QU81cHF1QXlLS2NSUjdBVnZSbDM3NEM4Zi9qUzFPQXpDa0UzNlUw?=
 =?utf-8?B?MXVrSlloTXpyTFFBZ09XUGZGUDhNOE5VZ3NlN0Q2QzFjdGQrNUhrMnhWWFFh?=
 =?utf-8?B?bnJNd3pMNStWRFVpYy9Fa3JhOGF3QU9GcWRjS0xpWHBqUkZ4dDh4V3BDU0Q5?=
 =?utf-8?B?OGhncDdYODJyaHo3aFZENkxZN1lJZHdlRkkxOTR4ck5aZWNMdXY1bzBTb0VP?=
 =?utf-8?B?dHRJeUlTMThPQzNHeHRpMGc5QTR2MVBCeFdjNzd3TkdYY2lhTVpWQUlSd2lk?=
 =?utf-8?B?b1BTcXBHMDZXd1BmeVA1bXowQTdJN0ptTHdzUVM1c0pyb1c1N1AzdUt2N25s?=
 =?utf-8?B?RXpHeWpMYXpuejVwZ3g2NjhwWEp2VkpNL0NzY0g4ZHRWVTBhRHg2ZjRibkw2?=
 =?utf-8?B?QXMxaVJDc25kblhYMHFnZWdyTTNsczh0azlsWHI3QlVmalhZZnVVVjM2U3lI?=
 =?utf-8?B?UXI5cnRwMXJpTjVDaWxvYnBrT2krblZ0TTQwRHlKbXdIYnhuVFRvc3dTUTBB?=
 =?utf-8?B?elUvdG1vQWtGLzNjaXBWMlFxcThUTFVsbXk0dVZoZFdkWlI2SmRXOUJhUS9i?=
 =?utf-8?B?VkFYdWt1M2NEMXFyQjZwaXppNER2MHVaaG1lZHBoTDlDNERWcEhURlJNWklv?=
 =?utf-8?B?Q0tYUWZ1ZENUREtXWWtOVGJlYm13Wk92NmNiMVE4Uk5sRXRUVDBMeVoyTk8z?=
 =?utf-8?B?dm01WXJNS04wTXZDY2RXeitUTE4zQVFtUEhKdk9wR3k4QUQrR1YyRjZwUkpy?=
 =?utf-8?B?T0RuK00waHRVVU1qdGJMVndMV0xpUFg3QXZ2SzZhTjJQN0MyZFZYNHorTFly?=
 =?utf-8?B?NFRBcnpPdzByMUQwU28wYXNZK2JxZ1ZHdU10eUF1N1dLMWxCdnFIa001VGYy?=
 =?utf-8?B?aHlFelNwMkJPbG9DOHNaejEvUVdROC80QWkyd2pxOGxrdlQzc1FvQ3Vxak5n?=
 =?utf-8?B?TzRlSDc3Q3lEbW04NmowMzM4MCtqbHdFMnNZcUEzYStqelVKcE1HN2dmR3Ux?=
 =?utf-8?Q?y/TIIoeEIvx/CKP8hRzAMSp8Njpvg7aA5m/9G+bWlpO2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba04aa99-eb56-43ea-f4ac-08db485826ec
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2023 02:19:25.2227
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BRA9QZ2iSv0WlmKGYZS/xlC+KgvwwwtXDQU1kwVnUW/12E3ikJ7rySCYoNMXzY0l8iKOOmi4ZGCxJ9UWNn9mNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6048
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 4/28/23 21:17, Mario Limonciello wrote:
> Hi,
>
> Some Pink Sardine platforms have some stability problems with reboot 
> cycling and it has been root caused to a misconfigured mux for audio.
>
> It's been fixed in this commit:
>
> a4d432e9132c ("ASoC: amd: ps: update the acp clock source.")
>
> Can you please backport this to 6.1.y +
>
> Thanks,
>
Sorry forgot to add that this commit backports cleanly to 6.2.y and 
6.3.y but 6.1.y will also need this other commit as prerequisite

4b1921143595 ("ASoC: amd: fix ACP version typo mistake")

