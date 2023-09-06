Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32269794295
	for <lists+stable@lfdr.de>; Wed,  6 Sep 2023 19:58:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235074AbjIFR6p (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 6 Sep 2023 13:58:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231616AbjIFR6p (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 6 Sep 2023 13:58:45 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2060f.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e89::60f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE5611BC7
        for <stable@vger.kernel.org>; Wed,  6 Sep 2023 10:58:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UwiJp9L/b6ZcT2tPa7YMSlIckNVARQN0DQT9eygkxIKs6RT1QEHflfx9HvbDbC9wPx00bbxF8oU0yEf/tpyqiKEnxf8vnGKtE5YtAfDyb39OSkwUwvORYERKkScHqtFyrqjhu6yeDLbkzCmnC/gOsOqe8+/I7tK1S5D6YNwtBv9hWneZqo74h99Ia72rK9eNa/oAfMR2GGKIcQmH2GXCgc5f29SPWW5PM98XfXOwtAbS40EoD3of8BTvP5GVlgOvNmpr4LqH4p0lGhX2GJmDY4oxJ+VfAL98QociKb4WrTC/v3g25gQ4qy/UfAbe9GAiYsSZ1dhPUKlSUGXd4o4uiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4fkMOmZbrEPyC/SCwEZZAYmPQAFxblmd6XzK59u6AbM=;
 b=PlkqYdH6FjfU52ouMP0VjeYqbWrcTDw5i/BPGhcvGRjy9/eaWnsWX1j8MhknGkOLAPhnAvLx/gDMPhCSTycx1XGGaL3f1bFmaOVtHoxHoJuq/E9EzTFvUiCwGblC0KF9m/3x8P/KMBqIMsGi6yfrBKFOVNW1kO6khVNH/jpZyrDfF3mpDCFHEcJsYkVrZthCiw+4cXlbvjNupukANmBedjSFgQuvG7IM9pk9pOxxgNF/qpNyqiSGVYq/Y2Dh2anFq0FcRUt8SpqAWUfz8pnI4xm4Qp04j3ITUAtUI10VgSzfIYSRBt+Uv3odaybGawxw1wG3hCTYYoOJ08t+Q3/ftw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4fkMOmZbrEPyC/SCwEZZAYmPQAFxblmd6XzK59u6AbM=;
 b=l9847KZGiwL6nc8+UQW9Zxi7sL269fw48dfgbYStzEE3uDOG8Ep4IA64DNs2RHz7fp1latJW0gJ5iSDsY0DLhRmniRaozwKKuarxIAUjgzHeiW5R/NQ7t9Qdd1cqIEZkYlJxoBMeCbzUxGgzbBKdJSFlpZH/P/xSHPydzi1lQ7M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MW6PR12MB8897.namprd12.prod.outlook.com (2603:10b6:303:24a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Wed, 6 Sep
 2023 17:55:33 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146%7]) with mapi id 15.20.6745.034; Wed, 6 Sep 2023
 17:55:32 +0000
Message-ID: <074d84cd-e802-4900-ad70-b9402de43e64@amd.com>
Date:   Wed, 6 Sep 2023 12:55:29 -0500
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To:     stable@vger.kernel.org
Cc:     Michael Larabel <Michael@MichaelLarabel.com>
From:   Mario Limonciello <mario.limonciello@amd.com>
Subject: Kernel 6.5 black screen regression
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR11CA0040.namprd11.prod.outlook.com
 (2603:10b6:5:14c::17) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|MW6PR12MB8897:EE_
X-MS-Office365-Filtering-Correlation-Id: 066c78b1-94be-422e-1606-08dbaf02772a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e+rtvlwnKOuwZWFi6RjtPfPkwalnf5GwNnS1NjOOySCxsPxVUeRzptSN70Uml93yTtB+k+5/N/Po6Ak2cOCrZR2V3mcfDXKK1DB5vJx/73VOTOzj3ec3cP/YR+I1aX9PwPqABTaK0GGQXr6ffYMQZMvk91Rz5a/msBkJjKYPt7BtjZFgy8cqU87P+3AZwafJn1+8EBjINTs6tmTizmQrvFFyN6iXsIxJ7CCV/wwHP4992JmU9XvXNqpjptgmdNEkHAHXohdIUjfPAT/7JioILac9ACq+k+hdANHjj7G/UGbOB8V1kAAS3VEnmb0KPFQaKofD8OPJBC895GUxn0KQLXyDRwTIA6a2EElhAe6kAG0WGNoEKG85II2eAH0tTQCCvHk1R6D9EEVK8Tiz4GqVGIZXKRmWWYHQiErHofgswmBBJ5DVwdyKpAwUMEmKYfyIvFF0JJ2eiES/jCa0yG1zGUpPZPE7+zPIEPsT85NlcSD3dXh6BjksUKYqno5EDElLxH5BFrJ3QvfuGXF7lLXquOtC8iyI2iNLqPJu3WbLcKGNLcPat/I8/gmc8aJe7dZLrnY5+pW6z9tZ6LDqPkQUq83nqdRPklXgNGnBweDTxDF46/c1IUimKecq1krVdWsm105tG0XlS0hxyTHgBp9cdQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(396003)(376002)(366004)(136003)(451199024)(186009)(1800799009)(38100700002)(478600001)(5660300002)(44832011)(6666004)(316002)(66946007)(66556008)(66476007)(6916009)(41300700001)(4326008)(8936002)(8676002)(83380400001)(31696002)(4744005)(2906002)(26005)(86362001)(36756003)(6512007)(31686004)(2616005)(6506007)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R1RFZnN2U3h6VDBDdGF4UXhZd1pSbFBNUklWendST2NibFkyQmF5bks1NnBQ?=
 =?utf-8?B?czZab2hzVWZaSCtxaGZhME9ObzNNS3M2SElDV3lSS29LQVNmalVJcVpZR0lo?=
 =?utf-8?B?b1lDT3J5d2llS1FzaEVsK3I0MzY4MllBbzhJTGNTVnpZOFBOdEttT3lEMDlX?=
 =?utf-8?B?ZDZjellmVDRiczBrakJmWDA2a1BCRGFUL3Nhczh3UlRWRjdzdlpUT05zTU9l?=
 =?utf-8?B?eVNOdDVnazM4NWZQcWptbmdGaUoyS1hVckJSa1RsdTNHVjdzcnlpUEtYTU14?=
 =?utf-8?B?a2ZPc0F2aEtiTUVia0UrVjcvZFRqLzh6cDM4L1FuampUQzh0REpPVE1hMXIz?=
 =?utf-8?B?OWdCNjYwSUx2c2FFVHlod1pQT1RUbGQxQ2krV3lvVjZ3VGtHMEVhRHNqNkc5?=
 =?utf-8?B?ZWlnRGdvVGhWTk1JRnJ2dHpwZlUxQkRaS1B3cjMrbzhDWHR4OEFZcERObnA2?=
 =?utf-8?B?azBlbEZ0Um14SVJhUWovT2ZNOEdlejcvemhEbnFwTFVlb3BmMS9GU29nOCt5?=
 =?utf-8?B?YkYyck1JWTlIak55OWMra2t0QWQxaWp2d1U1cUJ1UzZvb0ZVSk5SM1FKWERE?=
 =?utf-8?B?aDV3OGlEaUFxeEl5Ym9HcWhuUXMrck9ob3RYOFVNWHRhNVkzNU9NN2d5RE8w?=
 =?utf-8?B?cGVPclJ0Ym42WndaczQ4OURGR1U3TzF6eHZMcGpJNWF2UEsrSXlqb1lDNmpv?=
 =?utf-8?B?VWgzcUYzOHZxUlJxVHhFdlkrVUx2cnV2RlJNNjhTVzNWYmdDQzhnK0tnK3V3?=
 =?utf-8?B?YlJvbTlKa0RPdmlUZzhBUzJHTkExZXozUVNpYVNuRzE0T0pTR2gzOVRRR1Jw?=
 =?utf-8?B?UmxtdEVFMnNsMG9JaWdWTzRTOGRCUWJIVGIrQklhTGhFUERMU28wNVg1STdn?=
 =?utf-8?B?QTdDeFNZaWRJNlVnVjQ5UWNESkxNV0tZclJJcDNobmhPN1RMQ0toMEpRRjVG?=
 =?utf-8?B?Sms1SEh2RGFJNXdESWtlWmFjMkk1OEl2bEs2WElJNysrVWZoVml2VWpXYUlX?=
 =?utf-8?B?eUpDZStxNllneWJ5aG9SWTVURFRGamh6NDRjWXJwZlVlNDEwVG1JYzF1YnFQ?=
 =?utf-8?B?ZXFjNWhvMjU5aUJmdXNJQ215cFY5VXlWa2g4eW1pUmMxUGlpQ3pwSkRkd1Fq?=
 =?utf-8?B?ZExpaGhCTGQzaG92a1JDcHNabFMyZTl0MG81UHA3bW03b05za0xxdS81eUsx?=
 =?utf-8?B?YVp5M05PL3JXOFZicm93dUtzQmxFLys0NEt5ODJ3OTZKUW5VSVNadDNhK2xR?=
 =?utf-8?B?MzdlR0x3aWorLysxdG1yVytUeE1KbkNkZkEwb0hSb291ckpjTVVKSGI5bWRK?=
 =?utf-8?B?dFN3SVo5N2hEdDJrSnVOSEhFeGJRWEplbmtvY2xFdFJScklpeTZXMWhjYXMx?=
 =?utf-8?B?bEJOVzEzdEZZZ2RwNmEzcTMrb2htN0NpV1VrTWpzN2pVd0xheWhQck56QnBV?=
 =?utf-8?B?V3E3MzdzVGVqVHZSV09ZLzFhdDl2N24rVWxCem9OTytraGlKMVBYUDU0VUVq?=
 =?utf-8?B?dk5ubHhoNXdWam1oTDhRNmN2aEh0MU5KN2FHT1ZzU2diU3UxdXY5ZW5vZWxZ?=
 =?utf-8?B?SHRTWEZmN0dYOGhuNWlGZXIzY0lOS3d3bXR6eXVnRGN4a29jZWV6OFJQRTZC?=
 =?utf-8?B?U1lXUDZjcmQ0OGpHVnFVZHlQUnZuQ3ZBQW96MUdrSzdOUktjcXA4bm5rakVG?=
 =?utf-8?B?UGQrcWEyWHNiVngvZkRWWEladytNWUtxYWxFK0xkNHNITXhrRU9xeGNSdmRq?=
 =?utf-8?B?NHJySGhOcVJMQ1I2NkFZeUYxSS9ha2RQZUR1NkxMUUxtUE8xRFd6bm15UXpp?=
 =?utf-8?B?QUtXalBnamNWOTQ1VkpwMEFmcjRQNjIrbnNMNTQwRGZ4cFpveEhaUmhGM3JG?=
 =?utf-8?B?NmxiaHFLY2RJTVRkckIwZWZJd08vN0Z1NElQU2hHckZCN01yNTA4ZjFzWkht?=
 =?utf-8?B?aDAzSXQ3TjhvZGoxaS9iR01CdEhpdXhCWTY4RjNHM2d5VGN0bGppUW94VFlN?=
 =?utf-8?B?bzFKdnExQmNQSThFNDAwMkdVN3lna1E0eVJJY3BBVkUyRUF2WFBkc25DVHQw?=
 =?utf-8?B?NHdyV1hXZmRmcWIwQURsWWpPR3plQURMK0E5YXdHa0Q2bGw5RVVsVlNRakVK?=
 =?utf-8?Q?ANHk8nYiR6LjlP35pHRjzUK7n?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 066c78b1-94be-422e-1606-08dbaf02772a
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 17:55:32.8918
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FjHNdiA8ZFnG4QhSS2Tnj5tKSbfL3ZRF38tvJsXfY2aw5MI9ZLbSmvN5j/wtrMnvWnivoTkEmRARqCMckBrEAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8897
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi,

The following patch fixes a regression reported by Michael Larabel on an 
Acer Phoenix laptop where there is a black screen in GNOME with kernel 6.5.

It's marked CC to stable, but I checked the stable queue and didn't see 
it so I wanted to make sure it wasn't missed.

a7c0cad0dc06 ("drm/amd/display: ensure async flips are only accepted for 
fast updates")

Reported-by: Michael Larabel <Michael@MichaelLarabel.com>

Thanks!
