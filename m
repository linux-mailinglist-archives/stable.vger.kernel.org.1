Return-Path: <stable+bounces-233356-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iFAPIlJo02kCiAcAu9opvQ
	(envelope-from <stable+bounces-233356-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 06 Apr 2026 10:01:22 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BB593A21ED
	for <lists+stable@lfdr.de>; Mon, 06 Apr 2026 10:01:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4CAC5300683B
	for <lists+stable@lfdr.de>; Mon,  6 Apr 2026 08:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA8E817B50F;
	Mon,  6 Apr 2026 08:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="X4s+FIZF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E27EDF59;
	Mon,  6 Apr 2026 08:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775462469; cv=none; b=SzTGCGgX2LKOx3ChSPEVe6VvVqViWVt77EyfBzmkJKE6YTNKV7YAhiRzXTK86ZGJPh1fjJ/6BCk4LAE8rWyWAWIDdTUe9S+u3XvHtm7Pef71fRNpMEL7EgOreWwkWSFKhKONj0vfG0Aa3jt3LDksBIbuncmYvS30yY0k9oM8oC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775462469; c=relaxed/simple;
	bh=qiguDnkwogOTfoYFwsnl8E5XUsa3zTNWFthIu8iJO1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H50jLTUMDpVageQDCD35uERIKVQktu7jerdJaz9UlokbCo7tcEVdlVA40Ck0fI4NaJUv0c7VFGQX5l4shw558U7Sy4JsTKkDaV+T3n+A5rbf41RMXtjaKhYrpeVN03Sb95joGQwCDAY9rAQiFkTslqhGWABrTahhtwGJ3gZiW4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=X4s+FIZF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD038C4CEF7;
	Mon,  6 Apr 2026 08:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775462469;
	bh=qiguDnkwogOTfoYFwsnl8E5XUsa3zTNWFthIu8iJO1Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X4s+FIZF2f2J+56pDlLgMsIDiM23EcoaQarSvcSAfEgJ7kRaWXU9UJNbc+vQcxlbK
	 8RcyEDxR/yMjakXK7E6tAy11cLC7JPc/tANH00W6YVJRSAVVeDrKqen3qIVUOER6VB
	 Jwi5DoapXRwQ+BQ06BzRK93oGmUoKMyj6tx4HI3A=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 6.6.133
Date: Mon,  6 Apr 2026 10:00:56 +0200
Message-ID: <2026040656-study-reacquire-8975@gregkh>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026040656-earring-timothy-3640@gregkh>
References: <2026040656-earring-timothy-3640@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233356-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9BB593A21ED
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

diff --git a/Makefile b/Makefile
index 56ff90e4d603..753e98740a5e 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 6
-SUBLEVEL = 132
+SUBLEVEL = 133
 EXTRAVERSION =
 NAME = Pinguïn Aangedreven
 
diff --git a/fs/xattr.c b/fs/xattr.c
index 5f2d74332ea6..20a038b06d12 100644
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -699,6 +699,8 @@ SYSCALL_DEFINE5(fsetxattr, int, fd, const char __user *, name,
 
 	CLASS(fd, f)(fd);
 
+	if (!f.file)
+		return -EBADF;
 	audit_file(f.file);
 	error = setxattr_copy(name, &ctx);
 	if (error)
@@ -810,6 +812,8 @@ SYSCALL_DEFINE4(fgetxattr, int, fd, const char __user *, name,
 {
 	CLASS(fd, f)(fd);
 
+	if (!f.file)
+		return -EBADF;
 	audit_file(f.file);
 	return getxattr(file_mnt_idmap(f.file), f.file->f_path.dentry,
 			 name, value, size);
@@ -881,8 +885,10 @@ SYSCALL_DEFINE3(flistxattr, int, fd, char __user *, list, size_t, size)
 {
 	CLASS(fd, f)(fd);
 
+	if (!f.file)
+		return -EBADF;
 	audit_file(f.file);
-	return listxattr(f.file->f_path.dentry, list, size);
+	return  listxattr(f.file->f_path.dentry, list, size);
 }
 
 /*
@@ -943,6 +949,8 @@ SYSCALL_DEFINE2(fremovexattr, int, fd, const char __user *, name)
 	char kname[XATTR_NAME_MAX + 1];
 	int error;
 
+	if (!f.file)
+		return -EBADF;
 	audit_file(f.file);
 
 	error = strncpy_from_user(kname, name, sizeof(kname));

