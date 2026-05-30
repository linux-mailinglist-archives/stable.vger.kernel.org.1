Return-Path: <stable+bounces-257186-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wOpJJFIYG2pV/AgAu9opvQ
	(envelope-from <stable+bounces-257186-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 19:03:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E14FF60ECE0
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 19:03:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 699BA3089E59
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 16:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0256A33FE15;
	Sat, 30 May 2026 16:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="F0eyp84M"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA1B533F5A3;
	Sat, 30 May 2026 16:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780160110; cv=none; b=LqkGpL7Vu839gidXXY9UAzyNm1Af4QWd6IayBf8rgbuQXB3SfXn7zKLJWxEubroDqHxhDrVZmbXh+2xMp/JaqP2LmM0gK1qk17fteqvgisoJ/ChRU8ULMNJqrtABg22rIXlpsErrgciRoJuXIrEoOOAFKnY2ht46At89ZcuX9f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780160110; c=relaxed/simple;
	bh=F3hm1FVLbI3vgMAWUunpe2/kbwSUthaeushk+3gNbbk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QrkYxTlVF17bDJmAcYEXwnaCbnWSVNNehbb53aDj4uAn2MKO/Lok0QaaQ6Uamtp+aVuTnoz7py0S7dx32cnlNoSPtAMStpT+4kg14zil62hq4fOdZ+9Ef46vcdKKV3ZN/TCL5mPg4XlpObgBlWZGUMC6ofgOH1zCVQFVrxhC8uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=F0eyp84M; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28B5F1F00893;
	Sat, 30 May 2026 16:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780160109;
	bh=Hq3ITEbRiLGnpQ2QcDunhy7Rv/sje2A6jZIozubA+0k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=F0eyp84MZ9MIfajk09K5POnH/RbVgeFUUUIsf5QTUo8IbktkXIAgXrYIjF/Uj5lRY
	 9QH3Bs1/zPSHyqpCeGeUmDW6RpPh8yHIufP6qoUSiJC35vcjg0OwmxTL5f70EkmFT7
	 6t686hGv4SFCb9FxUt4CfU48w5+i+HUmBdQfFQWc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sohei Koyama <skoyama@ddn.com>,
	Andreas Dilger <adilger@dilger.ca>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Zhang Yi <yi.zhang@huawei.com>,
	Baokun Li <libaokun@linux.alibaba.com>,
	Theodore Tso <tytso@mit.edu>
Subject: [PATCH 6.1 247/969] ext4: fix missing brelse() in ext4_xattr_inode_dec_ref_all()
Date: Sat, 30 May 2026 17:56:11 +0200
Message-ID: <20260530160307.286911835@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530160300.485627683@linuxfoundation.org>
References: <20260530160300.485627683@linuxfoundation.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,ddn.com,dilger.ca,gmail.com,huawei.com,linux.alibaba.com,mit.edu];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257186-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: E14FF60ECE0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sohei Koyama <skoyama@ddn.com>

commit 77d059519382bd66283e6a4e83ee186e87e7708f upstream.

The commit c8e008b60492 ("ext4: ignore xattrs past end")
introduced a refcount leak in when block_csum is false.

ext4_xattr_inode_dec_ref_all() calls ext4_get_inode_loc() to
get iloc.bh, but never releases it with brelse().

Fixes: c8e008b60492 ("ext4: ignore xattrs past end")
Signed-off-by: Sohei Koyama <skoyama@ddn.com>
Reviewed-by: Andreas Dilger <adilger@dilger.ca>
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Cc: stable@vger.kernel.org
Reviewed-by: Zhang Yi <yi.zhang@huawei.com>
Reviewed-by: Baokun Li <libaokun@linux.alibaba.com>
Link: https://patch.msgid.link/20260406074830.8480-1-skoyama@ddn.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ext4/xattr.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -1112,7 +1112,7 @@ ext4_xattr_inode_dec_ref_all(handle_t *h
 {
 	struct inode *ea_inode;
 	struct ext4_xattr_entry *entry;
-	struct ext4_iloc iloc;
+	struct ext4_iloc iloc = { .bh = NULL };
 	bool dirty = false;
 	unsigned int ea_ino;
 	int err;
@@ -1207,6 +1207,8 @@ ext4_xattr_inode_dec_ref_all(handle_t *h
 			ext4_warning_inode(parent,
 					   "handle dirty metadata err=%d", err);
 	}
+
+	brelse(iloc.bh);
 }
 
 /*



