Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9831070DDD0
	for <lists+stable@lfdr.de>; Tue, 23 May 2023 15:46:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236691AbjEWNqP (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 23 May 2023 09:46:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234585AbjEWNqN (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 23 May 2023 09:46:13 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F59911F
        for <stable@vger.kernel.org>; Tue, 23 May 2023 06:46:08 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34NDiJwY003485;
        Tue, 23 May 2023 13:45:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=ABRlEm8RH0g67hbGMeRy2WEKjWYlmU83HdLZf5e+Cy4=;
 b=HG0v0pIBjoC7CW+ZYBfRP4Y5JXLHcA8sUVvgbHb9kEzjEkGTFXzxmnT4qo2Nt4RJB+Ri
 Szhh28JGKRAYcMuz4Ir28AZCdAiyaF5srR5p7mn1vR0Beskz1iL897t158DTvxWMiwoM
 jr4H11GOWc4PYlx6iT4kg3m2S9m+o8b3thfERfmNaTHztvl8JqEqE2CoQXoMzt/+mQBu
 5dnTkHVmoMInI/Lj+Z0ITQBmmWHLt2p5obROeLIH5WmWkkaWZnLDSCzJTGyeMRejAXVN
 cZg/Sf/O1jEIvqpc/YrIVyMCrsJF8JeT28ZObUbmKm/jSKtdE1msA9hAVDYdJg6pZJED Qw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qpp5bn4u5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 May 2023 13:45:39 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34NDOPkI027123;
        Tue, 23 May 2023 13:45:38 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qqk2dk9st-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 May 2023 13:45:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VZZRZabn+1So/BWEYuuJyVYyZmvykCrfv2ymMkWgeez68lG5xXm5xXdZ8iJY63zoXVcRp0AjKbSTOmct5409JitNyIzaf2OTW0rACJFGgNFBX6Yj/8+5SnEI652ns6JIxl4sD8C53SDIckwKV2aZYXlY3F/HeAboKaEElInlOfq+Er0VEYsuME8c4Vr0jIS3+W/ANc9y63E9REB+O5FIuAftfZT6Kz8NX3KKjH+QuADQr4vqDE1X1PqmdVYKXyl7A7Cf1jcmypp21kcNjoDsnwQtvZKle1UnRGoZYzjPyOUwQ1timbXN5XJediUxuZwQO30b1zmbduTRHR9jaXRgyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ABRlEm8RH0g67hbGMeRy2WEKjWYlmU83HdLZf5e+Cy4=;
 b=bkeWUYkoHupaAo2RRCnXCRbOMUwW6ggmZHKV1ncSEFaxUlP6KlAyXtcW1EZUyckID6QiVG+74I4yZyxtg84E6//8aoc/zcZXvOjwFrKIs8TvBouo1OO58XvZztay2FIzlKwRVMIfEwRr2ZOZrh9Xyd6+ZhWLokyzObXf3KVT2pDZOUeAXlfeueRLyzRcvgE0wRUjfEyLIlNIBLLRZeoNtw8wU3251Tyb9VS8SQwNQ+HUYfdUAbZEcv4xBDHWAS3ovJm9wU3KSVw70+bMqmGWg4wwnGgK3XyFVtKS7cIRhRrKsJ6sjLNDK6TP12APCyMG/Ecn16LlB78PN7kG5uCfIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ABRlEm8RH0g67hbGMeRy2WEKjWYlmU83HdLZf5e+Cy4=;
 b=Z97Y4SBJzjQuMzK/fuUAs9qahf00Bt638E3kMX+hNSJD2+jh5aqbZ4FPNt1eVqU8/8qmW2BQfwxKVASG8Rwq4XpvfTlIHEP+h1uI/Ni7F1rF2HVqXXx6mtq8M7TY8HMCm99E+aNMriiCP66r94ReE3WvphIyXbRI4JKj0pwBYxg=
Received: from PH0PR10MB5433.namprd10.prod.outlook.com (2603:10b6:510:e0::9)
 by DM6PR10MB4394.namprd10.prod.outlook.com (2603:10b6:5:221::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Tue, 23 May
 2023 13:45:36 +0000
Received: from PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::bc77:f9f4:b4cf:18df]) by PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::bc77:f9f4:b4cf:18df%6]) with mapi id 15.20.6411.029; Tue, 23 May 2023
 13:45:36 +0000
