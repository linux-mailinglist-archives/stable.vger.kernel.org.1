Return-Path: <stable+bounces-168639-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B553B235C3
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 20:54:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1366A586AF6
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 18:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADE9B2FD1B2;
	Tue, 12 Aug 2025 18:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Emmdq1UH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC342C21E3
	for <stable@vger.kernel.org>; Tue, 12 Aug 2025 18:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755024843; cv=none; b=TzFBoxQr7LpLUwpmPuObJZvrp8D7fAYAT9Px8KCXiHJpSFb/UfIFubzvdVI2FHuZK9VtpMywfWY73e5BCl81oyjeay7SDKa1jNU+MWr9WO/u14vccwZHF0Ky/GyVFpY0tOHVXbI4cjFHvI9uP6EJCVZkPq7RWxp/RdApfnH2/9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755024843; c=relaxed/simple;
	bh=IRcwteI01j6GJRcJjl350E6WVhnibHyJV8Yn2xdMing=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=D+mPrkNGZNXY9Z1WOl/YswNrl6OpCqDza2GVqlgbnSLzZShH4mWVsFZRzimJ12Cb210yT6YdDKjGmnn7UCaVA7BS8/pJRmGLUJqYp/8WqUFpkZlieyNmrV/rOMEkwjv/ppDqbGcdrHh7fhmZMiL5LPss5ZRQnrzC2yK0YmuITDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Emmdq1UH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C721C4CEF0;
	Tue, 12 Aug 2025 18:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755024843;
	bh=IRcwteI01j6GJRcJjl350E6WVhnibHyJV8Yn2xdMing=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Emmdq1UHYPL2ki/gkhKrGJLW85aMsheWt2i5V2XSIpk2OydytNLSxWLJo7lzfTy2W
	 hjbn03C9EMg4CwX9h/nojv1B3cY/Vira9FRrXjyGrVtwezwF8q63ddUdZ4vJlbb6JB
	 SMwFwCrBW9uS0X01QeaZtahWIXRduWizh3SgSRdNKLXVo/6+f4weqOzgzDvkKS4vFd
	 /NNcxvvhncwkBn73XyW8k0xW7Io8a9wahPYobagxJRrJKb51fNTBD5c9mIawQLANet
	 nrW0xXRvpwL05xlH4qAgML5hbaCHoTa3VbYi0ZOuk76cYs0L+wDSxSkSTXsZMT2cfH
	 kpbhYqCJq/Z4w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] smb: server: Fix extension string in ksmbd_extract_shortname()
Date: Tue, 12 Aug 2025 14:53:58 -0400
Message-Id: <20250812185358.2029378-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <2025081244-octagon-curve-7925@gregkh>
References: <2025081244-octagon-curve-7925@gregkh>
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
index 191df59748e0..a29c0494dccb 100644
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


