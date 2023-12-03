Return-Path: <stable+bounces-3792-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BB21802555
	for <lists+stable@lfdr.de>; Sun,  3 Dec 2023 17:16:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8409B1C2095B
	for <lists+stable@lfdr.de>; Sun,  3 Dec 2023 16:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4093615ACC;
	Sun,  3 Dec 2023 16:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Eb9EZrrQ"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2087.outbound.protection.outlook.com [40.107.223.87])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AB06B6;
	Sun,  3 Dec 2023 08:16:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lEr5WjvWVKcwqIcTU3uVJ/5hozgStwvIawx3hApvm3mKHMoV8XdlrTc+eCDPdsTVR7LQAgGPNuy5Q1tRVoxCIyHvKszfoluTDGF0JiLRK4+/5EJdMbLM4Frked2lx9qHT1fKUoitIt/bPRuxl6A9rgaGJpYemfPRpGnFv7fAdxC+JJc5RiaDjjURscUlfT0YZdXX+IFgxbsTFh+hByP2NQluyLbyAnWQEzq9EDyYrSBDv9P6vIy8GFJZ7+2NS7fb24uvPEj3roc3MP1hlKlN0iAV6eEGXXD5erOISUg4QTqt1MTrQyYLxC7R3iQ1EpEqGYHBSMGJqZbPnS8yRYLwZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rKPhSrbNic464Skk6JtWPx9rQWZcsyN/OBGEdXXo4tk=;
 b=WY81SyVBvC2zJ6knEieCgK2zn3Z+3i00c0k91bTmjjyTw48si3eCV0+0K/u6CATat83HBkHPQPwKBrBDVrgN2778DXlzlZi4d0qirhaWCDjPwsLu84qplwoSRV+SqJsELO8l7NYGaNYT1i/ez1ym+tTMbggsGpm3joUkpOxcCQjwK+kzWF3jse99ElWgWgboe3VpVpyKs1L3NULdNVVtv1dWs/QP1kMOKyZEu9aUNeyD34Q5UvURN56bHxNXOmnVr/VK3/BDFIVBCX99KvTYxQRNql6TdvH4cJhZIyprCUuI3bXvnGv3Ecv7Tv7ropNUe1Hsbz5ZddUtpC/KjMxW/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rKPhSrbNic464Skk6JtWPx9rQWZcsyN/OBGEdXXo4tk=;
 b=Eb9EZrrQE+4J54vGcdvYB9V6zFJPst/Tq/leOdzywX1lD405odzNfiZlI58K5ATw0DUUELijoweXLeimWWkWjxUuFz3wtOR1XyX33XSXdovNrBgBegAz8cdqgRQhdG4DiquoZ9e9YDnZ2u7S/lv+J3AfScLrxF1qe9+XrEjBIXs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by DS0PR12MB7850.namprd12.prod.outlook.com (2603:10b6:8:146::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.32; Sun, 3 Dec
 2023 16:16:27 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::6f3c:cedb:bf1e:7504]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::6f3c:cedb:bf1e:7504%4]) with mapi id 15.20.7046.032; Sun, 3 Dec 2023
 16:16:27 +0000
Message-ID: <93b7d9ca-788a-53cd-efdb-6a61b583c550@amd.com>
Date: Sun, 3 Dec 2023 21:46:18 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: Regression: Inoperative bluetooth, Intel chipset, mainline kernel
 6.6.2+
To: Greg KH <gregkh@linuxfoundation.org>,
 "Kris Karas (Bug Reporting)" <bugs-a21@moonlit-rail.com>
Cc: Paul Menzel <pmenzel@molgen.mpg.de>,
 Basavaraj Natikar <Basavaraj.Natikar@amd.com>, stable@vger.kernel.org,
 Thorsten Leemhuis <regressions@leemhuis.info>, regressions@lists.linux.dev,
 linux-bluetooth@vger.kernel.org,
 Mario Limonciello <mario.limonciello@amd.com>,
 Mathias Nyman <mathias.nyman@intel.com>, linux-usb@vger.kernel.org
