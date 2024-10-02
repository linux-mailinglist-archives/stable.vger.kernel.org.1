Return-Path: <stable+bounces-79876-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CF0B98DAB8
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 16:24:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81EA5B24A37
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 14:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 374F81CCEDA;
	Wed,  2 Oct 2024 14:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="A79q5u22"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C4F1D0E0D;
	Wed,  2 Oct 2024 14:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727878726; cv=none; b=X6SDee8FpOqT1Kp5rFlypfCPE32Ta43e1PuyolOV/AZsKbb7sjaJ4Htkjq+wuRMxRGbYKwfl/n7HvuhFtbuNYo4oMGfesz/F9rrt6c0kYS5SNV8U4jDKurSBsoe8HC2tQRg2+VulPINzlshEeBcuDcCsgHLT3Vc3g4Rbc4NTwiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727878726; c=relaxed/simple;
	bh=IxtVWT0K+2fcjPpdZyWqadhNEnfyBCTprQPEpQBPArI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UK+JrHqKHencaAgNSNzibXqEESCj9+uv6ajb0qxBFxtbk5KVTW/zwfiZ4g/X8Q1uJHqVlTwuEoJ4o/TU2T4ZyDtGuyObT1KFGFyrsO9joSbkweJ+1fIoaNf7Wmvu2gPtoL8KorUmC7+oet/J7OeGHsE2wDObxjFo7p49ySQbaD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=A79q5u22; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2358BC4CEC2;
	Wed,  2 Oct 2024 14:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727878725;
	bh=IxtVWT0K+2fcjPpdZyWqadhNEnfyBCTprQPEpQBPArI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A79q5u22yXa6iun5D/emb2j5jTyGiLLRCInuteVUkzAq+Q1+rXcVhCcg4WDj5+pTw
	 WnrovHNe7A48Yf1eandyBkl0KFelZyqgFqSvfu5636PyvkvWQSazrD3GuW6Iq2QRQj
	 1yzda7mRKTOx8kFJR9JmQr9S/w77FS09kdY1DU8w=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Hobin Woo <hobin.woo@samsung.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.10 504/634] ksmbd: make __dir_empty() compatible with POSIX
Date: Wed,  2 Oct 2024 15:00:04 +0200
Message-ID: <20241002125830.995271785@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241002125811.070689334@linuxfoundation.org>
References: <20241002125811.070689334@linuxfoundation.org>
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

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hobin Woo <hobin.woo@samsung.com>

commit ca4974ca954561e79f8871d220bb08f14f64f57c upstream.

Some file systems may not provide dot (.) and dot-dot (..) as they are
optional in POSIX. ksmbd can misjudge emptiness of a directory in those
file systems, since it assumes there are always at least two entries:
dot and dot-dot.
Just don't count dot and dot-dot.

Cc: stable@vger.kernel.org # v6.1+
Signed-off-by: Hobin Woo <hobin.woo@samsung.com>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/smb/server/vfs.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

--- a/fs/smb/server/vfs.c
+++ b/fs/smb/server/vfs.c
@@ -1115,9 +1115,10 @@ static bool __dir_empty(struct dir_conte
 	struct ksmbd_readdir_data *buf;
 
 	buf = container_of(ctx, struct ksmbd_readdir_data, ctx);
-	buf->dirent_count++;
+	if (!is_dot_dotdot(name, namlen))
+		buf->dirent_count++;
 
-	return buf->dirent_count <= 2;
+	return !buf->dirent_count;
 }
 
 /**
@@ -1137,7 +1138,7 @@ int ksmbd_vfs_empty_dir(struct ksmbd_fil
 	readdir_data.dirent_count = 0;
 
 	err = iterate_dir(fp->filp, &readdir_data.ctx);
-	if (readdir_data.dirent_count > 2)
+	if (readdir_data.dirent_count)
 		err = -ENOTEMPTY;
 	else
 		err = 0;



