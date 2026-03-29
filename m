Return-Path: <stable+bounces-230880-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6OMcA10KyWm5tgUAu9opvQ
	(envelope-from <stable+bounces-230880-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 13:17:49 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AFD9351C54
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 13:17:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A605B3033FB4
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 11:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7909C35B127;
	Sun, 29 Mar 2026 11:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=me.com header.i=@me.com header.b="CHKzYgb+"
X-Original-To: stable@vger.kernel.org
Received: from outbound.pv.icloud.com (p-west1-cluster4-host9-snip4-5.eps.apple.com [57.103.65.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F3A35AC13
	for <stable@vger.kernel.org>; Sun, 29 Mar 2026 11:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.65.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774783036; cv=none; b=JS8YwHh90Cq+O8R+cqyYJN4lmM7aLhPTYLUc7CQsg0dzDa7NuYTWnFc01yzljS2fHJ38Xq4BPTHmDZIHgv0V2qJqabVgMsFvwuyRykwmLZuVHTGv7CJFwtcG5q5uVRqCafkN7Muz6enLTBvefefzoZ27O78Xt22j0kofBPeY8uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774783036; c=relaxed/simple;
	bh=DR7JoByo08xdXJ+b32EeAwmU8I/EVik4CMJs3yRDnJo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U0VWu4sEfL6JKBP73MTdhKy7ZoxcLX3SY+n7EK9KMW0+fYK93T8P+Jxq7gKfW+GOJNGiLAAP9Ax/uu3Ng7Z18bXG1gTGaiZEfwrNCRcik1ymr9Y5YOiCxSHRrCWHKMbgWmkrvWJPvgS4J0ELO0Vnnc1z2RmxqaYPpkyC1U1xq3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=me.com; spf=pass smtp.mailfrom=me.com; dkim=pass (2048-bit key) header.d=me.com header.i=@me.com header.b=CHKzYgb+; arc=none smtp.client-ip=57.103.65.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=me.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=me.com
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-west-1a-60-percent-4 (Postfix) with ESMTPS id C81681800119;
	Sun, 29 Mar 2026 11:17:12 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai; t=1774783034; x=1777375034; bh=EMSyBTg5DLvD9v5zV+TTuvPW0ePpK+nqI/lJGNNnFdY=; h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme; b=CHKzYgb+4cXBxcEbWRIjd9ctXu1IVlzxNlN8EQj5mAvM0PqctO7alUx+7g1Ejp7AChMaGqqV5xXjLfoDMl3V+TDGMDVP+TD70+AeGBjLujglVaJEQ/OjMko6KiBvWWIxvOCCDp4X5PUZdMPw+X6Uc4RRMe7d7acgtPgIfx+wjVOXty3CCZAv+S0AQ4xh+5Zx0P7ap41f66ROfj+1l+hxXbuKJ82fSrrj17vBvgl2ERBJr/uk9GadJdswwkhyF87TgbWlBdrGkT7TOK/3miQQo4OMhKEBmXdztbLE2r/ezxDnoGG0p3Pll0FfDL8f6eTlp4VCrjEn2okOVxf57TSj+A==
Received: from bimmer.. (unknown [17.56.9.36])
	by p00-icloudmta-asmtp-us-west-1a-60-percent-4 (Postfix) with ESMTPSA id AC5D818000A4;
	Sun, 29 Mar 2026 11:17:10 +0000 (UTC)
From: tobgaertner <tob.gaertner@me.com>
To: almaz.alexandrovich@paragon-software.com
Cc: ntfs3@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	security@kernel.org,
	Tobias Gaertner <tob.gaertner@me.com>
Subject: [PATCH 1/2] ntfs3: add buffer boundary checks to run_unpack()
Date: Sun, 29 Mar 2026 04:17:02 -0700
Message-ID: <20260329111704.411449-2-tob.gaertner@me.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260329111704.411449-1-tob.gaertner@me.com>
References: <20260329111704.411449-1-tob.gaertner@me.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI5MDA4NyBTYWx0ZWRfX0RaNyda6sDu9
 BfwZzMSLhYlylaVpkfTbAnzkJ1s3Cpx71T8ptxcVy+aZdzFtC/gVRkEDHTcxaen9EC2smsnSava
 65fo2C83rYW0E9NNYkJR3LHUY/0DIZDLTDKXwDeYUzyeVY28AmrhfFrk64PP/h9KLckr9o5kp7D
 yGh65Cyefe0v0mpVnqOrTtgr2lKor4+NrttZAKTavgyMxsiOltqYkPbA9morHA6p+rFMhL76S4r
 A/hkbwBaFOvByJEpWgXOJQ8z/+0ayC3VnGsiJFNOz3np49WHXv4npqQfHh4y2izo20NoYwLE4kw
 E9t28oTi3g51NcbxEZe6/oC1yefAEdq8TDX/Yfh8hE29Uufu9NotizKNq+W/4M=
X-Proofpoint-ORIG-GUID: SSA5ZdeOsFDCQEW2U_ZYnHsX8CLraIsC
X-Authority-Info-Out: v=2.4 cv=BNy+bVQG c=1 sm=1 tr=0 ts=69c90a39
 cx=c_apl:c_pps:t_out a=azHRBMxVc17uSn+fyuI/eg==:117
 a=azHRBMxVc17uSn+fyuI/eg==:17 a=Yq5XynenixoA:10 a=x7bEGLp0ZPQA:10
 a=C3-SEi6G3EkA:10 a=VkNPw1HP01LnGYTKEx00:22 a=HHGDD-5mAAAA:8 a=VwQbUJbxAAAA:8
 a=jGwXaaXTPOOXkIRyr48A:9
X-Proofpoint-GUID: SSA5ZdeOsFDCQEW2U_ZYnHsX8CLraIsC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-29_03,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 spamscore=0 lowpriorityscore=0 mlxscore=0 phishscore=0 malwarescore=0
 clxscore=1015 suspectscore=0 bulkscore=0 adultscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603290087
X-Apple-Category-Label: Mjg5MDYwMTc4OiRjYXRlZ29yeSRfUGVyc29uYWws
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[me.com,quarantine];
	R_DKIM_ALLOW(-0.20)[me.com:s=1a1hai];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[me.com];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,kernel.org,me.com];
	TAGGED_FROM(0.00)[bounces-230880-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tob.gaertner@me.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[me.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,me.com:dkim,me.com:email,me.com:mid]
X-Rspamd-Queue-Id: 6AFD9351C54
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Tobias Gaertner <tob.gaertner@me.com>

run_unpack() checks `run_buf < run_last` at the top of the while loop
but then reads size_size and offset_size bytes via run_unpack_s64()
without verifying they fit within the remaining buffer.  A crafted NTFS
image with truncated run data in an MFT attribute triggers an OOB heap
read of up to 15 bytes when the filesystem is mounted.

Add boundary checks before each run_unpack_s64() call to ensure the
declared field size does not exceed the remaining buffer.

Found by fuzzing with a source-patched harness (LibAFL + QEMU).

Fixes: 82cae269cfa95 ("fs/ntfs3: Add initialization of super block")
Cc: stable@vger.kernel.org
Signed-off-by: Tobias Gaertner <tob.gaertner@me.com>
---
 fs/ntfs3/run.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/ntfs3/run.c b/fs/ntfs3/run.c
index 395b20492..c3c6917fa 100644
--- a/fs/ntfs3/run.c
+++ b/fs/ntfs3/run.c
@@ -970,6 +970,9 @@ int run_unpack(struct runs_tree *run, struct ntfs_sb_info *sbi, CLST ino,
 		if (size_size > sizeof(len))
 			return -EINVAL;
 
+		if (run_buf + size_size > run_last)
+			return -EINVAL;
+
 		len = run_unpack_s64(run_buf, size_size, 0);
 		/* Skip size_size. */
 		run_buf += size_size;
@@ -982,6 +985,9 @@ int run_unpack(struct runs_tree *run, struct ntfs_sb_info *sbi, CLST ino,
 		else if (offset_size <= sizeof(s64)) {
 			s64 dlcn;
 
+			if (run_buf + offset_size > run_last)
+				return -EINVAL;
+
 			/* Initial value of dlcn is -1 or 0. */
 			dlcn = (run_buf[offset_size - 1] & 0x80) ? (s64)-1 : 0;
 			dlcn = run_unpack_s64(run_buf, offset_size, dlcn);
-- 
2.43.0


