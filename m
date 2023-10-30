Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 556BB7DC1E6
	for <lists+stable@lfdr.de>; Mon, 30 Oct 2023 22:30:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbjJ3VaD (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 30 Oct 2023 17:30:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbjJ3VaC (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 30 Oct 2023 17:30:02 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2055.outbound.protection.outlook.com [40.107.94.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE6009F
        for <stable@vger.kernel.org>; Mon, 30 Oct 2023 14:29:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QttIvk2QyHYjw6UppEZaiV3hZjTK6jqMO9FETt47MWalUeIFFFYNpJ7HGURnTYzB0sb/C9SvsbgCFAQ44psbMsOrv100BaLrCYIpRvIIpJUcMvORT9Jrt2jzwt4sBZNkc1bs2TXQcDJLajEiElTA2qRHTla6AUHhmstn9gt/6wWX7A+kcPl2uU3oHu2j3/25UqzfxOHiqjW3KH8pESA8DPJ5WQLpRi029IYk5DV7WEDTN1Z+YxuZQxMTQEeVumzrg0kt+FJA7sg4QAf4uhYSs8z2dX/7zphzDf+OgKLpYXjdBzFt2D59prpjixjT0uJZM8r1u2L9Q25rLw/j1Wc3ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CfoCzfU2kce+5hYe1EHhC6vFGvJBKjuVBb87RHu+grU=;
 b=Jre8SDyut/QgxxPHWf2rpGcgU+sYsySZOw3J5KFTm+nIJASceyrA/XIUqYl2S6PQutwXLVeemqoDQpFwr0pD4iD2emX9iNZmw/a0I++NeE9+bwsZyma1pVKz/mt4nQBeGbGFEVS/+jeauazEP0BSg1NZGo+awQ05OabqusSXzFqctI+94RztsQIfbac+gytzi6qNFyegTkwKBQvcAMAmaBYelFuJUKKTbo638r0avBq0DUU59nfHnUoi420UXCjeRZNDPUMk86dcV5plKCSrUgkp6oPmD9YuGaejlJ5w50zBdr+hkSPFpvmv7bFSJUxthLwAuXHxlrYY8bBWg9V5fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CfoCzfU2kce+5hYe1EHhC6vFGvJBKjuVBb87RHu+grU=;
 b=TR6L0QxakpW9RS6BgXfRporNE295e2AIPHpW9fcVOvilfekOBwTXOtZAeNcr3kIssDuhVRDch4tL0zCB5TfHigVQ7faRj+6ONzu/41qLRRss7s3sHMRTkytOQofUZagB7VB6UJIAhH3wlwSKEz5pJwbztUzgVccVi2MDrm+VnS8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MW4PR12MB6779.namprd12.prod.outlook.com (2603:10b6:303:20f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.26; Mon, 30 Oct
 2023 21:29:56 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a%5]) with mapi id 15.20.6933.024; Mon, 30 Oct 2023
 21:29:55 +0000
Message-ID: <bb006649-bdf0-4dbf-bab6-45b06ecfdb10@amd.com>
Date:   Mon, 30 Oct 2023 16:29:53 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1.y] platform/x86: Add s2idle quirk for more Lenovo
 laptops
Content-Language: en-US
To:     David Lazar <dlazar@gmail.com>, stable@vger.kernel.org
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Mark Pearson <mpearson-lenovo@squebb.ca>,
        Greg KH <gregkh@linuxfoundation.org>
References: <ZUAcHzdwjpXA8VSq@localhost>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <ZUAcHzdwjpXA8VSq@localhost>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9P221CA0020.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:806:25::25) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|MW4PR12MB6779:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b2a90b4-291f-4963-7fce-08dbd98f5c6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G27xQGknWMbPmkYm4BIIUgV1oSmIoFH6gaQowTbkLux2M+cxW0b5nHwBvScNPTfzLCalfTjkC12zbHmcqhMZYMlSVi8Ba7s8TnbkCbLPTTdhQLYGCpsa0iuhZL6uICyWfGRDd8v3hKsfeezl/v9CALuhGUxzRpiwSx+gyEjrp9kobnYUg7rOu8lyyvh2csmo1mV1yQgulIKme5cj/EN7R3/U9A4FDhxj70OVSKU5o9URWquxxOHcE5EUtrVuTwjhCQVKNn2jM8JkrLNRyJlzxTuu7B/Xa5iZqWwHxSPvx4T4qW3XlpgwD6lSDP547fnGzmG6fGJXAf/6SNJXcsDcw4wialenuOXOB2XGduUzwJTzCF85Jfe7Cd6j51vWrPQYRsrY+eU3sSzNFRZAjUGQQ7K3yxj3XFqmEJP8jH9GGXnkkyV3Q6i7Gb7CmQ5Qp9YDX2Zdg0M3jbi2VD8XmpT+VzqKmtMf6FIVPKIdfqKVq/mS3X0IA13y25QkpppLHtIFH/sLO8UxPeX4uz+kXaG0xbnSIpIRHNJSt0MNUoGYVcFW/8niUEZ4paT3c9h1sbB96buUK4F72XCzMc/XwrrMRdDkszSl5VHhlMjLLZ5lHtGBnAztoIwEMA2XA5CfJZbE7DEvvXJzjU0tzVLIsg4d9baruHB/OkHNLia97R0Lz2q/aNEOLyylCP5dU4fCpcrz
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(376002)(136003)(396003)(39860400002)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(83380400001)(41300700001)(5660300002)(2906002)(2616005)(86362001)(36756003)(31686004)(26005)(31696002)(38100700002)(6506007)(6512007)(53546011)(6486002)(966005)(478600001)(66946007)(54906003)(8676002)(66476007)(4326008)(8936002)(66556008)(44832011)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dklBQU9YdHRWbGlJVWlkR2VrckhhOGxhTHV3cCsramlzaHhEVWpHZFlyaWRO?=
 =?utf-8?B?VVFxZmVsazZEbmpybHNkdFBZSlVWZWE4KzNsRko3WDlZcVM5a0tpclViMlVl?=
 =?utf-8?B?U2RDUHY1UVV6TWdVQ0ZudmJNK25nV2pTR0lFdmtFem9vMGs0eHd3aitzYS9v?=
 =?utf-8?B?VFA5Y0c4b0h5cU00eGpCTG5iSjVlUUJ6RDA5Zk5DNTBMcVdzTWNSRDNXRlI0?=
 =?utf-8?B?WXFpcjJtQU5adDNzcmVuZlNiNVRqYVl0UWNqdUZrQVdrMDcxNGYxU0RObjdE?=
 =?utf-8?B?OC9HRVpOUTNraCtzMmVhQ3hoWXZ6RXI5T3pOajhMTDIzWFdnNHpTOVRudzFH?=
 =?utf-8?B?OXJYMXd6NFZRSjdQZVNiVDlweWh5NzBqKzFaNXduTzI5cHlBRUc3M0tyUmsx?=
 =?utf-8?B?OVl4Ris2bTgvZmF5N3pJdFFLQVpNeWk2dldSUHIydmxKR211K1hvSHhNeVBL?=
 =?utf-8?B?RjI1ekFVcDFBdzVKUDlNNnhoaTNaKzJhRXhKVUt6OWNVSXRwQksxenUxQVUz?=
 =?utf-8?B?RjYvdjY1NHZXemNEUldXNDJuTHV0dnJlUnhycEhXUDZBTHZsckhyS0c0UWxi?=
 =?utf-8?B?NzdJV0hQeGxQdEFEUklMVXlwYzZKZ3IrZEMvSWlRbjB5R05jcW1IYlBGOWZP?=
 =?utf-8?B?dXNLYW82STRNcTVTWlJGWE1laDN3OWJSRzhnNnpxc2JiWU9HRFBiNjkyS2pS?=
 =?utf-8?B?R2NNRDhGUnRXMTQ4Q01WcTJSNFcvZkRqNE1NZUdtN0lFUi9tajBXNUR6RW9n?=
 =?utf-8?B?U0Z0NG4rcFBzQjdNQ1h3WGVRMURkT0NXVUVuMzFRalNWZ3BSRmt2TEdhQmlW?=
 =?utf-8?B?a2VmeVBJRytBUU9Ya29acEpWUVUyUFdiM2FxSlZyQk5TNCtZV3g5VkxzZktC?=
 =?utf-8?B?VEFSckdJUTJUdE1qTHhkY3NPYXE1eVRFcHFiUmVoZkZGN0JTajY0RlhGMDNl?=
 =?utf-8?B?RjRSRlpWc0EwRWIyT0w4MHZEZEpvdW1nTUZrcy9wZEtzQmtFZjR2SHkxTFFh?=
 =?utf-8?B?RmJmNHRKSGRnV2RmdE1sbUdpclVDaUVHVUE5TFBqSUpmUlVmNW1Rek12S0x2?=
 =?utf-8?B?WnYyTHY1VE9CcjAreUVvU1krV3JEekxkVmhwTnlOamt6R0xpM0lZdHV0aXlt?=
 =?utf-8?B?TWE4Zlc2QU5FQ1BXU25YNklwMTVLekJycDBONFVlOTR5d3lySzhoaTRjaDZD?=
 =?utf-8?B?RzRiRFdRMnRMbVJOOG9YKzQ2VmlpdkFKRWdPL1dZODFiOTFkelBEMklGQVF1?=
 =?utf-8?B?YzhXeWZkY0diS0ZJRmt6Y0NFUWEvODY5RTVZN2Q5RTJyamhrdElKeEhpd0Ny?=
 =?utf-8?B?Q3FCVmltYWMvTEhxMTB4c1JQTVFhMjJkdGtUV1dFV0pYcGdWdlZMZExJUWl6?=
 =?utf-8?B?WlMwWkVEdmx1MXJWUjFDSXZlQ3BJUHdKc21vdHdKSk9BNHVWUUtBcGwzTUQw?=
 =?utf-8?B?U3dEQ3k3VDBpM3BSNC9IdkkwbjgvQ3lZbWxzQUhhQkpwZVpIMlZmSDBPWkJN?=
 =?utf-8?B?UDBDYUQzUGRMRkNtOFdTenZ4QXNjWUEvamMzNzBsWVM0Tm12SDM1YlA1ZTZE?=
 =?utf-8?B?Vk8veHY4cnA1RHUzNWZSTy9MVHZLMDIxNGhlOG9hdCtucDM2NHNVOS9oaThW?=
 =?utf-8?B?ZnNBbVlGRFNvaWNaOS83bFMyQkxCSUh3NzJIcTB2VmtVNno3bG8yRitSVEhQ?=
 =?utf-8?B?SGt3MXVhczJja0Vsbnd4UTZxQks1akMxQnprM0tKZkxZSGZ0OW5QNFJJZlBt?=
 =?utf-8?B?TWRTUGVxOXc3TjU3MFRpMEhvekQrcEJPc1p4aGc0OEJMT0NpaGlvd0tZMHZt?=
 =?utf-8?B?a0oyejliN0wzK2dCWW1vSkhPZmlxb295UkpVK3hRZU1zOGtUV3VPNHYwemN2?=
 =?utf-8?B?N29PaERpZFdlWi8rL3RoanBPVzlOTDFkeWNBT1E5SjZpZ0VaNjlTYytGZzVY?=
 =?utf-8?B?eDZVbXhOYTlRellHanBGZTE0bnBIOUc5M1k2dk1ZemxrS3lBWDdlbWxid3Mv?=
 =?utf-8?B?N1VpTG83Z3RXVjhUVlg5YklVbEFhM3ZHV1EzYklrT2pXdGV4NVFibVZjajhl?=
 =?utf-8?B?RFUvRmIvMjNPTE4zLzFVelpyTk1DWktsb0dOY2VZeHRsMWhzaHFtR3dtNnI1?=
 =?utf-8?Q?xfpr3lPDkzazLJ6tsJRfg9Nl5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b2a90b4-291f-4963-7fce-08dbd98f5c6e
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2023 21:29:55.8792
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zYGiSQgfi8vbB8+WjtVf7lYliXAEzMrV5Cnj2Q7KJBcC+RO/5GEMUJDqRx+GQjsZHRglO/rzdQEe7PFFVh209A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6779
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 10/30/2023 16:11, David Lazar wrote:
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

As this is changed from the original commit in 6.6, you should add what 
you changed in why below the commit.  Something like:

Moved quirks into drivers/platform/x86/thinkpad_acpi.c since kernel 6.1
doesn't include the refactor that moved it to AMD PMC driver.

>   drivers/platform/x86/thinkpad_acpi.c | 73 ++++++++++++++++++++++++++++
>   1 file changed, 73 insertions(+)
> 
> diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
> index e7ece2738de9..3bb60687f2e4 100644
> --- a/drivers/platform/x86/thinkpad_acpi.c
> +++ b/drivers/platform/x86/thinkpad_acpi.c
> @@ -4513,6 +4513,79 @@ static const struct dmi_system_id fwbug_list[] __initconst = {
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
>   	{}
>   };
>   

