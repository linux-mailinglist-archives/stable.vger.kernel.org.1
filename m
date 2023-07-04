Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92645746D55
	for <lists+stable@lfdr.de>; Tue,  4 Jul 2023 11:28:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbjGDJ2i (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 4 Jul 2023 05:28:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230492AbjGDJ2h (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 4 Jul 2023 05:28:37 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2070.outbound.protection.outlook.com [40.107.223.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF0A711F
        for <stable@vger.kernel.org>; Tue,  4 Jul 2023 02:28:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SQ0ghfuuNlgIZo76OGb93Mik42DOOTdAFgSSiulb6dvKQ1cK8TUHwNBAvGYMHCU4xpxQ3fcafeT/bXX7gZsb0GSursD6hWluFbQacO04NoVAEmLko+9MGNJ4Z5UEibbMOOZwtFmBmBgtQuGczS1jHpxR6/M5MAEJvav/zmGHoQHtV11iugC+2sn8OBU6J8737hyel0CFBqCs673tPl9NarMfBQEDV7EtYnzgHSFB2+LlVkL7Xa9KV+JS2+iGPR8+Bs3tTGzKmGGMRTNV9VKUNWkH2XUIjMoIQUjZ5IWn9Tc8hcifAky5JS/yJtq7fcRP9nUkAjSReYa+gcEHqlkKww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/5oOoiVlA/82NaxvpMCLylmWK/jpOYumvzjKG1Vpgb4=;
 b=ke5EfYabL7yQDbHmuWpywJdgrenZfWSsMzlOFQa92OsCdVBprCE8rXe2cJbAp+46Drkw6jxrm6caQBXUbixtAMwweHBHxbZXOLFvW8B670mRAZ+fPVwYXzkF3zI8q8YiuhBRJ3ZfkgLNy8ov96c2R5OlBe/SnvWXuQMtUeSQedlLbwnSeVNgNzRbB32bA7sFGurqukGnLy6K0dQxnauo0Var+Qq32rbgMhCr5jA5ObR65BlsYkjv+NBqS+NV+GnzNqQbiklbk5wb8zdi6cN1EH83BMuKM/wyYCGSTqVTHds20qg/Kii+V2YmfwDv8ROG5Z1ykElbu/zrvfZ3niRk+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/5oOoiVlA/82NaxvpMCLylmWK/jpOYumvzjKG1Vpgb4=;
 b=hvsDOVYAYXJERaBFCCrZGiqxDx1KsRcBwVLTTE04jksdaaf/FJukMVgmWN6Mu/DC/+bDKr7bDRuiSqANo/4VZASpEFfQbnK7D2yP8+pfdVjNEPp+acdxxEC2UQ535B40kuF8PHqfjQqG8G5VMZsbPASOfqLnnL94wNgDFINOLJY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by IA1PR12MB8406.namprd12.prod.outlook.com (2603:10b6:208:3da::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Tue, 4 Jul
 2023 09:28:34 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::5fe3:edc2:ade4:32ea]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::5fe3:edc2:ade4:32ea%7]) with mapi id 15.20.6544.024; Tue, 4 Jul 2023
 09:28:34 +0000
Message-ID: <b691b60d-80c4-2bf8-4f62-c957bf8fc1ba@amd.com>
Date:   Tue, 4 Jul 2023 14:58:18 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] HID: amd_sfh: Check that sensors are enabled before
 set/get report
To:     Mario Limonciello <mario.limonciello@amd.com>,
        Basavaraj Natikar <basavaraj.natikar@amd.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Malte Starostik <malte@starostik.de>, stable@vger.kernel.org,
        Linux regression tracking <regressions@leemhuis.info>,
        Haochen Tong <linux@hexchain.org>
