Return-Path: <stable+bounces-125876-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0C13A6D7D8
	for <lists+stable@lfdr.de>; Mon, 24 Mar 2025 10:49:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69DC51685E4
	for <lists+stable@lfdr.de>; Mon, 24 Mar 2025 09:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56FEC143895;
	Mon, 24 Mar 2025 09:49:00 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EDA010F9
	for <stable@vger.kernel.org>; Mon, 24 Mar 2025 09:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742809740; cv=none; b=rg+IhNIuiUKW1I/uI1Nw3Sj7VZNWufQ526ux5Rx6UN29sKmUL2KAq8eV2BP4qvk28yBLfPbGXk+ZYYX33NcXiVY4M9Os7uks1MjrtAMrQBVf2Wq4LrN+rB29LibJB0fHlUpua9dB8sV7GZtaZQlYutRenRON8rbQkGjDdMIa00A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742809740; c=relaxed/simple;
	bh=gXvZ2F7TsAu/aFx7uGjtTdvyEkExAOzgbPcJN5SxrYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EW7uhzg1loSF+6A/vQtRrxeQkrwjIvJo2KeZTjMNrPBDII7UtVRUQmhNGn+vsmyVzbr0Cb0kOKZlT0M/qWo6OZYOcF8exLKZae0O+Yni4BMt7CWPEDLf8bBvMAdMzSwn6oiIuqTkJC/qW0xZjBcvnbaD/Mu5Lor8QWIYGKjWnNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B903221172;
	Mon, 24 Mar 2025 09:48:56 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9005113874;
	Mon, 24 Mar 2025 09:48:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id UFbYIYgq4Wf3aAAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Mon, 24 Mar 2025 09:48:56 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: jfalempe@redhat.com,
	airlied@redhat.com
Cc: dri-devel@lists.freedesktop.org,
	Thomas Zimmermann <tzimmermann@suse.de>,
	stable@vger.kernel.org
Subject: [PATCH 1/3] drm/ast: Fix comment on modeset lock
Date: Mon, 24 Mar 2025 10:44:09 +0100
Message-ID: <20250324094520.192974-2-tzimmermann@suse.de>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250324094520.192974-1-tzimmermann@suse.de>
References: <20250324094520.192974-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Spam-Score: -4.00
X-Spam-Flag: NO
X-Rspamd-Queue-Id: B903221172
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org

The ast driver protects the commit tail against concurrent reads
of the display modes by acquiring a lock. The comment is misleading
as the lock is not released in atomic_flush, but at the end of the
commit-tail helper. Rewrite the comment.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Fixes: 1fe182154984 ("drm/ast: Acquire I/O-register lock in atomic_commit_tail function")
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Jocelyn Falempe <jfalempe@redhat.com>
Cc: Dave Airlie <airlied@redhat.com>
Cc: dri-devel@lists.freedesktop.org
Cc: <stable@vger.kernel.org> # v6.2+
---
 drivers/gpu/drm/ast/ast_mode.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/ast/ast_mode.c b/drivers/gpu/drm/ast/ast_mode.c
index 4cac5c7f4547..20fbea11b710 100644
--- a/drivers/gpu/drm/ast/ast_mode.c
+++ b/drivers/gpu/drm/ast/ast_mode.c
@@ -939,9 +939,9 @@ static void ast_mode_config_helper_atomic_commit_tail(struct drm_atomic_state *s
 
 	/*
 	 * Concurrent operations could possibly trigger a call to
-	 * drm_connector_helper_funcs.get_modes by trying to read the
-	 * display modes. Protect access to I/O registers by acquiring
-	 * the I/O-register lock. Released in atomic_flush().
+	 * drm_connector_helper_funcs.get_modes by reading the display
+	 * modes. Protect access to registers by acquiring the modeset
+	 * lock.
 	 */
 	mutex_lock(&ast->modeset_lock);
 	drm_atomic_helper_commit_tail(state);
-- 
2.48.1


