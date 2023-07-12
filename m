Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A1CF7512C5
	for <lists+stable@lfdr.de>; Wed, 12 Jul 2023 23:51:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229480AbjGLVvW (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 12 Jul 2023 17:51:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231867AbjGLVvV (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 12 Jul 2023 17:51:21 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2044.outbound.protection.outlook.com [40.107.237.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD27F1FE9
        for <stable@vger.kernel.org>; Wed, 12 Jul 2023 14:51:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HhsVx9xo4BFEDlJiwJ2juiIspKqTrOP7rNQffXmhIT9nQqHMuQ4HT+YM228D1/OXv2SNK95yg43f46JMf+/dvaBsnZTurUE+Fq+gI7d+lsEagyEQLJoE8WdABDptebnp9UwhCNmhFf2Olc6Qxw/4VxtP2y9VJ9N4QSdR3beacQg/J6FoCgx/87lkc95Q6yFMLcABCI6rST0H/glwhO9e7AwFZc1YH+tWyOaiP4wJ04AMXoRcPJFUEGJ4cmueZn6vgiJw67wU7tM/qCITtQ9Eh0WVCYxcWwZO5pWunQIQv8wmFdiEKh0q5/az0IIgUbjHf2rJFdFPcEuh3uASRuokLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8qiLAAAGQzuvmbopfhI4fJ4qKVjUV3Fm2obWe5YudBI=;
 b=RBXMuWLmQAfsJLPf/FZYeWHKcYZP6RuWD5ech+OTBQvTtiWP2BnEKpnMda1PpHqSC75t1AVKH0dtqiA6TZx3bG47cOYM99y16Z6OH77Ig7eZ/3M/wjH+5rAlyf1/72TPe7a7bF25eEO8cjIcBgARxzaldvOLIy55rzNtEBDKR3zED8DCHZWjbgnRfvcAoWDBqSUOoesYVSIrBKPYK0rfcyTaGJk+tk2Bgd2TIC7OTrwxy6ixwYrPCZUAckh1sTgOMoYCDdupPNpJwuzU7dJvuMOxU3Irx5SDQX3PxzHeXDyjoWguOm9EbuDVrhxFOCf7xWzfP2VAjTiYl9nxKKeNmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8qiLAAAGQzuvmbopfhI4fJ4qKVjUV3Fm2obWe5YudBI=;
 b=PpNsXbdXgPoyxAUJo+PSbFW52lLyy6OvXX0k6k8wBJH5hSEIFkY7LWj+LfA15irEf2qerTr6ewv9AEnfX4n356ka7VmqH9T+YhPxYzsu4nmqWYFk7jazNhP7LBpZPc2V4CixvMxRLH5PPotRY7V1o9vhw1Qh9qfOhS8LI4xjm9o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by BY5PR12MB4114.namprd12.prod.outlook.com (2603:10b6:a03:20c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Wed, 12 Jul
 2023 21:51:18 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::bce4:716a:8303:efcf]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::bce4:716a:8303:efcf%4]) with mapi id 15.20.6588.017; Wed, 12 Jul 2023
 21:51:18 +0000
Message-ID: <050d87f7-5a77-571d-f5c9-f66f39ba2f2e@amd.com>
Date:   Wed, 12 Jul 2023 16:51:24 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Content-Language: en-US
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
Subject: Mark dGPUs as devices
Cc:     "Pananchikkal, Renjith" <Renjith.Pananchikkal@amd.com>,
        "Gong, Richard" <Richard.Gong@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0147.namprd13.prod.outlook.com
 (2603:10b6:806:27::32) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|BY5PR12MB4114:EE_
X-MS-Office365-Filtering-Correlation-Id: ba99bc79-cd36-4505-6cac-08db83221f38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bKCpJ2bSHjx4x+V/ZFSaGqOlZYM37oPI3G6RwG+rcuzGr82CEdvNKl/0NfB2BwQ44BzEoisTkbrIANJX5j0ytwl38tG5F7h7JVDj+yVExpPYp94+L+8THp9kN7010wzm6Jj67ThOtHBAmfxvlkmom9pa6SkKWeyCbT/Rr0GjpFO5SxXya3EVHgkeOVSie/l4tfe+1RCcsZksvP9cknyjP1m8nCEg2eII2zS4jpEl+vi3DtsV+0y6lXT3+0oF+iVAQhNocemnPm50/KyB8H4MYOQ0NdXJj2TjVnA9vVgytJRhZQ1RnsfxcgCpjOcBFWA2eCsesZdAsvlvo3EvlfjqKQajBfYevxMcSoEce64npjioFz063wApJePCuuZGgKiBYkycd1has9lWNS0MkQCEKYgMGwgSPWMJ6x+we8d0ooWRnR0SAQIxR/o91P9H39Pm+i+bzWZUmC0QXt3Q9uVjQsuh+97SySXV2X1xE/oZDNi0QrDCq/yR+rydBHybMpVpeJQxhQxZj3yigcZXnR5c7JLOfYD9bkmNaOXuaJ72buQlaVDC+S/fXWWzJQNbNi9IpBfh4e6tuqyemECGTuqf/gtdJ2lgfX0PyeD366Y8QMTkZ2Y7G4NduDv3I7ja/ZerPVS2k+JkZKGSUayzas1KHQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(39860400002)(136003)(376002)(366004)(451199021)(4326008)(6916009)(66946007)(66556008)(66476007)(316002)(2906002)(4744005)(41300700001)(478600001)(8676002)(8936002)(31686004)(54906003)(5660300002)(6666004)(6486002)(6512007)(6506007)(186003)(36756003)(3480700007)(38100700002)(2616005)(86362001)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K3VPTlIzUG1wVkYyZUVmVG5vMWJEUUJSakxGOUhJU0JNWmNmcDFRVkxwUEg5?=
 =?utf-8?B?aHVrdThwR1V2enR3RFVtYmNhZlZvdlJwdWdFK3V3OFlwTERzRW5BUDVJSy9r?=
 =?utf-8?B?VlNyaXJTSlJ5cXdpTlkycUlXK3FFVVdKR3ZsOC9JTGYxR2VBSXpvQ2Jya3FT?=
 =?utf-8?B?NGppVGthOEw0c1gvV3pHMXdpUytZYnpIVkU4UHMxNVJUeWl0RW5INmNzTGNw?=
 =?utf-8?B?dUFjbnZUaTVvbXB0WXZ0TVplcmo4eENMWTF4M3NiNFA2Z2QrWVFRemo2ZW9S?=
 =?utf-8?B?eTZheHVaZndxeFB4VmZoeDBqeUdVRDI5N1dNcTZ6NHJsWXNaM0FwSHM1RG0y?=
 =?utf-8?B?c3N4RlVvWHhzc2ExUkVNVjNpS2pReHQyTVBNU2RtMUFZNWVzbklWRWJWcWZn?=
 =?utf-8?B?L3QzVDl2b0FpNVdBUS9ENnRBVGJPeUVUSHJybXhOaU1xb0xkMms1TnA1VEEy?=
 =?utf-8?B?ZVFHSStJK0J0NHZWSzR3K3dxUDhtSE1yOXhFYzNFZmxlNU9SS0hUWjhzM21M?=
 =?utf-8?B?L2xkU014Qjc5TW9DTUlFT0lrVTR6b2lJeTRpRjA1eHluOXllVS9ZMzlTR0d3?=
 =?utf-8?B?dHhWQmZkZUoxNTVaZmVERU9Oa0ZVem4vRmdRdUVTcE9xVXpQQVQxN3FETU9S?=
 =?utf-8?B?MlZGeHNZS3ZZbVhMRmNkcTY1QWI5QTFidWU0c3U4TGlRTnRvZUF3RDNSTUZE?=
 =?utf-8?B?bG43N3g3Y1RqTHA5R1JmdjM1dXNhQ1B5ZUhFZ3FlVU1kdEh1Y0pHWG9wcmhy?=
 =?utf-8?B?ZFQ3OENSdTRSRmVmaUJ1MHRxS1VCamd1YUtMU0hHN3dpa2pIYnpsbFF0dlJX?=
 =?utf-8?B?dFd2VEpyMGZiRjI0dE1sdHNrS0J4cFdWUFpJWDQwNGthOHBqZUlIZHQ5Tmp5?=
 =?utf-8?B?N1hzT1RWUDR0OTFHM0paR2hmL1ZEbFNvOTNyZkRHNjh5WDBCazd6RTVEOFJT?=
 =?utf-8?B?M09FMVpHTlpJVnNzMGZtMEZQVmRXMXh6Qk1hL0NmaDhRV3hkdDlYdnduTDIy?=
 =?utf-8?B?UG16ZGJadC91YWNtbHdkK1lkUmtCWXBFNWNsSjNrcGdEelRSR2VTcHNUdkhT?=
 =?utf-8?B?ZTY1czRNS0Y2M1pRbnNwczllQVduS0F4MS9oTU5TdWFhSzhqVWZHMWtmYmlt?=
 =?utf-8?B?VklsODl4SnJyYzcvZFRvUnIwNUpWOGkwM3FNUEpBbFBsRWdsQ2ZpbFZuNjQr?=
 =?utf-8?B?UytmUkIzS0oya1lQdGEvVGpvTVBYSHFjNHdURVZUZkFjdGxIR1pMSE9Ubkl0?=
 =?utf-8?B?VnZESlhZYmE5bVZIUWNqbHVpV2RxRE9NcGtITkxkQlVnd2h0QUZKMlFsVHRj?=
 =?utf-8?B?akJQSVdaZnpLUHNpdWdCVmRrSTU2VUxnbnZ5NWMwYVFMNjNlejdJd09EUHZ3?=
 =?utf-8?B?RzhnVEMvY3A1NXdHaGMrNnFtUVZQZDBKajhXZnJDcEpKMjc5TlRJbnhaM00x?=
 =?utf-8?B?VW5keHBtZ2ZTVzBxZTBsdUZ1TUZDajBmOXZ1TWtQSkVVQVdmVzdHMTlnMko0?=
 =?utf-8?B?UCszWVBwaEV4VnlKRjJ2WTNlSDAzaDhYKzB0ZWh2b2ZQK3FUNWJBSVVUR2Zz?=
 =?utf-8?B?UVRnZnN3ak5uN1E2NFdNTllhL1BYbTZkdmFZNkxDbkVzeWZZUkQxY0R3OVYx?=
 =?utf-8?B?OTEyYncyd1VBSkkzQ1o4b0w3bjZvb0tyekxPM1ZxS1krN3R4S1VTWk5WM1ps?=
 =?utf-8?B?UlBTd08xTjZNUmR6RlBldHFqYlhqZ2w0dmpwaW1ZZ1VIb1lRN0xneWs0ZEpt?=
 =?utf-8?B?YWZKRU51dkp2N3doeWRuQVRpR2Q0cVVhN1BkWXJOaFlKM05sZkhNM0FGc3pH?=
 =?utf-8?B?Tnh2Z21KNG0xWC9BT1Flclh0V1JWTDVDdnNyQ3ZITzBqdE0zUGEwcjZjMTZE?=
 =?utf-8?B?bU9ad09ZNW1UOUg2UUZRaDkrVHRQalc3S1g4Y2tGUk5scmhPZ0VFcW1FbzBX?=
 =?utf-8?B?K1RKZGxjNmZpWDJ5dkFINlFBKzNDMnFjN1QxQnVPbjNMZnBEdXNoUGlBM3Ri?=
 =?utf-8?B?TTdlNFN5b0RBRmJGQzBSOTF1WEI1SlJkWXRxZC9MYU5oeUV4eUh5RGlWdmhG?=
 =?utf-8?B?YUhhWlpXSEtnVTgvbTRBZEJBRjAyNzZGQ1N2NS9WK2RtQ1BlaDM4a3FPRzRM?=
 =?utf-8?B?QnhvRWllNlgxbjBLeGIzTlBQa1RWLzhJeDFTVXN1VVVBNExJN1hZZjRJVVI4?=
 =?utf-8?Q?j6rj8okYBEu9qxYFmU6Lnsd7GFiGh9o9ypyTCZVGfibz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba99bc79-cd36-4505-6cac-08db83221f38
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 21:51:18.1491
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WcqcKO1B82g9+8lCFC8rQwkeTlZuShtPRgf4ojS/aAqXrz5k+eOoGq4tSPNAsTsjKHxIZlLPEv8eQtD9VKXYIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4114
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi,

A problem exists where dGPUs with type-C ports are considered power 
supplies that power the system.
This leads to poor performance of the dGPU because graphics drivers like 
amdgpu use power_supply_is_system_supplied() to decide how to configure 
the dGPU.
This has been fixed in 6.5-rc1 by marking dGPUs as "DEVICE".

The logic to fix what to do when DEVICE is encountered was fixed in 
6.4-rc4 and already backported to stable:
95339f40a8b6 ("power: supply: Fix logic checking if system is running 
from battery")

So to wrap up the fix in stable kernels can you please backport:

6.4.y:
a7fbfd44c020 ("usb: typec: ucsi: Mark dGPUs as DEVICE scope")

6.1.y:
f510b0a3565b ("i2c: nvidia-gpu: Add ACPI property to align with 
device-tree")
430b38764fbb ("i2c: nvidia-gpu: Remove ccgx,firmware-build property")
a7fbfd44c020 ("usb: typec: ucsi: Mark dGPUs as DEVICE scope")

Thanks!

