Return-Path: <stable+bounces-226183-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wGKPKg6FuWlyIgIAu9opvQ
	(envelope-from <stable+bounces-226183-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:45:02 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 379BE2AE55B
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:45:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C64C8300D70C
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 16:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BF183EC2EC;
	Tue, 17 Mar 2026 16:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OKILE0Oy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E38D3EC2DC;
	Tue, 17 Mar 2026 16:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773765627; cv=none; b=npBIcSS2Y+WN6mRiUQ3LOqejXuRDOmt4Sc+XjeUkNXRAI93K0RlAwamfFfjnl7wW+A/NnglPzA4QFhpL3qH1eDnEMx/8bZMfvUXwV/bI/RURjic3mBN3w1Ac2gpd0LmKq7ijsuCohnYKCWk5kwGODH0PkHqfEk8h8bFJhUnFiiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773765627; c=relaxed/simple;
	bh=F1ldTUQXHCJgNmsM6zaD+KyWNXm959twP7lBiRhYIvc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mj+7xMdJiztv6I/iBUYIN35LmpHn5SFc4kf4dVpB2JqAdVDovpZOwx1eQSO8EBsBJsNSFaXtrwDD9A5Qb4wk0KUi8+glALnFx+2QZeFugarx9yrXPMpFxG1yq60qo4OCMb5gDKIraugNmUVQcwAVRSeojA5/57uBqzKt+i7MwQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OKILE0Oy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F577C2BC86;
	Tue, 17 Mar 2026 16:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773765627;
	bh=F1ldTUQXHCJgNmsM6zaD+KyWNXm959twP7lBiRhYIvc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OKILE0Oy/i7W8sOFMZXBazz1eDHdcw2Cxbe4mTUcyVbpVcOEsTQICxNN5i8gbkkXR
	 MkzqfSsvQUC/pBXoiuLxGatSb7WloCZhA3szND5aLJdnU/61TQDqm49EzGlt4NYUNR
	 w2kp/CK4eSc0IyIJLdS/Qmmb/6ezFK+HlEm63OlE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Olga Kornievskaia <okorniev@redhat.com>,
	Scott Mayhew <smayhew@redhat.com>,
	Roberto Bergantinos Corpas <rbergant@redhat.com>,
	Anna Schumaker <anna.schumaker@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 026/378] nfs: return EISDIR on nfs3_proc_create if d_alias is a dir
Date: Tue, 17 Mar 2026 17:29:43 +0100
Message-ID: <20260317163007.940592955@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260317163006.959177102@linuxfoundation.org>
References: <20260317163006.959177102@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-226183-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:mid,oracle.com:email]
X-Rspamd-Queue-Id: 379BE2AE55B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Roberto Bergantinos Corpas <rbergant@redhat.com>

[ Upstream commit 410666a298c34ebd57256fde6b24c96bd23059a2 ]

If we found an alias through nfs3_do_create/nfs_add_or_obtain
/d_splice_alias which happens to be a dir dentry, we don't return
any error, and simply forget about this alias, but the original
dentry we were adding and passed as parameter remains negative.

This later causes an oops on nfs_atomic_open_v23/finish_open since we
supply a negative dentry to do_dentry_open.

This has been observed running lustre-racer, where dirs and files are
created/removed concurrently with the same name and O_EXCL is not
used to open files (frequent file redirection).

While d_splice_alias typically returns a directory alias or NULL, we
explicitly check d_is_dir() to ensure that we don't attempt to perform
file operations (like finish_open) on a directory inode, which triggers
the observed oops.

Fixes: 7c6c5249f061 ("NFS: add atomic_open for NFSv3 to handle O_TRUNC correctly.")
Reviewed-by: Olga Kornievskaia <okorniev@redhat.com>
Reviewed-by: Scott Mayhew <smayhew@redhat.com>
Signed-off-by: Roberto Bergantinos Corpas <rbergant@redhat.com>
Signed-off-by: Anna Schumaker <anna.schumaker@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfs/nfs3proc.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/nfs3proc.c b/fs/nfs/nfs3proc.c
index 1181f9cc6dbdb..f8bc9bffdad90 100644
--- a/fs/nfs/nfs3proc.c
+++ b/fs/nfs/nfs3proc.c
@@ -392,8 +392,13 @@ nfs3_proc_create(struct inode *dir, struct dentry *dentry, struct iattr *sattr,
 	if (status != 0)
 		goto out_release_acls;
 
-	if (d_alias)
+	if (d_alias) {
+		if (d_is_dir(d_alias)) {
+			status = -EISDIR;
+			goto out_dput;
+		}
 		dentry = d_alias;
+	}
 
 	/* When we created the file with exclusive semantics, make
 	 * sure we set the attributes afterwards. */
-- 
2.51.0




