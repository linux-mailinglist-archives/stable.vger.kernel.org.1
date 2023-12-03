Return-Path: <stable+bounces-3793-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29BB0802566
	for <lists+stable@lfdr.de>; Sun,  3 Dec 2023 17:24:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91E0B280E42
	for <lists+stable@lfdr.de>; Sun,  3 Dec 2023 16:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8936B15AE9;
	Sun,  3 Dec 2023 16:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="M2DrlGCK"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2067.outbound.protection.outlook.com [40.107.220.67])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81D59A8;
	Sun,  3 Dec 2023 08:24:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UOrX1/sTd97elKMHbWkGPzeSZVKa8nF/6HPSq/FA/9Zdr0NGZ+rojhV0qlgBq2tgNP2MXdzd6Gw8cl8MDM5cEcblnzyT27s6C0TUYuHUwo6XqyROi+WDOge7238h9sL3mPNhJ9GoI/sj4CtK76+FxnsdXse4Qn5w9v/RcnPl7vEQxwll5ceOSlemrScpVpU0NHld2tdW7X7SBvbvCwTpy985a/2+b9CpPsg0Dygaq2gayMLEH0S12VTa9wvT+0HKOL/Ml78H0L+r2iHVzLjE/PZswYYR9ebOizYvC/dH5NtWsG531Dr6qfeVCfE4i0Ma6WXxgY0OENtFwzrbQTTrWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ln7OulHVbKZRD/ZM9dyadwbv/YmfGEJMLPSaOE3929A=;
 b=JiqsYgab6cDkwl7Wn+38ajAhELqTzAWc0GvV5DlAco1HW4SPnVjNG5Yblfd55UMTLOGrUbVHDMRBgF8ItEbNpZ+IKlS6ktYmK3h6TIPbvurG121AatGudwqmilovP9hWb4+y3qgMHgh/4E3U62DLkGspSkDzeqIWyI+p+TH4xvgu60H6xqQWszrCwMhLuwogDE/RZwMyTnk/rSeb8YwzrjRy7mws/dquUNQDgUUUmk8sidEYDId5FRn2r+nNDU9lVyXh2WgdXq7wx25dcNvcrLuIBjaXi8ita8tPFceKn0v1kmi5ofMYlRoDnIIPcharlYDeSt6P6klGEnlu/n06HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ln7OulHVbKZRD/ZM9dyadwbv/YmfGEJMLPSaOE3929A=;
 b=M2DrlGCKgX5ZK1LyGhE+PRqvAxsSx8u5j+TE13WIoLH6OmnthoskFBq5+4/ebVJ58PDM75O/HcMrU1ucxmbBxAXNGn7eddBuyOnt7fyU1DRs+l+nDkgyDk1criRItGXv5t+fBHY8frf++4gxKnIWt+7Xc5Vo5bIrNWb0LVx66Jo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by PH7PR12MB6395.namprd12.prod.outlook.com (2603:10b6:510:1fd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.28; Sun, 3 Dec
 2023 16:24:39 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::6f3c:cedb:bf1e:7504]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::6f3c:cedb:bf1e:7504%4]) with mapi id 15.20.7046.032; Sun, 3 Dec 2023
 16:24:38 +0000
Message-ID: <4c8072b9-637b-a871-4dc1-3031aa3712bd@amd.com>
Date: Sun, 3 Dec 2023 21:54:28 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: Regression: Inoperative bluetooth, Intel chipset, mainline kernel
 6.6.2+
Content-Language: en-US
From: Basavaraj Natikar <bnatikar@amd.com>
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
 <93b7d9ca-788a-53cd-efdb-6a61b583c550@amd.com>
