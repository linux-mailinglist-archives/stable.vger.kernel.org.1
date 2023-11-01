Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E6857DE0E7
	for <lists+stable@lfdr.de>; Wed,  1 Nov 2023 13:37:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343569AbjKAMYq (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 1 Nov 2023 08:24:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343636AbjKAMYp (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 1 Nov 2023 08:24:45 -0400
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C78FB124
        for <stable@vger.kernel.org>; Wed,  1 Nov 2023 05:24:36 -0700 (PDT)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A1BPaIh001359
        for <stable@vger.kernel.org>; Wed, 1 Nov 2023 05:24:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
         h=from:to:subject:date:message-id:in-reply-to:references
        :content-transfer-encoding:content-type:mime-version; s=
        PPS06212021; bh=PT+lMsdFA2KYFn/Opg7psa35HiUFDAcjTf9vkvyWH4Y=; b=
        NqoGUN745fvny2GHgTF5Z4AmK3uGjB/Y87ZVEterveokQWz52ovZc1gtE58aLXOp
        dM/nDfS7B/9jo4MMpTohT0/WRe90lxVNVPwaOr4z+je4DvsaSu5dl7T8cewCRP/3
        +qUir1jk0N8yOhZaXLOkfeozPwiDbeaA61FFAVvS/zPZKBj2BdnVadrkqisTKWWr
        1RDGtHOa3+soSZykbxFvkFOzt2lw48KohGAELhEZgzDCjcZmP2e/lj7qlOltUJhB
        iU7JqN9cvQbzC2eFpY9dyA07BMDOSWVTYfqG7PR/7CCzKxB4N0SX4fBw8LatTJsX
        tE2VRqjxILlYxA2O12qeUg==
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3u0wk0mp3q-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <stable@vger.kernel.org>; Wed, 01 Nov 2023 05:24:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aH00V1eCH9eDj9AEsadoORAuNIYnBeUTMhn5DjLTByUIAgIv9k+cVAnfzyDpHWEwQ/E7QSGV555J7IAodRicMaC9gizkbYc8ADIiF9AH2JLxiQMkyw+OK1OdOQwliKLUo5YeS45bj3HodPbiyUyRryt/2xRQ9HicVTs/Z0pqBylNGYw8uK3os8Dp14LqiKPHgHVZ3HnNrdupLMXc/GWTo9L6456MVWCcyvLvGif41UNbJH2bzAPMlt+OJSut/qPMvDOHtY5KgjcsURrDU0SsHM/l7g28w+Q/FsSoM4gSbSUjU4MtPBqQozYIK+l6F1KOehnnBGuHssBvDfBMVmIm5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PT+lMsdFA2KYFn/Opg7psa35HiUFDAcjTf9vkvyWH4Y=;
 b=hIwof92jlmprr50f/9wbbz2+334HkaFbO+MMdLsvaFe9CT0BXM89lKwD8/djhXWdJNC/kKqUN9SUkF2yJqgJ1UIlj80QRwsZdCvp9CjUSBRz2ctcGYdvTUMkvmWBotMdSE9bQScCISq9rY0WptYe/Y4HZcMjzLPZs1Ma4PSuLmscDaAO2xc0HT7nFMV8xwRkdi2tkPjF2f5mcVFLk3JJmv5GaPnCOBJLvZ6Bcn6gGguZwLu/pOXBR5uz/qjjCrvAvy58apDWzMH5zKl/+lRs+Gx4VWbyV4/+pT60J5MSPPClakVAt5KNgO34Cm25/1/bxpk95U4FBYQuTfCDeygsCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from PH0PR11MB4952.namprd11.prod.outlook.com (2603:10b6:510:40::15)
 by MN6PR11MB8244.namprd11.prod.outlook.com (2603:10b6:208:470::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19; Wed, 1 Nov
 2023 12:24:30 +0000
Received: from PH0PR11MB4952.namprd11.prod.outlook.com
 ([fe80::5f7f:2dc0:203e:e5e5]) by PH0PR11MB4952.namprd11.prod.outlook.com
 ([fe80::5f7f:2dc0:203e:e5e5%6]) with mapi id 15.20.6933.029; Wed, 1 Nov 2023
 12:24:30 +0000
From:   Dragos-Marian Panait <dragos.panait@windriver.com>
To:     stable@vger.kernel.org
Subject: [PATCH 5.4 1/2] nvmet-tcp: move send/recv error handling in the send/recv methods instead of call-sites
Date:   Wed,  1 Nov 2023 14:24:21 +0200
Message-Id: <20231101122422.1005567-2-dragos.panait@windriver.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231101122422.1005567-1-dragos.panait@windriver.com>
References: <2023102012-pleat-snippet-29cf@gregkh>
 <20231101122422.1005567-1-dragos.panait@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR06CA0112.eurprd06.prod.outlook.com
 (2603:10a6:803:8c::41) To PH0PR11MB4952.namprd11.prod.outlook.com
 (2603:10b6:510:40::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4952:EE_|MN6PR11MB8244:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e367958-d971-4707-3105-08dbdad57f12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ldl4BMZxNgY6LV/O6SUqQQiF/eEeaV2XY/DICNI6GNFo6UiM35tCFYAtcX0DlUaXgHj8Ee5DWIdSs/zOw7gSehZXpMScDJu/SahDrbYKA5zwabXq/5PcwQYPDsdJOwQbPmkbaxPt0C4zer8IPoGEF3xArmSHsCAk8tWyKURIS1iJEv0+GgNnWV9BWZnBsO1fcChyVMpKyyJirCLRoXMfmZR4Z1MY3/7j7fbBu00gzNcD0Ec7/ehlZchaXqYyuya7fokDyKGx4a9/kjj09dZc4RRMoGPAFSOPW6rgBHYSfNRY7IFzJddNX1DAQFCIeIMMjkxWd0XXwZ5eyTW27Mn3cE6zHoUT5A3VxfMQyJ7vE81XpJln0GhsYDrDY0DDQYpxgp19lNOvHY/DxRm53lzZD868tPjOVzNbBWyhGCYUmXa8MTdZOt9ntwmemdh8dVzHhsfs2o7Tz7EmWhmISrnET4rCHOC5+5lKAkftfwF+HbCrG/ynexdAi9KbRO91smG2eoaj9mFQkKo3e6cvWjaJ6hGuA9LL3xHmacjxzwM94MXD/l6RQrnqZNjvsraAeIAYsLDh3Ete3k9LL7Kp8gIZsm03M8OPQUcEaroLbiLOE41bF6zcj25TD9j6T3uILvKt
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4952.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39850400004)(136003)(366004)(376002)(346002)(396003)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(8936002)(2616005)(5660300002)(1076003)(86362001)(26005)(38350700005)(6666004)(6486002)(478600001)(6506007)(2906002)(6512007)(52116002)(66946007)(66476007)(66556008)(6916009)(36756003)(41300700001)(316002)(38100700002)(8676002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rxbEZvxTFJKiF7s1ZVsWcz8FcocOIEL+sWoYfXdp7qLN1z9gKgYNZBm/Zish?=
 =?us-ascii?Q?iNK2LCQ5uDyJsGJdlzhmWRDwiLtwntwNSTlo7Iss/g7qb4grA7MPzJcqSV5t?=
 =?us-ascii?Q?Dd5ec0MsFsFwKevnuriQdYZPrrE2Bzj0FUNGCilhENx2MPf2vtWCQV/1dsjF?=
 =?us-ascii?Q?nWrki6kbkglpUwoYfIesQ9ZyTnEdtuF2h2STEmIrlY8icMxLkiaSoNiSaA+W?=
 =?us-ascii?Q?AqWBMbtlpLfpKfQlO6Itnn0aiRCOyHi2OaK+7hI9+ExbdK82CcQjrjtP1chE?=
 =?us-ascii?Q?7UUnfbQlWJHdMy4XO4zswTjCj8vLMqVc5FzFZ2HS8dRpECRAEihAMMh5Qis3?=
 =?us-ascii?Q?6OMt08tv0ys5GG8b+PcwmOiglAej9rjZJSrpBOZwWyLw9A2S29q5RPmNlNEu?=
 =?us-ascii?Q?dfYK2PaJTZLSbFHcBaOVZCdpDYxgyJ7nkNBum/IVBuXEMN7dgRkmliRkzaEm?=
 =?us-ascii?Q?pRJrkf2Y61S34pbdGQMVfFRAvvrhMl4E6NAkkdfJgtIBwuNnNZF9LBStvzET?=
 =?us-ascii?Q?yd6Fyce22J8FVsw29VN2rME1bX0b04kTpcqoHvfj19FveRvQHWgpeQOSrEvp?=
 =?us-ascii?Q?XhRsINVwqMErzST8sjNhF7luGfeL062Ake+Tiv7H8znJhBNNV4aNqDdTbflw?=
 =?us-ascii?Q?Y2ifODlNqdX/mXdx+PWUHhkVfB7U3aEU5rPQZ5GUR5YIw/TR5wA7Nmtw2ves?=
 =?us-ascii?Q?5SSvKCSKN9jaRjRdxsmdy5GQtEM3lYX9mwFPyWhRexsY0y15V+S2hietAmlk?=
 =?us-ascii?Q?wCXmdq4lHUzRgKcUlu6DRSVS1t2J7XKprI9NA/4ERYPNUAI1dJCNtaK56LtR?=
 =?us-ascii?Q?LDLdJTuCuPDbojkpK5sUEfjWLDm4YTi/WBhgOvNXG6S0jPhdaCqiwLgR+ugZ?=
 =?us-ascii?Q?7+WwQ0+jL2DoMNrJ7l0QO+eUeD+txX2vZVMOiWV9RaFmAY3///7zemy8m3Cy?=
 =?us-ascii?Q?vJ2aPauRCJ/4vhRHaJ+uYRimS6l/OvAii6nkhoXTJVpqp3RigtA3zZem7w0H?=
 =?us-ascii?Q?1JIfVC4QmAerAOsMfOOWr9WrtOQpPSuZp7MoItNTMYzadyejwskxi2EiiJ70?=
 =?us-ascii?Q?L96ThfWOXhWNGSTe6Ub7cxsQDm//+6rN9RDZ8ifBG5WI030UzB2/fnuuTdZM?=
 =?us-ascii?Q?D6FDGcNWE/sjykDFIjOeabjzGU4j1wRURvvGbEgiw98s07Wlov3u/LdoKbce?=
 =?us-ascii?Q?nAfNWtsLgS9x4ddGrNvXvruHATkDR2P8IXUTPwjN/UUgHgBOr6L2cFVA9CpW?=
 =?us-ascii?Q?kk8XNl8/qsU0f1YyYD0PNIdNZEVG3FGh28PWoTLcZfHvD9VGFNKPKA1fYWPM?=
 =?us-ascii?Q?lHVCWhatVuE7PB+BuWcKvK/EBojjTVkgTFsTsVKWGdBOZgWeDLWsSKJsJWdC?=
 =?us-ascii?Q?LEFiG8NYeVaovrVEnKtuDSDNo/d5hrOOlHmQF1bMEfG9tRM4zgVWhdxoLEkh?=
 =?us-ascii?Q?ZSJV8F0zVJRxR1J9D+QVQ1+j7M2SWyIO+zJ/04E1S8EfD/jYykhTG7c9OOf9?=
 =?us-ascii?Q?QWT4/oRs/ANrWE6olRdF+tiOCEyukPcX4Nvzekk3+Yb9vqnK4VeiViNzOM6W?=
 =?us-ascii?Q?EOnc13ZURXn+XGlCPQtkb91OipwGI609Ydo6GXg4hPIaR6M5rUdnd+YDCBsf?=
 =?us-ascii?Q?6A=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e367958-d971-4707-3105-08dbdad57f12
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4952.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2023 12:24:30.0106
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iSHhR/XQeeOLMXaNc8bJOsdPhLLD5MDNGW2gJvQWLishWGlgN5BRLXoDQtzfqQJIqOacQESn/A8sQiwlAwL/aJt2vgFaDeENuaoW+t1zFDI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR11MB8244
X-Proofpoint-ORIG-GUID: MfYjRsdnU3__eOWweMLNRkhXq7YJzQZM
X-Proofpoint-GUID: MfYjRsdnU3__eOWweMLNRkhXq7YJzQZM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-01_10,2023-11-01_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=999 spamscore=0 phishscore=0 adultscore=0 clxscore=1015
 priorityscore=1501 mlxscore=0 lowpriorityscore=0 suspectscore=0
 bulkscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2310240000 definitions=main-2311010104
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Sagi Grimberg <sagi@grimberg.me>

commit 0236d3437909ff888e5c79228e2d5a851651c4c6 upstream.

Have routines handle errors and just bail out of the poll loop.
This simplifies the code and will help as we may enhance the poll
loop logic and these are somewhat in the way.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Dragos-Marian Panait <dragos.panait@windriver.com>
---
 drivers/nvme/target/tcp.c | 43 ++++++++++++++++++++++-----------------
 1 file changed, 24 insertions(+), 19 deletions(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index df7a911d303f..e63a50e22e5a 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -321,6 +321,14 @@ static void nvmet_tcp_fatal_error(struct nvmet_tcp_queue *queue)
 		kernel_sock_shutdown(queue->sock, SHUT_RDWR);
 }
 
+static void nvmet_tcp_socket_error(struct nvmet_tcp_queue *queue, int status)
+{
+	if (status == -EPIPE || status == -ECONNRESET)
+		kernel_sock_shutdown(queue->sock, SHUT_RDWR);
+	else
+		nvmet_tcp_fatal_error(queue);
+}
+
 static int nvmet_tcp_map_data(struct nvmet_tcp_cmd *cmd)
 {
 	struct nvme_sgl_desc *sgl = &cmd->req.cmd->common.dptr.sgl;
@@ -714,11 +722,15 @@ static int nvmet_tcp_try_send(struct nvmet_tcp_queue *queue,
 
 	for (i = 0; i < budget; i++) {
 		ret = nvmet_tcp_try_send_one(queue, i == budget - 1);
-		if (ret <= 0)
+		if (unlikely(ret < 0)) {
+			nvmet_tcp_socket_error(queue, ret);
+			goto done;
+		} else if (ret == 0) {
 			break;
+		}
 		(*sends)++;
 	}
-
+done:
 	return ret;
 }
 
@@ -1167,11 +1179,15 @@ static int nvmet_tcp_try_recv(struct nvmet_tcp_queue *queue,
 
 	for (i = 0; i < budget; i++) {
 		ret = nvmet_tcp_try_recv_one(queue);
-		if (ret <= 0)
+		if (unlikely(ret < 0)) {
+			nvmet_tcp_socket_error(queue, ret);
+			goto done;
+		} else if (ret == 0) {
 			break;
+		}
 		(*recvs)++;
 	}
-
+done:
 	return ret;
 }
 
@@ -1196,27 +1212,16 @@ static void nvmet_tcp_io_work(struct work_struct *w)
 		pending = false;
 
 		ret = nvmet_tcp_try_recv(queue, NVMET_TCP_RECV_BUDGET, &ops);
-		if (ret > 0) {
+		if (ret > 0)
 			pending = true;
-		} else if (ret < 0) {
-			if (ret == -EPIPE || ret == -ECONNRESET)
-				kernel_sock_shutdown(queue->sock, SHUT_RDWR);
-			else
-				nvmet_tcp_fatal_error(queue);
+		else if (ret < 0)
 			return;
-		}
 
 		ret = nvmet_tcp_try_send(queue, NVMET_TCP_SEND_BUDGET, &ops);
-		if (ret > 0) {
-			/* transmitted message/data */
+		if (ret > 0)
 			pending = true;
-		} else if (ret < 0) {
-			if (ret == -EPIPE || ret == -ECONNRESET)
-				kernel_sock_shutdown(queue->sock, SHUT_RDWR);
-			else
-				nvmet_tcp_fatal_error(queue);
+		else if (ret < 0)
 			return;
-		}
 
 	} while (pending && ops < NVMET_TCP_IO_WORK_BUDGET);
 
-- 
2.42.0

