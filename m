Return-Path: <stable+bounces-61430-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B0A8C93C31D
	for <lists+stable@lfdr.de>; Thu, 25 Jul 2024 15:36:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4D591C2114E
	for <lists+stable@lfdr.de>; Thu, 25 Jul 2024 13:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87A3A198E78;
	Thu, 25 Jul 2024 13:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IuQpvPYg"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B08A4C8DF
	for <stable@vger.kernel.org>; Thu, 25 Jul 2024 13:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721914606; cv=none; b=DQu1ogkecgqcTZ5cTSdZ4j046LwL/88WDOeaXVC7AzayQq+/sIRoHlsyf1VAPxEpYJxACRjSzQLfhpe+ykYZO6N4QPbU2Fn84PZmWUApABN7OwZwSpjoIp9nc3SHEFA7X35WRbCXOvqak7Rwxwb/C3lq31Gjwnwsf56oQKsdF6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721914606; c=relaxed/simple;
	bh=J5MGTw4Lo37SVAoabN3Fr/KKgg2UEJjeG2UpeGbbvz8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Meh3kWMP4UTRpLlbY61CE2ZaBVosTQksU/P36WE89weSgFPfGstNyzQ5oMg115K3OJ6lDr/xhOu9OHUhNrsjMS1VDJLTzNFWHyglFKJoi6GbOTUw7NC9Y4KFORthKmxGrkM9SoP4C7Q64WPUd5WSzAwmb2FlK2cjR0bJBAZ0eKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IuQpvPYg; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4266fd395eeso6846515e9.3
        for <stable@vger.kernel.org>; Thu, 25 Jul 2024 06:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721914603; x=1722519403; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ci5WccFjX7Id9FxFRfbLX6JJ9WpQtxw7zRs+FLTrQyo=;
        b=IuQpvPYgBQmrHWB9zG8AM1rk8nVBgnBKa33bvchdW9lI97GmIQUrlTaQX52Wpaz1RY
         NCsag939p5ang6BA+DCMHv2FSrQS0mkbQC7w6wfCP+Ay197E9qKPIwh9RmWHCIaaqaF4
         6/vFwVMIoQgMv1PQvvyduT7IwRO3sdAEs+bNl2c6aJ9S1nhW3zSoq+2ZrPNYA8oiaWUq
         ychdE9eGshj/CxwCBLsMBfYg6vBBA9K/Ef5cJvxQ+n23uaD6L1ptYsqxZwvZYiDRtrS2
         YVym94yISxGk/NmC3C1a4YGUBJsRWxvbPeH2Oj7tLwYzMNBXQmqetJJnabrCZ2GRBOtO
         cieg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721914603; x=1722519403;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ci5WccFjX7Id9FxFRfbLX6JJ9WpQtxw7zRs+FLTrQyo=;
        b=B+zMaWCG1CW6zm5mIKIYxqAjzscLC93KdT8M6VqMLHUYjDBAiFL0tVxdHsRQTTqE5O
         i/0/hgNNzX6VcBZTz5Qvxvyk75Ve7t7qlcQ607g5sqeTi26A/J/3CrL1RtzXQufsM8da
         ILa2YMevN/UVTQIG2690QbzzKFJVOwTQ4gRjYz+QEkA0BmuS3QYM/vtpDeasSiKV/F+P
         4RinZCDXYlWSwQF8e4YtqoCQmqwWlSWf9UyVwMdpXdYTrl5/OhMAWzqz30+j2eSR2ERd
         GHdzBGzEr9RX9ueQ1tp5Dqczwzblzp/LLMV5khTXQOefk915alfAnR3GADpHYgAkTtyd
         Bgtw==
X-Gm-Message-State: AOJu0YyVOzLV0XJj2g7F59f5jJ4ruxbQNxR26/7jIajycsTjn9mnQqxi
	9oQPboc6FFlSZ/6deYfdkuvxDFnkZIjNdG0Ya+9CWZz3RuZ63M6BXW6laAxS
X-Google-Smtp-Source: AGHT+IEf069GnhZM17p/H3KJ8SZnEu8EBtK9yPg40M3mQXRhH0/CJRsEcTugpE8Hlx+7BnCCCjxjGw==
X-Received: by 2002:a05:600c:4ca1:b0:426:5dc8:6a6a with SMTP id 5b1f17b1804b1-42806bae7admr15268185e9.21.1721914602560;
        Thu, 25 Jul 2024 06:36:42 -0700 (PDT)
Received: from laptop.home (83.50.134.37.dynamic.jazztel.es. [37.134.50.83])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-428057b740bsm36977455e9.46.2024.07.25.06.36.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 06:36:42 -0700 (PDT)
From: =?UTF-8?q?Sergio=20Gonz=C3=A1lez=20Collado?= <sergio.collado@gmail.com>
To: stable@vger.kernel.org
Cc: linux-kernel-mentees@lists.linuxfoundation.org,
	Filipe Manana <fdmanana@suse.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	David Sterba <dsterba@suse.com>,
	=?UTF-8?q?Sergio=20Gonz=C3=A1lez=20Collado?= <sergio.collado@gmail.com>,
	syzbot+c56033c8c15c08286062@syzkaller.appspotmail.com
Subject: [PATCH 6.1.y] btrfs: do not BUG_ON on failure to get dir index for new snapshot
Date: Thu, 25 Jul 2024 15:35:59 +0200
Message-Id: <20240725133559.151607-1-sergio.collado@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

[ Upstream commit df9f278239046719c91aeb59ec0afb1a99ee8b2b ]

During the transaction commit path, at create_pending_snapshot(), there
is no need to BUG_ON() in case we fail to get a dir index for the snapshot
in the parent directory. This should fail very rarely because the parent
inode should be loaded in memory already, with the respective delayed
inode created and the parent inode's index_cnt field already initialized.

However if it fails, it may be -ENOMEM like the comment at
create_pending_snapshot() says or any error returned by
btrfs_search_slot() through btrfs_set_inode_index_count(), which can be
pretty much anything such as -EIO or -EUCLEAN for example. So the comment
is not correct when it says it can only be -ENOMEM.

However doing a BUG_ON() here is overkill, since we can instead abort
the transaction and return the error. Note that any error returned by
create_pending_snapshot() will eventually result in a transaction
abort at cleanup_transaction(), called from btrfs_commit_transaction(),
but we can explicitly abort the transaction at this point instead so that
we get a stack trace to tell us that the call to btrfs_set_inode_index()
failed.

So just abort the transaction and return in case btrfs_set_inode_index()
returned an error at create_pending_snapshot().

Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
(cherry picked from commit df9f278239046719c91aeb59ec0afb1a99ee8b2b)
Signed-off-by: Sergio González Collado <sergio.collado@gmail.com>
Reported-by: syzbot+c56033c8c15c08286062@syzkaller.appspotmail.com
---
 fs/btrfs/transaction.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index a7853a3a5719..604241e6e2c1 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -1701,7 +1701,10 @@ static noinline int create_pending_snapshot(struct btrfs_trans_handle *trans,
 	 * insert the directory item
 	 */
 	ret = btrfs_set_inode_index(BTRFS_I(parent_inode), &index);
-	BUG_ON(ret); /* -ENOMEM */
+	if (ret) {
+		btrfs_abort_transaction(trans, ret);
+		goto fail;
+	}
 
 	/* check if there is a file/dir which has the same name. */
 	dir_item = btrfs_lookup_dir_item(NULL, parent_root, path,
-- 
2.39.2


