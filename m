Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F54272C62D
	for <lists+stable@lfdr.de>; Mon, 12 Jun 2023 15:40:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235319AbjFLNkM (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 12 Jun 2023 09:40:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233804AbjFLNjp (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 12 Jun 2023 09:39:45 -0400
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76E1B12A
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 06:39:42 -0700 (PDT)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35CBqONs032722;
        Mon, 12 Jun 2023 13:39:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=PPS06212021;
 bh=2HnQDgPfamt+WaggqT1ZmPnkUVAvopQn+XalDjP1vIw=;
 b=nHagf6oT45czqEOA2WwAgNppPhhr6Db2euOcgnJHI8y91kRZMbRgELVYMZw1mgVKhc2l
 4gMUNEU73rYj3wz2SLS2n64bUb+3+RPSegd5ZA0gJ6ReAob72d/YtB77Ur38B4N/5Vz8
 6pDctXUtI6wsR6cpnkdiyH4vgaI6lFyjmAn1A0jmiKLstlcmv3/RwEaf6uti6+nLWubw
 rIbzucZ4PorCDQl6c/70F6fmTzWPVnpCEXtvnZxDQGQYm2gKiWnFcPRliCi5TNdEf8Ub
 3QxKhFvGNciD7lsNnKau+Tx0hWHjIvKxblgjN4iklvtuD1vLpT+fwobJ/mEnQWovNsAv IQ== 
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2047.outbound.protection.outlook.com [104.47.73.47])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3r4ed01nb4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Jun 2023 13:39:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yi2XRpw05WCTT62JK55yzMsABULrfyuswGqUNCPaQ2WnBialW0IgOIcJs9svxVVFjZ96iAge9Bzv0hsUYf+qNdhEcA+nyH5nepsOHMasNuimcqnrqpiKabGUpK/vxTufSqXSPf9tfC68VKx+eBlv1yWyoVYNiv3t0//4eMk9UWdbJh0zrbcu/bs54aUFUnHjJ74Oj9UxrtPP5KGMLyflEBzF+oAEGeSd9B/FB8vxFDnQjSMvIhcCs3xds+FgQRPCtjbUwmDof8341C9zxWLQXcE1uQDHKH/zbW370E+OqnltN3UEBmqCW90Brx3deQP3lrHapRJPoNM3N2852QqFww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2HnQDgPfamt+WaggqT1ZmPnkUVAvopQn+XalDjP1vIw=;
 b=MrgxJ3Rc/OphoInwcHx1yts5XmjozzhlT44nptYkn4aa+5JJLY8afPtHtXoMHNPR/LBom1b0VlBp+F3hKhEyw/Xi+eH0UdBypj7zITBbY3vIUnWFD6YnJGEA2OuYD9RaWB1vv3oxk2jtNP3Kp5h5Sn9559jdegbV54VrrAsasFZoLbn+EYYC9FI3O1Dh3JGCj+y7rdNY0yBZ3a2NkoP2/8EMEk+3bgQb3Z+Nmf2H8hFx894P21bdKkeN5U9COGQfEiy2pUmgEIgzJh7Hjeo+OJNhiskgARgQhaBw6GPCzgo6WI6J3XghPTT5adOjb06poCeNQsH1l+mUJGWjam13PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DM4PR11MB5327.namprd11.prod.outlook.com (2603:10b6:5:392::22)
 by CH3PR11MB7866.namprd11.prod.outlook.com (2603:10b6:610:124::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.44; Mon, 12 Jun
 2023 13:39:25 +0000
Received: from DM4PR11MB5327.namprd11.prod.outlook.com
 ([fe80::3686:e9c9:56d6:8949]) by DM4PR11MB5327.namprd11.prod.outlook.com
 ([fe80::3686:e9c9:56d6:8949%4]) with mapi id 15.20.6477.028; Mon, 12 Jun 2023
 13:39:25 +0000
From:   ovidiu.panait@windriver.com
To:     stable@vger.kernel.org
Cc:     Dinghao Liu <dinghao.liu@zju.edu.cn>, Sean Young <sean@mess.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Ovidiu Panait <ovidiu.panait@windriver.com>
Subject: [PATCH 5.10 1/3] media: dvbdev: Fix memleak in dvb_register_device
Date:   Mon, 12 Jun 2023 16:39:05 +0300
Message-Id: <20230612133907.2999114-1-ovidiu.panait@windriver.com>
X-Mailer: git-send-email 2.39.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR08CA0151.eurprd08.prod.outlook.com
 (2603:10a6:800:d5::29) To DM4PR11MB5327.namprd11.prod.outlook.com
 (2603:10b6:5:392::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB5327:EE_|CH3PR11MB7866:EE_
X-MS-Office365-Filtering-Correlation-Id: e5ff3492-3d1f-45b4-428b-08db6b4a6f8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ENrDjJGE6YMFpp1GCKKXo18nYGciAUQ79O1GMw174mWaw+WqpooDoIn7zTH9TdFdTLktOoVl6RCOJzn2KBhzXjCnGCHrCDB/T8WM6ogIae4NJVUoKYDcIlderpyseZWjkOpdr02EYg+fqpfZMIFP5xctG2FWR3cva8iSRh3ydsQxGdbwjBPhvdMHrFln2ezk1xMCrWLZJDV74gZohcA2eW9gSgsLylKsEugyNrYnQZJMOWlBzemhjsAhH5ykjWgLVAgya8rsKEPcPzbqRm+0nGNtE/WveKJN/p/Z8/kNewWaUeTPPecEReHRYyLLH+ngLZemWUAlCAkMTQnwcdHwvI712dC0fF0/WziDuRCflOQholpXpd+GWWNgN3xLZgTWk8lE/g4LU+q74PfENzHwdWcd9hknabNkDwz4CnU10RfJ41+zq16H9Bw2yir76P7gHT/a6pzY2C6Sd0NTHu9qldG6ggOjix0GsVKTFg04/vOgGj0w5DHphu3GFf+sFIjRuFblpyUxFNuSeIlToVN9frb77K+1e3JWPvyGK07MHN5VLw2NoGnjltLLCFQUZhdOnE7t/Ewl/oP4Xt0blNakUGZ7iaoSVfS+6cCuQmGcdG0weSDU6rwl69FBtuHVvBhL
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(346002)(396003)(376002)(39850400004)(451199021)(2616005)(38100700002)(86362001)(38350700002)(36756003)(478600001)(54906003)(4326008)(6486002)(6666004)(8936002)(8676002)(2906002)(5660300002)(52116002)(66556008)(66946007)(66476007)(6916009)(41300700001)(316002)(186003)(107886003)(6506007)(6512007)(9686003)(1076003)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uVSpifoUUZ+DD5kXKkyMaVdr05wweHGSH++Lq+cs2DL43q9PU9+VatfXkjvg?=
 =?us-ascii?Q?VbAvjRuoDiCbRW++/Od0YqLXaYgC69adnlKW0Y+45aSCKD3hY03E7qlazJ3i?=
 =?us-ascii?Q?UQTAJHRhRSwQ4UBgTQnR31bJyPqpDmMe9T9u7YjGQHKQaOc3qjZlsiVB1yRT?=
 =?us-ascii?Q?2+TaiFo3CJ0/Z57eTP+/FBh+aK0GKXBlQpbgdc2QicNDauSCR9WkT6vlVgcM?=
 =?us-ascii?Q?AfKYuC94bZKojWGQhH8p35AMidMlACIBG/Uy+8CyTA4Wa5/eIhpT3TMfhyYH?=
 =?us-ascii?Q?fcK8/fA81WJDAUjW0f0FRHCIGdTyHjo7f0LtFIYlKi7jW7a8T445pE0QbXks?=
 =?us-ascii?Q?i1CRnCww3+TkIZI908bjXWcN0v1RSH/MDmAdLaGrvE3etmr9pBpt198iNW/h?=
 =?us-ascii?Q?1A0iTMZ0++e7pMtU2ysmQD1zyoqiuMuLf67VyVmjwyD7N0lAyIXanfCNgYMO?=
 =?us-ascii?Q?g0dgMtLNj6x8BgKzFcdNK8aHv+Vr4A+U/r0BWL3wmfirYoTbqsQ/hfCKKC1k?=
 =?us-ascii?Q?VX4FFOiJnKzM7CL2B8Om92LCdoav6Dc1IIYJYyFs3a/txdhAcPXDnndl7YGl?=
 =?us-ascii?Q?EoLagyFuwWD3KZRKKZxGGtDHYoT96L5cwGgR3rXSDExLh00/UPsnQ0drNpgr?=
 =?us-ascii?Q?gSwe3KhKjPtrscSdsMrI5JiiHGc9vOS4kpjFvTISJmJDJFtCa7gakJS+xXwK?=
 =?us-ascii?Q?8eVgibu9RRPERv5yGzZhEyoikQVQamdhuSX5viiufqfIIPkLKBFAepvpsowT?=
 =?us-ascii?Q?kgS0GoS9X2IQEyKeAvoQtpmZCiomLt46eLj1ffAvHBPc5NCTEwx5tDaa5hHg?=
 =?us-ascii?Q?GoXGdS9Ibjpfc+k4Lm65diXzgeir5qdV6ktzF+MwLm4XJFmkR3pGw/1Tj1N1?=
 =?us-ascii?Q?fZmLqTdJW6VMS+uIjYuOWQYPW9YR93/VwjvqjOPDfZJa5iHBr7XBhrkcT/XF?=
 =?us-ascii?Q?IZSCChxvDXLhpZCx7syv/9CQoY0zN3eIizWpfRv/QgqHYR7oeRfC9+Nc/hQj?=
 =?us-ascii?Q?gYsigOQplimi0DBwMok3orXy2p0yg9sTPCgTn5SCh+owy5jvxPXKBv38Li1J?=
 =?us-ascii?Q?bBJ0MraD5PUyT78wT5FC4vXe9Q90c9RbmFvlm/5/Ru2yWqXSoYRuWb2kBwVo?=
 =?us-ascii?Q?9GuRBAkWg7TjktwZv3o9CTt1/qu0cevS9vapeY4P615jHAPCt1bW+qwb6qBr?=
 =?us-ascii?Q?EVXZ98RdrkhoKrEMnJnPsJJwEXOOHyQHjxgKcV+2PGS4BJEMCPVgyiDWjuHA?=
 =?us-ascii?Q?s8EJkBKpXV2+L/pb7B+oyh1YEDF1npIvGTR3llPTiCsgGkDimxvsm+V8xl6J?=
 =?us-ascii?Q?LMeNGOQoANcupEQimpQnNHwB9Bb5o5hZ/V/1l7XC1+ZCHDp6C4C5UYGfVFBK?=
 =?us-ascii?Q?fKNnXycAfpt8wnLr1TsY0KFhu11IogvBTpL8DKJAt1HEl+c9vcl4P86TrsJh?=
 =?us-ascii?Q?4IOII3iPsrFbQBuR8KRajQK5Pc6mP7oUA3ldezbQcQCUlsAsxshhTnwiaon7?=
 =?us-ascii?Q?CI9zX3ApPTGCKblyHCV1T5K6Nsg/1oAiZsUVOE6s2LFL8UzoaxZ+jIkgAjpY?=
 =?us-ascii?Q?aT5ryLIpBJ2sCteJPsESCvT4kJVmfKeaURLcTZfuwv8QI1rUGPHYwxltRCZu?=
 =?us-ascii?Q?4g=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5ff3492-3d1f-45b4-428b-08db6b4a6f8f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2023 13:39:24.9609
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cLVj2CY5V05cXqUlQH0uq9vVf91jMFcvJj5v0TolHh6noBjuOav3bfnQIuPkUVNiQmZtJsNpwopwZe0PRVHojFeYzpzu6N6SV2A8xvxCTc0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7866
X-Proofpoint-GUID: fxc9okl1KhrMBfjys4aFoQ-PwJgXEPdb
X-Proofpoint-ORIG-GUID: fxc9okl1KhrMBfjys4aFoQ-PwJgXEPdb
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

From: Dinghao Liu <dinghao.liu@zju.edu.cn>

commit 167faadfcf9339088910e9e85a1b711fcbbef8e9 upstream.

When device_create() fails, dvbdev and dvbdevfops should
be freed just like when dvb_register_media_device() fails.

Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
Signed-off-by: Sean Young <sean@mess.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Ovidiu Panait <ovidiu.panait@windriver.com>
---
 drivers/media/dvb-core/dvbdev.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/media/dvb-core/dvbdev.c b/drivers/media/dvb-core/dvbdev.c
index fea2d82300b0..52315434e0a9 100644
--- a/drivers/media/dvb-core/dvbdev.c
+++ b/drivers/media/dvb-core/dvbdev.c
@@ -545,6 +545,9 @@ int dvb_register_device(struct dvb_adapter *adap, struct dvb_device **pdvbdev,
 	if (IS_ERR(clsdev)) {
 		pr_err("%s: failed to create device dvb%d.%s%d (%ld)\n",
 		       __func__, adap->num, dnames[type], id, PTR_ERR(clsdev));
+		dvb_media_device_free(dvbdev);
+		kfree(dvbdevfops);
+		kfree(dvbdev);
 		return PTR_ERR(clsdev);
 	}
 	dprintk("DVB: register adapter%d/%s%d @ minor: %i (0x%02x)\n",
-- 
2.39.1

