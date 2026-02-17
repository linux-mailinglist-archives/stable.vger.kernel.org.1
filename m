Return-Path: <stable+bounces-217082-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8H0bK1bUlGmfIAIAu9opvQ
	(envelope-from <stable+bounces-217082-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 21:49:26 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 20BB8150587
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 21:49:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E82F6303EE93
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 20:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7338E2773E4;
	Tue, 17 Feb 2026 20:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rvjZJAoe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D7929A1;
	Tue, 17 Feb 2026 20:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771361362; cv=none; b=WLTqYv8XyZuQ3VmyW+Xo/1mGLCK7Q/NFs0QX3rEazWistgfOt8ttR3uP8HpTgEAxCBihwiapAdwHOMY3pUpp0ueIgxpemCFvdaSdPaoOLwRC0Wgb/oCgn7/g6Ull2/La2XNWm58sD0bXefnTLLXKizwbkiT76SxdTqZ1JGBob4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771361362; c=relaxed/simple;
	bh=BUcm7vzYMqn0wuHuUq7QOB3DstmHC3nVF1B1wpjPGQw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RRiLIfq056EX9caYgLort4dP8N2vUF6nSK7pEgGXeWaQX6c5VkAY8PARIhF5tXv+3FsdnBJCKjJ7MVRjfQj2o2gM6wEDi2czbmw+6R+rRmn1nWlBbkhm2eepG6jwalruo0tK61buzs3FSwXBI+QY0WcZfVl47hQ8y55kUIzW2Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rvjZJAoe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0053C4CEF7;
	Tue, 17 Feb 2026 20:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771361362;
	bh=BUcm7vzYMqn0wuHuUq7QOB3DstmHC3nVF1B1wpjPGQw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rvjZJAoe84fRC0iWL9wj7HP+VdZ7ylWUTLdkk7Rt61YDgMFZnJDDhoNo+thsSIHuu
	 Pm2Uw7LZBVOrgEDVsE34qnR5D/J7ectExQoCREqOE7FzWSIoE5qrlEOx8J+grVqetK
	 VOCcmenr9ZArZrsZFXP6lzRzTcgwVTWrY9OgUXqU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable@kernel.org,
	Sungjong Seo <sj1557.seo@samsung.com>,
	Sunmin Jeong <s_min.jeong@samsung.com>,
	Yeongjin Gil <youngjin.gil@samsung.com>,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 6.19 13/18] f2fs: optimize f2fs_overwrite_io() for f2fs_iomap_begin
Date: Tue, 17 Feb 2026 21:32:09 +0100
Message-ID: <20260217200003.205754105@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260217200002.683975158@linuxfoundation.org>
References: <20260217200002.683975158@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-217082-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,linuxfoundation.org:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,samsung.com:email]
X-Rspamd-Queue-Id: 20BB8150587
X-Rspamd-Action: no action

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yeongjin Gil <youngjin.gil@samsung.com>

commit d860974a7e38d35e9e2c4dc8a9f4223b38b6ad99 upstream.

When overwriting already allocated blocks, f2fs_iomap_begin() calls
f2fs_overwrite_io() to check block mappings. However,
f2fs_overwrite_io() iterates through all mapped blocks in the range,
which can be inefficient for fragmented files with large I/O requests.

This patch optimizes f2fs_overwrite_io() by adding a 'check_first'
parameter and introducing __f2fs_overwrite_io() helper. When called from
f2fs_iomap_begin(), we only check the first mapping to determine if the
range is already allocated, which is sufficient for setting
map.m_may_create.

This optimization significantly reduces the number of f2fs_map_blocks()
calls in f2fs_overwrite_io() when called from f2fs_iomap_begin(),
especially for fragmented files with large I/O requests.

Cc: stable@kernel.org
Fixes: 351bc761338d ("f2fs: optimize f2fs DIO overwrites")
Reviewed-by: Sungjong Seo <sj1557.seo@samsung.com>
Reviewed-by: Sunmin Jeong <s_min.jeong@samsung.com>
Signed-off-by: Yeongjin Gil <youngjin.gil@samsung.com>
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/f2fs/data.c |   12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1799,7 +1799,8 @@ out:
 	return err;
 }
 
-bool f2fs_overwrite_io(struct inode *inode, loff_t pos, size_t len)
+static bool __f2fs_overwrite_io(struct inode *inode, loff_t pos, size_t len,
+				bool check_first)
 {
 	struct f2fs_map_blocks map;
 	block_t last_lblk;
@@ -1821,10 +1822,17 @@ bool f2fs_overwrite_io(struct inode *ino
 		if (err || map.m_len == 0)
 			return false;
 		map.m_lblk += map.m_len;
+		if (check_first)
+			break;
 	}
 	return true;
 }
 
+bool f2fs_overwrite_io(struct inode *inode, loff_t pos, size_t len)
+{
+	return __f2fs_overwrite_io(inode, pos, len, false);
+}
+
 static int f2fs_xattr_fiemap(struct inode *inode,
 				struct fiemap_extent_info *fieinfo)
 {
@@ -4187,7 +4195,7 @@ static int f2fs_iomap_begin(struct inode
 	 * f2fs_map_lock and f2fs_balance_fs are not necessary.
 	 */
 	if ((flags & IOMAP_WRITE) &&
-		!f2fs_overwrite_io(inode, offset, length))
+		!__f2fs_overwrite_io(inode, offset, length, true))
 		map.m_may_create = true;
 
 	err = f2fs_map_blocks(inode, &map, F2FS_GET_BLOCK_DIO);



