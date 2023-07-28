Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E5C6766579
	for <lists+stable@lfdr.de>; Fri, 28 Jul 2023 09:39:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233713AbjG1Hjp (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 28 Jul 2023 03:39:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233523AbjG1Hjo (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 28 Jul 2023 03:39:44 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05A96B6
        for <stable@vger.kernel.org>; Fri, 28 Jul 2023 00:39:43 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36S0C2kM004125;
        Fri, 28 Jul 2023 07:39:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-03-30; bh=yze51+sM26cXgiSu2x3p+A3zEUNG46xaDASba7s3Ayo=;
 b=r8ETN0aO4X/tcv02vNLbJPSt8fTng1eUFAMa/hvM/IuNVJ3qiMdW4VPYAG1Eo79CHA6b
 nl1+qRzpmMix6iwO3NLZ19YdLR1WArpGSuD2vJZGjnTD7ubcJxqxe+qcw4q6arzdZjqK
 vnBTU9LZfyMrU130HpwV5i86oexOBGiSoSdHG1btJSzel8pI3NNDW3fY5vVxlWdTMXza
 A7fvbXNLSn2F5a6hsYVcMod1muGRaO53lcLUzG6tTM/hJtWQy8Xar+G6DmzXxOkiJZBf
 Vtp1P9RUeNvLUaUIKhMAYJyQQuORZPxTa6ZePBfhN3OvAUmGhLd/rX0ACAhLKrm8JsL7 UQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s075dbfxr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Jul 2023 07:39:17 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36S6dNW7030428;
        Fri, 28 Jul 2023 07:39:17 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3s05jf0a5m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Jul 2023 07:39:17 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36S7dG0o007017;
        Fri, 28 Jul 2023 07:39:16 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3s05jf0a4q-1;
        Fri, 28 Jul 2023 07:39:16 +0000
From:   Harshvardhan Jha <harshvardhan.j.jha@oracle.com>
To:     stable@vger.kernel.org
Cc:     harshvardhan.j.jha@oracle.com, josef@toxicpanda.com,
        dsterba@suse.com, clm@fb.com
Subject: [PATCH 5.4 0/3] CVE-2023-1611 Kernel: race between quota disable and quota assign ioctls in fs/btrfs/ioctl.c 
Date:   Fri, 28 Jul 2023 00:39:11 -0700
Message-ID: <20230728073914.226947-1-harshvardhan.j.jha@oracle.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-27_10,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 adultscore=0 suspectscore=0 phishscore=0 malwarescore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307280069
X-Proofpoint-ORIG-GUID: htEqRE2dbJcyJqfFgYmtF3ccy4zGawkR
X-Proofpoint-GUID: htEqRE2dbJcyJqfFgYmtF3ccy4zGawkR
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

The following series is a backport the fix of CVE-2023-1611
on stable 5.4. All pics were clean and no conflict resolution was
needed.

Commits "btrfs: qgroup: remove one-time use variables for quota_root
checks" and "btrfs: qgroup: return ENOTCONN instead of EINVAL when
quotas are not enabled" were added to get a clean pick for the fix
"btrfs: fix race between quota disable and quota assign ioctls"

These changes have been tested using the xfstests test-suite and no regressions
were observed when compared to stable 5.4.

Filipe Manana (1):
  btrfs: fix race between quota disable and quota assign ioctls

Marcos Paulo de Souza (2):
  btrfs: qgroup: remove one-time use variables for quota_root checks
  btrfs: qgroup: return ENOTCONN instead of EINVAL when quotas are not
    enabled

 fs/btrfs/ioctl.c  |  2 ++
 fs/btrfs/qgroup.c | 55 +++++++++++++++++++++--------------------------
 2 files changed, 27 insertions(+), 30 deletions(-)

-- 
2.40.0

