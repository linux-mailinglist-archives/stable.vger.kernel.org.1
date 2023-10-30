Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A97BA7DC1E8
	for <lists+stable@lfdr.de>; Mon, 30 Oct 2023 22:31:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbjJ3VbC (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 30 Oct 2023 17:31:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbjJ3VbB (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 30 Oct 2023 17:31:01 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2054.outbound.protection.outlook.com [40.107.237.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98368E1
        for <stable@vger.kernel.org>; Mon, 30 Oct 2023 14:30:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cf8VtfzBBGYQCWS/9KoQlnpTG4CvIcDYlQPNhB42JG/a/AVZ+EtpUOKPUFVU3sGqRcLUOcDAKnFzzWqO3jzKxxjayM+IRI4zRLCpRdggXbJylpXGpCeQ1RGGlHY5UF3AdUpbizydKsQEcHZJDufJK4BbdQoHhCTTxjcfxf3ajxc42U186SjLEhBGQn1wMJFitqQM1yONEY6WSGgqHlGO96afc/XkmwOvcuTyulZsJXKvwfWsaVJXzZLi+4dAktwGEmfnBke0rf4vjTElXkJm6kj4OfzyETBeZCIm5CxK+ssJ1Vds6hi2Da1NBhtIASY4K9QPsiwQa5c0K6+DDyYffg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P7XcH1lZUNwfw+WTSNR71V5huX/soKntFYiiCa7xau4=;
 b=lXAx/MY2GKj/NLdRORlMN/U1/boIJ8TnYZzRz1hZB04B4QRiI3fXRjrOxV7fhA1omIFksuzLnQdbfdo+bnn+BV7MXujk27ryORu1kFhP13eyppZuSmWY5NFPhUR1D3O0R1y3EODnMWCk4c5KzgNzW/JgRuJYlS2XvwSqUv90T1DaglfoXYpj5sbgbS3WLt7t3FFjvRxKWY454o21cRvYKKqBhWi8GeQzsS0nQ57FFK0n0VtLDnX/9eukxkvtVLPbsYQV0ozhlmMzx/4JACsaC8+b9P0C65Zg5Em4U6/oKQPLoXSN+CbOr0Bjje+DwNpvlF64FGT/NyPO7x6ucFwhjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P7XcH1lZUNwfw+WTSNR71V5huX/soKntFYiiCa7xau4=;
 b=2eNnyBu+87sOQjZer4nRSQLBVBKCRJE0iLWlqoXX9ZfAD9+/tCcQvbkkbKqb13d0O2L3w743uzFRLt58+kTmJsRuvczZ7oJm/ZMfLa2anwbY3pHKVRZnP31ka1Alkt020aPzxuOXIbLAVR0236AFqi7KgDH4J90LVoKA/Gj3Iek=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DM6PR12MB4372.namprd12.prod.outlook.com (2603:10b6:5:2af::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.28; Mon, 30 Oct
 2023 21:30:56 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a%5]) with mapi id 15.20.6933.024; Mon, 30 Oct 2023
 21:30:56 +0000
Message-ID: <f10297db-3a65-4e61-8f59-3f029e69dbb0@amd.com>
Date:   Mon, 30 Oct 2023 16:30:55 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.5.y] platform/x86: Add s2idle quirk for more Lenovo
 laptops
Content-Language: en-US
To:     David Lazar <dlazar@gmail.com>, stable@vger.kernel.org
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Mark Pearson <mpearson-lenovo@squebb.ca>,
        Greg KH <gregkh@linuxfoundation.org>
References: <ZUAcTIClmzL2admd@localhost>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <ZUAcTIClmzL2admd@localhost>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9P221CA0020.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:806:25::25) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DM6PR12MB4372:EE_
X-MS-Office365-Filtering-Correlation-Id: c7e42362-c6b1-4325-6300-08dbd98f8047
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vIvpPoROk1YgkVnGZadD9oA06A7+M7mH4SyF40mLAT8wJwlFx42MQWfQdhmbvjXHwifpTYZnp0V3gSq9GqUZtOQbvhSVMx8grZOgssJRL2FRmbgo8OLqM7YT4HKIMLybV3vBJcZ+3Fcwa/jfuzhlNyJ5I1jnO6UXik4vU0ssIbLtsUlncsszZoDn45/mIevEdfSHagKqyNClktiVZgzN8GVxXQlBKfOp+J5iLI7Le6+Vz0BYice2/Xn61hqagGNovzPZrJkIOOo8/hwvKYOEyOg6YgbTzlYH9GM+5kMIjfNYm0tnVJMBcIpMpPUCGoAl7pv25XNWGiQE2FSS1IkwbyDw0aFiPr8lVrrGvaPO9KulphjEP/1wnq13Hb1sFgqfiEuEy2f3SBYsv/3pIIozFbHFhvMTKIUXQ+PVDHZUDtscSEZHgpIF7/xYQfGMwlRHatK3VjBVS7BkxFaOay7ErYo/8YHwY0sSlzgzTOK+Zq49aSir+8iea4QRcadcgovABXC6FWHZQkbmREnoT08giyMmMxHuJtsVALCvDoLFAi6++qP9LLKFZepJ1z7OCBBe6x+vT68w3BWAf48iqr3Dx/4cBI2/949atckYm0PgJLIPJ+B68OSRjgX3Aq5wapZBdRnuO1qkqaYFo5bqKmcPK4j2kxPFNalbTbnCizzbxho=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(39860400002)(396003)(366004)(376002)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(31686004)(2906002)(8676002)(44832011)(5660300002)(41300700001)(31696002)(86362001)(4326008)(8936002)(36756003)(316002)(38100700002)(66476007)(66556008)(54906003)(2616005)(66946007)(26005)(6506007)(83380400001)(6512007)(53546011)(6486002)(966005)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q3ZTZUhCcm44OFBoeUhYdlNYUENqUW0xUDlpOGRqVkJaQmFYVFRIaU9yWjI2?=
 =?utf-8?B?bm0yVGp0bW5xb2w5U3MyYnFUVVBhcnJiTDQzTEd2RHFXRyttcy90L2JZakNt?=
 =?utf-8?B?M2hqSmtuRUxvTUdWaXZFZ0lqci9XV0Q4bUIwUnB3QVUyK1hkV3UzalFmUXZW?=
 =?utf-8?B?V0ZNVUZHWHZCRGtEWXpmMGhsNE1vTzM4Tm9LMmlxYTI4M1FDY3lBYkVGbHhF?=
 =?utf-8?B?MDFoZERjTHdpT05ESGVCQW5DNkF6VEZUV2lNWWdicUxjY0lVWlA4RG1UREJn?=
 =?utf-8?B?elB0T09oem5maGN4TTFOcUh1Z1J3OElYREVVcHU3NVZ5czM2dmd4TlFab3pt?=
 =?utf-8?B?R0t2U2ZOQ1psREdIZktCWmZFbTFZNVZRcGZmUVhYUVdVTEpKU2tUVysrKzlj?=
 =?utf-8?B?aVZSSVdTb2NLSmVJeW9ZS3NEUGlNRHRMTktDQ3NuU1dydEZicVJxdys5MFBt?=
 =?utf-8?B?SkhxOUFJQmZpUllKQlc1UVRIT1VZaVhBT2dvVlhydTNNMWtuM0g2NUtlM1FI?=
 =?utf-8?B?KzBEeTNHNGJ0TC9JQUllVXRWVmtoLzFUcXgyOHBJN21ydnVHMVd3MmtyWEpT?=
 =?utf-8?B?dGZhYm4vZkJ6eE4wSDUyY2ZIQ1liTUJoUDRBS1Z5TW1sdTJ1WDFNTHdydWs5?=
 =?utf-8?B?eXpENngrNVhsMFZFWTdyajVGVldzREJsSjVjcDZiYlZsRGN4QmdCVk5ZTFBu?=
 =?utf-8?B?UzM3QXI0Lys5WU9MUXZzeHRiWUxDOFR3cXl2dGRpS0lBblovT3dIZitWNFd3?=
 =?utf-8?B?dFc0UHh1USswQWFzamJLT1RUcjMzUE5kR2dqd1FabnIrUUt3djhuUzMzanRG?=
 =?utf-8?B?azdiZ2pQMGZkcXVTNDZjVW83MzFtSnlVNzEwampLTjJ2dVR0N2t1TjlxZGp4?=
 =?utf-8?B?dkFwTjNzZDFrT00zbjk4QXNUUWgyWmZWNHhha1RYdTBCdFlRYm1XK2NpM2xu?=
 =?utf-8?B?aHNtWWsxU3RqREF1NStSL0duNmRsUHh2aTY3Ym8vc3NkRmhEQXlEbGZicnhN?=
 =?utf-8?B?bTJBRFNGTFM3Zmxtc1ZsL2dVcW1GVFpSRWRJOWpYNFhmL2Q2cHpnVXk5azJI?=
 =?utf-8?B?Y25mKy9sL0R4d3hCTDZNcnZzNURMN0sxelpuNWl6dU9rY20vQ0RwTDRmUEtJ?=
 =?utf-8?B?QWFuT2xKK0lFVk4xQXpaZzFzNEMxbFhCVlExaStZcmYvVEo3Y0F0MThMK1Bz?=
 =?utf-8?B?dVNvQy9iWmg5dnd0Y1VJczlreG4vK3R1ZjNJZU5IWGl1elJDREJTU0YrKzhT?=
 =?utf-8?B?RjRETm9ZSXdsTUFIL3VwcWpVdllNa0w2NzBIWVFBT1Y0MVJ3WTF5Y0VQVTFP?=
 =?utf-8?B?NDVKeXdHNVlISitTM2tTcUplcWxubFJiR1pSMXZGZVZnK2dUVlMzVlRCOGV0?=
 =?utf-8?B?eXZobkJBdEh6bUVhek9zNFRwbGhGaHRJcWRxRDRVWjU0YUl2YlRpSmxqMXZl?=
 =?utf-8?B?S1NXMGNBU01QL2RWNjFqNjdhdlRGWXQvN1ZtODdqZnZqZVBOUEc3dDM2MGpO?=
 =?utf-8?B?S2tsM2twSEoyTnRpUWNKL0JnTENNK3B5OWwxN1BIeUdvcUlmNVlXamJRTXVi?=
 =?utf-8?B?VnhmME1xU29Vb1FZcGhJRHdUMEZLSTY5SzlxY1lvWXpKTDJWNzNpSjVmNUxH?=
 =?utf-8?B?RnV1ek9sWTZtcktmbkovU3hRZmloUnlFUFQwYjBsTkVKYzdyRDFXc00reVJ2?=
 =?utf-8?B?bEd4dHdyQ3BHcjZMUXBBdCtJMFFwaGszRWJxZXBzbnJuWW9RdDdwTzlpTzRS?=
 =?utf-8?B?eUtjNXl3c1VWVGdWUWNEY2ZqdEoxWFYvYjJWUjlDSC81OSt6bjdwd0U2d0Za?=
 =?utf-8?B?cld2VjhBNmF2c0RTNktxWm9vV0dBTVBzZXJtb2JpM1c4OElqcXZZTzU2S0o1?=
 =?utf-8?B?d0RIcitSb2dsWDJFUFV1SXFoK3NFUzhVNVlKSUloZGxITTZwR2d3UTRnWDl6?=
 =?utf-8?B?eXZXTFVlbW1hK3dad0FyL1dsNzlheVowZFJhQWtHVUVsWk1LV0s2NjRIQ0hG?=
 =?utf-8?B?ZTdlVzlhaVU1QXpVdWQyc3NlK0RUYW5USmkyWG1Lb2JTREJhQUl5aCsrbWZE?=
 =?utf-8?B?OG9aNHdVWmNQZHcvbGdKWTVFMklHQWo3ZFQwNUJGcUU4Q3R5c3M2TUZzek5I?=
 =?utf-8?Q?6540aGaivCa63JYpEVVMfWPEJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7e42362-c6b1-4325-6300-08dbd98f8047
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2023 21:30:56.0060
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T2fF/2vfwkgAGZXTStjEFyjR44sIDYkSv4ZdYfNuTUZhX7bEsRO+kJdgYIJ51Kyv0h/dteB4j++eUfgTnrLH9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4372
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 10/30/2023 16:12, David Lazar wrote:
> commit 3bde7ec13c971445faade32172cb0b4370b841d9 upstream.
> 
> When suspending to idle and resuming on some Lenovo laptops using the
> Mendocino APU, multiple NVME IOMMU page faults occur, showing up in
> dmesg as repeated errors:
> 
> nvme 0000:01:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x000b
> address=0xb6674000 flags=0x0000]
> 
> The system is unstable afterwards.
> 
> Applying the s2idle quirk introduced by commit 455cd867b85b ("platform/x86:
> thinkpad_acpi: Add a s2idle resume quirk for a number of laptops")
> allows these systems to work with the IOMMU enabled and s2idle
> resume to work.
> 
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218024
> Suggested-by: Mario Limonciello <mario.limonciello@amd.com>
> Suggested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
> Signed-off-by: David Lazar <dlazar@gmail.com>
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
> Link: https://lore.kernel.org/r/ZTlsyOaFucF2pWrL@localhost
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---

In this case are there modifications or is a clean cherry-pick?  If it's 
not a clean cherry pick, why?

If it's just missing another system in the quirk list it's cleaner to 
backport that missing system and then have a clean pick.

>   drivers/platform/x86/amd/pmc-quirks.c | 73 +++++++++++++++++++++++++++
>   1 file changed, 73 insertions(+)
> 
> diff --git a/drivers/platform/x86/amd/pmc-quirks.c b/drivers/platform/x86/amd/pmc-quirks.c
> index ad702463a65d..6bbffb081053 100644
> --- a/drivers/platform/x86/amd/pmc-quirks.c
> +++ b/drivers/platform/x86/amd/pmc-quirks.c
> @@ -111,6 +111,79 @@ static const struct dmi_system_id fwbug_list[] = {
>   			DMI_MATCH(DMI_PRODUCT_NAME, "21A1"),
>   		}
>   	},
> +	/* https://bugzilla.kernel.org/show_bug.cgi?id=218024 */
> +	{
> +		.ident = "V14 G4 AMN",
> +		.driver_data = &quirk_s2idle_bug,
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "82YT"),
> +		}
> +	},
> +	{
> +		.ident = "V14 G4 AMN",
> +		.driver_data = &quirk_s2idle_bug,
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "83GE"),
> +		}
> +	},
> +	{
> +		.ident = "V15 G4 AMN",
> +		.driver_data = &quirk_s2idle_bug,
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "82YU"),
> +		}
> +	},
> +	{
> +		.ident = "V15 G4 AMN",
> +		.driver_data = &quirk_s2idle_bug,
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "83CQ"),
> +		}
> +	},
> +	{
> +		.ident = "IdeaPad 1 14AMN7",
> +		.driver_data = &quirk_s2idle_bug,
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "82VF"),
> +		}
> +	},
> +	{
> +		.ident = "IdeaPad 1 15AMN7",
> +		.driver_data = &quirk_s2idle_bug,
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "82VG"),
> +		}
> +	},
> +	{
> +		.ident = "IdeaPad 1 15AMN7",
> +		.driver_data = &quirk_s2idle_bug,
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "82X5"),
> +		}
> +	},
> +	{
> +		.ident = "IdeaPad Slim 3 14AMN8",
> +		.driver_data = &quirk_s2idle_bug,
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "82XN"),
> +		}
> +	},
> +	{
> +		.ident = "IdeaPad Slim 3 15AMN8",
> +		.driver_data = &quirk_s2idle_bug,
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "82XQ"),
> +		}
> +	},
>   	/* https://gitlab.freedesktop.org/drm/amd/-/issues/2684 */
>   	{
>   		.ident = "HP Laptop 15s-eq2xxx",

