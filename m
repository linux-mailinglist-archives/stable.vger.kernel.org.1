Return-Path: <stable+bounces-160952-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4710DAFD2BC
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 18:50:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9822A1BC51D1
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 16:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDCC62E54BA;
	Tue,  8 Jul 2025 16:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pSUalJMW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC9922045B5;
	Tue,  8 Jul 2025 16:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751993169; cv=none; b=Pt3G8vvR7nQ+axgFdl83CMPwV0ZHMCEaWgkgCYK9rtJ1AcgWcVPENOoV6AY3NuSZXrOOg351XQWB4VTS0BmsVaVT/4KgBZpHJlAXvtFb1g1ViNTPe5QHGhmmInjQ/50l4r769Rp4wykk/Jtr4xwZQme0yg+jMQt2rQxrDWV8X44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751993169; c=relaxed/simple;
	bh=AoJJlVSUqckAZ7S3dJOwfBZB4o68Zcwrj8Wpq7jCpGw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WvZohISpDDV18P/Sr8Z+DVraQSx3A8GCbF6kIWj5s2HuOsnIJZ8A69GUYJytZvR+8AtucnGjuDh6geotFK/Iv2nGywfZSNbSxk/IR3euPK5ilLnzGa3muP2VcUMoBzx+ucrKFiV+MzV81nEl4jwK0FyfLc0X2RjdTscDc0lII5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pSUalJMW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32E8FC4CEF0;
	Tue,  8 Jul 2025 16:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751993169;
	bh=AoJJlVSUqckAZ7S3dJOwfBZB4o68Zcwrj8Wpq7jCpGw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pSUalJMWF/AJb1w+dnDTJAvDDOhNaW5rxj+WNOK0PD95+HtJ/KrURBIxu84vcPtQd
	 INTE4DP+1Wf1Ju9K358iSNl+1xhTnuz2bxfEwRnDo18IQJNRdx8Fqi5Ya9sfEWCkSL
	 N3/aFK41gi4UVo3VtLGKL8Q74FoTifauF7Dipkco=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Philipp Kerling <pkerling@casix.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.12 212/232] smb: client: fix readdir returning wrong type with POSIX extensions
Date: Tue,  8 Jul 2025 18:23:28 +0200
Message-ID: <20250708162246.988670656@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250708162241.426806072@linuxfoundation.org>
References: <20250708162241.426806072@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Philipp Kerling <pkerling@casix.org>

commit b8f89cb723b9e66f5dbd7199e4036fee34fb0de0 upstream.

When SMB 3.1.1 POSIX Extensions are negotiated, userspace applications
using readdir() or getdents() calls without stat() on each individual file
(such as a simple "ls" or "find") would misidentify file types and exhibit
strange behavior such as not descending into directories. The reason for
this behavior is an oversight in the cifs_posix_to_fattr conversion
function. Instead of extracting the entry type for cf_dtype from the
properly converted cf_mode field, it tries to extract the type from the
PDU. While the wire representation of the entry mode is similar in
structure to POSIX stat(), the assignments of the entry types are
different. Applying the S_DT macro to cf_mode instead yields the correct
result. This is also what the equivalent function
smb311_posix_info_to_fattr in inode.c already does for stat() etc.; which
is why "ls -l" would give the correct file type but "ls" would not (as
identified by the colors).

Cc: stable@vger.kernel.org
Signed-off-by: Philipp Kerling <pkerling@casix.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/smb/client/readdir.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/smb/client/readdir.c
+++ b/fs/smb/client/readdir.c
@@ -263,7 +263,7 @@ cifs_posix_to_fattr(struct cifs_fattr *f
 	/* The Mode field in the response can now include the file type as well */
 	fattr->cf_mode = wire_mode_to_posix(le32_to_cpu(info->Mode),
 					    fattr->cf_cifsattrs & ATTR_DIRECTORY);
-	fattr->cf_dtype = S_DT(le32_to_cpu(info->Mode));
+	fattr->cf_dtype = S_DT(fattr->cf_mode);
 
 	switch (fattr->cf_mode & S_IFMT) {
 	case S_IFLNK:



