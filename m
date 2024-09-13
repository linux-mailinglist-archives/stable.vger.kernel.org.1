Return-Path: <stable+bounces-76111-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D247797893B
	for <lists+stable@lfdr.de>; Fri, 13 Sep 2024 22:03:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 991DC284F1B
	for <lists+stable@lfdr.de>; Fri, 13 Sep 2024 20:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAACD145FF9;
	Fri, 13 Sep 2024 20:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="B/VmNyzs"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECBDE126F2A
	for <stable@vger.kernel.org>; Fri, 13 Sep 2024 20:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726257806; cv=none; b=RSgbGqQBzK8gFYeJ8NSsM0GQ3fSowlkwRHUIG7ACESM4F5LfFhsR3o2aKS/+itmF6jSyxK/NAgYMTHaaGpiICVLXMy1jE2MdvOO9cs3hRlaW7wvkWgDqRFP0L+i90Qn+hfpH9tLZPzUKgiGZlHYji1wXo21ceKKjzG13zDMY6T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726257806; c=relaxed/simple;
	bh=hhgvm5UVniyhx0lOjjvc1VC7sFM3yabw9FztIhCJHXw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e4aambW9fpXprewC/uRnwKW4bghdXMRNec3L8Q1o0ecsBO+RWgCE6HMJKMYaFNEO0vwNO+3d+4WtNS0Uo83ZWRRNBsBU535d/q9QWjRl9pIvUFqvC+49pWnFetcj/CP98habRTC57BoIe+2heJLeDoh7heg4qoMYM/H2iTxgCI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=B/VmNyzs; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48DJ0sTr006196;
	Fri, 13 Sep 2024 20:03:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=corp-2023-11-20; bh=D
	F8depKgCmgm/ddS/e0mYsXqkIQC+VBcKBqNJiXQ+dw=; b=B/VmNyzs0vn/RPxJD
	SJgf5kHW8ir6lWvI5iS4i3LQerxUs+ymzOnvV/FyXMFVXzWzgmaaa5wqWMkhpqgv
	JiQ1eRt0IEshycT50UIPhf6Smvizt4Z1YlLpuaEOAJfQbYnENEu267jDLVzH/DGE
	zNhJQ8EjNFtpqhy59W/pEqsdc1lL0XleMmk7oJZNhsEjl4WQvOUK3FfL2lpuTZIS
	Z34ndxAoMnq9HWwGG2t8GL74hAdnGUmwuqWRY5jzjZ4ICVgCOLj0LYjek+2ofjf4
	VLaOfIm7Q90GKISazNGDUKQoXW00J/MEDI1BBXvRQNTGmpciFfTX1gKkGyldrnZ0
	TIkbg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41gevcxksd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Sep 2024 20:03:21 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48DIc9xh033168;
	Fri, 13 Sep 2024 20:03:21 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41gd9ke3tq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Sep 2024 20:03:21 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 48DK1HJT017052;
	Fri, 13 Sep 2024 20:03:20 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 41gd9ke3c9-3;
	Fri, 13 Sep 2024 20:03:20 +0000
From: Samasth Norway Ananda <samasth.norway.ananda@oracle.com>
To: stable@vger.kernel.org
Cc: gautammenghani201@gmail.com, skhan@linuxfoundation.org,
        usama.anjum@collabora.com, saeed.mirzamohammadi@oracle.com,
        samasth.norway.ananda@oracle.com
Subject: [PATCH 4.19 2/2] selftests/kcmp: remove call to ksft_set_plan()
Date: Fri, 13 Sep 2024 13:02:40 -0700
Message-ID: <20240913200249.4060165-3-samasth.norway.ananda@oracle.com>
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
X-Proofpoint-ORIG-GUID: n8nWv7WpYWv3ixtdT8sSpWcaDzNjyh_w
X-Proofpoint-GUID: n8nWv7WpYWv3ixtdT8sSpWcaDzNjyh_w

The function definition for ksft_set_plan() is not present in linux-4.19.y.
kcmp_test selftest fails to compile because of this.

Fixes: 32b0469d13eb ("selftests/kcmp: Make the test output consistent and clear")
Signed-off-by: Samasth Norway Ananda <samasth.norway.ananda@oracle.com>
Reviewed-by: Saeed Mirzamohammadi <saeed.mirzamohammadi@oracle.com>
---
 tools/testing/selftests/kcmp/kcmp_test.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/kcmp/kcmp_test.c b/tools/testing/selftests/kcmp/kcmp_test.c
index d7a8e321bb16b..60305f858c48d 100644
--- a/tools/testing/selftests/kcmp/kcmp_test.c
+++ b/tools/testing/selftests/kcmp/kcmp_test.c
@@ -89,7 +89,6 @@ int main(int argc, char **argv)
 		int ret;
 
 		ksft_print_header();
-		ksft_set_plan(3);
 
 		fd2 = open(kpath, O_RDWR);
 		if (fd2 < 0) {
-- 
2.45.2


