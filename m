Return-Path: <stable+bounces-109352-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB393A14E2C
	for <lists+stable@lfdr.de>; Fri, 17 Jan 2025 12:06:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E83C3A289B
	for <lists+stable@lfdr.de>; Fri, 17 Jan 2025 11:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52E411FBE83;
	Fri, 17 Jan 2025 11:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="mgySlyVX";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="mgySlyVX"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7DB1F8905
	for <stable@vger.kernel.org>; Fri, 17 Jan 2025 11:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737111958; cv=none; b=XAeUu/tMkhq7kpO6qM/7DpWmnANLTsAigxL1hfblKikKyy4bklOZbcImOB76q2IKBVf2Ug+4dmquQJS/Z+pvvfivU3MEblWynf61qhDvwOGSPiYw8wk+2SvbUpP8S+2x7RONfgCG39ljRKYDcgWVQ3+egijBY7QTXZKDwJAqhh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737111958; c=relaxed/simple;
	bh=x7fxZLIMDzWTRzsYMymQ2HPlz8wBwG/BRxeZ92OlwnU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nS9WdpTwJnmBrkjidqym/bJYXbIv7Mn9aHmGQTkPj7rdnjcSJNg/q3ETKakiVTOg9iJgnYCJwbIN+AhgYO/PafNMoI0u2zG655yOj+dofJcOSCbzWpujUKOhVbrqex5jwTgrCCh5GOpJT3lZWN09h7lFYRoOMIR+wMJgIaYEYrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=mgySlyVX; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=mgySlyVX; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3A8DF2117A;
	Fri, 17 Jan 2025 11:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1737111954; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=qHcoPfOv6nHacGYBmCbCnZc2leprJNl/XevOa0fyg6M=;
	b=mgySlyVXay/RnFwjSPXfXp99vX6+Q26+G6q0I96HZuHfC7pq7QduRj/w/InbX4FPmZwbmq
	YZJ//eurUKdmyOYzZ9v5bpVIHmIJ1YKl0Gnh2wNsP9eey1JSSX4vE8RICPOI/PHL6mTGUH
	R02VO5KcmPAtAXwlmFtdTs+TPmYChcI=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1737111954; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=qHcoPfOv6nHacGYBmCbCnZc2leprJNl/XevOa0fyg6M=;
	b=mgySlyVXay/RnFwjSPXfXp99vX6+Q26+G6q0I96HZuHfC7pq7QduRj/w/InbX4FPmZwbmq
	YZJ//eurUKdmyOYzZ9v5bpVIHmIJ1YKl0Gnh2wNsP9eey1JSSX4vE8RICPOI/PHL6mTGUH
	R02VO5KcmPAtAXwlmFtdTs+TPmYChcI=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1604413332;
	Fri, 17 Jan 2025 11:05:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id UAjUA5I5imeidAAAD6G6ig
	(envelope-from <jgross@suse.com>); Fri, 17 Jan 2025 11:05:54 +0000
From: Juergen Gross <jgross@suse.com>
To: gregkh@linuxfoundation.org
Cc: stable@vger.kernel.org,
	Juergen Gross <jgross@suse.com>
Subject: [PATCH] x86/xen: fix SLS mitigation in xen_hypercall_iret()
Date: Fri, 17 Jan 2025 12:05:51 +0100
Message-ID: <20250117110551.13930-1-jgross@suse.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -2.80
X-Spam-Flag: NO

The backport of upstream patch a2796dff62d6 ("x86/xen: don't do PV iret
hypercall through hypercall page") missed to adapt the SLS mitigation
config check from CONFIG_MITIGATION_SLS to CONFIG_SLS.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
This patch is meant to be applied to the following stable kernels:
- linux-6.6
- linux-6.1
- linux-5.15
- linux-5.10
---
 arch/x86/xen/xen-asm.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/xen/xen-asm.S b/arch/x86/xen/xen-asm.S
index 901b60516683..6231f6efb4ee 100644
--- a/arch/x86/xen/xen-asm.S
+++ b/arch/x86/xen/xen-asm.S
@@ -221,7 +221,7 @@ SYM_CODE_END(xen_early_idt_handler_array)
 	push %rax
 	mov  $__HYPERVISOR_iret, %eax
 	syscall		/* Do the IRET. */
-#ifdef CONFIG_MITIGATION_SLS
+#ifdef CONFIG_SLS
 	int3
 #endif
 .endm
-- 
2.43.0


