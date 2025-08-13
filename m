Return-Path: <stable+bounces-169391-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E05FB24AA2
	for <lists+stable@lfdr.de>; Wed, 13 Aug 2025 15:33:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6332163E7C
	for <lists+stable@lfdr.de>; Wed, 13 Aug 2025 13:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1A402E611F;
	Wed, 13 Aug 2025 13:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hsVv6K/F"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0559192D97
	for <stable@vger.kernel.org>; Wed, 13 Aug 2025 13:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755091941; cv=none; b=o4UK61rrVRpdGai6joatI73BelP7ZeiD4r+j++9ypVHb9DY6Mq92cKF3ZghX23JQyx0vZgQM1u3QFNHagM6mfyzGVyWejjcwSQMwTd07J7yod+Tj2CatpZBrmSKbyf2N+2a4yGmqZUKDdx76793BKqw0jH3X/f2LRH9gVNUKkLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755091941; c=relaxed/simple;
	bh=wsOobTfT6VyMSKBaXMDuQzU6EsoJJ7eiNC2rBfB2Ly8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oVQPUafiie9J8Z69BxAAd3FCZdFDoX7dBg0FutzlHu1jTpejwKCOQ4pA+SaKzVxaFQcnwdhEOL9o0OHdU03Lxq1OyzCeV7vmF2OyK46/IqP6hdzuQxbH4tuhHvoQWHQYY25TCBb5DWt7Pgh9IWkco8wzimSRP6b1ugZM5MqpZe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hsVv6K/F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 991F1C4CEEB;
	Wed, 13 Aug 2025 13:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755091941;
	bh=wsOobTfT6VyMSKBaXMDuQzU6EsoJJ7eiNC2rBfB2Ly8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hsVv6K/FvWkkANpYKNhFb83rG5Uc04WIwO9dXjmc1dceGGQ7R3tFXvwW1qhmLRW9y
	 Sy2u7lD5WYR11kbUqR7qRljnleEjTaX7XRlPNSivc3i0CZtvVYHtEI/tVnGMOTb2sU
	 iDw2NLcovSQpMcHoFttoLjBUnknUB/RqJxvF97Gj6TDZnsIn001zCQcwd8fD0fTRhS
	 oS6InTFIml8CPHDekPy4mjHN0k8bRbyETj1jb8QAx/DriTrjZR/uv1W9aUOEUjVsin
	 vmYgArV9UYZV4p3/SbwcPy3Yam8pW/4IcDFARuO4KvwkSWYTcnbWofjsJilCKLac8O
	 Io86SeeH9FxYg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] smb: server: Fix extension string in ksmbd_extract_shortname()
Date: Wed, 13 Aug 2025 09:32:18 -0400
Message-Id: <20250813133218.2035014-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <2025081211-chirping-aversion-8b66@gregkh>
References: <2025081211-chirping-aversion-8b66@gregkh>
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
 fs/ksmbd/smb_common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ksmbd/smb_common.c b/fs/ksmbd/smb_common.c
index e90a1e8c1951..0438a634f4c2 100644
--- a/fs/ksmbd/smb_common.c
+++ b/fs/ksmbd/smb_common.c
@@ -508,7 +508,7 @@ int ksmbd_extract_shortname(struct ksmbd_conn *conn, const char *longname,
 
 	p = strrchr(longname, '.');
 	if (p == longname) { /*name starts with a dot*/
-		strscpy(extension, "___", strlen("___"));
+		strscpy(extension, "___", sizeof(extension));
 	} else {
 		if (p) {
 			p++;
-- 
2.39.5


