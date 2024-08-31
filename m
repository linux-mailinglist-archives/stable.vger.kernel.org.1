Return-Path: <stable+bounces-71694-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10C2F967299
	for <lists+stable@lfdr.de>; Sat, 31 Aug 2024 18:09:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42BE31C2133A
	for <lists+stable@lfdr.de>; Sat, 31 Aug 2024 16:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDA613AC01;
	Sat, 31 Aug 2024 16:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kvMX/Gb2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C99F18E11
	for <stable@vger.kernel.org>; Sat, 31 Aug 2024 16:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725120560; cv=none; b=DEC1oxa6QcBArV/d/qwSLwz4uncItJ6l+qmv1UBhBNGIJ94goMjBkZ3IhyPGGUiyFozqO5O+QlBhge7XuHv2gTvg6evQb06iOLXw+w+tG1iejAWcApK4FkgtSsY8iln4eNykFqK4mo6ifxJBuFj7+YGBQoMhXaarxO6yizbVb50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725120560; c=relaxed/simple;
	bh=Gk8KgWX+EdkfNPYuJfuWOoSMFyo4gdFFddlg/COYXCE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SdofMKCglGJ6W2g8xaO6xuHYIK9b1e/NGE2fez7xUGLPpAjDIejLSBVgbGGVL5S1SIJ6/R+c5Rg3LWESOEWZHDsTglWn0g/7rbRaSNIxxDv2IwdtLx8uf6eGH6cn3pkJxfgWRSqjL7u5NLz0xVF/jApks2oOCPIAGDRoqomJaq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kvMX/Gb2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 888E1C4CEC0;
	Sat, 31 Aug 2024 16:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725120560;
	bh=Gk8KgWX+EdkfNPYuJfuWOoSMFyo4gdFFddlg/COYXCE=;
	h=From:To:Cc:Subject:Date:From;
	b=kvMX/Gb2uMb26OUTNXP6VMopLkeqcieayIRAZeJHZSmk6O9x3ejFY+saT0HdeXqnb
	 vr/H6qzlOPBwpoz77VxF10/EeKe+PcsDCQpKr50tZcuyQKWQb2rTvIlTAKIgACk3MI
	 Y5xBoS1G+c9XCJmixDubEpIbe+T9DxBT0e4EtexfcswuQYNvDg3zZSKfpz0S92XfOV
	 icwOe7hjmIHBuWTbWsTOSQ8q+aMUyF1+aN1HPfCzy5eWA6Zwj4dfLMQAfm3WSK+YXK
	 POu4ywtZICbXKVzcbyKFR2fH7wIwg0fJ/xdJmxdTwqAeAT32gaFHjXPPpQqxlrzzR0
	 WvBR2lRjgKgiQ==
From: cel@kernel.org
To: <ltp@lists.linux.it>
Cc: Amir Goldstein <amir73il@gmail.com>,
	Petr Vorel <pvorel@suse.cz>,
	<stable@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH RFC] syscalls/fanotify09: Note backport of commit e730558adffb
Date: Sat, 31 Aug 2024 12:09:00 -0400
Message-ID: <20240831160900.173809-1-cel@kernel.org>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

I backported commit e730558adffb ("fsnotify: consistent behavior for
parent not watching children") to v5.15.y and v5.10.y. Update
fanotify09 to test older LTS kernels containing that commit.

Suggested-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 testcases/kernel/syscalls/fanotify/fanotify09.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

Untested.

diff --git a/testcases/kernel/syscalls/fanotify/fanotify09.c b/testcases/kernel/syscalls/fanotify/fanotify09.c
index f61c4e45a88c..48b198b9415a 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify09.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify09.c
@@ -29,7 +29,6 @@
  *      7372e79c9eb9 fanotify: fix logic of reporting name info with watched parent
  *
  * Test cases #6-#7 are regression tests for commit:
- * (from v5.19, unlikely to be backported thus not in .tags):
  *
  *      e730558adffb fanotify: consistent behavior for parent not watching children
  */
@@ -380,9 +379,9 @@ static void test_fanotify(unsigned int n)
 		return;
 	}
 
-	if (tc->ignore && tst_kvercmp(5, 19, 0) < 0) {
+	if (tc->ignore && tst_kvercmp(5, 10, 0) < 0) {
 		tst_res(TCONF, "ignored mask on parent dir has undefined "
-				"behavior on kernel < 5.19");
+				"behavior on kernel < 5.10");
 		return;
 	}
 
@@ -520,6 +519,7 @@ static struct tst_test test = {
 		{"linux-git", "b469e7e47c8a"},
 		{"linux-git", "55bf882c7f13"},
 		{"linux-git", "7372e79c9eb9"},
+		{"linux-git", "e730558adffb"},
 		{}
 	}
 };
-- 
2.46.0