References: <ee109942-ef8e-45b9-8cb9-a98a787fe094@moonlit-rail.com>
 <8d6070c8-3f82-4a12-8c60-7f1862fef9d9@leemhuis.info>
 <2023120119-bonus-judgingly-bf57@gregkh>
 <6a710423-e76c-437e-ba59-b9cefbda3194@moonlit-rail.com>
 <55c50bf5-bffb-454e-906e-4408c591cb63@molgen.mpg.de>
 <2023120213-octagon-clarity-5be3@gregkh>
 <f1e0a872-cd9a-4ef4-9ac9-cd13cf2d6ea4@moonlit-rail.com>
 <2023120259-subject-lubricant-579f@gregkh>
 <ef575387-4a52-49bd-9c26-3a03ac816b61@moonlit-rail.com>
 <2023120329-length-strum-9ee1@gregkh>
Content-Language: en-US
From: Basavaraj Natikar <bnatikar@amd.com>
In-Reply-To: <2023120329-length-strum-9ee1@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0009.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:95::17) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5040:EE_|DS0PR12MB7850:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a7abc35-bdf5-40f8-469d-08dbf41b33b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	4B+P/aYYrN9S1imp/pE113kraukLe6r3kWsROlgjmd9oOLloaZtZ3mWRtuK6OhNwMfgZwRxiuOEiZp+igtosQNx8MvCxQw3r50+flxd0Ap5bY+qZ6rSWNKVUKC7dZHICCw7vFXHrQ2/5A+p2m895C1QQtfsuF/hse20U8zvmtxT74dGkPEQvZHROSwK52w8wH6MNC4s1ZekLqHFfk1PUWLIGhWeT0i5TmOgbzcUH0+3aUkHZcxTrhyoNrHXh21J/KEDwsEDFU7eGanaUjF+hTjQWeelm+AVgCkNqd7N+lVZZ9SwkX6GNsSxx+8SJibmcP6AzMF8lsXZQyUD2Mon3c0Y9BoBwRd2BNeDm5CqO/nbbUFb3rblmao/MSvVaS20KXY2e4OCms2q6no1Icng+w8ub4caZdiulnb/npsUQRZUhcxHd6086llINE8D5neRaTsaPFDs7o47KFI1S1jSuN9EW/MCmRXzhVb/GpaJ8tzDO4eILb6P2x8S73Mhk39g8LA+DvOIQ3xHdqECikQGlr4vEIrt530ztOTjbiD25hrcg2EhbPWOqzLF6i4fQ9D6h9dkEfwhFFAZggEiBKiThy4QZmFY8zknXkyDtV/DtRHxSPKEgciO6xgZ+j29txwP5lg9FDfxNjet+QZZJQSIWFw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(366004)(376002)(396003)(136003)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(31686004)(2616005)(4326008)(8936002)(8676002)(6512007)(6506007)(53546011)(26005)(6486002)(966005)(478600001)(6666004)(110136005)(66476007)(54906003)(66946007)(66556008)(316002)(2906002)(41300700001)(36756003)(38100700002)(31696002)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SEY1ZWgyTCtKM24xZm5NSDN5UGR2Y1Q0bXdIbnBnZ2xNWmMxWVJYY0kxREZT?=
 =?utf-8?B?UTlVK1BSZlFWZ1hDODdON3pQU3hVSFQ5eTMvUjdSbXVjS1haSjFqbDVidW11?=
 =?utf-8?B?SkFNVTRXV0grdG85VGRHNVdLZzVqT2tVN0FKbjVZOVAzeFRhbCtld25FdStR?=
 =?utf-8?B?MFhFV3YvSFNHaGNnYWtnYmRuSEo5eUJmc05ES2xEL2RWWDZHQy9LK1N5L2kz?=
 =?utf-8?B?L3NhaXdoVmFHZXhwOVRPWkQzMzlqM2ZDeGFrcEZjU2gzZzNYQTM1c0Nncnd2?=
 =?utf-8?B?Y3JxZ290WXhDbFU5NnRUQnRheVNJdWlsUHlJczE1UmN6b08yY3l2WXc4bS9r?=
 =?utf-8?B?b3czeWpJRWlWL3p6MXAvcU9kTTlTMy8yYWwwdkFSU0xZWDMwL1ltTEF4RzBF?=
 =?utf-8?B?M25Sd2E1dnZrcWZtKzdydXQxeVYvUWM5UUUyS2pTcXB1YjVGSHBMNHRBWWpQ?=
 =?utf-8?B?dmROc1k1cnJZZ3BMSmpmdEhacmRFYjExZjMwNDZTQ0kvM1NxMVpNUUtEUU9G?=
 =?utf-8?B?alJTSDZNYWpJRmIrTlM2WnJEUEQwY1RQczVaS0U2anJENmVHa01yOTcxZVAx?=
 =?utf-8?B?VkNGQmZXY3NrL0NyV3oydC9hNEZ4dzlMUVgyN29aUzBoSVFBcGg2M3pDMnQ5?=
 =?utf-8?B?cE11L0ZHTk1EU1RIR2VJN0lWNnF2dGpHeHo0TTRqV0EvajgzYkl6YmpTNUpW?=
 =?utf-8?B?N0MyTDlOUndlZlZjTEJNUHRFdEQwODA5VDJNdzZNKy92d0Z0djJIaHVVclJD?=
 =?utf-8?B?RXl0U1ZUU1JtNlAzMlo1cEFaaXVoeFZscEdqM3NjMHZRTkFLVFlTcGdKL2Fs?=
 =?utf-8?B?cXZ1L3hsVjdMZU9TQlphcmthSGFucUwrSUlZZndqSXR2a2R0M3MwWDVTM3du?=
 =?utf-8?B?ajZwMTd5cFdOZ3JvY09yQTVETU1TMlFJQmlrVGYzUExUUWlISG0xSHEraDZh?=
 =?utf-8?B?eHRweHJmbkp4VSt2RHB1ejJpU0kxUHR6djFzTllGVU1LWDlwa2dibXpUQUYy?=
 =?utf-8?B?T29lYm5OdkhHcS85dHlnSHkrOGJhL2d5QmR4QmQxY3k1NVZMdWpndFlwRVFD?=
 =?utf-8?B?TUtPSnhMRHhBYnNPbWZRRUhXSDhmZUx6V2lWcGRYSFA0Z2hlZWNYNFF6eTRJ?=
 =?utf-8?B?NWNXSUJwdzF0T1hqVUIzV2s2enZpSnE3eDhoSzJFQ1UwSlVJL0QvQ2VSR1RH?=
 =?utf-8?B?bVNZTmRnWFlheUJML093K2hqTFhWY2Q2NmxPVEJSMTNQMndBb1oxTG9ab3hO?=
 =?utf-8?B?VHJvclJrNkkycjJhSW5kZ3NrZGF1eWl3VUhwaWxxNU5mLzJ3c01ucHN5Qi9B?=
 =?utf-8?B?MklJbmUyRG1oUUw3ZmhTZStOZnMxa0lUT2RINkx2RUptV3UrRnhjN210Qnl1?=
 =?utf-8?B?Z21tcTlJOWhWMVgxZ1R1aUNjOHZHdkxnRUR2V1hPL01WL05WMUlZVTJXLzVo?=
 =?utf-8?B?T0c5dEtHNTVhdW0yK2RVZk5zdzNmVHZSUVJENThoL2xUOHNZZ0EySGY1WlFn?=
 =?utf-8?B?dFFMRDI4b0xmR1drbG44NDNrdFVMZzNRQ0hzUmU4VXBqTzd0dWlnV3AweGZI?=
 =?utf-8?B?WHg1bDc1bmhCcFJXNlh6bGtkSGRvUUN2R3drRFVaK29ncmxTb1R1MEVxUkQ2?=
 =?utf-8?B?dEJtUElvbEIvY1ZtZDV2azNwenJEVUZmcWJDbUdiQjN5UjlEREo4L2NCU1ZU?=
 =?utf-8?B?S2JXdC9JUjVwUkJXbm8rbHMrQkh0QUdYc3pPV2h1enBGN25ML1pqN053VFJJ?=
 =?utf-8?B?WFN0Z2N5enVTUUxJbnp3N2NiRGxBdmduZTkxUGZCUStxOUVYM05oYWtZVjZG?=
 =?utf-8?B?YTVNTHd1c0h6UEJpcjRlMUtJNGJ2a1puSjhld2lKSk9FSm1UekJhUXhHRUlj?=
 =?utf-8?B?aFA1cFZ2OHduNEdxWnA3WmI1cDVTWmVweFdhTWhzSDZRd0xKNkwzM0RaUEVC?=
 =?utf-8?B?MmwrV2x6MnpXWFRlQkhZNGdyYzNyMkwvNFgwRWp6WkEvVXNtb1MrdnZ5VEhl?=
 =?utf-8?B?Z1M2bkFRdEhNcTExSGxUaXMwQS8rUEZRclltYm9uVmI5NHlMdTdmRys1ZnNS?=
 =?utf-8?B?SXlncVJhbWlCREpJTjFBT0JONEIzM09uaVVVS2trOHVNQk1uM3MvaUxXRmNZ?=
 =?utf-8?Q?Pl6K2A1RKKWqeXMYCWKuuqz/N?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a7abc35-bdf5-40f8-469d-08dbf41b33b5
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2023 16:16:27.5127
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bJA9fnNYDHj/SVRx1RjhhNCGycJ7NE+4HZkX33/fVW0ujZR+j4Q0RWlDBqlasx0/GhuDxEGbCoagZvVrNsGtbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7850


