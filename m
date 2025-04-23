Return-Path: <stable+bounces-136089-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE1DDA991D7
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 17:36:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE52492509F
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 15:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 731C728EA52;
	Wed, 23 Apr 2025 15:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2kZGIrbY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30EEA2641EA;
	Wed, 23 Apr 2025 15:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745421626; cv=none; b=YajSAM1gbPeWKtq3B3cADIQ1Pw9wwnQgx8T4gfDUx2GZgXZRlK0Gr2pgkAFjKY5jIgkr2jIbSxPMtpnth+bdz8jpmmdasfWk4diVQ3a/m5eIgsDFd5QZfBssn7SwkwXFii1XOT9z07jpXVON4BpMx+ykXidNmyQUoJ5OVrxAzKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745421626; c=relaxed/simple;
	bh=eabFZxWx0pL5sBTqGlBcTqxCBMfLZzJKIUAyDGfrdNM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dbc6GXOvfxn0HhUk9Vldv68VjSpl7bjEODQucjp1qi5zZRPmZiB33rZNrr+WklSa62gGCv9LzOihOABEAcvqK9jvHibLK82K8I1vwXnTp92wBHgd5DZDfmXLj176cSNxLgXVi17y7GkWNfkufzuwG43T319hgQlCVX6k/85PPfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2kZGIrbY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5C5FC4CEE3;
	Wed, 23 Apr 2025 15:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745421626;
	bh=eabFZxWx0pL5sBTqGlBcTqxCBMfLZzJKIUAyDGfrdNM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=2kZGIrbYOtTusn2zAGKYQlqjgKJUv6CB+fWmd+CH+YK9rx/snwJR5au3hspS4m8vO
	 3Z9c09eI1CwaNez9N8qWzwbMjZTr8S2BRJqPQ06dJp/ClOlgW2ydLdAb92/EyVJjsb
	 dEA7p3MqIMfQyApjBZhZrfzkTyK5GBJkoOkSTbNs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alexandra Diupina <adiupina@astralinux.ru>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.6 201/393] cifs: avoid NULL pointer dereference in dbg call
Date: Wed, 23 Apr 2025 16:41:37 +0200
Message-ID: <20250423142651.694828499@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250423142643.246005366@linuxfoundation.org>
References: <20250423142643.246005366@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexandra Diupina <adiupina@astralinux.ru>

commit b4885bd5935bb26f0a414ad55679a372e53f9b9b upstream.

cifs_server_dbg() implies server to be non-NULL so
move call under condition to avoid NULL pointer dereference.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: e79b0332ae06 ("cifs: ignore cached share root handle closing errors")
Cc: stable@vger.kernel.org
Signed-off-by: Alexandra Diupina <adiupina@astralinux.ru>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/smb/client/smb2misc.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

--- a/fs/smb/client/smb2misc.c
+++ b/fs/smb/client/smb2misc.c
@@ -816,11 +816,12 @@ smb2_handle_cancelled_close(struct cifs_
 		WARN_ONCE(tcon->tc_count < 0, "tcon refcount is negative");
 		spin_unlock(&cifs_tcp_ses_lock);
 
-		if (tcon->ses)
+		if (tcon->ses) {
 			server = tcon->ses->server;
-
-		cifs_server_dbg(FYI, "tid=0x%x: tcon is closing, skipping async close retry of fid %llu %llu\n",
-				tcon->tid, persistent_fid, volatile_fid);
+			cifs_server_dbg(FYI,
+					"tid=0x%x: tcon is closing, skipping async close retry of fid %llu %llu\n",
+					tcon->tid, persistent_fid, volatile_fid);
+		}
 
 		return 0;
 	}



