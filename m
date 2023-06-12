Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E748C72C62C
	for <lists+stable@lfdr.de>; Mon, 12 Jun 2023 15:40:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232809AbjFLNkN (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 12 Jun 2023 09:40:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235316AbjFLNjq (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 12 Jun 2023 09:39:46 -0400
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EE4B1A1
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 06:39:43 -0700 (PDT)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35CBqONu032722;
        Mon, 12 Jun 2023 13:39:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=PPS06212021;
 bh=gxjreI4LvhFi0Zl2h4AMNcyKdT5YHJ3JFHljFNuwmxE=;
 b=eMzWuo2gH/397h28OKoOTN6JW3U8SxmQd+eT22G2pMbqbo9+NJZAjdpLSPJCa/opXRxf
 S5Ir1QCDoMpSkKoY/tn3OOCfjrkhIA/IWWva39mPPtwY0LFHuE5yuM7lsc1gEDDSSTst
 lXjw466B87BzGNypI0jTU1BgAA5+CtybTpWwvJQuFKn8rMsXWUxANZhdV38xaBDWnBmh
 5zYUXfXiohmNDd1F257pna8P3IeXGhAcsoITScCB4GunaNigDlqiQStwOFUi9+iy26pZ
 y+276z8oO7Wu73Q6pU7jNiWd33qcyuxtdSYD/QO2YBqhosFVn14A7IAsNRj4msl/Akdg 9Q== 
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2047.outbound.protection.outlook.com [104.47.73.47])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3r4ed01nb4-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Jun 2023 13:39:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j5d6CinYgxPcN/Y6KOGJRSUN2oojYMqCrRdRx1/Xl+IKgcDpT+CUiU0/Wa+/SBWW4DuDtzGU/+PTraKoUkH27rMT5o2qm/x+fgZZ9D0rCp3L3xcqkKZxqH6q35we56rVjiY2cwbZfE/Ta4tL4jVdgGK6HJaggXN5H4cyDonvJmsrnHEFw+CNeRKjI5BaoDJndwgRINQzF1hnq4N1iNQ+qu6s+rMzULzg2SIsLlTZ1kKvIZJliAI0A5BigHxWfELl4yFroV405CoRcF1B15S8BED0Gk5nWzcwbtvMO707fJufvUZG3/sFp0cczvQqGF2ZENRlFXgmT15pxYqi/fOqyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gxjreI4LvhFi0Zl2h4AMNcyKdT5YHJ3JFHljFNuwmxE=;
 b=WxAiIw6g6Kak3Lp6aQtwugtv69Xh2AKba40fJqK+6yGdvwZaTHq17loH/DvijOQ0IJIJ8RS/RJpOxqrjJTAkLTrpm6ae70WfpstN4bB/yltR9NIkSGzK5LnKVPclZ4RkheiWnMjuT/gDqJToXxDmvFSOcIlCLd769lRhfO02Y6/nUYL05PUKTM/GGoIadyKWya/q8ba1GF7DiegZs8rkZFuVrCFngT3FfPfpgL8A/Svag9tfPR7mIwmYeNFAn1ERO5KC2RgRBqoRsoLTu0KU6p5tQ6TqmXtHZ2ojjSUNk3vLryX/EXs8SbrJRYW5n4QZhfwE29zNCGv8H+dObvaqAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DM4PR11MB5327.namprd11.prod.outlook.com (2603:10b6:5:392::22)
 by CH3PR11MB7866.namprd11.prod.outlook.com (2603:10b6:610:124::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.44; Mon, 12 Jun
 2023 13:39:28 +0000
Received: from DM4PR11MB5327.namprd11.prod.outlook.com
 ([fe80::3686:e9c9:56d6:8949]) by DM4PR11MB5327.namprd11.prod.outlook.com
 ([fe80::3686:e9c9:56d6:8949%4]) with mapi id 15.20.6477.028; Mon, 12 Jun 2023
 13:39:28 +0000
From:   ovidiu.panait@windriver.com
To:     stable@vger.kernel.org
Cc:     Hyunwoo Kim <imv4bel@gmail.com>, kernel test robot <lkp@intel.com>,
        Dan Carpenter <error27@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Ovidiu Panait <ovidiu.panait@windriver.com>
Subject: [PATCH 5.10 3/3] media: dvb-core: Fix use-after-free due to race at dvb_register_device()
Date:   Mon, 12 Jun 2023 16:39:07 +0300
Message-Id: <20230612133907.2999114-3-ovidiu.panait@windriver.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230612133907.2999114-1-ovidiu.panait@windriver.com>
References: <20230612133907.2999114-1-ovidiu.panait@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR08CA0151.eurprd08.prod.outlook.com
 (2603:10a6:800:d5::29) To DM4PR11MB5327.namprd11.prod.outlook.com
 (2603:10b6:5:392::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB5327:EE_|CH3PR11MB7866:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e107aea-5f58-4c80-b1e5-08db6b4a717c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VFHV78B4F3vyGjQ9LwQq7uxoGhsPD9XgVmCcec9nBn74EWFaCzgzygS/3lkl8/tcGrPs0NF+vO1hRrB7AdTdm1FFOGe7P3uDSAVbbEpCGQIP+xbgTGHT3BKonprPRbn5HeD+LB6MGU12271UGekrDWoq8oujP1LpvUezg4lHnFKbw/hmDmm8XrSfjGBozAWjCFh/12LYqH689ZpHaAFYzvIyDpqnKc3Zkmw+7Nagy78YJiFlRqQFFkilqvJBc8jQb7sNPqXnNERqB7ks5s0dVSzphn7TyG0NTx8/7pYbbMMtTT/uvhXXXnXPUjND78OwxM05F2nn88hPKJm1TN0rSLar99VB7WnV+87BNzxkEYFXIXCRBtLlL4dsNVytVW9Mcyv2/NbeyZiQog8gXKR+83QspD9H373uLKv5lNm2xzvlI6WbhZzgeKqP5pOlPjhx5SepSC0O7sA+yu4HHReqqu1kpKvg/cnlCbl7ZvWRIxvpd8wQbtdxvPgaJK3KVzYdwfmk+FAszOdJreHLQk5M/KjeWX+zRN7oeqbwlHCZ/raHJLwWhJ9Wf76EtHl+tK0lztZtBGYir1UoT5zNIe1kz2BUXFvEM2Z9AcIc06dFNkE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(346002)(396003)(376002)(39850400004)(451199021)(2616005)(83380400001)(38100700002)(86362001)(38350700002)(36756003)(478600001)(54906003)(4326008)(6486002)(6666004)(966005)(8936002)(8676002)(2906002)(5660300002)(52116002)(66556008)(66946007)(66476007)(6916009)(41300700001)(316002)(186003)(107886003)(6506007)(6512007)(9686003)(1076003)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GEzKPihavH0CdwE3ND2plqn8u1hgJWL5Fh3rfbkxJIMQzmI4iSTWdWKRXDTz?=
 =?us-ascii?Q?JvIQChx/wBrbgrjZ0viyKCDtdWbI3Y7Op4sa2tkcYfoBli8AzsLTYYe9I4nx?=
 =?us-ascii?Q?bsMkVBh8mys05DALZwBJGv0bgPl7VMMd+dKSd1/2J0MaJSPBaqC6arcny+RS?=
 =?us-ascii?Q?Qd5l8NLXndeAJmGFQ3oahAwbV/7BzedzuIbN1OsCXdfnwc+0qxsOFl9Qcgdq?=
 =?us-ascii?Q?cK1OgzdjNa8FzMO0U21o32jIQ7H6GLyey75eRlIlNDlXFYZQD9XY1yVxcxcG?=
 =?us-ascii?Q?N/eAmUnHVYNbX2CmVbVR+jVqS/VgERgJKyECmjyYu8sD+U+fkUlZ1GQLdGuu?=
 =?us-ascii?Q?MPKTnIlbblAPTrvmJW6vdPZTDOcrNXcTHb0at0iWzKjXvJbaAixYRkS8Dsep?=
 =?us-ascii?Q?Dg3CMfmSXNL4F1Apx/UeuSyWlu91SB9xPTNErAauRUFH4Fju9qbFqSEgHSLc?=
 =?us-ascii?Q?5Ev/GsH6aC0ps8uDMwYHTsbXBNu5nvmykjPCQ2OdXwsSx+6CdV5vcQ7vS6y0?=
 =?us-ascii?Q?xfoDivOBfqwwQTBH+V31cZ3Lm5gSe2TmbGjCPriwEDxcOQBEZDSHV1Qzk1jc?=
 =?us-ascii?Q?4m2C34/rLsaD3oJef5InHuShqiE5lyuD4avV7JdZOCxn6sXBY6YegwlA7/Ku?=
 =?us-ascii?Q?kCy+M3sB87NR8ge72VAh9X7qdulbLY+Ej2pY+c9DyOmECXWqA2DocpXDdXWF?=
 =?us-ascii?Q?Jhzj6HjrvgCKLXyu3b/0fNVVv1I/5W3pTVYC8qzzbuT1f5eEWNMmb4ibAsws?=
 =?us-ascii?Q?ktCt4kXc/BhwtGFmWT5Xx/ORNlVX5bUFgdsjNfTpTzjRCdnEjJwpWm9HS2Tj?=
 =?us-ascii?Q?5918qTJHWy94mvOoAvAA6FzvYFNvFxRnOR9dlBUkBGagLAlD2ZAIMbJyWXvY?=
 =?us-ascii?Q?l5t6QvgrhIh+tHuMsHVAedp2AkJEyKg2MRSwfjP63R00qhj0MRnEF3cK+73c?=
 =?us-ascii?Q?/YRscTS9eGIH0EroLLZZy1ipevVUG2ZF853WAdP4ibH9gUt5OXtgDoxXbVXT?=
 =?us-ascii?Q?x2JCYZSRF2PhbZDN21AEIwXdRmE11rk7cnYQhYo74gmok+SAldeMy4pTGCXZ?=
 =?us-ascii?Q?Q4kiZc0KalsUSBdK2E49hUQVEVPY4IMFtk7MbwAHlTB5FY3hPkshtEuAJdXZ?=
 =?us-ascii?Q?Xv0eYSzUcpPkibaDC6/eNCA3z4XurI3O0lcZ+XIcVpk03eiwqM33JRrag+S2?=
 =?us-ascii?Q?x0QFVFVu5cuusJRmY8CcLxRpUkyZ08IanlK3VZGTF10kOx+8agISIGCHVAnh?=
 =?us-ascii?Q?vUZ6vZ4+36KENPAqcKodesDPlOxZBMzcmbyABJmVX8oyUgZTFqRPm5hJeDGE?=
 =?us-ascii?Q?TRp0n6qieKwlFdyim7wdeA4REnUZD28aEgPnjB0yCan2Hgo3rWz/MPNKSdox?=
 =?us-ascii?Q?uCoz17rXoUwbxfPpjkMGtJJ7oXMKFF8Y8vrffOriHlqUnHXRPXzjUzApdhdv?=
 =?us-ascii?Q?JDXH0zYrrpRP1/t6YtRSKIJD/NnRDTtrjohGW/LINGv4971x7ES7NcDFWol7?=
 =?us-ascii?Q?UFEbXJH8dvNmRcLqsPpbus9rg9+v869neEM0Ro8d7HQXafeTwj2A9aqQn4QT?=
 =?us-ascii?Q?Sg2R2CBISP3zhm6HVI7wz8KwWLYaDxVu17wgM7zGGgOPfdmNNtGRU0u+QOol?=
 =?us-ascii?Q?pg=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e107aea-5f58-4c80-b1e5-08db6b4a717c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2023 13:39:28.0009
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cgj+pPi+0la8iIM1bFPtWpyqRed0/v38AGoLzu6zfFV3GIqdr/BhEWI/h2Of4jwX432drMGjuj6Tvv5QrFPQVRFAoHY6knunJHyhZfpHsko=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7866
X-Proofpoint-GUID: Gm-uMT7JZVIHmqlkWZn-Q64tLK6HUw-D
X-Proofpoint-ORIG-GUID: Gm-uMT7JZVIHmqlkWZn-Q64tLK6HUw-D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-12_06,2023-06-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 mlxlogscore=999
 adultscore=0 spamscore=0 malwarescore=0 phishscore=0 suspectscore=0
 lowpriorityscore=0 impostorscore=0 bulkscore=0 mlxscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306120116
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
index 6e2b7e97da17..2ff8a1b776fb 100644
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
index c493a3ffe45c..91ff2d5fcd08 100644
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

