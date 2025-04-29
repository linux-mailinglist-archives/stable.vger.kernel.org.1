Return-Path: <stable+bounces-138404-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B125AA17E0
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 19:52:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A68318886AD
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 17:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 424902512E0;
	Tue, 29 Apr 2025 17:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="13X63qKN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF082472B9;
	Tue, 29 Apr 2025 17:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745949145; cv=none; b=J4P8fRAlLVw+D/zw4DYQHcBXymtdWMqaTIu8tnHtHiYNOQEuarOct+6v6Camv3h7jfpi/ZUNe2clRTOKmJhJ+jK/hhMH68pJYHVn8JqgQsHGfpoplzWoYSsb3Sxe5unVstXGWbgllaqjUu+W4xyujP+LO944WJwQeF/MxNsAyTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745949145; c=relaxed/simple;
	bh=0gG2fJPzE533c0pacagzgSUqxpAfmlmCSg+CZLhzAns=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jgsh6zjPbCT0HTaJDnyK/dTCNIAD73NRUdzjYJ1/Sil906wVbNMDsswrer0VY85KxAl3vVhPpaeK6s9woyZiNCcC4As8PLkvLUYO3xjSJgXbLhYneP6RAfEieTZn34VZTMKNOjhMleSveguWHjMI6Scz14Ii2puxbQrtlAYDBGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=13X63qKN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7430FC4CEE9;
	Tue, 29 Apr 2025 17:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745949144;
	bh=0gG2fJPzE533c0pacagzgSUqxpAfmlmCSg+CZLhzAns=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=13X63qKNIslWMSdpTer/03EQ0KZdF4VAy682urZW2OPD7fehcveNizIy7dimt6Yd3
	 0HDKewfEajLVKcFtST+1fvtqZhycqgTPgr6HkfAyzL/Z6esFssO1dUYwNTr1l4Q+Hj
	 jjF0LHaVWyx8a7gnGAlUSktx7P0LmQnNs7567Xpg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Paulo Alcantara (SUSE)" <pc@manguebit.com>,
	Steve French <stfrench@microsoft.com>,
	Cliff Liu <donghua.liu@windriver.com>,
	He Zhe <Zhe.He@windriver.com>
Subject: [PATCH 5.15 227/373] smb: client: fix potential deadlock when releasing mids
Date: Tue, 29 Apr 2025 18:41:44 +0200
Message-ID: <20250429161132.485852191@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250429161123.119104857@linuxfoundation.org>
References: <20250429161123.119104857@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paulo Alcantara <pc@manguebit.com>

commit e6322fd177c6885a21dd4609dc5e5c973d1a2eb7 upstream.

All release_mid() callers seem to hold a reference of @mid so there is
no need to call kref_put(&mid->refcount, __release_mid) under
@server->mid_lock spinlock.  If they don't, then an use-after-free bug
would have occurred anyways.

By getting rid of such spinlock also fixes a potential deadlock as
shown below

CPU 0                                CPU 1
------------------------------------------------------------------
cifs_demultiplex_thread()            cifs_debug_data_proc_show()
 release_mid()
  spin_lock(&server->mid_lock);
                                     spin_lock(&cifs_tcp_ses_lock)
				      spin_lock(&server->mid_lock)
  __release_mid()
   smb2_find_smb_tcon()
    spin_lock(&cifs_tcp_ses_lock) *deadlock*

Cc: stable@vger.kernel.org
Signed-off-by: Paulo Alcantara (SUSE) <pc@manguebit.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
[cifs_mid_q_entry_release() is renamed to release_mid() and
 _cifs_mid_q_entry_release() is renamed to __release_mid() by
 commit 70f08f914a37 ("cifs: remove useless DeleteMidQEntry()")
 which is integrated into v6.0, so preserve old names in v5.15.]
Signed-off-by: Cliff Liu <donghua.liu@windriver.com>
Signed-off-by: He Zhe <Zhe.He@windriver.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/cifs/cifsproto.h |    7 ++++++-
 fs/cifs/smb2misc.c  |    2 +-
 fs/cifs/transport.c |    9 +--------
 3 files changed, 8 insertions(+), 10 deletions(-)

--- a/fs/cifs/cifsproto.h
+++ b/fs/cifs/cifsproto.h
@@ -83,7 +83,7 @@ extern struct mid_q_entry *AllocMidQEntr
 					struct TCP_Server_Info *server);
 extern void DeleteMidQEntry(struct mid_q_entry *midEntry);
 extern void cifs_delete_mid(struct mid_q_entry *mid);
-extern void cifs_mid_q_entry_release(struct mid_q_entry *midEntry);
+void _cifs_mid_q_entry_release(struct kref *refcount);
 extern void cifs_wake_up_task(struct mid_q_entry *mid);
 extern int cifs_handle_standard(struct TCP_Server_Info *server,
 				struct mid_q_entry *mid);
@@ -637,4 +637,9 @@ static inline int cifs_create_options(st
 struct super_block *cifs_get_tcon_super(struct cifs_tcon *tcon);
 void cifs_put_tcon_super(struct super_block *sb);
 
+static inline void cifs_mid_q_entry_release(struct mid_q_entry *midEntry)
+{
+	kref_put(&midEntry->refcount, _cifs_mid_q_entry_release);
+}
+
 #endif			/* _CIFSPROTO_H */
--- a/fs/cifs/smb2misc.c
+++ b/fs/cifs/smb2misc.c
@@ -759,7 +759,7 @@ __smb2_handle_cancelled_cmd(struct cifs_
 {
 	struct close_cancelled_open *cancelled;
 
-	cancelled = kzalloc(sizeof(*cancelled), GFP_ATOMIC);
+	cancelled = kzalloc(sizeof(*cancelled), GFP_KERNEL);
 	if (!cancelled)
 		return -ENOMEM;
 
--- a/fs/cifs/transport.c
+++ b/fs/cifs/transport.c
@@ -75,7 +75,7 @@ AllocMidQEntry(const struct smb_hdr *smb
 	return temp;
 }
 
-static void _cifs_mid_q_entry_release(struct kref *refcount)
+void _cifs_mid_q_entry_release(struct kref *refcount)
 {
 	struct mid_q_entry *midEntry =
 			container_of(refcount, struct mid_q_entry, refcount);
@@ -155,13 +155,6 @@ static void _cifs_mid_q_entry_release(st
 	mempool_free(midEntry, cifs_mid_poolp);
 }
 
-void cifs_mid_q_entry_release(struct mid_q_entry *midEntry)
-{
-	spin_lock(&GlobalMid_Lock);
-	kref_put(&midEntry->refcount, _cifs_mid_q_entry_release);
-	spin_unlock(&GlobalMid_Lock);
-}
-
 void DeleteMidQEntry(struct mid_q_entry *midEntry)
 {
 	cifs_mid_q_entry_release(midEntry);



