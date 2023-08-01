Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FC1F76AEAB
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 11:40:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233296AbjHAJkj (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 05:40:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233122AbjHAJkJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 05:40:09 -0400
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 085571BE6
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 02:38:13 -0700 (PDT)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3714rcF2026402;
        Tue, 1 Aug 2023 09:38:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :content-transfer-encoding:content-type:mime-version; s=
        PPS06212021; bh=tcs+D4cRD4IrUrXw8vuK9KS2p+ZaMBiLKX6xyRq4mZ8=; b=
        Mw2yqL5g5sZ/+5sOHqy04piaGNoGTUSjvulEPYCYjX8V01ZWmf7zeq4PHVv8bsmf
        jNjmce/3DPykYrvlwVUx41ybXnlHy5VNkKmC8QIztZYtPzbLermYsosKjmPP0EAT
        5hkZ/0mhFf13Sc4e8/KDTunXxViAObxZHdvAMCqW7/5GIP42aisD0Mzpi8vN9SK+
        30As1vSw+SLMvfhBvXWRznUJNqjMXdoywrXvnTLXzQGTESutRzRJfymFdYh4L7rt
        yszePVJnijbrxrpYOmxnFf8I0nVywz0davCjbO1lI3iQcL1dhthMfW5203ap6t1k
        NBCgtt11vh9EO0t6kweJkw==
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3s4qyx2kyg-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Aug 2023 09:38:05 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k5iWWOW8soboIxWndpSbNkR2Zno1gol8fxqlc6Lgm3VZo2bS7t9VWdiIYFx75FLsbAEVJrI4qiwiPAyh+LCs+q1sMiiAzmP96BPy5q35o6xQqwQToBJNBFSe+TF7mbNWx4/7piTAmcjeV/dB20/5sEsxGrIwRDR6n+1F6QOmyE+13GZMWt9tX9JLaGfJu4rShefLCwHVWKT8aaQUMZA7XBGP9iXKqVUS/D5fYw1k9wNK/KETehu2GjcbS3+W0QKr0fbWT5SEtwIDOmAJMpG7iCaaEl+J9pmSbex7ZZwMIAvDEB3bUirrcCEiOuUazv9VwVH5GsHIZRVxLPmH+7VI3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tcs+D4cRD4IrUrXw8vuK9KS2p+ZaMBiLKX6xyRq4mZ8=;
 b=A/kBmLDmw0Y2ZiSR6HkvwJeYF/JSGEpx1GVw0wZaofyPHNUQxzJWwVGMx80gMZSEbHLFJQ7hCSoCU8tJv1ZZByatXpnatZ3B14r+HW74T4tBDZFpZLljn3VSXqnB4qRbbxQ7RtnnI5paeeXBrU1huHx/a0xnbmhIfpqPen4pF8m5MIND1lbSuJZRfzeECgkvQd6qFGTZ7dTKNpf9OQ4Q70GuZF8hgADPDJbomEkBCeE/UKvnNM1EC4qWd225YdgY/UB2i5M+iMw+KWKs9QnMIhyGudGg+ZiheniczoI1jRiRbxf+FO9/G1WTTINlcYbW4MdAwJKkW3o0FoWTzUexKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DM4PR11MB5327.namprd11.prod.outlook.com (2603:10b6:5:392::22)
 by SJ2PR11MB7425.namprd11.prod.outlook.com (2603:10b6:a03:4c0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.43; Tue, 1 Aug
 2023 09:38:01 +0000
Received: from DM4PR11MB5327.namprd11.prod.outlook.com
 ([fe80::1f8b:45ed:dd21:9c99]) by DM4PR11MB5327.namprd11.prod.outlook.com
 ([fe80::1f8b:45ed:dd21:9c99%7]) with mapi id 15.20.6631.043; Tue, 1 Aug 2023
 09:38:01 +0000
From:   ovidiu.panait@windriver.com
To:     stable@vger.kernel.org
Cc:     D Scott Phillips <scott@os.amperecomputing.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ovidiu Panait <ovidiu.panait@windriver.com>
Subject: [PATCH 5.4 2/2] arm64: Fix bit-shifting UB in the MIDR_CPU_MODEL() macro
Date:   Tue,  1 Aug 2023 12:37:36 +0300
Message-Id: <20230801093736.4110870-2-ovidiu.panait@windriver.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230801093736.4110870-1-ovidiu.panait@windriver.com>
References: <20230801093736.4110870-1-ovidiu.panait@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VE1PR03CA0004.eurprd03.prod.outlook.com
 (2603:10a6:802:a0::16) To DM4PR11MB5327.namprd11.prod.outlook.com
 (2603:10b6:5:392::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB5327:EE_|SJ2PR11MB7425:EE_
X-MS-Office365-Filtering-Correlation-Id: 1efe82f5-0374-4aee-782c-08db9272ffad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Gj7DDz15ogSF8dZMhKJYfj9oYTL4uWwCWh62D+aVmsUsPxB0VU9/Y4PO/zt20KsWmd8yfB5pcCrQ70C80z7a87kM39LiKO7C9cBOFoSenxYjUnCqjNlWuREvK/Y7H2prYMmUExQijyN8HlWiJo7RQjuqS3ECrKa2zLlWYFkRyG66UqssfGZltD39jvcLjul6112jBLAv3itBXNkHhl3wenL/OEEOed0MbqemAeZvZrmHAY2hN/1/ffx2C7+711SVGEOTcsPJ9+HmZZ6D5k7VYiQCDu4AAOiuoqH0gmLGvbytUaCywk8uxtZx7JeJTfEOy6CBvq+NQZ1hm94dMrleuVGs2Tigp65IqWOFwMkKHmr02i9iCOTggcPaIwgCe6sHtbJuoM9qnNGXFUxJMSlgRVutbeFEvT1wU+WgI9f7YXXSURTdCZwcIgiA32iv/yzYk3mqQNDzV1noRSazg49+B3XVE2nXawQ3QSZFIRUfwv6OXI+xe7cwQeFG1zV2IVFKUc5ZAt/GTBCVSukNTKzWjxOQNPmHWZ5e3hBA6FU13Ojsr2KsP2qN1fVZZ+uS8q8EYVL6oSW6GkrsNIn2OhWoH8jFzDnO9b9/X6ZHyIgJT4w=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39850400004)(376002)(396003)(366004)(346002)(451199021)(966005)(6512007)(9686003)(6486002)(52116002)(6666004)(2616005)(83380400001)(36756003)(86362001)(186003)(38100700002)(38350700002)(26005)(1076003)(6506007)(5660300002)(4326008)(41300700001)(8936002)(8676002)(6916009)(66946007)(66476007)(2906002)(316002)(107886003)(478600001)(54906003)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ijVY5laIxA1hxRWRMDjNvxmnEocy0kC0BdMg3lwVww3D7qolcyO6GPNT/rVn?=
 =?us-ascii?Q?OEM771fg2BpDnKBf0bQ8dTqHm/JE/u6PMqc/vTOintBwicXwk7hxho8zzork?=
 =?us-ascii?Q?U8b/jwPoMN9DN2/klsqYuep6lVuKGm7jiLOgMEUAZmrJTagEjrjQGhYl/JPy?=
 =?us-ascii?Q?7k+d5imXGgRm20Vyx39nYU2nP9gSrk6FYq8HzxW2wOpdW2eQ+VVK5rALafMM?=
 =?us-ascii?Q?v9/tlFy39KSBBFVo58PERRQVAOgsyj2pCKh5aPr9WapGETFn+YhmNgU9EvzN?=
 =?us-ascii?Q?oesq7QqseY+nNyqIVKLpSHK4Z1XxIKTr7Z1PFW9Qpy5k4uWdKqU2FcyPtxGs?=
 =?us-ascii?Q?grsGzDTXWD5W6tFA6IbSMd6Zvhi1k9inIcPz8WEfiD2wLBAwhNaq3h815vXS?=
 =?us-ascii?Q?QBphCMZdD3ok0JtA/3Qw2OMFnrTjiDSL1g9A+9aSyxJjEj7mshiZuf5lIUst?=
 =?us-ascii?Q?sTJBB7Q5fsUc+4Fr6Laz2bmZiCCE4khrylMoMPtANBz9xI08hz/O4J7aosVC?=
 =?us-ascii?Q?QRtgldzEPekUJkSVOPvM8wjdPjY9bFIorW0eYgkns4ak23f3NW/l+0RiDr9X?=
 =?us-ascii?Q?Lvedvcl9ONO+Pxa69DCpi7BwxsK6yWSzgYR4rMEs7wAd71O8+vzBe33KFnZa?=
 =?us-ascii?Q?6GerjI+rVK2zY26z9e487nLLkzUHwjQZiiGd8gza1RAE179bGgiHxOFASsDo?=
 =?us-ascii?Q?yzwhvi+O7L/Je9FhcIQUkB2JQzvQpsGlKHQZKD0IxZlXoGHJd97Vo4EzrgFX?=
 =?us-ascii?Q?0Y7VAKSNljpcdN+JDnQm1YgIMgUkHOVcFgnlNi/0y3lZO6V+J1/0KEUsgl1C?=
 =?us-ascii?Q?Y9sSLevB/bdDkFOFxSJRUVv3ok+KfYI6tGv3UozNReYvcVBRURXxJof1MOz5?=
 =?us-ascii?Q?7x3vr33jB9aLeFEoQnwrZsA8xxrnAZVLtu1sTMmzVms/h8aR2Uzj5iR2AA12?=
 =?us-ascii?Q?3FG+E3mkFR/144c28CcSGQNkJHsY8gl/nskqWYExtKEoYxo8DaYSbhkX/xfM?=
 =?us-ascii?Q?BxzT+FgAuxNg+83n/oC2UJmM0WWTlaD66vnMGJHDT36WPFJMKK3h8i6JtuGJ?=
 =?us-ascii?Q?D7V2LFNYIe3v9wb67IZB8NVGYCBRG6sZOO9naqtXTJWzsb97TTh6PjRI6VnP?=
 =?us-ascii?Q?9nzXeud+8VbX7SMIWgq2u36Pdol3Up89tArqrMv0DmkyOsIBFjhA56liZJRO?=
 =?us-ascii?Q?tBRv1h54UzvE+3rTTw7YiKCqD6joGLk3vKub61tVx3SOlNM7zv+DqoN74Vi6?=
 =?us-ascii?Q?EsU7bVvG2ErIiZ1fLpk4o/gRKw81w31ecUSZUo2lNK6UQfFGkj6VGIO8vE9o?=
 =?us-ascii?Q?g7Q8t5N5Hh4Hlh5/scnvAaK+gBkuhQO8+fOp9WavKDrsAXJSjw1jP71B5xJ6?=
 =?us-ascii?Q?6+q1UBfXK73AgYStewBNy5RbZ2skdnGUEJRWb6X7xRcWBVRtBMllQ6Iiio4N?=
 =?us-ascii?Q?l8dhrkfOYowjJPtPZRYS15+XHowMZlb2DFA71Hjg8lk/La3Nj88CPVwkFa+T?=
 =?us-ascii?Q?UhKI0Vxi9c6PZ0d/mc9QQ+zRftfQnOd4WUjPuHNZOAIkw5KO5KmAetmwWNwY?=
 =?us-ascii?Q?jrBkGNaL7SC22VpXERPwCk88x75ExnbFbA2kHIygKXrU8EmR6pVjjCfUowEK?=
 =?us-ascii?Q?JQ=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1efe82f5-0374-4aee-782c-08db9272ffad
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2023 09:38:01.7669
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h1Xfta8KTyySK8CVtk8qVm2yfueiFtpWfQd4eWyyIwzD79mTqXSZt9PiPU/UehKjG0mM8iSTqGfFAX0TpohcXKkkxBWoIw3ojkdFyZWFm3I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7425
X-Proofpoint-GUID: Q4GS0ccimXysju29fmcqQdn9ePD2_Wrb
X-Proofpoint-ORIG-GUID: Q4GS0ccimXysju29fmcqQdn9ePD2_Wrb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-01_03,2023-07-31_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 priorityscore=1501 mlxlogscore=999 suspectscore=0 mlxscore=0
 impostorscore=0 lowpriorityscore=0 clxscore=1011 adultscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2306200000 definitions=main-2308010086
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: D Scott Phillips <scott@os.amperecomputing.com>

commit 8ec8490a1950efeccb00967698cf7cb2fcd25ca7 upstream.

CONFIG_UBSAN_SHIFT with gcc-5 complains that the shifting of
ARM_CPU_IMP_AMPERE (0xC0) into bits [31:24] by MIDR_CPU_MODEL() is
undefined behavior. Well, sort of, it actually spells the error as:

 arch/arm64/kernel/proton-pack.c: In function 'spectre_bhb_loop_affected':
 arch/arm64/include/asm/cputype.h:44:2: error: initializer element is not constant
   (((imp)   << MIDR_IMPLEMENTOR_SHIFT) | \
   ^

This isn't an issue for other Implementor codes, as all the other codes
have zero in the top bit and so are representable as a signed int.

Cast the implementor code to unsigned in MIDR_CPU_MODEL to remove the
undefined behavior.

Fixes: 0e5d5ae837c8 ("arm64: Add AMPERE1 to the Spectre-BHB affected list")
Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: D Scott Phillips <scott@os.amperecomputing.com>
Link: https://lore.kernel.org/r/20221102160106.1096948-1-scott@os.amperecomputing.com
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Ovidiu Panait <ovidiu.panait@windriver.com>
---
 arch/arm64/include/asm/cputype.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/cputype.h b/arch/arm64/include/asm/cputype.h
index 08241810cfea..892fc0ceccb8 100644
--- a/arch/arm64/include/asm/cputype.h
+++ b/arch/arm64/include/asm/cputype.h
@@ -41,7 +41,7 @@
 	(((midr) & MIDR_IMPLEMENTOR_MASK) >> MIDR_IMPLEMENTOR_SHIFT)
 
 #define MIDR_CPU_MODEL(imp, partnum) \
-	(((imp)			<< MIDR_IMPLEMENTOR_SHIFT) | \
+	((_AT(u32, imp)		<< MIDR_IMPLEMENTOR_SHIFT) | \
 	(0xf			<< MIDR_ARCHITECTURE_SHIFT) | \
 	((partnum)		<< MIDR_PARTNUM_SHIFT))
 
-- 
2.39.1

