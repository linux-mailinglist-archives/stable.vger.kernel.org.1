Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 360C974A0D9
	for <lists+stable@lfdr.de>; Thu,  6 Jul 2023 17:23:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233586AbjGFPXR (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 6 Jul 2023 11:23:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233843AbjGFPXL (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 6 Jul 2023 11:23:11 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2074.outbound.protection.outlook.com [40.107.243.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2151FC9
        for <stable@vger.kernel.org>; Thu,  6 Jul 2023 08:23:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g2jLIjOYpgYWp9kYJ+XUwnYxw40XAPsdIOC9Jxv3JiaIyIJ7pbveBeaZQZpXD/VRDz8eR/Mh2pnX7o4F2d3EDO7O7TS/YrIZ/MqV3NiDrymf5g7bKnDsfRwewzRYgS1m++PapYit0Pgzb+J9g25MpqvHKekCCptgaV3Jld/HQGdEX3ycHj2nV2IA/4/kvzgki8YxEjLgfbcTfyEwP3jgIsIlNRszaMr+V/EGbQqle+a3nqYGPuRMoIT0KBU9Exnev1m8AOLxH12Ij05PYQJgeKi6QcF5Nf1TjE23aNywRJx5JN+dWBioXiwAq39jYZsJX+6rYYDPmTtVP33NuLecdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=60wD3vibx+uZDmt6ZBeAEyYRqNQPeKeaGHjSck9QDR4=;
 b=OscIatFwrAWdflSR1IPE86YZbjJ7YyxfiQfjFPOhbRyu4qisCueEdGl7FqkowZR92wjsu5ngsAKTZWpl/C66si6weBemd3v61JzlvXEj/izVFcM2vZw3uBkBnWO7XxgvC+wLO8lSJdH2bFktuu9hB2gKjcIe8tmkS2ryaJNZQ7LUpU3cpr52LorMTSGkqQfpR/PlOXiUAZ3wADSHsvDhhq4G3LsG0rmijWM20kU2oDUioRQBOuOQ6kpFPKJ9SMkeN9SJUgHUgFBAgu21e395Gj0ZW83CXOW8gGZ1rmrK3uXaXLk2MNzYlWbxQtlynrU4oGT89e7Y3XzsR5JmxA5WtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=60wD3vibx+uZDmt6ZBeAEyYRqNQPeKeaGHjSck9QDR4=;
 b=4FxTs25Yfzv1SRxAU+H6B7EZx2+LrylBxTRoCOJCWHNfpyX5zuYLqWMEZJd9HdqlFo4jURlP6SKxj9q3vy74JbocRqYsDeOsNBDrT9Blz/DlbWvoVJrfUG/UnQJsYK0g0W+PM834kcLJJG/6rQ5uEnSgEYHWi+p8mjtMkjxRiV0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CH3PR12MB8482.namprd12.prod.outlook.com (2603:10b6:610:15b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 15:23:03 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::dfcf:f53c:c778:6f70]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::dfcf:f53c:c778:6f70%5]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 15:23:03 +0000
Message-ID: <89ea9fb7-9026-ccb6-ad88-50e1c28b4474@amd.com>
Date:   Thu, 6 Jul 2023 10:23:00 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] HID: amd_sfh: Check that sensors are enabled before
 set/get report
Content-Language: en-US
To:     Thorsten Leemhuis <regressions@leemhuis.info>,
        "Natikar, Basavaraj" <Basavaraj.Natikar@amd.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Malte Starostik <malte@starostik.de>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Haochen Tong <linux@hexchain.org>
References: <20230620193946.22208-1-mario.limonciello@amd.com>
 <b691b60d-80c4-2bf8-4f62-c957bf8fc1ba@amd.com>
 <MN0PR12MB61012CD476072E6FBCCF5BE7E22FA@MN0PR12MB6101.namprd12.prod.outlook.com>
 <b81e3f5d-01ea-02c8-a9a7-e7f624ca0603@leemhuis.info>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <b81e3f5d-01ea-02c8-a9a7-e7f624ca0603@leemhuis.info>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR03CA0261.namprd03.prod.outlook.com
 (2603:10b6:5:3b3::26) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|CH3PR12MB8482:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a4fe119-50b4-4bbf-9126-08db7e34e3fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XMBilHuhgtKmGs6p0tFpc1GKf4J0SrwMeAPXe3BAN/lfd62ouYhXirmACq3L9dFmfkLOO2lrz0EFeksIeVKO9bcvkpoAweytuobnRtekixFUdrxekX/A/5HQyS2MPyFpZlEurcHwodQnLzu0bbteGF8X0zjKQV1SRJALrszjGtSTargsyZijk2uS9Hc2vUuZ52WKbbyRbbveXCGbps0cnOQD4CMdxfQ4Cjut5mdUjUD/4j67kvDcQXOsARrKrQhvYF1xkNh9o9cV7cH9puBvBKam/NJ924DpnLTQ3u/xo+DXICie0fyLfROP0SnMCaz0+QRNV2XihvzTBBHFPOiaDXCcA08+/jPQmCDtzANASLMM35Tp6RPAkKs+jxrunXHxm26p6ng5wRuiwiTwuoo7WqzJPUwTYH0NwlsiNOJD1ZnVVFmdKtT7NehscHm57PEjKynbGSuK+eDqxykvMlZ9V/uGksJ1JBthBA7zunH0izl96Zx6iAPAh7z3fqggPF9CjQmuPFuSdjKQlTJoo93lXn+/HgsWwKdaJoG7A3AgSJ6xdscdVkTAjNx3r1uhNZog+WCcvoDj5XAHyXWSdFx32CsU8Uc8+5Z8jmfuRI3nJ2kUJ9ay1KUu+isAYWKFeumcirlc0cdB1LtbUc5Jm7MdWA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(346002)(136003)(39860400002)(376002)(451199021)(38100700002)(66476007)(4326008)(66556008)(66946007)(2616005)(186003)(86362001)(6486002)(36756003)(966005)(6512007)(54906003)(478600001)(53546011)(26005)(31696002)(6506007)(110136005)(8676002)(8936002)(5660300002)(31686004)(2906002)(316002)(41300700001)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VkxNVnJ1dTVtL05GaHZ0MWlHNS9LOWxnMFZ2Zy85R0FJMEk3MEpjYXRJd3lC?=
 =?utf-8?B?YnFiSFYxR0Z6MFRXKzA5bEpTTzJaQW56N0VOc3Fhc1ErTXBIVmxpSW0yVTdN?=
 =?utf-8?B?NnlRZXZBNTVhVGJxZnYwVXpVN3ZRR2ZxZ2tYYVFiNlRPenhUcHdBaHd3Tk5K?=
 =?utf-8?B?dmJkZjRrR1k2cEp0R2hmZGlzQ21TNVZLcmhtV2dLdHQ1N0l0YjRtSmdnY2FR?=
 =?utf-8?B?WU1XMU1LNFpxZTh3MURiTG5ORjJOZU1SaW5UZ1JRRjNoMHBERi9zU1BMUmNz?=
 =?utf-8?B?a1JXMVBqK21tSEFsRXJtVnAzdE92M0sxTnN1TlJTZFhhVDhPOW5NNVpNZUFU?=
 =?utf-8?B?Zy9mNHhDSUNDYXRmTUpFVFAvS25ISzhHM0c5TzdUMm43VzRwWEt6QUc4MU8y?=
 =?utf-8?B?V0ZFVlBjQjdONnkyd3h4NUQrTHZkb08vYnlMZDd0M1IrUm8wVWZoNFYzMzRw?=
 =?utf-8?B?NHNHVDl0S0ZYeUpzNHpXaHRONERPd3R6c0pOMmNGN015Q2NEUC9qR0tjdlNF?=
 =?utf-8?B?UmxQYUFFZzJoeXhFV0l2UEU1Ym83SCtFUlRiT0R0cDNQYmd4RXVEamN4SGpX?=
 =?utf-8?B?UktUSmJ2NE92Nlo5RGxJaEVodXduR2tUSzVUbXhVRjllTFdkMG1CRnArK0hy?=
 =?utf-8?B?dWVPWUt5bVZ0ZXIvWW5UZHV6THcyUlZQSTZmdm9wOWlvaHJvWVNDSTJkSzlx?=
 =?utf-8?B?bVFkNTdLUjdveE9rUmNac25oSkJKdWltY1ZmdDU5OTBBMnpOYS9DOFRldXJ3?=
 =?utf-8?B?Y3ZST2N2RkhmODFlODRncDJFZkVJOUJFdWUyUHlGOE9NZE1ieGplanFzMVdi?=
 =?utf-8?B?QkZoL2Z6M2tKamdCSitheWhRcFBSRjljS3RNUzN2TFJDa1U3azh6Q0lPWGRh?=
 =?utf-8?B?UGd4RFgzUmFPQmcrTDE5dDJwSHBjMVQ4cU8wU05PS0RjeHBTcXFZNVgzTlBt?=
 =?utf-8?B?UGpYUVhXOXlqQ1hsc21PTHFmMTBNWDBNQ0FSMlJ1OHoyZk1BajYzelBhS1Mz?=
 =?utf-8?B?OG9vdHJCYkpWc1V4cW43WmpYdDBYMXIwL0VQQXFQZGgvNzdsbmh0a3JkT2xR?=
 =?utf-8?B?R0s5ZVk4SndiVEgwcnBxVzdZeW9BRkZwU2NJd2JxT3JHcjBXYkpoNHZCMDNT?=
 =?utf-8?B?dFVMd3IzdEVqOERkTnl3b2pyMEsrL1M0dkZuK0RVUGtMcFJpUXVveWtSOWpT?=
 =?utf-8?B?VXJvYmpwb3N0c1pieHpBSXdVMG1weGxVeU5HcGNheU5KOE4vQ0xmMTZlb1pj?=
 =?utf-8?B?aWorWURoQTBuZmxsWWhIZzdpdzRQcm1XeUhLN3lnOUFRRGhKVEN3bG84VHVI?=
 =?utf-8?B?U2F1OUlLNGhWUWMyWnE3bUJLMEVKbTh3cGF4YzE4TldBbEdYRlFUeGZOSnoy?=
 =?utf-8?B?SVFWL0d2aEtBbG5zM0pzK2NzN05BUXFqRDBMMGpMZXZEcHVzWGdiTitzTVFV?=
 =?utf-8?B?bE5mbUlrZEpMcEgxTERMWis3YWRJRjdFQU1RYkdlbkZJYkwvbnR1QkRBaTU0?=
 =?utf-8?B?SkhEYnh2VENiWmFuZHRwMHR3enNRTURKenByN0pwYnN5SjJVdUV0Z09raUhO?=
 =?utf-8?B?MWZLK1FvTnRGS3h4MFlkb0dLSy9MRXpIOHRXejIzb0FwbjJreG5VNmFwald0?=
 =?utf-8?B?ZFZ0a05YOXZsZ2wzQ2VRa2pGVlRUeUJ1SkRiaFFNM3NrL3BGR1hwUStnSFJx?=
 =?utf-8?B?eitwSU1LNDBSV01oVzM0NE8zTldBTElBZ2hEcXB2VTJmWUd2UkhWeENpRkFP?=
 =?utf-8?B?MjVIQ0VHVFM2U2hjdnk4bCszaGJRSDVTQ3dzeUx2enp6RFIvSkRQdnU0UHZB?=
 =?utf-8?B?b2hMbHpoN3JUMXYyeFVqK0tOZzAxM2pVbmVBWFJJT3FQa0NBdXNEQzNLaXM5?=
 =?utf-8?B?cm5rL0Vyc1V3QzBzZFcxdzhab0lFU2ZnamNLZFZDVjBUcEJ5aGZJZ2U3Vjls?=
 =?utf-8?B?ZnpjVGQvUDZtUndpaEZGMllLSG04QnlveFA3cjY2RzBIZ0hmYjNRb0N5WVpH?=
 =?utf-8?B?WHhUN1B6R25XTWxxRTJqMktYKzlWUEIrWXdISDkvekcrbW14RmMwMk9wTGs5?=
 =?utf-8?B?YVRVZGpYTDlzSXJHRHl0TmswZ1U3ZEk3NjhIMzgxZzFOV0cyeExBQWQyNDZB?=
 =?utf-8?Q?e2bTe5vGJaplNawl8idAHHOoH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a4fe119-50b4-4bbf-9126-08db7e34e3fa
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 15:23:03.2958
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vbbGgb7uCj4SZXZzAbLrVQI4EOAaZyzL3s7gnF6TP3sFS5PHBDDW2mno9EDgFmKkuy3q4XA8h5u2fjCi/T7s0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8482
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 7/6/2023 06:28, Thorsten Leemhuis wrote:
> On 05.07.23 18:07, Limonciello, Mario wrote:
>> [Public]
>>
>>> can we check below patch series which solves this issue by initializing HID only
>>> if is_any_sensor_enabled.
>>> https://lore.kernel.org/all/nycvar.YFH.7.76.2305231559000.29760@cbobk.
>>> fhfr.pm/
>>>
>>
>> The original reporter won't be able to test it because they've upgraded their
>> firmware and SFH is disabled in the new firmware.
>>
>> But yeah it seems plausible this series could help.  If it comes back up again
>> we should point anyone affected to this series.
>>
>> Thanks!
> 
> Hmmm. So this won't be fixed in 6.3.y. and 6.4.y then, as none of those
> patches afaics looks like they will be picked up by the stable team?
> 
> Hmmm. That doesn't completely feel right to me, unless we consider the
> problem Haochen Ton ran into an extremely unlikely bug (reminder: only a
> few of those that encounter a problem will report it). Do we? If not: is
> backporting that patch-set to 6.4.y an option once this was in mainline
> for a while without causing trouble?

So the problem that was found is the following set of circumstances:
1) System that doesn't have sensors connected to SFH
2) System that has SFH enabled in BIOS

As this is already fixed in BIOS update for affected laptop that 
disabled SFH and the vendor publishes the BIOS to LVFS, I think it's 
unlikely to crop back up on this model.

If anything it might crop up on a different model that meets what I said 
above.  If that happens, I suggest we ask any potential future reporters 
to test that series.

We can always backport it to remaining stable channels if it comes back.

> 
> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
> --
> Everything you wanna know about Linux kernel regression tracking:
> https://linux-regtracking.leemhuis.info/about/#tldr
> If I did something stupid, please tell me, as explained on that page.

