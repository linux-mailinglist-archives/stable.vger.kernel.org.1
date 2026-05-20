Return-Path: <stable+bounces-251550-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gHBmOvT4DWqq5AUAu9opvQ
	(envelope-from <stable+bounces-251550-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:09:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 077015956F9
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:09:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B9F57309D954
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5E18356745;
	Wed, 20 May 2026 17:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zeRA90KW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E40A28DC4;
	Wed, 20 May 2026 17:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779298271; cv=none; b=EEhzR4iK3wC3XBGCpMA5SATETl64mUgrPX6vsIaqLLotsYTts6hkt7oTHdrxczw/bIsfyNM5CaGK/nAI0OEZpNtLOvbFaECj1Iu19iOZYAys91U/OixU6X4Ns4mOgGle8n6SZKSMbRqf6JV43b1v7U6+P5l17V01HI6O+co86OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779298271; c=relaxed/simple;
	bh=TGJSEPiiuYxUxry9V/xKKs6XDlQQIvRQev1wJPA8tFs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C3XBKTAUPRctyjznXRBTTfJupJPWfXV2Qag2NnmLiOGlwMpy4oxvzXqzXWr+z84s3ZGbpwsG+txOudR/3wfqLA5rBDsDD/pqxSdbOzD5J1d/tC25tepwL/bFN9Bgf2Si6In+Qkt8aEcVW20wkEnzNtabOSWX+4ziNTajZhN9dHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zeRA90KW; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10AFB1F000E9;
	Wed, 20 May 2026 17:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779298270;
	bh=XfX8sdYrX/7ZPnn8fAnTstuVv1HEGZ5jCi6+tVtLa9s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=zeRA90KWhV/sv+JYsWEy/jRLMt5JRhirfwWaF/FemU+wi3RzZuPcKc4Y3NjqMXdw6
	 bwO++DCijNNOhd01HeXANbZvIrHSS/2BBpGj6AUeAG+pq8F1H5yvF9pZvdFjHtacC+
	 w0nvyirU3S8hAeAGEQNnkgmtsISWxP5PUoKQ4iiQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Miklos Szeredi <miklos@szeredi.hu>,
	Luis Henriques <luis@igalia.com>,
	Miklos Szeredi <mszeredi@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 345/957] dcache: export shrink_dentry_list() and add new helper d_dispose_if_unused()
Date: Wed, 20 May 2026 18:13:48 +0200
Message-ID: <20260520162142.013144340@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162134.554764788@linuxfoundation.org>
References: <20260520162134.554764788@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-251550-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,igalia.com:email,szeredi.hu:email]
X-Rspamd-Queue-Id: 077015956F9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Luis Henriques <luis@igalia.com>

[ Upstream commit 395b95530343e7f4bdd2870190d985a222997fb6 ]

Add and export a new helper d_dispose_if_unused() which is simply a wrapper
around to_shrink_list(), to add an entry to a dispose list if it's not used
anymore.

Also export shrink_dentry_list() to kill all dentries in a dispose list.

Suggested-by: Miklos Szeredi <miklos@szeredi.hu>
Signed-off-by: Luis Henriques <luis@igalia.com>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Stable-dep-of: 5a6baf204610 ("fuse: fix uninit-value in fuse_dentry_revalidate()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/dcache.c            | 18 ++++++++++++------
 include/linux/dcache.h |  2 ++
 2 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 8bf82b002b4d4..fcc8ddf7d3fa4 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -1086,6 +1086,15 @@ struct dentry *d_find_alias_rcu(struct inode *inode)
 	return de;
 }
 
+void d_dispose_if_unused(struct dentry *dentry, struct list_head *dispose)
+{
+	spin_lock(&dentry->d_lock);
+	if (!dentry->d_lockref.count)
+		to_shrink_list(dentry, dispose);
+	spin_unlock(&dentry->d_lock);
+}
+EXPORT_SYMBOL(d_dispose_if_unused);
+
 /*
  *	Try to kill dentries associated with this inode.
  * WARNING: you must own a reference to inode.
@@ -1096,12 +1105,8 @@ void d_prune_aliases(struct inode *inode)
 	struct dentry *dentry;
 
 	spin_lock(&inode->i_lock);
-	hlist_for_each_entry(dentry, &inode->i_dentry, d_u.d_alias) {
-		spin_lock(&dentry->d_lock);
-		if (!dentry->d_lockref.count)
-			to_shrink_list(dentry, &dispose);
-		spin_unlock(&dentry->d_lock);
-	}
+	hlist_for_each_entry(dentry, &inode->i_dentry, d_u.d_alias)
+		d_dispose_if_unused(dentry, &dispose);
 	spin_unlock(&inode->i_lock);
 	shrink_dentry_list(&dispose);
 }
@@ -1141,6 +1146,7 @@ void shrink_dentry_list(struct list_head *list)
 		shrink_kill(dentry);
 	}
 }
+EXPORT_SYMBOL(shrink_dentry_list);
 
 static enum lru_status dentry_lru_isolate(struct list_head *item,
 		struct list_lru_one *lru, void *arg)
diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index c83e02b943894..2bc1339bf6d03 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -268,6 +268,8 @@ extern void d_tmpfile(struct file *, struct inode *);
 
 extern struct dentry *d_find_alias(struct inode *);
 extern void d_prune_aliases(struct inode *);
+extern void d_dispose_if_unused(struct dentry *, struct list_head *);
+extern void shrink_dentry_list(struct list_head *);
 
 extern struct dentry *d_find_alias_rcu(struct inode *);
 
-- 
2.53.0




