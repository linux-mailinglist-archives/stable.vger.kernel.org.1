Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A372728A22
	for <lists+stable@lfdr.de>; Thu,  8 Jun 2023 23:19:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236999AbjFHVTa (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 8 Jun 2023 17:19:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbjFHVT3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 8 Jun 2023 17:19:29 -0400
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3B6C30CD
        for <stable@vger.kernel.org>; Thu,  8 Jun 2023 14:19:22 -0700 (PDT)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 358Jkhq7003445;
        Thu, 8 Jun 2023 14:19:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=from : to : cc :
 subject : date : message-id : content-type : mime-version; s=PPS06212021;
 bh=1k0lhNfQUTsgEfQ14uKZfGc7N61qLUF/FS9DdJQ+0R8=;
 b=ejwE4YqW8ZHENZtxRTQYO62f87cF3dWvyKG+Tn6dVv9HdQ927TZnx5Cmn7Ld39Ujfqoz
 WQ6aMAssO6IiD5RsK4whwO1790t2xR4qV/xNb1zVw+rUIdLxER8PQesKpamWQm43WZDj
 RHyOlFVjjgcP9duOpiR9dJZPojw8m8KHFQbOGqwqIXKUCxv4D0t4//j4S534SaJhe+Aw
 5vwKqp0/uCgHDiBUgJpmOpUT5fSjtok3ZFK+yOwPVzYvQWdVpO0qbGe0KYjm2mmFbuU7
 6vqODdk5kYF5ZneNFtm9EBjGqCn37eHe2XNLqE17+lr2dO3v504Uah9Z1j55B8F28jy1 Sw== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3r2a80t41k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Jun 2023 14:19:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QSIfMtMLjw6IpnxgPZ1IKCf938XjXj7lp8fblYBTgVs/k0hsH2LcCHUp1wbk5hPbfL/6tccG2ABCslk9j5QAJ5TNCbxqn8Ogd+XAk++hAnxDW23uWNXOPpPJLHbCRCyNSkP2/vlJsbaAECneozoEHfl5FG1P9nLcfstRLdRetevO6x6cG74knAm4d3Ch8GYMawDIesf7Q67BcG6zmzmLDAmBj0HPKQEoYdN1Q19yPxfUSmcFrL3/NOLN+/ctaqsfrH8/J5KEfUWk8acJIoH3GanSNFjg7aPe2nMcFf72n9DDrcjxV8tIERU/XANAwZoONMPfOLX77FckN53nxOVHyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1k0lhNfQUTsgEfQ14uKZfGc7N61qLUF/FS9DdJQ+0R8=;
 b=O+kRogxA7tWb2imm9SY2p1zCI56Poz6flVC0qCoqJr0WMiGjxDk0CQPSkAU0JUpxczFhBCcApcs8hN36kJJxq6+/8wC0iba6leNpR5yZXQ/+agUofG3uAyasog89OSa97m+3+Br+Wilx5QuzXSMHJS/LwAo43zAHnmvZya9LCvqbuuEQ4od8D84W+dMfRr4kF+OJ2ivQyeHbaRWxuhJFsaUu+r3gdQnWizd6215eoUwdw+Ghs6LV9wezTIjboA2iH3yiGeKlMYhpL/l7Euv3FDWESVRtRRRXSuLNRQ1Y4kuzk5JUun05Osgo6bs3ipbAy/DkmoH+tpL8dLiswCmDzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ0PR11MB4989.namprd11.prod.outlook.com (2603:10b6:a03:2d9::22)
 by DM4PR11MB6359.namprd11.prod.outlook.com (2603:10b6:8:b9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.38; Thu, 8 Jun
 2023 21:19:17 +0000
Received: from SJ0PR11MB4989.namprd11.prod.outlook.com
 ([fe80::e27:6174:8fbc:3dde]) by SJ0PR11MB4989.namprd11.prod.outlook.com
 ([fe80::e27:6174:8fbc:3dde%5]) with mapi id 15.20.6455.034; Thu, 8 Jun 2023
 21:19:17 +0000
From:   Stefan Ghinea <stefan.ghinea@windriver.com>
To:     stable@vger.kernel.org
Cc:     Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Stefan Ghinea <stefan.ghinea@windriver.com>
Subject: [PATCH 5.10 PATCH 1/2] btrfs: check return value of btrfs_commit_transaction in relocation
Date:   Fri,  9 Jun 2023 00:19:58 +0300
Message-Id: <20230608211959.8378-1-stefan.ghinea@windriver.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0177.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::13) To SJ0PR11MB4989.namprd11.prod.outlook.com
 (2603:10b6:a03:2d9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB4989:EE_|DM4PR11MB6359:EE_
X-MS-Office365-Filtering-Correlation-Id: 93a1fece-a4e9-467d-6c76-08db68660435
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 07jJVlFsrbfUte4ABfa1JefnCjyu8RyVuxaqFZpE3ZGB803ptiBg6dT3onlBj6ZzPzeisO36vu4cid1b4pLMMqoYV1/94G86bHemddE70Z9hjNbJ0QHRLfhe8/EU0Jd7HGBYQpisKSJRwMuu4eUqdlAWZJ7fYeQHGEoRAUi8AzBJMk9uO21/L0Tdqv8hB8Kp7lTlDZ51TAUJBqqCYLtzAJIfX+mEYqa/jNpiPRWJGOZGDFJvm9ovioKNryFoUNunNj+3onALLQp37ZlTfPsr9RLJaLy78vwbUVkeKOxgqNwfW4gTcqEOARHf7SDVPDhMA+tCvel+MlDxdmCQY9/O39l+ThMprkqFx0W9lLbli0SE71TylXbVSX3SyxSFfDKtXCtk2BlkyuZlhe0CuF3aTlLN3vbX3kCRLxY0AmBFQIhtNHdrTajL+Vvtr1zW3A0WLR4rRQrn1wjsuu4hBjc+GzrleQ3is1DcoCQxFH/2fKdUlGVJnh2Ij6N5wFSwZHygdzZmUsZPB7CI5pjG4NEZdqp+VQVhbGFN3nqzIc/+yLqnn6jg1zLqRskMR4I0gddg8342mHq7F+BUnn2oy7pTmlskiGMjXSslE+ln9WmpseNt1+l6H1cDLnCcRIDtD5+a
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB4989.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39850400004)(396003)(366004)(346002)(376002)(136003)(451199021)(6506007)(1076003)(36756003)(26005)(83380400001)(41300700001)(186003)(107886003)(6512007)(5660300002)(8676002)(54906003)(478600001)(8936002)(66946007)(6666004)(4326008)(66556008)(66476007)(6486002)(316002)(38350700002)(38100700002)(2906002)(52116002)(6916009)(86362001)(44832011)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ixEYQZdTW8AxtWkz77bsOWT1dBTCxM2O704QQTw1v+bu+lDqSWXU/hWSUwxh?=
 =?us-ascii?Q?ZPMAczYampIY7E1NmP/ApCJQpojuP6mBz7ZiemqWV6MJKF64HlLT22r5hcvN?=
 =?us-ascii?Q?b6+Bfh3rr6x+ozMEi7GRSeX9pXDeL++go5YKXJhUjRAI1Qbe6CiqGxQP2dj5?=
 =?us-ascii?Q?pgX6zPPaKnxuf4yY3USSuVy6bgB5zFYRxJxVWFt55W5WjZZ9xJNFpag7sd23?=
 =?us-ascii?Q?7irls2k2DbH/Ca42MMExQ5pyYOhRy8zkvpPLApCXkY+MLlm/NP/0IAn5eWB6?=
 =?us-ascii?Q?wYssWTcI1pIzXUEKcTan3q/BEGH2+HeQ8URd2l4RMtXGz2iw3/EY8VSrtBiI?=
 =?us-ascii?Q?GQa69/YD31pPNcBSc0liV7uc8h+7nKVYGIM6IU6XFAkEa6Z/gVSFyxvSVXzn?=
 =?us-ascii?Q?Bk/jXOeH6wrPQB507VosXgiMxycjO1BLvMSvJYjmNrf2X5hjfYhXR2ZG0jZg?=
 =?us-ascii?Q?TRWdZHDItRIrEIuhutNx0u6tmROPhvgszuMYACrZHu5ziR9MgERww9hGmtaK?=
 =?us-ascii?Q?y9Uvg5hyf/GpmAaZbw0winhFRyPgW5vPSQxFIbw+6C4kyKWMH8WlKb411MXL?=
 =?us-ascii?Q?6TJL0KdyD/jFkUoDaiAi1I6AE4/WT/BPsyuXr7IiyvJGQCk+UWRbe5cj/TjU?=
 =?us-ascii?Q?4XYAapSURD8L7SDWELQxaQbcR6mW1/c26wPLSgw4sYhl5ZtKnPx3DACynvcH?=
 =?us-ascii?Q?ZjDktg9GSFjut7clMs6O2u20dN+/97IL/teoUpPpVjYrOgPRtt6ZIuYArajE?=
 =?us-ascii?Q?MC/oXPFm1nJAcD+ds9ox3NZTa9gq7bEjdpqQGLHW9FtT0fPbOC+2Qs1egmWs?=
 =?us-ascii?Q?Ru2N9C07xcSZR99jOxB83abuM54LJhNlcBV8EjtCR7UhVLshzYF9VRRnxdM2?=
 =?us-ascii?Q?AGY4n4BVrH1+fst+Mr9odYiE9k40W+9Y8dns8AEHwy0xP27Pjp0SSWsK65wX?=
 =?us-ascii?Q?BHw6fvRS0QW+qaMlRmTstwRvoDNsiq5Mew/TDXBl4MYktwht3ZE+O4f/gXsA?=
 =?us-ascii?Q?yT4Bhwh2TPwFLSznMOlUk8EJVKj5SJ/u/UIAhx2xsMYujLgZUdC6yXYIaWM2?=
 =?us-ascii?Q?wKtbNxyOyHl1vvrareKuPRsvelPcJb/LQMA6dBARCMmf2bz+Keubgy1oCxZq?=
 =?us-ascii?Q?woawwVDnqM2KPC+Q4XTM30TyCvj8snG62Bgt3CPVbKejMFtVwFbySI75WkDN?=
 =?us-ascii?Q?+Bow1YUd4c677c+HwpbEKc3m8nm372/yKCFOdhhRCKXjX0KnDDp3Z6GBubUX?=
 =?us-ascii?Q?62k5PhQDh0swkOMTh/capF4a3SuSgSWHgRNvUrqCT2EkwDlkioyu0GjGfvOR?=
 =?us-ascii?Q?vA/S6B+APg+HpwDG2SeCr6w+GNEcZ8VnnSF72rb5ZlFs9oFZGp0RoB/iyDIa?=
 =?us-ascii?Q?O8hzMxZXfnwWvaw5u3FfnR33mgpMiHWMFn1fAecgsbSo8sKyraqGjmWJdeM6?=
 =?us-ascii?Q?L4yylnieDXVBnvBjiMsLSm3LsjUTRKcMH8EpsxVqi/V/wh+amOhtiVP7erXi?=
 =?us-ascii?Q?ix+VnN/qKokFFLmaED+N506SGnyFOYeNNapEgtcgB0s+hKOsIdRF/DVVdD0C?=
 =?us-ascii?Q?SXZI9z0pIWT905DdpliRa4t3zxiYS0IbCUzcoc/G8dgCwTB58T+rOTScSwk+?=
 =?us-ascii?Q?zA=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93a1fece-a4e9-467d-6c76-08db68660435
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB4989.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2023 21:19:17.1337
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7Y2J6aSAWlA/KcqJZekeheM4rOSyEFs+9GAvmpjcYbhaRETHADKnwtCwGwD1HB1Ac1U71zC9gSRFg2kTX8BGRt5u3xchm+VoJjP62ze468U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6359
X-Proofpoint-GUID: nCJ68taYiYLrOIVarkKU6EPrqJ-EY7Zq
X-Proofpoint-ORIG-GUID: nCJ68taYiYLrOIVarkKU6EPrqJ-EY7Zq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-08_16,2023-06-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=905 adultscore=0 impostorscore=0 lowpriorityscore=0
 clxscore=1011 mlxscore=0 phishscore=0 malwarescore=0 spamscore=0
 priorityscore=1501 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2305260000 definitions=main-2306080184
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Josef Bacik <josef@toxicpanda.com>

commit fb686c6824dd6294ca772b92424b8fba666e7d00 upstream

There are a few places where we don't check the return value of
btrfs_commit_transaction in relocation.c.  Thankfully all these places
have straightforward error handling, so simply change all of the sites
at once.

Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Stefan Ghinea <stefan.ghinea@windriver.com>
---
 fs/btrfs/relocation.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index c21545c5b34b..7d64180fec2e 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -1895,7 +1895,7 @@ int prepare_to_merge(struct reloc_control *rc, int err)
 	list_splice(&reloc_roots, &rc->reloc_roots);
 
 	if (!err)
-		btrfs_commit_transaction(trans);
+		err = btrfs_commit_transaction(trans);
 	else
 		btrfs_end_transaction(trans);
 	return err;
@@ -3270,8 +3270,7 @@ int prepare_to_relocate(struct reloc_control *rc)
 		 */
 		return PTR_ERR(trans);
 	}
-	btrfs_commit_transaction(trans);
-	return 0;
+	return btrfs_commit_transaction(trans);
 }
 
 static noinline_for_stack int relocate_block_group(struct reloc_control *rc)
@@ -3443,7 +3442,9 @@ static noinline_for_stack int relocate_block_group(struct reloc_control *rc)
 		err = PTR_ERR(trans);
 		goto out_free;
 	}
-	btrfs_commit_transaction(trans);
+	ret = btrfs_commit_transaction(trans);
+	if (ret && !err)
+		err = ret;
 out_free:
 	ret = clean_dirty_subvols(rc);
 	if (ret < 0 && !err)
-- 
2.40.1

