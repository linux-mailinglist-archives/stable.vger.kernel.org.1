Return-Path: <stable+bounces-168526-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B732CB23546
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 20:48:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 825E9171FDA
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 18:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C713D2FDC30;
	Tue, 12 Aug 2025 18:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mU2Jz2sT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C4E2FE584
	for <stable@vger.kernel.org>; Tue, 12 Aug 2025 18:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755024465; cv=none; b=Mg/htacwvrt+DokXDxFLhZV6ifxl7Oegbizw5DM+GA1WGOGoDdFb+ZArlAw1UycEiyXVOdxZjJBaXG9I0Cn2qTvefqYVRDo+o2ZkOEVsE601Q3GRF7ATyho7dfv0FpGtV40VQmoKRyQrQp1FQd+/sFiHfq9kPna50XSR7FmA5ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755024465; c=relaxed/simple;
	bh=CziuQVh4iq7lLlvhoxXKN6Q55B4af9Mr5xTJrXqsevw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XqYBnujZGNaLLOAt6I/kTThe+R4vwOt3xxThChGJ1BoeYFTsxs4R44hbWkYQVE35uSbuQuT3ycgAv66d1cE5UpagARDvXeg4xZybP7dW8fYqbHEsC1k0k+8WE4PbsTLN0hemIhXXimUcKltrdPgoEUR1AbBr9F+OwLO/5h8R+ZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mU2Jz2sT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20F9EC4CEF0;
	Tue, 12 Aug 2025 18:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755024465;
	bh=CziuQVh4iq7lLlvhoxXKN6Q55B4af9Mr5xTJrXqsevw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mU2Jz2sT0KfDULUgAILmkgcQUcyEJxPzGzof4NEhgKSSji0+vbOxgq+O0kmZJunxQ
	 5wZbxYYKbETSCgBn9LlkS3QOlc8J2/9tCvymxMKnlPVGhuoCnXS9uLfC443FAlkJzF
	 UtccAjcMl8mpJz88NnmJp7Y6ncoWj8bWOIFkJW4tG/T357Bcgr2CWS9tNmbgY35Joz
	 CaPqIFoN1Pa8R6LjMEMoAlTE8ndS2KuvUF7tadz26IlVrXe27v/pF0PLxkqMCnCs/w
	 hhBpWKNUDjo2qaz7uWzKY9NR8FpUFmKgefRZx3lULVSLzTfg0LmxWlNmdxXfZGGUoN
	 z+Nx6a6zKk0fQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.16.y] smb: server: Fix extension string in ksmbd_extract_shortname()
Date: Tue, 12 Aug 2025 14:47:40 -0400
Message-Id: <20250812184740.2027825-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <2025081238-unnamed-nappy-9be5@gregkh>
References: <2025081238-unnamed-nappy-9be5@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Thorsten Blum <thorsten.blum@linux.dev>

[ Upstream commit 8e7d178d06e8937454b6d2f2811fa6a15656a214 ]

In ksmbd_extract_shortname(), strscpy() is incorrectly called with the
length of the source string (excluding the NUL terminator) rather than
the size of the destination buffer. This results in "__" being copied
to 'extension' rather than "___" (two underscores instead of three).

Use the destination buffer size instead to ensure that the string "___"
(three underscores) is copied correctly.

Cc: stable@vger.kernel.org
Fixes: e2f34481b24d ("cifsd: add server-side procedures for SMB3")
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/server/smb_common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/smb/server/smb_common.c b/fs/smb/server/smb_common.c
index 425c756bcfb8..b23203a1c286 100644
--- a/fs/smb/server/smb_common.c
+++ b/fs/smb/server/smb_common.c
@@ -515,7 +515,7 @@ int ksmbd_extract_shortname(struct ksmbd_conn *conn, const char *longname,
 
 	p = strrchr(longname, '.');
 	if (p == longname) { /*name starts with a dot*/
-		strscpy(extension, "___", strlen("___"));
+		strscpy(extension, "___", sizeof(extension));
 	} else {
 		if (p) {
 			p++;
-- 
2.39.5


