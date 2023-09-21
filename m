Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 804407A969F
	for <lists+stable@lfdr.de>; Thu, 21 Sep 2023 19:11:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbjIURCl (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 21 Sep 2023 13:02:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjIURCJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 21 Sep 2023 13:02:09 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2060d.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe5b::60d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ED2F26A9
        for <stable@vger.kernel.org>; Thu, 21 Sep 2023 09:59:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DX+tX5PffwBO43rkrVP/7zEh4YpLaG2pu3d40IDwDWCUYJ78y/dkdtUo4LNC079Ph20tStlYGhkda8C9w2L/ZWIjqz6vUBTpIP2YQqbUecKH+yMaOJiNuKdro3sLz8Wtx2pCaf30RF3F/G1AU2t+Li/ABx9BDKnoj8bfo8jbKRkFF6eRUAAoGK3ezqsTkfdtRBkekJYX/3xc8C4lRSB2Cn7zlW5Ep31zd1Dbqvg+Yc7OWuZtGa7cgRRc2e2uZkQKCZRIG/vTtIcLTfpSpUFh5eAvYz0GKbRRZtYGbQF0PeBuUvS3zGo1B95JiJOLsb2zuwGthRvBb3IanD1MIiirtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GgZs7cOY1Y1C89w2QCu7/1DMcqOEjKlodGmd0tSwA/o=;
 b=AMlDz7YdOa5Ttjh72JRpnE3gBuRZGw2dM/2Z73ofynq4Jh7TnT10kqyepnlHQfv0NV3Y/xpADQwZPJIKBzma6gaJMT/pXSwje/vFM8il7MS8QY7a2IDir5rqSNOCMKGWBi/g7IrZbf9e1xVS4IEIHTlv4n+jfKLa1GMinRGxsHyXbhN+gAaf1MG1ywsJJK09DQmPhjI4iSeaHx07SXJpTOx5dOZWddyDp1WL+bPA2S8YztSFSKzr8vMJmvFSXRvgmpnTvj4YlU+2TmVMdkbzIX/qmFlU2u9dbmlp811C9j2jlO2oUathOnL4zLk8cxQQDAgZZWlq7AG9wtOMJC1jNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=bootlin.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GgZs7cOY1Y1C89w2QCu7/1DMcqOEjKlodGmd0tSwA/o=;
 b=0Bu7jS4TolPSWHk5H5atIQ6/4n365GWVDkPuF5Tk6TSdpLnrXoF17JRx95MOZuOFOTX2hjOfHqOYhcSZsnooL3cDJb3D5Pq9ZXZMQWcL9+YB/93G73+cTZyE01geBUUvi8efByZ36oAb7mczGxaZR/a16dYZBA9bK/KKhiiyEjA=
Received: from CY5PR15CA0192.namprd15.prod.outlook.com (2603:10b6:930:82::18)
 by CH3PR12MB8934.namprd12.prod.outlook.com (2603:10b6:610:17a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Thu, 21 Sep
 2023 10:25:16 +0000
Received: from CY4PEPF0000EE30.namprd05.prod.outlook.com
 (2603:10b6:930:82:cafe::cf) by CY5PR15CA0192.outlook.office365.com
 (2603:10b6:930:82::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.30 via Frontend
 Transport; Thu, 21 Sep 2023 10:25:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE30.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Thu, 21 Sep 2023 10:25:15 +0000
Received: from [192.168.137.2] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 21 Sep
 2023 05:25:12 -0500
Message-ID: <ead8ac00-cc2d-4258-aac1-af5eed93de7b@amd.com>
Date:   Thu, 21 Sep 2023 12:25:10 +0200
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE30:EE_|CH3PR12MB8934:EE_
X-MS-Office365-Filtering-Correlation-Id: 778c34fc-6351-4cd4-c894-08dbba8d0bb6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 541kYALBPMgMn59NFv9Oyl6zWXRGC69jKCd/+HNapw7SqtQjkO4ZIkM3iBV2DWtRwaG6GzsM1M+ifaoRggV6z1VHT9W33dlzYx3rk+CSNx2MHPoOlcevgSEciYsqv4jacFZ6p0JJZ13cFhXTg2sUKeaw5A3hjUfECjWSvPdeSdYX9WqzJhVWztW3oJGvqBIo3oJV8Y+mSchDjjx1tIJ/zYZ+0BxlZe9UhFjkMBcogOHoY2HwihROHNob3sWXelHsKGqlmiRxZbHeG0wUL45aKXVvkgSbe3uidtNzB3tcJDkYY1IRC/sceA/Ws3/fBuh1mkFrvLwZ7nfPOjuymNnEDfuuyvqEk9fp++Z+GRbg33i6RaT3nIus2smUVuzOV3d8p9DGoh/NDYH9wLpnLS6F7qHDZvQO3gZzNvRglkRILs8VjOM0b0WMYKBi4GAx4lmrFOZLdxRiqglG2hHA3AhvMCjcdeu3bipdJI7H5tV9Cv4Aa90qeB0wiGZRbaqEZBRMfgkfEKYjtG+wrJcSUStjLyutP3lQOv/meI5ifB4mtrmEyH01qBVWmTUH6/3ekm3ITaoYUu3858reyCYHxfinu93QoKVFYdsBK2RyRXAuql1WWzFAGUu+cM8+55885ZGpYRx69qCtg6eT9LTzdb/4vfIBLe5l+hyilObaYG08O4G/lnkZcYF4d8AJfq9KmI00OvwNqkuzVDXL7m3E6Ux6ICY05udsMZf9ISsUPuiA3uWDSJ+BQPYorHvI0r8+uDzt+8GvEFjW7Fv6BjRxV0T80u+YzqwBuUR4uqb1b+fQPLrtBVj39NotrI7w8wky/u8Z
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(376002)(396003)(39860400002)(346002)(451199024)(186009)(1800799009)(82310400011)(46966006)(36840700001)(40470700004)(31686004)(83380400001)(66899024)(53546011)(82740400003)(5660300002)(4326008)(36756003)(2906002)(316002)(6916009)(54906003)(44832011)(8676002)(41300700001)(8936002)(16576012)(36860700001)(31696002)(336012)(426003)(478600001)(47076005)(70206006)(81166007)(356005)(2616005)(40480700001)(86362001)(70586007)(26005)(16526019)(40460700003)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2023 10:25:15.1646
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 778c34fc-6351-4cd4-c894-08dbba8d0bb6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE30.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8934
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org



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

Testing team won't see any issue that's why feel free to add my
Acked-by: Michal Smek <michal.simek@amd.com>

Thanks,
Michal
