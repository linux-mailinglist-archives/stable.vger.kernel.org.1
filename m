Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56E03756E0A
	for <lists+stable@lfdr.de>; Mon, 17 Jul 2023 22:18:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbjGQUSA (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 17 Jul 2023 16:18:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbjGQURy (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 17 Jul 2023 16:17:54 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2044.outbound.protection.outlook.com [40.107.220.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA308136
        for <stable@vger.kernel.org>; Mon, 17 Jul 2023 13:17:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R6oeVK56uZa0z9ePlCTBuwnoEo3kelDDsCsz3m5U+NzAlxOkE3JxDy2OZSV/mqaQjNqGSGRTaraYAfLAAOHRD5gc3F4M3efwpzqkDdIUnr7U8SJh5Npd9/KKMEgBHSntAu9FMfseQcCGdFWZK3c4dalxy0BDnolBD5qJhyKDyGhAZ0/VmX4qQTz6kB7QgolcdxcvhwhNC2mH7HGyY/XerThFv0PrkOzbXaNDUfsBhAmnQQowJspEkNm6T0YOnKXN+/coda29r/+wNu0NHlOLeI3u17VnlNfyf2Aa3EbBpnEk4vok4/0KooQgjo6gMZn2Bt/dAAgGOb6sVeAQSY51Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KftFXz9HQU8yxXvlTnc+5Lv6CqcCFVY12Xjwadkq0B0=;
 b=AmRwRv7ap980q6RvWf3g91J1XWN6rCMRR5sJv4IQatjQ7k9MRyHO3EouXxAqBb/r/IyhIN8h0ZggnPw2mLottAhWeF3ThnsAej1sywT3ZPPfkboJ97yl9QZfUaqBUAj05mgRSWDx7y72+PLroHL7aV8Ri4OD11QPIrSgeRVwY3EEoyYQ8u5iKCp0xVz3aPIjFMcsZijprKk+RBr69aq2M1upsCqdzjWW4xuZ3r2ZzggjIu4AwKbr3fzu4h7twXhkVymw9adahHTnnswH3r6zaY7KrGE4UAYvmt/J4nkWcZN3zENZuqh+SySUv339rVTKdajolcodRLvFsHPvPKp1ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KftFXz9HQU8yxXvlTnc+5Lv6CqcCFVY12Xjwadkq0B0=;
 b=Uv944tt32NXIY7i6/7k+DCKWlYtlsIJiXrSmheA08V2aWDQetTDkuZyQWNz2+cwZE0fytYEDXqRo/0RAlECZDG2rDqk6LnGI0tONdsUxN5iBGQ15QCFS6luUya0YwZnQ+7EgE3MGOWS6sI0oNclapI4QcS91wmE+VbsVqLmsL8o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by PH7PR12MB6761.namprd12.prod.outlook.com (2603:10b6:510:1ab::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.33; Mon, 17 Jul
 2023 20:17:51 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146%7]) with mapi id 15.20.6588.031; Mon, 17 Jul 2023
 20:17:50 +0000
Message-ID: <10fef988-8460-f96a-2d3d-cc8c6a37f3eb@amd.com>
Date:   Mon, 17 Jul 2023 15:17:48 -0500
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
Subject: Interrupt storm on some gaming laptops
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR13CA0018.namprd13.prod.outlook.com
 (2603:10b6:5:bc::31) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|PH7PR12MB6761:EE_
X-MS-Office365-Filtering-Correlation-Id: 5126a812-a2e1-42c7-b81c-08db8702e520
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U3uM9BNqlZYccCRFRG3/gI8bmRLn/6pWJ7CyTMDj90nL77Z7hwFKXPZEgmGZO9VG4STFFpoVPcxZ/dZwf3xx25r23L26OJ+KXRMmVRUXFGLjOpLfmaB+AVwhHsCn9nyYun0b+g3vI26jAiuBdpzuy+CBkFkrcUez0wzpbcltUJz8x/02reOSKcMLz4PAP2HUiLPzrVsgWvmdI4PCjG7YTnDHYlnHZBc0vXP8GfOGndx4ZpWGjgtQrcY7IkNykJ3UfsYHYQm1Roo3e4jbxsxjur5iOU6tvpGsosGASiA96d4FwSU18wCi9ToPG9ml0uVSOZ6uC0fq+S6LvvmQoriCkZGqhvkLgSKbjQwHfHL53QAW2JqEEitSnNxezo7G9moaerd+0MeiGAbVWZ2TAZwKNGY1TyjidOq9xzkKFaM2UFWdv5Ve89eh3ex3x8yyvUFo99O81xDkT+8nQQ76uIC1NGsIaSHHttCkQ/ApMQkZzjZiyBaahNesdUoNEv3/XNgdMRWvAbtse9FK72cAVdAE5X0vl03tmA6ppeZTtjhzlGszV6pKge0LWPFTa9B7ECMUYNA77TF05M0r9cDfOMiihTAAlmmAdHHjJvdc36J1XMuksl1PsJbAQLCUP2/HEcLZBwWriVdIyagbRIQSv+SlhQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(39860400002)(136003)(346002)(376002)(451199021)(478600001)(6486002)(186003)(6506007)(6512007)(966005)(26005)(2906002)(316002)(41300700001)(6916009)(66946007)(66556008)(5660300002)(8936002)(66476007)(8676002)(38100700002)(31696002)(36756003)(86362001)(2616005)(83380400001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L2FvY29tMlp2VWpmbzhCTzhRSk9wRy91L2Zld3o0U0JodjZ1bFJrNjlKZFY5?=
 =?utf-8?B?UDhwS1FTMTlQTDMxM1Y4YnZvd3VrVVowTU8waGljSlQ0SGJhVklwSkc3Yllm?=
 =?utf-8?B?Y0VhbmhwVWFWc3hOakRxSjcvdkUvQ3lGNDNuSHVSTlgrVVhMODBFOHczenBO?=
 =?utf-8?B?Y0FtRkFVN1RtaHdaTC95dXRnTkNaVkNzUjNNaUdYTUdGYjNNQWMxQ3U5Ny85?=
 =?utf-8?B?c1plR0ZLRVNvYjlySnVycmNiMWhoRG1za21ZR2xRSEVBNWhlWHFjSWZwYVBW?=
 =?utf-8?B?SWJFNHFhSEpjRXJIZlRqZFlrMjl6WTYyRnVJWWRmcG1WcGwwUFZMNHZCbVNp?=
 =?utf-8?B?TUczMEdmeGlSN2JLSHJpOGVrT0FiQ0l2Rmh0dkFYWTNycm1VcTBEUDduajUr?=
 =?utf-8?B?ZHNMVHBpRm1NcUxjYUR0VVRhSENZYVgrdVIxSkd4dFE0UFE2R0dPL3lHUmw4?=
 =?utf-8?B?Z0NxVDJBaEs5QWhYY01zQzIxcCsxVHVyTEhSa0Y4MWFDNWVSUE9hakZNanUr?=
 =?utf-8?B?Y0RrMjV6ZS81emhIaHNRNStiYUdEeTdhODZlZVQ0azgvOHZTYzBzOW00NHVC?=
 =?utf-8?B?THdJSkVrbEtnYnppamxhRi8vUUZqM1d0aVdnMDNQZ1U3Mzc5SFUwT3ZwNmRU?=
 =?utf-8?B?YWZHR0ZoVXMxYXNUTG5TMVlvbmtGcTZJdkloR3lVeTdreFQ1czVNVHVtWFRW?=
 =?utf-8?B?aVFubmZEdXNrT2ZYUlVDM1dBckJlTVdBWm9ab2xLUjk0MkIySWNkTG05cmg4?=
 =?utf-8?B?SVV2ZU5sUytMdWdJM1RGSDlaaVg5TFU2dUpaM1ozWVdDMk1KdjRuYjJjbHpl?=
 =?utf-8?B?TTBVMGREWEhzMjJMa2xBN05YV2hPd3M1cUMwaGpKaUpTUk85Q295OXBRcHhB?=
 =?utf-8?B?MlFuUTFKeFhVVDVSdnhiZmZpR2RrZWVQU0lWS1RuaHJ0Umo3aVA4emZXaTZa?=
 =?utf-8?B?NGpDMG9zS2E4VmpkM3Z3OFV6UmhGOEJ0MkdqdlZqTWFaRGltSkh0MXJkaHhw?=
 =?utf-8?B?UEN5SVNJTTFjUTBJN2ZWQWk0dVB0QnhzSUdKYnpxMERBUXcrT2tHdnd2empG?=
 =?utf-8?B?aGxmcjhMcW4rK3hJclZ3NEF2bkhQM0JGdHZqTDU3blpGOENtY2FDZnA3c3BF?=
 =?utf-8?B?Q1U3c1BiWmNFL0RjcUNhUnljVDhmSUFTaW52eEhqaUpzd2JNem10dmxYbEpH?=
 =?utf-8?B?Tml2NmtLUkd1dHQvQy93ZHpWNGNtVjB4V2YwRms3Q0F4N2sxTkVtSGlQdnhJ?=
 =?utf-8?B?RHNLYmNJWUh2cEo5cGg2RDl5NDRGR09RbjNUZHJiYmRBVHdVSGxzMUFPd1A3?=
 =?utf-8?B?WklFL0FJTkU4dkVCZngxdk11OGIybnJxRjlUY2hta3B5aXR5eitQTmxTMFVE?=
 =?utf-8?B?bkdBcnNvdjhnaFNsbXQ1cHdhSEJaWHBZM0tORkxQclAwL1pjTjI3M0pNRmlE?=
 =?utf-8?B?ckdGbjdodmRaa1pZOXZXbW5pdm05VFhBVUNMam8xbjIrREd6dXhjeXM1WnZF?=
 =?utf-8?B?K1BhcjBSREppRis0elRtQklqVUxRcGtpU3ZtUkRVcld1UWVkOTEwOWQyQTFw?=
 =?utf-8?B?cS8wSk03TWUwR291OStzdXR4Y2tOeVg1L1VrOHFKZkQzNnYrNkUxTmkxUXl5?=
 =?utf-8?B?QjVCcDZwdHpwMDRUY09ScWR5NHBuT3lXZVQ3bHY4dmtLRFZhNy96b0xlQ3Rn?=
 =?utf-8?B?c2dPanRocWxEc2ROOUZuRXluNm1IN0IrRWJaeUlzYVgwUy9iS0plYjI3Q3E2?=
 =?utf-8?B?Wk9iVS9xVGNzTkdRQUExSFZ3Z08rYjlWNm1GcHNicm9nQ29ncXBDVjI2T0s0?=
 =?utf-8?B?dHBoQzdLQ0w1QjQvZFo3b2dIQWVGbEtnUThTUGxtb04vTTY4Z1N5cnVwMG1J?=
 =?utf-8?B?bmtRMlRMOFNSdWh1NER3ZHlicWlwejZ5R2svNGZPNFN5Nkw4MURBdytNaE9j?=
 =?utf-8?B?LzJCRDVsT2VUdmdQYWdqelUrVjA4U3Y4TWFTNU5tZll4cHl0L214U2N0RzNw?=
 =?utf-8?B?Q0FzcU9YaVRrbkhvM2VreGwySEZSMkZiWkVpMDRNRW5sKzFaWVFZb05JY3N2?=
 =?utf-8?B?R21lUHRRQzBWZHlRSk1kUWgwdHJ0R2JYdVEzMENybktWblZVeUk1Sy9Beldk?=
 =?utf-8?Q?DDpISl30TDRfgeiGfwheut79k?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5126a812-a2e1-42c7-b81c-08db8702e520
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 20:17:50.8407
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nkWwBYpTv9rFkJrFgXT9uwydAyRQ1LsxqQbq4pIAZ4/W6klrm1HSp9kBGF7B4OeakdrRDxZw8Xwzsb4lATU/+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6761
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

An interrupt storm was reported on some gaming laptops [1].
This is fixed by a series of commits that has gone into 6.5-rc2.
This interrupt storm causes a pretty dramatic issue of unable to use the 
internal keyboard, so IMO a good idea to take the solution back to 
stable kernels as well.

Here is the series needed for 6.4.y:
968ab9261627 pinctrl: amd: Detect internal GPIO0 debounce handling
a855724dc08b pinctrl: amd: Fix mistake in handling clearing pins at startup
0cf9e48ff22e pinctrl: amd: Detect and mask spurious interrupts
65f6c7c91cb2 pinctrl: amd: Revert "pinctrl: amd: disable and mask 
interrupts on probe"
0d5ace1a07f7 pinctrl: amd: Only use special debounce behavior for GPIO 0
635a750d958e pinctrl: amd: Use amd_pinconf_set() for all config options
3f62312d04d4 pinctrl: amd: Drop pull up select configuration
283c5ce7da0a pinctrl: amd: Unify debounce handling into amd_pinconf_set()

Here is the series needed for 6.1.y:
df72b4a692b6 pinctrl: amd: Add Z-state wake control bits
75358cf3319d pinctrl: amd: Adjust debugfs output
010f493d90ee pinctrl: amd: Add fields for interrupt status and wake status
968ab9261627 pinctrl: amd: Detect internal GPIO0 debounce handling
a855724dc08b pinctrl: amd: Fix mistake in handling clearing pins at startup
0cf9e48ff22e pinctrl: amd: Detect and mask spurious interrupts
65f6c7c91cb2 pinctrl: amd: Revert "pinctrl: amd: disable and mask 
interrupts on probe"
0d5ace1a07f7 pinctrl: amd: Only use special debounce behavior for GPIO 0
635a750d958e pinctrl: amd: Use amd_pinconf_set() for all config options
3f62312d04d4 pinctrl: amd: Drop pull up select configuration
283c5ce7da0a pinctrl: amd: Unify debounce handling into amd_pinconf_set()

[1] https://bugzilla.kernel.org/show_bug.cgi?id=217336

Thanks,
