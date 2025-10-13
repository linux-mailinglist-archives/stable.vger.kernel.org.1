Return-Path: <stable+bounces-184410-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 32DC5BD40ED
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 17:22:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 638AD503868
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 15:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E68630CDB9;
	Mon, 13 Oct 2025 14:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hIJ8J3md"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B662798FA;
	Mon, 13 Oct 2025 14:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760367355; cv=none; b=f2ylpBRR+aTeMntqpRy13Hsmd7Znw3PJOOhDVG2mXIzni0uyX8v8swdDv1LWkcz5DXbCsLJpVo1/sDp0sPMnkgMDGq8EvldyP6HW+aW6yRcbkaC8TOWkTL2c/26ThAUPuaoFrfP3Xtn6VGIM5+cLd4EDqftrO4vf5GCyeuBsURw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760367355; c=relaxed/simple;
	bh=jCu5KqEwKF3xDmmXm1tuvl1mNDZK33ESROoacAATyOI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AuOAXi3VwBjSp5AU7Z/FZFtzUU6v+gnAZqy/Ta1H40TfdYORXexIOdMTNV1z3ter1Wx6wOhWRp8I9/reoww6jcjLSJG8xWaEcMbf7A/1Xx678CFA6ndkwLSgfg657UF1EQRvm8Y7C+qN87iBpNC6O8E7x7WMweKpgx3/XfAjOzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hIJ8J3md; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47809C4CEE7;
	Mon, 13 Oct 2025 14:55:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760367355;
	bh=jCu5KqEwKF3xDmmXm1tuvl1mNDZK33ESROoacAATyOI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hIJ8J3mdyV1e8rXDwEvDArYQwB5dAMtrdwFI42p+D1YeqVvc2uZJRIxHScU+F0ajg
	 0lsuoTqL7GQim4jly/i9EOnDUVP7b+72MwB9VHGY4s4U+FnOe6RrU1EfvvzWBAp6/N
	 G8aKX2pSLSCE/wwwlBgiL/znq6v9Pa8PWGBQSeZc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Matvey Kovalev <matvey.kovalev@ispras.ru>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.1 180/196] ksmbd: fix error code overwriting in smb2_get_info_filesystem()
Date: Mon, 13 Oct 2025 16:45:53 +0200
Message-ID: <20251013144321.206521786@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251013144314.549284796@linuxfoundation.org>
References: <20251013144314.549284796@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Matvey Kovalev <matvey.kovalev@ispras.ru>

commit 88daf2f448aad05a2e6df738d66fe8b0cf85cee0 upstream.

If client doesn't negotiate with SMB3.1.1 POSIX Extensions,
then proper error code won't be returned due to overwriting.

Return error immediately.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: e2f34481b24db ("cifsd: add server-side procedures for SMB3")
Cc: stable@vger.kernel.org
Signed-off-by: Matvey Kovalev <matvey.kovalev@ispras.ru>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/smb/server/smb2pdu.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -5233,7 +5233,8 @@ static int smb2_get_info_filesystem(stru
 
 		if (!work->tcon->posix_extensions) {
 			pr_err("client doesn't negotiate with SMB3.1.1 POSIX Extensions\n");
-			rc = -EOPNOTSUPP;
+			path_put(&path);
+			return -EOPNOTSUPP;
 		} else {
 			info = (struct filesystem_posix_info *)(rsp->Buffer);
 			info->OptimalTransferSize = cpu_to_le32(stfs.f_bsize);



