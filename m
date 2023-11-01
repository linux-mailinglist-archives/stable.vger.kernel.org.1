Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C38EF7DE100
	for <lists+stable@lfdr.de>; Wed,  1 Nov 2023 13:37:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343649AbjKAMYq (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 1 Nov 2023 08:24:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343653AbjKAMYp (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 1 Nov 2023 08:24:45 -0400
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6381C103
        for <stable@vger.kernel.org>; Wed,  1 Nov 2023 05:24:36 -0700 (PDT)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A1BPaIf001359
        for <stable@vger.kernel.org>; Wed, 1 Nov 2023 05:24:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
         h=from:to:subject:date:message-id:in-reply-to:references
        :content-transfer-encoding:content-type:mime-version; s=
        PPS06212021; bh=TmuhwRmX2Fx/PRZgAavVxF91uSFyqX5J+520z+8Togc=; b=
        aR776qkmzpzqskcCP9feQA9Pv5OkUKH/RnBqGfH3tf0XhiT4unOb6svc4b3mmRsJ
        Jwie78tZ1L/sjzXyzVKHdsAZUM/q9WxL2uZL6Uf7m7llZDGcwyGpOoMSNJSzuJy9
        4WMf4g79vIT1epra/WNDqi8wjIczsF+4jx8rpgtln0hRzuYe313NWrio8RSYX2Ch
        XDq4nNc1GdYLcMWxoz+MZJ/5Hh5iimCrY/ZyZtV84dr69wKCq6KI/4fjkYv0wSY/
        snSR5po8mgQUK79EQcAbZd2hcc7/EF5+4/NiQKWmPe/9FbCDFbf1iniN/pNYu+79
        BZQ9aem1tFITlEnhui1uWQ==
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3u0wk0mp3q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <stable@vger.kernel.org>; Wed, 01 Nov 2023 05:24:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MWa2m4KZaJDqi6y+pVMxWbdYRDhkXA2zynCwXy/BfoRHNb3VQOpUlFuG68OHu55mEIWhBHlq5p1jxiyqrFmsb3kEVfvA6uyXgjocpSBmktilbO0WPDzmTjCKUdX/1Vx3izFW6T2zmbRlo+pKs4pUV8yQre1JDnPAea+YAEx4l1AJiZdwXF+DdYfiOf6r3fyciRlZCf5yIS3+h6ekfYMP6k2FNBvjhFzpb/Ld44UXnM1qGtZYYTCVk1y+C9tLQvglrj5QjoQnJt2vR3bEsMF1HYLVqFYB3TDDp+A5jbN/efnr7HeTn0YLRazi5ikg9isJthbk17GRIuvO+WXKYdQYiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TmuhwRmX2Fx/PRZgAavVxF91uSFyqX5J+520z+8Togc=;
 b=n85ixGC3MmKBY/L2zJpzEgCJmRa8JA54YqXbrHFTjLT5iuLJs9te85bznuAqi+gjIZq7tvMNOFXaiu9xWBz92hefoAB80s3gsfQkPRtc/n5BGfM+/ETyhSTzU58+F4zKQcsM3uowJg8pp6Afo/YRWOBoGij13ssU2BKlxR2bIBf6SnWT110nZE59qtucGFW++ilj7vQyJXHf5zpdq7WxsjxEHrGu2kRsI+RsE5yM9EiMTi0huan5gJ5DM7OJSqFMTtxlQ3+AarQZR5x6zv/IfK4fXdjjzMarmJYd25dwPDi7v7pL05TG3DHhWpqzI/bIy770DU136YoxjMSxxpvsAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from PH0PR11MB4952.namprd11.prod.outlook.com (2603:10b6:510:40::15)
 by MN6PR11MB8244.namprd11.prod.outlook.com (2603:10b6:208:470::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19; Wed, 1 Nov
 2023 12:24:29 +0000
Received: from PH0PR11MB4952.namprd11.prod.outlook.com
 ([fe80::5f7f:2dc0:203e:e5e5]) by PH0PR11MB4952.namprd11.prod.outlook.com
 ([fe80::5f7f:2dc0:203e:e5e5%6]) with mapi id 15.20.6933.029; Wed, 1 Nov 2023
 12:24:29 +0000
From:   Dragos-Marian Panait <dragos.panait@windriver.com>
To:     stable@vger.kernel.org
Subject: [PATCH 5.4 0/2] nvmet-tcp: backport fix for CVE-2023-5178
Date:   Wed,  1 Nov 2023 14:24:20 +0200
Message-Id: <20231101122422.1005567-1-dragos.panait@windriver.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2023102012-pleat-snippet-29cf@gregkh>
References: <2023102012-pleat-snippet-29cf@gregkh>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR06CA0112.eurprd06.prod.outlook.com
 (2603:10a6:803:8c::41) To PH0PR11MB4952.namprd11.prod.outlook.com
 (2603:10b6:510:40::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4952:EE_|MN6PR11MB8244:EE_
X-MS-Office365-Filtering-Correlation-Id: c402b921-299c-4d18-9df3-08dbdad57e5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: av2fVYqlQysFbqYiSjjTFYZEKEHxCMW5U2EmU0COLZhGjwgOaxY/YwfllRMcnXfVKHJ2NrmCJypPfCjJH0d47qxZZ5dZ+azfQzyZlz2aVd9Vyoye7uhyHeitLCGRinuo2Bpnnh+cKwN42cPprTbArKLTWP7L6p0XzYDjOLzNKzrtaiVCxV1uh7y4PkJE4kyKHyZWphsmXv26o/7vmPkVBwTigijJ4FSNBRdvnuqUPAt41gVldvz24sdnCXVxrqUnDs2oprfI7NjrDSQ3Ez2AvYsZnYqJW1OCuzkl46WmaY+of++OWBbvVOpv8Tj5zPMPtI8lgcYGETx44Gq4FUpEdPMwO8Oma5gOLvh1LEnMGVBGJYRGPsDcNZTYf5K0qut+HyRvTs+emOcydxRes3/XvBasiBNsWmUWleOddI8OHVND/MKOIq4gTcCOgxisdTiG/kzbLQblClA8zOTA0M5jk/+DwVVIanIXhVt0swLpQ0tdYQ0Q8c7+6fqKzEiSIZpeJqHbr7UM4q/8/N6JWgdE1y9tipCUlLoqyAOLYegZ/bJjzmjhPXkTirFfYBix518EDmWuThOJCzgKyRnzf/EDHY2EK/5cQyahr8cuGgIusl+2EYIgSdXUznSuYIgZBExmIageW36FHSqWgD2ingRHVA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4952.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39850400004)(136003)(366004)(376002)(346002)(396003)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(8936002)(2616005)(5660300002)(4744005)(1076003)(86362001)(26005)(38350700005)(6666004)(6486002)(478600001)(6506007)(966005)(2906002)(6512007)(52116002)(66946007)(66476007)(66556008)(6916009)(36756003)(41300700001)(316002)(38100700002)(8676002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?i2h0O5z4a3/2h6MKYgeQqp8F4iUC4Mab9egB7xozo1Qg1w47FuIc9zaVbYug?=
 =?us-ascii?Q?+1k2gZb4UT2l6NH/Rz09gcGlBKPeFLrauc/M95PGQelt5vH1HuKEp2IPFzmh?=
 =?us-ascii?Q?xBVzmFMiwNwasXxWD7t93oxGmJZrbiHavNlmPYA7lCBZhCy/X4H7GHhWaIBZ?=
 =?us-ascii?Q?9SAKdbhwCl+VGssz4ldnUwsdbBmSxyJAS7WzqvBg293/cmwQ5j+2i/t7aEMr?=
 =?us-ascii?Q?Aqz9O9IslI8GOLY+7KiZegBc6EKpY8OqvGdTRYJDnoLLlGZeONtJ3b6vsHG3?=
 =?us-ascii?Q?xL01g6jI1GMTLb1t7C71RbHEjmFvOtokKkTYuwPOENTDAjAenA0OIcvsRl49?=
 =?us-ascii?Q?xPtTH1a7kC/PXMZJp2UkY70PiXXGnL9dsh3aONT9jHt/xBMTcDEw0D2KZfps?=
 =?us-ascii?Q?Fz4D72BqQnV7I72GeeY7GdQHlC9SWv2MT3MA+6wNxAEydrg8Um6chDfmDMZ5?=
 =?us-ascii?Q?puro2WmhImDY9B8fQWzeI7/ht+Y6NFPfWospOlIOgAU/VQCGlYU1DdTmg9v6?=
 =?us-ascii?Q?Bs8Pzd+lhM03XHNOv8bEpKZVhSUGxaAeThknpUDN2sKKt7alrKca2Yes0uEF?=
 =?us-ascii?Q?f6aFpvNzL3tNhWkXiQxnpvTv+7URM1wg/f4yhkA9uAe9pnJQdaTQLOwY3r4B?=
 =?us-ascii?Q?/kKOruU8DwCZ6TJpIxE5fTtuggURJQjGFzk/Ft4SVzUCMEXMz9bhzSzsKNQ8?=
 =?us-ascii?Q?1wDKZtSKnkxcHtIMYm6C6jyLMmuFZAF5QGKS2wKafXmIAAuLOhoG/l5grrT9?=
 =?us-ascii?Q?HokZZcz12hK6qoge6jX3loFaicoI0aGgY8r1shktSdhsJiU8VV7RUYujFxlg?=
 =?us-ascii?Q?BMK+UcPoO+R6wlZSdni/K9ZKfo1+E3Z20jdpqsgNH9MiZsRQwKwEG/jB6EGD?=
 =?us-ascii?Q?O8DohOMW84FMV0f8QXZrjRNIYsl7o89GfGzWwS5l138IEdfyWM/n2Ym8hNLg?=
 =?us-ascii?Q?3qtHEj9w75LIXgOViLsdUR7C4g/UWiB/efwB/dl+jGAJpOp6TBAIpRhu41mf?=
 =?us-ascii?Q?Zy4Xy5m9r1zAjyu7MnXz2+3k9zYUHyEqu++imEKz5WamvgiQS2TGwsceLQW+?=
 =?us-ascii?Q?IBi6wxk7/R3UB7QyR+jR9qULpZU93y6XuVz/UN/cY5CborIzTTUu2ZyTcGco?=
 =?us-ascii?Q?MS9nqtcf20E9PkI2SJYnTJo+00uhL76XCrA9souc3rHG/pIEuqH8nSeikLXJ?=
 =?us-ascii?Q?Ys4N0HEyo1vR0IZtC0kcXvHwKP1m7wo8Mt90Q787QStl7noMb07on7iVPdPY?=
 =?us-ascii?Q?MEUP/3Euf2uY9r7xOL2JsmMP9lsY70zA81+CKn+leXK2Z8gAAxo3jp8Lt03F?=
 =?us-ascii?Q?NdMkRPSecGfb2VzXkMnmjFwQy381xTVx8zg5NPhvc6/7XBW9gbWNPnGaIIBn?=
 =?us-ascii?Q?HFW68MU/BhseDS/+PYE+uzTW8cUMMfxTfrV6iAKKudx7zCEpH2ayBTbgYAQq?=
 =?us-ascii?Q?ezvJ6Y5PQhUXrQ5C/bHnqbtS9SmE0jR8IoIwxcGV2WLwPf9m3itE+k1IvjO6?=
 =?us-ascii?Q?pUhzcTHSzOfsa7kqZ0zj3lR+fE8q3+OJyuzEOiPX6zHpN4Re/xQ+nCmA1yDc?=
 =?us-ascii?Q?ExAhcnEEG/R+8vz9O3dfmhox6WQ9Ei966m3ggVawvRDAQQN2uRR91io6fcDl?=
 =?us-ascii?Q?pw=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c402b921-299c-4d18-9df3-08dbdad57e5a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4952.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2023 12:24:28.9616
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YTxz+PWswa3OBKvq6QAjxp3g7bi+7htpkI5v/yQ45Ob00MF7DXLJtzqkZiobyazNcIiLe1HtF0QB2TJQEx05VSgtXZvzoLT0vlp27egFfZ4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR11MB8244
X-Proofpoint-ORIG-GUID: Nmls2f25JqAtYxq1nox1yz3vFYfeO11y
X-Proofpoint-GUID: Nmls2f25JqAtYxq1nox1yz3vFYfeO11y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-01_10,2023-11-01_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=334 spamscore=0 phishscore=0 adultscore=0 clxscore=1011
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

The following commit is needed to fix CVE-2023-5178:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d920abd1e7c4884f9ecd0749d1921b7ab19ddfbd

Support patch:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=0236d3437909ff888e5c79228e2d5a851651c4c6

Sagi Grimberg (2):
  nvmet-tcp: move send/recv error handling in the send/recv methods
    instead of call-sites
  nvmet-tcp: Fix a possible UAF in queue intialization setup

 drivers/nvme/target/tcp.c | 50 ++++++++++++++++++++-------------------
 1 file changed, 26 insertions(+), 24 deletions(-)


base-commit: 86ea40e6ad22d9d7daa54b9e8167ad1e4a8a48ee
-- 
2.42.0

