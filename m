Return-Path: <stable+bounces-10240-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EFB778273F0
	for <lists+stable@lfdr.de>; Mon,  8 Jan 2024 16:42:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07B461C22D36
	for <lists+stable@lfdr.de>; Mon,  8 Jan 2024 15:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D4FF54736;
	Mon,  8 Jan 2024 15:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WydC04A6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9EEE4645B;
	Mon,  8 Jan 2024 15:40:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A1A7C433C7;
	Mon,  8 Jan 2024 15:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704728429;
	bh=5H+htleyB73dsab+1s2RAubbIysJRcobeoB5l4VX5hk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WydC04A62FC2vKdpkSad7kq4usJmLW0DqTKTPei+pYd/For5ImwnaQS6DQOZJVj4f
	 eoTLVkKydTqK9qUhEltMKL+K2wTWpwFLHUbxY81EpcLFAihSw0EjfzSmHKpig8LJ4M
	 G0iXL+6IRO0syevvQoz2AhuP186oeorvZEf++dcg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Muhammad Usama Anjum <usama.anjum@collabora.com>,
	"kernelci.org bot" <bot@kernelci.org>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Mike Rapoport (IBM)" <rppt@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 056/150] selftests: secretmem: floor the memory size to the multiple of page_size
Date: Mon,  8 Jan 2024 16:35:07 +0100
Message-ID: <20240108153513.807916310@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240108153511.214254205@linuxfoundation.org>
References: <20240108153511.214254205@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Muhammad Usama Anjum <usama.anjum@collabora.com>

[ Upstream commit 0aac13add26d546ac74c89d2883b3a5f0fbea039 ]

The "locked-in-memory size" limit per process can be non-multiple of
page_size.  The mmap() fails if we try to allocate locked-in-memory with
same size as the allowed limit if it isn't multiple of the page_size
because mmap() rounds off the memory size to be allocated to next multiple
of page_size.

Fix this by flooring the length to be allocated with mmap() to the
previous multiple of the page_size.

This was getting triggered on KernelCI regularly because of different
ulimit settings which wasn't multiple of the page_size.  Find logs
here: https://linux.kernelci.org/test/plan/id/657654bd8e81e654fae13532/
The bug in was present from the time test was first added.

Link: https://lkml.kernel.org/r/20231214101931.1155586-1-usama.anjum@collabora.com
Fixes: 76fe17ef588a ("secretmem: test: add basic selftest for memfd_secret(2)")
Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Reported-by: "kernelci.org bot" <bot@kernelci.org>
Closes: https://linux.kernelci.org/test/plan/id/657654bd8e81e654fae13532/
Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: Mike Rapoport (IBM) <rppt@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/vm/memfd_secret.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/vm/memfd_secret.c b/tools/testing/selftests/vm/memfd_secret.c
index 957b9e18c7295..9b298f6a04b37 100644
--- a/tools/testing/selftests/vm/memfd_secret.c
+++ b/tools/testing/selftests/vm/memfd_secret.c
@@ -62,6 +62,9 @@ static void test_mlock_limit(int fd)
 	char *mem;
 
 	len = mlock_limit_cur;
+	if (len % page_size != 0)
+		len = (len/page_size) * page_size;
+
 	mem = mmap(NULL, len, prot, mode, fd, 0);
 	if (mem == MAP_FAILED) {
 		fail("unable to mmap secret memory\n");
-- 
2.43.0




