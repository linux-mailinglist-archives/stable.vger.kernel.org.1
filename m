Return-Path: <stable+bounces-251210-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id pYXbGjkYDmp96AUAu9opvQ
	(envelope-from <stable+bounces-251210-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 22:23:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E96B599846
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 22:23:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 975013288710
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D398136F901;
	Wed, 20 May 2026 17:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qcCHJgJC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8398033A033;
	Wed, 20 May 2026 17:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779297387; cv=none; b=BOsnQ47tQ8N3BUQGrl71x9i88tvjn+KYftN9R6yHVYunn6zXVKRvAW9XUZvFuuJoMRsy41GC9Wk3dqqhtESwwR7ra2w9lzyf0FySmpBGcl2mavgrItB99iT2relzFBEckmj/ZG/y5YhWpnMQ0PfSS0rLE7yucKOh3oj6Hzp8gHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779297387; c=relaxed/simple;
	bh=7nVx0Julvy+K//Oa+9JIQadWMHCbQAZrS7CUG54JaJU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UhE3eI26JweH5gOYXFq0siLjTLJABY9PYkc6LczSMLFoKRzIRAmvUZ06VQeNGfcdOOK9TQauaDspbai6lK1qiHXlsVwhUoT5sxlREvJRfl50QqiOHMPtjqepBfrCtrox1JlfI0LZH8bL4zeOlYzPyJdlS9TmhgEVfzkvD1QojRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qcCHJgJC; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F7BF1F00893;
	Wed, 20 May 2026 17:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779297386;
	bh=BPf3jLMUTI0tly7ooVwJeTyETETRi1megNrBxGUJye8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=qcCHJgJCbbZonH1J8bHL3X38SAQgCQ2BIqbx4QHnLXHhd+aFzILoTyt5pAcTLY2Pm
	 mE05GZoCqDLTdSvFYjIGP8tpFXQCO4rEZjmWI9FabDQud8qZ5oT3GcBu9S2w0mhomA
	 BPHIq0PUP5qFl3egtlSeqbyI3m4htucKPS3OQJXc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Zhan Xusheng <zhanxusheng@xiaomi.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 013/957] erofs: handle 48-bit blocks/uniaddr for extra devices
Date: Wed, 20 May 2026 18:08:16 +0200
Message-ID: <20260520162134.848053313@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162134.554764788@linuxfoundation.org>
References: <20260520162134.554764788@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-251210-lists,stable=lfdr.de];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alibaba.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 0E96B599846
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zhan Xusheng <zhanxusheng1024@gmail.com>

[ Upstream commit 63c2f06198ca7513433f1c92f2c654869d72417e ]

erofs_init_device() only reads blocks_lo and uniaddr_lo from the
on-disk device slot, ignoring blocks_hi and uniaddr_hi that were
introduced alongside the 48-bit block addressing feature.

For the primary device (dif0), erofs_read_superblock() already handles
this correctly by combining blocks_lo with blocks_hi when 48-bit
layout is enabled.  But the same logic was not applied to extra
devices.

With a 48-bit EROFS image using extra devices whose uniaddr or blocks
exceed 32-bit range, the truncated values cause erofs_map_dev() to
compute wrong physical addresses, leading to silent data corruption.

Fix this by reading blocks_hi and uniaddr_hi in erofs_init_device()
when 48-bit layout is enabled, consistent with the primary device
handling.  Also fix the erofs_deviceslot on-disk definition where
blocks_hi was incorrectly declared as __le32 instead of __le16.

Fixes: 61ba89b57905 ("erofs: add 48-bit block addressing on-disk support")
Suggested-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>
Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/erofs/erofs_fs.h | 4 ++--
 fs/erofs/super.c    | 8 ++++++--
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/fs/erofs/erofs_fs.h b/fs/erofs/erofs_fs.h
index 3d5738f80072e..63efadf75b1c0 100644
--- a/fs/erofs/erofs_fs.h
+++ b/fs/erofs/erofs_fs.h
@@ -44,9 +44,9 @@ struct erofs_deviceslot {
 	u8 tag[64];		/* digest(sha256), etc. */
 	__le32 blocks_lo;	/* total blocks count of this device */
 	__le32 uniaddr_lo;	/* unified starting block of this device */
-	__le32 blocks_hi;	/* total blocks count MSB */
+	__le16 blocks_hi;	/* total blocks count MSB */
 	__le16 uniaddr_hi;	/* unified starting block MSB */
-	u8 reserved[50];
+	u8 reserved[52];
 };
 #define EROFS_DEVT_SLOT_SIZE	sizeof(struct erofs_deviceslot)
 
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index ee37628ec99fb..f5f5d19459ecc 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -140,6 +140,7 @@ static int erofs_init_device(struct erofs_buf *buf, struct super_block *sb,
 	struct erofs_fscache *fscache;
 	struct erofs_deviceslot *dis;
 	struct file *file;
+	bool _48bit;
 
 	dis = erofs_read_metabuf(buf, sb, *pos, false);
 	if (IS_ERR(dis))
@@ -186,8 +187,11 @@ static int erofs_init_device(struct erofs_buf *buf, struct super_block *sb,
 		dif->file = file;
 	}
 
-	dif->blocks = le32_to_cpu(dis->blocks_lo);
-	dif->uniaddr = le32_to_cpu(dis->uniaddr_lo);
+	_48bit = erofs_sb_has_48bit(sbi);
+	dif->blocks = le32_to_cpu(dis->blocks_lo) |
+		(_48bit ? (u64)le16_to_cpu(dis->blocks_hi) << 32 : 0);
+	dif->uniaddr = le32_to_cpu(dis->uniaddr_lo) |
+		(_48bit ? (u64)le16_to_cpu(dis->uniaddr_hi) << 32 : 0);
 	sbi->total_blocks += dif->blocks;
 	*pos += EROFS_DEVT_SLOT_SIZE;
 	return 0;
-- 
2.53.0