On 12/3/2023 2:08 PM, Greg KH wrote:
> On Sun, Dec 03, 2023 at 03:32:52AM -0500, Kris Karas (Bug Reporting) wrote:
>> Greg KH wrote:
>>> Thanks for testing, any chance you can try 6.6.4-rc1?  Or wait a few
>>> hours for me to release 6.6.4 if you don't want to mess with a -rc
>>> release.
>> As I mentioned to Greg off-list (to save wasting other peoples' bandwidth),
>> I couldn't find 6.6.4-rc1.  Looking in wrong git tree?  But 6.6.4 is now
>> out, which I have tested and am running at the moment, albeit with the
>> problem commit from 6.6.2 backed out.
>>
>> There is no change with respect to this bug.  The problematic patch
>> introduced in 6.6.2 was neither reverted nor amended.  The "opcode 0x0c03
>> failed" lines to the kernel log continue to be present.
>>
>>> Also, is this showing up in 6.7-rc3?  If so, that would be a big help in
>>> tracking this down.
>> The bug shows up in 6.7-rc3 as well, exactly as it does here in 6.6.2+ and
>> in 6.1.63+.  The problematic patch bisected earlier appears identically (and
>> seems to have been introduced simultaneously) in these recent releases.
> Ok, in a way, this is good as that means I haven't missed a fix, but bad
> in that this does affect everyone more.
>
> So let's start over, you found the offending commit, and nothing has
> fixed it, so what do we do?  xhci/amd developers, any ideas?

Can we enable RPM on specific controllers for AMD xHC 1.1
instead to cover all AMD xHC 1.1? 

Please find below the proposed changes and let me know if it is OK?
 
Author: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Date:   Sun Dec 3 18:28:27 2023 +0530

    xhci: Remove RPM as default policy to cover AMD xHC 1.1

    xHC 1.1 runtime PM as default policy causes issues on few AMD controllers.
    Hence remove RPM as default policy to cover AMD xHC 1.1 and add only
    AMD USB host controller (1022:43f7) which has RPM support. 

    Fixes: 4baf12181509 ("xhci: Loosen RPM as default policy to cover for AMD xHC 1.1")
    Link: https://lore.kernel.org/all/2023120329-length-strum-9ee1@gregkh
    Signed-off-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>

diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
index 95ed9404f6f8..7ffd6b8227cc 100644
--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -535,7 +535,7 @@ static void xhci_pci_quirks(struct device *dev, struct xhci_hcd *xhci)
        /* xHC spec requires PCI devices to support D3hot and D3cold */
        if (xhci->hci_version >= 0x120)
                xhci->quirks |= XHCI_DEFAULT_PM_RUNTIME_ALLOW;
-       else if (pdev->vendor == PCI_VENDOR_ID_AMD && xhci->hci_version >= 0x110)
+       else if (pdev->vendor == PCI_VENDOR_ID_AMD && pdev->vendor == 0x43f7)
                xhci->quirks |= XHCI_DEFAULT_PM_RUNTIME_ALLOW;

        if (xhci->quirks & XHCI_RESET_ON_RESUME)

Thanks,
--
Basavaraj

>
> thanks,
>
> greg k-h


