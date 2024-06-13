Return-Path: <stable+bounces-50894-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E202906D53
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 14:00:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8581282C89
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 12:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CDE6146D69;
	Thu, 13 Jun 2024 11:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UQdCb+Em"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5AB21386DF;
	Thu, 13 Jun 2024 11:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718279699; cv=none; b=KB51JEIChMSwdVkQQkZcliDdtnAlJRtJ4c0JxoRLJGr4qrzvjCKA4zJr6YFEX0PBO2gpGI5YptCwgqKOTTjK5ldpW6y2MQErbD9ZnJgSkC+/PS4fQbvS4b+ovAFwSeHh9yW7oQIE0B0C9YLjLM0BTdXlJHRW4e6xFGSh7Cd92qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718279699; c=relaxed/simple;
	bh=f+MEg7pYCWnOwHq4pE8oww18GUYbDU869s9QgfcLooc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KWQIp/zF+WNyMLPyP4s8iU3e15hyR61dYIAPzWk25cUxQN9K3qNJL4iCbW5eJL6qOcYfi2NYCyBAu5Bi1xdLOZ4A6MNOeAm925a0Zn9cuNJHL5qgg9kzeihk0VPNQlK4mgCYkE+EoK42UuWi3f0WrgREVyDhnPSKOxifurEosN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UQdCb+Em; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D873C2BBFC;
	Thu, 13 Jun 2024 11:54:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718279699;
	bh=f+MEg7pYCWnOwHq4pE8oww18GUYbDU869s9QgfcLooc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UQdCb+Em8u6e8XXng7ZVa1jX52k2LGsri7JaC62MIQrozfQXS8Fe//sSJqinytXTd
	 sl2fTezDiO778A01MFpu6YTZz8WuFJgV1e7P8dQXnoa1MSimn/ZEEcqBFYxHX6U2tH
	 xdHl9zOnMmtRQnrn9+VUOntAkQNv/SzT7rCdRQfQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Enzo Matsumiya <ematsumiya@suse.de>,
	Shyam Prasad N <sprasad@microsoft.com>,
	"Paulo Alcantara (Red Hat)" <pc@manguebit.com>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.9 157/157] smb: client: fix deadlock in smb2_find_smb_tcon()
Date: Thu, 13 Jun 2024 13:34:42 +0200
Message-ID: <20240613113233.481331026@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240613113227.389465891@linuxfoundation.org>
References: <20240613113227.389465891@linuxfoundation.org>
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

6.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Enzo Matsumiya <ematsumiya@suse.de>

commit 02c418774f76a0a36a6195c9dbf8971eb4130a15 upstream.

Unlock cifs_tcp_ses_lock before calling cifs_put_smb_ses() to avoid such
deadlock.

Cc: stable@vger.kernel.org
Signed-off-by: Enzo Matsumiya <ematsumiya@suse.de>
Reviewed-by: Shyam Prasad N <sprasad@microsoft.com>
Reviewed-by: Paulo Alcantara (Red Hat) <pc@manguebit.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/smb/client/smb2transport.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/smb/client/smb2transport.c
+++ b/fs/smb/client/smb2transport.c
@@ -216,8 +216,8 @@ smb2_find_smb_tcon(struct TCP_Server_Inf
 	}
 	tcon = smb2_find_smb_sess_tcon_unlocked(ses, tid);
 	if (!tcon) {
-		cifs_put_smb_ses(ses);
 		spin_unlock(&cifs_tcp_ses_lock);
+		cifs_put_smb_ses(ses);
 		return NULL;
 	}
 	spin_unlock(&cifs_tcp_ses_lock);



