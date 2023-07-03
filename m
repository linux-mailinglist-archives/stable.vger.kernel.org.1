Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98A9B7454FB
	for <lists+stable@lfdr.de>; Mon,  3 Jul 2023 07:40:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbjGCFkR (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 3 Jul 2023 01:40:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbjGCFkQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 3 Jul 2023 01:40:16 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B96FF83
        for <stable@vger.kernel.org>; Sun,  2 Jul 2023 22:40:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iAqFSLZSDTiqgFnz469kI5sMYyVgTvZcGvrbz/MfkZ8/IkK2iDW6DnSDy5bXByR+NZYMLjHxvLBDDSvr24AvaXdAM8ZRqrAsCnTGclSAgwOX30Im1qZSNCRvM3JHQe+rss62DNCBfROjr13WP47d+vuGTkDWytu4j79vlyz6rX7FrTHGJmdURZbaaRrR9bDyOrQVr6Ha/GXVu56oDVPp3h7NpRVjwT2hTMS4yAr+iUpVBx7sbLYJk0Owsv9VuiwHK5LoVlMzHv+6/E3+iXP+1lM0rqkXtD/b4MqDeT4+3ty7exzgyVoulWDtz4QNc6MTS95IOanSIxVCmZ7PNYalgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XsSZ1yA01PT7tWkouVdz2C7giM6NFpnzdR0dHlgPsOA=;
 b=IhNdqAnLf/VYtKJ8M/c1/znDSm11u18vSuhoO03Q9VvXi6+L3HNyw9M6RwqiVodBMidTZcopt+tplTL4wn/CTEZ2OvZwyYmUr9ZA0BWzjjHiGtV3KWFwj7RV+FpajOofepl0LYLQBPscStx+tdgk00Q7Vp4aCBKHhbWNPPzenV8NVEyJa5wC81Ug0W9u5LzEXw7/xoHB8EAhIqJzsPXWH6r04ubFV9jHyU1yW1zSFgkEoGmLcKftTLG1FQ1b+aA9KxGjM9zT9mjYT3chu4FWQSVB2hTq4F+6ghffOC5911n98E0wHCLogXgxJgLXAiNMXVh4k9ukfGFCLhtF+fsj5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XsSZ1yA01PT7tWkouVdz2C7giM6NFpnzdR0dHlgPsOA=;
 b=uMGVi0CCpqt0QgbuHdpOB0TcvBH80iVRKPYRhLnm/GmWhnQFMnpD1WB5pDf5l0mPojGrNuX/nxOuHhl1I8C012y0GYVxUNzQ44yJmwld8IzkWYF6bk1FHqbDhtrOJuaUFBWQN44AhdJJX2fLl0o9pq+b3s6bg38qpADUD4Q+rYM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by BY5PR12MB4065.namprd12.prod.outlook.com (2603:10b6:a03:202::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Mon, 3 Jul
 2023 05:40:13 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::dfcf:f53c:c778:6f70]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::dfcf:f53c:c778:6f70%5]) with mapi id 15.20.6544.024; Mon, 3 Jul 2023
 05:40:13 +0000
Message-ID: <880981db-06be-7594-28f4-2818300fc250@amd.com>
Date:   Mon, 3 Jul 2023 00:40:10 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US
To:     stable@vger.kernel.org
From:   Mario Limonciello <mario.limonciello@amd.com>
Subject: Fix some issues due to missing _REG
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0115.namprd13.prod.outlook.com
 (2603:10b6:806:24::30) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|BY5PR12MB4065:EE_
