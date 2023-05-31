Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 023FE718888
	for <lists+stable@lfdr.de>; Wed, 31 May 2023 19:35:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbjEaRfF (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 31 May 2023 13:35:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230293AbjEaRfB (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 31 May 2023 13:35:01 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10EFDBE
        for <stable@vger.kernel.org>; Wed, 31 May 2023 10:34:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PGmlR1XizcY0sl4FKf3Q0h4Q2tuxjoTK1P4N0QcQt5AXj5ofs6V/ZAurKyFWDSNf7C25nQvCgIYgW8u8Tyh1zG+C5Fdpa24wz1BmFYW4Jq6YTERH8yvdI78LuM++O/VZ6Dr0IThQtunlDVRC8Trsabces1b0FDpz/0paSpG8LDzzpvC3PaIjzt2vO6IskWvKUA7hyRNcwNPz4iWaXucKep4hSlm43FMwdcWWQBjk1WdQah6EKv1nsuBxIO/eTHIc0X56VjDyAV/CnbqbqsEmVJAA0hH9PbS2lw7m1FT3ltoshfA9ysiM8xjndRmfS+/w32m5ABQVTfauHYm9eaqbtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2AStxlw95dn8YnK65Gyw/AwcqRPjagrre3YP/4M7ksM=;
 b=X0JjqnGoYpwo2G2Qwz9T/71uKZNSRF6ZX5bWZqx51VER2NYDKhT3bAVDbpEmCnBIGPwXHZ7Cj7YWQOlJdYzUekoR7Elhre1ZpgfKYA0oXySdfx7LyIweyXmdgHNKmlPNTAeltuXcDgKc/2c0zZXy1xPxzQ9EfAE3hSkvlrOv1xf2H6ckGDcl5I5GD90fvn1pxvPjUrrUWEu5soaB7ZffijCEkb8D2kwK1kIDgCTRpjnevQvbE09atL4MkyhM/yFiPCitRkul1yXSNK7fokhokSZibbxJuF0+jZKVzIQzpQgNccrnSl4CpXVA7Z45eJv/4xxxhfI/oUUWMnQjQKFMQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.4.225.30) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=infinera.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=infinera.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infinera.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2AStxlw95dn8YnK65Gyw/AwcqRPjagrre3YP/4M7ksM=;
 b=lD/Ij4Yp8S4DneQRnTBAYvVzNbq/hja6yCu2NfMy/3Ygt0BJ0RVkb3GjtyROa4R6RFnJ3smzo/VxVTO1W38v8HbMns2a7RdZ/wGSH0M5zYvukc6v8dYi5UR7hEwMgivnzyzMCltHnin9Xmov72oG9ird6MpVKTgqDMDfbk28uc8pOJIlWHOZk03n6rliVTyEW4dR9Ob/NJAYGrRNdNhTw7RGuPfKYOmMIPaPc7rJRJqJxHzNDNDKw4UpflGVmx8gN62zJw5Bsqf2sGy7DuiWvihAnctMweRBDkmc52foAffI+i2Kr3eq2PkGi33zYVp6Rmb0SfwKumnybpharwKKSw==
Received: from MW4PR04CA0154.namprd04.prod.outlook.com (2603:10b6:303:85::9)
 by SA1PR10MB6664.namprd10.prod.outlook.com (2603:10b6:806:2b3::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.22; Wed, 31 May
 2023 17:34:54 +0000
Received: from CO1NAM11FT025.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:85:cafe::c4) by MW4PR04CA0154.outlook.office365.com
 (2603:10b6:303:85::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.25 via Frontend
 Transport; Wed, 31 May 2023 17:34:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.4.225.30)
 smtp.mailfrom=infinera.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=infinera.com;
Received-SPF: Pass (protection.outlook.com: domain of infinera.com designates
 8.4.225.30 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.4.225.30; helo=owa.infinera.com; pr=C
Received: from owa.infinera.com (8.4.225.30) by
 CO1NAM11FT025.mail.protection.outlook.com (10.13.175.232) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.23 via Frontend Transport; Wed, 31 May 2023 17:34:53 +0000
Received: from sv-ex16-prd.infinera.com (10.100.96.229) by
 sv-ex16-prd.infinera.com (10.100.96.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Wed, 31 May 2023 10:34:53 -0700
Received: from sv-smtp-prod3.infinera.com (10.100.98.58) by
 sv-ex16-prd.infinera.com (10.100.96.229) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Wed, 31 May 2023 10:34:53 -0700
Received: from se-metroit-prd1.infinera.com ([10.210.32.58]) by sv-smtp-prod3.infinera.com with Microsoft SMTPSVC(8.5.9600.16384);
         Wed, 31 May 2023 10:34:02 -0700
Received: from gentoo-jocke.infinera.com (gentoo-jocke.infinera.com [10.210.71.73])
        by se-metroit-prd1.infinera.com (Postfix) with ESMTP id 50EA72C06D80;
        Wed, 31 May 2023 19:34:01 +0200 (CEST)
Received: by gentoo-jocke.infinera.com (Postfix, from userid 1001)
        id 4A6A520062E8; Wed, 31 May 2023 19:34:01 +0200 (CEST)
From:   Joakim Tjernlund <joakim.tjernlund@infinera.com>
To:     <stable@vger.kernel.org>
CC:     Romain Izard <romain.izard.pro@gmail.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Joakim Tjernlund <joakim.tjernlund@infinera.com>
Subject: [PATCH 1/2] usb: gadget: f_ncm: Add OS descriptor support
Date:   Wed, 31 May 2023 19:33:57 +0200
Message-ID: <20230531173358.910767-1-joakim.tjernlund@infinera.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 31 May 2023 17:34:02.0754 (UTC) FILETIME=[1757EE20:01D993E6]
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT025:EE_|SA1PR10MB6664:EE_
X-MS-Office365-Filtering-Correlation-Id: a9355f2c-65ed-4540-9a4a-08db61fd585c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KgvvAseP/7zt8YS4ajob5UhAp1rDsCa5Zk1wZQgaj74WSgWptoSQP/SO7OBhjT7xMTW+h65YK4gjYacsEJJY/mA/auXBSGnI/36fzh95L7WJyu19OxebSItkrMNy3/ib2/MzmelxGMXehDZS8S34kFtN0MYkqtIqT3MW3gzrTXXzSrgst0NsDhh31qrcAwLTivYK9xLJUKS1qLrwYjJgkKaUywCX0VOwR2jTniDgzt34cO1LBPQjWkTcKLblwraAmwR9VGecQuS73Uyb7a3VCfX/6j4fUqKfr3sZB4o7wX6GJwXUxUVC8YcqfsERkVf5PLhS9piWcKU55TFM1u1KAF4LMJOmQwLzzWUcyZ+UVjuB3gNBhIim93OP9jIU/b6OtGJXqgSn990Ba0dnOp8RPL6O1R+CS+wrHdhlXPBVyCbp60Z8K/5l5w5PKompN09XB3NYxJiAUDjdT4VYorrBqWi7aObLxLj96Z23Q6eAruCejcEeafIpMtrq4EqNMPRxWrHbfG3qOFY45WsNgkOTsDqiK2wdbPTdamU5xMU0OwuvXf175xVayvSwyfK3+RqILdTrWrHjOtF7XwkqpA9jzegLQaD6430VhEL4xxPWRgsXO1LYccGegYbyN5l+rFhKhZjZdhUqiEX5yM491nRChM25Uvc2K1mMKkjLB0qvBDKXwd/NaV/JpnmJeXkaOrZeNSUtZjzgXT5HCRwbXCFFHNwPWD0lwClbannMrZ9yND3i9e3bOg9hpIipbygiQ5xz
X-Forefront-Antispam-Report: CIP:8.4.225.30;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:owa.infinera.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(39860400002)(376002)(396003)(451199021)(46966006)(36840700001)(36756003)(186003)(82310400005)(6266002)(86362001)(2906002)(107886003)(5660300002)(1076003)(26005)(426003)(45080400002)(336012)(6666004)(44832011)(2616005)(40480700001)(54906003)(82740400003)(478600001)(83380400001)(316002)(19627235002)(47076005)(41300700001)(6916009)(356005)(70206006)(4326008)(81166007)(42186006)(70586007)(36860700001)(8936002)(8676002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: infinera.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2023 17:34:53.9516
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a9355f2c-65ed-4540-9a4a-08db61fd585c
X-MS-Exchange-CrossTenant-Id: 285643de-5f5b-4b03-a153-0ae2dc8aaf77
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=285643de-5f5b-4b03-a153-0ae2dc8aaf77;Ip=[8.4.225.30];Helo=[owa.infinera.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT025.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6664
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Romain Izard <romain.izard.pro@gmail.com>

To be able to use the default USB class drivers available in Microsoft
Windows, we need to add OS descriptors to the exported USB gadget to
tell the OS that we are compatible with the built-in drivers.

Copy the OS descriptor support from f_rndis into f_ncm. As a result,
using the WINNCM compatible ID, the UsbNcm driver is loaded on
enumeration without the need for a custom driver or inf file.

Signed-off-by: Romain Izard <romain.izard.pro@gmail.com>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Joakim Tjernlund <joakim.tjernlund@infinera.com>
Cc: stable@vger.kernel.org # v4.19
---

 Seems to have been forgotten when backporting NCM fixes.
 Needed to make Win10 accept Linux NCM gadget ethernet

 drivers/usb/gadget/function/f_ncm.c | 47 +++++++++++++++++++++++++++--
 drivers/usb/gadget/function/u_ncm.h |  3 ++
 2 files changed, 47 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/gadget/function/f_ncm.c b/drivers/usb/gadget/function/f_ncm.c
index e4aa370e86a9..b4571633f7b5 100644
--- a/drivers/usb/gadget/function/f_ncm.c
+++ b/drivers/usb/gadget/function/f_ncm.c
@@ -23,6 +23,7 @@
 #include "u_ether.h"
 #include "u_ether_configfs.h"
 #include "u_ncm.h"
+#include "configfs.h"
 
 /*
  * This function is a "CDC Network Control Model" (CDC NCM) Ethernet link.
@@ -1432,6 +1433,16 @@ static int ncm_bind(struct usb_configuration *c, struct usb_function *f)
 		return -EINVAL;
 
 	ncm_opts = container_of(f->fi, struct f_ncm_opts, func_inst);
+
+	if (cdev->use_os_string) {
+		f->os_desc_table = kzalloc(sizeof(*f->os_desc_table),
+					   GFP_KERNEL);
+		if (!f->os_desc_table)
+			return -ENOMEM;
+		f->os_desc_n = 1;
+		f->os_desc_table[0].os_desc = &ncm_opts->ncm_os_desc;
+	}
+
 	/*
 	 * in drivers/usb/gadget/configfs.c:configfs_composite_bind()
 	 * configurations are bound in sequence with list_for_each_entry,
@@ -1445,13 +1456,15 @@ static int ncm_bind(struct usb_configuration *c, struct usb_function *f)
 		status = gether_register_netdev(ncm_opts->net);
 		mutex_unlock(&ncm_opts->lock);
 		if (status)
-			return status;
+			goto fail;
 		ncm_opts->bound = true;
 	}
 	us = usb_gstrings_attach(cdev, ncm_strings,
 				 ARRAY_SIZE(ncm_string_defs));
-	if (IS_ERR(us))
-		return PTR_ERR(us);
+	if (IS_ERR(us)) {
+		status = PTR_ERR(us);
+		goto fail;
+	}
 	ncm_control_intf.iInterface = us[STRING_CTRL_IDX].id;
 	ncm_data_nop_intf.iInterface = us[STRING_DATA_IDX].id;
 	ncm_data_intf.iInterface = us[STRING_DATA_IDX].id;
@@ -1468,6 +1481,10 @@ static int ncm_bind(struct usb_configuration *c, struct usb_function *f)
 	ncm_control_intf.bInterfaceNumber = status;
 	ncm_union_desc.bMasterInterface0 = status;
 
+	if (cdev->use_os_string)
+		f->os_desc_table[0].if_id =
+			ncm_iad_desc.bFirstInterface;
+
 	status = usb_interface_id(c, f);
 	if (status < 0)
 		goto fail;
@@ -1547,6 +1564,9 @@ static int ncm_bind(struct usb_configuration *c, struct usb_function *f)
 	return 0;
 
 fail:
+	kfree(f->os_desc_table);
+	f->os_desc_n = 0;
+
 	if (ncm->notify_req) {
 		kfree(ncm->notify_req->buf);
 		usb_ep_free_request(ncm->notify, ncm->notify_req);
@@ -1601,16 +1621,22 @@ static void ncm_free_inst(struct usb_function_instance *f)
 		gether_cleanup(netdev_priv(opts->net));
 	else
 		free_netdev(opts->net);
+	kfree(opts->ncm_interf_group);
 	kfree(opts);
 }
 
 static struct usb_function_instance *ncm_alloc_inst(void)
 {
 	struct f_ncm_opts *opts;
+	struct usb_os_desc *descs[1];
+	char *names[1];
+	struct config_group *ncm_interf_group;
 
 	opts = kzalloc(sizeof(*opts), GFP_KERNEL);
 	if (!opts)
 		return ERR_PTR(-ENOMEM);
+	opts->ncm_os_desc.ext_compat_id = opts->ncm_ext_compat_id;
+
 	mutex_init(&opts->lock);
 	opts->func_inst.free_func_inst = ncm_free_inst;
 	opts->net = gether_setup_default();
@@ -1619,8 +1645,20 @@ static struct usb_function_instance *ncm_alloc_inst(void)
 		kfree(opts);
 		return ERR_CAST(net);
 	}
+	INIT_LIST_HEAD(&opts->ncm_os_desc.ext_prop);
+
+	descs[0] = &opts->ncm_os_desc;
+	names[0] = "ncm";
 
 	config_group_init_type_name(&opts->func_inst.group, "", &ncm_func_type);
+	ncm_interf_group =
+		usb_os_desc_prepare_interf_dir(&opts->func_inst.group, 1, descs,
+					       names, THIS_MODULE);
+	if (IS_ERR(ncm_interf_group)) {
+		ncm_free_inst(&opts->func_inst);
+		return ERR_CAST(ncm_interf_group);
+	}
+	opts->ncm_interf_group = ncm_interf_group;
 
 	return &opts->func_inst;
 }
@@ -1646,6 +1684,9 @@ static void ncm_unbind(struct usb_configuration *c, struct usb_function *f)
 
 	hrtimer_cancel(&ncm->task_timer);
 
+	kfree(f->os_desc_table);
+	f->os_desc_n = 0;
+
 	ncm_string_defs[0].id = 0;
 	usb_free_all_descriptors(f);
 
diff --git a/drivers/usb/gadget/function/u_ncm.h b/drivers/usb/gadget/function/u_ncm.h
index 67324f983343..dfd75ad61b3f 100644
--- a/drivers/usb/gadget/function/u_ncm.h
+++ b/drivers/usb/gadget/function/u_ncm.h
@@ -20,6 +20,9 @@ struct f_ncm_opts {
 	struct net_device		*net;
 	bool				bound;
 
+	struct config_group		*ncm_interf_group;
+	struct usb_os_desc		ncm_os_desc;
+	char				ncm_ext_compat_id[16];
 	/*
 	 * Read/write access to configfs attributes is handled by configfs.
 	 *
-- 
2.39.3

