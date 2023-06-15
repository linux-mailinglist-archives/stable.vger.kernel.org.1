Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADEA7730D24
	for <lists+stable@lfdr.de>; Thu, 15 Jun 2023 04:20:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230301AbjFOCUz (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 14 Jun 2023 22:20:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230144AbjFOCUz (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 14 Jun 2023 22:20:55 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6662B1FFF;
        Wed, 14 Jun 2023 19:20:54 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35ENRDpj013541;
        Thu, 15 Jun 2023 02:15:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-03-30;
 bh=AiZbaXIwktkXTcCnm/9xrWHBZ9lNt4U0eTk1hKjXYao=;
 b=zMODG8szWHE24O3FmVMixdZV2wuURXY3n5vv+9xVsA1R4NFWRLUY/93jmhOI/p8km9Ru
 xgBBn3aRBUooInh5ZWDEK72CCHoJ0oBf4Zn/qj9gxyBIHh0H+u97RL7jXvECWeM02zty
 RuotnsoKu8tbqKKlYceKz56F/ppUcUB+mF/qTs3cvn3j/agzsO+5Y4GBco6jDKu3FZm/
 2haAmsLNzVU+1EPuUqWZ6fION2uv2pqF5XpcQ+rraXVbRglUICRPxlyRQ35jxnGHgh6U
 0OYpeOchAoAk475C/gFK2LwZqmE7sPick6Hf55CWoMDRg3PePF8tVUY02QOrneybEEIo YA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r4fkdrsph-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Jun 2023 02:15:43 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35F2Ccbr008331;
        Thu, 15 Jun 2023 02:15:43 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3r4fmcm0j8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Jun 2023 02:15:43 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35F2FfT1031296;
        Thu, 15 Jun 2023 02:15:42 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3r4fmcm0h8-4;
        Thu, 15 Jun 2023 02:15:42 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     Don Brace <don.brace@microchip.com>,
        Gilbert Wu <gilbert.wu@microchip.com>,
        linux-scsi@vger.kernel.org, James Bottomley <jejb@linux.ibm.com>,
        Brian King <brking@linux.vnet.ibm.com>, stable@vger.kernel.org,
        Tom White <tom.white@microchip.com>,
        Sagar Biradar <sagar.biradar@microchip.com>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH v4] aacraid: reply queue mapping to CPUs based of IRQ affinity
Date:   Wed, 14 Jun 2023 22:15:34 -0400
Message-Id: <168679530530.3778443.15600922770110502404.b4-ty@oracle.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230519230834.27436-1-sagar.biradar@microchip.com>
References: <20230519230834.27436-1-sagar.biradar@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-14_14,2023-06-14_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=926 phishscore=0
 malwarescore=0 mlxscore=0 adultscore=0 bulkscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306150017
X-Proofpoint-ORIG-GUID: n0f9WyS46Pmb-m186aP0cLcCFpURrWVZ
X-Proofpoint-GUID: n0f9WyS46Pmb-m186aP0cLcCFpURrWVZ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Fri, 19 May 2023 16:08:34 -0700, Sagar Biradar wrote:

> Fix the IO hang that arises because of MSIx vector not
> having a mapped online CPU upon receiving completion.
> 
> The SCSI cmds take the blk_mq route, which is setup during the init.
> The reserved cmds fetch the vector_no from mq_map after the init
> is complete and before the init, they use 0 - as per the norm.
> 
> [...]

Applied to 6.4/scsi-fixes, thanks!

[1/1] aacraid: reply queue mapping to CPUs based of IRQ affinity
      https://git.kernel.org/mkp/scsi/c/9dc704dcc09e

-- 
Martin K. Petersen	Oracle Linux Engineering
