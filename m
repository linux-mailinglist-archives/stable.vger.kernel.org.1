Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CADCF7628DD
	for <lists+stable@lfdr.de>; Wed, 26 Jul 2023 04:49:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbjGZCtU (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 22:49:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjGZCtT (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 22:49:19 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2087.outbound.protection.outlook.com [40.107.101.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A60081A8
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 19:49:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zt7F8m4U8c8uLKfNY+z7cFETas9jgdhcXozwiXbb42lF3WgvFrziYLKsfJGTodj7j5+ImqYZDIICNhKY5GfiPqafVj/bsoKTTvFzNQXMa4+JcUIRPEDHhluJkWSiZ8vcXpB4Mg5+UxkymARPrl3yqEmDXlyO5j0XRxJXe3cIiWPfuePk1QlcC5KnGnInAaH9iUtLBMDjl6r4hAk3DSua0OpHMFwZKuSJxxPHx3RuwKOmW1J96oEOUfmkLxl3zQ2t2yoUYoINGSz5FmKsfyr+qykMkIW9N1LtmS9eqxR/tJjj7RgkcPDv2ege7uG1L0313a/stuGSJpJm2dggTqelxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nnGsN/tL384TsGaI50kjG4fE8HmEBKkJgLgeiGtbR/M=;
 b=OnUCZJ7nm4eELE5p/glz+SABDNEj/rr17QIjNjN6A+twMHz0Gw7fsYtSNX6H9Tm/RZNZwT7ua3G3BVjo4stjjg5Xceq60CdqwMz4nxL71o6qQXyUUY9qmQMKbl7IUuKX1ir35rKN/zt7Q2JRocpS0ZZWXvlll+3d/i3kMoUBNF4Q9RlKAw+bbgFzxk13PdH3kmKZ8tESXa5m3vaaF0CQ31edqLgLv9txjv9tU3cMksVM9UDs9woknzKVgz/HqVBmJaH7gm/4MP63qhUJ1vYBcA0Wn5yMk1jF1KFJW5Egfwmhz1IlKHytHimaDeC8DRxOdFT5+s2v8qR0qhrptlIPsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nnGsN/tL384TsGaI50kjG4fE8HmEBKkJgLgeiGtbR/M=;
 b=UXRjMRkHumnLml7wYqSpntIvPGfFDRSCL+CQtwf83VnkoV8E/6fRNlnVCHcCGEeeFmQRqnFMHsQZYZVdAPU502pipcjr9ygn+U/12VXEYNcuriWrwluziJj26Uv+1hMjSuuw/5qmbhZvbBGZYmFjs7QZOZV6dKJ/uBOqv0OFKsQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MN2PR12MB4303.namprd12.prod.outlook.com (2603:10b6:208:198::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Wed, 26 Jul
 2023 02:49:16 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146%7]) with mapi id 15.20.6631.026; Wed, 26 Jul 2023
 02:49:16 +0000
Message-ID: <1b5952d7-4421-597d-4f8c-74ce09f664cb@amd.com>
Date:   Tue, 25 Jul 2023 21:49:13 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: 6.1 / 6.4 Dynamic speed switching backports
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR05CA0102.namprd05.prod.outlook.com
 (2603:10b6:8:56::22) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|MN2PR12MB4303:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ee38604-d586-497f-d643-08db8d82e698
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VIsWIlqg50L3aTfe8R3G+k0jk39vq5Jtp/7bfRZ0FcIykOJlrV+IJiH+AYRoRLQCbbEYOeANaY48OSBIQe40C8Zg5CGUKD2OBBY9ul2jG+2ZZJwHCdoFNzS7Ty4Q7Q41vAuVnmL3wdEbo4SaaPXTE9LUigfBfbK07d9MBaxACvlrTJz93VT+KYQZzH5kVn5iFyWfTnUIYAA8/9M7NtI6BC9jf7YJjnjydnwumYIpEdpLgfqpx8kyyD8tfykmSkDdp254lowXFbVP4gM7zUVCeJB2YjjgHYbh2lLcPOxGo+F1Zm+Ui+9ooku8mayxj0nZxZUoWWwdhDWLGtqTItyg/bOsMJU8S05C74XHL++OXSqpuQtaF2oHo+kz+OSLu8IS1mDNmimp0cDgdZqW2QiRFsq8QfKM9tYvpbaKM4NKou2VQEi4JLvmTZtqV7uw+9gJlyiNtHq9S5e9jqDKzb7lEEMQY03cdLzZepwwv+V5GfU7KUYilu/wc92CqXBcCwgGh+cp05mCFVpiMvCNclMtqg2X+z/IG4JdO9veJJNWg6m0PrsS1IGaJbdao8JMHctJNsPhML6ZBAcE+KBWvZ7AQjHFS6c4aw7wR7HBfrZnLn8qpGEcFNrLrNvqr49k0rFo2lBjPHr44j3XIa2nvXjfpA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(396003)(136003)(39860400002)(366004)(451199021)(66556008)(66946007)(66476007)(2616005)(36756003)(6512007)(86362001)(31696002)(38100700002)(6506007)(186003)(6666004)(6486002)(478600001)(31686004)(41300700001)(5660300002)(316002)(2906002)(4744005)(6916009)(8676002)(8936002)(44832011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d0lMTDRuVGE3YWhrY3k1dEFTc2FiVzA3alVWTGpiZFg1dXlRVmNvQ3c2Q3Mv?=
 =?utf-8?B?RUZEVGRhRVVwVFZmZjBJQk5QNGRBMXRmSzdVRHFnL1ZjZCs2ZzJxYWFtMFdT?=
 =?utf-8?B?STg3enl0MmZDbUpyQjRLNnhqdUN0RTNhYlpPTjU2R091dnR3NXUrQy9rc1hJ?=
 =?utf-8?B?d2Q1UjlXTVNXb2h6TnVJNXZ2cmZHaUdIZnJ6SmpnTXo0VEVnVUpBSDdCd2pX?=
 =?utf-8?B?Nnl1L1c2eG5FNHozKzZTakdTMXF5bFdybnNCUWRXVm5Tc3ZxQW5EenRJRHVF?=
 =?utf-8?B?NUVRbmsyWXNPZ2FhSThOdnhZRzZyRS94a3EyNUtpNnZ0eUFpWEc4MU0yc3RN?=
 =?utf-8?B?eUlYMm5ZZlcrUDZZU09lSTBqdUZDQmF4UzlKOFZjd0w0NGNlVnVIUXJ6L3po?=
 =?utf-8?B?VXhwUHN6anZUWk5EdkEwV2loT0dYUjJNQldYWU5Qbys0VjcwejQ3b2hVYzM5?=
 =?utf-8?B?TW56VEt4MHlpR25TdXhVSDBkTUIvYm9XRGgzYncva0E0QndsTDQ3ckRXb3Q4?=
 =?utf-8?B?byttb3h2SC84TllCYXNWWEplY1IvWk9DUUZLRUVMcFJha0s0SW5jUlcweU9o?=
 =?utf-8?B?QXV6K05mQkZEdkpKUHJYckJuTFA2TzB3RlQydmwyaVhMeDdzRU16MEl5aENm?=
 =?utf-8?B?RTNHcmxpN2VLSFJvd3poa0lBaDZualBBaGRWa2U4MFdnK3FTZUtKN1c3aXN5?=
 =?utf-8?B?dTYxOCt3RXdnRmdlb1lxWEFpWFc5UUdLZnV5OU5laWF1TXhYK1lJb0dMVjQy?=
 =?utf-8?B?cGErK2tTTEpCMXJiVW1SQzQ2NnRPcDRpd0Vlbi9lSW8vY1pIZUI4R1R3dXNq?=
 =?utf-8?B?V2NKcFNlcHRyM0ZQeUIzVXhkME1rLy80VW1QM3ZXYWRKL3FsRWY2MHEwM1Zi?=
 =?utf-8?B?SWZtalkvTFdpQVVpWWpkbUgxbHg3ZkVXUHQyOXdvM2UxUmh4bUJDZWY2SW5h?=
 =?utf-8?B?UzdJa2p6QU4wME9xNzVZRi9FR09CU3BVWGZJVkNxVS9IYndQR0dOV1orY3Zz?=
 =?utf-8?B?eHVSaFJzc3NBczRtZGpocU8xcmpjUjNDWDArdWlYS1NKeFQvYUM0aWtrZDFw?=
 =?utf-8?B?WE9kQk5aWjVrYm9hZkhIUEh6eExlenh3VGVnZDVleU9sdlp0alBxdE0ydXBG?=
 =?utf-8?B?ZGVlU2gwaWJ1ZmpwTm45SjN0SmdDRzg1NXlaZUduWXNjSWo4MUJoT0E3OWMv?=
 =?utf-8?B?TVBSSC9pYXhPbEJJdFYzOUJ4V0xaaWVqblAwOExCVTFJT1dMMUpwSGczL1Rz?=
 =?utf-8?B?OWxXZmVFQnA4bDZ5bzRPV0t4c0FWeFE3VTF5RGtqZE4zMlRRWkVVSk5aamUv?=
 =?utf-8?B?RURncUl2ajNaaUJNSUd6dGV6YUFVR1hIVXdodFNGZUdVK0szZWduRDJ5NTdJ?=
 =?utf-8?B?cy9KdlhzV1NhNXFJVk9aREl5ZWc5QmltYzZSbXBhejFkYmcxR1pNRnVjU1JT?=
 =?utf-8?B?ZHpxcG02R1dQWWdCUmV4enZuOXJuSE5FcWtZUUFYQm5ybXI0WE5ueHlkR2dD?=
 =?utf-8?B?akVaR1JNeThpbmJ2ZGNOQXNnZ25lZkg1Y3JRKzZ3TS96RUlzSi9nMkttUE93?=
 =?utf-8?B?dk1XRGJ6Z2F6aDYxSndGV25rTFQ3UWZVNHNaamxwUkMvTC9GeGlPNnVjRkpo?=
 =?utf-8?B?bXFINHFCS2dPZURjSkdINlBvTUtTQkFUZ1k2MXUxTCtjZm4wVy9qcFp4bGJY?=
 =?utf-8?B?d3VTYWducjB5V3RlN2Frbmw4SG9jY2RYZkJHZStNbnJjbElIOHJ4ZEZTd0hR?=
 =?utf-8?B?SXJGQmRnZkJuNnlSUnBzMnBqM2M0eHFFYzlxOFY1cmhPbFh2SHZGS2Nic0hD?=
 =?utf-8?B?SVJYT01YcW5ibUl5d21KRldoajhlQ3NuTGFsOURXenQwaTlsRStyYncwcm9T?=
 =?utf-8?B?SG5Gc0hNNXZxb1ArTDNDRGgwVmRuSEp4M2NDQ3FmVVdQMW1Td2FxTVo3K3hl?=
 =?utf-8?B?N1o5SUdwUWFuRDNHelBtVlNWelphdnA1azFsbW1PS3RKQUZwQnplalowY2xu?=
 =?utf-8?B?VHZqL3hNZ1lJQkJwQWExR25OMmhYS1JLMXBFUEsvZ3VnUjNucTJZTGpuR0Zi?=
 =?utf-8?B?WkJrQTM3eDdMYTFUL2U2aSsxMEN6MjVObUwxc0owMEZ5dkNrYXJUN0pXOHQ3?=
 =?utf-8?B?NzdSZTR3RHhxQ2YxVSsxN3dLVlpGZ2RUWGFFU0N2RlpNdGQ1ajBqeDdUWFJG?=
 =?utf-8?B?WXc9PQ==?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ee38604-d586-497f-d643-08db8d82e698
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 02:49:15.9380
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OvSJVMKU1J9aE0xhSiUPb0Inx86b+FkcnGj8Pch2Zsc5y4Cw3HWPwumLt3gAgxatFkbcZTcZ+XmLXwcHXWW9MA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4303
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

A series landed in 6.5 that helps system hangs when AMD dGPUs are used 
in Intel hosts and the host advertises ASPM.

The whole series was CC stable 6.1+, but for some reason (unknown to me) 
these two commits in the series didn't apply to 6.1 and 6.4.

188623076d0f ("drm/amd: Move helper for dynamic speed switch check out 
of smu13")
e701156ccc6c ("drm/amd: Align SMU11 SMU_MSG_OverridePcieParameters 
implementation with SMU13")

The rest of the commits came back properly, and I double checked these 
were not in the queue and work when added into 6.4.6/6.1.41 so can you 
please bring them in to complete the stable backport?

Thanks!
