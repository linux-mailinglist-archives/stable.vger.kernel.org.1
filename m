Return-Path: <stable+bounces-262349-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XBwYJ8xGKGr0BQMAu9opvQ
	(envelope-from <stable+bounces-262349-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 09 Jun 2026 19:01:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 117DC662B76
	for <lists+stable@lfdr.de>; Tue, 09 Jun 2026 19:01:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=astralinux.ru header.s=mail header.b=srHLXrYH;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262349-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-262349-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=astralinux.ru;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B0C703025A61
	for <lists+stable@lfdr.de>; Tue,  9 Jun 2026 16:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18C84492526;
	Tue,  9 Jun 2026 16:53:10 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-gw01.astralinux.ru (mail-gw01.astralinux.ru [37.230.196.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41743FDC08;
	Tue,  9 Jun 2026 16:53:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781023989; cv=none; b=hx/s0WmrvslnqIJAhwQYtJ53PkOSFb2TMOGgqApamhuCCwBL9p44oMYSQ3Df0+xS6SsYuZG+cEIasDdBYqNv4gGBGZeWv7fIYjN2Md6NQ63PVbyAozLEg1DzKtQxm/4DgmXlLSQjqv2h6mR64pLdf5z0lbBHos9JAhvO4XxFIAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781023989; c=relaxed/simple;
	bh=BH0tbCa5Sr32v6IXmHJMQWbzPnYCnnKWwTUPw2KRafE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mBdC8Vz+HMRIoUxxdi7+3/gioIQIY8SWMJ565WZzmAT0EdovQwj7Coro9xFB3wColdB6u4u+MuC+Ep1L0sL1jSxnLIXZBMiaSXYqim0SI+7Nebv27FkQpOeS1Z6Ig+/FQYpFpQMNJqI8TcPP10DK1niMf8Q7+a4IKvXHlEZCXbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=astralinux.ru; spf=pass smtp.mailfrom=astralinux.ru; dkim=pass (2048-bit key) header.d=astralinux.ru header.i=@astralinux.ru header.b=srHLXrYH; arc=none smtp.client-ip=37.230.196.243
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=astralinux.ru;
	s=mail; t=1781023495;
	bh=BH0tbCa5Sr32v6IXmHJMQWbzPnYCnnKWwTUPw2KRafE=;
	h=From:To:Cc:Subject:Date:From;
	b=srHLXrYH+ePEflcWpPIf+grp6oDBIiQIDabQec1h95E9Ah53i8cu3lCijmlrlvsu8
	 QDFsMr1i6haEvqarIMGpb7vlyCYM4Yg2IC6xZc5dmbYVZXfva+l9+MMa2T1lYEWMSn
	 63+ijmneLfN93KduMDPjfq+lIdpcAxsLhK7TeNRllmq0rU2HCtTK4saZ//5sKg6kPx
	 qFWdc4JngFFGaNEmzSCJdYPH6tZXl//mvNnedgxDWJ84/nVhfURBLNkGzPmSR4d5g7
	 kEH01KZJzKZs5sm5Wi6nN0w78MPlSBAHDHLIsN/+6ut/QnJ9FL6asTzpOLpwDfII/a
	 arF7ctetaJxHg==
Received: from gca-sc-a-srv-ksmg01.astralinux.ru (localhost [127.0.0.1])
	by mail-gw01.astralinux.ru (Postfix) with ESMTP id E7D27251E9;
	Tue,  9 Jun 2026 19:44:55 +0300 (MSK)
Received: from new-mail.astralinux.ru (unknown [10.205.207.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-gw01.astralinux.ru (Postfix) with ESMTPS;
	Tue,  9 Jun 2026 19:44:53 +0300 (MSK)
Received: from rbta-msk-lt-156703.astralinux.ru (unknown [10.198.18.49])
	by new-mail.astralinux.ru (Postfix) with ESMTPA id 4gZZWn24XXzZcxS;
	Tue, 09 Jun 2026 19:44:53 +0300 (MSK)
From: Alexey Panov <apanov@astralinux.ru>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alexey Panov <apanov@astralinux.ru>,
	"Theodore Ts'o" <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Baokun Li <libaokun@linux.alibaba.com>,
	Jan Kara <jack@suse.cz>,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Zhang Yi <yi.zhang@huawei.com>,
	lvc-project@linuxtesting.org,
	syzbot+04c4e65cab786a2e5b7e@syzkaller.appspotmail.com,
	Tejas Bharambe <tejas.bharambe@outlook.com>,
	stable@kernel.org
Subject: [PATCH 5.10/5.15] ext4: validate p_idx bounds in ext4_ext_correct_indexes
Date: Tue,  9 Jun 2026 19:44:30 +0300
Message-Id: <20260609164430.29988-1-apanov@astralinux.ru>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-KSMG-AntiPhishing: NotDetected, bases: 2026/06/09 15:41:00
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Envelope-From: apanov@astralinux.ru
X-KSMG-AntiSpam-Info: LuaCore: 107 0.3.107 575e75fe8e3b9d45c142d144823c5de38605099e, {date_rfc_vio_soft_silent}, {Tracking_uf_ne_domains}, {Tracking_internal2}, {Tracking_from_domain_doesnt_match_to}, astralinux.ru:7.1.1;patch.msgid.link:7.1.1;new-mail.astralinux.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;syzkaller.appspot.com:7.1.1,5.0.1, FromAlignment: s
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiSpam-Lua-Profiles: 203763 [Jun 09 2026]
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Version: 6.1.1.22
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.0.7854, bases: 2026/06/09 15:23:00 #28224840
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected, bases: 2026/06/09 15:41:00
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 1
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[astralinux.ru,quarantine];
	R_DKIM_ALLOW(-0.20)[astralinux.ru:s=mail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_CC(0.00)[astralinux.ru,mit.edu,dilger.ca,vger.kernel.org,linux.alibaba.com,suse.cz,linux.ibm.com,gmail.com,huawei.com,linuxtesting.org,syzkaller.appspotmail.com,outlook.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-262349-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:apanov@astralinux.ru,m:tytso@mit.edu,m:adilger.kernel@dilger.ca,m:linux-ext4@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:libaokun@linux.alibaba.com,m:jack@suse.cz,m:ojaswin@linux.ibm.com,m:ritesh.list@gmail.com,m:yi.zhang@huawei.com,m:lvc-project@linuxtesting.org,m:syzbot+04c4e65cab786a2e5b7e@syzkaller.appspotmail.com,m:tejas.bharambe@outlook.com,m:stable@kernel.org,m:riteshlist@gmail.com,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[apanov@astralinux.ru,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[apanov@astralinux.ru,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[astralinux.ru:+];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,04c4e65cab786a2e5b7e];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,msgid.link:url,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,syzkaller.appspot.com:url,outlook.com:email,astralinux.ru:dkim,astralinux.ru:email,astralinux.ru:mid,astralinux.ru:from_mime,appspotmail.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 117DC662B76

From: Tejas Bharambe <tejas.bharambe@outlook.com>

commit 2acb5c12ebd860f30e4faf67e6cc8c44ddfe5fe8 upstream.

ext4_ext_correct_indexes() walks up the extent tree correcting
index entries when the first extent in a leaf is modified. Before
accessing path[k].p_idx->ei_block, there is no validation that
p_idx falls within the valid range of index entries for that
level.

If the on-disk extent header contains a corrupted or crafted
eh_entries value, p_idx can point past the end of the allocated
buffer, causing a slab-out-of-bounds read.

Fix this by validating path[k].p_idx against EXT_LAST_INDEX() at
both access sites: before the while loop and inside it. Return
-EFSCORRUPTED if the index pointer is out of range, consistent
with how other bounds violations are handled in the ext4 extent
tree code.

Reported-by: syzbot+04c4e65cab786a2e5b7e@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=04c4e65cab786a2e5b7e
Signed-off-by: Tejas Bharambe <tejas.bharambe@outlook.com>
Link: https://patch.msgid.link/JH0PR06MB66326016F9B6AD24097D232B897CA@JH0PR06MB6632.apcprd06.prod.outlook.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Cc: stable@kernel.org
[ Alexey: Adapt goto clean to break because the clean error path is not
  present in linux-5.10.y and linux-5.15.y. ]
Signed-off-by: Alexey Panov <apanov@astralinux.ru>
---
Backport fix for CVE-2026-31449
 fs/ext4/extents.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 80b7783c65b4..e6dbb2dfb331 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -1736,6 +1736,13 @@ static int ext4_ext_correct_indexes(handle_t *handle, struct inode *inode,
 	err = ext4_ext_get_access(handle, inode, path + k);
 	if (err)
 		return err;
+	if (unlikely(path[k].p_idx > EXT_LAST_INDEX(path[k].p_hdr))) {
+		EXT4_ERROR_INODE(inode,
+				 "path[%d].p_idx %p > EXT_LAST_INDEX %p",
+				 k, path[k].p_idx,
+				 EXT_LAST_INDEX(path[k].p_hdr));
+		return -EFSCORRUPTED;
+	}
 	path[k].p_idx->ei_block = border;
 	err = ext4_ext_dirty(handle, inode, path + k);
 	if (err)
@@ -1748,6 +1755,14 @@ static int ext4_ext_correct_indexes(handle_t *handle, struct inode *inode,
 		err = ext4_ext_get_access(handle, inode, path + k);
 		if (err)
 			break;
+		if (unlikely(path[k].p_idx > EXT_LAST_INDEX(path[k].p_hdr))) {
+			EXT4_ERROR_INODE(inode,
+					 "path[%d].p_idx %p > EXT_LAST_INDEX %p",
+					 k, path[k].p_idx,
+					 EXT_LAST_INDEX(path[k].p_hdr));
+			err = -EFSCORRUPTED;
+			break;
+		}
 		path[k].p_idx->ei_block = border;
 		err = ext4_ext_dirty(handle, inode, path + k);
 		if (err)
-- 
2.47.3

