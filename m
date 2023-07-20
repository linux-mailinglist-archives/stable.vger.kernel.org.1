Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9CEE75B6BB
	for <lists+stable@lfdr.de>; Thu, 20 Jul 2023 20:27:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231924AbjGTS1d (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 20 Jul 2023 14:27:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231853AbjGTS1c (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 20 Jul 2023 14:27:32 -0400
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9C85186
        for <stable@vger.kernel.org>; Thu, 20 Jul 2023 11:27:30 -0700 (PDT)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 36KATLTw020141;
        Thu, 20 Jul 2023 18:27:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
         h=from:to:cc:subject:date:message-id:content-type:mime-version;
         s=PPS06212021; bh=YpevN/jEkiyiO8pnzgWNcSWOgpO8M8OnvCjXZNyQUVY=; b=
        RLfkTWsitAiCt2wIIDP4J7v5b7GylBdPCCVH+PcaGq5UdjG+e2967RUlIZCcARBE
        2wyeeZe5KLPxkAOIBe6CslP42BiqTqmsryyxkIZy5Ex1sVswsmNwjap0d/Ll4Mo2
        1r2JK8mehGgqNJD+cuHA+Vdo1e84KzABCXY/AjEj5VbyCJY1YSuS2ziGWVtYh4DA
        I06BIqs0SlO3NO+W4aiRbA0Z+PhZL4ga420GcQkSXRh5QXd4qS8WGtsgBpZe+4UL
        WY0BCqTC46sD9/5ZsDU2nCQnnwYRT76HiHmdffmU+zNez3IxSa6TUxeZ1toFYLzm
        OAgWWLEfYnntsrcdJ3NOZg==
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3run9jvx5k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Jul 2023 18:27:27 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VHGncY38AROZ97luPIPDWjU7PDwvj9AWok/CtGxKRwsNLhE3kfwW8XiuOiT7zkqsXoJK5pR6cHmC9PCB5MrQFMf9/idp7qaNYgq/a3kzuPz1R1aUs1cNtLEeBXMn2IjFnjcM4uNz8Yby/K7sUbCWrVGnMh5s0bxg4kyQnSDVvAB649deiPC5dmrROct3B4kjgpTosYgXj3RZ2TcBGbcCGfbgnC9hTfPLIoOlXOXNoI92aNqX/euczBt+o8m7AXggwABcC2MPrntN7Y1dyfHehb9If+fKFIgRGm1alCWA2ajR4dW3XnbGPX+KRRzdkvtgaMshm3usISq1o3/7DTcJvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YpevN/jEkiyiO8pnzgWNcSWOgpO8M8OnvCjXZNyQUVY=;
 b=HS6ZFC4piOGlIe81/jQLvIXiIeh+PV8rKz76RLtFtV933zKAEgHgeKyuckl6LTCRT9EaLm7JPvP1S0QlPukFvtYy57S8NfN4za3R1GUSrTS769u0OetBRkdTNmAJ9VugBoHfpvxy6ikCzR8dsa2hA/szEIooSf4gbamlamt5Yzu29CbhrDJRJcx61KQVuWIx+rtgRjQzTXle6lija7Ujroy+ymyYG+hUq6bFX1HXYRMnKeV0fTj48ImLLH47gqv/jYfiC2stcVUFTh05U30ryjL6/OSxCanb01+ErKwForJqJ0B2d4s9yVA14n32kXCYAEQO95sXrwF3Xj/yy6RAbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ0PR11MB4989.namprd11.prod.outlook.com (2603:10b6:a03:2d9::22)
 by LV8PR11MB8607.namprd11.prod.outlook.com (2603:10b6:408:1ec::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Thu, 20 Jul
 2023 18:27:25 +0000
Received: from SJ0PR11MB4989.namprd11.prod.outlook.com
 ([fe80::dc1c:8053:63:bdbc]) by SJ0PR11MB4989.namprd11.prod.outlook.com
 ([fe80::dc1c:8053:63:bdbc%4]) with mapi id 15.20.6588.031; Thu, 20 Jul 2023
 18:27:25 +0000
From:   Stefan Ghinea <stefan.ghinea@windriver.com>
To:     stable@vger.kernel.org
Cc:     Thadeu Lima de Souza Cascardo <cascardo@canonical.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Stefan Ghinea <stefan.ghinea@windriver.com>
Subject: [PATCH 5.10 1/1] netfilter: nf_tables: do not ignore genmask when looking up chain by id
Date:   Thu, 20 Jul 2023 21:28:50 +0300
Message-Id: <20230720182850.2784-1-stefan.ghinea@windriver.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: VI1P191CA0002.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:800:1ba::20) To SJ0PR11MB4989.namprd11.prod.outlook.com
 (2603:10b6:a03:2d9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB4989:EE_|LV8PR11MB8607:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e6b1587-5c15-42a8-7616-08db894ef75b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B7nZNwm7XILZQ2CZ9ZgZgeXrf2tbLL55aQLncoop/tElhGc+UGVWLIF8q9wGoiIXl9k7/JkD4xq/Q7uIuleJzK5RzEMTJ9mzKyOqADPQgbZoV0GJODopF0gb+ldQwsaxhbtLJZR0T6UCEuctA3ppA3rN5BsUAWARr+boPAhjrpCpT7i52q6j1l34NG2Illw64TccmtwPnfIhxSEoV+wN6bI2TlMQZkAmy8YK6Wa55fPxemZXVhc28/GLesqNlU2Kc6qs+/8H58FT1obK9CrC8bLJcIawR7zUCG0pdlQdQAq9EyxEar8FhkWnC1cyS/IgAZv7kAsR0bAMnGj+H+9W/RW1MR3roj+ipYPMIjjN14uysO60AiyUZJ2VxLPVE3SUaSK0b1InrEL9er54UXZfRzN1ra4xr6FDdkPxygp84utN7joY9WzIv9bs72VqzO/E5hKx2kxNl73ZRWkvY815Ht8cW8hCqIswDzJHozzldCpFvOVXF/burv2FLY+Gm6g4d8NDq0B2bS91Ymko3GLZMl3ilf82nxQ23nGC2mgaan59w43osQd4rDRHK+eSO7ipve1+vW5E0qTj7AtLZz0ivzjsz3y3ulrKgURx/Bl/m6XL1AhJir0CWAyy6rwCvXOL
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB4989.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39840400004)(366004)(346002)(376002)(396003)(451199021)(107886003)(1076003)(6506007)(66476007)(38100700002)(36756003)(38350700002)(66556008)(54906003)(44832011)(5660300002)(41300700001)(316002)(4326008)(8936002)(6916009)(8676002)(86362001)(2906002)(66946007)(6486002)(52116002)(6666004)(478600001)(6512007)(2616005)(83380400001)(45080400002)(26005)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kBnKmNT84jIQZle3qZrc3XLLZmzVngdUmhX95Ud7L+Gr+EzpVQCIvCzg5OI1?=
 =?us-ascii?Q?4jlAsE09Yq5D24FfSomedmElBQ4WwZM4n/y9GjSpEiLDUhYqNSshreG0mgP2?=
 =?us-ascii?Q?LhcUJmC7DoZsd+Yyg1DUiAw6vm4JtYWmfKLD0rNRi1pE64CyZSKle+UfFXjg?=
 =?us-ascii?Q?yTDVYgdJOMRdWdTMnOXAfE/cMePzkkhdc2wfSl53aUfhC69D91fRbZ/pXjuK?=
 =?us-ascii?Q?Kzyiw9K9YkKzSjg7YfYIyTLIR9SYH8VPw7JsJWuq4hp1z+uE7b4EFoTpZw8R?=
 =?us-ascii?Q?1jhiKq+t34qzMzsF+tKeakMdH1OXqUSlR3bJVlU9ghtiFOfV81HLEhzQo2hR?=
 =?us-ascii?Q?A6bYLcCufS6167LZaGOXOXj19lYRhrCFEuUMt8X3BQwUmNMVUBMle4NlIIpq?=
 =?us-ascii?Q?iAfYuhLnt9SLXUQxrHIAuAXymtQIBhApmmlIyxus5++/z3KSC0MONT0ZPVn3?=
 =?us-ascii?Q?2JZ31nMoc0L9uw6qDE/dXht0zoRfyzKsLXFhQTTvX1mery86/tw0BH/LBb3a?=
 =?us-ascii?Q?H8JJf51IONRmUJRzt5qYBSFAMukTwG2gyzIcIFLM2EVMomUW3of3BBR2ZbWX?=
 =?us-ascii?Q?PpgLsTaQ6fu5jR9Zw6GpfYNVII4baUxkte603EBp2o67kcPfV5bTE3OsrwBM?=
 =?us-ascii?Q?/M2pPUw8hHJU1ZpxkFxWw4PahPH03H6UA0+dEDTV8tngPhwmM4nZgNBVYjqU?=
 =?us-ascii?Q?4yA3r3/M9f8SsCvqxgQnIZp0LTI0Fkx2AMN630BV8WpC67fZn6gdCcksOB6c?=
 =?us-ascii?Q?PZPrkzyLTIhrUJTzcUOMkTPmFXo1uagYAFbao9BLRsyGkunTrtWE6JRQbAPp?=
 =?us-ascii?Q?yhluATckUXeb0IEHtpMf2d/uFT3HgyaIHRSgEkWuGBCC1Y9xqG3UrprzP2zc?=
 =?us-ascii?Q?eIVpwLAad24MdSuRg50Umu6DhbzwaAK+0gSZXWdRUVHJheDuLsfPQoAalhJP?=
 =?us-ascii?Q?TnhkFcx05kRXNjD+RQsx9IMiA2t/IHDQG3bVlnhPtYJPuF9OUWyUVPzbYkS8?=
 =?us-ascii?Q?1AarTSrtEnfsqt8W7BWOM+Z436UvgHELKlwrYLON5EgNs76SsodehWFpyWwg?=
 =?us-ascii?Q?L4+xwfLVjOpjQEn4LFTCa3u5d2INBT6JjWOjVJWrX7YWh5SxVjjdSJ9sVrgD?=
 =?us-ascii?Q?kfaIdCI04x9p76NhjSQiTKSjaAZ9siL1flLBXPt7TWvc4tbYKJC2yws9tcWd?=
 =?us-ascii?Q?Pv6fiUkI9Hc9evUddWcGWy16HWhCYKCXVP/ewQ/yC/aewqDHrJ6amZOBmh71?=
 =?us-ascii?Q?hMsu1jYpGZ0Sxp72igPJv4LEoLYa9TS/7O22fNQob3z4PtkMvxf//Fa97ubZ?=
 =?us-ascii?Q?cIQVTJSBog7dbJG+ooKFEQ5B5TX9d14evU2SmQ09xuFmO1FXgjMZai+G6K0h?=
 =?us-ascii?Q?gmea1+L4zIlMbS47MJ/HWI7aNjyB/cfoIV0pkelH2rJynLjIIXsjZUCqwslj?=
 =?us-ascii?Q?BxlE68mODbH/2HB3FtZvW4+nhCRfg2wZBTTjRLTZY683kRriEe3M6BCZWPEO?=
 =?us-ascii?Q?BpHBemeWBQ7ZQzFcySKS8otsc7Oyww5b+Orpa2EnBnt1dL+xnt3/Ca5M+4KQ?=
 =?us-ascii?Q?UqXW7RdlwlRcRc0UT19PcUVJnIAKcJIxh3oUgugQ3BUBLPmNzlUGxbJYtAO5?=
 =?us-ascii?Q?/w=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e6b1587-5c15-42a8-7616-08db894ef75b
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB4989.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2023 18:27:25.4947
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NK2fPX5Hpjq8wphG6oChxtGgs2c8fBnSH2z46GaSRCkP3Fov/KDc8Av51svvLQVnZxZiYNknfSGX8+GDMZZNwbObkVTFpSloyTDQBZwvG3Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8607
X-Proofpoint-GUID: 29fgYHUATq1FhF6KmBUxnhLfP4tBawmE
X-Proofpoint-ORIG-GUID: 29fgYHUATq1FhF6KmBUxnhLfP4tBawmE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-20_10,2023-07-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 bulkscore=0
 mlxlogscore=999 phishscore=0 priorityscore=1501 clxscore=1015 mlxscore=0
 lowpriorityscore=0 spamscore=0 suspectscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2306200000 definitions=main-2307200155
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>

commit 515ad530795c118f012539ed76d02bacfd426d89 upstream

When adding a rule to a chain referring to its ID, if that chain had been
deleted on the same batch, the rule might end up referring to a deleted
chain.

This will lead to a WARNING like following:

[   33.098431] ------------[ cut here ]------------
[   33.098678] WARNING: CPU: 5 PID: 69 at net/netfilter/nf_tables_api.c:2037 nf_tables_chain_destroy+0x23d/0x260
[   33.099217] Modules linked in:
[   33.099388] CPU: 5 PID: 69 Comm: kworker/5:1 Not tainted 6.4.0+ #409
[   33.099726] Workqueue: events nf_tables_trans_destroy_work
[   33.100018] RIP: 0010:nf_tables_chain_destroy+0x23d/0x260
[   33.100306] Code: 8b 7c 24 68 e8 64 9c ed fe 4c 89 e7 e8 5c 9c ed fe 48 83 c4 08 5b 41 5c 41 5d 41 5e 41 5f 5d 31 c0 89 c6 89 c7 c3 cc cc cc cc <0f> 0b 48 83 c4 08 5b 41 5c 41 5d 41 5e 41 5f 5d 31 c0 89 c6 89 c7
[   33.101271] RSP: 0018:ffffc900004ffc48 EFLAGS: 00010202
[   33.101546] RAX: 0000000000000001 RBX: ffff888006fc0a28 RCX: 0000000000000000
[   33.101920] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
[   33.102649] RBP: ffffc900004ffc78 R08: 0000000000000000 R09: 0000000000000000
[   33.103018] R10: 0000000000000000 R11: 0000000000000000 R12: ffff8880135ef500
[   33.103385] R13: 0000000000000000 R14: dead000000000122 R15: ffff888006fc0a10
[   33.103762] FS:  0000000000000000(0000) GS:ffff888024c80000(0000) knlGS:0000000000000000
[   33.104184] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   33.104493] CR2: 00007fe863b56a50 CR3: 00000000124b0001 CR4: 0000000000770ee0
[   33.104872] PKRU: 55555554
[   33.104999] Call Trace:
[   33.105113]  <TASK>
[   33.105214]  ? show_regs+0x72/0x90
[   33.105371]  ? __warn+0xa5/0x210
[   33.105520]  ? nf_tables_chain_destroy+0x23d/0x260
[   33.105732]  ? report_bug+0x1f2/0x200
[   33.105902]  ? handle_bug+0x46/0x90
[   33.106546]  ? exc_invalid_op+0x19/0x50
[   33.106762]  ? asm_exc_invalid_op+0x1b/0x20
[   33.106995]  ? nf_tables_chain_destroy+0x23d/0x260
[   33.107249]  ? nf_tables_chain_destroy+0x30/0x260
[   33.107506]  nf_tables_trans_destroy_work+0x669/0x680
[   33.107782]  ? mark_held_locks+0x28/0xa0
[   33.107996]  ? __pfx_nf_tables_trans_destroy_work+0x10/0x10
[   33.108294]  ? _raw_spin_unlock_irq+0x28/0x70
[   33.108538]  process_one_work+0x68c/0xb70
[   33.108755]  ? lock_acquire+0x17f/0x420
[   33.108977]  ? __pfx_process_one_work+0x10/0x10
[   33.109218]  ? do_raw_spin_lock+0x128/0x1d0
[   33.109435]  ? _raw_spin_lock_irq+0x71/0x80
[   33.109634]  worker_thread+0x2bd/0x700
[   33.109817]  ? __pfx_worker_thread+0x10/0x10
[   33.110254]  kthread+0x18b/0x1d0
[   33.110410]  ? __pfx_kthread+0x10/0x10
[   33.110581]  ret_from_fork+0x29/0x50
[   33.110757]  </TASK>
[   33.110866] irq event stamp: 1651
[   33.111017] hardirqs last  enabled at (1659): [<ffffffffa206a209>] __up_console_sem+0x79/0xa0
[   33.111379] hardirqs last disabled at (1666): [<ffffffffa206a1ee>] __up_console_sem+0x5e/0xa0
[   33.111740] softirqs last  enabled at (1616): [<ffffffffa1f5d40e>] __irq_exit_rcu+0x9e/0xe0
[   33.112094] softirqs last disabled at (1367): [<ffffffffa1f5d40e>] __irq_exit_rcu+0x9e/0xe0
[   33.112453] ---[ end trace 0000000000000000 ]---

This is due to the nft_chain_lookup_byid ignoring the genmask. After this
change, adding the new rule will fail as it will not find the chain.

Fixes: 837830a4b439 ("netfilter: nf_tables: add NFTA_RULE_CHAIN_ID attribute")
Cc: stable@vger.kernel.org
Reported-by: Mingi Cho of Theori working with ZDI
Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
Reviewed-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Stefan Ghinea <stefan.ghinea@windriver.com>
---
 net/netfilter/nf_tables_api.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index e59cad1f7a36..3d8e7dae11ce 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -2278,7 +2278,7 @@ static int nf_tables_updchain(struct nft_ctx *ctx, u8 genmask, u8 policy,
 
 static struct nft_chain *nft_chain_lookup_byid(const struct net *net,
 					       const struct nft_table *table,
-					       const struct nlattr *nla)
+					       const struct nlattr *nla, u8 genmask)
 {
 	u32 id = ntohl(nla_get_be32(nla));
 	struct nft_trans *trans;
@@ -2288,7 +2288,8 @@ static struct nft_chain *nft_chain_lookup_byid(const struct net *net,
 
 		if (trans->msg_type == NFT_MSG_NEWCHAIN &&
 		    chain->table == table &&
-		    id == nft_trans_chain_id(trans))
+		    id == nft_trans_chain_id(trans) &&
+		    nft_active_genmask(chain, genmask))
 			return chain;
 	}
 	return ERR_PTR(-ENOENT);
@@ -3197,7 +3198,8 @@ static int nf_tables_newrule(struct net *net, struct sock *nlsk,
 			return -EOPNOTSUPP;
 
 	} else if (nla[NFTA_RULE_CHAIN_ID]) {
-		chain = nft_chain_lookup_byid(net, table, nla[NFTA_RULE_CHAIN_ID]);
+		chain = nft_chain_lookup_byid(net, table, nla[NFTA_RULE_CHAIN_ID],
+					      genmask);
 		if (IS_ERR(chain)) {
 			NL_SET_BAD_ATTR(extack, nla[NFTA_RULE_CHAIN_ID]);
 			return PTR_ERR(chain);
@@ -8682,7 +8684,8 @@ static int nft_verdict_init(const struct nft_ctx *ctx, struct nft_data *data,
 						 genmask);
 		} else if (tb[NFTA_VERDICT_CHAIN_ID]) {
 			chain = nft_chain_lookup_byid(ctx->net, ctx->table,
-						      tb[NFTA_VERDICT_CHAIN_ID]);
+						      tb[NFTA_VERDICT_CHAIN_ID],
+						      genmask);
 			if (IS_ERR(chain))
 				return PTR_ERR(chain);
 		} else {
-- 
2.41.0

