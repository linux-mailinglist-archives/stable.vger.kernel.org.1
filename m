Return-Path: <stable+bounces-18854-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DE1784A163
	for <lists+stable@lfdr.de>; Mon,  5 Feb 2024 18:52:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAAC6284C9E
	for <lists+stable@lfdr.de>; Mon,  5 Feb 2024 17:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAE284594A;
	Mon,  5 Feb 2024 17:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="auUJnNCS"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 083C845946;
	Mon,  5 Feb 2024 17:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707155524; cv=none; b=eptfVD+fHgwarzxX2EvXXAQTZynJYEWFjesEd6JwftQ5ugPMxLst3Dl8pjDzSZ2kYP4Xoiw62RsYnHqkjnx4WtExl94Qsd1afZsnYy9SlppDkjEMV/CGJJYoZQkRaY568+1g3W7ifMb12uAPaP5plWNn3rukfcYU1qKVHbCIe7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707155524; c=relaxed/simple;
	bh=o6YQGQ9mCnD5CeZ5d8XhryUh6p2Fp1WJUm864lAKkRc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SrpRC6Vi7T4M3U5dqvXY0GHL30jadkRJVW1fJKfHT7cR9EK+ADqB3deTgBmMBnDIVCbDYiDnY0rIlY2Cb6cJvLSfV85D/e++gsh3jpWG6xxiLF8b62x26e+oybWkyAJlHyM4+gF1TfNWKTq6RgQpJzFYEFg6ezx7X0ZZLYhv5HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=auUJnNCS; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 415DVpO4023683;
	Mon, 5 Feb 2024 17:51:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-11-20;
 bh=QdS/NJuUSIfZ9VGtmcmbg7RieoHNF4qrJpxg8LxaPgw=;
 b=auUJnNCSMdgFnOBaRHuTZ89L/Pfi1RgzD8J4o+bnaZNEK8NN2xDUGz3VcTg4EGCPGS7q
 E5534BqobG2MLAebt/q8kzZtwlErO/N9zyTJDpmeSMnz75G1XRXmea+Up+HPoIOqJjdL
 L6MEir1g8yF5OckOph+WmmwnoHy+XQHfTaSYZWOb3bIi6tSamyuVsKboL3sM70T8QLt2
 g8r0EEZ+vFZMMkS9BIsPtdFzM6HeV1uBR4kJ1s/LkMUAJk1zv5UW9wJZaqe569VwUAkD
 tYByCtotbUyYReUNmCuLb84NiV5hUAAwzxy752LzX0uqldMCsaxv94vQ15nXxlOUX8aS 5A== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w1d3ucmt1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 05 Feb 2024 17:51:49 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 415HidXY038392;
	Mon, 5 Feb 2024 17:51:49 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3w1bx5u21q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 05 Feb 2024 17:51:49 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 415Hpkio033449;
	Mon, 5 Feb 2024 17:51:48 GMT
Received: from localhost.localdomain (dhcp-10-175-62-2.vpn.oracle.com [10.175.62.2])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3w1bx5u1vh-2;
	Mon, 05 Feb 2024 17:51:48 +0000
From: Vegard Nossum <vegard.nossum@oracle.com>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jani Nikula <jani.nikula@intel.com>, linux-doc@vger.kernel.org,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Justin Forbes <jforbes@fedoraproject.org>,
        Salvatore Bonaccorso <carnil@debian.org>, stable@vger.kernel.org
Subject: [PATCH 1/8] docs: kernel_feat.py: fix build error for missing files
Date: Mon,  5 Feb 2024 18:51:26 +0100
Message-Id: <20240205175133.774271-2-vegard.nossum@oracle.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240205175133.774271-1-vegard.nossum@oracle.com>
References: <20240205175133.774271-1-vegard.nossum@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-05_12,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 phishscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402050134
X-Proofpoint-ORIG-GUID: RGSHpv-Zp6TliSXiKI658_Tj6_M0MhYz
X-Proofpoint-GUID: RGSHpv-Zp6TliSXiKI658_Tj6_M0MhYz

If the directory passed to the '.. kernel-feat::' directive does not
exist or the get_feat.pl script does not find any files to extract
features from, Sphinx will report the following error:

    Sphinx parallel build error:
    UnboundLocalError: local variable 'fname' referenced before assignment
    make[2]: *** [Documentation/Makefile:102: htmldocs] Error 2

This is due to how I changed the script in c48a7c44a1d0 ("docs:
kernel_feat.py: fix potential command injection"). Before that, the
filename passed along to self.nestedParse() in this case was weirdly
just the whole get_feat.pl invocation.

We can fix it by doing what kernel_abi.py does -- just pass
self.arguments[0] as 'fname'.

Fixes: c48a7c44a1d0 ("docs: kernel_feat.py: fix potential command injection")
Cc: Justin Forbes <jforbes@fedoraproject.org>
Cc: Salvatore Bonaccorso <carnil@debian.org>
Cc: Jani Nikula <jani.nikula@intel.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: stable@vger.kernel.org
Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
---
 Documentation/sphinx/kernel_feat.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/sphinx/kernel_feat.py b/Documentation/sphinx/kernel_feat.py
index b9df61eb4501..03ace5f01b5c 100644
--- a/Documentation/sphinx/kernel_feat.py
+++ b/Documentation/sphinx/kernel_feat.py
@@ -109,7 +109,7 @@ class KernelFeat(Directive):
             else:
                 out_lines += line + "\n"
 
-        nodeList = self.nestedParse(out_lines, fname)
+        nodeList = self.nestedParse(out_lines, self.arguments[0])
         return nodeList
 
     def nestedParse(self, lines, fname):
-- 
2.34.1


