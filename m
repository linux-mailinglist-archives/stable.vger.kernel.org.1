Return-Path: <stable+bounces-168839-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 02C54B236FC
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 21:07:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76D58188A188
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 19:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66AB723182D;
	Tue, 12 Aug 2025 19:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X1XeMfTk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261EC1C1AAA
	for <stable@vger.kernel.org>; Tue, 12 Aug 2025 19:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755025505; cv=none; b=R6dh9C5CvKCGgZGxHdDCN+RSZGEDeTjOgn+JouN7iSED6snDBvLqTu2r2KQQKoaU6GTnfWkJ9RavDLYX+AJZFXUpxqQl3htPPzXJ/uZc/VunKEw7IB4JUF4maVVQJBOxBCPV2SzobzqDjDFtb99uhziedooHSzt0/G0S4J/ykic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755025505; c=relaxed/simple;
	bh=R7pOS5px1NOi4avVfQfg2HVCGQjGjMpZzPpYNOi7pQc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fvNRZa/G/C4wHTbrIx795bO35dd7i3AdN8XNfhCrkLbwagjwGL+MbKyBZ7iyFQaXYd9wUzkuIFzqatjDtlmydfX+5pWD1lGx1wHBJp9a6oNOdhUc9eeN6JOaIaKhdAmb6ghIAZPHqVXVAEKyKFUs7sAaKl0g1RkctihW1UmbLVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X1XeMfTk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F6C6C4CEF1;
	Tue, 12 Aug 2025 19:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755025504;
	bh=R7pOS5px1NOi4avVfQfg2HVCGQjGjMpZzPpYNOi7pQc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X1XeMfTkvEVpXvd/rMggqZ6oXq/3MacFKNi5PcDJd0V//Ua/2c5W85UWBbpJptI03
	 n/vFQBY2JjW9/Di5c4T0vnVl247QYGBkPGhOP9htNRRl9x7ikiggeTxCnik3+XZGxl
	 BcikqTMaEt3IzQkFSWDkc1nDhI1bSja61+83Vicxs1gb77n6rC50irljSJHkBiIhTd
	 IqThkZNrwQOBBDaK2y7z9jYjlzwqUFyWeuLqRZiVzIRSvw4HFJ6ysnAb9fwZDzdNZM
	 mMg/KW3aVjWLMXyTlx5LUboNirgr0K1999547+iZwAEkgVJAqPQOEjNkdjCoTjsfQ/
	 a0d9pv/bjZ16Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] smb: server: Fix extension string in ksmbd_extract_shortname()
Date: Tue, 12 Aug 2025 15:05:00 -0400
Message-Id: <20250812190500.2031244-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <2025081249-afar-gesture-7178@gregkh>
References: <2025081249-afar-gesture-7178@gregkh>
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
index 7134abeeb53e..2850802f4a50 100644
--- a/fs/smb/server/smb_common.c
+++ b/fs/smb/server/smb_common.c
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


