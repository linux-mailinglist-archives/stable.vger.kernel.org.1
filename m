Return-Path: <stable+bounces-55222-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46ACF91629D
	for <lists+stable@lfdr.de>; Tue, 25 Jun 2024 11:37:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7917A1C21892
	for <lists+stable@lfdr.de>; Tue, 25 Jun 2024 09:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75F741494D1;
	Tue, 25 Jun 2024 09:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ASf4YTTB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3362E148315;
	Tue, 25 Jun 2024 09:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719308271; cv=none; b=RhxOnt25Sduj4rvnU59FDQROlUbn+mf8KBXUTZx9fwJdMx31d53rtc09Ppe9sG8uxOFUY6DYYszRHxmFTg9X44KCLxPg8lo5enlpp9/y5ehyzCD6oFViC8i5OTrfDPhU4MimA0BsBf4IMYTbK4yffs/yM/p3BK03Kxd9wtPpRoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719308271; c=relaxed/simple;
	bh=8RQXWSUdlO7lSX1OsijnUjLrpKChW5GnQlEnkutYH/w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JBD4zAWZuGf3aY1YocOxFubwfnn1ftnazW3yCUY6qsljUR2cjsLhbaFFbe7SWFOjGR1sEe2bN6pSvTQdNngmMOpNpFv/wa8B5nE9NBjRS9kZa57w1iKm023i5+zdlqmFelmkfg3M/EFaeGeHKFcuHuluckCMOJUMevzRRbSOb6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ASf4YTTB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABE4EC32781;
	Tue, 25 Jun 2024 09:37:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1719308271;
	bh=8RQXWSUdlO7lSX1OsijnUjLrpKChW5GnQlEnkutYH/w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ASf4YTTBH8M0L0iWQHBM8HCmpgLhxdRGG+ziV3y8Z5OjestNQDbtZ4zmV8SsKE+At
	 KjzU6JPR0GVrUrzyS9bntCYq+OZuZedplLhaARz4xBWXta0rNR4PYEoObmMZEvP89m
	 1w2WTKNQZ1SApzusWgjDQowrDyxCbrRlOC6JrkVo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kunwu Chan <chentao@kylinos.cn>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>,
	Will Deacon <will@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.9 033/250] kselftest: arm64: Add a null pointer check
Date: Tue, 25 Jun 2024 11:29:51 +0200
Message-ID: <20240625085549.329250998@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240625085548.033507125@linuxfoundation.org>
References: <20240625085548.033507125@linuxfoundation.org>
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

6.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kunwu Chan <chentao@kylinos.cn>

[ Upstream commit 80164282b3620a3cb73de6ffda5592743e448d0e ]

There is a 'malloc' call, which can be unsuccessful.
This patch will add the malloc failure checking
to avoid possible null dereference and give more information
about test fail reasons.

Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Link: https://lore.kernel.org/r/20240423082102.2018886-1-chentao@kylinos.cn
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/arm64/tags/tags_test.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/arm64/tags/tags_test.c b/tools/testing/selftests/arm64/tags/tags_test.c
index 5701163460ef7..955f87c1170d7 100644
--- a/tools/testing/selftests/arm64/tags/tags_test.c
+++ b/tools/testing/selftests/arm64/tags/tags_test.c
@@ -6,6 +6,7 @@
 #include <stdint.h>
 #include <sys/prctl.h>
 #include <sys/utsname.h>
+#include "../../kselftest.h"
 
 #define SHIFT_TAG(tag)		((uint64_t)(tag) << 56)
 #define SET_TAG(ptr, tag)	(((uint64_t)(ptr) & ~SHIFT_TAG(0xff)) | \
@@ -21,6 +22,9 @@ int main(void)
 	if (prctl(PR_SET_TAGGED_ADDR_CTRL, PR_TAGGED_ADDR_ENABLE, 0, 0, 0) == 0)
 		tbi_enabled = 1;
 	ptr = (struct utsname *)malloc(sizeof(*ptr));
+	if (!ptr)
+		ksft_exit_fail_msg("Failed to allocate utsname buffer\n");
+
 	if (tbi_enabled)
 		tag = 0x42;
 	ptr = (struct utsname *)SET_TAG(ptr, tag);
-- 
2.43.0




