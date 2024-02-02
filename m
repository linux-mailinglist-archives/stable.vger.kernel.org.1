Return-Path: <stable+bounces-17656-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FDEB84669A
	for <lists+stable@lfdr.de>; Fri,  2 Feb 2024 04:46:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D29B3B23EB4
	for <lists+stable@lfdr.de>; Fri,  2 Feb 2024 03:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BEA6C2CF;
	Fri,  2 Feb 2024 03:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UWWqHXrH"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F17EE541
	for <stable@vger.kernel.org>; Fri,  2 Feb 2024 03:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706845561; cv=none; b=gVP6leZJtrXCTrQXQhZlybi2g9DgmvpvzMQR7YhAOfvQ4rGLjlgXjoBSVVw7/Q17DKCwxzWhHmAHKhZCXlMnKHcl5QUltreFiVyE2aKdmJbv0daFsWb+WNReDLunaoP/ahlzT1amJtqVSwCovweYypeOLlZYZsSrbm+BD6yNCV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706845561; c=relaxed/simple;
	bh=RlqEQSvAE9uSPTVPHf2S8+flCwEfHuIuHr04AbG9uuw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uhOIlfT2ewtgts90tTva41m13yoGJxm2QAS3FQX8eQPVi+D1KvoC+EdPDHCc2Lx5MIP3MfnUFss8/C0NXN+LfE3o57MLFiYny80p7uGc072HwYxyjHXtHhj2/KQGnT6vwnpO0r60KOZyVqc5BOfb4w+3s72VMesGP8iVc6gEArE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UWWqHXrH; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4120k5eB000479;
	Fri, 2 Feb 2024 03:45:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-11-20; bh=9MkqDURYi9MQXjLvnhM3uOYw2+rtD6jKj+8FGMYFXf4=;
 b=UWWqHXrH0k9jrywdgGmKIESwsb0Zyxzq7Q3ixn48yIpPUbbECh/OjgUX+ONytqFEak8M
 RVkkoPal03n4gjIOLke0qWusDG2ruEG+s5gAb+LiCxj3CktcRIt1tjuKq/xjh7+vOOLZ
 OTV/fkNynmU6ZlCwGE+Ifnege/phxdlrjKqqxEeKTwiAnt/+pkVnLAnkeEjFfS3LN5cm
 +/YDPNUdRnU7F3AH5dq99zIKtUZ9Gh/zs3RCymg/Gu8pewUYi+9I1EgpfKLx7tNpkgF6
 B9YV9k/P9sRXX1HeIqZ4JT2aiQgGTNBv4Q/Fz6FShs124hw/qdbemriuoVQbew/8LlUH Wg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vvtcv6kf3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 02 Feb 2024 03:45:48 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4123JKk6011726;
	Fri, 2 Feb 2024 03:45:47 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3vvr9b98ek-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 02 Feb 2024 03:45:47 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4123jlBe009975;
	Fri, 2 Feb 2024 03:45:47 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3vvr9b98e0-1;
	Fri, 02 Feb 2024 03:45:47 +0000
From: Samasth Norway Ananda <samasth.norway.ananda@oracle.com>
To: stable@vger.kernel.org
Cc: samasth.norway.ananda@oracle.com, harshit.m.mogalapalli@oracle.com,
        yonghong.song@linux.dev, ast@kernel.org
Subject: [PATCH  6.6.y] selftests/bpf: Remove flaky test_btf_id test
Date: Thu,  1 Feb 2024 19:45:45 -0800
Message-ID: <20240202034545.3143734-1-samasth.norway.ananda@oracle.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-01_10,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 malwarescore=0
 suspectscore=0 phishscore=0 mlxscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402020024
X-Proofpoint-ORIG-GUID: -YX2o3pXbmT8N97r7PAP0L9ymZkeIB0g
X-Proofpoint-GUID: -YX2o3pXbmT8N97r7PAP0L9ymZkeIB0g

From: Yonghong Song <yonghong.song@linux.dev>

[ Upstream commit 56925f389e152dcb8d093435d43b78a310539c23 ]

With previous patch, one of subtests in test_btf_id becomes
flaky and may fail. The following is a failing example:

  Error: #26 btf
  Error: #26/174 btf/BTF ID
    Error: #26/174 btf/BTF ID
    btf_raw_create:PASS:check 0 nsec
    btf_raw_create:PASS:check 0 nsec
    test_btf_id:PASS:check 0 nsec
    ...
    test_btf_id:PASS:check 0 nsec
    test_btf_id:FAIL:check BTF lingersdo_test_get_info:FAIL:check failed: -1

The test tries to prove a btf_id not available after the map is closed.
But btf_id is freed only after workqueue and a rcu grace period, compared
to previous case just after a rcu grade period.
Depending on system workload, workqueue could take quite some time
to execute function bpf_map_free_deferred() which may cause the test failure.
Instead of adding arbitrary delays, let us remove the logic to
check btf_id availability after map is closed.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
Link: https://lore.kernel.org/r/20231214203820.1469402-1-yonghong.song@linux.dev
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
[Samasth: backport for 6.6.y]
Signed-off-by: Samasth Norway Ananda <samasth.norway.ananda@oracle.com>
---
Above patch is a fix for 59e5791f59dd ("bpf: Fix a race condition between 
btf_put() and map_free()"). While the commit causing the error is
present in 6.6.y the fix is not present. 
---
 tools/testing/selftests/bpf/prog_tests/btf.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/btf.c b/tools/testing/selftests/bpf/prog_tests/btf.c
index 92d51f377fe5..0c0881c7eb1a 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf.c
@@ -4630,11 +4630,6 @@ static int test_btf_id(unsigned int test_num)
 	/* The map holds the last ref to BTF and its btf_id */
 	close(map_fd);
 	map_fd = -1;
-	btf_fd[0] = bpf_btf_get_fd_by_id(map_info.btf_id);
-	if (CHECK(btf_fd[0] >= 0, "BTF lingers")) {
-		err = -1;
-		goto done;
-	}
 
 	fprintf(stderr, "OK");
 
-- 
2.42.0


