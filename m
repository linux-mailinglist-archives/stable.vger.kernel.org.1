Return-Path: <stable+bounces-83702-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06D8499BECE
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 06:07:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F112B226AF
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 04:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A6821A76A4;
	Mon, 14 Oct 2024 03:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QEei9gPf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C87DC1A726B;
	Mon, 14 Oct 2024 03:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728878340; cv=none; b=VBbyGAjkpm+4u0bekvAzPbcHYvSw6aOW+Kj74bIIKtbb+dDF8lyFDCYvIEj9NFTE4616T7kay3dX/UWehiYmzd50c7sa2Xkv9UAvbwyDfXsuntMGKvOn2a4E3M0r3h6lpHH3C8HGbTJLeJg3hk3kWt81aDguoJ1mKIhy4hM1NVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728878340; c=relaxed/simple;
	bh=iiNXBTXSYxUR7Njmep6gisphn1RKs2HVD7L0k2T+5a4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CV2KAkNSKIdaZIahGolugj6UNvRXBqjVoGb+KuZwkqFNq3H9UFozA0ZINuUR1ham3NlizFiGwKzVPMFM0SN5H6zZ/tRpiuB0eEpjIDuhprBeSz0omf4OBpC0bamZyKYpiQrrR/OqHbOLRnKrtMtKgf6yCLpKyXB+AVCSGarsE7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QEei9gPf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70D2FC4CED0;
	Mon, 14 Oct 2024 03:58:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728878340;
	bh=iiNXBTXSYxUR7Njmep6gisphn1RKs2HVD7L0k2T+5a4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QEei9gPficzZsIvvUU3XlRqmthnd9JAU8MfvGSvCDeunK0fkiFkWAD7Dyxa6JL5FG
	 CsmhjtVdb7BCxrZ/WLrB3vuSrpOYck7nwoAnz8aPkdTc/VdCZ6XaYzmC27NiSIS1k9
	 UG3i/1LOA31dshNsKDxvQgt1c28P/C6csdj0vmAVq6QqT7aXPyWgSTkUPR4r1yt4+I
	 qAJscDHpwSqJoPoM5dHyIFV6pNHyL6O7zXy6Va0LrZQtKPWzdq2oLXwCOuhEsXjiVX
	 X9xVoXh/uS6hWCVMyly/7WxuwPXdHBRRXKwNs7L6xBiXQqGXctzvzd30BEeUD8dhGo
	 vYFyHZP+z3Hsg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>,
	sfrench@samba.org,
	linux-cifs@vger.kernel.org,
	samba-technical@lists.samba.org
Subject: [PATCH AUTOSEL 6.1 07/10] cifs: Fix creating native symlinks pointing to current or parent directory
Date: Sun, 13 Oct 2024 23:58:42 -0400
Message-ID: <20241014035848.2247549-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241014035848.2247549-1-sashal@kernel.org>
References: <20241014035848.2247549-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.112
Content-Transfer-Encoding: 8bit

From: Pali Rohár <pali@kernel.org>

[ Upstream commit 63271b7d569fbe924bccc7dadc17d3d07a4e5f7a ]

Calling 'ln -s . symlink' or 'ln -s .. symlink' creates symlink pointing to
some object name which ends with U+F029 unicode codepoint. This is because
trailing dot in the object name is replaced by non-ASCII unicode codepoint.

So Linux SMB client currently is not able to create native symlink pointing
to current or parent directory on Windows SMB server which can be read by
either on local Windows server or by any other SMB client which does not
implement compatible-reverse character replacement.

Fix this problem in cifsConvertToUTF16() function which is doing that
character replacement. Function comment already says that it does not need
to handle special cases '.' and '..', but after introduction of native
symlinks in reparse point form, this handling is needed.

Note that this change depends on the previous change
"cifs: Improve creating native symlinks pointing to directory".

Signed-off-by: Pali Rohár <pali@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/cifs_unicode.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/fs/smb/client/cifs_unicode.c b/fs/smb/client/cifs_unicode.c
index e7582dd791794..53f862a9c03cc 100644
--- a/fs/smb/client/cifs_unicode.c
+++ b/fs/smb/client/cifs_unicode.c
@@ -485,10 +485,21 @@ cifsConvertToUTF16(__le16 *target, const char *source, int srclen,
 			/**
 			 * Remap spaces and periods found at the end of every
 			 * component of the path. The special cases of '.' and
-			 * '..' do not need to be dealt with explicitly because
-			 * they are addressed in namei.c:link_path_walk().
+			 * '..' are need to be handled because of symlinks.
+			 * They are treated as non-end-of-string to avoid
+			 * remapping and breaking symlinks pointing to . or ..
 			 **/
-			if ((i == srclen - 1) || (source[i+1] == '\\'))
+			if ((i == 0 || source[i-1] == '\\') &&
+			    source[i] == '.' &&
+			    (i == srclen-1 || source[i+1] == '\\'))
+				end_of_string = false; /* "." case */
+			else if (i >= 1 &&
+				 (i == 1 || source[i-2] == '\\') &&
+				 source[i-1] == '.' &&
+				 source[i] == '.' &&
+				 (i == srclen-1 || source[i+1] == '\\'))
+				end_of_string = false; /* ".." case */
+			else if ((i == srclen - 1) || (source[i+1] == '\\'))
 				end_of_string = true;
 			else
 				end_of_string = false;
-- 
2.43.0


