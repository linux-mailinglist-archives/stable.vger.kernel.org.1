Return-Path: <stable+bounces-76110-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 113D597893D
	for <lists+stable@lfdr.de>; Fri, 13 Sep 2024 22:03:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6736AB2431E
	for <lists+stable@lfdr.de>; Fri, 13 Sep 2024 20:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C447D1482ED;
	Fri, 13 Sep 2024 20:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="C8PxRqfe"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E41E136E01
	for <stable@vger.kernel.org>; Fri, 13 Sep 2024 20:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726257805; cv=none; b=WgmXbZK6BzNf+o26dqEl9slDc1P8vJ4Y0IuTFY6QBKBkt3kzkHWpFvcqmnUKFdWiaZ0WDQ9aZm2/1klwWFVJgSvx0wSniR7E/3YTO/yQH1kamOnq7b9yeZD1invpD+3GrchU4GwNw4dOEW0iovQz4riMqzcZiPgSxSHggrdAch8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726257805; c=relaxed/simple;
	bh=zTpr9bSrq9lNkPCJn5gTWaO3PMU9ROXuGN/cb/J28uk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oejMtY6Uyi8dGcd61/QtB1QFQlmx+s5IAPlZhxJvsRaVvNzuOYXdxYudFwIfBq7Sx2H+vBz2J7ZJ46z87GrZhJKEzCV+qoF8Ec7F0YIoyT1ZKo5Reiyz3196A4qaavxX0j7LBRvWPBK3lrT6onlMHvfDd2Pamcq/o9m5cz9KXP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=C8PxRqfe; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48DJ0VeW032521;
	Fri, 13 Sep 2024 20:03:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=corp-2023-11-20; bh=2
	LDv0+zFsoviPRbO97G8B/u8txf4yx8vK7HlCOphBpA=; b=C8PxRqfeV0/EjZWTo
	LeGFGt8D9TkG2CovbYEY4SoOFDik6YCLNhl58zzBY3pnKxaxut//oSo4acYtBPbM
	lOMZNePEGx9vsDggo9DG9zm+UN+JobVRS380SnCb+3EkxcJpJRbXQ02+0E8MJaYJ
	JnWOP/Q4xi1/2sR7YiiP6UExnxZ+zAKxHzia7QW9TbKy/9JA4HVaGp+cPx5eZjen
	OQiPW4+DU8/dGHSW3k2b4jHGjdxeu3jYOyhDXo/vPM6/a4XZjkS0W358nHNjOedD
	3sS31aOKBHC9FECc4wbRbAnp2ROSJcTyAykkjiyDhYSdXYfuyDB++0Mv/Z1e5Eac
	7/rbg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41gdm2xjhe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Sep 2024 20:03:20 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48DJ4Kwp032470;
	Fri, 13 Sep 2024 20:03:20 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41gd9ke3td-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Sep 2024 20:03:20 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 48DK1HJR017052;
	Fri, 13 Sep 2024 20:03:19 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 41gd9ke3c9-2;
	Fri, 13 Sep 2024 20:03:19 +0000
From: Samasth Norway Ananda <samasth.norway.ananda@oracle.com>
To: stable@vger.kernel.org
Cc: gautammenghani201@gmail.com, skhan@linuxfoundation.org,
        usama.anjum@collabora.com, saeed.mirzamohammadi@oracle.com,
        samasth.norway.ananda@oracle.com
Subject: [PATCH 4.19 1/2] selftests/vm: remove call to ksft_set_plan()
Date: Fri, 13 Sep 2024 13:02:39 -0700
Message-ID: <20240913200249.4060165-2-samasth.norway.ananda@oracle.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240913200249.4060165-1-samasth.norway.ananda@oracle.com>
References: <20240913200249.4060165-1-samasth.norway.ananda@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-13_11,2024-09-13_02,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 spamscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409130142
X-Proofpoint-GUID: tQX6O0LXoGqq8fzQ5mCjfXbh1Hq0uXqC
X-Proofpoint-ORIG-GUID: tQX6O0LXoGqq8fzQ5mCjfXbh1Hq0uXqC

The function definition for ksft_set_plan() is not present in linux-4.19.y.
compaction_test selftest fails to compile because of this.

Fixes: 9a21701edc41 ("selftests/mm: conform test to TAP format output")
Signed-off-by: Samasth Norway Ananda <samasth.norway.ananda@oracle.com>
Reviewed-by: Saeed Mirzamohammadi <saeed.mirzamohammadi@oracle.com>
---
 tools/testing/selftests/vm/compaction_test.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/testing/selftests/vm/compaction_test.c b/tools/testing/selftests/vm/compaction_test.c
index e056cfc487e08..e7044fa7f0b70 100644
--- a/tools/testing/selftests/vm/compaction_test.c
+++ b/tools/testing/selftests/vm/compaction_test.c
@@ -183,8 +183,6 @@ int main(int argc, char **argv)
 	if (prereq() != 0)
 		return ksft_exit_pass();
 
-	ksft_set_plan(1);
-
 	lim.rlim_cur = RLIM_INFINITY;
 	lim.rlim_max = RLIM_INFINITY;
 	if (setrlimit(RLIMIT_MEMLOCK, &lim))
-- 
2.45.2


