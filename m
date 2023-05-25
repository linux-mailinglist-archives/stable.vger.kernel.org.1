Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8C037110DA
	for <lists+stable@lfdr.de>; Thu, 25 May 2023 18:24:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239770AbjEYQYU (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 25 May 2023 12:24:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233548AbjEYQYT (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 25 May 2023 12:24:19 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2048.outbound.protection.outlook.com [40.107.237.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1671B10B
        for <stable@vger.kernel.org>; Thu, 25 May 2023 09:24:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f8LtBfAxCYBPWX90a3mW9QuHdy1JU2MgiC4H+DyhF8vtgoXDpyM8vH4nFhTtfhaXlrkIgbu38Hmqt0LW3CznQk03vJkf6A3bK1Bgzuh8JHhZnM0BYqxUU1bftNOJtQQ611Lqf3SXeRus5gxkhOJnQK0njtMyzFNwA4ZQ2jdosOpth0dvYcQ3Szm4HuOMEjy42YMChC0XBqnItFigBvTZBKlWgakx5W7Z6jXnpp6VQa+xP80RbLG4p2n97UMEJNmHvehOLhOugjbq0sYc5M3cdSbX9iMNma1krK+Oxa/j2DpPB87kWPcIgj2nFAohSV8fvoPJphJy9aomQjPabdqjWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a9jU1E2S1C5Wgtsq67Jz58usYKnT1BMMvfyVnksjwnI=;
 b=K6I00r5ysfN9XfKfH5tqzpBJYpf1c03TtmMX0KGDxwSujSrAsHLT4c+621Xt7xgsPDu36EUyz82b/qSxLRUEQUG1vmEe68K6QtN033DorFjJmY/658kUvvGzMdCx5fACLj//OQGEoTa3D/7wC+2LX+FJikn0PaKQCUS5Xz7buM0PXsvso84Lc1Z1FkKsCgCSb+eppQizqcy0QJSgMt6p4A2r+YCIUkcP588GbHKrQLwYO8ir5GfCf65MTySDD845eKibEsXygBvOcJFOF/gQfaByylnvZXUTwgCoPv+D5uOCBYCo+4w8fJoj9a0z/RI191yi9d7/NmCiYZHURy6qQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a9jU1E2S1C5Wgtsq67Jz58usYKnT1BMMvfyVnksjwnI=;
 b=IeWGcyQ3Y8pyZO5xE1XmpR7fyQSUZD9CvbZchkhWj5HPwmvpJJRAu0zU4VWaMkzBmmGlfRAV5N3hCFN5+3qmuT1VoDz7cNkZ8cC7+mtQr1KaZvJ4+eOJuCNsDw4mmbaUXSElzAza8/0oo1WBWDyd8zN0RpcLyhvI12mOF/9tB9w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6253.namprd12.prod.outlook.com (2603:10b6:8:a6::12) by
 IA0PR12MB8716.namprd12.prod.outlook.com (2603:10b6:208:485::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.15; Thu, 25 May
 2023 16:24:16 +0000
Received: from DM4PR12MB6253.namprd12.prod.outlook.com
 ([fe80::89e8:70f4:7584:d4f3]) by DM4PR12MB6253.namprd12.prod.outlook.com
 ([fe80::89e8:70f4:7584:d4f3%6]) with mapi id 15.20.6433.017; Thu, 25 May 2023
 16:24:16 +0000
Message-ID: <bff70d90-c530-b632-f64a-f400dd60c52a@amd.com>
Date:   Thu, 25 May 2023 11:23:44 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Content-Language: en-US
To:     stable@vger.kernel.org
Cc:     Mario Limonciello <mario.limonciello@amd.com>
From:   "Gong, Richard" <richard.gong@amd.com>
Subject: Fix suspend/resume failure with AMD Navi3x dGPU
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR11CA0025.namprd11.prod.outlook.com
 (2603:10b6:806:6e::30) To DM4PR12MB6253.namprd12.prod.outlook.com
 (2603:10b6:8:a6::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6253:EE_|IA0PR12MB8716:EE_
X-MS-Office365-Filtering-Correlation-Id: f3ed492e-877f-4354-4ee1-08db5d3c7c0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uCTiAItu73J5dDm1r57CxtwTq3DRAwF3R1fYQA7AWO/9LjfV2iVer1r34IC5DCuU8Lm1NaofR7Hy50coEFTrtgInd43WDgsPcMInVlAPvCL078OhwTT0ITHRzn9z88fgLw3TjXAbwKM3Sukr3J9+5lQlJG7ptMcOa8Y0JXVx3h7xcSPh/lrPQmQ+lvmzT+mUrtXGnW/3uVA52734kWWrJvwR3zpBmCtTA+9b6LZBU/uNH+7TDU+BhLy9UVbv4srPD/3DwjT+N7R6d3DuhG2ORGPki8We4TvGlxCac/aHa29MAZpL20DE1a007yrHlloX+z6GEtC/KR5HKjbjxV6I1M/tsJ6H0vQZ4zOzJbO/cTl8vMJfgYdNV+UxV/u+KP9URxzBWCs8XoKihbBO+J7Pq75v6sZ8t6PniwL6bKzOgTLwbqlOyRcRQFDN2e/ZZRubIPmmiHK4j6Yx2Om8FPoLjsX5Q8vSMYl7VX1jrvE+RfODsGoeJg1dOLlSVNhN0kW2bqo43/mC0Po4kys9mLke1sypDhCku7IqUdbZl/Z4gBkhoC+LYWFgQP8qzi6+uTjfe4f3QOfyOb+ThyPKDDNXyVIkBI7MAZ4TPrU/846VRti7QLsavn7I5/L/E2W5X53kE5Tyc98ulqpOlGqsmsnOH4XRUMMw203SllPhU4ELNoQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6253.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(136003)(376002)(39860400002)(366004)(451199021)(478600001)(31686004)(8676002)(8936002)(41300700001)(6486002)(6506007)(26005)(6512007)(15650500001)(6916009)(316002)(66556008)(6666004)(4326008)(66476007)(5660300002)(66946007)(186003)(2616005)(2906002)(83380400001)(38100700002)(86362001)(558084003)(31696002)(36756003)(32563001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MjFXQnZicVFERnNMcERzUEhzZ2NKM2hLUFFuZkJRUThodCtaMnZhblplcFhv?=
 =?utf-8?B?dzNqYURqYVJjUU1ML281aFhXNlVYdHVJQ0c1STRmQldHczc4TU0zdXpaWGRK?=
 =?utf-8?B?NExXT084dXRKRmtuZ2NyaVhxNE9NVjBmUmpDckF4T0w1V3BOdjVrQkEvRXNH?=
 =?utf-8?B?RXBjNDAzNzEyZWFrVEVyZkZqUitBeFVROVdjS1Z4M25ueHM1VEhqdjN5YndR?=
 =?utf-8?B?MmZqOWJrZEUybmZpcEUvdllESjlTT3NXTjhxOHJPcjU3OWRVKy9XRUpHaEdT?=
 =?utf-8?B?ekEzRlhsRWthMldRT1IwR3d4YUZwb3hrc0NXT00wTS9OMWdKUWVTN3JQWS96?=
 =?utf-8?B?TTV5RjcySHVmenMyR1hmK0pSd2dTenIweDcyemgvYlVNMldMbmFQVDFOY0o1?=
 =?utf-8?B?K1J3dnA2blVSQXp5dWZ6OG5vM3VCSGlBRGwzMVRlQkQ4VHZVbk5rYVpxQi9T?=
 =?utf-8?B?T3VKV1QxdDhrblhkVjlYTkFjZmw1TWF3eStQTDRYYUp6dkc0b3FIMHJsbERs?=
 =?utf-8?B?bVdua2hqWUhIbkxOSkUxMDI4R0gvRTdCS2ExWnZqWnYzZXRzTU4vMGNsYVFX?=
 =?utf-8?B?TDAycDcvVVh3QzZnNGMvdXRhT2huRlhValc3cktIY2RzMkEyY1J0R1ZKV1lr?=
 =?utf-8?B?aTVsZmV3MkZOeFhHaFo3WnJ3anZ4akd2dFZHd1ZFMnNySTdPQVRjK3NFZ3d4?=
 =?utf-8?B?cXdwc1hKTllSdlY4Nk5mbU1VSEF1WXBIajFWbUJVMFpLS2RvSU5WRDVCTHEy?=
 =?utf-8?B?T1VaTHVGbVYxQUE4RW1RMVNleEZmcDVLc2NuN29PVngzY3orOHNTVEEwOU9D?=
 =?utf-8?B?UXc5WWZic21zY3hPRkdtdnRvalRTcldIdkpuOGdMNjV3QXlwWXIrR0NvQWRq?=
 =?utf-8?B?M0w5R2N4cUJLY3JIaFFlY1FTSFBlQXRXeDNXSTl1czlZa2hFNk9kY252VnZz?=
 =?utf-8?B?TTBsZEJld3pHbkk2dUR5Wks0L1dxaGEwZzBFWTdlTFRmdlUySzArZTl6QkJk?=
 =?utf-8?B?dzNHVW1pTzh1OGxpTnNvTE9EK0pYa3gzZEJnb0k5UnhvanZJbzJZZFU5MTUr?=
 =?utf-8?B?bHEydzFBbFpHVi9TSGhEd2hDeDAybHF6aEQ5M3JlaDd6S2tOK1BFcnZrc1V2?=
 =?utf-8?B?SUp5dHBCUW5ocWd5bHR1NGs3WHVWZzZRaHpEY0tCM1A4Z013SjQ0UU8wUkdK?=
 =?utf-8?B?M3pOR21ZMTgveHk5RE5DRWx1UklCMk5HVkI2RUphbTdCd2p6NGVHNFgwbmU5?=
 =?utf-8?B?VnVqQjZLdUxOUHZmOHRaUWVrN1F2TDBsa3BZY3BtdVNMbEcrZjNMT3FiTFVn?=
 =?utf-8?B?cmlRd29qbjJZbU11SHFEWllKUWZrN2d4dUNEZGJyaHN2TE4valZuSHZZTXps?=
 =?utf-8?B?NzVmSmFHaGUrZUZqS1ZjRDRrRkloRmdkMFhGa2paZExKWjJ3aVZpRXhvL2RQ?=
 =?utf-8?B?a1h4dHNKMEVhZlltOFg4b0NyVEd3cHBzU1dFekk4L0owSUtpdnFlYkdHY0cw?=
 =?utf-8?B?RjZ0dlpVaDhwdnpYRytVUzBvV3FCR0E1WHRrTlBLS3hCQVI5WDhHVjBHU2NB?=
 =?utf-8?B?ZHNPcHdrOU41WC8zZy9CNXBJL3pKUkswVlBhcU8zekxQWkJqZGhKekJ3enkr?=
 =?utf-8?B?SXR2WTBHR2tOZVRwYlg4Qi83TXJnNVpDUTBhV0xoMGRjN2ZhQyt0TjlrVDhF?=
 =?utf-8?B?VFp6NU10bDA0QVZ1RVBWR0taZWZoVlJnY1lpbmlWUDFabTVhT3VaRWdJUGpo?=
 =?utf-8?B?TW43WFBhUDI1eUgyYUtHY3F5TTVQbTlvTXdvcGhYQVE3ZU1jZ3Z0cDJNN1B4?=
 =?utf-8?B?cHAxWUR2TXpFOUJTNUlYTXJHV1d5RTU3SGxSY29OZ3lLVkNMQVJMbjhDQmwv?=
 =?utf-8?B?THluc2QySUxYOEp2WEY3dnZTcjhDeVE2YlpMekNGQmZib3luRmpaVUdVMzJZ?=
 =?utf-8?B?SjVYcWI1THU2aitORXdqL3pBbDQ0akNIRUNJZ0FIOExhNC90RDh0TEZDak5T?=
 =?utf-8?B?M2htVlZ1QWd3UDV1aFU1ajlUSEI0cXE0VHVrbEV0RFhvZHFzYmYwY2IvUDIr?=
 =?utf-8?B?eVlZWkp2bXl3a1dVdzJJYUxBWHVTemdBYUowT3VHZEpkam5JV25iNHpDUEVQ?=
 =?utf-8?Q?fKjGrTV/ftTyG5GnQrUsfoZvu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3ed492e-877f-4354-4ee1-08db5d3c7c0d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6253.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2023 16:24:16.5508
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cwi6f+bHoSbpL9gLP8lxuSyl365z2iV9ipqm4G8j4XRB4RUUmU7IG75G7/oOiabPd9qb6qO5iUaIgrKc4mKXEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8716
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

The following commits are required for stable 6.1.y kernel to fix 
suspend/resume failure with AMD Navi3x dGPU.

	1e7bbdba68ba "drm/amd/amdgpu: update mes11 api def"
	a6b3b618c0f7 "drm/amdgpu/mes11: enable reg active poll"

Regards,
Richard
