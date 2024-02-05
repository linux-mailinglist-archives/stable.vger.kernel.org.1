Return-Path: <stable+bounces-18821-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB25F8497E5
	for <lists+stable@lfdr.de>; Mon,  5 Feb 2024 11:40:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 781EA285B0B
	for <lists+stable@lfdr.de>; Mon,  5 Feb 2024 10:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25D4E17572;
	Mon,  5 Feb 2024 10:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eM59Nmsn"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24331175B4
	for <stable@vger.kernel.org>; Mon,  5 Feb 2024 10:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707129616; cv=none; b=QYs2qR2gtWwb85H1bOZ665QUSK7z/e6ig5sxzBDrMehPy5PjF39zFykSun29cktKzGPguG+y3kfp7CpAr4ZDRxmyeYVUF3LyfSVVG+Vwv54qu5yV7NtXBrinpdihnAEz2jtmKgIgKa2SBbBM5eEYzSE+rS8cMdZxmalXNJkd/BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707129616; c=relaxed/simple;
	bh=LZ+ectrNy1WQhig0loqrq07Hh1s6oJ33PbC1M2sErIo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ikdoka2DkRa/DkiEhIDwHJbDYoTAa90xaBTOpuWH1pV9gsAZd1eqhNdEGrDbthCq+wYDJ/+3yB/UhgC5GI7VP24Qw2BXaTWIOuSTaqnc+kIozYnf6Qh+uzQQi+kJYjk7jBqaD9P54UNxR++psyGbye7FyJF6P9OPv8VIGZssQMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=eM59Nmsn; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4159OZVW005829;
	Mon, 5 Feb 2024 10:40:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-11-20;
 bh=kB97LssFl2YN4BXZKI5gv9CXMiBoEUSvx6yQWYwR1aw=;
 b=eM59NmsnfVMMhup8aPyM2FSW4Pb7K70n3qmQ2NiU85nggcBRLMAWK5kqFWhibXKodvQt
 to7UUPFiiWD3VlkbT8ppwajb5Hhh13VRwFHym6TfdaeUiyeNrZZiVzHhTqCzFM3HlGDP
 smU8ox1Ck2CzWz20Af0XD0lNpndyu3QDF7y7QPOxDu9TRk9v8/vmvpwIGJDRH3qcTd6s
 V/AERUQDBiAR6Be+3a9+AvzErGxuy5Cn8GucsjxPMZR4NQrddFlnCeTeUHbtGM3oBT6k
 X1NYWApvHQMv2D2u1Fgf1knjcb1IQkMe61/cAZEx2cD6dpN+bRfbldfuFF15lO5B6zme +w== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w1cdcumjd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 05 Feb 2024 10:40:08 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4158xdtL038305;
	Mon, 5 Feb 2024 10:40:07 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3w1bx5h9d5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 05 Feb 2024 10:40:07 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 415Ae7AT022135;
	Mon, 5 Feb 2024 10:40:07 GMT
Received: from t460-2.nl.oracle.com (dhcp-10-175-50-194.vpn.oracle.com [10.175.50.194])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3w1bx5h9ba-1;
	Mon, 05 Feb 2024 10:40:06 +0000
From: Vegard Nossum <vegard.nossum@oracle.com>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>, Jani Nikula <jani.nikula@intel.com>,
        Sasha Levin <sashal@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Justin Forbes <jforbes@fedoraproject.org>
Subject: [PATCH -stable] Documentation/arch/ia64/features.rst: fix kernel-feat directive
Date: Mon,  5 Feb 2024 11:39:59 +0100
Message-Id: <20240205103959.281871-1-vegard.nossum@oracle.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <6e02ac20-490a-48ff-9370-5e466cb740bb@oracle.com>
References: <6e02ac20-490a-48ff-9370-5e466cb740bb@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-05_06,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 mlxscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402050081
X-Proofpoint-GUID: HTim7QwhIa_VbDMPI6cYIdKjYvQsV0MQ
X-Proofpoint-ORIG-GUID: HTim7QwhIa_VbDMPI6cYIdKjYvQsV0MQ

My mainline commit c48a7c44a1d0 ("docs: kernel_feat.py: fix potential
command injection") contains a bug which can manifests like this when
building the documentation:

    Sphinx parallel build error:
    UnboundLocalError: local variable 'fname' referenced before assignment
    make[2]: *** [Documentation/Makefile:102: htmldocs] Error 2

However, this only appears when there exists a '.. kernel-feat::'
directive that points to a non-existent file, which isn't the case in
mainline.

When this commit was backported to stable 6.6, it didn't change
Documentation/arch/ia64/features.rst since ia64 was removed in 6.7 in
commit cf8e8658100d ("arch: Remove Itanium (IA-64) architecture"). This
lead to the build failure seen above -- but only in stable kernels.

This patch fixes the backport and should only be applied to kernels where
Documentation/arch/ia64/features.rst exists and commit c48a7c44a1d0 has
also been applied.

A second patch will follow to fix kernel_feat.py in mainline so that it
doesn't error out when the '.. kernel-feat::' directive points to a
nonexistent file.

Link: https://lore.kernel.org/all/ZbkfGst991YHqJHK@fedora64.linuxtx.org/
Fixes: e961f8c6966a ("docs: kernel_feat.py: fix potential command injection") # stable 6.6.15
Reported-by: Justin Forbes <jforbes@fedoraproject.org>
Reported-y: Salvatore Bonaccorso <carnil@debian.org>
Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
---
 Documentation/arch/ia64/features.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/arch/ia64/features.rst b/Documentation/arch/ia64/features.rst
index d7226fdcf5f8..056838d2ab55 100644
--- a/Documentation/arch/ia64/features.rst
+++ b/Documentation/arch/ia64/features.rst
@@ -1,3 +1,3 @@
 .. SPDX-License-Identifier: GPL-2.0
 
-.. kernel-feat:: $srctree/Documentation/features ia64
+.. kernel-feat:: features ia64
-- 
2.34.1


