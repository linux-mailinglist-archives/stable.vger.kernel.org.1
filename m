Return-Path: <stable+bounces-220119-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oObpKuApo2kr+AQAu9opvQ
	(envelope-from <stable+bounces-220119-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:46:08 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FF4A1C515E
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:46:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A6C133156297
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 17:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6649A480352;
	Sat, 28 Feb 2026 17:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NuhoiVZ2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26BB348034A;
	Sat, 28 Feb 2026 17:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300030; cv=none; b=R0lQAIYRqenI/Jp0t3A1wSBq1b9uG123EVEa4L6fqXbMVcwXfnHHVH5sy6xptPMfiQ56AtEXt0Ew8r5h/l55WU7szBYDeMFTvXF8pFFwWJHThRv6z+pzdoj2P+wE2tnxVzvO/NGn7T2TqBEQnQo1qErvUGKdUhDEe5pnu5ozTr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300030; c=relaxed/simple;
	bh=x3mFUwKG+WkAkFMJ/2Po3saOmtkk6EbTvNzoqVjfVOY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mI23rnlzktdpDg0S0Afr0hSP+xXZy5+A64CS7fBxEUlNHFHsdUXHg4s9i7/sfwYgcJC6P6kxp8ijxQVHXSFEPIOJ7WmdxxxeBeAKgl7G90sACXLWJndcOL+YykiMAmOIUOgKz3WhEFwPV25BxqNwx+7YJuhv98e2Vcfx6Iabb9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NuhoiVZ2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 335E8C116D0;
	Sat, 28 Feb 2026 17:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300029;
	bh=x3mFUwKG+WkAkFMJ/2Po3saOmtkk6EbTvNzoqVjfVOY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NuhoiVZ2UM4BgZ3PncEIMft+ND8g5KyQJPEYnFYmLsO58bliwhafFCs6usksuHszc
	 WP7rko000aV4bHNHtQ+A9IRw+TICmnwQfSV4eYb2X6mr21Gf6Aym/aHQ69gudEva/m
	 XwQCGltY3QUje4xf1w0rTe9GKYgaexBOhe+T4A2U9LF37UupCuCj1JtgAAj0Lbjjao
	 xfbMsyjNlN9ze/7jc1S+1ryR+bCkRmry+czMvWAy0OBIFwXJ/p/014SXiTqsQX+tC4
	 o/FMI4iJdIsf+UArrXDEH3l/Mca7YLRV7u2di10YJpCOQC3VKOMrjxds0gx1W6at71
	 mZQQgVWyvX+pw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jeffrey Bencteux <jeff@bencteux.fr>,
	Paul Moore <paul@paul-moore.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 041/844] audit: add missing syscalls to read class
Date: Sat, 28 Feb 2026 12:19:14 -0500
Message-ID: <20260228173244.1509663-42-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220119-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[paul-moore.com:email,bencteux.fr:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3FF4A1C515E
X-Rspamd-Action: no action

From: Jeffrey Bencteux <jeff@bencteux.fr>

[ Upstream commit bcb90a2834c7393c26df9609b889a3097b7700cd ]

The "at" variant of getxattr() and listxattr() are missing from the
audit read class. Calling getxattrat() or listxattrat() on a file to
read its extended attributes will bypass audit rules such as:

-w /tmp/test -p rwa -k test_rwa

The current patch adds missing syscalls to the audit read class.

Signed-off-by: Jeffrey Bencteux <jeff@bencteux.fr>
Signed-off-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/asm-generic/audit_read.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/asm-generic/audit_read.h b/include/asm-generic/audit_read.h
index 7bb7b5a83ae2e..fb9991f53fb6f 100644
--- a/include/asm-generic/audit_read.h
+++ b/include/asm-generic/audit_read.h
@@ -4,9 +4,15 @@ __NR_readlink,
 #endif
 __NR_quotactl,
 __NR_listxattr,
+#ifdef __NR_listxattrat
+__NR_listxattrat,
+#endif
 __NR_llistxattr,
 __NR_flistxattr,
 __NR_getxattr,
+#ifdef __NR_getxattrat
+__NR_getxattrat,
+#endif
 __NR_lgetxattr,
 __NR_fgetxattr,
 #ifdef __NR_readlinkat
-- 
2.51.0


