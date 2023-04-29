Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 095396F225B
	for <lists+stable@lfdr.de>; Sat, 29 Apr 2023 04:13:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230307AbjD2CNw (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 28 Apr 2023 22:13:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230249AbjD2CNv (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 28 Apr 2023 22:13:51 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2054.outbound.protection.outlook.com [40.107.223.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB8B119A5
        for <stable@vger.kernel.org>; Fri, 28 Apr 2023 19:13:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TFI7W2nRqI4//6e1VbdPk0cWpHssthFGpDZ9uTgpomeoQzsZa+dlejy/YRJjGzavL1P+SBOBYyZBlKaLT5Z9LyCK+geIts2DdtORDKWmJdx1recpO7jhyjCiG6xlC+dBdxYAK9L7wIjKrFosjayIX6EjbzpI2mP3K51kfHCBpuQhvNlsOgZje/tnvveCfPFYopFBYYJ2EDY7sZ7slfNQ/eMq7DiAYwPifnYQ8wi1OBlthAp4e0XOqXPOruMgrqXVpm/0zmG6iivkmH1rZvkG43qe24onsk+YRvDwwfAgR0G+KY5mQMhrKmQOhs4I1Ptvi4dL1EJUlSelOi7aoTtMYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1t8iWOq+4xlXjjBkWWz+Vk11DHt5MaJCkcoB21GoDVM=;
 b=X87NpVVg5YCIJZMiq4FehmW+0XxE91zpTFM6cmDyh6DeRm1vTF51auboooTJjirolRqaxrSZo1VNjZT9gUiC0/V/rbZ8anDWZegC0zYKXsp1eh7GoTgP2CLSdbknca94xhLHonJxfLwB3eMvMLlJY8aFgUBaL50HrrGmChRRKhlfHnPJlmUOtmoZInAFLVmgiois6VjAwX/CrywYXt1M/CmPm6llR57l2Ut6gmWUMlyYuIjJFv6aPv2CZpGrnts2KlIRiDJPHbEYb48Ou+HT0H+ht1xitSE6RkSlohX8NcvXfUr/3fat78ZfIUD+zCJgxObBJIpg5Cn8zp/z1gIMLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1t8iWOq+4xlXjjBkWWz+Vk11DHt5MaJCkcoB21GoDVM=;
 b=nTyGzjoxQ4ah9cHIGoE6bmsOTfJDLdXcsZED62mCwnpMZur2S9Iq5Y+E3S58/oaYQquO3XfvAjZV8jd3GHVQuVqBCUCjJSxrWcLv7aa8lPg0/c3OXwZEiWkV7UjLLVZZw1F+lwbHkEeGJStyjReE/wa3bu6VHqFuxKU8AsBy6Gc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DM6PR12MB4911.namprd12.prod.outlook.com (2603:10b6:5:20e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.24; Sat, 29 Apr
 2023 02:13:48 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3f45:358e:abba:24f5]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3f45:358e:abba:24f5%3]) with mapi id 15.20.6340.024; Sat, 29 Apr 2023
 02:13:47 +0000
Message-ID: <d0503264-3443-ec6e-c68a-b1768a9e8c1d@amd.com>
Date:   Fri, 28 Apr 2023 21:13:46 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>
From:   Mario Limonciello <mario.limonciello@amd.com>
Subject: Mediatek mt76 issue
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM5PR07CA0100.namprd07.prod.outlook.com
 (2603:10b6:4:ae::29) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DM6PR12MB4911:EE_
X-MS-Office365-Filtering-Correlation-Id: 59d5fe13-7a99-41f1-530d-08db48575dc2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j5HiH0F2A2ijVDYCEvdQkvvjbhbhBkAvLJnciqqANinlqTjZ+FzQS9ddrKYcRUI8TEovqIC7tp1LSdxIS8dbokNRMmQ38qsoxxPaKPgV1zHhnchL7HngEdaEeGdnUkWfpccqfG2VVDqWggsiNj/WkLOznsHCdHSX1UnvLEPiSXmTPBopu6/4yAn9DuZv0uGMHqdR8Y0qFLh+O/bSFYZkVXbc3kyi294vbVIDGBs8H8Xn2iGJRd2vKCg7L+jb2XSx5wA54S5R01/Ee5uzALxzCD2gKFdVzWv761b8cHFxrpoRnuTrZPiKnBZ/cxfYs1ni99SGAvI/9c9E8/+mqPOOiGe2uCf2+x1AT3nF1snCG0SP+ifIvVt+G/LVDLosdRrsfFYWGYGfYbFecGno//bHQ/+J9j/t3cVsbKomwuwzcGqP+Rt1RQxbLmfLpCCsfkUKzqSPs0iq2SwogY1kb67A+mPhR6STSGE5gdv+dzNbw1341A9xfGHdSiXz4ZUYEeAPubNFXY8UghP9uJ4lY4WsT4dO8Io7pNynpQcemSRiDZKyfnmPJtttjgH1Cl+CyaxJRy29XMMIge+LFiPZH6AWPm9GmK3B+ZpTODOvcnBzUdtmJ4ss7FY9tLDSPLZCzHZxRnO/ppKjsiOw97TFz/GGLQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(136003)(376002)(39860400002)(366004)(451199021)(186003)(6506007)(6512007)(41300700001)(6486002)(31686004)(2616005)(478600001)(44832011)(38100700002)(66476007)(66946007)(66556008)(6916009)(316002)(5660300002)(2906002)(36756003)(86362001)(31696002)(7116003)(8676002)(4744005)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZGZsS0p2OGdwRWFUdXBRcGtTbUY4R0hlWWlFcjZTOG1wK1MwMG1TVjlLZUt3?=
 =?utf-8?B?WTFyNzRmbFJyZTk0S0U0aTA4cEQ5cVRkcUFXeVBGL2MxNDFEd1dGRlV5Nm8v?=
 =?utf-8?B?ejUweWpMeUgvM0tKa2V0VUZVSTMxOXpQWWhjakdDSGE5elJFMVYzY0w3MWRY?=
 =?utf-8?B?SFFUV0lHM3dmOE5HVEQxU0RLODA3WjNua1dKcDBBcjQxK1N5VS9VQjRBS2Vz?=
 =?utf-8?B?T3hZMklxNm9PMWsvZ1VWRkJsdTRDd2hFa1NSanlNS24raTh1TWR1RXAvcTVO?=
 =?utf-8?B?UTZTeFRvVUZra1ByVXFVL3JjYmxOUk1KYUxGZ042UVh6RnNreDBkL1RleFBm?=
 =?utf-8?B?QmR2UW5vT2NIMjhtcFY0cjJac1lYVzFZQWdISWx0UkE2elVubFlrb3NFYStS?=
 =?utf-8?B?L215WUVCbENWUEVnYXY5M3ZQaHRnaFowU2h5UkpQRkVpZ0lUY1JGdHArR2Zu?=
 =?utf-8?B?RnhtZHpySXF5dmh0L3ZQbGYrbzJBQTNMdjNjTmJvcDdnYVdMMDBRdEdYVHlu?=
 =?utf-8?B?VWIxdWtib3l0dGtlSU1xQnR5RlUrSTRFOXo2VWxkVlFzYVIwb1dDOUJPNDZD?=
 =?utf-8?B?OElIY2YxTktCZHd1MU0zcWFLOHhJRXJFaDlFRENiSlFhY3FQTFl6dEdUV0Rs?=
 =?utf-8?B?dkhSaXpEd0hnMVlhOEM2VmMwckNlb0djT3dKQWorbUIyRVVDTHBCMGhUTGVC?=
 =?utf-8?B?QVJZRDFkWEpWenk5NjlyWW52cE9kdzU3OTMwOW9CQkZMcTM5NU9vckY5cjRk?=
 =?utf-8?B?bGlNdTZLVWlhSXZvVGZPUjZXNUN3dzB2Wmo1MEdmb2N3b1BaeTZUYVJFaWlQ?=
 =?utf-8?B?bGlQODR6Q2xCamtIdm5VLy81WVNXY3VTc21hc2F5VUp6OGREdlYybjYzTDRw?=
 =?utf-8?B?SGJzNW1lUExzU3U4cjBhOVA1NndGOWhES01MMnVxRlZvWkJTcEkzSkRBc0xP?=
 =?utf-8?B?U2hNNzFjWDdIemNEbHVicW9xVXpHTlZxdUM0VVNYVS9GaHo3UTQxVkF1RDhm?=
 =?utf-8?B?aGhZbEk4NGl1ek5UUjhudllvV0hiQXlHYzViaFk1VXQ1Zm5ma3cwOHgyWGp6?=
 =?utf-8?B?SVl0MlBVWjg2K3RGSTVMZ2xDNXpYeTB5R3ZCZTB2d1lCTlpocjM1MVcza00x?=
 =?utf-8?B?NG92aGxDbTNVNmRUNmZTWWtGNmVRbGNOTTF0aUdyWWxWZC96QXVpTXlnVFUx?=
 =?utf-8?B?WVcyU3QwcnNSZGVJQXgwVVJIZk1KTlVESHVyeVlXNmxPcW1ubldzaDA3bzN1?=
 =?utf-8?B?K3l6VldoMmkxeFJXbFFGR2tsOUJEejd2MHZ2UzFCZkphMkFVWmNjYUlVaytr?=
 =?utf-8?B?ajVHMlFyazhJYWh6eEs5dlB2ZmFacDdrZC9XQVpVUC9KMmlLelFoNHN4d29p?=
 =?utf-8?B?ZkFOS2JjbFB3ek9ITzZMemZ4bzhkcFdJdHpvMkpEZUZwcGVBZkI3YkwyTTFW?=
 =?utf-8?B?RmxKalVZMWVPZGVWR0hpVjNCTlNoUFMvYmEyQVJPRHdlQnFrb1pYL21aNWdZ?=
 =?utf-8?B?SFc0cEE1VmJIQ2Yza1ZUdWdHSFdnVmpSSlRhdEJ1M0lxaFhUMzlrRkg1bHk0?=
 =?utf-8?B?ZzNtd285Y0I1Qit0MVFVbzhjOGJMTGNPbnVSSkNla2VrNTljekNSZmdkdklx?=
 =?utf-8?B?aEx1bEY0Wlh4Sk94czhWM252V25XR3hjTHZPYWJxVjFJb09STnQxNFpYN2c0?=
 =?utf-8?B?L0QyZlJwdFRaNlV5MFVUQm1mZ1lteDdYS2FsZ3ZobmtwN2lUV2xOdmo4b2xJ?=
 =?utf-8?B?MGMxR0NwRXZwOUtldFdKTTV2em9La2NVSlFPM0diNEk5b05QbEFmeVp4b2Iv?=
 =?utf-8?B?QjE1TEgvSGhnbitZTDRDRW5zUTQxM2tLdTJ4MDZWTEI5V1J1YjQyWWhsM2lX?=
 =?utf-8?B?QitvbzFLQjE3TzUyUU1NUGZjVDNSUGU1ZEd6QzNSeVM4ZWdzSmV4QjJMcmFZ?=
 =?utf-8?B?dEVrdTJ2aGR3QWFrdUY1MzYxeThTeC9maSs4blViZk5tK2phOHFOK3c4MG84?=
 =?utf-8?B?YWxyTG5iTmw5STE1SVpLWWhnZWFIaE84cVBvSVJQMGFRUWRsSUpWQW8yY1BW?=
 =?utf-8?B?SEV4ejVwZmtjK3M3RHJXZ2FuTlQyUHFrVDI3U0g5L3lvNC9wQnhEUjltQ2ZI?=
 =?utf-8?B?blBpanljVlJZUUhMaUpBVzJGdXRWR1htRmw1V2lYUmhDL3RENkRuclJrZThj?=
 =?utf-8?Q?6mw3F50N22nmRG52QYFNFaG+jLuYsiVz2kR62a4g4PG4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59d5fe13-7a99-41f1-530d-08db48575dc2
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2023 02:13:47.7049
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EWgbT2ZUKxk4SW/K1iELJmoHhbzBcXV6YAK5gvDzCr6f3ha7wOoCdevzEPttoJ5on2SG/JHRNr4sZaqaQXArsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4911
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

A number of laptops with Mediatek wifi the wifi doesn't work unless you 
turn off fast boot in BIOS setup.

These laptops all ship with fast boot as the default.


It's been fixed by this commit:

09d4d6da1b65 ("wifi: mt76: mt7921e: Set memory space enable in 
PCI_COMMAND if unset")


Can you please bring it to 5.15.y and later?

Thanks,

