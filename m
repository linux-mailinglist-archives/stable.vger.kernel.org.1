Return-Path: <stable+bounces-243675-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QGj1Jamv+GkPzAIAu9opvQ
	(envelope-from <stable+bounces-243675-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:39:37 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 932C44BFD4C
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:39:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BAD20308A6DF
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 14:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 397903DE454;
	Mon,  4 May 2026 14:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uBgY5q/3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6B23DE45A;
	Mon,  4 May 2026 14:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777904489; cv=none; b=BG/8GMrDsBDtPtbg61Wuv7Gd8QP+VCEWRqfpVU/GNpfmYy0/ToJbWvSxd+5CJLznn0f2Lz7scefpxTr9LR6eqP6qv9fWVMLFwYHLADt+YOR4BEsNGL+k4Pb2+hYK5FfP4lr//O0FgesrHAo09+ZzP+nreaNWzCMxGZQGpv2WsOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777904489; c=relaxed/simple;
	bh=I0Rw/BMyqVqz/qGZWwvQoPka6dN/wVODhkA/Uxl5afY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=olLlsKbRRHCDlOQ2Jt+MNY4OjlzE/lJv57u6cP90l6q6YDV0NXFO8JTR+VvpdSOj4eqQJJ+tLHzTL2ACRWU29erijJ0URtHtBredf/33VawaS9rRq3vXwVyF05U0BjiH517WVQOjMX+NPLyRDddjWvB+iTmFKi3QYVDa0A1BZEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uBgY5q/3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85493C2BCB8;
	Mon,  4 May 2026 14:21:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777904488;
	bh=I0Rw/BMyqVqz/qGZWwvQoPka6dN/wVODhkA/Uxl5afY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uBgY5q/3rMeDLiVVFJmKTK8Nu5YjYaqIAbvZxO++6Ly3rA9B6wE/z9PmyOqZXPNzS
	 vDY9OiIlswY9TB6KeZcyrzhgJ7kiF2VVqvc6GaKdxfo4KXTJcS4CZwr+mq8Cp8BvXg
	 SCNEdP81WLmjbY9t99zWK4ARqODJ3hz/GCncvV1Y=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Zhang Yi <yi.zhang@huawei.com>,
	Theodore Tso <tytso@mit.edu>,
	stable@kernel.org
Subject: [PATCH 6.12 057/215] jbd2: fix deadlock in jbd2_journal_cancel_revoke()
Date: Mon,  4 May 2026 15:51:16 +0200
Message-ID: <20260504135132.258708313@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260504135130.169210693@linuxfoundation.org>
References: <20260504135130.169210693@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 932C44BFD4C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-243675-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,msgid.link:url,huawei.com:email]

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zhang Yi <yi.zhang@huawei.com>

commit 981fcc5674e67158d24d23e841523eccba19d0e7 upstream.

Commit f76d4c28a46a ("fs/jbd2: use sleeping version of
__find_get_block()") changed jbd2_journal_cancel_revoke() to use
__find_get_block_nonatomic() which holds the folio lock instead of
i_private_lock. This breaks the lock ordering (folio -> buffer) and
causes an ABBA deadlock when the filesystem blocksize < pagesize:

     T1                                T2
ext4_mkdir()
 ext4_init_new_dir()
  ext4_append()
   ext4_getblk()
    lock_buffer()    <- A
                                   sync_blockdev()
                                    blkdev_writepages()
                                     writeback_iter()
                                      writeback_get_folio()
                                       folio_lock()   <- B
     ext4_journal_get_create_access()
      jbd2_journal_cancel_revoke()
       __find_get_block_nonatomic()
        folio_lock()  <- B
                                     block_write_full_folio()
                                      lock_buffer()   <- A

This can occasionally cause generic/013 to hang.

Fix by only calling __find_get_block_nonatomic() when the passed
buffer_head doesn't belong to the bdev, which is the only case that we
need to look up its bdev alias. Otherwise, the lookup is redundant since
the found buffer_head is equal to the one we passed in.

Fixes: f76d4c28a46a ("fs/jbd2: use sleeping version of __find_get_block()")
Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
Link: https://patch.msgid.link/20260409114204.917154-1-yi.zhang@huaweicloud.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Cc: stable@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/jbd2/revoke.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

--- a/fs/jbd2/revoke.c
+++ b/fs/jbd2/revoke.c
@@ -429,6 +429,7 @@ int jbd2_journal_cancel_revoke(handle_t
 	int need_cancel;
 	int did_revoke = 0;	/* akpm: debug */
 	struct buffer_head *bh = jh2bh(jh);
+	struct address_space *bh_mapping = bh->b_folio->mapping;
 
 	jbd2_debug(4, "journal_head %p, cancelling revoke\n", jh);
 
@@ -466,13 +467,14 @@ int jbd2_journal_cancel_revoke(handle_t
 	 * buffer_head?  If so, we'd better make sure we clear the
 	 * revoked status on any hashed alias too, otherwise the revoke
 	 * state machine will get very upset later on. */
-	if (need_cancel) {
+	if (need_cancel && !sb_is_blkdev_sb(bh_mapping->host->i_sb)) {
 		struct buffer_head *bh2;
+
 		bh2 = __find_get_block_nonatomic(bh->b_bdev, bh->b_blocknr,
 						 bh->b_size);
 		if (bh2) {
-			if (bh2 != bh)
-				clear_buffer_revoked(bh2);
+			WARN_ON_ONCE(bh2 == bh);
+			clear_buffer_revoked(bh2);
 			__brelse(bh2);
 		}
 	}



