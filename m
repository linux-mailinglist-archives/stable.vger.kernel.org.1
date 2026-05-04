Return-Path: <stable+bounces-243240-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KEtEOQWp+GmdxgIAu9opvQ
	(envelope-from <stable+bounces-243240-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:11:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D65E4BEB66
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:11:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6EB3D30216FD
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 14:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2974F3DDDDF;
	Mon,  4 May 2026 14:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dRAetAll"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD328347BA9;
	Mon,  4 May 2026 14:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777903377; cv=none; b=NknRAwYFGr99whsdN9BquLv5t3rMsHPuLFQoHVxGqxu7ufaMYw/+gX53YMhSrRdIWTz8TFwI1ki4aU0LP/DY4OKSCBXtBeBZwXByIQ1RjyG5Ozcl1xevxx5QqNmeA9SW/QmUK3KKBD2EHso1MevZq4OM8WG1RVh2BzTW1oI3DFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777903377; c=relaxed/simple;
	bh=XW27s83QbpkYHYPx44Tj1CSzLwrZk0Ooa/iuY+NtbFE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C43Cn0sti7WJKozT/CJo7A4dp/3Nfmuu4eYoeyETS/eYuvh4My9ItIkbf/XzJZQfCEt4oAuTcDSKmZjXYd07TkrtbJHxJOgOpy9clBJyJ1bmtZ4kRXfX9Tnk5s6dPiu3vtFYllztYgeHyDyxYjfeynHMJ+b4IB2o5Kx7eoh2rM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dRAetAll; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 468C6C2BCB8;
	Mon,  4 May 2026 14:02:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777903377;
	bh=XW27s83QbpkYHYPx44Tj1CSzLwrZk0Ooa/iuY+NtbFE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dRAetAllAq+htXcFyETMlDdANG8ftO+M729pXDPsc1QlOlR8ZRkd/5W+r6lCbVU23
	 6N9cvRzSlVip2qiYfc1eYtI2UyTp4SK5bX7DcqFDJ67zTwJbv4aW+MPTOgPKmdB1Oi
	 3puzpnRlCsi0tTdo5pyl2Ew/lPIeaurpQ8bYme9A=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-unionfs@vger.kernel.org,
	linux-erofs@lists.ozlabs.org,
	Amir Goldstein <amir73il@gmail.com>,
	Serge Hallyn <serge@hallyn.com>,
	Paul Moore <paul@paul-moore.com>
Subject: [PATCH 7.0 168/307] fs: prepare for adding LSM blob to backing_file
Date: Mon,  4 May 2026 15:50:53 +0200
Message-ID: <20260504135149.185981479@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260504135142.814938198@linuxfoundation.org>
References: <20260504135142.814938198@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 0D65E4BEB66
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,vger.kernel.org,lists.ozlabs.org,gmail.com,hallyn.com,paul-moore.com];
	TAGGED_FROM(0.00)[bounces-243240-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[paul-moore.com:email,hallyn.com:email,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,ozlabs.org:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Amir Goldstein <amir73il@gmail.com>

commit 880bd496ec72a6dcb00cb70c430ef752ba242ae7 upstream.

In preparation to adding LSM blob to backing_file struct, factor out
helpers init_backing_file() and backing_file_free().

Cc: stable@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-unionfs@vger.kernel.org
Cc: linux-erofs@lists.ozlabs.org
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
Reviewed-by: Serge Hallyn <serge@hallyn.com>
[PM: use the term "LSM blob", fix comment style to match file]
Signed-off-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/file_table.c |   22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -66,6 +66,12 @@ void backing_file_set_user_path(struct f
 }
 EXPORT_SYMBOL_GPL(backing_file_set_user_path);
 
+static inline void backing_file_free(struct backing_file *ff)
+{
+	path_put(&ff->user_path);
+	kmem_cache_free(bfilp_cachep, ff);
+}
+
 static inline void file_free(struct file *f)
 {
 	security_file_free(f);
@@ -73,8 +79,7 @@ static inline void file_free(struct file
 		percpu_counter_dec(&nr_files);
 	put_cred(f->f_cred);
 	if (unlikely(f->f_mode & FMODE_BACKING)) {
-		path_put(backing_file_user_path(f));
-		kmem_cache_free(bfilp_cachep, backing_file(f));
+		backing_file_free(backing_file(f));
 	} else {
 		kmem_cache_free(filp_cachep, f);
 	}
@@ -283,6 +288,12 @@ struct file *alloc_empty_file_noaccount(
 	return f;
 }
 
+static int init_backing_file(struct backing_file *ff)
+{
+	memset(&ff->user_path, 0, sizeof(ff->user_path));
+	return 0;
+}
+
 /*
  * Variant of alloc_empty_file() that allocates a backing_file container
  * and doesn't check and modify nr_files.
@@ -305,7 +316,14 @@ struct file *alloc_empty_backing_file(in
 		return ERR_PTR(error);
 	}
 
+	/* The f_mode flags must be set before fput(). */
 	ff->file.f_mode |= FMODE_BACKING | FMODE_NOACCOUNT;
+	error = init_backing_file(ff);
+	if (unlikely(error)) {
+		fput(&ff->file);
+		return ERR_PTR(error);
+	}
+
 	return &ff->file;
 }
 EXPORT_SYMBOL_GPL(alloc_empty_backing_file);