Message-ID: <e542a9ea-8276-16c7-9319-0bf835f923df@oracle.com>
Date:   Tue, 23 May 2023 15:45:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [linux-stable-rc:queue/5.4 4610/23441]
 include/linux/compiler.h:350:45: error: call to '__compiletime_assert_215'
 declared with attribute error: FIELD_GET: mask is not constant
Content-Language: en-US
From:   Vegard Nossum <vegard.nossum@oracle.com>
To:     kernel test robot <lkp@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Daniel Santos <daniel.santos@pobox.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Felix Fietkau <nbd@nbd.name>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <202305210701.TND2uZBJ-lkp@intel.com>
 <07135e22-253f-cfdc-dbba-0e5e670c25e9@oracle.com>
In-Reply-To: <07135e22-253f-cfdc-dbba-0e5e670c25e9@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PA7P264CA0215.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:374::20) To PH0PR10MB5433.namprd10.prod.outlook.com
 (2603:10b6:510:e0::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5433:EE_|DM6PR10MB4394:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a63a586-747d-4c3d-4195-08db5b93fc8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UTg+UGfjUr1UwQkD9XFPP38L7m311fUm58YV0STUIhTreKwQV65pNddYKGFjCe4BESiZIBaXWWwbwTaGT7OUD2mQCjZvbPowF+sVS+vHz5o4bYnc755Nxi5C870sMbfguTRbF3v4cJqoyjQdDif078m/k6CU0stLux3f5uzAk01MFFoc3xnJmhlmMK9+/I+mtDFcQNiaH39uhxZYhh99Vhl8dxgVqF1K66fPUH1h6FHY6TrXri1BYmpR/LzK2D+1uesI9aRPSjWC/lBgnF9DKfNhTUoRe5yyPnI6QloOgHy8yFfZRz4P/sde3nZc9+V4cq8DlmmFPFC9MQfdPBtoMBuK7qBAoG57zb8yrkgbW3qXNE33JnJpz0xy8CFn8qV/VCuw6a2RNSe1WWv/wZztE/nHuPiZZa45q9K2JZmLGs7rqymJ2aiVuEiujwui+NF0QQsB74PX3oZJAVUnKGL/hHE+NmtRpbtJO2sMR8KmkISOHapCdHP2ih5U26bDz+nq+ieokI2YvStalTjPTaC9HYGY+Uc5emFjIIr0CggTRvx3dDjauriL/MzNR5PGh7/1G6SUx3R33tl0Q4b0yzArTrXv74O3/BMi5slzocfKUmgsJjKgFrWztKTkmSFZUeQAZbqp5Lb/VxfeaNmIUG4VQxnGi78GoFgObHTsvNizwWfhhRcNT3sn0rilBIbAacAt
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5433.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(366004)(136003)(396003)(346002)(376002)(451199021)(7416002)(966005)(8936002)(5660300002)(8676002)(83380400001)(2906002)(186003)(2616005)(36756003)(38100700002)(31696002)(86362001)(44832011)(6666004)(26005)(6512007)(6506007)(53546011)(316002)(66476007)(4326008)(66556008)(478600001)(31686004)(54906003)(110136005)(66946007)(6486002)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L3JNWVdTTnJjZ0lkNVAyNk0yUTEvQXhHNllobis1Y1VGdnZkRFFXU1NZLyt4?=
 =?utf-8?B?NklaTlQ1NmdTcUIrTWladzRjNithdDgxSHVjSGRJdUJHQmdkblhyV1k4MFRa?=
 =?utf-8?B?ZHJQSElzQ05RSHVrQUozSEFPNjBFZkdCRjdHVERCR2RhM2pvOE5Dcit1WWNG?=
 =?utf-8?B?QTlzRHJjOVkrTGZ3NnhYOHFqU0kzbWVFZHZzM2twbWNkVnE4NjZUbjU0Ui80?=
 =?utf-8?B?eXEwVUJxeXlGSlZnL0lMeTV4ZUJSVVBRZUNLYnZ6QmMwOUREUFRFNnBTYVVS?=
 =?utf-8?B?VGxVZE9XeUhWZVNmTURxUVVrbEVrcGI0QVFudzdIS2J6MENnUHlwdEtadXg0?=
 =?utf-8?B?bmp5RzVXd1Z2QzNaUUlKRjNqNFYwNVR2NzZuKzhqTXIrZ2t3Q3pXUFo5aXVz?=
 =?utf-8?B?UGovSThSRThYTENYWHRyN2VjS3pCbmFJRldiTG5xOTEvMU5VUDR3U2thbEpG?=
 =?utf-8?B?emh3U2l6R010VVI1YmlMcytTQXJqUVpFb1Z2VFFwSFhZWkNhUXpubUZWd0pW?=
 =?utf-8?B?cDFETUVBZHB5bzZOWmJBMnpQaGhGUG12NENVc25iTGlTZFd5ckoxb0hiNzNx?=
 =?utf-8?B?dXlxTkJGSHFGVjE0bHZ2WnR4L1UrVGRyZjhXaTdNUVJ4MDR6V21Qc0RBOEVm?=
 =?utf-8?B?WUxWTWkrZzdCUFF2MmM5S3ZwOVJjNWJqYlZ4OG84VjR3dWZNaG5KbFlteEg4?=
 =?utf-8?B?TmlnT2hDV1VMZFBvVnpmWTJaZGh6bDV0cUlwekhUQUpTYVJTSXFEZFNpcmN2?=
 =?utf-8?B?R05LbXNTT3JFTG1UakQvQ2RjZWVPSmcraHhkTkF2RVZwZ3JXSkVqUEp6di9C?=
 =?utf-8?B?M0srdmJJSlRGTEVTNnNnSVExVE1kcUxwT1pudzFQWU8yQjl3Vm5CckhMWjRm?=
 =?utf-8?B?SzZ5VVpWVi9FcG9ieFVxUDMxeXVMeWVMbGUrUTlycE5YeG83U0hTSXZaUy9v?=
 =?utf-8?B?VTRsVnpYZWVqSXpkV2hJaXFuYlhlMHZpMkV4N2cveDFhMVdPRUJFYzl3KzdC?=
 =?utf-8?B?SHpyams2aUdqc284UHphOHhEVThOSTJrS3JZRGd3QXEzTFJsbktqdG0vSjVE?=
 =?utf-8?B?S2EwcjM2cnBBY2tybTVINWRMTll1MWdld29MNlhjeDVqZkJOYWp1dFVMZy9y?=
 =?utf-8?B?bDVtNFc2MEN1V0hZK0VERzNqekliMVp6VjhSTkc4VWI5TExLYm92d3dpa2lq?=
 =?utf-8?B?cGpHVFpHT29qRE11dGxvOUYzNVBhT3lJa3JnWThVa3JZNXp0YklDMnBaVUQ3?=
 =?utf-8?B?UGFQaENyWm8vTjJqczRaYkRoMnAvaWxqeW4yWHFoM012T2U2VDZjRnNxd0Z6?=
 =?utf-8?B?L2E2QWlzVUdoOVZxdU9kQ2FYeU9wakZUckFvOTQycGNnSWhkbWY2WGdJaUZF?=
 =?utf-8?B?djNpWUlFNE5ueUlxRTFSL3IrbnMvTFYvQkFzMkdHTUVJWjBpckw1Z3F3QjdM?=
 =?utf-8?B?NmRweDAya3J6aml4RnlIajNWMWxhZWZrSDc1VHRkYlE0WmpFODFyMmFKS2FI?=
 =?utf-8?B?dWduYzBrcTVMN0hmQ3VHSHk1MXZFbllEMWtiU0pab0dKenhid2NQbm9Gakpm?=
 =?utf-8?B?ZDJ3ZlBnZlhXb2tEa2tsVkVLczkrcGIzYXVSS1Bkc1diTm5SZmxtT0Y2K1FS?=
 =?utf-8?B?OXhRNlNldmtURWw5SkFrNmZZUWF3bTNENlYzeUpIaGFrUis2VkNXd0kvTXRG?=
 =?utf-8?B?WWNrTzZvSEwvRGYvN0RvdmdJcytPNTlzV0dNK0N1Y21wbFhpN0k4bHVxV3F5?=
 =?utf-8?B?VSsvZHRJVmR0c1U1d2R6cHF0TG8wenVIYXhtOWl3VHRVN2QzVnVRQ3orWVNt?=
 =?utf-8?B?SHpITUVkVVNVcXZTOTQ2dTFVNllwSmI4VFZGKytwYmZ1VncrZjdhZVJ0a3ZY?=
 =?utf-8?B?R1dTSWw5NWkwdVpsMm1oMG1mdk9pRGEwRk5HK0laWGc1UEtGS1N2Zlp3WkEv?=
 =?utf-8?B?RHRVRk1zeitZS1JFRFl2Q3JLcU5kb2p6eW5uWEp3R1JLTk0zU0VRZG1qVmhX?=
 =?utf-8?B?Z3NYcFc0amY1M3p0bkU5YmhkUjd6U2s4K3dGL1VoNW0xejFueGZFcnhaeFNr?=
 =?utf-8?B?SmZ3ZDU0emhmWk5OenJieGpPMGhxV3d1MXZZTDdGRkRDRW9LSFhHUFAzNHpn?=
 =?utf-8?Q?JPhQyG3/Vzn7pwCW29BNehu3A?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?cngzTHhpQ2RTaURjakdHSmZYdTJmc0cyUStqSDkxdzNZS0VLTFVyTmRZQnph?=
 =?utf-8?B?MDFVZnhiRG1Qa1V0cHN5b3RCUFcrUkFzQ1NyVUoyT2gra2lObC9yaUYvZ3JH?=
 =?utf-8?B?UVpaQnpUQXFOYzk0YXlnM21ZQldFbCtCcVdQVnd3ZE5HNlZWQzk1MzV0U1VX?=
 =?utf-8?B?ZHZyWFdsTGdPaDNyVDIwTFRmZDF1SjRRNkx5aVhXT3ZMbzEzK2R6a2p6SE40?=
 =?utf-8?B?OXVhaVJlMndFYmpLdndsejRmZmt4WERsYW1iR2d3N1N5MzFsOUxxakZuZkUx?=
 =?utf-8?B?cnlqSDRmbUcwS0EycHpuYndRQzk1a1Z6TTNJWVV2MWdTUGlDVE5WR1hXU3h0?=
 =?utf-8?B?Q2tmOWNtSU1RWUtjRi8zSUZEZzlOd0MvUm5ISUdaVkowME1LMGFTNUwreUFs?=
 =?utf-8?B?RUllMVpwL1hrVmV2Tzlpd0E0M1hqb1BwY0R4M3IxYjBlSUJJYlR5V3RSbnVZ?=
 =?utf-8?B?YTIxL20waVh0bk1ZVHJneFNsYWZ5QTJ3QXJPYjBiUDAwTmdreGlSVXI4eDZh?=
 =?utf-8?B?Tnk3dHAwVlVwOGQ4U2FyM1cyc2l2U3g1UGNsMFpONDlTeEJxdzZ4Ykcxblhv?=
 =?utf-8?B?U2FFRXpRYnlkZzBGNlliTHlkN2F6NHIvT3Jhb0o3amRhYUlOVlJXcklUeFVp?=
 =?utf-8?B?NC9KLzY3OXRoVVRiMERGTDZJNDFLbEhKVitRZ29sOUpMbU9TSTd6R0J1cEFM?=
 =?utf-8?B?R1B6VVJYZ3FFTHNiTHBLVlhSSzQ5ZmNaSjd1NjRCT0FSTFB3NTNqSDkwMXh3?=
 =?utf-8?B?aERBWWN2c3RVeGNGdUQrOS9zOFJkME5wbDVlS2lZZlhhWUtqNjZ3WnNleGFS?=
 =?utf-8?B?ZlcyKy9Gd0ZUWFlUQlhBVGQzSStac2xoZGFzTXVaQ29ibktVMUIvcGMyelZi?=
 =?utf-8?B?U3IyQmNXbDlWZm52RVpxMm9sRDJuZzNlN0Q0Ly9BVmdhVlN2SkF5ZDZTRVFk?=
 =?utf-8?B?dGt0a1owQzZnajBaMWFUK1liOXB2YmlRd3BDM0I4QlZSY0pYenlZYkhzUkpi?=
 =?utf-8?B?djkrRlFYclNSNEpjOThxZGF3QU9LR2lVVHNzWTUxdFdPOTZtK3FBUWFvYjlO?=
 =?utf-8?B?b1IxK0hTTlZRcFV2UFFGQWtFc1ZtRWFZU3ZXRTNEeHpCNWhiZmVKTzU2ZVQv?=
 =?utf-8?B?U1cvWGtwL01vcGJHK0dnWHhYZnpjdS9MY1U3emFqTDJsWGRxZWFIRGsrWVo3?=
 =?utf-8?B?eGgwdDBKa0w0a2dvcXZEUkt5VEhOY09rSGpDZXZKZXc5b3FmNTJEL2tHSFhu?=
 =?utf-8?B?RUhJdzMxUTk5OTFLajFkWUt3K0xiTy80bnljZEVTZDdNSEhUTzhNeEgrR3la?=
 =?utf-8?B?UjltUTEydU1RTjRVa1YxQlFna0hwbzZORXNuRkZPcW5RVTFQU3dYVGdzWFJH?=
 =?utf-8?B?R3BibU1GT0N6TndUeWpvS3dEK3lzWm9TWEk1TXJpaTZYWUpnT0hhTEx2WDNi?=
 =?utf-8?B?ZXJFTTlzZHdPb1BWOEtWbVJzNEQ0eVJwUlloaGd3PT0=?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a63a586-747d-4c3d-4195-08db5b93fc8c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5433.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2023 13:45:36.1452
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5YXvcDU3ykbDy9rgcyKVJIa7CBQX5EUSORwnD6iXMsL2MXOD8hRuPCO0gfyuc+jJnnW7tKDI791QXtPEGFsWpiE/EOjpqtaV25IMME9DBrQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4394
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-23_09,2023-05-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 phishscore=0
 malwarescore=0 suspectscore=0 spamscore=0 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305230107
X-Proofpoint-GUID: nB2Mxtrww8psdeCMadjYZz-nujE2tFk4
X-Proofpoint-ORIG-GUID: nB2Mxtrww8psdeCMadjYZz-nujE2tFk4
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


On 5/23/23 15:37, Vegard Nossum wrote:
> 
> On 5/21/23 02:12, kernel test robot wrote:
>> Hi Vegard,
>>
>> FYI, the error/warning still remains.
>>
>> tree:   
>> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git queue/5.4
>> head:   9b5924fbde0d84c8b30d7ee297a08ca441a760de
>> commit: 3910babeac1ab031f4e178042cbd1af9a9a0ec51 [4610/23441] 
>> compiler.h: fix error in BUILD_BUG_ON() reporting
>> config: sparc64-randconfig-c44-20230521
>> compiler: sparc64-linux-gcc (GCC) 12.1.0
[...]

> I'm not sure why this flags my patch as the culprit.
> 
> I just tried this (with the supplied config):
> 
> git checkout stable/linux-5.4.y
> git revert 3910babeac1ab031f4e178042cbd1af9a9a0ec51 # revert my patch
> make drivers/net/wireless/mediatek/mt76/mt7615/mac.o
> 
> and it still outputs the same error.
> 
> The FIELD_GET() call was added in bf92e76851009 and seems to have been
> broken from the start as far as I can tell? If I checkout bf92e76851009^
> then it builds, if I checkout bf92e76851009 then it fails.
> 
> Should we just redefine to_rssi() as a macro so it actually passes the
> field as a literal/constant?

Ah, there is a mainline patch that fixes this, doing exactly that:

commit f53300fdaa84dc02f96ab9446b5bac4d20016c43
Author: Pablo Greco <pgreco@centosproject.org>
Date:   Sun Dec 1 15:17:10 2019 -0300

     mt76: mt7615: Fix build with older compilers
[...]

-static inline s8 to_rssi(u32 field, u32 rxv)
-{
-       return (FIELD_GET(field, rxv) - 220) / 2;
-}
+#define to_rssi(field, rxv)            ((FIELD_GET(field, rxv) - 220) / 2)

Greg, Sasha, does it make sense to pick that for 5.4 (as it doesn't seem
to be in there) to shut up the kernel test robot?

If so, should we add this to the changelog as well?

 >> If you fix the issue, kindly add following tag where applicable
 >> | Reported-by: kernel test robot <lkp@intel.com>
 >> | Closes:
 >> 
https://lore.kernel.org/oe-kbuild-all/202305210701.TND2uZBJ-lkp@intel.com/
 >>


Vegard
