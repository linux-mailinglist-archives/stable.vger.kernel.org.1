Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A653D728A2B
	for <lists+stable@lfdr.de>; Thu,  8 Jun 2023 23:20:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbjFHVU1 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 8 Jun 2023 17:20:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbjFHVU0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 8 Jun 2023 17:20:26 -0400
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FA932D52
        for <stable@vger.kernel.org>; Thu,  8 Jun 2023 14:20:25 -0700 (PDT)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 358Jm7LK009044;
        Thu, 8 Jun 2023 14:20:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=from : to : cc :
 subject : date : message-id : content-type : mime-version; s=PPS06212021;
 bh=qugJn9YPVR6GTSy5WSIyLkTJK4vN1clfJu5oshYQruE=;
 b=TCzVjY87ZqPakMWCbPJEDTrSK555fcWQ1tWS5orSt3L1kklRGEcYuIct9hEsFmmwau9j
 afvih9/fQDa2SkYNzGrzwortbJf9fpNLZxlvWdSQc+CcaDmpox8kXBKtVIfnpt9hPzHj
 sby+zhnIVPI1hvqVFLw/oUJcSGchnqcvMdqRp8KZ+EcohEHtheGDtrn5uxxmLA7TUus0
 /lxGSfkUpt6ldKF82Jlbm/R2O6DwGw0y7850Zp0S2yKUtLJt+bji/wNlyhlADEKDaCCH
 hIPqLOGlAN4wIRIizxwPNGG9prFt8hO5VcjDKtu4lEquGsGVgwwjEJxFfvzO69DaIO0m yA== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3r2av7a3bq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Jun 2023 14:20:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BYE3YlQWO2GyX7vDv609R+qsg84q88pMV6WFrI8mbYj3kP5GbV+hkhhjI0RjE7FGCg/9i3Z2dOro/KFk79t1pLWBn3RCQia/Jp8hmbLEqRKBY6l4emNixQQ9+SxxQ+j7Fx8gV4PyuT75P9r6Ptckljy7KYrLlkF2Qn0EaK1fDgx5zNmjzdoEGKHmR/9A/hQIERFNBdOqxIaC8/IsjPXM2qLFAGeyLNJpRiT8CTMyzAP2EgyrgZ5Dz1kPwCwKBLw/b3kf3zvd2dREVbcBoxdmlRXxDErWmC6rtRDA4gTdrhdAHbsTspiHC+3O74cNY2k7Nqb9uGrvpvu1b6mbKQ7DWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qugJn9YPVR6GTSy5WSIyLkTJK4vN1clfJu5oshYQruE=;
 b=ednAhNUoAN2XuY3yzG1csAYll9z5KPcc5Kxyps4fzaP+F8is5q3j8RAbKzpyuhU6Q9aHRQBLxG+W+rZhVdBReRwCa68bUimyyVoQgcI6awxANFIBaa0JLSaLJSzo/HlLhIefbeSr9K2KS+4wgpYfnIeQJDcsQvHgexcY+HliyoZFwu6iwi2pC7i3J4005IsTpCbp8UTOw1QsQbjHE4mfS780UtltQDl3oQTYs4U8htwNNXoo7cJahbMra2XsWbQwLLWXcqxpa/Ippruj8jgeQFXAgmY5jtT/LUHrf/Q/HT+/JOPN/khcfrb0UEKutSd/GtjoKMTuEr5aBhetoUt+Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ0PR11MB4989.namprd11.prod.outlook.com (2603:10b6:a03:2d9::22)
 by SA1PR11MB8445.namprd11.prod.outlook.com (2603:10b6:806:3a9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Thu, 8 Jun
 2023 21:20:18 +0000
Received: from SJ0PR11MB4989.namprd11.prod.outlook.com
 ([fe80::e27:6174:8fbc:3dde]) by SJ0PR11MB4989.namprd11.prod.outlook.com
 ([fe80::e27:6174:8fbc:3dde%5]) with mapi id 15.20.6455.034; Thu, 8 Jun 2023
 21:20:18 +0000
From:   Stefan Ghinea <stefan.ghinea@windriver.com>
To:     stable@vger.kernel.org
Cc:     Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Stefan Ghinea <stefan.ghinea@windriver.com>
Subject: [PATCH 4.19 PATCH 1/2] btrfs: check return value of btrfs_commit_transaction in relocation
Date:   Fri,  9 Jun 2023 00:21:21 +0300
Message-Id: <20230608212122.8534-1-stefan.ghinea@windriver.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: ZR2P278CA0069.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:52::15) To SJ0PR11MB4989.namprd11.prod.outlook.com
 (2603:10b6:a03:2d9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB4989:EE_|SA1PR11MB8445:EE_
X-MS-Office365-Filtering-Correlation-Id: abeff2b6-88ea-4de3-923c-08db686628ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pvGlJsfuSbNmGC/LBp3vKrxu9WEu1gHxjX7+AapvCec7QuexMtwTQeMJ0bR+lyYmBy4FqdVVdIT+QhZkw6PgigMAlzf4osRifrEMCjPAMQKhfkUEUj6fmM7BC3JnW2Tf0SsyN59nWE6Zm5t2YiEv/102dfKWv4rQuu/LcRZ3Irgqm8o60vZ01pqJQ4rXI65EIctVbnbmXB1qwLNyUfEJDkyVZRij7f2hV0YlLj5dr1c7b3roYLoR/h5NjKrF/eHiAMc4znBBJ67FsWkv0N/jAtK2Ipy7jAbm2oh936nkboPs+GazYI6BpizRFUE13wN3zA5IBWFZWVnvywngyvoSAl4VWy5NLc/8nhHoke6mBxE2pvkwo82Jq0fxy1q9Cb5Q0RvaINzpeVUqChy3wgOEVB0/sdQFW0MYPMaZlbOwVb/iuLScVmohYbB9uJF+EdFgnEIvugZNMV16DYDEjVUFVXoqgL9U1Ka5Wc69ZD60/4nGqBOYprxOvQZRQxR0JvYl1W/v3JuLt/CHjgmiE+MkQECgHACZLKoFpbc1H9xkBB4aorRrvh4O3E88LacJVbzlLVBnNmm48aSDl2A9GSMh+L0v3fZbTETEXOoo/ReFeg0S2F6TV3J7XtJYHtzRU35a
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB4989.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39850400004)(346002)(376002)(396003)(136003)(451199021)(6666004)(83380400001)(54906003)(478600001)(66476007)(8676002)(41300700001)(8936002)(66556008)(38350700002)(38100700002)(6916009)(316002)(4326008)(2616005)(6486002)(52116002)(1076003)(6512007)(6506007)(26005)(186003)(107886003)(5660300002)(86362001)(2906002)(36756003)(66946007)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2wF+41mQgbEI0mw0yt4stZpb24ohY6MffyQkpf932FPdFBLpWSqZsyWkiqco?=
 =?us-ascii?Q?EE5Xd4aayY0nT/7WYDUXAtq65DSED9Gu3gWOWW6F5tgjFMpzt5gWjaojBcMp?=
 =?us-ascii?Q?BinfF/NFGTATdcumJiob/sRLXSapqjgA6VrPCbJBh5O2DDzz0Ikyn85h7MA7?=
 =?us-ascii?Q?rrah1iX1WxwQFfVW6QV/8GgukLhxHzf+sUGxajdCRql50Q9rnOSdQLgyc+Lo?=
 =?us-ascii?Q?FA+i/Vd6GIoppUGfbD7DBr5ThVWROHVgeUWpiIVpGZnv8GODk5gjlzsJctaT?=
 =?us-ascii?Q?pj7aq50hXxxUYV7pB0HFBhq5Xdoo7fUvW86/Q+x7ePcgkrXaFef/37qFabBd?=
 =?us-ascii?Q?NRpGERl0PNx4X6snGWfLSN67lVQ7LEPDXGOuEcoOkKpLGw+3MXAFyeiTiEP4?=
 =?us-ascii?Q?UpracYshTKdidM0fy3zPBJumH1XHRCmqkGmAi/FYs1gWmd1zH/M7w3ou/o8e?=
 =?us-ascii?Q?/60DBuuaDY/qNr41OjzeeaTbpVV70aQ8cnu3ia4S9kVRLtnFPUon7IOdrlE/?=
 =?us-ascii?Q?/1D2Bu2EAU+vgfGzYpG5CV+KXe0e4JIlFzHDMQJ9uURKEmU7lcA/y7YG3eq2?=
 =?us-ascii?Q?VwxYCEB2IJhqXMpaEPLRU+wTJJ2JoIY8yDF59LFNGkgG7DQsNZVSXbxGdBoD?=
 =?us-ascii?Q?3mkOOVQTw9tW2NzVCzRS48UBNRvVMqEK2kJUdGTBtNTgpcTvTf9gcKtgr19b?=
 =?us-ascii?Q?4RztCsQFU0d6pmTqIF5gk8z0+WMKyADmELb5d6VleKBlZT5aDe1MZC6Tfba2?=
 =?us-ascii?Q?9byM46qOYYmkot1UgqSDUv/ldZyYOVIiI5aZHhO0Xwu5tlxbr0nDfAw75kVe?=
 =?us-ascii?Q?Gl8vzRHkBK93Ye/ihTVPHiAhaH2sSGMexEvtQ9dMj6Xmwrwoo6N1YlhriNNk?=
 =?us-ascii?Q?otPrKkAQASlHwq91joaOhr/02gx5cxkZhvqM9kFZ/Zp5xZae+1gNyo5KHBrM?=
 =?us-ascii?Q?E6hsDJ/VUT550XAxsOmjHpCFfYYIQ4vcQpOjXZLoJLyTDq5SlRHMsGAZBz1a?=
 =?us-ascii?Q?m7lDcioD/gN0stVrSCIC4f2lVtUHS3a2dT40dY2BvICqIk0Tgt6fbx/UeH7/?=
 =?us-ascii?Q?AYRFN6BkuYAKiqImj9VrkTOI0uSxuAUbsbpHtPEdEH25gNUKIAfX3DiySEw2?=
 =?us-ascii?Q?w32YnMRiVjv/cigGxPplXATOHK+dF6vjSn/bSDUz/ZHxyiN1r7J/N3e2j59k?=
 =?us-ascii?Q?qxQNYrSrBgfLxXD5PWxrWZU3rvxwGLdA6jIrT2WKIt6ihzlU8JD953vqaMsF?=
 =?us-ascii?Q?QIeIyGA0jeVw16ZiEm/H7Y4jc0BH9zNPgqZ8lcvtx8RYrbCvCMmKOMtfh6Ak?=
 =?us-ascii?Q?JzL57A7WWSs7hZ0KQOLnQEULSoQs9ah/PkEQUzDYy5ckK4eYqRDeaPCZqJgK?=
 =?us-ascii?Q?aEHJw4Dt7MdF+jMLRgAFyxvRwy/rYixD8BIGoU/ieCmcsdXkKI/lVf13K7ha?=
 =?us-ascii?Q?E31hTLTTO02G5p7LkShCr5zaHapKOYgg32XVKLTB2T4VIXZWi6EBTkzZ8Klo?=
 =?us-ascii?Q?k2vttOKclyIhkE0ZHfvEFUfOB94TUjNdK4mrDntdXgH4yw+Ik0w2bt1awGn8?=
 =?us-ascii?Q?ekHbZ7iq6pGKEoxISOXQAQ9+4wg+Wuu0mwCE8zjJpqDBZsA+eEkCU8WLEGrk?=
 =?us-ascii?Q?ng=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abeff2b6-88ea-4de3-923c-08db686628ae
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB4989.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2023 21:20:18.3386
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +D2XkTSUE3gKHjsrqr557L2tyKjCDjyddE5NgmvyvVej30uXuWpFF0MKWb0LTrdqoXzIFa7UZ15UkOnITrXOndDaaQiyoXSQc1sjEGZRghI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8445
X-Proofpoint-ORIG-GUID: xnOsjBimEylBMn2ue-mcjORRveBkOil0
X-Proofpoint-GUID: xnOsjBimEylBMn2ue-mcjORRveBkOil0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-08_16,2023-06-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 impostorscore=0 suspectscore=0 bulkscore=0 priorityscore=1501 adultscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 phishscore=0 mlxlogscore=998
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306080184
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
[SG: Adjusted context]
Signed-off-by: Stefan Ghinea <stefan.ghinea@windriver.com>
---
 fs/btrfs/relocation.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 06c6a66a991f..82d0a13ccc54 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -2341,7 +2341,7 @@ int prepare_to_merge(struct reloc_control *rc, int err)
 	list_splice(&reloc_roots, &rc->reloc_roots);
 
 	if (!err)
-		btrfs_commit_transaction(trans);
+		err = btrfs_commit_transaction(trans);
 	else
 		btrfs_end_transaction(trans);
 	return err;
@@ -3930,8 +3930,7 @@ int prepare_to_relocate(struct reloc_control *rc)
 		 */
 		return PTR_ERR(trans);
 	}
-	btrfs_commit_transaction(trans);
-	return 0;
+	return btrfs_commit_transaction(trans);
 }
 
 static noinline_for_stack int relocate_block_group(struct reloc_control *rc)
@@ -4097,7 +4096,9 @@ static noinline_for_stack int relocate_block_group(struct reloc_control *rc)
 		err = PTR_ERR(trans);
 		goto out_free;
 	}
-	btrfs_commit_transaction(trans);
+	ret = btrfs_commit_transaction(trans);
+	if (ret && !err)
+		err = ret;
 out_free:
 	btrfs_free_block_rsv(fs_info, rc->block_rsv);
 	btrfs_free_path(path);
-- 
2.40.1

