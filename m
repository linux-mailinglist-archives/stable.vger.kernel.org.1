Return-Path: <stable+bounces-227526-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SB8ZDA4yvWmI7QIAu9opvQ
	(envelope-from <stable+bounces-227526-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 12:39:58 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 932742D9B76
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 12:39:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 65CFD303C288
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 11:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13A6339E198;
	Fri, 20 Mar 2026 11:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="imTzkuJf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA1939A7E0
	for <stable@vger.kernel.org>; Fri, 20 Mar 2026 11:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774006782; cv=none; b=CAA+KaJ+MyxshE/ItFs350JiSiasYQJC4xLCbMy0NcqQ07cc2CLU2VtKcyUM/HgmD2h3j+StWxvl1mERlzypeVuz0KtkN0zerWanFI+nNtCi/LOCByuKkEp0XMGWp0yK2vF1LaYRwwyn6uu8jzs0JwqvspGRug+sHBRfHi5rrro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774006782; c=relaxed/simple;
	bh=6KI421U9CRdcz8Oj2SVET3aBDs+dyQUe7NEaZfoVEeI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J0aT8e7KFZpLROPumOHyKR/Ovu5SJ9tX7LhnC7FbK1ycTA7HWBkPfrBrsoF+2fGAc5APtuXQODS2AdnJpcVoLYfJEt046U7mZwsArc6/J3MTmz4uLN3J02wLiDlhFsTaaRJQnAeoES2+lVIkzYlDD/lGG5SvAqv9ZAHmIOhhl9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=imTzkuJf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4BFCC2BC9E;
	Fri, 20 Mar 2026 11:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774006782;
	bh=6KI421U9CRdcz8Oj2SVET3aBDs+dyQUe7NEaZfoVEeI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=imTzkuJfrdgfIwbboaWTJ0+4FL1RFU1mucaJNo5g6IkN1LV5tZpZx2ropbA0Xp9gt
	 sEpeVES03YoJ1WgoRhbf+fzw1Zp6qWKe/QZssXTRS2dywmXls95ioDYgX6/2gXnHWp
	 psG2Dg8CezQcQYCdeRTzMKm7OD9uCjBg5OibyG9rTDT4+r2Er0sOGrzJBzjAhfG+bF
	 Ogdb9TNXsIOlifwPTCJ+Pqbk2V/21uZodmdxoh1MJtgklSz8OFdYRBZOAsQGDvdgh+
	 lV8tjtyeRQX2zgZA6UuMiFHKJl3vvfh9efh3meQqNJgmLhe0DdltMFbhhUrYJdxrOP
	 jXyBvm2ljwxCg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Misbah Anjum N <misanjum@linux.ibm.com>,
	Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/2] NFSD: Hold net reference for the lifetime of /proc/fs/nfs/exports fd
Date: Fri, 20 Mar 2026 07:39:39 -0400
Message-ID: <20260320113939.3971291-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260320113939.3971291-1-sashal@kernel.org>
References: <2026032042-stalling-batboy-6b82@gregkh>
 <20260320113939.3971291-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227526-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.974];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 932742D9B76
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chuck Lever <chuck.lever@oracle.com>

[ Upstream commit e7fcf179b82d3a3730fd8615da01b087cc654d0b ]

The /proc/fs/nfs/exports proc entry is created at module init
and persists for the module's lifetime. exports_proc_open()
captures the caller's current network namespace and stores
its svc_export_cache in seq->private, but takes no reference
on the namespace. If the namespace is subsequently torn down
(e.g. container destruction after the opener does setns() to a
different namespace), nfsd_net_exit() calls nfsd_export_shutdown()
which frees the cache. Subsequent reads on the still-open fd
dereference the freed cache_detail, walking a freed hash table.

Hold a reference on the struct net for the lifetime of the open
file descriptor. This prevents nfsd_net_exit() from running --
and thus prevents nfsd_export_shutdown() from freeing the cache
-- while any exports fd is open. cache_detail already stores
its net pointer (cd->net, set by cache_create_net()), so
exports_release() can retrieve it without additional per-file
storage.

Reported-by: Misbah Anjum N <misanjum@linux.ibm.com>
Closes: https://lore.kernel.org/linux-nfs/dcd371d3a95815a84ba7de52cef447b8@linux.ibm.com/
Fixes: 96d851c4d28d ("nfsd: use proper net while reading "exports" file")
Cc: stable@vger.kernel.org
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Reviewed-by: NeilBrown <neil@brown.name>
Tested-by: Olga Kornievskaia <okorniev@redhat.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/nfsctl.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index ad7a3909ae6df..8178d7d016487 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -152,9 +152,19 @@ static int exports_net_open(struct net *net, struct file *file)
 
 	seq = file->private_data;
 	seq->private = nn->svc_export_cache;
+	get_net(net);
 	return 0;
 }
 
+static int exports_release(struct inode *inode, struct file *file)
+{
+	struct seq_file *seq = file->private_data;
+	struct cache_detail *cd = seq->private;
+
+	put_net(cd->net);
+	return seq_release(inode, file);
+}
+
 static int exports_nfsd_open(struct inode *inode, struct file *file)
 {
 	return exports_net_open(inode->i_sb->s_fs_info, file);
@@ -164,7 +174,7 @@ static const struct file_operations exports_nfsd_operations = {
 	.open		= exports_nfsd_open,
 	.read		= seq_read,
 	.llseek		= seq_lseek,
-	.release	= seq_release,
+	.release	= exports_release,
 };
 
 static int export_features_show(struct seq_file *m, void *v)
@@ -1421,7 +1431,7 @@ static const struct proc_ops exports_proc_ops = {
 	.proc_open	= exports_proc_open,
 	.proc_read	= seq_read,
 	.proc_lseek	= seq_lseek,
-	.proc_release	= seq_release,
+	.proc_release	= exports_release,
 };
 
 static int create_proc_exports_entry(void)
-- 
2.51.0


