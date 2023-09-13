Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF43479E03F
	for <lists+stable@lfdr.de>; Wed, 13 Sep 2023 08:54:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbjIMGyQ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 13 Sep 2023 02:54:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231848AbjIMGyP (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 13 Sep 2023 02:54:15 -0400
Received: from BL0PR02CU006.outbound.protection.outlook.com (mail-eastusazon11013004.outbound.protection.outlook.com [52.101.54.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2FE71738
        for <stable@vger.kernel.org>; Tue, 12 Sep 2023 23:54:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FznnTDAAKRIT4S6jCvrODCW0fJgEvtBbHRdeZzZjf6mH1JiR06y8dBBa+e1d1mwvU5dpzA/5lM7ecHVAFE1qWsjKOrTk/atnIEJDugGZu8yxN8Ts2VH0DJHMxyAwjM5FiA/onsGeEI5m6VLsOq1C46Df4K9NShmXq/wmX4A0HRnRIyKWpwGArtKec7QzIYrMeXJeVzT20/s3rM8HfH0iXC5FgooNNOAZ2w41XGtqKJDyMvzG1LDsX31wsnrvvkTdcFIJ8WAO+iIJ1jKVuUMShYylg37KyMB/CItF56qrhRfnqHgNpqzluCGVR+9mgkaNBm2HDpOOyAtseWlixPJwCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h6wUTamDqFydRzkeMQtKc6wJY+kUKUzv4HzlfyitC50=;
 b=GE6TTfm3Jtffr74K3Bp/i3UsSvZ+NBlHsOgzAgN014/e8mEQ9QQsAe1/MbEtmMBNm6b6DM7KNT01zmYxWRldMHt0uAeWdI/1M6HsgeCEmWtbDy89kgt1i205HRsehEH8PjofV8BAhXvJl7zGWMevWGkyqylvAZugimKXD4xHraaiQjMx/W80dbVMwo48GyW7XFtJu5j39UmWFwU9pMwkbAN6tMmM54tMZK7BkShYxz9Hk59DPdUVx7a7kZX8yLteOQraOloXyQ//DTcK1LzCao8nGzUF1yZUqgKCGmVpjOjqyTSQpJA3O6Gdl4/fG7WnhWknvvYDAfUcrO9vRhezVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h6wUTamDqFydRzkeMQtKc6wJY+kUKUzv4HzlfyitC50=;
 b=zc/j2AUBzdnVhefnHAiOeHQE1ZlpNUQpD64gnvAt+TBHcIWYIw17eQfBe8wlnAJbi/AKF5qsOAzWX9RHy09oZfTDzLbOEaeMQp35GOPutkFBER8K5Hj2yNAUT2aHctq48OnK4B5SRksfdAgOgxkhHjBkG92c9eM38scr15owvls=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
Received: from BYAPR05MB4982.namprd05.prod.outlook.com (2603:10b6:a03:a3::31)
 by DS0PR05MB9641.namprd05.prod.outlook.com (2603:10b6:8:143::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.36; Wed, 13 Sep
 2023 06:54:09 +0000
Received: from BYAPR05MB4982.namprd05.prod.outlook.com
 ([fe80::c1f7:4ed:2680:f088]) by BYAPR05MB4982.namprd05.prod.outlook.com
 ([fe80::c1f7:4ed:2680:f088%4]) with mapi id 15.20.6792.019; Wed, 13 Sep 2023
 06:54:09 +0000
Date:   Wed, 13 Sep 2023 06:54:07 +0000
From:   Quan Tian <qtian@vmware.com>
To:     stable@vger.kernel.org
Cc:     qtian@vmware.com
Subject: IPv6 traffic distribution problem with OVS group on 6.5
Message-ID: <20230913065407.GA510095@bm02>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: BYAPR07CA0102.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::43) To BYAPR05MB4982.namprd05.prod.outlook.com
 (2603:10b6:a03:a3::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR05MB4982:EE_|DS0PR05MB9641:EE_
X-MS-Office365-Filtering-Correlation-Id: 82076c62-a784-4c50-b2c6-08dbb4263b07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YgVaQLPrmMsAY8PSKMUgngolMiMwK4EewnhdCVOXJXQcfcUxbmMYQ0rUt94G920MxcybdRbrgtALwgkS3mnMA1XsljzPLogX4DakatAslLyUsU9eT2dyb/qlfqSBM5oYTi/imNZzj+7cdk4aGklRzel8xmWGznMLgx5sKWrYEsFVeu9gVg+7+hMcg/Y/t2Z4U7FOx98AgIeGYjVpJZyFTGLc54oo9I7m5Oju/ZPHqutLD81VNP/AiIJMNKZm/NkE+oq6mU+7zGizd60CxK/eaEJSP0Ij7XfU7zF1hcPn9mtJWLulHDJiFEMeTi5OCO54iXb+2CoaK6SFN2Eu1WYMJua5oYazZLtzCBh7UDJ76+WCLgOPMpNINY3HqV27EZXg0Fq3rDjsKVNW9MXZKOoaV46/oNsIKbtCjoo8v8TDycEhY+J1uAYN41qFWn31T0IoZNrxS53eqQRb/maW0+U+JgUapeEcsA34t4tteE/V8WxhUAWWou8elHpmTonxSVsIydG8zrPSNFO+6BmKqMpx2Jd7efwOH0Vm+ouG0dlL40OZWTmUsbf0R2r5ozGxf90ejU/98V6sIGXVVlAPswMO9gnRGjLKtjvcla2QsHMt7eH1oKjgsiucxlPtFB4Nuij/Yqrfg8Hjvn9VacAVazQGQtGApox7LEPpFwVebFz6pkN6s2csJ+koZqpCZEpOAAcXiDtDwmD93K3oKIfErIMcfg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR05MB4982.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(346002)(366004)(136003)(376002)(396003)(186009)(1800799009)(451199024)(66476007)(6506007)(33716001)(966005)(52116002)(6486002)(9686003)(1076003)(66556008)(8676002)(6512007)(26005)(478600001)(4744005)(2906002)(316002)(5660300002)(66946007)(8936002)(4326008)(107886003)(6916009)(41300700001)(33656002)(38350700002)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nBGFTNC1UNJibegkfshH3aiFJIJX2XSEMfZ5TT7OIavEKe8VEY+ClyISg3IW?=
 =?us-ascii?Q?clqDyy/SAo5ATXbp9Nwtu7lvC5SQWuKd350GuOw9gPkvqb2pppf7cI2GUkYz?=
 =?us-ascii?Q?oLMaNLUKybh3oNFiC9AYxKoOPW2ylKpRBNs9XPFttp9gS85Khqhzq9VTZNxA?=
 =?us-ascii?Q?fLwIp8+8qw26FdolL0zeE/zOK7ALx41mZIfUBfRZQ/JwwxBLL9YvXuaqIplN?=
 =?us-ascii?Q?OVhvjYjqYXkCq8tIdHRwgjOuf5tENnXouI6sXPZB+cHi5AcUptXbPa2k3+6N?=
 =?us-ascii?Q?cgCw62eBpC5Ap1IU6oWEKFHP3xae/haipuiuZdzMP3YIMxQ5XZqHhcAxpSwl?=
 =?us-ascii?Q?dblwrbNpXqt9AEQLngQa7Aommt6/rP4d/LIpWfUs2EAAAtmXrdYSBd8Zg/M4?=
 =?us-ascii?Q?TUs76VSzDDrpSzy2UNfhJnYnkFYqY5NgKB612+mpU6InbpjVc/zQqHAJzc9g?=
 =?us-ascii?Q?s4YDkMdAospZ4LPF+rognwnW4YPEDsnaxODslh4t0EzXc+OBt0Ia2g0pGzKH?=
 =?us-ascii?Q?KrsLaxgTBjaJYmLyzRn+MWtTHsE9xWIcsOnHsFfLhAaGM9VSp7qoEIQ9hF2c?=
 =?us-ascii?Q?yFz1j0gIr+5xbomJUj0LeP7y8buV5LtPZyHoOuDqyDi6or4mWDnq/Dgc4ELr?=
 =?us-ascii?Q?tGsqcxc4csH1N3pL91GR6+XLH9xaJXHanlVefkkAUZFHWAL6ncZA5OUQDrJ5?=
 =?us-ascii?Q?2/qmuUXGCupoy9pD6LXu/E9ZX1/evly/l/dPXApg4Neg+ErcxgS1lpkqBAg9?=
 =?us-ascii?Q?X5NS5Um+hmrJCTl65t7oIuoEJ5NS05Phup/iD0cqeTF7Tvny0ATUV1Ql9BAZ?=
 =?us-ascii?Q?NeLSSYFQ4O2eQxzzoCxoee+lBdQ1esiIakqg2YfkGJ4efm0Zb90r6N0F0BOw?=
 =?us-ascii?Q?Rz/nf1WrJ5q/YF9pjRpfbRMXBS5myTcI77ziOCiYzvJO9xV79azxC3rBwj1/?=
 =?us-ascii?Q?cbB2zCeb2ra9Cx6fN6PTLXx93QsrMtlviUcgBVK7rM6hI+szM5jCVWDu0MLL?=
 =?us-ascii?Q?ZvMEoLt7qcmmbP4f3HWfUTeyxK3xlaHjJndPjQhE2uXz0UzGbfsDkAjRsl62?=
 =?us-ascii?Q?pk6jmJHrO4YH6xlNo0EuL+y6TyI9fri/SK9rc1OOy9E3ANxusSK1P1PIUWMi?=
 =?us-ascii?Q?zCDy1Ed4IDfrqUwTlWSTKakOtKljKCEm46rZNvUEuMfkrn3Ur4fp3qkgAg/c?=
 =?us-ascii?Q?d1Ad3O1nHIX2keq9A0HBgaNWe3vMWExYG+ZgjvS5IDmMpzLl/U4q3Vjrc2ge?=
 =?us-ascii?Q?M96LYCGlu9jc2vBjz8xCFT9mHDNgoFM7WnyrM9bwcQYx0HuCMsHzLReSnTs9?=
 =?us-ascii?Q?lno9SKX4HphyFttmT5kkLrp6zNhU2njfvG77mQzbcoxDtEPgvnrLTHFn5hn3?=
 =?us-ascii?Q?XHngIz4TekV9t9wORyChKyRc61Bgylx/brc9ke8tIJHu6k/DEKAiQ7z8jEVn?=
 =?us-ascii?Q?nanq541kqyB6DSwMdtkYzZe28ZwOEleee9OzScrJZt5wl1hZPwscvlgFQylk?=
 =?us-ascii?Q?ADUcY6Wo5e+Fghf0LSslaGvvr+HOxlT5469ZTwgOuhzol8QbpbhSJWpplXUO?=
 =?us-ascii?Q?XzBLDOOK081tuDbu8qtPCQMFDZNFNick+uxmGfKa?=
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82076c62-a784-4c50-b2c6-08dbb4263b07
X-MS-Exchange-CrossTenant-AuthSource: BYAPR05MB4982.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2023 06:54:09.5914
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +6dVR6fNFHxzcOjJ+0CBEDtcgrNZjzYICXRDkAM6Z/swkQzcYeRo6ffnx3Wd8qRc2qpSy8AnkdcJEV3W7BHfGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR05MB9641
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi,

We found that OVS group always selected the same bucket for different L4
flows between two given IPv6 addresses on 6.5. It was because commit
e069ba07e6c7 ("net: openvswitch: add support for l4 symmetric hashing")
introduced support for symmetric hashing and used the flow dissector,
which had a problem that it didn't incorporate transport ports when
flow label is present in IPv6 header. The bug is fixed by this commit:

a5e2151ff9d5 ("net/ipv6: SKB symmetric hash should incorporate transport ports")

Could you please backport it to 6.5.y?

Issue: https://github.com/antrea-io/antrea/issues/5457

Thanks,
Quan
