Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3D6C739DBC
	for <lists+stable@lfdr.de>; Thu, 22 Jun 2023 11:52:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbjFVJwp (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 22 Jun 2023 05:52:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231165AbjFVJwb (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 22 Jun 2023 05:52:31 -0400
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F4D0210C
        for <stable@vger.kernel.org>; Thu, 22 Jun 2023 02:45:06 -0700 (PDT)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 35M8mStP031970;
        Thu, 22 Jun 2023 01:57:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :content-transfer-encoding:content-type:mime-version; s=
        PPS06212021; bh=VOn0nY8F3v2rs6npXoAUm+KbHnZICEzmStvPHLYdixY=; b=
        cPNP8f/sw6rnJnKMFq6lFRSv2Eq0uk7rMH7x5LhLsbx/Pgqwknb2wAz5OTazMG89
        R9uvtRpf8F1UNVFOU4wehfty75k/8u9YNABMwRZUm+3NCSg2ZV4lNryXNsf4JWgB
        0WdtD95NbP3g6VuOeY6Rsb1AgAq9SPk4oEhGa6q4sjgamIezh1nKOn8Nxw1fgmod
        4k8GFKhowQU5PP/CrDtoa7+LUYyvTHGrwmXRQWc1f4VOuupN8NjS9VoL4XpaWehf
        A7OE3WFbn0GMaoCYbDjG4fMBgdDa20KYy8XsbmaZ0sApVMjDMiTGO1tbLtYHXp75
        P2vye3+iTFNUGeQXBmfDyw==
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3rcd6yg7sf-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Jun 2023 01:57:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U5TRqqpkAmjxNoKt9lRho77w27Ko5CGYNctUoCyU1vPffK+bXAgd9lBWJETdtydT3YlQ8zWP8XB8DsNFGaSAR43YU1QiDCUYWROqssEGiVsnAc339BI19/9WEFdInDjsyE3t7MaB3I4hZcctGu10Lo8xDuIizIsu108JGwhB8t2XxJALwqcZy4gxfMyV+4RN/UoIwZMI6jdRouwW6KA05390cvwP9sTx/4f8vgyp7UW8uFEnyFwgu6uLjDyLWrU1RSA0XUZzQ8ivDNFNgr7AM+SwAUQL5GNjwD47A3QNZKQv6J9AEqiPc+H34fpbtMOMUXyss0URFBrmuskSbF71tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VOn0nY8F3v2rs6npXoAUm+KbHnZICEzmStvPHLYdixY=;
 b=ebZmB/KaA5pDA/7soM4d1WOrHj6mxOb5nzpseeWiWtYy8XmdB+MzDyQJwOnqFYcozpgOMQo6tzhENGO9HtW+om2k9AnL2maZLlpR/X9N/EBclbD8LXvWtdklzb6U8g9ycLDzQgG/sXjwqEbAw9TdDXVf9ikm31tKdOWrHw9JgFkbFdatkN+97A2//4woVVzxZm0xg/CTujT9xGH7Rn+ftkAlXzVtlCKaa3ZknPsjui0OVUCderaVD2gR6/G5g6UYaKGihI+50bc/MeKXHb/jrWNRIhV1TXd6rSg9/hX1sVTVTXkew5PXzNoH6ImgMw2H5bc1OF3kFo0JKgwB0EJCGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DM4PR11MB5327.namprd11.prod.outlook.com (2603:10b6:5:392::22)
 by PH7PR11MB5766.namprd11.prod.outlook.com (2603:10b6:510:130::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Thu, 22 Jun
 2023 08:57:07 +0000
Received: from DM4PR11MB5327.namprd11.prod.outlook.com
 ([fe80::3686:e9c9:56d6:8949]) by DM4PR11MB5327.namprd11.prod.outlook.com
 ([fe80::3686:e9c9:56d6:8949%4]) with mapi id 15.20.6521.024; Thu, 22 Jun 2023
 08:57:07 +0000
From:   ovidiu.panait@windriver.com
To:     stable@vger.kernel.org
Cc:     Hyunwoo Kim <imv4bel@gmail.com>, kernel test robot <lkp@intel.com>,
        Dan Carpenter <error27@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Ovidiu Panait <ovidiu.panait@windriver.com>
Subject: [PATCH 5.4 3/3] media: dvb-core: Fix use-after-free due to race at dvb_register_device()
Date:   Thu, 22 Jun 2023 11:56:45 +0300
Message-Id: <20230622085645.1298223-3-ovidiu.panait@windriver.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230622085645.1298223-1-ovidiu.panait@windriver.com>
References: <20230622085645.1298223-1-ovidiu.panait@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR0102CA0028.eurprd01.prod.exchangelabs.com
 (2603:10a6:802::41) To DM4PR11MB5327.namprd11.prod.outlook.com
 (2603:10b6:5:392::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB5327:EE_|PH7PR11MB5766:EE_
X-MS-Office365-Filtering-Correlation-Id: f14dcfcf-29cd-4fe0-2654-08db72fea844
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TOD5DWgZ8wVTbSB8bfEsBx7xH8zQw4+eR8fiEZmKwG8q1ihoPm8NoXbWAf+EHoJb3YxnZ1CpotsH0dR5+73sy/UTXYtEYrNFiCwjJUjmNHD9KW7beqUAreYK1vrliLK0//gRftaR3OVPynmgqSb+6ulL4TQ1BHbQKqJ7HhLztIRs5uGyk4ggkw2BAFD8slwsOvQ9Rb/+xI1KwaF8KT+OWM+uNVWiaxJQBB98ay1EkVD9W3FfB1vkLyOE4rY5IGbAFQq/IYgckeF2pAf02eVN0bYZdwD6apm7Vn2CcTmhU2qd/ot0gCXw/Ysluft9fMT6415MHVh359eV6s1ZdFY7vyVphKxTts51stg6dHrRlWF/97Pu3+MPrwSYOB8GbrDY/hvYnF/63ljbkDzE/Iuv87t9wKAatZk/DlkPPIgqpa6ZEe1+/f4aBV9v0WgF7xI3nKXTtYL7c2xWHJvEb6pgeCufO0BVIi52rGfTk3/Znl1MmhhJB3MxsUuK5Vmxy9cIDusUXCHRB8p165dZkCvLEAgij6T/a5lL7s/yINiKuHI1wG5ywf4ykLlYAhoG6wnIVSdS63143bc4UcswCcOha6X/W1tYkKZ11zMxYuZ8cec=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(136003)(346002)(366004)(39850400004)(451199021)(8676002)(4326008)(6486002)(52116002)(66556008)(66946007)(66476007)(6916009)(478600001)(36756003)(6666004)(316002)(54906003)(86362001)(83380400001)(6512007)(1076003)(26005)(6506007)(186003)(2616005)(38100700002)(966005)(9686003)(5660300002)(2906002)(41300700001)(38350700002)(8936002)(107886003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PDqCRVqzawPIc98u7V/vyE0+NupZ0TFeEQsiVH1vR60FoJULVfPZ2RLa2Nae?=
 =?us-ascii?Q?v6uVcNbsrSx1ae4gPtTdYHrqQud+a61Tb/oMJKJzAC/HmFh8cYuyjASYhpBD?=
 =?us-ascii?Q?hrT7UyJILaQavFVNN7t0Akk9V2tQhZtYouQjYnHkcArKL58F2lDAu5126hM5?=
 =?us-ascii?Q?zhtNzMygKD+ouRmxuNUDsG2Xt4uhgFLRLbTf3rg4I2ljt9zGyc3vGFrQVPUo?=
 =?us-ascii?Q?QRcznIPj3WJwjB6/uuJE9ajfmMl9h6suTRmqeEYKlJkkj6JdLjKEJAvd4cpX?=
 =?us-ascii?Q?kPZW9CtAgf/Pv0BEnkAdBlQjqy/Ams3P5TPAowgY0cWkRkXNUYlQuSFcS1YZ?=
 =?us-ascii?Q?0ooXAlmFD+Kh2HrhIWsunjNhds/F0g0Bs1HjXsR4lkBq1lHk2R5Cr1jep/Ry?=
 =?us-ascii?Q?4LREnVcKMk61iIZ0Ko/tbBGipn62ERDogpv9jUaGlWNdvu2s2q+ZN3CktToN?=
 =?us-ascii?Q?PgSLGa1sBLAFk3XIawnNG5POGwpa+TNR8HEzQ0ZcAvuYCmBQb2S4XCFBzoen?=
 =?us-ascii?Q?fxlzSY/bSZhcIzA6Tgy4j921+Kc6O4fjb6Y2auvm/5JbshmYzKTvu72D1HLU?=
 =?us-ascii?Q?t/l/83wsV+/kQ/MO+adOlHe11WPkNBdb2pNaXyCi57fWUW+N3gM+65QSC9/N?=
 =?us-ascii?Q?eRWbBc40uXwoHah12nNw0zowSFxc89KThc5D4cbILM04xaXPGxpmiMUobXdu?=
 =?us-ascii?Q?J4fWR9ut8SA0r1A9O6PyH53luN/6pU84N2jdK4I6jeCXbkaf0bwlCHjm+rng?=
 =?us-ascii?Q?LDEdGI1HsgQHOQHsWDGYHeRZZsMH333q4yG82v+W9mbPsDtqhNn4gGVVaZsg?=
 =?us-ascii?Q?ZfRGPL1tiBgBvgSM5wrnUuywSPQ+0j2pbGOekbu6m1pCb1dzGeues7KdtpOn?=
 =?us-ascii?Q?gnZf6dW+V0wkNcj2Lah545DJ8Ruv5bCFs7SpleuUt1/AZYA5AC8N8YLXRwkX?=
 =?us-ascii?Q?QfStb24wtAL2/o8VpqeBTsLARb0Qw8CME09rXkqVdNsGFsdZ9FPuNZby8VaU?=
 =?us-ascii?Q?yfWVFxArNO7MHXARXukbLSq4vP+CnRt/Jjakthz5LxsQjd2BTkmnF2ytRmzu?=
 =?us-ascii?Q?CQR6RPMEauZt9Vyc448gb4lclCdjcA3IsRlm4SsO841A8TAQzeVAQOjsONKm?=
 =?us-ascii?Q?TJqYZUD72m9zaJjei5qffeZHX4+lFzUEPzDMr4zqzlfkufIzWu7PfQhnLU7D?=
 =?us-ascii?Q?bJKJk+M7ADLifC63Rd6j0Uqvh8r1FMfu/VnLiDADm4wp1fK3j+3gdnV/TNDN?=
 =?us-ascii?Q?Fvo9hujbos10ViGjhEdQNcqA+m818EoTnEYhru7xeS5wegjAhQGTt9g8I6uj?=
 =?us-ascii?Q?kDxwtlF+uVRII6gvJ1mAXMs1ByI+5pNoX+5yqpw+rRMF7tsEs3HCF1U48fSD?=
 =?us-ascii?Q?4Bj7XChKLBT96ZIQ4pEyax2+2wMtdZGMlmRuF7mb4ZElMbYg236kKDjtgnhy?=
 =?us-ascii?Q?REnAqnuzMyN4mk/+oRIURbIem2HTyFzjWUPAdlalnG+n5Tbjuecl+q7mmXsZ?=
 =?us-ascii?Q?519eSvfVKC60znhmSX8AK721MJeNiukh2KOoCIrf7UXXvnqiWfU+b83KC77X?=
 =?us-ascii?Q?f9ypR7dKf653S+w+P5PIAjQhfJslnD1BWZkmzvO0qXgLakkV4nlHJbojWn+M?=
 =?us-ascii?Q?iA=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f14dcfcf-29cd-4fe0-2654-08db72fea844
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 08:57:07.4809
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UIAoaRPjHVjdpj1pQ+3ha/bX9mApxymIzHdw1hG7eYIP389+7u0H/7kMWpOWBEaiTXDNS3Hd+RRyNdjLtZPfGJWqmu1oey+X0XzZ0Tb5W3c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5766
X-Proofpoint-GUID: WPv6aYdZ5R6n2gzQVu8vJLa2TiO3MLKX
X-Proofpoint-ORIG-GUID: WPv6aYdZ5R6n2gzQVu8vJLa2TiO3MLKX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-22_05,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 mlxscore=0 mlxlogscore=999 impostorscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 adultscore=0 phishscore=0
 clxscore=1015 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2305260000 definitions=main-2306220074
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Hyunwoo Kim <imv4bel@gmail.com>

commit 627bb528b086b4136315c25d6a447a98ea9448d3 upstream.

dvb_register_device() dynamically allocates fops with kmemdup()
to set the fops->owner.
And these fops are registered in 'file->f_ops' using replace_fops()
in the dvb_device_open() process, and kfree()d in dvb_free_device().

However, it is not common to use dynamically allocated fops instead
of 'static const' fops as an argument of replace_fops(),
and UAF may occur.
These UAFs can occur on any dvb type using dvb_register_device(),
such as dvb_dvr, dvb_demux, dvb_frontend, dvb_net, etc.

So, instead of kfree() the fops dynamically allocated in
dvb_register_device() in dvb_free_device() called during the
.disconnect() process, kfree() it collectively in exit_dvbdev()
called when the dvbdev.c module is removed.

Link: https://lore.kernel.org/linux-media/20221117045925.14297-4-imv4bel@gmail.com
Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <error27@gmail.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
Signed-off-by: Ovidiu Panait <ovidiu.panait@windriver.com>
---
 drivers/media/dvb-core/dvbdev.c | 84 ++++++++++++++++++++++++---------
 include/media/dvbdev.h          | 15 ++++++
 2 files changed, 78 insertions(+), 21 deletions(-)

diff --git a/drivers/media/dvb-core/dvbdev.c b/drivers/media/dvb-core/dvbdev.c
index e8b0cc62c26e..31b299ced3c1 100644
--- a/drivers/media/dvb-core/dvbdev.c
+++ b/drivers/media/dvb-core/dvbdev.c
@@ -37,6 +37,7 @@
 #include <media/tuner.h>
 
 static DEFINE_MUTEX(dvbdev_mutex);
+static LIST_HEAD(dvbdevfops_list);
 static int dvbdev_debug;
 
 module_param(dvbdev_debug, int, 0644);
@@ -462,14 +463,15 @@ int dvb_register_device(struct dvb_adapter *adap, struct dvb_device **pdvbdev,
 			enum dvb_device_type type, int demux_sink_pads)
 {
 	struct dvb_device *dvbdev;
-	struct file_operations *dvbdevfops;
+	struct file_operations *dvbdevfops = NULL;
+	struct dvbdevfops_node *node = NULL, *new_node = NULL;
 	struct device *clsdev;
 	int minor;
 	int id, ret;
 
 	mutex_lock(&dvbdev_register_lock);
 
-	if ((id = dvbdev_get_free_id (adap, type)) < 0){
+	if ((id = dvbdev_get_free_id (adap, type)) < 0) {
 		mutex_unlock(&dvbdev_register_lock);
 		*pdvbdev = NULL;
 		pr_err("%s: couldn't find free device id\n", __func__);
@@ -477,18 +479,45 @@ int dvb_register_device(struct dvb_adapter *adap, struct dvb_device **pdvbdev,
 	}
 
 	*pdvbdev = dvbdev = kzalloc(sizeof(*dvbdev), GFP_KERNEL);
-
 	if (!dvbdev){
 		mutex_unlock(&dvbdev_register_lock);
 		return -ENOMEM;
 	}
 
-	dvbdevfops = kmemdup(template->fops, sizeof(*dvbdevfops), GFP_KERNEL);
+	/*
+	 * When a device of the same type is probe()d more than once,
+	 * the first allocated fops are used. This prevents memory leaks
+	 * that can occur when the same device is probe()d repeatedly.
+	 */
+	list_for_each_entry(node, &dvbdevfops_list, list_head) {
+		if (node->fops->owner == adap->module &&
+				node->type == type &&
+				node->template == template) {
+			dvbdevfops = node->fops;
+			break;
+		}
+	}
 
-	if (!dvbdevfops){
-		kfree (dvbdev);
-		mutex_unlock(&dvbdev_register_lock);
-		return -ENOMEM;
+	if (dvbdevfops == NULL) {
+		dvbdevfops = kmemdup(template->fops, sizeof(*dvbdevfops), GFP_KERNEL);
+		if (!dvbdevfops) {
+			kfree(dvbdev);
+			mutex_unlock(&dvbdev_register_lock);
+			return -ENOMEM;
+		}
+
+		new_node = kzalloc(sizeof(struct dvbdevfops_node), GFP_KERNEL);
+		if (!new_node) {
+			kfree(dvbdevfops);
+			kfree(dvbdev);
+			mutex_unlock(&dvbdev_register_lock);
+			return -ENOMEM;
+		}
+
+		new_node->fops = dvbdevfops;
+		new_node->type = type;
+		new_node->template = template;
+		list_add_tail (&new_node->list_head, &dvbdevfops_list);
 	}
 
 	memcpy(dvbdev, template, sizeof(struct dvb_device));
@@ -499,20 +528,20 @@ int dvb_register_device(struct dvb_adapter *adap, struct dvb_device **pdvbdev,
 	dvbdev->priv = priv;
 	dvbdev->fops = dvbdevfops;
 	init_waitqueue_head (&dvbdev->wait_queue);
-
 	dvbdevfops->owner = adap->module;
-
 	list_add_tail (&dvbdev->list_head, &adap->device_list);
-
 	down_write(&minor_rwsem);
 #ifdef CONFIG_DVB_DYNAMIC_MINORS
 	for (minor = 0; minor < MAX_DVB_MINORS; minor++)
 		if (dvb_minors[minor] == NULL)
 			break;
-
 	if (minor == MAX_DVB_MINORS) {
+		if (new_node) {
+			list_del (&new_node->list_head);
+			kfree(dvbdevfops);
+			kfree(new_node);
+		}
 		list_del (&dvbdev->list_head);
-		kfree(dvbdevfops);
 		kfree(dvbdev);
 		up_write(&minor_rwsem);
 		mutex_unlock(&dvbdev_register_lock);
@@ -521,41 +550,47 @@ int dvb_register_device(struct dvb_adapter *adap, struct dvb_device **pdvbdev,
 #else
 	minor = nums2minor(adap->num, type, id);
 #endif
-
 	dvbdev->minor = minor;
 	dvb_minors[minor] = dvb_device_get(dvbdev);
 	up_write(&minor_rwsem);
-
 	ret = dvb_register_media_device(dvbdev, type, minor, demux_sink_pads);
 	if (ret) {
 		pr_err("%s: dvb_register_media_device failed to create the mediagraph\n",
 		      __func__);
-
+		if (new_node) {
+			list_del (&new_node->list_head);
+			kfree(dvbdevfops);
+			kfree(new_node);
+		}
 		dvb_media_device_free(dvbdev);
 		list_del (&dvbdev->list_head);
-		kfree(dvbdevfops);
 		kfree(dvbdev);
 		mutex_unlock(&dvbdev_register_lock);
 		return ret;
 	}
 
-	mutex_unlock(&dvbdev_register_lock);
-
 	clsdev = device_create(dvb_class, adap->device,
 			       MKDEV(DVB_MAJOR, minor),
 			       dvbdev, "dvb%d.%s%d", adap->num, dnames[type], id);
 	if (IS_ERR(clsdev)) {
 		pr_err("%s: failed to create device dvb%d.%s%d (%ld)\n",
 		       __func__, adap->num, dnames[type], id, PTR_ERR(clsdev));
+		if (new_node) {
+			list_del (&new_node->list_head);
+			kfree(dvbdevfops);
+			kfree(new_node);
+		}
 		dvb_media_device_free(dvbdev);
 		list_del (&dvbdev->list_head);
-		kfree(dvbdevfops);
 		kfree(dvbdev);
+		mutex_unlock(&dvbdev_register_lock);
 		return PTR_ERR(clsdev);
 	}
+
 	dprintk("DVB: register adapter%d/%s%d @ minor: %i (0x%02x)\n",
 		adap->num, dnames[type], id, minor, minor);
 
+	mutex_unlock(&dvbdev_register_lock);
 	return 0;
 }
 EXPORT_SYMBOL(dvb_register_device);
@@ -584,7 +619,6 @@ static void dvb_free_device(struct kref *ref)
 {
 	struct dvb_device *dvbdev = container_of(ref, struct dvb_device, ref);
 
-	kfree (dvbdev->fops);
 	kfree (dvbdev);
 }
 
@@ -1090,9 +1124,17 @@ static int __init init_dvbdev(void)
 
 static void __exit exit_dvbdev(void)
 {
+	struct dvbdevfops_node *node, *next;
+
 	class_destroy(dvb_class);
 	cdev_del(&dvb_device_cdev);
 	unregister_chrdev_region(MKDEV(DVB_MAJOR, 0), MAX_DVB_MINORS);
+
+	list_for_each_entry_safe(node, next, &dvbdevfops_list, list_head) {
+		list_del (&node->list_head);
+		kfree(node->fops);
+		kfree(node);
+	}
 }
 
 subsys_initcall(init_dvbdev);
diff --git a/include/media/dvbdev.h b/include/media/dvbdev.h
index 73c1df584a14..3745a13f6e08 100644
--- a/include/media/dvbdev.h
+++ b/include/media/dvbdev.h
@@ -189,6 +189,21 @@ struct dvb_device {
 	void *priv;
 };
 
+/**
+ * struct dvbdevfops_node - fops nodes registered in dvbdevfops_list
+ *
+ * @fops:		Dynamically allocated fops for ->owner registration
+ * @type:		type of dvb_device
+ * @template:		dvb_device used for registration
+ * @list_head:		list_head for dvbdevfops_list
+ */
+struct dvbdevfops_node {
+	struct file_operations *fops;
+	enum dvb_device_type type;
+	const struct dvb_device *template;
+	struct list_head list_head;
+};
+
 /**
  * dvb_device_get - Increase dvb_device reference
  *
-- 
2.39.1

