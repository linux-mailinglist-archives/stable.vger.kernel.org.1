Return-Path: <stable+bounces-234265-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yF5jEbKc1mmyGggAu9opvQ
	(envelope-from <stable+bounces-234265-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:21:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D7DA13C07AC
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:21:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 14B233039BEE
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 18:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B619A3AF646;
	Wed,  8 Apr 2026 18:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jQ+hylml"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C27386550;
	Wed,  8 Apr 2026 18:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775672411; cv=none; b=eF8pqd1nwaOnxpy0hx6P26ICkjPZDYs3yFo9rAX/RjruZ61I2X+rU4W693FaZ50RpLy3Z/BBHPGsZwCXY/hZfWaGr846tMHPGQhTF2HuzJNE4PSicfTblbp1SvoRsd7hL0r8rajl7UyOxwr82O8K3JrT9EeTWqm8tv1DiAA6M7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775672411; c=relaxed/simple;
	bh=DvXGfJ9Oo7ghRsfDGJnIh3sp02I9zCEZEJtSy4jMH7w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L6oqTReCn9/XJiCF4RcfCT7x5lQadupcrpvFDQLp6htVcV3gHY9SdY+8ueRYd+KNRYoEnKION6USBPqcKISO/wqXhY6yrfsYs+xuqNVpza2s4ovgrwPNzUlEjfLOBhuf6a/7N2scEUvwkZr9+QIvCkzKBNEHD6g5SorQOsD2/pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jQ+hylml; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08F92C19421;
	Wed,  8 Apr 2026 18:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775672411;
	bh=DvXGfJ9Oo7ghRsfDGJnIh3sp02I9zCEZEJtSy4jMH7w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jQ+hylmlrE0De6hgy7r1U38U9DbxuuUJC+/kt4PXtuuPpmFTHCrCdBk7VnCBrfbNJ
	 LtJtRxiu1Plxox1xaP+asCvM2XnENxeMHUIsWVfcscJJGbpAQVIVH51jdJJMOKlNLI
	 nqgdM3eljGto3anQ9RtasoDsQIIqW3KmfHoKTYj0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+bbf0f9a213c94f283a5c@syzkaller.appspotmail.com,
	Theodore Tso <tytso@mit.edu>,
	Jason Yan <yanaijie@huawei.com>
Subject: [PATCH 6.1 310/312] ext4: fix lost error code reporting in __ext4_fill_super()
Date: Wed,  8 Apr 2026 20:03:47 +0200
Message-ID: <20260408175945.352602900@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408175933.715315542@linuxfoundation.org>
References: <20260408175933.715315542@linuxfoundation.org>
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
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-234265-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable,bbf0f9a213c94f283a5c];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,syzkaller.appspot.com:url,appspotmail.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: D7DA13C07AC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Theodore Ts'o <tytso@mit.edu>

commit d5e72c4e3256335d6fb75c2e321144f93141f4f5 upstream.

When code was factored out of __ext4_fill_super() into
ext4_percpu_param_init() the error return was discarded.  This meant
that it was possible for __ext4_fill_super() to return zero,
indicating success, without the struct super getting completely filled
in, leading to a potential NULL pointer dereference.

Reported-by: syzbot+bbf0f9a213c94f283a5c@syzkaller.appspotmail.com
Fixes: 1f79467c8a6b ("ext4: factor out ext4_percpu_param_init() ...")
Link: https://syzkaller.appspot.com/bug?id=6dac47d5e58af770c0055f680369586ec32e144c
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Reviewed-by: Jason Yan <yanaijie@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ext4/super.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -5531,7 +5531,8 @@ static int __ext4_fill_super(struct fs_c
 		sbi->s_journal->j_commit_callback =
 			ext4_journal_commit_callback;
 
-	if (ext4_percpu_param_init(sbi))
+	err = ext4_percpu_param_init(sbi);
+	if (err)
 		goto failed_mount6;
 
 	if (ext4_has_feature_flex_bg(sb))



