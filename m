Return-Path: <stable+bounces-150522-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E0C8ACB8BF
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 17:45:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3056947491
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 15:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B27B42236F2;
	Mon,  2 Jun 2025 15:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sN73QNol"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E58C223327;
	Mon,  2 Jun 2025 15:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748877386; cv=none; b=mJMKrAmiRye0OzippkjzUMXC0d3h+0jLbhJshd7NrgN0WQPnaUw9GBcj2FJv2C2La3FExQY+IelZPLIJBhSVj8fqAuW8DZ1yXzIeqA87pDZ/JofTyGYif/o1xiSzTCvQVx3dG+GciYk7jkcykr8u8RsNqZQkWKZT10kPSl3bBKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748877386; c=relaxed/simple;
	bh=p6mOEcFfkWQLR7RtEt+7YjiKJ1mKDJyMBmz1Msz0YmQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B6I3oKmvgYtBRbRLiq0b5GHkf1Z04Nft5NsRYMAUx6U6JEXwIAmTYQd2vlaBXtwdO5us8cA/CzCRnod0+Gt6Xuxlo/iSEFiJEd8sESTPXnm8DM+pado060U58YTPmYvYFcBFjjuad27PV8l9xSN561uIKg5wz1IXU7qgRiasFk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sN73QNol; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71BCBC4CEEB;
	Mon,  2 Jun 2025 15:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748877385;
	bh=p6mOEcFfkWQLR7RtEt+7YjiKJ1mKDJyMBmz1Msz0YmQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sN73QNolYzNGxC6c69VzVuITLf1PKFuONTp6TvhYcDlsSGR1Ce+8kISaZzIXF5JcR
	 XZVM1ebIy1evZmWUKeN1Gm6XV9eLP2kS7P0af4iiUXB/3czcaMVqfzs3HvV0nkRqVy
	 Ez0tAgjYE264rPgYDtohqyNK8IgxpkiX359tHYYw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Wang Zhaolong <wangzhaolong1@huawei.com>,
	"Paulo Alcantara (Red Hat)" <pc@manguebit.com>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.1 261/325] smb: client: Reset all search buffer pointers when releasing buffer
Date: Mon,  2 Jun 2025 15:48:57 +0200
Message-ID: <20250602134330.381807127@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250602134319.723650984@linuxfoundation.org>
References: <20250602134319.723650984@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Wang Zhaolong <wangzhaolong1@huawei.com>

commit e48f9d849bfdec276eebf782a84fd4dfbe1c14c0 upstream.

Multiple pointers in struct cifs_search_info (ntwrk_buf_start,
srch_entries_start, and last_entry) point to the same allocated buffer.
However, when freeing this buffer, only ntwrk_buf_start was set to NULL,
while the other pointers remained pointing to freed memory.

This is defensive programming to prevent potential issues with stale
pointers. While the active UAF vulnerability is fixed by the previous
patch, this change ensures consistent pointer state and more robust error
handling.

Signed-off-by: Wang Zhaolong <wangzhaolong1@huawei.com>
Cc: stable@vger.kernel.org
Reviewed-by: Paulo Alcantara (Red Hat) <pc@manguebit.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/smb/client/readdir.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/fs/smb/client/readdir.c
+++ b/fs/smb/client/readdir.c
@@ -765,7 +765,10 @@ find_cifs_entry(const unsigned int xid,
 			else
 				cifs_buf_release(cfile->srch_inf.
 						ntwrk_buf_start);
+			/* Reset all pointers to the network buffer to prevent stale references */
 			cfile->srch_inf.ntwrk_buf_start = NULL;
+			cfile->srch_inf.srch_entries_start = NULL;
+			cfile->srch_inf.last_entry = NULL;
 		}
 		rc = initiate_cifs_search(xid, file, full_path);
 		if (rc) {



