Return-Path: <stable+bounces-47470-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 29BB78D0E22
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 21:37:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F78BB2171D
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 19:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C54391607BA;
	Mon, 27 May 2024 19:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bam8Gb5F"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84FEA15FCF0;
	Mon, 27 May 2024 19:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716838633; cv=none; b=YKf1UTRTjvb/0kpuAFyuH4ab/29t9FDGMt5fX9rGqmRR6AaVzmaWGJ9vdWOWLya96wmWMs47XNkB8BrtsQq5VcR0lCX7trxna/B/ktuPv8aAA/60v5U7Y9rICM0J1zVSxoavyTgNmwbncRw5HENU73+Y+547e4+K9stnbsBSJFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716838633; c=relaxed/simple;
	bh=yC0vwy+yu/+a008ygCDlIkYAXb4O2m0S2MeOGFOvaM8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=crzPoRJnvsS/s24QmDhvT/RfDtju496FbKkeQw+s5IJZMz3F4uKjhDP0FgDYIQx321iTPrwLwoXjmm1O448pJ1esug74XP+eXC9avrsJ/2XM221/fzvsN0XvFpSBQWcXpR5DklWqYiyKRFEiDTrntiwSs9tnOJzliwkDUyirQjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bam8Gb5F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AFA0C2BBFC;
	Mon, 27 May 2024 19:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716838633;
	bh=yC0vwy+yu/+a008ygCDlIkYAXb4O2m0S2MeOGFOvaM8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bam8Gb5FNFcup61sOAOFWBnKF2xKQuT390Q+dnwCCROVEtoxh7QutfjdjpaVq9YYR
	 MC7owC4R6Mhx+/4qc/1Ht2tGx2f+Z6wdwCIj2wiwl63Hw47HcIAp7Ag3IX9J5NtruU
	 11r2PctEI8a86OLJF5lgg1qZ/lDPORJQIii8AH18=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Edward Liaw <edliaw@google.com>,
	Cyrill Gorcunov <gorcunov@gmail.com>,
	Eric Biederman <ebiederm@xmission.com>,
	Shuah Khan <shuah@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 467/493] selftests/kcmp: remove unused open mode
Date: Mon, 27 May 2024 20:57:49 +0200
Message-ID: <20240527185645.455281228@linuxfoundation.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240527185626.546110716@linuxfoundation.org>
References: <20240527185626.546110716@linuxfoundation.org>
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

6.8-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Edward Liaw <edliaw@google.com>

[ Upstream commit eb59a58113717df04b8a8229befd8ab1e5dbf86e ]

Android bionic warns that open modes are ignored if O_CREAT or O_TMPFILE
aren't specified.  The permissions for the file are set above:

	fd1 = open(kpath, O_RDWR | O_CREAT | O_TRUNC, 0644);

Link: https://lkml.kernel.org/r/20240429234610.191144-1-edliaw@google.com
Fixes: d97b46a64674 ("syscalls, x86: add __NR_kcmp syscall")
Signed-off-by: Edward Liaw <edliaw@google.com>
Reviewed-by: Cyrill Gorcunov <gorcunov@gmail.com>
Cc: Eric Biederman <ebiederm@xmission.com>
Cc: Shuah Khan <shuah@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/kcmp/kcmp_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kcmp/kcmp_test.c b/tools/testing/selftests/kcmp/kcmp_test.c
index 25110c7c0b3ed..d7a8e321bb16b 100644
--- a/tools/testing/selftests/kcmp/kcmp_test.c
+++ b/tools/testing/selftests/kcmp/kcmp_test.c
@@ -91,7 +91,7 @@ int main(int argc, char **argv)
 		ksft_print_header();
 		ksft_set_plan(3);
 
-		fd2 = open(kpath, O_RDWR, 0644);
+		fd2 = open(kpath, O_RDWR);
 		if (fd2 < 0) {
 			perror("Can't open file");
 			ksft_exit_fail();
-- 
2.43.0




