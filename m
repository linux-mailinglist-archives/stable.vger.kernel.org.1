Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 209C073769B
	for <lists+stable@lfdr.de>; Tue, 20 Jun 2023 23:28:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbjFTV2g (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 20 Jun 2023 17:28:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjFTV2f (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 20 Jun 2023 17:28:35 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2086.outbound.protection.outlook.com [40.107.223.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD9CC184
        for <stable@vger.kernel.org>; Tue, 20 Jun 2023 14:28:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dmZCiAc9+xs5jBQzuMvVZMJT6k9DtuYdVPYiBm4c6oZDmUrAmYX7fOj9P1Gx+rNNNPrSTpgREMqawYS5v1yRLUXsdxdY+7R75K9sotR8Trz7YrTD7VXUf+hAxULARUe/DUpjEqVkPbMWJNLFVrqTq630PIg8r8Vh3tTp11mEniMIJqNH7O5KRSVO3QhzY/OUoKfx07JHLqVf0u7Nv3caHdRMeVHBAnDlEO8+r/Ul8O+MBYZerx9wApJ/WU0oc7VlmM64wdep8vaMn03XLRImEEHDjyfbriPI+XJobpocYBGEUDoN3vPSv7oBAHtYzT8PdzaKvCdBRk2SjV4pwgf3oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fe0aJwNuloCBNJ7vgWpduRQbodCESWXyCTk6zGuLBf4=;
 b=ogYIT9Cs/RSLGe531/Kr/9XKNVD8K/cVW+kxRJAPgbHHv3/9oTkjehi6R8dMyy8t72zc7bkRqugI5yIYNVP31OdFLTt9C6v3+vf1irNPIgLckj8eNIWD2XzsE5vOY/xcHTLDsoyDOW0nNFtKJemoSQlnFifR4jxBKs5a6oCVbnJlR6r3usHz4oUbgVwvOTfcS7jygHPv4Rsj7ycWKBUD+zCSv3DTADRjmFFU8TBnZqShS+9Q3/UXC9vnujE2iqh2Tp2agRPRqy9PBLguDSsyIZYWzZm00Vbz5muQVHHdNPoxZ0kNDZlXS49TOpjb+YMPH47ylSxKgQgBE2iu+ZSC/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fe0aJwNuloCBNJ7vgWpduRQbodCESWXyCTk6zGuLBf4=;
 b=WCMHP9gormyx6xzQgZa+XNmBYrmU6pDMbgvXihD7LTVNSKRGLepeIZCXaOA3Y49eR+T5NPXg28/NeygkjkeK9JmGX2a3nTegWB9lgMK9ARYPHeFEEuj/Tkj95NXA0pCfbIL+T22oENfb9j4CYSzZI7KPkwmIvfYzgWXXrBuHAYk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CO6PR12MB5412.namprd12.prod.outlook.com (2603:10b6:5:35e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Tue, 20 Jun
 2023 21:28:31 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::dfcf:f53c:c778:6f70]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::dfcf:f53c:c778:6f70%5]) with mapi id 15.20.6521.020; Tue, 20 Jun 2023
 21:28:30 +0000
Message-ID: <8ad8aa7a-f97f-1fb7-afaf-01c1b1309bb0@amd.com>
Date:   Tue, 20 Jun 2023 16:28:28 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Content-Language: en-US
To:     stable@vger.kernel.org
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
Subject: Phoenix TPM Support
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR03CA0041.namprd03.prod.outlook.com
 (2603:10b6:5:100::18) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|CO6PR12MB5412:EE_
X-MS-Office365-Filtering-Correlation-Id: 0229c020-d456-4b30-b198-08db71d54b48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wLeiZMtBhY3lTJ+Jw/iJQWVHQSMMy5mJyCqlcGMbJQJiV30Tyo17gTDd/VEZxC+P8PAC1ulYJZ1IV8GesQy6icDYRmlARxK56Bo9dZ+ZSlBg2JPlwZjQXU7FaCK6Nc+nAPo5gT+Jvw+0pMkMc5hz7M2i+bx3Cb1CXLy8Wo0mn/Ll9xk3YLksCFnDdl/sWuvJ5QmPzdaQgZEBDvAKfOgnRUFG1QwKsuHEeMCj4+VNRwRbq9Ou045n7/rFSwVj9iZRjiOrdWhne2SYXpqh5OPQT+kjOVt83dwtnw3651pbD5jFkgri4usiwHrsYlu1lYfj1kfuhmyZGWKPJN0QY6KrI7PHKqDvIYlEcoYLcd0tPplydTj7Nmgvyfm4+kmZvF1mO7pAxSkI+ij3R7ywLrhKXjnRz+z8TRDsmfANt/eciX0HSJZFZ5So8u8MXQ6qM8x0vA33CFbDbyG3M3kxOzG2wOW6gcYw+CVO4Wo99/4Ha9SF94CCBSNyl1iRLiAXXgGDn3jd7UoFdQwpDRjplTCWwcOC75mmZeIjfzAjBlrnpCo7pmRxADhoTBDpfkAhIa+zAJfikTst23FgaUP3bRcUH1yibwZyhy3K7fEaWKabFChVkhrkuJR04RxRQStEsuFnj4Sr662SfXVqs736WNpYUw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(376002)(39860400002)(136003)(396003)(451199021)(5660300002)(31686004)(7116003)(66476007)(66556008)(6916009)(316002)(36756003)(66946007)(66899021)(4744005)(2906002)(8676002)(8936002)(41300700001)(6486002)(3480700007)(31696002)(86362001)(478600001)(38100700002)(6506007)(6512007)(26005)(186003)(2616005)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y29BSjdpZ3VnVDlRL0FLeHRkdC9GY3Z4Ynl4RmN4NDJjTmNrdGFBVjB1b0pU?=
 =?utf-8?B?djVvRTBGcmtGd3VJNStKQWJMUU5PLy9jNHV3SnB2eWg1SmZaM0xlbW5yVjlu?=
 =?utf-8?B?bUpqL2J6NmdhcUo4RWZROU5XbmFaZ3V4dFRIaXlwbk9xZmpMRTZEMmw4SERa?=
 =?utf-8?B?dFdjaWt2ampqNi8ySC9OV2kzUWxvYTQ0ZHM5VGYwenBJTG9QVFVaU3hLY01s?=
 =?utf-8?B?WEFYUjdVYUQzMkcyc0xRR01yVFlzYXpuVW5GL0R3MHRtRzdjT2hqN29xeVoy?=
 =?utf-8?B?ZDhMNDJ3SGs4OHM3T2luTDB4UDFQU1NaNnVIRTBkaFExaE1yNHRDMDFMYVl6?=
 =?utf-8?B?dHlKVlVPU3dGaUhUeVVrZUVTS0kzZjN5UzVHR1l6N1g4ZDU2dlB1YUZ2NHdH?=
 =?utf-8?B?MzAyZUV3ZERia0dZNXdNMVZPa2EwQlV4T3oyY21xRUlEd3IzWkhMcmNtVThI?=
 =?utf-8?B?VTZDNnA0YVI2TkNseEh5c1R5NHNrM1RQczRycHorVXF0ZGhCdk9VVWN2NGVC?=
 =?utf-8?B?MVhIczlIblN3cnAwSzl2UStjYkZGWDdmRDRPb1hlNkYzYlNlN28xRWtoTVpq?=
 =?utf-8?B?Y3JzaGs5MXhMaFFpdmNhT2dlbVYycXdPcE1taW92NStqU3orcS9KZFFocHVk?=
 =?utf-8?B?NVlLTk1ZcVh0eDF5TTBuOHE0T1NlWTV6enFHSWV2UWhsRDRsdElBRmFHL0dt?=
 =?utf-8?B?M0FNc0xad0plL1Y3RmdlaExpUmU3dDI3VVh1c3huanRuTXNsTTIzd3FjZjBu?=
 =?utf-8?B?YXVtYlU1bVZBK0lWZkIyZFJOVkVPQ1Uzajc5M1FTcENuZVV2aUs4UUsxOFoz?=
 =?utf-8?B?WmVSZzVFVHJFd1R1a2NPbnVmaTQ4ZGlIdUlLcXF6MkRtUmN5Ti9yRTZaeEFu?=
 =?utf-8?B?MWN0d21Qb1FlWEhQclMvZlo4YlgvUTNGWXl0SzJyaTIrNm84UFN1QWVVWEw4?=
 =?utf-8?B?RHFhUGNpOGtKYk94aWEvZU5TYm44WEFuUE5lRm9BZmlyQmdsTGIrM2lUNUdC?=
 =?utf-8?B?TFozQ3NacnlYY3B0NTFLemJIREZlMTUyb3ZQSXd6VS9kMzd2cXlnTGUxU1pZ?=
 =?utf-8?B?Mk10YkZvQTFXWmlGZURGcUFrNThKTGVna1NwUVErejhIbWI2RG94eURCWm9x?=
 =?utf-8?B?WktWYTkxWVJCL2pISGpvM2ljYnRhNzlLWFh1TlozTFZIR1NVRW56ZlJ2dVVy?=
 =?utf-8?B?UkhSZ0gyN3VSd2dCS0JHajNHK0xHbCsrSzk4bnhlZEVpWXhDdndSOEdtN2VG?=
 =?utf-8?B?N0wwTXJlelhOcUxib2psVzY5RVhuUm1ZRHI3Y2h4aEh5TFFYRzJNZG5vWWZn?=
 =?utf-8?B?S0owZE1jbXZ4MkJ0NytvU2FwQ3lrS1VhVjBKeE5Fb0F6bzVZaFJNdU1FUnE5?=
 =?utf-8?B?cDJkVlNpa3U5Y1YxWlo4ZXVJbFBKdTdtRHBHdzdZNWdicWVneUNnZlZFOU02?=
 =?utf-8?B?WVdQYlRaTm5IamFvQ1hnNlNINy83LzJYVUpNd0hXTmNpTFp1OUdvQkNHS2RS?=
 =?utf-8?B?UC9lU0NVZG1kc2x5eWhNRmF6dVJDZkZxUWxQWUhuNVVPMTA4Y3g3UG0yVDJi?=
 =?utf-8?B?ZzN6STV1K00xK2lVNFN3ZlYweW85RlBuZjBkeDFCQWt1QWt6SFFWN0lvSDJO?=
 =?utf-8?B?dTVEdkhQUTNGVXZhbjIzOTJOQUlHVjNLL1FZd3E5R0xVUGRJYXZkUmlkaHJa?=
 =?utf-8?B?eVFNczVZWVJrQ0EzZnRWeGdYeUlWTlF5bUIwQ3dmaXdVdFI2MlRhQVV4cGRU?=
 =?utf-8?B?cVZNZk9BRlRKOFhJNHlFT1gyZVhDU1lHYnJtYWdyQjZ2ZXNUVEMyWDY5azF0?=
 =?utf-8?B?SHFIdm1vcmVhSm1rdjlaang2V29ZUkZ1ZkRiQ2FnSCtsOS9vRTJNaWFQK0dR?=
 =?utf-8?B?dU9JdG50MWJOd0Y3TEFydjRkN1dNRzN0RUFNdGZJS2hMYXpLU2VIWkNvNkV0?=
 =?utf-8?B?QmNkVExaeUZIcDVaN1VubmlMWm5UVkxVMGtyVEVUNytXUDAyRmZBNUJxSGpi?=
 =?utf-8?B?RFVJVG9FRTZWZVphYnZuMzBMTWFoTHdydmtzcEtpN1NneFlCSzZTQW1ZTHFw?=
 =?utf-8?B?MTFUNkh0ZHNnclVjQ0RlVkNteU9zK2dVRnd5OTlUQmd0RkkyOTI4TUpIdi9w?=
 =?utf-8?Q?4+yX3WPhl+rbRp97tqY/R/OQw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0229c020-d456-4b30-b198-08db71d54b48
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2023 21:28:30.9729
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sN8fZCV5oGlxp25BAUV9zqoy70WO8iyMhJ7sFhu2bWbuCdVI7ETFxb7OclnhB1aMf21mDSqRRgjL4PRgAxGBSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5412
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi,

Some (consumer) Phoenix laptops are showing up on the market that don't 
have discrete TPMs and are choosing not to enable the AMD security 
processor firmware TPM (fTPM).
In these laptops they offer Pluton, and are relying upon Pluton for TPM 
functionality.
This was introduced in kernel 6.3 with:

4d2732882703 ("tpm_crb: Add support for CRB devices based on Pluton")

I double checked with a backport of this to 6.1.y and at least basic TPM 
functionality does work properly.

Could this be brought back to 6.1.y so that users with these laptops 
have TPM working with the LTS kernel?

Thanks,

