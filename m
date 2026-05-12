Return-Path: <stable+bounces-246281-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KCMpDlhtA2rF5gEAu9opvQ
	(envelope-from <stable+bounces-246281-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 20:11:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C9437526FD9
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 20:11:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3A38A315E2D7
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 18:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F9B033D51A;
	Tue, 12 May 2026 18:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NpQq/DrQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B5823E356;
	Tue, 12 May 2026 18:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778608823; cv=none; b=lLCq0f6vpKrFEXjSeEnGDuJPhh80cUhQ2X7Lw+H73L9pTKGWu9wKYWCWL/uszeGQ/cG+9SqkmIS/QlLC/JR+lr+ut9uSsyOvPGmTuVHVw9qnwY+dp4pCKo3yfGPchWt7OCor+f8Jqej/E5X00wzMq84ZrhLP9wU0gX46KgD+3qM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778608823; c=relaxed/simple;
	bh=nqchJuUUfVW6rltgw9EDAJLAz/CTrGuQn8Sc4sWmtxM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=leG1OWRtzdNr+huntwQ0HsMS5SF4XxAqBHaDzqgGjaYk/dWjzAanm/aSI6gbbS3N7zja5jX+hsF3R5KqTNEQ2SGZPqb0hTHviWhKoYvnfBK0gMF/T8aFEXxpdeYQkT78n7AtO2Xoysaarb8cz1HyD7gDD1ut+tDv7nfddeLdRuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NpQq/DrQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B8BEC2BCB0;
	Tue, 12 May 2026 18:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778608822;
	bh=nqchJuUUfVW6rltgw9EDAJLAz/CTrGuQn8Sc4sWmtxM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NpQq/DrQMm8qfQ1fAL+dwvcBTKGdwkhssfRjxSAyHnn4vXP+i+e55/XlefRRZzU0R
	 pbhJ4ePzHv5dMg1LLuuXo51DIJSTMcpDFEDXXhiRD9MI80ON28e1aXnTVM6uZ20S3f
	 73NrRNLlQpYSEVxllLLF5OK9Shg0AzrEYbvl9ReQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Guangshuo Li <lgs201920130244@gmail.com>,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 6.18 229/270] f2fs: fix uninitialized kobject put in f2fs_init_sysfs()
Date: Tue, 12 May 2026 19:40:30 +0200
Message-ID: <20260512173943.267685875@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260512173938.452574370@linuxfoundation.org>
References: <20260512173938.452574370@linuxfoundation.org>
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
X-Rspamd-Queue-Id: C9437526FD9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-246281-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Guangshuo Li <lgs201920130244@gmail.com>

commit b635f2ecdb5ad34f9c967cabb704d6bed9382fd0 upstream.

In f2fs_init_sysfs(), all failure paths after kset_register() jump to
put_kobject, which unconditionally releases both f2fs_tune and
f2fs_feat.

If kobject_init_and_add(&f2fs_feat, ...) fails, f2fs_tune has not been
initialized yet, so calling kobject_put(&f2fs_tune) is invalid.

Fix this by splitting the unwind path so each error path only releases
objects that were successfully initialized.

Fixes: a907f3a68ee26ba4 ("f2fs: add a sysfs entry to reclaim POSIX_FADV_NOREUSE pages")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/f2fs/sysfs.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -1935,24 +1935,26 @@ int __init f2fs_init_sysfs(void)
 	ret = kobject_init_and_add(&f2fs_feat, &f2fs_feat_ktype,
 				   NULL, "features");
 	if (ret)
-		goto put_kobject;
+		goto unregister_kset;
 
 	ret = kobject_init_and_add(&f2fs_tune, &f2fs_tune_ktype,
 				   NULL, "tuning");
 	if (ret)
-		goto put_kobject;
+		goto put_feat;
 
 	f2fs_proc_root = proc_mkdir("fs/f2fs", NULL);
 	if (!f2fs_proc_root) {
 		ret = -ENOMEM;
-		goto put_kobject;
+		goto put_tune;
 	}
 
 	return 0;
 
-put_kobject:
+put_tune:
 	kobject_put(&f2fs_tune);
+put_feat:
 	kobject_put(&f2fs_feat);
+unregister_kset:
 	kset_unregister(&f2fs_kset);
 	return ret;
 }



