Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FFF77345E4
	for <lists+stable@lfdr.de>; Sun, 18 Jun 2023 13:41:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbjFRLlE (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 18 Jun 2023 07:41:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjFRLlD (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 18 Jun 2023 07:41:03 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2047.outbound.protection.outlook.com [40.107.243.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4885D13D
        for <stable@vger.kernel.org>; Sun, 18 Jun 2023 04:41:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jIvRe8mczh6jsUSR+4aj1RQnnp+WeIr9Wens7mb3fdfN1K+VmVlwCbos87hVEFOZLnVxfmHt9v5WeAF4MjauBFsILxEZTCJo4U6YA46AxB2OZtAT9KikC/w5y26JFiIm00jBiCJIt0bGuHOQ9cY9YcSWs5bGNj6HK8vzJeefNrl4XPmRNBcLrF9pJ7ocZpAWqxuzIQBDSicHnYfOZHi1ujsKjNBZDtXzBO3FwV57NvAxnAlZTxXBCBsngzArAtT7FQx00adI9DF2KuteEmXSwBYdDD058M32FA/9q/JijHxHIrsOOgiJaF0yUY9FQ/zADCXMq81bYZOvjEiVoMvLtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W8M31XS8GD6NetpQnZwE6ExHS2k6OEEfV19jcWh2NL0=;
 b=KKGb23MoHYfXK7XCYaBZaWaPBEuWNgvn7qh5R8Za3RloEwon17jlQ3p3BTUDQWwbRzRafOebUKiv+k89tsldfAGpTTu0/vl+ZhffOBMRiZcWawXwSuq9T7yWZvhAne8HnEU9PZzj3fCmuNA+IuHVwDTaUMZXU2GCaOzoQn1G2FPT78tvOehmde+FlBsjI6BXQxnVR/DXNzwsBqVq5/BhKBr2j8uq8melmj+npQzfrA659b3Xfdy4Je7K4E1sFJPe2WqDneS0R/PsAHg30Xx+akwlh2XAt5R5Icj5/yhtOpla0zuC4kWo+OK+zaQrz/11eHGCGc6ZPFGgC+28iJhg0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.4.225.30) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=infinera.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=infinera.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infinera.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W8M31XS8GD6NetpQnZwE6ExHS2k6OEEfV19jcWh2NL0=;
 b=NtH9kbEJFr1b4WYUzaetFAD4FNdlXbLs7YBiFYbzBdBvgu2YZV5KL40HQRdXwRpGRHfCDLvmUwgXNG0f5i1QGo5r1+itY00UY/GlMXVgkkl5Kfrcu9y8VVvdE/ThSYDFLS0VlmozMto2QP8d9w1QTQqVY5lMVprERclY+zT2g5au/QjrPno79HnfnJqZ45ASanrJIk2GSbM77JTMCurh9SVkE53+27c9dyo50NVnoOYUYhZFR8ox8V+jWnTQMS0PruK7nFKVG/3e+pvvi3UfDGcJLms82Z8NAl8q3KTZKBuJccKjSFeYqD5vgCbDL+iLOAMB9JTm34QYATLzZ/hjHQ==
Received: from DS7PR03CA0071.namprd03.prod.outlook.com (2603:10b6:5:3bb::16)
 by CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.35; Sun, 18 Jun
 2023 11:40:57 +0000
Received: from MWH0EPF000971E7.namprd02.prod.outlook.com
 (2603:10b6:5:3bb:cafe::74) by DS7PR03CA0071.outlook.office365.com
 (2603:10b6:5:3bb::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.35 via Frontend
 Transport; Sun, 18 Jun 2023 11:40:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.4.225.30)
 smtp.mailfrom=infinera.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=infinera.com;
Received-SPF: Pass (protection.outlook.com: domain of infinera.com designates
 8.4.225.30 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.4.225.30; helo=owa.infinera.com; pr=C
Received: from owa.infinera.com (8.4.225.30) by
 MWH0EPF000971E7.mail.protection.outlook.com (10.167.243.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.19 via Frontend Transport; Sun, 18 Jun 2023 11:40:57 +0000
Received: from sv-ex16-prd.infinera.com (10.100.96.229) by
 sv-ex16-prd.infinera.com (10.100.96.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Sun, 18 Jun 2023 04:40:55 -0700
Received: from sv-smtp-prod3.infinera.com (10.100.98.58) by
 sv-ex16-prd.infinera.com (10.100.96.229) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Sun, 18 Jun 2023 04:40:55 -0700
Received: from se-metroit-prd1.infinera.com ([10.210.32.58]) by sv-smtp-prod3.infinera.com with Microsoft SMTPSVC(8.5.9600.16384);
         Sun, 18 Jun 2023 04:40:55 -0700
Received: from gentoo-jocke.infinera.com (gentoo-jocke.infinera.com [10.210.71.73])
        by se-metroit-prd1.infinera.com (Postfix) with ESMTP id C53B22C06D80;
        Sun, 18 Jun 2023 13:40:54 +0200 (CEST)
Received: by gentoo-jocke.infinera.com (Postfix, from userid 1001)
        id B94E82000BC8; Sun, 18 Jun 2023 13:40:54 +0200 (CEST)
From:   Joakim Tjernlund <joakim.tjernlund@infinera.com>
To:     "stable @ vger . kernel . org" <stable@vger.kernel.org>,
        <gregkh@linuxfoundation.org>
CC:     Romain Izard <romain.izard.pro@gmail.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Joakim Tjernlund <joakim.tjernlund@infinera.com>
Subject: [PATCHv2 1/2] usb: gadget: f_ncm: Add OS descriptor support
Date:   Sun, 18 Jun 2023 13:40:49 +0200
Message-ID: <20230618114050.2750443-1-joakim.tjernlund@infinera.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <2023061834-relative-gem-0d53@gregkh>
References: <2023061834-relative-gem-0d53@gregkh>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 18 Jun 2023 11:40:55.0995 (UTC) FILETIME=[BE7C90B0:01D9A1D9]
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E7:EE_|CO1PR10MB4531:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b898dc8-5266-4866-0634-08db6ff0e1b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p2nRmBXZG/Fa+kpAIq5Jywn8W1kiQLSEr7lRNBOzxIYqQo25j7vXn27fk6lkJt424ymyGLus86DRZ1f2oMaXF0gYbbhIt/iPGWuq+c8wfCj8dM6qO1OGGWYSGRUY8IaFI4dIBd3I+B6zK2FnFxtzpvNb25PA3/J8rP5aZxYU2dz1ugCYJgpMvWZkS4bQchgPqwjtXaxHV/ATMwxwJ6EhjkvAApAFZX/h/yzV2LJYagJanev6ianFBiNuQgGeAf5QtVtTPZiZoexwpU2YYb0Lt95DEfdrGVnUru6PMk5ROt22XbHpamUJU+MhxsZ2/KMrVx4sh5fxT0hlMg7YQKo0oMtK43vcRhM+riXf2KJT+78rJ3zECPDmVitrK/MFY7Xx6cSqyA3G85vPVZDuPX+rFYzI3egFNMTg7RYDLWp9hXYnwE0wG5vgtFiOQWoDLayDwm9A0KYhfdVWPMDNoow2xuFoGsfBETpZiO1raQ5P9Nz6DTE6NfCMP1+ga5tnwnN3ZMTe6IuAjsvScnKTqIJo6VIBTduqXI6vmqKg6BFPfM8LIIOIImiUsR6HzfxiAzgCT75G0Mj4ZlB0iNL/imG1rY0zGlFs0nTsL8Eb3FhxGpDWiNG3OIQvqx2PtJg6o5e2mQ50K6+c9yKEQbty2jMXtqJfBRpMx0xe3PeV06ggmds6caVwOY+McjbLZF5Zgui4Ptb4t8DNFfElEVBrxGgSBHAwIXSDZyXPQbZ3vvDdgZ/ThrRVVyCHd36m1JY0pTCj
X-Forefront-Antispam-Report: CIP:8.4.225.30;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:owa.infinera.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39850400004)(346002)(376002)(136003)(396003)(451199021)(36840700001)(46966006)(6666004)(45080400002)(478600001)(107886003)(1076003)(5660300002)(86362001)(36756003)(2906002)(82310400005)(44832011)(54906003)(40480700001)(110136005)(42186006)(19627235002)(8936002)(8676002)(41300700001)(70206006)(70586007)(316002)(2616005)(81166007)(356005)(47076005)(336012)(426003)(36860700001)(83380400001)(4326008)(26005)(82740400003)(186003)(6266002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: infinera.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2023 11:40:57.2094
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b898dc8-5266-4866-0634-08db6ff0e1b4
X-MS-Exchange-CrossTenant-Id: 285643de-5f5b-4b03-a153-0ae2dc8aaf77
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=285643de-5f5b-4b03-a153-0ae2dc8aaf77;Ip=[8.4.225.30];Helo=[owa.infinera.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4531
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Romain Izard <romain.izard.pro@gmail.com>

upstream commit: 793409292382027226769d0299987f06cbd97a6e

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

