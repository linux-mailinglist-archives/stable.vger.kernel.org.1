Return-Path: <stable+bounces-200563-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B5322CB2379
	for <lists+stable@lfdr.de>; Wed, 10 Dec 2025 08:33:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A3BF7310BA9A
	for <lists+stable@lfdr.de>; Wed, 10 Dec 2025 07:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F11512741BC;
	Wed, 10 Dec 2025 07:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="haHLaXMc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7AF271462;
	Wed, 10 Dec 2025 07:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765351905; cv=none; b=rkaaqaanVpZpWQl/Zg61RFzmLrqmkAL+YS3kJA4MaA86Xjyth9STvJxyWmRSbpNRO6Rd7bAT5WS3MSgsBjZLZbBDDnD34zNFmi0RQpFHJULpvQ3Qhu0huMx2WwzU658LcDbnR+U8iOfy3rrHoBtEz9+NbivZ25Po/vhC4jfXzn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765351905; c=relaxed/simple;
	bh=8H3yXVXMpz5xb54qFosG/fhO+XA3ozXk+uweaxQYpNw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cpwj4XyHVdQaWZKWWptIV2FbzfoEPI2ERd9hQt3Jes6TWXwNRVXGOqfVS3kBfzaiG1JISZ2rYm+Ilh+p/eYAGkT8N0uc4x5rJ5MdAfcdE+zgNg9oL4tYbrIv/7wp0xKRjoQ2r1BH4+SHhoaY+6HFtI+XxVM7z2O/XeMWXxosUWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=haHLaXMc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31E88C19423;
	Wed, 10 Dec 2025 07:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1765351905;
	bh=8H3yXVXMpz5xb54qFosG/fhO+XA3ozXk+uweaxQYpNw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=haHLaXMceonIxSmgtGmAUNCK1Jl9xM/slOdW4xvCY3BPpK/fdFoTOpfb5lv1FoTSV
	 7plsakwqxHOtJDJkU0DR81kwZDq6R0NNWnvbfLimKd16TZRU6IqLb7xhIoHwDZHoFs
	 4bocPtM5hWLuypyYJlubDhFnkxvu7NRseAuUVWLQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yiqi Sun <sunyiqixm@gmail.com>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 25/49] smb: fix invalid username check in smb3_fs_context_parse_param()
Date: Wed, 10 Dec 2025 16:29:55 +0900
Message-ID: <20251210072948.789535436@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251210072948.125620687@linuxfoundation.org>
References: <20251210072948.125620687@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yiqi Sun <sunyiqixm@gmail.com>

[ Upstream commit ed6612165b74f09db00ef0abaf9831895ab28b7f ]

Since the maximum return value of strnlen(..., CIFS_MAX_USERNAME_LEN)
is CIFS_MAX_USERNAME_LEN, length check in smb3_fs_context_parse_param()
is always FALSE and invalid.

Fix the comparison in if statement.

Signed-off-by: Yiqi Sun <sunyiqixm@gmail.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/fs_context.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/smb/client/fs_context.c b/fs/smb/client/fs_context.c
index 9a4492106c25f..17133adfe798b 100644
--- a/fs/smb/client/fs_context.c
+++ b/fs/smb/client/fs_context.c
@@ -1415,7 +1415,7 @@ static int smb3_fs_context_parse_param(struct fs_context *fc,
 			break;
 		}
 
-		if (strnlen(param->string, CIFS_MAX_USERNAME_LEN) >
+		if (strnlen(param->string, CIFS_MAX_USERNAME_LEN) ==
 		    CIFS_MAX_USERNAME_LEN) {
 			pr_warn("username too long\n");
 			goto cifs_parse_mount_err;
-- 
2.51.0




