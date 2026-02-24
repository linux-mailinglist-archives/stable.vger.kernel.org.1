Return-Path: <stable+bounces-217853-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sp50CN4cnWmuMwQAu9opvQ
	(envelope-from <stable+bounces-217853-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 04:37:02 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C89B01816AD
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 04:37:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A957B303663A
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 03:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B12421B9F5;
	Tue, 24 Feb 2026 03:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=139.com header.i=@139.com header.b="5JF4KW2J"
X-Original-To: stable@vger.kernel.org
Received: from n169-111.mail.139.com (n169-111.mail.139.com [120.232.169.111])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C43358C1F
	for <stable@vger.kernel.org>; Tue, 24 Feb 2026 03:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=120.232.169.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771904217; cv=none; b=lRGOmY3KrZBa2JjhsPYpqkiSHhcYvqvpaTdy+kghrxXI1fspB2pSJlUAzZ5ua9KP1kS+jYSHMV1MlZM+Q3xw22K6HUOjMqKa5wae66r32jtH1iv+EPpdUqPqX6//euoO6Wu6CJv7VaTUwaJ+TdSV8U0L7qsG3IJH3Ez3rekjRbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771904217; c=relaxed/simple;
	bh=ErJlm82ImNLhLdSoIgv+QJnE9j/M4ecqEgTTZKHxD6M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aqd4DYK229x6E9EXF4V7Vc4cC7VD97Pr/RlFldM+CK1B6BGWozlCMOW7PauyNICf7auFm/8FKoLRmo+3MZ0rSbt+C+1W+QSdOQDzPLbTzUorpKLUl8zPcaLNNHFxztvXfAEA0Wb71Myq4MW9n2WdJB7DPmWLf8f1TXGNILPfseM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com; spf=pass smtp.mailfrom=139.com; dkim=pass (1024-bit key) header.d=139.com header.i=@139.com header.b=5JF4KW2J; arc=none smtp.client-ip=120.232.169.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=139.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=139.com; s=dkim; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=5JF4KW2JhSfYU2clmoNc5KxQNNMYipPM84lzHrjGqzd8D52WTOiQnx0RtvTqt3bmO6FdmAqjxYOfZ
	 fQb9RD/lHEQz6X1Ysf9er4z+VTgm8YbOBjFhTo1p7IaPKduzkHhDHMo63SMQ6LaQeFOvcTjLV9ahTT
	 3HusbLnOSjnZ4Ojw=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM:                                                                                        
X-RM-SPAM-FLAG:00000000
Received:from ubuntu24.corp.ad.wrs.com (unknown[120.244.194.215])
	by rmsmtp-lg-appmail-11-12089 (RichMail) with SMTP id 2f39699d1bcf10f-d95d2;
	Tue, 24 Feb 2026 11:32:32 +0800 (CST)
X-RM-TRANSID:2f39699d1bcf10f-d95d2
From: Bin Lan <lanbincn@139.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: =?UTF-8?q?Miquel=20Sabat=C3=A9=20Sol=C3=A0?= <mssola@mssola.com>,
	syzbot+d991fea1b4b23b1f6bf8@syzkaller.appspotmail.com,
	David Sterba <dsterba@suse.com>,
	Bin Lan <lanbincn@139.com>
Subject: [PATCH 6.6.y] btrfs: fix NULL dereference on root when tracing inode eviction
Date: Tue, 24 Feb 2026 03:32:14 +0000
Message-ID: <20260224033214.4976-1-lanbincn@139.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[139.com:s=dkim];
	MID_CONTAINS_FROM(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[139.com];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[139.com];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[mssola.com,syzkaller.appspotmail.com,suse.com,139.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-217853-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[139.com:-];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lanbincn@139.com,stable@vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-0.994];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable,d991fea1b4b23b1f6bf8];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,appspotmail.com:email,syzkaller.appspot.com:url,suse.com:email,mssola.com:email]
X-Rspamd-Queue-Id: C89B01816AD
X-Rspamd-Action: no action

From: Miquel Sabaté Solà <mssola@mssola.com>

[ Upstream commit f157dd661339fc6f5f2b574fe2429c43bd309534 ]

When evicting an inode the first thing we do is to setup tracing for it,
which implies fetching the root's id. But in btrfs_evict_inode() the
root might be NULL, as implied in the next check that we do in
btrfs_evict_inode().

Hence, we either should set the ->root_objectid to 0 in case the root is
NULL, or we move tracing setup after checking that the root is not
NULL. Setting the rootid to 0 at least gives us the possibility to trace
this call even in the case when the root is NULL, so that's the solution
taken here.

Fixes: 1abe9b8a138c ("Btrfs: add initial tracepoint support for btrfs")
Reported-by: syzbot+d991fea1b4b23b1f6bf8@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=d991fea1b4b23b1f6bf8
Signed-off-by: Miquel Sabaté Solà <mssola@mssola.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
[ Adjust context ]
Signed-off-by: Bin Lan <lanbincn@139.com>
---
 include/trace/events/btrfs.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/trace/events/btrfs.h b/include/trace/events/btrfs.h
index f759109caeea..eb762cc7bec5 100644
--- a/include/trace/events/btrfs.h
+++ b/include/trace/events/btrfs.h
@@ -225,8 +225,8 @@ DECLARE_EVENT_CLASS(btrfs__inode,
 		__entry->generation = BTRFS_I(inode)->generation;
 		__entry->last_trans = BTRFS_I(inode)->last_trans;
 		__entry->logged_trans = BTRFS_I(inode)->logged_trans;
-		__entry->root_objectid =
-				BTRFS_I(inode)->root->root_key.objectid;
+		__entry->root_objectid = BTRFS_I(inode)->root ?
+					 btrfs_root_id(BTRFS_I(inode)->root) : 0;
 	),
 
 	TP_printk_btrfs("root=%llu(%s) gen=%llu ino=%llu blocks=%llu "
-- 
2.43.0