X-MS-Office365-Filtering-Correlation-Id: 9316accd-fe66-497e-8ab7-08db7b87f8d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +o0+rru36G9aACLjN08qU+QNKeBKkMOJrTu9l0wfZA0+zCTgDifq8EgJER0altzAswV9id8kQH3TEIkdxkqVnM1fe88mkPSuyW+9h2tLsYJaReXW85sgDPh58j3MnQkXwe4maI+Y6bhnAM3VdqlZoK9Iq0QhMV7ZhV8JoBYnVq8jdof8Hu+ts8cjo53jQQveQhtKc17oj6Pwdswrfkg9c2okfzgkGnpBox14fVLo62QjQvCA9pFY1/aTdvDzwSRKINn4xKeacP3W05CrYQ9PC9Wax++twj4n0kiu+5kXopw+TyN3EH7F0jRbGlFstDIxfGOT8X0q08Y3QNvEzrFfD11+M2aavMw9nY3pzCQlZuCf0mkaBq2Ca86tdfsT/afvA0OCmoad1nT2+wVBvkmyLI7ROixm6WY2IGJVf8cwc7yhFJWoecneQReJSmYMlRDgE3WnnM1WaX52fOc50PzSuHDjxvMk2wNexAv0P6DLRZYecHKJJctGEhOt9LGcnDcE5GcU859TIJ379LVQA6Ld8ZKAobA6N0d7bW3X6pYqXObqrXN9HvBx+Y9ePtZXaVWYADwJAvzGiJ/DlDYIUDM2fuEHQ3wdJJEE2Bti/SkRXMiYi8I2puJdPPLes/KSVHgpY/rjXV7jZ/rUL8vZik8f+Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(376002)(396003)(39850400004)(346002)(451199021)(4744005)(2906002)(41300700001)(5660300002)(8936002)(8676002)(44832011)(36756003)(31696002)(86362001)(186003)(2616005)(31686004)(478600001)(6512007)(6506007)(6486002)(316002)(6916009)(66476007)(66946007)(66556008)(38100700002)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b2Z5M2Y1ZmJpT0cwMXl6cUtDTlFlUDVkQXhxQU5zR0UwLzUwd2YzQVcwN0wy?=
 =?utf-8?B?M0ZSUHRvaThjVTJSbjBJci8zeXltSE1tQ3VsY1E4Wlc2RDdDWFc5ZEREdit3?=
 =?utf-8?B?ZkI2OTJsN254RVlCdkRFTkdVL3ZqWStvRXFHQm1jRUo5VVkwQ29QaHI3eHpC?=
 =?utf-8?B?N2oyMzIvRGxJcGNNYlZZMGE2bWdTTFp6VmM4OEZUalZ4eCtCQlRVMStsaVRy?=
 =?utf-8?B?T3oveEsxSy9UTlFFVHUzVk1rNEswejhwNU9YUTFkUW9oMnY2NVpqSU1lU25v?=
 =?utf-8?B?S2dFUjViRzdCZjJydk01a3BBVGZYVi9nQVBLNXBoUFVVdWJydFdYV1VhcTZ6?=
 =?utf-8?B?b2tQRGVqVDdKdzNvaGVFUlpzb2hXTG43R3FPMTJEbDBWSEVEZS95MUd6Lyto?=
 =?utf-8?B?dml0Q1g4dUlhUkgwUkdvNVE3eDY0Q3J6UTZ5M0h3K0IwdzJyZnVJaWdsVFl1?=
 =?utf-8?B?RU9MeG8ySUx3dUpRUmtra1F5YnEwUDhsdnRKanBjblV2aXJabEJEOVkza1lT?=
 =?utf-8?B?MjFoMmNiUFRrdVJOaU9yRU5WSEVVb0lRSk5udEx6RkVndUVlWEFXTVdTeC9J?=
 =?utf-8?B?UkZIaTVjUkdrV2g4SDVGTmxDajQ5L3A4M1hLWWQ0b0JyMkNKQkRFRDA0RHd3?=
 =?utf-8?B?ZmVaYTd1Rjk5NGsrTitRRXhaWEcxSThVQWNZMEE4Z1JuM1hWa1dLVi9rSUFl?=
 =?utf-8?B?QWJDdEhLZ3hXcFZ4bFVnTU1oMlRvQ25yeXY2ZTVGVE5kZk80Q2tDcFZwRE9u?=
 =?utf-8?B?QzFhMW1TekdZYXdGMHVNRGVoZmd0Nm1hS3pRa2ZlWm5GY1lubE1uT0JFUjZ4?=
 =?utf-8?B?L1locGlRck1ZODMwRjdpSEUxK1hhUm5zM0FpRDdIazdKOHdjTUdBdXB0bGFS?=
 =?utf-8?B?cHBHUkRoUmh2TTRPVEpET2F1ckxmSUJ4RXJIb0s4ZjNUajdMcGhxd09wZng2?=
 =?utf-8?B?VGk4QjBVcXgzYkg1ZEZ2enY1QVpSd05va0w5WHl2NjJGY05idkFhZFdMZkxt?=
 =?utf-8?B?MUJ4blo1R2w0YXZRNFF0RkFHMXIzcHhjeHNGbXJmcWV6b2J2T3ZkdEl6RE84?=
 =?utf-8?B?Nzk2SGcweWkrMGhMZjdIcitCUXNKWnhkNHh2SzRrOVhxM3NrenF2aXJDRDlN?=
 =?utf-8?B?UGRHQnVuYUhnL3FSdGN0Mm4yR05naW9pM2FGUWdSZ3gvYVo0YUdRMGcvK0Fs?=
 =?utf-8?B?NkxEclhTY1Zqc2tkVmNvOFlQczg5MXFyMXR5Z2w4QVlwZUoyK2pWcklWT3Ex?=
 =?utf-8?B?K0xIeE4yNTFYS2s4bmhNTDR0M1pEbmVPei9nQVUrV016QTFtRUh6NzhXOUdK?=
 =?utf-8?B?VitVUFFtUExBSzYvNnYyVHgwc2NsMmtMSGN3ZTZBZGlKRC8zdkI2bnJ4eis5?=
 =?utf-8?B?ek1KcWlldzF5U1kyV2pYSGJtdUQxN0tNKzcveVg5UGppZXgwMUorbXIwdmFR?=
 =?utf-8?B?WGF6L0xnSWQvS1pSdHVuZjQ0bEhlY3lxa1A4RHdJQWdiTzJLSTJFK2tSV016?=
 =?utf-8?B?SlpmdmN2S1pUQ1NJMEFoZk10YlBJd0h5bE9rNU5UbzI2MGlvc0NMeWw4aTls?=
 =?utf-8?B?M1luYUpSMStpRzl3cXdxdGt2cFlqandiSHRtc0ZMT3ZsSlFwa0VtamV3WWhQ?=
 =?utf-8?B?cmg4SkVJMU9rUXpYZGFlajdVTE54bDdLMWo5T2k0cm5zUGdnS1FxTkdmZ2ZG?=
 =?utf-8?B?UDJXYkYzeXM0RTFNdlJkQUhTcml5cTJyMkJmSXR6TzVHRG5HMk0vTy8zTzd4?=
 =?utf-8?B?SXNTZVJZUUMyK2MyNWQrcEk0YVFUU0g4QkNRaFJHVHVMN3ErR3NISm1xYkZT?=
 =?utf-8?B?YXg0dVZ1VldCejFqdm5KSjJ5emQ1OXhlZ1FyMlhVTjJ5cEMzajNHWlRkQVRJ?=
 =?utf-8?B?R0gyWVVxZnB4ODBxSi9Ta1FSVG16OWJ4Mzc0OGZIVVFIVGlSV0g3Y2xNWkcw?=
 =?utf-8?B?ZFZQNWNsUEFmMUVkY3M1OE5yRU1sTXhiTzBtL2M3NVNhTXRRV1Aybis1YUdK?=
 =?utf-8?B?Uko4SVVvRGtISUNXTk5WV3FOMFFERUdDbjVEbktHUDUwRDRIbTl5aHlyRHVh?=
 =?utf-8?B?OU9HVDBSdGl1ektBRmJIMTdya3B5SkJkLyt0TFloWUZUK3Vjaml0b2twbHdU?=
 =?utf-8?B?Y0tuVHBCWVFYcmJCTGtFUDRHOXgzSEpoT0JkZDhteVlKMkZyVVJ4dXNhdnIr?=
 =?utf-8?B?Q2c9PQ==?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9316accd-fe66-497e-8ab7-08db7b87f8d1
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2023 05:40:13.0091
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J8CkSikR81QgnumamPztXZDniz0O/LFLzd6IPFV6TSRrRIz+5fqjdy5ZmJoIKR66JEeqyJ8YTv68wnpzQLd3QA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4065
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi,

There are two issues that have been identified recently where the lack 
of calling ACPI _REG when devices change D-states leads to functional 
problems.

The first one is a case where some PCIe devices are not functional after 
resuming from suspend (S3 or s0ix).

The second one is a case where as the kernel is initializing it gets 
stuck in a busy loop waiting for AML that never returns.

In both cases this is fixed by cherry-picking these two commits:

5557b62634ab ("PCI/ACPI: Validate acpi_pci_set_power_state() parameter")
112a7f9c8edb ("PCI/ACPI: Call _REG when transitioning D-states")

Can you please backport these to 6.1.y and later?

Thanks,