References: <20230620193946.22208-1-mario.limonciello@amd.com>
Content-Language: en-US
From:   Basavaraj Natikar <bnatikar@amd.com>
In-Reply-To: <20230620193946.22208-1-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0033.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:22::8) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5040:EE_|IA1PR12MB8406:EE_
X-MS-Office365-Filtering-Correlation-Id: 0408d1ff-d4ea-49af-fa66-08db7c710a03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V98Hp+mqqtVXAZe2fz1u6+Rs2lD3mx9a1+EGlY7JWVK/E/WA9NKF/H6NV6W/NbhVgi4I0RgaIDnTlvxj8Wuwslguy+auQo78tZldw4ki0A1WRuFIhmUvZUQoN00sy8n4aksyLU++oYdTi1JTkyobin7OWqk02/VDdE6DAApjGVFCvXbpKb6/T3tK/vBza6kDmKWsGMElg+IPv9ChbRvmqZ0z+dQKtAB3f5m6BULA8slp5zzxLObHzquD4Bsrq9omVVkEIaMCwNCNUHLWDDdZBOOzjwkNlvZ5Y5dfj2FsJ3RdGkeuH0Ue72GqpE2cuoS6Jx3LFe+EmAy0I6tIyN5YWpvAjpvwLR0w6mHVAGlJaBN0NvTtiti5wu+YB1WXpWIfJmeKrFx/U4+6VBne9tBKlNt7EgptH1L5TRzYRZ11Io9dwRLzcMWDrdifUbXA/LvPZr9rrd20Brc9VSUBtwV+zzm2uwdQM6KcyTPJD1tBhfOVjv7sdkoxFzvRT18HBlbObl83IWHLvokpCdoUx0MSnUw126T7G9M4nO9lGd6Nd+HlmcVY0Ppyk0q66U9B803Qwib1v8Neduiv05knRiuG5nXMC2XWMvvzNxdzb532W26qlOr/DqYHXEZJhRuiuvh7E6p89ZJWGEUL4NnSDNX0W7DUUv9L+MOJci5mvG75I43Jqt606+q3tDAMO1bRTkUq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(39860400002)(346002)(366004)(136003)(451199021)(38100700002)(2906002)(6486002)(8936002)(110136005)(54906003)(8676002)(36756003)(41300700001)(6666004)(478600001)(5660300002)(53546011)(66946007)(66476007)(6512007)(186003)(26005)(6506007)(66556008)(316002)(4326008)(31686004)(966005)(31696002)(2616005)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MURqdHdDTmxndlV6TTl6S04zSFFQSnhuMWRPTWd4N3V5TnpTRWFPc045WVRQ?=
 =?utf-8?B?eGNHaWxPKzkvTzVTZVF0dHVCMEdlSnhDSmZ5Zm40SHVxKzUrZFRodHBBaXZi?=
 =?utf-8?B?eE00VEc4T0FuOThOaVhpUzFCeEhQL3hITVVDS1NmdFd3OFM3bjlwTW1Ea0Zz?=
 =?utf-8?B?WGZ0emZxSGNCSGU0UDAvMUJISm9JUWZYY0JxNk1JUzNVZTJaVWZYZzFPNkR5?=
 =?utf-8?B?YTZ4WFZHSVJpc3dIVHVESmY4RHFtMUtNUVFZNzBFSmpYNXdaL21GNldKMkxa?=
 =?utf-8?B?QVpISHdtOVMrUXBOY2JVR3dPd2xWRGszcm9GbWl2ZnlLcG9NVno3UWdEN25s?=
 =?utf-8?B?WEtBaUN4bWVEUisrUTg3MUhoaVVDTmo2Ykt2S0F2VCtNd0tXMEduanc2VDhE?=
 =?utf-8?B?azNyUjJ6LzNNR1hsekNSMGlwbWdwMWdGK0pNZmlQMVkxeTVsY01yempJM1M5?=
 =?utf-8?B?ZEwvY052QUhweWhFMk8wbmQ1Nk40cnBaekc1Y3k4bHRuOHJrUkFRQWxFaXF4?=
 =?utf-8?B?bSthWmhRWkMrRkUrZW92c00yL1VNRUNqbndMTEN3VW5pVVJnYXNUdFRZNjli?=
 =?utf-8?B?VDhtbzNubDhIVFlhQWJIU25ESmhPbkpxK1d1SXlQQXN6S2pMR28zVFgwbkp3?=
 =?utf-8?B?U3pKWWxYQi96TUVRVlJoN3FIWVhHUFFWc3YwclpwUVRrWmNCMzhJeURPZE0z?=
 =?utf-8?B?SS9QenZBUTZuWHU3dENMbHloWFlUR2ZsMjg1MHduZlVxRDYwVG52TzZkUFRP?=
 =?utf-8?B?NGRFSVJVVW5KNDNINkhtZkFJT1VuZHJ1QlhLTmxzZ1ZyM0h4MXF2dnFjM2Ri?=
 =?utf-8?B?Z2VCRlp1MHcyTzFmY0dCeUZmcnUyM2F1eVlNajVMYVdEeWd2bFJ4a3kzODVo?=
 =?utf-8?B?UmRlZTJqUnd5VEFyZ3RmVWRnV1pHWkNCV3MvdWxnb1h2MGx5MkNhZ0RNSzVw?=
 =?utf-8?B?Z3JMQUNFMWdDS0VFYTY1YmJyQndMZDNQZ3AvbUk4Wk9nSTZiVDBBWnd6dnE3?=
 =?utf-8?B?Z2JQaEhaSXZjL1NGaUM3dGk2UU8zZC80SytZTWVsUHVhRk95TnFzYTZ5UlJU?=
 =?utf-8?B?T1Qwa09yZHdlRFFQS1JaQ3p1eDVzNDJOSCtNR3graHR3bVJpdXJ4a2trRnRC?=
 =?utf-8?B?MHN4eXAxcDN2WUpDMXJZZTdwS2VBYkZmR3JTV1JPd3cvSGw1c3NYUGFOVitZ?=
 =?utf-8?B?VHcva0xHdmVxLzNjNnJTbDJCbTB3bXZIcVhlbENYUDY4ZzB1a05keDh1Vzh3?=
 =?utf-8?B?VUlYdjYxbjRKVHRYUDFFN0daekkwZHJqN1drUWFUb2ZzZVY3R0d0RlVycmow?=
 =?utf-8?B?Vk13cXJSTm9DRzlVZk1HM2tXdFBiM056SmNvSGxNUE9waHpEMGo1c2wwSURw?=
 =?utf-8?B?bGoyTmQ3REsyeHFHaXNLaEM3R2ZmOUcwQ2FRczZTcTFic3VFUEZkcWdLSGw0?=
 =?utf-8?B?TDkzOGJlUVNldFdiM0hMUWVBRUpaTjJVMk9rMVpZVHUyR1lWRkYrRDFDUFVH?=
 =?utf-8?B?QVMvcGloZXdxdnRCSVNlNGJDKzhId0J5RE5oT0g1ei9QUUErTEt5ckszM00v?=
 =?utf-8?B?bWt3MENnK0dPQ0F2eUNGZS9hSjNtZjlCYWM4cXNsWEYyMEJTajZ5ai9XZzEz?=
 =?utf-8?B?M0VheS84WGpuL0ZJWU9VYUQzdWdYQmFwdXN6Q3cwN2lHOXdBN0UwNUg5WjlJ?=
 =?utf-8?B?MzZ1OUZmOHlsRWxRaGlMcUhvYUtqTTkxUHY4clAreVFkVlE0d2YwajVsZU41?=
 =?utf-8?B?ZXN5RXpOemJNVS9Gem5wZCtDWi81UkpNcGZKMmNOZFMvalMvZXBrZjE2NWNl?=
 =?utf-8?B?T3RTMEpMUHRFRmNJS2tPdTE5WkE3OGtuUmlzNU1SUnVhbythcGRnL1NRRTh4?=
 =?utf-8?B?TEdBc2lJSDZZSW45bEQ0djA4VmoySXVKNlNKZnRtTUV5NUgyUFhXT3hJTytD?=
 =?utf-8?B?NTdNK3duMVdSK1FoQThadVlkajlEbS8vL0ZIZ21VUU9pcTA1VlVyMUJWd1g1?=
 =?utf-8?B?YTAvdnhqQ29HOTlCaE9hSXNXNnBDY1RLaFUrdDBGTHdVVkl0SDg2dHpRaGpD?=
 =?utf-8?B?MisrZkRldE02emsveEdRMTlmZHhwZkZnaTN4eERzV08zcEVBVU1zL29KSThT?=
 =?utf-8?Q?BJ/pNfYyXLmsHO+NbiecvXZ4S?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0408d1ff-d4ea-49af-fa66-08db7c710a03
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2023 09:28:34.5278
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 89CDiWWhHbDwM+WBKxWeXYOD/h13p7ejZkQ+v80gAY7Q6ghMoKEhyDW3vNowxkMSmG4LPZnqh95QQZXRYoK+Yw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8406
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


