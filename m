Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABB8D75B6BA
	for <lists+stable@lfdr.de>; Thu, 20 Jul 2023 20:27:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231915AbjGTS1O (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 20 Jul 2023 14:27:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231933AbjGTS1N (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 20 Jul 2023 14:27:13 -0400
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87AB0270C
        for <stable@vger.kernel.org>; Thu, 20 Jul 2023 11:27:08 -0700 (PDT)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 36K5UVsl019763;
        Thu, 20 Jul 2023 18:27:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
         h=from:to:cc:subject:date:message-id:content-type:mime-version;
         s=PPS06212021; bh=nxBNfbDJqw62cNsdoQC5VUwafHn5q4TsSwMguxmzj0o=; b=
        E3VocVQyyyvQ0FEU4y1M0ysXIprbc0MaC3j/aIoPeMvdWBvpsXqPLvRyNEyJsU/P
        +zz+gHLZCJZIC/qMFyIiB1MQ+g2hAUoxiAMoezhD12kZS6upIFzdlIQOyo2pvkdg
        nCqyh1r1hAgtPlVOjgtxbOgMXyc1vLmKwcO6jbAM/QTsSVq/EwTmKktKLQxuxYnc
        zQ9GAijxQ94CMZjQDxLyqx4kOzxnTEug32Ebd5j+uq0Um+aHDfUYX6Da7TZJrdTA
        4xQUMadnFo2mj+snH+AmBjFHmbrcRJya4Ox+Pm8Jvmj2uvBm+Ds4TLbT8WMzgHdL
        BnSgGg2AFmQ4hR9a/km0aA==
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3run9jvx4y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Jul 2023 18:27:03 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MDot5Y9OArs9T5ruLh3O+rYGvPqmmJdNxOEK8TK+iGHX5E9QcAMd+AzpVa49ewQn+4gdyCIoKSmbZIm0Hi9Uhn4cZZ3LU69TP1eGDIiRCcDXolm72EeXbnwg/eIHOj/4UPy/vDlUW4MHuSt9KSpuyvqwqhp4enXfNZcNgaAdVM826aUtG346kHs622HZdYMrF1FO40xCN6M6TTuHpYdd6HOugaq3ihMjoSTk9YBSkjTop2ISKTCIRdR78yLrhQmG2pB2zjN8bx1vC+Q6yXrozpFj1YZ1lwO72/PT4/XcPWyHzTMVYDs8BticPxxcWaL9yip64LwlVfK4LuN55B/8ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nxBNfbDJqw62cNsdoQC5VUwafHn5q4TsSwMguxmzj0o=;
 b=fk8UtHukFN/PxZZsHOwZwcBGp+nZvXt6NQhefiYFQzruqa1EIj/WDGLhyZEjwSsDXscB97/NXPZmHmDT1IaqeHiOoJ1XyRWsQz7uPkUbm8dhzKGjtTFmdPPHjwPc6BVHurkAKdQvlJT4nQWTDPPqAI9CjlG1QHO+vAdBWcWbpVG0HA39xlF4F8wt7VRLmeM8H3dI0mmKxGPbFLnMxR0GHzdVfB5BcoXDWItVnbywSP8mzI+DGB/VpJAH+HGvZwiSlsHGpVgM26MxmIlU/uyxDJRQsSbJHc4NVAfxARQcNhqLmC6wG6k2miJznNI324Ugt8dl3S7kTDhFFjh4wfbwlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ0PR11MB4989.namprd11.prod.outlook.com (2603:10b6:a03:2d9::22)
 by LV8PR11MB8607.namprd11.prod.outlook.com (2603:10b6:408:1ec::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Thu, 20 Jul
 2023 18:26:59 +0000
Received: from SJ0PR11MB4989.namprd11.prod.outlook.com
 ([fe80::dc1c:8053:63:bdbc]) by SJ0PR11MB4989.namprd11.prod.outlook.com
 ([fe80::dc1c:8053:63:bdbc%4]) with mapi id 15.20.6588.031; Thu, 20 Jul 2023
 18:26:58 +0000
From:   Stefan Ghinea <stefan.ghinea@windriver.com>
To:     stable@vger.kernel.org
Cc:     Thadeu Lima de Souza Cascardo <cascardo@canonical.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Stefan Ghinea <stefan.ghinea@windriver.com>
Subject: [PATCH 5.15 1/1] netfilter: nf_tables: do not ignore genmask when looking up chain by id
Date:   Thu, 20 Jul 2023 21:28:20 +0300
Message-Id: <20230720182820.2649-1-stefan.ghinea@windriver.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: VI1P190CA0050.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:800:1bb::15) To SJ0PR11MB4989.namprd11.prod.outlook.com
 (2603:10b6:a03:2d9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB4989:EE_|LV8PR11MB8607:EE_
X-MS-Office365-Filtering-Correlation-Id: 06511839-9c7d-4adf-a5d9-08db894ee771
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n76IJHG4lSFBSBjWDQASlZKHzqvU39BIqzKtSaUoBu59pAR6AH9uY+ORNQtDi5VosMXqgFnmar3Bf514tUgk1GxLdcgtIN6iGgikTcZyr1nzhltaYobPAmVRxWA/uPD8nMGSumKzv8gxaNfsYuwj0IClU0wNDLpyRX5Mi0ZHgeE0AjOq5g6P3/13Gmdlh6A0/XO7mNm4u6SlIL0AAzwxqUYSURCjxZ7QrVWXgdbhb4+8ZZlBknzXwmjv/ogS682hXEyBSmRJJYcc6e1zQI4xbyQytBJtQeodKNGlOovchr2WUFULuKI8alPl0yZmp4jVf4lLkbvVuAnwfm7ulx+C2X1b8faLeyqewWFz4p7nz+qbx7S92wBE05kdstCdymYWJMPTWSKe0viZ2QvbkxsNfw6g1XMSsqV6jc+GkhdXACM6bu8+zhE/PX0Qezc3icJ9CORxUAUtZBOQl3GHxY3JLVVcDJ/k8Vij/SBdAJBTcmYwfAVeiUaNo8bVNvurYBRVN0XaQGqvVr4eMyT+JpHVTMLurxnLanvzjPlTN8wmHho5uHW9911HkhSNCyO/q08r846LF+E4xbDdoXGDC4+BFCzUPEHL17Em9Cz8XFWHlHBphSMftJN1bjT4is61tUP8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB4989.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39840400004)(366004)(346002)(376002)(396003)(451199021)(107886003)(1076003)(6506007)(66476007)(38100700002)(36756003)(38350700002)(66556008)(54906003)(44832011)(5660300002)(41300700001)(316002)(4326008)(8936002)(6916009)(8676002)(86362001)(2906002)(66946007)(6486002)(52116002)(6666004)(478600001)(6512007)(2616005)(83380400001)(45080400002)(26005)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BnIqxv7aakY4VFKWwjIEIy/+GadUDDrt5me6ezO//iKg/9mjvBwonRsWlQCO?=
 =?us-ascii?Q?rGEpmodxmrVhb1eEra7qhtTUAFy7ioRos8Uo1EPQDexoBZwlsESpnBK6Rs7q?=
 =?us-ascii?Q?3nMIVBCVOFUXDPk5hGBFZngs6Vwcj4cVmUzuGKT9HnBtbP+C2qlu9QA5zmcu?=
 =?us-ascii?Q?pTSNJ8Qp53rp0w5Ua02ABlt/RVGmFXAwXb/eCUhGilTr2MQ//QSCxttALcZQ?=
 =?us-ascii?Q?2Lp9rUZkDKeQJgzcVq9R6TE8Nizlwijkrywp/rJWb6BTabj4xMU59TXj3HTw?=
 =?us-ascii?Q?GAM9Gl+7VFFeKYe1EYTFdQFvMu3vGALcnr+kZe/nc9Uy9/r97LwWYYkUWi1K?=
 =?us-ascii?Q?2LiGdS0xYQ+j2zDUz954Rilgf5IQPOzpjaQuSZpfT+JfSX3LFpeq7iGvwkf4?=
 =?us-ascii?Q?a7UKXaSgATeNj1WcFYvxlx+et44+DkdMNScxaFnDOEGyWHswPFCa5KhfJEqc?=
 =?us-ascii?Q?e8RRiAxyeF3JiFANevDG1uH7vgbHLc6qmU19x64EmzDLbq+7P5FIV3fOPPGJ?=
 =?us-ascii?Q?Zr2NwHlmJqALEow9hJJxhRgwSBdM78cS35apdwAe+1HvYXj+XNUVSdUbvaJV?=
 =?us-ascii?Q?3FW2s1opPzd9FLhnL3+pgrJ2kYwgHfgcQh7rISmIaUIknwXCDovcicOX63aK?=
 =?us-ascii?Q?1dPbXHQI832JzKWMRKgl/E2vtZ3d2vRvFbx/UTKCDtFuck+SQrpIojAN05+7?=
 =?us-ascii?Q?62N3frV4V9KXnLBHPhtq94GFADueph6nJ+5biHrhmzfytxFaKnTQvIbe7vjm?=
 =?us-ascii?Q?VJdQTkn1E2xrLtxkln1bBj9M65wsyr9nXHBLp0c6ijOs4QKxGo48HAiR5cRf?=
 =?us-ascii?Q?0oh1qK2CCUYt6wdPBgd5AgOjKxx2Dbx3gzXjwdvjR8+xoOL+AQKpp0rf7kRa?=
 =?us-ascii?Q?7HmnVV2rOU+Ge3IbQ8rfg/6g5lZWvAwIgvUXt95fO7tf2wwSNr4B6JhXgoy0?=
 =?us-ascii?Q?gqvXgmjm5xoCa80o2Klprb2mTvdSegx9lej/7sBpWWaAqJAa4rBMK0i81FHn?=
 =?us-ascii?Q?SI7//FOczx+soh3gvnsgtMJoRqClcP4R4RCKGwcgEuqPy++pDSWOShlt7913?=
 =?us-ascii?Q?DWTph5lAL0Iz4Jc3n4m8V8L/QntCgqYSQYRXl8VyNNtfWHg4wW7645N7XBm9?=
 =?us-ascii?Q?vTly0919kNjhDNOEZ6XBatI0HTX2UvSvuzsE5PcJjU0XDqXDairjkCNpx2zA?=
 =?us-ascii?Q?BrMAbmPcaC69BRhnHlwOWifmPq/X/EHgEVilLh6tnKmQSztPRuCUM4BqI+Ks?=
 =?us-ascii?Q?0p+A9vl37X+wwRJ4WbOWq7v3yZ9idlHQLSnOAS9Vm1CeJ07jrRUKGxkNxV9x?=
 =?us-ascii?Q?Ws1X/pkLYasnXjTBRlpNYHd2QyVOvsInjl4jqwJeJDPICsHE4lxPmjXz4yNp?=
 =?us-ascii?Q?MfG10CbYvq4a8j4ZE2PV4fzl4i62o3J5AbJ6u/oM1bj37hN5DOtUuAdNRyTt?=
 =?us-ascii?Q?D9ojiqWAEFoIbMUo9HxKw+TWAnMuMUbGQlBTpJopGych+LS1IKeLhknt3hT1?=
 =?us-ascii?Q?AkW2d72Ua4OCcoAg54E0SI+ipE19LvHHRFsKBMTmygRmjBZkSX+6JIO1Fd2Z?=
 =?us-ascii?Q?DlDgueZ+vgPnYiYz8VPwbHRk0rlQH7TgOe1kl74yUeNbTUyHX6A+ipELPSI+?=
 =?us-ascii?Q?2g=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06511839-9c7d-4adf-a5d9-08db894ee771
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB4989.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2023 18:26:58.8338
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jl6gLF67195Nb3c59usCq6FGll1R8lkufN/5jV8Rn9rVEjX7fQcODLyNUzNAnS6XMKkpZ0x+RY0DlTaT+dZxxQgVoKFmpshWjgnYfc3H1fg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8607
X-Proofpoint-GUID: LFIyXjhmzDxXAB4GsJp_UsT0Lwit9yPm
X-Proofpoint-ORIG-GUID: LFIyXjhmzDxXAB4GsJp_UsT0Lwit9yPm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-20_10,2023-07-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 bulkscore=0
 mlxlogscore=999 phishscore=0 priorityscore=1501 clxscore=1011 mlxscore=0
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
index 826bd961d90c..661e9d64c7bd 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -2478,7 +2478,7 @@ static int nf_tables_updchain(struct nft_ctx *ctx, u8 genmask, u8 policy,
 
 static struct nft_chain *nft_chain_lookup_byid(const struct net *net,
 					       const struct nft_table *table,
-					       const struct nlattr *nla)
+					       const struct nlattr *nla, u8 genmask)
 {
 	struct nftables_pernet *nft_net = nft_pernet(net);
 	u32 id = ntohl(nla_get_be32(nla));
@@ -2489,7 +2489,8 @@ static struct nft_chain *nft_chain_lookup_byid(const struct net *net,
 
 		if (trans->msg_type == NFT_MSG_NEWCHAIN &&
 		    chain->table == table &&
-		    id == nft_trans_chain_id(trans))
+		    id == nft_trans_chain_id(trans) &&
+		    nft_active_genmask(chain, genmask))
 			return chain;
 	}
 	return ERR_PTR(-ENOENT);
@@ -3483,7 +3484,8 @@ static int nf_tables_newrule(struct sk_buff *skb, const struct nfnl_info *info,
 			return -EOPNOTSUPP;
 
 	} else if (nla[NFTA_RULE_CHAIN_ID]) {
-		chain = nft_chain_lookup_byid(net, table, nla[NFTA_RULE_CHAIN_ID]);
+		chain = nft_chain_lookup_byid(net, table, nla[NFTA_RULE_CHAIN_ID],
+					      genmask);
 		if (IS_ERR(chain)) {
 			NL_SET_BAD_ATTR(extack, nla[NFTA_RULE_CHAIN_ID]);
 			return PTR_ERR(chain);
@@ -9819,7 +9821,8 @@ static int nft_verdict_init(const struct nft_ctx *ctx, struct nft_data *data,
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

