Return-Path: <stable+bounces-218048-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GHenAAJQnmlIUgQAu9opvQ
	(envelope-from <stable+bounces-218048-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:27:30 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 296B018EAB7
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:27:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C446B3002908
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02C82251795;
	Wed, 25 Feb 2026 01:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aydsd1wb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAAA51D5ABA;
	Wed, 25 Feb 2026 01:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771982813; cv=none; b=gd4f8RvUI8wSd016G+QY+pKo5meGGz4wxfKLiw5ROgtzsR+eZP9yTvsCZHTVjuNq8o+mJDBTkj8sJRG2TIWh8H5sCnvzi63ufNC75wzc+Nq7goj6Ezk6PmIy6JaRv1JCveSbD1hbAgseP+i0O3sjv/O0Ng573k4U/c2cF8U7NOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771982813; c=relaxed/simple;
	bh=vbwopU/Cdr6Jgc+Fl1QEY/rc0qMpWfLxQOjmMZzylB4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XB+8EanU6zX6M8wmXt8fAK2EZ4arYj/h/2UnAwEtKe2H8MV3INbTMGEoGQ/IMIfPH+/hAUWJbWGBZsnkvKOjfHGpZCJEYJZbyVq2EMp3QFL58zTxsrKAcHpo8L3WxIh4I8My7zZCya98d3pzlS36rY9n6FPpaCRFF3w+G18gfVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aydsd1wb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D836C116D0;
	Wed, 25 Feb 2026 01:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771982813;
	bh=vbwopU/Cdr6Jgc+Fl1QEY/rc0qMpWfLxQOjmMZzylB4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aydsd1wbMkR92KXSIUZMXkCjKLFVm99kEsRw3V5yh2mQphol7Ke4rM/oCYLZXexjP
	 mSE/E71LwpNJ2Ktfh6A7xbsAnjivO7U305Y8X0lcdYubk2RBcnBN4Nbk7T9DS8upBI
	 72xOsmE6wkDjl2MCxYgC3rMmyE5tMS+FGtZDQdKM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Amir Goldstein <amir73il@gmail.com>,
	Jan Kara <jack@suse.cz>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 011/781] fs: move initializing f_mode before file_ref_init()
Date: Tue, 24 Feb 2026 17:12:00 -0800
Message-ID: <20260225012359.976793027@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225012359.695468795@linuxfoundation.org>
References: <20260225012359.695468795@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-218048-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,suse.cz,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 296B018EAB7
X-Rspamd-Action: no action

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Amir Goldstein <amir73il@gmail.com>

[ Upstream commit 1219e0feaefc9697f738b223540e8e8906291cb3 ]

The comment above file_ref_init() says:
"We're SLAB_TYPESAFE_BY_RCU so initialize f_ref last."
but file_set_fsnotify_mode() was added after file_ref_init().

Move it right after setting f_mode, where it makes more sense.

Fixes: 711f9b8fbe4f4 ("fsnotify: disable pre-content and permission events by default")
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
Link: https://patch.msgid.link/20260109211536.3565697-1-amir73il@gmail.com
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/file_table.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/file_table.c b/fs/file_table.c
index cd4a3db4659ac..34244fccf2edf 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -176,6 +176,11 @@ static int init_file(struct file *f, int flags, const struct cred *cred)
 
 	f->f_flags	= flags;
 	f->f_mode	= OPEN_FMODE(flags);
+	/*
+	 * Disable permission and pre-content events for all files by default.
+	 * They may be enabled later by fsnotify_open_perm_and_set_mode().
+	 */
+	file_set_fsnotify_mode(f, FMODE_NONOTIFY_PERM);
 
 	f->f_op		= NULL;
 	f->f_mapping	= NULL;
@@ -197,11 +202,6 @@ static int init_file(struct file *f, int flags, const struct cred *cred)
 	 * refcount bumps we should reinitialize the reused file first.
 	 */
 	file_ref_init(&f->f_ref, 1);
-	/*
-	 * Disable permission and pre-content events for all files by default.
-	 * They may be enabled later by fsnotify_open_perm_and_set_mode().
-	 */
-	file_set_fsnotify_mode(f, FMODE_NONOTIFY_PERM);
 	return 0;
 }
 
-- 
2.51.0




