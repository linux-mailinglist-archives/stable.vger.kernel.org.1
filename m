Return-Path: <stable+bounces-76098-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 218099786BF
	for <lists+stable@lfdr.de>; Fri, 13 Sep 2024 19:29:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A0181C20FE4
	for <lists+stable@lfdr.de>; Fri, 13 Sep 2024 17:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 053B38289E;
	Fri, 13 Sep 2024 17:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="iCkSMpxS"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 515B21EEE4
	for <stable@vger.kernel.org>; Fri, 13 Sep 2024 17:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726248539; cv=none; b=nagmmuB3uKC4sX3A5RHBGP/rnruoFYebeugelzoNKZpgJYmOun3y+KRa2EpgzIsQtI2mCUi2tIvgkj8xj9JvfKzju+RIDyxdAM9sYKacE0tcmtB6sE0eoypx57zlwzxd+uSYnDoChwcAo16AjpTSi9IQZgqo+1jYogc6N5nTGwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726248539; c=relaxed/simple;
	bh=6SCoYvowv92Dj53wJCD6euhlEpB4iJI0VCV8S4gdqNI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kEgPT8P5oFTpK2Wggq3M0L6rdFRzDU6gjkDp09ciU0m3JENHMJuGyJbU7/rVnMBxqK5NKAjhBMWN6AvW52fBLrZ+KOO7jumbaQOQgkC9c8s5HSrxXuX8lNm28Zh/y7YubG2GRs2E79AEvQOQIIcEjoPMI5UXGZeu7O3nqw4M2tU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=iCkSMpxS; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48DGkgUr008400;
	Fri, 13 Sep 2024 17:28:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding; s=corp-2023-11-20; bh=uO3h/rBOng8LuP
	c1+hNDJLJ69j0neGxdQe8MruvFX7c=; b=iCkSMpxS8AMY6Bh6q1cgJsSocPjLtq
	nUdAWGax/1i0hCopzHFNHtskoYvkUpc/jwXSvWJpEuGGIqqJWNtB9akS4QKnS622
	eGA0lRaCUN2u4un1S9Lwzvc9k9W3ea93Aw5jOhSIjkjvDHDTNO5TbgkL7gJob+Gg
	cbVx9WzAwhmuPwHNZCcJfFJ/Uivft7nGYlSUEDvykJTOaijRLlUwaGpVOLHJf4Qz
	zzT4yY6sEs7b8UW+mxkMGn1YOk+0CPhkT06ZV9u5cvHqNIABCjWliVMdt4CP4iSv
	FzIzl5iIVeaQMI1ijXTwHFOtnsRVqyMzZf0SC4AuEM2D2DJZM9a3Ejnw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41gdrbe6t0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Sep 2024 17:28:54 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48DGvHu9033599;
	Fri, 13 Sep 2024 17:28:53 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41gd9cxdtt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Sep 2024 17:28:53 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 48DHSqwe023617;
	Fri, 13 Sep 2024 17:28:52 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 41gd9cxdtj-1;
	Fri, 13 Sep 2024 17:28:52 +0000
From: Samasth Norway Ananda <samasth.norway.ananda@oracle.com>
To: stable@vger.kernel.org
Cc: mhiramat@kernel.org, skhan@linuxfoundation.org, keescook@chromium.org,
        samasth.norway.ananda@oracle.com
Subject: [PATCH 5.4.y] selftests: breakpoints: Fix a typo of function name
Date: Fri, 13 Sep 2024 10:28:52 -0700
Message-ID: <20240913172852.3690929-1-samasth.norway.ananda@oracle.com>
X-Mailer: git-send-email 2.45.2
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
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 phishscore=0
 spamscore=0 malwarescore=0 adultscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2409130125
X-Proofpoint-ORIG-GUID: 3MrVoYS_VVQBrZ-7PBMSxugdqcETFW7H
X-Proofpoint-GUID: 3MrVoYS_VVQBrZ-7PBMSxugdqcETFW7H

From: Masami Hiramatsu <mhiramat@kernel.org>

commit 5b06eeae52c02dd0d9bc8488275a1207d410870b upstream.

Since commit 5821ba969511 ("selftests: Add test plan API to kselftest.h
and adjust callers") accidentally introduced 'a' typo in the front of
run_test() function, breakpoint_test_arm64.c became not able to be
compiled.

Remove the 'a' from arun_test().

Fixes: 5821ba969511 ("selftests: Add test plan API to kselftest.h and adjust callers")
Reported-by: Jun Takahashi <takahashi.jun_s@aa.socionext.com>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Kees Cook <keescook@chromium.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
[Samasth: bp to 5.4.y]
Signed-off-by: Samasth Norway Ananda <samasth.norway.ananda@oracle.com>
---
 tools/testing/selftests/breakpoints/breakpoint_test_arm64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/breakpoints/breakpoint_test_arm64.c b/tools/testing/selftests/breakpoints/breakpoint_test_arm64.c
index 58ed5eeab7094..ad41ea69001bc 100644
--- a/tools/testing/selftests/breakpoints/breakpoint_test_arm64.c
+++ b/tools/testing/selftests/breakpoints/breakpoint_test_arm64.c
@@ -109,7 +109,7 @@ static bool set_watchpoint(pid_t pid, int size, int wp)
 	return false;
 }
 
-static bool arun_test(int wr_size, int wp_size, int wr, int wp)
+static bool run_test(int wr_size, int wp_size, int wr, int wp)
 {
 	int status;
 	siginfo_t siginfo;
-- 
2.45.2


