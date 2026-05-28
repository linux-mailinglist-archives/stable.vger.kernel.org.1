Return-Path: <stable+bounces-255105-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CIkhNDCdGGr+lQgAu9opvQ
	(envelope-from <stable+bounces-255105-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 21:53:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 64AE35F75E9
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 21:53:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5E502302F6A6
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 19:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3E8940910C;
	Thu, 28 May 2026 19:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="coCnVppe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA67E3126D0;
	Thu, 28 May 2026 19:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779997981; cv=none; b=qVRIai/S7DiYeI7pw5g9FvuevnHqZuURz4/1GipOzv5ByTJoCN2EIK0dtE1fQPhPM+ZuYVamiYExEnu7LSM83ifVRTsBfwlAGvok8GehCkofGvZXIBkrTt0/Isxvl2F6vDzPaYWV9/Hn/HfMda5wWnNpEQ0gQRgxerGxU6POwsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779997981; c=relaxed/simple;
	bh=EUhm6zG65TYYMLOAz1eTu2DE1K9SI0nC71588bYey7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=avBORPKgay18636iDT5JNBrmGIFdHV8U3fo9yU4GTQr1ic4pwG6xtuWX4HsG7D7KrdYAZUEk1Q8JKdrtqA2EqjumiEaunbrqK7rsPX/GN1ecx0iKcacVUwQYUruOTNmLSEUd6lJVE9XmZuEGTEHB5InWQ5UWzEyp2ag5VV2FNA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=coCnVppe; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E05B51F000E9;
	Thu, 28 May 2026 19:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779997980;
	bh=WUI71er2/PWqiK9JltqVPPG9UCwvh1+jXf46gaQFauQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=coCnVppe5e8/8gVXmgDg0fMfnPQcq6il/bLyRtAnuOBkDRzAPSD+DqOHU5CAHuByT
	 HVVyCPOg2MOkb5esFkAYA1OJKMEDrWq8xxjHOLggt1/H/VIYNLH49Ws1GIKd7DYOeV
	 v98gZSDR9KYtcBWV860p5PCzfFwmdPgp1eyQqbgc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jeremy Laratro <research@aradex.io>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 7.0 012/461] ksmbd: fix null pointer dereference in proc_show_files()
Date: Thu, 28 May 2026 21:42:21 +0200
Message-ID: <20260528194647.207361766@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528194646.819809818@linuxfoundation.org>
References: <20260528194646.819809818@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-255105-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,aradex.io:email]
X-Rspamd-Queue-Id: 64AE35F75E9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jeremy Laratro <research@aradex.io>

commit 904901561e61a2b559070b20c74a8c95491f30aa upstream.

When a SMB2 client opens a file with a durable v2 handle and then issues
SMB2 SESSION_LOGOFF, session_fd_check() clears fp->tcon = NULL on the
reconnectable file pointer but leaves the fp registered in global_ft.idr
until the durable scavenger fires (up to fp->durable_timeout seconds
later).

During that window any read of /proc/fs/ksmbd/files (mode 0400) panics
the kernel because proc_show_files() walks global_ft.idr and
unconditionally dereferences fp->tcon->id with no NULL guard.

Reproducer requires only a successful SMB2 SESSION_SETUP and a share
configured with 'durable handles = yes'. KASAN report on mainline
70390501d194:

  general protection fault, probably for non-canonical address
  0xdffffc0000000000: 0000 [#1] SMP KASAN PTI
  KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
  RIP: 0010:proc_show_files+0x118/0x740
  Call Trace:
   proc_show_files+0x118/0x740
   seq_read_iter+0x4ef/0xe10
   proc_reg_read_iter+0x1b7/0x280
   ...

Guard the dereference. A durable-disconnected fp legitimately has no
tcon; report its tree id as 0 rather than oopsing.

Fixes: b38f99c1217a ("ksmbd: add procfs interface for runtime monitoring and statistics")
Cc: stable@vger.kernel.org
Signed-off-by: Jeremy Laratro <research@aradex.io>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/smb/server/vfs_cache.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/smb/server/vfs_cache.c b/fs/smb/server/vfs_cache.c
index 354c4d8a1cfb..913164c958b1 100644
--- a/fs/smb/server/vfs_cache.c
+++ b/fs/smb/server/vfs_cache.c
@@ -81,7 +81,7 @@ static int proc_show_files(struct seq_file *m, void *v)
 	read_lock(&global_ft.lock);
 	idr_for_each_entry(global_ft.idr, fp, id) {
 		seq_printf(m, "%#-10x %#-10llx %#-10llx %#-10x",
-			   fp->tcon->id,
+			   fp->tcon ? fp->tcon->id : 0,
 			   fp->persistent_id,
 			   fp->volatile_id,
 			   atomic_read(&fp->refcount));
-- 
2.54.0




