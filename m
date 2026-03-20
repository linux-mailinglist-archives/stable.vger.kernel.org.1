Return-Path: <stable+bounces-227517-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eJ5BDKctvWmI7QIAu9opvQ
	(envelope-from <stable+bounces-227517-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 12:21:11 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C57052D9710
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 12:21:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E93CA300E5BD
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 11:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E89BB36829F;
	Fri, 20 Mar 2026 11:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OUVquA6A"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC2F12E4274
	for <stable@vger.kernel.org>; Fri, 20 Mar 2026 11:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774005668; cv=none; b=I3EzF9nUDKB30wI0domajX+HTy/28ApYgW+xL1iJ67C2QrMMMO72lMwsi5d0zAyDtKjTjxmrFoTDtU/uuRf8w1+iP/kE9EaTAPQHxmKpIhX6XD0lrANOUogOLwAbk4W+T3l1UvmzeAkqbtQnU1rqnnp09S4T+z57s08CsmPgh+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774005668; c=relaxed/simple;
	bh=k+bOQHBkzxAjisXSM9H3nLZCgmMwibfZS2YAlre400I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HfsdU/jq+MmRSfuaYCCMjFm/ihfT/yqjQ45ZFzsxKya28Ync/OSK2Y1h4MKB/DPiEYU+P1qERxREi2J+NWjMqZnJ9GlLk0nsyqBjwpxsDFUr4C/ft8IozZ5XxPsJlQyjotLogLoEPDpjYlst+QkTux/FjkMTRIswYQ3fwaOkeQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OUVquA6A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD346C4CEF7;
	Fri, 20 Mar 2026 11:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774005668;
	bh=k+bOQHBkzxAjisXSM9H3nLZCgmMwibfZS2YAlre400I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OUVquA6AKS7kyDg2TPAG5MOa+aIp1dqKJ4sEaHBx5E0cS0shTxjAqCNI6ipswSx4U
	 axb20EXJ8yN3Eh057f6r0AzL5M3p73TWCcVWuTb54Lcp6o2ADDqnyjV4yWEHlcjXqA
	 Fz1/++GPlcvLiCaTxZL0xH4aHYqvENl2N/g6yMsNxxEJ1JpY/+wlxhLUEafY4NocIY
	 IKU0nFrPj80PCyX+Ra4T8odAYZqi9mORklLBz8gt2ipcqlWugTVAXgn0YTlNZDnvr2
	 aL9iBhsOP/xuB1ADCgexWlcCGep2/0ZIS0IMe/WTRtIebIWMpvlFc6neql+e0d1YKa
	 3l7Ypwsww0eNw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Tom Rix <trix@redhat.com>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/2] nfsd: define exports_proc_ops with CONFIG_PROC_FS
Date: Fri, 20 Mar 2026 07:21:05 -0400
Message-ID: <20260320112106.3879597-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026032034-freeing-unlimited-383f@gregkh>
References: <2026032034-freeing-unlimited-383f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227517-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.997];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C57052D9710
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
index cc0dea883fbdb..730e0e580cf57 100644
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


