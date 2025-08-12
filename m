Return-Path: <stable+bounces-169058-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D97C4B237F1
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 21:17:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50B261B67498
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 19:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ECDB285CAA;
	Tue, 12 Aug 2025 19:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IIZsUy99"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3505628505A
	for <stable@vger.kernel.org>; Tue, 12 Aug 2025 19:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755026237; cv=none; b=E52qnGy0gnRoscVfSI/UPbTy5vVQy2Cxg/RMlGwz6g/SzdXK1AlmlrzikarBanp1OjtXwwxh1gs4HSFIXMT8pxbBNWNIYIXV2mKHlumenvxwPggbHlBklGzVNp1b/hk6WuV7utRIzvTBZvh/XrbiU0TS3tYf4u4v9jISmPXYbX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755026237; c=relaxed/simple;
	bh=wsOobTfT6VyMSKBaXMDuQzU6EsoJJ7eiNC2rBfB2Ly8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XKlmIiYDUV459xg2W6saEDP8N6M0Q0zGzMjl3O2HHylmUiOFTNMc2z9kXUR55o1cUwnPwvurl1N1LdHIzFEKe/egaurGmNicwoaArFZI39Duph4Qs+k8Q5yjV6Pu+9vPT5kdFOVFbkTSDCUPu88wdOCcG1SCy6vinY1ue8iSDgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IIZsUy99; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0C18C4CEF7;
	Tue, 12 Aug 2025 19:17:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755026236;
	bh=wsOobTfT6VyMSKBaXMDuQzU6EsoJJ7eiNC2rBfB2Ly8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IIZsUy9949FghxQxjR97GeVm8cv4BbRVEuk//U7hv0kMji6kUUfd9+HwO9B7H5Hyi
	 +xxlSYGL0Cvr64gWmaCaBlS97KU5oJAdK9zs/8lvhOGM1EbxWInHFuyh6ZrbP/wH8x
	 hxTJ6N4fr7jHY9OZZcf6EwgRvMge3ahAbFpg+cq4ohxLly5yRFshZfyhpvBR85QzXe
	 i3H8KOzKK/beTf2ArvKXYovmM/lvFghg6lrkxb3HlD/hiThDEsZgXfwmtzChIphfs5
	 Yb+DusNk+wkNHczPp5mdFw5EGbN15B3KDzRdc7Bf92Wiov9Y+jxbKyTGkAIPGtOJ5c
	 y7Lzjj1diLK2A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] smb: server: Fix extension string in ksmbd_extract_shortname()
Date: Tue, 12 Aug 2025 15:17:11 -0400
Message-Id: <20250812191711.2033414-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <2025081251-slang-colony-6d23@gregkh>
References: <2025081251-slang-colony-6d23@gregkh>
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


