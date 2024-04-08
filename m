Return-Path: <stable+bounces-37284-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F37D889C433
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 15:47:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 934221F21073
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 13:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDB0185951;
	Mon,  8 Apr 2024 13:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dVT4KxWI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3128594E;
	Mon,  8 Apr 2024 13:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712583786; cv=none; b=bUziSNTYGm0srzRkrJ7jIp0be1pyd79XqyKS+h8tyUy8oKIyG5JjCRbI9/TNHptdw8/eTlBr8teOEA5/M2B2Tiqv3nzeoMrdKsHsfMFDX9Xs69tN1SAj6zgeXMIbxtt+WjRKetcTR2tgr+V2N+Z0ZBlep82rT+XZuEMINceLfkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712583786; c=relaxed/simple;
	bh=tk2S5H29r2Mage2gYZ/5MFOFCykSzXGfUG/bV8zjnxs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WWm3M/4emCGI8jntjVHynn6ozpsMgICxK8HNvniw4ZS/1r8FmAs8r+5whSZVv1Qg8ne4LqsCYCFFG/ZnP78mN4oSc75O4KvRg0eS2KhpG09AFnu6TepjvjudoIDLaioUZhUyk/97hYpIcq27n6A6zxhaNOaq9A5QVp15t3RgjiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dVT4KxWI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 027B8C433F1;
	Mon,  8 Apr 2024 13:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712583786;
	bh=tk2S5H29r2Mage2gYZ/5MFOFCykSzXGfUG/bV8zjnxs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dVT4KxWIP0P7tkxzA7ndNDDuslWlh/dkqHEOWR2BqTJyx9J4oXF4GKKC2daumneLP
	 25N2RF2CBGJPAdc04Mq8BEdB7Di76omIGQRyRrQXHp/bmJ3t6YRviJsM1C1tbRjDSI
	 /coaNTudb3F384Z4zSH8rVyQQSxWZN+ydq2QdHBY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.8 198/273] ksmbd: dont send oplock break if rename fails
Date: Mon,  8 Apr 2024 14:57:53 +0200
Message-ID: <20240408125315.472847776@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240408125309.280181634@linuxfoundation.org>
References: <20240408125309.280181634@linuxfoundation.org>
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

6.8-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Namjae Jeon <linkinjeon@kernel.org>

commit c1832f67035dc04fb89e6b591b64e4d515843cda upstream.

Don't send oplock break if rename fails. This patch fix
smb2.oplock.batch20 test.

Cc: stable@vger.kernel.org
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/smb/server/smb2pdu.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -5632,8 +5632,9 @@ static int smb2_rename(struct ksmbd_work
 	if (!file_info->ReplaceIfExists)
 		flags = RENAME_NOREPLACE;
 
-	smb_break_all_levII_oplock(work, fp, 0);
 	rc = ksmbd_vfs_rename(work, &fp->filp->f_path, new_name, flags);
+	if (!rc)
+		smb_break_all_levII_oplock(work, fp, 0);
 out:
 	kfree(new_name);
 	return rc;



