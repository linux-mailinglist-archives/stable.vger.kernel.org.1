Return-Path: <stable+bounces-230540-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oL0LI/zAxWlnBQUAu9opvQ
	(envelope-from <stable+bounces-230540-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 00:27:56 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BD0533D0B9
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 00:27:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 89FF8305E308
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 23:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D483839B4B8;
	Thu, 26 Mar 2026 23:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tDgp5RN4"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E6939902D
	for <stable@vger.kernel.org>; Thu, 26 Mar 2026 23:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774567301; cv=none; b=H2zwYGXKp+qmHMaDrj4Xi/UQWGyNUF3tqNxfDlVZl924XPpiNVaPQXTAK43yeH+Na/7QrjKmvn+OAgdhWfTa0ADY6bxgNbDYl9JWn99tKOx3oIy+dhuKME/yb6Hg+eyf9l6BdaqHMh9/rGUP7Zeud5kat8impGcJD4vdLhDZDJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774567301; c=relaxed/simple;
	bh=hpbfVrehy2OjGPM+jJX1ohV94KpPjBKZvlND6YVVV40=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YKlWLCWOIri1YSvFVikZzKtVrAwECKGmVl/h3p7G4rrdjM7bvbMzICaeMrzly2tn+skBjgb312EBBRqy4/Lbs4V8vViulgIZD81D+O7KL5YUIE+h5n1ylz9JMx8Eh4/nLf33cBs9XUyeej/9j00/pqg5XnW+A1YMDMsCzIA0tI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tDgp5RN4; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-35c0e7b751aso1487404a91.2
        for <stable@vger.kernel.org>; Thu, 26 Mar 2026 16:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774567300; x=1775172100; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=f+mEOaggnyuWbQn7RlN5WCwkPLdohB+eIDOx+cSRQiM=;
        b=tDgp5RN48Jxr+or6rZRB2JA5T1vgXSMVpJZ2nSTsn6RLklZwLa+W+6UAzP0Yx4aJgg
         4hZpOZ4RxUPV6TSYNov8mIEet5VCk9+EANVJUz4u+kK0imvROCLPQ6xvZpiQD/DcjAtY
         R7PaTuS+410B22PAc/yO0ENZv6SvzAhRV182tiFFb0oGWHlKHOclxtL8q2jSUGY0vyKq
         8Y4y9RasapVsYZL6jneOz6KVH9nvR8efg1uG9V4M/DljA09LHdwPBhctjIoe0qXGhIIe
         1qw/Rvlg1eDRZT0xKG2xfEBZKrzcuXyNdncUCoNr8M90p5upzvizDP2apyJU92rhp9zD
         EzGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774567300; x=1775172100;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f+mEOaggnyuWbQn7RlN5WCwkPLdohB+eIDOx+cSRQiM=;
        b=hHybmEU90cqebiH+r0kJ4DSkq7eUNDWlMauqwZlR1VHnKduCwdKTHQcIhAsilGOv/0
         I0HHJSMNRIBAySxMGnoUjMQjpjbxmwowr0vAQXSVSPoWtyDI9g5oSbWLzFdlVwJXTsvj
         HZ9b53ZTTVk6Yjzcyja3XbE3biXa1CZDQLYmFGYLuB6H/Y94u2h9mzzdQI9h0ec1Bvdt
         BIerom6/Jozw+kNtdO4KEu2rPG5Y2bo6RypkE84ZJ9USULy9i5fqI1ZiFAPM9nXXm/bF
         oo/DRTcm/3rnUDGwjfyJNxvw77H/H2blRncm4X9waMlSGuNbhUcUebqXJPNKel38Rwkg
         +xEA==
X-Forwarded-Encrypted: i=1; AJvYcCVL+5wo87EjUXtEmyFZTf/r9Utr07nGhqvKJVtbjGqbzGKo036VVX/4CQaKuhasczDiYq6X14k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9JJy14YHtXDKKfOPndYX0oPNkpbDgeRDgE6ZxyDKwvBUF8bcK
	n1jXUWcoVD71ymQkChdMA/R/adKdK456DsdzgmWWjQDxFwhv33CsyYMp
X-Gm-Gg: ATEYQzySD1dIe5J4J5z8n21CO2/urjK+AQbVe4KF5MNzYMk/itl1EAai6MgXiSd/RbO
	v6tXfGLMQFW+9zHyUfcGadA3XKoScIcz4F6XVE9MfM1L5IxZC7/QJVchYtbNO3Rp1KqsBkN/530
	xh3rvbYOzkGsHk7mSaVXJqSlbtpQG+4hqBthKx7oPaQWYngZbBtvsSnPpSjiY9bUqdOEXkmoJiK
	ceUdZ3vSLNcb/HJXaL7NPoH6emLImo5nKkd8WJmb8EvKeDCs9hkozhzqliLlz8XBamSLbk7TxXI
	YbMlY+c3NZCYwXBB2ZX6vtuP1ZNY8kQwxIS14L7cSmPZZmEm9VebZFPWA1p/OcZtZ2Zl24AiDIA
	8MvayI0WcZ9p8Vjv1ndrAberjaK/t5T2OZ2PwKKXjqlsgQT7v4zPOZNDXQOiGaF+meAUMMbPiUI
	Zj3VwDomVOrf18xik1nRq6CF364Rk=
X-Received: by 2002:a17:90b:4f41:b0:35b:af3f:3618 with SMTP id 98e67ed59e1d1-35c3010eda1mr342185a91.28.1774567299618;
        Thu, 26 Mar 2026 16:21:39 -0700 (PDT)
Received: from hpxjwg3u.sm.local ([203.123.64.28])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35c22a4c36fsm2794222a91.4.2026.03.26.16.21.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 16:21:39 -0700 (PDT)
From: Xiang Shen <turyshen@gmail.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	Mateusz Guzik <mjguzik@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Xiang Shen <turyshen@gmail.com>
Subject: [PATCH 1/1] fs: fix deadlock in insert_inode_locked() waiting for inode eviction
Date: Fri, 27 Mar 2026 10:21:30 +1100
Message-Id: <20260326232130.1891210-1-turyshen@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-230540-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[turyshen@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2BD0533D0B9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Commit 88ec797c4680 ("fs: make insert_inode_locked() wait for inode
destruction") changed insert_inode_locked() to sleep via
__wait_on_freeing_inode() when it encounters an inode being freed.  This
introduces a deadlock when the caller already holds resources that the
eviction path needs.

For example, ext4_new_inode() holds an active jbd2 journal handle when
it calls insert_inode_locked().  If a stale inode with the same ino is
being freed, the function now sleeps waiting for eviction to complete.
However, ext4_evict_inode() needs to start a new journal transaction via
ext4_journal_start(), which may block in add_transaction_credits()
waiting for the current transaction to commit.  That transaction cannot
commit because the caller's handle (in ext4_new_inode) is still active,
resulting in a deadlock:

  Thread A (ext4_new_inode)         Thread B (evicting old inode)
  -------------------------         ----------------------------
  jbd2_journal_start() -> handle
  insert_inode_locked()
    finds old inode I_FREEING
    __wait_on_freeing_inode()
      schedule() [waits for B]      ext4_evict_inode()
                                      ext4_journal_start()
                                        add_transaction_credits()
                                          [waits for T to commit]
                                          [T blocked by A's handle]

Fix this by replacing the blocking __wait_on_freeing_inode() call with a
non-blocking drop-and-retry loop.  When a freeing inode is encountered,
drop both i_lock and inode_hash_lock, yield the CPU with cond_resched(),
and restart the outer while(1) loop via continue.

Unlike the pre-88ec797c4680 code which skipped freeing inodes within the
inner hlist_for_each_entry loop (risking duplicate inodes in the hash),
this fix restarts the entire lookup from scratch -- the new inode is only
inserted when no matching entry (including freeing ones) exists in the
hash chain.

Fixes: 88ec797c4680 ("fs: make insert_inode_locked() wait for inode destruction")
Cc: stable@vger.kernel.org
Signed-off-by: Xiang Shen <turyshen@gmail.com>
---
 fs/inode.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index cc12b68e021b..8ecdd297c83f 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -1842,7 +1842,6 @@ int insert_inode_locked(struct inode *inode)
 	while (1) {
 		struct inode *old = NULL;
 		spin_lock(&inode_hash_lock);
-repeat:
 		hlist_for_each_entry(old, head, i_hash) {
 			if (old->i_ino != ino)
 				continue;
@@ -1860,9 +1859,10 @@ int insert_inode_locked(struct inode *inode)
 			return 0;
 		}
 		if (inode_state_read(old) & (I_FREEING | I_WILL_FREE)) {
-			__wait_on_freeing_inode(old, true, false);
-			old = NULL;
-			goto repeat;
+			spin_unlock(&old->i_lock);
+			spin_unlock(&inode_hash_lock);
+			cond_resched();
+			continue;
 		}
 		if (unlikely(inode_state_read(old) & I_CREATING)) {
 			spin_unlock(&old->i_lock);
-- 
2.34.1


