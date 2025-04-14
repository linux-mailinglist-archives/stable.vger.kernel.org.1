Return-Path: <stable+bounces-132664-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E274A88BBC
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 20:50:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E92C3189ACD1
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 18:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1B9C1AF0BF;
	Mon, 14 Apr 2025 18:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kXPhaAsq"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED2EB23D285
	for <stable@vger.kernel.org>; Mon, 14 Apr 2025 18:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744656654; cv=none; b=jlb/vkPg3i0DwAIBKi74KfTNPkBJGYlMZkDVS7nL9Vq+i8csU88sxIcoG+Nc6OiMESb5zXCqTTBKWpg2MCQ8rDPEayheimJjTfLmOU/MST1eLB2+rO7rzZNqvT5lOKOp9I47gcPng+TDKszE3UazPQZj7/KQ4ux5N4UMTTHPLvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744656654; c=relaxed/simple;
	bh=9S/kiGaBrFdlFmjrporD1TD7nHuW4YlMPk8L/T+cVAU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mQUVgjrpmJ9hakUCMsgwcWbBmOkc4Ao//3/xruIH6mm+R07KOIUWgTdxtZNL1QJ044Suj/RavpEWjdHJ1Jx4CgDgvc59wue4MxAaqDWU0oMA5i+G3k3mDHM+8dKEw4atRrjz/dIwJbA8xXKE/IiOJImPPzAHlouFgdVdokvMUxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kXPhaAsq; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53EIMYoS021050;
	Mon, 14 Apr 2025 18:50:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2023-11-20; bh=IyPDy
	Y2HJJRkZZEVvveto4vmZMZrVy207aDxWNJoREE=; b=kXPhaAsqxHlIaGlait5oo
	yucSJFA1pioHIfmQbq3kuSZMbDhi35n4lNDN8D/SOaJ/VGyUhhf25FlmvI5jvUn3
	wnqVlcsJx3S/qFUH5CTLMt0F80rEzLj3Gq1Uy+ETMPaEpDKD7tNrDynB6xzZD0Y1
	sjV7PfPp3NywxsgCw8pZqN3W+s0K7Xuu4mFJj9scLKpQJpD6EtxoFltlmZ9jGE5J
	TS+qJnGxigKkCMOVQ2a2rOVE8x2RjWqdUo78qwuRM/dBk4MXWia1IDE18sLECHuU
	EloFMxuZOuESZKLnZrj/2EE8YmENRJ5VGaqoIF4JfuzQ2KqK6G/genu1cmt29Vb5
	w==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4617ju81ug-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Apr 2025 18:50:47 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53EHlKdG024679;
	Mon, 14 Apr 2025 18:50:46 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 460d4y5fcq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Apr 2025 18:50:46 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 53EIoUHK035509;
	Mon, 14 Apr 2025 18:50:46 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 460d4y5f48-6;
	Mon, 14 Apr 2025 18:50:46 +0000
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To: stable@vger.kernel.org
Cc: vegard.nossum@oracle.com,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: [PATCH 5.15.y 5/6] filemap: Fix bounds checking in filemap_read()
Date: Mon, 14 Apr 2025 11:50:22 -0700
Message-ID: <20250414185023.2165422-6-harshit.m.mogalapalli@oracle.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250414185023.2165422-1-harshit.m.mogalapalli@oracle.com>
References: <20250414185023.2165422-1-harshit.m.mogalapalli@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-14_07,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2504140137
X-Proofpoint-GUID: vuwLEo8VHX9UXuGquieDq12xs4ro0ENH
X-Proofpoint-ORIG-GUID: vuwLEo8VHX9UXuGquieDq12xs4ro0ENH

From: Trond Myklebust <trond.myklebust@hammerspace.com>

[ Upstream commit ace149e0830c380ddfce7e466fe860ca502fe4ee ]

If the caller supplies an iocb->ki_pos value that is close to the
filesystem upper limit, and an iterator with a count that causes us to
overflow that limit, then filemap_read() enters an infinite loop.

This behaviour was discovered when testing xfstests generic/525 with the
"localio" optimisation for loopback NFS mounts.

Reported-by: Mike Snitzer <snitzer@kernel.org>
Fixes: c2a9737f45e2 ("vfs,mm: fix a dead loop in truncate_inode_pages_range()")
Tested-by: Mike Snitzer <snitzer@kernel.org>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
(cherry picked from commit ace149e0830c380ddfce7e466fe860ca502fe4ee)
[Harshit: Minor conflict resolved due to missing commit: 25d6a23e8d28
("filemap: Convert filemap_get_read_batch() to use a folio_batch") in
5.15.y]
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
 mm/filemap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index c71e86c12418..cc86c5a127b9 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2617,7 +2617,7 @@ ssize_t filemap_read(struct kiocb *iocb, struct iov_iter *iter,
 	if (unlikely(!iov_iter_count(iter)))
 		return 0;
 
-	iov_iter_truncate(iter, inode->i_sb->s_maxbytes);
+	iov_iter_truncate(iter, inode->i_sb->s_maxbytes - iocb->ki_pos);
 	pagevec_init(&pvec);
 
 	do {
-- 
2.47.1


