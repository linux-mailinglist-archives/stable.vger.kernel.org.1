Return-Path: <stable+bounces-230581-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UMcdAvAExmk5FQUAu9opvQ
	(envelope-from <stable+bounces-230581-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 05:17:52 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 87D1C33F118
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 05:17:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0735130A109A
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 04:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EE6E378D84;
	Fri, 27 Mar 2026 04:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="jtIEHhig"
X-Original-To: stable@vger.kernel.org
Received: from out199-1.us.a.mail.aliyun.com (out199-1.us.a.mail.aliyun.com [47.90.199.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A114346FC6
	for <stable@vger.kernel.org>; Fri, 27 Mar 2026 04:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.199.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774584953; cv=none; b=kqoM5I4igc6HwGc7TPlxRXQfZNMvSjE0JvBO50RyO0Ph/OVVcmcnbTETBLHUiZvDAi2ep1BMWgPvKrSh2v1Q5QJmULIjJFpB104gHz1R1ob/3kDVNB7Pjska7WM+50ptXgtSrTdYHAKok6n+BJ0D48ejcaB2K7vLi4Pbrtu1m24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774584953; c=relaxed/simple;
	bh=uwQpGT+RNhxzxY9sg8Kez7DTmMKSheNykE6A6s+zve0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X/cEHsR7FKmnj3Y7NDBiUedm8v30dRWcsSCHeRvYROwhkcPHHDGftY5hW7HyB9PcOaDqPAHwhlJ+x7Bstb0VsUvA9+IK/2EyRQoKh7HphcZJWP+XQWqEBmT1a8nHYFqVBZ/xHVAODLRbtatFKk2KgipDw6EzzUQBYSxqHwUTHqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=jtIEHhig; arc=none smtp.client-ip=47.90.199.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1774584930; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=SaMl55v3P256PUqGIsXKeLgVv4g7GfDpRpgEKt5uNj4=;
	b=jtIEHhig4G60GApHh6VutWxWZmlqqctVP6g3YYIWDD/zx/9G+byFV5AoI69P/E3TP996KLROqgTOF/pnB36JSxMCT2sPsdY4INnk4a6V3ScdT08/J5T/Csaax4npF7ic4ORU54SZXw4wza804EaBBOV03wFRwNVpGcL65GAN3s0=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0X.n37JY_1774584925;
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X.n37JY_1774584925 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 27 Mar 2026 12:15:30 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-erofs@lists.ozlabs.org,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	syzbot+b6353e35ae2bab997538@syzkaller.appspotmail.com
Subject: [PATCH 6.6.y] erofs: fix "BUG: Bad page state in z_erofs_do_read_page"
Date: Fri, 27 Mar 2026 12:15:24 +0800
Message-ID: <20260327041524.1087336-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-6.16 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-230581-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable,b6353e35ae2bab997538];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[syzkaller.appspot.com:url,linux.alibaba.com:dkim,linux.alibaba.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,alibaba.com:email]
X-Rspamd-Queue-Id: 87D1C33F118
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

It's actually a stable-only issue from backporting 9e2f9d34dd12
("erofs: handle overlapped pclusters out of crafted images properly")

We missed to update `oldpage` after `pcl->compressed_bvecs[nr].page`
is updated, so that the following cmpxchg() will fail; the original
upstream commit doesn't behave like this due to new features and
refactoring.

This backport issue only impacts some specific crafted images and
normal filesystems won't be impacted at all.

Fixes: 1bf7e414cac3 ("erofs: handle overlapped pclusters out of crafted images properly") # 6.6.y
Closes: https://syzkaller.appspot.com/bug?extid=b6353e35ae2bab997538
Reported-and-tested-by: syzbot+b6353e35ae2bab997538@syzkaller.appspotmail.com [1]
[1] https://lore.kernel.org/r/69c3b299.a70a0220.234938.004b.GAE@google.com
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/zdata.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index c1f802ecc47b..97764612fc76 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -1500,6 +1500,7 @@ static struct page *pickup_page_for_submission(struct z_erofs_pcluster *pcl,
 	lock_page(page);
 	if (likely(page->mapping == mc)) {
 		WRITE_ONCE(pcl->compressed_bvecs[nr].page, page);
+		oldpage = page;
 
 		/*
 		 * The cached folio is still in managed cache but without
-- 
2.43.5


