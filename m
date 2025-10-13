Return-Path: <stable+bounces-184198-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30450BD23AB
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 11:15:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 958F83A5D42
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 09:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F06623956A;
	Mon, 13 Oct 2025 09:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="N7g9Vatq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E06B02FC86F
	for <stable@vger.kernel.org>; Mon, 13 Oct 2025 09:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760346928; cv=none; b=Fu0y1AOA3biyeNrk4kghOIVdEeVeDx6sE1Fw5sya7MGVvLnRjbWdo3uNIccgszKH5ccVdkw7HBnYL0AT9YmF+1HiCCyOBMqDrOUVwFpVhUSo1dqG+Zqilx3Dfgif5p0+U8C+mLKVFSYFpztwAoRY6g1vE8dAWNWwCbVm25IzPIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760346928; c=relaxed/simple;
	bh=c4Y4lpZnXLS9EL5bnIoiWT5a2y5d7B14ZhY9cdc6AHE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ZgAhxTtKsAhEOQcI60p0KzBNc152z4JHFfMM/HVr1U2IGJPqY/LQJ4pqjz7FoYSwsC20t4f1OYdu8FzfShXGcB32HPD9I952GTeq9IQAeF7LzlhWIFVyK0T6OMyuMlQGPFPj47fJ6NSKD1eogBVaA+F86f3xRbIb66y9gjbpJEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=N7g9Vatq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15716C4CEE7;
	Mon, 13 Oct 2025 09:15:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760346927;
	bh=c4Y4lpZnXLS9EL5bnIoiWT5a2y5d7B14ZhY9cdc6AHE=;
	h=Subject:To:Cc:From:Date:From;
	b=N7g9VatqUv/JvnycejLljp9fwuhtj8khojCUzYt3itcDcfDrXwaii6fHvDDxotZAD
	 CwZfneMoieefr5Suk7RZ+1InWfiNkUaYnqyBT4YHt3rOlSOgZUkw+VZWApjL4JMOWM
	 iFYNqZU63M0DYz3Z3H12TY4HvAg4IDzuTNzPbIxk=
Subject: FAILED: patch "[PATCH] ksmbd: fix error code overwriting in" failed to apply to 5.15-stable tree
To: matvey.kovalev@ispras.ru,linkinjeon@kernel.org,stfrench@microsoft.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 13 Oct 2025 11:15:24 +0200
Message-ID: <2025101324-echo-cardinal-3043@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 88daf2f448aad05a2e6df738d66fe8b0cf85cee0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025101324-echo-cardinal-3043@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 88daf2f448aad05a2e6df738d66fe8b0cf85cee0 Mon Sep 17 00:00:00 2001
From: Matvey Kovalev <matvey.kovalev@ispras.ru>
Date: Thu, 25 Sep 2025 15:12:34 +0300
Subject: [PATCH] ksmbd: fix error code overwriting in
 smb2_get_info_filesystem()

If client doesn't negotiate with SMB3.1.1 POSIX Extensions,
then proper error code won't be returned due to overwriting.

Return error immediately.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: e2f34481b24db ("cifsd: add server-side procedures for SMB3")
Cc: stable@vger.kernel.org
Signed-off-by: Matvey Kovalev <matvey.kovalev@ispras.ru>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index 0c069eff80b7..133ca5beb7cf 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -5629,7 +5629,8 @@ static int smb2_get_info_filesystem(struct ksmbd_work *work,
 
 		if (!work->tcon->posix_extensions) {
 			pr_err("client doesn't negotiate with SMB3.1.1 POSIX Extensions\n");
-			rc = -EOPNOTSUPP;
+			path_put(&path);
+			return -EOPNOTSUPP;
 		} else {
 			info = (struct filesystem_posix_info *)(rsp->Buffer);
 			info->OptimalTransferSize = cpu_to_le32(stfs.f_bsize);


