Return-Path: <stable+bounces-175324-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F653B367CC
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 16:10:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D9B81C40059
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 14:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 761DB341650;
	Tue, 26 Aug 2025 13:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YaDNjZFM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 165FB352FF7;
	Tue, 26 Aug 2025 13:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756216735; cv=none; b=BBOr/LEkQJ5TXOLOvlf6FNmhrzIy2O8zPGBYcFPLqb8TFMMn6nvM4CZKsgbSvdZOztujavGtf++Lsxoc8qBuRcR1jM8SrxM4HQW7xL0LKKy5+/6RN8AGeU7vkLdNLLSaX7A77+EBenPz4RnwabYlgoffplvlD4IcvOyQ+RNL3AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756216735; c=relaxed/simple;
	bh=douXv3ssvUooykMqByIrU+XbIX2G8C6oNsjPDtEhKVY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ViWHY5VRubLzsaGOBZAMbyLKVr5M4YUDH0cz36OnpRCLmaUNBGgXcHV/b/5kBO8p9xNk04tHCxmlHLIg18zA1QPAv9EUUDOqN/x3A7z1fzvP1XRzkZB5efmA4BG99hJJ+bzUskdaPE1bc4YDqRjOvtS6H4mlHa0VUhNzDfh6dMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YaDNjZFM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34DFFC4CEF1;
	Tue, 26 Aug 2025 13:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756216734;
	bh=douXv3ssvUooykMqByIrU+XbIX2G8C6oNsjPDtEhKVY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YaDNjZFMVtQAYsxL4kkTUxcBVKykz4VypL+w1F9glMl3muHpUHUOzkyYeFBRJy1Rm
	 h38zNq62N9SUUdiIRCni73ploTEg7U/BGERcGcngIhOTkUUwXcFsmSPFzIWRM54ECg
	 AC8uemZ0Xzflg1bUyAiyEjsQ2v0vdwx40a6BsS0w=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Thorsten Blum <thorsten.blum@linux.dev>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 523/644] smb: server: Fix extension string in ksmbd_extract_shortname()
Date: Tue, 26 Aug 2025 13:10:14 +0200
Message-ID: <20250826110959.470251450@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826110946.507083938@linuxfoundation.org>
References: <20250826110946.507083938@linuxfoundation.org>
User-Agent: quilt/0.68
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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ksmbd/smb_common.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/ksmbd/smb_common.c
+++ b/fs/ksmbd/smb_common.c
@@ -508,7 +508,7 @@ int ksmbd_extract_shortname(struct ksmbd
 
 	p = strrchr(longname, '.');
 	if (p == longname) { /*name starts with a dot*/
-		strscpy(extension, "___", strlen("___"));
+		strscpy(extension, "___", sizeof(extension));
 	} else {
 		if (p) {
 			p++;



