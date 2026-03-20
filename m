Return-Path: <stable+bounces-227521-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uPZWOwYwvWmI7QIAu9opvQ
	(envelope-from <stable+bounces-227521-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 12:31:18 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EB242D99B6
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 12:31:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7CB05304C13D
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 11:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 576C939B97C;
	Fri, 20 Mar 2026 11:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uj+mKy9u"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7C8384250
	for <stable@vger.kernel.org>; Fri, 20 Mar 2026 11:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774006183; cv=none; b=NUM3dJxcD+JIyYbNPRQDjze7GjeQFCa4AauK2SLsa3axm3q+PtipVD3W2AqNFON6foc9TYc6hAsE13YhWvNiTLK4qOAMs6F72n2qBHHUeTQcUIoEzu7EWVXO89lZrm5ZZjG0G7q0jKb3GMNj6LB3qEkh+JKHO8Mcvfr++Jr4eGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774006183; c=relaxed/simple;
	bh=Ulul02vxKICPJhgJhclG8q6kYlxmM5lrLmqFX6/AWlc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iQP2gBX7lfXV05YIBx1aTtYBS0da2P1e0sUpHZ6xh4sIx376HKJtCFXoTjFrMkAF1UJHJ7OAYFjaZmAqt5EfxSh9VCD2NnXtCS8nctKzumUE68GIP/7YIXdm9t2j7OnHNCnUoFuRlPG03Jgp+3f8cDga0Sv5SBdqdaz6k49MM0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uj+mKy9u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58832C2BC9E;
	Fri, 20 Mar 2026 11:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774006182;
	bh=Ulul02vxKICPJhgJhclG8q6kYlxmM5lrLmqFX6/AWlc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uj+mKy9ucNwVGtWzukWR7jgz6pNsoKv0K4k+UcpFMQQbOWAH1Vm+5MPe7YZoCJaG8
	 Gu9/ssWAye/Ng+/Eu2xtNr48Qsgpiz2c1EgUermvLXvRcCDuBEiAe5b/K3u2+m9op7
	 Ezo7HTFFInK/Cn1HUXO3sDZ1vXDjldzczl5SQTpSswWQEcBZUj3DKwLFybmprQqTVM
	 1S+GfpMZVA6NRYKYbXP0uUxol+Audf8E9Ub4HSZ6ahf06NKnvjuHXHrmN78NK0pGPU
	 mbRulx7L28gW/nPOQUIYQPt5MRrUlQf+5kqYiHfM3nQeZDFi0j6plY2h6hRMzfZwWf
	 S5YFyYovIVgBA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Tom Rix <trix@redhat.com>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/2] nfsd: define exports_proc_ops with CONFIG_PROC_FS
Date: Fri, 20 Mar 2026 07:29:39 -0400
Message-ID: <20260320112940.3960556-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026032038-dimly-tiring-d92b@gregkh>
References: <2026032038-dimly-tiring-d92b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-227521-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Queue-Id: 7EB242D99B6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Tom Rix <trix@redhat.com>

[ Upstream commit 340086da9a87820b40601141a0e9e87c954ac006 ]

gcc with W=1 and ! CONFIG_PROC_FS
fs/nfsd/nfsctl.c:161:30: error: ‘exports_proc_ops’
  defined but not used [-Werror=unused-const-variable=]
  161 | static const struct proc_ops exports_proc_ops = {
      |                              ^~~~~~~~~~~~~~~~

The only use of exports_proc_ops is when CONFIG_PROC_FS
is defined, so its definition should be likewise conditional.

Signed-off-by: Tom Rix <trix@redhat.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Stable-dep-of: e7fcf179b82d ("NFSD: Hold net reference for the lifetime of /proc/fs/nfs/exports fd")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/nfsctl.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index ba2eaf3744efa..e3d34fb7fce5a 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -155,18 +155,6 @@ static int exports_net_open(struct net *net, struct file *file)
 	return 0;
 }
 
-static int exports_proc_open(struct inode *inode, struct file *file)
-{
-	return exports_net_open(current->nsproxy->net_ns, file);
-}
-
-static const struct proc_ops exports_proc_ops = {
-	.proc_open	= exports_proc_open,
-	.proc_read	= seq_read,
-	.proc_lseek	= seq_lseek,
-	.proc_release	= seq_release,
-};
-
 static int exports_nfsd_open(struct inode *inode, struct file *file)
 {
 	return exports_net_open(inode->i_sb->s_fs_info, file);
@@ -1423,6 +1411,19 @@ static struct file_system_type nfsd_fs_type = {
 MODULE_ALIAS_FS("nfsd");
 
 #ifdef CONFIG_PROC_FS
+
+static int exports_proc_open(struct inode *inode, struct file *file)
+{
+	return exports_net_open(current->nsproxy->net_ns, file);
+}
+
+static const struct proc_ops exports_proc_ops = {
+	.proc_open	= exports_proc_open,
+	.proc_read	= seq_read,
+	.proc_lseek	= seq_lseek,
+	.proc_release	= seq_release,
+};
+
 static int create_proc_exports_entry(void)
 {
 	struct proc_dir_entry *entry;
-- 
2.51.0


