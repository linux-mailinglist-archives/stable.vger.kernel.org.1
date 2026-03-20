Return-Path: <stable+bounces-227525-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0HjwAgEyvWmI7QIAu9opvQ
	(envelope-from <stable+bounces-227525-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 12:39:45 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A431A2D9B68
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 12:39:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C466D301251C
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 11:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 453163793CC;
	Fri, 20 Mar 2026 11:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cui9JZ9P"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E57285CB4
	for <stable@vger.kernel.org>; Fri, 20 Mar 2026 11:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774006782; cv=none; b=nzpwNOB2qu8wW5PAeIg1eyWx4iHdCawLDCowpQTjIPjNtFjAJARsz0JySLBc9rolbr8GB05s7d/NQ6wtPxlRueBv4l8lg/fqfueMk5X4C7JxruIr0LMrcHS4XFeuUmcpsoyEC6WnKoN7izIbNjM9g9jYRGXzkQIgN6xQINmzg5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774006782; c=relaxed/simple;
	bh=hLD9dA/uhlliqWrXG6r/uQ5BWHEXHyzP5wLmgUcoRAU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PfZEHIQ21wnzSZQw0YYpePOnhQN2IzKl0J0TLUafhiQBZqhkl35O+TNG2ndzz2IIAjQBeSxk/lAMsd9PAQ4785FgORLC01kufFYKds1bBaX2t6PpEA5lyZrImFq5Bqw2IL2HNMAAidEiMLyQkOXwnZtfpPqPwdPzWvU/WkFqkj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cui9JZ9P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02393C4CEF7;
	Fri, 20 Mar 2026 11:39:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774006781;
	bh=hLD9dA/uhlliqWrXG6r/uQ5BWHEXHyzP5wLmgUcoRAU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Cui9JZ9PjMoSU1FoxY96pUne/fAVV4UqH9aiqJEDpNK3rZLraqokD026gOa8G0Lcy
	 AU7Ahf9vidzwP+YLLuMSNzPB5EyYSHeOp81uMhbrVwyT5zNTT82G+FaxHe1NSMHVuw
	 GhG01AgclF7hy97jNFhe8fqVPryLVgU8Q8TkZVXoiBCAzBCrMm3qgb6WobWqIn6Ybo
	 glDrvzgJPnBdl6l0+zA9AeEUOJA78bTi/AuspawzUX1Ed3E+vPg2Jd8EDb6508f1lN
	 7+F4mFCuJHACSwBqJ3kLNjeEuj39+LKS/06/AmY2DnxvQ5ZclHs1M9KlC1DtIEK6CS
	 wtyJjVbzNz0cA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Tom Rix <trix@redhat.com>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/2] nfsd: define exports_proc_ops with CONFIG_PROC_FS
Date: Fri, 20 Mar 2026 07:39:38 -0400
Message-ID: <20260320113939.3971291-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026032042-stalling-batboy-6b82@gregkh>
References: <2026032042-stalling-batboy-6b82@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-227525-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Queue-Id: A431A2D9B68
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
index 07e5b1b23c91f..ad7a3909ae6df 100644
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


