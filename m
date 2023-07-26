Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92CF0763935
	for <lists+stable@lfdr.de>; Wed, 26 Jul 2023 16:33:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234329AbjGZOdu (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 26 Jul 2023 10:33:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234140AbjGZOdt (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 26 Jul 2023 10:33:49 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2053.outbound.protection.outlook.com [40.107.220.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5F5210A
        for <stable@vger.kernel.org>; Wed, 26 Jul 2023 07:33:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JogeFdzcP+HHc5E21+ZYR9/F1xJr6OMlCzb5QpetUevl0wITZpVYUe1RNoeDDsYapUN0B0/JQfI8nWMCrj4BoE2ITo0e9WIF2B5fTO1iOJWZjJSdblMyCFxeighhx+qmEOjoJbHkgJkSv+UUN/WzThLjCVwSwaiJ2dUBwVbJLgijGJwmV3fBWvGzHUP1KYkXMqzD2TAlXDvTNGjIEvuIuWTydeJSWpi2h/RRm1fJVcYpOHxPFhbvf5ob0jN7CqICXO8K/aNys8hyU1e6gs5Rjp1gTIEWBpWqFGs3rcUxw3uNQgSyN1queLN/jxldMSNFNTyzgHvIZIGA/BQNJywZLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U0HCkwFav9+sDScd1McmNjJ+9oDYL7FSmS20pAbooao=;
 b=hoazPst5dkHp/n5FBpd1kJlRJcn6VvHkGHateQVT7vzCSQIOlouCbB+S463+Cc2lt3k0j8CYGLDtkuYoaiM1zvFLwYhzmvypZVsdvsQVERbLzn70rGI1CluCxOyhej4hyYwfCRQDJWJdVA1TcFbDHTptSOygofihkM+pQvElWeMTGusVXL/8PS7u67Lc2WKBbe7xKCkHTHg8dJs+AM1l1APcApPZ1SNQvJrr9o+npWI1CAdXfyyU+Ch1GM4ozW33M57bQwpMs9HOcoRHhehW0n2pJqaXXrVYaho7YjHZElC3ELhMuWV+Y2F+jK1Sn5+j5iYUt9EadGcrW6uyEB1Ivg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U0HCkwFav9+sDScd1McmNjJ+9oDYL7FSmS20pAbooao=;
 b=aUh8QybjPKpDEmRSSHzCy5u0aBkUlHgOU+0eeHpnX4q3AgUd/SOJIg2zQePKVUGPPiZtY5rJlDbpsgnJRhjRn0E/yBA+gT+Os+BOa7d8937sF6dXoQXaTlDMxRlii/TpyW1xacphZQqxY2/etoCyK34hQRwtXT4UMR9bjZ9p1Cc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SJ2PR12MB8012.namprd12.prod.outlook.com (2603:10b6:a03:4c7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Wed, 26 Jul
 2023 14:33:44 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146%7]) with mapi id 15.20.6631.026; Wed, 26 Jul 2023
 14:33:44 +0000
Message-ID: <a7e443d5-e818-f205-a12d-73a2f88bb085@amd.com>
Date:   Wed, 26 Jul 2023 09:33:40 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>
From:   Mario Limonciello <mario.limonciello@amd.com>
Subject: [6.1] Fix phoenix PHY hang
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0015.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::28) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SJ2PR12MB8012:EE_
X-MS-Office365-Filtering-Correlation-Id: d80ca4cf-ab8d-40ee-4c33-08db8de55083
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EEqUQtMORkXSGSo6nQ/cYCXu5OCOPKJYTPpvSu5F5hwwTPtSjN5W0QOFPjrPH5yeVCTai2ZJ33GPeabdR9UdKvoVbjuDZMB6DMeq4LZkT0DX4zZmFP1P5QVgcLw+4uTSb+RnDrTuL1xWulh78My8Ipa2WEkeVD0ficYxwqjxDwQGca9S2cIHQ/NudQX3dKgdJLy0cpD0/6Y7U/YIaC4LqKOocrXlnFz+CPcz17LUrDwZOGepHoKSRNnmzsgCCxQVcYyNubUmw7obCr4SH2BPDzLNGOzHxjHUna0EBH7UUlD97fCOwzjvevTJxkMHfCN+K5Lu8ne/4Ctn39nysH0dMYhZDclBUYmSIUI5ndcWBHU7uGnojPPH9CqQrOIl/X0zXtBQkOmNbgCYeGcLlx+b3Yp1kDHH7Lt7M8oABm0PbKpeHyM0ZenyxeF9B/+zSLyoebbRSJCPu+w3yziEnVjiiqGiAyzB2Z6YnOdgUCNqQCHZxuFB7diI+u6Y/T5ExpnjzvFbLOV1/TlZwWPV1PbtFeUXat48sAW7diXLQKpvpYQEM27sUBGt+5F9cHpLXygfJbH4l98S9u8wZknscpUphDbUX+lkAz0GfMDHqy+GYYZWhk7E/SULbu5VUYDQoI2J05ixqibpckgJEXBPB2Jrig==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(396003)(136003)(346002)(39860400002)(451199021)(6666004)(6486002)(478600001)(6506007)(6512007)(38100700002)(186003)(66556008)(6916009)(66946007)(66476007)(31686004)(2616005)(44832011)(5660300002)(41300700001)(2906002)(8676002)(8936002)(316002)(86362001)(31696002)(36756003)(558084003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VFVUUi8vMisycHViU3FNdmk5S2E4czFVSFVIalNsSGRLVnZGN0I2czdleEFy?=
 =?utf-8?B?RXJqUFFZZGtOVmR2ZG41b1NhUkRydjBCOVdROFlYaUFjM01uM3FLOXBvY3JT?=
 =?utf-8?B?MCs5RHRhcmM5TDB6ZlJQNVh3N2xJTHcyTFpMakdySjhhcWk2S1ZodjdqbU8z?=
 =?utf-8?B?b2tJRVR2WUN0QmNPd3o4dHJJdG1DTkJrWjNaRnFubE9pU2ROblpLbGN4dUh3?=
 =?utf-8?B?MEY2cXg5ckF2MmIxY2pSSm9NV1EwQ2FuSXQwU0lSeStrNm9VTTNFTEMweVB0?=
 =?utf-8?B?ci9Gd3FrbUF3QldsTjNjUCt4cWhaWEduZXNoVVdGSWlKYjVPTnZ6WlhKVGpT?=
 =?utf-8?B?Y05pN1FzemFSRkc3WFlIcDk5citPRmxYY29wS3JBcVVJYzM1YzRJSWFVdm5o?=
 =?utf-8?B?ZGsrLzhyalN0Nm5vekQrSDhpZkJZN1RXeGpRdTU4N3ZVcWVON2NHMzhuekN2?=
 =?utf-8?B?V2V4clZnNCtIUGNRQitpaXlBTkdmOXpGdWVlWGFzb2ZkQXAwSVNaZC9PWk5E?=
 =?utf-8?B?TkJDVzJGVXM5cWlKSkRlSk84c1NjZVJvcEo2ZmloQU5ISkhEeExFQkdTOWlN?=
 =?utf-8?B?MDZ4RDFSdE92a3RDb1ptOVliLzh6OHFLZUZFdkVlemptNStyaUc4T1dCNXFX?=
 =?utf-8?B?emlkRGpOK1MxVktmZUs4dFVCRkMzbkl4c3B0RDFaT3VqcGg4SW5ISTBzc25o?=
 =?utf-8?B?NUtmVVFkTUlmWDFTWWlVZi9GU0cwVGlPN3plcTdtMmZ4cmRsMmdTTnR2Zjk1?=
 =?utf-8?B?NE5YUithNXlCenp1Y09CZllGRzNlRVN3bkk2aHR5TzNFK1hhWWVOSzZEc1Er?=
 =?utf-8?B?cHdPbERyKytydWZLOUM1VXdqYXJrU2k4NHZqUTRYK01iOGd6ZVJ3Y1VmWks3?=
 =?utf-8?B?OVhQM0MraXA2SDU4bVI5cktyRU4rY0k3ZGtrY3FIelhiaHdBak5uaWZjVzFl?=
 =?utf-8?B?aE5zR3Z3eUhwUm5iOGhNN1Z4TlBmMGgxSjY0MHB2UjVlaHhCZU5Jb0phWTJm?=
 =?utf-8?B?cWlqb1lRdGpucGNFQW53TURaVUcrOGYvT0pERFh6OXd0T1B5ODFuSVVKOURy?=
 =?utf-8?B?TE9iNW0yY0FWd0R4TmlwbFBiMzZaVkJjRWRYUHNDM1E0elg3d1Nxa21MYkdS?=
 =?utf-8?B?eEpnZTloMC9vNG5ybWQrRExYRGEvaEtKWFhxczZMVGNHQWZaMDY3Mk94TEFI?=
 =?utf-8?B?c0hCYVdpdkRyTjE1aG81N25wdHJRQzNJWWRoY2hHb0RibHBJYmV4VTlPK2Mw?=
 =?utf-8?B?OWRpb0FpbytnZFp4Qm9DNE1oOHBXOFlXeDRhNitrVllaSjR6b3dMdXRxRmRw?=
 =?utf-8?B?aytoVldEdnlNTlVrUXhNcGtLNUYwNEpHMk8xM09nSncycWRPcWdPUFZ5d0cv?=
 =?utf-8?B?OXlSTm8waWdRQXVCQUtraHdLYlZ5aVR3SEZTaTlWTUFCVTM5b0NhaUU1UHVk?=
 =?utf-8?B?dUZTVXlRaTE2d1VnRU5zVlZtSEpiRGNLRjhyOEVLZms2UjBaZzgrM2hlbUEw?=
 =?utf-8?B?a3MvL29wa3RyTkVoTmpDZUF2c2J4VXdCWVZaVU5kTXR2c2ZxeXM2WGJWUzU5?=
 =?utf-8?B?R3REVzE5RHhiNWo1b3pZYm5ORFgwNERVUzZMbVZyZDlZOWljemk5QUx5VTBT?=
 =?utf-8?B?SmtDMjR2dHEzTmpWbGVPbktxWWNheGxlbVI4alJ2a3pPcFFsUTFZbHFhblVv?=
 =?utf-8?B?UlJPMG9XNHA3bGtKMTJiWjNXSzQ5eWVzOERQb0R6T2VlTzR4bk56MU1RWlNN?=
 =?utf-8?B?Mk94QTdvTVdjNkdtRzA2Q2svUGMzTk84VzhDSzZ5M2o2anNmUjJJT0xkMjJF?=
 =?utf-8?B?QmpzWTI4SHN4TUdLV1Zxa1dyaHhSL1hXQmNGODJHUWM3MklkUklCOGxKSEZR?=
 =?utf-8?B?QjUwNFArRDVjRkwzTnJpUVJwajZMUm5jSXFtbFVZVy83bUVPYzNLWHlwTC9i?=
 =?utf-8?B?UUdWUkliMGxTYktRUUhEUDlyRm9tNG1XeHhQSFVFU0JEMVdoZE9vbUlEV1Vh?=
 =?utf-8?B?UGdEcFNBV3AvY2N5UHJra2EzUjhlbzF6K3VmTDlmWTZjUkhabzEvT1E5cjZS?=
 =?utf-8?B?ekxJV28wYyszKzV4TVRzOXk2LzV6MnN4ZENwQTBNU3RpT2J3NkVCL0xiR1hJ?=
 =?utf-8?B?dFFoZ0tJVml1K2oxelFURkZ3VklvTWNhcEkycXZJVFBVTC9mWWtuRjNzQU03?=
 =?utf-8?B?V3c9PQ==?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d80ca4cf-ab8d-40ee-4c33-08db8de55083
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 14:33:44.3450
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nBjMvJ/SCUyXJU0Dv/95MbdQSW5NGqx7BLw2ffbjERsiQzFRcgWnEFNZ08z0UBZlIUNpb0eQ7K48sHelqy7jTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8012
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

This commit fixes a PHY hang that happens on AMD Phoenix when DPMS is 
toggled on/off.  Can you please take to 6.1.y?

2b02d746c181 ("drm/amd/display: Keep PHY active for dp config")

Thanks,
