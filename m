Return-Path: <stable+bounces-87314-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96B439A6464
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 12:46:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DE8B1F21189
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 10:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F03021EABBC;
	Mon, 21 Oct 2024 10:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DeYCSEwg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81DD1EABA6;
	Mon, 21 Oct 2024 10:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729507234; cv=none; b=dXx2m4MU79g5CVLOhoTE2ORdrYDN7z7hWMDLmDd3Wl1m4fRBOD6AnnGi5Km6amzQ/PPx5N6vcOlp0o5ZVl3AsQtXvUkCLNSfGaEu4aikJYu3bi6wPX25d0nJFtSW4zysLg9e+4dBLj90uqsNGw/8kBcsvE4aq8YRblGr/FEWAnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729507234; c=relaxed/simple;
	bh=7NEvsXqaOcs6tw+RnUQvLa49NWAw3lDYM2DWbEduj6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SYvEKKA/FA9KfxHl5XK52Wp/51sz0RPFqzEwN9VCquMXFhKyefR5XmWO5EKADZ/clG9oYj+SMaTB7yz7ljWugc+34LqoaWIApOixHJLyvx2byEnwXf+cFrjTIT7JJM1ecwPiTEJmy6I52jpKh3DfWuaK7L5HwGjySgrowgiULCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DeYCSEwg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28103C4CEC3;
	Mon, 21 Oct 2024 10:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1729507234;
	bh=7NEvsXqaOcs6tw+RnUQvLa49NWAw3lDYM2DWbEduj6Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DeYCSEwgsXXc/sEK4CizzfiMgWoaPxmOMKeF1YAVI93sSuBDzHqxKUcAr5yAcZU/F
	 Jy+me376SDfsVFpZV1zGIZUfzSEjy7mZ3C7eHnFDwGri09AlqkLUuthZF7HF+DiQrF
	 evfWXJ715ziYx75vgGlciGiZoADGgp1hXsNsD2lQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jan Kara <jack@suse.cz>,
	Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Subject: [PATCH 6.1 10/91] udf: Provide function to mark entry as deleted using new directory iteration code
Date: Mon, 21 Oct 2024 12:24:24 +0200
Message-ID: <20241021102250.207121646@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241021102249.791942892@linuxfoundation.org>
References: <20241021102249.791942892@linuxfoundation.org>
User-Agent: quilt/0.67
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

From: Jan Kara <jack@suse.cz>

[ Upstream commit 4cca7e3df7bea8661a0c2a70c0d250e9aa5cedb4 ]

Provide function udf_fiiter_delete_entry() to mark directory entry as
deleted using new directory iteration code.

Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/udf/namei.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

--- a/fs/udf/namei.c
+++ b/fs/udf/namei.c
@@ -714,6 +714,16 @@ out_ok:
 	return fi;
 }
 
+static void udf_fiiter_delete_entry(struct udf_fileident_iter *iter)
+{
+	iter->fi.fileCharacteristics |= FID_FILE_CHAR_DELETED;
+
+	if (UDF_QUERY_FLAG(iter->dir->i_sb, UDF_FLAG_STRICT))
+		memset(&iter->fi.icb, 0x00, sizeof(struct long_ad));
+
+	udf_fiiter_write_fi(iter, NULL);
+}
+
 static int udf_delete_entry(struct inode *inode, struct fileIdentDesc *fi,
 			    struct udf_fileident_bh *fibh,
 			    struct fileIdentDesc *cfi)



