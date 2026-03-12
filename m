Return-Path: <stable+bounces-225060-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qMAgOvMfs2l/SQAAu9opvQ
	(envelope-from <stable+bounces-225060-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 21:20:03 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 94CC1278CC3
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 21:20:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 85FCF3028F43
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 20:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC664347503;
	Thu, 12 Mar 2026 20:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fnlDpk4J"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD4E30DD3C;
	Thu, 12 Mar 2026 20:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773346799; cv=none; b=SRCEHYA4x4pOucAEXn1+pPz+fawCSyLYfpluzgbxq0PU1rLj5nt7YJU6m08hXJ/LCHv3pAT5mpvKEn6oB9NKscb5P7nYNxDjdT39Yc+1qv1mlWFdo3D3y64tQK1MPtvFZiwTnb6XAuUu42pqJ5AClTFXHrhnA6Lrb8KErx7FvIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773346799; c=relaxed/simple;
	bh=HG+4TMxyC74tYQAC4r974rXqAh7aYF/T34uFF0U+vxg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bywxaOaBjRctimvX0ffW+LTMNC+2WmKEjo+bijMGpgA+Ddux7WuY1WwuxSq084H8VMbqRwUNieTtCM/aL9wI73teRNtiT540yXxOLTMQN7RQcrrBgrk2IHBLCwK7DubgvbTKICBf3NGRY/FspRojECQ5nxfpFYEBJ4TTS9oFTdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fnlDpk4J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95EE3C4CEF7;
	Thu, 12 Mar 2026 20:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773346799;
	bh=HG+4TMxyC74tYQAC4r974rXqAh7aYF/T34uFF0U+vxg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fnlDpk4JyiNpwr5QoGKoGJ8P4L4O2Iaqf4GsxlYY65W1A1o9Tk343/pA7KvDg+/5w
	 Gj3wMBQWaRLU8oV0b5TM7phCq6DA2RZTk8eV5TnmavfSo3oZdPQZl/pKFy8DYXXT3Z
	 icMHlBB7Vdvz6/rhmyQSEBMnD96agW0klqqeWNyA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Christian Brauner <brauner@kernel.org>
Subject: [PATCH 6.12 127/265] namespace: fix proc mount iteration
Date: Thu, 12 Mar 2026 21:08:34 +0100
Message-ID: <20260312201022.837206352@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260312201018.128816016@linuxfoundation.org>
References: <20260312201018.128816016@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-225060-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: 94CC1278CC3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christian Brauner <brauner@kernel.org>

commit 4a403d7aa9074f527f064ef0806aaab38d14b07c upstream.

The m->index isn't updated when m->show() overflows and retains its
value before the current mount causing a restart to start at the same
value. If that happens in short order to due a quickly expanding mount
table this would cause the same mount to be shown again and again.

Ensure that *pos always equals the mount id of the mount that was
returned by start/next. On restart after overflow mnt_find_id_at(*pos)
finds the exact mount. This should avoid duplicates, avoid skips and
should handle concurrent modification just fine.

Cc: <stable@vger.kernel.org>
Fixed: 2eea9ce4310d8 ("mounts: keep list of mounts in an rbtree")
Link: https://patch.msgid.link/20260129-geleckt-treuhand-4bb940acacd9@brauner
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/namespace.c |   20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -1590,23 +1590,33 @@ static struct mount *mnt_find_id_at_reve
 static void *m_start(struct seq_file *m, loff_t *pos)
 {
 	struct proc_mounts *p = m->private;
+	struct mount *mnt;
 
 	down_read(&namespace_sem);
 
-	return mnt_find_id_at(p->ns, *pos);
+	mnt = mnt_find_id_at(p->ns, *pos);
+	if (mnt)
+		*pos = mnt->mnt_id_unique;
+	return mnt;
 }
 
 static void *m_next(struct seq_file *m, void *v, loff_t *pos)
 {
-	struct mount *next = NULL, *mnt = v;
+	struct mount *mnt = v;
 	struct rb_node *node = rb_next(&mnt->mnt_node);
 
-	++*pos;
 	if (node) {
-		next = node_to_mount(node);
+		struct mount *next = node_to_mount(node);
 		*pos = next->mnt_id_unique;
+		return next;
 	}
-	return next;
+
+	/*
+	 * No more mounts. Set pos past current mount's ID so that if
+	 * iteration restarts, mnt_find_id_at() returns NULL.
+	 */
+	*pos = mnt->mnt_id_unique + 1;
+	return NULL;
 }
 
 static void m_stop(struct seq_file *m, void *v)