In-Reply-To: <93b7d9ca-788a-53cd-efdb-6a61b583c550@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0012.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:95::21) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5040:EE_|PH7PR12MB6395:EE_
X-MS-Office365-Filtering-Correlation-Id: 82745e9c-d567-4cee-a175-08dbf41c585e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xpzmaMJz0ac8l/Xt8PGaroSwXio6JGwkNLW9NoXuIW5ty/1QkPgpmkYxkOoq4gktejdxRZ8xpBLTbfqzlmoSVcwfnZMmY9kVNi7DAgAX9sBHxQ1CR7quogjFa9i9+OJdS0ypz8ezcx0QfZK5nWMPxe8ElwnX7mexwSZyy90YgBw13f0vKn+nPID8+u5pEPwK9U0CRVi6omYmtFBiOl56gERxRosoPHiMMrC0EVl1UaeloV73MloWl9IwHHNqbqQD31xNmlHFJTPEaWOeNe47YpKa/EWi4XqvDSrRK/mHsMa82w7msuvqyHp7if0fklEwNP9mSjm+htNkeDsBMoKzfGWl5RZYH/cqENqktLZ41URDbDF1Gewer/zuJsoyKFnvs7FftJzmz/e1MBctn8wcz7iEx7MhlkcrsDHHeVrhoKiO5PRPOTe37xwluHGexmXAi4Sj3RcmtPyTJz8Qx15kONZXAP4/i2isors3OdZWCGPG5mn45JmoJ5vdrry/8FLwo8JGyfd1jfjX3FZdnjGE63JHbp8Bkq1nxVxD9RlNZOkNsuK1q7z6NPCwaELG3q/845jfUX1NGTfCRqL3JMbwxMRmuxFoFBB5WG/AIURD/+7tc/4Pw/UCA3ENLnf/84Cv+jc0pOD2kzx2GapIALC28Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(376002)(346002)(136003)(39860400002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(26005)(53546011)(6506007)(36756003)(6666004)(2616005)(5660300002)(66476007)(2906002)(66946007)(54906003)(110136005)(316002)(66556008)(31696002)(4326008)(8936002)(8676002)(31686004)(6512007)(38100700002)(478600001)(6486002)(41300700001)(966005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T2Fpbk50blRjd1lVZ2J4YzhHOUVuVGoweUErV0g2UDlHdVlick5HL1NCM0sv?=
 =?utf-8?B?bnJwaFdUazRmb2dRSzlNV3FmbDJwOU5nbHorY3pTMHdRay94anJSWjhwTms4?=
 =?utf-8?B?UDFaNDR5UndWK0QzQnlScFVTbmF2cGRCSk5rcHdhcFV0ZkY0cjZNVWZ4TFFv?=
 =?utf-8?B?OFRjZFAySmxkWFFWWTJleWh6VE52azdKS1FzRFBqWDZQWC83M1FpZjN6SE5C?=
 =?utf-8?B?bnBKTzVENXZaNmhaaDl1V1VmS3dhOEVUbmxLcWs4dG9wc3pSOFA3RWxkUDVJ?=
 =?utf-8?B?czV2cGEvQ1hNcklQNWZvRjZ0bWpsdnhndDN2L2pWaXVwZjNkaDkxTTZXa0t0?=
 =?utf-8?B?SFlxWVdlQlovNVNndVVCa3M4OEIrYllleXJmbEd1N2lWZW5UOFdhZjhaNGxl?=
 =?utf-8?B?TElLcGtPMFdwVmFrSHFRMjVHTzc3elUxVklQcnArQjU5YmdBN1lSZHVWMi8r?=
 =?utf-8?B?NU5WTmxYeThBOWo2eTVJVTBzTjFxbEVYeGtYdTZkOElXdloyL0lzVDF6bWsv?=
 =?utf-8?B?dG8vRHZKbzU5dm8vcURrSURPQnhxWFk3aEZQL2N4UXZ5UVg2TzYxbjRjWUli?=
 =?utf-8?B?ak5XRWJXeVZqOTVCQVlPU2ErS1N0MXcxaERwU0xkR2VNdGJmK2gzdTZQTVRx?=
 =?utf-8?B?SzdlZEp0YTJvdGtPR1lCcEk1OS9WWjFXaS9NYk5hekxBQnFLUXBnSklqTDJX?=
 =?utf-8?B?UHB5MmxmVXVyNkplUyt4aGRPaFpmLzdUVjM1RExBbCtVUDhobHorWjlVRmlu?=
 =?utf-8?B?WXNyQndyemlsY1hJVnFDUFVTWTVFVzU2bnJBVnZiYkhoWDNUM0g3TkVlaU1k?=
 =?utf-8?B?cVNDV0lQdWFJdFFhT25WenNOVDB5SXltVlFtWng1amlNeDVzcXRDNmtJZHdM?=
 =?utf-8?B?NVhqaUQvWCtXOTc2VS82S2JDdGlHMlNob2kwUjdXZmtQZUROaVQzYnlvSlEr?=
 =?utf-8?B?UEtsRlRTRnluK0N2bkc1ekFSYjNwc01vNUg2RDN5UmpBNVZCSkdyMUp5QnpG?=
 =?utf-8?B?NjRrZ09vVW0zYXIxc0gwR2R4ZkNkMGZraWdQa2diL3RtV2hrdFdMWHFKcTFG?=
 =?utf-8?B?WlVpN0RvalV5YVhKS3lwZGo3eUFhVG1uMld2ajRnSy9ON2p0TTVDL0FVSmJF?=
 =?utf-8?B?azdkY3hXaW9DQXpldTl6anljNit3Y1MwOGhYYURrZmNUR2o2L1lkWWZjMFo1?=
 =?utf-8?B?TGxSZHNaVXphVTFBMnNteXBzNnh2aTRpTEF4NDAwV2xpbXJJR0pqZ0dFL0Yz?=
 =?utf-8?B?a2wyNXNUbnh5Q1JVVDFkajIzUEFiRXF0d2daOWVxQVV4d1dUZHY5N1h2NjRa?=
 =?utf-8?B?TjJ3MHBhQS9JR1owMXVhemdubEo2RkNORFdBTUxKVXBPcmswMHg4ZEhTSDJI?=
 =?utf-8?B?dU1KZkhJZXNsSHlONi9IaXRiUlBYK28zUXVKNFpWL281M09Wd3poOGJ0R3ZQ?=
 =?utf-8?B?NG53QTY3T1IwRHI2WXZZQVFqc2xnemc2Wk85NVFKdS96Q0JVblQveldjZWI2?=
 =?utf-8?B?SUc2Q3diYTJCa1c4NkpOOHYyMnVkYkxOUEQ1Vm0ySk5PVkRHMVA4NWUvWEly?=
 =?utf-8?B?Q0c3eS82SWVsY2xnSUltKzNlMnFWZzJxM0t6K1JYcmpQTGszODNTeVJkK1VK?=
 =?utf-8?B?N2FzaGRreUQrWXluTTZMTUE0TGxpWWNCU05CMnBEdFNwbXdIZG5EbHF4VDVJ?=
 =?utf-8?B?eWxYUXJKUnRQelRLOTJ3d0hSYmVsb3U1U3c1K0IzNmlMKzNlK2Y1QTJVR0Ux?=
 =?utf-8?B?Y24wcW94Tk9HSHZ1bEF6VlRuMGF5V0dPQU0xRXUvK212RmplWXFVMzQvcUli?=
 =?utf-8?B?Z3dyL2cyanZwS3FXajJFQUhpYktuUS9NSEpmcHdtWGt2SWI1T0wvOGpVc3lT?=
 =?utf-8?B?RmhWaUVkUXVWSkVVSDkwYUJTcWEyb3pHNUs2TmNXZ0xIRUJNSS9iMEp2aDc3?=
 =?utf-8?B?U2tpc2FCNHRRZTVuQ3JMd3RjME9mQ2lQUko0RVhNMFpNZGdCZXJNSTg0UjNN?=
 =?utf-8?B?MFVLcUtFbm1SMjJVajN3WFFZWFNrbFh0R0JwY2VhQXRxWGFvMEJaY2VZQklU?=
 =?utf-8?B?M0ZIT2Z4endHYldsRmQzU01QRXhXY0YxVEwyRzJ1MGtqTXpGeUxodXVGOHVD?=
 =?utf-8?Q?wOhXak502f66qyFFo3hGJXa20?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82745e9c-d567-4cee-a175-08dbf41c585e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2023 16:24:38.5062
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3OJSWimOrn+6OzdNu7QxBD9gUdIl6MutsRzo9AnRZq1q0+Z77aCnZ8r4i0JGfzBf7ZRU6HG5NWzPT09ZJrY5tg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6395


On 12/3/2023 9:46 PM, Basavaraj Natikar wrote:
> On 12/3/2023 2:08 PM, Greg KH wrote:
>> On Sun, Dec 03, 2023 at 03:32:52AM -0500, Kris Karas (Bug Reporting) wrote:
>>> Greg KH wrote:
>>>> Thanks for testing, any chance you can try 6.6.4-rc1?  Or wait a few
>>>> hours for me to release 6.6.4 if you don't want to mess with a -rc
>>>> release.
>>> As I mentioned to Greg off-list (to save wasting other peoples' bandwidth),
>>> I couldn't find 6.6.4-rc1.  Looking in wrong git tree?  But 6.6.4 is now
>>> out, which I have tested and am running at the moment, albeit with the
>>> problem commit from 6.6.2 backed out.
>>>
>>> There is no change with respect to this bug.  The problematic patch
>>> introduced in 6.6.2 was neither reverted nor amended.  The "opcode 0x0c03
>>> failed" lines to the kernel log continue to be present.
>>>
>>>> Also, is this showing up in 6.7-rc3?  If so, that would be a big help in
>>>> tracking this down.
>>> The bug shows up in 6.7-rc3 as well, exactly as it does here in 6.6.2+ and
>>> in 6.1.63+.  The problematic patch bisected earlier appears identically (and
>>> seems to have been introduced simultaneously) in these recent releases.
>> Ok, in a way, this is good as that means I haven't missed a fix, but bad
>> in that this does affect everyone more.
>>
>> So let's start over, you found the offending commit, and nothing has
>> fixed it, so what do we do?  xhci/amd developers, any ideas?
> Can we enable RPM on specific controllers for AMD xHC 1.1
> instead to cover all AMD xHC 1.1? 
>
> Please find below the proposed changes and let me know if it is OK?
>  
> Author: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
> Date:   Sun Dec 3 18:28:27 2023 +0530
>
>     xhci: Remove RPM as default policy to cover AMD xHC 1.1
>
>     xHC 1.1 runtime PM as default policy causes issues on few AMD controllers.
>     Hence remove RPM as default policy to cover AMD xHC 1.1 and add only
>     AMD USB host controller (1022:43f7) which has RPM support. 
>
>     Fixes: 4baf12181509 ("xhci: Loosen RPM as default policy to cover for AMD xHC 1.1")
>     Link: https://lore.kernel.org/all/2023120329-length-strum-9ee1@gregkh
>     Signed-off-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
>
> diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
> index 95ed9404f6f8..7ffd6b8227cc 100644
> --- a/drivers/usb/host/xhci-pci.c
> +++ b/drivers/usb/host/xhci-pci.c
> @@ -535,7 +535,7 @@ static void xhci_pci_quirks(struct device *dev, struct xhci_hcd *xhci)
>         /* xHC spec requires PCI devices to support D3hot and D3cold */
>         if (xhci->hci_version >= 0x120)
>                 xhci->quirks |= XHCI_DEFAULT_PM_RUNTIME_ALLOW;
> -       else if (pdev->vendor == PCI_VENDOR_ID_AMD && xhci->hci_version >= 0x110)
> +       else if (pdev->vendor == PCI_VENDOR_ID_AMD && pdev->vendor == 0x43f7)

sorry its 
pdev->device == 0x43f7

Incorrect ---> else if (pdev->vendor == PCI_VENDOR_ID_AMD && pdev->vendor == 0x43f7)
correct line --> else if (pdev->vendor == PCI_VENDOR_ID_AMD && pdev->device == 0x43f7)

>                 xhci->quirks |= XHCI_DEFAULT_PM_RUNTIME_ALLOW;
>
>         if (xhci->quirks & XHCI_RESET_ON_RESUME)
>
> Thanks,
> --
> Basavaraj
>
>> thanks,
>>
>> greg k-h


