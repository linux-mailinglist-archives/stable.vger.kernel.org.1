Return-Path: <stable+bounces-247227-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CPOeOGrnBWp0dQIAu9opvQ
	(envelope-from <stable+bounces-247227-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 17:16:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 21AAF543E02
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 17:16:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 44C1D300118A
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 15:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96E7D3E0251;
	Thu, 14 May 2026 15:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qcaYWEqL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C944F426EA7
	for <stable@vger.kernel.org>; Thu, 14 May 2026 15:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778771304; cv=none; b=QRyTbarNLNVmEeQEe5eqTUfep5ejS68fW14wmFDmEthLw0i06iXmi2hCOudBS+y+ALyuQOD/B4ShcNAxuKLmdg9Rr21U9XhcQJYRpmB9b864adNJ774DgkP5L70bRMvmj0qJFiG92eStoOm0+geAWtk2CKByfr4GDL5C6A/W9HA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778771304; c=relaxed/simple;
	bh=ySJBOVmV+6OFVV8eyhC9LBb3Rr1p84W5twy+ERW4r6A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oXSc88XK/tu+CG2akijGSIGrK+pU7SSPP7P5jB2lcDkUKVk8ChZKKJZqlbOYNrP74RVFvy2WSQcEf2/yIP3ZvSmAF2xc5WBxuZDcN6UKSDH57gnLh8DfPoCQX3qWh4gK2J6/BoTBgTjh5BGQW9nZ7s6n/UDWZm3FxRKkO2EzKxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qcaYWEqL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2C60C2BCB3;
	Thu, 14 May 2026 15:08:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778771303;
	bh=ySJBOVmV+6OFVV8eyhC9LBb3Rr1p84W5twy+ERW4r6A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qcaYWEqLdyFO/fIabtq8Ysx0qRrGVDHSISQvtq154dgiSNackxiyA4wHDv37096Ma
	 TYWSOhLDKORf9YVLn7t2/UrWicggbzBf1vkgqED5VWKRZI7hrUTnSAeA/lyViioA8Z
	 77OymxiE5vqaJOIWOxvn7BPAc1N27OnjVbrTzitE04MZFdciwxp/YXbnbGHCgpez4m
	 zljy/6pMWgOFfwNEylrDG5SJHQdteW5Wkh5ULeY+6QNazV19i3oceqnZ+PwqCQzIfA
	 xNGnrCI/FOKyUxATkRgOJVcgA1j16fcTNom0EmnuDGosYBMYLvUa3wANTTjKLR2GDX
	 qcdgAs/VzwbKw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/2] papr-hvpipe: convert papr_hvpipe_dev_create_handle() to FD_PREPARE()
Date: Thu, 14 May 2026 11:08:19 -0400
Message-ID: <20260514150820.274333-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026051217-briskness-posing-6f46@gregkh>
References: <2026051217-briskness-posing-6f46@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 21AAF543E02
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-247227-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Action: no action

From: Christian Brauner <brauner@kernel.org>

[ Upstream commit 6d3789d347a7af5c4b0b2da3af47b8d9da607ab2 ]

Fixes a UAF for src_info as well.

Link: https://patch.msgid.link/20251123-work-fd-prepare-v4-33-b6efa1706cfd@kernel.org
Signed-off-by: Christian Brauner <brauner@kernel.org>
Stable-dep-of: 7a4f0846ee6c ("pseries/papr-hvpipe: Fix race with interrupt handler")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/platforms/pseries/papr-hvpipe.c | 39 +++++---------------
 1 file changed, 9 insertions(+), 30 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/papr-hvpipe.c b/arch/powerpc/platforms/pseries/papr-hvpipe.c
index 21a2f447c43fd..dd7b668799d9b 100644
--- a/arch/powerpc/platforms/pseries/papr-hvpipe.c
+++ b/arch/powerpc/platforms/pseries/papr-hvpipe.c
@@ -479,10 +479,7 @@ static const struct file_operations papr_hvpipe_handle_ops = {
 
 static int papr_hvpipe_dev_create_handle(u32 srcID)
 {
-	struct hvpipe_source_info *src_info;
-	struct file *file;
-	long err;
-	int fd;
+	struct hvpipe_source_info *src_info __free(kfree) = NULL;
 
 	spin_lock(&hvpipe_src_list_lock);
 	/*
@@ -506,20 +503,13 @@ static int papr_hvpipe_dev_create_handle(u32 srcID)
 	src_info->tsk = current;
 	init_waitqueue_head(&src_info->recv_wqh);
 
-	fd = get_unused_fd_flags(O_RDONLY | O_CLOEXEC);
-	if (fd < 0) {
-		err = fd;
-		goto free_buf;
-	}
-
-	file = anon_inode_getfile("[papr-hvpipe]",
-			&papr_hvpipe_handle_ops, (void *)src_info,
-			O_RDWR);
-	if (IS_ERR(file)) {
-		err = PTR_ERR(file);
-		goto free_fd;
-	}
+	FD_PREPARE(fdf, O_RDONLY | O_CLOEXEC,
+		   anon_inode_getfile("[papr-hvpipe]", &papr_hvpipe_handle_ops,
+				      (void *)src_info, O_RDWR));
+	if (fdf.err)
+		return fdf.err;
 
+	retain_and_null_ptr(src_info);
 	spin_lock(&hvpipe_src_list_lock);
 	/*
 	 * If two processes are executing ioctl() for the same
@@ -528,22 +518,11 @@ static int papr_hvpipe_dev_create_handle(u32 srcID)
 	 */
 	if (hvpipe_find_source(srcID)) {
 		spin_unlock(&hvpipe_src_list_lock);
-		err = -EALREADY;
-		goto free_file;
+		return -EALREADY;
 	}
 	list_add(&src_info->list, &hvpipe_src_list);
 	spin_unlock(&hvpipe_src_list_lock);
-
-	fd_install(fd, file);
-	return fd;
-
-free_file:
-	fput(file);
-free_fd:
-	put_unused_fd(fd);
-free_buf:
-	kfree(src_info);
-	return err;
+	return fd_publish(fdf);
 }
 
 /*
-- 
2.53.0


