Return-Path: <stable+bounces-35215-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB0318942F7
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 18:58:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75539283837
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 16:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC8184D9E9;
	Mon,  1 Apr 2024 16:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zSlyjl3n"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ABB34C630;
	Mon,  1 Apr 2024 16:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711990672; cv=none; b=t4Yh+ArxadrqWN3pgbvlFzqosEEB2VQAMXzyeaTN1sYeQzqOTSDUORdt3ZGR4Gv43o5pHNQhCTiMfSuP0/JXhQ5vSh+t4OWmVpS0TZAh/EQNE8MY+ehNcJyjYl60cnZhtjnxbmhwGDWQMZTLUw8+TLDd7ie2r72qW4YPJrPIUm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711990672; c=relaxed/simple;
	bh=ThDbHaZfn6vxVCxw7bkjAA6r62pJtSaYk8uUm6Pcc8s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qHZBIV3E1bJNqFWw8cqmicNDBOH6wW3xLqe053B1TNA/Fjn361cQub46S8Za3cDZbw/Eu0AUPsrw+GJrxlsr7ge38zh1NzLVtfLOUTQBFlKv9dmG033x1z8fMT/NMZ9fwKEHNW/bJojShOtv4Zejtfp/A60wQZRDd2eVmT/e/Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zSlyjl3n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB112C43394;
	Mon,  1 Apr 2024 16:57:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711990672;
	bh=ThDbHaZfn6vxVCxw7bkjAA6r62pJtSaYk8uUm6Pcc8s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=zSlyjl3nm9cbHVwrXPoccGfNxI3KphXBaW+lFK7CKL/FrbSrS1XvDC2JC0HgmQhTW
	 k422yWBTIemR9TdFRtKMD7S6uTklgkAcNDfFF3G2x4Vb2ugOrDWSdV9zBxePkSTjkk
	 2Lxhpz/mvCYkWC7+mUncdPr9WVlAmpZqPzNJ8bQQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Randy Dunlap <rdunlap@infradead.org>,
	Igor Zhbanov <izh1979@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	sparclinux@vger.kernel.org,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Nick Alcock <nick.alcock@oracle.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Andreas Larsson <andreas@gaisler.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 031/272] sparc: vDSO: fix return value of __setup handler
Date: Mon,  1 Apr 2024 17:43:41 +0200
Message-ID: <20240401152531.327645828@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240401152530.237785232@linuxfoundation.org>
References: <20240401152530.237785232@linuxfoundation.org>
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

From: Randy Dunlap <rdunlap@infradead.org>

[ Upstream commit 5378f00c935bebb846b1fdb0e79cb76c137c56b5 ]

__setup() handlers should return 1 to obsolete_checksetup() in
init/main.c to indicate that the boot option has been handled.
A return of 0 causes the boot option/value to be listed as an Unknown
kernel parameter and added to init's (limited) argument or environment
strings. Also, error return codes don't mean anything to
obsolete_checksetup() -- only non-zero (usually 1) or zero.
So return 1 from vdso_setup().

Fixes: 9a08862a5d2e ("vDSO for sparc")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: Igor Zhbanov <izh1979@gmail.com>
Link: lore.kernel.org/r/64644a2f-4a20-bab3-1e15-3b2cdd0defe3@omprussia.ru
Cc: "David S. Miller" <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org
Cc: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Nick Alcock <nick.alcock@oracle.com>
Cc: Sam Ravnborg <sam@ravnborg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: stable@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Andreas Larsson <andreas@gaisler.com>
Signed-off-by: Andreas Larsson <andreas@gaisler.com>
Link: https://lore.kernel.org/r/20240211052808.22635-1-rdunlap@infradead.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/sparc/vdso/vma.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/sparc/vdso/vma.c b/arch/sparc/vdso/vma.c
index ae9a86cb6f3d9..2b97df0850aa7 100644
--- a/arch/sparc/vdso/vma.c
+++ b/arch/sparc/vdso/vma.c
@@ -449,9 +449,8 @@ static __init int vdso_setup(char *s)
 	unsigned long val;
 
 	err = kstrtoul(s, 10, &val);
-	if (err)
-		return err;
-	vdso_enabled = val;
-	return 0;
+	if (!err)
+		vdso_enabled = val;
+	return 1;
 }
 __setup("vdso=", vdso_setup);
-- 
2.43.0




