Return-Path: <stable+bounces-178946-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83863B497CA
	for <lists+stable@lfdr.de>; Mon,  8 Sep 2025 20:01:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 404554E08ED
	for <lists+stable@lfdr.de>; Mon,  8 Sep 2025 18:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EF7F201266;
	Mon,  8 Sep 2025 18:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kNDMwXAJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C333A145B16
	for <stable@vger.kernel.org>; Mon,  8 Sep 2025 18:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757354514; cv=none; b=K/SGSbKBfFwrq+q0ri3uScngcipUZGoftszmQ1c/DB4b23dV9r0A3kJlgXl0VJos+fCuVJmEkW9rbEhruyydrx3uf04X7wkD/6DKi3xEkJa0eWSR5Mye1WBKLmUno0HCvLa4hVO9dJY7ExhH6qZ1QlM9pSyLrc9rLH2beYLvQ1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757354514; c=relaxed/simple;
	bh=4thEBXIa4uUqL/v7E2V1NhZ3Ku7M+ncqan2REiybOR4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tz38PumWfoM5zLOrIzUb/80JwkYd/NeQnJ5WtHuRyz4UYSfeXzYT7mEdLbsc3arlf2kCxG3QUno3UkT4z+XJvxomUvY1Wup1jqtDdQu75CQH01NGRNkBJs5ug4gRG1OULgDMyB7ohJPQUuUmSz0LMbmb0fw41ynukXUa0WhLegs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kNDMwXAJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA030C4CEF1;
	Mon,  8 Sep 2025 18:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757354514;
	bh=4thEBXIa4uUqL/v7E2V1NhZ3Ku7M+ncqan2REiybOR4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kNDMwXAJHL19y/A4mdy9aAJ2zDUG3EdYd5iWJiB4pitncnIor+jE5IN/iw4/7x9ZS
	 hxzqEKhDzqJ2DXifpw7f1AcdkU3u0QA/ubSK+muXn8FkdpuxjjU/haHgS5ck5KLycl
	 59vDqEZrIzr/uQS8q8HefWdBYB3QPWV2GcXfOWC1j9Hc13UKQIJ0VJFvvsD5PDCsuY
	 RruI9i4/jNhQChSICGLGYssFNWJz1+dOhVqLiCZfTIOA4l+BTJ1WzWbxcYPlV8mSUO
	 c1gi/qmz9WQ6bQjR/fDkJyaQT4QO0yDN4YqzTaFO1P6gwA/9bjCP/LxuR4mSwDQwVp
	 BMJ8AIv4cPz1A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mimi Zohar <zohar@linux.ibm.com>,
	Stefan Berger <stefanb@linux.ibm.com>,
	Petr Vorel <pvorel@suse.cz>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] ima: limit the number of ToMToU integrity violations
Date: Mon,  8 Sep 2025 14:01:51 -0400
Message-ID: <20250908180151.1333407-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025041739-props-huff-8deb@gregkh>
References: <2025041739-props-huff-8deb@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mimi Zohar <zohar@linux.ibm.com>

[ Upstream commit a414016218ca97140171aa3bb926b02e1f68c2cc ]

Each time a file in policy, that is already opened for read, is opened
for write, a Time-of-Measure-Time-of-Use (ToMToU) integrity violation
audit message is emitted and a violation record is added to the IMA
measurement list.  This occurs even if a ToMToU violation has already
been recorded.

Limit the number of ToMToU integrity violations per file open for read.

Note: The IMA_MAY_EMIT_TOMTOU atomic flag must be set from the reader
side based on policy.  This may result in a per file open for read
ToMToU violation.

Since IMA_MUST_MEASURE is only used for violations, rename the atomic
IMA_MUST_MEASURE flag to IMA_MAY_EMIT_TOMTOU.

Cc: stable@vger.kernel.org # applies cleanly up to linux-6.6
Tested-by: Stefan Berger <stefanb@linux.ibm.com>
Reviewed-by: Petr Vorel <pvorel@suse.cz>
Tested-by: Petr Vorel <pvorel@suse.cz>
Reviewed-by: Roberto Sassu <roberto.sassu@huawei.com>
Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
[ adapted IMA flag definitions location from ima.h to integrity.h ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 security/integrity/ima/ima_main.c | 16 +++++++++++-----
 security/integrity/integrity.h    |  3 ++-
 2 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 068edb0d79f73..3b734a4dfcbe4 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -128,16 +128,22 @@ static void ima_rdwr_violation_check(struct file *file,
 		if (atomic_read(&inode->i_readcount) && IS_IMA(inode)) {
 			if (!iint)
 				iint = integrity_iint_find(inode);
+
 			/* IMA_MEASURE is set from reader side */
-			if (iint && test_bit(IMA_MUST_MEASURE,
-						&iint->atomic_flags))
+			if (iint && test_and_clear_bit(IMA_MAY_EMIT_TOMTOU,
+						       &iint->atomic_flags))
 				send_tomtou = true;
 		}
 	} else {
 		if (must_measure)
-			set_bit(IMA_MUST_MEASURE, &iint->atomic_flags);
-		if (inode_is_open_for_write(inode) && must_measure)
-			send_writers = true;
+			set_bit(IMA_MAY_EMIT_TOMTOU, &iint->atomic_flags);
+
+		/* Limit number of open_writers violations */
+		if (inode_is_open_for_write(inode) && must_measure) {
+			if (!test_and_set_bit(IMA_EMITTED_OPENWRITERS,
+					      &iint->atomic_flags))
+				send_writers = true;
+		}
 	}
 
 	if (!send_tomtou && !send_writers)
diff --git a/security/integrity/integrity.h b/security/integrity/integrity.h
index ad20ff7f5dfaa..a007edae938ae 100644
--- a/security/integrity/integrity.h
+++ b/security/integrity/integrity.h
@@ -74,7 +74,8 @@
 #define IMA_UPDATE_XATTR	1
 #define IMA_CHANGE_ATTR		2
 #define IMA_DIGSIG		3
-#define IMA_MUST_MEASURE	4
+#define IMA_MAY_EMIT_TOMTOU	4
+#define IMA_EMITTED_OPENWRITERS	5
 
 enum evm_ima_xattr_type {
 	IMA_XATTR_DIGEST = 0x01,
-- 
2.51.0