On 6/21/2023 1:09 AM, Mario Limonciello wrote:
> A crash was reported in amd-sfh related to hid core initialization
> before SFH initialization has run.
>
> ```
>    amdtp_hid_request+0x36/0x50 [amd_sfh
> 2e3095779aada9fdb1764f08ca578ccb14e41fe4]
>    sensor_hub_get_feature+0xad/0x170 [hid_sensor_hub
> d6157999c9d260a1bfa6f27d4a0dc2c3e2c5654e]
>    hid_sensor_parse_common_attributes+0x217/0x310 [hid_sensor_iio_common
> 07a7935272aa9c7a28193b574580b3e953a64ec4]
>    hid_gyro_3d_probe+0x7f/0x2e0 [hid_sensor_gyro_3d
> 9f2eb51294a1f0c0315b365f335617cbaef01eab]
>    platform_probe+0x44/0xa0
>    really_probe+0x19e/0x3e0
> ```
>
> Ensure that sensors have been set up before calling into
> amd_sfh_get_report() or amd_sfh_set_report().
>
> Cc: stable@vger.kernel.org
> Cc: Linux regression tracking (Thorsten Leemhuis) <regressions@leemhuis.info>
> Fixes: 7bcfdab3f0c6 ("HID: amd_sfh: if no sensors are enabled, clean up")
> Reported-by: Haochen Tong <linux@hexchain.org>
> Link: https://lore.kernel.org/all/3250319.ancTxkQ2z5@zen/T/
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/hid/amd-sfh-hid/amd_sfh_client.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/hid/amd-sfh-hid/amd_sfh_client.c b/drivers/hid/amd-sfh-hid/amd_sfh_client.c
> index d9b7b01900b5..88f3d913eaa1 100644
> --- a/drivers/hid/amd-sfh-hid/amd_sfh_client.c
> +++ b/drivers/hid/amd-sfh-hid/amd_sfh_client.c
> @@ -25,6 +25,9 @@ void amd_sfh_set_report(struct hid_device *hid, int report_id,
>  	struct amdtp_cl_data *cli_data = hid_data->cli_data;
>  	int i;
>  
> +	if (!cli_data->is_any_sensor_enabled)
> +		return;
> +

can we check below patch series which solves this issue by initializing HID only
if is_any_sensor_enabled
https://lore.kernel.org/all/nycvar.YFH.7.76.2305231559000.29760@cbobk.fhfr.pm/

>  	for (i = 0; i < cli_data->num_hid_devices; i++) {
>  		if (cli_data->hid_sensor_hubs[i] == hid) {
>  			cli_data->cur_hid_dev = i;
> @@ -41,6 +44,9 @@ int amd_sfh_get_report(struct hid_device *hid, int report_id, int report_type)
>  	struct request_list *req_list = &cli_data->req_list;
>  	int i;
>  
> +	if (!cli_data->is_any_sensor_enabled)
> +		return -ENODEV;
> +

can we check below patch series which solves this issue by initializing HID only
if is_any_sensor_enabled.
https://lore.kernel.org/all/nycvar.YFH.7.76.2305231559000.29760@cbobk.fhfr.pm/

Thanks,
--
Basavaraj

>  	for (i = 0; i < cli_data->num_hid_devices; i++) {
>  		if (cli_data->hid_sensor_hubs[i] == hid) {
>  			struct request_list *new = kzalloc(sizeof(*new), GFP_KERNEL);

