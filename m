Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE3AB747C68
	for <lists+stable@lfdr.de>; Wed,  5 Jul 2023 07:28:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbjGEF2u (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 5 Jul 2023 01:28:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjGEF2t (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 5 Jul 2023 01:28:49 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2112.outbound.protection.outlook.com [40.107.244.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 880F3E2;
        Tue,  4 Jul 2023 22:28:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jg/dKgIGuSBTfiPiHqNtbpzZ/jLJlcq00lwNkw1iPYftwNMYk7tuwhaA0iAe2rWDvqgzD2YX7FyLw1ghKM2DkkN+pa4p2NeA6zV9bJJLnicLhel9eS2AqhK+gaMs3o8YD08ZH5ENbFN5ABdbE+w8933z9Wmfbjp0HZSLLjvOMKYT2VcGkzOy0Axy00NfO4UkV5qnSCROFPfsob0e8rYeP7fqDBFGVT9uJKmKkqWGmJR+9OLtcWNYyL5Fq0y9vu624FnVfHqCCuVRQyC564umgWNH+Acp730ka+AqyDnLu848Wc+jgLujiAVQudrOsxc3UT6OBTCFSRDHBF6K14SyIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z94uFq3Qid4lhL0r52QQv4NTix9YbJASUhgrePS5BQY=;
 b=gn9a7rPhR1Pu16iMkMRyWgRIz7J73k6jCByKads4DFkKKfAq6TYdMnGRsScYvzIMKID8LvMAAsxLgVRSJMwKvrceIjnwiWUhE+2HB1uwZmJKk7tTK18jcCprTLyJwGCeMQX4qYEyWRYSO+mieqvwlvdA1raxMWjlfoPzTYsq+6giiDvKgWqBAgTnzJzu7Gi4GSBxvwOrUgAJohRBWlBTF2apfe8vtjOYq63CYJrdypDAg1yKuq0pqGfqT+nkxZrLGcDTzvMgBElmLkxYdCZLPYpFPzhZnIAdHJA1YJz3hUY/Mnv2t1TYR5G77xQejs3IAq8FwdDIbctjhPeJdFBYyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z94uFq3Qid4lhL0r52QQv4NTix9YbJASUhgrePS5BQY=;
 b=QR6Nw27AOGvXiDWw1GBuw2MjtZMdAIJTQcTByhY5LFP2e+PUJgQcFWAeaoWFmxC2/M36/gHgbr1Rz/2+hpzArdqa8PiFnl36oNbxcgtC4QgCjz//yrtfFCM5XFLXxsdxei+0rKZTGE+hc4jimJ7HjEvYXpxxc7GDmpNYjtQbIsc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from DM6PR13MB4249.namprd13.prod.outlook.com (2603:10b6:5:7b::25) by
 CH2PR13MB4410.namprd13.prod.outlook.com (2603:10b6:610:64::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6544.24; Wed, 5 Jul 2023 05:28:46 +0000
Received: from DM6PR13MB4249.namprd13.prod.outlook.com
 ([fe80::eb7b:880f:dc82:c8d1]) by DM6PR13MB4249.namprd13.prod.outlook.com
 ([fe80::eb7b:880f:dc82:c8d1%4]) with mapi id 15.20.6544.024; Wed, 5 Jul 2023
 05:28:46 +0000
From:   Louis Peens <louis.peens@corigine.com>
To:     David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     Jacob Keller <jacob.e.keller@intel.com>,
        Simon Horman <simon.horman@corigine.com>,
        Yinjun Zhang <yinjun.zhang@corigine.com>,
        netdev@vger.kernel.org, stable@vger.kernel.org,
        oss-drivers@corigine.com
Subject: [PATCH net v3] nfp: clean mc addresses in application firmware when closing port
Date:   Wed,  5 Jul 2023 07:28:18 +0200
Message-Id: <20230705052818.7122-1-louis.peens@corigine.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0165.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:45::18) To DM6PR13MB4249.namprd13.prod.outlook.com
 (2603:10b6:5:7b::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR13MB4249:EE_|CH2PR13MB4410:EE_
X-MS-Office365-Filtering-Correlation-Id: bde8c4a7-6a3f-4cd5-deec-08db7d18b449
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0xV16X4GyZz6MOi5eKePutjMsxkhedNGm1md07dDRt6Dmm/K8OS8FWyKApRoHyiIYF3m5vlpuch7JuzOj4KenwITC0y8AT2+Ea1SVTgmqXyA2ekiXheRHC3aZnvqAdTa4TMsCiOgAKYJ5mzsEioRaOGuO47TKTePNZVnVyDBzsUg/iCZgUY3m4jxq6nED82KQFY0k7BYK744sZH+yPNb6t8h2OIapBaOQcofP17x1911WcQ6NlLHADzPuXgLzGMWWOsMlm9ZrWLtbgMSMkHpzCiu+lfx+WEon1fD0lkMGm9/Dbdh5udY4vpi7+6tw+fiz68lF8awAxZ/25VN4sYA5T/9Ou6WSeDahGLa+ksL4wJGcxssH0KKHuGAS5WMB0IFy5ebjBfwNMbUMEtjVXYkFdEagL9BrupQaeYm28+nSOquGjdRJOkxxv2ECxkPPcu8tt93tpSQ+FXWwjAd0/HBYMz8EhFNvAK1MIu3gPrmMIhOUM+ShM4JhBn/ly+OnGDVT9iw5MNfMDlU0cOINJlJMgV+wodrdAdDEX8Z4wMEJ68hcPcjU0U4juYdKKQS0S5hBsUFkPxXhiJQmEFReMcCek/VJfGleoJc/JL7hnHP/F2KhQVXIJAvALkcWUHqrbcNHTSF7UmoEJr4yh62vDH1/8iTJRDITs3GBTZIRoN/OOA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR13MB4249.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(136003)(396003)(366004)(39840400004)(451199021)(26005)(107886003)(478600001)(6506007)(6666004)(1076003)(6512007)(86362001)(2616005)(186003)(54906003)(38350700002)(4326008)(38100700002)(66946007)(66556008)(83380400001)(110136005)(66476007)(6486002)(52116002)(316002)(8676002)(44832011)(41300700001)(2906002)(8936002)(5660300002)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Jkaij4pmzuRuqzMJgN+quwPwZZP/PJv2/24PmjzHxqstf2l6GeEp66Dq6MqM?=
 =?us-ascii?Q?6AnqhDNjEs5x0lgYCEEKXSZuBdY70pkHdMYt6TyYCG9V/Y0EIMXo658O+u6s?=
 =?us-ascii?Q?NJ6I/A0wjwRUJTUPFlc3kdzyIOdCQNTsN1fB6hHs41T6Id30tm5RD6m87zch?=
 =?us-ascii?Q?i+d53B4m9L0G52F5VJE5M4f9x3dwMCfeHVrKxaPWIyVRzGE6IThQyhIsPl1x?=
 =?us-ascii?Q?Yub+cXgLLu15oysAeAf8izKH02GB0oNVhMKoV95Cf92BkLjAb6EwgWQhyKzq?=
 =?us-ascii?Q?ipLZ4q7wjrfK8qb3zTIX+obSzP2mA2yIUJMM45PR9fyeQXfWNr1WYIp2V/Q4?=
 =?us-ascii?Q?W0Vvc3siDebEwT/FnJimmhsinwOcQ37tZIizJbmNW1bf7IWfmj+MaY/jdNs/?=
 =?us-ascii?Q?ATQkIFWdjpPNkppbBHTf5d/0xZk88a9iU6p7n0kKuR2B5H4lHWrsObZU+U3l?=
 =?us-ascii?Q?2SQhMYamfbI4gOzddI6FNmE16hvW9AlNl0oEurBQYP18yTQdCrGQF3uUicqC?=
 =?us-ascii?Q?7Q57pzveqgOw8+7Bb5aMJ/BSdlbL9vLUYhCfYRfFmXB52WzwmEkzEn5QurNF?=
 =?us-ascii?Q?Hbn6qMNQndeQWlnfwjGPB4lfAz42AmtZl/sT/mdu19zCxJMAN+Jrx20LGNWL?=
 =?us-ascii?Q?n6193vmpH0XMvSgMaUd8k9ITJrNds95Et5Ghiw0F6aZwdF5XG1QFCZZFlS9Z?=
 =?us-ascii?Q?uK52tHi7/DUP7C3MkGrCp2QG4Py0B/aeVlr9glTccrE44/5fXCs7XQJ4tGcD?=
 =?us-ascii?Q?gt6c3BvQLdEYBOWx63Ik7zQl4oC9FJEIfMmID0eCmgTmQtOLSO5cNfIl5u4t?=
 =?us-ascii?Q?KwVaxB+9vQAYjC4qIJO2OCb6JqdLqLIah1OmAjvDU66JqbWltlfAgpT23Jce?=
 =?us-ascii?Q?gJ17ufHCAFa2N7MpdYUtPIqFcnVi8VlAeW2jY2KwCCKeve/dlOea/zYKVejv?=
 =?us-ascii?Q?BhFAQ+dY4GA5vFFR458U1WuMdxG6hGo3hPjgZeiRHe1fqikq6p9gLztBBi0K?=
 =?us-ascii?Q?NFGXV5Re7KukI0LC+ypz7qfMaOFRCL2IY98FpCrvWnymz85EnqEV07IBTL6o?=
 =?us-ascii?Q?hfp+XL5RQPaqkzEv7dqR6lRrCcjMJFtb2ZLLNas7ztQb6/eBrF8ljFr0QEuB?=
 =?us-ascii?Q?/xuzzgtqOWieNpGt76Qk+toz5LKsVZs/hPkoZ4zLCA9NFiFwIeCQHk+mvKho?=
 =?us-ascii?Q?TppbXX5CmxOGCuBcY/f9+IYuRgJhP064P+mcxcET1WkkvZ9wdr9ZiW2WkXFI?=
 =?us-ascii?Q?gZj5SL63U33xo8ZAPVFwC7r7LVZZ2DQa1eK2070CJdnRQnXXiqAGP30hqIuk?=
 =?us-ascii?Q?Z7SFMYAnBFae9Nd10AfB0Dx4IQNbBZuRA31kV6YU5z7R4/v/ZKAF465HxNgx?=
 =?us-ascii?Q?eSh5lRX84PHdtQ71mOhK9e+yGZ6KiUPSx4VNwypyr9sTc9V8raYve9b2QtVm?=
 =?us-ascii?Q?90fP/RRsVZ4QzQi6jOCqMhyIqNlHWG+0ld2zdjUdKX2txwbba8LPTv/PHAbA?=
 =?us-ascii?Q?BNpF8uOz/T5P/O94NHCstFm8Obx/eZhKiHG8WbfpAhzyim4sr15xKxhR/2cs?=
 =?us-ascii?Q?M395elMZMTfHUtoLFHVLVYtHDMEZU6a7GNUWMiAAQVefx4iI6nPStq4dwVBR?=
 =?us-ascii?Q?6g=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bde8c4a7-6a3f-4cd5-deec-08db7d18b449
X-MS-Exchange-CrossTenant-AuthSource: DM6PR13MB4249.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 05:28:46.4371
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: duOYsYZcTZp2zPoKfjwSYU/u6+cwp+0y7CMijGFRmiDPF9FDXnVGAYMtEaviLxmYhH6IAJu22G4ACxH3cm5QFGp70n5utBUwKqp6ytCWOUc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB4410
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Yinjun Zhang <yinjun.zhang@corigine.com>

When moving devices from one namespace to another, mc addresses are
cleaned in software while not removed from application firmware. Thus
the mc addresses are remained and will cause resource leak.

Now use `__dev_mc_unsync` to clean mc addresses when closing port.

Fixes: e20aa071cd95 ("nfp: fix schedule in atomic context when sync mc address")
Cc: stable@vger.kernel.org
Signed-off-by: Yinjun Zhang <yinjun.zhang@corigine.com>
Acked-by: Simon Horman <simon.horman@corigine.com>
Signed-off-by: Louis Peens <louis.peens@corigine.com>
---
Changes since v2:
* Use function prototype to avoid moving code chunk.

Changes since v1:

* Use __dev_mc_unsyc to clean mc addresses instead of tracking mc addresses by
  driver itself.
* Clean mc addresses when closing port instead of driver exits,
  so that the issue of moving devices between namespaces can be fixed.
* Modify commit message accordingly.

 drivers/net/ethernet/netronome/nfp/nfp_net_common.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/netronome/nfp/nfp_net_common.c b/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
index 49f2f081ebb5..6b1fb5708434 100644
--- a/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
+++ b/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
@@ -53,6 +53,8 @@
 #include "crypto/crypto.h"
 #include "crypto/fw.h"
 
+static int nfp_net_mc_unsync(struct net_device *netdev, const unsigned char *addr);
+
 /**
  * nfp_net_get_fw_version() - Read and parse the FW version
  * @fw_ver:	Output fw_version structure to read to
@@ -1084,6 +1086,9 @@ static int nfp_net_netdev_close(struct net_device *netdev)
 
 	/* Step 2: Tell NFP
 	 */
+	if (nn->cap_w1 & NFP_NET_CFG_CTRL_MCAST_FILTER)
+		__dev_mc_unsync(netdev, nfp_net_mc_unsync);
+
 	nfp_net_clear_config_and_disable(nn);
 	nfp_port_configure(netdev, false);
 
-- 
2.34.1

