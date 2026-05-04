Return-Path: <stable+bounces-243117-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2Fg8OFKm+GnQxQIAu9opvQ
	(envelope-from <stable+bounces-243117-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 15:59:46 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DCD04BE452
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 15:59:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 223863014284
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 13:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCC553DDDBC;
	Mon,  4 May 2026 13:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WmhBDV+w"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803913A63EC;
	Mon,  4 May 2026 13:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777903061; cv=none; b=pB+HxwbWA1afD1y4FuViXP7u+AVJVbb2pBUkf+UlfeDpBAlGF61oQYXmL7Gi6mQbqBHBgEtJwfaM/Np9tN+CxuMrjBIsoJfuWzyf4T2Q+bNGStRF0n5eTW59g4Ye+k9sfXmExFcnI3VIo9cOcvfobTLsjl943ew2tUjx2L3a0IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777903061; c=relaxed/simple;
	bh=21+rQBueSG9ZfK+RBmjUD+ynX7vmXS/mHxAy4M35ZDY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ubmMOm7Mn6TdxWVgII6AOtCSqBxYXKwVdr3MvcFJwHdeCK9scFpo7mCCkHmBAzGtk/yVTGdXfW9Sdz9k7tMXh5gBWP91Ik6DdBBjcRHcDXZ3Db67A9yxQVCfqbksOYHyXG3xCgyDG53u442J3KVmHrihUDGidceVBjzqYyRgm3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WmhBDV+w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16E43C2BCC4;
	Mon,  4 May 2026 13:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777903061;
	bh=21+rQBueSG9ZfK+RBmjUD+ynX7vmXS/mHxAy4M35ZDY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WmhBDV+w9h/7lc/q7zB0Lag5lRpf/HMMamDtxww2GSaFzcYDJ7aYhHeaQnrVrYm64
	 WD5SPyUz+nDObcq/qDqp+2Nj+zA6Wk3d4vRqMvsWVgxTy5YLEjkJVh7w9NIDS7SHbp
	 +zSf/m5CCiIeFtDYrfFghriZJc3NAC2IbvnWRhZQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Helge Deller <deller@gmx.de>
Subject: [PATCH 7.0 088/307] parisc: _llseek syscall is only available for 32-bit userspace
Date: Mon,  4 May 2026 15:49:33 +0200
Message-ID: <20260504135146.126110133@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260504135142.814938198@linuxfoundation.org>
References: <20260504135142.814938198@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 1DCD04BE452
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmx.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-243117-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,gmx.de:email]

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Helge Deller <deller@gmx.de>

commit da3680f564bd787ce974f9931e6e924d908b3b2a upstream.

Cc: stable@vger.kernel.org
Signed-off-by: Helge Deller <deller@gmx.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/parisc/kernel/syscalls/syscall.tbl |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/parisc/kernel/syscalls/syscall.tbl
+++ b/arch/parisc/kernel/syscalls/syscall.tbl
@@ -154,7 +154,7 @@
 # 137 was afs_syscall
 138	common	setfsuid		sys_setfsuid
 139	common	setfsgid		sys_setfsgid
-140	common	_llseek			sys_llseek
+140	32	_llseek			sys_llseek
 141	common	getdents		sys_getdents			compat_sys_getdents
 142	common	_newselect		sys_select			compat_sys_select
 143	common	flock			sys_flock



