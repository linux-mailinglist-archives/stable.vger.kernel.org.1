Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB79B7AAD9A
	for <lists+stable@lfdr.de>; Fri, 22 Sep 2023 11:16:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbjIVJQg (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 22 Sep 2023 05:16:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231753AbjIVJQf (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 22 Sep 2023 05:16:35 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2067.outbound.protection.outlook.com [40.107.220.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E5CC199
        for <stable@vger.kernel.org>; Fri, 22 Sep 2023 02:16:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L8ercCJVW6wjSjVa13SW8X7hUVga5Swbtm4dDH06hLaSj3cbPmapiHy9vpe8D4tXALB7ZyIdoBCyTdOy9ZiG1uwIV0GitOs8U6o6zznLBmqjpHzIF5mPauQjlQzQNga5XJXcOnrotr15xZtJ6VLRQTcgEijv7ZcR1L+3iomsnLIHQkt+qfVM6DQAXJJJa/WvYY74pD/CvW8TrvNirfBHba5b8N9IK+f9hkIDZaBx4O5OHQvtfYMsZPLYMMRQezP92qy23g/4siX8Et1TKc4V9RRQC6pA3C2e+BQ9P24/FplHl7H3nndvFWdbOBGQCQBUyUBAGETEK9oDqBjT5mtmSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4uNabt7+znbaJox2oAB9kCM3q8M84d3+j2nolEy2pfg=;
 b=ZWMor7QiGMbjRB+PuAGbV+QYQQkLJRTc2o9aNJTuxhHa4RQqztTeXPxmjJQuXOa2vu/sWHj8KRexG/t+M22aLkMBEt/dglaw3+VWeL+gzyw88D0sWL8ZC/nPEkP5aAsHtdYguAKbOGW0dAbdS4wnz9rl+kH8Qs//CuskfgYKKzvjoKUNF10jxDCFfGvwBcpoiXYaw5CBlakm7EfbnBo93zUvOeC/TmZyHArSHPDLXPRhQupJZmydQctmQQi8snJ1TGYPPQrgBvmD5rHL+GNqRwbtP6vnqK9gsy4fvC6MoBgFIHjrQNkHWcUevr2Dh8WlB6a3k6xVjXj5gx/s1Ty9AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=bootlin.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4uNabt7+znbaJox2oAB9kCM3q8M84d3+j2nolEy2pfg=;
 b=luGmMUj2DnjaGT247sQ2ZkY3gVxeId5al8QJflpJGdQCUM9Rq9Pu6brMvfcyeTjkV/eWuw7RfcAymekhgcOhC32cj71y7mVEcqigtdC955cVlMrHxkwdu4/QbPNnf7noUyZwTjypyn+xcvqe2n1W/OojH5kdZF4P4kdb5zHRAEc=
Received: from MN2PR01CA0031.prod.exchangelabs.com (2603:10b6:208:10c::44) by
 IA1PR12MB8358.namprd12.prod.outlook.com (2603:10b6:208:3fa::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.23; Fri, 22 Sep
 2023 09:16:25 +0000
Received: from BL02EPF0001A0FE.namprd03.prod.outlook.com
 (2603:10b6:208:10c:cafe::de) by MN2PR01CA0031.outlook.office365.com
 (2603:10b6:208:10c::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.31 via Frontend
 Transport; Fri, 22 Sep 2023 09:16:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0FE.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.19 via Frontend Transport; Fri, 22 Sep 2023 09:16:25 +0000
Received: from [192.168.137.2] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 22 Sep
 2023 04:16:23 -0500
Message-ID: <cfc032b5-dfa4-485f-a2f1-5085964f6697@amd.com>
Date:   Fri, 22 Sep 2023 11:16:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] mtd: rawnand: arasan: Ensure program page operations
 are successful
Content-Language: en-US
To:     Miquel Raynal <miquel.raynal@bootlin.com>
CC:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <tudor.ambarus@linaro.org>,
        Pratyush Yadav <pratyush@kernel.org>,
        Michael Walle <michael@walle.cc>,
        <linux-mtd@lists.infradead.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        <stable@vger.kernel.org>
References: <20230717194221.229778-1-miquel.raynal@bootlin.com>
 <20230717194221.229778-2-miquel.raynal@bootlin.com>
 <20230911175247.44c1d894@xps-13>
 <cf1a0b96-0f1e-4a6d-960b-93185faf27ba@amd.com>
 <20230912161752.581019bc@xps-13>
 <ead8ac00-cc2d-4258-aac1-af5eed93de7b@amd.com>
 <20230922111437.57804995@xps-13>
From:   Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 xsFNBFFuvDEBEAC9Amu3nk79+J+4xBOuM5XmDmljuukOc6mKB5bBYOa4SrWJZTjeGRf52VMc
 howHe8Y9nSbG92obZMqsdt+d/hmRu3fgwRYiiU97YJjUkCN5paHXyBb+3IdrLNGt8I7C9RMy
 svSoH4WcApYNqvB3rcMtJIna+HUhx8xOk+XCfyKJDnrSuKgx0Svj446qgM5fe7RyFOlGX/wF
 Ae63Hs0RkFo3I/+hLLJP6kwPnOEo3lkvzm3FMMy0D9VxT9e6Y3afe1UTQuhkg8PbABxhowzj
 SEnl0ICoqpBqqROV/w1fOlPrm4WSNlZJunYV4gTEustZf8j9FWncn3QzRhnQOSuzTPFbsbH5
 WVxwDvgHLRTmBuMw1sqvCc7CofjsD1XM9bP3HOBwCxKaTyOxbPJh3D4AdD1u+cF/lj9Fj255
 Es9aATHPvoDQmOzyyRNTQzupN8UtZ+/tB4mhgxWzorpbdItaSXWgdDPDtssJIC+d5+hskys8
 B3jbv86lyM+4jh2URpnL1gqOPwnaf1zm/7sqoN3r64cml94q68jfY4lNTwjA/SnaS1DE9XXa
 XQlkhHgjSLyRjjsMsz+2A4otRLrBbumEUtSMlPfhTi8xUsj9ZfPIUz3fji8vmxZG/Da6jx/c
 a0UQdFFCL4Ay/EMSoGbQouzhC69OQLWNH3rMQbBvrRbiMJbEZwARAQABzSlNaWNoYWwgU2lt
 ZWsgKEFNRCkgPG1pY2hhbC5zaW1la0BhbWQuY29tPsLBlAQTAQgAPgIbAwULCQgHAgYVCgkI
 CwIEFgIDAQIeAQIXgBYhBGc1DJv1zO6bU2Q1ajd8fyH+PR+RBQJkK9VOBQkWf4AXAAoJEDd8
 fyH+PR+ROzEP/1IFM7J4Y58SKuvdWDddIvc7JXcal5DpUtMdpuV+ZiHSOgBQRqvwH4CVBK7p
 ktDCWQAoWCg0KhdGyBjfyVVpm+Gw4DkZovcvMGUlvY5p5w8XxTE5Xx+cj/iDnj83+gy+0Oyz
 VFU9pew9rnT5YjSRFNOmL2dsorxoT1DWuasDUyitGy9iBegj7vtyAsvEObbGiFcKYSjvurkm
 MaJ/AwuJehZouKVfWPY/i4UNsDVbQP6iwO8jgPy3pwjt4ztZrl3qs1gV1F4Zrak1k6qoDP5h
 19Q5XBVtq4VSS4uLKjofVxrw0J+sHHeTNa3Qgk9nXJEvH2s2JpX82an7U6ccJSdNLYbogQAS
 BW60bxq6hWEY/afbT+tepEsXepa0y04NjFccFsbECQ4DA3cdA34sFGupUy5h5la/eEf3/8Kd
 BYcDd+aoxWliMVmL3DudM0Fuj9Hqt7JJAaA0Kt3pwJYwzecl/noK7kFhWiKcJULXEbi3Yf/Y
 pwCf691kBfrbbP9uDmgm4ZbWIT5WUptt3ziYOWx9SSvaZP5MExlXF4z+/KfZAeJBpZ95Gwm+
 FD8WKYjJChMtTfd1VjC4oyFLDUMTvYq77ABkPeKB/WmiAoqMbGx+xQWxW113wZikDy+6WoCS
 MPXfgMPWpkIUnvTIpF+m1Nyerqf71fiA1W8l0oFmtCF5oTMkzsFNBFFuvDEBEACXqiX5h4IA
 03fJOwh+82aQWeHVAEDpjDzK5hSSJZDE55KP8br1FZrgrjvQ9Ma7thSu1mbr+ydeIqoO1/iM
 fZA+DDPpvo6kscjep11bNhVa0JpHhwnMfHNTSHDMq9OXL9ZZpku/+OXtapISzIH336p4ZUUB
 5asad8Ux70g4gmI92eLWBzFFdlyR4g1Vis511Nn481lsDO9LZhKyWelbif7FKKv4p3FRPSbB
 vEgh71V3NDCPlJJoiHiYaS8IN3uasV/S1+cxVbwz2WcUEZCpeHcY2qsQAEqp4GM7PF2G6gtz
 IOBUMk7fjku1mzlx4zP7uj87LGJTOAxQUJ1HHlx3Li+xu2oF9Vv101/fsCmptAAUMo7KiJgP
 Lu8TsP1migoOoSbGUMR0jQpUcKF2L2jaNVS6updvNjbRmFojK2y6A/Bc6WAKhtdv8/e0/Zby
 iVA7/EN5phZ1GugMJxOLHJ1eqw7DQ5CHcSQ5bOx0Yjmhg4PT6pbW3mB1w+ClAnxhAbyMsfBn
 XxvvcjWIPnBVlB2Z0YH/gizMDdM0Sa/HIz+q7JR7XkGL4MYeAM15m6O7hkCJcoFV7LMzkNKk
 OiCZ3E0JYDsMXvmh3S4EVWAG+buA+9beElCmXDcXPI4PinMPqpwmLNcEhPVMQfvAYRqQp2fg
 1vTEyK58Ms+0a9L1k5MvvbFg9QARAQABwsF8BBgBCAAmAhsMFiEEZzUMm/XM7ptTZDVqN3x/
 If49H5EFAmQr1YsFCRZ/gFoACgkQN3x/If49H5H6BQ//TqDpfCh7Fa5v227mDISwU1VgOPFK
 eo/+4fF/KNtAtU/VYmBrwT/N6clBxjJYY1i60ekFfAEsCb+vAr1W9geYYpuA+lgR3/BOkHlJ
 eHf4Ez3D71GnqROIXsObFSFfZWGEgBtHBZ694hKwFmIVCg+lqeMV9nPQKlvfx2n+/lDkspGi
 epDwFUdfJLHOYxFZMQsFtKJX4fBiY85/U4X2xSp02DxQZj/N2lc9OFrKmFJHXJi9vQCkJdIj
 S6nuJlvWj/MZKud5QhlfZQsixT9wCeOa6Vgcd4vCzZuptx8gY9FDgb27RQxh/b1ZHalO1h3z
 kXyouA6Kf54Tv6ab7M/fhNqznnmSvWvQ4EWeh8gddpzHKk8ixw9INBWkGXzqSPOztlJbFiQ3
 YPi6o9Pw/IxdQJ9UZ8eCjvIMpXb4q9cZpRLT/BkD4ttpNxma1CUVljkF4DuGydxbQNvJFBK8
 ywyA0qgv+Mu+4r/Z2iQzoOgE1SymrNSDyC7u0RzmSnyqaQnZ3uj7OzRkq0fMmMbbrIvQYDS/
 y7RkYPOpmElF2pwWI/SXKOgMUgigedGCl1QRUio7iifBmXHkRrTgNT0PWQmeGsWTmfRit2+i
 l2dpB2lxha72cQ6MTEmL65HaoeANhtfO1se2R9dej57g+urO9V2v/UglZG1wsyaP/vOrgs+3
 3i3l5DA=
In-Reply-To: <20230922111437.57804995@xps-13>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FE:EE_|IA1PR12MB8358:EE_
X-MS-Office365-Filtering-Correlation-Id: 87fcace1-1bec-423a-7a68-08dbbb4c9858
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nbY+dBbgo/JJXX6sHSC4UrSST1a2+xk8yvg1g+chnY8UlX5Q0rjddJ92fqUlzQ/HXy6B3WjJs/89eU+lA38L/2zGLaYkd4kh0oG2fyTxEpyJGjUkqRhkbEDiHqjbanBFVQ7E3yMhbt0Y+N/FkNr5C/yNpfGoBOVTuGwLzJ+WRH0wBzBwUeL+UyxLqrqt7NYGD5XPgM8rqAoc4wojz5yKy7xPnsoA1S9tZCOw/8gXdALIdxLDWbab9sLqvJEUJXTmOYcoEur5NfYcoEvtOXXqdOhUo6tEjmebzzb6pocC9AOkUhiTQLL2S4ZSFgxhJ5FKUv60cTS9pySni2BnAJ0kVqfAUGqnx2KqncB+e4jP6qqsLAyt9uYNNXM0ZPgIVc6yvmD0vuupygZ2sBXjzLgG+Sqjt0lucKRs19gV9Xvp4ZR2giqs70VVyyCxOGlmG/Pq13unNO6Y/EuvlS2kVcY2XkAWf4wxnrvofLoeTOaMk79ZXMplrU5VC1Mt3tMQTQnshUpXh4/c1WfMYyDgv/GrnzxITIg/AqEgS5SAWp0nsF3MrY/UGRmYbNLw4B7LLOfcDjExxsWB6wZRfPblg0T6IZv90UYcfQ9RKCAbPv71ALyXbuF+9sci743As453dK+MQ0iSfHO2756u1GQTTSpwdWjHYOrIf4CF/8EQIqBn/k+SKMGQ7cdsAtWqKlhJjNoaiBigtwd1nAdm8PMm+GGp5tblmK2Csg/SvFlWW8jHLqTK8/UtEpXRohmI985vM2y+7eaJ4sptzxgzl1U6D/nuEN26eteNGZ9XXjmPPCB2dHRf+s4pX1L0pkD+DwRoCjxbTO2cPbGBOJzD3QCwr0fqLg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(39860400002)(136003)(376002)(396003)(230921699003)(82310400011)(1800799009)(451199024)(186009)(36840700001)(46966006)(40470700004)(8676002)(31696002)(8936002)(44832011)(31686004)(4326008)(5660300002)(54906003)(70206006)(70586007)(36860700001)(6916009)(316002)(16576012)(41300700001)(36756003)(2906002)(47076005)(83380400001)(86362001)(478600001)(426003)(336012)(26005)(16526019)(356005)(2616005)(81166007)(40460700003)(40480700001)(53546011)(82740400003)(66899024)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2023 09:16:25.0432
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 87fcace1-1bec-423a-7a68-08dbbb4c9858
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8358
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org



On 9/22/23 11:14, Miquel Raynal wrote:
> Hi Michal,
> 
> michal.simek@amd.com wrote on Thu, 21 Sep 2023 12:25:10 +0200:
> 
>> On 9/12/23 16:17, Miquel Raynal wrote:
>>> Hi Michal,
>>>
>>> michal.simek@amd.com wrote on Tue, 12 Sep 2023 15:55:23 +0200:
>>>    
>>>> Hi Miquel,
>>>>
>>>> On 9/11/23 17:52, Miquel Raynal wrote:
>>>>> Hi Michal,
>>>>>
>>>>> miquel.raynal@bootlin.com wrote on Mon, 17 Jul 2023 21:42:20 +0200:
>>>>>     >>>> The NAND core complies with the ONFI specification, which itself
>>>>>> mentions that after any program or erase operation, a status check
>>>>>> should be performed to see whether the operation was finished *and*
>>>>>> successful.
>>>>>>
>>>>>> The NAND core offers helpers to finish a page write (sending the
>>>>>> "PAGE PROG" command, waiting for the NAND chip to be ready again, and
>>>>>> checking the operation status). But in some cases, advanced controller
>>>>>> drivers might want to optimize this and craft their own page write
>>>>>> helper to leverage additional hardware capabilities, thus not always
>>>>>> using the core facilities.
>>>>>>
>>>>>> Some drivers, like this one, do not use the core helper to finish a page
>>>>>> write because the final cycles are automatically managed by the
>>>>>> hardware. In this case, the additional care must be taken to manually
>>>>>> perform the final status check.
>>>>>>
>>>>>> Let's read the NAND chip status at the end of the page write helper and
>>>>>> return -EIO upon error.
>>>>>>
>>>>>> Cc: Michal Simek <michal.simek@amd.com>
>>>>>> Cc: stable@vger.kernel.org
>>>>>> Fixes: 88ffef1b65cf ("mtd: rawnand: arasan: Support the hardware BCH ECC engine")
>>>>>> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
>>>>>>
>>>>>> ---
>>>>>>
>>>>>> Hello Michal,
>>>>>>
>>>>>> I have not tested this, but based on a report on another driver, I
>>>>>> believe the status check is also missing here and could sometimes
>>>>>> lead to unnoticed partial writes.
>>>>>>
>>>>>> Please test on your side that everything still works and let me
>>>>>> know how it goes.
>>>>>
>>>>> Any news from the testing team about patches 2/3 and 3/3?
>>>>
>>>> I asked Amit to test and he didn't get back to me even I asked for it couple of times.
>>>
>>> Ok.
>>>    
>>>> Can you please tell me how to test it? I will setup HW myself and test it and get back to you.
>>>
>>> I believe setting up the board to use the hardware BCH engine and
>>> performing basic erase/write/read testing with a known file and check
>>> it still behaves correctly would work. You can also run
>>>
>>> 	nandbiterrs -i /dev/mtdx
>>>
>>> as a second step and verify there is no difference with and without the
>>> patch and finally check the impact:
>>>
>>> 	flash_speed -d -c 10 /dev/mtdx
>>> 	(be careful: this is a destructive operation)
>>
>> Testing team won't see any issue that's why feel free to add my
>> Acked-by: Michal Smek <michal.simek@amd.com>
> 
> I think you told me in the last e-mail you tested the pl353 patch, not
> the one for the Arasan controller. Shall I add your Acked-by here and
> your Tested-by in the other?

Yes exactly.
I tested pl353 myself. If that log looks good feel free to add my Tested-by tag.
And I got information from testing team that they tested Arasan one hence only 
Ack one.

Thanks,
Michal

