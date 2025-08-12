Return-Path: <stable+bounces-168740-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38177B23677
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 21:01:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D1DB7BC5F4
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 18:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E664D2FE571;
	Tue, 12 Aug 2025 18:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RIJj4+43"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A33C42FE595;
	Tue, 12 Aug 2025 18:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755025180; cv=none; b=WX39dmGpnBXmFo0kztWVH83SZKvgqHINZOq9SZyYnL9SnzZdaidAhpcADlBNYOc7aIItFYnjLwD8e4eJdv/HjkPObpgb1mpyE4xOuQ5WKU44rEFbM6Fa2LKGhl5ft8FDP9P8N7th+kC0zG5t2s5KrB+BMXJ1ahHGs55RlCSYuig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755025180; c=relaxed/simple;
	bh=04OkG36H0miVv9IGJTif/C6xmY/+Y3K7fXrb6I9RtYs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G7azOp56A6fHEE6CqhTTzj71N/IANZWmvWPxusI1tLYmB0bZAyE+yNzj3crLWU8fr9r64bX0RSJOKcsesW6TWHiYlPShucGEbJRCBmoheSS0s7TornehRQhqZJoC5G7zzfY8a8hUqJp4H6d0YhEHKPzQFy+n8QaSpz9mzqqomBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RIJj4+43; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3482C4CEF0;
	Tue, 12 Aug 2025 18:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755025179;
	bh=04OkG36H0miVv9IGJTif/C6xmY/+Y3K7fXrb6I9RtYs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RIJj4+43B0hk+RJP0tCk/7Txe6b03+WI4Iq1v9yHBdMDZe8IlV4+eDcH+HV6+E3An
	 f4n66sSMy18AEo54k/BzT0Jz5H1Yk3PMFJmiy77dWMLVDAeoY5cjKiTCndeoW6LCBv
	 3CAHeq6jIFz+8hi4PrX+iadQPdX4kkf6cFaUXsFg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Thorsten Blum <thorsten.blum@linux.dev>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.16 591/627] smb: server: Fix extension string in ksmbd_extract_shortname()
Date: Tue, 12 Aug 2025 19:34:46 +0200
Message-ID: <20250812173454.351778913@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250812173419.303046420@linuxfoundation.org>
References: <20250812173419.303046420@linuxfoundation.org>
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

6.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thorsten Blum <thorsten.blum@linux.dev>

commit 8e7d178d06e8937454b6d2f2811fa6a15656a214 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/smb/server/smb_common.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/smb/server/smb_common.c
+++ b/fs/smb/server/smb_common.c
@@ -515,7 +515,7 @@ int ksmbd_extract_shortname(struct ksmbd
 
 	p = strrchr(longname, '.');
 	if (p == longname) { /*name starts with a dot*/
-		strscpy(extension, "___", strlen("___"));
+		strscpy(extension, "___", sizeof(extension));
 	} else {
 		if (p) {
 			p++;



