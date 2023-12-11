Return-Path: <stable+bounces-5802-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EA6380D71E
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 19:37:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 400671C2140A
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 18:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77C7F5381D;
	Mon, 11 Dec 2023 18:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Qte1j079"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3389252F8A;
	Mon, 11 Dec 2023 18:35:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA39DC433C9;
	Mon, 11 Dec 2023 18:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702319701;
	bh=UAH6SsHmmKR5NixTkYXlYYcz8kpNoDBTlpvJVH65LTo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Qte1j0797P5QxanT8cwB1jaqekiB+zyFP2OXnGWw1HcEvqdxE9PMBOj6lyKAtHq9k
	 O5/rZJ0qz/Pf4uzsLd1/XDwBFrd36htwpyZ2pqSp0MrqrKwn2CgbnjOhjCjxmBRuC8
	 eHsfm3lzt9eaaQefZRZKnPvR7T5GbCalR0fm6nBk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Helge Deller <deller@gmx.de>,
	Linux Kernel Functional Testing <lkft@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 201/244] parisc: Fix asm operand number out of range build error in bug table
Date: Mon, 11 Dec 2023 19:21:34 +0100
Message-ID: <20231211182054.964944990@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231211182045.784881756@linuxfoundation.org>
References: <20231211182045.784881756@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Helge Deller <deller@gmx.de>

[ Upstream commit 487635756198cad563feb47539c6a37ea57f1dae ]

Build is broken if CONFIG_DEBUG_BUGVERBOSE=n.
Fix it be using the correct asm operand number.

Signed-off-by: Helge Deller <deller@gmx.de>
Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
Fixes: fe76a1349f23 ("parisc: Use natural CPU alignment for bug_table")
Cc: stable@vger.kernel.org   # v6.0+
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/parisc/include/asm/bug.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/parisc/include/asm/bug.h b/arch/parisc/include/asm/bug.h
index 1641ff9a8b83e..833555f74ffa7 100644
--- a/arch/parisc/include/asm/bug.h
+++ b/arch/parisc/include/asm/bug.h
@@ -71,7 +71,7 @@
 		asm volatile("\n"					\
 			     "1:\t" PARISC_BUG_BREAK_ASM "\n"		\
 			     "\t.pushsection __bug_table,\"a\"\n"	\
-			     "\t.align %2\n"				\
+			     "\t.align 4\n"				\
 			     "2:\t" __BUG_REL(1b) "\n"			\
 			     "\t.short %0\n"				\
 			     "\t.blockz %1-4-2\n"			\
-- 
2.42.0




