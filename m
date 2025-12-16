Return-Path: <stable+bounces-201273-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A9ACCC2322
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 12:26:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B3FE2302DB73
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 11:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69631341670;
	Tue, 16 Dec 2025 11:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HLrtnVuo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 248F9341645;
	Tue, 16 Dec 2025 11:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765884101; cv=none; b=UkMMchG9bkAoj8Jf4Mb93SMSuaHpdNdo11IIR1p5h7icZ8WkxHjv1RCRHPW15Lq4cURdLPo88LVLYM7FcMccPxbllSnFfAPuYh5HLfa/AB/aXNqcgYt3pqCLD6ZvvdF7KXd2PAFJ89umfZngVY/gZjwhCTKvwvh5nhZXUweQE70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765884101; c=relaxed/simple;
	bh=t5BWnJc5lC+P0oOO40+KdEh68LZCiFoYQDAZpdp/Aq8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aJRnRDwr3ajXhGHAzA511uKRWRLDSLlRCC/IBdZyNWcPHPNTwsB63whnIrmCtuWBfjc4nnpKBdNDyJATe2etbdYSrlwSnItI/a//v+qi0q3UO9myDU4/VKXSmkHj1d6lN+spZcURJM/eewxeEf+HwaAYLkHmR4UgI1XsR0egpqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HLrtnVuo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A296C4CEF5;
	Tue, 16 Dec 2025 11:21:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1765884100;
	bh=t5BWnJc5lC+P0oOO40+KdEh68LZCiFoYQDAZpdp/Aq8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HLrtnVuos5nZ/uFZF1FO05TnY/C+RfCXfqi4MojAuDyjNXFFsIkYb2NDINmUm2QeX
	 KwiCysl+ttRAzpJBHUsYNh8OsV4KoQuQkfF9N20lMBeBJc4oski6dDwOh5SmEZFKIy
	 XdwmKuOhgx0bMp7/pmW6hC0WJYRIJ0B/YkAvaJaM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Benjamin Berg <benjamin.berg@intel.com>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 091/354] tools/nolibc/stdio: let perror work when NOLIBC_IGNORE_ERRNO is set
Date: Tue, 16 Dec 2025 12:10:58 +0100
Message-ID: <20251216111324.220275505@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251216111320.896758933@linuxfoundation.org>
References: <20251216111320.896758933@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Benjamin Berg <benjamin.berg@intel.com>

[ Upstream commit c485ca3aff2442adea4c08ceb5183e671ebed22a ]

There is no errno variable when NOLIBC_IGNORE_ERRNO is defined. As such,
simply print the message with "unknown error" rather than the integer
value of errno.

Fixes: acab7bcdb1bc ("tools/nolibc/stdio: add perror() to report the errno value")
Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/include/nolibc/stdio.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/include/nolibc/stdio.h b/tools/include/nolibc/stdio.h
index c968dbbc4ef81..4749a32b3064b 100644
--- a/tools/include/nolibc/stdio.h
+++ b/tools/include/nolibc/stdio.h
@@ -351,7 +351,11 @@ int printf(const char *fmt, ...)
 static __attribute__((unused))
 void perror(const char *msg)
 {
+#ifdef NOLIBC_IGNORE_ERRNO
+	fprintf(stderr, "%s%sunknown error\n", (msg && *msg) ? msg : "", (msg && *msg) ? ": " : "");
+#else
 	fprintf(stderr, "%s%serrno=%d\n", (msg && *msg) ? msg : "", (msg && *msg) ? ": " : "", errno);
+#endif
 }
 
 static __attribute__((unused))
-- 
2.51.0




