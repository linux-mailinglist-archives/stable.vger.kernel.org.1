Return-Path: <stable+bounces-68471-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34EF8953274
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 16:06:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2B5228533C
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 14:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 532911AED38;
	Thu, 15 Aug 2024 14:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1cIC9TVH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B651A00CF;
	Thu, 15 Aug 2024 14:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723730674; cv=none; b=W4Vt5lvhg9xwmoLQGTE08p1yHMgBOxwqS8aa51QjwYyRemLIz1JXolDv+avtvloK1wOJFfIXGI/6gqjUrihKb7YSbxtZkB2JE0DWU/DFUqB63MywddJZOeg1BEFb5UuCbrqnlw7447TOf+Gy9OSUaRwqi9mJQhrq6JD6QXArpWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723730674; c=relaxed/simple;
	bh=YMyzEVdxAKPqqOPFMtvtEkZP/+/fKBFJqiKCG3IKnCA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MSgaaECtZFocyn8ANIRubUVvGc/DHCGezN6iXpAVcYlWX4ZneqP4rTSk+qYztKVsA3qXsv/GsltSYu3mkYPgA2u4dGsLhfpVV1xCcnHZpQ75aCwzfJCu5tyAP11vMCLyEU/CKwPr7r6D1TvDWbn+QQfuRZbsfZnvZokLkAhUgg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1cIC9TVH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B39DC32786;
	Thu, 15 Aug 2024 14:04:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723730673;
	bh=YMyzEVdxAKPqqOPFMtvtEkZP/+/fKBFJqiKCG3IKnCA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=1cIC9TVHwbxYsiPOIi5wOnZPN2tQQgo5zrYohdlCnB3imRedbKDcL1M8zDU/LBr2V
	 NiaJL269O3h3eRmHxMPGLZ8U3lcqN516jTLNCNKnuL77srH8knVCLM2HyFVv15sEUa
	 IhbQvArFWyAQn9fDBZh/OCKWVMw1oNMpD9OG3LAA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Stefan ORear <sorear@fastmail.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Greg Ungerer <gerg@linux-m68k.org>,
	Kees Cook <kees@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 482/484] binfmt_flat: Fix corruption when not offsetting data start
Date: Thu, 15 Aug 2024 15:25:40 +0200
Message-ID: <20240815132000.101495264@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240815131941.255804951@linuxfoundation.org>
References: <20240815131941.255804951@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kees Cook <kees@kernel.org>

[ Upstream commit 3eb3cd5992f7a0c37edc8d05b4c38c98758d8671 ]

Commit 04d82a6d0881 ("binfmt_flat: allow not offsetting data start")
introduced a RISC-V specific variant of the FLAT format which does
not allocate any space for the (obsolete) array of shared library
pointers. However, it did not disable the code which initializes the
array, resulting in the corruption of sizeof(long) bytes before the DATA
segment, generally the end of the TEXT segment.

Introduce MAX_SHARED_LIBS_UPDATE which depends on the state of
CONFIG_BINFMT_FLAT_NO_DATA_START_OFFSET to guard the initialization of
the shared library pointer region so that it will only be initialized
if space is reserved for it.

Fixes: 04d82a6d0881 ("binfmt_flat: allow not offsetting data start")
Co-developed-by: Stefan O'Rear <sorear@fastmail.com>
Signed-off-by: Stefan O'Rear <sorear@fastmail.com>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Acked-by: Greg Ungerer <gerg@linux-m68k.org>
Link: https://lore.kernel.org/r/20240807195119.it.782-kees@kernel.org
Signed-off-by: Kees Cook <kees@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/binfmt_flat.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/binfmt_flat.c b/fs/binfmt_flat.c
index 7ca3e0db06ffa..250651cdce0a6 100644
--- a/fs/binfmt_flat.c
+++ b/fs/binfmt_flat.c
@@ -76,8 +76,10 @@
 
 #ifdef CONFIG_BINFMT_FLAT_NO_DATA_START_OFFSET
 #define DATA_START_OFFSET_WORDS		(0)
+#define MAX_SHARED_LIBS_UPDATE		(0)
 #else
 #define DATA_START_OFFSET_WORDS		(MAX_SHARED_LIBS)
+#define MAX_SHARED_LIBS_UPDATE		(MAX_SHARED_LIBS)
 #endif
 
 struct lib_info {
@@ -991,7 +993,7 @@ static int load_flat_binary(struct linux_binprm *bprm)
 		return res;
 
 	/* Update data segment pointers for all libraries */
-	for (i = 0; i < MAX_SHARED_LIBS; i++) {
+	for (i = 0; i < MAX_SHARED_LIBS_UPDATE; i++) {
 		if (!libinfo.lib_list[i].loaded)
 			continue;
 		for (j = 0; j < MAX_SHARED_LIBS; j++) {
-- 
2.43.0




