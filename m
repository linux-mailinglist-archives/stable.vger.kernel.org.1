Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2572E7A74F2
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 09:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232190AbjITHzV (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 03:55:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232038AbjITHzU (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 03:55:20 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2066.outbound.protection.outlook.com [40.107.102.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 592B2AB
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 00:55:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a390mP6KM+J7J4EXjse22CSveINeBF6Dm4/XNyDBh7dF9lRzXRIa2DCzP5jsuo0VTSEZ+KJGjCVqaGQhyoJThDVOiFEvDA3Simr6LZR0wK1ktXPfOR0nHx5qy0xgZCJZDUZkoqP5MKNX6X5LmM8oVRg9jsVniIY+ptt4qf480gjWKWoZZ28tVzor/o9zKON4GV2R3UwzvBavLLJucOVeq/6H9AMIY3Y/iQKHfPi9gs95lYqnuhVWYX5QXM8z48Oi4bhlIhOH3ZR6p5Lumk6yn1T3jNWfGDJ8Gg6icL8/JZi6Em2l5aYI8daMnBlbCZLDVJ9Lnk9IwcEJHobbZQPe0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5l+FNtEGOnm1jQv7ANV4mE3MijUbOa97DfAH+2PHkZM=;
 b=SzzBDyLQIq/uPIABc+/kxOeloiGponZepyEvt8TqRcGRk9BlS1Hhnl0gMUt2/2X3UoZTYn1puwRHexc6MlsLOP9APolwNEZdHrMpWhzm/L1btbPNwbG4BU2teopDnUfI2uAOCKGY2hdjIFJFHOBfItrrSFTYl0nZosvp876y62Be/0AVrswvB83+xwSZDjuXehk9SCGmbrh92wLELVBPTYFzVbs2sJWX1ja2ZcKqGmIHh4YgDdn8PZuEiJGBKxWcQOb9PJGQxfo1rZu7zSb95s1+8bsxvbG+8ZuiewJR5Vx+LaN/TWkDcYaTOmUPqsmZqBL1cGbkM9h0bhEhIllYNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=bootlin.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5l+FNtEGOnm1jQv7ANV4mE3MijUbOa97DfAH+2PHkZM=;
 b=XYi6tDvPIrWTrw+DD3sMBGyskL76U+2imvzn9HWT1ixKFyCo4eleB/sqQPv7mctvFkw4Q9HyQb3cYgbtzpKOHiSXLSN922O9VLLFJ31vDQhl3frb3SHA8xe8i/4iWtgd5BhpNUiK9u9o6gYAfgFflZHRcFHXXOQzvOdUi7S8wEk=
Received: from DM6PR11CA0023.namprd11.prod.outlook.com (2603:10b6:5:190::36)
 by BL3PR12MB6524.namprd12.prod.outlook.com (2603:10b6:208:38c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Wed, 20 Sep
 2023 07:55:09 +0000
Received: from DS1PEPF0001709B.namprd05.prod.outlook.com
 (2603:10b6:5:190:cafe::51) by DM6PR11CA0023.outlook.office365.com
 (2603:10b6:5:190::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.29 via Frontend
 Transport; Wed, 20 Sep 2023 07:55:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001709B.mail.protection.outlook.com (10.167.18.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Wed, 20 Sep 2023 07:55:09 +0000
Received: from [192.168.137.2] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 20 Sep
 2023 02:55:06 -0500
Message-ID: <d8404c2a-7683-44f8-aee3-fb94d3ef45f3@amd.com>
Date:   Wed, 20 Sep 2023 09:55:04 +0200
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
From:   Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20230912161752.581019bc@xps-13>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709B:EE_|BL3PR12MB6524:EE_
X-MS-Office365-Filtering-Correlation-Id: 89bbcfa1-10a7-4691-f08c-08dbb9aee952
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v/QBmniiqfICh/XHJq2jXqJS05lLjDdj5OUttYtTzcdX0WTwv6vlHO60k736Ztie8WyTa50JgcRVxC4+cBowNOMNQhy7kLe+xtcUx7KF6PIx3uRu++xa5xXuYgraKUS2ibz5xF3ur10uHowJComFDtavIBvtn2CD/kEHLCPF/nHOovTnHhyAQrqnU5SQmViTT+5uNmkLrNruJEFiyWI8zxNNzJMDLVwdq3dyvQgiOzd3DyyF44lmn9i3IGr6ndaZ8FRUlYqER10DRAZZubgHLLpaCfoYKPFDJRamrSIL3Ia0qQxGh7na2ktgeoDhy1aXzR7IaE8Ynyr5Wu02hrgiRcHbEjQfeRLFvo61icErxwpJ2xXw0Kxi7/0NOWeg2HXJ+z/ICpznnnTtjvwOd8Di5DtO36ai3jmiOUhnHECqZyPfaDhh8RGkNJry9CdcxnwaqKHnvyHp+zgaop4Z8h2wPtg+RCrG0vI1+cl3iiliZxqZbHfXiNoXl1nPISnf18hqsL10KnwLYRn+XtaR6kcuvnM71+Bi0JUTV5ZIQXOUQczVLeou1xtbO4fObDdEKLQ6RN038jX/QqkpaNBO+wfDLovVw9sSG5wCyI8TXiTHzYSZXUjcz/+PgmxRpuYeYM7auMeS6ghXSzdWRHnlM8WNRUTKyLPzbQz2WRjzlLX1nuIuPb4g1qraIz9f9LNzN2EndPofFPzCWUBEmIi9sfZ7Yh0qBliClVMw/ImlZ1hXhThanR3FRbEoW7ELh6f5PjHZ3qtxafbj/Jpgt63X8qEhQiRaw0TJSzKVdRw8CPxinVCJ+rSlNKh/N/IJ2Gpi/Gb7
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(346002)(376002)(396003)(136003)(451199024)(186009)(82310400011)(1800799009)(46966006)(40470700004)(36840700001)(478600001)(41300700001)(40480700001)(83380400001)(44832011)(5660300002)(2906002)(70206006)(316002)(70586007)(16576012)(54906003)(6916009)(8936002)(8676002)(4326008)(31686004)(53546011)(66899024)(2616005)(40460700003)(26005)(16526019)(426003)(336012)(47076005)(36860700001)(36756003)(356005)(81166007)(31696002)(86362001)(82740400003)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2023 07:55:09.1782
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 89bbcfa1-10a7-4691-f08c-08dbb9aee952
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001709B.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6524
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi Miquel,

On 9/12/23 16:17, Miquel Raynal wrote:
> Hi Michal,
> 
> michal.simek@amd.com wrote on Tue, 12 Sep 2023 15:55:23 +0200:
> 
>> Hi Miquel,
>>
>> On 9/11/23 17:52, Miquel Raynal wrote:
>>> Hi Michal,
>>>
>>> miquel.raynal@bootlin.com wrote on Mon, 17 Jul 2023 21:42:20 +0200:
>>>    
>>>> The NAND core complies with the ONFI specification, which itself
>>>> mentions that after any program or erase operation, a status check
>>>> should be performed to see whether the operation was finished *and*
>>>> successful.
>>>>
>>>> The NAND core offers helpers to finish a page write (sending the
>>>> "PAGE PROG" command, waiting for the NAND chip to be ready again, and
>>>> checking the operation status). But in some cases, advanced controller
>>>> drivers might want to optimize this and craft their own page write
>>>> helper to leverage additional hardware capabilities, thus not always
>>>> using the core facilities.
>>>>
>>>> Some drivers, like this one, do not use the core helper to finish a page
>>>> write because the final cycles are automatically managed by the
>>>> hardware. In this case, the additional care must be taken to manually
>>>> perform the final status check.
>>>>
>>>> Let's read the NAND chip status at the end of the page write helper and
>>>> return -EIO upon error.
>>>>
>>>> Cc: Michal Simek <michal.simek@amd.com>
>>>> Cc: stable@vger.kernel.org
>>>> Fixes: 88ffef1b65cf ("mtd: rawnand: arasan: Support the hardware BCH ECC engine")
>>>> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
>>>>
>>>> ---
>>>>
>>>> Hello Michal,
>>>>
>>>> I have not tested this, but based on a report on another driver, I
>>>> believe the status check is also missing here and could sometimes
>>>> lead to unnoticed partial writes.
>>>>
>>>> Please test on your side that everything still works and let me
>>>> know how it goes.
>>>
>>> Any news from the testing team about patches 2/3 and 3/3?
>>
>> I asked Amit to test and he didn't get back to me even I asked for it couple of times.
> 
> Ok.
> 
>> Can you please tell me how to test it? I will setup HW myself and test it and get back to you.
> 
> I believe setting up the board to use the hardware BCH engine and
> performing basic erase/write/read testing with a known file and check
> it still behaves correctly would work. You can also run
> 
> 	nandbiterrs -i /dev/mtdx
> 
> as a second step and verify there is no difference with and without the
> patch and finally check the impact:
> 
> 	flash_speed -d -c 10 /dev/mtdx
> 	(be careful: this is a destructive operation)

I run this myself.

pl353 test log before the patch.

# cat /proc/mtd
dev:    size   erasesize  name
mtd0: 10000000 00020000 "pl35x-nand-controller"
# nandbiterrs -i /dev/mtd0
incremental biterrors test
Successfully corrected 0 bit errors per subpage
Inserted biterror @ 0/5
Read reported 1 corrected bit errors
Successfully corrected 1 bit errors per subpage
Inserted biterror @ 0/2
Failed to recover 1 bitflips
Read error after 2 bit errors per page
#  flash_speed -d -c 10 /dev/mtd0
scanning for bad eraseblocks
scanned 10 eraseblocks, 0 are bad
testing eraseblock write speed
eraseblock write speed is 4555 KiB/s
testing eraseblock read speed
eraseblock read speed is 5765 KiB/s
testing page write speed
page write speed is 4383 KiB/s
testing page read speed
page read speed is 5614 KiB/s
testing 2 page write speed
2 page write speed is 4444 KiB/s
testing 2 page read speed
2 page read speed is 5688 KiB/s
Testing erase speed
erase speed is 320000 KiB/s
Testing 2x multi-block erase speed
2x multi-block erase speed is 320000 KiB/s
Testing 4x multi-block erase speed
4x multi-block erase speed is 320000 KiB/s
Testing 8x multi-block erase speed
8x multi-block erase speed is 320000 KiB/s
Testing 16x multi-block erase speed
16x multi-block erase speed is 320000 KiB/s
Testing 32x multi-block erase speed
32x multi-block erase speed is 320000 KiB/s
Testing 64x multi-block erase speed
64x multi-block erase speed is 320000 KiB/s
finished
# dmesg | grep nand
[    2.876719] nand: device found, Manufacturer ID: 0x2c, Chip ID: 0xda
[    2.883130] nand: Micron MT29F2G08ABAEAWP
[    2.887230] nand: 256 MiB, SLC, erase size: 128 KiB, page size: 2048, OOB 
size: 64
#


When applied

# cat /proc/mtd
dev:    size   erasesize  name
mtd0: 10000000 00020000 "pl35x-nand-controller"
# nandbiterrs -i /dev/mtd0
incremental biterrors test
Successfully corrected 0 bit errors per subpage
Inserted biterror @ 0/5
Read reported 1 corrected bit errors
Successfully corrected 1 bit errors per subpage
Inserted biterror @ 0/2
Failed to recover 1 bitflips
Read error after 2 bit errors per page
# flash_speed -d -c 10 /dev/mtd0
scanning for bad eraseblocks
scanned 10 eraseblocks, 0 are bad
testing eraseblock write speed
eraseblock write speed is 4522 KiB/s
testing eraseblock read speed
eraseblock read speed is 5765 KiB/s
testing page write speed
page write speed is 4383 KiB/s
testing page read speed
page read speed is 5638 KiB/s
testing 2 page write speed
2 page write speed is 4444 KiB/s
testing 2 page read speed
2 page read speed is 5714 KiB/s
Testing erase speed
erase speed is 320000 KiB/s
Testing 2x multi-block erase speed
2x multi-block erase speed is 320000 KiB/s
Testing 4x multi-block erase speed
4x multi-block erase speed is 320000 KiB/s
Testing 8x multi-block erase speed
8x multi-block erase speed is 320000 KiB/s
Testing 16x multi-block erase speed
16x multi-block erase speed is 320000 KiB/s
Testing 32x multi-block erase speed
32x multi-block erase speed is 320000 KiB/s
Testing 64x multi-block erase speed
64x multi-block erase speed is 320000 KiB/s
finished
# dmesg | grep nand
[    2.896206] nand: device found, Manufacturer ID: 0x2c, Chip ID: 0xda
[    2.902648] nand: Micron MT29F2G08ABAEAWP
[    2.906667] nand: 256 MiB, SLC, erase size: 128 KiB, page size: 2048, OOB 
size: 64

Behavior is the same. Speed is changing on every run.


I don't have zynqmp board here but will try to get data asap.


Thanks,
Michal
