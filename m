Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B425711B6F
	for <lists+stable@lfdr.de>; Fri, 26 May 2023 02:40:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbjEZAkz (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 25 May 2023 20:40:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjEZAky (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 25 May 2023 20:40:54 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2065.outbound.protection.outlook.com [40.107.93.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BB53EE
        for <stable@vger.kernel.org>; Thu, 25 May 2023 17:40:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KstKUiL2nRK4jpxI2WLhSH+S6eEfZKd4QZAneOMF+0t/nxqWVIhfC52DB79ogTQZ36sKNPfbfGDgeuVSelMIvgvHZhVIjuTUoc9p8eVWZ3FbA2N9JrqtNTKggs4F8ouP3sbnUkActasHH5gEvYbmDv7KJ6Py9nPY5cj4pimeya13Me4EFarPTFf+fpOgdz/x/FsIwxSn6c8VXlOOvjiUYARuJoxK6q3yHUlIHxDv036fbBE2AQvzRS6mRYba7R/O9dx66QuCHf2pPxKtWM4qCgh9+GMKdvNABVUoYNvL28Evu7k6SsFosmDEK1ub33nO3+7Ht0l8GKu0YmW2bw0FgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JucF0xwosUZYCkDPiv2NHi8FNcG7uurG/5LOvVQ3DKU=;
 b=XCrgVbU9C3TGt3QEV4f5UVIFvSQpMpm/OpdB98zLJE/YhW3OyD5JVYN4SMxEDS7Spa2f53+mlxIVdjFmhOiF8ZVX33OtuYuXtKR/HoMEO/SK5X/EFSS5QwkVkofq4T9JuBYPWHnEhr5ttp4qwiIh1KPW9k7e4unoU+MR18T2d3yXVeF3dIV12CamJpmfc2SFf7PEqCT0klrqCr8WaVgPWNylmZEjwuvfFMjl16lKpOa1qfJ7UEKrwdox9TbslBX0jBkajsgVBQH5fh4xZq3Yy7QHsg+xk1B0VVHAJoO9OpPzGeQ/yGsCIo4vykuiYEXHLEKWHMXfFumqZUaHvvdp8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JucF0xwosUZYCkDPiv2NHi8FNcG7uurG/5LOvVQ3DKU=;
 b=DOlkjlKmPc2qVdu+DytmtCb8y6eqFvgYP6XBTFHFs0q9wgWpO5Dx989vAzUQQiNa6YcJCF6hTE4RSv/feBDPCwZ+/VjKbrtwvrbsi1QbndDIkGh+8pxCb49XiCOkFnFB6tkrQABOeGYljLj40OvoYSMbFqxgcwrRetUIdQ0uuVs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SA1PR12MB7173.namprd12.prod.outlook.com (2603:10b6:806:2b4::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.16; Fri, 26 May
 2023 00:40:51 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3f45:358e:abba:24f5]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3f45:358e:abba:24f5%3]) with mapi id 15.20.6411.028; Fri, 26 May 2023
 00:40:51 +0000
Message-ID: <67948087-ef70-adc9-0c3e-c1e6e4cb50bb@amd.com>
Date:   Thu, 25 May 2023 19:40:49 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Content-Language: en-US
To:     stable@vger.kernel.org
From:   Mario Limonciello <mario.limonciello@amd.com>
Subject: Watchdog timer fix
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0115.namprd13.prod.outlook.com
 (2603:10b6:806:24::30) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SA1PR12MB7173:EE_
X-MS-Office365-Filtering-Correlation-Id: 487ee8fd-6ac7-4ec2-48cf-08db5d81dafe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o6wuVDVt3nNqt3omYz8cx4ZVvvhEI1GnSvCLSz/pv85yevVtYMEhcYRDQKlsbsGd7hUL2Fxz4vpwYOhk6uGYPMJWxB0028O0UKmoUmkZ9rk5Mc3RO1le97D3JGz5Y7dvLN9FAzrlPvElP46MGhjnjg3/EIz55sbjzdu1EZNvsxBtmY2oVmSl4Qe6UEJfOWVeAzS91Bh946Ye1l215c5UELG2fVD/fujkG4/OAfgYHAmAQgr8ong3b6RdGfIXnxqA7ziCyGj0S5rSJq9+vH7U66jLsg67L5r9rCXNQBZMxp89ZXEDGKxtD8iVmKeyLSyIlM7svqc9/Nql0fk+maJgco3MDf/cLJq0wQ4PQ7tTt4bAzlyZfnTzUIOaVohGB8mPgIbzBlgAn5XBTAI2JklFNq3a6wPMiKzS4P6kMPmTuEvp69pJu7qodbEhMBxwf82pi4fdq3rglwHt1vwyhxoJjUgXHgDNUXQ9ySDcTx+jS1h5U+4K2iljlYUjJVBurGMH/tR2oPmOCLnM0AIcFf5iC9LhVYI7oMfRfKrLwQf0oJQOncgGtRJaT8OZOBxeR2nJS4osEY4tLj/yKopljuqbiH+MtdzKypslCEMa7aSigIKDv6QVqV2ZlXKwazLCVc+8kktsTlrpOs4Z7JUI8Y30dg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(136003)(396003)(39860400002)(376002)(451199021)(3480700007)(6486002)(41300700001)(44832011)(6506007)(6512007)(8676002)(7116003)(8936002)(5660300002)(38100700002)(2616005)(36756003)(83380400001)(31696002)(2906002)(558084003)(86362001)(186003)(6916009)(66556008)(66476007)(66946007)(31686004)(478600001)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RjVTZGo3djc5M0lNMGVCRUdSTGY5SWtoOTlOYVBoV3hYYXRZb2lBRHFjS3dF?=
 =?utf-8?B?UGo0NGhiaDZPa1o0TVN0NDVsY1c0K1lnaDNVU1doZEljUFZZOEwvY09QeFZh?=
 =?utf-8?B?d1ByNUFqTXp3aVVLc3JkN3FLY0JhUk5CS2NKL3YvT0VsckxKQmo3ZjlnbWNy?=
 =?utf-8?B?Qm9jTy9BbHBtR2FKS0F6QXFEVyt2dm5uNk1nUC9tak5QM0RrazgvSGsyRGcx?=
 =?utf-8?B?VVErbnFxK1VVMWtsN1dXZ3BQcFg0WERNZFBCY0JQRlMrSW4wdkc2Q2pnT1Vw?=
 =?utf-8?B?cHBrYUE5MEwxcWQzV3M1Q1hvS1ppdkV0THRQTWxzSStuQmUyd3RKT2xWVFRm?=
 =?utf-8?B?Ym1WcS9lR0lkeGVEMDlMK1J0cXFjTUJNbVlrUU1DVkQzZWxhcm1xZFpKWlZa?=
 =?utf-8?B?R2dLc1pGeXVac3lmei9qbGNBT1NoSmRCM00ycDZUMjhwZ1JDazIvNUd5Yk9K?=
 =?utf-8?B?TklUSk1PLyszQTc2UHRiTmtBZHk1aWhRY1VzUm91UDRpKzVWSStJbUg4N0Jv?=
 =?utf-8?B?cUFEdGhlNzNBanpORndndjNMVVF1SmtiR01ZSDd2VGhyRnlUQ0NxVGFOMTJa?=
 =?utf-8?B?QU4vemdkUlJsK2x2NzBDQ2NKSVVLRmRVUHY5UkoxTkZxTjBIc1htUkRFOVFZ?=
 =?utf-8?B?WVZBczRIc0RSY2poRklWb2RqbGw3WDMwZzBwZVY0T01tSGhKUzRKeFVjSisz?=
 =?utf-8?B?Sm1VVW1TUVhCb1grMyt2VTVoSkl0M29SaC9jN3B5VW1lb01NR201K1kxbzRK?=
 =?utf-8?B?TWtaSzJJaXRkckJOTG91L0Zwb0RXT3lmV1JHbWJkaWhQQUdBZVRMd3dUOUFY?=
 =?utf-8?B?SjBXL1NNM0htTGdDWW9HOXRCRTg0a3RaeS93Y2Q4OCtRM2QzQkp1c2hIUms2?=
 =?utf-8?B?a1RlaHBKaVp3bTZ2SmJzMTJOcnd5U3NDSnVPT2VveGpUL0o2a3c4eWQ0WVB6?=
 =?utf-8?B?YXFRN0dsSURqc0NuVzBab0Ntc0NUVFF5NVNvbVFWWW1SUlZmWnVVci9XdzZj?=
 =?utf-8?B?U3VmZmJkVE5oSDUxMjRIYXpFYXlTb0tkNE9hL0lGOUVwenplRXVSd3NFRU5U?=
 =?utf-8?B?akpNNnFhdmRaUlc2UzFjL3lKV000ZjBFeTJVdldlM3NGaWZjZDdGRlhoekV3?=
 =?utf-8?B?WlJGdm9ZNzBoc1NTZGxjZ0ZmNHlaRDFCbGdkMU1ySy9vUEJNeFQwcmRDZmxt?=
 =?utf-8?B?QllZMytVelVjRy9nU2w0dmFiWXRjWUtlS2luaWdXSW8xY0I5WmZiT0wwTmhj?=
 =?utf-8?B?MDVwSVpHZ2FqTno3VjlRT3VLVE1jTGhyVnRYNHdVWk9iMTZRenkvSlJodkhN?=
 =?utf-8?B?VU4wZ2VmeE9xT2dmSWc4SEVnaFBIS0pvUGFpTTA1b1dNY0pram1wdWIyKzJL?=
 =?utf-8?B?S3d6SjM2VU1ZSko1aGdTTlQ4VDA4cTdYaDkrajRySThkQXJQUXErMXZJK1Z4?=
 =?utf-8?B?TXVWVC9oalNpeDJyR0NLTGFyYW9JUHJuWS92WEdBbHpjMWs1UVRGU0MvVzVI?=
 =?utf-8?B?SWxQeU11RDJJeVZZemRMNER3eU1jaUZEcEpTTGxBeEJibFFPNDlIYVA0Sy9V?=
 =?utf-8?B?TXNOckdRazRmKzdFaW5YWWQyUkh4bjJJVzA5TFE4UVl2Z3VIcEw5Y2lLRitG?=
 =?utf-8?B?SCtCTEZQelpvM2djUUJ4V08rRjh6T1Jab0VncW9LM2xQVTFJSFhOT3RVVU5o?=
 =?utf-8?B?ZTlsRktOWXkvWHpUUUdEeXhHaU9jVUVXZ3hLaG1KZktaUHhIa0RXdHlqck9V?=
 =?utf-8?B?Nkc4N1pKM1MrV1lQbUgwRGxiVGF0ZHFwYTdSTWRyN2d1VXFJSXF6dStZbGtX?=
 =?utf-8?B?Q3l5TXZhemhESWtHR1UrbnI4L1hEdFpYNFhLM3FGRkNVSk8wc2UxQjdOYVk1?=
 =?utf-8?B?U3ZtYURRd0taTTJOYjNlaTRNYXdqQytULzBEYTJoY3dqRVhNUjQ4RkFnSUlS?=
 =?utf-8?B?eHQ5WVFHbFNMazIxZG1MUmVaeXhFVGlqdE5Od0U4UXlabVBYWVdDMm5EUlJV?=
 =?utf-8?B?RXNIZVM5YXdYMzltSmFLcXB1R25HN0pvOXowNzRmVGY4ZDRsQW5CK2M3L0xT?=
 =?utf-8?B?ZmFlQTRBcnQwVWp4ZnpvY01FaDUvMzc0MzBJUkZZcUFBZXJGOHNaZGlyeTJI?=
 =?utf-8?B?ZEFrR2hhaUxMK3o4dHJta3lFODdIYXVyR2JwZFY5c2lTSE44WW1wQzlvbmxP?=
 =?utf-8?B?ZGc9PQ==?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 487ee8fd-6ac7-4ec2-48cf-08db5d81dafe
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2023 00:40:51.1510
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vo/Nlg43ym6zmIT1BK7L/5YW/WWDKxgvEpJeyTpLmYMsEPw0iaboTDqAR7TgRZTUWaFoLPR/cCau8ykhSrMqZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7173
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

The following commit helps fix the watchdog timer on various AMD SoCs.

Please backport it to 5.4.y and later.

4eda19cc8a29 ("watchdog: sp5100_tco: Immediately trigger upon starting.")

Thanks!
