Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A00F7DE0FD
	for <lists+stable@lfdr.de>; Wed,  1 Nov 2023 13:37:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343660AbjKAMYr (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 1 Nov 2023 08:24:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343659AbjKAMYp (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 1 Nov 2023 08:24:45 -0400
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69D1F11F
        for <stable@vger.kernel.org>; Wed,  1 Nov 2023 05:24:37 -0700 (PDT)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A1BPaIi001359
        for <stable@vger.kernel.org>; Wed, 1 Nov 2023 05:24:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
         h=from:to:subject:date:message-id:in-reply-to:references
        :content-transfer-encoding:content-type:mime-version; s=
        PPS06212021; bh=T2175b9HMqpK+7jE8dtnR7ju3xTfyaNum2sUNrgKcZI=; b=
        AX/7TSuP8RcvAFCDAcRQSnfXavDP/dW6XBojVbQr5y3gadc9FOalOYRhaFvKPTbe
        Xm8nvffaWn4pRZKqY9Hdfi+EykXX1/orFtQYxl76hrcA9lOTluFmhBUjF+/QkYMP
        BDtmne4oeI2hQ2fGn/zdcUESVdrk+uQ1PK9CUfiW9NEuMU8DmohyyvlHIkt8RZ6/
        9J6v1PcGay4LgKnrwKvT5+ajtOdJfBx97uSHCBpAN8PM0jNV+MSCE5gAc44QiNrU
        s0+mCfonEwZD7ShjZf9Lm6rzUW8OmA+mNa0ArLZeOWsUat1SAakOYqFtIVKOZnbS
        qs172XxBFOmZsY0f/h6vNA==
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3u0wk0mp3q-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <stable@vger.kernel.org>; Wed, 01 Nov 2023 05:24:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uh/A6Rf5Wgeyn+U0mHL3FMcVlNF8NUW34E7kCBBp5AiVx2pOrKKNDJcfjBQF5cFD6ML071fVMPyy807k/fXoxKEPDOS8TEbBdJ9BDUBEQVne4aRpQ5BoLTu8Bv7rvdnQg6pyajH39V/e6VcZQxHB3nIMBd8wxowFMNXiqZO+mTWQ4kjACVwzNtLdoj4/gxgbI796FRktqvxgHDbL6aknWEIWxIn4Ay0wuiYJ0zBzx2kLL3ovhQjNS3MsmZET275yUpp+pGfcodjxWrBZeVNZpqpEjjIqvTHkfrxQuyC0HhKCqg6MyAe4XGIEbPzoLbReBOVhtI0tsUsG/svri43ABA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T2175b9HMqpK+7jE8dtnR7ju3xTfyaNum2sUNrgKcZI=;
 b=nmRF7XpaZvGopXAQnacNFiR3/aZuOJ+lwzujiu35E1DFdx+WXF6AGvZdKGtINLhmipwiZZ26qrn9pag9ikJyp74IRoxCaaCgcsPS6Kod5s/LmwlXfkKomQVWkl4ZpWIZ2tR4OI3xS2DtWVSDwrPZAYxduW8GLJjWJDjQcSchqPx9Moi6VxDpI6yRJULCQkxJDm/fRQFjfJyR06TC89ODyiswE1IiE7HvR9SChsi6T4+fJSPIG3EgLD966ULO0RFYkYhdbZ+2++OYXj9PilVGVlh6pkaggPd6Wpw+FzC0xpEvLsCDiuZ3d3C1VH2eS+4oelSoJsaHNjRpDuuj9/4ZRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from PH0PR11MB4952.namprd11.prod.outlook.com (2603:10b6:510:40::15)
 by MN6PR11MB8244.namprd11.prod.outlook.com (2603:10b6:208:470::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19; Wed, 1 Nov
 2023 12:24:31 +0000
Received: from PH0PR11MB4952.namprd11.prod.outlook.com
 ([fe80::5f7f:2dc0:203e:e5e5]) by PH0PR11MB4952.namprd11.prod.outlook.com
 ([fe80::5f7f:2dc0:203e:e5e5%6]) with mapi id 15.20.6933.029; Wed, 1 Nov 2023
 12:24:31 +0000
From:   Dragos-Marian Panait <dragos.panait@windriver.com>
To:     stable@vger.kernel.org
Subject: [PATCH 5.4 2/2] nvmet-tcp: Fix a possible UAF in queue intialization setup
Date:   Wed,  1 Nov 2023 14:24:22 +0200
Message-Id: <20231101122422.1005567-3-dragos.panait@windriver.com>
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
X-MS-Office365-Filtering-Correlation-Id: e94ea268-a047-4bd2-8e85-08dbdad57faf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mCLDaF00i5dZu1PfuizHTKRrY51p0CrXYd2Of32tViPYfbYklHrQJljFJeHH3D9KZY7EVtxbWYiJZR26JQw4ZUPqkWdVbEqBXPnIC38EDOe/8Yc8Vkchbf3tKhQf9Ynx1CZJeDB8b67I1xO+HsX4exUEOEqoN5JuukIlTCNGi3/6j0LR4umlmo/wkt+LdHvOnmV4bFUP4G/adQQixQNRlAKU8a2CDVlbE4+O7YXBMH3Q6XP2jS02Rl0lSOCm2/9KV3VBGDvSrgRXmM9gTgqu/Ad63U2jVRWxHYXr1bJ85rj1Qwrn4Smo23bpmkebknSYR8DYa4QtjUKgtTIA/z1YaahbhzbBaUUryAOH6B2i6kwEvq9/yyW4dhsExvpHiFo2B7wLm3L+DEsb7etslfkmPrs6aCE4gbTBpbOQBbxA1tL+GqGZ5b4XqGHcxM+IZ7X3Jr+x62xEP5gOIZ2yEzsa3XzU68Qag2ogcyQdySYvz5f3Uf+BkC8DcON616FnYQgFQHMTWurJisG57JFpSxE37TgmGga6+eEqOfQDDvtgjBrmNrPGRF3Ieqd5Tnq7QOtS7JL0tA2a0LOGhVQplWXWq7VhpyHOvoUydeW9RpIzOGjrQfRDSDCqPp8bdwvId4Ez
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4952.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39850400004)(136003)(366004)(376002)(346002)(396003)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(8936002)(2616005)(5660300002)(66899024)(1076003)(86362001)(26005)(38350700005)(6666004)(6486002)(478600001)(6506007)(2906002)(6512007)(52116002)(66946007)(66476007)(66556008)(6916009)(36756003)(41300700001)(316002)(38100700002)(8676002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/NwZrL3+9n2MlArqbjT6iQwBFnCfs+n4Lxkjfy2izM6dndmwfVo4lqle3ffj?=
 =?us-ascii?Q?ilb3c7rXnpw7aH/1jOUyGCuFRaCAzzCLz7Vo3TO8LkEMDG36bLLU32siZhTJ?=
 =?us-ascii?Q?uFsqqFhfW45LSxAwN0vvQWstv1Vk7XZlsboRCjsZPV5e1s+STNf27vbcnErx?=
 =?us-ascii?Q?JHoBnY7t4RweNihfPaQUdv41yjvKWIJi7S7VvM5K5iZmlBLGELtajzSCjOlw?=
 =?us-ascii?Q?K3qg0a4z/OGpMxVyer3bcxNUJj4sG4KSyRgbEn6GLIuUAXWahcg8LpaTGHhZ?=
 =?us-ascii?Q?xNwxBP368khx2glzT8GLkOPxKaRza2+GWR8G5KDzVFlFg31G5ulnlEwHnhFc?=
 =?us-ascii?Q?hoTARKWn7VmGJasw1TwUh39cw/DTojreHMA0PMCKQDyGQaoZl1SNWXfyzIc1?=
 =?us-ascii?Q?6/QqsUSV3GyLOrNoqTDkxvoTf01qshbQqKAfCmVRNn18ZxlYjYRKJMmivAaO?=
 =?us-ascii?Q?UyORnn7Lgr36+H+UvA2BmY7yc3a1L45NIuPwWC/bsKCPLgo3dTAc0YrSci8e?=
 =?us-ascii?Q?EZkGHZ10+rmQ/1p/SE8j55c4OePtOezjWCNvo76ztcbjUKGFzOfe0s187EuG?=
 =?us-ascii?Q?3QDWzOa39woUu0hujpMDlhcgcarChrQA6v/jBCc7QWfzqV+zSqPUybEKuk+k?=
 =?us-ascii?Q?0JhQNZTXMSdAYXF7I7dXpIV5ex9zRbAcC4sfa+aBcqRXkedYEJblmMRWp8RG?=
 =?us-ascii?Q?qniXMO966PizRNjuu/OTxmMeu/AA69wqqixyNLdj2hv3vGeJr8X3hvtmwZYI?=
 =?us-ascii?Q?I3ys6LvQzSaQypDln3H+ltUn0X+u2Zy7kDkQ0EW42eN5KDYUF09b0OvxJzte?=
 =?us-ascii?Q?TkSrbbzZs94OKwZsmNiy1psyO9IMbM0GJT1vTmg0hwrwrqKwJgnXFzsJFG6Z?=
 =?us-ascii?Q?MdDm8OSAudu10hKYOpWnMkACoGLU7LAvlrLFScwt1rKYv7e0ioWLaQSy1YPI?=
 =?us-ascii?Q?lfpUfJ2dzAJZD0kbeWyHvmhnjBBVk9kgOQCpC42g0XuAOqBpDzdYF0aS4Zku?=
 =?us-ascii?Q?S6DRT8/slvZ8l4xtWL2dIK9wKGfafYXyEVLwUYk63+LRRZbngP62vutN0Dhh?=
 =?us-ascii?Q?EdD/9VNKNGzOLcXSksVF6EtwC6bri4Grn8SRuFLh6flNm1aySD5jXNA8tX/h?=
 =?us-ascii?Q?KZeK7pi5+qwO7EkBrdC8VjR6U+4TNL2Z9xMNSkdOelN4OUisTmM6sli1CMZd?=
 =?us-ascii?Q?SqhLEc+EEpD2eC64sW1AHayA0O73f4NQPSmU2hWfoAUBUDpk89htjTo6qYy6?=
 =?us-ascii?Q?YBKKVsK1dtFr2HaPO1S3kyGOKZ3YVrOKz203yZ5lac8d/7oSu/q4g6K4QKlC?=
 =?us-ascii?Q?mtB+rtxk1YqHK1DWEZkJKHNvQ1aAI3FTxEsU7LP++hcB8ILXrQnWOQJqxvcb?=
 =?us-ascii?Q?hDKq7V8XljbqpjIofGpKOZxLW5omfIOeMRZ24Cp4FPu1o/xTHh0/NKDd+X2R?=
 =?us-ascii?Q?tT9unMlDwcEksLuG3kUCr0F0QmoWGJvPtNKpyfeOcN9N5plF+JyJiqCVUEbF?=
 =?us-ascii?Q?qh51+hl86kdd5nFsKAYxgAPjMp0YvXe26RRNyEmw1ZHaPT5Ld4tPelrpxJJT?=
 =?us-ascii?Q?6CarwzwKbchyzv++V/cQQpvV3/nhXDl3BjbOf8cbzPLgmF/f4dV372WHb3lt?=
 =?us-ascii?Q?yg=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e94ea268-a047-4bd2-8e85-08dbdad57faf
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4952.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2023 12:24:30.9698
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hovcvHfvob+rmf8WVKOg74rwIcCSrSHH+q1OqpHPM7ueuVdf71pHHE5O2k/7Q/8xxnKgSyG1/orXFvPDQrO3VOCodaEwaSn2JTevV2NdtSw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR11MB8244
X-Proofpoint-ORIG-GUID: KYaf17QrogBDpg7iKXkQsBhW9eR-uMro
X-Proofpoint-GUID: KYaf17QrogBDpg7iKXkQsBhW9eR-uMro
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

commit d920abd1e7c4884f9ecd0749d1921b7ab19ddfbd upstream.

From Alon:
"Due to a logical bug in the NVMe-oF/TCP subsystem in the Linux kernel,
a malicious user can cause a UAF and a double free, which may lead to
RCE (may also lead to an LPE in case the attacker already has local
privileges)."

Hence, when a queue initialization fails after the ahash requests are
allocated, it is guaranteed that the queue removal async work will be
called, hence leave the deallocation to the queue removal.

Also, be extra careful not to continue processing the socket, so set
queue rcv_state to NVMET_TCP_RECV_ERR upon a socket error.

Cc: stable@vger.kernel.org
Reported-by: Alon Zahavi <zahavi.alon@gmail.com>
Tested-by: Alon Zahavi <zahavi.alon@gmail.com>
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Dragos-Marian Panait <dragos.panait@windriver.com>
---
 drivers/nvme/target/tcp.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index e63a50e22e5a..e8c7135c4c11 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -323,6 +323,7 @@ static void nvmet_tcp_fatal_error(struct nvmet_tcp_queue *queue)
 
 static void nvmet_tcp_socket_error(struct nvmet_tcp_queue *queue, int status)
 {
+	queue->rcv_state = NVMET_TCP_RECV_ERR;
 	if (status == -EPIPE || status == -ECONNRESET)
 		kernel_sock_shutdown(queue->sock, SHUT_RDWR);
 	else
@@ -828,15 +829,11 @@ static int nvmet_tcp_handle_icreq(struct nvmet_tcp_queue *queue)
 	iov.iov_len = sizeof(*icresp);
 	ret = kernel_sendmsg(queue->sock, &msg, &iov, 1, iov.iov_len);
 	if (ret < 0)
-		goto free_crypto;
+		return ret; /* queue removal will cleanup */
 
 	queue->state = NVMET_TCP_Q_LIVE;
 	nvmet_prepare_receive_pdu(queue);
 	return 0;
-free_crypto:
-	if (queue->hdr_digest || queue->data_digest)
-		nvmet_tcp_free_crypto(queue);
-	return ret;
 }
 
 static void nvmet_tcp_handle_req_failure(struct nvmet_tcp_queue *queue,
-- 
2.42.0

