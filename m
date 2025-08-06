Return-Path: <stable+bounces-166668-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 847EBB1BE1C
	for <lists+stable@lfdr.de>; Wed,  6 Aug 2025 03:04:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62537189D7C8
	for <lists+stable@lfdr.de>; Wed,  6 Aug 2025 01:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 455D264A8F;
	Wed,  6 Aug 2025 01:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="eVVd3e1w"
X-Original-To: stable@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D896A2E36EC
	for <stable@vger.kernel.org>; Wed,  6 Aug 2025 01:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754442292; cv=none; b=lHaQlNBh3GabBHewzjaAmNL3PoLb0qncefGyl/6mjlb7uNo4KjEgeOipUHizEAfp3bmNEth0NXUGeLCNVIo0z5gpbJOxGx2SYkstXQOiOaigccy9cVD8ViJEYWR5LQCjvqjqSRJJp7J/RENI8J/kT0GYJc84XrmQyC3fWI6Xf5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754442292; c=relaxed/simple;
	bh=7xv4EuNJe9l+nHGwPOvCi5WPN3pL0wKiQw4xh+kWLKQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TS2nXgcPXkQzioqOQco0pEscVLzZDeEDrlvMsYUG1YE3zTPIvaAoyrR3uUe2xsqSTCV46mzqIsHCrgfneMFC214QijyIEBXrcn6WGfYGbPde2WLMMhwuW31xoZnFlAr/xFYqIxO9pFSVcRre5i2sAfZwK5f7wOrzC8dqwwCsPPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=eVVd3e1w; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1754442277;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=a2FuUZ+f2cjOGCbD5ZW+D9cVIW5HzYCMplPAzNqlP4A=;
	b=eVVd3e1wE6kUIHZf/Gy/r0lt5HawdOmJBwAPpf+hJpL6xIfYDS/0NC67BeuFBPVvxNwDyc
	n7HKhMeEPZILTkqUNab3BTsQpozJRk/Hk72kX5imnkw2ahbvzlokGkWs7fuU+w+oLNxboC
	Yi2m98c4IApwXCpZ5fH73ByL8flMQno=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <smfrench@gmail.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Tom Talpey <tom@talpey.com>,
	Ronnie Sahlberg <lsahlber@redhat.com>,
	Hyunchul Lee <hyc.lee@gmail.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	stable@vger.kernel.org,
	Steve French <stfrench@microsoft.com>,
	Namjae Jeon <namjae.jeon@samsung.com>,
	linux-cifs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] smb: server: Fix extension string in ksmbd_extract_shortname()
Date: Wed,  6 Aug 2025 03:03:49 +0200
Message-ID: <20250806010348.61961-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

In ksmbd_extract_shortname(), strscpy() is incorrectly called with the
length of the source string (excluding the NUL terminator) rather than
the size of the destination buffer. This results in "__" being copied
to 'extension' rather than "___" (two underscores instead of three).

Use the destination buffer size instead to ensure that the string "___"
(three underscores) is copied correctly.

Cc: stable@vger.kernel.org
Fixes: e2f34481b24d ("cifsd: add server-side procedures for SMB3")
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
Changes in v2:
- Use three parameter variant of strscpy() for easier backporting
- Link to v1: https://lore.kernel.org/lkml/20250805221424.57890-1-thorsten.blum@linux.dev/
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
2.50.1


