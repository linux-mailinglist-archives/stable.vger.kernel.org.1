Return-Path: <stable+bounces-31769-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A5498894EB
	for <lists+stable@lfdr.de>; Mon, 25 Mar 2024 09:12:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C2001F2E722
	for <lists+stable@lfdr.de>; Mon, 25 Mar 2024 08:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 704BF3986B6;
	Mon, 25 Mar 2024 03:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a4EkFEyr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 347E115ECEA;
	Sun, 24 Mar 2024 23:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322312; cv=none; b=WOhiMhWWRgWA+NOE+dJ5YNX2cTYwUT0anKUxRlFhufsV+ZQ8o6321UK9h4XWjqNI4JpYpTfq+BUu0VNB1ijq+7WNwFf0SpjRTk7P/6Qo2FLaac9e+Sr5pSqtM/S6au5d9Pn3+AD+ls9cxhXptCccdW/j6FP9KsK09qF1RYD0kuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322312; c=relaxed/simple;
	bh=vYDrj65XbguCNZEvMXtOEcXUTXcfMV3g0dkmYc1mhQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fUuj6vusmzNFheW4G0tcfdTN1SBV01F/EMlLuHQCoU+Y/I4YL9Zgsbgsc+ZDmE0VJT61NmzjS9q2ijfafJK+w/XISOlFiDbc/Ar8CzWFjTeWlE81YmN1GU67Q6BQMmKQtYSqOiRVNt42eGDUXSUstWSTC1cCHsfeU+ArV+tQ/A4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a4EkFEyr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4746DC433F1;
	Sun, 24 Mar 2024 23:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322310;
	bh=vYDrj65XbguCNZEvMXtOEcXUTXcfMV3g0dkmYc1mhQ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a4EkFEyrQJ7BPmVgFFuKRvBrNolcvOb1SmXbMLacN1dOtKqyYSwXQDx1y2dkebRUQ
	 azMM4lGRlVM6RKkg5Q7w1Vtjfo47L/TmXkA5GyuWu76ILZNQhYhEcM6wCAmLqUfIxX
	 vB7UbVhN1MsFLRD/4ZDLodY9Kscq60wC4F06NIE34QrcHJHutUK2xJ8Wsw7i8P0ziq
	 MYZLtNqvDYFJoFl2mas64QjcC/6B8eouCPZzoGrFUoMuTXIz9gKhFdhpHJo6XHzAXv
	 dDdarFAtqOIuccN06Yh8R125Nl5avCTk39XffASImasEGhu3BCEb0nfsv/66URQouN
	 McIH4YjD7G19A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Masahiro Yamada <masahiroy@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 394/451] kconfig: fix infinite loop when expanding a macro at the end of file
Date: Sun, 24 Mar 2024 19:11:10 -0400
Message-ID: <20240324231207.1351418-395-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Masahiro Yamada <masahiroy@kernel.org>

[ Upstream commit af8bbce92044dc58e4cc039ab94ee5d470a621f5 ]

A macro placed at the end of a file with no newline causes an infinite
loop.

[Test Kconfig]
  $(info,hello)
  \ No newline at end of file

I realized that flex-provided input() returns 0 instead of EOF when it
reaches the end of a file.

Fixes: 104daea149c4 ("kconfig: reference environment variables directly and remove 'option env='")
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 scripts/kconfig/lexer.l | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/scripts/kconfig/lexer.l b/scripts/kconfig/lexer.l
index cc386e4436834..2c2b3e6f248ca 100644
--- a/scripts/kconfig/lexer.l
+++ b/scripts/kconfig/lexer.l
@@ -302,8 +302,11 @@ static char *expand_token(const char *in, size_t n)
 	new_string();
 	append_string(in, n);
 
-	/* get the whole line because we do not know the end of token. */
-	while ((c = input()) != EOF) {
+	/*
+	 * get the whole line because we do not know the end of token.
+	 * input() returns 0 (not EOF!) when it reachs the end of file.
+	 */
+	while ((c = input()) != 0) {
 		if (c == '\n') {
 			unput(c);
 			break;
-- 
2.43.0


