Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78BEB79D2ED
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 15:55:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234939AbjILNzf (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 12 Sep 2023 09:55:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234890AbjILNze (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 12 Sep 2023 09:55:34 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2057.outbound.protection.outlook.com [40.107.95.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 419C010CE
        for <stable@vger.kernel.org>; Tue, 12 Sep 2023 06:55:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CvwTvSdmPOJ26NrfjZfShL4WoMb/Hf1IgzX/mydIoGdMCRH5e4wQzT/sHwEy8hE3NohroeGwE0BqNUdmN7ohr/qeUGywV55WwA8XVALqtiZT9VJ/oJMaIvSp2B+uSpgzBmK9d1pFtxR9tFrre3H2LuI1b53ujF0yn0DLdYhzWncuOMvVNtr6/cJF1QunCs+axrHzm2ZU8NHqk/kqIY8wjgqoM2ahOlrq6dztyiRGdFRbSBA/Jl/tw+QqUJiBqWZQJk9CEtP/2yh3ULJm40WuSy72KLTdLzqElmnVpNVGIdtA3rfn+Gx9D5xKSt0zXJ1U5YpzQ/QpgwVCt1Xh4qiE9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LaJ7Peo9mGl4irdzKwfsHod7zLuahQl8ar6cAK3hjCQ=;
 b=hyOSJg1qeE435BvZSb5J8l7XNLX671qRphjxB4s8i5SvocTJuBjGHqPQjtKOxXaIwsxtILqXQVg/z5ONeRk2+L/I4YtFW/pbwuB9FCRqcx9MC3IZLz2kopaopZuyngUHlKY2iFz0jPkp+wneCFmKksWSSUX6fkc4oo2f5xFmQp774vFB1/xBRfwzS4NWhZNP5dJe+lt997cNkCztFlUhjn0zKu0g5/HAXN94OmF5xArUI7uYGmv4AvciFxdh00EBAwoGyj1FTx3YnF2Ar1lWa/ct9Wrwn+wYf7GL2AkF2Vwv+8bcwlo7A+LIyhF19oUnHUOTRaEyeClu+A/Mg2gYCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=bootlin.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LaJ7Peo9mGl4irdzKwfsHod7zLuahQl8ar6cAK3hjCQ=;
 b=irRU84PMOtX2Y7k0jz23dTdYRN4EecnmeHtbCE5oiZnzWIG2kJo96sqyAfHw7CYKSmfaY/z6ZCV4IApaufZjTO/qWnEhPcu3oIoeNSEBBfPZw6yaWmK83z9ggow3cuQd5Z77D5/TISihnBP+Zg7ctzX/GAtzM0NcRU73CwpuFX8=
Received: from DS7PR03CA0340.namprd03.prod.outlook.com (2603:10b6:8:55::21) by
 IA1PR12MB8239.namprd12.prod.outlook.com (2603:10b6:208:3f7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.32; Tue, 12 Sep
 2023 13:55:28 +0000
Received: from DS3PEPF000099D5.namprd04.prod.outlook.com
 (2603:10b6:8:55:cafe::5e) by DS7PR03CA0340.outlook.office365.com
 (2603:10b6:8:55::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.19 via Frontend
 Transport; Tue, 12 Sep 2023 13:55:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D5.mail.protection.outlook.com (10.167.17.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.16 via Frontend Transport; Tue, 12 Sep 2023 13:55:27 +0000
Received: from [192.168.137.2] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 12 Sep
 2023 08:55:25 -0500
Message-ID: <cf1a0b96-0f1e-4a6d-960b-93185faf27ba@amd.com>
Date:   Tue, 12 Sep 2023 15:55:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] mtd: rawnand: arasan: Ensure program page operations
 are successful
Content-Language: en-US
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <tudor.ambarus@linaro.org>,
        Pratyush Yadav <pratyush@kernel.org>,
        Michael Walle <michael@walle.cc>,
        <linux-mtd@lists.infradead.org>
CC:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        <stable@vger.kernel.org>
References: <20230717194221.229778-1-miquel.raynal@bootlin.com>
 <20230717194221.229778-2-miquel.raynal@bootlin.com>
 <20230911175247.44c1d894@xps-13>
From:   Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20230911175247.44c1d894@xps-13>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D5:EE_|IA1PR12MB8239:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c0e7704-d56a-4ed2-ea6f-08dbb397eb8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WcpWsvsE5nbAKkpUFVMureGx/45ZzR2wQwdh4H3ySPyCeQaEq71eAHo7NpkfrqDfO/lhBlVIO3xxMHbivPMugAT7/v6Ya4KJqELyqZNYyVWDyxfbkmpFM+S4odY78+YSQSD3+e3WGlu/Kk6wvdz8g0fswEu4Gs/UgzIkM8WNfVSvntsXOoa8i7ZxSqJSx6wNnFgm6Hjhr76Mj8A7dtYbKw/RS8TvPGNbVFMUhwIkbRjmh2G6UB/q/B1fzOGuv3kv70lr8rgEBC+0/byMp+pqmCSTrJeWdeUpDOaUVaH0n4LkW7SIgkTHhBwmLUY5+pt1oP1hpmNcfftzZKZK8I4n+M2ITL7yrVYaOxOJkm/3mgzolZord2DfMQwiisCdv0EZyaPbhp5x2HPOj7BuRxV/jMhQ4pyvgPanFDhhPq1m9X2s1SbdGzKdpV2eZIGxITWFpisILcQqRUg1HQpYwy9oDsISpacDX+fMqWuqi/3P7Pfykruy6IXsDkM1eA9qPWEohdWAAUeIffNezT3WMTv3LXP+k2i9EokCY5uAwtXUakezCi2Xi4pGcX0SoVZsEJ0V52Eio18hobQu4UIS/xeFSkLcaunadxxA8clT8u1o2Gd0B4ju2xLOOxSeAlbiRgfeXDKDU+fcfirkevTQA7iHH3KwuZwIrYqB8460XHAhMwZBgvEa6J7Lx6aWwPYkG/Pv105WFEHrvkd+7brIa04xX2fSEGP2rGzqV3aRYIayO2IF5azZhyTesGHCJIDVh4h5oTizWye+WT+VrgL1x7+fEbIiFAaIo9OcQzFRXUF+pJHLXg937PUzDXoFNgmszCNC
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(396003)(39860400002)(346002)(376002)(186009)(451199024)(1800799009)(82310400011)(46966006)(40470700004)(36840700001)(41300700001)(16576012)(316002)(40480700001)(16526019)(26005)(336012)(426003)(31686004)(70586007)(8936002)(110136005)(2906002)(44832011)(70206006)(8676002)(4326008)(54906003)(5660300002)(478600001)(66899024)(53546011)(40460700003)(36756003)(36860700001)(47076005)(2616005)(83380400001)(86362001)(31696002)(81166007)(82740400003)(356005)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2023 13:55:27.5655
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c0e7704-d56a-4ed2-ea6f-08dbb397eb8d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8239
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi Miquel,

On 9/11/23 17:52, Miquel Raynal wrote:
> Hi Michal,
> 
> miquel.raynal@bootlin.com wrote on Mon, 17 Jul 2023 21:42:20 +0200:
> 
>> The NAND core complies with the ONFI specification, which itself
>> mentions that after any program or erase operation, a status check
>> should be performed to see whether the operation was finished *and*
>> successful.
>>
>> The NAND core offers helpers to finish a page write (sending the
>> "PAGE PROG" command, waiting for the NAND chip to be ready again, and
>> checking the operation status). But in some cases, advanced controller
>> drivers might want to optimize this and craft their own page write
>> helper to leverage additional hardware capabilities, thus not always
>> using the core facilities.
>>
>> Some drivers, like this one, do not use the core helper to finish a page
>> write because the final cycles are automatically managed by the
>> hardware. In this case, the additional care must be taken to manually
>> perform the final status check.
>>
>> Let's read the NAND chip status at the end of the page write helper and
>> return -EIO upon error.
>>
>> Cc: Michal Simek <michal.simek@amd.com>
>> Cc: stable@vger.kernel.org
>> Fixes: 88ffef1b65cf ("mtd: rawnand: arasan: Support the hardware BCH ECC engine")
>> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
>>
>> ---
>>
>> Hello Michal,
>>
>> I have not tested this, but based on a report on another driver, I
>> believe the status check is also missing here and could sometimes
>> lead to unnoticed partial writes.
>>
>> Please test on your side that everything still works and let me
>> know how it goes.
> 
> Any news from the testing team about patches 2/3 and 3/3?

I asked Amit to test and he didn't get back to me even I asked for it couple of 
times.
Can you please tell me how to test it? I will setup HW myself and test it and 
get back to you.

Thanks,
Michal
